Return-Path: <linux-kernel+bounces-827592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C5FB92293
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53107A902B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088733126C0;
	Mon, 22 Sep 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRqzP5s6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8231197D;
	Mon, 22 Sep 2025 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557685; cv=none; b=c9qPDmReSe0JXOmKJMCvgCPied11+mtvvIyqMc4LJNRlwCmeeosCwmrag4onTz2XuDzey8KKGkQk9N5W9aMQxFZ8zv6+W9uCbKOqdFudPW7Y9BUOwG7O+o/ezLzDvN5KdCOlX3oLCXXPUk0W+tw0SKnvCpRSAY0d5UEHuWmzisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557685; c=relaxed/simple;
	bh=fjF/wzE63+fDOVGjbw4C2GjQY6O0hB6fbYPYd6ttus0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYFbM45QlpCyu/mVvF2DrO0GMzEw9G6NRBEYRkPimdIbkFTILfDFTmCvVAXgr3kTVdZnrHT8xEXo1+IEK6cUZ6/867SReZEms/v5tfe3Q3NSiYgU7do0N4P6CgvfInwy+9xKdih6/DMEk7K8D3IROUd1YZT9Qltt9l+aFiDUyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRqzP5s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FC1C4CEF7;
	Mon, 22 Sep 2025 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758557684;
	bh=fjF/wzE63+fDOVGjbw4C2GjQY6O0hB6fbYPYd6ttus0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRqzP5s65l2QwKZat1WEKi0w//3fX1geA5RKJXPWh110wX0YuFWooz5vSQ7Ko6G3g
	 eXiyQh4sRWv9n/bA2JBDw0kb0NyYBfWfJItS9411JjwAJhe5tqsqzOSERpoBEGeuKa
	 bNCnTiF247gY85ZhD3qxRr2C2WWjKK897m3u53BM90jYpgzIY+u6JNRcMm0DdmkHm+
	 mlfSIdITyCzU3pwb+e7tW2N1MX0UBv1OKUM5JeE2zNMJiECnvcBz5exMjfMLqgwKVV
	 9sPTdeyvSdDscDf8f5j+z6l08lz+QJ7P7U8PVLSNpOKO9eQ/lBkkSF2mrySN7yAAf2
	 nyMtLEFp3/f1w==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/7] sched_ext: Misc updates around scx_sched instance pointer
Date: Mon, 22 Sep 2025 06:14:36 -1000
Message-ID: <20250922161436.358949-8-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922161436.358949-1-tj@kernel.org>
References: <20250922161436.358949-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for multiple scheduler support:

- Add the @sch parameter to find_global_dsq() and refill_task_slice_dfl().

- Restructure scx_allow_ttwu_queue() and make it read scx_root into $sch.

- Make RCU protection in scx_dsq_move() and scx_bpf_dsq_move_to_local()
  explicit.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 62 ++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0c99a55f199b..32306203fba5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -181,10 +181,9 @@ static bool u32_before(u32 a, u32 b)
 	return (s32)(a - b) < 0;
 }
 
-static struct scx_dispatch_q *find_global_dsq(struct task_struct *p)
+static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch,
+					      struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
-
 	return sch->global_dsqs[cpu_to_node(task_cpu(p))];
 }
 
@@ -880,10 +879,10 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 	WRITE_ONCE(dsq->nr, dsq->nr + delta);
 }
 
-static void refill_task_slice_dfl(struct task_struct *p)
+static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
 	p->scx.slice = SCX_SLICE_DFL;
-	__scx_add_event(scx_root, SCX_EV_REFILL_SLICE_DFL, 1);
+	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
 static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
@@ -901,7 +900,7 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			scx_error(sch, "attempting to dispatch to a destroyed dsq");
 			/* fall back to the global dsq */
 			raw_spin_unlock(&dsq->lock);
-			dsq = find_global_dsq(p);
+			dsq = find_global_dsq(sch, p);
 			raw_spin_lock(&dsq->lock);
 		}
 	}
@@ -1080,20 +1079,20 @@ static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
 		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
 
 		if (!ops_cpu_valid(sch, cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
-			return find_global_dsq(p);
+			return find_global_dsq(sch, p);
 
 		return &cpu_rq(cpu)->scx.local_dsq;
 	}
 
 	if (dsq_id == SCX_DSQ_GLOBAL)
-		dsq = find_global_dsq(p);
+		dsq = find_global_dsq(sch, p);
 	else
 		dsq = find_user_dsq(sch, dsq_id);
 
 	if (unlikely(!dsq)) {
 		scx_error(sch, "non-existent DSQ 0x%llx for %s[%d]",
 			  dsq_id, p->comm, p->pid);
-		return find_global_dsq(p);
+		return find_global_dsq(sch, p);
 	}
 
 	return dsq;
@@ -1272,15 +1271,15 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 * higher priority it becomes from scx_prio_less()'s POV.
 	 */
 	touch_core_sched(rq, p);
-	refill_task_slice_dfl(p);
+	refill_task_slice_dfl(sch, p);
 local_norefill:
 	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
 	return;
 
 global:
 	touch_core_sched(rq, p);	/* see the comment in local: */
-	refill_task_slice_dfl(p);
-	dispatch_enqueue(sch, find_global_dsq(p), p, enq_flags);
+	refill_task_slice_dfl(sch, p);
+	dispatch_enqueue(sch, find_global_dsq(sch, p), p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
@@ -1692,7 +1691,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-			dst_dsq = find_global_dsq(p);
+			dst_dsq = find_global_dsq(sch, p);
 			dst_rq = src_rq;
 		}
 	} else {
@@ -1848,7 +1847,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 
 	if (src_rq != dst_rq &&
 	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, find_global_dsq(p), p,
+		dispatch_enqueue(sch, find_global_dsq(sch, p), p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
@@ -2380,7 +2379,7 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 	if (keep_prev) {
 		p = prev;
 		if (!p->scx.slice)
-			refill_task_slice_dfl(p);
+			refill_task_slice_dfl(rcu_dereference_sched(scx_root), p);
 	} else {
 		p = first_local_task(rq);
 		if (!p) {
@@ -2391,14 +2390,14 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 		}
 
 		if (unlikely(!p->scx.slice)) {
-			struct scx_sched *sch = scx_root;
+			struct scx_sched *sch = rcu_dereference_sched(scx_root);
 
 			if (!scx_rq_bypassing(rq) && !sch->warned_zero_slice) {
 				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in %s()\n",
 						p->comm, p->pid, __func__);
 				sch->warned_zero_slice = true;
 			}
-			refill_task_slice_dfl(p);
+			refill_task_slice_dfl(sch, p);
 		}
 	}
 
@@ -2487,7 +2486,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 
 		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, NULL, 0);
 		if (cpu >= 0) {
-			refill_task_slice_dfl(p);
+			refill_task_slice_dfl(sch, p);
 			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
 		} else {
 			cpu = prev_cpu;
@@ -3572,9 +3571,22 @@ bool task_should_scx(int policy)
 
 bool scx_allow_ttwu_queue(const struct task_struct *p)
 {
-	return !scx_enabled() ||
-		(scx_root->ops.flags & SCX_OPS_ALLOW_QUEUED_WAKEUP) ||
-		p->sched_class != &ext_sched_class;
+	struct scx_sched *sch;
+
+	if (!scx_enabled())
+		return true;
+
+	sch = rcu_dereference_sched(scx_root);
+	if (unlikely(!sch))
+		return true;
+
+	if (scx_root->ops.flags & SCX_OPS_ALLOW_QUEUED_WAKEUP)
+		return true;
+
+	if (unlikely(p->sched_class != &ext_sched_class))
+		return true;
+
+	return false;
 }
 
 /**
@@ -5537,9 +5549,15 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(void)
  */
 __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
 {
-	struct scx_sched *sch = scx_root;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return false;
 
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
-- 
2.51.0


