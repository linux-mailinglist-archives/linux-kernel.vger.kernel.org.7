Return-Path: <linux-kernel+bounces-884617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78533C3096E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D584189F117
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D22DA765;
	Tue,  4 Nov 2025 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHARpKno"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885C2D9EEF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253319; cv=none; b=FHSqhqkbJyhl3xFeLM3eUSwpdTSOQMldEMSMNeE76MaQ//2cjolgJCDvu3lZ2y4X7ynUzn4pIHvfXS4LmxXmAkJ116I8LTIFTFqorskp1m7mWdv2gZE0WqhYTi7VHjjSC9WC79BeyczsnyB7Q3GtHI3xFkEfB3Kf0Ifeo7g812Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253319; c=relaxed/simple;
	bh=Wn3gL8sjRD+/oY+n/DvD5D+IQIJTqg/u1sQpss6GOUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnyKtKkzLCUWHalTuhM2/MbddYD7YeuV7Oo84XYeoCkS51JNi94Opdn/7RKtAnccav7Bmn2bgkc+zyvvC60MwTQIYgsnGA+WIA89N0enXqsuFdgcIG80sPodWfDlNJiBAL2GxFZHeTAiR+gUjEnr1AV5nmajySTZht5snWwV9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHARpKno; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762253316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uL/CjzwNMQI9eljDIqied7MXuhzHl1Ftl+z2w4DtGsE=;
	b=YHARpKnoaIPQqm6aGeGttJryIR0MulQ+RWA10hTLmGSw4P393aShC9VddQ1vSX8GILZG7P
	4VVjl1aD2U9hrPK5AFDqQ31wPeGZfaRNSdbOq/IF6WnQK2F/lFkZ3OxU4OMncK1LVnWjQ5
	zqMY82lz2lmlqnKFcA6HUlrbZo7QQKY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-fxaLslkLM_qXTQY1p-Ir7Q-1; Tue,
 04 Nov 2025 05:48:32 -0500
X-MC-Unique: fxaLslkLM_qXTQY1p-Ir7Q-1
X-Mimecast-MFC-AGG-ID: fxaLslkLM_qXTQY1p-Ir7Q_1762253311
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1C90180121B;
	Tue,  4 Nov 2025 10:48:31 +0000 (UTC)
Received: from eda-pc.redhat.com (unknown [10.45.224.83])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4027180057B;
	Tue,  4 Nov 2025 10:48:28 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <llong@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	"John B . Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v14 7/7] timers: Exclude isolated cpus from timer migration
Date: Tue,  4 Nov 2025 11:47:39 +0100
Message-ID: <20251104104740.70512-8-gmonaco@redhat.com>
In-Reply-To: <20251104104740.70512-1-gmonaco@redhat.com>
References: <20251104104740.70512-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The timer migration mechanism allows active CPUs to pull timers from
idle ones to improve the overall idle time. This is however undesired
when CPU intensive workloads run on isolated cores, as the algorithm
would move the timers from housekeeping to isolated cores, negatively
affecting the isolation.

Exclude isolated cores from the timer migration algorithm, extend the
concept of unavailable cores, currently used for offline ones, to
isolated ones:
* A core is unavailable if isolated or offline;
* A core is available if non isolated and online;

A core is considered unavailable as isolated if it belongs to:
* the isolcpus (domain) list
* an isolated cpuset
Except if it is:
* in the nohz_full list (already idle for the hierarchy)
* the nohz timekeeper core (must be available to handle global timers)

CPUs are added to the hierarchy during late boot, excluding isolated
ones, the hierarchy is also adapted when the cpuset isolation changes.

Due to how the timer migration algorithm works, any CPU part of the
hierarchy can have their global timers pulled by remote CPUs and have to
pull remote timers, only skipping pulling remote timers would break the
logic.
For this reason, prevent isolated CPUs from pulling remote global
timers, but also the other way around: any global timer started on an
isolated CPU will run there. This does not break the concept of
isolation (global timers don't come from outside the CPU) and, if
considered inappropriate, can usually be mitigated with other isolation
techniques (e.g. IRQ pinning).

This effect was noticed on a 128 cores machine running oslat on the
isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
and the CPU with lowest count in a timer migration hierarchy (here 1
and 65) appears as always active and continuously pulls global timers,
from the housekeeping CPUs. This ends up moving driver work (e.g.
delayed work) to isolated CPUs and causes latency spikes:

before the change:

 # oslat -c 1-31,33-63,65-95,97-127 -D 62s
 ...
  Maximum:     1203 10 3 4 ... 5 (us)

after the change:

 # oslat -c 1-31,33-63,65-95,97-127 -D 62s
 ...
  Maximum:      10 4 3 4 3 ... 5 (us)

The same behaviour was observed on a machine with as few as 20 cores /
40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.

Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/timer.h         |   9 ++
 kernel/cgroup/cpuset.c        |   3 +
 kernel/time/timer_migration.c | 172 +++++++++++++++++++++++++++++++++-
 3 files changed, 179 insertions(+), 5 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 0414d9e6b4fcd..62e1cea711257 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -188,4 +188,13 @@ int timers_dead_cpu(unsigned int cpu);
 #define timers_dead_cpu		NULL
 #endif
 
+#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
+extern int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask);
+#else
+static inline int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7ad5a92af5c73..719f119a563cf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1402,6 +1402,9 @@ static void update_isolation_cpumasks(bool isolcpus_updated)
 
 	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
+
+	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
+	WARN_ON_ONCE(ret < 0);
 }
 
 /**
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 99503d34f151d..f93c5fba24fd8 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <linux/timerqueue.h>
 #include <trace/events/ipi.h>
+#include <linux/sched/isolation.h>
 
 #include "timer_migration.h"
 #include "tick-internal.h"
@@ -428,6 +429,9 @@ static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
  */
 static cpumask_var_t tmigr_available_cpumask;
 
+/* Enabled during late initcall */
+DEFINE_STATIC_KEY_FALSE(tmigr_exclude_isolated);
+
 #define TMIGR_NONE	0xFF
 #define BIT_CNT		8
 
@@ -436,6 +440,33 @@ static inline bool tmigr_is_not_available(struct tmigr_cpu *tmc)
 	return !(tmc->tmgroup && tmc->available);
 }
 
+/*
+ * Returns true if @cpu should be excluded from the hierarchy as isolated.
+ * Domain isolated CPUs don't participate in timer migration, nohz_full CPUs
+ * are still part of the hierarchy but become idle (from a tick and timer
+ * migration perspective) when they stop their tick. This lets the timekeeping
+ * CPU handle their global timers. Marking also isolated CPUs as idle would be
+ * too costly, hence they are completely excluded from the hierarchy.
+ * This check is necessary, for instance, to prevent offline isolated CPUs from
+ * being incorrectly marked as available once getting back online.
+ *
+ * This function returns false during early boot and the isolation logic is
+ * enabled only after isolated CPUs are marked as unavailable at late boot.
+ * The tick CPU can be isolated at boot, however we cannot mark it as
+ * unavailable to avoid having no global migrator for the nohz_full CPUs. This
+ * should be ensured by the callers of this function: implicitly from hotplug
+ * callbacs and explicitly in tmigr_init_isolation and
+ * tmigr_isolated_exclude_cpumask.
+ */
+static inline bool tmigr_is_isolated(int cpu)
+{
+	if (static_branch_unlikely(&tmigr_exclude_isolated))
+		return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) ||
+			cpuset_cpu_is_isolated(cpu)) &&
+		       housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE);
+	return false;
+}
+
 /*
  * Returns true, when @childmask corresponds to the group migrator or when the
  * group is not active - so no migrator is set.
@@ -1449,8 +1480,9 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	int migrator;
 	u64 firstexp;
 
-	cpumask_clear_cpu(cpu, tmigr_available_cpumask);
 	scoped_guard(raw_spinlock_irq, &tmc->lock) {
+		if (!tmc->available)
+			return 0;
 		tmc->available = false;
 		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 
@@ -1463,11 +1495,11 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	}
 
 	if (firstexp != KTIME_MAX) {
-		migrator = cpumask_any(tmigr_available_cpumask);
+		migrator = cpumask_any_but(tmigr_available_cpumask, cpu);
 		work_on_cpu(migrator, tmigr_trigger_active, NULL);
 	}
 
-	return 0;
+	return 1;
 }
 
 static int tmigr_set_cpu_available(unsigned int cpu)
@@ -1478,14 +1510,143 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 	if (WARN_ON_ONCE(!tmc->tmgroup))
 		return -EINVAL;
 
-	cpumask_set_cpu(cpu, tmigr_available_cpumask);
+	if (tmigr_is_isolated(cpu))
+		return 0;
+
 	scoped_guard(raw_spinlock_irq, &tmc->lock) {
+		if (tmc->available)
+			return 0;
 		trace_tmigr_cpu_available(tmc);
 		tmc->idle = timer_base_is_idle();
 		if (!tmc->idle)
 			__tmigr_cpu_activate(tmc);
 		tmc->available = true;
 	}
+	return 1;
+}
+
+static int tmigr_online_cpu(unsigned int cpu)
+{
+	if (tmigr_set_cpu_available(cpu) > 0)
+		cpumask_set_cpu(cpu, tmigr_available_cpumask);
+	return 0;
+}
+
+static int tmigr_offline_cpu(unsigned int cpu)
+{
+	if (tmigr_clear_cpu_available(cpu) > 0)
+		cpumask_clear_cpu(cpu, tmigr_available_cpumask);
+	return 0;
+}
+
+static void tmigr_cpu_isolate(struct work_struct *ignored)
+{
+	tmigr_clear_cpu_available(smp_processor_id());
+}
+
+static void tmigr_cpu_unisolate(struct work_struct *ignored)
+{
+	tmigr_set_cpu_available(smp_processor_id());
+}
+
+/**
+ * tmigr_isolated_exclude_cpumask - Exclude given CPUs from hierarchy
+ * @exclude_cpumask: the cpumask to be excluded from timer migration hierarchy
+ *
+ * This function can be called from cpuset code to provide the new set of
+ * isolated CPUs that should be excluded from the hierarchy.
+ * Online CPUs not present in exclude_cpumask but already excluded are brought
+ * back to the hierarchy.
+ * Functions to isolate/unisolate need to be called locally and can sleep.
+ */
+int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
+{
+	struct work_struct __percpu *works __free(free_percpu) =
+		alloc_percpu(struct work_struct);
+	cpumask_var_t cpumask_unisol __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+	cpumask_var_t cpumask_isol __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+	int cpu;
+
+	lockdep_assert_cpus_held();
+
+	if (!alloc_cpumask_var(&cpumask_isol, GFP_KERNEL))
+		return -ENOMEM;
+	if (!alloc_cpumask_var(&cpumask_unisol, GFP_KERNEL))
+		return -ENOMEM;
+	if (!works)
+		return -ENOMEM;
+
+	cpumask_andnot(cpumask_unisol, cpu_online_mask, exclude_cpumask);
+	cpumask_andnot(cpumask_unisol, cpumask_unisol, tmigr_available_cpumask);
+	/* Set up the mask earlier to avoid races with the migrator CPU */
+	cpumask_or(tmigr_available_cpumask, tmigr_available_cpumask, cpumask_unisol);
+	for_each_cpu(cpu, cpumask_unisol) {
+		struct work_struct *work = per_cpu_ptr(works, cpu);
+
+		INIT_WORK(work, tmigr_cpu_unisolate);
+		schedule_work_on(cpu, work);
+	}
+
+	cpumask_and(cpumask_isol, exclude_cpumask, tmigr_available_cpumask);
+	cpumask_and(cpumask_isol, cpumask_isol, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
+	/*
+	 * Handle this here and not in the cpuset code because exclude_cpumask
+	 * might include also the tick CPU if included in isolcpus.
+	 */
+	for_each_cpu(cpu, cpumask_isol) {
+		if (!tick_nohz_cpu_hotpluggable(cpu)) {
+			cpumask_clear_cpu(cpu, cpumask_isol);
+			break;
+		}
+	}
+	/* Set up the mask earlier to avoid races with the migrator CPU */
+	cpumask_andnot(tmigr_available_cpumask, tmigr_available_cpumask, cpumask_isol);
+	for_each_cpu(cpu, cpumask_isol) {
+		struct work_struct *work = per_cpu_ptr(works, cpu);
+
+		INIT_WORK(work, tmigr_cpu_isolate);
+		schedule_work_on(cpu, work);
+	}
+
+	for_each_cpu_or(cpu, cpumask_isol, cpumask_unisol)
+		flush_work(per_cpu_ptr(works, cpu));
+
+	return 0;
+}
+
+static int __init tmigr_init_isolation(void)
+{
+	struct work_struct __percpu *works __free(free_percpu) =
+		alloc_percpu(struct work_struct);
+	cpumask_var_t cpumask __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+	int cpu;
+
+	static_branch_enable(&tmigr_exclude_isolated);
+	if (!housekeeping_enabled(HK_TYPE_DOMAIN))
+		return 0;
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+	if (!works)
+		return -ENOMEM;
+	cpumask_andnot(cpumask, tmigr_available_cpumask,
+		       housekeeping_cpumask(HK_TYPE_DOMAIN));
+	cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
+	/* Never disable the tick CPU, see tmigr_is_isolated for details */
+	for_each_cpu(cpu, cpumask) {
+		if (!tick_nohz_cpu_hotpluggable(cpu)) {
+			cpumask_clear_cpu(cpu, cpumask);
+			break;
+		}
+	}
+	for_each_cpu(cpu, cpumask) {
+		struct work_struct *work = per_cpu_ptr(works, cpu);
+
+		INIT_WORK(work, tmigr_cpu_isolate);
+		schedule_work_on(cpu, work);
+	}
+	for_each_cpu(cpu, cpumask)
+		flush_work(per_cpu_ptr(works, cpu));
+
 	return 0;
 }
 
@@ -1860,7 +2021,7 @@ static int __init tmigr_init(void)
 		goto err;
 
 	ret = cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
-				tmigr_set_cpu_available, tmigr_clear_cpu_available);
+				tmigr_online_cpu, tmigr_offline_cpu);
 	if (ret)
 		goto err;
 
@@ -1871,3 +2032,4 @@ static int __init tmigr_init(void)
 	return ret;
 }
 early_initcall(tmigr_init);
+late_initcall(tmigr_init_isolation);
-- 
2.43.0


