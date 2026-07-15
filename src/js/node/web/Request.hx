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

package js.node.web;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.lib.ArrayBuffer;
import js.lib.ArrayBufferView;
import js.lib.Promise;
import js.lib.Uint8Array;
import js.node.url.URL;
import js.node.url.URLSearchParams;

/**
	The Fetch API `Request` interface (undici).

	@see https://nodejs.org/api/globals.html#class-request
**/
@:native("Request")
extern class Request {
	final method:String;
	final url:String;
	final headers:Headers;
	final destination:String;
	final referrer:String;
	final referrerPolicy:String;
	final mode:String;
	final credentials:String;
	final cache:String;
	final redirect:String;
	final integrity:String;
	final keepalive:Bool;
	final signal:AbortSignal;
	final duplex:String;

	/**
		Always `false` in Node.js (undici); provided for browser API completeness.
	**/
	final isHistoryNavigation:Bool;

	/**
		Always `false` in Node.js (undici); provided for browser API completeness.
	**/
	final isReloadNavigation:Bool;

	/**
		A `ReadableStream` of the body contents, or `null`.
	**/
	final body:Null<ReadableStream>;

	final bodyUsed:Bool;

	@:overload(function(input:Request, ?init:RequestInit):Void {})
	@:overload(function(input:URL, ?init:RequestInit):Void {})
	function new(input:String, ?init:RequestInit):Void;

	function clone():Request;
	function arrayBuffer():Promise<ArrayBuffer>;
	function blob():Promise<Blob>;
	function bytes():Promise<Uint8Array>;
	function formData():Promise<FormData>;
	function json():Promise<Any>;
	function text():Promise<String>;
}

/**
	Init options for `Request` / `fetch`.
**/
typedef RequestInit = {
	@:optional var method:String;
	@:optional var headers:EitherType<Headers, EitherType<Array<Array<String>>, DynamicAccess<String>>>;
	@:optional var body:BodyInit;
	@:optional var referrer:String;
	@:optional var referrerPolicy:String;
	@:optional var mode:String;
	@:optional var credentials:String;
	@:optional var cache:String;
	@:optional var redirect:String;
	@:optional var integrity:String;
	@:optional var keepalive:Bool;
	@:optional var signal:AbortSignal;
	@:optional var duplex:String;

	/**
		Undici-specific custom dispatcher for the request.
		Left as `Any` until an undici `Dispatcher` extern exists.
	**/
	@:optional var dispatcher:Any;
}

/**
	Values accepted as request/response bodies.
**/
typedef BodyInit = EitherType<Blob,
	EitherType<FormData,
		EitherType<URLSearchParams,
			EitherType<ArrayBuffer, EitherType<ArrayBufferView, EitherType<String, EitherType<ReadableStream, Any>>>>>>>;
