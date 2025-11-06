Return-Path: <linux-kernel+bounces-889394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C6BC3D73A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7201891AD3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E0305E09;
	Thu,  6 Nov 2025 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNOLYOZI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51770303CA1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463038; cv=none; b=LkX6Sl7OaZWHq7wVAw3jJf9X4PfZHOpjb8bkU4IHeFFZoM7yXuGCPc7/lOZ6hbKM4apvdquUf+2n4PhvNqJzqTs5D/CT3O5O00H2rgzV996yp6dY9i/17mKxyOgtZ7fV3s9JoqzBbuqOPpZmETwMC9MDqS4yJNE5ZNBzoF8HPOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463038; c=relaxed/simple;
	bh=voCNL6Frp/bCeX0n8ab8z3IJn8JPD5gDRgf0KDYYEA4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ONZK2nsCCYMeBTFuF4rEhCcA3ovh1Vrere/RrumH3c71apZHf/kamJP9aO1GhnOg7x0X+UStZMkZCp8/Rx+Ck98SMIjaJZoDrGIHxoTtVxMenrFG1KTcj2l1UeQ9PukyQpAplIJKKWVMxeICAL736aH63o06YJE49zshcLfH1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNOLYOZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D5CC2BC86;
	Thu,  6 Nov 2025 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762463037;
	bh=voCNL6Frp/bCeX0n8ab8z3IJn8JPD5gDRgf0KDYYEA4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=MNOLYOZIxSABILKahp2sC4pu7ujQbMQLEUaNJbj34g/5wHvDsva3bW6Eua3Q/WyRL
	 y/Ctgs1651DZVDAuzbf1jiGMvvYSXaaGcGhiXDo6ZPsLCrSZ8IFMg/2e6ZShip3NFQ
	 lwTGffGa7acnKCy2Fap7ivfSir/Bn8i8yWVGd9qxHUeYf5QU6AZZF4VFSfVGhJ9uXb
	 cdSFZ/DPVhAJmUZDZW+bTDW8PYmy0XdY13ClhaSkemO7N9+1gvlesRLtgQl/FKM9Mt
	 rsLrQzbMssdLiFOIClMM49fGNGF0s3SsK28jyP7PnzPbBi6lrHL7HFXoZ3FdBK+hC7
	 F3Cr6jEqZk71A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vH79B-000000008Cq-2h6Y;
	Thu, 06 Nov 2025 16:03:57 -0500
Message-ID: <20251106210357.498967804@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 06 Nov 2025 16:03:35 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 4/7] tracing: Remove dummy options and flags
References: <20251106210331.537317097@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When a tracer does not define their own flags, dummy options and flags are
used so that the values are always valid. There's not that many locations
that reference these values so having dummy versions just complicates the
code. Remove the dummy values and just check for NULL when appropriate.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://patch.msgid.link/20251105161935.206093132@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 48 +++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0e822db5d9e4..afeaa9a164e9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -94,17 +94,6 @@ static bool tracepoint_printk_stop_on_boot __initdata;
 static bool traceoff_after_boot __initdata;
 static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
 
-/* For tracers that don't implement custom flags */
-static struct tracer_opt dummy_tracer_opt[] = {
-	{ }
-};
-
-static int
-dummy_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
-{
-	return 0;
-}
-
 /*
  * To prevent the comm cache from being overwritten when no
  * tracing is active, only save the comm when a trace event
@@ -2356,23 +2345,9 @@ int __init register_tracer(struct tracer *type)
 		}
 	}
 
-	if (!type->set_flag)
-		type->set_flag = &dummy_set_flag;
-	if (!type->flags) {
-		/*allocate a dummy tracer_flags*/
-		type->flags = kmalloc(sizeof(*type->flags), GFP_KERNEL);
-		if (!type->flags) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		type->flags->val = 0;
-		type->flags->opts = dummy_tracer_opt;
-	} else
-		if (!type->flags->opts)
-			type->flags->opts = dummy_tracer_opt;
-
 	/* store the tracer for __set_tracer_option */
-	type->flags->trace = type;
+	if (type->flags)
+		type->flags->trace = type;
 
 	ret = do_run_tracer_selftest(type);
 	if (ret < 0)
@@ -5159,14 +5134,12 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 {
 	struct tracer_opt *trace_opts;
 	struct trace_array *tr = m->private;
+	struct tracer *trace;
 	u32 tracer_flags;
 	int i;
 
 	guard(mutex)(&trace_types_lock);
 
-	tracer_flags = tr->current_trace->flags->val;
-	trace_opts = tr->current_trace->flags->opts;
-
 	for (i = 0; trace_options[i]; i++) {
 		if (tr->trace_flags & (1ULL << i))
 			seq_printf(m, "%s\n", trace_options[i]);
@@ -5174,6 +5147,13 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 			seq_printf(m, "no%s\n", trace_options[i]);
 	}
 
+	trace = tr->current_trace;
+	if (!trace->flags || !trace->flags->opts)
+		return 0;
+
+	tracer_flags = tr->current_trace->flags->val;
+	trace_opts = tr->current_trace->flags->opts;
+
 	for (i = 0; trace_opts[i].name; i++) {
 		if (tracer_flags & trace_opts[i].bit)
 			seq_printf(m, "%s\n", trace_opts[i].name);
@@ -5189,9 +5169,10 @@ static int __set_tracer_option(struct trace_array *tr,
 			       struct tracer_opt *opts, int neg)
 {
 	struct tracer *trace = tracer_flags->trace;
-	int ret;
+	int ret = 0;
 
-	ret = trace->set_flag(tr, tracer_flags->val, opts->bit, !neg);
+	if (trace->set_flag)
+		ret = trace->set_flag(tr, tracer_flags->val, opts->bit, !neg);
 	if (ret)
 		return ret;
 
@@ -5210,6 +5191,9 @@ static int set_tracer_option(struct trace_array *tr, char *cmp, int neg)
 	struct tracer_opt *opts = NULL;
 	int i;
 
+	if (!tracer_flags || !tracer_flags->opts)
+		return 0;
+
 	for (i = 0; tracer_flags->opts[i].name; i++) {
 		opts = &tracer_flags->opts[i];
 
-- 
2.51.0



