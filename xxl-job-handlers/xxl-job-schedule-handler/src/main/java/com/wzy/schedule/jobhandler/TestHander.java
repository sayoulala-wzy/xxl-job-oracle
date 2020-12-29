package com.wzy.schedule.jobhandler;

import com.wzy.schedule.service.TestService;
import com.xxl.job.core.biz.model.ReturnT;
import com.xxl.job.core.handler.annotation.XxlJob;
import com.xxl.job.core.log.XxlJobLogger;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Component
public class TestHander {
    private static Logger logger = LoggerFactory.getLogger(TestHander.class);
    @Autowired
    private TestService testService;

    @XxlJob("testHander")
    public ReturnT<String> testHander(String param) throws Exception {
        XxlJobLogger.log("XXL-JOB, Hello World.");
        try {
            List<Map<String, Object>> all = testService.getAll();
            System.out.println("默认数据源==="+all);
            List<Map<String, Object>> baseAll = testService.getBaseAll();
            System.out.println("切换数据源==="+baseAll);
            List<Map<String, Object>> all_1 = testService.getAll();
            System.out.println("再走默认数据源==="+all_1);
        }catch (Exception e){
            e.printStackTrace();
        }
        for (int i = 0; i < 5; i++) {
            XxlJobLogger.log("beat at:" + i);
            TimeUnit.SECONDS.sleep(2);
        }
        return ReturnT.SUCCESS;
    }



}
