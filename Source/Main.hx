package;

import sage.agi.resources.AGIFileReader;
import openfl.ui.Keyboard;
import lime.ui.KeyCode;
import haxe.EnumTools;
import lime.ui.ScanCode;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import sage.agi.helpers.AGIColor;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import sage.agi.resources.AGIPicture;
import sage.agi.interpreter.AGIInterpreter;
import sage.agi.AGIResourceType;

class Main extends Sprite {
	var drawable:AGIPicture;

	public function new() {
		super();

		lime.app.Application.current.window.title = "SAGE";
		AGIInterpreter.instance.initialize();

		/**
			Setup a main event loop
		**/
		stage.addEventListener(Event.ENTER_FRAME, function(event:Event) {
			AGIInterpreter.instance.run();

			// render(this, 0, 0, 320, 200, AGIInterpreter.instance.RENDERER.videoBackBuffer.toArray(), AGIColor.getColorByDosColor(0));
		});

		stage.addEventListener(KeyboardEvent.KEY_DOWN, function(event:KeyboardEvent) {
			if (event.keyCode == Keyboard.F1)
				trace("F1!");
			trace('convert: ${event.keyCode}');
			trace('F1 keycode = ${KeyCode.F1}');
			trace('charcode: ${event.charCode}');
			trace('keycode: ${KeyCode.fromScanCode(ScanCode.F1)}');
			trace('scancode: ${ScanCode.fromKeyCode(KeyCode.F1)}');
			trace('keyboard code: ${Keyboard.F1}');
			trace('ScanCode from keyboard code: ${ScanCode.fromKeyCode(event.keyCode)}');
			trace('ScanCode from Keyboard?? ${ScanCode.fromKeyCode(Keyboard.F1)}');
		});

		// TODO: Keep this for later
		// https://www.openfl.org/learn/npm/api/classes/openfl.display.bitmapdata.html#setpixels
		// https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/BitmapData.html#setPixels()
		try {			
			var reader = new AGIFileReader();
			reader.loadDirectoryEntries(AGIResourceType.PICTURE);
			var data = new AGIPicture(reader.getFile(67)).getPicturePixels().toArray();
			AGIColorConverter.convertPixelsToRGB(data);
			render(this, 0, 0, 320, 200, data, AGIColor.getColorByDosColor(15));

			// var data:Array<Int> = [for (i in drawable.getPicturePixels()) i];
			// AGIColorConverter.convertPixelsToRGB(data);
			// render(this, 0, 0, 320, 200, data, AGIColor.getColorByDosColor(15));
			// render(this, target.width * 4 + 10, 0, target.width, target.height, target.data, target.transparentColor);
			// render(this, target.width * 8 + 20, 0, target.width, target.height, target.data, target.transparentColor);
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
		// bitmap.scaleX = 4;
		// bitmap.scaleY = 4;
		bitmap.x = x;
		bitmap.y = y;
		stage.addChild(bitmap);
	}
}
