Return-Path: <linux-kernel+bounces-748602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561A1B14380
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F49C4E2EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E097E27A92B;
	Mon, 28 Jul 2025 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ0B6VaK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8C22A4EB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735786; cv=none; b=LJyvWBHNn+TPAP8TqAg7u3fLN6U7X8H7aC/2DuZ65t1yT6/Qu8sdXFXL7FJDi1xz7DgkALP/HbnhYSWGKLYt+ub4R5G5tEDDJ7wKZzPlMwP94F+zQX8PPJAH3YcTdFYFIRcBYmgKtZBqof3UJonbF93cOCOWP5Wwog/wLvMxBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735786; c=relaxed/simple;
	bh=FGd6uP//wL11kLSl1PdCcAAVYZSczd25hHGCi590xPw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ok89Ti9PVPGteezWendkThA6aQf61++T8qI+dsbD0tbTUIAPIIfOpV/WiO2I8leNsyefCmYALd8xO5YZCo1jYNzOVL2NaufaOxRtxsf0vTL0RWnptDhFSmAHVdglu0RISOL5cNvk9jiZPlh4NndafAaVauId9xzg09gIFWCZ+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ0B6VaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BC7C4CEF7;
	Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753735786;
	bh=FGd6uP//wL11kLSl1PdCcAAVYZSczd25hHGCi590xPw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=SJ0B6VaK+WTX9Le2/5IuCvGjugtu7ooT+pqyHFGKSbfneqfn7EK5Z+g8ZDmUYm731
	 kggtnYwf1UkVAHo3I9G6ylAwxA+Til1SAc9NWlK7rZtvknuxHIYm6YTnWexTDiCtfD
	 3FIw6BQVcjJfwcwY08gQOYWLGXzOLTTvng0qbyE1qBwux+DPYoi4enTP6mQsmKPe1c
	 Vwe9ym5dzVgQf5RMb/q9svxnb9mE/M3fY0ISMfowZFJr8et6P6Oc5fJ5AT+89vCGoq
	 9ns07pk5NOCSf51uWuNhFuerW7nrwtWLKafBzROxyQ83XTbZAFJ0g5s5iyFLv0hQ4g
	 bL/EikSCh3LlA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugUnH-000000042xm-0zzZ;
	Mon, 28 Jul 2025 16:49:59 -0400
Message-ID: <20250728204959.088532429@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 28 Jul 2025 16:49:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Nam Cao <namcao@linutronix.de>,
 Juri Lelli <jlelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 08/11] sched: Adapt sched tracepoints for RV task model
References: <20250728204934.281385756@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

Add the following tracepoint:
* sched_set_need_resched(tsk, cpu, tif)
    Called when a task is set the need resched [lazy] flag

Remove the unused ip parameter from sched_entry and sched_exit and alter
sched_entry to have a value of preempt consistent with the one used in
sched_switch.

Also adapt all monitors using sched_{entry,exit} to avoid breaking build.

These tracepoints are useful to describe the Linux task model and are
adapted from the patches by Daniel Bristot de Oliveira
(https://bristot.me/linux-task-model/).

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Link: https://lore.kernel.org/20250728135022.255578-7-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/sched.h                  |  7 ++++++-
 include/trace/events/sched.h           | 12 ++++++++----
 kernel/sched/core.c                    | 13 ++++++++++---
 kernel/trace/rv/monitors/sco/sco.c     |  4 ++--
 kernel/trace/rv/monitors/scpd/scpd.c   |  4 ++--
 kernel/trace/rv/monitors/sncid/sncid.c |  4 ++--
 kernel/trace/rv/monitors/snep/snep.c   |  4 ++--
 kernel/trace/rv/monitors/tss/tss.c     |  4 ++--
 8 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fabd7fe1a07a..91d1fdbc2f56 100644
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
@@ -2063,6 +2065,9 @@ static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
 
 static inline void set_tsk_need_resched(struct task_struct *tsk)
 {
+	if (tracepoint_enabled(sched_set_need_resched_tp) &&
+	    !test_tsk_thread_flag(tsk, TIF_NEED_RESCHED))
+		__trace_set_need_resched(tsk, TIF_NEED_RESCHED);
 	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
 }
 
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 4e6b2910cec3..c08893bde255 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -882,18 +882,22 @@ DECLARE_TRACE(sched_compute_energy,
 	TP_ARGS(p, dst_cpu, energy, max_util, busy_time));
 
 DECLARE_TRACE(sched_entry,
-	TP_PROTO(bool preempt, unsigned long ip),
-	TP_ARGS(preempt, ip));
+	TP_PROTO(bool preempt),
+	TP_ARGS(preempt));
 
 DECLARE_TRACE(sched_exit,
-	TP_PROTO(bool is_switch, unsigned long ip),
-	TP_ARGS(is_switch, ip));
+	TP_PROTO(bool is_switch),
+	TP_ARGS(is_switch));
 
 DECLARE_TRACE_CONDITION(sched_set_state,
 	TP_PROTO(struct task_struct *tsk, int state),
 	TP_ARGS(tsk, state),
 	TP_CONDITION(!!(tsk->__state) != !!state));
 
+DECLARE_TRACE(sched_set_need_resched,
+	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
+	TP_ARGS(tsk, cpu, tif));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ec68fc686bd7..b485e0639616 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
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
@@ -5329,7 +5335,7 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 * switched the context for the first time. It is returning from
 	 * schedule for the first time in this path.
 	 */
-	trace_sched_exit_tp(true, CALLER_ADDR0);
+	trace_sched_exit_tp(true);
 	preempt_enable();
 
 	if (current->set_child_tid)
@@ -6678,7 +6684,8 @@ static void __sched notrace __schedule(int sched_mode)
 	struct rq *rq;
 	int cpu;
 
-	trace_sched_entry_tp(preempt, CALLER_ADDR0);
+	/* Trace preemptions consistently with task switches */
+	trace_sched_entry_tp(sched_mode == SM_PREEMPT);
 
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
@@ -6793,7 +6800,7 @@ static void __sched notrace __schedule(int sched_mode)
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
 	}
-	trace_sched_exit_tp(is_switch, CALLER_ADDR0);
+	trace_sched_exit_tp(is_switch);
 }
 
 void __noreturn do_task_dead(void)
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
index 66f4639d46ac..04c36405e2e3 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -24,12 +24,12 @@ static void handle_sched_set_state(void *data, struct task_struct *tsk, int stat
 	da_handle_start_event_sco(sched_set_state_sco);
 }
 
-static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+static void handle_schedule_entry(void *data, bool preempt)
 {
 	da_handle_event_sco(schedule_entry_sco);
 }
 
-static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+static void handle_schedule_exit(void *data, bool is_switch)
 {
 	da_handle_start_event_sco(schedule_exit_sco);
 }
diff --git a/kernel/trace/rv/monitors/scpd/scpd.c b/kernel/trace/rv/monitors/scpd/scpd.c
index 299703cd72b0..1e351ba52fee 100644
--- a/kernel/trace/rv/monitors/scpd/scpd.c
+++ b/kernel/trace/rv/monitors/scpd/scpd.c
@@ -30,12 +30,12 @@ static void handle_preempt_enable(void *data, unsigned long ip, unsigned long pa
 	da_handle_start_event_scpd(preempt_enable_scpd);
 }
 
-static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+static void handle_schedule_entry(void *data, bool preempt)
 {
 	da_handle_event_scpd(schedule_entry_scpd);
 }
 
-static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+static void handle_schedule_exit(void *data, bool is_switch)
 {
 	da_handle_event_scpd(schedule_exit_scpd);
 }
diff --git a/kernel/trace/rv/monitors/sncid/sncid.c b/kernel/trace/rv/monitors/sncid/sncid.c
index 3e1ee715a0fb..c8491f426365 100644
--- a/kernel/trace/rv/monitors/sncid/sncid.c
+++ b/kernel/trace/rv/monitors/sncid/sncid.c
@@ -30,12 +30,12 @@ static void handle_irq_enable(void *data, unsigned long ip, unsigned long parent
 	da_handle_start_event_sncid(irq_enable_sncid);
 }
 
-static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+static void handle_schedule_entry(void *data, bool preempt)
 {
 	da_handle_start_event_sncid(schedule_entry_sncid);
 }
 
-static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+static void handle_schedule_exit(void *data, bool is_switch)
 {
 	da_handle_start_event_sncid(schedule_exit_sncid);
 }
diff --git a/kernel/trace/rv/monitors/snep/snep.c b/kernel/trace/rv/monitors/snep/snep.c
index 2adc3108d60c..558950f524a5 100644
--- a/kernel/trace/rv/monitors/snep/snep.c
+++ b/kernel/trace/rv/monitors/snep/snep.c
@@ -30,12 +30,12 @@ static void handle_preempt_enable(void *data, unsigned long ip, unsigned long pa
 	da_handle_start_event_snep(preempt_enable_snep);
 }
 
-static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+static void handle_schedule_entry(void *data, bool preempt)
 {
 	da_handle_event_snep(schedule_entry_snep);
 }
 
-static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+static void handle_schedule_exit(void *data, bool is_switch)
 {
 	da_handle_start_event_snep(schedule_exit_snep);
 }
diff --git a/kernel/trace/rv/monitors/tss/tss.c b/kernel/trace/rv/monitors/tss/tss.c
index 0452fcd9edcf..95ebd15131f5 100644
--- a/kernel/trace/rv/monitors/tss/tss.c
+++ b/kernel/trace/rv/monitors/tss/tss.c
@@ -27,12 +27,12 @@ static void handle_sched_switch(void *data, bool preempt,
 	da_handle_event_tss(sched_switch_tss);
 }
 
-static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+static void handle_schedule_entry(void *data, bool preempt)
 {
 	da_handle_event_tss(schedule_entry_tss);
 }
 
-static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+static void handle_schedule_exit(void *data, bool is_switch)
 {
 	da_handle_start_event_tss(schedule_exit_tss);
 }
-- 
2.47.2



