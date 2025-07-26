Return-Path: <linux-kernel+bounces-746764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4060B12AE2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A237D1C234CB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CABF288C23;
	Sat, 26 Jul 2025 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBserE0q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CF28688C
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539138; cv=none; b=huHK3hiLJ2T2Wj5WknR9bnc6PQzbYhC8sNkEG0OhDjEE6IopWFKeumCDjIj7OL1bycSMmjOZ+kyw3GltnQRQ5NWNSPOezr/cfTBNOZNdJkPI/Jx5UJFEUrp4ztebYJG3VJajGma3kpH61MycdY3laBFtGsHJgDd6qVboc4t98Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539138; c=relaxed/simple;
	bh=TZpjkXBbQZ0/7HMBCrfXxzxFf0zNLQMS0dsRZI7G/40=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=K+tUnka6tsftzBunM/9oRkWnCUuhcTLLFxDTIKYx3nR/J3CLD/kLgggU6jGzYK+G1wZ0iUjT1j+b3Q5jN5b/X7R/XehZBB52PuY18UrL9Cs6v6DQPoqAcHQWPwTNKRvBM4p6ATC/rSOxUPG9hKsfzOwiRFF+57vhwrWmgfg0PPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBserE0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05EBC4CEF6;
	Sat, 26 Jul 2025 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753539137;
	bh=TZpjkXBbQZ0/7HMBCrfXxzxFf0zNLQMS0dsRZI7G/40=;
	h=Date:From:To:Cc:Subject:References:From;
	b=gBserE0qjIuMoap6TaoVC2lXIpgtZ2ZrcLuFmDykwMli4XaIf7hy28sNROcwwdHOe
	 wirPb02es16diVd43tzmP4x5wrdMc8MqF0Q9EfrGm+ytGx7KLgeJlQjL5TuK1lS8OP
	 Dh9tYD+z5bbyZQJx/hsxKZggvUsegUhZ64xOAT6bNwRrt2H4QD7/NddeEBc/kVELdA
	 SAdC2CENCuoh26N00CMbgoKjDkJnHz140/3pfLH2B/V7aXbtDnUar6SPMYw1wrA7fp
	 cnE4BvdWX57FBIpyYIU0nD8wd0/YII6SRia15XDLs96mIl1Gjq480+Tq776svForKe
	 2erLEWL7LG1FA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uffdR-00000001sg7-2bUM;
	Sat, 26 Jul 2025 10:12:25 -0400
Message-ID: <20250726141225.470646928@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 26 Jul 2025 10:07:14 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [for-next][PATCH 10/10] unwind: Finish up unwind when a task exits
References: <20250726140704.560579628@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

On do_exit() when a task is exiting, if a unwind is requested and the
deferred user stacktrace is deferred via the task_work, the task_work
callback is called after exit_mm() is called in do_exit(). This means that
the user stack trace will not be retrieved and an empty stack is created.

Instead, add a function unwind_deferred_task_exit() and call it just
before exit_mm() so that the unwinder can call the requested callbacks
with the user space stack.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Sam James <sam@gentoo.org>
Link: https://lore.kernel.org/20250725185740.748555530@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/unwind_deferred.h |  3 +++
 kernel/exit.c                   |  2 ++
 kernel/unwind/deferred.c        | 23 ++++++++++++++++++++---
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 2efbda01e959..26122d00708a 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -39,6 +39,8 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie);
 void unwind_deferred_cancel(struct unwind_work *work);
 
+void unwind_deferred_task_exit(struct task_struct *task);
+
 static __always_inline void unwind_reset_info(void)
 {
 	struct unwind_task_info *info = &current->unwind_info;
@@ -71,6 +73,7 @@ static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback
 static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
 static inline void unwind_deferred_cancel(struct unwind_work *work) {}
 
+static inline void unwind_deferred_task_exit(struct task_struct *task) {}
 static inline void unwind_reset_info(void) {}
 
 #endif /* !CONFIG_UNWIND_USER */
diff --git a/kernel/exit.c b/kernel/exit.c
index bb184a67ac73..1d8c8ac33c4f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -68,6 +68,7 @@
 #include <linux/rethook.h>
 #include <linux/sysfs.h>
 #include <linux/user_events.h>
+#include <linux/unwind_deferred.h>
 #include <linux/uaccess.h>
 #include <linux/pidfs.h>
 
@@ -938,6 +939,7 @@ void __noreturn do_exit(long code)
 
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
+	unwind_deferred_task_exit(tsk);
 	trace_sched_process_exit(tsk, group_dead);
 
 	/*
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index a5ef1c1f915e..dc6040aae3ee 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -114,7 +114,7 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 	/* Should always be called from faultable context */
 	might_fault();
 
-	if (current->flags & PF_EXITING)
+	if (!current->mm)
 		return -EINVAL;
 
 	if (!info->cache) {
@@ -147,9 +147,9 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 	return 0;
 }
 
-static void unwind_deferred_task_work(struct callback_head *head)
+static void process_unwind_deferred(struct task_struct *task)
 {
-	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
+	struct unwind_task_info *info = &task->unwind_info;
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
 	unsigned long bits;
@@ -186,6 +186,23 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	}
 }
 
+static void unwind_deferred_task_work(struct callback_head *head)
+{
+	process_unwind_deferred(current);
+}
+
+void unwind_deferred_task_exit(struct task_struct *task)
+{
+	struct unwind_task_info *info = &current->unwind_info;
+
+	if (!unwind_pending(info))
+		return;
+
+	process_unwind_deferred(task);
+
+	task_work_cancel(task, &info->work);
+}
+
 /**
  * unwind_deferred_request - Request a user stacktrace on task kernel exit
  * @work: Unwind descriptor requesting the trace
-- 
2.47.2



