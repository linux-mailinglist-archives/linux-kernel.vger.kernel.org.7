Return-Path: <linux-kernel+bounces-875759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F33B0C19C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55D01A663CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E9634DB53;
	Wed, 29 Oct 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DExvI5uZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67C34AB12
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733452; cv=none; b=ME3iPv/KVKjjSid37+1WDfIB2wCSGGgqGCveoGH8JZo0pKAVCVYzgSkQjcS+jgOxWjxVaz3iLxVGmer+K3A9rcwcoRjtoEyXFGy9loXK7bVNNSyoN1DOYJH/PmSVFt4J3tpCAlv2xb638l/muAd3RoYz6zDuTM+8x5LBHcBvl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733452; c=relaxed/simple;
	bh=7FPIAlaSMQVMnw08rBMcPCE2W4qDvZkdq1QLYzST4CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/FOws1RBs5uF8BjCP70FB2NPs1AuermfTjeA46n571p2IbE/MV4gvydSHlkTYZ3YLFW+OvBwXALv4GGjsSrTN514Dy9Z+Jo/cbZZm7nEZ+9gHl0LUOZmKt3UMFL5tqidbnimuGfiXYwcxNnN6OhEiARlhSO0gjkeGWYrcUNHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DExvI5uZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7A0r7kNcXmywV0vSi5O47M2dCOMeNz2cGEoE+qzOrtI=; b=DExvI5uZaNlOi40HDGKpze0EXl
	gOYgYVOlxhva7H7bEjUurPd86P2w5APwNso99dqvg2jPwTpJ2zxt2RISXqdQiz8uojPTCzahEhFhE
	G2/hzeyH+qaiva/CmEzR7NgGXA/ZTznD8bumVH/vutFoH1l3kPur+jzFFO0qZxIcv7JCCxs6RV+oi
	AdfjjjVYfqSmPGz+qGxwE8SOn/5L5vO953JoObHAenkyS/Jpc8sBjUbLKgNgHMH6QMav4cNluM3YV
	epf11kKg6CuY0qUSFjOHuXzsGINdxTcx65J3h/7ajBJFHKbZy3AjwnBKQf/BLE2GwTS5IdeKXW7Wl
	ExXw/JUg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3LT-00000007GPU-32Fb;
	Wed, 29 Oct 2025 10:24:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5265F302FD7; Wed, 29 Oct 2025 11:23:59 +0100 (CET)
Date: Wed, 29 Oct 2025 11:23:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V6 00/31] rseq: Optimize exit to user space
Message-ID: <20251029102359.GH988547@noisy.programming.kicks-ass.net>
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027084220.785525188@linutronix.de>

On Mon, Oct 27, 2025 at 09:44:14AM +0100, Thomas Gleixner wrote:
> Thomas Gleixner (31):
>       rseq: Avoid pointless evaluation in __rseq_notify_resume()
>       rseq: Condense the inline stubs
>       rseq: Move algorithm comment to top
>       rseq: Remove the ksig argument from rseq_handle_notify_resume()
>       rseq: Simplify registration
>       rseq: Simplify the event notification
>       rseq, virt: Retrigger RSEQ after vcpu_run()
>       rseq: Avoid CPU/MM CID updates when no event pending
>       rseq: Introduce struct rseq_data
>       entry: Cleanup header
>       entry: Remove syscall_enter_from_user_mode_prepare()
>       entry: Inline irqentry_enter/exit_from/to_user_mode()
>       sched: Move MM CID related functions to sched.h
>       rseq: Cache CPU ID and MM CID values
>       rseq: Record interrupt from user space
>       rseq: Provide tracepoint wrappers for inline code
>       rseq: Expose lightweight statistics in debugfs
>       rseq: Provide static branch for runtime debugging
>       rseq: Provide and use rseq_update_user_cs()
>       rseq: Replace the original debug implementation
>       rseq: Make exit debugging static branch based
>       rseq: Use static branch for syscall exit debug when GENERIC_IRQ_ENTRY=y
>       rseq: Provide and use rseq_set_ids()
>       rseq: Separate the signal delivery path
>       rseq: Rework the TIF_NOTIFY handler
>       rseq: Optimize event setting
>       rseq: Implement fast path for exit to user
>       rseq: Switch to fast path processing on exit to user
>       entry: Split up exit_to_user_mode_prepare()
>       rseq: Split up rseq_exit_to_user_mode()
>       rseq: Switch to TIF_RSEQ if supported

Applied to tip/core/rseq.

