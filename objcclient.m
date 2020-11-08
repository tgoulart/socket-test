#import "TPTCPSocket.h"

@interface ClientDelegate : NSObject
@end

@implementation ClientDelegate
- (void)tcpSocket:(TPTCPSocket*)tcpSocket gotData:(NSData*)data {puts("1");}
- (void)tcpSocketDidSendData:(TPTCPSocket*)tcpSocket {puts("2");}
- (void)tcpSocket:(TPTCPSocket*)listenSocket connectionAccepted:(TPTCPSocket*)childSocket {puts("3");}
- (void)tcpSocketConnectionSucceeded:(TPTCPSocket*)tcpSocket {puts("4");}
- (void)tcpSocketConnectionFailed:(TPTCPSocket*)tcpSocket {puts("5");}
- (void)tcpSocketConnectionClosed:(TPTCPSocket*)tcpSocket {puts("6");}
@end

int main(int argc, char* argv[])
{
    char *address = "127.0.0.1";
    int port = 8080;
    if (argc > 1) {
        address = argv[1];
        if (argc > 2) {
            port = atoi(argv[2]);
        }
    }

    @autoreleasepool {
        ClientDelegate *delegate = [[ClientDelegate alloc] init];
        TPTCPSocket *sock = [[TPTCPSocket alloc] initWithDelegate:delegate];
        BOOL res = [sock connectToHost:[NSString stringWithUTF8String:address] onPort:port];
        if (!res) {
            printf("Error: failed to connect\n");
            exit(0);
        }

        const char* message = "sup yo!";
        res = [sock sendData:[NSData dataWithBytes:message length:strlen(message)]];
        if (!res) {
            printf("Error: failed to send message\n");
            exit(0);
        }

        [[NSRunLoop currentRunLoop] run];
    }
}
