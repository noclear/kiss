



module kiss.nio.ServerSocketChannel;
import kiss.nio.ChannelBase;
import kiss.nio.SocketChannel;
import std.conv;
import std.socket;
import kiss.nio.SelectionKey;




class ServerSocketChannel : ChannelBase {

protected:
    this(){
        super();
    }

public:
    static open(string ip = null, ushort port = 0, int backlog = 50) {

        ServerSocketChannel ret = new ServerSocketChannel();
        if (!(ip is null))
        {
            ret.bind(ip,port,backlog);
        }
        return ret;
    }
    ServerSocketChannel socket() {
        return this;
    }

    void bind(string ip, ushort port, int backlog = 50)
    {
        synchronized(regLock)
        {
            string strPort = to!string(port);
            AddressInfo[] arr = getAddressInfo(ip , strPort , AddressInfoFlags.PASSIVE);
            _socket = new Socket(arr[0].family , arr[0].type , arr[0].protocol);
            _socket.bind(arr[0].address);
            _socket.blocking(blocking);
            _socket.listen(backlog);
            setOpen(true);
        }
        return;
    }

    SocketChannel accept() {
        SocketChannel sc = SocketChannel.open();
        sc.setOpen(true);
        sc._socket = _socket.accept();
        return sc;
    }   
    


    override int validOps(){
        return SelectionKey.OP_ACCEPT;
    }

    


    

}
