Return-Path: <linux-kernel+bounces-876414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02037C1BB19
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73E965A5C27
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88F4354AF5;
	Wed, 29 Oct 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi7lqFJS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADEE3358B4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748844; cv=none; b=Rkaz+Grixo1S4ChjHurcc0HcEm5HNR9A46EXQSFrSQ0GKFkbOAda0qFr/vLuwuY+SLMSFMIlGiOKHDzx32MLbB/tM3EeHdy/IAGZFUPUtX0rhTeqrz1QOBgy+hsAO+ArqYX14dVZremS9ECLiMCtbu9pH7N7haB9jBnJ+k1XXOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748844; c=relaxed/simple;
	bh=ojVc0eYwsp4b9IGkKm0j5kxSqVB1ME1YqtnSX0gBAEo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eyZLiluVUjw/pS4fjPqWztia2dy8Sytf2uFZlIU+Ct8XGre5qN6WQ+GUK2HUoMMH++RC7VIRidvYUqRphttYDdrgZujjfpr+dIq8k5WEvv/TN8j+5F6Qh6+q6JSm2+91w8UhSwCnQwXEYHLzuHtE6yFLb4XECG/wkFZwf/wfV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi7lqFJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257A2C116B1;
	Wed, 29 Oct 2025 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748844;
	bh=ojVc0eYwsp4b9IGkKm0j5kxSqVB1ME1YqtnSX0gBAEo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=hi7lqFJSTFsPuMSeWnDH4yr5dNDOBzzTeR6Z9/5dFyCAeTsOWY6GhOavUkgw7dW6+
	 gcfJQnwIWu+7JM9zee6f1wZjQk0Msn0QxSUKiC1sXODxfaCKW6PShqRXyN3y+ghIDm
	 iKI+JZHPY+z2FFgw2lwgWoYazMY3pvmQXUvDWsykSeSBG3QezgHpkUGURi1HbqPMMj
	 EKVp8X+YLX46bAiwTV1FL176rjF0PWSukO48oDw+qNVz7Xs+S9/cWkKHBbzt5QfS2V
	 wqMueGu7lQ4wWVPkch+sWFtCCKVgrdHnStdFocL2e9cxhTG3jE4R3E2eM/j6mTnTkS
	 FwpA+QO4KtS1A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vE7Ma-000000052xg-3tZ5;
	Wed, 29 Oct 2025 10:41:24 -0400
Message-ID: <20251029144124.774884443@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 29 Oct 2025 10:40:49 -0400
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
Subject: [for-next][PATCH 08/13] tracing: Add a config and syscall_user_buf_size file to limit amount
 written
References: <20251029144041.475297995@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When a system call that can copy user space addresses into the ring
buffer, it can copy up to 511 bytes of data. This can waste precious ring
buffer space if the user isn't interested in the output. Add a new file
"syscall_user_buf_size" that gets initialized to a new config
CONFIG_SYSCALL_BUF_SIZE_DEFAULT that defaults to 63.

The config also is used to limit how much perf can read from user space.

Also lower the max down to 165, as this isn't to record everything that a
system call may be passing through to the kernel. 165 is more than enough.

The reason for 165 is because adding one for the nul terminating byte, as
well as possibly needing to append the "..." string turns it into 170
bytes. As this needs to save up to 3 arguments and 3 * 170 is 510 which
fits nicely in 512 bytes (a power of 2).

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
Link: https://lore.kernel.org/20251028231148.260068913@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst |  8 ++++++
 kernel/trace/Kconfig           | 14 +++++++++
 kernel/trace/trace.c           | 52 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h           |  3 ++
 kernel/trace/trace_syscalls.c  | 50 ++++++++++++++++++--------------
 5 files changed, 105 insertions(+), 22 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index aef674df3afd..d1f313a5f4ad 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -366,6 +366,14 @@ of ftrace. Here is a list of some of the key files:
 	for each function. The displayed address is the patch-site address
 	and can differ from /proc/kallsyms address.
 
+  syscall_user_buf_size:
+
+	Some system call trace events will record the data from a user
+	space address that one of the parameters point to. The amount of
+	data per event is limited. This file holds the max number of bytes
+	that will be recorded into the ring buffer to hold this data.
+	The max value is currently 165.
+
   dyn_ftrace_total_info:
 
 	This file is for debugging purposes. The number of functions that
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d2c79da81e4f..99283b2dcfd6 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -575,6 +575,20 @@ config FTRACE_SYSCALLS
 	help
 	  Basic tracer to catch the syscall entry and exit events.
 
+config TRACE_SYSCALL_BUF_SIZE_DEFAULT
+	int "System call user read max size"
+	range 0 165
+	default 63
+	depends on FTRACE_SYSCALLS
+	help
+	 Some system call trace events will record the data from a user
+	 space address that one of the parameters point to. The amount of
+	 data per event is limited. That limit is set by this config and
+	 this config also affects how much user space data perf can read.
+
+	 For a tracing instance, this size may be changed by writing into
+	 its syscall_user_buf_size file.
+
 config TRACER_SNAPSHOT
 	bool "Create a snapshot trace buffer"
 	select TRACER_MAX_TRACE
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 50832411c5c0..2aee9a3088f4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6911,6 +6911,43 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 	goto out;
 }
 
+static ssize_t
+tracing_syscall_buf_read(struct file *filp, char __user *ubuf,
+			 size_t cnt, loff_t *ppos)
+{
+	struct inode *inode = file_inode(filp);
+	struct trace_array *tr = inode->i_private;
+	char buf[64];
+	int r;
+
+	r = snprintf(buf, 64, "%d\n", tr->syscall_buf_sz);
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+}
+
+static ssize_t
+tracing_syscall_buf_write(struct file *filp, const char __user *ubuf,
+			  size_t cnt, loff_t *ppos)
+{
+	struct inode *inode = file_inode(filp);
+	struct trace_array *tr = inode->i_private;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > SYSCALL_FAULT_USER_MAX)
+		val = SYSCALL_FAULT_USER_MAX;
+
+	tr->syscall_buf_sz = val;
+
+	*ppos += cnt;
+
+	return cnt;
+}
+
 static ssize_t
 tracing_entries_read(struct file *filp, char __user *ubuf,
 		     size_t cnt, loff_t *ppos)
@@ -8043,6 +8080,14 @@ static const struct file_operations tracing_entries_fops = {
 	.release	= tracing_release_generic_tr,
 };
 
+static const struct file_operations tracing_syscall_buf_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= tracing_syscall_buf_read,
+	.write		= tracing_syscall_buf_write,
+	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
+};
+
 static const struct file_operations tracing_buffer_meta_fops = {
 	.open		= tracing_buffer_meta_open,
 	.read		= seq_read,
@@ -10145,6 +10190,8 @@ trace_array_create_systems(const char *name, const char *systems,
 
 	raw_spin_lock_init(&tr->start_lock);
 
+	tr->syscall_buf_sz = global_trace.syscall_buf_sz;
+
 	tr->max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 #ifdef CONFIG_TRACER_MAX_TRACE
 	spin_lock_init(&tr->snapshot_trigger_lock);
@@ -10461,6 +10508,9 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
 			  tr, &buffer_subbuf_size_fops);
 
+	trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
+			 tr, &tracing_syscall_buf_fops);
+
 	create_trace_options_dir(tr);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -11386,6 +11436,8 @@ __init static int tracer_alloc_buffers(void)
 
 	global_trace.flags = TRACE_ARRAY_FL_GLOBAL;
 
+	global_trace.syscall_buf_sz = CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT;
+
 	INIT_LIST_HEAD(&global_trace.systems);
 	INIT_LIST_HEAD(&global_trace.events);
 	INIT_LIST_HEAD(&global_trace.hist_vars);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8439fe3058cc..d5cb4bc6cd2e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -131,6 +131,8 @@ enum trace_type {
 #define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
 #define HIST_STACKTRACE_SKIP	5
 
+#define SYSCALL_FAULT_USER_MAX 165
+
 /*
  * syscalls are special, and need special handling, this is why
  * they are not included in trace_entries.h
@@ -430,6 +432,7 @@ struct trace_array {
 	int			function_enabled;
 #endif
 	int			no_filter_buffering_ref;
+	unsigned int		syscall_buf_sz;
 	struct list_head	hist_vars;
 #ifdef CONFIG_TRACER_SNAPSHOT
 	struct cond_snapshot	*cond_snapshot;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 3eafe1b8f53e..a2de6364777a 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -390,21 +390,19 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 /*
  * Create a per CPU temporary buffer to copy user space pointers into.
  *
- * SYSCALL_FAULT_BUF_SZ holds the size of the per CPU buffer to use
- * to copy memory from user space addresses into.
- *
- * SYSCALL_FAULT_ARG_SZ is the amount to copy from user space.
- *
- * SYSCALL_FAULT_USER_MAX is the amount to copy into the ring buffer.
- *  It's slightly smaller than SYSCALL_FAULT_ARG_SZ to know if it
- *  needs to append the EXTRA or not.
+ * SYSCALL_FAULT_USER_MAX is the amount to copy from user space.
+ *  (defined in kernel/trace/trace.h)
+
+ * SYSCALL_FAULT_ARG_SZ is the amount to copy from user space plus the
+ *   nul terminating byte and possibly appended EXTRA (4 bytes).
  *
- * This only allows up to 3 args from system calls.
+ * SYSCALL_FAULT_BUF_SZ holds the size of the per CPU buffer to use
+ * to copy memory from user space addresses into that will hold
+ * 3 args as only 3 args are allowed to be copied from system calls.
  */
-#define SYSCALL_FAULT_BUF_SZ 512
-#define SYSCALL_FAULT_ARG_SZ 168
-#define SYSCALL_FAULT_USER_MAX 128
+#define SYSCALL_FAULT_ARG_SZ (SYSCALL_FAULT_USER_MAX + 1 + 4)
 #define SYSCALL_FAULT_MAX_CNT 3
+#define SYSCALL_FAULT_BUF_SZ (SYSCALL_FAULT_ARG_SZ * SYSCALL_FAULT_MAX_CNT)
 
 /* Use the tracing per CPU buffer infrastructure to copy from user space */
 struct syscall_user_buffer {
@@ -498,7 +496,8 @@ static int syscall_copy_user_array(char *buf, const char __user *ptr,
 	return 0;
 }
 
-static char *sys_fault_user(struct syscall_metadata *sys_data,
+static char *sys_fault_user(unsigned int buf_size,
+			    struct syscall_metadata *sys_data,
 			    struct syscall_user_buffer *sbuf,
 			    unsigned long *args,
 			    unsigned int data_size[SYSCALL_FAULT_MAX_CNT])
@@ -548,6 +547,10 @@ static char *sys_fault_user(struct syscall_metadata *sys_data,
 		data_size[i] = -1; /* Denotes no pointer */
 	}
 
+	/* A zero size means do not even try */
+	if (!buf_size)
+		return NULL;
+
 	buffer = trace_user_fault_read(&sbuf->buf, NULL, size,
 				       syscall_copy, &sargs);
 	if (!buffer)
@@ -568,19 +571,20 @@ static char *sys_fault_user(struct syscall_metadata *sys_data,
 					buf[x] = '.';
 			}
 
+			size = min(buf_size, SYSCALL_FAULT_USER_MAX);
+
 			/*
 			 * If the text was truncated due to our max limit,
 			 * add "..." to the string.
 			 */
-			if (ret > SYSCALL_FAULT_USER_MAX) {
-				strscpy(buf + SYSCALL_FAULT_USER_MAX, EXTRA,
-					sizeof(EXTRA));
-				ret = SYSCALL_FAULT_USER_MAX + sizeof(EXTRA);
+			if (ret > size) {
+				strscpy(buf + size, EXTRA, sizeof(EXTRA));
+				ret = size + sizeof(EXTRA);
 			} else {
 				buf[ret++] = '\0';
 			}
 		} else {
-			ret = min(ret, SYSCALL_FAULT_USER_MAX);
+			ret = min((unsigned int)ret, buf_size);
 		}
 		data_size[i] = ret;
 	}
@@ -590,7 +594,8 @@ static char *sys_fault_user(struct syscall_metadata *sys_data,
 
 static int
 syscall_get_data(struct syscall_metadata *sys_data, unsigned long *args,
-		 char **buffer, int *size, int *user_sizes, int *uargs)
+		 char **buffer, int *size, int *user_sizes, int *uargs,
+		 int buf_size)
 {
 	struct syscall_user_buffer *sbuf;
 	int i;
@@ -600,7 +605,7 @@ syscall_get_data(struct syscall_metadata *sys_data, unsigned long *args,
 	if (!sbuf)
 		return -1;
 
-	*buffer = sys_fault_user(sys_data, sbuf, args, user_sizes);
+	*buffer = sys_fault_user(buf_size, sys_data, sbuf, args, user_sizes);
 	/*
 	 * user_size is the amount of data to append.
 	 * Need to add 4 for the meta field that points to
@@ -705,7 +710,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	if (mayfault) {
 		if (syscall_get_data(sys_data, args, &user_ptr,
-				     &size, user_sizes, &uargs) < 0)
+				     &size, user_sizes, &uargs, tr->syscall_buf_sz) < 0)
 			return;
 	}
 
@@ -1204,6 +1209,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	bool mayfault;
 	char *user_ptr;
 	int user_sizes[SYSCALL_FAULT_MAX_CNT] = {};
+	int buf_size = CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT;
 	int syscall_nr;
 	int rctx;
 	int size = 0;
@@ -1233,7 +1239,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
 	if (mayfault) {
 		if (syscall_get_data(sys_data, args, &user_ptr,
-				     &size, user_sizes, &uargs) < 0)
+				     &size, user_sizes, &uargs, buf_size) < 0)
 			return;
 	}
 
-- 
2.51.0



