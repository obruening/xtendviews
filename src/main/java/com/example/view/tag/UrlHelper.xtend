package com.example.view.tag

import java.util.List
import java.util.Map
import org.springframework.util.LinkedMultiValueMap
import org.springframework.web.util.UriComponentsBuilder

class UrlHelper {

    def static toUrl(String path, List<String> params, Map<String, String> queryParams) {
        val multiValueMap = new LinkedMultiValueMap<String, String>()
        for (Map.Entry<String, String> queryParam : queryParams.entrySet()) {
            multiValueMap.add(queryParam.getKey(), queryParam.getValue())
        }
        return UriComponentsBuilder.fromPath(path).queryParams(multiValueMap).buildAndExpand(params.toArray()).toString
    }

}
