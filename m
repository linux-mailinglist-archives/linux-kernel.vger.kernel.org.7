Return-Path: <linux-kernel+bounces-794820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A70EB3E7A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DBD1656BF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AEC3451A6;
	Mon,  1 Sep 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNldhXmY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BDB343D84;
	Mon,  1 Sep 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737891; cv=none; b=ewmoV3slU+/VXeDDDQe3pi5zR9aBwALClTfWTl2K/S9X90iVMyvG/AgLckD1GzIZb+Qf+g4wkjx7s+nxzOF/MsdONEo3yMiNuIQDco30sELKpPcnH4/9aWFW//02QrXdsyradCFyeLjcD2sBk2PToDvtYRaQY8cUcqdtdJB0v04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737891; c=relaxed/simple;
	bh=TexR1Jlu74yN1ClKsSqnkr3UhwJH7VO/18tTFV1286U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFJq+Stj/6bH8VRac4Z5knv5hM6DI0Li2DXGlAfJ8F82Qe1IvYIirZFFAq1vKSsroBjyN4wkUDZX1jmmvFhEKjYt7RBr5Xu6/pSYyv0AUuJmk3PtKDkL1ahjhRiXq6QByoRhz7dPM1nNhc9djjsEOOM0jOE8Mi0KeRP5P9kaZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNldhXmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100D9C4CEF0;
	Mon,  1 Sep 2025 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737891;
	bh=TexR1Jlu74yN1ClKsSqnkr3UhwJH7VO/18tTFV1286U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNldhXmY8acUlBR8Njbl8JRj0SS+md022UrpPYRAJPnG+dP2GxXmo1BlBejeoHf6Y
	 i8FaZW/6N7tZVZatvpwP0+VnvtIBUMCIbpFIrE5+exY7H0RfQgAeheqmzYXW1P//wY
	 02CJcxo/VuQ90JU9NECf6AtvhcXaDDaQg1sABR6N0pYC7ON7p/8BAItsJXJa0EAE8u
	 fdbAPY5ZEsEkc9iePWkWpeNkMx29hF07s6p12iRx8s8TFgyGstyMZ0Sk82fO9bXwjF
	 0lkH6MvQTyg7o67iSX0w4Jyj2Q++VSYQHmq8vReTRuZF6gMDtw4f5jt9NDt6a3tM8c
	 oVL3ZzBtmg6tw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [RFC PATCH 1/6] tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
Date: Mon,  1 Sep 2025 23:44:45 +0900
Message-ID: <175673788575.478080.17611922836391707019.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175673787502.478080.3342912952394010967.stgit@devnote2>
References: <175673787502.478080.3342912952394010967.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a new probe event for the hardware breakpoint called wprobe-event.
This wprobe allows user to trace (watch) the memory access at the
specified memory address.
The new syntax is;

 w[:[GROUP/]EVENT] [r|w|rw]@[ADDR|SYM][:SIZE] [FETCH_ARGs]

User also can use $addr to fetch the accessed address. But no other
variables are supported. To record updated value, use '+0($addr)'.

For example, tracing updates of the jiffies;

 /sys/kernel/tracing # echo 'w:my_jiffies w@jiffies' >> dynamic_events
 /sys/kernel/tracing # cat dynamic_events
 w:wprobes/my_jiffies w@jiffies:4
 /sys/kernel/tracing # echo 1 > events/wprobes/my_jiffies/enable
 /sys/kernel/tracing # head -n 20 trace | tail -n 5
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
          <idle>-0       [000] d.Z1.   206.547317: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
          <idle>-0       [000] d.Z1.   206.548341: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
          <idle>-0       [000] d.Z1.   206.549346: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)


Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/index.rst       |    1 
 Documentation/trace/wprobetrace.rst |   69 ++++
 include/linux/trace_events.h        |    2 
 kernel/trace/Kconfig                |   14 +
 kernel/trace/Makefile               |    1 
 kernel/trace/trace.c                |    9 
 kernel/trace/trace.h                |    5 
 kernel/trace/trace_probe.c          |   20 +
 kernel/trace/trace_probe.h          |    8 
 kernel/trace/trace_wprobe.c         |  685 +++++++++++++++++++++++++++++++++++
 10 files changed, 811 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/trace/wprobetrace.rst
 create mode 100644 kernel/trace/trace_wprobe.c

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index b4a429dc4f7a..14de6858ae1b 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -36,6 +36,7 @@ the Linux kernel.
    kprobes
    kprobetrace
    fprobetrace
+   wprobetrace
    eprobetrace
    fprobe
    ring-buffer-design
diff --git a/Documentation/trace/wprobetrace.rst b/Documentation/trace/wprobetrace.rst
new file mode 100644
index 000000000000..9774f57e2947
--- /dev/null
+++ b/Documentation/trace/wprobetrace.rst
@@ -0,0 +1,69 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Watchpoint probe (wprobe) Event Tracing
+=======================================
+
+.. Author: Masami Hiramatsu <mhiramat@kernel.org>
+
+Overview
+--------
+
+Wprobe event is a dynamic event based on the hardware breakpoint, which is
+similar to other probe events, but it is for watching data access. It allows
+you to trace which code accesses a specified data.
+
+As same as other dynamic events, wprobe events are defined via
+`dynamic_events` interface file on tracefs.
+
+Synopsis of wprobe-events
+-------------------------
+::
+
+  w:[GRP/][EVENT] SPEC [FETCHARGS]                       : Probe on data access
+
+ GRP            : Group name for wprobe. If omitted, use "wprobes" for it.
+ EVENT          : Event name for wprobe. If omitted, an event name is
+                  generated based on the address or symbol.
+ SPEC           : Breakpoint specification.
+                  [r|w|rw]@<ADDRESS|SYMBOL[+|-OFFS]>[:LENGTH]
+
+   r|w|rw       : Access type, r for read, w for write, and rw for both.
+                  Use rw if omitted.
+   ADDRESS      : Address to trace (hexadecimal).
+   SYMBOL       : Symbol name to trace.
+   LENGTH       : Length of the data to trace in bytes. (1, 2, 4, or 8)
+
+ FETCHARGS      : Arguments. Each probe can have up to 128 args.
+  $addr         : Fetch the accessing address.
+  @ADDR         : Fetch memory at ADDR (ADDR should be in kernel)
+  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
+  +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*1)(\*2)
+  \IMM          : Store an immediate value to the argument.
+  NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
+  FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
+                  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
+                  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
+                  and bitfield are supported.
+
+  (\*1) this is useful for fetching a field of data structures.
+  (\*2) "u" means user-space dereference.
+
+For the details of TYPE, see :ref:`kprobetrace documentation <kprobetrace_types>`.
+
+Usage examples
+--------------
+Here is an example to add a wprobe event on a variable `jiffies`.
+::
+
+  # echo 'w:my_jiffies w@jiffies' >> dynamic_events
+  # cat dynamic_events
+  w:wprobes/my_jiffies w@jiffies
+  # echo 1 > events/wprobes/enable
+  # cat trace | head
+  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+  #              | |         |   |||||     |         |
+           <idle>-0       [000] d.Z1.  717.026259: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
+           <idle>-0       [000] d.Z1.  717.026373: my_jiffies: (tick_do_update_jiffies64+0xbe/0x130)
+
+You can see the code which writes to `jiffies` is `do_timer()`.
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 04307a19cde3..7c65f2f73ff4 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -324,6 +324,7 @@ enum {
 	TRACE_EVENT_FL_UPROBE_BIT,
 	TRACE_EVENT_FL_EPROBE_BIT,
 	TRACE_EVENT_FL_FPROBE_BIT,
+	TRACE_EVENT_FL_WPROBE_BIT,
 	TRACE_EVENT_FL_CUSTOM_BIT,
 	TRACE_EVENT_FL_TEST_STR_BIT,
 };
@@ -354,6 +355,7 @@ enum {
 	TRACE_EVENT_FL_UPROBE		= (1 << TRACE_EVENT_FL_UPROBE_BIT),
 	TRACE_EVENT_FL_EPROBE		= (1 << TRACE_EVENT_FL_EPROBE_BIT),
 	TRACE_EVENT_FL_FPROBE		= (1 << TRACE_EVENT_FL_FPROBE_BIT),
+	TRACE_EVENT_FL_WPROBE		= (1 << TRACE_EVENT_FL_WPROBE_BIT),
 	TRACE_EVENT_FL_CUSTOM		= (1 << TRACE_EVENT_FL_CUSTOM_BIT),
 	TRACE_EVENT_FL_TEST_STR		= (1 << TRACE_EVENT_FL_TEST_STR_BIT),
 };
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d2c79da81e4f..dd8919386425 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -807,6 +807,20 @@ config EPROBE_EVENTS
 	  convert the type of an event field. For example, turn an
 	  address into a string.
 
+config WPROBE_EVENTS
+	bool "Enable wprobe-based dynamic events"
+	depends on TRACING
+	depends on HAVE_HW_BREAKPOINT
+	select PROBE_EVENTS
+	select DYNAMIC_EVENTS
+	default y
+	help
+	  This allows the user to add watchpoint tracing events based on
+	  hardware breakpoints on the fly via the ftrace interface.
+
+	  Those events can be inserted wherever hardware breakpoints can be
+	  set, and record various register and memory values.
+
 config BPF_EVENTS
 	depends on BPF_SYSCALL
 	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index dcb4e02afc5f..1d57bb36c5fc 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
 obj-$(CONFIG_FPROBE) += fprobe.o
 obj-$(CONFIG_RETHOOK) += rethook.o
 obj-$(CONFIG_FPROBE_EVENTS) += trace_fprobe.o
+obj-$(CONFIG_WPROBE_EVENTS) += trace_wprobe.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 obj-$(CONFIG_RV) += rv/
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4283ed4e8f59..ac2fc6d768ad 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5506,8 +5506,12 @@ static const char readme_msg[] =
 	"  uprobe_events\t\t- Create/append/remove/show the userspace dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
 #endif
+#ifdef CONFIG_WPROBE_EVENTS
+	"  wprobe_events\t\t- Create/append/remove/show the hardware breakpoint dynamic events\n"
+	"\t\t\t  Write into this file to define/undefine new trace events.\n"
+#endif
 #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS) || \
-    defined(CONFIG_FPROBE_EVENTS)
+    defined(CONFIG_FPROBE_EVENTS) || defined(CONFIG_WPROBE_EVENTS)
 	"\t  accepts: event-definitions (one definition per line)\n"
 #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
 	"\t   Format: p[:[<group>/][<event>]] <place> [<args>]\n"
@@ -5517,6 +5521,9 @@ static const char readme_msg[] =
 	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
 	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
 #endif
+#ifdef CONFIG_WPROBE_EVENTS
+	"\t           w[:[<group>/][<event>]] [r|w|rw]@<addr>[:<len>]\n"
+#endif
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t           s:[synthetic/]<event> <field> [<field>]\n"
 #endif
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1dbf1d3cf2f1..ae175ddc3f58 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -173,6 +173,11 @@ struct fexit_trace_entry_head {
 	unsigned long		ret_ip;
 };
 
+struct wprobe_trace_entry_head {
+	struct trace_entry	ent;
+	unsigned long		ip;
+};
+
 #define TRACE_BUF_SIZE		1024
 
 struct trace_array;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 5b92376a58fc..ef500c373f3c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -968,6 +968,24 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 		goto inval;
 	}
 
+	/* wprobe only support "$addr" and "$value" variable */
+	if (ctx->flags & TPARG_FL_WPROBE) {
+		if (!strcmp(arg, "addr")) {
+			code->op = FETCH_OP_BADDR;
+			return 0;
+		}
+		if (!strcmp(arg, "value")) {
+			code->op = FETCH_OP_BADDR;
+			code++;
+			code->op = FETCH_OP_DEREF;
+			code->offset = 0;
+			*pcode = code;
+			return 0;
+		}
+		err = TP_ERR_BAD_VAR;
+		goto inval;
+	}
+
 	if (str_has_prefix(arg, "retval")) {
 		if (!(ctx->flags & TPARG_FL_RETURN)) {
 			err = TP_ERR_RETVAL_ON_PROBE;
@@ -1098,7 +1116,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		break;
 
 	case '%':	/* named register */
-		if (ctx->flags & (TPARG_FL_TEVENT | TPARG_FL_FPROBE)) {
+		if (ctx->flags & (TPARG_FL_TEVENT | TPARG_FL_FPROBE | TPARG_FL_WPROBE)) {
 			/* eprobe and fprobe do not handle registers */
 			trace_probe_log_err(ctx->offset, BAD_VAR);
 			break;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 76bf2dee8071..13c9dbc4d0e2 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -89,6 +89,7 @@ enum fetch_op {
 	FETCH_OP_STACK,		/* Stack : .param = index */
 	FETCH_OP_STACKP,	/* Stack pointer */
 	FETCH_OP_RETVAL,	/* Return value */
+	FETCH_OP_BADDR,		/* Break address */
 	FETCH_OP_IMM,		/* Immediate : .immediate */
 	FETCH_OP_COMM,		/* Current comm */
 	FETCH_OP_ARG,		/* Function argument : .param */
@@ -396,6 +397,7 @@ static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
 #define TPARG_FL_USER   BIT(4)
 #define TPARG_FL_FPROBE BIT(5)
 #define TPARG_FL_TPOINT BIT(6)
+#define TPARG_FL_WPROBE BIT(7)
 #define TPARG_FL_LOC_MASK	GENMASK(4, 0)
 
 static inline bool tparg_is_function_entry(unsigned int flags)
@@ -556,7 +558,11 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_TYPE4STR,		"This type does not fit for string."),\
 	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
 	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
-	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),
+	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),	\
+	C(BAD_ACCESS_FMT,	"Access memory address requires @"),	\
+	C(BAD_ACCESS_TYPE,	"Bad memory access type"),	\
+	C(BAD_ACCESS_LEN,	"This memory access length is not supported"), \
+	C(BAD_ACCESS_ADDR,	"Invalid access memory address"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
new file mode 100644
index 000000000000..4b00a8e917c1
--- /dev/null
+++ b/kernel/trace/trace_wprobe.c
@@ -0,0 +1,685 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hardware-breakpoint-based tracing events
+ *
+ * Copyright (C) 2023, Masami Hiramatsu <mhiramat@kernel.org>
+ */
+#define pr_fmt(fmt)	"trace_wprobe: " fmt
+
+#include <linux/hw_breakpoint.h>
+#include <linux/kallsyms.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/perf_event.h>
+#include <linux/rculist.h>
+#include <linux/security.h>
+#include <linux/tracepoint.h>
+#include <linux/uaccess.h>
+
+#include <asm/ptrace.h>
+
+#include "trace_dynevent.h"
+#include "trace_probe.h"
+#include "trace_probe_kernel.h"
+#include "trace_probe_tmpl.h"
+
+#define WPROBE_EVENT_SYSTEM "wprobes"
+
+static int trace_wprobe_create(const char *raw_command);
+static int trace_wprobe_show(struct seq_file *m, struct dyn_event *ev);
+static int trace_wprobe_release(struct dyn_event *ev);
+static bool trace_wprobe_is_busy(struct dyn_event *ev);
+static bool trace_wprobe_match(const char *system, const char *event,
+			       int argc, const char **argv, struct dyn_event *ev);
+
+static struct dyn_event_operations trace_wprobe_ops = {
+	.create = trace_wprobe_create,
+	.show = trace_wprobe_show,
+	.is_busy = trace_wprobe_is_busy,
+	.free = trace_wprobe_release,
+	.match = trace_wprobe_match,
+};
+
+struct trace_wprobe {
+	struct dyn_event	devent;
+	struct perf_event * __percpu *bp_event;
+	unsigned long		addr;
+	int			len;
+	int			type;
+	const char		*symbol;
+	struct trace_probe	tp;
+};
+
+static bool is_trace_wprobe(struct dyn_event *ev)
+{
+	return ev->ops == &trace_wprobe_ops;
+}
+
+static struct trace_wprobe *to_trace_wprobe(struct dyn_event *ev)
+{
+	return container_of(ev, struct trace_wprobe, devent);
+}
+
+#define for_each_trace_wprobe(pos, dpos)			\
+	for_each_dyn_event(dpos)				\
+		if (is_trace_wprobe(dpos) && (pos = to_trace_wprobe(dpos)))
+
+static bool trace_wprobe_is_busy(struct dyn_event *ev)
+{
+	struct trace_wprobe *tw = to_trace_wprobe(ev);
+
+	return trace_probe_is_enabled(&tw->tp);
+}
+
+static bool trace_wprobe_match(const char *system, const char *event,
+			       int argc, const char **argv, struct dyn_event *ev)
+{
+	struct trace_wprobe *tw = to_trace_wprobe(ev);
+
+	if (event[0] != '\0' && strcmp(trace_probe_name(&tw->tp), event))
+		return false;
+
+	if (system && strcmp(trace_probe_group_name(&tw->tp), system))
+		return false;
+
+	/* TODO: match arguments */
+	return true;
+}
+
+/*
+ * Note that we don't verify the fetch_insn code, since it does not come
+ * from user space.
+ */
+static int
+process_fetch_insn(struct fetch_insn *code, void *rec, void *edata,
+		   void *dest, void *base)
+{
+	void *baddr = rec;
+	unsigned long val;
+	int ret;
+
+retry:
+	/* 1st stage: get value from context */
+	switch (code->op) {
+	case FETCH_OP_BADDR:
+		val = (unsigned long)baddr;
+		break;
+	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
+		code++;
+		goto retry;
+	default:
+		ret = process_common_fetch_insn(code, &val);
+		if (ret < 0)
+			return ret;
+	}
+	code++;
+
+	return process_fetch_insn_bottom(code, val, dest, base);
+}
+NOKPROBE_SYMBOL(process_fetch_insn)
+
+static void wprobe_trace_handler(struct trace_wprobe *tw,
+				 struct perf_sample_data *data,
+				 struct pt_regs *regs,
+				 struct trace_event_file *trace_file)
+{
+	struct wprobe_trace_entry_head *entry;
+	struct trace_event_call *call = trace_probe_event_call(&tw->tp);
+	struct trace_event_buffer fbuffer;
+	int dsize;
+
+	if (WARN_ON_ONCE(call != trace_file->event_call))
+		return;
+
+	if (trace_trigger_soft_disabled(trace_file))
+		return;
+
+	dsize = __get_data_size(&tw->tp, (void *)tw->addr, NULL);
+
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry) + tw->tp.size + dsize);
+	if (!entry)
+		return;
+
+	entry->ip = instruction_pointer(regs);
+	store_trace_args(&entry[1], &tw->tp, (void *)tw->addr, NULL, sizeof(*entry), dsize);
+
+	fbuffer.regs = regs;
+	trace_event_buffer_commit(&fbuffer);
+}
+
+static void wprobe_perf_handler(struct perf_event *bp,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs)
+{
+	struct trace_wprobe *tw = bp->overflow_handler_context;
+	struct event_file_link *link;
+
+	trace_probe_for_each_link_rcu(link, &tw->tp)
+		wprobe_trace_handler(tw, data, regs, link->file);
+}
+
+static int __register_trace_wprobe(struct trace_wprobe *tw)
+{
+	struct perf_event_attr attr;
+
+	if (tw->bp_event)
+		return -EINVAL;
+
+	hw_breakpoint_init(&attr);
+	attr.bp_addr = tw->addr;
+	attr.bp_len = tw->len;
+	attr.bp_type = tw->type;
+
+	tw->bp_event = register_wide_hw_breakpoint(&attr, wprobe_perf_handler, tw);
+	if (IS_ERR((void * __force)tw->bp_event)) {
+		int ret = PTR_ERR((void * __force)tw->bp_event);
+
+		tw->bp_event = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __unregister_trace_wprobe(struct trace_wprobe *tw)
+{
+	if (tw->bp_event) {
+		unregister_wide_hw_breakpoint(tw->bp_event);
+		tw->bp_event = NULL;
+	}
+}
+
+static void free_trace_wprobe(struct trace_wprobe *tw)
+{
+	if (tw) {
+		trace_probe_cleanup(&tw->tp);
+		kfree(tw->symbol);
+		kfree(tw);
+	}
+}
+DEFINE_FREE(free_trace_wprobe, struct trace_wprobe *, if (!IS_ERR_OR_NULL(_T)) free_trace_wprobe(_T));
+
+static struct trace_wprobe *alloc_trace_wprobe(const char *group,
+					       const char *event,
+					       const char *symbol,
+					       unsigned long addr,
+					       int len, int type, int nargs)
+{
+	struct trace_wprobe *tw __free(free_trace_wprobe) = NULL;
+	int ret;
+
+	tw = kzalloc(struct_size(tw, tp.args, nargs), GFP_KERNEL);
+	if (!tw)
+		return ERR_PTR(-ENOMEM);
+
+	if (symbol) {
+		tw->symbol = kstrdup(symbol, GFP_KERNEL);
+		if (!tw->symbol)
+			return ERR_PTR(-ENOMEM);
+	}
+	tw->addr = addr;
+	tw->len = len;
+	tw->type = type;
+
+	ret = trace_probe_init(&tw->tp, event, group, false, nargs);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	dyn_event_init(&tw->devent, &trace_wprobe_ops);
+	return_ptr(tw);
+}
+
+static struct trace_wprobe *find_trace_wprobe(const char *event,
+					      const char *group)
+{
+	struct dyn_event *pos;
+	struct trace_wprobe *tw;
+
+	for_each_trace_wprobe(tw, pos)
+		if (strcmp(trace_probe_name(&tw->tp), event) == 0 &&
+		    strcmp(trace_probe_group_name(&tw->tp), group) == 0)
+			return tw;
+	return NULL;
+}
+
+static enum print_line_t
+print_wprobe_event(struct trace_iterator *iter, int flags,
+		   struct trace_event *event)
+{
+	struct wprobe_trace_entry_head *field;
+	struct trace_seq *s = &iter->seq;
+	struct trace_probe *tp;
+
+	field = (struct wprobe_trace_entry_head *)iter->ent;
+	tp = trace_probe_primary_from_call(
+		container_of(event, struct trace_event_call, event));
+	if (WARN_ON_ONCE(!tp))
+		goto out;
+
+	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
+
+	if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET))
+		goto out;
+
+	trace_seq_putc(s, ')');
+
+	if (trace_probe_print_args(s, tp->args, tp->nr_args,
+			     (u8 *)&field[1], field) < 0)
+		goto out;
+
+	trace_seq_putc(s, '\n');
+out:
+	return trace_handle_return(s);
+}
+
+static int wprobe_event_define_fields(struct trace_event_call *event_call)
+{
+	int ret;
+	struct wprobe_trace_entry_head field;
+	struct trace_probe *tp;
+
+	tp = trace_probe_primary_from_call(event_call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENOENT;
+
+	DEFINE_FIELD(unsigned long, ip, FIELD_STRING_IP, 0);
+
+	return traceprobe_define_arg_fields(event_call, sizeof(field), tp);
+}
+
+static struct trace_event_functions wprobe_funcs = {
+	.trace	= print_wprobe_event
+};
+
+static struct trace_event_fields wprobe_fields_array[] = {
+	{ .type = TRACE_FUNCTION_TYPE,
+	  .define_fields = wprobe_event_define_fields },
+	{}
+};
+
+static int wprobe_register(struct trace_event_call *event,
+			   enum trace_reg type, void *data);
+
+static inline void init_trace_event_call(struct trace_wprobe *tw)
+{
+	struct trace_event_call *call = trace_probe_event_call(&tw->tp);
+
+	call->event.funcs = &wprobe_funcs;
+	call->class->fields_array = wprobe_fields_array;
+	call->flags = TRACE_EVENT_FL_WPROBE;
+	call->class->reg = wprobe_register;
+}
+
+static int register_wprobe_event(struct trace_wprobe *tw)
+{
+	init_trace_event_call(tw);
+	return trace_probe_register_event_call(&tw->tp);
+}
+
+static int register_trace_wprobe_event(struct trace_wprobe *tw)
+{
+	struct trace_wprobe *old_tb;
+	int ret;
+
+	guard(mutex)(&event_mutex);
+
+	old_tb = find_trace_wprobe(trace_probe_name(&tw->tp),
+				   trace_probe_group_name(&tw->tp));
+	if (old_tb)
+		return -EBUSY;
+
+	ret = register_wprobe_event(tw);
+	if (ret)
+		return ret;
+
+	dyn_event_add(&tw->devent, trace_probe_event_call(&tw->tp));
+	return 0;
+}
+static int unregister_wprobe_event(struct trace_wprobe *tw)
+{
+	return trace_probe_unregister_event_call(&tw->tp);
+}
+
+static int unregister_trace_wprobe(struct trace_wprobe *tw)
+{
+	if (trace_probe_has_sibling(&tw->tp))
+		goto unreg;
+
+	if (trace_probe_is_enabled(&tw->tp))
+		return -EBUSY;
+
+	if (trace_event_dyn_busy(trace_probe_event_call(&tw->tp)))
+		return -EBUSY;
+
+	if (unregister_wprobe_event(tw))
+		return -EBUSY;
+
+unreg:
+	__unregister_trace_wprobe(tw);
+	dyn_event_remove(&tw->devent);
+	trace_probe_unlink(&tw->tp);
+
+	return 0;
+}
+
+static int enable_trace_wprobe(struct trace_event_call *call,
+			       struct trace_event_file *file)
+{
+	struct trace_probe *tp;
+	struct trace_wprobe *tw;
+	bool enabled;
+	int ret = 0;
+
+	tp = trace_probe_primary_from_call(call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENODEV;
+	enabled = trace_probe_is_enabled(tp);
+
+	if (file) {
+		ret = trace_probe_add_file(tp, file);
+		if (ret)
+			return ret;
+	} else {
+		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
+	}
+
+	if (!enabled) {
+		list_for_each_entry(tw, trace_probe_probe_list(tp), tp.list) {
+			ret = __register_trace_wprobe(tw);
+			if (ret < 0) {
+				/* TODO: rollback */
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int disable_trace_wprobe(struct trace_event_call *call,
+				struct trace_event_file *file)
+{
+	struct trace_wprobe *tw;
+	struct trace_probe *tp;
+
+	tp = trace_probe_primary_from_call(call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENODEV;
+
+	if (file) {
+		if (!trace_probe_get_file_link(tp, file))
+			return -ENOENT;
+		if (!trace_probe_has_single_file(tp))
+			goto out;
+		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
+	} else {
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+	}
+
+	if (!trace_probe_is_enabled(tp)) {
+		list_for_each_entry(tw, trace_probe_probe_list(tp), tp.list) {
+			__unregister_trace_wprobe(tw);
+		}
+	}
+
+out:
+	if (file)
+		trace_probe_remove_file(tp, file);
+
+	return 0;
+}
+
+static int wprobe_register(struct trace_event_call *event,
+			   enum trace_reg type, void *data)
+{
+	struct trace_event_file *file = data;
+
+	switch (type) {
+	case TRACE_REG_REGISTER:
+		return enable_trace_wprobe(event, file);
+	case TRACE_REG_UNREGISTER:
+		return disable_trace_wprobe(event, file);
+
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_REGISTER:
+		return enable_trace_wprobe(event, NULL);
+	case TRACE_REG_PERF_UNREGISTER:
+		return disable_trace_wprobe(event, NULL);
+	case TRACE_REG_PERF_OPEN:
+	case TRACE_REG_PERF_CLOSE:
+	case TRACE_REG_PERF_ADD:
+	case TRACE_REG_PERF_DEL:
+		return 0;
+#endif
+	}
+	return 0;
+}
+
+static int parse_address_spec(const char *spec, unsigned long *addr, int *type,
+			      int *len, char **symbol)
+{
+	char *_spec __free(kfree) = NULL;
+	int _len = HW_BREAKPOINT_LEN_4;
+	int _type = HW_BREAKPOINT_RW;
+	unsigned long _addr = 0;
+	char *at, *col;
+
+	_spec = kstrdup(spec, GFP_KERNEL);
+	if (!_spec)
+		return -ENOMEM;
+
+	at = strchr(_spec, '@');
+	col = strchr(_spec, ':');
+
+	if (!at) {
+		trace_probe_log_err(0, BAD_ACCESS_FMT);
+		return -EINVAL;
+	}
+
+	if (at != _spec) {
+		*at = '\0';
+
+		if (strcmp(_spec, "r") == 0)
+			_type = HW_BREAKPOINT_R;
+		else if (strcmp(_spec, "w") == 0)
+			_type = HW_BREAKPOINT_W;
+		else if (strcmp(_spec, "rw") == 0)
+			_type = HW_BREAKPOINT_RW;
+		else {
+			trace_probe_log_err(0, BAD_ACCESS_TYPE);
+			return -EINVAL;
+		}
+	}
+
+	if (col) {
+		*col = '\0';
+		if (kstrtoint(col + 1, 0, &_len)) {
+			trace_probe_log_err(col + 1 - _spec, BAD_ACCESS_LEN);
+			return -EINVAL;
+		}
+
+		switch (_len) {
+		case 1:
+			_len = HW_BREAKPOINT_LEN_1;
+			break;
+		case 2:
+			_len = HW_BREAKPOINT_LEN_2;
+			break;
+		case 4:
+			_len = HW_BREAKPOINT_LEN_4;
+			break;
+		case 8:
+			_len = HW_BREAKPOINT_LEN_8;
+			break;
+		default:
+			trace_probe_log_err(col + 1 - _spec, BAD_ACCESS_LEN);
+			return -EINVAL;
+		}
+	}
+
+	if (kstrtoul(at + 1, 0, &_addr) != 0) {
+		char *off_str = strpbrk(at + 1, "+-");
+		int offset = 0;
+
+		if (off_str) {
+			if (kstrtoint(off_str, 0, &offset) != 0) {
+				trace_probe_log_err(off_str - _spec, BAD_PROBE_ADDR);
+				return -EINVAL;
+			}
+			*off_str = '\0';
+		}
+		_addr = kallsyms_lookup_name(at + 1);
+		if (!_addr) {
+			trace_probe_log_err(at + 1 - _spec, BAD_ACCESS_ADDR);
+			return -ENOENT;
+		}
+		_addr += offset;
+		*symbol = kstrdup(at + 1, GFP_KERNEL);
+		if (!*symbol)
+			return -ENOMEM;
+	}
+
+	*addr = _addr;
+	*type = _type;
+	*len = _len;
+	return 0;
+}
+
+static int __trace_wprobe_create(int argc, const char *argv[])
+{
+	/*
+	 * Argument syntax:
+	 *  b[:[GRP/][EVENT]] SPEC
+	 *
+	 * SPEC:
+	 *  [r|w|rw]@[ADDR|SYMBOL[+OFFS]][:LEN]
+	 */
+	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
+	struct trace_wprobe *tw __free(free_trace_wprobe) = NULL;
+	const char *event = NULL, *group = WPROBE_EVENT_SYSTEM;
+	const char *tplog __free(trace_probe_log_clear) = NULL;
+	char *symbol = NULL;
+	unsigned long addr;
+	int len, type, i;
+	int ret = 0;
+
+	if (argv[0][0] != 'w')
+		return -ECANCELED;
+
+	if (argc < 2)
+		return -EINVAL;
+
+	tplog = trace_probe_log_init("wprobe", argc, argv);
+
+	if (argv[0][1] != '\0') {
+		if (argv[0][1] != ':') {
+			trace_probe_log_set_index(0);
+			trace_probe_log_err(1, BAD_MAXACT_TYPE);
+			/* Invalid format */
+			return -EINVAL;
+		}
+		event = &argv[0][2];
+	}
+
+	trace_probe_log_set_index(1);
+	ret = parse_address_spec(argv[1], &addr, &type, &len, &symbol);
+	if (ret < 0)
+		return ret;
+
+	if (!event)
+		event = symbol ? symbol : "wprobe";
+
+	argc -= 2; argv += 2;
+	tw = alloc_trace_wprobe(group, event, symbol, addr, len, type, argc);
+	if (IS_ERR(tw))
+		return PTR_ERR(tw);
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->flags = TPARG_FL_KERNEL | TPARG_FL_WPROBE;
+
+	/* parse arguments */
+	for (i = 0; i < argc; i++) {
+		trace_probe_log_set_index(i + 2);
+		ctx->offset = 0;
+		ret = traceprobe_parse_probe_arg(&tw->tp, i, argv[i], ctx);
+		if (ret)
+			return ret;	/* This can be -ENOMEM */
+	}
+
+	ret = traceprobe_set_print_fmt(&tw->tp, PROBE_PRINT_NORMAL);
+	if (ret < 0)
+		return ret;
+
+	ret = register_trace_wprobe_event(tw);
+	if (!ret)
+		tw = NULL; /* To avoid free */
+
+	return ret;
+}
+
+static int trace_wprobe_create(const char *raw_command)
+{
+	return trace_probe_create(raw_command, __trace_wprobe_create);
+}
+
+static int trace_wprobe_release(struct dyn_event *ev)
+{
+	struct trace_wprobe *tw = to_trace_wprobe(ev);
+	int ret = unregister_trace_wprobe(tw);
+
+	if (!ret)
+		free_trace_wprobe(tw);
+	return ret;
+}
+
+static int trace_wprobe_show(struct seq_file *m, struct dyn_event *ev)
+{
+	struct trace_wprobe *tw = to_trace_wprobe(ev);
+	int i;
+
+	seq_printf(m, "w:%s/%s", trace_probe_group_name(&tw->tp),
+		   trace_probe_name(&tw->tp));
+
+	char type_char;
+
+	if (tw->type == HW_BREAKPOINT_R)
+		type_char = 'r';
+	else if (tw->type == HW_BREAKPOINT_W)
+		type_char = 'w';
+	else
+		type_char = 'x'; /* Should be rw */
+
+	int len;
+
+	if (tw->len == HW_BREAKPOINT_LEN_1)
+		len = 1;
+	else if (tw->len == HW_BREAKPOINT_LEN_2)
+		len = 2;
+	else if (tw->len == HW_BREAKPOINT_LEN_4)
+		len = 4;
+	else
+		len = 8;
+
+	if (tw->symbol)
+		seq_printf(m, " %c@%s:%d", type_char, tw->symbol, len);
+	else
+		seq_printf(m, " %c@0x%lx:%d", type_char, tw->addr, len);
+
+	for (i = 0; i < tw->tp.nr_args; i++)
+		seq_printf(m, " %s=%s", tw->tp.args[i].name, tw->tp.args[i].comm);
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static __init int init_wprobe_trace(void)
+{
+	return dyn_event_register(&trace_wprobe_ops);
+}
+fs_initcall(init_wprobe_trace);
+


