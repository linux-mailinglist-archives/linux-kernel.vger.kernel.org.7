Return-Path: <linux-kernel+bounces-753805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B312B1883B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 22:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC4416BCF8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3944328DB77;
	Fri,  1 Aug 2025 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEbBDZvA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79194214812;
	Fri,  1 Aug 2025 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080716; cv=none; b=AQCpZOBQM+IpEjDsHiz0jO1nffo9YyT4FmG0R8sbKLn1RRXJ24EQJWnBRngRsvV9pw8J4cLF5oyw3BZIBiOymol9zYZt/jRYTPaM+kBFM4fjzMZEdK0KO9jYHHOA3xc9AmUpZSJz0S8/mWkBYivaH2VIJ7xJt7AhH39KBTWOpgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080716; c=relaxed/simple;
	bh=cctrR7jatq+pM1SG3SF/xhHgsBAYobbqH/fKsmbXX3k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iNk5a2idMmiBvBd9apeAifSAKEBeeagGwsl61Xu4hSZnTd2VITCnetMqQdtXTRBvDUYIHHoxdsp71C/D8ulP7A7h8zxgLOa4Ba3nL8VGiVwmRljAVEfN6THHIoYopLXHF9rXZqSFyktOWKeP4011eur6yMjXPVDmbczjjDSUGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEbBDZvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2326FC4CEE7;
	Fri,  1 Aug 2025 20:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754080716;
	bh=cctrR7jatq+pM1SG3SF/xhHgsBAYobbqH/fKsmbXX3k=;
	h=Date:From:To:Cc:Subject:References:From;
	b=LEbBDZvAnfOGCB0aaDEQ9y2wpM8L8pigaIlahtVspSBIb1gZI2TQ18B4N+6ahTkjS
	 KGkFFzExozb2diTg/XTtizoTJ65KNdk+IWQX008DwNQVLkqjVAUNRj5qcKQ9reNwhW
	 K8XDi1NcE/B8o6ITNL7gviYijjKqWOs1YQRxgIJs2sxb5118b01UisFFrFjyutDnmZ
	 Slj9fSqyaBuNtrneGYn1H8YnaiLyPq/ZrJV8BvQF2a4LexmY1LR/70y70Muh4tiI2I
	 5yzmec7iYfo68U8xwKZrCf7eTyrEwXizxLYd+7ih6LfpMAX697PbNL91bLAzG5ZpGy
	 g9S//jm5CLofQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uhwWn-00000007ja5-3bIc;
	Fri, 01 Aug 2025 16:38:57 -0400
Message-ID: <20250801203857.710501021@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 01 Aug 2025 16:37:24 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/5] tracing: Add guard(ring_buffer_nest)
References: <20250801203722.072085868@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Some calls to the tracing ring buffer can happen when the ring buffer is
already being written to by the same context (for example, a
trace_printk() in between a ring_buffer_lock_reserve() and a
ring_buffer_unlock_commit()).

In order to not trigger the recursion detection, these functions use
ring_buffer_nest_start() and ring_buffer_nest_end(). Create a guard() for
these functions so that their use cases can be simplified and not need to
use goto for the release.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h       |  3 ++
 kernel/trace/trace.c              | 69 +++++++++++++------------------
 kernel/trace/trace_events_synth.c |  6 +--
 3 files changed, 34 insertions(+), 44 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index cd7f0ae26615..8253cb69540c 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -144,6 +144,9 @@ int ring_buffer_write(struct trace_buffer *buffer,
 void ring_buffer_nest_start(struct trace_buffer *buffer);
 void ring_buffer_nest_end(struct trace_buffer *buffer);
 
+DEFINE_GUARD(ring_buffer_nest, struct trace_buffer *,
+	     ring_buffer_nest_start(_T), ring_buffer_nest_end(_T))
+
 struct ring_buffer_event *
 ring_buffer_peek(struct trace_buffer *buffer, int cpu, u64 *ts,
 		 unsigned long *lost_events);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0ec9cab9a812..332487179e1d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1160,13 +1160,11 @@ int __trace_array_puts(struct trace_array *tr, unsigned long ip,
 
 	trace_ctx = tracing_gen_ctx();
 	buffer = tr->array_buffer.buffer;
-	ring_buffer_nest_start(buffer);
+	guard(ring_buffer_nest)(buffer);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,
 					    trace_ctx);
-	if (!event) {
-		size = 0;
-		goto out;
-	}
+	if (!event)
+		return 0;
 
 	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
@@ -1182,8 +1180,6 @@ int __trace_array_puts(struct trace_array *tr, unsigned long ip,
 
 	__buffer_unlock_commit(buffer, event);
 	ftrace_trace_stack(tr, buffer, trace_ctx, 4, NULL);
- out:
-	ring_buffer_nest_end(buffer);
 	return size;
 }
 EXPORT_SYMBOL_GPL(__trace_array_puts);
@@ -1213,7 +1209,6 @@ int __trace_bputs(unsigned long ip, const char *str)
 	struct bputs_entry *entry;
 	unsigned int trace_ctx;
 	int size = sizeof(struct bputs_entry);
-	int ret = 0;
 
 	if (!printk_binsafe(tr))
 		return __trace_puts(ip, str, strlen(str));
@@ -1227,11 +1222,11 @@ int __trace_bputs(unsigned long ip, const char *str)
 	trace_ctx = tracing_gen_ctx();
 	buffer = tr->array_buffer.buffer;
 
-	ring_buffer_nest_start(buffer);
+	guard(ring_buffer_nest)(buffer);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_BPUTS, size,
 					    trace_ctx);
 	if (!event)
-		goto out;
+		return 0;
 
 	entry = ring_buffer_event_data(event);
 	entry->ip			= ip;
@@ -1240,10 +1235,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 	__buffer_unlock_commit(buffer, event);
 	ftrace_trace_stack(tr, buffer, trace_ctx, 4, NULL);
 
-	ret = 1;
- out:
-	ring_buffer_nest_end(buffer);
-	return ret;
+	return 1;
 }
 EXPORT_SYMBOL_GPL(__trace_bputs);
 
@@ -3397,21 +3389,19 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 
 	size = sizeof(*entry) + sizeof(u32) * len;
 	buffer = tr->array_buffer.buffer;
-	ring_buffer_nest_start(buffer);
-	event = __trace_buffer_lock_reserve(buffer, TRACE_BPRINT, size,
-					    trace_ctx);
-	if (!event)
-		goto out;
-	entry = ring_buffer_event_data(event);
-	entry->ip			= ip;
-	entry->fmt			= fmt;
-
-	memcpy(entry->buf, tbuffer, sizeof(u32) * len);
-	__buffer_unlock_commit(buffer, event);
-	ftrace_trace_stack(tr, buffer, trace_ctx, 6, NULL);
+	scoped_guard(ring_buffer_nest, buffer) {
+		event = __trace_buffer_lock_reserve(buffer, TRACE_BPRINT, size,
+						    trace_ctx);
+		if (!event)
+			goto out_put;
+		entry = ring_buffer_event_data(event);
+		entry->ip			= ip;
+		entry->fmt			= fmt;
 
-out:
-	ring_buffer_nest_end(buffer);
+		memcpy(entry->buf, tbuffer, sizeof(u32) * len);
+		__buffer_unlock_commit(buffer, event);
+		ftrace_trace_stack(tr, buffer, trace_ctx, 6, NULL);
+	}
 out_put:
 	put_trace_buf();
 
@@ -3452,20 +3442,19 @@ int __trace_array_vprintk(struct trace_buffer *buffer,
 	len = vscnprintf(tbuffer, TRACE_BUF_SIZE, fmt, args);
 
 	size = sizeof(*entry) + len + 1;
-	ring_buffer_nest_start(buffer);
-	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
-					    trace_ctx);
-	if (!event)
-		goto out;
-	entry = ring_buffer_event_data(event);
-	entry->ip = ip;
-
-	memcpy(&entry->buf, tbuffer, len + 1);
-	__buffer_unlock_commit(buffer, event);
-	ftrace_trace_stack(printk_trace, buffer, trace_ctx, 6, NULL);
+	scoped_guard(ring_buffer_nest, buffer) {
+		event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
+						    trace_ctx);
+		if (!event)
+			goto out;
+		entry = ring_buffer_event_data(event);
+		entry->ip = ip;
 
+		memcpy(&entry->buf, tbuffer, len + 1);
+		__buffer_unlock_commit(buffer, event);
+		ftrace_trace_stack(printk_trace, buffer, trace_ctx, 6, NULL);
+	}
 out:
-	ring_buffer_nest_end(buffer);
 	put_trace_buf();
 
 out_nobuffer:
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 33cfbd4ed76d..f24ee61f8884 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -536,12 +536,12 @@ static notrace void trace_event_raw_event_synth(void *__data,
 	 * is being performed within another event.
 	 */
 	buffer = trace_file->tr->array_buffer.buffer;
-	ring_buffer_nest_start(buffer);
+	guard(ring_buffer_nest)(buffer);
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + fields_size);
 	if (!entry)
-		goto out;
+		return;
 
 	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
 		val_idx = var_ref_idx[i];
@@ -584,8 +584,6 @@ static notrace void trace_event_raw_event_synth(void *__data,
 	}
 
 	trace_event_buffer_commit(&fbuffer);
-out:
-	ring_buffer_nest_end(buffer);
 }
 
 static void free_synth_event_print_fmt(struct trace_event_call *call)
-- 
2.47.2



