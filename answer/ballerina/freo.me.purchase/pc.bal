import ballerina/grpc;

endpoint PurchaseBlockingClient pbc {
    
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
    foreach i in 0...10000 {
        _ = pbc -> purchase(pr);
    }
    
}