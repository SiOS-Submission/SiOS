# -*- coding: utf-8 -*-
from scapy.all import *
import socket
import binascii 
import time




def main(argv):
    socklst = []
   
    playfile = './weblink-' + argv[0] + '.pcap'
    packets = rdpcap(playfile)
    
    print "[*] Action: " + argv[0]    
    if argv[0] == "gohome":
        ssport = 56968
    elif argv[0] == "gowork":   
        ssport = 57200
    elif argv[0] == "gohome-again":
        ssport = 57224
    else:
        print "wrong arg"
        return   
         
    i = 0
    sip = ""
    for ip in argv[1: ]:
        sip += ip 
        sip += ', '
        socklst.append(socket.socket())
        address = (ip, 12345)
        socklst[i].connect(address)
        i+=1
    print "[*] Ip list: " + sip 
        
    print "[*] Sending payload..."    
    i = 0    
    for packet in packets:        
        if packet.haslayer(Raw):  
#             print "sport: " + str(packet.sport)
#             print "dport: " + str(packet.dport)
#             print "-----"
            

            if packet.sport == ssport  and packet.dport == 55432: 
                              
#                 print "**** sending data ****"
                #print binascii.b2a_hex(packet.load)
                time.sleep(0.02)
                if packet.load[2] == "\x48":
                    i += 1
                    #print '[' + str(i) + ']: ' + binascii.b2a_hex(packet.load)
                    if i == 19:
                        time.sleep(7)
                try:
                    for sk in socklst:
                        sk.send(packet.load) 
#                         print "**** recv data ****"
#                         print binascii.b2a_hex(sk.recv(2048))
        
                except:
                    print "err"       
                    continue  
    #print i
    print "[+] Done"                                            
    return

    # rdpcap comes from scapy and loads in our pcap file
    #packets = rdpcap('./weblink-gohome.pcap')
    
    
    sk = socket.socket()
    address = ('192.168.30.177', 12345)
    sk.connect(address)
    
               
    # Let's iterate through every packet

    
        #print packet.load
        
        # We're only interested packets with a DNS Round Robin layer
        
            # If the an(swer) is a DNSRR, print the name it replied with.
            #packet.show()
    #         print packet.type
    

        #         print packet.src
        #         print packet.dst
                #print packet.load 
                #if packet.sport == 51061 and packet.dport == 55432: #reroute
                #if packet.sport == 55904 or packet.dport == 55432: #up
            #if packet.sport == 56384  and packet.dport == 55432: #up    
            #if packet.sport == 56395  and packet.dport == 55432: #down 
            #if packet.sport == 56415  and packet.dport == 55432: #left             
            #if packet.sport == 56443  and packet.dport == 55432: #right 
            #if packet.sport == 56968  and packet.dport == 55432: #gohome    
  
                            
if __name__ == "__main__":
   main(sys.argv[1:])