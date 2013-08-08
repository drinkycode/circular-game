package com.ludoko.circular;

import org.flixel.FlxGroup;
import org.flixel.FlxSprite;

/**
 * ...
 * @author Michael Lee
 */
class Center extends FlxGroup
{

	public static inline var RADIUS:Int = 36;
	
	public function new() 
	{
		super();
		
		_center = new FlxSprite(G.halfWidth - RADIUS, G.halfHeight - RADIUS, "assets/imgs/center.png");
		add(_center);
		_center.antialiasing = true;
		
		_dot = new FlxSprite(G.halfWidth - 32, G.halfHeight - 32);
		add(_dot);
		_dot.loadGraphic("assets/imgs/dots.png", true, false, 64, 64);
		_dot.addAnimation("0", [0], 0, false);
		_dot.play("0");
	}
	
	public function rotate(Rotation:Float):Void
	{
		_center.angle = Rotation;
	}
	
	public function changeDot(DotType:Int):Void
	{
		_dot.color = Dot.dotColor(DotType);
	}
	
	override public function update():Void
	{
		super.update();
	}
	
	private var _center:FlxSprite;
	private var _dot:FlxSprite;
	
}