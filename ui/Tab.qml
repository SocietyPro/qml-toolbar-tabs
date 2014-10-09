import QtQuick 2.3
import QtWebKit 3.0
import QtWebKit.experimental 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {
    id: module
    signal pageModified(int identifier, string url, string title)
    signal locationRequest(string txt)
    signal urlChanged(int identifier, string url)
    property alias page: webView
    property alias currentUrl: webView.url
    color: "#FFFFFF"

    onWidthChanged: webView.returnToBounds()
    onHeightChanged: webView.returnToBounds()

    ScrollView {
        anchors.fill: parent

        WebView {
            id: webView
            anchors.fill: parent
            //experimental.userAgent: "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36"
            //experimental.userAgent: "Mozilla/5.0 (Linux; U; Android 4.0.3; ko-kr; LG-L160L Build/IML74K) AppleWebkit/534.30    (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"
            //experimental.userAgent: "Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25"
            url: launchUrl
            onTitleChanged: module.pageModified(identifier, url, title)
            onUrlChanged: module.urlChanged(identifier, url)
            onCanGoBackChanged: toolBar.canGoBack = canGoBack
            onCanGoForwardChanged: toolBar.canGoForward = canGoForward
        }
    }
}
