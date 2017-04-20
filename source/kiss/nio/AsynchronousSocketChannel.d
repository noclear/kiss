


module kiss.nio.AsynchronousSocketChannel;



import kiss.nio.AsynchronousChannelSelector;
import kiss.nio.CompletionHandle;
import kiss.nio.AsynchronousChannelBase;
import kiss.nio.AsynchronousChannelThreadGroup;
import kiss.event.Event;

import std.conv;
import std.socket;

class AsynchronousSocketChannel : AsynchronousChannelBase{



public:

    this(AsynchronousChannelThreadGroup group, AsynchronousChannelSelector sel)
    {
        super(group, sel);
    }

    static open(AsynchronousChannelThreadGroup group, AsynchronousChannelSelector sel)
    {
        return new AsynchronousSocketChannel(group, sel);
    }

    
    
    
    void connect(string ip, ushort port, ConnectCompletionHandle handle, void* attachment)
    {
        string strPort = to!string(port);
        AddressInfo[] arr = getAddressInfo(ip , strPort , AddressInfoFlags.CANONNAME);
        _socket = new Socket(arr[0].family , arr[0].type , arr[0].protocol);
        _socket.blocking(false);
		_socket.connect(arr[0].address);
        setOpen(true);
        register(AIOEventType.OP_CONNECTED, cast(void*)handle, attachment, null);
    }


    override int validOps(){
        return  (AIOEventType.OP_READED | AIOEventType.OP_WRITEED | AIOEventType.OP_CONNECTED);
    }


}