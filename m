Return-Path: <linux-kernel+bounces-835274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD2BBA6A09
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C4817B414
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2982BEC3A;
	Sun, 28 Sep 2025 07:29:04 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED712BE631
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044544; cv=none; b=aLo2G+tUhw17CsqMEqdCa2Pm2V1gJLBq6wviVxkmSKv7byMCwpjG7IoSl7XceGs0H7wLzbNJ2la/EnckN8UlUso2zUSZH5bc4948gkREvqpZcTd6pinvDLJG0NZ2ksPJAV8epdaxKLjLg0q8DNiwzinFNrtKUaXhyCrEkK0M0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044544; c=relaxed/simple;
	bh=UPE/Fq93EsTvybhJhC6i4JhGmkmhzfL1i+enUm6fsx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ncTmlevmyHHF5SM9CcvfI7XEflkYdKRV6aNnSEkgfSntwzT7B9tbL4HL2eLoMHJRLG5H+RBgHvwH97vNpb4y1sN+JaCgR0DcYUx1UGPUv6+PSFOr2EBPCSHl0agTNalPYAPJENTvwdnUYVw8+fNTWiRKHAWMFQ44MlijB3EEruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCD5gbrzYQvf8;
	Sun, 28 Sep 2025 15:28:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AAB1B1A1718;
	Sun, 28 Sep 2025 15:28:54 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S3;
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
Subject: [PATCH -next RFC 01/16] cpuset: use update_partition_sd_lb in update_cpumasks_hier
Date: Sun, 28 Sep 2025 07:12:51 +0000
Message-Id: <20250928071306.3797436-2-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr18WF1DGF45JF48CF1rJFb_yoW8ZF1rpF
	9FkayxJa1Y9r1UC34UZan29ryfXa1kXFy5t3ZxtF1rJF13ta1YyFyv9a93JFWUKF90kF1U
	Ar1q9r42g3ZYyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7qjgUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

For cgroup v2, when a cpuset is not a valid partition root, it inherits
the CS_SCHED_LOAD_BALANCE flag from its parent. The existing logic in
update_cpumasks_hier() manually handled this inheritance condition.

This patch replaces the inline implementation with a call to the dedicated
update_partition_sd_lb() helper function, which already encapsulates the
same logic. The helper function comprehensively handles both the load
balance flag update and the necessary scheduling domain rebuild decision.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2c178a..052f9e0c7a65 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1257,6 +1257,8 @@ static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
 	bool rebuild_domains = (new_prs > 0) || (old_prs > 0);
 	bool new_lb;
 
+	if (!cpuset_v2())
+		return;
 	/*
 	 * If cs is not a valid partition root, the load balance state
 	 * will follow its parent.
@@ -2276,19 +2278,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
 
 		cpuset_update_tasks_cpumask(cp, cp->effective_cpus);
-
-		/*
-		 * On default hierarchy, inherit the CS_SCHED_LOAD_BALANCE
-		 * from parent if current cpuset isn't a valid partition root
-		 * and their load balance states differ.
-		 */
-		if (cpuset_v2() && !is_partition_valid(cp) &&
-		    (is_sched_load_balance(parent) != is_sched_load_balance(cp))) {
-			if (is_sched_load_balance(parent))
-				set_bit(CS_SCHED_LOAD_BALANCE, &cp->flags);
-			else
-				clear_bit(CS_SCHED_LOAD_BALANCE, &cp->flags);
-		}
+		update_partition_sd_lb(cp, old_prs);
 
 		/*
 		 * On legacy hierarchy, if the effective cpumask of any non-
-- 
2.34.1


