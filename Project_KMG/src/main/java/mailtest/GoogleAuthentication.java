package mailtest;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
    
    public GoogleAuthentication(){
        passAuth = new PasswordAuthentication("kmg3167@gmail.com", "hsvvgerjvrhatjux");
    }
 
    public PasswordAuthentication getPasswordAuthentication() {
        return passAuth;
    }
}
