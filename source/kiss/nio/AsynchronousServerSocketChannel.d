



module kiss.nio.AsynchronousServerSocketChannel;

import kiss.nio.AsynchronousSocketChannel;
import kiss.nio.CompletionHandle;
import kiss.nio.AsynchronousChannelBase;
import kiss.nio.ByteBuffer;
import kiss.nio.AsynchronousChannelThreadGroup;
import kiss.event.Event;
import std.conv;
import std.socket;


class AsynchronousServerSocketChannel : AsynchronousChannelBase{

public:
    this(AsynchronousChannelThreadGroup group)
    {
        super(group, group.getIOSelector());
    }

    static open(AsynchronousChannelThreadGroup group)
    {
        return new AsynchronousServerSocketChannel(group);
    }

    
    void accept(void* attachment, AcceptCompletionHandle handler)
    {
        register(AIOEventType.OP_ACCEPTED, cast(void*)handler, attachment);
    }

    void bind(string ip, ushort port, int backlog = 1024)
    {
        AddressInfo[] arr = getAddressInfo(ip , to!string(port) , AddressInfoFlags.PASSIVE);
        _socket = new Socket(arr[0].family , arr[0].type , arr[0].protocol);
        
        _socket.setOption(SocketOptionLevel.SOCKET , SocketOption.REUSEADDR , 1);
        version(linux)
        {
            //SO_REUSEPORT
            _socket.setOption(SocketOptionLevel.SOCKET, cast(SocketOption) 15, 1);
        }

        _socket.bind(arr[0].address);
        _socket.blocking(false);
        _socket.listen(backlog);
        setOpen(true);
    }

    override int validOps(){
        return AIOEventType.OP_ACCEPTED;
    }




}