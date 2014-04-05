import re

def FileDispatcher( fn, dispatch_table ):
	
	# Start de scan loop
	for line in open( fn ):
		#print line
		for (regex, fnc) in dispatch_table:

			if not regex: break
			
			m = regex.search( line )
			
			if m:
				#print "match"
				
				if fnc == "*EXIT*": return
				if fnc: 
					try:
						fnc( m )
					except:
						return
					
					break


def _testmij(m):
	print m.group(1)
	
if __name__ == '__main__':
	open('test.mij','w').writelines( [ 'dqidcucec abc654def igediwgg\n', 'dqidcucec ab654def igediwgg\n' ] )
	FileDispatcher( 'test.mij', [ ( re.compile('abc(\d*)def'), _testmij) ] )
	import os
	os.remove( 'test.mij' )