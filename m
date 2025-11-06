Return-Path: <linux-kernel+bounces-889393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2ADC3D731
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D37E3B7186
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F413C304BA0;
	Thu,  6 Nov 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHZMFbAD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45438303CA0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463038; cv=none; b=E+7t74wRsAOGQE3UPoa3peI03BRPFCZA8DJ5p883yw+bY/SBJ53IxM4NUx/DvyhsHJbqaMx2W1RrSPRfj+CcjOt2B2hq5bhPTp8BqSjHtys1ThmDIqOwl0wmuhJWRiV6Gnk+GA+IQGuvZEFPmuV872rLH7RIoqMVphxs4Co5KII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463038; c=relaxed/simple;
	bh=tJVTfvIahPAX1PxDS/vCqXJD0uo0I5JkC53Sw22Tl1Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EGLUCwmfn9m9Cmqd/07Z5H9tS8MizOqsKY7NUaMysHf093TFn1DbefNZE2P4yZXVJX8pE0Vw5dFWlcOucugzfYUj73mLbiV/MFUBxAJCwLZX3Co+dl7mxkYjdUyEyRFlOdKtOd9MLZHa7Zxcx87adToT15+DIde4Y3sQWJ7JcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHZMFbAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2049BC116C6;
	Thu,  6 Nov 2025 21:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762463038;
	bh=tJVTfvIahPAX1PxDS/vCqXJD0uo0I5JkC53Sw22Tl1Q=;
	h=Date:From:To:Cc:Subject:References:From;
	b=bHZMFbADskIWZrWLOWxe+rUPX2YIoi/AfJF55ev9WpZRnZHJ59mDWieIhw2K5CGpI
	 NwnJKMddLqURIQ75lIKZIyK54hukWk+2z2VRY+VFn0xFY3msBYQpNnrtdsvfnnLehN
	 Tv5nRYzyawXBmVNJHwtGpz7aAfL1C3hqs0hPu6hCNYwBrLhVHk6ml94UcEyASAp+Po
	 iHH1iQjV5AVEvlYkgzzeYQZT8KHJqGVkjrRTAHU+kTMd8mk7Ro7by1cYlHosyftUdw
	 vaFnPUVyIZWlORTkm2ttq38IsbbuaCfGegkqk/qh4qcEAFF0iUxLI2MTJqCAOoP77x
	 4vUxM5yEEmA9w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vH79B-000000008DK-3OAE;
	Thu, 06 Nov 2025 16:03:57 -0500
Message-ID: <20251106210357.662018725@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 06 Nov 2025 16:03:36 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 5/7] tracing: Have add_tracer_options() error pass up to callers
References: <20251106210331.537317097@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function add_tracer_options() can fail, but currently it is ignored.
Pass the status of add_tracer_options() up to adding a new tracer as well
as when an instance is created. Have the instance creation fail if the
add_tracer_options() fail.

Only print a warning for the top level instance, like it does with other
failures.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://patch.msgid.link/20251105161935.375299297@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 55 +++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index afeaa9a164e9..ed929d331e1d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2302,7 +2302,7 @@ static inline int do_run_tracer_selftest(struct tracer *type)
 }
 #endif /* CONFIG_FTRACE_STARTUP_TEST */
 
-static void add_tracer_options(struct trace_array *tr, struct tracer *t);
+static int add_tracer_options(struct trace_array *tr, struct tracer *t);
 
 static void __init apply_trace_boot_options(void);
 
@@ -2353,9 +2353,14 @@ int __init register_tracer(struct tracer *type)
 	if (ret < 0)
 		goto out;
 
+	ret = add_tracer_options(&global_trace, type);
+	if (ret < 0) {
+		pr_warn("Failed to create tracer options for %s\n", type->name);
+		goto out;
+	}
+
 	type->next = trace_types;
 	trace_types = type;
-	add_tracer_options(&global_trace, type);
 
  out:
 	mutex_unlock(&trace_types_lock);
@@ -6221,7 +6226,7 @@ int tracing_update_buffers(struct trace_array *tr)
 
 struct trace_option_dentry;
 
-static void
+static int
 create_trace_option_files(struct trace_array *tr, struct tracer *tracer);
 
 /*
@@ -6243,17 +6248,17 @@ static void tracing_set_nop(struct trace_array *tr)
 
 static bool tracer_options_updated;
 
-static void add_tracer_options(struct trace_array *tr, struct tracer *t)
+static int add_tracer_options(struct trace_array *tr, struct tracer *t)
 {
 	/* Only enable if the directory has been created already. */
 	if (!tr->dir && !(tr->flags & TRACE_ARRAY_FL_GLOBAL))
-		return;
+		return 0;
 
 	/* Only create trace option files after update_tracer_options finish */
 	if (!tracer_options_updated)
-		return;
+		return 0;
 
-	create_trace_option_files(tr, t);
+	return create_trace_option_files(tr, t);
 }
 
 int tracing_set_tracer(struct trace_array *tr, const char *buf)
@@ -9585,7 +9590,7 @@ create_trace_option_file(struct trace_array *tr,
 
 }
 
-static void
+static int
 create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 {
 	struct trace_option_dentry *topts;
@@ -9596,24 +9601,24 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 	int i;
 
 	if (!tracer)
-		return;
+		return 0;
 
 	flags = tracer->flags;
 
 	if (!flags || !flags->opts)
-		return;
+		return 0;
 
 	/*
 	 * If this is an instance, only create flags for tracers
 	 * the instance may have.
 	 */
 	if (!trace_ok_for_array(tracer, tr))
-		return;
+		return 0;
 
 	for (i = 0; i < tr->nr_topts; i++) {
 		/* Make sure there's no duplicate flags. */
 		if (WARN_ON_ONCE(tr->topts[i].tracer->flags == tracer->flags))
-			return;
+			return -EINVAL;
 	}
 
 	opts = flags->opts;
@@ -9623,13 +9628,13 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 
 	topts = kcalloc(cnt + 1, sizeof(*topts), GFP_KERNEL);
 	if (!topts)
-		return;
+		return 0;
 
 	tr_topts = krealloc(tr->topts, sizeof(*tr->topts) * (tr->nr_topts + 1),
 			    GFP_KERNEL);
 	if (!tr_topts) {
 		kfree(topts);
-		return;
+		return -ENOMEM;
 	}
 
 	tr->topts = tr_topts;
@@ -9644,6 +9649,7 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 			  "Failed to create trace option: %s",
 			  opts[cnt].name);
 	}
+	return 0;
 }
 
 static struct dentry *
@@ -10094,15 +10100,18 @@ static void init_trace_flags_index(struct trace_array *tr)
 		tr->trace_flags_index[i] = i;
 }
 
-static void __update_tracer_options(struct trace_array *tr)
+static int __update_tracer_options(struct trace_array *tr)
 {
 	struct tracer *t;
+	int ret = 0;
+
+	for (t = trace_types; t && !ret; t = t->next)
+		ret = add_tracer_options(tr, t);
 
-	for (t = trace_types; t; t = t->next)
-		add_tracer_options(tr, t);
+	return ret;
 }
 
-static void update_tracer_options(struct trace_array *tr)
+static __init void update_tracer_options(struct trace_array *tr)
 {
 	guard(mutex)(&trace_types_lock);
 	tracer_options_updated = true;
@@ -10151,9 +10160,13 @@ static int trace_array_create_dir(struct trace_array *tr)
 	}
 
 	init_tracer_tracefs(tr, tr->dir);
-	__update_tracer_options(tr);
-
-	return ret;
+	ret = __update_tracer_options(tr);
+	if (ret) {
+		event_trace_del_tracer(tr);
+		tracefs_remove(tr->dir);
+		return ret;
+	}
+	return 0;
 }
 
 static struct trace_array *
-- 
2.51.0



