Return-Path: <linux-kernel+bounces-750797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA1CB16122
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2763B16C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA9129B76B;
	Wed, 30 Jul 2025 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYhwhim3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23608299AAC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881163; cv=none; b=Q5vRFy3h/B0mLcyLddRCK6ELwm6NnReuLi7wttI6iB5z7T5zx+cwdzdwI+c8QLVMt9kIY0dLQp6P0EGXKWMEp+f29nKCizfCusidU4AOaTPfPZjgpttKeide7YHyUrKkOVoQvv0F1cXwfsx5Kma5k7iIaCNqaFfBRNlrjesCBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881163; c=relaxed/simple;
	bh=FWeVNuBCOVN1EzIWXtd3EkeuNAA3X+MP3kKOzDzkL74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prLMhL5EeYyXrx/lg2nEhyNgiYhTzc+byuFPr+VrU2Pg44tHbP0fP0QxfAfP8nLrEN8+wKXVGoZAK3WXT6vvMAfPtSiqbXU76wQT1bHzhDnfARnbyv1uqEsvs81/JE1bc0zirZSChlsnuKGOUWjaMecXSLsPdx49XGDJ513slhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYhwhim3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753881161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lTm+QVIZd33pyQLXRisfe00KUx2XeZWXw+ADC3Egfs=;
	b=aYhwhim3ySOWxnp+wvLbhrIH97jHmzqHGYQWivEzhDW6d1vhV3o905HF02qnduEr5bEyuj
	6+SKpifTnbRWWXbcRjZiOxLDsskRyVOIbkx3iSKmpvw+X+Ci3S4Q2XqSIKtAUTc2pKhRnU
	pNYDTUP76r16elWadStuGMstOdZ7R14=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-QY2MizVzPBy589zrTwJyzw-1; Wed,
 30 Jul 2025 09:12:39 -0400
X-MC-Unique: QY2MizVzPBy589zrTwJyzw-1
X-Mimecast-MFC-AGG-ID: QY2MizVzPBy589zrTwJyzw_1753881158
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C286F1800877;
	Wed, 30 Jul 2025 13:12:38 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.33.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A9FB19560A2;
	Wed, 30 Jul 2025 13:12:35 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v9 8/8] timers: Exclude isolated cpus from timer migration
Date: Wed, 30 Jul 2025 15:11:58 +0200
Message-ID: <20250730131158.101668-9-gmonaco@redhat.com>
In-Reply-To: <20250730131158.101668-1-gmonaco@redhat.com>
References: <20250730131158.101668-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/timer.h         |   9 +++
 kernel/cgroup/cpuset.c        |   3 +
 kernel/time/timer_migration.c | 100 +++++++++++++++++++++++++++++++++-
 3 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 0414d9e6b4fc..62e1cea71125 100644
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
index a946d85ce954..ff5b66abd047 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1392,6 +1392,9 @@ static void update_exclusion_cpumasks(bool isolcpus_updated)
 
 	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
+
+	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
+	WARN_ON_ONCE(ret < 0);
 }
 
 /**
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 36e7f784ec60..5e66147fce11 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <linux/timerqueue.h>
 #include <trace/events/ipi.h>
+#include <linux/sched/isolation.h>
 
 #include "timer_migration.h"
 #include "tick-internal.h"
@@ -436,6 +437,20 @@ static inline bool tmigr_is_not_available(struct tmigr_cpu *tmc)
 	return !(tmc->tmgroup && tmc->available);
 }
 
+/*
+ * Returns true if @cpu should be excluded from the hierarchy as isolated.
+ * Domain isolated CPUs don't participate in timer migration, nohz_full
+ * CPUs are still part of the hierarchy but are always considered idle.
+ * This check is necessary, for instance, to prevent offline isolated CPU from
+ * being incorrectly marked as available once getting back online.
+ */
+static inline bool tmigr_is_isolated(int cpu)
+{
+	return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) ||
+		cpuset_cpu_is_isolated(cpu)) &&
+	       housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE);
+}
+
 /*
  * Returns true, when @childmask corresponds to the group migrator or when the
  * group is not active - so no migrator is set.
@@ -1454,6 +1469,8 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 
 	cpumask_clear_cpu(cpu, tmigr_available_cpumask);
 	scoped_guard(raw_spinlock_irq, &tmc->lock) {
+		if (!tmc->available)
+			return 0;
 		tmc->available = false;
 		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 
@@ -1473,7 +1490,7 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	return 0;
 }
 
-static int tmigr_set_cpu_available(unsigned int cpu)
+static inline int _tmigr_set_cpu_available(unsigned int cpu)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
 
@@ -1483,6 +1500,8 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 
 	cpumask_set_cpu(cpu, tmigr_available_cpumask);
 	scoped_guard(raw_spinlock_irq, &tmc->lock) {
+		if (tmc->available)
+			return 0;
 		trace_tmigr_cpu_available(tmc);
 		tmc->idle = timer_base_is_idle();
 		if (!tmc->idle)
@@ -1492,14 +1511,89 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 	return 0;
 }
 
+static int tmigr_set_cpu_available(unsigned int cpu)
+{
+	if (tmigr_is_isolated(cpu))
+		return 0;
+	return _tmigr_set_cpu_available(cpu);
+}
+
+static bool tmigr_should_isolate_cpu(int cpu, void *ignored)
+{
+	/*
+	 * The tick CPU can be marked as isolated by the cpuset code, however
+	 * we cannot mark it as unavailable to avoid having no global migrator
+	 * for the nohz_full CPUs.
+	 */
+	return tick_nohz_cpu_hotpluggable(cpu);
+}
+
+static void tmigr_cpu_isolate(void *ignored)
+{
+	tmigr_clear_cpu_available(smp_processor_id());
+}
+
+static void tmigr_cpu_unisolate(void *ignored)
+{
+	tmigr_set_cpu_available(smp_processor_id());
+}
+
+static void tmigr_cpu_unisolate_force(void *ignored)
+{
+	/*
+	 * Required at boot to restore the tick CPU if nohz_full is available.
+	 * Hotplug handlers don't check for tick CPUs during runtime.
+	 */
+	_tmigr_set_cpu_available(smp_processor_id());
+}
+
+int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
+{
+	cpumask_var_t cpumask;
+
+	lockdep_assert_cpus_held();
+
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_and(cpumask, exclude_cpumask, tmigr_available_cpumask);
+	cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
+	on_each_cpu_cond_mask(tmigr_should_isolate_cpu, tmigr_cpu_isolate, NULL,
+			      1, cpumask);
+
+	cpumask_andnot(cpumask, cpu_online_mask, exclude_cpumask);
+	cpumask_andnot(cpumask, cpumask, tmigr_available_cpumask);
+	on_each_cpu_mask(cpumask, tmigr_cpu_unisolate, NULL, 1);
+
+	free_cpumask_var(cpumask);
+	return 0;
+}
+
 /*
  * NOHZ can only be enabled after clocksource_done_booting(). Don't
  * bother trashing the cache in the tree before.
  */
 static int __init tmigr_late_init(void)
 {
-	return cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
-				 tmigr_set_cpu_available, tmigr_clear_cpu_available);
+	int cpu, ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
+				tmigr_set_cpu_available, tmigr_clear_cpu_available);
+	if (ret)
+		return ret;
+	/*
+	 * The tick CPU may not be marked as available in the above call, this
+	 * can occur only at boot as hotplug handlers are not called on the
+	 * tick CPU. Force it enabled here.
+	 */
+	for_each_possible_cpu(cpu) {
+		if (!tick_nohz_cpu_hotpluggable(cpu)) {
+			ret = smp_call_function_single(
+				cpu, tmigr_cpu_unisolate_force, NULL, 1);
+			break;
+		}
+	}
+	return ret;
 }
 
 static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
-- 
2.50.1


