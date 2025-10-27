Return-Path: <linux-kernel+bounces-871103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E963C0C74B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 008A84F20B7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4860B3112C9;
	Mon, 27 Oct 2025 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tjnI+9ZI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKsprpb8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25913310777
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554694; cv=none; b=rn21uTGEP4OsMMcU7UpXaFVEiylpd3KRtyAjAci4eorXHgzHs9lOzYJOTBXbGRuNNOPXqNwbj8vWcFlXOdUUq65i4v6fw1Cq6mTTkSLTp+aPcm8cKSJz1ueH7UBpMyvvhvRUBj8Q/aRXHYir8W7p7ojYHhyPXw3jYEQNX+3BT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554694; c=relaxed/simple;
	bh=UB6GUoa1bwFI1b5d6i52NpWqC/cZwFr/ngcFtxyI9jw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MHvTIhcCj3SThiVgeTQEtCAs4aCfAt0CCBd8bYGUxPpjMDDAjIdDiFmYKIUR9CupOj1lCgoBbHNeQYfBC1Ondg0tSlqlCsLdxC1Y0aIuLcGeFfJkYApHB5onpCpbLDHruBrX42FO2r0YKRMh39Zy31uPsLIk38tMzozB+9AqSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tjnI+9ZI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKsprpb8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084306.967114316@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VHbEMEUbJ9sABjNNjENKnjw6SUQbj/5g+w8+hNtQ8+E=;
	b=tjnI+9ZINbVz3PD/pHieLUpo0Z3Q0noZbmLZbQpo2pwE/OeW50dkgtbRNFvqNtlJrOQpRD
	whPcHyTrbd+vhq759Tzzgj/tVDyJl5fLVqxviK4x+R6j4VEOIMZe4KkMeupr1QJN92heyr
	17sOBG+QyidacU5nZUfA4IXah6fLNN3NlwbQ3D4m6P7wcoADpyNUSTXzCBr/tplN+VUVIx
	R5ndSyFOnUBUQhXkWh5ZZU/Hpb8vTtrTfNQ8UbX9oHnbg/KlVq98gecHnQ1KAuzhaZ4svm
	NjwxuhcVHup4yXN6PcWF1YXF2yqrBDcBeTCVAW2TLZ46EnE6RH9GsZrf9W4RCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VHbEMEUbJ9sABjNNjENKnjw6SUQbj/5g+w8+hNtQ8+E=;
	b=PKsprpb8Ka3VIvEcrAEuC7L3xVtk19Lig0hn6BMwJs9yIxKi8GLDjRyFGYVA+O+r5PNc9g
	+pipklUlVwqqWjDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V6 16/31] rseq: Provide tracepoint wrappers for inline code
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:50 +0100 (CET)

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
 kernel/rseq.c              |   19 ++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)
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
@@ -70,7 +70,7 @@
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
-#include <linux/rseq.h>
+#include <linux/rseq_entry.h>
 #include <linux/types.h>
 #include <linux/ratelimit.h>
 #include <asm/ptrace.h>
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


