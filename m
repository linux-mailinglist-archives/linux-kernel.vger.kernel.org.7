Return-Path: <linux-kernel+bounces-876408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E97C1B7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E97C1586316
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716663358A9;
	Wed, 29 Oct 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLMPmw1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A882D2388
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748843; cv=none; b=SGbsLKbwGPs8FLFwK3ADklZ/wGLJLu5w1/GsKaKOb3m0xWpSl7V8fKEIklKPvIf2oaHtN2R8RdUs62CnyXO+9TIi5ue/KSmSvTBLftJfQBRcCt4nupyKjghOhtMgOaDdXnrBXd+8rAnz5bcAe7PCPcTA/r3buaCH541GdmqAWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748843; c=relaxed/simple;
	bh=wg37EDSPNiuppcK5YThO5GZtGFA0XcoRUs2ElGjIviU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=euYKOqO7WJb6zcuyecw5PH2AuJ/+agUP/5b+7O3zM6cr4rcF3BepvXVP9+WKMs5WFuM2mEkGZH8lyFLpouhdDz6wujpEvMjgXhmrolF+umN4Bku9799yEfCuEjA2YxUkfeDqnO/tRYgB3lmxlSvlcK43X6hvHS0vXd+WEUmdx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLMPmw1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8EAC4CEFF;
	Wed, 29 Oct 2025 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748843;
	bh=wg37EDSPNiuppcK5YThO5GZtGFA0XcoRUs2ElGjIviU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=pLMPmw1DUTJyoqkVPR8AMOevonqEn8uP9DzIJc6gbsuUPawSfgL7cr7t8MYEtEsnM
	 ddTEd+WEdYGmglkWqeL+o+nJwqHlHyhyOdsISnIvFeKpmG4mNRvCf0f7LI/KVFWnkI
	 yQobS5VrSB/jxBRYSYGsbayLzK4T4YivtHPbzTs5Xler9JlqvkG0S/2H5Zykzevu8s
	 Er80Hir620l5g8GgUG+8igPMZfFl71bUI+r0OBfTl6aGFjlS3qk2EyU4N7/rTrFkft
	 FKC53KfAWm06M244RGXvHXfQVy9TQl+Ep3NkJ/ge578Isjs9E885shEgGPtlFDMRll
	 VRh6Kojp0HbWQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vE7Ma-000000052vE-0KNa;
	Wed, 29 Oct 2025 10:41:24 -0400
Message-ID: <20251029144123.925809276@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 29 Oct 2025 10:40:44 -0400
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
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ingo Molnar <mingo@redhat.com>
Subject: [for-next][PATCH 03/13] perf: tracing: Simplify perf_sysenter_enable/disable() with guards
References: <20251029144041.475297995@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Use guard(mutex)(&syscall_trace_lock) for perf_sysenter_enable() and
perf_sysenter_disable() as well as for the perf_sysexit_enable() and
perf_sysexit_disable(). This will make it easier to update these functions
with other code that has early exit handling.

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
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Link: https://lore.kernel.org/20251028231147.429583335@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 48 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 528ac90eda5d..42d066d8c0ab 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1049,22 +1049,21 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
 static int perf_sysenter_enable(struct trace_event_call *call)
 {
-	int ret = 0;
 	int num;
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
 
-	mutex_lock(&syscall_trace_lock);
-	if (!sys_perf_refcount_enter)
-		ret = register_trace_sys_enter(perf_syscall_enter, NULL);
-	if (ret) {
-		pr_info("event trace: Could not activate syscall entry trace point");
-	} else {
-		set_bit(num, enabled_perf_enter_syscalls);
-		sys_perf_refcount_enter++;
+	guard(mutex)(&syscall_trace_lock);
+	if (!sys_perf_refcount_enter) {
+		int ret = register_trace_sys_enter(perf_syscall_enter, NULL);
+		if (ret) {
+			pr_info("event trace: Could not activate syscall entry trace point");
+			return ret;
+		}
 	}
-	mutex_unlock(&syscall_trace_lock);
-	return ret;
+	set_bit(num, enabled_perf_enter_syscalls);
+	sys_perf_refcount_enter++;
+	return 0;
 }
 
 static void perf_sysenter_disable(struct trace_event_call *call)
@@ -1073,12 +1072,11 @@ static void perf_sysenter_disable(struct trace_event_call *call)
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
 
-	mutex_lock(&syscall_trace_lock);
+	guard(mutex)(&syscall_trace_lock);
 	sys_perf_refcount_enter--;
 	clear_bit(num, enabled_perf_enter_syscalls);
 	if (!sys_perf_refcount_enter)
 		unregister_trace_sys_enter(perf_syscall_enter, NULL);
-	mutex_unlock(&syscall_trace_lock);
 }
 
 static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *regs,
@@ -1155,22 +1153,21 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 
 static int perf_sysexit_enable(struct trace_event_call *call)
 {
-	int ret = 0;
 	int num;
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
 
-	mutex_lock(&syscall_trace_lock);
-	if (!sys_perf_refcount_exit)
-		ret = register_trace_sys_exit(perf_syscall_exit, NULL);
-	if (ret) {
-		pr_info("event trace: Could not activate syscall exit trace point");
-	} else {
-		set_bit(num, enabled_perf_exit_syscalls);
-		sys_perf_refcount_exit++;
+	guard(mutex)(&syscall_trace_lock);
+	if (!sys_perf_refcount_exit) {
+		int ret = register_trace_sys_exit(perf_syscall_exit, NULL);
+		if (ret) {
+			pr_info("event trace: Could not activate syscall exit trace point");
+			return ret;
+		}
 	}
-	mutex_unlock(&syscall_trace_lock);
-	return ret;
+	set_bit(num, enabled_perf_exit_syscalls);
+	sys_perf_refcount_exit++;
+	return 0;
 }
 
 static void perf_sysexit_disable(struct trace_event_call *call)
@@ -1179,12 +1176,11 @@ static void perf_sysexit_disable(struct trace_event_call *call)
 
 	num = ((struct syscall_metadata *)call->data)->syscall_nr;
 
-	mutex_lock(&syscall_trace_lock);
+	guard(mutex)(&syscall_trace_lock);
 	sys_perf_refcount_exit--;
 	clear_bit(num, enabled_perf_exit_syscalls);
 	if (!sys_perf_refcount_exit)
 		unregister_trace_sys_exit(perf_syscall_exit, NULL);
-	mutex_unlock(&syscall_trace_lock);
 }
 
 #endif /* CONFIG_PERF_EVENTS */
-- 
2.51.0



