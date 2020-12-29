package com.wzy.schedule.service.impl;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.wzy.schedule.mapper.TestMapper;
import com.wzy.schedule.service.TestService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class TestServiceImpl implements TestService {

    @Resource
    private TestMapper testMapper;

    @Override
    public List<Map<String, Object>> getAll() {
        return testMapper.getAll();
    }

    /**
     * 切换一次数据源
     *
     * @return
     */
    @Override
    @DS("basic")
    public List<Map<String, Object>> getBaseAll() {
        return testMapper.getBaseAll();
    }

}
