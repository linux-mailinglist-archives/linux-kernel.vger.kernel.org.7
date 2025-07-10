Return-Path: <linux-kernel+bounces-725190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C82AFFBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7455B17B57B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E9528B7E6;
	Thu, 10 Jul 2025 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DyegoFRJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QvbiV7x/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185C22D9E3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134944; cv=none; b=Lt1pqKPh7sx0Jj4352XgDX+CjRMcUDfTDXB1k+25mk5u+w/xURqoaj64QV/cvxuXAllfawjlMNihQX+RfGt4Ut3BoEvMbEfqeuohHH6xbPy3kf2zZrU7gwFzjMChBImSUoJpDjLIbz3IXAWnZ6QXYroc6oFWStqSwTsnwaIpAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134944; c=relaxed/simple;
	bh=48PyfFMYcQJg1yk3LnWFL8LdxXWvzlPuBY6YzfigKwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWgD8lY6CcNRT4mP84j3UoVM/txvrqiY6Kl0h3u/ZGoZnTsF9T7Ik85HhYYD//wh2ga/ubxInPGGzmRajni9yX9mkdzfGqGyhP9uuDODY1HRPNXUsS39D9nlSw9tjd4NZ3Ad/HJnaFtUqc6wT2GMs7c685dzHYy08MwOV0eHX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DyegoFRJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QvbiV7x/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 10:08:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752134940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oa6O3AF+QsNKWnrNuflUUdi+NFSqmgc7NpB2m8vOixI=;
	b=DyegoFRJoiWTFmX8LAWZUEY9IrwwNhqIey66GmblVds8+OeSAYsBHbk5xemTO7Fr06J5om
	NJ1HisppRxtywnzD/gTkf8jAZg6hBpghPUcUaFHqnZH9+ifNEbgQU9G15tu19N9hm4z6sB
	PtzjkdKLGh5FLOndK/D4qhPsnCO2haAx43WrEGM0BneQw455TSmH21BLzfO3dMGC5hZf1B
	oODna+ojDFGxZSnG7WVO71j8bXRzEwPae8YSUHSYs+YosDPCLojTZJDkGNYvuCJ6eMolgK
	RlS9F+JgqMJEBZEeuBmdQirD/yOR4QD1gpQodGDPaMEVIXwkGwhv0Rq9zVxhPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752134940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oa6O3AF+QsNKWnrNuflUUdi+NFSqmgc7NpB2m8vOixI=;
	b=QvbiV7x/4+l79934XfkoHS0cyHB4JuhUruyj/EsLPLs/B6tZQ4MaVPf9LerByswEt6M62k
	NARNQQmGM5S7NgBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/3] selftests/futex: Adapt the private hash test to RCU
 related changes
Message-ID: <20250710080859.LsLwRH_j@linutronix.de>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
 <20250707143623.70325-2-bigeasy@linutronix.de>
 <20250708074124.GE1613376@noisy.programming.kicks-ass.net>
 <20250708080140.YUpDy-bM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708080140.YUpDy-bM@linutronix.de>

On 2025-07-08 10:01:42 [+0200], To Peter Zijlstra wrote:
> > So the auto scaling thing is 'broken' in that if you do a 'final'
> > pthread_create() it will try and stage this new hash. If for whatever
> > reason the refcount isn't '0' -- and this can already happen today due
> > to a concurrent futex operation. Nothing will re-try the rehash.
> 
> Sure it was there but not in the way the test case was setup. I *think*
> it is okay because in real life the new hash will be put to use unless
> you terminate shortly after at which point you don't need it.
> 
> > This RCU business made this all but a certainty, but the race was there.
> >
> > I briefly wondered if we should have a workqueue re-try the rehash.
> 
> I don't think we need to worry about it.

Just to replace the *think* arguments with some technical foundation: I
added a few trace printks to see how it going and this came out:

|    zstd-2308004 [012] ..... 01.857262: __futex_pivot_hash: mm ffff88854c3f9b80 fph ffff88854ed3f000 (16)
first thread/ assignment
|    zstd-2308004 [012] ..... 01.858722: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff88854a795000
|    zstd-2308004 [012] ..... 01.858760: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff88854a795000
|    zstd-2308004 [012] ..... 01.858792: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff88854a795000
|    zstd-2308004 [012] ..... 01.858830: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff88854a795000
|    zstd-2308004 [012] ..... 01.858865: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff888782280000
|    zstd-2308004 [012] ..... 01.858913: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff888782280000
|    zstd-2308004 [012] ..... 01.858963: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff888782280000
|    zstd-2308004 [012] ..... 01.859019: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff888782280000
|    zstd-2308004 [012] ..... 01.859057: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff888782280000
|    zstd-2308004 [012] ..... 01.859092: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff888782280000
|    zstd-2308004 [012] ..... 01.859125: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff888782280000
|    zstd-2308004 [012] ..... 01.859160: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff888782280000
|    zstd-2308004 [012] ..... 01.859202: futex_hash_allocate: mm ffff88854c3f9b80 current ffff88854ed3f000 pending ffff8885b65c8000

Another and another thread is created. So it ends up allocating a new
futex_private_hash because current mask is less than what we want to
have. We then acquire mm__struct::futex_hash_lock, notice that
mm_struct::futex_phash_new is already set (pending in the trace) and
free the newly allocated one.
As an optimization we could check mm_struct::futex_phash_new under the
lock and skip the allocation if the already fph is okay. We will acquire
the lock for assignment anyway so we could skip the allocation in this
case. As you see the pending address changed a few times because as the
number of threads increased, the size also increased three times.

|  <idle>-0       [012] ..s1. 01.890423: futex_ref_rcu: mm ffff88854c3f9b80 [0] ffff88854ed3f000
|  <idle>-0       [012] ..s1. 01.926421: futex_ref_rcu: mm ffff88854c3f9b80 [1] ffff88854ed3f000
the state transition, two times because the setting up threads was so
quick.

|    zstd-2308007 [031] ..... 02.724004: __futex_pivot_hash: mm ffff88854c3f9b80 fph ffff8885b65c8000 (128)
almost a second later the first futex op led to the assignment of the hash.

|    zstd-2308004 [012] ..... 41.162795: futex_hash_free: mm ffff88854c3f9b80 fph ffff8885b65c8000 new 0000000000000000
almost 40 secs, the application is done.

This is an example for let me setup the threads, I need them for a while.
A different one:

|         lz4-2309026 [008] ..... 2.654404: __futex_pivot_hash: mm ffff888664977380 fph ffff8885b2000800 (16)
first assignment.

|         lz4-2309026 [008] ..... 2.654597: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff88854d0bc000
|         lz4-2309026 [008] ..... 2.654641: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff88854d0bc000
|         lz4-2309026 [008] ..... 2.654690: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff88854d0bc000
|         lz4-2309026 [008] ..... 2.654732: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff88854d0bc000
|         lz4-2309026 [008] ..... 2.654774: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff888615e3e000
|         lz4-2309026 [008] ..... 2.654812: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff888615e3e000
|         lz4-2309026 [008] ..... 2.654847: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff888615e3e000
|         lz4-2309026 [008] ..... 2.654884: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff888615e3e000
|         lz4-2309026 [008] ..... 2.654919: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff888615e3e000
|         lz4-2309026 [008] ..... 2.654962: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff888615e3e000
|         lz4-2309026 [008] ..... 2.655002: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff888615e3e000
|         lz4-2309026 [008] ..... 2.655039: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff888615e3e000
|         lz4-2309026 [008] ..... 2.655202: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff8885ac4b4000
|         lz4-2309026 [008] ..... 2.655250: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff8885ac4b4000
|         lz4-2309026 [008] ..... 2.655288: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff8885ac4b4000
|         lz4-2309026 [008] ..... 2.655329: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff8885ac4b4000
|         lz4-2309026 [008] ..... 2.655370: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff8885ac4b4000
|         lz4-2309026 [008] ..... 2.655411: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff8885ac4b4000
|         lz4-2309026 [008] ..... 2.655449: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff8885ac4b4000
|         lz4-2309026 [008] ..... 2.655488: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff8885ac4b4000
|         lz4-2309026 [008] ..... 2.655525: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff8885ac4b4000
|         lz4-2309026 [008] ..... 2.655562: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff8885ac4b4000
|         lz4-2309026 [008] ..... 2.655603: futex_hash_allocate: mm ffff888664977380 current ffff8885b2000800 pending ffff8885ac4b4000
a bunch of threads is created.

|      <idle>-0       [008] ..s1. 2.689306: futex_ref_rcu: mm ffff888664977380 [0] ffff8885b2000800
|      <idle>-0       [008] ..s1. 2.725324: futex_ref_rcu: mm ffff888664977380 [1] ffff8885b2000800
state transition over

|kworker/8:38-2307372 [008] ..... 2.727104: futex_hash_free: mm ffff888664977380 fph ffff8885b2000800 new ffff8885ac4b4000

The hash is released from the kworker due to mmput_async(). It frees the
current and the new hash which was never assigned.
I have a few examples which are similar to the lz4 where the new hash
was not assigned either because the application terminated early or it
did not invoke any futex opcodes after that.

Therefore it does not make sense to assign the new hash once it is
possible and mobilize a kworker for it. Avoiding the alloc/ free dance
would make sense.

Sebastian

