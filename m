Return-Path: <linux-kernel+bounces-876418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700DEC1B892
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08A564298F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3273559E8;
	Wed, 29 Oct 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9us2OvS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24383358B2
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748845; cv=none; b=uMp70CkEMrPZNvdt0hY8BKpmFSUJRtSjfVdY3CnvuHh/rCHXs+0fhpwiBszPZNrA6Aiq7aFWFuaj9bMGhHtXASUzZ8fU4S+MzOf8PCSXkRwdmgommMUFtgQkkfDGbVy23aQVUhpe2WtsC1YkvxU0OYMaSUZxJfPw5VIof1+YSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748845; c=relaxed/simple;
	bh=lT04hyvXI3hRYRjGC/NWe2ZlZUcXJ5lKgvqe06P2w1Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CNB77qB5Td715PhArdRiBI2+Zqbp7s2cO6sqryCtukt56qSJh1RnxCQASE4Urb8Ol9j7w7lbkEYvSQGlqBVCx2OC6yOq5m8Z3u+4mypn7KjOWeuXyZvDzBmDTT8aA5zXo7tq/bQRrv5C1XcRBD7Mh4+a4NBPl05J1iTvZeR5izU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9us2OvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3158C116B1;
	Wed, 29 Oct 2025 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748844;
	bh=lT04hyvXI3hRYRjGC/NWe2ZlZUcXJ5lKgvqe06P2w1Q=;
	h=Date:From:To:Cc:Subject:References:From;
	b=n9us2OvSrZx+atrtqSiiH86nSrJAvWh1HGodF1AvfBJSGSPWSj/BBRe2k6dzMetL+
	 tF5E3NBSLg7QN06wJ3SgwxgJ733JLJMt1rR8zMPVeRMkc+HF+lHZl9Us57DcGoLjxn
	 g/2ue7+Phz1Oo1/NEdRmix8qXM8IwwiSLf9Z690wX7ftRishlQAWivHcDp8IxOPfuJ
	 5qRI1+qYmn3LpZmOeKpOQpFn1cQYgm/VZkOqx5Kad/vq2wyS2e/fxF55+6GRg+HR9T
	 Zri/kp6y3u6eV6dT9tXUtRMAU0q3KRF4I7VQ9d6VAH7aBux041PJ+CGTeMiuzA4G/d
	 TALd008CxWOqw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vE7Mb-000000052zh-2ZTU;
	Wed, 29 Oct 2025 10:41:25 -0400
Message-ID: <20251029144125.462405292@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 29 Oct 2025 10:40:53 -0400
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
Subject: [for-next][PATCH 12/13] tracing: Check for printable characters when printing field dyn
 strings
References: <20251029144041.475297995@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When the "fields" option is enabled, it prints each trace event field
based on its type. But a dynamic array and a dynamic string can both have
a "char *" type. Printing it as a string can cause escape characters to be
printed and mess up the output of the trace.

For dynamic strings, test if there are any non-printable characters, and
if so, print both the string with the non printable characters as '.', and
the print the hex value of the array.

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
Link: https://lore.kernel.org/20251028231148.929243047@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 97db0b0ccf3e..718b255b6fd8 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -950,7 +950,9 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 	int offset;
 	int len;
 	int ret;
+	int i;
 	void *pos;
+	char *str;
 
 	list_for_each_entry_reverse(field, head, link) {
 		trace_seq_printf(&iter->seq, " %s=", field->name);
@@ -977,8 +979,29 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 				trace_seq_puts(&iter->seq, "<OVERFLOW>");
 				break;
 			}
-			pos = (void *)iter->ent + offset;
-			trace_seq_printf(&iter->seq, "%.*s", len, (char *)pos);
+			str = (char *)iter->ent + offset;
+			/* Check if there's any non printable strings */
+			for (i = 0; i < len; i++) {
+				if (str[i] && !(isascii(str[i]) && isprint(str[i])))
+					break;
+			}
+			if (i < len) {
+				for (i = 0; i < len; i++) {
+					if (isascii(str[i]) && isprint(str[i]))
+						trace_seq_putc(&iter->seq, str[i]);
+					else
+						trace_seq_putc(&iter->seq, '.');
+				}
+				trace_seq_puts(&iter->seq, " (");
+				for (i = 0; i < len; i++) {
+					if (i)
+						trace_seq_putc(&iter->seq, ':');
+					trace_seq_printf(&iter->seq, "%02x", str[i]);
+				}
+				trace_seq_putc(&iter->seq, ')');
+			} else {
+				trace_seq_printf(&iter->seq, "%.*s", len, str);
+			}
 			break;
 		case FILTER_PTR_STRING:
 			if (!iter->fmt_size)
-- 
2.51.0



