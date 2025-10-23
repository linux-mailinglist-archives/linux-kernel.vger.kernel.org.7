Return-Path: <linux-kernel+bounces-866566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA56C0019B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8543A6A08
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E42FBDE4;
	Thu, 23 Oct 2025 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L6M+w5T2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC482FB0AB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210284; cv=none; b=QxoAbtVAGNd+UHe5UL35pm1u5O2H6BpCgG8FEEZhCM2zPG6mZrUFdt9JwPNh/GHLbf6Fcc8kbolw5pGfcK++bVKEbaJvVpbttMxRRcn3Nqh9WhSbXy2zaaRBqHNM1Ymrks7PqfJHwHNrFEQoMPK+fsz5DovQmMtqsQK5tmy0s/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210284; c=relaxed/simple;
	bh=AG3DQ4ohMyNvEfGyyPOPBMNU2nmqrhk9CzFfhA7/zMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSQNZNK05piUFjUWm2JByCg21sSuwywS0Ws4OoO8Jco8gRbQ/nDl+Z7ZnU3rmt4rdTihqCPFoqw0Lkh7ISmmHMzTT70uyLF5W/pqAc8ouE1sX50GLxFbX4hce0uVxzxgA77H1NYV/r8uGFzmQ6P/isEWxe7GiAhLwxu3P2vgeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L6M+w5T2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ugbkR/yZ6vbSWzCZ92nXtNOBQd1ESw5dTTriM0yXjNA=; b=L6M+w5T2k4S5fc3ZAdfFyg9Xuh
	EkbChA+ZTAYV+Tr7DKSWoyOlj2uRSDc+D+q2pySdApZKI/Y65hIsF+gVZuZLY+8zf6qBxuZjyXIU1
	RZY1p19sOnXmUawhsUnLUzl8xvem2IGR12A/0QR5+dXSnxCy/7P1m6Q/juYMacw7S1ViW3AusstRR
	HgY0WgQdr0hgKqihQ528WnLRt3w2O3K5x44swkuxL2FkU38Q70w2xttc2ELRvzYnhR7cfa2oU9D9r
	GwCREWODkjmhMfzI0mxX6q4vhbPlO1q9o/TszdxlayUCzPOxfM0TZy+97iaX7aZaIHCBb8mPoMTJE
	f94hTTtQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBrFN-0000000GDaM-3xZg;
	Thu, 23 Oct 2025 09:04:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7C9C9300208; Thu, 23 Oct 2025 11:04:38 +0200 (CEST)
Date: Thu, 23 Oct 2025 11:04:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V5 28/31] rseq: Switch to fast path processing on exit to
 user
Message-ID: <20251023090438.GX3245006@noisy.programming.kicks-ass.net>
References: <20251022121836.019469732@linutronix.de>
 <20251022121943.156913457@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022121943.156913457@linutronix.de>

On Wed, Oct 22, 2025 at 02:52:35PM +0200, Thomas Gleixner wrote:
> +static __always_inline unsigned long __exit_to_user_mode_loop(struct pt_regs *regs,
> +							      unsigned long ti_work)
>  {
>  	/*
>  	 * Before returning to user space ensure that all pending work
> @@ -62,6 +57,23 @@ void __weak arch_do_signal_or_restart(st
>  	return ti_work;
>  }
>  
> +/**
> + * exit_to_user_mode_loop - do any pending work before leaving to user space
> + * @regs:	Pointer to pt_regs on entry stack
> + * @ti_work:	TIF work flags as read by the caller
> + */
> +__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> +						     unsigned long ti_work)
> +{
> +	for (;;) {
> +		ti_work = __exit_to_user_mode_loop(regs, ti_work);
> +
> +		if (likely(!rseq_exit_to_user_mode_restart(regs)))
> +			return ti_work;
> +		ti_work = read_thread_flags();
> +	}
> +}

Loops in loops seems to be your favourite new theme :-)

