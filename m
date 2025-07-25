Return-Path: <linux-kernel+bounces-745796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03829B11EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B06EAA5CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B072ECE93;
	Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFZEylB2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4272EBDD5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447326; cv=none; b=U0rfs7x4QjOcSM0xRF6k2ShrML/I9orSnUF7zt0qDx41kV6EE1ZxFAL6L/79l3xj2bzpncj29WvRajeY0K4v+DZvkNRYu4kAjUf1025Glg3Qhw2I5LPrW0O26nCHPOqLKPY4LPux4MSi/0K8pxV7bRnfbSvtoKAMjXozcebc9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447326; c=relaxed/simple;
	bh=wwD8akdN0/QOyuYxcJgvFCWsfpE9mN9oy+phuLPb93o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jYqOeGNAbown4yUjHpsUYGNKCWlYU+I9RyE4Ymi6PYQ1/W+NngXDf/t1QtsMMcE+YiOL6JtPs9ktGC17zAjERT9yN1yKrkeBkQksLechdpVaHEFbZwBbfT5NLBOvuTtfmZRMCvfPXGfLR9dDQUu4pLOLLUkQn7diazMlV+XeKGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFZEylB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A70C4CEF5;
	Fri, 25 Jul 2025 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753447325;
	bh=wwD8akdN0/QOyuYxcJgvFCWsfpE9mN9oy+phuLPb93o=;
	h=Date:From:To:Cc:Subject:References:From;
	b=NFZEylB2dPE//bgWVNgRTNm3Q4d49nTKo2uHPY9LuJ+6Xg5GerRiefWSihtds976F
	 RqmwJvMc+a5V23Yg2BjuML8Ul6zjdf7/2dFXJ3JZdtWsmLMZ21cnKbc7Lkitihc0AA
	 fS3eapgXzIELrCSFPF07xAaRIyaPVkp/RSSTHGTgm3Bc40oUQAxXsCxAu3nyAYd6S0
	 xsLUlyeoseTuGC0QMZlLEMVAbI4w0YaJJwXyRaqNM8D6eT6TpDyyGXWuYDo/ip+3VK
	 kKK9BQtobJxJr3FOXfpEcuae7K7Bc07Rh4b2VPdV9KeZN9/fd0hs7JPxwK7MdTLE9a
	 GqLMh3XacmThg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufHkY-00000001Ctv-3q8M;
	Fri, 25 Jul 2025 08:42:10 -0400
Message-ID: <20250725124210.768285913@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 08:41:48 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [for-next][PATCH 3/9] PM: cpufreq: powernv/tracing: Move powernv_throttle trace event
References: <20250725124145.391996103@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

As the trace event powernv_throttle is only used by the powernv code, move
it to a separate include file and have that code directly enable it.

Trace events can take up around 5K of memory when they are defined
regardless if they are used or not. It wastes memory to have them defined
in configurations where the tracepoint is not used.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/20250612145407.906308844@goodmis.org
Fixes: 0306e481d479a ("cpufreq: powernv/tracing: Add powernv_throttle tracepoint")
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/cpufreq/Makefile          |  1 +
 drivers/cpufreq/powernv-cpufreq.c |  4 ++-
 drivers/cpufreq/powernv-trace.h   | 44 +++++++++++++++++++++++++++++++
 include/trace/events/power.h      | 22 ----------------
 kernel/trace/power-traces.c       |  1 -
 5 files changed, 48 insertions(+), 24 deletions(-)
 create mode 100644 drivers/cpufreq/powernv-trace.h

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index d38526b8e063..681d687b5a18 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_CPUFREQ_VIRT)		+= virtual-cpufreq.o
 
 # Traces
 CFLAGS_amd-pstate-trace.o               := -I$(src)
+CFLAGS_powernv-cpufreq.o                := -I$(src)
 amd_pstate-y				:= amd-pstate.o amd-pstate-trace.o
 
 ##################################################################################
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index a8943e2a93be..7d9a5f656de8 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -21,7 +21,6 @@
 #include <linux/string_choices.h>
 #include <linux/cpu.h>
 #include <linux/hashtable.h>
-#include <trace/events/power.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -30,6 +29,9 @@
 #include <asm/opal.h>
 #include <linux/timer.h>
 
+#define CREATE_TRACE_POINTS
+#include "powernv-trace.h"
+
 #define POWERNV_MAX_PSTATES_ORDER  8
 #define POWERNV_MAX_PSTATES	(1UL << (POWERNV_MAX_PSTATES_ORDER))
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
diff --git a/drivers/cpufreq/powernv-trace.h b/drivers/cpufreq/powernv-trace.h
new file mode 100644
index 000000000000..8cadb7c9427b
--- /dev/null
+++ b/drivers/cpufreq/powernv-trace.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#if !defined(_POWERNV_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _POWERNV_TRACE_H
+
+#include <linux/cpufreq.h>
+#include <linux/tracepoint.h>
+#include <linux/trace_events.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM power
+
+TRACE_EVENT(powernv_throttle,
+
+	TP_PROTO(int chip_id, const char *reason, int pmax),
+
+	TP_ARGS(chip_id, reason, pmax),
+
+	TP_STRUCT__entry(
+		__field(int, chip_id)
+		__string(reason, reason)
+		__field(int, pmax)
+	),
+
+	TP_fast_assign(
+		__entry->chip_id = chip_id;
+		__assign_str(reason);
+		__entry->pmax = pmax;
+	),
+
+	TP_printk("Chip %d Pmax %d %s", __entry->chip_id,
+		  __entry->pmax, __get_str(reason))
+);
+
+#endif /* _POWERNV_TRACE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE powernv-trace
+
+#include <trace/define_trace.h>
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 6c631eec23e3..913181cebfe9 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -99,28 +99,6 @@ DEFINE_EVENT(psci_domain_idle, psci_domain_idle_exit,
 	TP_ARGS(cpu_id, state, s2idle)
 );
 
-TRACE_EVENT(powernv_throttle,
-
-	TP_PROTO(int chip_id, const char *reason, int pmax),
-
-	TP_ARGS(chip_id, reason, pmax),
-
-	TP_STRUCT__entry(
-		__field(int, chip_id)
-		__string(reason, reason)
-		__field(int, pmax)
-	),
-
-	TP_fast_assign(
-		__entry->chip_id = chip_id;
-		__assign_str(reason);
-		__entry->pmax = pmax;
-	),
-
-	TP_printk("Chip %d Pmax %d %s", __entry->chip_id,
-		  __entry->pmax, __get_str(reason))
-);
-
 TRACE_EVENT(pstate_sample,
 
 	TP_PROTO(u32 core_busy,
diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
index 21bb161c2316..f2fe33573e54 100644
--- a/kernel/trace/power-traces.c
+++ b/kernel/trace/power-traces.c
@@ -17,5 +17,4 @@
 EXPORT_TRACEPOINT_SYMBOL_GPL(suspend_resume);
 EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_idle);
 EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_frequency);
-EXPORT_TRACEPOINT_SYMBOL_GPL(powernv_throttle);
 
-- 
2.47.2



