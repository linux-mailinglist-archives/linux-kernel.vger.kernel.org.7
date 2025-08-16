Return-Path: <linux-kernel+bounces-771800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C6CB28BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346563A98E6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD38223DF6;
	Sat, 16 Aug 2025 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mAiimklo"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDAD849C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755331321; cv=none; b=SXs57Wjf/bF7hMgg3Mf4ED5jXAvwQ9oKTkF8uaYzAnq0QUlpCFOmwwnTVs4iL6vPeyKxNXKjBJswgR6uFH3mPoQVeryf90w6bP/XRdBe6dYGo+iLwXuLQv9vdBLdzJP8KETgtXsJFTUPSph1OaF9LpGm8Cs7l1xL+co9SYGikRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755331321; c=relaxed/simple;
	bh=xeZB0/MV2mRIdGtensK7l2hpViEnBkI48t/wlVNfDAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twqJYov2zSCgdgikgC2pav6/w2P9GtEVvh7LuEsTyewPEI5tXIK99rmJtffHTsyuMhAca5va2V+VsNH9sJ+d64vyxFuybaEClccXEEHhenQyd4Em06DJFKq1CgLtJYlXcYWVh47hHSsLCsMzF4cAV7+di1uHM7EwE/XHS1jV2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mAiimklo; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 16 Aug 2025 16:01:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755331316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EOo8GB7o2DUvLMEWO0WKIusOz/pycPiItGuieZ5F3Os=;
	b=mAiimklowZnC4ncMq5D5aWLLDUqkRnWsS0Zb8uiLFJk6xsZlYeQwpzLnQlJLWAvu5qZPZZ
	hApNxZdJ7X7JaX91swUNSvOpWLb5HikunvI7RwMKSSQs5HXU41sqIy4nt1GNQIa3dpCLEb
	l8jepjAqxubbQp6bzKtRojk+3g2IF6g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Icenowy Zheng <uwu@icenowy.me>, Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH 2/2] clk: thead: th1520-ap: fix parent of padctrl0 clock
Message-ID: <aKA64Xj-2GCCVRgg@troy-wujie14pro-arch>
References: <20250813171136.2213309-1-uwu@icenowy.me>
 <20250813171136.2213309-3-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813171136.2213309-3-uwu@icenowy.me>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 01:11:36AM +0800, Icenowy Zheng wrote:
> The padctrl0 clock seems to be a child of the perisys_apb4_hclk clock,
> gating the later makes padctrl0 registers stuck too.
> 
> Fix this relationship.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  drivers/clk/thead/clk-th1520-ap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
With fixing what Drew said, feel free to add:

Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
> 
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> index d08e7fb387e50..f6f3d63d53353 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -888,13 +888,16 @@ static CCU_GATE(CLK_PERISYS_APB3_HCLK, perisys_apb3_hclk, "perisys-apb3-hclk", p
>  		0x150, 11, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk, "perisys-apb4-hclk", perisys_ahb_hclk_pd,
>  		0x150, 12, 0);
> +static const struct clk_parent_data perisys_apb4_hclk_pd[] = {
> +	{ .hw = &perisys_apb4_hclk.gate.hw },
> +};
>  static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, 5, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, 13, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", emmc_sdio_ref_clk_pd, 0x204, 30, 0);
>  static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd, 0x204, 26, 0);
>  static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1", perisys_apb_pclk_pd, 0x204, 24, 0);
>  static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart", perisys_apb_pclk_pd, 0x204, 23, 0);
> -static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb_pclk_pd, 0x204, 22, 0);
> +static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb4_hclk_pd, 0x204, 22, 0);
>  static CCU_GATE(CLK_GMAC_AXI, gmac_axi_clk, "gmac-axi", axi4_cpusys2_aclk_pd, 0x204, 21, 0);
>  static CCU_GATE(CLK_GPIO3, gpio3_clk, "gpio3-clk", peri2sys_apb_pclk_pd, 0x204, 20, 0);
>  static CCU_GATE(CLK_GMAC0, gmac0_clk, "gmac0", gmac_pll_clk_pd, 0x204, 19, 0);
> -- 
> 2.50.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

