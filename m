Return-Path: <linux-kernel+bounces-835268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C564DBA69F7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D033BB499
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE8B29D270;
	Sun, 28 Sep 2025 07:29:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630254918
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044540; cv=none; b=iy/n/lIpYOZorJuBPCDVDGT2NnN4feZWUhMI6ZvXcA0i7x2+g+vWakeyNscjz7pKq3JFl/IzF69G4jsUR5EPOUaAeoImuT2+wVlBAL1HgYmii+CWhsjSwewjBdRcbS1HRQt0mDsGxGW2c/6DwjWKYqPjhOjn4hJnROx3gzfaXQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044540; c=relaxed/simple;
	bh=CxGfb5aoco/r2OsuXIST3DwEQqsexsoB3qpLfdr0Zac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sgsicx5RJR/6xLAU6ZseQcCZXEePL/uHnvPceNURAStECNl6FofZmPHh1IxtMZjlHNDWSA0bqUo4AIjDG0mN3542mcL/aMHxeeyJzF+BB1jq01YBpCPACAqJrZudbwblJmiPxp27837CDjYMwmNFdxdzXhbXnfIKQCPw4J0PP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCG4F9dzKHNHG;
	Sun, 28 Sep 2025 15:28:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CDE941A1488;
	Sun, 28 Sep 2025 15:28:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S7;
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
Subject: [PATCH -next RFC 05/16] cpuset: factor out partition_update() function
Date: Sun, 28 Sep 2025 07:12:55 +0000
Message-Id: <20250928071306.3797436-6-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S7
X-Coremail-Antispam: 1UD129KBjvJXoWxtryfZF1rXw4kZFyUtrWDArb_yoW7Xr1rpF
	yUCr4IqayUtr13u3sxtan2kws5Kw4ktF9FywnrX34rJFy3Ga4vya4jya98XFy5W34DWry5
	ZFZ0qr42qF17CwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Extract the core partition update logic into a dedicated partition_update()
function. This refactoring centralizes updates to key cpuset data
structures including remote_sibling, effective_xcpus, partition_root_state,
and prs_err.

The function handles the complete partition update workflow:
- Adding and removing exclusive CPUs via partition_xcpus_add()/del()
- Managing remote sibling relationships
- Synchronizing effective exclusive CPUs mask
- Updating partition state and error status
- Triggering required system updates and workqueue synchronization

This creates a coherent interface for partition operations and establishes
a foundation for enhanced partition management while maintaining existing
remote partition behavior.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 71 ++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1944410ae872..0e2f95daf459 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1587,6 +1587,49 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
 	cpuset_force_rebuild();
 }
 
+/**
+ * partition_update - Update an existing partition configuration
+ * @cs: The cpuset to update
+ * @prs: Partition root state (must be positive)
+ * @xcpus: New exclusive CPUs mask for the partition (NULL to keep current)
+ * @excpus: New effective exclusive CPUs mask
+ * @tmp: Temporary masks
+ *
+ * Updates partition-related fields. The tmp->addmask is the CPU mask that
+ * will be added to the subpartitions_cpus and removed from parent's
+ * effective_cpus, and the tmp->delmask vice versa.
+ */
+static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
+				  struct cpumask *excpus, struct tmpmasks *tmp)
+{
+	bool isolcpus_updated;
+	bool excl_updated;
+	struct cpuset *parent;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(!cpuset_v2());
+	WARN_ON_ONCE(prs <= 0);
+
+	parent = is_remote_partition(cs) ? NULL : parent_cs(cs);
+	excl_updated = !cpumask_empty(tmp->addmask) ||
+			!cpumask_empty(tmp->delmask);
+
+	spin_lock_irq(&callback_lock);
+	isolcpus_updated = partition_xcpus_add(prs, parent, tmp->addmask);
+	isolcpus_updated |= partition_xcpus_del(prs, parent, tmp->delmask);
+	/*
+	 * Need to update effective_xcpus and exclusive_cpus now as
+	 * update_sibling_cpumasks() below may iterate back to the same cs.
+	 */
+	cpumask_copy(cs->effective_xcpus, excpus);
+	if (xcpus)
+		cpumask_copy(cs->exclusive_cpus, xcpus);
+	spin_unlock_irq(&callback_lock);
+	update_unbound_workqueue_cpumask(isolcpus_updated);
+	if (excl_updated)
+		cpuset_force_rebuild();
+}
+
 /*
  * remote_partition_enable - Enable current cpuset as a remote partition root
  * @cs: the cpuset to update
@@ -1669,10 +1712,6 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 			       struct cpumask *excpus, struct tmpmasks *tmp)
 {
-	bool adding, deleting;
-	int prs = cs->partition_root_state;
-	int isolcpus_updated = 0;
-
 	if (WARN_ON_ONCE(!is_remote_partition(cs)))
 		return;
 
@@ -1683,15 +1722,15 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 		goto invalidate;
 	}
 
-	adding   = cpumask_andnot(tmp->addmask, excpus, cs->effective_xcpus);
-	deleting = cpumask_andnot(tmp->delmask, cs->effective_xcpus, excpus);
+	cpumask_andnot(tmp->addmask, excpus, cs->effective_xcpus);
+	cpumask_andnot(tmp->delmask, cs->effective_xcpus, excpus);
 
 	/*
 	 * Additions of remote CPUs is only allowed if those CPUs are
 	 * not allocated to other partitions and there are effective_cpus
 	 * left in the top cpuset.
 	 */
-	if (adding) {
+	if (!cpumask_empty(tmp->addmask)) {
 		WARN_ON_ONCE(cpumask_intersects(tmp->addmask, subpartitions_cpus));
 		if (!capable(CAP_SYS_ADMIN))
 			cs->prs_err = PERR_ACCESS;
@@ -1702,23 +1741,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 			goto invalidate;
 	}
 
-	spin_lock_irq(&callback_lock);
-	if (adding)
-		isolcpus_updated += partition_xcpus_add(prs, NULL, tmp->addmask);
-	if (deleting)
-		isolcpus_updated += partition_xcpus_del(prs, NULL, tmp->delmask);
-	/*
-	 * Need to update effective_xcpus and exclusive_cpus now as
-	 * update_sibling_cpumasks() below may iterate back to the same cs.
-	 */
-	cpumask_copy(cs->effective_xcpus, excpus);
-	if (xcpus)
-		cpumask_copy(cs->exclusive_cpus, xcpus);
-	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
-	if (adding || deleting)
-		cpuset_force_rebuild();
-
+	partition_update(cs, cs->partition_root_state, xcpus, excpus, tmp);
 	/*
 	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
 	 */
-- 
2.34.1


