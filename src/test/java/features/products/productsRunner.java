package features.products;


import com.intuit.karate.junit4.Karate;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;
import features.authorization.WireMockHook;

@RunWith(Karate.class)
public class productsRunner {

    static WireMockHook wiremock = new WireMockHook();

    @BeforeClass
    public static void beforeClass() {
        System.setProperty("karate.env", "mock");
    }

    @AfterClass
    public static void afterClass() {
        wiremock.teardownWiremockServer();
    }

}