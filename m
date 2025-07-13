Return-Path: <linux-kernel+bounces-729175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49100B032C8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 21:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8400C3B144D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E649127A124;
	Sun, 13 Jul 2025 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOZ+B6YO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39C2AEE4;
	Sun, 13 Jul 2025 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752436664; cv=none; b=kbu2xFm8qGQZtcqpQJ0tDbp6aNRaespCGeVbP2FsIr7Y4LZd/FoIW92Lxov6WmlDjVyjjeB0dzPOb8tGcPWK90Swj4Ip2H+52wFso5WpOOXkkao+sJq+SRXzUlZ2B0cWd+m9XEFSgk9fUEdOdsTkzGVpI75T6BcNKBQpGfUqn84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752436664; c=relaxed/simple;
	bh=7MhP7Eqd6lgawO40n7WyV/A2Nja9gmD0SILlAqtyncA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZDuiL0SAYLk4Tf1ZqqZmnLzwoJSu4NPfRhdAvoDmlDgPAvrDx6Y4HWGGIO+oydR/k+gCvCv++4QyFbY3DSLacXf8s2k6rqmbHNF/MbWAu5jKgAfEaynkxWUTroMtRy9gBxw09CbosLOIyd3UbR0H+QaSZqIbsx3Nkb0Gc1Udr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOZ+B6YO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA785C4CEE3;
	Sun, 13 Jul 2025 19:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752436663;
	bh=7MhP7Eqd6lgawO40n7WyV/A2Nja9gmD0SILlAqtyncA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOZ+B6YOOeI5xoYoJ9T+4exP4IdtHlNv4716nRx564DAv2sr/JZd1HhRl/qxWtvgk
	 UgdlDMwqD6+3abg3eLTVIBLDl0jN14ndsCsMadyVryFL2oGRp4v5PYyB5Zn8moLERf
	 zJLFhtN8BSJNINr5WbtMltmB+1pu3xXbhdKlCU585v4ilSlqGGnnysaYHBGWgBOnF9
	 V0JFNtxg3mACUmeU1h9iF2AoqbcAs1vOMz0fwdT0vEyb38wt8ozxp+yuQEme56mes0
	 n2IS6U0GWP9MxLMMV2jEVEpPmYYI0WVI9v8vkyKbASyOb6QHd5YNcyL6uQjA15BII2
	 ebDM3o8W2Iqlw==
Date: Sun, 13 Jul 2025 12:57:42 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	Yangtao Li <frank.li@vivo.com>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: thead: th1520-ap: Correctly refer the parent
 of osc_12m
Message-ID: <aHQPtjB9FjIsCYHW@x1>
References: <20250710092135.61049-1-ziyao@disroot.org>
 <20250710092135.61049-2-ziyao@disroot.org>
 <aHAp1q9tLy465gnO@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHAp1q9tLy465gnO@x1>

On Thu, Jul 10, 2025 at 02:00:06PM -0700, Drew Fustini wrote:
> On Thu, Jul 10, 2025 at 09:21:34AM +0000, Yao Zi wrote:
> > The "osc_12m" fixed factor clock refers the external oscillator by
> > setting clk_parent_data.fw_name to osc_24m, which is obviously wrong
> > since no clock-names property is allowed for compatible
> > thead,th1520-clk-ap.
> > 
> > Refer the oscillator as parent by index instead.
> > 
> > Fixes: ae81b69fd2b1 ("clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks")
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  drivers/clk/thead/clk-th1520-ap.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> > index ebfb1d59401d..42feb4bb6329 100644
> > --- a/drivers/clk/thead/clk-th1520-ap.c
> > +++ b/drivers/clk/thead/clk-th1520-ap.c
> > @@ -582,7 +582,14 @@ static const struct clk_parent_data peri2sys_apb_pclk_pd[] = {
> >  	{ .hw = &peri2sys_apb_pclk.common.hw }
> >  };
> >  
> > -static CLK_FIXED_FACTOR_FW_NAME(osc12m_clk, "osc_12m", "osc_24m", 2, 1, 0);
> > +static struct clk_fixed_factor osc12m_clk = {
> > +	.div		= 2,
> > +	.mult		= 1,
> > +	.hw.init	= CLK_HW_INIT_PARENTS_DATA("osc_12m",
> > +						   osc_24m_clk,
> > +						   &clk_fixed_factor_ops,
> > +						   0),
> > +};
> >  
> >  static const char * const out_parents[] = { "osc_24m", "osc_12m" };
> >  
> > -- 
> > 2.50.0
> 
> Reviewed-by: Drew Fustini <fustini@kernel.org>
> 
> Thanks for fixing this. osc_12m now appears under osc_24m in
> clk_summary.
> 
> Drew

Thank you for the patch. I've now applied it to thead-clk-for-next as
commit d274c77ffa20 [1].

Drew

[1] https://github.com/pdp7/linux/commit/d274c77ffa202b70ad01d579f33b73b4de123375

