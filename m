Return-Path: <linux-kernel+bounces-850145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 155BABD20CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09DD54EE62B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408382F362E;
	Mon, 13 Oct 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P1jrCx+u"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C112EACF7;
	Mon, 13 Oct 2025 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343995; cv=none; b=C81j6Ej0rURADYYHzk83mIxqdFbM/J4GaF4fQr0VWfdl7EFHEmaURp/vnbPMPyrysgLLLHdgWo2+aH6hBfJhHTGz96fqHwwUIoAKIVKdMHrtb12mzLMKjBfnL/gBayxxaF9Q18AH3BJlYBc0oCqJxYo9jHE8Y62cOnXGx8oEo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343995; c=relaxed/simple;
	bh=mhYbMUqo6ZsY2xdUH3I9/u+IkGuSpwABWXvCjwa48yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jasmdKiM3IO+IdWHmSNyDgIP84wO1RG9oFAg7FJrM3DV2NhpZbAx8mQoeO8Qq7nZuVjGL3B8vf/bISEHM83DIc5Maln+RSU+OLLLksoPchxAv+0/v00qMN7XELk7iLsQHHAeKEuP4sWHZW9eciwu8OcmfLtT6VW51q5RmMxh6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P1jrCx+u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2onQY5FvSXunJQp4XQbpmjw1bmWMDR7bKnWkiVs65Vs=; b=P1jrCx+uheHj/hJbkIbTIzHL7H
	I6udKigyAEQLZTwd8MN28N6NsWzWXhmA5ZbVjtuyRNKl3bxrmkVAYFLgW/U2u675HyAneoft1dEuL
	alxOCO24vFUepC7YJHE0kI4R5yzxiwmXf1LyZXJ8VGxWF1g13hX48IeDZAXu9VjHHzofcdfYERFui
	qYSEPJlP4sncOP7WVVMUEc8I0MfL7g1aBPAHGD76XwXoe/FiwQuE1ZIw2Qjsf1QnLIA473kBynCRs
	9M8hEyKjW1X1nFTgeIQK5YAvIi3hTBuqjmXctQFGpL7bpRLmNTa392/lI7K16xQiCJTJWqhzYelzj
	R1UeeJ1g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Dsz-000000026Gw-11YD;
	Mon, 13 Oct 2025 08:26:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4733C300212; Mon, 13 Oct 2025 10:26:29 +0200 (CEST)
Date: Mon, 13 Oct 2025 10:26:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [tip:x86/core 1/1] vmlinux.o: warning: objtool:
 rcar_pcie_probe+0x13e: no-cfi indirect call!
Message-ID: <20251013082629.GH4067720@noisy.programming.kicks-ass.net>
References: <202510092124.O2IX0Jek-lkp@intel.com>
 <20251010032001.GA3741500@ax162>
 <20251010071032.GE4067720@noisy.programming.kicks-ass.net>
 <20251010074446.GE4068168@noisy.programming.kicks-ass.net>
 <20251010223012.GA3597090@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010223012.GA3597090@ax162>

On Fri, Oct 10, 2025 at 03:30:12PM -0700, Nathan Chancellor wrote:
> On Fri, Oct 10, 2025 at 09:44:46AM +0200, Peter Zijlstra wrote:
> > That's here... and that is indeed broken. Also note how it zeros r11
> > right before calling it.
> > 
> > AFAICT this is:
> > 
> >         host->phy_init_fn = of_device_get_match_data(dev);
> >         err = host->phy_init_fn(host);
> > 
> > Where it has decided that of_device_get_match_data() *will* return NULL
> > and then helpfully emits (*NULL)(); or something like that. And then
> 
> Oh duh because it will :)
> 
>   $ rg '^(# )?CONFIG_OF' .config
>   1528:# CONFIG_OF is not set
> 
> which means that of_device_get_match_data() is always NULL:
> 
>   static inline const void *of_device_get_match_data(const struct device *dev)
>   {
>       return NULL;
>   }
> 
> > forgets to add CFI bits on for extra fun and games.
> 
> which means this is another instance of what Sami mentioned happening on
> another report of a similar issue
> 
>   https://lore.kernel.org/CABCJKue1wCB6jBLYUc-fAEzpyQWHXwbk8R5GBaZCkCao0EQZPA@mail.gmail.com/

Ah yes -- I had missed that :/

> which does somewhat make sense because what's the point of setting up
> the CFI call if you know nothing can actually make use of it since we
> will crash when trying to indirectly call a NULL pointer?

As Sami says, it would be really nice if clang would at least WARN about
emitting an unconditional NULL call like that. I mean, it *knows* its
going to crash and burn at that point, right?

> Something like this would avoid this issue then.

Yes, this seems reasonable -- even if the driver should perhaps
mandate/depend on CONFIG_OF, making sure to behave when NULL does get
returned is definitely a good thing!.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Cheers,
> Nathan
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 213028052aa5..15514c9c1927 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -981,7 +981,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  		goto err_clk_disable;
>  
>  	host->phy_init_fn = of_device_get_match_data(dev);
> -	err = host->phy_init_fn(host);
> +	err = host->phy_init_fn ? host->phy_init_fn(host) : -ENODEV;
>  	if (err) {
>  		dev_err(dev, "failed to init PCIe PHY\n");
>  		goto err_clk_disable;

