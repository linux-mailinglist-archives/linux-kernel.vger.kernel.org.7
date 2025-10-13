Return-Path: <linux-kernel+bounces-849920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 763D2BD1557
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7A21891D65
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4CC271459;
	Mon, 13 Oct 2025 03:52:12 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9913B797
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760327532; cv=none; b=ge8w+FQLe23eeTFKBTCEP77x/UBzTQbSt9/o7oUi6yggAcx6Nax8mmaCLBYhwt7g/dKBVI24ZGrhj70a+BpNcLkTQO0es+AYwY+S6C41Daonyz2X3jykQqcCsnWJfAuRG5H5TuKWeOF7EF61szUzpko3jcvfa69fJDNwcxgs9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760327532; c=relaxed/simple;
	bh=zNgmoU1Rq63WaQtd7qyYMCluSw7M5F9xGQnR1HvkV1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IIOIXe92XBidQwwFo8SbCPprXiNhqXN4dPQkZGbwsp65BAtBo4ulQVXAtmynuoExL7EdbkDhlabwvar9bGmTcWsmrnNN9XqOmTGY/o+Ca+tnwrcv9sjGhx+L0oFkprDkwTcpxOSDXvQ7PZujwxt+WG3pj8RhdcTrqzrUMrwM1D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4clNgk5BrXzKHLy9
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:51:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EA4361A0DD3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:52:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP2 (Coremail) with SMTP id Syh0CgCn_UVdd+xob7_EAA--.56133S4;
	Mon, 13 Oct 2025 11:52:04 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: mingo@redhat.com
Cc: peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	huang.ying.caritas@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/topology: Fix memory leak in the error path of sched_init_numa
Date: Mon, 13 Oct 2025 04:13:48 +0000
Message-Id: <20251013041348.350886-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn_UVdd+xob7_EAA--.56133S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWkWw1UZr4UuryxCr18AFb_yoW8uw48pw
	sFgr90yr4vkrn3GFn5Zry7Cry5WFZ7twnF9a429w4kJry5Gr4jgr40va4agFyj9FW0yFWS
	vr1Dtr13XF17KFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

In sched_init_numa, masks are used to store memory, but the error path
returns directly without freeing the allocated memory.
To fix this, the freeing logic in sched_reset_numa can be extraced into a
new function, free_masks, which can be called on the error path.

Fixes: 0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/sched/topology.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 444bdfdab731..fd03bb6669f5 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1924,6 +1924,20 @@ static void init_numa_topology_type(int offline_node)
 
 #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
 
+static void free_masks(struct cpumask ***masks, int nr_levels)
+{
+	int i, j;
+
+	for (i = 0; i < nr_levels && masks; i++) {
+		if (!masks[i])
+			continue;
+		for_each_node(j)
+			kfree(masks[i][j]);
+		kfree(masks[i]);
+	}
+	kfree(masks);
+}
+
 void sched_init_numa(int offline_node)
 {
 	struct sched_domain_topology_level *tl;
@@ -2003,15 +2017,19 @@ void sched_init_numa(int offline_node)
 	 */
 	for (i = 0; i < nr_levels; i++) {
 		masks[i] = kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
-		if (!masks[i])
+		if (!masks[i]) {
+			free_masks(masks, nr_levels);
 			return;
+		}
 
 		for_each_cpu_node_but(j, offline_node) {
 			struct cpumask *mask = kzalloc(cpumask_size(), GFP_KERNEL);
 			int k;
 
-			if (!mask)
+			if (!mask) {
+				free_masks(masks, nr_levels);
 				return;
+			}
 
 			masks[i][j] = mask;
 
@@ -2079,18 +2097,9 @@ static void sched_reset_numa(void)
 	masks = sched_domains_numa_masks;
 	rcu_assign_pointer(sched_domains_numa_masks, NULL);
 	if (distances || masks) {
-		int i, j;
-
 		synchronize_rcu();
 		kfree(distances);
-		for (i = 0; i < nr_levels && masks; i++) {
-			if (!masks[i])
-				continue;
-			for_each_node(j)
-				kfree(masks[i][j]);
-			kfree(masks[i]);
-		}
-		kfree(masks);
+		free_masks(masks, nr_levels);
 	}
 	if (sched_domain_topology_saved) {
 		kfree(sched_domain_topology);
-- 
2.34.1


