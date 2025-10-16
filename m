Return-Path: <linux-kernel+bounces-855995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B58DEBE2D47
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365DA5E13C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F7111A8;
	Thu, 16 Oct 2025 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pXUrcsMc"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7432863A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610254; cv=none; b=sckQVD5nDLv7H6eyB6+xlYm9WlG0HZ9iOS0Dq6WcaTNdyUR43UYzkwNHDIHvsLPapWbC0XpTF6Xz9Q+/2ns6d/6npqsbS4oCwKgK6Bc/jKEDvA8oxcSU1TTJl6Vnq8hn4Vrxsf2L5v/BumVEOXC3ksw3egTCqi87xPZs/v2JXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610254; c=relaxed/simple;
	bh=THynFsm+uNetSIOEglsqSzltbK2zZODtc7fw8J3Y8/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T1s1JIeFsDnLPeZe2o0Hh7c27i0ZGde5bGMKnvS45DZFBGmch3T+YyfRroa5T5wpdGrc6NIVK6pwKIgfA3chC4Zjh7+ZQyA4P3BhLItbmgFe8LO5FZcf93NGLb5j4oFByUS2eYxpjx1Jrx7ZCfwRYSBjejnaagPfsmZhAo8O6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pXUrcsMc; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ey
	RI+CsMCcUKicgmPIqDbD8tGK56XEuTP9EuKahNIm4=; b=pXUrcsMcsHlPUKK/uQ
	A2HkjoLaGe3rmq23C76FmCIy9bKfpVaXq5+w4FgNyY8UD6C4ujhxQdYriqp+h0Lj
	ll7/Ix7NoqGOOkfKMaihVMUywIt4CJ+BQUQZnE9WPAnc8o2JaR6yqgJeeWh8rmFZ
	u7bzS5eEh4Gi91Sttoc76ssAw=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAHS_2zx_BoOCKJAg--.5549S2;
	Thu, 16 Oct 2025 18:23:48 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: tj@kernel.org,
	jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH] workqueue: Support RT workqueue
Date: Thu, 16 Oct 2025 18:23:45 +0800
Message-Id: <20251016102345.2200815-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHS_2zx_BoOCKJAg--.5549S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr4kZF4DAw1xZryUKFW3ZFb_yoWfZrW3pF
	4Fkrs8Kw48Xr4jgasxKay7Jry3Kr10g3W7J34xuw1ay398tr9av3WvyFyYvryrtr98uw13
	AFWDta92yw4qvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piiSdxUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwBR1f2jwx7TKjAAA3z

In a system with high real-time requirements, we have noticed that many
high-priority tasks, such as kernel threads responsible for dispatching
GPU tasks and receiving data sources, often experience latency spikes
due to insufficient real-time execution of work.
The kworker threads are shared globally based on the attributes of the
workqueue (wq) and the parameters of queue_work_on. This means that
regardless of whether you create a new wq or use an existing one, the
kworker thread that processes the work does not exclusively run any
specific work or work from a specific wq. While this design saves
resources, it makes it difficult to ensure the real-time execution of
work by modifying the priority of the kworker thread associated with a
specific work in hard real-time scenarios. Additionally, if I manually
set the real-time priority of the kworker while executing the work task
and then adjust it back upon completion, the next time queue_work_on is
called, the priority of the kworker thread will have reverted, making it
impossible to ensure timely execution of these lower-priority threads.
Moreover, frequent priority adjustments can incur additional overhead.
Perhaps we could implement all logic related to hard real-time tasks
using kernel threads, but I believe this workload is unnecessary. The
existing workqueue mechanism in the system is well-structured and can
guarantee that work executes in an orderly manner in concurrent scenarios
by adjusting the max_active and WQ_ORDERED attributes. We only need to
introduce a WQ_RT flag and add a small amount of code to meet the
requirements of hard real-time workqueues.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 include/linux/workqueue.h |  6 ++++++
 kernel/workqueue.c        | 34 ++++++++++++++++++++++++----------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 45d5dd470..973876b79 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -16,6 +16,7 @@
 #include <linux/cpumask_types.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue_types.h>
+#include <uapi/linux/sched/types.h>
 
 /*
  * The first word is the work queue pointer and the flags rolled into
@@ -404,6 +405,8 @@ enum wq_flags {
 	WQ_POWER_EFFICIENT	= 1 << 7,
 	WQ_PERCPU		= 1 << 8, /* bound to a specific cpu */
 
+	WQ_RT			= 1 << 9,
+
 	__WQ_DESTROYING		= 1 << 15, /* internal: workqueue is destroying */
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
@@ -460,6 +463,7 @@ enum wq_consts {
 extern struct workqueue_struct *system_wq; /* use system_percpu_wq, this will be removed */
 extern struct workqueue_struct *system_percpu_wq;
 extern struct workqueue_struct *system_highpri_wq;
+extern struct workqueue_struct *system_rt_wq;
 extern struct workqueue_struct *system_long_wq;
 extern struct workqueue_struct *system_unbound_wq;
 extern struct workqueue_struct *system_dfl_wq;
@@ -781,6 +785,8 @@ extern void __warn_flushing_systemwide_wq(void)
 	     _wq == system_wq) ||					\
 	    (__builtin_constant_p(_wq == system_highpri_wq) &&		\
 	     _wq == system_highpri_wq) ||				\
+	    (__builtin_constant_p(_wq == system_rt_wq) &&		\
+	     _wq == system_rt_wq) ||					\
 	    (__builtin_constant_p(_wq == system_long_wq) &&		\
 	     _wq == system_long_wq) ||					\
 	    (__builtin_constant_p(_wq == system_unbound_wq) &&		\
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c6b79b367..ccbf19e3a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -103,7 +103,7 @@ enum work_cancel_flags {
 };
 
 enum wq_internal_consts {
-	NR_STD_WORKER_POOLS	= 2,		/* # standard pools per cpu */
+	NR_STD_WORKER_POOLS	= 3,		/* # standard pools per cpu */
 
 	UNBOUND_POOL_HASH_ORDER	= 6,		/* hashed by pool->attrs */
 	BUSY_WORKER_HASH_ORDER	= 6,		/* 64 pointers */
@@ -123,6 +123,7 @@ enum wq_internal_consts {
 	 */
 	RESCUER_NICE_LEVEL	= MIN_NICE,
 	HIGHPRI_NICE_LEVEL	= MIN_NICE,
+	RTPRI_LEVEL		= MIN_NICE - 1,
 
 	WQ_NAME_LEN		= 32,
 	WORKER_ID_LEN		= 10 + WQ_NAME_LEN, /* "kworker/R-" + WQ_NAME_LEN */
@@ -509,6 +510,8 @@ struct workqueue_struct *system_percpu_wq __ro_after_init;
 EXPORT_SYMBOL(system_percpu_wq);
 struct workqueue_struct *system_highpri_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_highpri_wq);
+struct workqueue_struct *system_rt_wq __read_mostly;
+EXPORT_SYMBOL_GPL(system_rt_wq);
 struct workqueue_struct *system_long_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_long_wq);
 struct workqueue_struct *system_unbound_wq __ro_after_init;
@@ -2751,7 +2754,8 @@ static int format_worker_id(char *buf, size_t size, struct worker *worker,
 		if (pool->cpu >= 0)
 			return scnprintf(buf, size, "kworker/%d:%d%s",
 					 pool->cpu, worker->id,
-					 pool->attrs->nice < 0  ? "H" : "");
+					 pool->attrs->nice < 0 ?
+					 (pool->attrs->nice == RTPRI_LEVEL ? "F" : "H") : "");
 		else
 			return scnprintf(buf, size, "kworker/u%d:%d",
 					 pool->id, worker->id);
@@ -2760,6 +2764,9 @@ static int format_worker_id(char *buf, size_t size, struct worker *worker,
 	}
 }
 
+static int kworker_rt_prio = 1;
+module_param(kworker_rt_prio, int, 0444);
+
 /**
  * create_worker - create a new workqueue worker
  * @pool: pool the new worker will belong to
@@ -2776,6 +2783,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 {
 	struct worker *worker;
 	int id;
+	struct sched_param sp;
 
 	/* ID is needed to determine kthread name */
 	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
@@ -2810,7 +2818,12 @@ static struct worker *create_worker(struct worker_pool *pool)
 			goto fail;
 		}
 
-		set_user_nice(worker->task, pool->attrs->nice);
+		if (pool->attrs->nice == RTPRI_LEVEL) {
+			sp.sched_priority = kworker_rt_prio;
+			sched_setscheduler_nocheck(worker->task, SCHED_FIFO, &sp);
+		} else {
+			set_user_nice(worker->task, pool->attrs->nice);
+		}
 		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
 	}
 
@@ -5470,7 +5483,7 @@ static void unbound_wq_update_pwq(struct workqueue_struct *wq, int cpu)
 
 static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 {
-	bool highpri = wq->flags & WQ_HIGHPRI;
+	int prio = (wq->flags & WQ_RT) ? 2 : (wq->flags & WQ_HIGHPRI ? 1 : 0);
 	int cpu, ret;
 
 	lockdep_assert_held(&wq_pool_mutex);
@@ -5491,7 +5504,7 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 			struct pool_workqueue **pwq_p;
 			struct worker_pool *pool;
 
-			pool = &(per_cpu_ptr(pools, cpu)[highpri]);
+			pool = &(per_cpu_ptr(pools, cpu)[prio]);
 			pwq_p = per_cpu_ptr(wq->cpu_pwq, cpu);
 
 			*pwq_p = kmem_cache_alloc_node(pwq_cache, GFP_KERNEL,
@@ -5511,14 +5524,14 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	if (wq->flags & __WQ_ORDERED) {
 		struct pool_workqueue *dfl_pwq;
 
-		ret = apply_workqueue_attrs_locked(wq, ordered_wq_attrs[highpri]);
+		ret = apply_workqueue_attrs_locked(wq, ordered_wq_attrs[prio]);
 		/* there should only be single pwq for ordering guarantee */
 		dfl_pwq = rcu_access_pointer(wq->dfl_pwq);
 		WARN(!ret && (wq->pwqs.next != &dfl_pwq->pwqs_node ||
 			      wq->pwqs.prev != &dfl_pwq->pwqs_node),
 		     "ordering guarantee broken for workqueue %s\n", wq->name);
 	} else {
-		ret = apply_workqueue_attrs_locked(wq, unbound_std_wq_attrs[highpri]);
+		ret = apply_workqueue_attrs_locked(wq, unbound_std_wq_attrs[prio]);
 	}
 
 	return ret;
@@ -7720,7 +7733,7 @@ static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int n
 void __init workqueue_init_early(void)
 {
 	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_SYSTEM];
-	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
+	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL, RTPRI_LEVEL };
 	void (*irq_work_fns[2])(struct irq_work *) = { bh_pool_kick_normal,
 						       bh_pool_kick_highpri };
 	int i, cpu;
@@ -7805,6 +7818,7 @@ void __init workqueue_init_early(void)
 	system_wq = alloc_workqueue("events", 0, 0);
 	system_percpu_wq = alloc_workqueue("events", 0, 0);
 	system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
+	system_rt_wq = alloc_workqueue("events_rt", WQ_RT, 0);
 	system_long_wq = alloc_workqueue("events_long", 0, 0);
 	system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND, WQ_MAX_ACTIVE);
 	system_dfl_wq = alloc_workqueue("events_unbound", WQ_UNBOUND, WQ_MAX_ACTIVE);
@@ -7818,8 +7832,8 @@ void __init workqueue_init_early(void)
 	system_bh_wq = alloc_workqueue("events_bh", WQ_BH, 0);
 	system_bh_highpri_wq = alloc_workqueue("events_bh_highpri",
 					       WQ_BH | WQ_HIGHPRI, 0);
-	BUG_ON(!system_wq || !system_percpu_wq|| !system_highpri_wq || !system_long_wq ||
-	       !system_unbound_wq || !system_freezable_wq || !system_dfl_wq ||
+	BUG_ON(!system_wq || !system_percpu_wq || !system_highpri_wq || !system_rt_wq ||
+	       !system_long_wq || !system_unbound_wq || !system_freezable_wq || !system_dfl_wq ||
 	       !system_power_efficient_wq ||
 	       !system_freezable_power_efficient_wq ||
 	       !system_bh_wq || !system_bh_highpri_wq);
-- 
2.34.1


