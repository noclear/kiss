




module kiss.nio.CompletionHandle;
import kiss.nio.AsynchronousSocketChannel;
import kiss.nio.ByteBuffer;



interface AcceptCompletionHandle 
{
    void completed(AsynchronousSocketChannel result , void* attachment);
    void failed(void* attachment);
}

interface ConnectCompletionHandle 
{
    void completed( void* attachment);
    void failed(void* attachment);
}

interface ReadCompletionHandle 
{
    void completed(size_t count , ByteBuffer buffer,void* attachment);
    void failed(void* attachment);
}

interface WriteCompletionHandle 
{
    void completed(size_t count , ByteBuffer buffer, void* attachment);
    void failed(void* attachment);
}