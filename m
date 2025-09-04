Return-Path: <linux-kernel+bounces-801752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D8B44981
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45E3B4E2C0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668D82FC87A;
	Thu,  4 Sep 2025 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVfdi6rt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+/kEuMie"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C332F8BC3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024467; cv=none; b=GOE5ypJlLrOENF50rBOYTPZ+zs8Y2JEUVDrp4aI3txjzEk6v889NivfaqJAoitUqMiykMhdF6wOvyHIQltQg1x2wMbNebkVfU7LAWOMCWH32Ap2Bq2rBehl5UCNLJIyvnvl36zDsJUvIA3U+vj9jX3c4sc16/+urDdNXvn8tCyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024467; c=relaxed/simple;
	bh=4ghSQSA6ygpn4VSB5NPZWZuMJQteCrrYVsreKPJWXgE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=smAFGvxsZlkZdDY4xfYBq7eho16x0laJ8K+h7BqYc5c8uvqwz2dGK34H5LsXuQuZTlWXpNXkaV3oHYma8KCGXth/xI12qzgLZeaNNoB4X+cBqO7KT+QBFKTwWMupe6oNjQLddL5tq1uc90GlVJ4MQBk7IyZ7XE3pFiOQTNsVhes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVfdi6rt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+/kEuMie; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185720.150944384@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=jENW2pLaY1cNK8kKMarghne97j86Sp4vW16zY5vMznc=;
	b=oVfdi6rt9kxv+Rl3e4NZymM93I5870z10NqxT+UrO7K1ijbKhGlGoOr40lh6uS6EEhO+P9
	bh/bFp07+oeW9aaVkclmacRrKf24j5ToryCj8IJL2vuw9m16fCezAft50/9RhjaX8mgf76
	TAtLjTJfkRp7ZsuVOlBenL1TMU6F0D5x6SfyvRuV+7Wn0Q2Z5IJQDfOn5ITtH2VSnaaT/+
	CEyUDyYhlOTXY2+GiWA4SY4yUMay71sCIRqlJionjXSreRa6O7gmJESSaybyyU36QClzEm
	SutLj1eWgx4Sfhl86jf+VQIgs1gHjMBnaWWhpS4a1NpvIDciecjrB7x0XICUTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=jENW2pLaY1cNK8kKMarghne97j86Sp4vW16zY5vMznc=;
	b=+/kEuMieEXUTbRHq2y93TYyDTDv9kO6PhGVr5p9p78bCKq9YQzgU57oenJfaltOEW+bF76
	cIOJeK/IHO4JkBBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V3 16/37] From: Thomas Gleixner <tglx@linutronix.de>
 65;7006;1cSubject: rseq: Provide tracepoint wrappers for inline code Date:
 Sat, 23 Aug 2025 18:39:45 +0200
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:04 +0200 (CEST)

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


