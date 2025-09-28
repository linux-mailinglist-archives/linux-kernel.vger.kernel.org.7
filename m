Return-Path: <linux-kernel+bounces-835277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE69BA6A12
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DA817BCF2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A972D2BF009;
	Sun, 28 Sep 2025 07:29:05 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA82BE62C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044545; cv=none; b=ZnjXm9nkzI26GdKE33X0o7cyJ2BSpGIa66gry+0fEUL2XTaRihSUDUFpDnuucKtipJBb5rwJxtqwbh86UFn6K53+xtnabWhqRoNVqtT+1v0CXdIHWOvWP2+9ZLSBMRgGQRoWB3LWkCOMbTytGUofmWo0N+1hMVUVTdyhTr0KPZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044545; c=relaxed/simple;
	bh=y+/W8vdbErT6Gts1FZ5Hg4C5dqqAVkYABYrsAxjr7nY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m77ifuN87ISffRAlciybM2t+jmIvl92zh2h1k6jOLfj6nqr9auczQNmeotpfKkEj/MahZ6MGC2rmuZLl+9q/T6sWUVsPQwDKIFIeKvNrEohVYwzaarq2J/FDv6bp77ojccIZjXjsHlEQZO+7grZ20jIGMSBfFm+T5s1n/QBw0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCF0KBzzYQvfN;
	Sun, 28 Sep 2025 15:28:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E728B1A0C83;
	Sun, 28 Sep 2025 15:28:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S9;
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
Subject: [PATCH -next RFC 07/16] cpuset: introduce local_partition_disable()
Date: Sun, 28 Sep 2025 07:12:57 +0000
Message-Id: <20250928071306.3797436-8-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1xXw1fWr4DWryxWFyUZFb_yoWrurWfpF
	yUGrW7KayjqFy3ua47Jan7Aw4rKws7JayxtwnxW34rJFy7J3WvvFy0ya95Z3W8WryDGry7
	ZFZ0qr4UWF17ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The partition_disable() function introduced earlier can be extended to
handle local partition disablement.

First, partition_disable() was enhanced to support local partitions by
properly managing the parent's nr_subparts counter and integrating
notification operations.

Then, local_partition_disable() is introduced, which extracts the local
partition disable logic from update_parent_effective_cpumask(). It calls
partition_disable() to complete the disablement process.

This refactoring establishes a clear separation between local and remote
partition operations while promoting code reuse through the shared
partition_disable() infrastructure.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 60 ++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 154992cdfe9a..87ba43e93540 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1576,13 +1576,20 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
 				    int new_prs, enum prs_errcode prs_err)
 {
 	bool isolcpus_updated;
+	int old_prs;
 
 	lockdep_assert_held(&cpuset_mutex);
 	WARN_ON_ONCE(new_prs > 0);
 	WARN_ON_ONCE(!cpuset_v2());
 
+	old_prs = cs->partition_root_state;
 	spin_lock_irq(&callback_lock);
 	list_del_init(&cs->remote_sibling);
+	if (parent && is_partition_valid(parent) &&
+	    is_partition_valid(cs)) {
+		parent->nr_subparts -= 1;
+		WARN_ON_ONCE(parent->nr_subparts < 0);
+	}
 	/* disable a partition should only delete exclusive cpus */
 	isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
 						parent, cs->effective_xcpus);
@@ -1592,6 +1599,9 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 	cpuset_force_rebuild();
+	/* Clear exclusive flag; no errors are expected */
+	update_partition_exclusive_flag(cs, new_prs);
+	notify_partition_change(cs, old_prs);
 }
 
 /**
@@ -1870,6 +1880,37 @@ static int local_partition_enable(struct cpuset *cs,
 	return 0;
 }
 
+/**
+ * local_partition_disable - Disable a local partition
+ * @cs: Target cpuset (local partition root) to disable
+ * @tmp: Temporary masks for CPU calculations
+ */
+static void local_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
+{
+	struct cpuset *parent = parent_cs(cs);
+	bool cpumask_updated = false;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
+
+	if (!is_partition_valid(cs))
+		return;
+
+	/*
+	 * May need to add cpus back to parent's effective_cpus
+	 * (and maybe removed from subpartitions_cpus/isolated_cpus)
+	 * for valid partition root. xcpus may contain CPUs that
+	 * shouldn't be removed from the two global cpumasks.
+	 */
+	cpumask_updated = !cpumask_empty(cs->effective_xcpus);
+	partition_disable(cs, parent, PRS_MEMBER, PERR_NONE);
+
+	if (cpumask_updated) {
+		cpuset_update_tasks_cpumask(parent, tmp->addmask);
+		update_sibling_cpumasks(parent, cs, tmp);
+	}
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1962,20 +2003,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 	nocpu = tasks_nocpu_error(parent, cs, xcpus);
 
-	if (cmd == partcmd_disable) {
-		/*
-		 * May need to add cpus back to parent's effective_cpus
-		 * (and maybe removed from subpartitions_cpus/isolated_cpus)
-		 * for valid partition root. xcpus may contain CPUs that
-		 * shouldn't be removed from the two global cpumasks.
-		 */
-		if (is_partition_valid(cs)) {
-			cpumask_copy(tmp->addmask, cs->effective_xcpus);
-			adding = true;
-			subparts_delta--;
-		}
-		new_prs = PRS_MEMBER;
-	} else if (newmask) {
+	if (newmask) {
 		/*
 		 * Empty cpumask is not allowed
 		 */
@@ -3104,9 +3132,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		if (is_remote_partition(cs))
 			remote_partition_disable(cs, &tmpmask);
 		else
-			update_parent_effective_cpumask(cs, partcmd_disable,
-							NULL, &tmpmask);
-
+			local_partition_disable(cs, &tmpmask);
 		/*
 		 * Invalidation of child partitions will be done in
 		 * update_cpumasks_hier().
-- 
2.34.1


