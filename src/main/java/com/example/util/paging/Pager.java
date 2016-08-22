package com.example.util.paging;

import java.util.ArrayList;
import java.util.List;
import java.util.SortedSet;
import java.util.TreeSet;

public class Pager {
    private long pageCount;
    private long currentPage;
    private int innerItemsCount;
    private int outerItemsCount;
    private boolean showFirstLast = false;

    public long getPageCount() {
        return pageCount;
    }

    public void setPageCount(long pageCount) {
        this.pageCount = pageCount;
    }

    public long getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(long currentPage) {
        this.currentPage = currentPage;
    }

    public int getInnerItemsCount() {
        return innerItemsCount;
    }

    public void setInnerItemsCount(int innerItemsCount) {
        this.innerItemsCount = innerItemsCount;
    }

    public int getOuterItemsCount() {
        return outerItemsCount;
    }

    public void setOuterItemsCount(int outerItemsCount) {
        this.outerItemsCount = outerItemsCount;
    }

    public boolean isShowFirstLast() {
        return showFirstLast;
    }

    public void setShowFirstLast(boolean showFirstLast) {
        this.showFirstLast = showFirstLast;
    }

    public List<Item> getItems() {
        List<Item> pagerItems = new ArrayList<Item>();

        if (pageCount < 2) {
            return pagerItems;
        }

        SortedSet<Long> items = new TreeSet<Long>();

        items.add(new Long(currentPage));

        // inner items left of currentPage
        for (int i = 0; i < innerItemsCount; i++) {
            long index = currentPage - i - 1;
            if (index >= 0) {
                items.add(new Long(index));
            }
        }

        // inner items right of currentPage
        for (int i = 0; i < innerItemsCount; i++) {
            long index = currentPage + i + 1;
            if (index < pageCount) {
                items.add(new Long(index));
            }
        }

        // outer items left of currentPage
        for (int i = 0; i < outerItemsCount; i++) {
            if (i <= currentPage) {
                items.add(new Long(i));
            }
        }

        // outer items right of currentPage
        for (int i = 0; i < outerItemsCount; i++) {
            long index = pageCount - i - 1;
            if (index >= currentPage) {
                items.add(new Long(index));
            }
        }

        Long[] itemsArray = items.toArray(new Long[items.size()]);

        int itemsCount = items.size();

        Long compareTo = itemsArray[0];
        for (int i = 0; i < itemsCount; i++) {
            compareTo = itemsArray[i];
            pagerItems.add(new Item(itemsArray[i], currentPage == itemsArray[i], Item.NavType.PAGE, true,
                    String.valueOf(itemsArray[i] + 1)));

            if (i < itemsCount - 1) {
                if ((itemsArray[i + 1] - compareTo) > 1) {
                    pagerItems.add(new Item(-1, false, Item.NavType.GAP, false, "..."));
                }
            }
        }

        long prevPage = currentPage - 1;
        if (prevPage < 0) {
            prevPage = -1;
        }

        pagerItems.add(0, new Item(prevPage, currentPage == prevPage, Item.NavType.PREV, prevPage != -1, "Previous"));

        if (isShowFirstLast()) {
            pagerItems.add(0, new Item(0, currentPage == 0, Item.NavType.FIRST, currentPage != 0, "First"));
        }

        long nextPage = currentPage + 1;
        if (nextPage >= pageCount) {
            nextPage = -1;
        }

        pagerItems.add(new Item(nextPage, currentPage == nextPage, Item.NavType.NEXT, nextPage != -1, "Next"));

        if (isShowFirstLast()) {
            pagerItems.add(new Item(pageCount - 1, currentPage == pageCount - 1, Item.NavType.LAST,
                    currentPage != (pageCount - 1), "Last"));
        }

        return pagerItems;
    }
}
