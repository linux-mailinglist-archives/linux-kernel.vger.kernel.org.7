Return-Path: <linux-kernel+bounces-752843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08FB17B81
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C000C3ADE34
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 03:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8311991B6;
	Fri,  1 Aug 2025 03:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="dTD6gLEJ";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="pnRgjqoe"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E613EFF3;
	Fri,  1 Aug 2025 03:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754019821; cv=none; b=M81iHL/xabVywfhPmbn3JsdcRdGDYW3luLN+5cKnY2ZarB3sh+TS6CCYt3twcxWLbnWg70I1vaR7rnNAlV4YEiz/81bweHDFTJ0rx7BTYRhyIXT0DfGELMOR/Zf0VuYc5rtnhv5AP1RCZcGK3k73s7HbkzJ2D5cp9tan9/qJNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754019821; c=relaxed/simple;
	bh=RyU/06axbOmuAEJla6gJSqqD6WDLQtT4/yHasgWo1pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHoS8Ah2rVxX7mTsnyMMf40b92EL4UyV+PwsIKSSGsmreVtakbW6UtWA46+j6F4hVab6biMZV69xQdHw3G0eJH2/4Cc3vgyCvYen7fWYuILtK/qKjSjVsGP0a51VsH9WUpdRyCN2J8smf0M/ngiC9hJ8dNTEIXHkHG5dEpsrkr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=dTD6gLEJ; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=pnRgjqoe; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from localhost (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 77F3F12FB41C;
	Thu, 31 Jul 2025 20:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1754018742; bh=RyU/06axbOmuAEJla6gJSqqD6WDLQtT4/yHasgWo1pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTD6gLEJ2CxMefUxfELj+QGXw7f1ofNLfDbbteWeH0CUnHdx0xr3kDgc+CCm60WTv
	 mP1RYMfwcVQ/EyKU3dx9NbiQcnP1y/NgPN8L6n/tVAKt8X14V/zj7k6I5miD0iJvSQ
	 M+y8cSVF9F+3h1rLhWuTCH5W7NZSKmSs5UhIZ98vzXJqJUtSkst6j4fW/RdduEC6Ha
	 0tUV/5BgD7dFkgj9woUOasCD7LjOWjPUJzL1Kpe/MibT3ttBJ2DUxdy13lS8P7Vdjc
	 4YAjbNfvE89YPtIoHOJyLwVHwyc8eLU722xMB1ko0CfWIuu41vrrkDmJw4UpvNNQ9K
	 KuPg/DJbTyJRQ==
X-Virus-Scanned: amavis at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by localhost (bayard.4d2.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W3_rfJeT08lw; Thu, 31 Jul 2025 20:25:39 -0700 (PDT)
Received: from ketchup (unknown [117.171.66.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id C3E1112FB405;
	Thu, 31 Jul 2025 20:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1754018739; bh=RyU/06axbOmuAEJla6gJSqqD6WDLQtT4/yHasgWo1pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnRgjqoe3THj7xbnE85paANZv0icsEkbjpr9Ce/YDMcF8rblWRxnJYHNON/ekjKd3
	 305OiLnwCecZ4BuKK1fhaIYEv4S8/FKCH53aIkZUekhlJ0D4GfdSHyKwYdt054iKvQ
	 uxpy51q9ELngIZpIOzeYhRUCFdk/fjzf4DWzPyza9oQJVOY0yf3LdJ6FIK2DNXFPtv
	 LAJuxvSIOw8s/tyc9Yl8bAeaTRMxSg2wXtK99TYKyEQF25L5vbmUweZ3RUNCInRnQF
	 LqZImkf8dO+8NGI+FWXtyZ8B1DoUKLENjYg37vf5FY9eJ9mxSsuwTjuGvNvHhnGzZp
	 ROz16puH1/qzg==
Date: Fri, 1 Aug 2025 03:25:32 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Alex Elder <elder@riscstar.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH RESEND v3 2/2] clk: spacemit: fix sspax_clk
Message-ID: <aIwzrHKD-GiZ0oFv@ketchup>
References: <20250731-k1-clk-i2s-v3-0-2f655ddb0c6f@linux.spacemit.com>
 <20250731-k1-clk-i2s-v3-2-2f655ddb0c6f@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-k1-clk-i2s-v3-2-2f655ddb0c6f@linux.spacemit.com>

On Thu, Jul 31, 2025 at 10:14:07PM +0800, Troy Mitchell wrote:
> Hardware Requirement:
> When FNCLKSEL in APBC_SSPAX_CLK_RST is set to 7 (3'b111),
> BIT3 must be set to 1 for the SSPAx parent clock to be I2S_BCLK.

The change itself looks good to me. But additionally, maybe it's helpful
to have a comment explaining this, just like twsi8_clk's case.

> This patch introduces SSPAx_I2S_BCLK as a virtual gate to enable BIT3.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Suggested-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/clk/spacemit/ccu-k1.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)

With a comment added, feel free to add my

Reviewed-by: Haylen Chu <heylenay@4d2.org>

Regards,
Haylen Chu

> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> index cdde37a0523537c2f436e481ae8d6ec5a581b87e..24a561499a7c11b6a661c026f0bd2fac28fe7b04 100644
> --- a/drivers/clk/spacemit/ccu-k1.c
> +++ b/drivers/clk/spacemit/ccu-k1.c
> @@ -349,7 +349,10 @@ CCU_GATE_DEFINE(aib_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_AIB_CLK_RST, BIT(1),
>  
>  CCU_GATE_DEFINE(onewire_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_ONEWIRE_CLK_RST, BIT(1), 0);
>  
> -static const struct clk_parent_data sspa_parents[] = {
> +CCU_GATE_DEFINE(sspa0_i2s_bclk, CCU_PARENT_HW(i2s_bclk), APBC_SSPA0_CLK_RST, BIT(3), 0);
> +CCU_GATE_DEFINE(sspa1_i2s_bclk, CCU_PARENT_HW(i2s_bclk), APBC_SSPA1_CLK_RST, BIT(3), 0);
> +
> +static const struct clk_parent_data sspa0_parents[] = {
>  	CCU_PARENT_HW(pll1_d384_6p4),
>  	CCU_PARENT_HW(pll1_d192_12p8),
>  	CCU_PARENT_HW(pll1_d96_25p6),
> @@ -357,10 +360,22 @@ static const struct clk_parent_data sspa_parents[] = {
>  	CCU_PARENT_HW(pll1_d768_3p2),
>  	CCU_PARENT_HW(pll1_d1536_1p6),
>  	CCU_PARENT_HW(pll1_d3072_0p8),
> -	CCU_PARENT_HW(i2s_bclk),
> +	CCU_PARENT_HW(sspa0_i2s_bclk),
>  };
> -CCU_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
> -CCU_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
> +CCU_MUX_GATE_DEFINE(sspa0_clk, sspa0_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
> +
> +static const struct clk_parent_data sspa1_parents[] = {
> +	CCU_PARENT_HW(pll1_d384_6p4),
> +	CCU_PARENT_HW(pll1_d192_12p8),
> +	CCU_PARENT_HW(pll1_d96_25p6),
> +	CCU_PARENT_HW(pll1_d48_51p2),
> +	CCU_PARENT_HW(pll1_d768_3p2),
> +	CCU_PARENT_HW(pll1_d1536_1p6),
> +	CCU_PARENT_HW(pll1_d3072_0p8),
> +	CCU_PARENT_HW(sspa1_i2s_bclk),
> +};
> +CCU_MUX_GATE_DEFINE(sspa1_clk, sspa1_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
> +
>  CCU_GATE_DEFINE(dro_clk, CCU_PARENT_HW(apb_clk), APBC_DRO_CLK_RST, BIT(1), 0);
>  CCU_GATE_DEFINE(ir_clk, CCU_PARENT_HW(apb_clk), APBC_IR_CLK_RST, BIT(1), 0);
>  CCU_GATE_DEFINE(tsen_clk, CCU_PARENT_HW(apb_clk), APBC_TSEN_CLK_RST, BIT(1), 0);
> @@ -965,6 +980,8 @@ static struct clk_hw *k1_ccu_apbc_hws[] = {
>  	[CLK_SSPA1_BUS]		= &sspa1_bus_clk.common.hw,
>  	[CLK_TSEN_BUS]		= &tsen_bus_clk.common.hw,
>  	[CLK_IPC_AP2AUD_BUS]	= &ipc_ap2aud_bus_clk.common.hw,
> +	[CLK_SSPA0_I2S_BCLK]	= &sspa0_i2s_bclk.common.hw,
> +	[CLK_SSPA1_I2S_BCLK]	= &sspa1_i2s_bclk.common.hw,
>  };
>  
>  static const struct spacemit_ccu_data k1_ccu_apbc_data = {
> 
> -- 
> 2.50.0
> 

