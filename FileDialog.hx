package ;

import haxe.io.Bytes;
import js.html.FileReader;
import js.html.InputElement;
import js.jquery.JQuery;

class FileDialog {

    private var INPUT_ID = "haxe-js-file-dialog-input";
    private var input = null;

    private var inputElement(get, never): InputElement;
    private function get_inputElement(): InputElement {
        return cast new JQuery("#"+INPUT_ID).get(0);
    }

    public function new(inputId: String, acceptFileTypes: Array<String> = null, multiple: Bool = false) {
        new JQuery("").ready(function(e) {
            INPUT_ID += inputId;
            var accept: String;
            if (acceptFileTypes != null) {
                accept = acceptFileTypes.toString();
            } else accept = "";
            if (input == null) input = new JQuery("<input id='" + INPUT_ID + "' type='file' accept='" + accept + "' style='display:none' ></input>");
            else input.attr('accept', accept);
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

    public function open() {
        new JQuery("#"+INPUT_ID).click();
    }

    public function dispose() {
        new JQuery("#"+INPUT_ID).remove();
    }

    public dynamic function onLoadEnd(name: String, type: String, bytes: Bytes) {}

}
