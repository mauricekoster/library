import os
import sys

if sys.platform == 'Win32':

    import registry

    __common_shellfolders = registry.readValues( 'HKLM', r'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders')

    __personal_shellfolders = registry.readValues( 'HKCU', r'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders')

    def CommonAppData():
        return __common_shellfolders['Common AppData']

    def MyDocuments():
        return __personal_shellfolders['Personal']

    def MyTemp():
        return os.environ['TEMP']

    def MyDesktop():
        return __personal_shellfolders['Desktop']

    def MyAppData():
        return __personal_shellfolders['AppData']

    def MyLocalAppData():
        return __personal_shellfolders['Local AppData']

elif sys.platform == 'linux2':
    # return XDG desktop compliant directories
    # source: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
    homedir = os.environ['HOME']
    global dirs
    dirs = {}
    if os.path.exists(os.path.join(homedir,'.config','user-dirs.dirs')):
        print 'XXX'
        execfile(os.path.join(homedir,'.config','user-dirs.dirs'), dirs)

    def CommonAppData():
        if 'XDG_DATA_DIRS' in os.environ:
            d = os.environ['XDG_DATA_DIRS']
        else:
            d = '/usr/local/share/:/usr/share/'
        return d.split(':')[0]

    def MyDocuments():
        print dirs
        if 'XDG_DOCUMENTS_DIR' in dirs:
            return dirs['XDG_DOCUMENTS_DIR'].replace('$HOME',homedir)
        else:
            return os.path.join(homedir, 'Documents')

if __name__ == '__main__':
    print "Common data dir: %s" % CommonAppData()
    print "My Documents: %s" % MyDocuments()
    print "My AppData: %s" % MyAppData()
    print "My Temp: %s" % MyTemp()
    print "My Desktop: %s" % MyDesktop()
