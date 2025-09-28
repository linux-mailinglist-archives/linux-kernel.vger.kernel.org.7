Return-Path: <linux-kernel+bounces-835280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1142CBA6A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563A9189CA8F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64C22C0F9C;
	Sun, 28 Sep 2025 07:29:08 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA32C033C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044548; cv=none; b=KPYYdktif8rdwzc3OfD0m6M39WPOEzREOXDYZYLwDGXv7KXkB06swwpT9mY5bozB6BX9Sm2brAGaEYQAuUjkrsm4oZnV9bU31ocGtfzlgM3l0xjaDDVhQaUBZJW/VL4m8rc2L0xArENB2+POsacWjiF8f+PWRusZkUAizpqlG90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044548; c=relaxed/simple;
	bh=ywGOVe2rn0IA/yycNEDW2c1NH0cVDxPzQS5KrVJOkxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RwnysJ7VkNzfbZf0x9zL6hh1qZ/MThNc8A1TRSH28ETkpQ24n7pVl+9uAyYg+hv/59ENukoArlfhtVQHG+knWP4nGge6s2wtPj7h+RxqQRgmtdxIiCvKgf+fYbcYLiR98XxjRM8soz8z3gIdb/SGAOSCbUWt5rmxg2P8GXarfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZGCF39G9zYQvfd;
	Sun, 28 Sep 2025 15:28:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 584DB1A1733;
	Sun, 28 Sep 2025 15:28:55 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgAHUhaY49hoiDJLBA--.29596S17;
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
Subject: [PATCH -next RFC 15/16] cpuset: use partition_disable for update_prstate
Date: Sun, 28 Sep 2025 07:13:05 +0000
Message-Id: <20250928071306.3797436-16-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAHUhaY49hoiDJLBA--.29596S17
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1kJr48ur4kZF43ur1kGrg_yoW8uF1fpa
	s3Cr47Gw4UXr15u34UWF4xZ3WrWws2qry2yFyDW34xX3W3J3sF9FyYy3ySqa1jyF98G3s8
	Z3ZFgr18Xa17CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The update_prstate() function currently handles partition state transitions
by directly manipulating partition-related fields. However, when a
partition is enabled or disabled through the proper interfaces, these
fields are already set correctly, making the direct manipulation redundant.

This patch refactors the logic to use partition_disable() when partition
errors are detected, ensuring consistent state management. For successful
state transitions, the partition-related fields are set appropriately.

This change eliminates redundant field manipulation and centralizes
partition state management through the established partition_disable()
interface, improving code maintainability and consistency.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2aaa688c596f..a22cf97e6af5 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2961,17 +2961,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	 * Make partition invalid & disable CS_CPU_EXCLUSIVE if an error
 	 * happens.
 	 */
-	if (err) {
-		new_prs = -new_prs;
-		update_partition_exclusive_flag(cs, new_prs);
-	}
-
-	spin_lock_irq(&callback_lock);
-	cs->partition_root_state = new_prs;
-	WRITE_ONCE(cs->prs_err, err);
-	if (!is_partition_valid(cs))
-		reset_partition_data(cs);
-	spin_unlock_irq(&callback_lock);
+	if (err)
+		partition_disable(cs, parent, -new_prs, err);
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
@@ -2983,7 +2974,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	/* Update sched domains and load balance flag */
 	update_partition_sd_lb(cs, old_prs);
 
-	notify_partition_change(cs, old_prs);
 	if (force_sd_rebuild)
 		rebuild_sched_domains_locked();
 	free_tmpmasks(&tmpmask);
-- 
2.34.1


