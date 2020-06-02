from socket import *
import sys
import mysql.connector as mysql

db = mysql.connect(
    host="localhost",
    user="fpga",
    passwd="fpga",
    database="Barcodes",
    auth_plugin="mysql_native_password"
)
cursor = db.cursor()

interface = "enx00e04d69ac3c"
s = socket(AF_PACKET, SOCK_RAW, htons(3))
s.bind((interface, 0))

print('Starting FPGA product server')

def sendeth(payload, src = b'\x69\x69\x69\x69\x69\xAA', dst = b'\x00\xe0\x4d\x69\xac\x3c', eth_type = b'\x69\x69'):
  assert(len(src) == len(dst) == 6) # 48-bit ethernet addresses
  assert(len(eth_type) == 2) # 16-bit ethernet type
  s.send((src + dst + eth_type + payload))


while True:
    # Wait on ethernet packet from FPGA
    print('waiting for a packet')
    FPGA_packet=s.recv(1024)
    #print(FPGA_packet)
    data = FPGA_packet.split(b'\xaaii')
    if len(data) > 1:
     barcode = data[1].decode();
     print('Barcode request: ', barcode)

     cursor.execute("SELECT * from Products WHERE Barcode=%s", (barcode,))
     product = cursor.fetchall()
     if len(product) > 0:
       print('sending product information for '+product[0][1]+' to FPGA')
       sendeth(product[0][2].encode().lower())
     else:
       print('Product not found')
       sendeth(b'Product Not Found')
  
