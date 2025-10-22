Return-Path: <linux-kernel+bounces-864981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF7ABFC00E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7AD621858
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF6834BA3E;
	Wed, 22 Oct 2025 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MOayLTsn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uix3kQPA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B534B1B8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137549; cv=none; b=mrKUAZH2hhvp/cFsDCc8Cez8Ny+tR9ylGo1YabMMGW0z/no/eHZk0wGJbxP7BpSnOdJZwO32yVs09WniGraVBI3hrCd+DC0/6vx1ppaDj5sHAKxAWQITZNlVznr13C56qNbZa12uDflxvhO/VvCP/aL0L3tv+mboHzUu2UJ8Dvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137549; c=relaxed/simple;
	bh=UB6GUoa1bwFI1b5d6i52NpWqC/cZwFr/ngcFtxyI9jw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=s8OkKhFjeiWVFE9KgZKeTmGqr+h9P0YfruOUxW49af20dIZeHCo2/zuJ4Iet5pvHaUYG8Hard7TO5weOHrhbpCnvsNiGC45bSM85mjTnw2KA6itA18v9S8oMRhXzOyxacmtKrxBRsjOvNTw8yr2ODmMp5tRIqcPKBT52TX+zxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MOayLTsn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uix3kQPA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121942.411878856@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VHbEMEUbJ9sABjNNjENKnjw6SUQbj/5g+w8+hNtQ8+E=;
	b=MOayLTsnLGCmsqUJNJtuIIfs8Zm8PbFUsPIG5LGf82BphIWG+v2g7WQerqEFuESgggRoWK
	cj/Voa5UXLd9mAZhkShg7ELclTDnFz1uP3Zbuo4PRUxy+Hrez82as09/mbtkt4eiolSIAG
	Mt2r8QyHBqjt/Fl4WTrP+FiJbRJkLe4UTalu50mgC84cNI9wpylH52bXBL+2SnHCSiYlLi
	mm4BSjhK/dXfrwEJsx19UdiY5jcpGpceCVPd/YGQz2pdcQtMIF+uBGny8JKwDB+KUay/PB
	Y5m3ov1HwtoWXIKwjtX05fyEjhRp0Y+yHFXmHguXmaahq7qk8WfKIY8y6B45ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VHbEMEUbJ9sABjNNjENKnjw6SUQbj/5g+w8+hNtQ8+E=;
	b=Uix3kQPAlE40gHWmdt1LEfLH6CIzEb20X15RegZ1NVLWD0oZOQ5IHUSJNQnhJFr5FbJaXv
	WVFt+5GJcsvz9LDw==
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
Subject: [patch V5 16/31] rseq: Provide tracepoint wrappers for inline code
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:20 +0200 (CEST)

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


