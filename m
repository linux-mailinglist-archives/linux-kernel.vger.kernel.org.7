Return-Path: <linux-kernel+bounces-745793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B894B11EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FFD3BE372
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258722EBDEC;
	Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCJELA8v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876F92EACEA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447325; cv=none; b=CJE4fcsFlf/gj/1g91m1203H0MvhhybHE3SKcF5xk03petOKq8MUp9wlm7woiRFV8HvD+gk7o4zZtm36qk3ruGpquS/VXSzNKNCIYfCqY3G2wgTknRTlLZW1YdkunS1Mk/Wu5LMETyUIAENDLiz/ynIkQYF6PKJ58DMgFceT1zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447325; c=relaxed/simple;
	bh=/UtvtbF9UQFZcvkqoMh5MWKWlr2aj76x1NrMv7B8wx8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Xh/D+KHWAIsFnwOeV3572dKSfZ0QM/qvtrzxuVjWMikWg5ogNSYTAeTpszvtVC+IAxSCoy3fhdeAvg3zmYT+FMvnBZ4IdkzlHPPU4LR5tsA/JvnaVdzOS4qft0x1+zTrCTU+u+lA9kBWShCCP5dc/yHNbASNdlKDdfaTh78w7Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCJELA8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E90C4CEEB;
	Fri, 25 Jul 2025 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753447325;
	bh=/UtvtbF9UQFZcvkqoMh5MWKWlr2aj76x1NrMv7B8wx8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=GCJELA8vw3Dn/nzF+A2qGsqYER8QRLBvUtv7TeYXYOJYIN/faoQ2+Wz2X2DHAjpq+
	 ub3wJK34rwhW+PG9WP2aTgr3CavrW/aZF80AQPeuLOtwdOBv0PrNoejno9D1+erC2b
	 Dmmn9+qj+ACURW2sKxL+0VdYymQ/bJvByawt1PVW/P+ioBatQEonYgHFUxqkrSOir7
	 b9VLuPorYF3cyo8HYkGrCVLWRaqPQXx03WW6b3Opyt9g4Z2qUQWf1D2MsDH6PjFljH
	 FToCABl5KEDtawmijD3A6WvWnxSIlZ7jUWE1wFO8lj72Kwo9ipZV03lI2DgBPyxY10
	 JfTY7m8Jn+j2g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufHkY-00000001Csx-2RrK;
	Fri, 25 Jul 2025 08:42:10 -0400
Message-ID: <20250725124210.435086464@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 08:41:46 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tony Luck <tony.luck@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [for-next][PATCH 1/9] tracing, AER: Hide PCIe AER event when PCIEAER is not configured
References: <20250725124145.391996103@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The event aer_event is only used when CONFIG_PCIEAER is configured. It
should not be created when it is not. When an event is created it creates
around 5K of text and meta data regardless if the tracepoint is used or
not. Instead of wasting this memory, put #ifdef around the event to not
create it when it is not used.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250612094932.4a08abd6@batman.local.home
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/ras/ras_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 14c9f943d53f..c8cd0f00c845 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -252,6 +252,7 @@ TRACE_EVENT(non_standard_event,
 		  __print_hex(__get_dynamic_array(buf), __entry->len))
 );
 
+#ifdef CONFIG_PCIEAER
 /*
  * PCIe AER Trace event
  *
@@ -337,6 +338,7 @@ TRACE_EVENT(aer_event,
 			__print_array(__entry->tlp_header, PCIE_STD_MAX_TLP_HEADERLOG, 4) :
 			"Not available")
 );
+#endif /* CONFIG_PCIEAER */
 
 /*
  * memory-failure recovery action result event
-- 
2.47.2



