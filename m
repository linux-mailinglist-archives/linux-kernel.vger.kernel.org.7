Return-Path: <linux-kernel+bounces-731322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C840B05298
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6270C3AE4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482452777F3;
	Tue, 15 Jul 2025 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fr0UuRKN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425A27603A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563772; cv=none; b=t+B1B7m6bH8MFrMcEe0ajDruwrVLt3HZavUvk5jTrMawFNNF+gq4WralHp3ExJLi3UJegLQo11RK4NyNTSGUV39ix1VE5QrbSybqOSsBjRtpXjzis47udRWjnuaebw7RBjQfN2epbRSjIo1eNHKIhL+3w1xAkPyl5knuRwZaEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563772; c=relaxed/simple;
	bh=wFdF7EpXBYFWK9Jbm8c0lN86C3/98hbYMMGEfzZbW9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoC84Ue35Wven58Fe4a1xCYN2aaxIcMoZNVU2xNC3IzFYgylS+ZYumY80D4oYk5o4he3bBOg3PbwOz/oSooK+e+bzuxxdSphk3FcSwcymS9ZyniX7xMSwoultClNijLCbmE84xcmjlWilUJ4g8BGi4n17J3k5pJzrehFf7QIE1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fr0UuRKN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYlgmcKzwEhoS0a9BGFylsAetkBhqQKG1+nbvaKZxSA=;
	b=fr0UuRKNybfTGkUOYMjUnDXWZ1Bb6eoJkW6CYGhielbepk8a5TMfDooUAqo3ccTzffdR7E
	hMITZuPKrOZiz7bANg/3SB0Jqjy0Dv2aE59xy566dG3kKSWXx5MoW6W8AT9g6ZlY28Y3us
	xoVC/kkaT2MgvWwJE0p5E4xLssPtPo8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-MvhcTSVKNjKHJXiaq0bkJQ-1; Tue,
 15 Jul 2025 03:16:08 -0400
X-MC-Unique: MvhcTSVKNjKHJXiaq0bkJQ-1
X-Mimecast-MFC-AGG-ID: MvhcTSVKNjKHJXiaq0bkJQ_1752563767
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA9C11801210;
	Tue, 15 Jul 2025 07:16:06 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF544180045B;
	Tue, 15 Jul 2025 07:16:01 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task model
Date: Tue, 15 Jul 2025 09:14:29 +0200
Message-ID: <20250715071434.22508-13-gmonaco@redhat.com>
In-Reply-To: <20250715071434.22508-1-gmonaco@redhat.com>
References: <20250715071434.22508-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add the following tracepoints:
* sched_set_need_resched(tsk, cpu, tif)
    Called when a task is set the need resched [lazy] flag
* sched_switch_vain(preempt, tsk, tsk_state)
    Called when a task is selected again during __schedule
    i.e. prev == next == tsk : no real context switch

Add new parameter to sched_set_state to identify whether the state
change was due to an explicit call or a signal pending while scheduling.
We now also trace from try_to_block_task in case a signal was pending
and the task is set to runnable.

Also adapt all monitors using sched_set_state to avoid breaking build.

These tracepoints are useful to describe the Linux task model and are
adapted from the patches by Daniel Bristot de Oliveira
(https://bristot.me/linux-task-model/).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/sched.h                  |  7 ++++++-
 include/trace/events/sched.h           | 17 +++++++++++++++--
 kernel/sched/core.c                    | 10 +++++++++-
 kernel/trace/rv/monitors/sco/sco.c     |  3 ++-
 kernel/trace/rv/monitors/sleep/sleep.c |  3 ++-
 kernel/trace/rv/monitors/snroc/snroc.c |  3 ++-
 6 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7bce4c7ae3b4f..19ab4597c97d3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -339,9 +339,11 @@ extern void io_schedule_finish(int token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 
-/* wrapper function to trace from this header file */
+/* wrapper functions to trace from this header file */
 DECLARE_TRACEPOINT(sched_set_state_tp);
 extern void __trace_set_current_state(int state_value);
+DECLARE_TRACEPOINT(sched_set_need_resched_tp);
+extern void __trace_set_need_resched(struct task_struct *curr, int tif);
 
 /**
  * struct prev_cputime - snapshot of system and user cputime
@@ -2059,6 +2061,9 @@ static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
 
 static inline void set_tsk_need_resched(struct task_struct *tsk)
 {
+	if (tracepoint_enabled(sched_set_need_resched_tp) &&
+	    !test_tsk_thread_flag(tsk, TIF_NEED_RESCHED))
+		__trace_set_need_resched(tsk, TIF_NEED_RESCHED);
 	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
 }
 
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 4e6b2910cec3f..c9dec6d38ad2d 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -889,11 +889,24 @@ DECLARE_TRACE(sched_exit,
 	TP_PROTO(bool is_switch, unsigned long ip),
 	TP_ARGS(is_switch, ip));
 
+/*
+ * Tracepoint called when setting the state of a task;
+ * this tracepoint is guaranteed to be called from the waking context of the
+ * task setting the state.
+ */
 DECLARE_TRACE_CONDITION(sched_set_state,
-	TP_PROTO(struct task_struct *tsk, int state),
-	TP_ARGS(tsk, state),
+	TP_PROTO(struct task_struct *tsk, int state, bool from_signal),
+	TP_ARGS(tsk, state, from_signal),
 	TP_CONDITION(!!(tsk->__state) != !!state));
 
+DECLARE_TRACE(sched_set_need_resched,
+	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
+	TP_ARGS(tsk, cpu, tif));
+
+DECLARE_TRACE(sched_switch_vain,
+	TP_PROTO(bool preempt, struct task_struct *tsk, unsigned int prev_state),
+	TP_ARGS(preempt, tsk, prev_state));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81c6df746df17..6cb70e6f7fa17 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -495,7 +495,7 @@ EXPORT_TRACEPOINT_SYMBOL(sched_set_state_tp);
 /* Call via the helper macro trace_set_current_state. */
 void __trace_set_current_state(int state_value)
 {
-	trace_sched_set_state_tp(current, state_value);
+	trace_sched_set_state_tp(current, state_value, false);
 }
 EXPORT_SYMBOL(__trace_set_current_state);
 
@@ -1110,6 +1110,7 @@ static void __resched_curr(struct rq *rq, int tif)
 
 	cpu = cpu_of(rq);
 
+	trace_sched_set_need_resched_tp(curr, cpu, tif);
 	if (cpu == smp_processor_id()) {
 		set_ti_thread_flag(cti, tif);
 		if (tif == TIF_NEED_RESCHED)
@@ -1125,6 +1126,11 @@ static void __resched_curr(struct rq *rq, int tif)
 	}
 }
 
+void __trace_set_need_resched(struct task_struct *curr, int tif)
+{
+	trace_sched_set_need_resched_tp(curr, smp_processor_id(), tif);
+}
+
 void resched_curr(struct rq *rq)
 {
 	__resched_curr(rq, TIF_NEED_RESCHED);
@@ -6592,6 +6598,7 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 	int flags = DEQUEUE_NOCLOCK;
 
 	if (signal_pending_state(task_state, p)) {
+		trace_sched_set_state_tp(p, TASK_RUNNING, true);
 		WRITE_ONCE(p->__state, TASK_RUNNING);
 		*task_state_p = TASK_RUNNING;
 		return false;
@@ -6786,6 +6793,7 @@ static void __sched notrace __schedule(int sched_mode)
 		rq = context_switch(rq, prev, next, &rf);
 	} else {
 		rq_unpin_lock(rq, &rf);
+		trace_sched_switch_vain_tp(preempt, prev, prev_state);
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
 	}
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
index 66f4639d46ac4..c9206aa12c319 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -19,7 +19,8 @@
 static struct rv_monitor rv_sco;
 DECLARE_DA_MON_PER_CPU(sco, unsigned char);
 
-static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
+static void handle_sched_set_state(void *data, struct task_struct *tsk,
+				   int state, bool from_signal)
 {
 	da_handle_start_event_sco(sched_set_state_sco);
 }
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monitors/sleep/sleep.c
index eea447b069071..5103a98818c53 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -82,7 +82,8 @@ static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *mon, bo
 
 }
 
-static void handle_sched_set_state(void *data, struct task_struct *task, int state)
+static void handle_sched_set_state(void *data, struct task_struct *task,
+				   int state, bool from_signal)
 {
 	if (state & TASK_INTERRUPTIBLE)
 		ltl_atom_pulse(task, LTL_SLEEP, true);
diff --git a/kernel/trace/rv/monitors/snroc/snroc.c b/kernel/trace/rv/monitors/snroc/snroc.c
index 540e686e699f4..2651f589d1554 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.c
+++ b/kernel/trace/rv/monitors/snroc/snroc.c
@@ -19,7 +19,8 @@
 static struct rv_monitor rv_snroc;
 DECLARE_DA_MON_PER_TASK(snroc, unsigned char);
 
-static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
+static void handle_sched_set_state(void *data, struct task_struct *tsk,
+				   int state, bool from_signal)
 {
 	da_handle_event_snroc(tsk, sched_set_state_snroc);
 }
-- 
2.50.1


