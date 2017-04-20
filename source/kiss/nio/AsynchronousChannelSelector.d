





module kiss.nio.AsynchronousChannelSelector;

import kiss.nio.EpollA;
import kiss.nio.AsynchronousChannelBase;
import kiss.nio.ByteBuffer;
import kiss.nio.CompletionHandle;

import core.sys.posix.signal;
import core.thread;
import std.experimental.logger;
import std.stdio;

class AsynchronousChannelSelector : Thread {
public:
    this (int timeout = 50)
    {
        _epoll = new EpollA();
        _isRunning = false;
        _timeout = timeout;
        super(&run);
    }


    void start()
    {
        if(_isRunning)
        {
			log(LogLevel.warning , "already started");
			return ;
		}
        _isRunning = true;
        super.start();
    }

    void stop()
    {
        _isRunning = false;
    }

    void wait()
    {
        super.join();
    }

    void run() {
        writeln("Thread run");
        while(_isRunning)
        {
            _epoll.poll(_timeout);
        }
    }


public:
    EpollA _epoll;
private:
    int _timeout;

    bool _isRunning;
    


}