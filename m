Return-Path: <linux-kernel+bounces-890453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B84AC40172
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1861F4EE180
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C052D97AA;
	Fri,  7 Nov 2025 13:24:49 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B572DAFBF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521889; cv=none; b=t0t3dEArv5sCir8u4p2piI3VZc3Z8RDuttHETSn7vYKuBYpa/7cfysiOjmx6nG0A6J6oGBlS6lS5/bcYcVUbkcMjqlk7ubC/Z+8XsrN12x3GSc6HJZtQBx0Fw63cX3VqjLQD5vP91W1GhYGkhTzsASABGdbSGQUM+y19ZhCZgBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521889; c=relaxed/simple;
	bh=+kSqEW8KprcnZcsKwMRI/SObqdZug8SKrPXS1WYuDI8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PFzthHf8AgbPZBd4BW0cOZarNYJMUk1VVYbIAevP06n1BiS4w4TFzlJVRHwHXaCnqBVe1S9fSnmQGTKE+6JQhPeQ1NE01OONp8pIkQ5EK4t/YjMs+ODaWcqvbexdIgenWGBt2QpdmxoJLt9MaZAhsg7V/N16S6nGQ+/oaR4xqvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 24A004B986;
	Fri,  7 Nov 2025 13:24:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 3F2B42000D;
	Fri,  7 Nov 2025 13:24:43 +0000 (UTC)
Date: Fri, 7 Nov 2025 08:24:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Zhang
 Chujun <zhangchujun@cmss.chinamobile.com>, Zilin Guan <zilin@seu.edu.cn>
Subject: [GIT PULL] tracing: A few minor fixes for v6.18
Message-ID: <20251107082444.45c4536d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: u4zd1qxzaof6u6pk8sqtswmaxpw88q79
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3F2B42000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+fmYaqL0zi8T+Bo9Zc/CD7cUNfWYlBuPA=
X-HE-Tag: 1762521883-120543
X-HE-Meta: U2FsdGVkX1+h/RreJl5gkdvQtAbGiNXpr/CITmq+n0zTlkdi5IiRBpHEHXl2s8Fe6ej4b9MmWRxxxp3HZC806ZOEoZUFh9o/9k4PySdzfyonKYANhiBptK028sVd5t/PvYQrlpEn9uj1gtrhXreV166OEAyllR9x9G0RtMKoq4EnWwkq1oXtUgeVbwpyZc8lyBK0toPB4ZwBORIUIumLcXLkmx7jOKC8ihHVAd10CrYK2U7yef/uvs9vLiYJxfK8gsQQViBubBDNW9FHTuIAstGr4xCQzb+SpV+Zom5qt0gP3EBy09ANNig3kqlgSHLd0PD0Mt6FqSygCOse9PQI4GmLzedlEsTv


Linus,

Fixes for tracing:

- Check for reader catching up in ring_buffer_map_get_reader()

  If the reader catches up to the writer in the memory mapped ring buffer
  then calling rb_get_reader_page() will return NULL as there's no
  pages left. But this isn't checked for before calling rb_get_reader_page()
  and the return of NULL causes a warning.

  If it is detected that the reader caught up to the writer, then simply
  exit the routine.

- Fix memory leak in histogram create_field_var()

  The couple of the error paths in create_field_var() did not properly clean
  up what was allocated. Make sure everything is freed properly on error.

- Fix help message of tools latency_collector

  The help message incorrectly stated that "-t" was the same as "--threads"
  whereas "--threads" is actually represented by "-e".


Please pull the latest trace-v6.18-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.18-rc4

Tag SHA1: a9d5bb4a7261f61be9248ee46ff77fd0c6261970
Head SHA1: 53afec2c8fb2a562222948cb1c2aac48598578c9


Steven Rostedt (1):
      ring-buffer: Do not warn in ring_buffer_map_get_reader() when reader catches up

Zhang Chujun (1):
      tracing/tools: Fix incorrcet short option in usage text for --threads

Zilin Guan (1):
      tracing: Fix memory leaks in create_field_var()

----
 kernel/trace/ring_buffer.c                | 4 ++++
 kernel/trace/trace_events_hist.c          | 6 ++++--
 tools/tracing/latency/latency-collector.c | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)
---------------------------
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1244d2c5c384..afcd3747264d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7344,6 +7344,10 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 		goto out;
 	}
 
+	/* Did the reader catch up with the writer? */
+	if (cpu_buffer->reader_page == cpu_buffer->commit_page)
+		goto out;
+
 	reader = rb_get_reader_page(cpu_buffer);
 	if (WARN_ON(!reader))
 		goto out;
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1d536219b624..6bfaf1210dd2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3272,14 +3272,16 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 	var = create_var(hist_data, file, field_name, val->size, val->type);
 	if (IS_ERR(var)) {
 		hist_err(tr, HIST_ERR_VAR_CREATE_FIND_FAIL, errpos(field_name));
-		kfree(val);
+		destroy_hist_field(val, 0);
 		ret = PTR_ERR(var);
 		goto err;
 	}
 
 	field_var = kzalloc(sizeof(struct field_var), GFP_KERNEL);
 	if (!field_var) {
-		kfree(val);
+		destroy_hist_field(val, 0);
+		kfree_const(var->type);
+		kfree(var->var.name);
 		kfree(var);
 		ret =  -ENOMEM;
 		goto err;
diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index cf263fe9deaf..ef97916e3873 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -1725,7 +1725,7 @@ static void show_usage(void)
 "-n, --notrace\t\tIf latency is detected, do not print out the content of\n"
 "\t\t\tthe trace file to standard output\n\n"
 
-"-t, --threads NRTHR\tRun NRTHR threads for printing. Default is %d.\n\n"
+"-e, --threads NRTHR\tRun NRTHR threads for printing. Default is %d.\n\n"
 
 "-r, --random\t\tArbitrarily sleep a certain amount of time, default\n"
 "\t\t\t%ld ms, before reading the trace file. The\n"

