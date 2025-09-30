Return-Path: <linux-kernel+bounces-837947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11325BAE1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322AB1895AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBBC30BF58;
	Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey3RfBoM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5AF1E5B63
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251685; cv=none; b=AC3QMvkADPI5Q9JjQmFFtwydV3y37wG0B+nTrQMcGjtauzk6RXGbeAp1UTnea4lQv1axjtl6kTz16NX0xTNfBVgNSlJmjQOHLGwn01WFOmyCt9hQvb9QR6KW1h1UJAepCJJXoLFnQQl1B963nr0zqEMjUvtUHUEswKCA1GH3eNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251685; c=relaxed/simple;
	bh=vY2v5I9kO5ehK/jc4YTT7DsX1ZGch709+915nX0G2s4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SAQKenP0DZyVxjDoreeP++jgcN3gh16zWqSy7qwytul8GamDLgVJa8QoFzuhDgiicco5qded/9wVwnPP7Rpx68H8+zsOXiw87RXLqarv3Fa758xgOdfGMg2y7IzHYzOXlD9XRmClO44DavbxB9v5mRJut+WHf8IwxSoeUnHKRFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey3RfBoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74600C4CEF0;
	Tue, 30 Sep 2025 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251685;
	bh=vY2v5I9kO5ehK/jc4YTT7DsX1ZGch709+915nX0G2s4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Ey3RfBoM06rSS+/fFro6uDf+g5ZTLhzEwsGWC8FvEY1SIJ40ut5GNMBddS0Gow8ru
	 oA/iFbX3oQT0f99A/75Kb9cKF2lEjljAF96vQPyj4GHS65JhecHP+pNTyF5I2ygNSX
	 E4vgvK+0XRTZXbzGouANvxVAfVPrBc3TwxaDJzQ4I+VleFFm9LJVjLOz0KMK2yhuAr
	 JdCO+eM5tv64/ITOBQZBP9iY1f6v6vaqbPn9IHVt4LkrMwV6OQDXCVoZH87EJLQi1M
	 c95M52ozc/kjkodpIw60itvppls6J8H1qX2tW/BQGhSGK54CaGrN+nymR5Ed8IpypP
	 6X0aV0iveVHZw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3dkj-0000000DIFq-28hw;
	Tue, 30 Sep 2025 13:03:01 -0400
Message-ID: <20250930170301.362050230@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 13:01:36 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [for-next][PATCH 01/11] tracing: Replace syscall RCU pointer assignment with
 READ/WRITE_ONCE()
References: <20250930170135.285740909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The syscall events are pseudo events that hook to the raw syscalls. The
ftrace_syscall_enter/exit() callback is called by the raw_syscall
enter/exit tracepoints respectively whenever any of the syscall events are
enabled.

The trace_array has an array of syscall "files" that correspond to the
system calls based on their __NR_SYSCALL number. The array is read and if
there's a pointer to a trace_event_file then it is considered enabled and
if it is NULL that syscall event is considered disabled.

Currently it uses an rcu_dereference_sched() to get this pointer and a
rcu_assign_ptr() or RCU_INIT_POINTER() to write to it. This is unnecessary
as the file pointer will not go away outside the synchronization of the
tracepoint logic itself. And this code adds no extra RCU synchronization
that uses this.

Replace these functions with a simple READ_ONCE() and WRITE_ONCE() which
is all they need. This will also allow this code to not depend on
preemption being disabled as system call tracepoints are now allowed to
fault.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Takaya Saeki <takayas@google.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ian Rogers <irogers@google.com>
Cc: Douglas Raillard <douglas.raillard@arm.com>
Link: https://lore.kernel.org/20250923130713.594320290@kernel.org
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h          |  4 ++--
 kernel/trace/trace_syscalls.c | 14 ++++++--------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5f4bed5842f9..85eabb454bee 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -380,8 +380,8 @@ struct trace_array {
 #ifdef CONFIG_FTRACE_SYSCALLS
 	int			sys_refcount_enter;
 	int			sys_refcount_exit;
-	struct trace_event_file __rcu *enter_syscall_files[NR_syscalls];
-	struct trace_event_file __rcu *exit_syscall_files[NR_syscalls];
+	struct trace_event_file	*enter_syscall_files[NR_syscalls];
+	struct trace_event_file	*exit_syscall_files[NR_syscalls];
 #endif
 	int			stop_count;
 	int			clock_id;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 46aab0ab9350..3a0b65f89130 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -310,8 +310,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
 		return;
 
-	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
-	trace_file = rcu_dereference_sched(tr->enter_syscall_files[syscall_nr]);
+	trace_file = READ_ONCE(tr->enter_syscall_files[syscall_nr]);
 	if (!trace_file)
 		return;
 
@@ -356,8 +355,7 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
 		return;
 
-	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE()) */
-	trace_file = rcu_dereference_sched(tr->exit_syscall_files[syscall_nr]);
+	trace_file = READ_ONCE(tr->exit_syscall_files[syscall_nr]);
 	if (!trace_file)
 		return;
 
@@ -393,7 +391,7 @@ static int reg_event_syscall_enter(struct trace_event_file *file,
 	if (!tr->sys_refcount_enter)
 		ret = register_trace_sys_enter(ftrace_syscall_enter, tr);
 	if (!ret) {
-		rcu_assign_pointer(tr->enter_syscall_files[num], file);
+		WRITE_ONCE(tr->enter_syscall_files[num], file);
 		tr->sys_refcount_enter++;
 	}
 	mutex_unlock(&syscall_trace_lock);
@@ -411,7 +409,7 @@ static void unreg_event_syscall_enter(struct trace_event_file *file,
 		return;
 	mutex_lock(&syscall_trace_lock);
 	tr->sys_refcount_enter--;
-	RCU_INIT_POINTER(tr->enter_syscall_files[num], NULL);
+	WRITE_ONCE(tr->enter_syscall_files[num], NULL);
 	if (!tr->sys_refcount_enter)
 		unregister_trace_sys_enter(ftrace_syscall_enter, tr);
 	mutex_unlock(&syscall_trace_lock);
@@ -431,7 +429,7 @@ static int reg_event_syscall_exit(struct trace_event_file *file,
 	if (!tr->sys_refcount_exit)
 		ret = register_trace_sys_exit(ftrace_syscall_exit, tr);
 	if (!ret) {
-		rcu_assign_pointer(tr->exit_syscall_files[num], file);
+		WRITE_ONCE(tr->exit_syscall_files[num], file);
 		tr->sys_refcount_exit++;
 	}
 	mutex_unlock(&syscall_trace_lock);
@@ -449,7 +447,7 @@ static void unreg_event_syscall_exit(struct trace_event_file *file,
 		return;
 	mutex_lock(&syscall_trace_lock);
 	tr->sys_refcount_exit--;
-	RCU_INIT_POINTER(tr->exit_syscall_files[num], NULL);
+	WRITE_ONCE(tr->exit_syscall_files[num], NULL);
 	if (!tr->sys_refcount_exit)
 		unregister_trace_sys_exit(ftrace_syscall_exit, tr);
 	mutex_unlock(&syscall_trace_lock);
-- 
2.50.1



