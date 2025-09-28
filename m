Return-Path: <linux-kernel+bounces-835281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186DBA6A1E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13230189CE67
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A6B2C11C8;
	Sun, 28 Sep 2025 07:29:09 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6552C0290
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044548; cv=none; b=ur0EZQfLnptGsl2wIieO+zUKtCxPqbu2MLrLlYvhquCC6O06d5GF7jO7ypKfvQIfzlk9276g390IiLtf7Rb6XxanmPWyBh1kzkk+WpXvQpOxi6agznctTnShPv5UJ+MH4+wrBdUQ/HcYau/cqbqAvKHVtQrU8pO+QoH713Rf61s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044548; c=relaxed/simple;
	bh=m7+wQpMl4dpOGgdg8LlUvDJq4UWL+pBw91BUjBbG7eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QffuAdDCPT4S7MHrfkhrkazKUyJXATs+CEWeuVWuH8DxE9n/fgFoyQAcx49IKxNHuF5m6wLJwn3cC0TDbfnhZmRFdpXTQF1AYhZe+OLOPlIVfgfp/2Mv9GmFDpHhpLcoheWGljTnqb/g7KZ8uQ5scWZ0ZNUlDM2nfQj5bOENCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCF1tghzYQvfb;
	Sun, 28 Sep 2025 15:28:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 283E31A0D72;
	Sun, 28 Sep 2025 15:28:55 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S13;
	Sun, 28 Sep 2025 15:28:55 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next RFC 11/16] cpuset: simplify partition update logic for hotplug tasks
Date: Sun, 28 Sep 2025 07:13:01 +0000
Message-Id: <20250928071306.3797436-12-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250928071306.3797436-1-chenridong@huaweicloud.com>
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S13
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr48GFW7GFWruw4fCFWDXFb_yoW7ArW7pF
	y3CrW7tayUGr15u3sxJFs7Z3yrGws7JFyqy3ZxJ34rJF12ya4vyFyjk395ZayYqryDXry7
	Zayqgr4xJF17CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Simplify the partition update logic in cpuset_hotplug_update_tasks() by
calling the unified local_partition_update() interface.

For local partitions, the previous patch introduced local_partition_update
which handles both validation state transitions:
- Invalidates local partitions that fail validation checks
- Transitions invalid partitions to valid state when no errors are detected

This eliminates the need for separate transition logic
in cpuset_hotplug_update_tasks(), which can now simply call
local_partition_update() to handle all local partition changes.

This patch simplifies the logic by always proceeding to update_tasks for
remote partitions, regardless of whether they were disabled or not. Since
the original code didn't perform any meaningful operations for non-disabled
remote partitions, this change should not affect functionality.

The partition_cmd mechanism can now be safely removed as it is no longer
referenced by any code paths after the partition update logic
simplification.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 67 ++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 41 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9e98df542715..a1896a199c8b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1211,17 +1211,6 @@ static void compute_effective_cpumask(struct cpumask *new_cpus,
 	cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
 }
 
-/*
- * Commands for update_parent_effective_cpumask
- */
-enum partition_cmd {
-	partcmd_enable,		/* Enable partition root	  */
-	partcmd_enablei,	/* Enable isolated partition root */
-	partcmd_disable,	/* Disable partition root	  */
-	partcmd_update,		/* Update parent's effective_cpus */
-	partcmd_invalidate,	/* Make partition invalid	  */
-};
-
 static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 				    struct tmpmasks *tmp);
 
@@ -2062,6 +2051,9 @@ static int __local_partition_update(struct cpuset *cs, struct cpumask *xcpus,
 		update_partition_sd_lb(cs, old_prs);
 		return part_error;
 	}
+	/* Nothing changes, return PERR_NONE */
+	if (new_prs == old_prs && cpumask_equal(excpus, cs->effective_xcpus))
+		return PERR_NONE;
 
 	cpumask_updated = cpumask_andnot(tmp->addmask, excpus, cs->effective_xcpus);
 	cpumask_updated |= cpumask_andnot(tmp->delmask, cs->effective_xcpus, excpus);
@@ -3868,8 +3860,6 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	static nodemask_t new_mems;
 	bool cpus_updated;
 	bool mems_updated;
-	bool remote;
-	int partcmd = -1;
 	struct cpuset *parent;
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
@@ -3896,16 +3886,15 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * Compute effective_cpus for valid partition root, may invalidate
 	 * child partition roots if necessary.
 	 */
-	remote = is_remote_partition(cs);
-	if (remote || (is_partition_valid(cs) && is_partition_valid(parent)))
+	if (is_remote_partition(cs)) {
 		compute_partition_effective_cpumask(cs, &new_cpus);
-
-	if (remote && cpumask_empty(&new_cpus) &&
-	    partition_is_populated(cs, NULL)) {
-		cs->prs_err = PERR_HOTPLUG;
-		remote_partition_disable(cs, tmp);
-		compute_effective_cpumask(&new_cpus, cs, parent);
-		remote = false;
+		if (cpumask_empty(&new_cpus) &&
+		    partition_is_populated(cs, NULL)) {
+			cs->prs_err = PERR_HOTPLUG;
+			remote_partition_disable(cs, tmp);
+			compute_effective_cpumask(&new_cpus, cs, parent);
+		}
+		goto update_tasks;
 	}
 
 	/*
@@ -3913,28 +3902,24 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * the following conditions hold:
 	 * 1) empty effective cpus but not valid empty partition.
 	 * 2) parent is invalid or doesn't grant any cpus to child
-	 *    partitions.
-	 */
-	if (is_local_partition(cs) && (!is_partition_valid(parent) ||
-				tasks_nocpu_error(parent, cs, &new_cpus))) {
-		partcmd = partcmd_invalidate;
-		local_partition_invalidate(cs, tmp);
-	}
-	/*
+	 *  partitions.
+	 *
 	 * On the other hand, an invalid partition root may be transitioned
 	 * back to a regular one with a non-empty user xcpus.
+	 *
+	 * local_partition_update can handle these cases.
 	 */
-	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
-		 !cpumask_empty(user_xcpus(cs))) {
-		partcmd = partcmd_update;
-		local_partition_update(cs, tmp);
-	}
-	if (partcmd >= 0) {
-		if ((partcmd == partcmd_invalidate) || is_partition_valid(cs)) {
-			compute_partition_effective_cpumask(cs, &new_cpus);
-			cpuset_force_rebuild();
-		}
-	}
+	local_partition_update(cs, tmp);
+
+	/*
+	 * Recompute effective CPU mask after partition state update:
+	 * - For valid partitions: calculate partition-specific effective CPUs
+	 * - For invalid partitions: compute member effective CPU mask
+	 */
+	if (is_partition_valid(cs))
+		compute_partition_effective_cpumask(cs, &new_cpus);
+	else
+		compute_effective_cpumask(&new_cpus, cs, parent);
 
 update_tasks:
 	cpus_updated = !cpumask_equal(&new_cpus, cs->effective_cpus);
-- 
2.34.1


