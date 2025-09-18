Return-Path: <linux-kernel+bounces-822281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A15B8371B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64733A3C73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67F42F5320;
	Thu, 18 Sep 2025 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kPAlMzXn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652C2ED853
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182819; cv=none; b=KtlqvAPnVar/lKXh/zJ8zUDZ4cau511j/SuY1aX6TLJKNhb2aqjL6DUfSuOAZsiO73B3qNLr5j/krdh0QnjB0ziAlkkLb72zyHz6molZE3tBHm7dLZfM0JGix11Zae/B5oNmxkbtrup3wk80YXKgSyeNte/tPaHM2+yiSsNF600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182819; c=relaxed/simple;
	bh=nkRh0zoa1wb7KWILX2rkE+WfDaLMenhee0GDCugCODg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EEWYfsO3QiQZONtSKM0GaSucvx5pdX1nQvZGp7sqmcMIJzfR/CrJOsiuOWznLmZJN3otXapZExbuRaTkatrs37JsH/552WLLxkAiV38f5eF7DVKQ0Rwcn4HXxvf8cNCAavvC0Fk30p7mRpwE/IoAmwkmozTaTZgN9dUq8xt3ggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kPAlMzXn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=i/e6ipjEvjUpvQ1N8nr9Vxs1Rh/qX1Ik2QYKpUjY4A4=; b=kPAlMzXnrG8RA2n9kRWtJrjnqS
	5u14EwjbnK2GbEgeN4RXuY9O6R4X3Jip0YaqpqNDfP5ihnFgrNG0zb/tylKCp4faX1CfVZKJPds4+
	mz6ZR6b1/zzwcMk16xuPvcZMKhlpGHLcQS+O2WFOXEYIp1YrGrsiCAG/ntVeGZuXrL+24Q3EXdM2b
	zLIDwS7yNMlyUvC+mUbwbfz9MUhu3UiKPy2hsB1GpvZjudLc/tDtUBL7TABNiohXLobbng68Gd7de
	/O/omHegG77FnZrcfTBkUQDKs1PuDXY0BiOr5J+L9nAXlyWPOpC8Rv/WpBGzqcd8ckBJIWDCHQkD4
	pKqMkHJQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9fD-0000000Fbs2-0Ws3;
	Thu, 18 Sep 2025 08:06:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2BE68302FFC; Thu, 18 Sep 2025 10:06:46 +0200 (CEST)
Message-ID: <20250918080206.065140324@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 18 Sep 2025 09:52:25 +0200
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
Subject: [PATCH 6/8] hrtimer: Re-arrange hrtimer_interrupt()
References: <20250918075219.091828500@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Rework hrtimer_interrupt() such that reprogramming is split out into
an independent function at the end of the interrupt.

This prepares for reprogramming getting delayed beyond the end of
hrtimer_interrupt().

Notably, this changes the hang handling to always wait 100ms instead
of trying to keep it proportional to the actual delay. This simplifies
the state, also this really shouldn't be happening.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/hrtimer.c |   87 ++++++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 48 deletions(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1889,6 +1889,29 @@ static __latent_entropy void hrtimer_run
 #ifdef CONFIG_HIGH_RES_TIMERS
 
 /*
+ * Very similar to hrtimer_force_reprogram(), except it deals with
+ * in_hrirq and hang_detected.
+ */
+static void __hrtimer_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t now)
+{
+	ktime_t expires_next = hrtimer_update_next_event(cpu_base);
+
+	cpu_base->expires_next = expires_next;
+	cpu_base->in_hrtirq = 0;
+
+	if (unlikely(cpu_base->hang_detected)) {
+		/*
+		 * Give the system a chance to do something else than looping
+		 * on hrtimer interrupts.
+		 */
+		expires_next = ktime_add_ns(now, 100 * NSEC_PER_MSEC);
+		cpu_base->hang_detected = 0;
+	}
+
+	tick_program_event(expires_next, 1);
+}
+
+/*
  * High resolution timer interrupt
  * Called with interrupts disabled
  */
@@ -1924,63 +1947,31 @@ void hrtimer_interrupt(struct clock_even
 
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
 
-	/* Reevaluate the clock bases for the [soft] next expiry */
-	expires_next = hrtimer_update_next_event(cpu_base);
-	/*
-	 * Store the new expiry value so the migration code can verify
-	 * against it.
-	 */
-	cpu_base->expires_next = expires_next;
-	cpu_base->in_hrtirq = 0;
-	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
-
-	/* Reprogramming necessary ? */
-	if (!tick_program_event(expires_next, 0)) {
-		cpu_base->hang_detected = 0;
-		return;
-	}
-
 	/*
 	 * The next timer was already expired due to:
 	 * - tracing
 	 * - long lasting callbacks
 	 * - being scheduled away when running in a VM
 	 *
-	 * We need to prevent that we loop forever in the hrtimer
-	 * interrupt routine. We give it 3 attempts to avoid
-	 * overreacting on some spurious event.
-	 *
-	 * Acquire base lock for updating the offsets and retrieving
-	 * the current time.
+	 * We need to prevent that we loop forever in the hrtiner interrupt
+	 * routine. We give it 3 attempts to avoid overreacting on some
+	 * spurious event.
 	 */
-	raw_spin_lock_irqsave(&cpu_base->lock, flags);
+	expires_next = hrtimer_update_next_event(cpu_base);
 	now = hrtimer_update_base(cpu_base);
-	cpu_base->nr_retries++;
-	if (++retries < 3)
-		goto retry;
-	/*
-	 * Give the system a chance to do something else than looping
-	 * here. We stored the entry time, so we know exactly how long
-	 * we spent here. We schedule the next event this amount of
-	 * time away.
-	 */
-	cpu_base->nr_hangs++;
-	cpu_base->hang_detected = 1;
-	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+	if (expires_next < now) {
+		if (++retries < 3)
+			goto retry;
+
+		delta = ktime_sub(now, entry_time);
+		cpu_base->max_hang_time = max_t(unsigned int,
+						cpu_base->max_hang_time, delta);
+		cpu_base->nr_hangs++;
+		cpu_base->hang_detected = 1;
+	}
 
-	delta = ktime_sub(now, entry_time);
-	if ((unsigned int)delta > cpu_base->max_hang_time)
-		cpu_base->max_hang_time = (unsigned int) delta;
-	/*
-	 * Limit it to a sensible value as we enforce a longer
-	 * delay. Give the CPU at least 100ms to catch up.
-	 */
-	if (delta > 100 * NSEC_PER_MSEC)
-		expires_next = ktime_add_ns(now, 100 * NSEC_PER_MSEC);
-	else
-		expires_next = ktime_add(now, delta);
-	tick_program_event(expires_next, 1);
-	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
+	__hrtimer_rearm(cpu_base, now);
+	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 }
 #endif /* !CONFIG_HIGH_RES_TIMERS */
 



