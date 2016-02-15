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
        self.__bold = bold;
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

    def _get_string(self,
                    bold=None,
                    underline=None,
                    foreground=None,
                    background=None):
        child_text = []
        for x in self.__childs:
            if type(x) is Promptly:
                text = x._get_string(self.__bold,
                                     self.__underline,
                                     self.__foreground,
                                     self.__background)
            else:
                text = str(x)
            child_text.append(text)
        s = ''.join([str(x) for x in child_text])

        # Add foreground color
        if self.__foreground is not None:
            if self.__foreground != foreground:
                s = '%F{{{}}}{}'.format(self.__foreground, s)
                if foreground is None:
                    s = s + '%f'
                else:
                    s = s + '%F{{{}}}'.format(foreground)

        # Add background color
        if self.__background is not None:
            if self.__background != background:
                s = '%K{{{}}}{}'.format(self.__background, s)
                if background is None:
                    s = s + '%k'
                else:
                    s = s + '%K{{{}}}'.format(background)

        # Add bold decorator
        if self.__bold is not None:
            if self.__bold != bold:
                if self.__bold:
                    s = '%B' + s
                else:
                    s = '%b' + s
                if bold is True:
                    s = s + '%B'
                else:
                    s = s + '%b'

        # Add underline decorator
        if self.__underline is not None:
            if self.__underline != underline:
                if self.__underline:
                    s = '%U' + s
                else:
                    s = '%u' + s
                if underline is True:
                    s = s + '%U'
                else:
                    s = s + '%u'

        return s

    def __len__(self):
        return sum([len(x) for x in self.__childs])

    def __str__(self):
        return self._get_string()
