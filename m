Return-Path: <linux-kernel+bounces-835287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCDCBA6A42
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2340165C16
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF072571C2;
	Sun, 28 Sep 2025 07:44:34 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A2824BD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759045474; cv=none; b=KJFjm25ifqX2xnb1/DHuskCZAwG5QG94897mrEyJHMp6gPb5ExGz+58mkltksoVIi/+xenHCpyrTeKZtB/7UaRXhvJOKrSNbyiwWUXFs+/hl3rXAJwBVH+d3qvVSjan2/lHZszWLZYJpoSpBzty+L0DdIagA26f0UdfWnQ8LgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759045474; c=relaxed/simple;
	bh=Q+EMg5TQ8yFYIisOxYmnmLmns5/akqtWB+xBJzo0Jgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7OAYH6BapemmyaEVvii4yy35OKqhdAVd8qFAw360bPuGkNrr1AlGv1vkf4S2sj+jCrKmM8bRvDGmx0IHBfYGpb7ml47ua6uUrJjKKeeDAje2vVCOK36T9tgQ6CpUYKPwYKLwl5lQvzHKiFoRYgBaM1cbq98+QgQOUyS/SB1l/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCF2bH5zYQvfg;
	Sun, 28 Sep 2025 15:28:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 43D201A1733;
	Sun, 28 Sep 2025 15:28:55 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S15;
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
Subject: [PATCH -next RFC 13/16] cpuset: use partition_disable for compute_partition_effective_cpumask
Date: Sun, 28 Sep 2025 07:13:03 +0000
Message-Id: <20250928071306.3797436-14-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S15
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWkZF15Ar1rXw4kXryrJFb_yoW5Jr1fpF
	1xAr47GFW5X345u3y7ta97uwn8Gws2g3WDtr1fXw1fXFy7Awn0ka42yaySqFWjqr97W34U
	Z3Z0qr48Gan7AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Replace the partition invalidation logic in the
compute_partition_effective_cpumask() with a call to partition_disable().

This centralizes partition state management and ensures consistent
handling of partition disable operations throughout the cpuset subsystem.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6625b803ba02..20288dbd6ccf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -170,15 +170,6 @@ static inline bool cs_is_member(const struct cpuset *cs)
 	return cs->partition_root_state == PRS_MEMBER;
 }
 
-/*
- * Callers should hold callback_lock to modify partition_root_state.
- */
-static inline void make_partition_invalid(struct cpuset *cs)
-{
-	if (cs->partition_root_state > 0)
-		cs->partition_root_state = -cs->partition_root_state;
-}
-
 /*
  * Send notification event of whenever partition_root_state changes.
  */
@@ -2073,6 +2064,7 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 	struct cgroup_subsys_state *css;
 	struct cpuset *child;
 	bool populated = partition_is_populated(cs, NULL);
+	enum prs_errcode prs_err;
 
 	/*
 	 * Check child partition roots to see if they should be
@@ -2095,26 +2087,20 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 		 * partition root.
 		 */
 		WARN_ON_ONCE(is_remote_partition(child));
-		child->prs_err = 0;
+		prs_err = 0;
 		if (!cpumask_subset(child->effective_xcpus,
 				    cs->effective_xcpus))
-			child->prs_err = PERR_INVCPUS;
+			prs_err = PERR_INVCPUS;
 		else if (populated &&
 			 cpumask_subset(new_ecpus, child->effective_xcpus))
-			child->prs_err = PERR_NOCPUS;
-
-		if (child->prs_err) {
-			int old_prs = child->partition_root_state;
+			prs_err = PERR_NOCPUS;
 
+		if (prs_err) {
 			/*
 			 * Invalidate child partition
 			 */
-			spin_lock_irq(&callback_lock);
-			make_partition_invalid(child);
-			cs->nr_subparts--;
-			child->nr_subparts = 0;
-			spin_unlock_irq(&callback_lock);
-			notify_partition_change(child, old_prs);
+			partition_disable(child, parent_cs(child),
+					  -child->partition_root_state, prs_err);
 			continue;
 		}
 		cpumask_andnot(new_ecpus, new_ecpus,
-- 
2.34.1


