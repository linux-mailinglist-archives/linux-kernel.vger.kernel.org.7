Return-Path: <linux-kernel+bounces-775283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D52AB2BD82
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3F41B63C64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A8275863;
	Tue, 19 Aug 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="jt9G8Zo+"
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A395AD2FF;
	Tue, 19 Aug 2025 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595881; cv=none; b=so3Y++5/41KmM/Rt6l0c428AdS5Q7qA/WQRV9yqUA/Wocg/+vp3vIKtYzsQkAoekSkZb1DxS/iZ6dapInyDso8ppTrSy14gWgTkg/SZRiw8EjEv19bUcEQqSxxcJmY3uMw8nzOt+Of4bc87/OkJ4XoOc6iyH3oa4uMBQ8SD8GU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595881; c=relaxed/simple;
	bh=UqeIA/NkP5K5JWZ2Fz3bp+2FTTmeiRE61bZX0rcCweI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VabfmruSLKep8Qovz3tv3SNeJ/vvhDD5QV78CbZdLzPhulXlJY4g24qI0+gDLuY3OOz80hLGmu7kKYLwOAeWciA7+5w5ZSz245f6qqMGrqOyV+ktha7OXSKlYtrdduTzI9Df8KtqUWxw22VIn94V6WiBxPEZ1YPnwLOo+RtMEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=jt9G8Zo+; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.19])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 7F4EC184369EF4;
	Tue, 19 Aug 2025 17:26:56 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.71.102) by
 BJ02-ACTMBX-01.didichuxing.com (10.79.65.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 19 Aug 2025 17:27:47 +0800
Date: Tue, 19 Aug 2025 17:27:39 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.19
From: Tio Zhang <tiozhang@didiglobal.com>
To: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>,
	<fan.yu9@zte.com.cn>, <corbet@lwn.net>, <bsingharora@gmail.com>,
	<yang.yang29@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <jiang.kun2@zte.com.cn>, <xu.xin16@zte.com.cn>,
	<wang.yong12@zte.com.cn>, <tiozhang@didiglobal.com>, <zyhtheonly@gmail.com>,
	<zyhtheonly@yeah.net>
Subject: [PATCH] delayacct/sched: add SOFTIRQ delay
Message-ID: <20250819092739.GA31177@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: akpm@linux-foundation.org, wang.yaxin@zte.com.cn,
	fan.yu9@zte.com.cn, corbet@lwn.net, bsingharora@gmail.com,
	yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, jiang.kun2@zte.com.cn,
	xu.xin16@zte.com.cn, wang.yong12@zte.com.cn, zyhtheonly@gmail.com,
	zyhtheonly@yeah.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BJ03-PUBMBX-01.didichuxing.com (10.79.71.11) To
 BJ02-ACTMBX-01.didichuxing.com (10.79.65.19)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=didiglobal.com;
	s=2025; t=1755595632;
	bh=mkLiziTKzDwwd5S2w8sWaVjZqvj6fJDpgoTMcEXlfI8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type;
	b=jt9G8Zo+Nvg/H+Vxaj+nj5skj9X00wKw2oAIPBgUP00jNhTILZ877yLX0i0yIC3rN
	 TU4HI3ZwRnZRnVIlZkAjm0TGbiE2mxCMr5Kyzpwb147SfokHlKThYUBim4dU75mWTU
	 VliKlRu5gO5qe2r1df7689OF/B+pGs8x948UgiQ8=

Intro SOFTIRQ delay, so we can separate softirq as SOFTIRQ delay
and hardirq as {IRQ - SOFTIRQ} delay.

A typical scenario is when tasks delayed by network,
if they delayed by rx net packets, i.e, net_rx_action(),
SOFTIRQ delay is almost same as IRQ delay;
if they delayed by, e.g, bad driver or broken hardware,
SOFTIRQ delay is almost 0 while IRQ delay remains big.

Examples tool usage could be found in
Documentation/accounting/delay-accounting.rst

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 Documentation/accounting/delay-accounting.rst |  5 ++++-
 include/linux/delayacct.h                     | 18 ++++++++++------
 include/uapi/linux/taskstats.h                |  9 +++++++-
 kernel/delayacct.c                            |  9 +++++++-
 kernel/sched/core.c                           | 14 +++++++++----
 kernel/sched/cputime.c                        | 21 ++++++++++++++-----
 kernel/sched/sched.h                          |  6 +++++-
 tools/accounting/getdelays.c                  |  7 +++++++
 8 files changed, 70 insertions(+), 19 deletions(-)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index 8ccc5af5ea1e..b6453723fbac 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -17,6 +17,7 @@ e) thrashing
 f) direct compact
 g) write-protect copy
 h) IRQ/SOFTIRQ
+i) SOFTIRQ
 
 and makes these statistics available to userspace through
 the taskstats interface.
@@ -50,7 +51,7 @@ this structure. See
 for a description of the fields pertaining to delay accounting.
 It will generally be in the form of counters returning the cumulative
 delay seen for cpu, sync block I/O, swapin, memory reclaim, thrash page
-cache, direct compact, write-protect copy, IRQ/SOFTIRQ etc.
+cache, direct compact, write-protect copy, IRQ/SOFTIRQ, SOFTIRQ etc.
 
 Taking the difference of two successive readings of a given
 counter (say cpu_delay_total) for a task will give the delay
@@ -123,6 +124,8 @@ Get sum and peak of delays, since system boot, for all pids with tgid 242::
 	              156       11215873          0.072ms     0.207403ms     0.033913ms
 	IRQ         count    delay total  delay average      delay max      delay min
 	                0              0          0.000ms     0.000000ms     0.000000ms
+	SOFTIRQ     count    delay total  delay average      delay max      delay min
+	                0              0          0.000ms     0.000000ms     0.000000ms
 
 Get IO accounting for pid 1, it works only with -p::
 
diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 800dcc360db2..b73d777d7a96 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -62,13 +62,18 @@ struct task_delay_info {
 
 	u64 irq_delay_max;
 	u64 irq_delay_min;
-	u64 irq_delay;	/* wait for IRQ/SOFTIRQ */
+	u64 irq_delay;		/* wait for IRQ/SOFTIRQ */
+
+	u64 soft_delay_max;
+	u64 soft_delay_min;
+	u64 soft_delay;		/* wait for SOFTIRQ */
 
 	u32 freepages_count;	/* total count of memory reclaim */
 	u32 thrashing_count;	/* total count of thrash waits */
 	u32 compact_count;	/* total count of memory compact */
 	u32 wpcopy_count;	/* total count of write-protect copy */
-	u32 irq_count;	/* total count of IRQ/SOFTIRQ */
+	u32 irq_count;		/* total count of IRQ/SOFTIRQ */
+	u32 soft_count;		/* total count of SOFTIRQ */
 };
 #endif
 
@@ -98,7 +103,7 @@ extern void __delayacct_compact_start(void);
 extern void __delayacct_compact_end(void);
 extern void __delayacct_wpcopy_start(void);
 extern void __delayacct_wpcopy_end(void);
-extern void __delayacct_irq(struct task_struct *task, u32 delta);
+extern void __delayacct_irq(struct task_struct *task, u32 delta, u32 delta_soft);
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -233,13 +238,14 @@ static inline void delayacct_wpcopy_end(void)
 		__delayacct_wpcopy_end();
 }
 
-static inline void delayacct_irq(struct task_struct *task, u32 delta)
+static inline void delayacct_irq(struct task_struct *task, u32 delta,
+					u32 delta_soft)
 {
 	if (!static_branch_unlikely(&delayacct_key))
 		return;
 
 	if (task->delays)
-		__delayacct_irq(task, delta);
+		__delayacct_irq(task, delta, delta_soft);
 }
 
 #else
@@ -280,7 +286,7 @@ static inline void delayacct_wpcopy_start(void)
 {}
 static inline void delayacct_wpcopy_end(void)
 {}
-static inline void delayacct_irq(struct task_struct *task, u32 delta)
+static inline void delayacct_irq(struct task_struct *task, u32 delta, u32 delta_soft)
 {}
 
 #endif /* CONFIG_TASK_DELAY_ACCT */
diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index 5929030d4e8b..23307f88e255 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -34,7 +34,7 @@
  */
 
 
-#define TASKSTATS_VERSION	16
+#define TASKSTATS_VERSION	17
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
@@ -230,6 +230,13 @@ struct taskstats {
 
 	__u64	irq_delay_max;
 	__u64	irq_delay_min;
+
+	/* v17: Delay waiting for SOFTIRQ */
+	__u64	soft_count;
+	__u64	soft_delay_total;
+
+	__u64	soft_delay_max;
+	__u64	soft_delay_min;
 };
 
 
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 30e7912ebb0d..15f88ca0c0e6 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -189,6 +189,7 @@ int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	UPDATE_DELAY(compact);
 	UPDATE_DELAY(wpcopy);
 	UPDATE_DELAY(irq);
+	UPDATE_DELAY(soft);
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 	return 0;
@@ -289,7 +290,7 @@ void __delayacct_wpcopy_end(void)
 		      &current->delays->wpcopy_delay_min);
 }
 
-void __delayacct_irq(struct task_struct *task, u32 delta)
+void __delayacct_irq(struct task_struct *task, u32 delta, u32 delta_soft)
 {
 	unsigned long flags;
 
@@ -300,6 +301,12 @@ void __delayacct_irq(struct task_struct *task, u32 delta)
 		task->delays->irq_delay_max = delta;
 	if (delta && (!task->delays->irq_delay_min || delta < task->delays->irq_delay_min))
 		task->delays->irq_delay_min = delta;
+	task->delays->soft_delay += delta_soft;
+	task->delays->soft_count++;
+	if (delta_soft > task->delays->soft_delay_max)
+		task->delays->soft_delay_max = delta_soft;
+	if (delta_soft && (!task->delays->soft_delay_min || delta_soft < task->delays->soft_delay_min))
+		task->delays->soft_delay_min = delta_soft;
 	raw_spin_unlock_irqrestore(&task->delays->lock, flags);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..30ba2e312356 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -773,11 +773,12 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
  * In theory, the compile should just see 0 here, and optimize out the call
  * to sched_rt_avg_update. But I don't trust it...
  */
-	s64 __maybe_unused steal = 0, irq_delta = 0;
+	s64 __maybe_unused steal = 0, irq_delta = 0, soft_delta = 0;
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	if (irqtime_enabled()) {
-		irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
+		irq_delta = irq_time_read(cpu_of(rq), &soft_delta) - rq->prev_irq_time;
+		soft_delta -= rq->prev_soft_time;
 
 		/*
 		 * Since irq_time is only updated on {soft,}irq_exit, we might run into
@@ -794,12 +795,17 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 		 * the current rq->clock timestamp, except that would require using
 		 * atomic ops.
 		 */
-		if (irq_delta > delta)
+		if (soft_delta > delta) {  /* IRQ includes SOFTIRQ */
+			soft_delta = delta;
 			irq_delta = delta;
+		} else if (irq_delta > delta) {
+			irq_delta = delta;
+		}
 
 		rq->prev_irq_time += irq_delta;
+		rq->prev_soft_time += soft_delta;
 		delta -= irq_delta;
-		delayacct_irq(rq->curr, irq_delta);
+		delayacct_irq(rq->curr, irq_delta, soft_delta);
 	}
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 7097de2c8cda..17467f1f3e72 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -38,13 +38,14 @@ void disable_sched_clock_irqtime(void)
 }
 
 static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
-				  enum cpu_usage_stat idx)
+				  u64 delta_soft, enum cpu_usage_stat idx)
 {
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
 
 	u64_stats_update_begin(&irqtime->sync);
 	cpustat[idx] += delta;
 	irqtime->total += delta;
+	irqtime->total_soft += delta_soft;
 	irqtime->tick_delta += delta;
 	u64_stats_update_end(&irqtime->sync);
 }
@@ -57,17 +58,27 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
 	unsigned int pc;
-	s64 delta;
+	s64 delta, delta_soft = 0, cpu_clock;
 	int cpu;
 
 	if (!irqtime_enabled())
 		return;
 
 	cpu = smp_processor_id();
-	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
+	cpu_clock = sched_clock_cpu(cpu);
+	delta = cpu_clock - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
 	pc = irq_count() - offset;
 
+	/*
+	 * We only account softirq time when we are called by
+	 * account_softirq_enter{,exit}
+	 */
+	if ((offset & SOFTIRQ_OFFSET) || (pc & SOFTIRQ_OFFSET)) {
+		delta_soft = cpu_clock - irqtime->soft_start_time;
+		irqtime->soft_start_time += delta_soft;
+	}
+
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
 	 * We want to continue accounting softirq time to ksoftirqd thread
@@ -75,9 +86,9 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 	 * that do not consume any time, but still wants to run.
 	 */
 	if (pc & HARDIRQ_MASK)
-		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
+		irqtime_account_delta(irqtime, delta, delta_soft, CPUTIME_IRQ);
 	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
-		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
+		irqtime_account_delta(irqtime, delta, delta_soft, CPUTIME_SOFTIRQ);
 }
 
 static u64 irqtime_tick_accounted(u64 maxtime)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f7..b263cb046cfa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1219,6 +1219,7 @@ struct rq {
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
+	u64			prev_soft_time;
 	u64			psi_irq_time;
 #endif
 #ifdef CONFIG_PARAVIRT
@@ -3135,8 +3136,10 @@ static inline void sched_core_tick(struct rq *rq) { }
 
 struct irqtime {
 	u64			total;
+	u64			total_soft;
 	u64			tick_delta;
 	u64			irq_start_time;
+	u64			soft_start_time;
 	struct u64_stats_sync	sync;
 };
 
@@ -3153,7 +3156,7 @@ static inline int irqtime_enabled(void)
  * Otherwise ksoftirqd's sum_exec_runtime is subtracted its own runtime
  * and never move forward.
  */
-static inline u64 irq_time_read(int cpu)
+static inline u64 irq_time_read(int cpu, u64 *total_soft)
 {
 	struct irqtime *irqtime = &per_cpu(cpu_irqtime, cpu);
 	unsigned int seq;
@@ -3162,6 +3165,7 @@ static inline u64 irq_time_read(int cpu)
 	do {
 		seq = __u64_stats_fetch_begin(&irqtime->sync);
 		total = irqtime->total;
+		*total_soft = irqtime->total_soft;
 	} while (__u64_stats_fetch_retry(&irqtime->sync, seq));
 
 	return total;
diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 21cb3c3d1331..7299cb60aa33 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -205,6 +205,7 @@ static int get_family_id(int sd)
  * version >= 13  - supports WPCOPY statistics
  * version >= 14  - supports IRQ statistics
  * version >= 16  - supports *_max and *_min delay statistics
+ * version >= 17  - supports SOFTIRQ statistics
  *
  * Always verify version before accessing version-dependent fields
  * to maintain backward compatibility.
@@ -296,6 +297,12 @@ static void print_delayacct(struct taskstats *t)
 			irq_count, irq_delay_total,
 			irq_delay_max, irq_delay_min);
 	}
+
+	if (t->version >= 17) {
+		PRINT_FILED_DELAY("SOFTIRQ", t->version, t,
+			soft_count, soft_delay_total,
+			soft_delay_max, soft_delay_min);
+	}
 }
 
 static void task_context_switch_counts(struct taskstats *t)
-- 
2.39.3 (Apple Git-145)


