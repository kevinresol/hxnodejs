package js.node.net;

/**
    Enumeration of events for `Socket` objects.
**/
@:enum abstract SocketEvent {
    /**
        Emitted when a socket connection is successfully established. See `Socket.connect`.
    **/
    var Connect = "connect";

    /**
        Emitted when data is received.
        The argument data will be a `Buffer` or `String`.
        Encoding of data is set by `Socket.setEncoding`.

        Note that the data will be lost if there is no listener when a Socket emits a 'data' event.

        Listener arguments:
            chunk : Buffer or String - received data
    **/
    var Data = "data";

    /**
        Emitted when the other end of the socket sends a FIN packet.

        By default (allowHalfOpen == false) the socket will destroy its file descriptor once
        it has written out its pending write queue. However, by setting allowHalfOpen == true
        the socket will not automatically `end` its side allowing the user to write arbitrary amounts of data,
        with the caveat that the user is required to `end` their side now.
    **/
    var End = "end";

    /**
        Emitted if the socket times out from inactivity.
        This is only to notify that the socket has been idle
        The user must manually close the connection.
        See also: `Socket.setTimeout`
    **/
    var Timeout = "timeout";

    /**
        Emitted when the write buffer becomes empty. Can be used to throttle uploads.
        See also: the return values of `Socket.write`
    **/
    var Drain = "drain";

    /**
        Emitted when an error occurs. The 'close' event will be called directly following this event.

        Listener arguments:
            error - Error object
    **/
    var Error = "error";

    /**
        Emitted once the socket is fully closed.
        The argument `had_error` is a boolean which says if the socket was closed due to a transmission error.

        Listener arguments:
            had_error : Bool - true if the socket had a transmission error
    **/
    var Close = "close";
}

/**
    Options for creating new `Socket` object.
**/
typedef SocketOptions = {
    /**
        allows you to specify the existing file descriptor of socket.
    **/
    @:optional var fd:Null<Int>;

    /**
        If true, then the socket won't automatically send a FIN packet when the other end of the socket sends a FIN packet.
        The socket becomes non-readable, but still writable. You should call the `end` method explicitly.
        See 'end' event for more information.
    **/
    @:optional var allowHalfOpen:Bool;

    /**
        allow reads on this socket (NOTE: Works only when `fd` is passed)
    **/
    @:optional var readable:Bool;

    /**
        allow writes on this socket (NOTE: Works only when `fd` is passed)
    **/
    @:optional var writable:Bool;
}

/**
    Bound address, the address family name and port of the socket as reported by the operating system.
**/
typedef NetworkAdress = {
    /**
        Connection port.
    **/
    var port:Int;

    /**
        IP Family.
    **/
    var family:String;

    /**
        IP Address.
    **/
    var address:String;
}

@:jsRequire("net", "Socket")
extern class Socket extends js.node.stream.Duplex {
    /**
        Construct a new socket object.
    **/
    function new(?options:SocketOptions);

    /**
        Opens the connection for a given socket.
        If `port` and `host` are given, then the socket will be opened as a TCP socket,
        if `host` is omitted, localhost will be assumed.
        If a `path` is given, the socket will be opened as a unix socket to that path.

        Normally this method is not needed, as `Net.createConnection` opens the socket.
        Use this only if you are implementing a custom `Socket`.

        This function is asynchronous. When the 'connect' event is emitted the socket is established.
        If there is a problem connecting, the 'connect' event will not be emitted,
        the 'error' event will be emitted with the exception

        The `connectListener` parameter will be added as an listener for the 'connect' event.
    **/
    @:overload(function(path:String, ?connectListener:Void->Void):Socket {})
    @:overload(function(port:Int, ?connectListener:Void->Void):Socket {})
    function connect(port:Int, host:String, ?connectListener:Void->Void):Socket;

    /**
        `Socket` has the property that `socket.write` always works. This is to help users get up and running quickly.
        The computer cannot always keep up with the amount of data that is written to a socket - the network connection
        simply might be too slow. Node will internally queue up the data written to a socket and send it out over the
        wire when it is possible. (Internally it is polling on the socket's file descriptor for being writable).

        The consequence of this internal buffering is that memory may grow. This property shows the number of characters
        currently buffered to be written. (Number of characters is approximately equal to the number of bytes to be written,
        but the buffer may contain strings, and the strings are lazily encoded, so the exact number of bytes is not known.)

        Users who experience large or growing `bufferSize` should attempt to "throttle" the data flows
        in their program with `pause` and `resume`.
    **/
    var bufferSize:Int;

    /**
        Ensures that no more I/O activity happens on this socket. Only necessary in case of errors (parse error or so).
    **/
    function destroy():Void;

    /**
        Sets the socket to timeout after `timeout` milliseconds of inactivity on the socket.
        By default `Socket` do not have a timeout.

        When an idle timeout is triggered the socket will receive a 'timeout' event but the connection will not be severed.
        The user must manually `end` or `destroy` the socket.

        If `timeout` is 0, then the existing idle timeout is disabled.

        The optional `callback` parameter will be added as a one time listener for the 'timeout' event.
    **/
    function setTimeout(timeout:Int, ?callback:Void->Void):Void;

    /**
        Disables the Nagle algorithm.
        By default TCP connections use the Nagle algorithm, they buffer data before sending it off.
        Setting true for `noDelay` will immediately fire off data each time `write` is called.
        `noDelay` defaults to true.
    **/
    function setNoDelay(?noDelay:Bool):Void;

    /**
        Enable/disable keep-alive functionality, and optionally set the initial delay
        before the first keepalive probe is sent on an idle socket.

        `enable` defaults to false.

        Set `initialDelay` (in milliseconds) to set the delay between the last data packet received and
        the first keepalive probe.

        Setting 0 for `initialDelay` will leave the value unchanged from the default (or previous) setting.
        Defaults to 0.
    **/
    @:overload(function(?initialDelay:Int):Void {})
    function setKeepAlive(enable:Bool, ?initialDelay:Int):Void;

    /**
        Returns the bound address, the address family name and port of the socket as reported by the operating system.
    **/
    function address():NetworkAdress;

    /**
        Calling `unref` on a socket will allow the program to exit if this is the only active socket in the event system.
        If the socket is already `unref`d calling `unref` again will have no effect.
    **/
    function unref():Void;

    /**
        Opposite of `unref`, calling `ref` on a previously `unref`d socket will not let the program exit
        if it's the only socket left (the default behavior).
        If the socket is `ref`d calling `ref` again will have no effect.
    **/
    function ref():Void;

    /**
        The string representation of the remote IP address.
        For example, '74.125.127.100' or '2001:4860:a005::68'.
    **/
    var remoteAddress(default,null):String;

    /**
        The numeric representation of the remote port. For example, 80 or 21.
    **/
    var remotePort(default,null):Int;

    /**
        The string representation of the local IP address the remote client is connecting on.
        For example, if you are listening on '0.0.0.0' and the client connects on '192.168.1.1',
        the value would be '192.168.1.1'.
    **/
    var localAddress(default,null):String;

    /**
        The numeric representation of the local port. For example, 80 or 21.
    **/
    var localPort(default,null):Int;

    /**
        The amount of received bytes.
    **/
    var bytesRead(default,null):Int;

    /**
        The amount of bytes sent.
    **/
    var bytesWritten(default,null):Int;
}
