Return-Path: <linux-kernel+bounces-728508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40BB02924
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 05:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7D0585AF1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B57C1FFC59;
	Sat, 12 Jul 2025 03:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4X20kRN"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2801F7575
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752291262; cv=none; b=XzoCV+wG1rrZYtgPpz2TxqUDtc8ujefwc5dqiKiooDIbBGBIilMIOwWmh1dfjfCG1lcyRWRGICEZLrY8zD1PKaCnPPin3M6DdkQQMTKjJMmjm0CIo73ZL9tC/Gt8b/e02T7SEQLw4TkV4D7nsyjBF9xk5xZCUgoeNPJbwTUgOxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752291262; c=relaxed/simple;
	bh=E9BRbJXMe0/nYQ1bgCddiiXCeZLlpdEjEZgz4SOKuY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hG8rSC8QBzQsNCQv+8nbZLy8TysNci3k+Epi8p0t+Kae3lN/JhfDe3OPXRAjIur7BgFSfYLiZv+7YcLc6vtF6KhI/vf0tilJ2BMFpO9B8mNYU9w/DgHrirYGKLgz8wc5CxLFbwaEs/1KgeMSCo0qiv3ifr1JmLLUny3FrL3EnlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4X20kRN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313f702d37fso2852240a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752291259; x=1752896059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+AbZUBhL4AUdhsW/eOFIK7IUkWM1FRN3cRsd+jlZ1ow=;
        b=u4X20kRNQWlOQ0Ho1ORe5pgH6mulrRztHuJ8P4CjVM7S8HQmQxqUrtXWQA/HJwHx0Z
         CClohshgvdaTnYzjN7QOxlZewnovaGeJbwPKUmT50FK1nAxVAF2e+3rRZreXnqpFUuGX
         kbi9AkdRIPgUYKV0sEOxn1U33k03FXXXpEwH3+6hLG8yCSBrRQ4p57lxG3IHF17c1I3I
         b5SIuxX13cSP0D1jMcroiQlc/IufyEZdt64SdgB/tzXd8VQe2MJ3XkguFmkZT9jek53r
         n4dOwT1o5lFPU/CqNjYDM2KDALHhDOLNT3Ps8N6pb5J0pJ2UUxVV3hwDe2mxrMvcT27H
         8AOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752291259; x=1752896059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AbZUBhL4AUdhsW/eOFIK7IUkWM1FRN3cRsd+jlZ1ow=;
        b=SjT0tec1I+q6HSFD3W3BcL+gEZcytPpRSRcB1wO4A1Zrmwybbrug/m0PCk9Mdw8YmT
         KnRTGp28FigtJKdKkgVJNLGBJvDBms/ZpOi0jdw7GorcnWDIr/pVsPLaCzIC+KAFkq8S
         oayowdYsNgEp1rr0VOivYpDgpNQHqEgGo2+3bQue5SnA1GepTHqwH14hj4K4g7Yp1r14
         /jnea3tFSCFPnNvNmMz30kU2Lh/nUwpC+6+YI3BVGjikJfFGWjDGSInbQfp3ODB5Pr9M
         SWNg8JTUEpQ/Mb29TmznS/MLOVT1IB4Oo+UwlT3fqNUGkf4lAWs3DEPkJN2URZ1PNNIj
         B2oQ==
X-Gm-Message-State: AOJu0YziKbT4pYcGa1XtRnffvNK691Kvc1Ts5AD5Y93/XzMRId2IKCZJ
	UOpjcYq4r1PHzeQ8TqDkq5sB4Ymn6S8w55ErKIdCcE0BXS5v364XCl6CPpV5CvcgNcaaHg3Zc6j
	udpac+mXmTCM/Gd8VWNgRVvQh0s+MLObYdsVPXXk+8D4pxTP/4h+ooeDxCekDn9dEvylNM/T5eF
	TQhbOQ6Ewwtr5a9INBpea3+BDH9Q7iIATqmUqvndF7ymS5I1yR
X-Google-Smtp-Source: AGHT+IHA6gpxwJ68POuktr0YtPoE3QpMcvDqvrNo/5dRbr0PMMwnya6OZ7i4kbzGZRNpBuM9BofZQTDp2zsM
X-Received: from pjbqx4.prod.google.com ([2002:a17:90b:3e44:b0:315:f140:91a5])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d89:b0:312:f650:c795
 with SMTP id 98e67ed59e1d1-31c4f512ab0mr6831733a91.21.1752291259457; Fri, 11
 Jul 2025 20:34:19 -0700 (PDT)
Date: Sat, 12 Jul 2025 03:33:45 +0000
In-Reply-To: <20250712033407.2383110-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712033407.2383110-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712033407.2383110-5-jstultz@google.com>
Subject: [PATCH v19 4/8] sched: Move update_curr_task logic into update_curr_se
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


