Return-Path: <linux-kernel+bounces-835270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CC1BA69FD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4FA1899B9F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA7329D29C;
	Sun, 28 Sep 2025 07:29:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86423226D02
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044540; cv=none; b=RD3G2XVbSmpCpNAi3ZdXdjfYj0uJCuX7vEs4Qo0YTypGJLZaU/gAXbhWtZ+aUwSavpZy9ASF2L43Ahg9MY9GCSqzW07MTWfUA6+ejixtd0fdRd11XgCBMmKhvcirYylgR1N7h/2q7QQJRBBjAZ87lIgv2H6N59lTb7nNPP4pES4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044540; c=relaxed/simple;
	bh=9brNlO4NlISnv5/bLGaaY6qPZIeV9JVoCd1zgROL1hA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+t6kNF1OdSrZBON5TSGkEFlpU64ZM9FyLAfiyURgp+n46tflhAN9+j+h3XjGPE2v5ds14eN+R27DJ1z6tGGB/d4QcYXbZviaRut+WGhsM6gIOx6xWccN6ATxhOS9iun1Jv+phEAbx6ND1EFZFP0M2lD7jnFV0MjkvTpbFlSIGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCG3P3hzKHN6c;
	Sun, 28 Sep 2025 15:28:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id ADE761A1017;
	Sun, 28 Sep 2025 15:28:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S4;
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
Subject: [PATCH -next RFC 02/16] cpuset: generalize validate_partition() interface
Date: Sun, 28 Sep 2025 07:12:52 +0000
Message-Id: <20250928071306.3797436-3-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWDJFW7WFW3uF43Wry3Arb_yoWrWryxpF
	y5GrW7G3yUtryaka4kta97Cw1YgwnrX3WDt3sxJ3WSvFy7tw1vyFyj9390vryfW39rGw1U
	ZanI9F4fWF9rAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcTmhUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Refactor validate_partition() to accept a more generic parameter set,
making the interface flexible enough to handle local partition enablement
validation scenarios. This prepares the function for broader use cases
beyond its current validation scope while maintaining backward
compatibility with existing callers.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 77 ++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 052f9e0c7a65..0787904321a9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1702,6 +1702,34 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 	return false;
 }
 
+/**
+ * validate_partition - Validate a cpuset partition configuration
+ * @cs: The cpuset to validate
+ * @new_prs: The proposed new partition root state
+ * @new_excpus: The new effective exclusize CPUs mask to validate
+ *
+ * Return: PRS error code (0 if valid, non-zero error code if invalid)
+ */
+static enum prs_errcode validate_partition(struct cpuset *cs, int new_prs,
+						 struct cpumask *new_excpus)
+{
+	struct cpuset *parent = parent_cs(cs);
+
+	if (new_prs == PRS_MEMBER)
+		return PERR_NONE;
+
+	if (cpumask_empty(new_excpus))
+		return PERR_INVCPUS;
+
+	if (prstate_housekeeping_conflict(new_prs, new_excpus))
+		return PERR_HKEEPING;
+
+	if (tasks_nocpu_error(parent, cs, new_excpus))
+		return PERR_NOCPUS;
+
+	return PERR_NONE;
+}
+
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1805,19 +1833,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
 		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
 
-		/*
-		 * Enabling partition root is not allowed if its
-		 * effective_xcpus is empty.
-		 */
-		if (cpumask_empty(xcpus))
-			return PERR_INVCPUS;
-
-		if (prstate_housekeeping_conflict(new_prs, xcpus))
-			return PERR_HKEEPING;
-
-		if (tasks_nocpu_error(parent, cs, xcpus))
-			return PERR_NOCPUS;
-
+		part_error = validate_partition(cs, new_prs, xcpus);
+		if (part_error)
+			return part_error;
 		/*
 		 * This function will only be called when all the preliminary
 		 * checks have passed. At this point, the following condition
@@ -2367,36 +2385,6 @@ static int parse_cpuset_cpulist(const char *buf, struct cpumask *out_mask)
 	return 0;
 }
 
-/**
- * validate_partition - Validate a cpuset partition configuration
- * @cs: The cpuset to validate
- * @trialcs: The trial cpuset containing proposed configuration changes
- *
- * If any validation check fails, the appropriate error code is set in the
- * cpuset's prs_err field.
- *
- * Return: PRS error code (0 if valid, non-zero error code if invalid)
- */
-static enum prs_errcode validate_partition(struct cpuset *cs, struct cpuset *trialcs)
-{
-	struct cpuset *parent = parent_cs(cs);
-
-	if (cs_is_member(trialcs))
-		return PERR_NONE;
-
-	if (cpumask_empty(trialcs->effective_xcpus))
-		return PERR_INVCPUS;
-
-	if (prstate_housekeeping_conflict(trialcs->partition_root_state,
-					  trialcs->effective_xcpus))
-		return PERR_HKEEPING;
-
-	if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus))
-		return PERR_NOCPUS;
-
-	return PERR_NONE;
-}
-
 static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialcs,
 					struct tmpmasks *tmp)
 {
@@ -2451,7 +2439,8 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 	if (cs_is_member(cs))
 		return;
 
-	prs_err = validate_partition(cs, trialcs);
+	prs_err = validate_partition(cs, trialcs->partition_root_state,
+				     trialcs->effective_xcpus);
 	if (prs_err)
 		trialcs->prs_err = cs->prs_err = prs_err;
 
-- 
2.34.1


