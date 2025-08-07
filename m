Return-Path: <linux-kernel+bounces-758590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4437AB1D11A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB31D626F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C861CAA65;
	Thu,  7 Aug 2025 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="TXTN/5mf";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="jdQbIJFM"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1B23CB;
	Thu,  7 Aug 2025 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754535742; cv=none; b=qWLMoYwitAHfB0LAZbgVR6Cz4AOpH9f6KYybzNS2zmMD/d1RKgHzJ/0/1imSMhn4WwFBOnhV7x/1dyQZkXnL983afyJZwPwLAQ6FwCzAhbxv1HYklzrTCy/nOAWLodncnk2B0VYUNMMTUNaySbyvUrRkZ/icAA6qA5LFQgedFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754535742; c=relaxed/simple;
	bh=OlG6Mjad+haShvjgVxRjEO8qyOkeqUokqCYlSq/LmOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSIimaWwXywN4jf2n6axy7JCav/NdjqTsQSq9GXVz+XDNFiYEZ8ufNnKdZmyPNDfcpfdGdHsPzSEmTFJIVs4fYF5em/+6253LyhASIT7aIlar0TTvOttYrAF0XlRe7D6CA2g4Xy/WZGIq5a89BybRyF9tUVTII633IS3Ao3CW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=TXTN/5mf; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=jdQbIJFM; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from localhost (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 0651212FB437;
	Wed, 06 Aug 2025 20:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1754535732; bh=OlG6Mjad+haShvjgVxRjEO8qyOkeqUokqCYlSq/LmOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXTN/5mfzl3clvuzeNNCQqhgS3ri7dhlpu+I0HZ8hCExsjLgQZza5mRYngJnFOCdt
	 QMMHl5PeQUnYrYfRdZqF42XnbQ8I/InFsaqP2Ga5ukt1tGP7sDkN65jOBI0th2zjbm
	 yZQDO3vtBhsLMGn2ATB3fAtWx2HnTwoeovg1fRoh87KZ+zSDrerKPfitBL0AlxL0el
	 KoTDIrCPbFDH7T5fMAWIjhiSLNqUemLUQQh7W97JORnHnP/jjCtR0z2zMPlnoB/YcB
	 ZON1baYiSywej3CmQdkF4CfP29vHh4Tg4BMEIrNgOvfwBMc7SO1VNa1R4y5RzxfExI
	 fvZZZXxUu72Xw==
X-Virus-Scanned: amavis at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by localhost (bayard.4d2.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gl8dWHxY44b0; Wed,  6 Aug 2025 20:02:08 -0700 (PDT)
Received: from ketchup (unknown [117.171.64.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id DFB9F12FB405;
	Wed, 06 Aug 2025 20:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1754535728; bh=OlG6Mjad+haShvjgVxRjEO8qyOkeqUokqCYlSq/LmOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdQbIJFMt8WAoxsnjXZFVNWrtk5ZoKmMLJKLhs+Sty3jfPVUykp/dEx5g5p8GM1vE
	 tz0BI+Q8zz4xuY1mi/aheQnq8s3erhUaSWzITIJhoWX0m0SZgPQ0OyIO35fbV3FXeX
	 P3Lu1RbtHCwfmW6TPt4wzDep3irr9FB57xSeUhWhO007dfJ3h3WVI3pAQxONgFglSQ
	 51+k7EWCuf0/i2BRrKwwdRS2Sc5YlR2QaPc95GDu8gkWjqDSioIY1dVCu3+ol79apX
	 6rT5aAUKX8NAEby3Q4qljx8zXn2Nh+TlCoENJOcKh9/ZOTXNYv90jfhJvEkBPGFPiB
	 iS0r5elCNRvSw==
Date: Thu, 7 Aug 2025 03:02:00 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
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
Subject: Re: [PATCH 2/2] clk: spacemit: introduce i2s pre-clock and fix i2s
 clock
Message-ID: <aJQXKN_ccpWVJ5oZ@ketchup>
References: <20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com>
 <20250807-k1-clk-i2s-generation-v1-2-7dc25eb4e4d3@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807-k1-clk-i2s-generation-v1-2-7dc25eb4e4d3@linux.spacemit.com>

On Thu, Aug 07, 2025 at 09:30:11AM +0800, Troy Mitchell wrote:
> Defining i2s_bclk and i2s_sysclk as fixed-rate clocks is insufficient
> for real I2S use cases.

This is a little misleading: they're modeled as gates with fixed-factor
for now whose rate is calculated from their parents instead of defined
statically. You could avoid possible confusion by replacing "fixed-rate"
with "fixed-factor".

> Moreover, the current I2S clock configuration does not work as expected
> due to missing parent clocks.
> 
> This patch adds the missing parent clocks, defines i2s_sysclk as
> a DDN clock, and i2s_bclk as a DIV clock.
> 
> The i2s_sysclk behaves as an M/N fractional divider in hardware,
> with an additional gate control.
> 
> To properly model this, CCU_DDN_GATE_DEFINE is introduced.

Could it be represented as a DDN clock taking a gate as parent? Just
like what is described in the published clock diagram. Generally I'd
like to avoid introducing more clock types, there're already a lot.

> The original DDN operations applied an implicit divide-by-2, which should
> not be a default behavior.
> 
> This patch removes that assumption, letting each clock define its
> actual behavior explicitly.
> 
> The i2s_bclk is a non-linear, discrete divider clock.
> The previous macro only supported linear dividers,
> so CCU_DIV_TABLE_GATE_DEFINE is introduced to support
> the hardware accurately.

The divider IS linear, from the perspective of functionality, it just
implies a 1/2 factor. Could it be represented as an usual divider and a
1/2 fixed factor?

> The I2S-related clock registers can be found here [1].

So this patch actually does four separate things,

- Introduce a gate-capable variant of DDN clocks
- Make the pre-divider of DDN clocks flexible
- Support looking up mappings between register values and divisors
  through a table when calculating rates of dividers
- Fix the definition of i2s_bclk and i2s_sysclk

IMHO it's better to split them into separate patches for clearness.

> Link:
> https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb
> [1]
> 
> Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
> Co-developer: Jinmei Wei <weijinmei@linux.spacemit.com>
> Signed-off-by: Jinmei Wei <weijinmei@linux.spacemit.com>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  drivers/clk/spacemit/ccu-k1.c     | 34 ++++++++++++++++++++++++----
>  drivers/clk/spacemit/ccu_common.h | 13 +++++++++++
>  drivers/clk/spacemit/ccu_ddn.c    | 47 ++++++++++++++++++++++++++++++++++-----
>  drivers/clk/spacemit/ccu_ddn.h    | 25 +++++++++++++++++++--
>  drivers/clk/spacemit/ccu_mix.c    | 47 +++++++++++++++++++++++++++++----------
>  drivers/clk/spacemit/ccu_mix.h    | 26 +++++++++++++---------
>  include/soc/spacemit/k1-syscon.h  |  7 +++---
>  7 files changed, 161 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> index 65e6de030717afa60eefab7bda88f9a13b857650..a6773d4c2ff32d270e1f09b0d93cfff727ea98fa 100644
> --- a/drivers/clk/spacemit/ccu-k1.c
> +++ b/drivers/clk/spacemit/ccu-k1.c
> @@ -136,13 +136,36 @@ CCU_GATE_DEFINE(pll1_d3_819p2, CCU_PARENT_HW(pll1_d3), MPMU_ACGR, BIT(14), 0);

...

> +static const struct clk_div_table i2s_bclk_div_table[] = {
> +	{ .val = 0, .div = 2 },
> +	{ .val = 1, .div = 4 },
> +	{ .val = 2, .div = 6 },
> +	{ .val = 3, .div = 8 },
> +	{ /* sentinel */ },
> +};

This is just a normal 0-based divider if you divide the divisor by 2.

> +CCU_DIV_TABLE_GATE_DEFINE(i2s_bclk, CCU_PARENT_HW(i2s_sysclk), MPMU_ISCCR,
> +			  27, 2, i2s_bclk_div_table, BIT(29), 0);
>  
>  static const struct clk_parent_data apb_parents[] = {
>  	CCU_PARENT_HW(pll1_d96_25p6),
> @@ -756,6 +779,9 @@ static struct clk_hw *k1_ccu_mpmu_hws[] = {
>  	[CLK_I2S_BCLK]		= &i2s_bclk.common.hw,
>  	[CLK_APB]		= &apb_clk.common.hw,
>  	[CLK_WDT_BUS]		= &wdt_bus_clk.common.hw,
> +	[CLK_I2S_153P6]		= &i2s_153p6.common.hw,
> +	[CLK_I2S_153P6_BASE]	= &i2s_153p6_base.common.hw,
> +	[CLK_I2S_SYSCLK_SRC]	= &i2s_sysclk_src.common.hw,
>  };
>  
>  static const struct spacemit_ccu_data k1_ccu_mpmu_data = {

...

> diff --git a/include/soc/spacemit/k1-syscon.h b/include/soc/spacemit/k1-syscon.h
> index c59bd7a38e5b4219121341b9c0d9ffda13a9c3e2..253db8a602fe43a1109e2ba248af11109c7baa22 100644
> --- a/include/soc/spacemit/k1-syscon.h
> +++ b/include/soc/spacemit/k1-syscon.h
> @@ -29,10 +29,11 @@ to_spacemit_ccu_adev(struct auxiliary_device *adev)
>  #define APBS_PLL3_SWCR3			0x12c
>  
>  /* MPMU register offset */
> +#define MPMU_FCCR			0x0008
>  #define MPMU_POSR			0x0010
> -#define  POSR_PLL1_LOCK			BIT(27)
> -#define  POSR_PLL2_LOCK			BIT(28)
> -#define  POSR_PLL3_LOCK			BIT(29)
> +#define POSR_PLL1_LOCK			BIT(27)
> +#define POSR_PLL2_LOCK			BIT(28)
> +#define POSR_PLL3_LOCK			BIT(29)

This reformatting doesn't seem related to the patch.

>  #define MPMU_SUCCR			0x0014
>  #define MPMU_ISCCR			0x0044
>  #define MPMU_WDTPCR			0x0200
> 
> -- 
> 2.50.1
> 

Best regards,
Haylen Chu

