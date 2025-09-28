Return-Path: <linux-kernel+bounces-835275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01734BA6A0C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0140317B7EC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C632BEFEA;
	Sun, 28 Sep 2025 07:29:05 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C12BE636
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044544; cv=none; b=FXCeAPtKnf4cdZNqnGSaRBzuTa1FFaKCRUr0Xt2IglReALZryZHvRogka6USukfOAa9TxvoB19BYTIRmMr677Z8+JH+EgzMVjGsku92/q6hgA9aHKVrntZnHZTXveHJoFt5T1drLSGiIufuzbw6oO3V2Hpr1Atvd+c9SZN2+9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044544; c=relaxed/simple;
	bh=n07w+BAygcFwNSAZpd/xFKzdgXtBLBNGeVdkBIR1ZDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KXG3BLOgHNKsfKSRbHGKau5+iK/wyDQPd8mOJkVVlxNFHiRKK6HDTqOEi/347JnTNuWe3a0ECoPpfvUlUK/rD3yVKwN/WcSM8R34aQfZErLVaeB3bD/n9JwJaUEQHYCY5Lr7WXODBEz4dh4QE+dfsqG8quNeAKbAk+EmQteXXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCD61DRzYQvfC;
	Sun, 28 Sep 2025 15:28:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B3E411A0C76;
	Sun, 28 Sep 2025 15:28:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S5;
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
Subject: [PATCH -next RFC 03/16] cpuset: factor out partition_enable() function
Date: Sun, 28 Sep 2025 07:12:53 +0000
Message-Id: <20250928071306.3797436-4-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGFykKw1ktFWruF13ZFyfCrg_yoWrGFWUpF
	y5Cr4xtayUtry3C39xJFs7uwsYgws7tF12ywnxW34fXa43J3Wqka4jk390q3WYgryDGry5
	Zan0qF4xWF17CwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwhFxUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Extract the core partition enablement logic into a dedicated
partition_enable() function. This refactoring centralizes updates to key
cpuset data structures including remote_sibling, effective_xcpus,
partition_root_state, and prs_err.

The function handles the complete partition enablement workflow:
- Adding exclusive CPUs via partition_xcpus_add()
- Managing remote sibling relationships
- Synchronizing effective exclusive CPUs mask
- Updating partition state and error status
- Triggering required scheduler domain rebuilds

This creates a coherent interface for partition operations and establishes
a foundation for future local partition support while maintaining existing
remote partition behavior.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 55 +++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0787904321a9..43ce62f4959c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1515,6 +1515,49 @@ static inline bool is_local_partition(struct cpuset *cs)
 	return is_partition_valid(cs) && !is_remote_partition(cs);
 }
 
+static void partition_state_update(struct cpuset *cs, int new_prs,
+					  enum prs_errcode prs_err)
+{
+	lockdep_assert_held(&callback_lock);
+
+	cs->partition_root_state = new_prs;
+	WRITE_ONCE(cs->prs_err, prs_err);
+	if (!is_partition_valid(cs))
+		reset_partition_data(cs);
+}
+
+/**
+ * partition_enable - Transitions a cpuset to a partition root
+ * @cs: The cpuset to enable partition for
+ * @parent: Parent cpuset of @cs, NULL for remote parent
+ * @new_prs: New partition root state to set
+ * @new_excpus: New exclusive CPUs mask for the partition
+ *
+ * Transitions a cpuset to a partition root, only for v2.
+ */
+static void partition_enable(struct cpuset *cs, struct cpuset *parent,
+				 int new_prs, struct cpumask *new_excpus)
+{
+	bool isolcpus_updated;
+
+	lockdep_assert_held(&cpuset_mutex);
+	WARN_ON_ONCE(new_prs <= 0);
+	WARN_ON_ONCE(!cpuset_v2());
+
+	if (cs->partition_root_state == new_prs)
+		return;
+
+	spin_lock_irq(&callback_lock);
+	/* enable partition should only add exclusive cpus */
+	isolcpus_updated = partition_xcpus_add(new_prs, parent, new_excpus);
+	list_add(&cs->remote_sibling, &remote_children);
+	cpumask_copy(cs->effective_xcpus, new_excpus);
+	partition_state_update(cs, new_prs, PERR_NONE);
+	spin_unlock_irq(&callback_lock);
+	update_unbound_workqueue_cpumask(isolcpus_updated);
+	cpuset_force_rebuild();
+}
+
 /*
  * remote_partition_enable - Enable current cpuset as a remote partition root
  * @cs: the cpuset to update
@@ -1528,8 +1571,6 @@ static inline bool is_local_partition(struct cpuset *cs)
 static int remote_partition_enable(struct cpuset *cs, int new_prs,
 				   struct tmpmasks *tmp)
 {
-	bool isolcpus_updated;
-
 	/*
 	 * The user must have sysadmin privilege.
 	 */
@@ -1552,15 +1593,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return PERR_INVCPUS;
 
-	spin_lock_irq(&callback_lock);
-	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
-	list_add(&cs->remote_sibling, &remote_children);
-	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
-	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
-	cpuset_force_rebuild();
-	cs->prs_err = 0;
-
+	partition_enable(cs, NULL, new_prs, tmp->new_cpus);
 	/*
 	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
 	 */
-- 
2.34.1


