public class AnimalLocatorMock implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"animals":[{"id":1,"name":"Tiger"}]}');
        res.setStatusCode(200);
        return res;
    }
}