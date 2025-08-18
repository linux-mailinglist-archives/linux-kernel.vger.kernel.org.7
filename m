Return-Path: <linux-kernel+bounces-773646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A3DB2A3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998BF6243D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C23631CA72;
	Mon, 18 Aug 2025 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="KTF0ZmbZ"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A83218C2;
	Mon, 18 Aug 2025 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522509; cv=none; b=QKM3ZF0vd3NVrNA+dwlHj4HMb/FlWbuLwEvdpIxtipkGo9O3y1PtKc3s3eZZ6t/j5DZgo4+wj0cDIV9nq1dsQKz5d3/NUfSzntNq1gV9kfmY/XJdZpGs6upgPDSFf/eCzm1WJZ2RXcpBJ06sRjcFywkivG3ZNYzISgIt4qSZb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522509; c=relaxed/simple;
	bh=ZWlzv9zQPgG3T4Qdt+COdLbnVTsm7kZtfnXMkGnLfdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3wAdmyBSBI1yozOdflXdFP7HtyykPr+Ih+VKIW9KrqXaFpU0/zLhbiCxBmY5D7X+ogZEV55Xpvy3qhHU0n3fgpheze5eVqi41+hF+8kLRKWcnEm5PzNBbRpwNnbMRB9zj+XhGUyXb7d3n6urNthJtcjjIFHb4o8WpRy5iAnWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=KTF0ZmbZ; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755522486;
	bh=s8YclNR8beo4nWkkZUjnovn1goim6RIxNT6d2tnjL/s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=KTF0ZmbZZcLnmrdiokOxKonJKRDPuK3ldJN39AXjBl05dQGjorzbBYxT+Z7AUjeiu
	 CDdXKglwU0ci+Qz02k2fkW+u8nVBCITCqICJFT91NNNQuc/YFuqLUY9jMfmpT00yYE
	 NYQVrCfiuHCbPgHK6LEeL4z7ts+9I92lCXKM/x3c=
X-QQ-mid: zesmtpip2t1755522484tf2d46652
X-QQ-Originating-IP: /v1dWevNYr4qGYbGv6tjmtqkcrChCHifqsQeMmx0+5s=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 21:08:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14735046647836716306
EX-QQ-RecipientCnt: 16
Date: Mon, 18 Aug 2025 21:08:00 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Haylen Chu <heylenay@4d2.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Alex Elder <elder@riscstar.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH v3 3/3] clk: spacemit: fix i2s clock
Message-ID: <2CB30FE47E82A003+aKMlsDlLnLqh2fC0@troy-wujie14pro-arch>
References: <20250818-k1-clk-i2s-generation-v3-0-8139b22ae709@linux.spacemit.com>
 <20250818-k1-clk-i2s-generation-v3-3-8139b22ae709@linux.spacemit.com>
 <aKL6ormE1N72fwVG@ketchup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKL6ormE1N72fwVG@ketchup>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NOIkHYnr7VzdD4Fm5+xrXjUyOJ2uYLQ5NIHyQuWjIvpTe0DyqX9G9Ol6
	NlBOtiIEWaTvscUw2trtl7LWYFQJQ1HnrK1t1TbF7HpnyiAAVyL+eAuq9zdBJv9ZTXxO8eg
	E4uNIGceLO/bf9Q0QracnXOOFi9BBuob3ULgL61TDixeE2mfE+WlUSMFaZL9c6LgGa8JOfq
	5oyOhQOOoqkd80KIOqBz3QR6afAvFGzksbHSz6sgUs0z9kcODbf53Zez84W+t/F6kl3vcOP
	tef9SQT7rb+8WBIDV1YcVo8rP1CVJnRki8dAygglQCaCnEA4XgR9/7g+5CjCWbOimEuKBLX
	eJTPyeI96C1P2rLF5moEHlncljf7IwKGwH7TwEPE6WGmO21K3PLHTr4BkF9Atvakl/6hE82
	w1FkLAo14PDx5mtCSQ/IMIMRY/X3I7LfgB3a9MbSuOB55u01WkrTLZNjcNXbL+6/8RLUikn
	ZP0LKmzEspEpOf/X4ZS37PQUNn/qm1nVgvp/zF6iN7/2QN5PunQb4nbkYhlotBkWexeTLjm
	ThYnrffup6hHdKcAypkgnm6+4WiIDbAHw+xm6GPH8afMVUBSy/SkUGwLIyD9MOcK5C3liwA
	1/X1jBWHE0NMaz0dMLrgnquskM8KKXtHpAIsnLT4aYYDVeEqvfJngZQJDbfuIyVQWaA3ZuD
	baBByEw+7XgFmL6MxjtL9d6XWM9WclmksSSI0NLHG2Mwf9ZY4/ZXx0hRsroBm+28DYGVVgK
	n42cExCDgSPHtNvHCL+YAEHha/pb1gFSrptigeWVv6OiyRCeulim08mPd2tH++nHhqQjhbs
	V8SyzPZM1y409Nzy3Vhk7kqOiobDAkLlhXDJeOgyDw/lnHO51jb0IjD1IqheoBSda4A/cCw
	RpD22m/nL6UTgiMg9teiZetAPwT2Rm4NLbEbkEQsqHj+D5K/q/W+j3EwXNpFndyKdwKOG1i
	/W61JbTI4zvJSEjRqugncOiVx7ydL1ceHBF8YZ1uPYKfDMWub6dKcYxfKuJNrlFKJOgyHyg
	pCJhTXa5nf8jp2/t8zW07cXlk/Yox9pv9bpgoG7b2/5vUk4aN3a7fjqNYHzDZzuKE4P+4ZV
	vSiFeNZQuFH
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Hi Haylen,

I accept all ur suggestions and I'll send v4 ASAP.

Thanks for ur review!

                - Troy

On Mon, Aug 18, 2025 at 10:04:18AM +0000, Haylen Chu wrote:
> On Mon, Aug 18, 2025 at 05:28:22PM +0800, Troy Mitchell wrote:
> > Defining i2s_bclk and i2s_sysclk as fixed-rate clocks is insufficient
> > for real I2S use cases.
> > 
> > Moreover, the current I2S clock configuration does not work as expected
> > due to missing parent clocks.
> > 
> > This patch adds the missing parent clocks, defines i2s_sysclk as
> > a DDN clock, and i2s_bclk as a DIV clock.
> > 
> > A special note for i2s_bclk:
> > 
> > From the definition of register, The i2s_bclk is a non-linear,
> > discrete divider clock.
> 
> No, it IS linear. It just comes with a 1/2 factor according to your code
> (I'm assuming there's a typo in the table below).
> 
> > In calculus and related areas, a linear function is a function whose
> > graph is a straight line, that is, a polynomial function of degree
> > zero or one. (From Wikipedia)
> 
> > The following table shows the correspondence between index
> > and frequency division coefficients:
> > 
> > | index |  div  |
> > |-------|-------|
> > |   0   |   2   |
> > |   1   |   4   |
> > |   2   |   6   |
> > |   2   |   8   |
> 
> Index = 2 appears twice in the table. Is this a typo?
> 
> > From a software perspective, introducing i2s_bclk_factor as the
> > parent of i2s_bclk is sufficient to address the issue.
> > 
> > The I2S-related clock registers can be found here [1].
> > 
> > Link:
> > https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb
> > [1]
> > 
> > Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
> > Co-developer: Jinmei Wei <weijinmei@linux.spacemit.com>
> > Suggested-by: Haylen Chu <heylenay@4d2.org>
> > Signed-off-by: Jinmei Wei <weijinmei@linux.spacemit.com>
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> >  drivers/clk/spacemit/ccu-k1.c    | 29 +++++++++++++++++++++++++++--
> >  drivers/clk/spacemit/ccu_mix.h   |  2 +-
> >  include/soc/spacemit/k1-syscon.h |  1 +
> >  3 files changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> > index 7155824673fb450971439873b6b6163faf48c7e5..b2c426b629a37a9901bbced26fc55c5f1b34eba5 100644
> > --- a/drivers/clk/spacemit/ccu-k1.c
> > +++ b/drivers/clk/spacemit/ccu-k1.c
> 
> ...
> 
> > + * i2s_bclk is a non-linear discrete divider clock.
> > + * Using i2s_bclk_factor as its parent simplifies software handling
> > + * and avoids dealing with the non-linear division directly.
> > + */
> 
> And thus this comment is wrong and misleading. Suggest something like,
> 
> 	Divider of i2s_bclk always implies a 1/2 factor, which is
> 	described by i2s_bclk_factor.
> 
> > +CCU_DIV_GATE_DEFINE(i2s_bclk, CCU_PARENT_HW(i2s_bclk_factor), MPMU_ISCCR, 27, 2, BIT(29), 0);
> 
> >  static const struct clk_parent_data apb_parents[] = {
> >  	CCU_PARENT_HW(pll1_d96_25p6),
> > @@ -756,6 +777,10 @@ static struct clk_hw *k1_ccu_mpmu_hws[] = {
> >  	[CLK_I2S_BCLK]		= &i2s_bclk.common.hw,
> >  	[CLK_APB]		= &apb_clk.common.hw,
> >  	[CLK_WDT_BUS]		= &wdt_bus_clk.common.hw,
> > +	[CLK_I2S_153P6]		= &i2s_153p6.common.hw,
> > +	[CLK_I2S_153P6_BASE]	= &i2s_153p6_base.common.hw,
> > +	[CLK_I2S_SYSCLK_SRC]	= &i2s_sysclk_src.common.hw,
> > +	[CLK_I2S_BCLK_FACTOR]	= &i2s_bclk_factor.common.hw,
> >  };
> >  
> >  static const struct spacemit_ccu_data k1_ccu_mpmu_data = {
> 
> Best regards,
> Haylen Chu
> 

