Return-Path: <linux-kernel+bounces-745799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3AEB11EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227071CE47CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1757D2EE292;
	Fri, 25 Jul 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQhy5j05"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738BC2ECD1A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447326; cv=none; b=hYWlAlf9avcSdh2qGvtGiS419+lu0vFCe47EB+bBiq5kxjR4kgTAziwijRBl2kzSMnPEFlgArnecOat04bri4+A0bAhVWq7nk3MLqdDnjBVWGUYXx8nJvF6N7NxBTk+Mf3U7aIF2q4Oe2LATBdJqT8GfnmPMHK4FCeAfNUGFbRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447326; c=relaxed/simple;
	bh=Gd6c7GIye9x5ICs77K4Go8O7Rfxad14ZIzp+MYRxQeA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VjVFbiJG8yEDSceo7SxNrbFHbziBuNjW51tNAP+GWBQPDLpxRfrnGijHbLP672jkrdWx2kjiZ+j2BG4uo6hzTQkFEAbvLR4pXEaViWh7jKf19y0UL/zNSCffAGqMCIxn2FUB8HPPl+6ENmDPZFZCVc7+zGeLxvhvbPY6uNLoBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQhy5j05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C45C4CEEB;
	Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753447326;
	bh=Gd6c7GIye9x5ICs77K4Go8O7Rfxad14ZIzp+MYRxQeA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=AQhy5j05RSYn0AqmZwsLTuUTfX3N3XeD/olcRPCPzIQn3v9Z5p+dS6SGl0iCSeEYk
	 qjO6XS1iJzg61vHmKYM9rVcjY+JyCqC68aK6XJH/XgqTzKPLQrA2O6HeBgR7QlzE16
	 SCylv+BV7gwIMd6HqeSNcYEPosEpJ0rmUDJ55GanUytr5OJ7ZDUlMRQH/7wwmT78Is
	 qUw1MeVmcesqDJAEcrZ4TF/RrGiHKV2sU6i5s+80cCySS2SA+DJLftigdQG/boQ5os
	 drpaeNW7mGtmYBivJak6SG9kWvoKWXbSe3zvrHQH58uvdamqp/KYFFsjCUyfdlhl+/
	 s/QVj8EV0A+uA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufHkZ-00000001CwO-3BXv;
	Fri, 25 Jul 2025 08:42:11 -0400
Message-ID: <20250725124211.614005382@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 08:41:53 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Nicolas Pitre <nico@fluxnic.net>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Subject: [for-next][PATCH 8/9] tracing: arm: arm64: Hide trace events ipi_raise, ipi_entry and
 ipi_exit
References: <20250725124145.391996103@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ipi tracepoints are mostly generic, but the tracepoints ipi_raise,
ipi_entry and ipi_exit are only used by arm and arm64. This means these
trace events are wasting memory in all the other architectures that do not
use them.

Add CONFIG_HAVE_EXTRA_IPI_TRACEPOINTS and have arm and arm64 select it to
enable these trace events. The config makes it easy if other architectures
decide to trace these as well.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Will Deacon <will@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/20250722103714.64eba013@gandalf.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig           |  1 +
 arch/arm64/Kconfig         |  1 +
 include/trace/events/ipi.h | 58 ++++++++++++++++++++------------------
 kernel/trace/Kconfig       |  6 ++++
 4 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3072731fe09c..e8f98217d0fc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -102,6 +102,7 @@ config ARM
 	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
 	select HAVE_DMA_CONTIGUOUS if MMU
+	select HAVE_EXTRA_IPI_TRACEPOINTS
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 393d71124f5d..a027cb81dfcc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -136,6 +136,7 @@ config ARM64
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select CPUMASK_OFFSTACK if NR_CPUS > 256
 	select DCACHE_WORD_ACCESS
+	select HAVE_EXTRA_IPI_TRACEPOINTS
 	select DYNAMIC_FTRACE if FUNCTION_TRACER
 	select DMA_BOUNCE_UNALIGNED_KMALLOC
 	select DMA_DIRECT_REMAP
diff --git a/include/trace/events/ipi.h b/include/trace/events/ipi.h
index 3de9bfc982ce..9912f0ded81d 100644
--- a/include/trace/events/ipi.h
+++ b/include/trace/events/ipi.h
@@ -7,34 +7,6 @@
 
 #include <linux/tracepoint.h>
 
-/**
- * ipi_raise - called when a smp cross call is made
- *
- * @mask: mask of recipient CPUs for the IPI
- * @reason: string identifying the IPI purpose
- *
- * It is necessary for @reason to be a static string declared with
- * __tracepoint_string.
- */
-TRACE_EVENT(ipi_raise,
-
-	TP_PROTO(const struct cpumask *mask, const char *reason),
-
-	TP_ARGS(mask, reason),
-
-	TP_STRUCT__entry(
-		__bitmask(target_cpus, nr_cpumask_bits)
-		__field(const char *, reason)
-	),
-
-	TP_fast_assign(
-		__assign_bitmask(target_cpus, cpumask_bits(mask), nr_cpumask_bits);
-		__entry->reason = reason;
-	),
-
-	TP_printk("target_mask=%s (%s)", __get_bitmask(target_cpus), __entry->reason)
-);
-
 TRACE_EVENT(ipi_send_cpu,
 
 	TP_PROTO(const unsigned int cpu, unsigned long callsite, void *callback),
@@ -79,6 +51,35 @@ TRACE_EVENT(ipi_send_cpumask,
 		  __get_cpumask(cpumask), __entry->callsite, __entry->callback)
 );
 
+#ifdef CONFIG_HAVE_EXTRA_IPI_TRACEPOINTS
+/**
+ * ipi_raise - called when a smp cross call is made
+ *
+ * @mask: mask of recipient CPUs for the IPI
+ * @reason: string identifying the IPI purpose
+ *
+ * It is necessary for @reason to be a static string declared with
+ * __tracepoint_string.
+ */
+TRACE_EVENT(ipi_raise,
+
+	TP_PROTO(const struct cpumask *mask, const char *reason),
+
+	TP_ARGS(mask, reason),
+
+	TP_STRUCT__entry(
+		__bitmask(target_cpus, nr_cpumask_bits)
+		__field(const char *, reason)
+	),
+
+	TP_fast_assign(
+		__assign_bitmask(target_cpus, cpumask_bits(mask), nr_cpumask_bits);
+		__entry->reason = reason;
+	),
+
+	TP_printk("target_mask=%s (%s)", __get_bitmask(target_cpus), __entry->reason)
+);
+
 DECLARE_EVENT_CLASS(ipi_handler,
 
 	TP_PROTO(const char *reason),
@@ -127,6 +128,7 @@ DEFINE_EVENT(ipi_handler, ipi_exit,
 
 	TP_ARGS(reason)
 );
+#endif /* CONFIG_HAVE_EXTRA_IPI_TRACEPOINTS */
 
 #endif /* _TRACE_IPI_H */
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a3f35c7d83b6..35448f7233fe 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -53,6 +53,12 @@ config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 config HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
 	bool
 
+config HAVE_EXTRA_IPI_TRACEPOINTS
+	bool
+	help
+	 For architectures that use ipi_raise, ipi_entry and ipi_exit
+	 tracepoints.
+
 config HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	bool
 	help
-- 
2.47.2



