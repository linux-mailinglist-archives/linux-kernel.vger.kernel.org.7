Return-Path: <linux-kernel+bounces-837948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D75BAE1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DF632683B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976D430BBB8;
	Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbUIlZrb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A73309F17
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251686; cv=none; b=fzgzjDkCYhYPOdmHIsiT759JTS582UlmpFk7HAg5sUncQQ0U0Ki42U8ExOw/bLRSsUEntrqxY8cczM+sg/9JEtp3NDZ9AwrTnWcB7sSulQ4aCK1Yn2XO2bI8zuY+A5e45mc/Asg6B5IjAOhrFlMcyVWN9f5oVhQwNY9Yg4tUxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251686; c=relaxed/simple;
	bh=IUS9gn4p9iWzZ6Wm0O5tf4RWJiFVhFmnx6hA+d1hSN4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=J9hMzHV7eElhk/YOzN5e42N84IRenIEBm1n84gL9qeJ6hO5wKMFDfRuGXLDvACFQB7uNsmLQkI0eEizHml1exXoEvgvYu7Vyisk4YIp8Z8bqBK8KbLmTRSWSGzI0tD8PS3CnvwfzoD2PL2s6db96OKAxD1G9H3KAWnDAcNg1mHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbUIlZrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABECCC116C6;
	Tue, 30 Sep 2025 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251685;
	bh=IUS9gn4p9iWzZ6Wm0O5tf4RWJiFVhFmnx6hA+d1hSN4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=PbUIlZrbxUuphpUFOnWVkjuhVn9S9WtyvvyiDtWTyhl/niFjHvpdicT4wGdjgwJLW
	 wSbgp8QrvkMxbTn6wHCDNoaeH5RxkZgRRc7MoTo+7VCthIhHYGO3cPf48Ehf0Uackl
	 dgDF2dX6SAKEIjfYF1XrSJ3nq4gHHSoRstKXFatyrXrOQvc/clMF8cMisFgQn0teOZ
	 GNH/ZcounFq6d/b6aKogvg23d2+SNnya6HXC2HOsvRjDlIt6geXr8OhGpvah2HIqGM
	 68Kf7lEDRQqemulEmtPl8K3T13i1SDH4fMr8LSF6bjf4CqyiFjBgnhd/v9QK14MAeX
	 nW1XeXcNy4j2g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3dkj-0000000DIGM-2qfq;
	Tue, 30 Sep 2025 13:03:01 -0400
Message-ID: <20250930170301.530992021@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 13:01:37 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [for-next][PATCH 02/11] tracing: Have syscall trace events show "0x" for values greater than
 10
References: <20250930170135.285740909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently the syscall trace events show each value as hexadecimal, but
without adding "0x" it can be confusing:

   sys_write(fd: 4, buf: 0x55c4a1fa9270, count: 44)

Looks like the above write wrote 44 bytes, when in reality it wrote 68
bytes.

Add a "0x" for all values greater or equal to 10 to remove the ambiguity.
For values less than 10, leave off the "0x" as that just adds noise to the
output.

Also change the iterator to check if "i" is nonzero and print the ", "
delimiter at the start, then adding the logic to the trace_seq_printf() at
the end.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Takaya Saeki <takayas@google.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ian Rogers <irogers@google.com>
Cc: Douglas Raillard <douglas.raillard@arm.com>
Link: https://lore.kernel.org/20250923130713.764558957@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 3a0b65f89130..0f932b22f9ec 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -153,14 +153,20 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		if (trace_seq_has_overflowed(s))
 			goto end;
 
+		if (i)
+			trace_seq_puts(s, ", ");
+
 		/* parameter types */
 		if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
 			trace_seq_printf(s, "%s ", entry->types[i]);
 
 		/* parameter values */
-		trace_seq_printf(s, "%s: %lx%s", entry->args[i],
-				 trace->args[i],
-				 i == entry->nb_args - 1 ? "" : ", ");
+		if (trace->args[i] < 10)
+			trace_seq_printf(s, "%s: %lu", entry->args[i],
+					 trace->args[i]);
+		else
+			trace_seq_printf(s, "%s: 0x%lx", entry->args[i],
+					 trace->args[i]);
 	}
 
 	trace_seq_putc(s, ')');
-- 
2.50.1



