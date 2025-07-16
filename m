Return-Path: <linux-kernel+bounces-732717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F3B06B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5231A65A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E7B219A81;
	Wed, 16 Jul 2025 01:31:57 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93D2F50
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629517; cv=none; b=A01C8sRsuvA0cqbCCwMgaabZVp/JXVDMKFj1t2ZD8L4PM3QeJVWEUGhOo11RA4A8n1vwMqHFUwXIzZdebR+6jX402vX2HlWSqMJE0jitsErQxasdolWEHm0yd91iX++M31QTdhlEGrQKBQgcE9zxRY/n5wA3qACJ1TDnRXuO1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629517; c=relaxed/simple;
	bh=7JaT9xNUNFj0Sg990gXmpW6feSYYn9JGAnBvKs6XN2w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FXfnoGRY4d6O4nj2sr/uSBiZQu4fN+7dywqtFTLbHs6GefDvY4OCH7F+yqSf7XZHl1TFkhNlSNK9fuT31WTDP9sKXvo3i3wDtFHqvYZfx8nUGDkQyJSAWj4O70AoleUfdit5K2Ie9ydXPktG0Hm8Kg1AFGGUKTouRSMXJWOU198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bhdhv2vmNzHrDB;
	Wed, 16 Jul 2025 09:27:43 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D04D180B63;
	Wed, 16 Jul 2025 09:31:50 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Jul 2025 09:31:50 +0800
Received: from huawei.com (10.67.175.84) by kwepemq100012.china.huawei.com
 (7.202.195.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 16 Jul
 2025 09:31:49 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <raistlin@linux.it>, <harshit@nutanix.com>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH] sched/dl: Fix race in push_dl_task
Date: Wed, 16 Jul 2025 01:15:16 +0000
Message-ID: <20250716011516.3591655-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq100012.china.huawei.com (7.202.195.195)

push_dl_task() pick the first pushable task and find an eligible
lowest_rq, then double_lock_balance(rq, lowest_rq), so if
double_lock_balance() unlock the rq (when double_lock_balance() return
1), we have to check if this task is still on the rq. We cannot rely on
these checks of this task to make sure it is still on the original rq,
even though we hold the rq->lock. This patch will repick the first
pushable task to be sure the task is still on the rq.

This is very similar to the issue report in CVE-2025-38234, one is rt
and one is ddl. The patch for the rt bugfix is
https://lore.kernel.org/r/20250225180553.167995-1-harshit@nutanix.com

Fixes: 1baca4ce16b8 ("sched/deadline: Add SCHED_DEADLINE SMP-related data structures & logic")
Cc: stable@vger.kernel.org
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 kernel/sched/deadline.c | 53 ++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 89019a140826..3b53e71f2b86 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2619,6 +2619,25 @@ static int find_later_rq(struct task_struct *task)
 	return -1;
 }
 
+static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_dl_tasks(rq))
+		return NULL;
+
+	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
+
+	WARN_ON_ONCE(rq->cpu != task_cpu(p));
+	WARN_ON_ONCE(task_current(rq, p));
+	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
+
+	WARN_ON_ONCE(!task_on_rq_queued(p));
+	WARN_ON_ONCE(!dl_task(p));
+
+	return p;
+}
+
 /* Locks the rq it finds */
 static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 {
@@ -2646,12 +2665,15 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
-			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !dl_task(task) ||
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
+			/*
+			 * We had to unlock the run queue. In
+			 * the mean time, task could have
+			 * migrated already or had its affinity changed.
+			 * Also make sure that it wasn't scheduled on its rq.
+			 */
+			if (unlikely(is_migration_disabled(task) ||
+					!cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
+					task != pick_next_pushable_dl_task(rq))) {
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
 				break;
@@ -2674,25 +2696,6 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 	return later_rq;
 }
 
-static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_dl_tasks(rq))
-		return NULL;
-
-	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
-
-	WARN_ON_ONCE(rq->cpu != task_cpu(p));
-	WARN_ON_ONCE(task_current(rq, p));
-	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
-
-	WARN_ON_ONCE(!task_on_rq_queued(p));
-	WARN_ON_ONCE(!dl_task(p));
-
-	return p;
-}
-
 /*
  * See if the non running -deadline tasks on this rq
  * can be sent to some other CPU where they can preempt
-- 
2.34.1


