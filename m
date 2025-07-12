Return-Path: <linux-kernel+bounces-728509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43E4B02926
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 05:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6064585D0B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2807321883C;
	Sat, 12 Jul 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QXmz++u"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DB1FCCF8
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 03:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752291263; cv=none; b=rj/0lihvJaaXILmySVhvyQ8xrCaR6eXcqMIiXr63BGpgQht3U7VWrjNarB6pE+icymvwh//pUec8IYevREPRrW8bg8jBsO8AXItfGahz310wFilYkJYzcleoe9KbeOmPHZ1gIQ81T9xEl+nlzLr/eX7/+aQrk1/rNCd+PmEA1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752291263; c=relaxed/simple;
	bh=w/5Z05JWQxDCXH3VP+Bseb+TW5gj6HkFGljwFSWGQl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QHTWSvCQSZZnzw9+L2us2Yg4Aof/ePwa1uOLsKBFGgyH9+2iQXW3ke2xG9qHF1CqyEfyfkqylDoXhiOusnJziKvTa7kucZrsc1WQT1LyVjfQMDLcxsPO9vBRbZH2ivAJbETdA33XeKz2q2b6mgM4gLBq6Ms5PiN/2FJpUkkCre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QXmz++u; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso2810851a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752291261; x=1752896061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=92EYSjhNLkWOuubLSKggwNqEDGryRbhYkmkTsTaH1Kw=;
        b=2QXmz++utp15+mP6G4lQXuHnSdPHS5KlTHwvBxocQbArbgjH+xb+SLilH2Wih89+P5
         vNxBFpgnzbAjPzTWPGPqhX1GkXrl/nxqpjRiGq7UR+Nou14qTYUadFkofQ8WkBAuy0i0
         qkDDzNyxw4DMwWE/pN3Ryn/rQPMSAEBbC5A/G/QMhxRsNStF9BhdfJw7GwhIhouyzctm
         0lQ+cAO87asmgVxioC+CsFdCTEKvln36bj2NO2o64EMLOlQwuchBEjT+jpXNZFApUq20
         PsFHNCew2D2rR3HSxJp1DF2ockAcnwoZLUsGIJaOBijKgfHOIXi+apoGMgjcYQxV1r4Q
         uidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752291261; x=1752896061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92EYSjhNLkWOuubLSKggwNqEDGryRbhYkmkTsTaH1Kw=;
        b=qZyE2Ml0S7k3EIbvSYDWuL91UJNw5oygQqQOgoCogOZ5bHrnPSFEOvapuPkrAV6PI1
         mHlY5lvwSQEjI++CmHgRaXXj2P0oTjaKA31RxzvjktRcb+9Or2OOULlX+51GhF9JhSb2
         DMXZw25ptzUvhqC1sNwLeRjn7mR9vOD9HusJlfBxfK5ZBnsRw7oFVwgQZ3zZbwFrLftu
         vOqQIkRlt3DBptasb/kdCZ9hEZSXCn/vhbKGtUtjWE1NmaDb9uK+i3TNuGymoYRG6bI0
         FLO3WANA6J76NykjtskbrW7tYEKa1smWqVbP63f3LGURbvohgI1+Z+Mlv4rAK/lVkwsq
         fkKA==
X-Gm-Message-State: AOJu0Yw8LCth0dyO/N3Wi8ywvanLBse0Fh8sMkEUfF2A6PPyHjcC44q/
	xEsMQohtY9DTGtI3Wl5wf6j8W+w1tsAu8OH2L8Hs7X8TP1TE4h5iAmLEApnD7EuV9CUMtVgbC6n
	dkAu6EVCSpKscDFyUV7tjm8Bxqpm363ok/0eHwpY1azXv0/qfE6ooCRfE9zJgQBYhgbmWA07ka+
	tK/ZWOG6Rw60kTtTZUkBtwZq8eKYBXKH4UOAXVdonndKLFKknc
X-Google-Smtp-Source: AGHT+IEyCWYlpG1/Tgz+vYCZ/3nxG4C07Dgg7oG1e2xNdH6yULt54Lsf7nmd7r2hC2LmLQXfahDXdtiPBXOG
X-Received: from pjm3.prod.google.com ([2002:a17:90b:2fc3:b0:311:8076:14f1])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5830:b0:311:df4b:4b7a
 with SMTP id 98e67ed59e1d1-31c4f563387mr6124589a91.29.1752291261004; Fri, 11
 Jul 2025 20:34:21 -0700 (PDT)
Date: Sat, 12 Jul 2025 03:33:46 +0000
In-Reply-To: <20250712033407.2383110-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712033407.2383110-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712033407.2383110-6-jstultz@google.com>
Subject: [PATCH v19 5/8] sched: Fix runtime accounting w/ split exec & sched contexts
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
v19:
* Slight tweak further simplifying update_curr_common() suggested
  by Peter

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
 kernel/sched/fair.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index edcc7d59ecc3b..068002fe15dd8 100644
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
@@ -1211,9 +1221,7 @@ static inline bool do_preempt_short(struct cfs_rq *cfs_rq,
  */
 s64 update_curr_common(struct rq *rq)
 {
-	struct task_struct *donor = rq->donor;
-
-	return update_curr_se(rq, &donor->se);
+	return update_se(rq, &rq->donor->se);
 }
 
 /*
@@ -1221,6 +1229,12 @@ s64 update_curr_common(struct rq *rq)
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
@@ -1229,7 +1243,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (unlikely(!curr))
 		return;
 
-	delta_exec = update_curr_se(rq, curr);
+	delta_exec = update_se(rq, curr);
 	if (unlikely(delta_exec <= 0))
 		return;
 
-- 
2.50.0.727.gbf7dc18ff4-goog


