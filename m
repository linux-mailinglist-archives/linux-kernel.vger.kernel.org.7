Return-Path: <linux-kernel+bounces-874080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC5C15765
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A49421DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2862D33F8DA;
	Tue, 28 Oct 2025 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="maMp3RXA"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD433FE26
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665274; cv=none; b=m1QwB48HtNWsgJ1qIjaG4NL7PaZg3EMvRYhX3SmTjmF7zh7310sH03OU6u7I7VUdoKcLHQ4TO4ZjkVrW8RMKK+GfKQpCwMhB/ipMAhxaP2niLs0mST16sKmpkNnxmXXYlaKrzpuDgV1+OygeUCFEfV7DmuvK6nqa0rkyYWMuQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665274; c=relaxed/simple;
	bh=+/CHONzxLDieRtlJFsAnMDWhSrLbAfvO2zV+n1hsIts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGXSTfJN8ZOSUCEDvF57xpRdqGJcJh0neB1W45mG3bUY/2IRIrjrZmkgYtPkXykJVfG6kLHWN3zf0b60bwu3JTcgQB7bvZByTJATt5PDQ0SMhcco8Mm7b/rnJ05eVdK7+he8jBNkhLGpn62oIzBJuI07lNhbThqmmoh47ABug4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=maMp3RXA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qQ/N1nE79yF3eY56NVirFIZzJSB5QsRK3K4ggJAIWS8=; b=maMp3RXA4QIPWvNEvAtqDYyu5l
	MtoRUxrnWTp+d84Ij/ELzN4p5yMXzbPs8kN/oiyNEZKLe12ih2zs/Szssxnv1KH6KCIEJGqMjcP9B
	/gDBcBY05kAFw5OOl42+4/gbm+gZLOcnlg/dO1BzltL10Y4vSoMipXY125HIAjSZZZ5yVgpQVqwLx
	4CpgTA4PZNTBT/cevAGAO5Z6ZgpTY8/mQkDTw+bgoCubaeRy6yf7qZUAShkvgyvvp7q/cDeKr1DD4
	4oftfbUVGLiq8BPnszYyYB+umUKyYrRxSr4EAbVZKqNcNTy3NxCMCxKj80Vp9jKx7Y3fhY04WceJn
	7hB6dG6A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDkkC-00000004f5Y-1OY8;
	Tue, 28 Oct 2025 14:32:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5CD6F300289; Tue, 28 Oct 2025 16:27:47 +0100 (CET)
Date: Tue, 28 Oct 2025 16:27:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] perf/x86: Add cond_resched() when allocate/release DS
 buffers
Message-ID: <20251028152747.GR4068168@noisy.programming.kicks-ass.net>
References: <20251027212724.1759322-1-namhyung@kernel.org>
 <20251028141518.GA4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028141518.GA4067720@noisy.programming.kicks-ass.net>

On Tue, Oct 28, 2025 at 03:15:18PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 27, 2025 at 02:27:24PM -0700, Namhyung Kim wrote:
> > On large systems, it's possible to trigger sched latency warning during
> > the DS buffer allocation or release.  Add cond_resched() to avoid it.
> 
> We're >.< close to deleting cond_resched(), it makes absolutely no sense
> adding more.

Specifically, IIRC the plan was to do something like the below after the
next LTS release, and then continue to remove VOLUNTARY in subsequent
releases, leaving NONE the only option for the legacy architectures that
do not support preemption.


diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index da326800c1c9..db4ae53c1d49 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -16,11 +16,12 @@ config ARCH_HAS_PREEMPT_LAZY
 
 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE
+	default PREEMPT_LAZY
 
 config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
 	depends on !PREEMPT_RT
+	depends on ARCH_NO_PREEMPT
 	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
@@ -35,8 +36,8 @@ config PREEMPT_NONE
 
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
-	depends on !ARCH_NO_PREEMPT
 	depends on !PREEMPT_RT
+	depends on ARCH_NO_PREEMPT
 	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more

