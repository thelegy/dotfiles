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
            raise Exception('Color is undefined')
        self.__color = color

    def decorate(self, s):
        return '%F{' + self.__color + '}' + s + '%f'


class BackgroundColor(Decorator):

    def __init__(self, color):
        colors = 'black red green yellow blue magenta cyan white'.split()
        color = color.lower().strip()
        if color not in colors:
            raise Exception('Color is undefined')
        self.__color = color

    def decorate(self, s):
        return '%K{' + self.__color + '}' + s + '%k'


class Promptly(object):

    def __init__(self,
                 *childs,
                 bold=None,
                 underline=None,
                 foreground=None,
                 background=None):
        self.__childs = childs
        if bold not in [None, True, False]:
            raise Exception('Bold value is not understood')
        if underline not in [None, True, False]:
            raise Exception('Underline value is not understood')
        self.__underline = underline
        if foreground not in [None, 'black', 'red', 'green', 'yellow',
                              'blue', 'magenta', 'cyan', 'white']:
            raise Exception('Foreground value is not understood')
        self.__foreground = foreground
        if background not in [None, 'black', 'red', 'green', 'yellow',
                              'blue', 'magenta', 'cyan', 'white']:
            raise Exception('Background value is not understood')
        self.__background = background

    def __len__(self):
        return sum([len(x) for x in self.__childs])

    def __str__(self):
        s = ''.join([str(x) for x in self.__childs])
        if True:
            return s
        else:
            return self.__decoration.decorate(s)
