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

package js.node.http2;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.node.Http2.Http2Headers;
import js.node.events.EventEmitter.Event;
import js.node.net.Socket;
import js.node.stream.Readable;
import js.lib.Error;

/**
	Events emitted by `Http2ServerRequest` in addition to its parent class events.
**/
enum abstract Http2ServerRequestEvent<T:haxe.Constraints.Function>(Event<T>) to Event<T> {
	/**
		Emitted whenever a `Http2ServerRequest` instance is abnormally aborted in mid-communication.
	**/
	var Aborted:Http2ServerRequestEvent<() -> Void> = "aborted";

	/**
		Indicates that the underlying `Http2Stream` was closed.
	**/
	var Close:Http2ServerRequestEvent<() -> Void> = "close";
}

/**
	A `Http2ServerRequest` object is created by `http2.Server` or `http2.SecureServer`
	and passed as the first argument to the `'request'` event.

	@see https://nodejs.org/api/http2.html#class-http2http2serverrequest
**/
@:jsRequire("http2", "Http2ServerRequest")
extern class Http2ServerRequest extends Readable<Http2ServerRequest> {
	/**
		The `request.aborted` property will be `true` if the request has been aborted.
	**/
	final aborted:Bool;

	/**
		The request authority pseudo header field.
	**/
	final authority:String;

	/**
		The `request.complete` property will be `true` if the request has been completed, aborted, or destroyed.
	**/
	final complete:Bool;

	/**
		See `request.socket`.
	**/
	@:deprecated("Use request.socket instead")
	final connection:Socket;

	/**
		Calls `destroy()` on the `Http2Stream` that received the `Http2ServerRequest`.
	**/
	override function destroy(?error:Error):Http2ServerRequest;

	/**
		The request/response headers object.
	**/
	final headers:Http2Headers;

	/**
		In case of server request, the HTTP version sent by the client. Returns `'2.0'`.
	**/
	final httpVersion:String;

	/**
		HTTP Version first integer.
	**/
	final httpVersionMajor:Int;

	/**
		HTTP Version second integer.
	**/
	final httpVersionMinor:Int;

	/**
		The request method as a string.
	**/
	var method:String;

	/**
		The raw request/response headers list exactly as they were received.
	**/
	final rawHeaders:Array<String>;

	/**
		The raw request/response trailer keys and values exactly as they were received.
	**/
	final rawTrailers:Array<String>;

	/**
		The request scheme pseudo header field.
	**/
	final scheme:String;

	/**
		Sets the `Http2Stream`'s timeout value to `msecs`.
	**/
	function setTimeout(msecs:Int, ?callback:() -> Void):Http2ServerRequest;

	/**
		Returns a `Proxy` object that acts as a `net.Socket` (or `tls.TLSSocket`)
		but applies getters, setters, and methods based on HTTP/2 logic.
	**/
	final socket:Socket;

	/**
		The `Http2Stream` object backing the request.
	**/
	final stream:ServerHttp2Stream;

	/**
		The request/response trailers object. Only populated at the `'end'` event.
	**/
	final trailers:DynamicAccess<String>;

	/**
		Request URL string. Contains only the URL present in the actual HTTP request.
	**/
	var url:String;
}
