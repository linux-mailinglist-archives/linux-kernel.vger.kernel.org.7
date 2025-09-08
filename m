Return-Path: <linux-kernel+bounces-806026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD038B490F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B06C16A17C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D781A2E92D9;
	Mon,  8 Sep 2025 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="fAzFDKRW"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1A2FDC53;
	Mon,  8 Sep 2025 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340839; cv=pass; b=tQSRRIB2x5QbTGy/FfNr388eoxLsFMtcQkMdqcsJTMhGBtjn+f8lbq5c4iDLMnaS6KAgBfBKlI8DgXn3cKbRzi+n7qRkcbSGIji//53Do7+PbOHYAVlAQDLgm30/YjDMLp5vvwbhVImUBZmWiVoib7hnH6h1oX6ETydFEq+uRzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340839; c=relaxed/simple;
	bh=1L4kJL3UJUTzEDDNFNP7ZgGEfdrGBGYl9Q/dHHEvhMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYMbS2Jwz3omWEmIW0MjgLi5C1FIOXm8+WSRXgIx2nde5osJBGRBTmZ357nfTVcEJBfRTy3LqN0RtVN++jJ9aNuHfMtIy9Ic8Ewaw2ClRXbTCTpV1sZlyalkNdX55UzOZP+RIzBEQ/Lqt69YUJQgvE/xui2PiaORGSTpknTkpak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=fAzFDKRW; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1757340821; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HY1W1rb3UWJjXA4GWgwrCg3WFkQYKp1HxUYChOQp3hLHVwQmGlreUJ7mJwoAZN9IWGGGMSS58l6BY4O88C8jkfzlujM0PWICCdBvDCM1UIKSB4FViavBd39KBrBvC+G6MdoKUdRCyyAziCEkOG0c4p8kmE15p8+mw3IOSckdVh8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757340821; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D7dn87T1Q/YhXyIChz9la9EUN9N/WrqpB+mjFuCaq8M=; 
	b=oCoF7sKbhb1bY8MBY26jtyvrM6IKx3Ifx1TrBY7xQuB2JAJ6TafPnxd+q/Vb1CCBq0PqC93uAVaVf8KseSDKeU1CZGnHf3sTQ6x8MGy87EqZTn8144CIREu2l3Ls+jWsN1o/ukf3QbJYLS5z6fB1+YCKIwzifeDT0GqEObu3w8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757340821;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=D7dn87T1Q/YhXyIChz9la9EUN9N/WrqpB+mjFuCaq8M=;
	b=fAzFDKRW67DZIKvriEmeGKwNktUD9kT8p1+18uMw43hFU0ZWUgF7va0Aom3vwjPl
	xOqPlSXBITAEhLbBU4WtsKg+6bmDMldmi2bPZNOe3JSYE4n4GjXrEBM8p2ppjOiEcS1
	PGR9TQ0WJBjxwZoXYMSBpU/FHgseaGM9t+eznWVo=
Received: by mx.zohomail.com with SMTPS id 1757340814629883.3802401714803;
	Mon, 8 Sep 2025 07:13:34 -0700 (PDT)
Message-ID: <0947d9cc-86ba-46e0-92aa-04f4714e7a20@zohomail.com>
Date: Mon, 8 Sep 2025 22:13:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] clk: canaan: Add clock driver for Canaan K230
To: Yao Zi <ziyao@disroot.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>
References: <20250905-b4-k230-clk-v8-0-96caa02d5428@zohomail.com>
 <20250905-b4-k230-clk-v8-2-96caa02d5428@zohomail.com> <aLz4Q7LZFEfQQGUj@pie>
From: Xukai Wang <kingxukai@zohomail.com>
Content-Language: en-US
In-Reply-To: <aLz4Q7LZFEfQQGUj@pie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227f7ec689b3a1cc24ae91973f30000be427d4c8078f809808da5614982b6ab992c7250b1278ceefc:zu08011227438f7af4f083e7026300f4d400000fbe94f06e0793af23973735d85f8d1e64b7706faea7ad9aad:rf0801122c56cc4189672bcef28f1e80d3000043dc8331194374bd3027e2bf5ba8e1559fece2c3849fc43722bf23cf923e:ZohoMail
X-ZohoMailClient: External


On 2025/9/7 11:13, Yao Zi wrote:
>> On Fri, Sep 05, 2025 at 11:10:23AM +0800, Xukai Wang wrote:
>> This patch provides basic support for the K230 clock, which covers
>> all clocks in K230 SoC.
>>
>> The clock tree of the K230 SoC consists of a 24MHZ external crystal
>> oscillator, PLLs and an external pulse input for timerX, and their
>> derived clocks.
>>
>> Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
>> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
>> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
>> ---
>>  drivers/clk/Kconfig    |    6 +
>>  drivers/clk/Makefile   |    1 +
>>  drivers/clk/clk-k230.c | 2456 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 2463 insertions(+)
>>
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index 299bc678ed1b9fcd9110bb8c5937a1bd1ea60e23..b597912607a6cc8eabff459a890a1e7353ef9c1d 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -464,6 +464,12 @@ config COMMON_CLK_K210
>>  	help
>>  	  Support for the Canaan Kendryte K210 RISC-V SoC clocks.
>>  
>> +config COMMON_CLK_K230
>> +	bool "Clock driver for the Canaan Kendryte K230 SoC"
>> +	depends on ARCH_CANAAN || COMPILE_TEST
>> +	help
>> +	  Support for the Canaan Kendryte K230 RISC-V SoC clocks.
>> +
>>  config COMMON_CLK_SP7021
>>  	tristate "Clock driver for Sunplus SP7021 SoC"
>>  	depends on SOC_SP7021 || COMPILE_TEST
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index fb8878a5d7d93da6bec487460cdf63f1f764a431..5df50b1e14c701ed38397bfb257db26e8dd278b8 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -51,6 +51,7 @@ obj-$(CONFIG_MACH_ASPEED_G6)		+= clk-ast2600.o
>>  obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
>>  obj-$(CONFIG_CLK_HSDK)			+= clk-hsdk-pll.o
>>  obj-$(CONFIG_COMMON_CLK_K210)		+= clk-k210.o
>> +obj-$(CONFIG_COMMON_CLK_K230)		+= clk-k230.o
>>  obj-$(CONFIG_LMK04832)			+= clk-lmk04832.o
>>  obj-$(CONFIG_COMMON_CLK_LAN966X)	+= clk-lan966x.o
>>  obj-$(CONFIG_COMMON_CLK_LOCHNAGAR)	+= clk-lochnagar.o
>> diff --git a/drivers/clk/clk-k230.c b/drivers/clk/clk-k230.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..2ba74c008b30ae3400acbd8c08550e8315dfe205
>> --- /dev/null
>> +++ b/drivers/clk/clk-k230.c
>> @@ -0,0 +1,2456 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Kendryte Canaan K230 Clock Drivers
>> + *
>> + * Author: Xukai Wang <kingxukai@zohomail.com>
>> + * Author: Troy Mitchell <troymitchell988@gmail.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +
>> +#include <dt-bindings/clock/canaan,k230-clk.h>
>> +
>> +/* PLL control register bits. */
>> +#define K230_PLL_BYPASS_ENABLE			BIT(19)
>> +#define K230_PLL_GATE_ENABLE			BIT(2)
>> +#define K230_PLL_GATE_WRITE_ENABLE		BIT(18)
>> +#define K230_PLL_OD_SHIFT			24
>> +#define K230_PLL_OD_MASK			0xF
>> +#define K230_PLL_R_SHIFT			16
>> +#define K230_PLL_R_MASK				0x3F
>> +#define K230_PLL_F_SHIFT			0
>> +#define K230_PLL_F_MASK				0x1FFF
>> +#define K230_PLL_DIV_REG_OFFSET			0x00
>> +#define K230_PLL_BYPASS_REG_OFFSET		0x04
>> +#define K230_PLL_GATE_REG_OFFSET		0x08
>> +#define K230_PLL_LOCK_REG_OFFSET		0x0C
> Maybe FIELD_PREP() and FIELD_GET() would help for the PLL-related
> rountines, and you could get avoid of writing shifts and masks by hand.
OK, I've already replaced the manual shifts and masks with GENMASK() and
FIELD_GET().
>
> ...
>
>> +struct k230_clk_rate_self {
>> +	struct clk_hw	hw;
>> +	void __iomem	*reg;
>> +	bool		read_only;
> Isn't a read-only multiplier, divider or something capable of both a
> simple fixed-factor hardware?
You're right. None of the rate clocks are read-only, so this flag is
unnecessary and should be removed.
> If so please switch to the existing clock
> hardware, instead of introducing a field in description of rate clocks.
>
> It's worth noting that you've already had at least one fixed-ra te clock
> (shrm_sram_div2).

>
>> +	u32		write_enable_bit;
>> +	u32		mul_min;
>> +	u32		mul_max;
>> +	u32		mul_shift;
>> +	u32		mul_mask;
>> +	u32		div_min;
>> +	u32		div_max;
>> +	u32		div_shift;
>> +	u32		div_mask;
>> +	/* ensures mutual exclusion for concurrent register access. */
>> +	spinlock_t	*lock;
>> +};
> ...
>
>> +static int k230_clk_find_approximate_mul_div(u32 mul_min, u32 mul_max,
>> +					     u32 div_min, u32 div_max,
>> +					     unsigned long rate,
>> +					     unsigned long parent_rate,
>> +					     u32 *div, u32 *mul)
>> +{
>> +	long abs_min;
>> +	long abs_current;
>> +	long perfect_divide;
>> +
>> +	if (!rate || !parent_rate || !mul_min)
>> +		return -EINVAL;
>> +
>> +	perfect_divide = (long)((parent_rate * 1000) / rate);
>> +	abs_min = abs(perfect_divide -
>> +		     (long)(((long)div_max * 1000) / (long)mul_min));
>> +
>> +	*div = div_max;
>> +	*mul = mul_min;
>> +
>> +	for (u32 i = div_max - 1; i >= div_min; i--) {
>> +		for (u32 j = mul_min + 1; j <= mul_max; j++) {
>> +			abs_current = abs(perfect_divide -
>> +					 (long)(((long)i * 1000) / (long)j));
>> +
>> +			if (abs_min > abs_current) {
>> +				abs_min = abs_current;
>> +				*div = i;
>> +				*mul = j;
>> +			}
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> This looks like a poor version of rational_best_approximation(). Could
> you please consider switching to it?
OK, I've switched k230_clk_find_approximate_mul_div() to use
rational_best_approximation().

Additionally, since rational_best_approximation() only supports setting
the maximum value for numerator and denominator, I added extra checks
after the call to ensure that the resulting values are not lower than
mul_min and div_min.
>
>> +static int k230_clk_set_rate_mul(struct clk_hw *hw, unsigned long rate,
>> +				 unsigned long parent_rate)
>> +{
>> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
>> +	struct k230_clk_rate_self *rate_self = &clk->clk;
>> +	u32 div, mul, mul_reg;
>> +
>> +	if (rate > parent_rate)
>> +		return -EINVAL;
>> +
>> +	if (rate_self->read_only)
>> +		return 0;
>> +
>> +	if (k230_clk_find_approximate_mul(rate_self->mul_min, rate_self->mul_max,
>> +					  rate_self->div_min, rate_self->div_max,
>> +					  rate, parent_rate, &div, &mul))
>> +		return -EINVAL;
>> +
>> +	guard(spinlock)(rate_self->lock);
>> +
>> +	mul_reg = readl(rate_self->reg + clk->mul_reg_off);
>> +	mul_reg |= ((mul - 1) & rate_self->mul_mask) << (rate_self->mul_shift);
>> +	mul_reg |= BIT(rate_self->write_enable_bit);
>> +	writel(mul_reg, rate_self->reg + clk->mul_reg_off);
>> +
>> +	return 0;
>> +}
>> +
>> +static int k230_clk_set_rate_div(struct clk_hw *hw, unsigned long rate,
>> +				 unsigned long parent_rate)
>> +{
>> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
>> +	struct k230_clk_rate_self *rate_self = &clk->clk;
>> +	u32 div, mul, div_reg;
>> +
>> +	if (rate > parent_rate)
>> +		return -EINVAL;
>> +
>> +	if (rate_self->read_only)
>> +		return 0;
>> +
>> +	if (k230_clk_find_approximate_div(rate_self->mul_min, rate_self->mul_max,
>> +					  rate_self->div_min, rate_self->div_max,
>> +					  rate, parent_rate, &div, &mul))
>> +		return -EINVAL;
>> +
>> +	guard(spinlock)(rate_self->lock);
>> +
>> +	div_reg = readl(rate_self->reg + clk->div_reg_off);
>> +	div_reg |= ((div - 1) & rate_self->div_mask) << (rate_self->div_shift);
>> +	div_reg |= BIT(rate_self->write_enable_bit);
>> +	writel(div_reg, rate_self->reg + clk->div_reg_off);
>> +
>> +	return 0;
>> +}
>> +
>> +static int k230_clk_set_rate_mul_div(struct clk_hw *hw, unsigned long rate,
>> +				     unsigned long parent_rate)
>> +{
>> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
>> +	struct k230_clk_rate_self *rate_self = &clk->clk;
>> +	u32 div, mul, div_reg, mul_reg;
>> +
>> +	if (rate > parent_rate)
>> +		return -EINVAL;
>> +
>> +	if (rate_self->read_only)
>> +		return 0;
>> +
>> +	if (k230_clk_find_approximate_mul_div(rate_self->mul_min, rate_self->mul_max,
>> +					      rate_self->div_min, rate_self->div_max,
>> +					      rate, parent_rate, &div, &mul))
>> +		return -EINVAL;
>> +
>> +	guard(spinlock)(rate_self->lock);
>> +
>> +	div_reg = readl(rate_self->reg + clk->div_reg_off);
>> +	div_reg |= ((div - 1) & rate_self->div_mask) << (rate_self->div_shift);
>> +	div_reg |= BIT(rate_self->write_enable_bit);
>> +	writel(div_reg, rate_self->reg + clk->div_reg_off);
>> +
>> +	mul_reg = readl(rate_self->reg + clk->mul_reg_off);
>> +	mul_reg |= ((mul - 1) & rate_self->mul_mask) << (rate_self->mul_shift);
>> +	mul_reg |= BIT(rate_self->write_enable_bit);
>> +	writel(mul_reg, rate_self->reg + clk->mul_reg_off);
>> +
>> +	return 0;
>> +}
> There are three variants of rate clocks, mul-only, div-only and mul-div
> ones, which are similar to clk-multiplier, clk-divider,
> clk-fractional-divider.
>
> The only difference is to setup new parameters for K230's rate clocks,
> a register bit, described as k230_clk_rate_self.write_enable_bit, must
> be set first.
Actually, I think the differences are not limited to just the
write_enable_bit. There are also distinct mul_min, mul_max, div_min, and
div_max values, which are not typically just 1 and (1 << bit_width) as
in standard clock divider or multiplier structures.

For example, the div_min for hs_sd_card_src_rate is 2, not 1. This
affects the calculation of the approximate divider, and cannot be fully
represented if we only use the clk_divider structure.

Another example is ls_codec_adc_rate, where mul_min is 0x10, mul_max is
0x1B9, div_min is 0xC35, and div_max is 0x3D09. These specific ranges
cannot be described using the normal clk_fractional_divider structure.

>
> What do you think of introducing support for such "write enable bit" to
> the generic implementation of multipler/divider/fractional? Then you
> could reuse the generic implementation in K230's driver, avoiding code
> duplication.
Therefore, in addition to the requirement of setting the
write_enable_bit, the customizable ranges for these parameters are also
important differences that should be considered.
>
> ...
>
>> +static const struct of_device_id k230_clk_ids[] = {
>> +	{ .compatible = "canaan,k230-clk" },
>> +	{ /* Sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, k230_clk_ids);
> MODULE_DEVICE_TABLE is unnecessary if your driver couldn't be built as
> a module.
OK, thanks for point it out.
>
>> +static struct platform_driver k230_clk_driver = {
>> +	.driver = {
>> +		.name = "k230_clock_controller",
>> +		.of_match_table = k230_clk_ids,
>> +	},
>> +	.probe = k230_clk_probe,
>> +};
>> +builtin_platform_driver(k230_clk_driver);
> Best regards,
> Yao Zi

