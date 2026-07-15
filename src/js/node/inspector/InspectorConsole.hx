/*
 * Copyright (C)2014-2026 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package js.node.inspector;

import haxe.extern.Rest;

/**
	Object used to send messages to the remote inspector console.

	Exposed by the V8 inspector console API; method signatures deliberately differ
	from (and are more permissive than) the Node.js `console` API.

	@see https://nodejs.org/docs/latest-v24.x/api/inspector.html#inspectorconsole
**/
extern class InspectorConsole {
	function debug(data:Rest<Any>):Void;
	function error(data:Rest<Any>):Void;
	function info(data:Rest<Any>):Void;
	function log(data:Rest<Any>):Void;
	function warn(data:Rest<Any>):Void;
	function dir(data:Rest<Any>):Void;
	function dirxml(data:Rest<Any>):Void;
	function table(data:Rest<Any>):Void;
	function trace(data:Rest<Any>):Void;
	function group(data:Rest<Any>):Void;
	function groupCollapsed(data:Rest<Any>):Void;
	function groupEnd(data:Rest<Any>):Void;
	function clear(data:Rest<Any>):Void;
	function count(?label:Any):Void;
	function countReset(?label:Any):Void;
	function assert(?value:Any, data:Rest<Any>):Void;
	function profile(?label:Any):Void;
	function profileEnd(?label:Any):Void;
	function time(?label:Any):Void;
	function timeEnd(?label:Any):Void;
	function timeLog(?label:Any):Void;
	function timeStamp(?label:Any):Void;

	/**
		Creates a new inspector console context with the given name.
	**/
	function context(name:Any):Void;
}
