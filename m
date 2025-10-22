Return-Path: <linux-kernel+bounces-865000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876A1BFC0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448796207F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B07346E40;
	Wed, 22 Oct 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wkQCc1zh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FuErGpoW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8F3469EE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137723; cv=none; b=LtI69D5N/woo72DCcoqQmKbzZhN1+R4UtAgs2i6Z0RL+e4Z1LE0RINdH7TLBXuoA1MfV43vqc2mO5yts186bAp+UNL2Mfz2xK06mZr+5TfG5zLKSaIXPnWAZp5OdzyuAnuG6NDfMfSrlZPGrmpdwjsfWRj9L/KIFlfprOtcX0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137723; c=relaxed/simple;
	bh=8Ad4VPnGevoQucG/XBFHfbcTVo5FmVZVBltsdREnJ28=;
	h=Message-ID:From:To:Cc:Subject:Date; b=VIVEmNxZQp5LUgLKZA9vg+rXQi4oLgv/QKvjPOiqe/PIvOsDWEMCcKQxTGKaS8FVKtbjGpxl76AbKdLrqT3nlsgAXbVg50tGCJ0+s9/wZcgfcuQRhmT5OJ2ROxe8qO2SVUY2hGqhXYSHFkSTW9HtzRtr3fNQ4EK8+PNgOo6ZIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wkQCc1zh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FuErGpoW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022104005.907410538@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=32ZWHZ3rfMN3d6q600y/RRBxB7Jbg/V+A7kDEtnDhfo=;
	b=wkQCc1zhOy0QXzr9Uz6IQJs11gE4LLCZxlypzsJorwGr+DHwxDSroYqKsaOztYrW0wnuPu
	Dud02Jl7+IT7rr0yZSN3aOoGFGJyklcVwagQcHpHGKXbX85TCXGOo+msbdBlGP5XZHK8jT
	HwLAntZB8IyHU6iPpMGF6iLpCzEVMgULWgyWsb2aa9RymsMz4ehReaSIQoxw7vp8+cbNZP
	sjeeN99+KzMkjFC4Ntns9mvsj2oG/iUqEkR/LeWtjVwPYEtvpyqZliX04oi3gP9tiNvkJK
	dHBT/0/7xEd0K4EuLQYpoQKga0Ld5/m63TR6BrVkupI50vKnxUoYv04BVjf1sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=32ZWHZ3rfMN3d6q600y/RRBxB7Jbg/V+A7kDEtnDhfo=;
	b=FuErGpoWm90Ym/hl/EX5TvxP1NeUBOtb7Reh8CZt6bn0cINeyh0uH3AyiilGbu8DmkSlu8
	y0/a6AJgRG/ex7DQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>
Subject: [patch V2 00/20] sched: Rewrite MM CID management
Date: Wed, 22 Oct 2025 14:55:19 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up on V1 series which can be found here:

    https://lore.kernel.org/20251015164952.694882104@linutronix.de

The V1 cover letter contains a detailed analyisis of the issues.

TLDR: The CID management is way to complex and adds significant overhead
into scheduler hotpaths.

The series rewrites MM CID management in a more simplistic way which
focusses on low overhead in the scheduler while maintaining per task CIDs
as long as the number of threads is not exceeding the number of possible
CPUs.

The series is based on the V5 series of the rseq rewrite:

    https://lore.kernel.org/20251022121836.019469732@linutronix.de/

which is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf

The series on top of the rseq/perf branch is available from git as well:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid

Changes vs. V1:

   - Use num_possible_cpus() instead of nr_cpu_ids. - PeterZ

   - Cache the number of possible CPUs as that is constant after init and
     expose the cached value via num_possible_cpus() instead of calculating
     the same constant weight over and over.

   - Rename cpumask_or_weight() and use the weight helper macro - Yury

   - Fix the bogus condition in the task to CPU fixup - PeterZ

   - Add a transitional state bit which prevents CID space exhaustion when
     switching from per CPU mode to per task mode and fixup the
     corresponding logic all over the place.

Thanks,

	tglx
---
Thomas Gleixner (20):
      sched/mmcid: Revert the complex CID management
      sched/mmcid: Use proper data structures
      sched/mmcid: Cacheline align MM CID storage
      sched: Fixup whitespace damage
      sched/mmcid: Move scheduler code out of global header
      sched/mmcid: Prevent pointless work in mm_update_cpus_allowed()
      cpumask: Introduce cpumask_or_and_calc_weight()
      sched/mmcid: Use cpumask_or_and_calc_weight()
      cpumask: Cache num_possible_cpus()
      sched/mmcid: Convert mm CID mask to a bitmap
      signal: Move MMCID exit out of sighand lock
      sched/mmcid: Move initialization out of line
      sched/mmcid: Provide precomputed maximal value
      sched/mmcid: Serialize sched_mm_cid_fork()/exit() with a mutex
      sched/mmcid: Introduce per task/CPU ownership infrastrcuture
      sched/mmcid: Provide new scheduler CID mechanism
      sched/mmcid: Provide CID ownership mode fixup functions
      irqwork: Move data struct to a types header
      sched/mmcid: Implement deferred mode change
      sched/mmcid: Switch over to the new mechanism

 include/linux/bitmap.h         |   16 
 include/linux/cpumask.h        |   26 +
 include/linux/irq_work.h       |    9 
 include/linux/irq_work_types.h |   14 
 include/linux/mm_types.h       |  125 ------
 include/linux/rseq.h           |   27 -
 include/linux/rseq_types.h     |   71 +++
 include/linux/sched.h          |   19 
 init/init_task.c               |    3 
 kernel/cpu.c                   |   15 
 kernel/exit.c                  |    1 
 kernel/fork.c                  |    7 
 kernel/sched/core.c            |  815 +++++++++++++++++++----------------------
 kernel/sched/sched.h           |  396 ++++++++-----------
 kernel/signal.c                |    2 
 lib/bitmap.c                   |    6 
 16 files changed, 727 insertions(+), 825 deletions(-)



