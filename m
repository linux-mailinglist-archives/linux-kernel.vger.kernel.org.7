Return-Path: <linux-kernel+bounces-765247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EBBB22DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2867A3A9050
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3B2F8BDF;
	Tue, 12 Aug 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFQjCpvX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED682F8BC7;
	Tue, 12 Aug 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015857; cv=none; b=iatycsiwkCePOWpl925NI536O9PWB4PrqFlbU0bs+nueWHLrbdNQBQswGASt2lW9sc5oCv67SewkO7FK2ayuuf4TGR9q5fUDqe2DJhoN/uAWWVl2vRo+8GY8XKSLQuXtUK7nxOWkAxfTDiaja5ZsoOgCHiksL12tauGiUgO1oNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015857; c=relaxed/simple;
	bh=30o4U4tFe32XjiNz5Xqo8vYYR40fKkKwC8cxKxV1ldA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtaJ5oOHz+sgENDKxW/97PCNjwhGxRC4LTBj1BHPeksj8gXmlPvOtq0OhsjKp7FuGv4H+s+vi1ATo4XLAMrZ+8gTmoBKmjPdKgatMgkfUhi2yr/gyGAKwWhkEhK1esuCy6FYK7/Sjuu9c38QWN4YgWeXBAEdYl237twETzMabl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFQjCpvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E94C4CEF0;
	Tue, 12 Aug 2025 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755015857;
	bh=30o4U4tFe32XjiNz5Xqo8vYYR40fKkKwC8cxKxV1ldA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFQjCpvXvmuacmrZpk3++l3tgWJKfZp7c8w8aiWkYwkC668QD+n2jTqaJ+WTySpEB
	 0CbOP2Hae2Oblck1IaZGYo3urSxA5DUxKbTkyvaVbPIv2Z0u+vxQbnnxqePAk2sLc+
	 LAJpLiC6o/7K8d2m058b5PZ8ld+nNAcb1cnzL2UVbdnO0kICxaHuPCvK7DfbDmtBLW
	 MgAOMmgnVAV7Z9LxsJETuxHKtKinze/1gWW1FLhOVK8fTWIbjzGPdRCXtiKA0Yxl/j
	 cBVkzpL7l3m11RYSVECb4JkI8aYgAAtTX4gzoW08HwUDOHkUC/Eg0IuN6f2eAeYmph
	 O3JQr1YZlmnTA==
Date: Tue, 12 Aug 2025 09:24:15 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] clk: thead: Misc changes to TH1520 clock driver
Message-ID: <aJtqrz9y4/hR8fEu@x1>
References: <20250812054258.1968351-1-uwu@icenowy.me>
 <50a61990b5009217dcc0ed74142c4ffeba137f73.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50a61990b5009217dcc0ed74142c4ffeba137f73.camel@icenowy.me>

On Tue, Aug 12, 2025 at 09:42:23PM +0800, Icenowy Zheng wrote:
> 在 2025-08-12星期二的 13:42 +0800，Icenowy Zheng写道：
> > This patchset is my changes to the TH1520 clock driver, mainly for
> > supporting the display controller (the first 3).
> > 
> > The first two are functionality additions, with the first one adding
> > support for enabling/disabling PLLs (for DPU PLL) and the second one
> > adding support for changing DPU dividers.
> > 
> > The 3rd one is to address hang issues met when testing the DPU driver
> > w/o clk_ignore_unused command line option.
> > 
> > The 4th one has no relationship to display, and only exists for my
> > need
> > to change an arbitrary GPIO (well, GPIO3_3, the one controlling the
> > fan
> > on Lichee Pi 4A) with gpioset.
> > 
> > This patchset has a dependency (a 0th one) [1].
> > 
> > [1]
> > https://lore.kernel.org/linux-riscv/20250809-fix_clocks_thead_aug_9-v1-1-299c33d7a593@samsung.com/
> > 
> 
> Oops, looks like this patchset deserves a new revision now...

Thanks, that does make it easier to apply with 'b4 shazam'.

> PATCH 2/4 has a round_rate() implementation, which is considered out-
> of-date and determine_rate() will replace it.

I saw your reply over in the big patchset from Brian Masney. That's good
that we will be able to skip adding round_rate() to the driver.

> PATCH 3/4 was broken during rebasing.
> 
> PATCH 4/4 is found to be not working (and even makes padctrl0 an orphan
> clock). Yao Zi told me that I need to first do some changes to ccu_gate
> code.

Is there a way to test the functionality without additional patches from
your branch?

I look forward to v2. Thanks for working on the display. 

-Drew

