Return-Path: <linux-kernel+bounces-720514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7FDAFBCBD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77384A6B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5984A267732;
	Mon,  7 Jul 2025 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPx5bRj2"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A8262FFF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921065; cv=none; b=t+ajNGJlhjuyisiM3ri2ssSvf78wmTCmUEimtds3A0L2xBpaAv8QTr35AN9zSub9/PoBbgzI559/9hJlSAxfNuMce901Loac4trclMFxvS7JTaK3NDQWXrHupRtlBE0kt8YQdmBoOSD3tHJjqgaMtdFOCb6//QMMuvCdwt4ehUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921065; c=relaxed/simple;
	bh=lqAQZVltZS+lvkWKjTT0msQEex9/pUi+VcnFxgyd7tc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GWMeR62TxEjlysPAT25sUqrf4/6H6nMg9lbH/4HaZxhAq9ePKJ/nF4YlszFJQZgAv621M02hZJERrME2C7NRVXYKVhnEJ5ftRXxDcSEylA+uNjNji+ZwgKHIzaY6TDRCT5e8n/zkvX//gHNVEZ3z9Uom2wkBFJzF7al+WZkCPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPx5bRj2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b00e4358a34so2187948a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751921063; x=1752525863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHue3Nd9RiQZ9pLuaob+NG3Hrx0YWPuPvJ+cxebN6WE=;
        b=BPx5bRj28bZGHpRbLRvhJ3bMh8lZH5L/1PSUkWySx6RugOCslQq9QISN+rGfrRXks1
         FK1p2h0xlIvoqfL2l6usFNLAO+7/G5xtHvIgU5F/4yNUzFfCFn8b4mFt9KUhIuGRzU24
         XqftFV/dq+qrRnaKiEIz5hEfL8TpB01JkAret6fmDZZWOoICHrtAMOpBxMaOz3Ih/O4V
         /kzLck3dflJ1ktPPHJHLc5pdn8mujZbd8NztzchIm6NJ+FU8xBHNcUsbf+sxdTXt+etX
         eDz+GzX8n70ztP1nzAXuCqyEYcM/vNuli3uEYb+1htkef/I7El7uh17iYU+PNMGZdzh7
         BhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921063; x=1752525863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHue3Nd9RiQZ9pLuaob+NG3Hrx0YWPuPvJ+cxebN6WE=;
        b=X7qJYtX7DFZxZk7fR/wCvrukKWKN7NRVY1ZUfej28HdlQxLplzrXRUkLcoNblsmI0C
         xyr08Xm/tj7xGC8lW0dJQP7bNw0jMr8fJ4Kf3wjwFUSqWyFzkP5MQortaPe6l2Wo/uh3
         vUxVdLzBiowRZj8ct1IgXrQGOv2c0j+8x9g70Ruy8Lj5KSQn5kgaj2R4VLgbqsmMLzp2
         rBr/V9dM1bP2JFJUx91tQWU0/AOcVa1foHR3eDazCmmWkPS9DY03wnBRqQOqk3D/L3DL
         6kHtrLbSoDYqyorRPrx+WqV0gVvssG8a6YSVQBiu0+E/sNT4T0Z0bhnSdhN31xXra9MA
         fBSA==
X-Gm-Message-State: AOJu0YzVTc3xZvu7EMwSoBSqntcQDjsQ5zPcqQLJ5SPDV010NVdj8UMU
	JeZ0ZYi7fRbXfSBPdC8clLA8U8pnG5Ftc4rqRXrZEW6qNSFKo7JMT0JghAIeQsXv8bhjb3DE1ug
	Z7f49Sg+0azD0azF2kEZPuCzlNGd322X1qHuf9EjQ2GplrDo+nOKQPCz3djWfbmMbMgy21+KXMg
	BJXYmSuUmspR7ghVEbuabEV+vgqqyQqexVMFrba6QkZIMZjkdp
X-Google-Smtp-Source: AGHT+IEx5x4iZCDdsZic7GyPUoMuUfWYSVOK7+h6vDSyUXV5CkzHltFTs3EkzA0DtyGgC8tGfTk1Hns49q5r
X-Received: from pgac12.prod.google.com ([2002:a05:6a02:294c:b0:b34:c32a:5da8])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9998:b0:218:9b3e:e8bd
 with SMTP id adf61e73a8af0-2260998b100mr20934369637.10.1751921062916; Mon, 07
 Jul 2025 13:44:22 -0700 (PDT)
Date: Mon,  7 Jul 2025 20:43:52 +0000
In-Reply-To: <20250707204409.1028494-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707204409.1028494-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707204409.1028494-6-jstultz@google.com>
Subject: [RESEND][PATCH v18 5/8] sched: Fix runtime accounting w/ split exec &
 sched contexts
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>, 
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Without proxy-exec, we normally charge the "current" task for
both its vruntime as well as its sum_exec_runtime.

With proxy, however, we have two "current" contexts: the
scheduler context and the execution context. We want to charge
the execution context rq->curr (ie: proxy/lock holder) execution
time to its sum_exec_runtime (so it's clear to userland the
rq->curr task *is* running), as well as its thread group.

However the rest of the time accounting (such a vruntime and
cgroup accounting), we charge against the scheduler context
(rq->donor) task, because it is from that task that the time
is being "donated".

If the donor and curr tasks are the same, then it's the same as
without proxy.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v16:
* Renamed update_curr_se to update_se_times, as suggested by
  Steven Rostedt.
* Reworded the commit message as suggested by Steven Rostedt
v17:
* Renamed update_se_times to update_se, as suggested by Peter
* Added comment calrifying cfs_rq->curr being rq->donor.se as
  suggested by Peter
* Reworked to fix issue Peter pointed out with thread group
  accounting being done on the donor, rather then the running
  execution context.
* Slight rewording of the commit message to further clairifiy
  things.

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kuyo chang <kuyo.chang@mediatek.com>
Cc: hupu <hupu.gm@gmail.com>
Cc: kernel-team@android.com
---
 kernel/sched/fair.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index edcc7d59ecc3b..c34e0891193a7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1143,30 +1143,40 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
-static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
+static s64 update_se(struct rq *rq, struct sched_entity *se)
 {
 	u64 now = rq_clock_task(rq);
 	s64 delta_exec;
 
-	delta_exec = now - curr->exec_start;
+	delta_exec = now - se->exec_start;
 	if (unlikely(delta_exec <= 0))
 		return delta_exec;
 
-	curr->exec_start = now;
-	curr->sum_exec_runtime += delta_exec;
+	se->exec_start = now;
+	if (entity_is_task(se)) {
+		struct task_struct *donor = task_of(se);
+		struct task_struct *running = rq->curr;
+		/*
+		 * If se is a task, we account the time against the running
+		 * task, as w/ proxy-exec they may not be the same.
+		 */
+		running->se.exec_start = now;
+		running->se.sum_exec_runtime += delta_exec;
 
-	if (entity_is_task(curr)) {
-		struct task_struct *p = task_of(curr);
+		trace_sched_stat_runtime(running, delta_exec);
+		account_group_exec_runtime(running, delta_exec);
 
-		trace_sched_stat_runtime(p, delta_exec);
-		account_group_exec_runtime(p, delta_exec);
-		cgroup_account_cputime(p, delta_exec);
+		/* cgroup time is always accounted against the donor */
+		cgroup_account_cputime(donor, delta_exec);
+	} else {
+		/* If not task, account the time against donor se  */
+		se->sum_exec_runtime += delta_exec;
 	}
 
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
 
-		stats = __schedstats_from_se(curr);
+		stats = __schedstats_from_se(se);
 		__schedstat_set(stats->exec_max,
 				max(delta_exec, stats->exec_max));
 	}
@@ -1213,7 +1223,7 @@ s64 update_curr_common(struct rq *rq)
 {
 	struct task_struct *donor = rq->donor;
 
-	return update_curr_se(rq, &donor->se);
+	return update_se(rq, &donor->se);
 }
 
 /*
@@ -1221,6 +1231,12 @@ s64 update_curr_common(struct rq *rq)
  */
 static void update_curr(struct cfs_rq *cfs_rq)
 {
+	/*
+	 * Note: cfs_rq->curr corresponds to the task picked to
+	 * run (ie: rq->donor.se) which due to proxy-exec may
+	 * not necessarily be the actual task running
+	 * (rq->curr.se). This is easy to confuse!
+	 */
 	struct sched_entity *curr = cfs_rq->curr;
 	struct rq *rq = rq_of(cfs_rq);
 	s64 delta_exec;
@@ -1229,7 +1245,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (unlikely(!curr))
 		return;
 
-	delta_exec = update_curr_se(rq, curr);
+	delta_exec = update_se(rq, curr);
 	if (unlikely(delta_exec <= 0))
 		return;
 
-- 
2.50.0.727.gbf7dc18ff4-goog


