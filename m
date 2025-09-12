Return-Path: <linux-kernel+bounces-813692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F99B5498A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419BA48120D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF362EAB85;
	Fri, 12 Sep 2025 10:19:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA92EA737;
	Fri, 12 Sep 2025 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672386; cv=none; b=VlftYUSR4e4yVfetFiJatcagfvnHsER11tfWBAiqchW4fdU3xbUS7HIxMs6V/cuylrfhk9HxFju1D1w2kGzSEwmKvc4do4zKPSx1bhGRcJODikcn2lHIXoSrY/MGHCu7tzBgqqkFc1zolTIVGJjaIpLvZeclKiBM3jHX5yHzrLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672386; c=relaxed/simple;
	bh=80VD8j953rabZpdH+qBSUDke5/D1/YIn00wR201HN5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgTOgAkI/D0HMCwphOKuNrpnzrQHJK/Y4jiQ6nauHOHbCyHa4bEMwCOKmLfqjyF6eRMVvf/BPUYEE9nCfu4zFoqHnSMg8sVjyB7gedSbnsdjC2RUKNdRNEyQwpTIzBc+AeEJHLj6OYNCejqPcSwjf6FBasUHWgTgb4gbARpcEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E3F616A3;
	Fri, 12 Sep 2025 03:19:36 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B5E53F66E;
	Fri, 12 Sep 2025 03:19:42 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:19:40 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] clk: sunxi-ng: sun55i-a523-ccu: Add missing NPU
 module clock
Message-ID: <20250912111940.61f87a3e@donnerap>
In-Reply-To: <20250911174710.3149589-4-wens@kernel.org>
References: <20250911174710.3149589-1-wens@kernel.org>
	<20250911174710.3149589-4-wens@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 01:47:06 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The main clock controller on the A523/T527 has the NPU's module clock.
> It was missing from the original submission, likely because that was
> based on the A523 user manual; the A523 is marketed without the NPU.
> 
> Also, merge the private header back into the driver code itself. The
> header only contains a macro containing the total number of clocks.
> This has to be updated every time a missing clock gets added. Having
> it in a separate file doesn't help the process. Instead just drop the
> macro, and thus the header no longer has any reason to exist.
> 
> Also move the .num value to after the list of clks to make it obvious
> that it should be updated when new clks are added.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks for the change!

Cheers,
Andre

> ---
> Changes since v1:
> - Move .num to after list of clks
> ---
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 21 ++++++++++++++++++---
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.h | 14 --------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
>  delete mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> index 1a9a1cb869e2..acb532f8361b 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> @@ -11,6 +11,9 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> +#include <dt-bindings/clock/sun55i-a523-ccu.h>
> +#include <dt-bindings/reset/sun55i-a523-ccu.h>
> +
>  #include "../clk.h"
>  
>  #include "ccu_common.h"
> @@ -25,8 +28,6 @@
>  #include "ccu_nkmp.h"
>  #include "ccu_nm.h"
>  
> -#include "ccu-sun55i-a523.h"
> -
>  /*
>   * The 24 MHz oscillator, the root of most of the clock tree.
>   * .fw_name is the string used in the DT "clock-names" property, used to
> @@ -486,6 +487,18 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_clk, "ve", ve_parents, 0x690,
>  
>  static SUNXI_CCU_GATE_HWS(bus_ve_clk, "bus-ve", ahb_hws, 0x69c, BIT(0), 0);
>  
> +static const struct clk_hw *npu_parents[] = {
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_periph0_600M_clk.hw,
> +	&pll_periph0_800M_clk.common.hw,
> +	&pll_npu_2x_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(npu_clk, "npu", npu_parents, 0x6e0,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
>  static SUNXI_CCU_GATE_HWS(bus_dma_clk, "bus-dma", ahb_hws, 0x70c, BIT(0), 0);
>  
>  static SUNXI_CCU_GATE_HWS(bus_msgbox_clk, "bus-msgbox", ahb_hws, 0x71c,
> @@ -1217,6 +1230,7 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
>  	&bus_ce_sys_clk.common,
>  	&ve_clk.common,
>  	&bus_ve_clk.common,
> +	&npu_clk.common,
>  	&bus_dma_clk.common,
>  	&bus_msgbox_clk.common,
>  	&bus_spinlock_clk.common,
> @@ -1343,7 +1357,6 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
>  };
>  
>  static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
> -	.num	= CLK_NUMBER,
>  	.hws	= {
>  		[CLK_PLL_DDR0]		= &pll_ddr_clk.common.hw,
>  		[CLK_PLL_PERIPH0_4X]	= &pll_periph0_4x_clk.common.hw,
> @@ -1524,7 +1537,9 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
>  		[CLK_FANOUT0]		= &fanout0_clk.common.hw,
>  		[CLK_FANOUT1]		= &fanout1_clk.common.hw,
>  		[CLK_FANOUT2]		= &fanout2_clk.common.hw,
> +		[CLK_NPU]		= &npu_clk.common.hw,
>  	},
> +	.num	= CLK_NPU + 1,
>  };
>  
>  static struct ccu_reset_map sun55i_a523_ccu_resets[] = {
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.h b/drivers/clk/sunxi-ng/ccu-sun55i-a523.h
> deleted file mode 100644
> index fc8dd42f1b47..000000000000
> --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.h
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright 2024 Arm Ltd.
> - */
> -
> -#ifndef _CCU_SUN55I_A523_H
> -#define _CCU_SUN55I_A523_H
> -
> -#include <dt-bindings/clock/sun55i-a523-ccu.h>
> -#include <dt-bindings/reset/sun55i-a523-ccu.h>
> -
> -#define CLK_NUMBER	(CLK_FANOUT2 + 1)
> -
> -#endif /* _CCU_SUN55I_A523_H */


