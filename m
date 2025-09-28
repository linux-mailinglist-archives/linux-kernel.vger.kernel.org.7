Return-Path: <linux-kernel+bounces-835273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FC1BA6A06
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3116E3BC01F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F62B2BE7C0;
	Sun, 28 Sep 2025 07:29:04 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3F2BDC2C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044543; cv=none; b=jRTsGuw+LCCtc4bbAeqUHGlByn6taLJybdU+n3sCS1fGQU8K/fICMD66wfzW1EKATkVa1Z9GOlzEHVrau9iaS0aHQTdVAzApvK+K9cW9TA+rLkRA8nIUtzLkbReRyC2IyMqvTxCKGlKlMCoT0ks2kBQQZhnm+XtAcuqnlnzJmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044543; c=relaxed/simple;
	bh=mp9ZaWIp0DrgDNjG05KPRnT8NRsqy6SG1i2t2oJIN1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y00Ha4bHwASrVoW6hheScICPr+fFDbJlEnvAK0UeCivwOOTUIaXfy2D8Y317xRPTxpic60/z21CNqW258+GQC6HmwOGzU0CDHUhpVsOSQb0xjBNkIxgZWs0wjhhwscAacwSjArjLrF6gQS5hrTse/5uBAk83W/it9gX/sXGJby8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCH0XYkzKHNJM;
	Sun, 28 Sep 2025 15:28:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 50C701A174E;
	Sun, 28 Sep 2025 15:28:55 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S16;
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
Subject: [PATCH -next RFC 14/16] cpuset: fix isolcpus stay in root when isolated partition changes to root
Date: Sun, 28 Sep 2025 07:13:04 +0000
Message-Id: <20250928071306.3797436-15-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S16
X-Coremail-Antispam: 1UD129KBjvJXoWxXr47uw4UJryxZw15CFyfZwb_yoWrtw15pF
	yFka1Iq3yUtw15C3sFqan7uw1rKa1DtFy7tws8W3WfZFy7A3WvyFyjk39YyFy5WFyDGry5
	Zas09r48Xa42ywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A bug was detected with the following steps:

  # cd /sys/fs/cgroup/
  # mkdir test
  # echo 9 > test/cpuset.cpus
  # echo isolated > test/cpuset.cpus.partition
  # cat test/cpuset.cpus.partition
  isolated
  # cat test/cpuset.cpus
  9
  # echo root > test/cpuset.cpus.partition
  # cat test/cpuset.cpus
  9
  # cat test/cpuset.cpus.partition
  root

CPU 9 was initially placed in an isolated partition. When the partition
type is changed from isolated to root, CPU 9 remains in what becomes a
valid root partition. This violates the rule that isolcpus can only be
assigned to isolated partitions.

Fix the issue by re-enabling partition validation, which performs
comprehensive partition error checking. In the scenario described above,
this change causes the operation to fail with housekeeping conflicts,
preventing the invalid configuration.

Additionally, when enable a local partition, the warning for tmp->addmask
not being a subset of parent's effective CPUs was removed. This warning was
triggered during local partition re-enablement because the CPUs were
already added to exclusive_cpus during the previous enable operation. The
subset check is not applicable in this re-enablement scenario.

Fixes: f28e22441f35 ("cgroup/cpuset: Add a new isolated cpus.partition type")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 20288dbd6ccf..2aaa688c596f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1873,6 +1873,7 @@ static int local_partition_enable(struct cpuset *cs,
 {
 	struct cpuset *parent = parent_cs(cs);
 	enum prs_errcode part_error;
+	bool cpumask_updated = false;
 
 	lockdep_assert_held(&cpuset_mutex);
 	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
@@ -1899,22 +1900,14 @@ static int local_partition_enable(struct cpuset *cs,
 	if (part_error)
 		return part_error;
 
-	/*
-	 * This function will only be called when all the preliminary
-	 * checks have passed. At this point, the following condition
-	 * should hold.
-	 *
-	 * (cs->effective_xcpus & cpu_active_mask) ⊆ parent->effective_cpus
-	 *
-	 * Warn if it is not the case.
-	 * addmask is used as temporary variable.
-	 */
-	cpumask_and(tmp->addmask, tmp->new_cpus, cpu_active_mask);
-	WARN_ON_ONCE(!cpumask_subset(tmp->addmask, parent->effective_cpus));
+	cpumask_updated = cpumask_andnot(tmp->addmask, tmp->new_cpus,
+					 parent->effective_cpus);
 	partition_enable(cs, parent, new_prs, tmp->new_cpus);
 
-	cpuset_update_tasks_cpumask(parent, tmp->addmask);
-	update_sibling_cpumasks(parent, cs, tmp);
+	if (cpumask_updated) {
+		cpuset_update_tasks_cpumask(parent, tmp->addmask);
+		update_sibling_cpumasks(parent, cs, tmp);
+	}
 	return 0;
 }
 
@@ -2902,7 +2895,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	int err = PERR_NONE, old_prs = cs->partition_root_state;
 	struct cpuset *parent = parent_cs(cs);
 	struct tmpmasks tmpmask;
-	bool isolcpus_updated = false;
 
 	if (old_prs == new_prs)
 		return 0;
@@ -2920,7 +2912,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (err)
 		goto out;
 
-	if (!old_prs) {
+	if (new_prs > 0) {
 		/*
 		 * cpus_allowed and exclusive_cpus cannot be both empty.
 		 */
@@ -2950,12 +2942,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			err = local_partition_enable(cs, new_prs, &tmpmask);
 		else
 			err = remote_partition_enable(cs, new_prs, &tmpmask);
-	} else if (old_prs && new_prs) {
-		/*
-		 * A change in load balance state only, no change in cpumasks.
-		 * Need to update isolated_cpus.
-		 */
-		isolcpus_updated = true;
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
@@ -2985,16 +2971,13 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	WRITE_ONCE(cs->prs_err, err);
 	if (!is_partition_valid(cs))
 		reset_partition_data(cs);
-	else if (isolcpus_updated)
-		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
 
 	/* A newly created partition must have effective_xcpus set */
-	WARN_ON_ONCE(!old_prs && (new_prs > 0)
+	WARN_ON_ONCE(!old_prs && (cs->partition_root_state > 0)
 			      && cpumask_empty(cs->effective_xcpus));
 
 	/* Update sched domains and load balance flag */
-- 
2.34.1


