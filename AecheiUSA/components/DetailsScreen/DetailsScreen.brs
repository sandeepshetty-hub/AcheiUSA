 Function Init()
 ? "[DetailsScreen] init"
    
    m.top.observeField("visible", "onVisibleChange")
    m.top.observeField("focusedChild", "OnFocusedChildChange")
             
    m.buttons           =   m.top.findNode("Buttons")
    m.videoPlayer       =   m.top.findNode("VideoPlayer")
    m.poster            =   m.top.findNode("Poster")
'    m.Title = m.top.findNode("Title")
'    m.Description = m.top.findNode("Description")
    
      m.videoContent = createObject("roSGNode", "ContentNode")
    result = []
    for each button in ["Watch Now", "Watch Later"]
        result.push({title : button})
    end for
    m.buttons.content = ContentList2SimpleNode(result)
 End Function
 


' set proper focus to buttons if Details opened and stops Video if Details closed
Sub onVisibleChange()
    ? "[DetailsScreen] onVisibleChange"
    if m.top.visible = true then
        m.buttons.jumpToItem = 0
        m.buttons.setFocus(true)
    else
        m.videoPlayer.visible = false
        m.videoPlayer.control = "stop"
        m.poster.uri=""
    end if
End Sub

' set proper focus to Buttons in case if return from Video PLayer
Sub OnFocusedChildChange()
    if m.top.isInFocusChain() and not m.buttons.hasFocus() and not m.videoPlayer.hasFocus() then
        m.buttons.setFocus(true)
    end if
End Sub

' set proper focus on buttons and stops video if return from Playback to details
Sub onVideoVisibleChange()
    if m.videoPlayer.visible = false and m.top.visible = true
        m.buttons.setFocus(true)
        m.videoPlayer.control = "stop"
    end if
End Sub

' event handler of Video player msg
Sub OnVideoPlayerStateChange()
    if m.videoPlayer.state = "error"
        ' error handling
        m.videoPlayer.visible = false
    else if m.videoPlayer.state = "playing"
        ' playback handling
    else if m.videoPlayer.state = "finished"
        m.videoPlayer.visible = false
    end if
End Sub

' on Button press handler
Sub onItemSelected()
    ' first button is Play
    if m.top.itemSelected = 0
        m.videoPlayer.visible = true
        m.videoPlayer.setFocus(true)
        m.videoPlayer.control = "play"
        m.videoPlayer.observeField("state", "OnVideoPlayerStateChange")
    end if
End Sub

            ' Content change handler
Sub OnContentChange()
contentItem = m.top.itemContent
print "item content values>>", m.top.itemContent
  '  m.description.content   = m.top.content
    'm.description.Description.width = "770"
     m.videoContent.url = m.top.itemContent.URL
    m.videoPlayer.content   = m.videoContent
    m.poster.uri = contentItem.HDPOSTERURL
    'm.Title.text = contentItem.TITLE
    'm.Description.text = contentItem.DESCRIPTION

End Sub


'Function onKeyEvent(key as String, press as Boolean) as Boolean 
'
'    if press then
'        if (key = "back") then
'            print "back pressed"
'            m.VideoPlayer.visible = "false" 
'            m.videoPlayer.control = "stop"
'            m.detailsScreen.visible = "true"
'           'm.top.visible = false
'            return true
'        end if
'    end if
'end Function

' Helper function convert AA to Node
Function ContentList2SimpleNode(contentList as Object, nodeType = "ContentNode" as String) as Object
    result = createObject("roSGNode",nodeType)
    if result <> invalid
        for each itemAA in contentList
            item = createObject("roSGNode", nodeType)
            item.setFields(itemAA)
            result.appendChild(item)
        end for
    end if
    return result
End Function
