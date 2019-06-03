package;

import sage.agi.helpers.AGIColor;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import sage.agi.resources.AGIFileReader;
import sage.agi.EAGIFileName;
import openfl.display.Sprite;
import sage.agi.resources.AGIView;

class Main extends Sprite {
	var drawable:AGIView;

	public function new() {
		super();

		lime.app.Application.current.window.title = "SAGE";

		var interpreter = new sage.agi.interpreter.AGIInterpreter.AGIInterpreter();

		// Sys.setCwd("C:\\Users\\sgalland\\Desktop\\AGIDATA\\DOS\\AGI2\\BC_2_439");
		var reader = new AGIFileReader();
		// reader.loadDirectoryEntries(EAGIFileName.LOGIC);
		// var file = reader.getFile(0);
		// var logic = new AGILogic(file, 0);
		// trace(logic.getMessage(0));

		reader.loadDirectoryEntries(EAGIFileName.VIEW);
		var file = reader.getFile(0);

		drawable = new AGIView(file);
		var target:ViewCell = drawable.getViewLoops()[0].loopCells[0];

		// https://www.openfl.org/learn/npm/api/classes/openfl.display.bitmapdata.html#setpixels
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/BitmapData.html#setPixels()
		try {
			AGIColorConverter.convertPixelsToRGB(target.data);
			render(this, 0, 0, target.width, target.height, target.data, target.transparentColor);
			render(this, target.width * 4 + 10, 0, target.width, target.height, target.data, target.transparentColor);
			render(this, target.width * 8 + 20, 0, target.width, target.height, target.data, target.transparentColor);
		} catch (e:String) {
			trace(e);
		}
	}

	static function render(stage:Sprite, x:Int, y:Int, width:Int, height:Int, bytes:Array<Int>, transparentColor:AGIColor) {
		var r = transparentColor.r;
		var g = transparentColor.g;
		var b = transparentColor.b;
		var data = new BitmapData(width, height, false, AGIColorConverter.convertRGBToARGBInteger(r, g, b));
		var rect = new Rectangle(0, 0, width, height);
		var byteArray = data.getPixels(rect);
		for (i in bytes)
			byteArray.writeInt(i);

		byteArray.position = 0;
		data.setPixels(rect, byteArray);

		var bitmap = new Bitmap(data);
		bitmap.scaleX = 4;
		bitmap.scaleY = 4;
		bitmap.x = x;
		bitmap.y = y;
		stage.addChild(bitmap);
	}
}
