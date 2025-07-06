Return-Path: <linux-kernel+bounces-717807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95274AF997A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 19:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2295A4326
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 17:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B052D3728;
	Fri,  4 Jul 2025 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Shejrna2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35328C865
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751648931; cv=none; b=H2Ag2UTBKvVw4oiORWs9xxX9CCDSanGb0dT6fzKyIrwe4beWEbBEb8gTao39/Mnf+ZFexZUb4pH+PFfvdrfWtVbQy7WAB62twzj8xv1W/JWaZ76sOCoDv4hpYuEzBwbwPnpFq7jPBYSWqV1rffJ/v1fQ8d8fTO+vkviHhFyGdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751648931; c=relaxed/simple;
	bh=OdjCzs5oBwsiFU9ybTJnF41S+AHSQl7mGlpQc1/NOj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OB67c2MJ7xvxEodoQAQnjhp8H3MsWQ5pFqN1ZlUdfLO+zBvorW/e4X9khv1hgviIlq0rHYiTdIwYxw/WNb4V+sqxEoSMxdZSvOe3i1XzPbC+sgnCom2xJDSrJqWzVdiQggcomZwsfYShiEu2mI0He6ytdreV4zWWQhaKOxoUi/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Shejrna2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751648929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8c26B+tXYtM+uAF1aKbVYP1jnJ2dmO5fQ29lWYwD/18=;
	b=Shejrna2L/l+wjQJ7HfOvjkWW8xuIvFh53Gu+CILApDFA9wyIdntQJaNVacltUJI5pLP30
	V5mh36SDDx5h96A9fFybFkln5ppEoz7G74kmjURswtqfqSEy8BSBDtm3nXtZpJ4dtz59mS
	R6F9qMgII8iPeQy9vKCImeKesQMZRxw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-bd-cPDVlOkGG_ZHBfgvbMg-1; Fri,
 04 Jul 2025 13:08:43 -0400
X-MC-Unique: bd-cPDVlOkGG_ZHBfgvbMg-1
X-Mimecast-MFC-AGG-ID: bd-cPDVlOkGG_ZHBfgvbMg_1751648921
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77047180047F;
	Fri,  4 Jul 2025 17:08:41 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A57B19560AB;
	Fri,  4 Jul 2025 17:08:34 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v3 1/2] trace/preemptirq: reduce overhead of irq_enable/disable tracepoints
Date: Fri,  4 Jul 2025 14:07:42 -0300
Message-ID: <20250704170748.97632-2-wander@redhat.com>
In-Reply-To: <20250704170748.97632-1-wander@redhat.com>
References: <20250704170748.97632-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The irqsoff tracer is rarely enabled in production systems due to the
non-negligible overhead it introduces—even when unused. This is caused
by how trace_hardirqs_on/off() are always invoked in
local_irq_enable/disable(), evaluate the tracepoint static key.

This patch reduces the overhead in the common case where the tracepoint
is disabled by performing the static key check earlier, avoiding the
call to trace_hardirqs_on/off() entirely.

This makes the impact of disabled preemptirq IRQ tracing negligible in
performance-sensitive environments.

We also move the atomic.h include from tracepoint-defs.h to tracepoint.h
due a circular dependency when building 32 bits ARM.

The failure occurs because the new logic in <linux/irqflags.h> calls
tracepoint_enabled(), which requires the tracepoint-defs.h header file.
This header, in turn, includes <linux/atomic.h>. On ARM32, the include
path for kernel/bounds.c creates a circular dependency:
atomic.h -> cmpxchg.h -> irqflags.h -> tracepoint.h -> atomic.h

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/irqflags.h        | 30 +++++++++++++++++++++---------
 include/linux/tracepoint-defs.h |  1 -
 include/linux/tracepoint.h      |  1 +
 kernel/trace/trace_preemptirq.c |  3 +++
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 57b074e0cfbb..40e456fa3d10 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -17,6 +17,7 @@
 #include <linux/cleanup.h>
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
+#include <linux/tracepoint-defs.h>
 
 struct task_struct;
 
@@ -197,9 +198,17 @@ extern void warn_bogus_irq_restore(void);
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
 
+DECLARE_TRACEPOINT(irq_enable);
+DECLARE_TRACEPOINT(irq_disable);
+
+#define __trace_enabled(tp)				\
+	(IS_ENABLED(CONFIG_PROVE_LOCKING) ||		\
+	 tracepoint_enabled(tp))
+
 #define local_irq_enable()				\
 	do {						\
-		trace_hardirqs_on();			\
+		if (__trace_enabled(irq_enable))	\
+			trace_hardirqs_on();		\
 		raw_local_irq_enable();			\
 	} while (0)
 
@@ -207,31 +216,34 @@ extern void warn_bogus_irq_restore(void);
 	do {						\
 		bool was_disabled = raw_irqs_disabled();\
 		raw_local_irq_disable();		\
-		if (!was_disabled)			\
+		if (__trace_enabled(irq_disable) &&	\
+		    !was_disabled)			\
 			trace_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
-		if (!raw_irqs_disabled_flags(flags))	\
+		if (__trace_enabled(irq_disable) &&	\
+		    !raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_restore(flags)			\
 	do {						\
-		if (!raw_irqs_disabled_flags(flags))	\
+		if (__trace_enabled(irq_enable) &&	\
+		    !raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_on();		\
 		raw_local_irq_restore(flags);		\
 	} while (0)
 
-#define safe_halt()				\
-	do {					\
-		trace_hardirqs_on();		\
-		raw_safe_halt();		\
+#define safe_halt()					\
+	do {						\
+		if (__trace_enabled(irq_enable))	\
+			trace_hardirqs_on();		\
+		raw_safe_halt();			\
 	} while (0)
 
-
 #else /* !CONFIG_TRACE_IRQFLAGS */
 
 #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index aebf0571c736..cb1f15a4e43f 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -8,7 +8,6 @@
  * trace_print_flags{_u64}. Otherwise linux/tracepoint.h should be used.
  */
 
-#include <linux/atomic.h>
 #include <linux/static_key.h>
 
 struct static_call_key;
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 826ce3f8e1f8..2fd91ef49b7f 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -20,6 +20,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
+#include <linux/atomic.h>
 
 struct module;
 struct tracepoint;
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 0c42b15c3800..90ee65db4516 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -111,6 +111,9 @@ void trace_hardirqs_off(void)
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 NOKPROBE_SYMBOL(trace_hardirqs_off);
+
+EXPORT_TRACEPOINT_SYMBOL(irq_disable);
+EXPORT_TRACEPOINT_SYMBOL(irq_enable);
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 #ifdef CONFIG_TRACE_PREEMPT_TOGGLE
-- 
2.50.0


