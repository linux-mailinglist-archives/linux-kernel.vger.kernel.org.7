Return-Path: <linux-kernel+bounces-771559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD09B288E8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E277BAFA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A15F2D4B65;
	Fri, 15 Aug 2025 23:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjKM+RrD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686EE2D3727;
	Fri, 15 Aug 2025 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301504; cv=none; b=k5z8aar58j7nzZeCZy+ikPHCkaIUe6XQSjOkWNim6+sKR810jiaKygpLr7j7RWtMZ7xYchd1JjRvFBwNU6ne0jyMGBscZJfICkiexF34+g+CtlKqUMlE9lDoeNfNRWmEYEJOAUox8WuoMgHxSkTdjnN2S5MhCgjDlLA/G05T3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301504; c=relaxed/simple;
	bh=PmcBMUQVb7YUhAvAzMDl9UseO4hrrR3ph0w6p79xwlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtqciWVjgxqv+nacW2/SNAq7xGkHXCPadZf7AxfTm+JdZzelnPnCU4ewF7Y8l/pZFBM2FGmGB3m3mX0ksn0khk01tSpKLkYJapeOURbO2/pYGcRx+hMyXzKOKJ11IK0o4kaT74HTqlRkuLw3Ow5l3QV+lT6zFAjftqe3WWGzhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjKM+RrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8341C4CEEB;
	Fri, 15 Aug 2025 23:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755301503;
	bh=PmcBMUQVb7YUhAvAzMDl9UseO4hrrR3ph0w6p79xwlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjKM+RrD0htfrl3ryPG7UBplETzrOIHPabW/sMTd6k1OBSHoq7M/aM+JYITLHQRma
	 fVtLCabVsDEJGQH112zivFtuVbNagpD3qy7MV+EGVH9W4lQ6tTOUJ5N/e5kTlkDMNs
	 dRJ9VOcKtmZPcipyz+Eb49/Mq0cpqqdmu2wnpTpcdvOKStyup1PwPkibFzl7KU3OUO
	 7PfURkhmTtbQTu3Ntn+DR0WMhCtNzSgDPOcQBYqC4WwZvN4Alm2ZvM3/I/U8wSd9Ja
	 4K1xhfgaCZejxkA8BSY984mGxPOTpgA/GU0CKsTC0+PzBazsyEcXAdVZk6+WMjuMoG
	 YTOOFMN20l8JA==
Date: Fri, 15 Aug 2025 16:45:02 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: thead: th1520-ap: fix parent of padctrl0 clock
Message-ID: <aJ/GfmLjU/K4FJOM@x1>
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

Nit: when I run checkpatch on the whole file, it warns that there should
be a blank line after function/struct/union/enum declarations. Probably
best to insert a new line here.

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

Aside from that nit:

Reviewed-by: Drew Fustini <fustini@kernel.org>

