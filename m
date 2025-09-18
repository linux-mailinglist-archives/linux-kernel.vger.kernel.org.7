Return-Path: <linux-kernel+bounces-822287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E01EB8373F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F7754E2E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580F2F9C37;
	Thu, 18 Sep 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LlU7lQXP"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C642F83AB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182827; cv=none; b=j+/csvCJZj9TJVzcXAvDdwqWoti4KLAFSPp5aiqSP/u2k2DniR7/1kj8u1vZwS1zrgqRKC2+06sUDD4o9RaLr2wCjqfKlN7F4NzI8jCpNeGefBsjAgOwoC9EjGLD0FWX/Q1R5Mv6ZjqmFNi4T1OBD3ZV53Bf8oIfNa4gXOBBco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182827; c=relaxed/simple;
	bh=Hocxsvqta7ng97jsUGtfkfY8kMmy2AwacDSRcdwgxUk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EbOtnqnCIAfesKm0Vfe73yb8Lm1SVbPfe46u7F2Cql4AmuLkP8rILja7rDMJqnyBRrTDRDfBHTZ/MFSEs1EzVz23IpngEjcBZzoZiSYfB24/ayD/NvtCHPMVQynH+i0Jl0wWQ7IOLBGjFZU4nEE6LY+kMH4VrMR/mFHSUDWH6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LlU7lQXP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=S+8w906lmYBpDgHqxUiliogi7/tD4aoFlTOCeUtEKj0=; b=LlU7lQXPnfgCmJtdbqkljh9AlN
	NTMPOp3pSGQ4jjl1c+1+a7nlpFnKBgNt8Be/Ob8tXsPV05oqK6o8MIC6V6g3yDOslpBS1Gk4bHQdW
	c1tc2WGjwm3YGfSRLf/V8hZaEGMhC/bItC6GWBG8Ne0K+0MM0df2sYseepwiDDkfTO/kAzSJFZ4O1
	NfrmhLuf2hTuMuHaBeF9XVP7Loiy6SKHs0ZGVgBWbPGc2Z4X3NTaxEYVoxCiABuHk1M/eqfB8nhZ/
	uyFxTO57YPdg343LqCeeOfUPvzRAhNzKthNpMsHCQKV9SxL3GOP2zzB/ckkQABeCxQxASGxg7rbiQ
	2O/JJeGQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9fD-00000007Z6M-0fx8;
	Thu, 18 Sep 2025 08:06:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 27958302F79; Thu, 18 Sep 2025 10:06:46 +0200 (CEST)
Message-ID: <20250918080205.949243191@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 18 Sep 2025 09:52:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: arnd@arndb.de,
 anna-maria@linutronix.de,
 frederic@kernel.org,
 peterz@infradead.org,
 luto@kernel.org,
 mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: [PATCH 5/8] hrtimer,sched: Add fuzzy hrtimer mode for HRTICK
References: <20250918075219.091828500@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Upon schedule() HRTICK will cancel the current timer, pick the next
task and reprogram the timer. When schedule() consistently triggers
due to blocking conditions instead of the timer, this leads to endless
reprogramming without ever firing.

Mitigate this with a new hrtimer mode: fuzzy (not really happy with
that name); this mode does two things:

 - skip reprogramming the hardware on timer remove;
 - skip reprogramming the hardware when the new timer
   is after cpu_base->expires_next

Both things are already possible;

 - removing a remote timer will leave the hardware programmed and
   cause a spurious interrupt.
 - this remote CPU adding a timer can skip the reprogramming
   when the timer's expiration is after the (spurious) expiration.

This new timer mode simply causes more of this 'fuzzy' behaviour; it
causes a few spurious interrupts, but similarly avoids endlessly
reprogramming the timer.

This makes the HRTICK match the NO_HRTICK hackbench runs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/hrtimer.h       |    1 +
 include/linux/hrtimer_types.h |    1 +
 kernel/sched/core.c           |    3 ++-
 kernel/time/hrtimer.c         |   16 +++++++++++++++-
 4 files changed, 19 insertions(+), 2 deletions(-)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -38,6 +38,7 @@ enum hrtimer_mode {
 	HRTIMER_MODE_PINNED	= 0x02,
 	HRTIMER_MODE_SOFT	= 0x04,
 	HRTIMER_MODE_HARD	= 0x08,
+	HRTIMER_MODE_FUZZY	= 0x10,
 
 	HRTIMER_MODE_ABS_PINNED = HRTIMER_MODE_ABS | HRTIMER_MODE_PINNED,
 	HRTIMER_MODE_REL_PINNED = HRTIMER_MODE_REL | HRTIMER_MODE_PINNED,
--- a/include/linux/hrtimer_types.h
+++ b/include/linux/hrtimer_types.h
@@ -45,6 +45,7 @@ struct hrtimer {
 	u8				is_rel;
 	u8				is_soft;
 	u8				is_hard;
+	u8				is_fuzzy;
 };
 
 #endif /* _LINUX_HRTIMER_TYPES_H */
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -928,7 +928,8 @@ void hrtick_start(struct rq *rq, u64 del
 static void hrtick_rq_init(struct rq *rq)
 {
 	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
-	hrtimer_setup(&rq->hrtick_timer, hrtick, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+	hrtimer_setup(&rq->hrtick_timer, hrtick, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_HARD | HRTIMER_MODE_FUZZY);
 }
 #else /* !CONFIG_SCHED_HRTICK: */
 static inline void hrtick_clear(struct rq *rq)
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1122,7 +1122,7 @@ static void __remove_hrtimer(struct hrti
 	 * an superfluous call to hrtimer_force_reprogram() on the
 	 * remote cpu later on if the same timer gets enqueued again.
 	 */
-	if (reprogram && timer == cpu_base->next_timer)
+	if (!timer->is_fuzzy && reprogram && timer == cpu_base->next_timer)
 		hrtimer_force_reprogram(cpu_base, 1);
 }
 
@@ -1269,6 +1269,19 @@ static int __hrtimer_start_range_ns(stru
 	if (new_base->cpu_base->in_hrtirq)
 		return 0;
 
+	if (timer->is_fuzzy) {
+		/*
+		 * XXX fuzzy implies pinned!  not sure how to deal with
+		 * retrigger_next_event() for the !local case.
+		 */
+		WARN_ON_ONCE(!(mode & HRTIMER_MODE_PINNED));
+		/*
+		 * Notably, by going into hrtimer_reprogram(), it will
+		 * not reprogram if cpu_base->expires_next is earlier.
+		 */
+		return first;
+	}
+
 	if (!force_local) {
 		/*
 		 * If the current CPU base is online, then the timer is
@@ -1645,6 +1658,7 @@ static void __hrtimer_setup(struct hrtim
 	base += hrtimer_clockid_to_base(clock_id);
 	timer->is_soft = softtimer;
 	timer->is_hard = !!(mode & HRTIMER_MODE_HARD);
+	timer->is_fuzzy = !!(mode & HRTIMER_MODE_FUZZY);
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
 



