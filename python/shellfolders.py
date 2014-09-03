import os
import registry

__shellfolders = registry.readValues( 'HKCU', r'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders')

def MyDocuments():
    return __shellfolders['Personal']

def MyTemp():
    return os.environ['TEMP']

def MyDesktop():
    return __shellfolders['Desktop']

def MyAppData():
    return __shellfolders['AppData']

def MyLocalAppData():
    return __shellfolders['Local AppData']

if __name__ == '__main__':
    print "My Documents: %s" % MyDocuments()
    print "My AppData: %s" % MyAppData()
    print "My Temp: %s" % MyTemp()
    print "My Desktop: %s" % MyDesktop()
