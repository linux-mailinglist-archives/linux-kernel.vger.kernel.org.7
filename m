Return-Path: <linux-kernel+bounces-801256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAE5B442BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657E41CC2883
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570DA23BD1A;
	Thu,  4 Sep 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1y2h0VMe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PqfX3uuB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC527FD7C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003305; cv=none; b=SLiyI3YOgWnwKcixllYDmzdZOwDTBvCIKF1bq/azqoP2e2Q9vjXvnWfnhRRSCX8kByn40QSasNyCpn8bY/6TSGXHNjIDELCxMaW1KC/9gi493lnD0sKSqyHdsO/WiGriLejha/x5pJ5jOGButdBpFDTR868EG8YLZunAUqEgdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003305; c=relaxed/simple;
	bh=Mu03xrLlBftYdCkZ9MqB3EdfgeKGsFCY19Eti734qLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXolJGYnxA3055itAdac1zP2EklKlozo11a0p0J7VxZmu8VWDBiF3i9x6uQjagk7QiIXTpFK4oibWocjEzW9KnfnISRvNATDUQY1ZoUW/rGwk93UF9PUYjfJ/Nvm9A63Fmoecykmi0i6tHWY/joewW4p5cHnvgH05v+wjPWIVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1y2h0VMe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PqfX3uuB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Sep 2025 18:28:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757003302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3ozP4jYvi/12V9wGHLZq/yHrM+Eg/2hMfQi3PZrS7k=;
	b=1y2h0VMe8/pLkJjGlUBafjnXPZHv7dG+jdQjiN3P5XbwQ5atD+aM0L6PIYFDeHnIY9vnvR
	Ih9Xgz0podQPxkkEiqZ/IDGdtpfEbzneCVh2Lg8q4hLmIw9SQlDcAp7FohuKKUcVxdqQYX
	apxFJYCso2jVT7mDhH9cmLWP9im8ha1fJlEmg3To31OGXiKUXxKFNYlz6dqPVV5Mrcc9Yi
	xq1fqT2oc3OvkWDbx8QnzExKL6xEF2HueSXoLrNFLVT76quIfzZoEvkGvgMeLnzyJIHbaX
	FMpE9NemG+/OpynqSkNndK1Nu5BqbX5o30xQVDFnEur5eoQb/f1uZvSA95JQhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757003302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3ozP4jYvi/12V9wGHLZq/yHrM+Eg/2hMfQi3PZrS7k=;
	b=PqfX3uuBogrHb0z0zmu94RxEK1PbfHmFe4gbMY7fFOHQhoOyY8hxP4jJI+hN8gK23vgLW4
	YqVNKAD0YS3OypDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Peter Zijlstra <peterz@infradead.org>,
	syzbot <syzbot+034246a838a10d181e78@syzkaller.appspotmail.com>,
	andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] general protection fault in try_to_wake_up (3)
Message-ID: <20250904162820.NS1U-oZp@linutronix.de>
References: <68b75989.050a0220.3db4df.01dd.GAE@google.com>
 <20250902214628.GL4067720@noisy.programming.kicks-ass.net>
 <20250903130712.br0G6lOq@linutronix.de>
 <a1808501-559e-4762-b0ea-f1fffd2e7f19@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1808501-559e-4762-b0ea-f1fffd2e7f19@kernel.dk>

On 2025-09-03 12:51:09 [-0600], Jens Axboe wrote:
> > The syz-reproducer lists only:
> > | timer_create(0x0, &(0x7f0000000080)={0x0, 0x11, 0x0, @thr={0x0, 0x0}}, &(0x7f0000000000))
> > | timer_settime(0x0, 0x0, &(0x7f0000000240)={{0x0, 0x8}, {0x0, 0x9}}, 0x0)
> > | futex(&(0x7f000000cffc), 0x80000000000b, 0x0, 0x0, &(0x7f0000048000), 0x0)
> > | futex(&(0x7f000000cffc), 0xc, 0x1, 0x0, &(0x7f0000048000), 0x0)
> > 
> > and that is probably why it can't come up with C-reproducer.
> > The whole log has (filtered) the following lines:
> > 
> > | io_uring_setup(0x85a, &(0x7f0000000180)={0x0, 0x58b9, 0x1, 0x2, 0x383})
> > | syz_io_uring_setup(0x88f, &(0x7f0000000300)={0x0, 0xaedf, 0x0, 0x0, 0x25d}, &(0x7f0000000140)=<r0=>0x0, &(0x7f0000000280)=<r1=>0x0)
> > | syz_memcpy_off$IO_URING_METADATA_GENERIC(r0, 0x4, &(0x7f0000000080)=0xfffffffc, 0x0, 0x4)
> > | syz_io_uring_submit(r0, r1, &(0x7f00000001c0)=@IORING_OP_RECVMSG={0xa, 0x8, 0x1, r2, 0x0, &(0x7f0000000440)={0x0, 0x0, 0x0}, 0x0, 0x40000020, 0x1, {0x2}})
> > 
> > This should explain the how the waiter got NULL. There is no private
> > flag so that is how they interact with each other.
> > Do we want this:
> > 
> > diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
> > index c716a66f86929..0c98256ebdcb7 100644
> > --- a/kernel/futex/requeue.c
> > +++ b/kernel/futex/requeue.c
> > @@ -312,6 +312,8 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
> >  	if (!top_waiter->rt_waiter || top_waiter->pi_state)
> >  		return -EINVAL;

I've been poking at this today and I have one problem with my
explanation:
The io_uring code initializes its futex_q with futex_q_init. At this
point futex_q::rt_waiter is set to NULL and never set to something else.
We should bail out here instead of going further.
Only the PI bits set rt_waiter. Only io_uring sets task to NULL.
I'm hopeless, this makes no sense.

> > +	if (!top_waiter->task)
> > +		-EINVAL;
> >  	/* Ensure we requeue to the expected futex. */
> >  	if (!futex_match(top_waiter->requeue_pi_key, key2))
> >  		return -EINVAL;
> > 

Sebastian

