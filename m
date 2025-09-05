Return-Path: <linux-kernel+bounces-803217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD2B45C3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C67188534E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B07731B81B;
	Fri,  5 Sep 2025 15:14:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC54C98;
	Fri,  5 Sep 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085275; cv=none; b=Ar5DDMOk40eRN8jmqfSjc2zScRTvJOFK95vTXvInXd4v523D7resD/6n6bFdZJ6kQGh58325lXQmq6/j0Clu9tuc5O79wqNr/IoPL4+w7xh97RWI+1tLuvOSg5L6sq9EloL5wYaav8bq14tyw21hdKlSmBvVHJpqK/WkSGITXHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085275; c=relaxed/simple;
	bh=PPcCgTIVutmSIZ2EVfaCPGztu+vqDvWxO32SaYZJe/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DW7nzHhh5ke44t+IopoFhlOoN8qFOlESFNs71AV6q1BxtrMVaimCwN79OspT1NhUuFmfge67bjZcU9Z2tNvjo0r7Y6c4MLljiifKjH174HwhSRdNIbo6Ew/cqMPnPUNePDzuq+KnoJqEiElryPzoaFyAFR+PrjAIrjBxe4zTCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A2E6152B;
	Fri,  5 Sep 2025 08:14:24 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE32A3F6A8;
	Fri,  5 Sep 2025 08:14:30 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:14:28 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, Samuel
 Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] clk: sunxi-ng: add support for the A523/T527 MCU
 CCU
Message-ID: <20250905161428.7747729e@donnerap>
In-Reply-To: <20250830170901.1996227-7-wens@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
 <20250830170901.1996227-7-wens@kernel.org>
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

On Sun, 31 Aug 2025 01:08:59 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi Chen-Yu,

many thanks for this patch, I feel with you when it comes to model
Allwinner CCUs in the kernel ;-)

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The A523/T527 SoCs have a new MCU PRCM, which has more clocks and reset
> controls for the RISC-V MCU and other peripherals. There is no visible
> bus in this part, but there is a second audio PLL. The BSP driver uses
> the 24MHz main oscillator as the parent for all the bus clocks.

So my copy of the T527 manual (v0.92) shows the system but tree of the
MCU_PRCM in figure 2-24, and there some peripherals are on AHB_DEC0, while
others are on APBS0. Shall we model this correctly, then?

> Add a driver to support this part. Unlike the BSP driver, the SoC's main
> MBUS clock is chosen as the parent for the MCU MBUS clock, and the
> latter then serves as the parent of the MCU DMA controller's MBUS clock.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi-ng/Kconfig               |   5 +
>  drivers/clk/sunxi-ng/Makefile              |   2 +
>  drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c | 447 +++++++++++++++++++++
>  3 files changed, 454 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c
> 
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 8896fd052ef1..6af2d020e03e 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -57,6 +57,11 @@ config SUN55I_A523_CCU
>  	default ARCH_SUNXI
>  	depends on ARM64 || COMPILE_TEST
>  
> +config SUN55I_A523_MCU_CCU
> +	tristate "Support for the Allwinner A523/T527 MCU CCU"
> +	default ARCH_SUNXI
> +	depends on ARM64 || COMPILE_TEST
> +
>  config SUN55I_A523_R_CCU
>  	tristate "Support for the Allwinner A523/T527 PRCM CCU"
>  	default ARCH_SUNXI
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 82e471036de6..a1c4087d7241 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_SUN50I_H6_CCU)	+= sun50i-h6-ccu.o
>  obj-$(CONFIG_SUN50I_H6_R_CCU)	+= sun50i-h6-r-ccu.o
>  obj-$(CONFIG_SUN50I_H616_CCU)	+= sun50i-h616-ccu.o
>  obj-$(CONFIG_SUN55I_A523_CCU)	+= sun55i-a523-ccu.o
> +obj-$(CONFIG_SUN55I_A523_MCU_CCU)	+= sun55i-a523-mcu-ccu.o
>  obj-$(CONFIG_SUN55I_A523_R_CCU)	+= sun55i-a523-r-ccu.o
>  obj-$(CONFIG_SUN4I_A10_CCU)	+= sun4i-a10-ccu.o
>  obj-$(CONFIG_SUN5I_CCU)		+= sun5i-ccu.o
> @@ -61,6 +62,7 @@ sun50i-h6-ccu-y			+= ccu-sun50i-h6.o
>  sun50i-h6-r-ccu-y		+= ccu-sun50i-h6-r.o
>  sun50i-h616-ccu-y		+= ccu-sun50i-h616.o
>  sun55i-a523-ccu-y		+= ccu-sun55i-a523.o
> +sun55i-a523-mcu-ccu-y		+= ccu-sun55i-a523-mcu.o
>  sun55i-a523-r-ccu-y		+= ccu-sun55i-a523-r.o
>  sun4i-a10-ccu-y			+= ccu-sun4i-a10.o
>  sun5i-ccu-y			+= ccu-sun5i.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c
> new file mode 100644
> index 000000000000..6105485837c9
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523-mcu.c
> @@ -0,0 +1,447 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Chen-Yu Tsai <wens@csie.org>
> + *
> + * Based on the A523 CCU driver:
> + *   Copyright (C) 2023-2024 Arm Ltd.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/clock/sun55i-a523-mcu-ccu.h>
> +#include <dt-bindings/reset/sun55i-a523-mcu-ccu.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu_div.h"
> +#include "ccu_gate.h"
> +#include "ccu_mp.h"
> +#include "ccu_mult.h"
> +#include "ccu_nm.h"
> +
> +static const struct clk_parent_data osc24M[] = {
> +	{ .fw_name = "hosc" }
> +};
> +
> +#define SUN55I_A523_PLL_AUDIO1_REG	0x00c
> +static struct ccu_sdm_setting pll_audio1_sdm_table[] = {
> +	{ .rate = 2167603200, .pattern = 0xa000a234, .m = 1, .n = 90 }, /* div2->22.5792 */
> +	{ .rate = 2359296000, .pattern = 0xa0009ba6, .m = 1, .n = 98 }, /* div2->24.576 */
> +	{ .rate = 1806336000, .pattern = 0xa000872b, .m = 1, .n = 75 }, /* div5->22.576 */
> +};
> +
> +static struct ccu_nm pll_audio1_clk = {
> +	.enable		= BIT(27),
> +	.lock		= BIT(28),
> +	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		= _SUNXI_CCU_DIV(1, 1),
> +	.sdm		= _SUNXI_CCU_SDM(pll_audio1_sdm_table, BIT(24),
> +					 0x010, BIT(31)),
> +	.min_rate	= 180000000U,
> +	.max_rate	= 3500000000U,
> +	.common		= {
> +		.reg		= 0x00c,
> +		.features	= CCU_FEATURE_SIGMA_DELTA_MOD,
> +		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-audio1",
> +							   osc24M, &ccu_nm_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +static const struct clk_hw *pll_audio1_div_parents[] = { &pll_audio1_clk.common.hw };
> +static CLK_FIXED_FACTOR_HWS(pll_periph1_div2_clk, "pll-audio1-div2",
> +			    pll_audio1_div_parents, 2, 1,
> +			    CLK_SET_RATE_PARENT);

I admit that those "fixed programmable" dividers are odd, but there are
fields in the PLL control register that we should use, so it's not a
fixed divider clock, but a programmable divider, using
SUNXI_CCU_M_HWS().

And I think you want the struct name to contain audio1, not periph1?

> +static CLK_FIXED_FACTOR_HWS(pll_periph1_div5_clk, "pll-audio1-div5",
> +			    pll_audio1_div_parents, 5, 1,
> +			    CLK_SET_RATE_PARENT);

Same here.

> +
> +static SUNXI_CCU_M_WITH_GATE(audio_out_clk, "audio-out",
> +			     "pll-audio1-div2", 0x01c,
> +			     0, 5, BIT(31), CLK_SET_RATE_PARENT);

I wonder if CLK_SET_RATE_PARENT is a good idea here. IIUC, then the
idea would be that the PLL is running at a fixed high rate (3072 MHz),
and gets divided down here to something more audio-y, like 48 or 96 MHz?

Do you have an idea what this clock is supposed to be used for? I
don't see it used anywhere, neither in this series, nor in the manual's
other clock descriptions or even pins.

> +
> +static const struct clk_parent_data dsp_parents[] = {
> +	{ .fw_name = "hosc" },
> +	{ .fw_name = "losc" },
> +	{ .fw_name = "iosc" },
> +	{ .hw = &pll_periph1_div5_clk.hw },
> +	{ .hw = &pll_periph1_div2_clk.hw },

The manual says that parent 0b011 is the DIV2 clock, and 0b100 is the
DIV5 clock, so those lines should be swapped.

> +	{ .fw_name = "dsp" },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(dsp_clk, "mcu-dsp", dsp_parents, 0x0020,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static const struct clk_parent_data i2s_parents[] = {
> +	{ .fw_name = "pll-audio0-4x" },
> +	{ .hw = &pll_periph1_div2_clk.hw },
> +	{ .hw = &pll_periph1_div5_clk.hw },
> +};
> +
> +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s0_clk, "i2s0", i2s_parents, 0x02c,
> +				  0, 5,		/* M */
> +				  5, 5,		/* P */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  CLK_SET_RATE_PARENT);

Same question about CLK_SET_RATE_PARENT here. Does the flag mean that any
rate request is only to be fulfilled by the parent? Couldn't find a good
explanation for that.

> +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s1_clk, "i2s1", i2s_parents, 0x030,
> +				  0, 5,		/* M */
> +				  5, 5,		/* P */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s2_clk, "i2s2", i2s_parents, 0x034,
> +				  0, 5,		/* M */
> +				  5, 5,		/* P */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s3_clk, "i2s3", i2s_parents, 0x038,
> +				  0, 5,		/* M */
> +				  5, 5,		/* P */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  CLK_SET_RATE_PARENT);
> +
> +static const struct clk_parent_data i2s3_asrc_parents[] = {
> +	{ .fw_name = "pll-periph0-300m" },
> +	{ .hw = &pll_periph1_div2_clk.hw },
> +	{ .hw = &pll_periph1_div5_clk.hw },
> +};
> +static SUNXI_CCU_DUALDIV_MUX_GATE(i2s3_asrc_clk, "i2s3-asrc",
> +				  i2s3_asrc_parents, 0x038,

that address should be 0x03c

> +				  0, 5,		/* M */
> +				  5, 5,		/* P */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_GATE_DATA(bus_i2s0_clk, "bus-i2s0", osc24M, 0x040, BIT(0), 0);

My manual says that APBS0 is the bus clock for the I2S peripherals. I
guess another one for the list of "clocks" in the DT binding :-(
This applies to the other bus clocks as well, they should be either APBS0
or AHB(_DEC0?).

> +static SUNXI_CCU_GATE_DATA(bus_i2s1_clk, "bus-i2s1", osc24M, 0x040, BIT(1), 0);
> +static SUNXI_CCU_GATE_DATA(bus_i2s2_clk, "bus-i2s2", osc24M, 0x040, BIT(2), 0);
> +static SUNXI_CCU_GATE_DATA(bus_i2s3_clk, "bus-i2s3", osc24M, 0x040, BIT(3), 0);
> +
> +static const struct clk_parent_data audio_parents[] = {
> +	{ .fw_name = "pll-audio0-4x" },
> +	{ .hw = &pll_periph1_div2_clk.hw },
> +	{ .hw = &pll_periph1_div5_clk.hw },
> +};
> +static SUNXI_CCU_DUALDIV_MUX_GATE(spdif_tx_clk, "spdif-tx",
> +				  audio_parents, 0x044,
> +				  0, 5,		/* M */
> +				  5, 5,		/* P */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_DUALDIV_MUX_GATE(spdif_rx_clk, "spdif-rx",
> +				  i2s3_asrc_parents, 0x048,
> +				  0, 5,		/* M */
> +				  5, 5,		/* P */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_GATE_DATA(bus_spdif_clk, "bus-spdif", osc24M, 0x04c, BIT(0), 0);
> +
> +static SUNXI_CCU_DUALDIV_MUX_GATE(dmic_clk, "dmic", audio_parents, 0x050,
> +				  0, 5,		/* M */
> +				  5, 5,		/* P */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_GATE_DATA(bus_dmic_clk, "bus-dmic", osc24M, 0x054, BIT(0), 0);
> +
> +static SUNXI_CCU_DUALDIV_MUX_GATE(audio_dac_clk, "audio-dac",
> +				  audio_parents, 0x058,
> +				  0, 5,		/* M */
> +				  5, 5,		/* P */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  CLK_SET_RATE_PARENT);
> +static SUNXI_CCU_DUALDIV_MUX_GATE(audio_adc_clk, "audio-adc",
> +				  audio_parents, 0x05c,
> +				  0, 5,		/* M */
> +				  5, 5,		/* P */
> +				  24, 3,	/* mux */
> +				  BIT(31),	/* gate */
> +				  CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_GATE_DATA(bus_audio_codec_clk, "bus-audio-codec",
> +			   osc24M, 0x060, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_DATA(bus_dsp_msgbox_clk, "bus-dsp-msgbox",
> +			   osc24M, 0x068, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(bus_dsp_cfg_clk, "bus-dsp-cfg",
> +			   osc24M, 0x06c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_DATA(bus_npu_hclk, "bus-npu-hclk", osc24M, 0x070, BIT(1), 0);
> +static SUNXI_CCU_GATE_DATA(bus_npu_aclk, "bus-npu-aclk", osc24M, 0x070, BIT(2), 0);
> +
> +static const struct clk_parent_data timer_parents[] = {
> +	{ .fw_name = "hosc" },
> +	{ .fw_name = "losc" },
> +	{ .fw_name = "iosc" },
> +	{ .fw_name = "r-ahb" }
> +};
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer0_clk, "mcu-timer0", timer_parents,
> +				      0x074,
> +				      1, 3,	/* P */
> +				      4, 2,	/* mux */
> +				      BIT(0),	/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer1_clk, "mcu-timer1", timer_parents,
> +				      0x078,
> +				      1, 3,	/* P */
> +				      4, 2,	/* mux */
> +				      BIT(0),	/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer2_clk, "mcu-timer2", timer_parents,
> +				      0x07c,
> +				      1, 3,	/* P */
> +				      4, 2,	/* mux */
> +				      BIT(0),	/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer3_clk, "mcu-timer3", timer_parents,
> +				      0x080,
> +				      1, 3,	/* P */
> +				      4, 2,	/* mux */
> +				      BIT(0),	/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer4_clk, "mcu-timer4", timer_parents,
> +				      0x084,
> +				      1, 3,	/* P */
> +				      4, 2,	/* mux */
> +				      BIT(0),	/* gate */
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(mcu_timer5_clk, "mcu-timer5", timer_parents,
> +				      0x088,
> +				      1, 3,	/* P */
> +				      4, 2,	/* mux */
> +				      BIT(0),	/* gate */
> +				      0);
> +static SUNXI_CCU_GATE_DATA(bus_mcu_timer_clk, "bus-mcu-timer", osc24M, 0x08c, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(bus_mcu_dma_clk, "bus-mcu-dma", osc24M, 0x104, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(tzma0_clk, "tzma0", osc24M, 0x108, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(tzma1_clk, "tzma1", osc24M, 0x10c, BIT(0), 0);

Where did you find those two? I guess in the BSP code? Can you maybe add a
comment about it then?

> +static SUNXI_CCU_GATE_DATA(bus_pubsram_clk, "bus-pubsram", osc24M, 0x114, BIT(0), 0);
> +
> +/*
> + * user manual has "mbus" clock as parent of both clocks below,
> + * but this makes more sense, since BSP MCU DMA controller has
> + * reference to both of them, likely needing both enabled.
> + */
> +static SUNXI_CCU_GATE_FW(mbus_mcu_clk, "mbus-mcu", "mbus", 0x11c, BIT(1), 0);
> +static SUNXI_CCU_GATE_HW(mbus_mcu_dma_clk, "mbus-mcu-dma",
> +			 &mbus_mcu_clk.common.hw, 0x11c, BIT(0), 0);
> +
> +static const struct clk_parent_data riscv_pwm_parents[] = {

Where does the pwm part come from? Is the clock below actually the RISC-V
PWM clock? Which would make more sense, since I don't see a PLL or any
other fast clock in there.

> +	{ .fw_name = "hosc" },
> +	{ .fw_name = "losc" },
> +	{ .fw_name = "iosc" },
> +};
> +
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(riscv_clk, "riscv",

Related to above: what RISC-V clock is this exactly? Is that some PWM
clock source, as the parents name suggests, or the main clock, which looks
rather slow then? Or is that to select the root of the RISC-V clock tree?

> +				    riscv_pwm_parents, 0x120,
> +				    27, 3, BIT(31), 0);
> +static SUNXI_CCU_GATE_DATA(bus_riscv_cfg_clk, "bus-riscv-cfg", osc24M,
> +			   0x124, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(bus_riscv_msgbox_clk, "bus-riscv-msgbox", osc24M,
> +			   0x128, BIT(0), 0);
> +
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(mcu_pwmmcu0_clk, "mcu-pwm0",
> +				    riscv_pwm_parents, 0x130,
> +				    27, 3, BIT(31), 0);

The mux fields for this clock start at bit 24.

> +static SUNXI_CCU_GATE_DATA(bus_mcu_pwm0_clk, "bus-mcu-pwm0", osc24M,
> +			   0x128, BIT(0), 0);

The register offset is 0x134.

> +
> +/*
> + * Contains all clocks that are controlled by a hardware register. They
> + * have a (sunxi) .common member, which needs to be initialised by the common
> + * sunxi CCU code, to be filled with the MMIO base address and the shared lock.
> + */
> +static struct ccu_common *sun55i_a523_mcu_ccu_clks[] = {
> +	&pll_audio1_clk.common,
> +	&audio_out_clk.common,
> +	&dsp_clk.common,
> +	&i2s0_clk.common,
> +	&i2s1_clk.common,
> +	&i2s2_clk.common,
> +	&i2s3_clk.common,
> +	&i2s3_asrc_clk.common,
> +	&bus_i2s0_clk.common,
> +	&bus_i2s1_clk.common,
> +	&bus_i2s2_clk.common,
> +	&bus_i2s3_clk.common,
> +	&spdif_tx_clk.common,
> +	&spdif_rx_clk.common,
> +	&bus_spdif_clk.common,
> +	&dmic_clk.common,
> +	&bus_dmic_clk.common,
> +	&audio_dac_clk.common,
> +	&audio_adc_clk.common,
> +	&bus_audio_codec_clk.common,
> +	&bus_dsp_msgbox_clk.common,
> +	&bus_dsp_cfg_clk.common,
> +	&bus_npu_aclk.common,
> +	&bus_npu_hclk.common,
> +	&mcu_timer0_clk.common,
> +	&mcu_timer1_clk.common,
> +	&mcu_timer2_clk.common,
> +	&mcu_timer3_clk.common,
> +	&mcu_timer4_clk.common,
> +	&mcu_timer5_clk.common,
> +	&bus_mcu_timer_clk.common,
> +	&bus_mcu_dma_clk.common,
> +	&tzma0_clk.common,
> +	&tzma1_clk.common,
> +	&bus_pubsram_clk.common,
> +	&mbus_mcu_dma_clk.common,
> +	&mbus_mcu_clk.common,
> +	&riscv_clk.common,
> +	&bus_riscv_cfg_clk.common,
> +	&bus_riscv_msgbox_clk.common,
> +	&mcu_pwm0_clk.common,
> +	&bus_mcu_pwm0_clk.common,
> +};
> +
> +static struct clk_hw_onecell_data sun55i_a523_mcu_hw_clks = {
> +	.num	= CLK_BUS_MCU_PWM0 + 1,

like of the NPU patch, can we use ".num = NUM_CLOCKS," here, and
#define NUM_CLOCKS at the beginning of the file, right after including the
binding headers?
Or alternatively, put .num after the .hws definitions, so that last clock
and number are closer together?

> +	.hws	= {
> +		[CLK_MCU_PLL_AUDIO1]		= &pll_audio1_clk.common.hw,
> +		[CLK_MCU_PLL_AUDIO1_DIV2]	= &pll_periph1_div2_clk.hw,
> +		[CLK_MCU_PLL_AUDIO1_DIV5]	= &pll_periph1_div5_clk.hw,
> +		[CLK_MCU_AUDIO_OUT]		= &audio_out_clk.common.hw,
> +		[CLK_MCU_DSP]			= &dsp_clk.common.hw,
> +		[CLK_MCU_I2S0]			= &i2s0_clk.common.hw,
> +		[CLK_MCU_I2S1]			= &i2s1_clk.common.hw,
> +		[CLK_MCU_I2S2]			= &i2s2_clk.common.hw,
> +		[CLK_MCU_I2S3]			= &i2s3_clk.common.hw,
> +		[CLK_MCU_I2S3_ASRC]		= &i2s3_asrc_clk.common.hw,
> +		[CLK_BUS_MCU_I2S0]		= &bus_i2s0_clk.common.hw,
> +		[CLK_BUS_MCU_I2S1]		= &bus_i2s1_clk.common.hw,
> +		[CLK_BUS_MCU_I2S2]		= &bus_i2s2_clk.common.hw,
> +		[CLK_BUS_MCU_I2S3]		= &bus_i2s3_clk.common.hw,
> +		[CLK_MCU_SPDIF_TX]		= &spdif_tx_clk.common.hw,
> +		[CLK_MCU_SPDIF_RX]		= &spdif_rx_clk.common.hw,
> +		[CLK_BUS_MCU_SPDIF]		= &bus_spdif_clk.common.hw,
> +		[CLK_MCU_DMIC]			= &dmic_clk.common.hw,
> +		[CLK_BUS_MCU_DMIC]		= &bus_dmic_clk.common.hw,
> +		[CLK_MCU_AUDIO_CODEC_DAC]	= &audio_dac_clk.common.hw,
> +		[CLK_MCU_AUDIO_CODEC_ADC]	= &audio_adc_clk.common.hw,
> +		[CLK_BUS_MCU_AUDIO_CODEC]	= &bus_audio_codec_clk.common.hw,
> +		[CLK_BUS_MCU_DSP_MSGBOX]	= &bus_dsp_msgbox_clk.common.hw,
> +		[CLK_BUS_MCU_DSP_CFG]		= &bus_dsp_cfg_clk.common.hw,
> +		[CLK_BUS_MCU_NPU_HCLK]		= &bus_npu_hclk.common.hw,
> +		[CLK_BUS_MCU_NPU_ACLK]		= &bus_npu_aclk.common.hw,
> +		[CLK_MCU_TIMER0]		= &mcu_timer0_clk.common.hw,
> +		[CLK_MCU_TIMER1]		= &mcu_timer1_clk.common.hw,
> +		[CLK_MCU_TIMER2]		= &mcu_timer2_clk.common.hw,
> +		[CLK_MCU_TIMER3]		= &mcu_timer3_clk.common.hw,
> +		[CLK_MCU_TIMER4]		= &mcu_timer4_clk.common.hw,
> +		[CLK_MCU_TIMER5]		= &mcu_timer5_clk.common.hw,
> +		[CLK_BUS_MCU_TIMER]		= &bus_mcu_timer_clk.common.hw,
> +		[CLK_BUS_MCU_DMA]		= &bus_mcu_dma_clk.common.hw,
> +		[CLK_MCU_TZMA0]			= &tzma0_clk.common.hw,
> +		[CLK_MCU_TZMA1]			= &tzma1_clk.common.hw,
> +		[CLK_BUS_MCU_PUBSRAM]		= &bus_pubsram_clk.common.hw,
> +		[CLK_MCU_MBUS_DMA]		= &mbus_mcu_dma_clk.common.hw,
> +		[CLK_MCU_MBUS]			= &mbus_mcu_clk.common.hw,
> +		[CLK_MCU_RISCV]			= &riscv_clk.common.hw,
> +		[CLK_BUS_MCU_RISCV_CFG]		= &bus_riscv_cfg_clk.common.hw,
> +		[CLK_BUS_MCU_RISCV_MSGBOX]	= &bus_riscv_msgbox_clk.common.hw,
> +		[CLK_MCU_PWM0]			= &mcu_pwm0_clk.common.hw,
> +		[CLK_BUS_MCU_PWM0]		= &bus_mcu_pwm0_clk.common.hw,
> +	},
> +};
> +
> +static struct ccu_reset_map sun55i_a523_mcu_ccu_resets[] = {
> +	[RST_BUS_MCU_I2S0]		= { 0x0040, BIT(16) },
> +	[RST_BUS_MCU_I2S1]		= { 0x0040, BIT(17) },
> +	[RST_BUS_MCU_I2S2]		= { 0x0040, BIT(18) },
> +	[RST_BUS_MCU_I2S3]		= { 0x0040, BIT(19) },
> +	[RST_BUS_MCU_SPDIF]		= { 0x004c, BIT(16) },
> +	[RST_BUS_MCU_DMIC]		= { 0x0054, BIT(16) },
> +	[RST_BUS_MCU_AUDIO_CODEC]	= { 0x0060, BIT(16) },
> +	[RST_BUS_MCU_DSP_MSGBOX]	= { 0x0068, BIT(16) },
> +	[RST_BUS_MCU_DSP_CFG]		= { 0x006c, BIT(16) },
> +	[RST_BUS_MCU_NPU]		= { 0x0070, BIT(16) },
> +	[RST_BUS_MCU_TIMER]		= { 0x008c, BIT(16) },
> +	[RST_BUS_MCU_DSP_DEBUG]		= { 0x0100, BIT(16) },
> +	[RST_BUS_MCU_DSP]		= { 0x0100, BIT(17) },

I don't see those two in the manual.

> +	[RST_BUS_MCU_DMA]		= { 0x0104, BIT(16) },
> +	[RST_BUS_MCU_PUBSRAM]		= { 0x0114, BIT(16) },

The manual shows a reset bit in register 0x120, in the same register as
this ominous riscv_clk above.

> +	[RST_BUS_MCU_RISCV_CFG]		= { 0x0124, BIT(16) },
> +	[RST_BUS_MCU_RISCV_DEBUG]	= { 0x0124, BIT(17) },
> +	[RST_BUS_MCU_RISCV_CORE]	= { 0x0124, BIT(18) },
> +	[RST_BUS_MCU_RISCV_MSGBOX]	= { 0x0128, BIT(16) },

There is a reset bit for the PWM0 clock in the manual, register 0x130,
same as the mcu_pwmmcu0_clk above.


> +	[RST_BUS_MCU_PWM0]		= { 0x0134, BIT(16) },

Verified that all of the names defined in the binding headers appear here,
and all definitions here are mentioned in the binding headers.

> +};
> +
> +static const struct sunxi_ccu_desc sun55i_a523_mcu_ccu_desc = {
> +	.ccu_clks	= sun55i_a523_mcu_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun55i_a523_mcu_ccu_clks),
> +
> +	.hw_clks	= &sun55i_a523_mcu_hw_clks,
> +
> +	.resets		= sun55i_a523_mcu_ccu_resets,
> +	.num_resets	= ARRAY_SIZE(sun55i_a523_mcu_ccu_resets),
> +};
> +
> +static int sun55i_a523_mcu_ccu_probe(struct platform_device *pdev)
> +{
> +	void __iomem *reg;
> +	u32 val;
> +	int ret;
> +
> +	reg = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +
> +	val = readl(reg + SUN55I_A523_PLL_AUDIO1_REG);
> +
> +	/*
> +	 * The PLL clock code does not model all bits, for instance it does
> +	 * not support a separate enable and gate bit. We present the
> +	 * gate bit(27) as the enable bit, but then have to set the
> +	 * PLL Enable, LDO Enable, and Lock Enable bits on all PLLs here.
> +	 */
> +	val |= BIT(31) | BIT(30) | BIT(29);
> +
> +	/* Enforce p1 = 5, p0 = 2 (the default) for PLL_AUDIO1 */
> +	val &= ~(GENMASK(22, 20) | GENMASK(18, 16));
> +	val |= (4 << 20) | (1 << 16);

Ah, I see, here you set those fixed dividers. I still think we should
model them properly, as suggested above.

Cheers,
Andre

> +
> +	writel(val, reg + SUN55I_A523_PLL_AUDIO1_REG);
> +
> +	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun55i_a523_mcu_ccu_desc);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sun55i_a523_mcu_ccu_ids[] = {
> +	{ .compatible = "allwinner,sun55i-a523-mcu-ccu" },
> +	{ }
> +};
> +
> +static struct platform_driver sun55i_a523_mcu_ccu_driver = {
> +	.probe	= sun55i_a523_mcu_ccu_probe,
> +	.driver	= {
> +		.name			= "sun55i-a523-mcu-ccu",
> +		.suppress_bind_attrs	= true,
> +		.of_match_table		= sun55i_a523_mcu_ccu_ids,
> +	},
> +};
> +module_platform_driver(sun55i_a523_mcu_ccu_driver);
> +
> +MODULE_IMPORT_NS("SUNXI_CCU");
> +MODULE_DESCRIPTION("Support for the Allwinner A523 MCU CCU");
> +MODULE_LICENSE("GPL");


