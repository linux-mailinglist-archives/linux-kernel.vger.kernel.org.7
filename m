Return-Path: <linux-kernel+bounces-769979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564B7B2759B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A90FA257D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBCF2989B5;
	Fri, 15 Aug 2025 02:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="jRZgONT5"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4390B1922FA;
	Fri, 15 Aug 2025 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224604; cv=none; b=uxjj24h18JKPdFoH3BLLxpk56pGwPySEG0450VOSfmGLXXnl+fSW1kuyfctDpOLXFLjaMhnUCWkOPMJY6cACWLiTb7wqpjgmIW0NwXeSgu4nqzUiOrbymdQrQTWo1Qf95Nq09I2j9Dng/7usYP0fCVKRztMbms6cf+xD1zm9SIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224604; c=relaxed/simple;
	bh=XruUVYyoFszbeJGWSb3rZHzycGQGngep9xPazeWgbMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg55mn59Ar//2Xy/fJfM6SfjTicvnJvjXhcZmHENQ5P6d4RDRKOc0WhkgQ6k/Tgk04j5UvHhTIbs+MyafQxJppA2n7xPAM6QeutrMELMDVoc54UXUc1b1FoUUhUE0MzljlWHwyB6BlXUtLmEnf5qwX9e90Qu6ZsvzGqfnc2gT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=jRZgONT5; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755224594;
	bh=Niaj4OMwo4W2fUafjFNulcdi+Nlm7R7eM7SD6asWCMs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=jRZgONT5a/yyaF4bL4Tr6GJbw7bbNi6SfF8jagTU6NUGls0wvnbllyaP/H5atOc41
	 D0ujqqEcTL6p65sFLo7SP8fRTqr5EJ9h2NlrXEXgtIWIzAp69p/BJmpjn4cPmTbOxA
	 5tne02m3/g2lB1eMaWmnd5QurHDUthcdhnAthXzM=
X-QQ-mid: zesmtpgz7t1755224593t961c5431
X-QQ-Originating-IP: 9mkEVNaVfiiSECCslKxiFqq//seDD1r4T4Oyt/0nWFw=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 10:23:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14240890600098775965
EX-QQ-RecipientCnt: 13
Date: Fri, 15 Aug 2025 10:23:12 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Icenowy Zheng <uwu@icenowy.me>, Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v2 2/3] clk: thead: support changing DPU pixel clock rate
Message-ID: <B226CDDA4BC5D173+aJ6aEPwUqM91jnLv@LT-Guozexi>
References: <20250813072702.2176993-1-uwu@icenowy.me>
 <20250813072702.2176993-3-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813072702.2176993-3-uwu@icenowy.me>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MV3nwXc78CnhQWAZy3cypx8a4zJ++TjPzIyWj/FVGrLqXHir0ddWBLIW
	MYf/gd3OZClEo0fqa50QReXZOkXIIhkttngqZ57QV1b4an7xBa/cOMEgPeAoWAlLS2x97J2
	w8MgStQiLabAPj+GnCbkz745juSlrsPvr3n2VqWU3FbdVnKZh8SJRulBjo4NcD39oXFIKb3
	Urkrc63FLdyoxvC2lCXZfPcEDs/Sc9XPw6Gh5V+B4jdr3ymLHJeBs1xZE+FA3Oakhb/6BbM
	s7oJJhk1TUbZndRrJI/MXOp7eNWUGfIZ7iXsefv0AfoVXIzHiK0xleKtXfrOBAkmL5zcFPj
	HBQ7DgCdsmZUdggojpdfA52kNFG5f+hcgg7JL26ZXOFtjPhA+FE/kGi4cIShfGkhAvEg0dn
	8zFtQptCFKQHKN/maSVOCBw3TZLUVJhLqPfmCVFp3Hzqw7/DYcdCvflHDo4jcOIMzZ7pfrp
	e9pEam8t2WNewk/ZNONAFv6hsZdLdTqAKZu/0xAZySvK5kAlsEb7aH0eSkZ8H2UbvqhbyzC
	wXNNHqLFKejnLiaFccp3aMmMu27MkkrP4fDE7fhEYpD5UasvrHREU+wGkl/NPtdrXXjGm8B
	WrmJc7KH6Yxx1L2H/j05dMCKwdgO3Rh8qqJUxHTDoGezC/gZ7TtTG9w2SHOkrifpbxpNJC0
	ciJZDzBWWbzHQBZO+mhb5bT3ygQ/cAG4m8o1RWaUfumrmiXuR1Vp+IuUlK028Q4yK8/ypEu
	J3OaUs8qhIjC05A8xT2/3SIq5Imyzxq1/A3MnN4Yi9JXwwNwQiX6C2Gfryr656l6umxgdtV
	YgZcCBI2umDqv5PHe9AiilJN2sSmvmHcIwBa9JxfAXj5Fpe7WltyZItqFKqlGkrjafQgiQa
	f42dV7BTAJEuPnbExxxFiTnmi+sQKJ+AAMaIinzc6lw473fClye68vWH0ziqUD8yJb6mJLK
	E0sxexc36NeifHdBCNOZsT6wgA4xODT+dE8NzA8GjmuVlXyWD9Lj1myVKM25CbTeG/0LTLV
	wkVisR2Y+FFaGBqD3taVpIAWrcsHk+6L9je/hZOdaxr5hNPL2XLP4NMF33Ul6ofX+fLQL8Y
	g==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Wed, Aug 13, 2025 at 03:27:01PM +0800, Icenowy Zheng wrote:
> The DPU pixel clock rate corresponds to the required dot clock of the
> display mode, so it needs to be tweakable.
> 
> Add support to change it, by adding generic divider setting code,
> arming the code to the dpu0/dpu1 clocks, and setting the pixel clock
> connected to the DPU (after a gate) to CLK_SET_RATE_PARENT to propagate
> it to the dividers.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> Changes in v2:
> - Dropped round_rate() because of deprecation.
> - Changed the logic of determine_rate() to early return if the divider
>   could be changed.
> 
>  drivers/clk/thead/clk-th1520-ap.c | 64 ++++++++++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> index 0b5458af8c550..b220a8ed22607 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -55,6 +55,7 @@ struct ccu_gate {
>  
...
> +static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +				      unsigned long parent_rate)
> +{
> +	struct ccu_div *cd = hw_to_ccu_div(hw);
> +	int val = divider_get_val(rate, parent_rate, NULL,
> +				  cd->div.width, cd->div.flags);
> +	unsigned int curr_val, reg_val;
> +
> +	if (val < 0)
> +		return val;
> +
> +	regmap_read(cd->common.map, cd->common.cfg0, &reg_val);
> +	curr_val = reg_val;
uh? remove this line.

                - Troy

> +	curr_val = curr_val >> cd->div.shift;
> +	curr_val &= GENMASK(cd->div.width - 1, 0);
> +
> +	if (!cd->div_en && curr_val != val)
> +		return -EINVAL;
> +
> +	reg_val &= ~cd->div_en;
> +	regmap_write(cd->common.map, cd->common.cfg0, reg_val);
> +	udelay(1);
> +
> +	reg_val &= ~GENMASK(cd->div.width + cd->div.shift - 1, cd->div.shift);
> +	reg_val |= val << cd->div.shift;
> +	regmap_write(cd->common.map, cd->common.cfg0, reg_val);
> +
> +	reg_val |= cd->div_en;
> +	regmap_write(cd->common.map, cd->common.cfg0, reg_val);
> +
> +	return 0;
> +}
> +
>  static u8 ccu_div_get_parent(struct clk_hw *hw)
>  {
>  	struct ccu_div *cd = hw_to_ccu_div(hw);
> @@ -240,7 +291,8 @@ static const struct clk_ops ccu_div_ops = {
>  	.get_parent	= ccu_div_get_parent,
>  	.set_parent	= ccu_div_set_parent,
>  	.recalc_rate	= ccu_div_recalc_rate,
> -	.determine_rate	= clk_hw_determine_rate_no_reparent,
> +	.set_rate	= ccu_div_set_rate,
> +	.determine_rate = ccu_div_determine_rate,
>  };
>  
>  static void ccu_pll_disable(struct clk_hw *hw)
> @@ -784,6 +836,7 @@ static struct ccu_div venc_clk = {
>  };
>  
>  static struct ccu_div dpu0_clk = {
> +	.div_en		= BIT(8),
>  	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
>  	.common		= {
>  		.clkid          = CLK_DPU0,
> @@ -791,7 +844,7 @@ static struct ccu_div dpu0_clk = {
>  		.hw.init	= CLK_HW_INIT_PARENTS_HW("dpu0",
>  					      dpu0_pll_clk_parent,
>  					      &ccu_div_ops,
> -					      0),
> +					      CLK_SET_RATE_UNGATE),
>  	},
>  };
>  
> @@ -800,6 +853,7 @@ static const struct clk_parent_data dpu0_clk_pd[] = {
>  };
>  
>  static struct ccu_div dpu1_clk = {
> +	.div_en		= BIT(8),
>  	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
>  	.common		= {
>  		.clkid          = CLK_DPU1,
> @@ -807,7 +861,7 @@ static struct ccu_div dpu1_clk = {
>  		.hw.init	= CLK_HW_INIT_PARENTS_HW("dpu1",
>  					      dpu1_pll_clk_parent,
>  					      &ccu_div_ops,
> -					      0),
> +					      CLK_SET_RATE_UNGATE),
>  	},
>  };
>  
> @@ -891,9 +945,9 @@ static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
>  static CCU_GATE(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
>  		video_pll_clk_pd, 0x0, BIT(4), 0);
>  static CCU_GATE(CLK_DPU_PIXELCLK0, dpu0_pixelclk, "dpu0-pixelclk",
> -		dpu0_clk_pd, 0x0, BIT(5), 0);
> +		dpu0_clk_pd, 0x0, BIT(5), CLK_SET_RATE_PARENT);
>  static CCU_GATE(CLK_DPU_PIXELCLK1, dpu1_pixelclk, "dpu1-pixelclk",
> -		dpu1_clk_pd, 0x0, BIT(6), 0);
> +		dpu1_clk_pd, 0x0, BIT(6), CLK_SET_RATE_PARENT);
>  static CCU_GATE(CLK_DPU_HCLK, dpu_hclk, "dpu-hclk", video_pll_clk_pd, 0x0,
>  		BIT(7), 0);
>  static CCU_GATE(CLK_DPU_ACLK, dpu_aclk, "dpu-aclk", video_pll_clk_pd, 0x0,
> -- 
> 2.50.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

