Return-Path: <linux-kernel+bounces-752179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFEEB17228
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643673BB7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3972D12EF;
	Thu, 31 Jul 2025 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+KQcaZK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAFD2C3257
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968969; cv=none; b=BbsSaCjELIJZAU/qo7uqwlKEjYelzbL4Rr+eoYEYI+rJ78DyWKEy/nMkiL43uPVbISLty8/86wlz+BtXUmNOQQUeMdor8zp2q9jIZb+SUyFYS3DBzkUuW3k3YHCnF0uwBEWm47qLGf8qL7tMCO7Khy7uC3fGlxCOskGtfEnMLjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968969; c=relaxed/simple;
	bh=dodEZVs5Wzy1Rte/OJTw+2gXp4BrIVcN/jHO2OsbLKU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Sgp/cwPRqCR8WQP2WsUNTM6c1+qdPr7e+q2STiejGWTast62SRvAPh68S1RNLNA/ulLXds5zxBa1CXtyXDpZHGiA+AMrlDMXMjf+enE8qdw7N6tWKR3s+forj3U+y1BqQCbqHcKLV3S72C+KfmC4v7zijGbKjEx89hq1mW0pnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+KQcaZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BF6C4CEFB;
	Thu, 31 Jul 2025 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753968968;
	bh=dodEZVs5Wzy1Rte/OJTw+2gXp4BrIVcN/jHO2OsbLKU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=B+KQcaZKWR+TJ7RESkDSuTr8J5AOlT4s0swq9LvLujhUWgS7YKW5fsPgpZFoa+12b
	 /HINn9mjYzsDFKreEuk6YwUqhbdMH+ugWLGqjfpRwPYE33NpQ2bEzX5vKyjYq08mxr
	 IOJX2pLP5DqDENuEMW7rM7tqjJQUVHNpF1xpic/7jMhYuBJtqzYa2DddiwrVUsygQY
	 5m36/elkL3il3/IXgL4fMeCiLwqsu0IWPEY8HJG+XOmxOqt1U22gKD2ec6og69c4Jx
	 oGr7++9kx19SwXpFrsLRcLAkebBBmJ/CFgnKalnGig0ZeRvF0n+v3dwut4eUgAR6BO
	 GBZdYW9RaUQug==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uhTSN-00000006kjH-1Gis;
	Thu, 31 Jul 2025 09:36:27 -0400
Message-ID: <20250731133627.154069401@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 31 Jul 2025 09:36:14 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: [for-next][PATCH 1/2] tracing: Have eprobes have their own config option
References: <20250731133613.889948523@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Eprobes were added in 5.15 and were selected whenever any of the other
probe events were selected. If kprobe events were enabled (which it is by
default if kprobes are enabled) it would enable eprobe events as well. The
same for uprobes and fprobes.

Have eprobes have its own config and it gets enabled by default if tracing
is enabled.

Link: https://lore.kernel.org/all/20250729102636.b7cce553e7cc263722b12365@kernel.org/

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/20250730140945.360286733@kernel.org
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig  | 14 ++++++++++++++
 kernel/trace/Makefile |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 93e8e7fc11c0..f80298e6aa16 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -792,6 +792,20 @@ config UPROBE_EVENTS
 	  This option is required if you plan to use perf-probe subcommand
 	  of perf tools on user space applications.
 
+config EPROBE_EVENTS
+	bool "Enable event-based dynamic events"
+	depends on TRACING
+	depends on HAVE_REGS_AND_STACK_ACCESS_API
+	select PROBE_EVENTS
+	select DYNAMIC_EVENTS
+	default y
+	help
+	  Eprobes are dynamic events that can be placed on other existing
+	  events. It can be used to limit what fields are recorded in
+	  an event or even dereference a field of an event. It can
+	  convert the type of an event field. For example, turn an
+	  address into a string.
+
 config BPF_EVENTS
 	depends on BPF_SYSCALL
 	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 057cd975d014..dcb4e02afc5f 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -82,7 +82,7 @@ obj-$(CONFIG_EVENT_TRACING) += trace_event_perf.o
 endif
 obj-$(CONFIG_EVENT_TRACING) += trace_events_filter.o
 obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
-obj-$(CONFIG_PROBE_EVENTS) += trace_eprobe.o
+obj-$(CONFIG_EPROBE_EVENTS) += trace_eprobe.o
 obj-$(CONFIG_TRACE_EVENT_INJECT) += trace_events_inject.o
 obj-$(CONFIG_SYNTH_EVENTS) += trace_events_synth.o
 obj-$(CONFIG_HIST_TRIGGERS) += trace_events_hist.o
-- 
2.47.2



