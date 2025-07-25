Return-Path: <linux-kernel+bounces-745797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1463B11EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA06D5A4CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E0A2EE28E;
	Fri, 25 Jul 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqMVirwd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231832EBDE8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447326; cv=none; b=ST7uvphrMEEjZfTJsJlBEu1uwm3+82ZOL+jO0eDs/MxKj/lf6qafVMk02g/qigts0nC5VqG0q3xnUsJo4p8bgKt6620omO1QjHiq16w8U+yK1o2zI9N2jCYVNfeTo1DlF99h1STcNSQeDx5SUgMvYyPLomVI2TG8N1lIwiJN7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447326; c=relaxed/simple;
	bh=TSYyYdc2kUVh5hhhFunzCcBGjyYSshiQxo01fjyU+Qc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Z1dcQF7sVV3rBwjxbpkcSbaNiBCH1BOomN/PY6Lpectl8DeTM3Y/X2rxUo94iiAyHL6UJ1kLUQHaGotwN6IlEmToSHyGbsdA4nDtuw+4Uwe5J2qoKv/f2NH3myohP5/80FH1uJ8Cu0mabjKYwtpVo7j7FTBCD34ARvj/fk82SUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqMVirwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037DBC4CEE7;
	Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753447326;
	bh=TSYyYdc2kUVh5hhhFunzCcBGjyYSshiQxo01fjyU+Qc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=kqMVirwdIQ4DlNhFpuXrM3MyqSZl1ERwls2kwjzHwqYGHDOOLWvKaYidJc0yUk+aV
	 nwcnAeOsNnEPhvuXSxPQEN1w7syyKXgxoPi/vTtQmhYFZPS82LvoTVFW4rsOnCx35C
	 TX2BDDMrFRSKrIOkCub6qBVGZnndWj8KvJgvpN4yo58rPzi/YjzEorLs3qsjt66N7D
	 17OUq9Ftu5r3HdQNYYLEbl6xUHbpy5tBRsyhLIst53H/pf/iOBBJHErQ/Rl1cCKi0s
	 NWE4esgW2/Tcb9QSxQXKxeVq2efI6+wgnDg96ZqVpd9YUxbKJG1CZAmPCPFTc4OV+t
	 qpFpLL6gD/mbw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufHkZ-00000001CvN-1mFX;
	Fri, 25 Jul 2025 08:42:11 -0400
Message-ID: <20250725124211.273108187@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 08:41:51 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [for-next][PATCH 6/9] PM: tracing: Hide power_domain_target event under ARCH_OMAP2PLUS
References: <20250725124145.391996103@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The power_domain_target event event is only called when CONFIG_OMAP2PLUS
is defined. As each event can take up to 5K regardless if they are used or
not, it's best not to define them when they are not used. Add #ifdef
around these events when they are not used.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/20250612145408.415483176@goodmis.org
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/power.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 5b1df5e1e092..82904291c2b8 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -319,6 +319,7 @@ DEFINE_EVENT(wakeup_source, wakeup_source_deactivate,
 	TP_ARGS(name, state)
 );
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
 /*
  * The power domain events are used for power domains transitions
  */
@@ -350,6 +351,7 @@ DEFINE_EVENT(power_domain, power_domain_target,
 
 	TP_ARGS(name, state, cpu_id)
 );
+#endif
 
 /*
  * CPU latency QoS events used for global CPU latency QoS list updates
-- 
2.47.2



