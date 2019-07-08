package;

import openfl.events.KeyboardEvent;
import sage.agi.AGIVersion;
import sage.agi.helpers.AGIColor;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import sage.agi.resources.AGIFileReader;
import sage.agi.EAGIFileName;
import openfl.display.Sprite;
import sage.agi.resources.AGIView;
import sage.agi.resources.AGIPicture;

class Main extends Sprite {
	var viewLoop:Int = 0;
	var cell:Int = 0;

	public function new() {
		super();

		lime.app.Application.current.window.title = "SAGE";

		var interpreter = new sage.agi.interpreter.AGIInterpreter.AGIInterpreter();
		var version = AGIVersion.getVersion();
		trace(version);

		// Sys.setCwd("C:\\Users\\sgalland\\Desktop\\AGIDATA\\DOS\\AGI2\\BC_2_439");
		var reader = new AGIFileReader();
		// reader.loadDirectoryEntries(EAGIFileName.LOGIC);
		// var file = reader.getFile(0);
		// var logic = new AGILogic(file, 0);
		// trace(logic.getMessage(0));

		// var createDrawable = function(fileNumber:Int):ViewCell {
		// 	reader.loadDirectoryEntries(EAGIFileName.VIEW);
		// 	var file = reader.getFile(fileNumber);
		// 	var drawable:AGIView = new AGIView(file);
		// 	trace('viewLoop=$viewLoop');
		// 	var target:ViewCell = drawable.getViewLoops()[viewLoop].loopCells[cell];
		// 	AGIColorConverter.convertPixelsToRGB(target.data);
		// 	return target;
		// };

		// var target0 = createDrawable(0);
		// var target1 = createDrawable(1);
		// var target2 = createDrawable(2);

		// https://www.openfl.org/learn/npm/api/classes/openfl.display.bitmapdata.html#setpixels
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/BitmapData.html#setPixels()
		// try {
		// 	render(this, 0, 0, target0.width, target0.height, target0.data, target0.transparentColor);
		// 	// render(this, target1.width * 4 + 10, 0, target1.width, target1.height, target1.data, target1.transparentColor);
		// 	// render(this, target2.width * 8 + 20, 0, target2.width, target2.height, target2.data, target2.transparentColor);
		// } catch (e:String) {
		// 	trace(e);
		// }

		// stage.addEventListener(KeyboardEvent.KEY_DOWN, function(evt:KeyboardEvent) {
		// 	if (evt.keyCode == 38) { // Check if up arrow in pressed
		// 		if (this.viewLoop < 4)
		// 			this.viewLoop++;

		// 		trace(viewLoop);

		// 		var target0 = createDrawable(0);
		// 		if (stage.numChildren > 0)
		// 			stage.removeChildren();
		// 		render(this, 0, 0, target0.width, target0.height, target0.data, target0.transparentColor);
		// 	}

		// 	// Check if the down arrow is pressed
		// 	if (evt.keyCode == 40) { // Check if up arrow in pressed
		// 		if (this.viewLoop > 0)
		// 			this.viewLoop--;

		// 		trace(viewLoop);

		// 		var target0 = createDrawable(0);
		// 		if (stage.numChildren > 0)
		// 			stage.removeChildren();
		// 		render(this, 0, 0, target0.width, target0.height, target0.data, target0.transparentColor);
		// 	}
		// });

		reader.loadDirectoryEntries(EAGIFileName.PICTURE);
		var file = reader.getFile(1);
		var pic = new AGIPicture(file);
		var pixs = pic.getPicturePixels().toArray();
		AGIColorConverter.convertPixelsToRGB(pixs);
		render(this, 0, 0, 320, 200, pixs, AGIColor.getColorByDosColor(15));
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
