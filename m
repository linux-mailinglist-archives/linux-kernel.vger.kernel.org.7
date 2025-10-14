Return-Path: <linux-kernel+bounces-852083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA34EBD8204
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBD9B4F760B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B9E30F817;
	Tue, 14 Oct 2025 08:14:44 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2199D30F934
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429684; cv=none; b=WO4IdRMAcvz/ljMFOcxSPgeEbimsc0QgoEmAThocud+/SUeqq1SunOO0TZzrllbpYx5sievEZK/34fw/FVUNOaJdiu+zvT70RTejvUqeUE1TEzgBYQ9pEtloxWuOv9fFJaRKKm+GCdXo9353DFsPyg13s2lKWESb5vvBhYcu4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429684; c=relaxed/simple;
	bh=zL8hY0RywDjGJHpHJY9qFgeC0bS5koIc43JLAnyLAgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c7iKENkH5Q3nyrdDh3McnLf4lcfea5M+2akTXsnUf9aMPHZn0f4eEObUdtpGmW+LVkP7ah8Ub1RyyBnF/psht0oYUs9v9B2FiSRQS9smiNycIsQQrqMtQSHVQwA59+R+/LV4RX3seADDWR3BgvrYpo3612jNDpK3uMy9ucCKaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cm6S61CqwzYQtwZ
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:13:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DBE3A1A164C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:14:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP2 (Coremail) with SMTP id Syh0CgBnvUVoBu5obOpLAQ--.28014S4;
	Tue, 14 Oct 2025 16:14:36 +0800 (CST)
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
Subject: [PATCH v2] sched/topology: Fix memory leak in the error path of sched_init_numa
Date: Tue, 14 Oct 2025 08:36:50 +0000
Message-Id: <20251014083650.815439-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnvUVoBu5obOpLAQ--.28014S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGF48Kw4xKF4ktr4rXw4kXrb_yoW5Gr1fpw
	s0gry5Ar4UKr1kGFs5Ary7CFy5XFZ7t3sF9a429w4kJry5Cr1jgr40v3WagFWUWFW0yFWS
	vr1qgr12q3W7KFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbmii3UUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

In sched_init_numa, masks are used to store memory, but the error path
returns directly without freeing the allocated memory.
To fix this, the freeing logic in sched_reset_numa can be extraced into a
new function, __sched_free_masks, which can be called on the error path.

Fixes: 0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 Change log
 V1->V2:
 - Rename the free_masks to __sched_free_masks as suggested by Huang, Ying
 - Add Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
 Link to V1: https://lore.kernel.org/all/20251013041348.350886-1-luogengkun@huaweicloud.com/
---
 kernel/sched/topology.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 444bdfdab731..4e4e0bffd323 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1924,6 +1924,20 @@ static void init_numa_topology_type(int offline_node)
 
 #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
 
+static void __sched_free_masks(struct cpumask ***masks, int nr_levels)
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
+			__sched_free_masks(masks, nr_levels);
 			return;
+		}
 
 		for_each_cpu_node_but(j, offline_node) {
 			struct cpumask *mask = kzalloc(cpumask_size(), GFP_KERNEL);
 			int k;
 
-			if (!mask)
+			if (!mask) {
+				__sched_free_masks(masks, nr_levels);
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
+		__sched_free_masks(masks, nr_levels);
 	}
 	if (sched_domain_topology_saved) {
 		kfree(sched_domain_topology);
-- 
2.34.1


