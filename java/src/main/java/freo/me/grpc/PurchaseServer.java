package freo.me.grpc;

import freo.me.purchase.PurchaseOuterClass.PurchaseReply;
import freo.me.purchase.PurchaseOuterClass.PurchaseRequest;
import io.grpc.Server;
import io.grpc.ServerBuilder;
import io.grpc.stub.StreamObserver;

import java.io.IOException;
import java.util.logging.Logger;

/**
 * Server that manages startup/shutdown of a {@code Greeter} server.
 */
public class PurchaseServer {
  private static final Logger logger = Logger.getLogger(PurchaseServer.class.getName());

  private Server server;

  private void start() throws IOException {
    /* The port on which the server should run */
    int port = 50051;
    server = ServerBuilder.forPort(port).addService(new PurchaseImpl()).build().start();
    logger.info("Server started, listening on " + port);
    Runtime.getRuntime().addShutdownHook(new Thread() {
      @Override
      public void run() {
        // Use stderr here since the logger may have been reset by its JVM shutdown
        // hook.
        System.err.println("*** shutting down gRPC server since JVM is shutting down");
        PurchaseServer.this.stop();
        System.err.println("*** server shut down");
      }
    });
  }

  private void stop() {
    if (server != null) {
      server.shutdown();
    }
  }

  /**
   * Await termination on the main thread since the grpc library uses daemon
   * threads.
   */
  private void blockUntilShutdown() throws InterruptedException {
    if (server != null) {
      server.awaitTermination();
    }
  }

  /**
   * Main launches the server from the command line.
   */
  public static void main(String[] args) throws IOException, InterruptedException {
    final PurchaseServer server = new PurchaseServer();
    server.start();
    server.blockUntilShutdown();
  }

  static class PurchaseImpl extends freo.me.purchase.PurchaseGrpc.PurchaseImplBase {

    @Override
    public void purchase(PurchaseRequest req, StreamObserver<PurchaseReply> responseObserver) {

      System.out.println("Customer Number: " + req.getCustomerNumber());
      System.out.println("PO Number: " + req.getPoNumber());
      PurchaseReply reply = PurchaseReply.newBuilder().setMessage("order accepted").setReturncode(0).build();
      responseObserver.onNext(reply);
      responseObserver.onCompleted();
    }
  }
}
