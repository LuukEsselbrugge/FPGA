import socket
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

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_address = ('', 420)
print('Starting FPGA product server {} port {}'.format(*server_address))
sock.bind(server_address)
sock.listen(1)

while True:
    # Wait on TCP connection from FPGA
    print('waiting for a connection')
    connection, client_address = sock.accept()
    try:
        print('connection from', client_address)
        while True:
            data = connection.recv(16)
            barcode = data.decode('utf-8').rstrip()
            print('received barcode ' + barcode)
            cursor.execute(
                "SELECT * from Products WHERE Barcode=%s", (barcode,))
            product = cursor.fetchall()
            if len(product) > 0:
                print('sending product information for '+product[0][1]+' to FPGA')
                connection.sendall(product[0][1].encode()+b','+product[0][2].encode())
            else:
                print('Product not found')
                connection.sendall('error,product not found'.encode())

    finally:
        # Clean up the connection
        connection.close()
