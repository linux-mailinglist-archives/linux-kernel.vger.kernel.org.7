Return-Path: <linux-kernel+bounces-804523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF750B478BF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 05:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 497524E05DD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 03:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC0E1C8606;
	Sun,  7 Sep 2025 03:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DthegXUY"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7A1CD0C;
	Sun,  7 Sep 2025 03:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757214810; cv=none; b=OahqpHpNGG3l+WBET/M16UxzINneaOpLepZ9Hk+CHN+oN1RmuGzQnVcSbX5Q3QwWyO+meuE3oGhHo2wVGm8fQ6VdO3N7xHWA4xaWHSj8X5kSvdyrzE0QIbxC8T5natpeXXH2+One3YpUhIC1jyWSB90+sDIjMa4mcNKhRzAIWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757214810; c=relaxed/simple;
	bh=WGYsmq2i0xQOy0XvkGdIAuosUYWsc2M6BYcU65RZ73c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUSvaSffNAWD6mktBCl27I8wqRqXiY0n/WqNlkqpwEBet1iwUg7VWY/JtEqAtEK19MJ15m/eCvway09MSASmuMAp5mvDoVE1ZWFtksASk47lIMLsnOMWoo9Ca3vNijB40IYero0axxPZLNf2HqkY/+MwJV5btedRi5L/9y5k24k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DthegXUY; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B6C4622B77;
	Sun,  7 Sep 2025 05:13:23 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6xw19dj0dS1S; Sun,  7 Sep 2025 05:13:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757214802; bh=WGYsmq2i0xQOy0XvkGdIAuosUYWsc2M6BYcU65RZ73c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DthegXUYNDDTki8ApBYAUa2vPhPwXv6SnfUh4XeV6DH+2c7F/Cn2o6Aye4bZbhp4v
	 5QBsrYe8xKd2l2MQXFnkR+rP98uroXeGRYH65vG9STp7ar568sX4RRKgTPiTId2aw+
	 YtGJjxWtsQCvRbD7NQLOOrUD/YSYdZHucij07vT+r5NUMz5rqRASBkmUNtX7DuBk98
	 mP71dke9wy9ceg7WNk2iwbmGPWJtKjTf6sESdafQas9/w22TGVDyfPRw0S9D2vfJTV
	 4Ird9s1XBEsxZI4iwcaeZK5K9nXgGwRVDlbRBkqoA9FVH1Kwv1YCdNoj9d/x8++K3o
	 Hh37QYf3VL/yA==
Date: Sun, 7 Sep 2025 03:13:07 +0000
From: Yao Zi <ziyao@disroot.org>
To: Xukai Wang <kingxukai@zohomail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Troy Mitchell <TroyMitchell988@gmail.com>
Subject: Re: [PATCH v8 2/3] clk: canaan: Add clock driver for Canaan K230
Message-ID: <aLz4Q7LZFEfQQGUj@pie>
References: <20250905-b4-k230-clk-v8-0-96caa02d5428@zohomail.com>
 <20250905-b4-k230-clk-v8-2-96caa02d5428@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-b4-k230-clk-v8-2-96caa02d5428@zohomail.com>

> On Fri, Sep 05, 2025 at 11:10:23AM +0800, Xukai Wang wrote:
> This patch provides basic support for the K230 clock, which covers
> all clocks in K230 SoC.
> 
> The clock tree of the K230 SoC consists of a 24MHZ external crystal
> oscillator, PLLs and an external pulse input for timerX, and their
> derived clocks.
> 
> Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
> ---
>  drivers/clk/Kconfig    |    6 +
>  drivers/clk/Makefile   |    1 +
>  drivers/clk/clk-k230.c | 2456 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2463 insertions(+)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 299bc678ed1b9fcd9110bb8c5937a1bd1ea60e23..b597912607a6cc8eabff459a890a1e7353ef9c1d 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -464,6 +464,12 @@ config COMMON_CLK_K210
>  	help
>  	  Support for the Canaan Kendryte K210 RISC-V SoC clocks.
>  
> +config COMMON_CLK_K230
> +	bool "Clock driver for the Canaan Kendryte K230 SoC"
> +	depends on ARCH_CANAAN || COMPILE_TEST
> +	help
> +	  Support for the Canaan Kendryte K230 RISC-V SoC clocks.
> +
>  config COMMON_CLK_SP7021
>  	tristate "Clock driver for Sunplus SP7021 SoC"
>  	depends on SOC_SP7021 || COMPILE_TEST
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index fb8878a5d7d93da6bec487460cdf63f1f764a431..5df50b1e14c701ed38397bfb257db26e8dd278b8 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_MACH_ASPEED_G6)		+= clk-ast2600.o
>  obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
>  obj-$(CONFIG_CLK_HSDK)			+= clk-hsdk-pll.o
>  obj-$(CONFIG_COMMON_CLK_K210)		+= clk-k210.o
> +obj-$(CONFIG_COMMON_CLK_K230)		+= clk-k230.o
>  obj-$(CONFIG_LMK04832)			+= clk-lmk04832.o
>  obj-$(CONFIG_COMMON_CLK_LAN966X)	+= clk-lan966x.o
>  obj-$(CONFIG_COMMON_CLK_LOCHNAGAR)	+= clk-lochnagar.o
> diff --git a/drivers/clk/clk-k230.c b/drivers/clk/clk-k230.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2ba74c008b30ae3400acbd8c08550e8315dfe205
> --- /dev/null
> +++ b/drivers/clk/clk-k230.c
> @@ -0,0 +1,2456 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Kendryte Canaan K230 Clock Drivers
> + *
> + * Author: Xukai Wang <kingxukai@zohomail.com>
> + * Author: Troy Mitchell <troymitchell988@gmail.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +
> +#include <dt-bindings/clock/canaan,k230-clk.h>
> +
> +/* PLL control register bits. */
> +#define K230_PLL_BYPASS_ENABLE			BIT(19)
> +#define K230_PLL_GATE_ENABLE			BIT(2)
> +#define K230_PLL_GATE_WRITE_ENABLE		BIT(18)
> +#define K230_PLL_OD_SHIFT			24
> +#define K230_PLL_OD_MASK			0xF
> +#define K230_PLL_R_SHIFT			16
> +#define K230_PLL_R_MASK				0x3F
> +#define K230_PLL_F_SHIFT			0
> +#define K230_PLL_F_MASK				0x1FFF
> +#define K230_PLL_DIV_REG_OFFSET			0x00
> +#define K230_PLL_BYPASS_REG_OFFSET		0x04
> +#define K230_PLL_GATE_REG_OFFSET		0x08
> +#define K230_PLL_LOCK_REG_OFFSET		0x0C

Maybe FIELD_PREP() and FIELD_GET() would help for the PLL-related
rountines, and you could get avoid of writing shifts and masks by hand.

...

> +struct k230_clk_rate_self {
> +	struct clk_hw	hw;
> +	void __iomem	*reg;
> +	bool		read_only;

Isn't a read-only multiplier, divider or something capable of both a
simple fixed-factor hardware? If so please switch to the existing clock
hardware, instead of introducing a field in description of rate clocks.

It's worth noting that you've already had at least one fixed-rate clock
(shrm_sram_div2).

> +	u32		write_enable_bit;
> +	u32		mul_min;
> +	u32		mul_max;
> +	u32		mul_shift;
> +	u32		mul_mask;
> +	u32		div_min;
> +	u32		div_max;
> +	u32		div_shift;
> +	u32		div_mask;
> +	/* ensures mutual exclusion for concurrent register access. */
> +	spinlock_t	*lock;
> +};

...

> +static int k230_clk_find_approximate_mul_div(u32 mul_min, u32 mul_max,
> +					     u32 div_min, u32 div_max,
> +					     unsigned long rate,
> +					     unsigned long parent_rate,
> +					     u32 *div, u32 *mul)
> +{
> +	long abs_min;
> +	long abs_current;
> +	long perfect_divide;
> +
> +	if (!rate || !parent_rate || !mul_min)
> +		return -EINVAL;
> +
> +	perfect_divide = (long)((parent_rate * 1000) / rate);
> +	abs_min = abs(perfect_divide -
> +		     (long)(((long)div_max * 1000) / (long)mul_min));
> +
> +	*div = div_max;
> +	*mul = mul_min;
> +
> +	for (u32 i = div_max - 1; i >= div_min; i--) {
> +		for (u32 j = mul_min + 1; j <= mul_max; j++) {
> +			abs_current = abs(perfect_divide -
> +					 (long)(((long)i * 1000) / (long)j));
> +
> +			if (abs_min > abs_current) {
> +				abs_min = abs_current;
> +				*div = i;
> +				*mul = j;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

This looks like a poor version of rational_best_approximation(). Could
you please consider switching to it?

> +static int k230_clk_set_rate_mul(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long parent_rate)
> +{
> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
> +	struct k230_clk_rate_self *rate_self = &clk->clk;
> +	u32 div, mul, mul_reg;
> +
> +	if (rate > parent_rate)
> +		return -EINVAL;
> +
> +	if (rate_self->read_only)
> +		return 0;
> +
> +	if (k230_clk_find_approximate_mul(rate_self->mul_min, rate_self->mul_max,
> +					  rate_self->div_min, rate_self->div_max,
> +					  rate, parent_rate, &div, &mul))
> +		return -EINVAL;
> +
> +	guard(spinlock)(rate_self->lock);
> +
> +	mul_reg = readl(rate_self->reg + clk->mul_reg_off);
> +	mul_reg |= ((mul - 1) & rate_self->mul_mask) << (rate_self->mul_shift);
> +	mul_reg |= BIT(rate_self->write_enable_bit);
> +	writel(mul_reg, rate_self->reg + clk->mul_reg_off);
> +
> +	return 0;
> +}
> +
> +static int k230_clk_set_rate_div(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long parent_rate)
> +{
> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
> +	struct k230_clk_rate_self *rate_self = &clk->clk;
> +	u32 div, mul, div_reg;
> +
> +	if (rate > parent_rate)
> +		return -EINVAL;
> +
> +	if (rate_self->read_only)
> +		return 0;
> +
> +	if (k230_clk_find_approximate_div(rate_self->mul_min, rate_self->mul_max,
> +					  rate_self->div_min, rate_self->div_max,
> +					  rate, parent_rate, &div, &mul))
> +		return -EINVAL;
> +
> +	guard(spinlock)(rate_self->lock);
> +
> +	div_reg = readl(rate_self->reg + clk->div_reg_off);
> +	div_reg |= ((div - 1) & rate_self->div_mask) << (rate_self->div_shift);
> +	div_reg |= BIT(rate_self->write_enable_bit);
> +	writel(div_reg, rate_self->reg + clk->div_reg_off);
> +
> +	return 0;
> +}
> +
> +static int k230_clk_set_rate_mul_div(struct clk_hw *hw, unsigned long rate,
> +				     unsigned long parent_rate)
> +{
> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
> +	struct k230_clk_rate_self *rate_self = &clk->clk;
> +	u32 div, mul, div_reg, mul_reg;
> +
> +	if (rate > parent_rate)
> +		return -EINVAL;
> +
> +	if (rate_self->read_only)
> +		return 0;
> +
> +	if (k230_clk_find_approximate_mul_div(rate_self->mul_min, rate_self->mul_max,
> +					      rate_self->div_min, rate_self->div_max,
> +					      rate, parent_rate, &div, &mul))
> +		return -EINVAL;
> +
> +	guard(spinlock)(rate_self->lock);
> +
> +	div_reg = readl(rate_self->reg + clk->div_reg_off);
> +	div_reg |= ((div - 1) & rate_self->div_mask) << (rate_self->div_shift);
> +	div_reg |= BIT(rate_self->write_enable_bit);
> +	writel(div_reg, rate_self->reg + clk->div_reg_off);
> +
> +	mul_reg = readl(rate_self->reg + clk->mul_reg_off);
> +	mul_reg |= ((mul - 1) & rate_self->mul_mask) << (rate_self->mul_shift);
> +	mul_reg |= BIT(rate_self->write_enable_bit);
> +	writel(mul_reg, rate_self->reg + clk->mul_reg_off);
> +
> +	return 0;
> +}

There are three variants of rate clocks, mul-only, div-only and mul-div
ones, which are similar to clk-multiplier, clk-divider,
clk-fractional-divider.

The only difference is to setup new parameters for K230's rate clocks,
a register bit, described as k230_clk_rate_self.write_enable_bit, must
be set first.

What do you think of introducing support for such "write enable bit" to
the generic implementation of multipler/divider/fractional? Then you
could reuse the generic implementation in K230's driver, avoiding code
duplication.

...

> +static const struct of_device_id k230_clk_ids[] = {
> +	{ .compatible = "canaan,k230-clk" },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, k230_clk_ids);

MODULE_DEVICE_TABLE is unnecessary if your driver couldn't be built as
a module.

> +static struct platform_driver k230_clk_driver = {
> +	.driver = {
> +		.name = "k230_clock_controller",
> +		.of_match_table = k230_clk_ids,
> +	},
> +	.probe = k230_clk_probe,
> +};
> +builtin_platform_driver(k230_clk_driver);

Best regards,
Yao Zi

