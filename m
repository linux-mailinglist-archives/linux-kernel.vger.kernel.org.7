Return-Path: <linux-kernel+bounces-822279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED042B83719
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F9D5424A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E206A2F0681;
	Thu, 18 Sep 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t80yLKq1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A62EF662
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182818; cv=none; b=QMaSFEoJH6JikVpEFjuATfRH1S1DcnOsgYa+rteMtNvycyKAUy9k57SuooIUP8LAuWS17xTZkkC0Yccdxx14awt77iEwkDE/ubVHnTx2aBnPcIfpP/dVc9lvNh/LMoEROHm5Io1hcwQUUy/JSgRr7bIemRtNNoHBZNHerGywbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182818; c=relaxed/simple;
	bh=BiS576CCzFASsMDNnssFJqocZ8w2bVORDrMvHX51BNg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uxVI1AgPIhuO/AgWOZi0PH6tQ4ONPrk9kPPSIRBEZ7nkr0ExkDvEaTGBASxDvdmiXTZo8ghPqVXrSsLWZSsYf/PkowRlKRSMkUEeWJjSdOgbXQOYxo8ieBEipJc0H5pJLsW6TmjV4nofNk2YRMmJeNA4abiz4l5+drgUEf3OH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t80yLKq1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=0IHJD1ve6otuEUBwQ7egAocxkTJS+OpX92f7OrXR+qQ=; b=t80yLKq17IDwK8WLOwUgzN7fea
	K0FPk6zHaVJUoxaLzR59s21cxHXPfwohwKISR1x7pP87pAecvfdoKOC8y+0+86XYD498CHux1SJBD
	SAvkG+WsXAtogOI6X2wmbVFbUL2sDrAvUuq5+QSjHsrnVCqGdq44Wq5GY5xeiHPlmhCCXQVmSQ1Jn
	2a/8jTn/N9r6U+Ei8coPaSjFyEwKXkz9dedeYaiE96jpXXFNgPuDV7/J8qY4ehmcUxk4gREWCqMMB
	GZDeYgNdSrJo7OlDCdOD/l+qTiS+kFAasZoA8/6mDfUD6tJscPWgKU5JTsXtMX8aBDxu3Itu+Ugfc
	bXJNw7gg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9fD-0000000Fbs3-0i2L;
	Thu, 18 Sep 2025 08:06:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 302DA303002; Thu, 18 Sep 2025 10:06:46 +0200 (CEST)
Message-ID: <20250918080206.180399724@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 18 Sep 2025 09:52:26 +0200
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
Subject: [RFC][PATCH 7/8] entry,hrtimer: Push reprogramming timers into the interrupt return path
References: <20250918075219.091828500@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Currently hrtimer_interrupt() runs expired timers, which can re-arm
themselves, after which it computes the next expiration time and
re-programs the hardware.

However, things like HRTICK, a highres timer driving preemption,
cannot re-arm itself at the point of running, since the next task has
not been determined yet. The schedule() in the interrupt return path
will switch to the next task, which then causes a new hrtimer to be
programmed.

This then results in reprogramming the hardware at least twice, once
after running the timers, and once upon selecting the new task.

Notably, *both* events happen in the interrupt.

By pushing the hrtimer reprogram all the way into the interrupt return
path, it runs after schedule() and this double reprogram can be
avoided.

XXX: 0-day is unhappy with this patch -- it is reporting lockups that
very much look like a timer goes missing. Am unable to reproduce.
Notable: the lockup goes away when the workloads are ran without perf
monitors.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/thread_info_tif.h |    5 ++++-
 include/linux/hrtimer.h               |   17 +++++++++++++++++
 kernel/entry/common.c                 |    7 +++++++
 kernel/sched/core.c                   |    6 ++++++
 kernel/time/hrtimer.c                 |   28 ++++++++++++++++++++++++----
 5 files changed, 58 insertions(+), 5 deletions(-)

--- a/include/asm-generic/thread_info_tif.h
+++ b/include/asm-generic/thread_info_tif.h
@@ -41,8 +41,11 @@
 #define _TIF_PATCH_PENDING	BIT(TIF_PATCH_PENDING)
 
 #ifdef HAVE_TIF_RESTORE_SIGMASK
-# define TIF_RESTORE_SIGMASK	10	// Restore signal mask in do_signal() */
+# define TIF_RESTORE_SIGMASK	10	// Restore signal mask in do_signal()
 # define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
 #endif
 
+#define TIF_HRTIMER_REARM              11       // re-arm the timer
+#define _TIF_HRTIMER_REARM             BIT(TIF_HRTIMER_REARM)
+
 #endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -175,10 +175,27 @@ extern void hrtimer_interrupt(struct clo
 
 extern unsigned int hrtimer_resolution;
 
+#ifdef TIF_HRTIMER_REARM
+extern void _hrtimer_rearm(void);
+/*
+ * This is to be called on all irqentry_exit() paths; as well as in the context
+ * switch path before switch_to().
+ */
+static inline void hrtimer_rearm(void)
+{
+	if (test_thread_flag(TIF_HRTIMER_REARM))
+		_hrtimer_rearm();
+}
+#else
+static inline void hrtimer_rearm(void) { }
+#endif /* TIF_HRTIMER_REARM */
+
 #else
 
 #define hrtimer_resolution	(unsigned int)LOW_RES_NSEC
 
+static inline void hrtimer_rearm(void) { }
+
 #endif
 
 static inline ktime_t
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -7,6 +7,7 @@
 #include <linux/kmsan.h>
 #include <linux/livepatch.h>
 #include <linux/tick.h>
+#include <linux/hrtimer.h>
 
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
@@ -71,6 +72,7 @@ noinstr void irqentry_exit_to_user_mode(
 {
 	instrumentation_begin();
 	exit_to_user_mode_prepare(regs);
+	hrtimer_rearm();
 	instrumentation_end();
 	exit_to_user_mode();
 }
@@ -183,6 +185,7 @@ noinstr void irqentry_exit(struct pt_reg
 		 */
 		if (state.exit_rcu) {
 			instrumentation_begin();
+			hrtimer_rearm();
 			/* Tell the tracer that IRET will enable interrupts */
 			trace_hardirqs_on_prepare();
 			lockdep_hardirqs_on_prepare();
@@ -196,10 +199,14 @@ noinstr void irqentry_exit(struct pt_reg
 		if (IS_ENABLED(CONFIG_PREEMPTION))
 			irqentry_exit_cond_resched();
 
+		hrtimer_rearm();
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
 	} else {
+		instrumentation_begin();
+		hrtimer_rearm();
+		instrumentation_end();
 		/*
 		 * IRQ flags state is correct already. Just tell RCU if it
 		 * was not watching on entry.
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5161,6 +5161,12 @@ prepare_task_switch(struct rq *rq, struc
 	fire_sched_out_preempt_notifiers(prev, next);
 	kmap_local_sched_out();
 	prepare_task(next);
+	/*
+	 * Notably, this must be called after pick_next_task() but before
+	 * switch_to(), since the new task need not be on the return from
+	 * interrupt path.
+	 */
+	hrtimer_rearm();
 	prepare_arch_switch(next);
 }
 
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1892,10 +1892,9 @@ static __latent_entropy void hrtimer_run
  * Very similar to hrtimer_force_reprogram(), except it deals with
  * in_hrirq and hang_detected.
  */
-static void __hrtimer_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t now)
+static void __hrtimer_rearm(struct hrtimer_cpu_base *cpu_base,
+			    ktime_t now, ktime_t expires_next)
 {
-	ktime_t expires_next = hrtimer_update_next_event(cpu_base);
-
 	cpu_base->expires_next = expires_next;
 	cpu_base->in_hrtirq = 0;
 
@@ -1970,9 +1969,30 @@ void hrtimer_interrupt(struct clock_even
 		cpu_base->hang_detected = 1;
 	}
 
-	__hrtimer_rearm(cpu_base, now);
+#ifdef TIF_HRTIMER_REARM
+	set_thread_flag(TIF_HRTIMER_REARM);
+#else
+	__hrtimer_rearm(cpu_base, now, expires_next);
+#endif
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 }
+
+#ifdef TIF_HRTIMER_REARM
+void _hrtimer_rearm(void)
+{
+	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
+	ktime_t now, expires_next;
+
+	lockdep_assert_irqs_disabled();
+
+	scoped_guard (raw_spinlock, &cpu_base->lock) {
+		now = hrtimer_update_base(cpu_base);
+		expires_next = hrtimer_update_next_event(cpu_base);
+		__hrtimer_rearm(cpu_base, now, expires_next);
+		clear_thread_flag(TIF_HRTIMER_REARM);
+	}
+}
+#endif /* TIF_HRTIMER_REARM */
 #endif /* !CONFIG_HIGH_RES_TIMERS */
 
 /*



