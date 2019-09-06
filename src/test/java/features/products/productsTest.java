package features.products;

import com.intuit.karate.FileUtils;
import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import com.intuit.karate.netty.FeatureServer;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;

import java.io.File;

@RunWith(Karate.class )
@KarateOptions(tags = "~@mock",features = "classpath:features/products/products.feature")
public class productsTest {
    private static FeatureServer server;

    @BeforeClass
    public static void beforeClass() {
         System.setProperty("karate.env", "mock");
        File file = FileUtils.getFileRelativeTo(productsTest.class, "products-mock.feature");
        server = FeatureServer.start(file, 8089, false, null );
    }

    @AfterClass
    public static void afterClass() {
        server.stop();
    }
}