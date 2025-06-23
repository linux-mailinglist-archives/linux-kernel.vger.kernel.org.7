Return-Path: <linux-kernel+bounces-697557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AA0AE35BB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 08:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBF11891E62
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 06:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C434B1DF96F;
	Mon, 23 Jun 2025 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="z5PQYVt5"
Received: from out187-4.us.a.mail.aliyun.com (out187-4.us.a.mail.aliyun.com [47.90.187.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF111DFDA5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660253; cv=none; b=r+EWuXFu5uGJOnNpTXHMTqAQgd/2E3yg8BYsxvE8rHpFEtaFFYUYkWpgBWHtRgRTHvDFsNp4+K/e1Mb4UCZg2fH36kAxRH+9DNN87cz2lFjatgAQDm7vokgctLnjHMdQpIbaKs84EWjin427C0xArXNeG3PW+eXdwzUqP0J/rnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660253; c=relaxed/simple;
	bh=np2M2XvZl67KOzRmbmMgWd4vRESxraGXip8Ff+eOwdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1E0t5u/uizI2Br/sQGxIlEvVTApUErLGJNBUIb5PUiUCAF6cewxTRI3g/7q/Yqer4vLUU8Gt9Gsru7wdTrcy/G2zgQYnRCAXZL32D7r8o3q9osXr+cDdH6993HWBZQtGzLR+5kDejQjGnzz3AEM9nRTvaaf+6n9IMWxiCUDj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=z5PQYVt5; arc=none smtp.client-ip=47.90.187.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1750660238; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SJbjwHcVfD4zpsTrVRO/x5z3h/XBdScRppHdc+YW/LI=;
	b=z5PQYVt5dVjcXPy7t/OHY/dH1Px1tDdLJJxtAN9iHJNHpPj3rq5ko6WEJIKA/sychIdEusES3+pEuX6uEUjWzMgLQCRX6YSjpdKjyMUWrFBeD0MeL7XFXgvlmkrDBSjz8/589w8cpg1VEf+m63n8EqqElyoEI0rzgo1yIaN5ZDs=
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.dUC30ru_1750660237 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 23 Jun 2025 14:30:38 +0800
From: "Henry Huang" <henry.hj@antgroup.com>
To: changwoo@igalia.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com
Cc: "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
  "=?UTF-8?B?WWFuIFlhbihjYWlsaW5nKQ==?=" <yanyan.yan@antgroup.com>,
   <linux-kernel@vger.kernel.org>,
   <sched-ext@lists.linux.dev>,
  "Henry Huang" <henry.hj@antgroup.com>
Subject: [PATCH v3] sched_ext: Implement SCX_OPS_TRACK_MIGRATION
Date: Mon, 23 Jun 2025 14:30:33 +0800
Message-ID: <20250623063033.76808-2-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623063033.76808-1-henry.hj@antgroup.com>
References: <20250623063033.76808-1-henry.hj@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some BPF-schedulers, they should do something when
task is doing migration, such as updating per-cpu map.
If SCX_OPS_TRACK_MIGRATION is set, runnable/quiescent
would be called whether task is doing migration or not.

Signed-off-by: Henry Huang <henry.hj@antgroup.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d86..376e028 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -161,6 +161,12 @@ enum scx_ops_flags {
 	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
 
 	/*
+	 * If set, runnable/quiescent ops would be called whether the task is
+	 * doing migration or not.
+	 */
+	SCX_OPS_TRACK_MIGRATION		= 1LLU << 7,
+
+	/*
 	 * CPU cgroup support flags
 	 */
 	SCX_OPS_HAS_CGROUP_WEIGHT	= 1LLU << 16,	/* DEPRECATED, will be removed on 6.18 */
@@ -172,6 +178,7 @@ enum scx_ops_flags {
 					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
+					  SCX_OPS_TRACK_MIGRATION |
 					  SCX_OPS_HAS_CGROUP_WEIGHT,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
@@ -870,6 +877,7 @@ enum scx_enq_flags {
 	SCX_ENQ_WAKEUP		= ENQUEUE_WAKEUP,
 	SCX_ENQ_HEAD		= ENQUEUE_HEAD,
 	SCX_ENQ_CPU_SELECTED	= ENQUEUE_RQ_SELECTED,
+	SCX_ENQ_MIGRATING	= ENQUEUE_MIGRATING,
 
 	/* high 32bits are SCX specific */
 
@@ -913,6 +921,7 @@ enum scx_enq_flags {
 enum scx_deq_flags {
 	/* expose select DEQUEUE_* flags as enums */
 	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
+	SCX_DEQ_MIGRATING	= DEQUEUE_MIGRATING,
 
 	/* high 32bits are SCX specific */
 
@@ -2390,7 +2399,11 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
 
-	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p))
+	if (task_on_rq_migrating(p))
+		enq_flags |= SCX_ENQ_MIGRATING;
+
+	if (SCX_HAS_OP(sch, runnable) &&
+	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !(enq_flags & SCX_ENQ_MIGRATING)))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, runnable, rq, p, enq_flags);
 
 	if (enq_flags & SCX_ENQ_WAKEUP)
@@ -2463,6 +2476,9 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 		return true;
 	}
 
+	if (task_on_rq_migrating(p))
+		deq_flags |= SCX_DEQ_MIGRATING;
+
 	ops_dequeue(rq, p, deq_flags);
 
 	/*
@@ -2482,7 +2498,8 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, stopping, rq, p, false);
 	}
 
-	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
+	if (SCX_HAS_OP(sch, quiescent) &&
+	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !(deq_flags & SCX_DEQ_MIGRATING)))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, quiescent, rq, p, deq_flags);
 
 	if (deq_flags & SCX_DEQ_SLEEP)
@@ -5495,6 +5512,11 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
+	if ((ops->flags & SCX_OPS_TRACK_MIGRATION) && (!ops->runnable || !ops->quiescent)) {
+		scx_error(sch, "SCX_OPS_TRACK_MIGRATION requires ops.runnable() and ops.quiescent() to be implemented");
+		return -EINVAL;
+	}
+
 	if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
 		pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a noop\n");
 
-- 
Henry


