Return-Path: <linux-kernel+bounces-792064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BAAB3BFE3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E93B3B4BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F0F33769D;
	Fri, 29 Aug 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5wNbLiO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64043277B4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482537; cv=none; b=QeODJUd1O+05+qnvEh6IORg9sJtXjgfurTwGUIBdpR0oFTiFP9pzW0oNjT7lqzzP1UpRSB6O2QHGm3TARfccHzKCxGuVCDiVkvsQqYrtUzipo2OPvF7vPfeJ1Ank8aTtySX3jTdNUDTAgrtQWN7yz8IRHSXfLR+3hotoTjvEQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482537; c=relaxed/simple;
	bh=JhJw3/T9u/hnpbb5ctajFxg6YPqtzMSvHrfpSvw6ITg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKLrf/RBUNX3TvdDzfbzlg7kAqfthYhrt1DNhs4Xw9TuDhK1ikIhjDO8wn0Mtx3P4MHWd+GZhatB9TRaXBWLAAGBElaLE+jr0xDYYMGF3TcQWaFo+rfsd0sMN/Gtp+dQbF3ISgtK6EmuaQHpwUHDAtjvSBnjJPRSu5h5+UchuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5wNbLiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E69C4CEF0;
	Fri, 29 Aug 2025 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482536;
	bh=JhJw3/T9u/hnpbb5ctajFxg6YPqtzMSvHrfpSvw6ITg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5wNbLiOZzRvWvaRCJwSAcgWMUTKX0/llfwJIUnSlAWSODxwpafPzpuSR7UFeTHDa
	 8FRZg/DFMUwculwr27bBoYkMqMLQwHpXWAXW5EE0HHM4yceYoxGVGLXttHw5W9zHUd
	 chwG6QpK/2RxhGztQb1IqxKxRbhEZw96boL1S1YOVGM+QxyAdpSKbYlFQ6xU0BzMU3
	 6fjIAk1xQ+rRySBbdg4uTTgSLZwSHeud6yeGNbm2e7FhXokUQL9YadKU72PPZ80Lr7
	 ZUa04sFVTfXpnaQRgP8vpCL0Rh0rB0nphlS90GMIDjfJ7qaHoJvAqlwUrQcU4z+muk
	 hh2VYwgsZPrJw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 13/33] sched/isolation: Convert housekeeping cpumasks to rcu pointers
Date: Fri, 29 Aug 2025 17:47:54 +0200
Message-ID: <20250829154814.47015-14-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HK_TYPE_DOMAIN's cpumask will soon be made modifyable by cpuset.
A synchronization mechanism is then needed to synchronize the updates
with the housekeeping cpumask readers.

Turn the housekeeping cpumasks into RCU pointers. Once a housekeeping
cpumask will be modified, the update side will wait for an RCU grace
period and propagate the change to interested subsystem when deemed
necessary.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/isolation.c | 52 ++++++++++++++++++++++++++--------------
 kernel/sched/sched.h     |  1 +
 2 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index fb414e28706d..5ddb8dc5ca91 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -17,7 +17,7 @@ enum hk_flags {
 	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
 };
 
-static cpumask_var_t housekeeping_cpumasks[HK_TYPE_MAX];
+static struct cpumask __rcu *housekeeping_cpumasks[HK_TYPE_MAX];
 unsigned long housekeeping_flags;
 EXPORT_SYMBOL_GPL(housekeeping_flags);
 
@@ -27,16 +27,25 @@ bool housekeeping_enabled(enum hk_type type)
 }
 EXPORT_SYMBOL_GPL(housekeeping_enabled);
 
+const struct cpumask *housekeeping_cpumask(enum hk_type type)
+{
+	if (housekeeping_flags & BIT(type)) {
+		return rcu_dereference_check(housekeeping_cpumasks[type], 1);
+	}
+	return cpu_possible_mask;
+}
+EXPORT_SYMBOL_GPL(housekeeping_cpumask);
+
 int housekeeping_any_cpu(enum hk_type type)
 {
 	int cpu;
 
 	if (housekeeping_flags & BIT(type)) {
-		cpu = sched_numa_find_closest(housekeeping_cpumasks[type], smp_processor_id());
+		cpu = sched_numa_find_closest(housekeeping_cpumask(type), smp_processor_id());
 		if (cpu < nr_cpu_ids)
 			return cpu;
 
-		cpu = cpumask_any_and_distribute(housekeeping_cpumasks[type], cpu_online_mask);
+		cpu = cpumask_any_and_distribute(housekeeping_cpumask(type), cpu_online_mask);
 		if (likely(cpu < nr_cpu_ids))
 			return cpu;
 		/*
@@ -52,25 +61,17 @@ int housekeeping_any_cpu(enum hk_type type)
 }
 EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
 
-const struct cpumask *housekeeping_cpumask(enum hk_type type)
-{
-	if (housekeeping_flags & BIT(type))
-		return housekeeping_cpumasks[type];
-	return cpu_possible_mask;
-}
-EXPORT_SYMBOL_GPL(housekeeping_cpumask);
-
 void housekeeping_affine(struct task_struct *t, enum hk_type type)
 {
 	if (housekeeping_flags & BIT(type))
-		set_cpus_allowed_ptr(t, housekeeping_cpumasks[type]);
+		set_cpus_allowed_ptr(t, housekeeping_cpumask(type));
 }
 EXPORT_SYMBOL_GPL(housekeeping_affine);
 
 bool housekeeping_test_cpu(int cpu, enum hk_type type)
 {
 	if (housekeeping_flags & BIT(type))
-		return cpumask_test_cpu(cpu, housekeeping_cpumasks[type]);
+		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
 	return true;
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
@@ -85,9 +86,23 @@ void __init housekeeping_init(void)
 	if (housekeeping_flags & HK_FLAG_KERNEL_NOISE)
 		sched_tick_offload_init();
 
+	/*
+	 * Realloc with a proper allocator so that any cpumask update
+	 * can indifferently free the old version with kfree().
+	 */
 	for_each_set_bit(type, &housekeeping_flags, HK_TYPE_MAX) {
+		struct cpumask *omask, *nmask = kmalloc(cpumask_size(), GFP_KERNEL);
+
+		if (WARN_ON_ONCE(!nmask))
+			return;
+
+		omask = rcu_dereference(housekeeping_cpumasks[type]);
+
 		/* We need at least one CPU to handle housekeeping work */
-		WARN_ON_ONCE(cpumask_empty(housekeeping_cpumasks[type]));
+		WARN_ON_ONCE(cpumask_empty(omask));
+		cpumask_copy(nmask, omask);
+		RCU_INIT_POINTER(housekeeping_cpumasks[type], nmask);
+		memblock_free(omask, cpumask_size());
 	}
 }
 
@@ -95,9 +110,10 @@ static void __init housekeeping_setup_type(enum hk_type type,
 					   cpumask_var_t housekeeping_staging)
 {
 
-	alloc_bootmem_cpumask_var(&housekeeping_cpumasks[type]);
-	cpumask_copy(housekeeping_cpumasks[type],
-		     housekeeping_staging);
+	struct cpumask *mask = memblock_alloc_or_panic(cpumask_size(), SMP_CACHE_BYTES);
+
+	cpumask_copy(mask, housekeeping_staging);
+	RCU_INIT_POINTER(housekeeping_cpumasks[type], mask);
 }
 
 static int __init housekeeping_setup(char *str, unsigned long flags)
@@ -150,7 +166,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 
 		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX) {
 			if (!cpumask_equal(housekeeping_staging,
-					   housekeeping_cpumasks[type])) {
+					   housekeeping_cpumask(type))) {
 				pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
 				goto free_housekeeping_staging;
 			}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f7..0b1a233dcabf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -42,6 +42,7 @@
 #include <linux/ktime_api.h>
 #include <linux/lockdep_api.h>
 #include <linux/lockdep.h>
+#include <linux/memblock.h>
 #include <linux/minmax.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-- 
2.51.0


