package;

import flash.Lib;
import org.flixel.FlxGame;

import com.ludoko.circular.MenuState;
import com.ludoko.circular.PlayState;

class Game extends FlxGame
{	
	public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		var ratioX:Float = stageWidth / 960;
		var ratioY:Float = stageHeight / 640;
		var ratio:Float = Math.min(ratioX, ratioY);
		
		
		super(Math.ceil(stageWidth / ratio), Math.ceil(stageHeight / ratio), PlayState, ratio, 60, 60);
	}
}
