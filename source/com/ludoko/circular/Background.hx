package com.ludoko.circular;

import org.flixel.FlxGroup;
import org.flixel.FlxSprite;

/**
 * Background concentric circles
 * 
 * @author Michael Lee
 */
class Background extends FlxGroup
{

	public function new() 
	{
		super();
		
		_circles = new Array<FlxSprite>();
		
		addCircle(456, 0xb9b7b7, 0.03);
		addCircle(352, 0xffffff, 0.4);
		addCircle(264, 0xb9b7b7, 0.06);
		addCircle(188, 0xffffff, 0.4);
		addCircle(128, 0xb9b7b7, 0.12);
	}
	
	private function addCircle(Size:Float, Color:Int, Alpha:Float = 1):Void
	{
		var hsize:Float = 500 * 0.5;
		var c:FlxSprite = new FlxSprite(G.halfWidth - hsize, G.halfHeight - hsize, "assets/imgs/circle.png");
		c.antialiasing = true;
		
		var scale:Float = Size / 500;
		c.scale.x = c.scale.y = scale;
		
		c.color = Color;
		c.alpha = Alpha;
		
		add(c);
		_circles.push(c);
	}
	
	private var _circles:Array<FlxSprite>;
	
}