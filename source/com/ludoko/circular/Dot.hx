package com.ludoko.circular;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.util.FlxAngle;
import org.flixel.util.FlxMath;
import org.flixel.util.FlxRandom;

/**
 * Game dot
 * 
 * @author Michael Lee
 */
class Dot extends FlxSprite
{
	
	public static function dotsOnLayer(Layer:Int):Int
	{
		return 10;
		
		switch (Layer) 
		{
			case 0: return 20;
			case 1: return 24;
			case 2: return 32;
			case 3: return 38;
			case 4: return 44;
			case 5: return 50;
			case 6: return 56;
		}
		return 20;
	}
	
	public static function dotColor(DotType:Int):Int 
	{
		switch (DotType) 
		{
			case 0: return 0xdd4646;
			case 1: return 0xf8cc55;
			case 2: return 0x5787a5;
		}
		return 0xffffff;
	}
	
	public static function randomDotType():Int
	{
		return FlxRandom.intRanged(0, 2);
	}
	
	public static inline var INITIAL_SPACER:Int = 4;
	public static inline var SPACER:Int = 4;
	
	public var dotType:Int;
	
	public var size:Int;
	public var halfSize:Int;
	
	public var diameter:Int;
	public var radius:Int;
	
	public var layer:Int;
	public var position:Int;
	
	public function new(Layer:Int, Position:Int, InitialAngle:Float = 0, Empty:Bool = false, DotType:Int = -1) 
	{
		super(0, 0);
		
		size = 64;
		halfSize = Std.int(size * 0.5);
		
		setLayer(Layer);
		setPosition(Position);
		
		loadGraphic("assets/imgs/dots.png", true, false, 64, 64);
		addAnimation("0", [0], 0, false);
		addAnimation("1", [1], 0, false);
		addAnimation("2", [2], 0, false);
		addAnimation("3", [3], 0, false);
		addAnimation("4", [4], 0, false);
		addAnimation("5", [5], 0, false);
		addAnimation("6", [6], 0, false);
		addAnimation("7", [7], 0, false);
		
		if (!Empty)
		{
			if (DotType == -1)
			{
				dotType = randomDotType();
			}
			else
			{
				dotType = DotType;
			}
			color = dotColor(dotType);
		}
		else
		{
			dotType = -1;
			color = (position % 2 == 0) ? 0xe9e9e9 : 0xe7e4e4;
		}
		
		// Adjust hitbox
		//width = height = diameter;
		//offset.x = (size - width) * 0.5;
		//offset.y = (size - height) * 0.5;
		
		setXY(InitialAngle);
		play(_sizeAnim);
	}
	
	public function rotate(Rotation:Float):Void
	{
		setXY(Rotation);
	}
	
	public function moveUp():Void
	{
		setLayer(layer + 1);
		play(_sizeAnim);
		setXY();
	}
	
	public function setLayer(Layer:Int):Void
	{
		layer = Layer;
		
		diameter = getLayerDotSize(layer);
		radius = Std.int(diameter * 0.5);
		
		_sizeAnim = Std.string(layer);
		//_sizeAnim = "0";
		
		// Radius of core + spacer + radius of first layer dot + (diameter of dot + spacer)
		_currentDist = Center.RADIUS + INITIAL_SPACER + getLayerDotSize(0) * 0.5;
		
		if (layer > 0)
		{
			var i:Int;
			for (i in 1 ... layer + 1)
			{
				_currentDist += getLayerDotSize(i - 1) * 0.5 + getLayerDotSize(i) * 0.5 + SPACER + layerAdjust(i);
				//_currentDist += getLayerDotSize(0);
			}
		}
	}
	
	private function getLayerDotSize(Layer:Int):Int
	{
		switch (Layer) 
		{
			case 0: return 22;
			case 1: return 26;
			case 2: return 34;
			case 3: return 40;
			case 4: return 46;
			case 5: return 52;
			case 6: return 58;
		}
		return 64;
	}
	
	private function layerAdjust(Layer:Int):Int
	{
		return 0;
		switch (Layer) 
		{
			case 2: return -2;
			case 3: return -3;
			case 4: return -6;
			case 5: return -8;
			case 6: return -12;
		}
		return 0;
	}
	
	public function setPosition(Position:Int):Void
	{
		position = Position;
		var positionOffset:Float = 360 / dotsOnLayer(layer);
		//_positionAngleOffset = positionOffset * position + ((layer % 2 == 1) ? positionOffset * 0.5 : 0);
		_positionAngleOffset = positionOffset * position;
	}
	
	private function setXY(Rotation:Float = 0):Void
	{
		var rot:Float = Rotation + _positionAngleOffset;
		var cx:Float = G.halfWidth;
		var cy:Float = G.halfHeight;
		
		var rad:Float = FlxAngle.asRadians(rot);
		var dx:Float = cx + Math.sin(rad) * _currentDist;
		var dy:Float = cy - Math.cos(rad) * _currentDist;
		
		x = dx - halfSize;
		y = dy - halfSize;
	}
	
	private var _rotation:Float;
	
	private var _currentDist:Float;
	private var _positionAngleOffset:Float;
	private var _sizeAnim:String;
	
}