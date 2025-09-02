Return-Path: <linux-kernel+bounces-797482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43210B410ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD55F7A4A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5B02EAB94;
	Tue,  2 Sep 2025 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgllXmHb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE352EAB78
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856905; cv=none; b=OqBj3iO5pB5cj24ug/19LIZPZnanl0z+71I8SXxJ6Ds8JLw+3MADfYFv16pLwCvXLMgbuJ9Y86W7Ahr+3oIOUMOtQN6QYT5taAulLTv6yCU4rgyTAMQdv8lZs3yrsqYi1mWC8AYeq84D5x3/rNAn6zFMYNHP8TV2yxiRBfRyJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856905; c=relaxed/simple;
	bh=xDv6vhrL7sxcYjlEEI4BmfE07NKbTZVzlronQFUOBfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjGemr7avizVrpZWxr7Ot8WC97c/aKV2INCIf0DN44/RMLjtMxPLG4NHYvnthmkJ66C4BIJJmbSgkaZO57B6L1Lj00iLGlZIAmtPKw6yfTNGQsuhd6tf7935DfGKrCZXa2O2knU2LSu7/W/XZv7tGyfoWQsmwEMQvXCrPfwpyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgllXmHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABE6C4CEED;
	Tue,  2 Sep 2025 23:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756856905;
	bh=xDv6vhrL7sxcYjlEEI4BmfE07NKbTZVzlronQFUOBfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgllXmHbX6D7KRo5bH4pG06Y/CwJHkjhKDf8a1caRORlEkVcmwAP/9lnQcN8Q/hXt
	 ibJ5//TwrcOnyXpJkHyMVWBXG/IrIpe4woJvN8/6+3qgvpeT1F1WQmMc7LoaG6462v
	 7JnS4LoGacvQX0wn+HP9Gb5Au+Qhq76QCqDQjNnyUFbUOVllYky4bdir8nskaoE6gO
	 44nlPSY9iHzzvFFPjclcV2+olDGbw/mY6dfzzbLaP9w4/LeSD60nUbTtlxx0++O/xS
	 vSV92k9KV0duysD3y137ifGnlo3p3lXAxmxC16OGLm0yNpZfacaKNqS+6/POnPq0Yt
	 4FJxgzfSZfWcQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] sched_ext: Put event_stats_cpu in struct scx_sched_pcpu
Date: Tue,  2 Sep 2025 13:48:06 -1000
Message-ID: <20250902234817.279206-5-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902234817.279206-1-tj@kernel.org>
References: <20250902234817.279206-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_sched.event_stats_cpu is the percpu counters that are used to track
stats. Introduce struct scx_sched_pcpu and move the counters inside. This
will ease adding more per-cpu fields. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 18 +++++++++---------
 kernel/sched/ext_internal.h | 17 ++++++++++-------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7e15e852370c..701ca239ad00 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -635,7 +635,7 @@ static struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
  * This can be used when preemption is not disabled.
  */
 #define scx_add_event(sch, name, cnt) do {					\
-	this_cpu_add((sch)->event_stats_cpu->name, (cnt));			\
+	this_cpu_add((sch)->pcpu->event_stats.name, (cnt));			\
 	trace_sched_ext_event(#name, (cnt));					\
 } while(0)
 
@@ -648,7 +648,7 @@ static struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
  * This should be used only when preemption is disabled.
  */
 #define __scx_add_event(sch, name, cnt) do {					\
-	__this_cpu_add((sch)->event_stats_cpu->name, (cnt));			\
+	__this_cpu_add((sch)->pcpu->event_stats.name, (cnt));			\
 	trace_sched_ext_event(#name, cnt);					\
 } while(0)
 
@@ -3543,7 +3543,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	int node;
 
 	kthread_stop(sch->helper->task);
-	free_percpu(sch->event_stats_cpu);
+	free_percpu(sch->pcpu);
 
 	for_each_node_state(node, N_POSSIBLE)
 		kfree(sch->global_dsqs[node]);
@@ -4444,13 +4444,13 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 		sch->global_dsqs[node] = dsq;
 	}
 
-	sch->event_stats_cpu = alloc_percpu(struct scx_event_stats);
-	if (!sch->event_stats_cpu)
+	sch->pcpu = alloc_percpu(struct scx_sched_pcpu);
+	if (!sch->pcpu)
 		goto err_free_gdsqs;
 
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
 	if (!sch->helper)
-		goto err_free_event_stats;
+		goto err_free_pcpu;
 	sched_set_fifo(sch->helper->task);
 
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
@@ -4468,8 +4468,8 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 
 err_stop_helper:
 	kthread_stop(sch->helper->task);
-err_free_event_stats:
-	free_percpu(sch->event_stats_cpu);
+err_free_pcpu:
+	free_percpu(sch->pcpu);
 err_free_gdsqs:
 	for_each_node_state(node, N_POSSIBLE)
 		kfree(sch->global_dsqs[node]);
@@ -6493,7 +6493,7 @@ static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *event
 	/* Aggregate per-CPU event counters into @events. */
 	memset(events, 0, sizeof(*events));
 	for_each_possible_cpu(cpu) {
-		e_cpu = per_cpu_ptr(sch->event_stats_cpu, cpu);
+		e_cpu = &per_cpu_ptr(sch->pcpu, cpu)->event_stats;
 		scx_agg_event(events, e_cpu, SCX_EV_SELECT_CPU_FALLBACK);
 		scx_agg_event(events, e_cpu, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE);
 		scx_agg_event(events, e_cpu, SCX_EV_DISPATCH_KEEP_LAST);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 76690ede8700..af4c054fb6f8 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -846,6 +846,15 @@ struct scx_event_stats {
 	s64		SCX_EV_BYPASS_ACTIVATE;
 };
 
+struct scx_sched_pcpu {
+	/*
+	 * The event counters are in a per-CPU variable to minimize the
+	 * accounting overhead. A system-wide view on the event counter is
+	 * constructed when requested by scx_bpf_events().
+	 */
+	struct scx_event_stats	event_stats;
+};
+
 struct scx_sched {
 	struct sched_ext_ops	ops;
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
@@ -860,13 +869,7 @@ struct scx_sched {
 	 */
 	struct rhashtable	dsq_hash;
 	struct scx_dispatch_q	**global_dsqs;
-
-	/*
-	 * The event counters are in a per-CPU variable to minimize the
-	 * accounting overhead. A system-wide view on the event counter is
-	 * constructed when requested by scx_bpf_events().
-	 */
-	struct scx_event_stats __percpu *event_stats_cpu;
+	struct scx_sched_pcpu __percpu *pcpu;
 
 	bool			warned_zero_slice;
 
-- 
2.51.0


