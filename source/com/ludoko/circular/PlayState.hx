package com.ludoko.circular;

import org.flixel.FlxG;
import org.flixel.FlxState;

/**
 * Game state
 * 
 * @author Michael Lee
 */
class PlayState extends FlxState
{

	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		// Set a background color
		FlxG.bgColor = 0xff131c1b;
		
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.hide();
		FlxG.mouse.useSystemCursor = true;
		#end
		
		super.create();
	}
	
}