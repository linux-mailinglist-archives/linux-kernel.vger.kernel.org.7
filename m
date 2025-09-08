Return-Path: <linux-kernel+bounces-806805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F4B49C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5631A4E236C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5556303A27;
	Mon,  8 Sep 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ioJU9e1B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2JDE7HKP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BBD30CDA1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367122; cv=none; b=kJTwzTMYO3HWrKF69e2+Tk9Y2IuKg7ETOSsKSs+Dtxhd5JznhX/VzDzXdzlws6lnKtefuEZkSjUeXW3WZy8/Yi5tUfD6st2iIO0rOQ4J0sBce7HUjTIsPVK69tWRmWcv0u1YO70HBt7HjkCZmVeafDdSNaujT2NZ5k0hpT2F9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367122; c=relaxed/simple;
	bh=GJkMM2cLPlONG/2nw4FKofZiGfe1fX5W+qqnbNakNwY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=jr8zMzDPa7HeiZh8yrA7fXL3jeA92WUNG02kQ9KQXuNgQVFSWMzD2bR4kiutAPh6msnhLk94sB439/IY1mFfcljIVG2DU146bQ22TDWvEDACvXq/2wclqOpmLT4nZ9/1WZbG+J0VZi5o9d+hTSyvNhreVjVJer8u0guBSSIKSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ioJU9e1B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2JDE7HKP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.289021777@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4ah8yx574MbcXW+coHUeJRdmLHEW5lfpqykv4un0j4c=;
	b=ioJU9e1B1j9w+kRNupcUu9k0TVoKjorV7u6e325wIGOM5EQfbNjBfgnngBD6/bO11C5Zvd
	EmrajIkAH679Ot+NTD3cI8J+4mS7KKHjIQrl0v0O4CZmKN6o+W2gIai6lbwH3Ec1chhJKS
	J6Fy2D5CulsRYqs77LPpR1R4E57Fiq2eJsOiXHi7pe2VtaQnJgTKXUqhXiGw2e5gaRf65/
	HjVbao4VIh8iRYXIFCTOeB1hs/OjiTGvrSVakS7J8b0IAyThBQMPM7l3jQZTiCFhv8bMjC
	PCu5GZOCVGsMnD+cUKus1hoHCSFyKkVyh7j8C8ow3UT/WdkUTf0380ko/JDY6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4ah8yx574MbcXW+coHUeJRdmLHEW5lfpqykv4un0j4c=;
	b=2JDE7HKP710xhoUEZwDx4u46krGtVrapHKPknz/e7GLjign3Nnqu0hgQzbz7vQ9MVVK8u7
	mWv27CjCjtUqH1Cw==
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
Subject: [patch V4 16/36] rseq: Provide tracepoint wrappers for inline code
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:57 +0200 (CEST)

Provide tracepoint wrappers for the upcoming RSEQ exit to user space inline
fast path, so that the header can be safely included by code which defines
actual trace points.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
V4: Fix the fallback stub
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
+static inline void rseq_trace_update(struct task_struct *t, struct rseq_ids *ids) { }
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


