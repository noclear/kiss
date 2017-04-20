




module kiss.nio.SocketChannel;


import kiss.nio.ChannelBase;
import kiss.nio.SelectionKey;
import std.socket;
import std.conv;


class SocketChannel : ChannelBase {
    


public:
    static open(string ip = null, ushort port = 0)
    {
        SocketChannel ret = new SocketChannel();
        if (!(ip is null))
        {
            ret.connect(ip,port);
        }
        return ret;
    }
    this()
    {
        
    }

    void connect(string ip, ushort port)
    {
        string strPort = to!string(port);
        AddressInfo[] arr = getAddressInfo(ip , strPort , AddressInfoFlags.CANONNAME);
        _socket = new Socket(arr[0].family , arr[0].type , arr[0].protocol);
        _socket.blocking(blocking);
		_socket.connect(arr[0].address);
        setOpen(true);
    }


    override int validOps() {
        return (SelectionKey.OP_READ | SelectionKey.OP_WRITE | SelectionKey.OP_CONNECT);
    }









}