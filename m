Return-Path: <linux-kernel+bounces-874873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEFFC174B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22C73B8D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE1374AB1;
	Tue, 28 Oct 2025 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8krNUSc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2B36B99A;
	Tue, 28 Oct 2025 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693069; cv=none; b=CpUkzS5msRB2bYunYlOUFLC8YvT95jab8rnp5f9GLM2WtapqL0wp/9GN2j0zEu9qSDVLkkJbafp72E90fJAJkJ2MrtJ2rfj/6Pt5xXPPBnqmrFnzszbSisq8f9pQCP+IqIRZkb9ksR8nYcoJkq7emJQKshyjKYsT0l0AQRxVctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693069; c=relaxed/simple;
	bh=Lp/sEkMZsE67tXH+Ndy0qtN++BL6+DdO3Q5iet8yKzg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Y9UrdlOArzUH9BymnOl5r73T1JWf/yPkci67mBw3LybgCmaHRrRV1/4D6t7aqHOuEUQsmnu9CA3EymWyTwwVUL9vVpOnUs50xM3SIhAFmFgHSIbICwD11IaXqzTsEVy3hcpGvzXLG17Xw6N312SLjbpMj7PDGIYGXrtWAgFA/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8krNUSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EDFC19422;
	Tue, 28 Oct 2025 23:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761693069;
	bh=Lp/sEkMZsE67tXH+Ndy0qtN++BL6+DdO3Q5iet8yKzg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=i8krNUScaLziVHZs+ozI3RPNMAAeZZPq0nbXGTrj59pCCA7n3/6dyGnkkR7waj8h9
	 F+mIs/z8eOpUyuZrnLJAvYsiv62C+Q59l9z+mumDDI/ImZuPXj2H5aMjRlLRQptkek
	 v/hHurLMtHK3WiEFVdb5BUCRHnXoD4mCOUhN42Qij4ZeXz461m1RKA8FKa5Mt2VBYN
	 GVa+noXqKr96KLAjhIPnsGkYkd9sZ9ZTfPRHdGQH2T895jhWT5pHCuUyEXY0xP8Or0
	 oeOqHVgyTzMv6bngFbamDy4+vQYys9fStI1oeuCl57kL6QkZY424Uttc3HFbI1xA2j
	 oCpXc0KcwHjhQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vDsqy-00000004qtf-37bz;
	Tue, 28 Oct 2025 19:11:48 -0400
Message-ID: <20251028231148.594898736@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 28 Oct 2025 19:11:24 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
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
Subject: [PATCH v5 10/13] tracing: Add trace_seq_pop() and seq_buf_pop()
References: <20251028231114.820213884@kernel.org>
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



