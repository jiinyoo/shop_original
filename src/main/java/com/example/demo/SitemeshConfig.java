package com.example.demo;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class SitemeshConfig extends ConfigurableSiteMeshFilter{

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder)
	{
	 
		builder.addDecoratorPath("*", "/default.jsp");
		//admin폴더에 있는 모든 jsp를 출력시켜라
		builder.addDecoratorPath("/admin/*", "/views/common/admin.jsp");
        System.out.println("site");
        
        //제외할 폴더와 문서
        builder.addExcludedPath("/test/*");
        
        super.applyCustomConfiguration(builder);
        //부모클래스의 속성을 적용한다.
        
	}
}

//WEB-INF/decorators/views/common/default.jsp