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

    def __str__(self):
        userP = self._get_user_part()
        hostP = self._get_host_part()
        pathP = Path(self.__cwd, self.__home).to_Promptly()

        line1 = Promptly('┌─[',
                         userP,
                         '@',
                         hostP,
                         ':',
                         pathP,
                         ']──>')
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

    # This creates the actual prompt.
    s = '\r%E'
    for __ in range(int((len(get_short_PS1())-1) / args.width)):
        s += '\b\b\r%E'
    s += prom

    return s


def get_short_PS1():
    from os import environ

    ps1 = environ['PS1']

    ps1 = re.sub(r'%[FK]{\w+}', '', ps1)
    ps1 = re.sub(r'%[fkBbUuE]', '', ps1)

    env = environ.copy()
    env['ps1_cp'] = ps1

    ps1 = check_output(
        ['zsh', '-c', 'echo -n ${(%%)ps1_cp}'],
        env=env)

    return ps1.decode()


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

    args = parser.parse_args()

    print(prompt(args), end='')


if __name__ == '__main__':
    main()
