package features.products;

import com.intuit.karate.FileUtils;
import com.intuit.karate.netty.FeatureServer;
import org.junit.AfterClass;
import org.junit.BeforeClass;

import java.io.File;


public class mockStarter {
    private static FeatureServer server;

    @BeforeClass
    public static void beforeClass() {
        String queueName = "DEMO.MOCK";
        File file = FileUtils.getFileRelativeTo(mockStarter.class, "products-mock.feature");
        server = FeatureServer.start(file, 0, false, null );
        String paymentServiceUrl = "http://localhost:" + server.getPort();
    }


    @AfterClass
    public static void afterClass() {
        server.stop();
    }
}
