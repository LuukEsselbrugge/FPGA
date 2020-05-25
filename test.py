from socket import *

def send_ether(src, dst, type, payload, interface="wlp2s0"):
  # 48-bit Ethernet addresses
  assert(len(src) == len(dst) == 6)

  # 16-bit Ethernet type
  assert(len(type) == 2) # 16-bit Ethernet type

  s = socket(AF_PACKET, SOCK_RAW)
  s.bind((interface, 0))
  return s.send((dst + src + type + payload).encode())


print("Sent %d-byte Ethernet packet on eth0" %
  send_ether("\xFF\xFF\xFF\xFF\xFF\xFF",
          "\xFF\xFF\xFF\xFF\xFF\xFF",
          "\x7A\x05",
          "hello"))
