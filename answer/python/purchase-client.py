import grpc;
import purchase_pb2;
import purchase_pb2_grpc;
import time;

def run():
  channel = grpc.insecure_channel('localhost:50051')
  stub = purchase_pb2_grpc.PurchaseStub(channel)
  print ("starting")

  t0 = time.time();
  for i in range(1,10000):
      response = stub.purchase(purchase_pb2.PurchaseRequest(poNumber="001",quantity=5))
  print str(10000/(time.time() - t0))+" requests / sec"
  print("Purchase client received: " + response.message)
  print("Purchase client received: " + str(response.returncode))

run()
