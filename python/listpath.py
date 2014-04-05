import os

for key in ('Path','PYTHONPATH'):
    print '\n%s:' % (key)
    if os.environ.has_key(key):
        for dir in os.environ[key].split(os.pathsep):
            print dir

    else:
        print '<<not set>>'
