﻿module kiss.event.GroupPoll;

import kiss.event.Epoll;
import kiss.event.Poll;
import kiss.event.select;

import std.random;
import std.parallelism;
import core.thread;
import std.conv;

import kiss.util.log;

version (linux)
{
	alias DefaultPoll = Epoll;
}
else
{
	alias DefaultPoll = select;
}

class GroupPoll(T = DefaultPoll) : Group
{
	this(int timeout = 10,  int work_numbers = 4 )
	{
		while (work_numbers--)
			_works_polls ~= new T(timeout);

	}

	~this()
	{
		_works_polls.destroy();
	}

	Poll[] polls()
	{
		return _works_polls;
	}

	void start()
	{

		foreach (ref t; _works_polls)
			t.start();

	}

	void stop()
	{
		foreach (ref t; _works_polls)
			t.stop();
	}

	void wait()
	{
		foreach (ref t; _works_polls)
			t.wait();
	}


	private Poll[] _works_polls;

}
