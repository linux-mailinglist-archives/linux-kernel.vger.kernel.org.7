Return-Path: <linux-kernel+bounces-893619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EC9C47E78
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58D4D4F6722
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4922773CC;
	Mon, 10 Nov 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MmFpCWM8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C021273810
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791082; cv=none; b=R/iniycNCXV73E+9B+pvfTMHj9M9ZxNL8E4HXs/slq2rk0Sp7GGYuArJogdW7izqo+TDwsm5uZJBMteBzjl5cilFX6tIDbW49f3t4roeuoKQit8BPGpbYL+jHkIbqOpMwXsOnTBxVdyQF/diAjvlf6mgU2yOHpkxRT+zLMbL+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791082; c=relaxed/simple;
	bh=RhE8adnPxxaR0czYpwazNFhaaR0wCU6TFeG47NfjJNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWZ+oM2fKKHNlIUVC2qjsDxV/qm7SMxexMAN46BOfK2zzZ0Y+WX3W6ELW4c+NBo3nzRuUooUQPEtqDNSCoyGisvd1XMPa8qxZdLQEtcWZmzFLP0dz3ois+EIxaJv+jB5noLb3jozMv0y30H+D9qj2WGktJshRDoExsTGlJX3RGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MmFpCWM8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d3CmKZXG6H8IDGrUJWGL5HJ3FRwRftQZtuSaWwnv7fk=; b=MmFpCWM8Nt8onNj2fFK2TA9ne2
	GLaBKUjF+HlQBItjoyNF4rdTIly0IILTRA6eRjiPJ0enlCXtGr3PMMzbUYIXHAhC+chSP551sa2L4
	bJNErMLJchACjXRTlp+MFzfpGoeIbjZ2M6p5rOa4ZMYhEara8mqg5QarN1UMlX7NKc1jWndwmxxDk
	aPqOk+SK4CiatQ8/mDvLgQ4tdt5U17Rwd7twL6ZL7noKPYf/FZiIRb2XfKCj3Cz357nIdrXOZkxY/
	F6QiCloXjmv/Sa+g23le1SMwyY9+dtjLRQUaNNbes/Wr4XMGZ/cLXQrrPWwYzTlsusDMngCQX6PwJ
	Ps+iNIxw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIUU3-00000001VDr-2nQj;
	Mon, 10 Nov 2025 16:11:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2E5EC30029E; Mon, 10 Nov 2025 17:11:11 +0100 (CET)
Date: Mon, 10 Nov 2025 17:11:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Florian Weimer <fweimer@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch V3 07/20] cpumask: Introduce cpumask_weighted_or()
Message-ID: <20251110161111.GB278048@noisy.programming.kicks-ass.net>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.717519165@linutronix.de>
 <88d397b7-5eeb-41eb-ba44-980e72008fd2@linux.ibm.com>
 <87qzufw8fc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzufw8fc.ffs@tglx>

On Mon, Nov 03, 2025 at 02:29:59PM +0100, Thomas Gleixner wrote:
> On Mon, Nov 03 2025 at 14:45, Shrikanth Hegde wrote:
> > On 10/29/25 6:39 PM, Thomas Gleixner wrote:
> >> +static __always_inline
> >> +unsigned int cpumask_weighted_or(struct cpumask *dstp, const struct cpumask *src1p,
> >> +				 const struct cpumask *src2p)
> >> +{
> >> +	return bitmap_weighted_or(cpumask_bits(dstp), cpumask_bits(src1p),
> >> +				  cpumask_bits(src2p), small_cpumask_bits);
> >> +}
> >
> > nit:
> >
> > We have currently cpumask_weight_and & variants.
> > Wouldn't it be better to name it cpumask_weight_or ?
> 
> No. cpumask_weight_and() does weight(mask1 & mask2) but this does

The comment was about naming, notable: s/_weighted_or/_weight_or/g to
better match the existing _weight_and().

