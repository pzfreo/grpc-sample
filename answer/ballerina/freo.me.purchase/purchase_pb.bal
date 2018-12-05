import ballerina/grpc;
import ballerina/io;

public type PurchaseBlockingStub object {
    public grpc:Client clientEndpoint;
    public grpc:Stub stub;

    function initStub (grpc:Client ep) {
        grpc:Stub navStub = new;
        navStub.initStub(ep, "blocking", DESCRIPTOR_KEY, descriptorMap);
        self.stub = navStub;
    }
    
    function purchase (PurchaseRequest req, grpc:Headers? headers = ()) returns ((PurchaseReply, grpc:Headers)|error) {
        
        var unionResp = self.stub.blockingExecute("freo.me.purchase.Purchase/purchase", req, headers = headers);
        match unionResp {
            error payloadError => {
                return payloadError;
            }
            (any, grpc:Headers) payload => {
                grpc:Headers resHeaders;
                any result;
                (result, resHeaders) = payload;
                return (check <PurchaseReply>result, resHeaders);
            }
        }
    }
    
};

public type PurchaseStub object {
    public grpc:Client clientEndpoint;
    public grpc:Stub stub;

    function initStub (grpc:Client ep) {
        grpc:Stub navStub = new;
        navStub.initStub(ep, "non-blocking", DESCRIPTOR_KEY, descriptorMap);
        self.stub = navStub;
    }
    
    function purchase (PurchaseRequest req, typedesc listener, grpc:Headers? headers = ()) returns (error?) {
        
        return self.stub.nonBlockingExecute("freo.me.purchase.Purchase/purchase", req, listener, headers = headers);
    }
    
};


public type PurchaseBlockingClient object {
    public grpc:Client client;
    public PurchaseBlockingStub stub;

    public function init (grpc:ClientEndpointConfig config) {
        // initialize client endpoint.
        grpc:Client c = new;
        c.init(config);
        self.client = c;
        // initialize service stub.
        PurchaseBlockingStub s = new;
        s.initStub(c);
        self.stub = s;
    }

    public function getCallerActions () returns PurchaseBlockingStub {
        return self.stub;
    }
};

public type PurchaseClient object {
    public grpc:Client client;
    public PurchaseStub stub;

    public function init (grpc:ClientEndpointConfig config) {
        // initialize client endpoint.
        grpc:Client c = new;
        c.init(config);
        self.client = c;
        // initialize service stub.
        PurchaseStub s = new;
        s.initStub(c);
        self.stub = s;
    }

    public function getCallerActions () returns PurchaseStub {
        return self.stub;
    }
};


type PurchaseRequest record {
    string poNumber;
    string lineItem;
    int quantity;
    Date date;
    string customerNumber;
    string paymentReference;
    
};

type Date record {
    int year;
    int month;
    int day;
    
};

type PurchaseReply record {
    string message;
    int returncode;
    
};


@final string DESCRIPTOR_KEY = "freo.me.purchase.purchase.proto";
map descriptorMap = {
"freo.me.purchase.purchase.proto":"0A0E70757263686173652E70726F746F12106672656F2E6D652E707572636861736522E5010A0F507572636861736552657175657374121A0A08706F4E756D6265721801200128095208706F4E756D626572121A0A086C696E654974656D18022001280952086C696E654974656D121A0A087175616E7469747918032001280552087175616E74697479122A0A046461746518042001280B32162E6672656F2E6D652E70757263686173652E4461746552046461746512260A0E637573746F6D65724E756D626572180520012809520E637573746F6D65724E756D626572122A0A107061796D656E745265666572656E636518062001280952107061796D656E745265666572656E636522420A044461746512120A047965617218012001280552047965617212140A056D6F6E746818022001280552056D6F6E746812100A03646179180320012805520364617922490A0D50757263686173655265706C7912180A076D65737361676518012001280952076D657373616765121E0A0A72657475726E636F6465180220012805520A72657475726E636F6465325C0A08507572636861736512500A08707572636861736512212E6672656F2E6D652E70757263686173652E5075726368617365526571756573741A1F2E6672656F2E6D652E70757263686173652E50757263686173655265706C792200620670726F746F33"

};
