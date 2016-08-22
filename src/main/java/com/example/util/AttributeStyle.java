package com.example.util;

import org.apache.commons.lang.builder.ToStringStyle;

public class AttributeStyle extends ToStringStyle {

    private static final long serialVersionUID = 2714549989872306237L;

    public AttributeStyle() {
        super();
        this.setUseClassName(false);
        this.setUseIdentityHashCode(false);
        this.setNullText("");
        this.setContentStart("");
        this.setFieldSeparator(" ");
        this.setFieldSeparatorAtStart(false);
        this.setContentEnd("");
    }

}
