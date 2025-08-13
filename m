Return-Path: <linux-kernel+bounces-767144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A04FB24FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B4F3A8D30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86298286D6B;
	Wed, 13 Aug 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3/r3DbcB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wplqCtP9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663DC26E706
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102557; cv=none; b=A6HWf2RnH96PraFu1vEZgQp0gVq9znOZ1vOWb9rcTd9Rmq6W1UHirtMh7L7X0dBLnjY2Ta0hUfHbyetWfoD+reB+MY7wthpjlPWpd1VjV3nyyLCJQh5P5QDUQCZ/I8PlwXsCqgZwD6Z342WvNA/6YhZ6ZjeAVk/Jtjrg5Jw1R2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102557; c=relaxed/simple;
	bh=2JF2xCrHCYnW/egVqByJpyF/vLOl9FOdxgQOcweEKpk=;
	h=Message-ID:From:To:Cc:Subject:Date; b=imAt1V3S7JB0ZRQxHfku3oRB8fDAKh1yLbM/5iROsm15PVMZgKnXVgV51+wRGwlzUeADzF0lA65wkEAicnU8ArNSYtt1ZgppOJakoCKKounzQEO3OvG+oYUs3JWaLid/r5b6Myf0blkVV+YNme9AoQOYCvGQm6+w59GXc8DvFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3/r3DbcB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wplqCtP9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813155941.014821755@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755102554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=BclV7KrEu0uCq3bZK0gm4NqEpHuUHA3/W1/tPl6Do3M=;
	b=3/r3DbcB8yHIJ8WyXSRtDgNpIj3O7wg4FydOUvNrgfipO2SZzs59iVMPNJxF2L+TYr8Q/f
	nj5GX5RUuc3OP21mF0RiNk2lnMDYyOt2Y291B2kTu8Z4tKZhMfzcJPX1L5Z7Evp+PGgAH7
	BKLzgBd2jEiEVHSuEBqePK/pSuOKouyccVBYUKBdDcnPpjhehRfGRrOg+5ec2CcJC/Il7A
	+2VIQO5vLCCGiT/D0IBx24NregVZ436YiUN4MDkhYUy8Vt4peronJq+/2NomA40/PtxUAB
	Zxu8QGVrvIy3HtKohPkP9n0gJhvxg4lbdDmb6Q2Yk/ToAMEdk1c5lbFqRPLKrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755102554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=BclV7KrEu0uCq3bZK0gm4NqEpHuUHA3/W1/tPl6Do3M=;
	b=wplqCtP9o8oSrE9TBbjsmsIFFhQPkwKS0qQzhw6y7CMx1L/3rl2VlaWvqVUnZA9rjsAMhX
	xQ6cYqZGYu8OEfAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [patch 00/11] rseq: Optimize exit to user space
Date: Wed, 13 Aug 2025 18:29:12 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

With the more wide spread usage of rseq in glibc, rseq is not longer a
niche use case for special applications.

While working on a sane implementation of a rseq based time slice extension
mechanism, I noticed several shortcomings of the current rseq code:

  1) task::rseq_event_mask is a pointless bitfield despite the fact that
     the ABI flags it was meant to support have been deprecated and
     functionally disabled three years ago.

  2) task::rseq_event_mask is accumulating bits unless there is a critical
     section discovered in the user space rseq memory. This results in
     pointless invocations of the rseq user space exit handler even if
     there had nothing changed. As a matter of correctness these bits have
     to be clear when exiting to user space and therefore pristine when
     coming back into the kernel. Aside of correctness, this also avoids
     pointless evaluation of the user space memory, which is a performance
     benefit.

  3) The evaluation of critical sections does not differentiate between
     syscall and interrupt/exception exits. The current implementation
     silently fixes up critical sections which invoked a syscall unless
     CONFIG_DEBUG_RSEQ is enabled.

     That's just wrong. If user space does that on a production kernel it
     can keep the pieces. The kernel is not there to proliferate mindless
     user space programming and letting everyone pay the performance
     penalty.

This series addresses these issues and on top converts parts of the user
space access over to the new masked access model, which lowers the overhead
of Spectre-V1 mitigations significantly on architectures which support it
(x86 as of today). This is especially noticable in the access to the
rseq_cs field in struct rseq, which is the first quick check to figure out
whether a critical section is installed or not.

It survives the kernels rseq selftests, but I did not any performance tests
vs. rseq because I have no idea how to use the gazillion of undocumented
command line parameters of the benchmark. I leave that to people who are so
familiar with them, that they assume everyone else is too :)

The performance gain on regular workloads is clearly measurable and the
consistent event flag state allows now to build the time slice extension
mechanism on top. The first POC I implemented:

   https://lore.kernel.org/lkml/87o6smb3a0.ffs@tglx/

suffered badly from the stale eventmask bits and the cleaned up version
brought a whopping 25+% performance gain.

The series depends on the seperately posted rseq bugfix:

   https://lore.kernel.org/lkml/87o6sj6z95.ffs@tglx/

and the uaccess generic helper series:

   https://lore.kernel.org/lkml/20250813150610.521355442@linutronix.de/

and a related futex fix in

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent

For your conveniance it is also available as a conglomorate from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf

Thanks,

	tglx
---
 drivers/hv/mshv_common.c         |    2 
 include/linux/entry-common.h     |   12 +--
 include/linux/irq-entry-common.h |   31 ++++++--
 include/linux/resume_user_mode.h |   40 +++++++---
 include/linux/rseq.h             |  115 +++++++++----------------------
 include/linux/sched.h            |   10 +-
 include/uapi/linux/rseq.h        |   21 +----
 io_uring/io_uring.h              |    2 
 kernel/entry/common.c            |    9 +-
 kernel/entry/kvm.c               |    2 
 kernel/rseq.c                    |  142 +++++++++++++++++++++++++--------------
 kernel/sched/core.c              |    8 +-
 kernel/sched/membarrier.c        |    8 +-
 13 files changed, 213 insertions(+), 189 deletions(-)


