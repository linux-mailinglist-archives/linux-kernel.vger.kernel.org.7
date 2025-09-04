Return-Path: <linux-kernel+bounces-801789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69727B449D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853973AC6CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AF52EC0B4;
	Thu,  4 Sep 2025 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D5oi70zv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3VbdcIOn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F82E8DE9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025621; cv=none; b=XJTnN3uTbEQwMrofcE6bjGsnEs9hG6l4EFuJc0APfka2ySUIM5fAzUGQccekYI/0KiCodrbApfndgreqqnb5QLnthhh9Xd7EFm6Vve4RnG3ym2U7HaFPEQ+TBMBgm5Tk9OXgQN2RNv4fc2K9xArpkIjbxjMLTGhDnjHrgS6yHG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025621; c=relaxed/simple;
	bh=4ghSQSA6ygpn4VSB5NPZWZuMJQteCrrYVsreKPJWXgE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JrAsiCqxhE7Jceyd09ze3KJp8M/eiDbyjW8apNclN7N4qwOI5UT+V8/D+/mLMEZJD+0Xsw5KeAqszvEQ/DJgvAwEVovPRH2s2D+p+jweWUir0OoWu+wHzZqJC2aKkk2un7+bDLnK5wINIB3K0cSg+cx5JjwSO7/w7w9wvivzdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D5oi70zv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3VbdcIOn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757025617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jENW2pLaY1cNK8kKMarghne97j86Sp4vW16zY5vMznc=;
	b=D5oi70zvc/uTmhR878tx01/znsKCztsB4srhhwEVmexRz2Nyt36PZOmIv/EeLjSGanKj4M
	UCUlDn2M5nN951LvIi8KgWcW2/wHHRWVBNq3rPpCPWGk9CRifbpkqPgW+vh6rOdYB5P/EB
	y94ekwjJf5UD3NOynn9ew4azSgK4TfTyUf9GPZ1d+tQs0bUFz5T+srmRmdwm68MswoqoN9
	nCBnkX5wi4pzRLMjg5J58bE56+Jnz8mRnp+KVmU12TMG9ADzVPLdNsJEWI8TvfJBje8Mdk
	WrdH9I5zMIc3ZMwzoOkoEob5oxcCmICpUkff+nrk6NLmPtg01M4MAen7tBkFJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757025617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jENW2pLaY1cNK8kKMarghne97j86Sp4vW16zY5vMznc=;
	b=3VbdcIOn9lsG6jWqwRsIgdrTdzn85oKeDujS/Y5DEtbZ4o+nofRyGN7jQFRSZHtfZLxFTs
	xs1QfHu1pOXf+YBw==
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 RESEND 16/37] rseq: Provide tracepoint wrappers for
 inline code
In-Reply-To: <20250904185720.150944384@linutronix.de>
References: <20250904185336.943880027@linutronix.de>
 <20250904185720.150944384@linutronix.de>
Date: Fri, 05 Sep 2025 00:40:16 +0200
Message-ID: <874ithyh7z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Provide tracepoint wrappers for the upcoming RSEQ exit to user space inline
fast path, so that the header can be safely included by code which defines
actual trace points.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
V3: Get rid of one indentation level - Mathieu
---
 include/linux/rseq_entry.h |   28 ++++++++++++++++++++++++++++
 kernel/rseq.c              |   17 +++++++++++++++++
 2 files changed, 45 insertions(+)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -5,6 +5,34 @@
 #ifdef CONFIG_RSEQ
 #include <linux/rseq.h>
 
+#include <linux/tracepoint-defs.h>
+
+#ifdef CONFIG_TRACEPOINTS
+DECLARE_TRACEPOINT(rseq_update);
+DECLARE_TRACEPOINT(rseq_ip_fixup);
+void __rseq_trace_update(struct task_struct *t);
+void __rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
+			   unsigned long offset, unsigned long abort_ip);
+
+static inline void rseq_trace_update(struct task_struct *t, struct rseq_ids *ids)
+{
+	if (tracepoint_enabled(rseq_update) && ids)
+		__rseq_trace_update(t);
+}
+
+static inline void rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
+				       unsigned long offset, unsigned long abort_ip)
+{
+	if (tracepoint_enabled(rseq_ip_fixup))
+		__rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
+}
+
+#else /* CONFIG_TRACEPOINT */
+static inline void rseq_trace_update(struct task_struct *t) { }
+static inline void rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
+				       unsigned long offset, unsigned long abort_ip) { }
+#endif /* !CONFIG_TRACEPOINT */
+
 static __always_inline void rseq_note_user_irq_entry(void)
 {
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -91,6 +91,23 @@
 				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
 				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
 
+#ifdef CONFIG_TRACEPOINTS
+/*
+ * Out of line, so the actual update functions can be in a header to be
+ * inlined into the exit to user code.
+ */
+void __rseq_trace_update(struct task_struct *t)
+{
+	trace_rseq_update(t);
+}
+
+void __rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
+			   unsigned long offset, unsigned long abort_ip)
+{
+	trace_rseq_ip_fixup(ip, start_ip, offset, abort_ip);
+}
+#endif /* CONFIG_TRACEPOINTS */
+
 #ifdef CONFIG_DEBUG_RSEQ
 static struct rseq *rseq_kernel_fields(struct task_struct *t)
 {

