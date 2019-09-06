package features.authorization;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(features = "classpath:features/authorization/authorization.feature")
public class authorizationTest {
   static WireMockHook wiremock = new WireMockHook();

   @BeforeClass
   public static void beforeClass() {
      System.setProperty("karate.env", "mock");
      wiremock.setupWiremockServer();
   }

   @AfterClass
   public static void afterClass() {
      wiremock.teardownWiremockServer();
   }
   }