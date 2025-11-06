Return-Path: <linux-kernel+bounces-889390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AC9C3D72E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C021891853
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E533043D5;
	Thu,  6 Nov 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biKHxE3e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E069303A3F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463038; cv=none; b=WyZT2IZAICSJOaFRvbt29iAI+6CDJMGuNPc1MhIc/NX2mD5GkkcMs/2d/QjRK63+ZVuqIHX+OMNInPvBFF6XmcUIMIuBou/4TINU+ch37q2Gv+Jj0imjQkjcPoySD4KW0JZ7HRVeDTyze3hyhE+yUyGZx0IXnyp8cqk34vSTm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463038; c=relaxed/simple;
	bh=XNTfJoDevPl1hb1ZjuSJXLXWay9V6LixMtZD8WcvW+Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hQvOenhBRCHX461u/FZrC5WebF2a7HyExkoGJn4pFrrd843sRapUpWq5lvacvXn/sWTA5jm9C/xI4qnyP1yiJn0xpwW9JrjnE5o0yd1rCoNAsEyM+3REP1/7tSEabN2h+XCf7Bmxf6XgRkN4WDrBzYycfpa75R5pGpjXxKTAKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biKHxE3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA95C4CEF7;
	Thu,  6 Nov 2025 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762463037;
	bh=XNTfJoDevPl1hb1ZjuSJXLXWay9V6LixMtZD8WcvW+Q=;
	h=Date:From:To:Cc:Subject:References:From;
	b=biKHxE3erkHggVyMvU9jrhnq0aWqdgfSiUBBnPf8rxCgdVsjQ9W37hts2Gk/MiizB
	 LfCpaIQ2b/BBuYL0KDN5O7x6+AU5N7P4lHEq6MYLHLv5fS1SaQ56tAoaAXzj30koFp
	 Yk9jYCg+UpXW+nJKHmT8tPNz+h9j235hpQYG/Q3rgbSa1BT+dr77iD+DoEH3nM4u72
	 QG1MFCJ7d96JSCbXPaeDi1+/eHLbrcsPNEKzsOP0GJrw8Y7mOainYfj3wzkam1iZvG
	 JMPSg6omiXQHa72P7xp7n9g7ojvZQP8hgHCRQLkJBvmFPnVqKTz66JFr34ttxUAqKX
	 MdZUbG85gy/rw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vH79B-000000008Bs-1Htm;
	Thu, 06 Nov 2025 16:03:57 -0500
Message-ID: <20251106210357.157755907@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 06 Nov 2025 16:03:33 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 2/7] tracing: Add an option to show symbols in _text+offset for function
 profiler
References: <20251106210331.537317097@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Function profiler shows the hit count of each function using its symbol
name. However, there are some same-name local symbols, which we can not
distinguish.
To solve this issue, this introduces an option to show the symbols
in "_text+OFFSET" format. This can avoid exposing the random shift of
KASLR. The functions in modules are shown as "MODNAME+OFFSET" where the
offset is from ".text".

E.g. for the kernel text symbols, specify vmlinux and the output to
 addr2line, you can find the actual function and source info;

  $ addr2line -fie vmlinux _text+3078208
  __balance_callbacks
  kernel/sched/core.c:5064

for modules, specify the module file and .text+OFFSET;

  $ addr2line -fie samples/trace_events/trace-events-sample.ko .text+8224
  do_simple_thread_func
  samples/trace_events/trace-events-sample.c:23

Link: https://lore.kernel.org/all/176187878064.994619.8878296550240416558.stgit@devnote2/

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ftrace.c | 26 +++++++++++++++++++++++++-
 kernel/trace/trace.c  |  5 +++--
 kernel/trace/trace.h  | 11 ++++++++++-
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 42bd2ba68a82..ab601cd9638b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -534,7 +534,9 @@ static int function_stat_headers(struct seq_file *m)
 
 static int function_stat_show(struct seq_file *m, void *v)
 {
+	struct trace_array *tr = trace_get_global_array();
 	struct ftrace_profile *rec = v;
+	const char *refsymbol = NULL;
 	char str[KSYM_SYMBOL_LEN];
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	static struct trace_seq s;
@@ -554,7 +556,29 @@ static int function_stat_show(struct seq_file *m, void *v)
 		return 0;
 #endif
 
-	kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
+	if (tr->trace_flags & TRACE_ITER(PROF_TEXT_OFFSET)) {
+		unsigned long offset;
+
+		if (core_kernel_text(rec->ip)) {
+			refsymbol = "_text";
+			offset = rec->ip - (unsigned long)_text;
+		} else {
+			struct module *mod;
+
+			guard(rcu)();
+			mod = __module_text_address(rec->ip);
+			if (mod) {
+				refsymbol = mod->name;
+				/* Calculate offset from module's text entry address. */
+				offset = rec->ip - (unsigned long)mod->mem[MOD_TEXT].base;
+			}
+		}
+		if (refsymbol)
+			snprintf(str, sizeof(str), "  %s+%#lx", refsymbol, offset);
+	}
+	if (!refsymbol)
+		kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
+
 	seq_printf(m, "  %-30.30s  %10lu", str, rec->counter);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 14e8703a6a53..e5f186daf007 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -522,7 +522,8 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 
 /* trace_options that are only supported by global_trace */
 #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER(PRINTK) |			\
-	       TRACE_ITER(PRINTK_MSGONLY) | TRACE_ITER(RECORD_CMD))
+	       TRACE_ITER(PRINTK_MSGONLY) | TRACE_ITER(RECORD_CMD) |	\
+	       TRACE_ITER(PROF_TEXT_OFFSET))
 
 /* trace_flags that are default zero for instances */
 #define ZEROED_TRACE_FLAGS \
@@ -11291,7 +11292,7 @@ __init static int tracer_alloc_buffers(void)
 
 #ifdef CONFIG_FUNCTION_TRACER
 /* Used to set module cached ftrace filtering at boot up */
-__init struct trace_array *trace_get_global_array(void)
+struct trace_array *trace_get_global_array(void)
 {
 	return &global_trace;
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8c99136619bf..7d8f4bd9facd 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1359,6 +1359,14 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 # define STACK_FLAGS
 #endif
 
+#ifdef CONFIG_FUNCTION_PROFILER
+# define PROFILER_FLAGS					\
+		C(PROF_TEXT_OFFSET,	"prof-text-offset"),
+#else
+# define PROFILER_FLAGS
+# define TRACE_ITER_PROF_TEXT_OFFSET_BIT	-1
+#endif
+
 /*
  * trace_iterator_flags is an enumeration that defines bit
  * positions into trace_flags that controls the output.
@@ -1397,7 +1405,8 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
-		BRANCH_FLAGS
+		BRANCH_FLAGS					\
+		PROFILER_FLAGS
 
 /*
  * By defining C, we can make TRACE_FLAGS a list of bit names
-- 
2.51.0



