Return-Path: <linux-kernel+bounces-767359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EFBB2534A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E189A0F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F52EB5D3;
	Wed, 13 Aug 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZlohB5i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994552E1C56;
	Wed, 13 Aug 2025 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110924; cv=none; b=rNR12TVqkgqqKhnroLx/pr4331w1weZcSzUCFfwubaFx4WX/I+Dh0PW4qJyQA8+olxHC3jGqTof8eRGVmQF1Yt3pfYN/gMJeqs9vmhIgOiVYgvrl7aelck2Sj5fDBSBpcc4oJfcdnruPx6oWNv3YS9dzxUl3T8ZPjAY1qyeUOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110924; c=relaxed/simple;
	bh=h9+TOUuSmuwiGeeFq/t+i5nPgsw7wfFmCtzB/voaBMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ+i4Y4ViXvp48h8JQ6iKODvouo3DxZjTiA/m+wqHg+/BrQ7f/jV5zc36PywauIv8Hw28fSY+tyLiQZVzZi1/1v0jeXRY4f4T+S9uQit1+/eLeAvF1fumpY1Z7bHvoNhWw05qkovO+yF3GRUrhQG+6hxTGQ/cBGIYHMhtfxkwrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZlohB5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DA4C4CEEB;
	Wed, 13 Aug 2025 18:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755110923;
	bh=h9+TOUuSmuwiGeeFq/t+i5nPgsw7wfFmCtzB/voaBMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZlohB5ixOlaz45evaXnl7qDy32fDEOZ6BGbTSFAhliWdtw+dZVDpifkSuuPhDxJe
	 qE79KLFwqPMsz/kEyNXXYVLKpdGbpvayf3zBw2YGtzhQFc6od2+os7ZR2eBNfGTwDJ
	 na5LyNI6j3CJw+NUGqoK4nAsWBAmwRoUuW78MxkzKT5OnVNPo7swvjGlQ8i49M0wgG
	 lcCEPQ8qrjCWoLfwcycPTKi6gjkiS+1BZejCq4nNlwOUlpr55JdRdgsM93vk3jHzMC
	 gSQ/5iCyG5+2TAmkgqM33xcPgOp+/KWxvPl+qAhlnYirYAAhGE4KSoYPszSX7ne3S1
	 nxjTiH7GJV3Qg==
Date: Wed, 13 Aug 2025 11:48:41 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH] reset: thead: Scope TH1520 reset driver to VO subsystem
Message-ID: <aJzeCbARIRltiYE1@x1>
References: <CGME20250810211419eucas1p173e5fefcfaae437d8b5531d1406ff6a6@eucas1p1.samsung.com>
 <20250810-fix_reset_2-v1-1-b0d1900ba578@samsung.com>
 <aJrTq775sXTrsepl@x1>
 <aJxGnnwlE1sWarXa@pie>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJxGnnwlE1sWarXa@pie>

On Wed, Aug 13, 2025 at 08:04:40AM +0000, Yao Zi wrote:
> On Mon, Aug 11, 2025 at 10:39:55PM -0700, Drew Fustini wrote:
> > On Sun, Aug 10, 2025 at 11:14:19PM +0200, Michal Wilczynski wrote:
> > > The reset controller driver for the TH1520 was using the generic
> > > compatible string "thead,th1520-reset". However, the current
> > > implementation only manages the resets for the Video Output (VO)
> > > subsystem.
> > 
> > Looking at Section 5.4 on Page 451 of the TH1520 System User Manual [1],
> > it does seem like we would ultimately need 6 separate nodes for reset
> > controllers:
> 
> Yes, this is true. And another six nodes for clock controllers (there's
> already one).
> 
> >  0xFF_EF01_4000: AP_SUBSYS
> >  0xFF_EC02_C000: MISC_SUBSYS
> >  0xFF_E404_0000: VI_SUBSYS
> >  0xFF_EF52_8000: VO_SUBSYS
> >  0xFF_ECC3_0000: VP_SUBSYS
> >  0xFF_EF04_0000: DSP_SUBSYS
> > 
> > Maybe we should take this opportunity to document the bindings for all
> > the resets that the REE (e.g. Linux) can control?
> 
> It's worth noting that with either mainline U-Boot or vendor U-Boot, no
> core is configured to run as REE. IOW, AON_SUBSYS could be accessed by
> AP cores as well.

Interesting, I didn't know that the AP cores could access TEE resources.
> 
> I think introducing read-only clock support to Linux could help us to
> correctly describe pvt clocks which are now replaced with a aonsys
> placeholder and resolve issues like what is described in 0370395d45ca
> ("clk: thead: Mark essential bus clocks as CLK_IGNORE_UNUSED").
> 
> Futhermore, there may be downstream projects, e.g. U-Boot, make use of
> these TEE-only devices, which could benefit if we have these devices
> documented and described in devicetree, too. Thus I think the AON clock
> and reset controllers should be documented as well if we're going to
> document every reset/clock controller in a batch.

I think that does make sense to document the AONSYS clock and reset
controllers in the DT bindings as they are part of the hardware and
described in the t-head documentation. It would be great to be able to
make use of more functionality in the t-head sdk like the ability to
reboot the board.

Thanks,
Drew

