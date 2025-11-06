Return-Path: <linux-kernel+bounces-888261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAADC3A513
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 726F8350A8B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806A32DEA83;
	Thu,  6 Nov 2025 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JkZLIG8a"
Received: from fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.156.205.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13A2E7180
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.156.205.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425675; cv=none; b=ESWkwdnHVlGKUEYStU2q3n8dkl6vxMemCUyOz39xxQy06y+Jl+9sF6YGxjitlLnqcylWn/hXn5TF4Oy+qY5N5Fw/kLS44OZyYLE8XzlkdTNt6bPx8NxMYeh36c4mGjpuwxpvKvefkN7XVDu3iIefsBtjink1bjd/1FHb+EAHaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425675; c=relaxed/simple;
	bh=AH7fyg9mSRyP0w8xKjB/5Vk5vaEcqXyBHcQq13ueWQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DxCKyTYNoQ94IF29AU9zULSUcYNJQrBmeSy5IlQ+JwyeywcPAYELlz4IV6I55h8MjfWGhxBY99WQBc1HF18gzmxiCpWWROMyoM4on67bccvWtAyJpHPLSGAuYB7BP5hMThHkWhQqs04Tt4oAoo5UTKjR4b+hVThjDamL9PfnZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JkZLIG8a; arc=none smtp.client-ip=18.156.205.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762425674; x=1793961674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DIfE1sRcHzlkIplQspgwVLr+o35YgtcuNHsGKU6KDEQ=;
  b=JkZLIG8aoCGODx94nMEFUFscFchoHKpCllpDel3CyZDL5JKtXiJsaFPm
   NjujxsasX7D6F12SWERpUBMCIeicyJd4nEE/pp2DCOsa/e+zvWGyKiZd1
   psvusQDz+7eOmbRWZ6FW3blJNb62Ksg/jQCJ49J9TTHB5PZBk9eaxnmH5
   G+7ijpEaVpGY0t0YgNnJiQhatUOGhT4RqVeVL36r781Fg+IvHHOpzOVo2
   HdBHq5M7B3jnT/b4t7PUYeh9pguHc7Bj5l+pSH+k20AbTUwe8NjYStHQ1
   aeHCVelXsHMnE6G5a3xhhzGpPRNIVCE/j//YmIGyZDUvc10aSUXpCtwq0
   w==;
X-CSE-ConnectionGUID: XkUPWOVMSA2v0iKjGxmmKA==
X-CSE-MsgGUID: MtJodpotSZiWNzKsYaoAXQ==
X-IronPort-AV: E=Sophos;i="6.19,284,1754956800"; 
   d="scan'208";a="4764964"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:40:56 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:11320]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.45.127:2525] with esmtp (Farcaster)
 id 0ea984dd-9df7-450f-ac28-d7592dda643d; Thu, 6 Nov 2025 10:40:56 +0000 (UTC)
X-Farcaster-Flow-ID: 0ea984dd-9df7-450f-ac28-d7592dda643d
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 6 Nov 2025 10:40:45 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.108) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 6 Nov 2025 10:40:38 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <dwmw@amazon.co.uk>, <jschoenh@amazon.de>,
	<liuyuxua@amazon.com>
Subject: [PATCH] sched: Proxy yields to donor tasks
Date: Thu, 6 Nov 2025 12:40:10 +0200
Message-ID: <20251106104022.195157-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When executing a task in proxy context, handle yields as if they were
requested by the donor task.

This avoids scenario like proxy task yielding, pick next task selecting the
same previous blocked donor, running the proxy task again, etc.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
---
 kernel/sched/deadline.c | 2 +-
 kernel/sched/ext.c      | 4 ++--
 kernel/sched/fair.c     | 2 +-
 kernel/sched/rt.c       | 2 +-
 kernel/sched/syscalls.c | 5 +++--
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7b7671060bf9..c4402542ef44 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2143,7 +2143,7 @@ static void yield_task_dl(struct rq *rq)
 	 * it and the bandwidth timer will wake it up and will give it
 	 * new scheduling parameters (thanks to dl_yielded=1).
 	 */
-	rq->curr->dl.dl_yielded = 1;
+	rq->donor->dl.dl_yielded = 1;
 
 	update_rq_clock(rq);
 	update_curr_dl(rq);
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ecb251e883ea..7e0fcfdc06a2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1474,7 +1474,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 static void yield_task_scx(struct rq *rq)
 {
 	struct scx_sched *sch = scx_root;
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq->donor;
 
 	if (SCX_HAS_OP(sch, yield))
 		SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, yield, rq, p, NULL);
@@ -1485,7 +1485,7 @@ static void yield_task_scx(struct rq *rq)
 static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 {
 	struct scx_sched *sch = scx_root;
-	struct task_struct *from = rq->curr;
+	struct task_struct *from = rq->donor;
 
 	if (SCX_HAS_OP(sch, yield))
 		return SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, yield, rq,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb279..aa58c73b0f79 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8993,7 +8993,7 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
  */
 static void yield_task_fair(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr = rq->donor;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	struct sched_entity *se = &curr->se;
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7936d4333731..fb07dcfc60a2 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1490,7 +1490,7 @@ static void requeue_task_rt(struct rq *rq, struct task_struct *p, int head)
 
 static void yield_task_rt(struct rq *rq)
 {
-	requeue_task_rt(rq, rq->curr, 0);
+	requeue_task_rt(rq, rq->donor, 0);
 }
 
 static int find_lowest_rq(struct task_struct *task);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 77ae87f36e84..bf360a6fbb80 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1351,7 +1351,7 @@ static void do_sched_yield(void)
 	rq = this_rq_lock_irq(&rf);
 
 	schedstat_inc(rq->yld_count);
-	current->sched_class->yield_task(rq);
+	rq->donor->sched_class->yield_task(rq);
 
 	preempt_disable();
 	rq_unlock_irq(rq, &rf);
@@ -1420,12 +1420,13 @@ EXPORT_SYMBOL(yield);
  */
 int __sched yield_to(struct task_struct *p, bool preempt)
 {
-	struct task_struct *curr = current;
+	struct task_struct *curr;
 	struct rq *rq, *p_rq;
 	int yielded = 0;
 
 	scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
 		rq = this_rq();
+		curr = rq->donor;
 
 again:
 		p_rq = task_rq(p);
-- 
2.43.0




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


