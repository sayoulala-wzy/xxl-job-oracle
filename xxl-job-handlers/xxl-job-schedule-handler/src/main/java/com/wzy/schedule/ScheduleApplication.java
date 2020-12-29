package com.wzy.schedule;

import com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author xuxueli 2018-10-28 00:38:13
 */
@SpringBootApplication(exclude = DruidDataSourceAutoConfigure.class) // mybatisplus配置动态数据源时，切记需要关闭自带的自动数据源配置
public class ScheduleApplication {

	public static void main(String[] args) {
        SpringApplication.run(ScheduleApplication.class, args);
	}

}