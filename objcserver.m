#import "TPTCPSocket.h"

@interface ServerDelegate : NSObject
@end

@implementation ServerDelegate
- (void)tcpSocket:(TPTCPSocket*)tcpSocket gotData:(NSData*)data {puts("1");}
- (void)tcpSocketDidSendData:(TPTCPSocket*)tcpSocket {puts("2");}
- (void)tcpSocket:(TPTCPSocket*)listenSocket connectionAccepted:(TPTCPSocket*)childSocket {puts("3");}
- (void)tcpSocketConnectionSucceeded:(TPTCPSocket*)tcpSocket {puts("4");}
- (void)tcpSocketConnectionFailed:(TPTCPSocket*)tcpSocket {puts("5");}
- (void)tcpSocketConnectionClosed:(TPTCPSocket*)tcpSocket {puts("6");}
@end

int main(int argc, char *argv[])
{
    int port = 8080;
    if (argc > 1) {
        port = atoi(argv[1]);
    }

    @autoreleasepool {
        ServerDelegate *delegate = [[ServerDelegate alloc] init];
        TPTCPSocket *sock = [[TPTCPSocket alloc] initWithDelegate:delegate];
        BOOL res = [sock listenOnPort:port];

        if (!res) {
            printf("Error: failed to listen\n");
            exit(0);
        }

        [[NSRunLoop currentRunLoop] run];
    }
}
