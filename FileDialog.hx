package ;

import haxe.io.Bytes;
import js.html.FileReader;
import js.html.InputElement;
import js.JQuery;

class FileDialog {

    private static var INPUT_ID = "haxe-js-file-dialog-input";

    private static var inputElement(get, never): InputElement;
    private static function get_inputElement(): InputElement {
        return cast new JQuery("#"+INPUT_ID).get(0);
    }

    public static function init(multiple: Bool = false, accept: String = null) {
        new JQuery("").ready(function(e) {
            var input = new JQuery("<input id='" + INPUT_ID + "' type='file' style='display:none' ></input>");
            input.appendTo("body");
            input.change(function(e) {
                var f = inputElement.files[0];
                var r = new FileReader();
                r.onloadend = function(e) {
                    if (null != onLoadEnd) {
                        onLoadEnd(f.name, f.type, Bytes.ofData(r.result));
                    };
                };
                r.readAsArrayBuffer(f);
            });
        });
    }

    public static function open() {
        new JQuery("#"+INPUT_ID).click();
    }

    public static dynamic function onLoadEnd(name: String, type: String, bytes: Bytes) {}

}
