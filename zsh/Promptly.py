#!/usr/bin/env python3


class Decorator(object):

    def decorate(self, s):
        return s


class Bold(Decorator):

    def decorate(self, s):
        return '%B' + s + '%b'


class Underline(Decorator):

    def decorate(self, s):
        return '%U' + s + '%u'


class ForegroundColor(Decorator):

    def __init__(self, color):
        colors = 'black red green yellow blue magenta cyan white'.split()
        color = color.lower().strip()
        if color not in colors:
            raise Exception('Color is udefined')
        self.__color = color

    def decorate(self, s):
        return '%F{' + self.__color + '}' + s + '%f'


class BackgroundColor(Decorator):

    def __init__(self, color):
        colors = 'black red green yellow blue magenta cyan white'.split()
        color = color.lower().strip()
        if color not in colors:
            raise Exception('Color is udefined')
        self.__color = color

    def decorate(self, s):
        return '%K{' + self.__color + '}' + s + '%k'


class Promptly(object):

    def __init__(self, *childs, decoration=None):
        self.__childs = childs
        self.__decoration = decoration

    def __len__(self):
        return sum([len(x) for x in self.__childs])

    def __str__(self):
        s = ''.join([str(x) for x in self.__childs])
        if self.__decoration is None:
            return s
        else:
            return self.__decoration.decorate(s)


B = Bold
U = Underline
FC = ForegroundColor
BC = BackgroundColor
