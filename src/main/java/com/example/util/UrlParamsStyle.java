package com.example.util;

import org.apache.commons.lang.builder.ToStringStyle;

public class UrlParamsStyle extends ToStringStyle {

    private static final long serialVersionUID = -469146821114408950L;

    public UrlParamsStyle() {
        super();
        this.setUseClassName(false);
        this.setUseIdentityHashCode(false);
        this.setNullText("");
        this.setContentStart("");
        this.setFieldSeparator("&");
        this.setFieldSeparatorAtStart(true);
        this.setContentEnd("");
    }

}
