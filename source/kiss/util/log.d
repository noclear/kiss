﻿module kiss.util.log;
import std.string;

import std.stdio;



private string convTostr(string msg , string file , size_t line)
{
	import std.conv;
	return msg ~ " - " ~ file ~ ":" ~ to!string(line);	
}


void log_kiss(string msg , string type ,  string file = __FILE__ , size_t line = __LINE__)
{
	msg =  "[" ~ type  ~ "] " ~ msg ;
	writeln(convTostr(msg , file , line));
}


version(onyxLog)
{
	import onyx.log;
	import onyx.bundle;

	__gshared Log g_log;

	bool load_log_conf(immutable string logConfPath)
	{
		if(g_log is null)
		{
			auto bundle = new immutable Bundle(logConfPath);
			createLoggers(bundle);
			g_log = getLogger("logger");
		}
		return true;
	}

	void log_debug(string msg , string file = __FILE__ , size_t line = __LINE__)
	{
		if(g_log is null)
			log_kiss(msg , "debug" , file , line);
		else
			g_log.debug_(convTostr(msg , file , line));
	}

	void log_info(string msg , string file = __FILE__ , size_t line = __LINE__)
	{
		if(g_log is null)
			log_kiss(msg , "info" , file , line);
		else
			g_log.info(convTostr(msg , file , line));
	}

	void log_warning(string msg , string file = __FILE__ , size_t line = __LINE__)
	{
		if(g_log is null)
			log_kiss(msg , "warning" , file , line);
		else
			g_log.warning(convTostr(msg , file , line));
	}

	void log_error(string msg , string file = __FILE__ , size_t line = __LINE__)
	{
		if(g_log is null)
			log_kiss(msg , "error" , file , line);
		else
			g_log.error(convTostr(msg , file , line));
	}

	void log_critical(string msg ,string file = __FILE__ , size_t line = __LINE__)
	{
		if(g_log is null)
			log_kiss(msg , "critical" , file , line);
		else
			g_log.critical(convTostr(msg , file , line));
	}

	void log_fatal(string msg ,string file = __FILE__ , size_t line = __LINE__)
	{
		if(g_log is null)
			log_kiss(msg , "fatal" , file , line);
		else
			g_log.fatal(convTostr(msg , file , line));
	}

}
else
{
	bool load_log_conf(immutable string logConfPath)
	{
		return true;
	}
	void log_debug(string msg , string file = __FILE__ , size_t line = __LINE__)
	{
		log_kiss(msg , "debug" , file , line);
	}
	void log_info(string msg , string file = __FILE__ , size_t line = __LINE__)
	{
		log_kiss(msg , "info" , file , line);
	}
	void log_warning(string msg , string file = __FILE__ , size_t line = __LINE__)
	{
		log_kiss(msg , "warning" , file , line);
	}
	void log_error(string msg , string file = __FILE__ , size_t line = __LINE__)
	{
		log_kiss(msg , "error" ,  file , line);
	}
	void log_critical(string msg ,string file = __FILE__ , size_t line = __LINE__)
	{
		log_kiss(msg , "critical" , file , line);
	}
	void log_fatal(string msg ,string file = __FILE__ , size_t line = __LINE__)
	{
		log_kiss(msg , "fatal" ,  file , line);
	}

}