package com.ludoko.circular;

import haxe.ds.IntMap.IntMap;
import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxState;

/**
 * Game state
 * 
 * @author Michael Lee
 */
class PlayState extends FlxState
{

	
	public static inline var NUM_LAYERS:Int = 7;
	public static inline var MAX_ROTATION_SPEED:Float = 180;
	
	public var position:Int;
	public var rotation:Float = 0;
	public var nextDot:Int;
	
	public function new() 
	{
		super();
		
		G.playstate = this;
	}
	
	override public function create():Void 
	{
		G.halfWidth = FlxG.width * 0.5;
		G.halfHeight = FlxG.height * 0.5;
		
		// Set a background color
		FlxG.bgColor = 0xfff2f2f2;
		
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.hide();
		FlxG.mouse.useSystemCursor = true;
		#end
		
		super.create();
		
		
		add(new Background());
		
		_center = new Center();
		add(_center);
		
		_emptyGroup = new FlxGroup();
		add(_emptyGroup);
		_dotsGroup = new FlxGroup();
		add(_dotsGroup);
		
		_emptyDots = new Array<Dot>();
		_dots = new Array<Dot>();
		_layers = new IntMap<IntMap<Dot>>();
		
		var i:Int;
		var j:Int;
		
		for (i in 0 ... 5)
		{
			var layer:IntMap<Dot> = new IntMap<Dot>();
			for (j in 0 ... Dot.dotsOnLayer(i))
			{
				addEmptyDot(i, j);
				
				layer.set(i, null);
			}
			_layers.set(i, layer);
		}
		
		/*for (i in 0 ... 1)
		{
			for (j in 0 ... Dot.dotsOnLayer(i))
			{
				addDot(i, j);
			}
		}*/
		
		nextDot = Dot.randomDotType();
		_center.changeDot(nextDot);
	}
	
	public function addEmptyDot(Layer:Int, Position:Int):Dot
	{
		var d:Dot = new Dot(Layer, Position, rotation, true);
		_emptyGroup.add(d);
		_emptyDots.push(d);
		
		return d;
	}
	
	public function addDot(Layer:Int, Position:Int, DotType:Int = -1):Dot
	{
		var layer:IntMap<Dot> = _layers.get(Layer);
		if (layer.get(Position) != null)
		{
			var od:Dot = layer.get(Position);
			od.moveUp();
		}
		
		var d:Dot = new Dot(Layer, Position, 0, false, DotType);
		_dotsGroup.add(d);
		_dots.push(d);
		
		layer.set(Position, d);
		
		return d;
	}
	
	public function getDot(Layer:Int, Position:Int):Dot
	{
		if (Layer >= NUM_LAYERS) return null;
		if (Position >= Dot.dotsOnLayer(Layer)) return null;
		return _layers.get(Layer).get(Position);
	}
	
	
	override public function update():Void
	{
		var ang:Float = 0;
		if (FlxG.keys.justPressed("LEFT"))
		{
			position--;
			ang -= 360 / 10;
		}
		else if (FlxG.keys.justPressed("RIGHT"))
		{
			position++;
			ang += 360 / 10;
		}
		
		if (position < 0) position += 10;
		else if (position >= 10) position -= 10;
		
		/*if (FlxG.keys.pressed("LEFT"))
		{
			ang -= MAX_ROTATION_SPEED * FlxG.elapsed;
		}
		else if (FlxG.keys.pressed("RIGHT"))
		{
			ang += MAX_ROTATION_SPEED * FlxG.elapsed;
		}*/
		
		if (FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("SPACE"))
		{
			addDot(0, position, nextDot);
			
			nextDot = Dot.randomDotType();
			_center.changeDot(nextDot);
		}
		
		rotation += ang;
		if (ang != 0)
		{
			_center.rotate(rotation);
			
			/*var d:Dot;
			for (d in _emptyDots)
			{
				d.rotate(rotation);
			}
			
			for (d in _dots)
			{
				d.rotate(rotation);
			}*/
		}
		
		super.update();
	}
	
	private var _center:Center;
	
	private var _emptyGroup:FlxGroup;
	private var _emptyDots:Array<Dot>;
	
	private var _dotsGroup:FlxGroup;
	private var _dots:Array<Dot>;
	private var _layers:IntMap<IntMap<Dot>>;
	
}