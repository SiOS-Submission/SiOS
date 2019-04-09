#include <dlfcn.h>
#include <substrate.h>
#include <sys/stat.h>
#include <string>

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <stdio.h>
#include <uuid/uuid.h>
#include <unistd.h>

// todo: ensure this api reside in socket library.
static  NSString *obj = @"foo";

/*
//Implement printf to print logs...
int printf(const char * __restrict format, ...)
{ 
    //NSLog(@"in detoured printf");
    va_list args;
    va_start(args,format);    
    NSLog([NSString stringWithUTF8String:format], args) ;    
    va_end(args);
    return 1;
}
*/

/*
int vprintf(const char * __restrict fmt, va_list vlst)
{
    va_start(vlst, fmt);
    NSLog([NSString stringWithUTF8String:fmt], vlst);
    va_end(vlst);
    return 1;
}
*/

int	bind(int, const struct sockaddr *, socklen_t);
int 	(*orig_bind)(int fd, const struct sockaddr *addr, socklen_t len);
int hook_bind(int fd, const struct sockaddr *addr, socklen_t len)
{

	@synchronized(obj) {	
		const struct sockaddr_in *p = (const struct sockaddr_in *) addr;

		NSLog(@"vvvvv DetourInfo:: block start vvvvv");
		//printf("vvvvv print DetourInfo:: block start vvvvv");

        	NSLog(@"DetourInfo:: bundleIdentifier: %@", [[NSBundle mainBundle] bundleIdentifier]);
        	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        	NSLog(@"DetourInfo:: CFBundleDisplayName: %@", [infoDictionary objectForKey:@"CFBundleDisplayName"]);
        	NSLog(@"DetourInfo:: CFBundleShortVersionString: %@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]);
        	NSLog(@"DetourInfo:: FBundleVersion: %@", [infoDictionary objectForKey:@"CFBundleVersion"]);

		if (p->sin_family == AF_INET)
		{
        		NSLog(@"DetourInfo:: ipv4 info");			
			NSLog(@"DetourInfo:: sin_family: AF_INET		2		/* internetwork: UDP, TCP, etc. */");
		
			if(ntohs(p->sin_port) == 0)
			{
				NSLog(@"DetourInfo:: port: 0, dynamic port. \n");
			}
			else
			{
				NSLog(@"DetourInfo:: port: %d \n", ntohs(p->sin_port));
			}

			char *s_ip = inet_ntoa(p->sin_addr);
 			unsigned int i_ip = inet_addr(s_ip);
        		unsigned char first = (unsigned char) i_ip;

        		if (p->sin_addr.s_addr == INADDR_ANY)
        		{
                		NSLog(@"DetourInfo:: s_addr: INADDR_ANY");
        		}
        		else if (p->sin_addr.s_addr == inet_addr("127.0.0.1"))
        		{
                		NSLog(@"DetourInfo:: relax, safe s_addr config, 127.0.0.1");
        		}
        		else if( (first & 0x80) == 0 or (first & 0xc0) == 0x80 or (first & 0xe0) == 0xc0)
			{
                		NSLog(@"DetourInfo:: A, B or C family addr. %s", s_ip);
        		}
        		else
        		{
                		NSLog(@"DetourInfo:: D or E family addr. %s", s_ip);
        		}
		}
		else if (p->sin_family == AF_INET6)
		{
        		NSLog(@"DetourInfo:: ipv6 info");
			NSLog(@"DetourInfo:: sin_family: AF_INET6	30		/* IPv6 */");
			const struct sockaddr_in6 *p6 = (const struct sockaddr_in6 *)addr;
	        
			if (ntohs(p6->sin6_port) == 0)
			{
				NSLog(@"DetourInfo:: port: 0, dynamic port. \n");
			}
			else
			{
				NSLog(@"DetourInfo:: port: %d \n", ntohs(p6->sin6_port));
			}

			if (IN6_IS_ADDR_UNSPECIFIED(&(p6->sin6_addr)))
			{
                        	NSLog(@"DetourInfo:: sin6_addr: in6addr_any");
			}
                	else if (IN6_IS_ADDR_LOOPBACK(&(p6->sin6_addr)))
                	{
                        	NSLog(@"DetourInfo:: relax, safe sin6_addr config: loopback");
                	}
			else
			{		
				char s_ip6[INET6_ADDRSTRLEN];
				inet_ntop(AF_INET6, &(p6->sin6_addr), s_ip6, sizeof(s_ip6)); // IPv6
                        	NSLog(@"DetourInfo:: check MACRO defined in netinet/in.h to verfy this addr. %s", s_ip6);                	
				NSLog(@"DetourInfo:: sin6_addr:  %s", s_ip6);
			}
		}
		else if (p->sin_family == AF_LOCAL)
        	{
                	NSLog(@"DetourInfo:: relax, sin_family: AF_LOCAL");
        	}
		else
		{
			NSLog(@"DetourInfo:: add to sin_family: %d", p->sin_family);
		}
		
		// log will be trunk by ???, I log the call stack to file. however, it's helpless.
		NSString *tmpPath = NSTemporaryDirectory();		
		NSString *tmpFile = [tmpPath stringByAppendingPathComponent: [NSString stringWithFormat:@"%@%d.dat", [infoDictionary objectForKey:@"CFBundleDisplayName"], rand()]];
		NSFileManager *fileManager = [NSFileManager defaultManager];
		if (![fileManager fileExistsAtPath: tmpFile])
		{
			NSArray *stackArray = [NSThread callStackSymbols];
			[stackArray writeToFile: tmpFile atomically: YES];
		}
		/*
		else
		{
			NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath: tmpFile];
			[fileHandle seekToEndOfFile];
			[fileHandle writeData: [NSThread callStackSymbols]];
			[fileHandle closeFile];
		}
		*/
		NSLog(@"DetourInfo:: call stack logged to file: %@", tmpFile);
		NSLog(@"DetourInfo:: call stack: %@", [NSThread callStackSymbols]);
        	NSLog(@"^^^^^ DetourInfo:: block end ^^^^^");
	}
	return orig_bind(fd, addr, len);
}

%ctor
{
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];	
	NSLog(@"DetourInfo:: bind detours start for %@, %@", [[NSBundle mainBundle] bundleIdentifier], [infoDictionary objectForKey:@"CFBundleDisplayName"]);
	MSHookFunction(bind, &hook_bind, &orig_bind);
//	MSHookFunction(print, &hook_print, &orig_print);
}

