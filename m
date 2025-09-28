Return-Path: <linux-kernel+bounces-835269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6961EBA69FA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D7617A5FC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CE829D297;
	Sun, 28 Sep 2025 07:29:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864812343C0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044540; cv=none; b=GMpap7OpQLCICbcm2ofNTiyzeHqcwfurOUOU7S2w5OkwtOUR2EedJr/05TIx0vmbJqSdOtVx9H2YkmIByH0mtDAeakMIITOPymqn2G7go6IMsTMBSdAexl5YBZr/5V/Q9reXTuC6xrPdlQ9bk8qzJGydjER2rl5JOdUxALsDyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044540; c=relaxed/simple;
	bh=JiFxHyxl7+klQ0+MY99lkKT7c6mupzGqEByVIe28XOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IX1OVbwyFMYJ4yUdpeJqBXxKzEG/bGKRnP+cJVYTaKHnh7HtPNX0jWjUMfGQJR9ahWtNA6aiemptiNJaF04JBPy1OlbYNpnzn7CyYBWlm4rEcRGtBiJowsv0KD0pEavqmxzwlgS+6Rs+R67w1oDZfripxjRW5rTsOtoELpN3V0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCG4TxfzKHNHK;
	Sun, 28 Sep 2025 15:28:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D86391A171D;
	Sun, 28 Sep 2025 15:28:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S8;
	Sun, 28 Sep 2025 15:28:54 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next RFC 06/16] cpuset: introduce local_partition_enable()
Date: Sun, 28 Sep 2025 07:12:56 +0000
Message-Id: <20250928071306.3797436-7-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250928071306.3797436-1-chenridong@huaweicloud.com>
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S8
X-Coremail-Antispam: 1UD129KBjvJXoW3XFy7ArW3XrWrJr1fArWkWFg_yoWxWw4rpF
	yUGrsrtFWUtryrC39xJan7Cw4rKw4ktFW2ywnxX34rXFy7Aw1vyFy0y390qFyjgrWDZry5
	Za9Fqr4xWFy7ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The partition_enable() function introduced in the previous patch can be
reused to enable local partitions.

First, partition_enable() was enhanced to support local partition enabling
by properly handling parent's nr_subparts counter and adding notification
operations.

Then, the local_partition_enable() function is introduced, which factors
out the local partition enablement logic from
update_parent_effective_cpumask(). After passing local partition validation
checks, it delegates to partition_enable() to complete the partition setup.

This refactoring creates a clear separation between local and remote
partition operations while maintaining code reuse through the shared
partition_enable() infrastructure.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 111 +++++++++++++++++++++++++++--------------
 1 file changed, 74 insertions(+), 37 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0e2f95daf459..154992cdfe9a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1539,6 +1539,7 @@ static void partition_enable(struct cpuset *cs, struct cpuset *parent,
 				 int new_prs, struct cpumask *new_excpus)
 {
 	bool isolcpus_updated;
+	int old_prs;
 
 	lockdep_assert_held(&cpuset_mutex);
 	WARN_ON_ONCE(new_prs <= 0);
@@ -1547,15 +1548,21 @@ static void partition_enable(struct cpuset *cs, struct cpuset *parent,
 	if (cs->partition_root_state == new_prs)
 		return;
 
+	old_prs = cs->partition_root_state;
 	spin_lock_irq(&callback_lock);
 	/* enable partition should only add exclusive cpus */
 	isolcpus_updated = partition_xcpus_add(new_prs, parent, new_excpus);
-	list_add(&cs->remote_sibling, &remote_children);
+	/* enable remote partition */
+	if (!parent)
+		list_add(&cs->remote_sibling, &remote_children);
+	else if (!is_partition_valid(cs))
+		parent->nr_subparts += 1;
 	cpumask_copy(cs->effective_xcpus, new_excpus);
 	partition_state_update(cs, new_prs, PERR_NONE);
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 	cpuset_force_rebuild();
+	notify_partition_change(cs, old_prs);
 }
 
 /**
@@ -1801,6 +1808,68 @@ static enum prs_errcode validate_partition(struct cpuset *cs, int new_prs,
 	return PERR_NONE;
 }
 
+/**
+ * local_partition_enable - Enable local partition for a cpuset
+ * @cs: Target cpuset to become a local partition root
+ * @new_prs: New partition root state to apply
+ * @tmp: Temporary masks for CPU calculations
+ *
+ * This function enables local partition root capability for a cpuset by
+ * validating prerequisites, computing exclusive CPUs, and updating the
+ * partition hierarchy.
+ *
+ * Return: 0 on success, error code on failure
+ */
+static int local_partition_enable(struct cpuset *cs,
+				int new_prs, struct tmpmasks *tmp)
+{
+	struct cpuset *parent = parent_cs(cs);
+	enum prs_errcode part_error;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
+
+	/*
+	 * The parent must be a partition root.
+	 * The new cpumask, if present, or the current cpus_allowed must
+	 * not be empty.
+	 */
+	if (!is_partition_valid(parent)) {
+		return is_partition_invalid(parent)
+			? PERR_INVPARENT : PERR_NOTPART;
+	}
+
+	/*
+	 * Need to call compute_excpus() in case
+	 * exclusive_cpus not set. Sibling conflict should only happen
+	 * if exclusive_cpus isn't set.
+	 */
+	if (compute_excpus(cs, tmp->new_cpus))
+		WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
+
+	part_error = validate_partition(cs, new_prs, tmp->new_cpus);
+	if (part_error)
+		return part_error;
+
+	/*
+	 * This function will only be called when all the preliminary
+	 * checks have passed. At this point, the following condition
+	 * should hold.
+	 *
+	 * (cs->effective_xcpus & cpu_active_mask) ⊆ parent->effective_cpus
+	 *
+	 * Warn if it is not the case.
+	 * addmask is used as temporary variable.
+	 */
+	cpumask_and(tmp->addmask, tmp->new_cpus, cpu_active_mask);
+	WARN_ON_ONCE(!cpumask_subset(tmp->addmask, parent->effective_cpus));
+	partition_enable(cs, parent, new_prs, tmp->new_cpus);
+
+	cpuset_update_tasks_cpumask(parent, tmp->addmask);
+	update_sibling_cpumasks(parent, cs, tmp);
+	return 0;
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1893,35 +1962,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 	nocpu = tasks_nocpu_error(parent, cs, xcpus);
 
-	if ((cmd == partcmd_enable) || (cmd == partcmd_enablei)) {
-		/*
-		 * Need to call compute_excpus() in case
-		 * exclusive_cpus not set. Sibling conflict should only happen
-		 * if exclusive_cpus isn't set.
-		 */
-		xcpus = tmp->delmask;
-		if (compute_excpus(cs, xcpus))
-			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
-		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
-
-		part_error = validate_partition(cs, new_prs, xcpus);
-		if (part_error)
-			return part_error;
-		/*
-		 * This function will only be called when all the preliminary
-		 * checks have passed. At this point, the following condition
-		 * should hold.
-		 *
-		 * (cs->effective_xcpus & cpu_active_mask) ⊆ parent->effective_cpus
-		 *
-		 * Warn if it is not the case.
-		 */
-		cpumask_and(tmp->new_cpus, xcpus, cpu_active_mask);
-		WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, parent->effective_cpus));
-
-		deleting = true;
-		subparts_delta++;
-	} else if (cmd == partcmd_disable) {
+	if (cmd == partcmd_disable) {
 		/*
 		 * May need to add cpus back to parent's effective_cpus
 		 * (and maybe removed from subpartitions_cpus/isolated_cpus)
@@ -3045,14 +3086,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * If parent is valid partition, enable local partiion.
 		 * Otherwise, enable a remote partition.
 		 */
-		if (is_partition_valid(parent)) {
-			enum partition_cmd cmd = (new_prs == PRS_ROOT)
-					       ? partcmd_enable : partcmd_enablei;
-
-			err = update_parent_effective_cpumask(cs, cmd, NULL, &tmpmask);
-		} else {
+		if (is_partition_valid(parent))
+			err = local_partition_enable(cs, new_prs, &tmpmask);
+		else
 			err = remote_partition_enable(cs, new_prs, &tmpmask);
-		}
 	} else if (old_prs && new_prs) {
 		/*
 		 * A change in load balance state only, no change in cpumasks.
-- 
2.34.1


