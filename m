Return-Path: <linux-kernel+bounces-866531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A43EC00069
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A7854FB2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F163019D1;
	Thu, 23 Oct 2025 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wbv2jlFA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58433303A05
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209514; cv=none; b=BcKILQ4fEzNiz2bokV1iTH0mTGKOvc3hLtARQC9GZ31EGSUI9WPAERHKkbiCLV7jGl6B07y4Q8xtIOCivu7s4sppBAQToj3ycZtbAcrV2yBw83VDc8UzWhBK/66bxSn3z+W82Fe0qx4QX/b1xvxECKBe4GwLsQ8m4IwxbChD1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209514; c=relaxed/simple;
	bh=ahtIR74yL3EWBz+r68CqO2a2G3UwKOb5HH0xCiJgRD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2XsJ2L9YCyhM2zTrHqfrZeVte/F/j99R8sYsqZYjvTVKng1dFyzldl5+10gzlB/VVYrL9P07w1aF+tlTL5ux+AE4nEHFlIWWQsoVXq4PXcm+BwEb+hG8CqXkRv81fJOqQ2IvbH9B+EwfNZ0fbqv/C9qqD2Ul/YWS36VD1MHuY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wbv2jlFA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=alm3uqo548VUq6iMuCAO0S11jab2ED2XN0BTxGnB5jM=; b=Wbv2jlFAh3/uMrbC2/b5z2h/Yv
	mkj9w2hWtnpqpperw6s7Hy1ZD+cZRTLDjyJgYT5YN7CQL9CljLakabR19kMi5IcqzG477HHWJezox
	U9F/X0nusNG+Qe9XgN7GEjs/ES1j6677maHoHKTrnDwA5Ti+GJGeNuOjQjvXS0MNGYd/H7UFV5eI9
	ocg2Ib0kQ+03rQwaDS11om+pbjSp2s7XSV/E8HlmqnnyW5qU4ncyQWLv+WfI6nHkhXfpfDqvWnQBw
	phDqShUnpn7J3TwfgzCmgmVSO+2lj6wkh0ccyDUOLeIAaXucYqvcqOyydt5q7FBr3nvSFZIfOyEty
	tBDgEkTw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBr2u-0000000Fxxg-2HpL;
	Thu, 23 Oct 2025 08:51:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 91D91300289; Thu, 23 Oct 2025 10:51:44 +0200 (CEST)
Date: Thu, 23 Oct 2025 10:51:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V5 27/31] rseq: Implement fast path for exit to user
Message-ID: <20251023085144.GW3245006@noisy.programming.kicks-ass.net>
References: <20251022121836.019469732@linutronix.de>
 <20251022121943.093817667@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022121943.093817667@linutronix.de>

On Wed, Oct 22, 2025 at 02:52:34PM +0200, Thomas Gleixner wrote:
> @@ -245,12 +246,13 @@ rseq_update_user_cs(struct task_struct *
>  {
>  	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
>  	unsigned long ip = instruction_pointer(regs);
> +	unsigned long tasksize = TASK_SIZE;
>  	u64 start_ip, abort_ip, offset;
>  	u32 usig, __user *uc_sig;
>  
>  	rseq_stat_inc(rseq_stats.cs);
>  
> -	if (unlikely(csaddr >= TASK_SIZE)) {
> +	if (unlikely(csaddr >= tasksize)) {
>  		t->rseq.event.fatal = true;
>  		return false;
>  	}
> @@ -287,7 +289,7 @@ rseq_update_user_cs(struct task_struct *
>  		 * in TLS::rseq::rseq_cs. An RSEQ abort would then evade ROP
>  		 * protection.
>  		 */
> -		if (abort_ip >= TASK_SIZE || abort_ip < sizeof(*uc_sig))
> +		if (unlikely(abort_ip >= tasksize || abort_ip < sizeof(*uc_sig)))
>  			goto die;
>  
>  		/* The address is guaranteed to be >= 0 and < TASK_SIZE */

This seems like a random change, unconnected to the rest of the patch.

