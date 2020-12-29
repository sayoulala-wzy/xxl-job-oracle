package com.wzy.schedule.service;

import java.util.List;
import java.util.Map;

public interface TestService {


    /**
     * 默认数据源
     * @return
     */
    List<Map<String,Object>> getAll();

    /**
     * 切换一次数据源
     * @return
     */
    List<Map<String,Object>> getBaseAll();

}
