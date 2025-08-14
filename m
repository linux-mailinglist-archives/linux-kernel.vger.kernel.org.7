Return-Path: <linux-kernel+bounces-768484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4495B26184
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1FE62797F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301812EF67E;
	Thu, 14 Aug 2025 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GMLw65nl"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6BD2ED157
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164924; cv=none; b=Cd/WrZYJhoMl1WA9qT1UYAyhtpYNGORBAVuxmTkg5pXDZ8Rdygpavvrb+shNkq11kAho1aB9L9d6QgfLBagH/OZ3OJ8UewLqzPuT/mIeXkyAwKwJCSbbntDIvbLo9OTIekS1JPaZquAdO63GjPQBB7XS540tAl6ISnPGLCi3vSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164924; c=relaxed/simple;
	bh=LmS9j4UHeDnPOTHR71kZfF21w5WBoNoSAp6DHhx1ilo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHqJhqtfpwAhVC4UFYAS+TV7VFd1JHZiactqB7x55fUyZYo1mmqw7plwr2DpQMm73pwWi/QMapp35BTK+ik0Ueq0AsRZ5SZqf+MQNPPZfBybqunDOvEVGhVGLYci52cDrEgvHv7UaQ5r//CwuHBLVKIS4CwiblJBJHk+S/ntuB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GMLw65nl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4Xzogxu5AVvX1j3Vk9GON4oDKl14mQXPn5BsbSkYtlw=; b=GMLw65nlkw6nSaIMPoLT+Viwvd
	IhuTm3GdgIFpiJ+Nza+xiBCMsB9NJv6BEN3JGu/Je8QBpcuF0USTNSIebmW4qEiG+l2DztP2vjz8V
	nSgpOw0XF9F5xX+W0w0OEUhk7Tyv0aziGc7QQ46cT70wnKTMiNHZfhTgiWqBvNblmNeqptg4VRL5T
	eV+7/JsQPHc59tzDjJNM9r+oYVJPS+0iPTLpytfuznzuo9JZxx8YJcQhs/MjQYJui13JExS9aKmQW
	2bsqn5QXP7eh+JG2RPDtWfamn2NZe/aCSX3BccmSowdHIuFY13XJyfQv+1UNQMQbHs7h+yDZ8Lgtg
	WaHsKNSw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umUZU-0000000GKuJ-0Pk5;
	Thu, 14 Aug 2025 09:48:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 75D6B3002C5; Thu, 14 Aug 2025 11:48:31 +0200 (CEST)
Date: Thu, 14 Aug 2025 11:48:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: Query regarding work scheduling
Message-ID: <20250814094831.GT4067720@noisy.programming.kicks-ass.net>
References: <aJsoMnkoYYpNzBNu@opensource>
 <aJuNcM-BfznsVDWl@slm.duckdns.org>
 <aJ1eElydTbZfBq5X@opensource>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ1eElydTbZfBq5X@opensource>

On Thu, Aug 14, 2025 at 03:54:58AM +0000, Subbaraya Sundeep wrote:
> Hi Tejun,
> 
> On 2025-08-12 at 18:52:32, Tejun Heo (tj@kernel.org) wrote:
> > Hello,
> > 
> > On Tue, Aug 12, 2025 at 11:40:34AM +0000, Subbaraya Sundeep wrote:
> > > Hi,
> > > 
> > > One of our customers reported that when their kernel upgraded from 6.1 to 6.6 then they
> > > see more delay in their applications shutdown time.
> > > To put in simple terms, dataplane applications are run with SRIOV VFs attached to them and
> > > apps send number of mailbox messages to kernel PF driver (PF receives an mbox interrupt).
> > > During interrupt handler work is queued and messages are processed in work handler.
> > > I calculated the latencies (time between work queued and work execution start) of 6.1
> > > and 6.16 and below are the observations
> > > 
> > > 
> > > 6.1 mainline
> > > ------------
> > > Total samples: 4647
> > > Min latency: 0.001 ms
> > > Max latency: 0.195 ms
> > > Total latency: 7.797 ms
> > > 
> > > Latency Histogram (bucket size = 0.01 ms):
> > > 0.00 - 0.01 ms: 4644
> > > 0.01 - 0.02 ms: 1
> > > 0.03 - 0.04 ms: 1
> > > 0.19 - 0.20 ms: 1
> > > 
> > > ==================
> > > 
> > > 6.16 mainline
> > > -------------
> > > Total samples: 4647
> > > Min latency: 0.000 ms
> > > Max latency: 4.880 ms
> > > Total latency: 158.813 ms
> > 
> > Difficult to tell where the latencies are coming from. Maybe you can use
> > something like https://github.com/josefbacik/systing to look further into
> > it? All the scheduling events are tracked by default and you should be able
> > to add tracepoints and other events relatively easily. You can also set

> Thanks for the reply. I am using simple busybox to avoid overhead of any other apps
> or deamons running in background and taking CPU time in between.

Well, something is running. So there must be competing runnable tasks.

> I suspect this has something to do with EEVDF scheduling since this behavior is
> seen from 6.6 (please note I may be wrong completly).

EEVDF is stricter in a sense than CFS was, is looks like the workqueue
thread just ran out of cycles and is made to wait.

> Are there any methods or options with which I can bring back CFS scheduling behavior
> maybe with the knobs in /sys/kernel/debug/sched/features as a quick check? 

We have a lot of knobs; but not one that says: do-what-I-want.

If you push a ton of work into a workqueue and have competing runnable
tasks; why do you think it isn't reasonable to have the competing tasks
run some of the time?

You can maybe push the slice length up a bit -- it was fixed to the
small side of the CFS dynamic slice. But who knows what your workload is
doing.

