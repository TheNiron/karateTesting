package features.products;

import com.intuit.karate.FileUtils;
import com.intuit.karate.netty.FeatureServer;

import java.io.File;

public class mockServer {
    private static FeatureServer server;

    public static void start() {
         System.setProperty("karate.env", "mock");
        File file = FileUtils.getFileRelativeTo(productsRunner.class, "products-mock.feature");
        server = FeatureServer.start(file, 8089, false, null );
    }

    public static void shutdown() {
        server.stop();
    }
}
