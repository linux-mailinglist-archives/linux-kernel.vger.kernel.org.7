Return-Path: <linux-kernel+bounces-803216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB3BB45C43
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888805E0CF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CED225761;
	Fri,  5 Sep 2025 15:14:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DFE31B824;
	Fri,  5 Sep 2025 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085265; cv=none; b=FOlVFguixHDRm8JrSi5CtHHInyHaB5ia2aowmStKxeG1BQ5C+tzpOZ6xOiT0kIHect7VbrRZOKgy5naG8pt0LtNN4U/gNWJ8QZtnA9qi0D/JE81BOpcLcFokgDOoejsHFY3uSnox+gbh4g2PLK4XYM/XOixN+UfUk3TQNIrDstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085265; c=relaxed/simple;
	bh=BG2k1oDsnnhcNwGuKMXzIg8UPUKmN0Mer2rlo4LnUV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0Kxd81IYbjUrvE3GavbW8tvrdjCS39GCoxz9rGwc56278fKofx8DLGbH71CdPvYH5qu7RBoJXISK34ix/yOMTlB684EBu+D70t91ss6folXGxkWbaM2DNa/z6mhTaeGaGBSpvMmbOBbNvZOn8g1S6F7HNJvB+cH9q/pK+FRfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E228F152B;
	Fri,  5 Sep 2025 08:14:13 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D9693F6A8;
	Fri,  5 Sep 2025 08:14:20 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:14:18 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, Samuel
 Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] clk: sunxi-ng: sun55i-a523-ccu: Add missing NPU
 module clock
Message-ID: <20250905161418.30562637@donnerap>
In-Reply-To: <20250830170901.1996227-5-wens@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
	<20250830170901.1996227-5-wens@kernel.org>
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

On Sun, 31 Aug 2025 01:08:57 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi,

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The main clock controller on the A523/T527 has the NPU's module clock.
> It was missing from the original submission, likely because that was
> based on the A523 user manual; the A523 is marketed without the NPU.

Ah, sorry, I missed that one. I think I spotted writable bits in that
register, but didn't find a clue what this clock was about. Anyway, checked
the bits against the T527 manual, they match up.

> Also, merge the private header back into the driver code itself. The
> header only contains a macro containing the total number of clocks.
> This has to be updated every time a missing clock gets added. Having
> it in a separate file doesn't help the process. Instead just drop the
> macro, and thus the header no longer has any reason to exist.

Interesting, looks nice, and solves Krzysztof's complaint the other
day about the binding header inclusion missing from the driver as well.
Just one thought:

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 21 ++++++++++++++++++---
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.h | 14 --------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
>  delete mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> index 1a9a1cb869e2..88405b624dc5 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> @@ -11,6 +11,9 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> +#include <dt-bindings/clock/sun55i-a523-ccu.h>
> +#include <dt-bindings/reset/sun55i-a523-ccu.h>
> +

Should we have the number #define here, at a more central location? Seems a
bit buried down in there. And then use a plural name while at it:

#define NUM_CLOCKS	CLK_NPU + 1

Alternatively, put .num behind .hws below, so that the last clock and the
number definition are close together?

Cheers,
Andre

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
> @@ -1343,7 +1357,7 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
>  };
>  
>  static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
> -	.num	= CLK_NUMBER,
> +	.num	= CLK_NPU + 1,
>  	.hws	= {
>  		[CLK_PLL_DDR0]		= &pll_ddr_clk.common.hw,
>  		[CLK_PLL_PERIPH0_4X]	= &pll_periph0_4x_clk.common.hw,
> @@ -1524,6 +1538,7 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
>  		[CLK_FANOUT0]		= &fanout0_clk.common.hw,
>  		[CLK_FANOUT1]		= &fanout1_clk.common.hw,
>  		[CLK_FANOUT2]		= &fanout2_clk.common.hw,
> +		[CLK_NPU]		= &npu_clk.common.hw,
>  	},
>  };
>  
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


