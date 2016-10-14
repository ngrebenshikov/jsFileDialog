package ;

import js.JQuery;
class Example {
    public static function main() {
        FileDialog.init();
        new JQuery("").ready(function(e) {
            new JQuery("#button").click(function(e) {
                FileDialog.open();
            });
        });
    }
}
