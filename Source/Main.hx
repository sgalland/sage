package;

import sage.agi.AGIResourceType;
import sage.agi.AGIFileNameTools;
import sage.agi.helpers.AGIColor;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import sage.agi.resources.AGIFileReader;
import openfl.display.Sprite;
import sage.agi.resources.AGIView;
import sage.agi.resources.AGIPicture;
import sage.agi.interpreter.AGIInterpreter;

class Main extends Sprite {
	var drawable:AGIPicture;

	public function new() {
		super();

		lime.app.Application.current.window.title = "SAGE";

		while (true) {
			AGIInterpreter.instance.run();
		}

		// TODO: Keep this for later
		// https://www.openfl.org/learn/npm/api/classes/openfl.display.bitmapdata.html#setpixels
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/BitmapData.html#setPixels()
		// try {
		// 	var data:Array<Int> = [for (i in drawable.getPicturePixels()) i];

		// 	AGIColorConverter.convertPixelsToRGB(data);
		// 	render(this, 0, 0, 320, 200, data, AGIColor.getColorByDosColor(15));
		// 	// render(this, target.width * 4 + 10, 0, target.width, target.height, target.data, target.transparentColor);
		// 	// render(this, target.width * 8 + 20, 0, target.width, target.height, target.data, target.transparentColor);
		// } catch (e:String) {
		// 	trace(e);
		// }
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
		// bitmap.scaleX = 4;
		// bitmap.scaleY = 4;
		bitmap.x = x;
		bitmap.y = y;
		stage.addChild(bitmap);
	}
}
