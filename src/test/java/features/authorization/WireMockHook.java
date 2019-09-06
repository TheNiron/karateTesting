package features.authorization;

import com.github.tomakehurst.wiremock.WireMockServer;
import com.github.tomakehurst.wiremock.client.WireMock;
import cucumber.api.java.After;
import cucumber.api.java.Before;

import static com.github.tomakehurst.wiremock.client.WireMock.*;

public class WireMockHook {
    private int wireMockPort = 8247;
    private String wireMockHost = "localhost";
    private static String BEARER_TOKEN = "Bearer 123456789";
    private static String USERNAME = "Lakshani";
    private static String PASSWORD = "Password@123";

    private WireMockServer wireMockServer;
    private WireMock wireMock;

    @Before("@wiremockApi")
    public void setupWiremockServer(){
        wireMockServer = new WireMockServer(wireMockPort);
        wireMock = new WireMock(wireMockHost, wireMockPort);
        wireMockServer.start();

        wireMock.register(WireMock.get(WireMock.urlPathMatching("/getSomething")).willReturn(aResponse().withStatus(200)
                .withHeader("Content-Type", "application/json").withBody("{\"message\": \"Success\"}")));

        wireMock.register(WireMock.get(WireMock.urlPathMatching("/getLimitOffset"))
                .withQueryParam("limit", WireMock.matching("([0-9]*)"))
                .withQueryParam("offset", WireMock.matching("([0-9]*)"))
                .withHeader("Authorization", equalTo(BEARER_TOKEN))
                .willReturn(aResponse().withStatus(200)
                        .withHeader("Content-Type", "application/json").withBody("{\"message\": \"Limit offset acquired successfully.\"}")));

        wireMock.register(WireMock.post(WireMock.urlPathMatching("/Postemployeedata"))
                .withBasicAuth(USERNAME,PASSWORD)
                .withRequestBody(equalToJson("{\"message\": \"This is test JSON Body\"}"))
                .withHeader("department", equalTo("\"valid_department\""))
                .willReturn(aResponse().withStatus(200)
                        .withHeader("Content-Type", "application/json").withBody("{\"message\": \"Post Success\"}")));

        wireMock.register(WireMock.post(WireMock.urlEqualTo("/tokengen?client_id=clientID123&client_secret=clientSecret123"))
                .willReturn(aResponse().withStatus(200)
                        .withHeader("Content-Type", "application/json").withBody("{\"Bearer: token123test\",\"token_type\":\"bearer\", \"expires_in\":3600}")));

        wireMock.register(WireMock.get(WireMock.urlPathMatching("/getSomethingWithToken"))
                .withHeader("Authorization", equalTo("Bearer: token123test"))
                .willReturn(aResponse().withStatus(200)
                        .withHeader("Content-Type", "application/json")
                        .withBody("{\"message\": \"Get request done successfully with token.\"}")
                ));
    }

    @After("@wiremockApi")
    public void teardownWiremockServer() {
        wireMockServer.stop();

    }
}