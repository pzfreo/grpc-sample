import ballerina/grpc;
import ballerina/io;
import ballerina/system;
import ballerina/time;


endpoint PurchaseClient pc {
    url: "http://localhost:50051"
};

public function main(string... args) {
    PurchaseRequest pr = {
        poNumber: "001",
        lineItem: "Hello",
        quantity: 0,
        date: {
            year: 2018,
            month: 12,
            day: 5
        },
        customerNumber: "001",
        paymentReference: "NA"
    };
    io:println("starting");
    int now = time:nanoTime();
    foreach i in 0...10000 {
        io:print("s");
        var response = pc -> purchase(req, listener, headers = listener)
        io:print("f");
    }
    int taken = time:nanoTime()-now;
    io:println(taken);
}