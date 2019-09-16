package features.products;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class )
@KarateOptions(tags = "~@mock",features = "classpath:features/products/products.feature")
public class productsRunner {

}