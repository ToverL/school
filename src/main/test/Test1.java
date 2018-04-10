import com.oracle.dao.DiskDao;
import com.oracle.service.DiskService;
import com.oracle.vo.Disk;
import com.sun.org.apache.bcel.internal.generic.NEW;
import com.sun.xml.internal.ws.message.source.PayloadSourceMessage;
import org.junit.Test;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sun.applet.Main;
import sun.misc.PostVMInitHook;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Stack;
@Service
public class Test1 {


@Autowired
    DiskService diskService;

@Autowired
    DiskDao diskDao;

   @Test
    public void test1(){


    }

}
