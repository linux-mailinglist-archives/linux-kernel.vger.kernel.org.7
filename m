Return-Path: <linux-kernel+bounces-876416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BDEC1BAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E83646CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC0B355801;
	Wed, 29 Oct 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJD5+LLN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C983358BA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748844; cv=none; b=e23t5WCg5k2gepC7N+JRfu3t6rVBAKBgOuxy+YHEmOAHcyuuEo7d1g3eCxBD80gvb+2fqRHMQ/OgK/zslWuD4cCLdCdV3ZEagiulYl0ZfrObU8gDRNVFUXe8z4O5FAHNTt3QN2NhIjrtXTyFXPDklACEZDpuZMp5gHm0UgQnl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748844; c=relaxed/simple;
	bh=7owQCE2JhUTi1KE6esOu9llJPMz3AphT9HtDkb/lUHc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Jt70rMu3jqrSDKeECfC/bYBiBuLjRYEO3D+Dmz65603zXhRQjYnKnz2eJUQ3osTNe9E/xq/5uB1CYcyWmZx+e7I3M8iOGSIoJsaPXgDt6SGVg81lifgxZBrAD34AhAnJsObZIhPdNuXh5db222R5XfaEixhdVl2e27FN/Kix7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJD5+LLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC4BC2BC9E;
	Wed, 29 Oct 2025 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748844;
	bh=7owQCE2JhUTi1KE6esOu9llJPMz3AphT9HtDkb/lUHc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=IJD5+LLNF9c2tTVxkB29jbSrEAQKzzYb6r38NS+VLf/V8g1SN9fHRUbHQFM6kWVSv
	 aCiXl9/4e4JRw0q6KkEQQH/1dck18le2XkOW/IC42A5cJXJl0ljn/0oIbKr4d1wYAx
	 2wR7H0j/vsyhPx9Vu95l77pottRdeYh8gDmlygzqO8Qg1A8SHYw8ilv02kAL4OqH2d
	 G0M9c9KdTCFFcx1nLUAcX5qjHEmTUWOQ1GRW9JsID39E+i+7lm6fYQuggAE6KrwdHb
	 l6z1Xiwez8Mkc5I3inksMwXYlB/ogritSZHiEU4ixt7fouQ+lZn4Ci+XhSlImK2FZX
	 eSuJvc0ULAZ8A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vE7Mb-000000052yh-18gQ;
	Wed, 29 Oct 2025 10:41:25 -0400
Message-ID: <20251029144125.122306386@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 29 Oct 2025 10:40:51 -0400
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
Subject: [for-next][PATCH 10/13] tracing: Add trace_seq_pop() and seq_buf_pop()
References: <20251029144041.475297995@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to allow an interface to remove an added character from the
trace_seq and seq_buf descriptors, add helper functions trace_seq_pop()
and seq_buf_pop().

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
Link: https://lore.kernel.org/20251028231148.594898736@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/seq_buf.h   | 17 +++++++++++++++++
 include/linux/trace_seq.h | 13 +++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 52791e070506..9f2839e73f8a 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -149,6 +149,23 @@ static inline void seq_buf_commit(struct seq_buf *s, int num)
 	}
 }
 
+/**
+ * seq_buf_pop - pop off the last written character
+ * @s: the seq_buf handle
+ *
+ * Removes the last written character to the seq_buf @s.
+ *
+ * Returns the last character or -1 if it is empty.
+ */
+static inline int seq_buf_pop(struct seq_buf *s)
+{
+	if (!s->len)
+		return -1;
+
+	s->len--;
+	return (unsigned int)s->buffer[s->len];
+}
+
 extern __printf(2, 3)
 int seq_buf_printf(struct seq_buf *s, const char *fmt, ...);
 extern __printf(2, 0)
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 557780fe1c77..4a0b8c172d27 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -80,6 +80,19 @@ static inline bool trace_seq_has_overflowed(struct trace_seq *s)
 	return s->full || seq_buf_has_overflowed(&s->seq);
 }
 
+/**
+ * trace_seq_pop - pop off the last written character
+ * @s: trace sequence descriptor
+ *
+ * Removes the last written character to the trace_seq @s.
+ *
+ * Returns the last character or -1 if it is empty.
+ */
+static inline int trace_seq_pop(struct trace_seq *s)
+{
+	return seq_buf_pop(&s->seq);
+}
+
 /*
  * Currently only defined when tracing is enabled.
  */
-- 
2.51.0



