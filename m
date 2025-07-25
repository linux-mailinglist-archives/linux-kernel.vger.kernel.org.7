Return-Path: <linux-kernel+bounces-745800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC2B11EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA887BDAE0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6942EE28F;
	Fri, 25 Jul 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4uKJDqN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28C2ECD34
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447326; cv=none; b=Fmu5lw01WFVRGAq1hJqBUuRam6wKSxSmR5axK2Ea98JvuAvNyfLB6fer+NUIxycFDQ0fO1Qho/R04UbtBd0BwWDNgjUx1Lt8KkIsGbIJ5y1jd6/eIfbeGpO0GXkWPnG51nDpzWqiT2WaOuUjfjoHH4hubTkv9Q1FSGzE5nkjRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447326; c=relaxed/simple;
	bh=p8IGK4n6HKPRRjRVOFW5p1MfrK/F73ae7EmkoL2GcJQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bs91cr7R8LAhayb4k7RCKEN7H9l8c7xl9tlJ4mqZqj3SKj6cjaAJkXNiFd/obUKWS5seS85hhEesnew5+UNFF0/oLp/yIAX1KqPxcETwzB4wpCHYZwElrKZuCx8U6hL1yjAMUM8j5414ysXiFatwnbwRR+Qo3a1YmAYkw/bJ98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4uKJDqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFB8C4CEF8;
	Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753447326;
	bh=p8IGK4n6HKPRRjRVOFW5p1MfrK/F73ae7EmkoL2GcJQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=W4uKJDqNkGeVeStRyxOeizHDNSs5KBMQkkk43B0N7WMyurkkWAn4FR+8E62ttKivQ
	 ToS4YIN23yR1iZQE+0ai6m3eVtFGA9TjjEWFqRWrym/fyO0qD3ZAATLvFh4MDiH78K
	 PFd9yERtKVrImVpUzWBlm8WJGdM7fb4v78T/KUB8lSUX8BwI7W7rYjSfIOvukbvQ/3
	 SDR+3ao+enTz3ywLw6WVC/JLMjWHXZILFxse4MHH0rHyqYpQrlQwqwrjzgq9agKxcx
	 m+d0DbVwTj0x+m4AfS/oJm/JDsdXynSNubR6+HeGfUizDt5RVlKKdXWlpq9yXgj+lk
	 akaFMa8SzmD2w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufHkZ-00000001Cwu-3t2z;
	Fri, 25 Jul 2025 08:42:11 -0400
Message-ID: <20250725124211.779663463@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 08:41:54 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-next][PATCH 9/9] tracing: Call trace_ftrace_test_filter() for the event
References: <20250725124145.391996103@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The trace event filter bootup self test tests a bunch of filter logic
against the ftrace_test_filter event, but does not actually call the
event. Work is being done to cause a warning if an event is defined but
not used. To quiet the warning call the trace event under an if statement
where it is disabled so it doesn't get optimized out.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas.schier@linux.dev>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/20250723194212.274458858@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3885aadc434d..e4581e10782b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2900,6 +2900,10 @@ static __init int ftrace_test_event_filter(void)
 	if (i == DATA_CNT)
 		printk(KERN_CONT "OK\n");
 
+	/* Need to call ftrace_test_filter to prevent a warning */
+	if (!trace_ftrace_test_filter_enabled())
+		trace_ftrace_test_filter(1, 2, 3, 4, 5, 6, 7, 8);
+
 	return 0;
 }
 
-- 
2.47.2



