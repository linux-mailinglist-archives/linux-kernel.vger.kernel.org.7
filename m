Return-Path: <linux-kernel+bounces-830105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C970AB98BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3620D19C7C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE98287253;
	Wed, 24 Sep 2025 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wA0hlDkt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5712820D7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701020; cv=none; b=Ivwui/3AzLjsZYLFUS1QWLQJlRjtgkYyMcMZz/hc9e5j9VUzVzOL1b1GdWEsa0MyQgVnEKuC1jvRhqysWRfgEoEG1aZ/i2QoEby8CZ5QX6wfHJEEyBvpB9iJXJ47dsyxA/1LNinFwGYazv4nt0YhOKr8nuQA2oDL437P73S0Ttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701020; c=relaxed/simple;
	bh=DCHKXtICtVbOSz5Xk2gMriv6KBrymPWuwH5XeiwtRyw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XB0euRDMOu6IMIlX+3EYRkYthQ3k2Ms7OUPEaB/q50fc4FJs4QYSgX1n7qkH/dCQZHw2bk/xH4nfYKp7CnWvn/PMzcZK5wE63JGb0eJYQjPqMFvPEsM7yC8WpvCm3tPHantrpepI1f4utGqCjDxs/oXJtF3sNAIZ4jo24U0xPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wA0hlDkt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=9heMtrNryMBnT0lE0ZZ/4t8suww3ktzb1k/l4myqmuc=; b=wA0hlDkt4Vvg8JnuDi7R3lNzQj
	utIpNb9RYaBYCwcIfsko885Glj/VAIEDOvoFo5bSFB32WVjaYznmF2MccsPc3E+KQ0sfict28LYIG
	VW/WR/EeV2JAN2K5dHK+QzMMnv2hOGnWPtylrv5wmML4jJVnHFZsgrhqN+lzHLdC8NxmrZdOSVqwP
	1Z0apbQ1W1D2GVKsEy7+I74pUqb0VzSVZyUA+mQZ3kyzF+CQWnCnfHL2ziCNeFM2joaleR1kORO8U
	yJoiEHI8QMnNSo1y1HikZHHczigwiE2leFGwuiSWTKm+m6AFEUVYwdLbwGelrkAHN0r7FVbcUGnLN
	VMF2p3fg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTO-0000000BeEE-2T9S;
	Wed, 24 Sep 2025 08:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 130D2302DD8; Wed, 24 Sep 2025 10:03:33 +0200 (CEST)
Message-ID: <20250924080118.893367437@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 09:59:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 05/12] unwind: Add comment to unwind_deferred_task_exit()
References: <20250924075948.579302904@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Explain why unwind_deferred_task_exit() exist and its constraints.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/exit.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -934,7 +934,6 @@ void __noreturn do_exit(long code)
 
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
-	unwind_deferred_task_exit(tsk);
 	trace_sched_process_exit(tsk, group_dead);
 
 	/*
@@ -945,6 +944,12 @@ void __noreturn do_exit(long code)
 	 * gets woken up by child-exit notifications.
 	 */
 	perf_event_exit_task(tsk);
+	/*
+	 * PF_EXITING (above) ensures unwind_deferred_request() will no
+	 * longer add new unwinds. While exit_mm() (below) will destroy the
+	 * abaility to do unwinds.
+	 */
+	unwind_deferred_task_exit(tsk);
 
 	exit_mm();
 



