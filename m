Return-Path: <linux-kernel+bounces-848868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905BBBCEB9C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AACE544FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E682797BD;
	Fri, 10 Oct 2025 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiEOcNsE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC878277CB6;
	Fri, 10 Oct 2025 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136798; cv=none; b=rNRIyDcvuze0bcfmrB7iNJlcfYcat1xgzrh67l5Cv4dIGabgcqHxHFIJSeYNPraLVKOIcPWKSEAo23hsEl2IPQL1xnx5VYhnXd8jjmlTF2VnTplvCAsaZiunLBEVxs2BjKzhJ8ZNszzWLyM+5c1jJhN6a7c4M2SwO43/Yz7jkz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136798; c=relaxed/simple;
	bh=gpOkKkEsmX1Wjj/6cRNkLNpSD17dKGgauuMWdtr5Gzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhxPL+UEAerLNu5AuBqfKlXMqtq79MAuUzGFzMnV0zyhRqHFwpiZNWEHBoUG16WiKaRURvS1cf6ADydvKp0YaYShUG58l0+Jl3I8fM/hik9v0rQ8c5Pq34sEgo13FmduIp55D+gTLE7uspa4XY5zU9bbro55b9cV1cEVKvDnxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiEOcNsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32301C4CEF1;
	Fri, 10 Oct 2025 22:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760136798;
	bh=gpOkKkEsmX1Wjj/6cRNkLNpSD17dKGgauuMWdtr5Gzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiEOcNsEFFGgzzSrfbeSU/mjbQi8S0Dv3uo1oxtTJIq8c4qxdvUzkwxLego0PacwF
	 Wk8dNxP9mkmYVlypEraJFk5CiEgCTbEYqmih0u9NGwNgMjAZd+yAmui1MZYX7oCDGn
	 fptnk64LbLgkiaaAJG4wsDd9hnt5+6U+TOMb92qFAclpK0qPxZzptjGhDGFL9qILYx
	 uqxGuTYKaUoarZt8ARIWP812wHOMPt6rledRAMU9PjdiRLHma4Y8xvzLBTF1w/WHQn
	 xNw1CqabRmOGWPl36l36RGsqvuwWA3w7TWRHWZOeB4aapsd2UrTMxA2D8Yhjf3Yfm5
	 UPSqzKTM0GQbQ==
Date: Fri, 10 Oct 2025 15:53:17 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [tip:x86/core 1/1] vmlinux.o: warning: objtool:
 rcar_pcie_probe+0x13e: no-cfi indirect call!
Message-ID: <202510101552.2B06CB4CBB@keescook>
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
> 
> which does somewhat make sense because what's the point of setting up
> the CFI call if you know nothing can actually make use of it since we
> will crash when trying to indirectly call a NULL pointer?
> 
> Something like this would avoid this issue then.
> 
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

Much preferred over "always crash" ;) Nice digging!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

