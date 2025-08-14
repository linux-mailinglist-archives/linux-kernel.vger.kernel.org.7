Return-Path: <linux-kernel+bounces-768318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25BCB25FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B968E8833BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616172E7F18;
	Thu, 14 Aug 2025 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MMZOuMU5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621762FF662
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161673; cv=none; b=NYvuH89I/C6oQLkYF+Gf8aPpjb4s8mv27n/zLirrfH6Aqvchu3pO5WSZlUiBXt2MspTTDd2BQZXiRBfNj42RMPRrp2l6oPbOKpU145g76O74hBcyG2HAyP56d1amRFkm2btx/4tntZ7QOo2G1NipkGIbqJou+orY7Ie6yT5BBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161673; c=relaxed/simple;
	bh=qEqgfmyZ7dJGVf6/tqpqTJBQKy+840BPH59iTBN7z7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9wnrqsWu3QVDlCbkoAv5Yfs8aa1jUQb7tUxiUes9S5HWxcdjLmHHbfZkR7aI86Kt/2DOM7keP6QKAO2WczwsuFGf9TQbqEltcUM3L8WKhyYeHf8vfYHGNDpruH6UKomo57H/lLDaAdXvIaRMRBo+6D3PpAbTNiNA9VyosqCHk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MMZOuMU5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jkpdeRmIcX3sqtsY4hCVp4VwmTLzuEyFVk4s/KJpSWk=; b=MMZOuMU5REYU5gOYSXKTTezBut
	1szeHJg/M7WyIyQld3o2btfpgvytuitLkW/0v7ERaGzDeB21BbAc02yUCFikG33z8fkP59ro4tlr9
	YRCtbZkt3EztrWELTd0d+1CUd67qtgeCb+7z+G6me80QEQIiMw6IFGfBa1iSq1bSHXwHPVW1U0irF
	dCnHAYpTUqvXqxH8mBEDf5rvNBHnBeenvy136VpesJiZycjXfDnLmAfezvveNQAEct3IigluLqBsa
	BZROUm8JMAdjiD8axO1m9KXndFICum7sxjHxn5kDsndJ2JQnYsRut4ZBC74wDMyXs7dP2sdVY816I
	ve+jhQzA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umTj8-0000000GXEn-3XWp;
	Thu, 14 Aug 2025 08:54:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CC3683002C5; Thu, 14 Aug 2025 10:54:26 +0200 (CEST)
Date: Thu, 14 Aug 2025 10:54:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michael Jeanson <mjeanson@efficios.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [patch 10/11] rseq: Skip fixup when returning from a syscall
Message-ID: <20250814085426.GS4067720@noisy.programming.kicks-ass.net>
References: <20250813155941.014821755@linutronix.de>
 <20250813162824.420583910@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813162824.420583910@linutronix.de>

On Wed, Aug 13, 2025 at 06:29:37PM +0200, Thomas Gleixner wrote:

> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -408,6 +408,22 @@ static int rseq_ip_fixup(struct pt_regs
>  	return 0;
>  }
>  
> +static inline bool rseq_ignore_event(bool from_irq, bool ksig)
> +{
> +	/*
> +	 * On architectures which do not select_GENERIC_ENTRY
> +	 * @from_irq is not usable.
> +	 */
> +	if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || !IS_ENABLED(CONFIG_GENERIC_ENTRY))
> +		return false;
> +
> +	/*
> +	 * Avoid the heavy lifting when this is a return from syscall,
> +	 * i.e. not from interrupt and not from signal delivery.
> +	 */
> +	return !from_irq && !ksig;
> +}
> +
>  /*
>   * This resume handler must always be executed between any of:
>   * - preemption,

> @@ -467,6 +484,9 @@ void __rseq_handle_notify_resume(struct
>  			t->rseq_event_pending = false;
>  		}
>  
> +		if (rseq_ignore_event(from_irq, !!ksig))
> +			event = false;
> +
>  		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
>  			ret = rseq_ip_fixup(regs, event);
>  			if (unlikely(ret < 0))
> 

You now have a double check for CONFIG_DEBUG_RSEQ.

Since the value of @event is immaterial when DEBUG_RSEQ, might as well
remove it from rseq_ignore_event(), right?

