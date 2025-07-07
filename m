Return-Path: <linux-kernel+bounces-720513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F4AFBCBB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF4E16FF78
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC1264F81;
	Mon,  7 Jul 2025 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpyxPpVu"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6322F75B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921063; cv=none; b=fGshN9JshYVGDV+x6ITnV/Es2v+hhbLyeuoa7+mBYz+06iTXCIzBFMsiRrgaZI2YyuEqSoEo2gKnhvc2f+vN2qLf7WwQuxRUHZxj7lozkRkNS2cErOJtTVmkjgftG7ifvpr/aPOzd00feiW8Ojy5S2SdlIaQOaEQLc3Vi5O/PiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921063; c=relaxed/simple;
	bh=E9BRbJXMe0/nYQ1bgCddiiXCeZLlpdEjEZgz4SOKuY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mGtbyvFz6lIy7ARM/YKQX8lXMm8ckoiakcI1ygrmATm+jG40e0p3XhOEhpssEW36dlo/uneAr03uX5Ugkoc7pDobcWopWYRJ8lCot0X7ZIY6A/eH/OVDsWmUJJFhZBy0su8ymNJI4fg5Hr/l6f3fdIG5nkEY+xEiBzxqX0DaJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpyxPpVu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748cf01de06so5863778b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751921061; x=1752525861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+AbZUBhL4AUdhsW/eOFIK7IUkWM1FRN3cRsd+jlZ1ow=;
        b=mpyxPpVupKcrocJ+Vth09O9u2homMR6uWkW2V1L2wHw5dF53rW6i1TI22Rha42Qohu
         xxFK3qn76Fh2IL+9VZK8ZClQDW2LlX4LMSw/t3cmVBf4s8PoXus+3zL7/M2GOJJIrim9
         zmVDW7dGYZuf91YBdHV00p5OQpmgejFfm89I6X7Jjj0I582ucWnxoTL+4wpRq3vkRLrs
         dIIsiDTUBzzvISAJlzgAWzVCAjxB2zx42X57JoIrlrGuuyFanNNrQ/gc9cIbE7rkEjqo
         GeQ5SP0KAByBfnn/gJGZ83a+EBZ4QUjEfuKmQLtphTYxZGirbiQKxaljZmzvNrA2Liz0
         rhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921061; x=1752525861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AbZUBhL4AUdhsW/eOFIK7IUkWM1FRN3cRsd+jlZ1ow=;
        b=IlKcx2SWlezx3cqheBxmPmX9TQfE0VPFyVc7AqM+hInKXrjTRslAqNReuRRFAf8uxE
         YeNPcSxpv8o8IgEKLhvoLX8TfVgqwxH5uOy0PWVvXzW9NxlJIHLWDtwKKxx/rEgrWyJw
         P8nSKDDbZNoPlAtXxOnyosvMf8cVAIQEOGCZWGQZHrztrz4exZMyqWB82Ff3soZBrbz8
         KrJKX5qvn20W+E79L7tr/pMSZOPyFqUmRUSYfeIjQbt95Rr7Q82hMS/1P0fUGH/BGHRy
         u5AkMUlDY3DWqR7WYZ/McnOl4ezev0LyEpLmA9qzT3tELKz4aZzI2lrglKsbydxw2Uji
         rkkw==
X-Gm-Message-State: AOJu0Ywm+YwYytvKqoixA+livLj02fqdGyAssB28J3i2lAkoTiLhlfX+
	8p7rrDTaZfr9trh3KGlgme0e48eKGQUYp+LFsTSZSReHJ7N/p6KB0Bjm13m3wQjQkfZdwYcmeyW
	bqCRcu6QrsHtlZMmWq2f2neJ/yKrDkWpW1NIcMrYjZyJhGEAV+zLzbUuJYkUDYElzozE4mZ0jWj
	FSkSzzibPZelCj/dpwa39jMDuY+K6CsUi0+tngS7Tch3rb5MHj
X-Google-Smtp-Source: AGHT+IH8AysgDbvr2jlirLawkTwfcXO2Tis4TXmiByHOmfCB95ums6tA2sAk201MUw+plz37ikslD1NFSWIc
X-Received: from pfbhg10.prod.google.com ([2002:a05:6a00:860a:b0:749:1e51:d39a])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d94:b0:748:311a:8aef
 with SMTP id d2e1a72fcca58-74ce66697admr20248541b3a.12.1751921061334; Mon, 07
 Jul 2025 13:44:21 -0700 (PDT)
Date: Mon,  7 Jul 2025 20:43:51 +0000
In-Reply-To: <20250707204409.1028494-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707204409.1028494-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707204409.1028494-5-jstultz@google.com>
Subject: [RESEND][PATCH v18 4/8] sched: Move update_curr_task logic into update_curr_se
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

Absorb update_curr_task() into update_curr_se(), and
in the process simplify update_curr_common().

This will make the next step a bit easier.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
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
 kernel/sched/fair.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a14da5396fb2..edcc7d59ecc3b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1155,6 +1155,14 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 	curr->exec_start = now;
 	curr->sum_exec_runtime += delta_exec;
 
+	if (entity_is_task(curr)) {
+		struct task_struct *p = task_of(curr);
+
+		trace_sched_stat_runtime(p, delta_exec);
+		account_group_exec_runtime(p, delta_exec);
+		cgroup_account_cputime(p, delta_exec);
+	}
+
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
 
@@ -1166,13 +1174,6 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 	return delta_exec;
 }
 
-static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
-{
-	trace_sched_stat_runtime(p, delta_exec);
-	account_group_exec_runtime(p, delta_exec);
-	cgroup_account_cputime(p, delta_exec);
-}
-
 static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	if (!sched_feat(PREEMPT_SHORT))
@@ -1211,13 +1212,8 @@ static inline bool do_preempt_short(struct cfs_rq *cfs_rq,
 s64 update_curr_common(struct rq *rq)
 {
 	struct task_struct *donor = rq->donor;
-	s64 delta_exec;
 
-	delta_exec = update_curr_se(rq, &donor->se);
-	if (likely(delta_exec > 0))
-		update_curr_task(donor, delta_exec);
-
-	return delta_exec;
+	return update_curr_se(rq, &donor->se);
 }
 
 /*
@@ -1242,10 +1238,6 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
-		struct task_struct *p = task_of(curr);
-
-		update_curr_task(p, delta_exec);
-
 		/*
 		 * If the fair_server is active, we need to account for the
 		 * fair_server time whether or not the task is running on
-- 
2.50.0.727.gbf7dc18ff4-goog


