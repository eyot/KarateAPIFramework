package in.reqres;

import com.intuit.karate.junit5.Karate;

class UsersTest {
    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:in/reqres/feature/Users.feature");
    }
}