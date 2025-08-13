Return-Path: <linux-kernel+bounces-765768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8651B23E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84386562072
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B2E1B6CE9;
	Wed, 13 Aug 2025 02:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="DiLovhk3"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18096249E5;
	Wed, 13 Aug 2025 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755050833; cv=none; b=huzu8qRcCFIm3ZafyircuN4G7zOv2pzPDEU5Kofsh1t5XMgoo4UyAE+2lnBrEm3VhKTgP45U4vgUDF6ukvyMedjyf5yX9rHAREqt2DdQe5beO7MdX2ryIW/ciyrWb85uy9yMz8PucZrbiFa+80NQlPi1Bpaj5F7vVpv+2uglNGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755050833; c=relaxed/simple;
	bh=d6UdtNNuZaZ6bamfAHn8ybRPEHHUxUxuKOvOGDD16Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyqFEewGNEzO3yR9NUY2AtOwdzyOFgiY+NSFPPvgL8ztFAHY+6YcFhNZm0xY/ic+hhmvg210HUgOD//bVDXzaaepqkJ0hy0PLZA6WOJbbd7vbjbY/OZVakAM0H3InfmU/dYYTWbGUIvnLZrO1dKYK6/YKXmmUQGkjR3TmiNPI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=DiLovhk3; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755050666;
	bh=ZnyIiSbiRujF2YLZ0WQOHqhpmTla+FMTYfJUDVo3fOM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=DiLovhk38v2dePx200QeDQJddeXOYY/5O2HtGNH37P2+8NfVdSAVjQ78CqKOfSu4c
	 BWBxD1/UsK9vOEboHbI6Ue1z/WaceLzoZMzAtsRG9Iyltbz/l2FGVH/o1BeEGKjCZR
	 OHiNxNMv//3SELNncDsz9USSC1GMlU8HhouIXEo4=
X-QQ-mid: esmtpgz10t1755050657taffb3d78
X-QQ-Originating-IP: jJ6yvrAGhILmpgoimcz/SSjmuoT5NvuhLbgu+tpbQwA=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 10:04:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2947607227310690052
EX-QQ-RecipientCnt: 11
Date: Wed, 13 Aug 2025 10:04:16 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Icenowy Zheng <uwu@icenowy.me>, Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 2/4] clk: thead: support changing DPU pixel clock rate
Message-ID: <17A2B2E9749103E7+aJvyoBfDZRzbFM_b@LT-Guozexi>
References: <20250812054258.1968351-1-uwu@icenowy.me>
 <20250812054258.1968351-3-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812054258.1968351-3-uwu@icenowy.me>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MwQdfXoP8nuzNQhFR1XlhqZ6exU9J3FHn0e02e8UI3DUE7xoOXSHdacD
	0g+xL9PVWzKW++rnG7sT4yR9nqTmkER1vdhvN/190Ef/NlZ8b06gobg0xyibHL5TnSSWgP0
	4cbsbzOoXhlEJJ5/fu1bx2pm9zNinnaD4Cp31kGhthfTocNGDMr5c8v+fQpew0hdQ1QYcGZ
	2Ge0i34QwRWR71LsyzUGA51HAfWiqaRzpeepPQXHw7zfBl7mOjtkxUIua+T4TlYX2JUF6Lh
	i+x4oyq/IyiP2Rdex8NU2BFb1eHr5QwJHVDItMIZH8svV5zAYfLjLTYBHXmzIOfptQS/0pn
	tcoKxrUTtNyfqW5w4HaRIU9mQ+lopPCm4R8/tD96qDOeIC/O5P89KlIgA7Ahja9xiHVYiWc
	2tEuZsd43ZqQJlBQwSLILlKEMbHU41vO7FDH080xT0b74KfpJbcsxl2pxH9mATBWAO2uuRZ
	+B78va+U3X8C3XZD4D5QFQEKDpvLkf6iyxZmny3h1vGSr5BTOxwITXFhPk5Vb/OsmTCuZaQ
	c1gHnagdICWZaRihiOW/XcpxWIVHIaCu7lN+/kL/Bl8L+Vy/jq0Syl8YiF6TveZ/QOcOjXw
	0i7FI/p1SmTj7CIWUlO32H8sNYc1M+n6eSAVyLLfdcbEnmsZvINcOj6949wOaSC9S2XQitc
	vGabJe+IOnkgcWnJNulDBsjzMKMV7//6BhRTUYqM9uxMc/Z0pOV59SwCS90MyW72oNSvkNf
	H4lTpv04PeNFypFQ8G5lkYAvuy4jTsjV0MyURUpUEjZ0ZKDExklVP5c2Tb+HUyUeHJ2axfK
	XPyVcBAr+VLqm4QuS9LhmE30vODSCEXEeJYZkOKRHpKiDJmfp3h8IvwnfAS69golhRmXZpa
	hQk2dwj81fS36W9XQ+oGZF2ba4H1KBMza5P1kJ2+Ge/FXERkADkucgSYji4Vz8ZlZ6I7oeH
	5n0+fI0jVxfE8/CWCO7YMzdjmL1YBx9Qwo/5nnxbLNVawGsZYUTvpSFx4Mh73grRaP0jm52
	uZyEUHzojlU1gR1qUHtCuvH8pdzuV6npTRqW07Xl//I5Nuw1bP
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 01:42:56PM +0800, Icenowy Zheng wrote:
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
>  drivers/clk/thead/clk-th1520-ap.c | 87 +++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> index 2f87c7c2c3baf..3e81f3051cd6c 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -55,6 +55,7 @@ struct ccu_gate {
>  
>  struct ccu_div {
>  	u32			enable;
> +	u32			div_en;
>  	struct ccu_div_internal	div;
>  	struct ccu_internal	mux;
>  	struct ccu_common	common;
> @@ -198,6 +199,78 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
>  	return rate;
>  }
>  
> +static long ccu_div_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *parent_rate)
> +{
> +	struct ccu_div *cd = hw_to_ccu_div(hw);
> +	unsigned int val;
> +
> +	if (!cd->div_en) {
> +		regmap_read(cd->common.map, cd->common.cfg0, &val);
> +		val = val >> cd->div.shift;
> +		val &= GENMASK(cd->div.width - 1, 0);
> +		return divider_ro_round_rate(hw, rate, parent_rate,
> +					     NULL, cd->div.width, cd->div.flags,
> +					     val);
> +	} else {
> +		return divider_round_rate(hw, rate, parent_rate,
> +					  NULL, cd->div.width, cd->div.flags);
> +	}
How about this:
```
if (cd->div_en)
  return divider_round_rate(hw, rate, parent_rate,
          NULL, cd->div.width, cd->div.flags);


regmap_read(cd->common.map, cd->common.cfg0, &val);
val = val >> cd->div.shift;
val &= GENMASK(cd->div.width - 1, 0);
return divider_ro_round_rate(hw, rate, parent_rate,
			     NULL, cd->div.width, cd->div.flags,
			     val);
```
  
> +}
> +
> +static int ccu_div_determine_rate(struct clk_hw *hw,
> +				  struct clk_rate_request *req)
> +{
> +	struct ccu_div *cd = hw_to_ccu_div(hw);
> +	unsigned int val;
> +
> +	if (!cd->div_en) {
> +		regmap_read(cd->common.map, cd->common.cfg0, &val);
> +		val = val >> cd->div.shift;
> +		val &= GENMASK(cd->div.width - 1, 0);
> +		return divider_ro_determine_rate(hw, req, NULL,
> +						 cd->div.width,
> +						 cd->div.flags,
> +						 val);
> +	} else {
> +		return divider_determine_rate(hw, req, NULL,
> +					      cd->div.width, cd->div.flags);
ditto.

> +	}
> +}
> +
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
> @@ -240,7 +313,9 @@ static const struct clk_ops ccu_div_ops = {
>  	.get_parent	= ccu_div_get_parent,
>  	.set_parent	= ccu_div_set_parent,
>  	.recalc_rate	= ccu_div_recalc_rate,
> -	.determine_rate	= clk_hw_determine_rate_no_reparent,
> +	.round_rate	= ccu_div_round_rate,
> +	.set_rate	= ccu_div_set_rate,
> +	.determine_rate = ccu_div_determine_rate,
>  };
>  
>  static void ccu_pll_disable(struct clk_hw *hw)
> @@ -784,6 +859,7 @@ static struct ccu_div venc_clk = {
>  };
>  
>  static struct ccu_div dpu0_clk = {
> +	.div_en		= BIT(8),
>  	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
>  	.common		= {
>  		.clkid          = CLK_DPU0,
> @@ -791,7 +867,7 @@ static struct ccu_div dpu0_clk = {
>  		.hw.init	= CLK_HW_INIT_PARENTS_HW("dpu0",
>  					      dpu0_pll_clk_parent,
>  					      &ccu_div_ops,
> -					      0),
> +					      CLK_SET_RATE_UNGATE),
>  	},
>  };
>  
> @@ -800,6 +876,7 @@ static const struct clk_parent_data dpu0_clk_pd[] = {
>  };
>  
>  static struct ccu_div dpu1_clk = {
> +	.div_en		= BIT(8),
>  	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
>  	.common		= {
>  		.clkid          = CLK_DPU1,
> @@ -807,7 +884,7 @@ static struct ccu_div dpu1_clk = {
>  		.hw.init	= CLK_HW_INIT_PARENTS_HW("dpu1",
>  					      dpu1_pll_clk_parent,
>  					      &ccu_div_ops,
> -					      0),
> +					      CLK_SET_RATE_UNGATE),
>  	},
>  };
>  
> @@ -891,9 +968,9 @@ static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
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

