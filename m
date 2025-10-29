Return-Path: <linux-kernel+bounces-876415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8F9C1B83E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171E45841F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435BF354AD8;
	Wed, 29 Oct 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIOaac6J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8F3358B6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748844; cv=none; b=rHMpowzDMqZ9NQia1PTafW9i7q2UEryAaqC8PXHCHCbfotV69oAIUIF2Oi6OZYcMigRgdTNWurXpA90X0YEKURbe74czQq/uJzNILEiHD5bkISj7ErnpzKx+Rtgj20qsic4Hroe9id0hGppyOYrAJhehxqdBW/5J5pHCWw8Z6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748844; c=relaxed/simple;
	bh=KbIdQC6dInMhDPP8n6SgWM0TljxNLeWT7q2kyt6LT44=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=feBDynLYr70U0GqiR16g7deZuxPFsVfjnQ/tMsuMgP1I7t4T4QYLP96kCHfMIoh/zb/8FlwIJMduArQa9gtZ/EyXmwzkq6OzKZQBfnoLYm0lbbGNNnJfIvNxL6c58RHzCAlk1uk/U2kB1xDNO6TjvViSGJFJsNJwGgRFhQuuKoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIOaac6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428D5C4CEF8;
	Wed, 29 Oct 2025 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748844;
	bh=KbIdQC6dInMhDPP8n6SgWM0TljxNLeWT7q2kyt6LT44=;
	h=Date:From:To:Cc:Subject:References:From;
	b=bIOaac6JssSvoAjk8TRtRhmbz7eWN3OyxEVn+6FcHOP5u2QEsMGQB/Dpi0JiOWohG
	 vYDo1NNNZdGhf+5mNhwaa7YNW9y2+JDBRbNIoh5+vpDhmcsI5WzNdQuZNqJTRj752o
	 /pke+rGwYms+570I5nVbS0gdQ7KcZmLH0w7CDD+wabJmUwe95Tjz9hjdoQt0qq9WZp
	 BC49Mqtq8uBxmQk4xIHwk36OSALcYhkjYh22//rTKHpsQ4FADi64bSJxroBH9U5QxT
	 Zlvjyi3IBPuP3vdYPt1cLsMx0+CN5SZWTUnD+PKZRUgN/RPXyBAgevMkoruLdhIFBe
	 //djupGI48umg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vE7Mb-000000052yB-0QVA;
	Wed, 29 Oct 2025 10:41:25 -0400
Message-ID: <20251029144124.948264684@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 29 Oct 2025 10:40:50 -0400
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
Subject: [for-next][PATCH 09/13] tracing: Show printable characters in syscall arrays
References: <20251029144041.475297995@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When displaying the contents of the user space data passed to the kernel,
instead of just showing the array values, also print any printable
content.

Instead of just:

  bash-1113    [003] .....  3433.290654: sys_write(fd: 2, buf: 0x555a8deeddb0 (72:6f:6f:74:40:64:65:62:69:61:6e:2d:78:38:36:2d:36:34:3a:7e:23:20), count: 0x16)

Display:

  bash-1113    [003] .....  3433.290654: sys_write(fd: 2, buf: 0x555a8deeddb0 (72:6f:6f:74:40:64:65:62:69:61:6e:2d:78:38:36:2d:36:34:3a:7e:23:20) "root@debian-x86-64:~# ", count: 0x16)

This only affects tracing and does not affect perf, as this only updates
the output from the kernel. The output from perf is via user space. This
may change by an update to libtraceevent that will then update perf to
have this as well.

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
Link: https://lore.kernel.org/20251028231148.429422865@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index a2de6364777a..2d1307f13e13 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -155,6 +155,8 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 	trace_seq_printf(s, "%s(", entry->name);
 
 	for (i = 0; i < entry->nb_args; i++) {
+		bool printable = false;
+		char *str;
 
 		if (trace_seq_has_overflowed(s))
 			goto end;
@@ -193,8 +195,11 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 
 		val = trace->args[entry->user_arg_size];
 
+		str = ptr;
 		trace_seq_puts(s, " (");
 		for (int x = 0; x < len; x++, ptr++) {
+			if (isascii(*ptr) && isprint(*ptr))
+				printable = true;
 			if (x)
 				trace_seq_putc(s, ':');
 			trace_seq_printf(s, "%02x", *ptr);
@@ -203,6 +208,22 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 			trace_seq_printf(s, ", %s", EXTRA);
 
 		trace_seq_putc(s, ')');
+
+		/* If nothing is printable, don't bother printing anything */
+		if (!printable)
+			continue;
+
+		trace_seq_puts(s, " \"");
+		for (int x = 0; x < len; x++) {
+			if (isascii(str[x]) && isprint(str[x]))
+				trace_seq_putc(s, str[x]);
+			else
+				trace_seq_putc(s, '.');
+		}
+		if (len < val)
+			trace_seq_printf(s, "\"%s", EXTRA);
+		else
+			trace_seq_putc(s, '"');
 	}
 
 	trace_seq_putc(s, ')');
-- 
2.51.0



