package openfl.geom; #if !flash #if (display || openfl_next || js)


import openfl.display.DisplayObject;


class Transform {
	
	
	public var colorTransform:ColorTransform;
	public var concatenatedColorTransform:ColorTransform;
	public var concatenatedMatrix:Matrix;
	public var matrix (get, set):Matrix;
	public var pixelBounds:Rectangle;
	
	@:noCompletion private var __displayObject:DisplayObject;
	@:noCompletion private var __matrix:Matrix;
	
	
	public function new (displayObject:DisplayObject) {
		
		colorTransform = new ColorTransform ();
		concatenatedColorTransform = new ColorTransform ();
		concatenatedMatrix = new Matrix ();
		pixelBounds = new Rectangle ();
		
		__displayObject = displayObject;
		__matrix = new Matrix ();
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	
	
	@:noCompletion private function get_matrix ():Matrix {
		
		if (__matrix != null) {
			
			__matrix.identity ();
			__matrix.scale (__displayObject.scaleX, __displayObject.scaleY);
			__matrix.rotate (__displayObject.rotation * (Math.PI / 180));
			__matrix.translate (__displayObject.x, __displayObject.y);
			
			return __matrix.clone ();
			
		}
		
		return null;
		
	}
	
	
	@:noCompletion private function set_matrix (value:Matrix):Matrix {
		
		if (value == null) {
			
			return __matrix = null;
			
		}
		
		if (__displayObject != null) {
			
			__displayObject.x = value.tx;
			__displayObject.y = value.ty;
			__displayObject.__skewX = Math.atan(-value.c / value.d);
			__displayObject.__skewY = Math.atan( value.b / value.a);
			__displayObject.scaleX = value.a / Math.cos(__displayObject.__skewY);
			__displayObject.scaleY = value.d / Math.cos(__displayObject.__skewX);
			if (Math.abs(__displayObject.__skewX - __displayObject.__skewY) < 0.001)
			{
				__displayObject.rotation = __displayObject.__skewX * 180.0 / Math.PI;
				__displayObject.__skewX = __displayObject.__skewY = 0.0;
			}
			else
				__displayObject.rotation = 0.0;
			
		}
		
		return value;
		
	}
	
	
}


#else
typedef Transform = openfl._v2.geom.Transform;
#end
#else
typedef Transform = flash.geom.Transform;
#end