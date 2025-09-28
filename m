Return-Path: <linux-kernel+bounces-835272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7687BA6A03
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9336417ACBC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E22BE7BE;
	Sun, 28 Sep 2025 07:29:04 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ED121CC58
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044543; cv=none; b=mgkMUCwzMBTrwONgt0OBHKy4/wtcowDUS0lkIciqrqQbf43hAe7VpaJ80R/45VRbgSpKGcV56bzC0H/IBvv2CQZDeK8b/7FER1sk/IoTNJ5W7FDTUaui3t/TBJNItpS4M+U/LGa83S0qjCJIfEQBGIcDhaQPsux1fEw1lSMEF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044543; c=relaxed/simple;
	bh=GYS8UKcTIHZPaBWuqA9dsfyhy9xWi3PU5d4oS/pAJaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PskUNCbc3TzYM2PY8CN74dRTcQevkUM/LTbOdWu6ng+uzmOVc1E5z4oC1UfrtmoD/ToDZv2XN4m8TqtqbHGyz3rvAEPPrR9Iv3MI//VYFwtG4r1zBnnBKjt3peOJbTQkWWsyRD/QocBUvhwSuEzqx0Xa0PEYPjZvXjqhEot6Y6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCG6rctzKHNJ8;
	Sun, 28 Sep 2025 15:28:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 35BA31A173F;
	Sun, 28 Sep 2025 15:28:55 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S14;
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
Subject: [PATCH -next RFC 12/16] cpuset: unify local partition disable and invalidate
Date: Sun, 28 Sep 2025 07:13:02 +0000
Message-Id: <20250928071306.3797436-13-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S14
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4fAF4UArWUGF1xCF18Grg_yoW7GFWkpF
	y3Jr42grWUXFy5u34UJFs7Aw1fKwn7JFZ2ywnxWa4fXF17A3WvvFy0y39Yva45XF9rG347
	Za1qgr48XF1xCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The local_partition_invalidate() and local_partition_disable() functions
contain similar logic that can be unified into a single implementation.
This patch consolidates both functions into local_partition_disable(),
creating symmetry with the existing remote_partition_disable() function.

To support this unification, the partition error code is added as an
input parameter to local_partition_disable(), allowing proper recording
of the disablement reason for both invalid and regular disable operations.

This refactoring reduces code duplication and establishes a consistent
interface for partition disable operations across both local and remote
partition types.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 53 +++++++++++-------------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a1896a199c8b..6625b803ba02 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1932,10 +1932,12 @@ static int local_partition_enable(struct cpuset *cs,
  * @cs: Target cpuset (local partition root) to disable
  * @tmp: Temporary masks for CPU calculations
  */
-static void local_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
+static void local_partition_disable(struct cpuset *cs, enum prs_errcode part_error,
+				    struct tmpmasks *tmp)
 {
 	struct cpuset *parent = parent_cs(cs);
 	bool cpumask_updated = false;
+	int new_prs;
 
 	lockdep_assert_held(&cpuset_mutex);
 	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
@@ -1943,48 +1945,21 @@ static void local_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	if (!is_partition_valid(cs))
 		return;
 
+	if (part_error)
+		new_prs = -cs->partition_root_state;
+	else
+		new_prs = 0;
 	/*
 	 * May need to add cpus back to parent's effective_cpus
 	 * (and maybe removed from subpartitions_cpus/isolated_cpus)
 	 * for valid partition root. xcpus may contain CPUs that
 	 * shouldn't be removed from the two global cpumasks.
 	 */
-	cpumask_updated = !cpumask_empty(cs->effective_xcpus);
-	partition_disable(cs, parent, PRS_MEMBER, PERR_NONE);
-
-	if (cpumask_updated) {
-		cpuset_update_tasks_cpumask(parent, tmp->addmask);
-		update_sibling_cpumasks(parent, cs, tmp);
-	}
-}
-
-/**
- * local_partition_invalidate - Invalidate a local partition
- * @cs: Target cpuset (local partition root) to invalidate
- * @tmp: Temporary masks
- */
-static void local_partition_invalidate(struct cpuset *cs, struct tmpmasks *tmp)
-{
-	struct cpumask *xcpus = user_xcpus(cs);
-	struct cpuset *parent = parent_cs(cs);
-	int new_prs = cs->partition_root_state;
-	bool cpumask_updated = false;
-
-	lockdep_assert_held(&cpuset_mutex);
-	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
-
-	if (is_partition_invalid(cs))
-		return;
-	/*
-	 * Make the current partition invalid.
-	 */
 	if (is_partition_valid(parent))
-		cpumask_updated = cpumask_and(tmp->addmask,
-					      xcpus, parent->effective_xcpus);
-	if (cs->partition_root_state > 0)
-		new_prs = -cs->partition_root_state;
+		cpumask_updated = !cpumask_empty(cs->effective_xcpus);
+
+	partition_disable(cs, parent, new_prs, part_error);
 
-	partition_disable(cs, parent, new_prs, cs->prs_err);
 	if (cpumask_updated) {
 		cpuset_update_tasks_cpumask(parent, tmp->addmask);
 		update_sibling_cpumasks(parent, cs, tmp);
@@ -2033,7 +2008,7 @@ static int __local_partition_update(struct cpuset *cs, struct cpumask *xcpus,
 	new_prs = old_prs < 0 ? -old_prs : old_prs;
 	part_error = local_partition_check(cs, new_prs, excpus, excl_check);
 	if (part_error) {
-		local_partition_invalidate(cs, tmp);
+		local_partition_disable(cs, part_error, tmp);
 		return part_error;
 	}
 
@@ -2429,7 +2404,7 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
 			if (is_partition_valid(cp) &&
 			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
 				rcu_read_unlock();
-				local_partition_invalidate(cp, tmp);
+				local_partition_disable(cp, PERR_NOTEXCL, tmp);
 				rcu_read_lock();
 			}
 		}
@@ -2469,7 +2444,7 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 					   trialcs->effective_xcpus, tmp);
 	} else {
 		if (trialcs->prs_err)
-			local_partition_invalidate(cs, tmp);
+			local_partition_disable(cs, trialcs->prs_err, tmp);
 		else
 			__local_partition_update(cs, trialcs->exclusive_cpus,
 						trialcs->effective_xcpus, tmp, false);
@@ -3003,7 +2978,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		if (is_remote_partition(cs))
 			remote_partition_disable(cs, &tmpmask);
 		else
-			local_partition_disable(cs, &tmpmask);
+			local_partition_disable(cs, PERR_NONE, &tmpmask);
 		/*
 		 * Invalidation of child partitions will be done in
 		 * update_cpumasks_hier().
-- 
2.34.1


