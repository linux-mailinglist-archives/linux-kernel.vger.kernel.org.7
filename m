Return-Path: <linux-kernel+bounces-892316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D599AC44D68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A68F345DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F96C28CF6F;
	Mon, 10 Nov 2025 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqqtVuFI"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2637285C99
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762745580; cv=none; b=p8/meX4TmyjAGmdc33lIwTMs4D8vLug7k7i8ypGv7uxaJWQP2aumjQANfRhXR8SD14ZRXpB2brBEfXi0E8mTJpqYkphjk9phV5cvrzYZkqudS378TqLtEOMX56Im56QgdYi1nNXcdHNgmsNzljEajOp6dT1MwvzhB+nOgaCuJHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762745580; c=relaxed/simple;
	bh=K+lphNvEVvrv9gfmCYZhBpGCmBM0Fe+h3Fs8GflYSas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZQbsJBY/ed5JiuVYR80NS6EcOI4/kMfvANas7MOYLw6DHzBcsPDt7AMFOrr9wQwu9aKq+cE7QvP3QEEtoQ3HA4geK+fZM6whJqSU2E5ztk787iA8L8G9LHNIPGbR1VFga1Qif28BVuc36y1clrgv0aLONV2BhF/FeieoNRvNnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqqtVuFI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so1479023a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 19:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762745578; x=1763350378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5CylEexNgZw6tRk9eSa035lMMZnjoNawAO+XSe5fkM=;
        b=gqqtVuFI5BgXNC8FYPEreoEUH16NklznaayPlzRgrfS35rZpeXJaSZunlPI0/WVECF
         nJk7x2A5RwY7wBDJ28zJJXyXLJM5vcaAFva9Xl9mskpjdBboIV023a9BQ0NqmCI31L87
         7R42C2azNqOgM2jsgcmUCFJoEFX5MH5txFg4bYvIDZ/m0tG2wRjuuTB5K/6KT0JjBPIW
         6wb84XvzxF9Livb8BU9JyY0gvZ23BVOdaO+JLzdIjQSBqWMXKwd+6aHL0vnlVaQMsjzX
         /CJIjmm0tnNDBYayFmXHMQqNA9G4CV1WtCr80ZUoktlTe53w0fa34oLimARVNbvSWe8Y
         8gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762745578; x=1763350378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5CylEexNgZw6tRk9eSa035lMMZnjoNawAO+XSe5fkM=;
        b=rul7604cJxiDM82VfbhXL8AY3O7RZ0SZfNklwWNkGt2KoeVVOxQ861Bld8IrFG1RR9
         sdKx9amRJKGHmyc9rB9PAjJTMH2mFQRNGkMfq+zLAxNHNaO6XFGlMmHkn5E/epj5vs31
         q0dBrhmHly2K+378QlUzjRu9TGJ/tZ3xqPp908MUpbmh+oL6N5sHcLKXgVPzQs3GgSht
         L1v3MxsfgambaiPyvig/QNH4fWN0C05oL+KCK0oSOFvXve3SOKW9Rmbav+E8rjfiioC1
         ps6APZ08B4NE84zUnz+p7HYkOjcuBzBY+nPfjt8bT/PjNr3cMDKxUONh0st285Y0PdQ5
         ECNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOOc8spNz0N3uvI/HAqEmxMmin/qQNCVTQFRVlYk6dLQqmd6NHb/3DqLdqlD/VNzf3vVpvSpNpOReHU9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxkZ9p3YiHrhdVLvu5F/srQodB5jC7bXDd0uGGtd8yeWnhsbiV
	/iwz1ADegLfWQmi008rpSVCunWxiBcSZ0uFtoH8pymc9nA6ptNJ/9MxK
X-Gm-Gg: ASbGnctj3xaoVhlssc+zB4A1pflwTquXiRzX8QKZGrlXvf84rFI1PxTFkNx+Pq0avdh
	0h75c4sGC1iqqrkAIEgPhwG0HNSf4MtsqVygMcRoFn+xNs3sQZTyi+XYU9Btjf3DfHd/s6YYi65
	l4gw22Bc2K71+MsiywNLmlxnCjA/E9umg3ZNz7hnefq4WvGBuE0oNkN661IZBkvhfM7RIK0b+L+
	O9JnBaL7j0ro/GfUAriokYHdo1heyJ5DTH4YFamsvWpS+MW+8BQW9hcs30DJM1E0wwJvZkVJ/Eu
	049YnUHwQi2LqyhqJSh2EirZXqywtCrQ0Wer3R8COeAFUjYCptveQnvjnadyPWgRUUYXPhP8sQU
	vzeIZQvdQDWPOpZgAvi4XZGP2cjiqyyXpZ38rTzahz5RK/HGg+ldyNPGlPKxWuoDa7/MnwN3rQg
	==
X-Google-Smtp-Source: AGHT+IGez4kk9g88q/buP2zyNcZIHIq1gn1zm8dGzl3wEIxqyDd+cNXnlR/pLncvcW2A4Il/2swyiA==
X-Received: by 2002:a17:902:e80e:b0:268:cc5:5e4e with SMTP id d9443c01a7336-297e561a8femr97012465ad.1.1762745577754;
        Sun, 09 Nov 2025 19:32:57 -0800 (PST)
Received: from wanpengli.. ([124.93.80.37])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ba900fa571esm10913877a12.26.2025.11.09.19.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 19:32:57 -0800 (PST)
From: Wanpeng Li <kernellwp@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 05/10] sched/fair: Wire up yield deboost in yield_to_task_fair()
Date: Mon, 10 Nov 2025 11:32:26 +0800
Message-ID: <20251110033232.12538-6-kernellwp@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110033232.12538-1-kernellwp@gmail.com>
References: <20251110033232.12538-1-kernellwp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wanpeng Li <wanpengli@tencent.com>

From: Wanpeng Li <wanpengli@tencent.com>

Integrate the yield deboost mechanism into yield_to_task_fair() to
improve yield_to() effectiveness for virtualization workloads.

Add yield_to_deboost() as the main entry point that validates tasks,
finds cgroup LCA, updates rq clock and accounting, calculates penalty,
and applies EEVDF field adjustments.

The integration point after set_next_buddy() and before yield_task_fair()
works in concert with the existing buddy mechanism: set_next_buddy()
provides immediate preference, yield_to_deboost() applies bounded
vruntime penalty for sustained advantage, and yield_task_fair()
completes the standard yield path.

This is particularly beneficial for vCPU workloads where lock holder
detection triggers yield_to(), the holder needs sustained preference
to make progress, vCPUs may be organized in nested cgroups,
high-frequency yields require rate limiting, and ping-pong patterns
need debouncing.

Operation occurs under rq->lock with bounded penalties. The feature
can be disabled at runtime via
/sys/kernel/debug/sched/sched_vcpu_debooster_enabled.

Dbench workload in a virtualized environment (16 pCPUs host, 16 vCPUs
per VM running dbench-16 benchmark) shows consistent gains:
  2 VMs: +14.4% throughput
  3 VMs:  +9.8% throughput
  4 VMs:  +6.7% throughput

Performance gains stem from more effective yield_to() behavior,
enabling lock holders to make faster progress and reducing contention
overhead in overcommitted scenarios.

Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 kernel/sched/fair.c | 58 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4bad324f3662..619af60b7ce6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9017,7 +9017,7 @@ static bool yield_deboost_rate_limit(struct rq *rq, u64 now_ns)
  * Returns false with appropriate debug logging if any validation fails,
  * ensuring only safe and meaningful yield operations proceed.
  */
-static bool __maybe_unused yield_deboost_validate_tasks(struct rq *rq, struct task_struct *p_target,
+static bool yield_deboost_validate_tasks(struct rq *rq, struct task_struct *p_target,
 					  struct task_struct **p_yielding_out,
 					  struct sched_entity **se_y_out,
 					  struct sched_entity **se_t_out)
@@ -9066,7 +9066,7 @@ static bool __maybe_unused yield_deboost_validate_tasks(struct rq *rq, struct ta
  * the appropriate level for vruntime adjustments and EEVDF field updates
  * (deadline, vlag) to maintain scheduler consistency.
  */
-static bool __maybe_unused yield_deboost_find_lca(struct sched_entity *se_y, struct sched_entity *se_t,
+static bool yield_deboost_find_lca(struct sched_entity *se_y, struct sched_entity *se_t,
 				    struct sched_entity **se_y_lca_out,
 				    struct sched_entity **se_t_lca_out,
 				    struct cfs_rq **cfs_rq_common_out)
@@ -9162,7 +9162,7 @@ static u64 yield_deboost_apply_debounce(struct rq *rq, struct sched_entity *se_t
  * and implements reverse-pair debounce (~300us) to reduce ping-pong effects.
  * Returns 0 if no penalty needed, otherwise returns clamped penalty value.
  */
-static u64 __maybe_unused yield_deboost_calculate_penalty(struct rq *rq, struct sched_entity *se_y_lca,
+static u64 yield_deboost_calculate_penalty(struct rq *rq, struct sched_entity *se_y_lca,
 				    struct sched_entity *se_t_lca, struct sched_entity *se_t,
 				    int nr_queued)
 {
@@ -9250,7 +9250,7 @@ static u64 __maybe_unused yield_deboost_calculate_penalty(struct rq *rq, struct
  * scheduler state consistency. Returns true on successful application,
  * false if penalty cannot be safely applied.
  */
-static void __maybe_unused yield_deboost_apply_penalty(struct rq *rq, struct sched_entity *se_y_lca,
+static void yield_deboost_apply_penalty(struct rq *rq, struct sched_entity *se_y_lca,
 				 struct cfs_rq *cfs_rq_common, u64 penalty)
 {
 	u64 new_vruntime;
@@ -9303,6 +9303,52 @@ static void yield_task_fair(struct rq *rq)
 	se->deadline += calc_delta_fair(se->slice, se);
 }
 
+/*
+ * yield_to_deboost - deboost the yielding task to favor the target on the same rq
+ * @rq: runqueue containing both tasks; rq->lock must be held
+ * @p_target: task to favor in scheduling
+ *
+ * Cooperates with yield_to_task_fair(): buddy provides immediate preference;
+ * this routine applies a bounded vruntime penalty at the cgroup LCA so the
+ * target keeps advantage beyond the buddy effect. EEVDF fields are updated
+ * to keep scheduler state consistent.
+ *
+ * Only operates on tasks resident on the same rq; throttled hierarchies are
+ * rejected early. Penalty is bounded by granularity and queue-size caps.
+ *
+ * Intended primarily for virtualization workloads where a yielding vCPU
+ * should defer to a target vCPU within the same runqueue.
+ * Does not change runnable order directly; complements buddy selection with
+ * a bounded fairness adjustment.
+ */
+static void yield_to_deboost(struct rq *rq, struct task_struct *p_target)
+{
+	struct task_struct *p_yielding;
+	struct sched_entity *se_y, *se_t, *se_y_lca, *se_t_lca;
+	struct cfs_rq *cfs_rq_common;
+	u64 penalty;
+
+	/* Step 1: validate tasks and inputs */
+	if (!yield_deboost_validate_tasks(rq, p_target, &p_yielding, &se_y, &se_t))
+		return;
+
+	/* Step 2: find LCA in cgroup hierarchy */
+	if (!yield_deboost_find_lca(se_y, se_t, &se_y_lca, &se_t_lca, &cfs_rq_common))
+		return;
+
+	/* Step 3: update clock and current accounting */
+	update_rq_clock(rq);
+	if (se_y_lca != cfs_rq_common->curr)
+		update_curr(cfs_rq_common);
+
+	/* Step 4: calculate penalty (caps + debounce) */
+	penalty = yield_deboost_calculate_penalty(rq, se_y_lca, se_t_lca, se_t,
+						  cfs_rq_common->nr_queued);
+
+	/* Step 5: apply penalty and update EEVDF fields */
+	yield_deboost_apply_penalty(rq, se_y_lca, cfs_rq_common, penalty);
+}
+
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
@@ -9314,6 +9360,10 @@ static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 	/* Tell the scheduler that we'd really like se to run next. */
 	set_next_buddy(se);
 
+	/* Apply deboost under rq lock. */
+	yield_to_deboost(rq, p);
+
+	/* Complete the standard yield path. */
 	yield_task_fair(rq);
 
 	return true;
-- 
2.43.0


