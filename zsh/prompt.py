#!/usr/bin/env python3

import re
from subprocess import check_output

from Promptly import Promptly, FC, BC, B, U


class Path(object):

    def __init__(self, cwd, home):
        self.__cwd = cwd
        self.__home = home

    def _strip_home(self, path):
        if path.startswith(self.__home + '/'):
            path = path.lstrip(self.__home)
            path = '~/' + path
        return path

    def _shorten_path(self, path, maxLength=20):
        if len(path) > maxLength:
            path_split = path.split('/')
            if len(path_split) > 1:
                left = path_split[0]
                if len(left) > 0:
                    left = left[0]
                right = '/'.join(path_split[1:])
                right = self._shorten_path(
                    right,
                    maxLength=maxLength-1-len(left))
                path = left + '/' + right
        return path

    def to_Promptly(self):
        return Promptly(str(self))

    def __str__(self):
        path = self.__cwd + '/'

        path = self._strip_home(path)

        path = path.rstrip('/')

        path = self._shorten_path(path)

        return path


class Prompt(object):

    def __init__(self, args):
        self.__width = args.width
        self.__user = args.user
        self.__host = args.host
        self.__isRoot = args.isRoot
        self.__cwd = args.cwd
        self.__home = args.home
        self.__pyvenv = args.pyvenv

    def _get_user_part(self):
        part = Promptly(self.__user)
        if self.__isRoot:
            part = Promptly(part, decoration=FC('red'))
        else:
            part = Promptly(part, decoration=FC('green'))
        return part

    def _get_host_part(self):
        part = Promptly(self.__host, decoration=FC('yellow'))
        return part

    def _get_left_box(self):
        userP = self._get_user_part()
        hostP = self._get_host_part()
        pathP = Path(self.__cwd, self.__home).to_Promptly()

        box = Promptly('[',
                       userP,
                       '@',
                       hostP,
                       ':',
                       pathP,
                       ']')

        return box

    def _get_pyvenv_box(self):
        if len(self.__pyvenv) <= 1:
            return Promptly('')

        box = Promptly('(',
                       self.__pyvenv.split('/')[-1],
                       ')')

        return box

    def _get_date_box(self):
        from time import strftime

        box = Promptly('[',
                       strftime('%x %R'),
                       ']')

        return box

    def _get_left_half(self):
        left_box = self._get_left_box()
        pyvenv_box = self._get_pyvenv_box()

        half = Promptly('┌─',
                        left_box)

        if len(pyvenv_box) > 0:
            if len(pyvenv_box) + len(left_box) + 1 < self.__width:
                half = Promptly(half,
                                '─',
                                pyvenv_box)

        return half

    def _get_right_half(self):
        date_box = self._get_date_box()

        half = Promptly(date_box,
                        '─')

        return half

    def __str__(self):
        left_half = self._get_left_half()
        right_half = self._get_right_half()

        space_num = self.__width - len(left_half) - len(right_half)

        if space_num <= 0:
            right_half = Promptly()
            space_num = self.__width - len(left_half) - len(right_half)

        space = '─' + ''.join(['─' for __ in range(space_num-1)])

        line1 = Promptly(left_half,
                         space,
                         right_half)

        line2 = Promptly('│ $ ')

        if len(line1) > self.__width:
            prompt = Promptly('$')
            if self.__isRoot:
                prompt = Promptly(
                    prompt,
                    decoration=FC('red'))
            prompt = Promptly(prompt, ' %E%2G')
        else:
            prompt = Promptly(line1, '\n', line2, '%E')

        return str(prompt)


def prompt(args):
    p = Prompt(args)

    prom = str(p)

    s = '\r%E'
    s += prom

    return s


def main():
    from argparse import ArgumentParser
    from getpass import getuser
    from os import getcwd, getuid, environ
    from os.path import expanduser
    from socket import gethostname

    parser = ArgumentParser(
        description='Displays a command prompt')
    parser.add_argument(
        '-w',
        '--width',
        dest='width',
        action='store',
        type=int,
        required=True,
        help='define width of the prompt')
    parser.add_argument(
        '--user',
        dest='user',
        action='store',
        default=getuser(),
        help='overwrite the user')
    parser.add_argument(
        '--host',
        dest='host',
        action='store',
        default=gethostname(),
        help='overwrite the host')
    parser.add_argument(
        '--root',
        dest='isRoot',
        action='store',
        type=bool,
        default=(getuid() == 0),
        help='overwrite if root permissions should be assumed')
    parser.add_argument(
        '--cwd',
        dest='cwd',
        action='store',
        default=environ['PWD'],
        help='overwrite the current working directory')
    parser.add_argument(
        '--home',
        dest='home',
        action='store',
        default=expanduser('~'),
        help='overwrite the home directory')
    parser.add_argument(
        '--pyvenv',
        dest='pyvenv',
        action='store',
        default=environ.get('VIRTUAL_ENV', ''),
        help='overwrite the active python virtual environment')

    args = parser.parse_args()

    print(prompt(args), end='')


if __name__ == '__main__':
    main()
