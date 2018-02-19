def FlagsForFile(filename, **kwargs):
    flags = [
        '-pedantic',
        '-Wall',
        '-Wextra',
        '-Weverything',
        '-Wno-c++98-compat',
        '-Wno-c++98-compat-pedantic',
        '-Wno-missing-prototypes',
        '-Wno-missing-variable-declarations',
        '-I', '.',
        '-I', './include',
        '-I', './src',
        '-isystem', '/usr/include',
        '-isystem', '/usr/local/include'
    ]

    data = kwargs['client_data']
    filetype = data['&filetype']

    if filetype == 'c':
        flags += ['-x', 'c']
        flags += ['-std=gnu11']
    elif filetype == 'cpp':
        flags += ['-x', 'c++']
        flags += ['-std=c++1y']
        flags += ['-isystem', '/usr/include/c++/5']
    else:
        flags = []

    return {
        'flags':    flags,
        'do_cache': True
    }
