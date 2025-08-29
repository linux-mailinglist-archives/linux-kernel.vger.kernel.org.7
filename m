Return-Path: <linux-kernel+bounces-792079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CD8B3BFFC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB403B64FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB01343213;
	Fri, 29 Aug 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onb0u1kZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779E3314AC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482576; cv=none; b=Zdm2Kdmua7mY6dnEFlGjJZNtp6wg3JgHOn245kK+JkJdwo/ZpYMHO9O0x7C4A04l5fYlkU0mXJZI09ZYzQjpMaxM6dqhkNfHLWE3+u4ZXpy914gkaPOr2GCi3pMZloVxQguz7vpUIDO0P9MPr2D+pyEEzc9LL92N19B1B8E2FHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482576; c=relaxed/simple;
	bh=QmHeJLzWp0BmqCz+ztUiz8/RmLhDblGFFLV72Ii4meA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8ICXXjx1TOxDYwvIpaYsVfxbKrwnHAq4WyA+wq94Dqm/JTAvs0IAvQrShOEQ0cb1vFg+DmAiUbe2nEx+zE6ODknuz4wf+lbRRy9yDGWsfZnYlkBI2jvXmJpg4v5j4wqxXVVE+QMVIsA4Yok1KJZrg6FZ2JtGpwnW5boSYSzY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onb0u1kZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C8FC4CEF5;
	Fri, 29 Aug 2025 15:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482576;
	bh=QmHeJLzWp0BmqCz+ztUiz8/RmLhDblGFFLV72Ii4meA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Onb0u1kZ3slfgnN8k1ly/s8A1GZzWzaV5YsJT04FaL2a7EmkG7WZ3lbDCaky2ngSN
	 o7ZF3jsOYN4lEWAMdZtfl0JFKyx5fSrKh4x2mYeE/HmmZuBEQpy85BLaG5wwrcd11s
	 h+wKTCtCEIlEU1wdg/jgRKM6OzrTUVBdKR/hCp6OR3R2751odueFoposm69H7XAj9K
	 RD6i4peSxwqffTswmTtIGkiV+4LKuDy4XriHKU7lqZ+7AKXlG0mEpLrcR908qdK4uo
	 M6A55zOpjr50gyZPvKHra5/tNlZAXcm6JqjbQOPgOIMQVxJnTF1Db4TOV5sp48ZXaq
	 de/A2kTsqqemA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 27/33] sched/arm64: Move fallback task cpumask to HK_TYPE_DOMAIN
Date: Fri, 29 Aug 2025 17:48:08 +0200
Message-ID: <20250829154814.47015-28-frederic@kernel.org>
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

When none of the allowed CPUs of a task are online, it gets migrated
to the fallback cpumask which is all the non nohz_full CPUs.

However just like nohz_full CPUs, domain isolated CPUs don't want to be
disturbed by tasks that have lost their CPU affinities.

And since nohz_full rely on domain isolation to work correctly, the
housekeeping mask of domain isolated CPUs is always a subset of the
housekeeping mask of nohz_full CPUs (there can be CPUs that are domain
isolated but not nohz_full, OTOH there can't be nohz_full CPUs that are
not domain isolated):

	HK_TYPE_DOMAIN & HK_TYPE_KERNEL_NOISE == HK_TYPE_DOMAIN

Therefore use HK_TYPE_DOMAIN as the appropriate fallback target for
tasks and since this cpumask can be modified at runtime, make sure
that 32 bits support CPUs on ARM64 mismatched systems are not isolated
by cpusets.

CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 18 ++++++++++++---
 include/linux/cpu.h            |  4 ++++
 kernel/cgroup/cpuset.c         | 40 +++++++++++++++++++++++-----------
 3 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9ad065f15f1d..38046489d2ea 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1653,6 +1653,18 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 	return feature_matches(val, entry);
 }
 
+/*
+ * 32 bits support CPUs can't be isolated because tasks may be
+ * arbitrarily affine to them, defeating the purpose of isolation.
+ */
+bool arch_isolated_cpus_can_update(struct cpumask *new_cpus)
+{
+	if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
+		return !cpumask_intersects(cpu_32bit_el0_mask, new_cpus);
+	else
+		return true;
+}
+
 const struct cpumask *system_32bit_el0_cpumask(void)
 {
 	if (!system_supports_32bit_el0())
@@ -1666,7 +1678,7 @@ const struct cpumask *system_32bit_el0_cpumask(void)
 
 const struct cpumask *task_cpu_fallback_mask(struct task_struct *p)
 {
-	return __task_cpu_possible_mask(p, housekeeping_cpumask(HK_TYPE_TICK));
+	return __task_cpu_possible_mask(p, housekeeping_cpumask(HK_TYPE_DOMAIN));
 }
 
 static int __init parse_32bit_el0_param(char *str)
@@ -3963,8 +3975,8 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 	bool cpu_32bit = false;
 
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
-		if (!housekeeping_cpu(cpu, HK_TYPE_TICK))
-			pr_info("Treating adaptive-ticks CPU %u as 64-bit only\n", cpu);
+		if (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN))
+			pr_info("Treating domain isolated CPU %u as 64-bit only\n", cpu);
 		else
 			cpu_32bit = true;
 	}
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index b91b993f58ee..8bb239080534 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -228,4 +228,8 @@ static inline bool cpu_attack_vector_mitigated(enum cpu_attack_vectors v)
 #define smt_mitigations SMT_MITIGATIONS_OFF
 #endif
 
+struct cpumask;
+
+bool arch_isolated_cpus_can_update(struct cpumask *new_cpus);
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8260dd699fd8..cf99ea844c1d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1352,33 +1352,47 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return isolcpus_updated;
 }
 
+bool __weak arch_isolated_cpus_can_update(struct cpumask *new_cpus)
+{
+	return true;
+}
+
 /*
- * isolcpus_nohz_conflict - check for isolated & nohz_full conflicts
+ * isolated_cpus_can_update - check for conflicts against housekeeping and
+ *                            CPUs capabilities.
  * @new_cpus: cpu mask for cpus that are going to be isolated
- * Return: true if there is conflict, false otherwise
+ * Return: true if there no conflict, false otherwise
  *
- * If nohz_full is enabled and we have isolated CPUs, their combination must
- * still leave housekeeping CPUs.
+ * Check for conflicts:
+ * - If nohz_full is enabled and there are isolated CPUs, their combination must
+ *   still leave housekeeping CPUs.
+ * - Architecture has CPU capabilities incompatible with being isolated
  */
-static bool isolcpus_nohz_conflict(struct cpumask *new_cpus)
+static bool isolated_cpus_can_update(struct cpumask *new_cpus)
 {
 	cpumask_var_t full_hk_cpus;
-	int res = false;
+	bool res;
+
+	if (!arch_isolated_cpus_can_update(new_cpus))
+		return false;
 
 	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
-		return false;
+		return true;
 
 	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
-		return true;
+		return false;
+
+	res = true;
 
 	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
 		    housekeeping_cpumask(HK_TYPE_DOMAIN));
 	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
 	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);
 	if (!cpumask_weight_andnot(full_hk_cpus, new_cpus))
-		res = true;
+		res = false;
 
 	free_cpumask_var(full_hk_cpus);
+
 	return res;
 }
 
@@ -1497,7 +1511,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return PERR_INVCPUS;
 	if (isolated_cpus_should_update(new_prs, NULL) &&
-	    isolcpus_nohz_conflict(tmp->new_cpus))
+	    !isolated_cpus_can_update(tmp->new_cpus))
 		return PERR_HKEEPING;
 
 	spin_lock_irq(&callback_lock);
@@ -1599,7 +1613,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
 			cs->prs_err = PERR_NOCPUS;
 		else if (isolated_cpus_should_update(prs, NULL) &&
-			 isolcpus_nohz_conflict(tmp->addmask))
+			 !isolated_cpus_can_update(tmp->addmask))
 			cs->prs_err = PERR_HKEEPING;
 		if (cs->prs_err)
 			goto invalidate;
@@ -1954,7 +1968,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	}
 
 	if (deleting && isolated_cpus_should_update(new_prs, parent) &&
-	    isolcpus_nohz_conflict(tmp->delmask)) {
+	    !isolated_cpus_can_update(tmp->delmask)) {
 		cs->prs_err = PERR_HKEEPING;
 		return PERR_HKEEPING;
 	}
@@ -2979,7 +2993,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * Need to update isolated_cpus.
 		 */
 		isolcpus_updated = true;
-		if (isolcpus_nohz_conflict(cs->effective_xcpus))
+		if (!isolated_cpus_can_update(cs->effective_xcpus))
 			err = PERR_HKEEPING;
 	} else {
 		/*
-- 
2.51.0


