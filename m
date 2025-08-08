Return-Path: <linux-kernel+bounces-760709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047ACB1EF22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00B1189B787
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B90224AFB;
	Fri,  8 Aug 2025 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4tpGnif3"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F07C38DD8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683411; cv=none; b=py7HSlzD4V46GbKpnvwJjgHOoDwlYxK05u7ixAiA8TvO5RQLEhlLl8jvMajF9TnGHChYrF5KwZ+SFW+/ojV/Eyyo59F4vU4CglXs4vyI6S1T2joxvyQdCCeYjQaHm/FRojw/z5c+22Bdcueis3/9ihe5cVxZDa3WVmgSYI3iC1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683411; c=relaxed/simple;
	bh=QnGicouqjxX4375qN1r/AZitQYdLQdoftWkVyE7Gdxg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=khdGgiv67U1An0tKMAkWgTXSLNtPPwnJY/8E72LhTfHL/EP3PO1nrHqyXUYh2dlQcxG1CJ1v/J7LhPKW26EOKyeJfXPsyO/7qFD2+K0ZcZ4HettgSzA3cYK6p5bzEMB9y2s4etFlYArgmiM/SxzAV+/PCtnrXgf/jH6wXGlTp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4tpGnif3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-459f53d29d2so5746305e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754683408; x=1755288208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQQTdrUE/FoLC6Ybw0i7vf2hpt8f5CSWzafPnqwUGXA=;
        b=4tpGnif3AKhxpp/gc7iWk0fsGMXb6mgdUTQ4jRonfKXsZz+k4VsY2WUq4FpTsdrCYq
         L3v45A3XEdKWOpagSPLvMrM11Y6Dh6SKxVvbsS4jLfUdcdUtu6oYkfyyENwLa0i2GvMz
         VniIoeK6Ryv4v8Ehz/cnjkZId7IXPC0dSHk0uD+2tINlN6na80Fss9TCoc+4tsuH+K/Q
         hhMtxNk5eI92Q71aHPx778IWRqPqN8qjX9i+yJ9rezs1zr/pJQrAIVplVczmUWV//URc
         AWNGHtakcOYznX8ifRlGCyPti4bjEg2CesO/S26ivWM69Az7MNKFUajnTXZAmOTaIzFh
         C8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754683408; x=1755288208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQQTdrUE/FoLC6Ybw0i7vf2hpt8f5CSWzafPnqwUGXA=;
        b=dbDAJpMxn4JBBs2BnAB5qRWp1EYzVOc/u9XUddnTfqJX0+ESIGrGLhN7for67jiw/c
         z3S25nJHgltop9LATVQvxJ9yqpvLigE+QjM1yH25GWsP/kjYEQZBTRHfOGR6ATDkhs/S
         BO2pnv3tgI6CbkISvywkF7KTShBLmTDuP/kOqOR1XRSQ39WxYsyT1NYLgqwVpC5GFuyH
         x9H79nsDtcL7IhKzI4ONfnuavHlLk5BIgJjw6Y85l+qRZcBk4LXCfNH3y1ARjG+bAM57
         zbjy1DHTHHm5aI5HsvVxTuKrSD/UyoaqjwJOWVfpWH8pDubZchPSuDIuDdyxgVMGI19i
         vGow==
X-Gm-Message-State: AOJu0YyulGFWWPeoXxActHoPh3ZID7w08dsgO2ccwc+beS2XfPL7Gv1i
	qqHMxYhHKn/y3tdMUs3jEtYupnmPkw661oT6BZ3W0aGQO8PsuAzjdP8fU79EJ92KscjZGNJM2Te
	WXtJ7NBEz26BaSA==
X-Google-Smtp-Source: AGHT+IEmV7GwfmoE8uf8gbaIXpmsbBca39VQZvtZ0R47yTjMkr0V4ZnD2QV24JHQM5FmkQ95r66GJNYWegaPNA==
X-Received: from wmbhe3.prod.google.com ([2002:a05:600c:5403:b0:459:10dd:2e55])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fcb:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-459f4f3e883mr34390045e9.13.1754683407915;
 Fri, 08 Aug 2025 13:03:27 -0700 (PDT)
Date: Fri,  8 Aug 2025 20:02:48 +0000
In-Reply-To: <20250808200250.2016584-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808200250.2016584-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250808200250.2016584-2-jpiecuch@google.com>
Subject: [RFC PATCH 1/3] sched: add bool return value to sched_class::yield_task()
From: Kuba Piecuch <jpiecuch@google.com>
To: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, joshdon@google.com
Cc: linux-kernel@vger.kernel.org, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

The return value controls whether do_sched_yield() ends up calling
schedule(). This can be used e.g. as an optimization when we're certain
that the yield won't result in another task being scheduled.

This patch does not change the current behavior, i.e. every call to
do_sched_yield() will still go through to schedule().

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/deadline.c  | 4 +++-
 kernel/sched/ext.c       | 4 +++-
 kernel/sched/fair.c      | 6 ++++--
 kernel/sched/rt.c        | 3 ++-
 kernel/sched/sched.h     | 2 +-
 kernel/sched/stop_task.c | 2 +-
 kernel/sched/syscalls.c  | 9 ++++++++-
 7 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 89019a1408264..d8dcb73bd3433 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2194,7 +2194,7 @@ static bool dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
  *   yield_task_dl will indicate that some spare budget
  *   is available for other task instances to use it.
  */
-static void yield_task_dl(struct rq *rq)
+static bool yield_task_dl(struct rq *rq)
 {
 	/*
 	 * We make the task go to sleep until its current deadline by
@@ -2212,6 +2212,8 @@ static void yield_task_dl(struct rq *rq)
 	 * and double the fastpath cost.
 	 */
 	rq_clock_skip_update(rq);
+
+	return true;
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7dd5cbcb7a069..dd0a0b6b7aa05 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2502,7 +2502,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	return true;
 }
 
-static void yield_task_scx(struct rq *rq)
+static bool yield_task_scx(struct rq *rq)
 {
 	struct scx_sched *sch = scx_root;
 	struct task_struct *p = rq->curr;
@@ -2511,6 +2511,8 @@ static void yield_task_scx(struct rq *rq)
 		SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, yield, rq, p, NULL);
 	else
 		p->scx.slice = 0;
+
+	return true;
 }
 
 static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a14da5396fb2..c06a2f8290822 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9010,7 +9010,7 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
 /*
  * sched_yield() is very simple
  */
-static void yield_task_fair(struct rq *rq)
+static bool yield_task_fair(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
@@ -9020,7 +9020,7 @@ static void yield_task_fair(struct rq *rq)
 	 * Are we the only task in the tree?
 	 */
 	if (unlikely(rq->nr_running == 1))
-		return;
+		return true;
 
 	clear_buddies(cfs_rq, se);
 
@@ -9037,6 +9037,8 @@ static void yield_task_fair(struct rq *rq)
 	rq_clock_skip_update(rq);
 
 	se->deadline += calc_delta_fair(se->slice, se);
+
+	return true;
 }
 
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e40422c370335..1fa535457cc40 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1533,9 +1533,10 @@ static void requeue_task_rt(struct rq *rq, struct task_struct *p, int head)
 	}
 }
 
-static void yield_task_rt(struct rq *rq)
+static bool yield_task_rt(struct rq *rq)
 {
 	requeue_task_rt(rq, rq->curr, 0);
+	return true;
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 83e3aa9171429..8b2cd54a09942 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2395,7 +2395,7 @@ struct sched_class {
 
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
 	bool (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
-	void (*yield_task)   (struct rq *rq);
+	bool (*yield_task)   (struct rq *rq);
 	bool (*yield_to_task)(struct rq *rq, struct task_struct *p);
 
 	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 058dd42e3d9b5..c6da16a39e08d 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -54,7 +54,7 @@ dequeue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 	return true;
 }
 
-static void yield_task_stop(struct rq *rq)
+static bool yield_task_stop(struct rq *rq)
 {
 	BUG(); /* the stop task should never yield, its pointless. */
 }
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 547c1f05b667e..e708a31c8e313 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1354,11 +1354,18 @@ static void do_sched_yield(void)
 {
 	struct rq_flags rf;
 	struct rq *rq;
+	bool should_resched;
 
 	rq = this_rq_lock_irq(&rf);
 
+	should_resched = current->sched_class->yield_task(rq);
+
+	if (unlikely(!should_resched)) {
+		rq_unlock_irq(rq, &rf);
+		return;
+	}
+
 	schedstat_inc(rq->yld_count);
-	current->sched_class->yield_task(rq);
 
 	preempt_disable();
 	rq_unlock_irq(rq, &rf);
-- 
2.51.0.rc0.155.g4a0f42376b-goog


