package com.example.util.paging;

public class Item {
    public enum NavType {
        FIRST, PREV, NEXT, LAST, PAGE, GAP
    };

    private long pageNumber;
    private boolean currentPage;
    private NavType navType;
    private boolean enabled;
    private String label;

    public Item(long pageNumber, boolean currentPage, NavType navType, boolean enabled, String label) {
        this.pageNumber = pageNumber;
        this.currentPage = currentPage;
        this.navType = navType;
        this.enabled = enabled;
        this.label = label;
    }

    public long getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(long pageNumber) {
        this.pageNumber = pageNumber;
    }

    public boolean isCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(boolean currentPage) {
        this.currentPage = currentPage;
    }

    public NavType getNavType() {
        return navType;
    }

    public void setNavType(NavType navType) {
        this.navType = navType;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }
}
