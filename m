Return-Path: <linux-kernel+bounces-799697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ED1B42F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC67C7C4A4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A81E3DF2;
	Thu,  4 Sep 2025 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="HxAwEdPJ"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4656537F8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756950737; cv=none; b=ksq81dbzGsxYv/oz8U9PQPgZl8O5tUB8KbrCIlpYn7As6j8Ri0UcDO5bUUuThELLbAel5WWi9Y+Rw+7vaRcyjCZltsqGaNVxNjlcnc0vdce+1aRuB59qr31hqTbHcmKnb7e+u81j/hET18GqFhpGWzz+xybzAnSW+/LH5mrb/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756950737; c=relaxed/simple;
	bh=8uVrH3E9ZUTKlf+Fmwzqtu76wRGDK/8H1yi+H9t3Hqw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ciOVZs5bzvnL0QRYBuAcLfiiUEfCRvt31KIAPN3B+gaY2PWejxumXSCVg/57KrBTZhfX4N6zuUVlcg8L4VyTwtthk549q0gVuVpWVaHtcc7hIlh9wXAiTcBo5Cd6t62mIH6vwm852kclWp6gusxRKrSNlH2LBHqsbgwDq6DdxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=HxAwEdPJ; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756950728;
	bh=m3lqxD14iC8h790ABV4eqgcozXfZnxK6eiaK1KAMMyw=;
	h=From:To:Cc:Subject:Date;
	b=HxAwEdPJFOkPBDH6oPZIUV9fh6iIm9ipFAbPyAFoLIyU3zImibYhMJGbbGs93/Pmg
	 t7u+xQNJUdZrDgdIpz3yADdxAR6rBHOA76Zi6Igd4Fe/hq/RYgNKghcoNUN+OuV6Vb
	 AnU2m5vozlZrY+6B9Lxx660HODC1Hyy4jk9u80XM=
Received: from SSOC3-SH.company.local ([58.33.109.195])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id CF81B0EB; Thu, 04 Sep 2025 09:51:56 +0800
X-QQ-mid: xmsmtpt1756950716tvspqs74q
Message-ID: <tencent_3177343A3163451463643E434C61911B4208@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfDKUhPk/DzKNaoI17qaXQHyvmMMyNRZsHfRCwA/UZW0tEKKjL1w
	 2DfFJ66U2vuDDPNCDzb9l8/Jh/20ffTbwprEfUZp8xC7BHEewLfaypjx3vtrwD+QcTFbBSucVovL
	 OUoSrjA1JKDQ0VpxiurxZwDOIjsDiIqYcV8lL1t8DfxIOcggVquiR9DeUqFr22DwXYsd3o+9IFV1
	 +fIYwJ+EYuMIWVGvIC0MykZBk7DvC/ppspo3NjL9e2IOW+6ocyizjq1/YzhUGudvYNHLbJ0FPLWE
	 csYzSHcOnUiV9sew7wR+PBWE2w6o5BMrYPWRCQYbUe7F4x0rwJP2TCasv09/CDpogyEsXj0CJfSv
	 g0HxDq047FQ4yjfVCdjf975ETldYxRZWI3SiYowxsAuW2yl/fVqcOCHbAFCI+p9dOMRDMXOeyXfq
	 +RMJsSnOfBdPDfLnQpWuIUlzZpSfYU7E4jcwz/+bqtEGU2ZTAgJAaKIzy/EBV1sFOtXZpHaHNTdZ
	 nGGDMr+5FE2Hrm6LMNG0WWCuR0TzzSZz3kyTlSOW8v5b5j1jY8QFxzDtTSlg4mMV8uR3LdAdf0hX
	 SUAQgeSUsrnGsbb3Eayxw+CI86xzfVTBRhR5ZgG1Ym5rF0LG7fAID3PbJQ69FgvqBylKqOMXeLeY
	 z7Whbhof3dSmuYLRycE5LHMjSbw4BfXONiQ60K1n+kt3AssoVZKF8roYrKHhtxq1He9sJf62GZIS
	 f2xJLYeqyIH1QoSRk7QvAkKhKD6CA2WP9N78j0RpBFGdVy6fyISV9R5ZLPs83kj9Du5x1TjqZHEu
	 Qoiw+2cil/3Rzca/2faD/arN2pyqzo3gz3rEILKpPShASKvHoBpgRHS1G4oG7fCpiwPyuRUEFqDy
	 Yl6J645lnyfWM0Ww9QLDO/zn3Uo0OzpIn26guMycZSNtl6dBzuFOYbm/4vKXxg3rH3DcQ2bliTJv
	 m6sodyBSUy6G7Q6aJbZeYLKSeunZhIYxiQ+SAOk0f71MzyN0Kd8ETTxmgfewh4mIj294smoKi92g
	 lLbIDblKUnoQ2lj0tYnMNSX9ZRcMaKPl7gSazmhPo6CnqJNKp1
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Han Guangjiang <gj.han@foxmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc: hanguangjiang@lixiang.com,
	fanggeng@lixiang.com,
	yangchen11@lixiang.com
Subject: [PATCH] sched/fair: Fix DELAY_DEQUEUE issue related to cgroup throttling
Date: Thu,  4 Sep 2025 09:51:50 +0800
X-OQ-MSGID: <20250904015151.2606425-1-gj.han@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Han Guangjiang <hanguangjiang@lixiang.com>

When both CPU cgroup and memory cgroup are enabled with parent cgroup
resource limits much smaller than child cgroup's, the system frequently
hangs with NULL pointer dereference:

Unable to handle kernel NULL pointer dereference
at virtual address 0000000000000051
Internal error: Oops: 0000000096000006 [#1] PREEMPT_RT SMP
pc : pick_task_fair+0x68/0x150
Call trace:
 pick_task_fair+0x68/0x150
 pick_next_task_fair+0x30/0x3b8
 __schedule+0x180/0xb98
 preempt_schedule+0x48/0x60
 rt_mutex_slowunlock+0x298/0x340
 rt_spin_unlock+0x84/0xa0
 page_vma_mapped_walk+0x1c8/0x478
 folio_referenced_one+0xdc/0x490
 rmap_walk_file+0x11c/0x200
 folio_referenced+0x160/0x1e8
 shrink_folio_list+0x5c4/0xc60
 shrink_lruvec+0x5f8/0xb88
 shrink_node+0x308/0x940
 do_try_to_free_pages+0xd4/0x540
 try_to_free_mem_cgroup_pages+0x12c/0x2c0

The issue can be mitigated by increasing parent cgroup's CPU resources,
or completely resolved by disabling DELAY_DEQUEUE feature.

SCHED_FEAT(DELAY_DEQUEUE, false)

With CONFIG_SCHED_DEBUG enabled, the following warning appears:

WARNING: CPU: 1 PID: 27 at kernel/sched/fair.c:704 update_entity_lag+0xa8/0xd0
!se->on_rq
Call trace:
 update_entity_lag+0xa8/0xd0
 dequeue_entity+0x90/0x538
 dequeue_entities+0xd0/0x490
 dequeue_task_fair+0xcc/0x230
 rt_mutex_setprio+0x2ec/0x4d8
 rtlock_slowlock_locked+0x6c8/0xce8

The warning indicates se->on_rq is 0, meaning dequeue_entity() was
entered at least twice and executed update_entity_lag().

Root cause analysis:
In rt_mutex_setprio(), there are two dequeue_task() calls:
1. First call: dequeue immediately if task is delay-dequeued
2. Second call: dequeue running tasks

Through debugging, we observed that for the same task, both dequeue_task()
calls are actually executed. The task is a sched_delayed task on cfs_rq,
which confirms our analysis that dequeue_entity() is entered at least
twice.

Semantically, rt_mutex handles scheduling and priority inheritance, and
should only dequeue/enqueue running tasks. A sched_delayed task is
essentially non-running, so the second dequeue_task() should not execute.

Further analysis of dequeue_entities() shows multiple cfs_rq_throttled()
checks. At the function's end, __block_task() updates sched_delayed
tasks to non-running state. However, when cgroup throttling occurs, the
function returns early without executing __block_task(), leaving the
sched_delayed task in running state. This causes the unexpected second
dequeue_task() in rt_mutex_setprio(), leading to system crash.

We initially tried modifying the two cfs_rq_throttled() return points in
dequeue_entities() to jump to the __block_task() condition check, which
resolved the issue completely.

This patch takes a cleaner approach by moving the __block_task()
operation from dequeue_entities() to finish_delayed_dequeue_entity(),
ensuring sched_delayed tasks are properly marked as non-running
regardless of cgroup throttling status.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Han Guangjiang <hanguangjiang@lixiang.com>
---
 kernel/sched/fair.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..d6c2a604358f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5373,6 +5373,12 @@ static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
 	clear_delayed(se);
 	if (sched_feat(DELAY_ZERO) && se->vlag > 0)
 		se->vlag = 0;
+
+	if (entity_is_task(se)) {
+		struct task_struct *p = task_of(se);
+
+		__block_task(task_rq(p), p);
+	}
 }
 
 static bool
@@ -7048,21 +7054,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
-	if (p && task_delayed) {
-		WARN_ON_ONCE(!task_sleep);
-		WARN_ON_ONCE(p->on_rq != 1);
-
-		/* Fix-up what dequeue_task_fair() skipped */
-		hrtick_update(rq);
-
-		/*
-		 * Fix-up what block_task() skipped.
-		 *
-		 * Must be last, @p might not be valid after this.
-		 */
-		__block_task(rq, p);
-	}
-
 	return 1;
 }
 
-- 
2.25.1


