Return-Path: <linux-kernel+bounces-601583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4E6A86FC1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 23:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286A18A5AEE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 21:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EC5230D01;
	Sat, 12 Apr 2025 21:03:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F22253F6
	for <linux-kernel@vger.kernel.org>; Sat, 12 Apr 2025 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744491823; cv=none; b=L00/BNTc8ufD5CuUNU/6gNdcO18NVQEjENMw7g+Bshz5OkyPvXJazJu73vuCNItfVJRNns3eFpWM/1ZZN7K8aZpE2hsY1AborbEsAaxAdbvgrDAoGQdP/VciDBVeAYKfMdqceTOmLCoqmhCZ9REnIgB0gB4KP1pL1Y9Bz7wWiv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744491823; c=relaxed/simple;
	bh=vlcadWhN1kpMYnw+3E7ZcAlZv9dphSozdaw8cKl3E4M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VagA78VL9wn7Bf5ZiIlkp5WcxFjL8ay9XGQb8POQVkSjjbCGsKsygvwa/oMLDrKd8Cbs+gAerLD020/uJAv4FexHoSl1sdJZYxRGNX7dB+833ANnqc9me6YsQ+DgiB2ztKWcwwZYEwhJJOOcYmRWeLEMYOJg3GlDxJt+mjETBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEDEC4CEE3;
	Sat, 12 Apr 2025 21:03:43 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u3i2J-0000000AEFq-1FNU;
	Sat, 12 Apr 2025 17:05:11 -0400
Message-ID: <20250412210511.150486416@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 12 Apr 2025 17:04:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Brown <broonie@kernel.org>
Subject: [for-linus][PATCH 6/7] ftrace: Do not have print_graph_retval() add a newline
References: <20250412210446.338481957@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The retval and retaddr options for function_graph tracer will add a
comment at the end of a function for both leaf and non leaf functions that
looks like:

               __wake_up_common(); /* ret=0x1 */

               } /* pick_next_task_fair ret=0x0 */

The function print_graph_retval() adds a newline after the "*/". But if
that's not called, the caller function needs to make sure there's a
newline added.

This is confusing and when the function parameters code was added, it
added a newline even when calling print_graph_retval() as the fact that
the print_graph_retval() function prints a newline isn't obvious.

This caused an extra newline to be printed and that made it fail the
selftests when the retval option was set, as the selftests were not
expecting blank lines being injected into the trace.

Instead of having print_graph_retval() print a newline, just have the
caller always print the newline regardless if it calls print_graph_retval()
or not. This not only fixes this bug, but it also simplifies the code.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250411133015.015ca393@gandalf.local.home
Reported-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk/
Fixes: ff5c9c576e754 ("ftrace: Add support for function argument to graph tracer")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 2f077d4158e5..0c357a89c58e 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -880,8 +880,6 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 
 		if (print_retval || print_retaddr)
 			trace_seq_puts(s, " /*");
-		else
-			trace_seq_putc(s, '\n');
 	} else {
 		print_retaddr = false;
 		trace_seq_printf(s, "} /* %ps", func);
@@ -899,7 +897,7 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 	}
 
 	if (!entry || print_retval || print_retaddr)
-		trace_seq_puts(s, " */\n");
+		trace_seq_puts(s, " */");
 }
 
 #else
@@ -975,7 +973,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 		} else
 			trace_seq_puts(s, "();");
 	}
-	trace_seq_printf(s, "\n");
+	trace_seq_putc(s, '\n');
 
 	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
 			cpu, iter->ent->pid, flags);
@@ -1313,10 +1311,11 @@ print_graph_return(struct ftrace_graph_ret_entry *retentry, struct trace_seq *s,
 		 * that if the funcgraph-tail option is enabled.
 		 */
 		if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
-			trace_seq_puts(s, "}\n");
+			trace_seq_puts(s, "}");
 		else
-			trace_seq_printf(s, "} /* %ps */\n", (void *)func);
+			trace_seq_printf(s, "} /* %ps */", (void *)func);
 	}
+	trace_seq_putc(s, '\n');
 
 	/* Overrun */
 	if (flags & TRACE_GRAPH_PRINT_OVERRUN)
-- 
2.47.2



