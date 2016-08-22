package com.example.view.layout

import com.example.view.BaseLayout

class AppLayout extends BaseLayout {

    def String render(String body) {
        '''
            <!DOCTYPE html>
            <html>
            <head>
              <meta charset="utf-8" />
              <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
              <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
            
              <title>Xtend::«model.get("title") as String»</title>
            
              <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.2/semantic.css" />
              <link rel="stylesheet" type="text/css" href="/css/semantic-ui-layout.css" />
            </head>
            <body>
              <div class="ui fixed inverted menu">
                <div class="ui container">
                  <div href="#" class="header item">
                    XTend Template Example
                  </div>
                </div>
              </div>
              <div class="ui main text container">
                «body»
              </div>
            </body>
            </html>
        '''
    }
}
