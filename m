Return-Path: <linux-kernel+bounces-807166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3463EB4A114
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D241672DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C6A221F26;
	Tue,  9 Sep 2025 05:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="PKUzDq6B"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EA1D6BB;
	Tue,  9 Sep 2025 05:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394124; cv=pass; b=Ha7NAIHz114CRcNIwwfPB8K1zS3yJkeGVwVMU1/HimhcL3Q3OjfsjbsTqRCwBJBKNI+EKH59zaoju24VPuELCes1mz3K+YieekVx5qBvblpMBcRASyjSqd2Di8TK0SgWJ0aqIyy8GLHx1Bj/10aLsOAMbhGZi3r5vy8sKX+OoRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394124; c=relaxed/simple;
	bh=L9y6+jYoS36hnzA2NE3O1DvvsKsYiDuS9plSl1vqNgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYRDa8QEL003kngPzuyJVYSmITJ0f2ITf+BNX2IKtP1tnrxG8OO9dHIWSxPWXmVtm0mmLbn9NI0EsnOdKLjTrpQAgSX0/nZ0THcmPSa1zQQK7G/rqxil/qgfK6v6+4udxUM3II34Ew6XWZXtkwaNy8BUlMz4ola+XZzZrYM0LoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=PKUzDq6B; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1757394096; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PBv5OOrRqTfiqWBsmfOmAnEY1oeMd1pXy8oaqOA0vRNaqaMt1PKFQijvOcqvCQYNV8UIcE3f4imn1esP+4uEWzEIc048mkOkxRwVWu7wjYUSHCvcz0wLpSlBhTGMX23755YcWVw4yO3t3R6GTt2lD5Pb/U7EHI5/8JQVFFmAirg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757394096; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TO3v4VcMN5jFOEoVCx0uIH7StyuzE0TsktzYy6dcckk=; 
	b=elTK077rp6M1hxpHxE3kWjLTZvky2smF7wa4FXguZAin6JbFto4UagHajoMzmt3GQs4dSvoB/VL4qkeK+B6T23XkZdDMZtnKTM2zUNNbvVGjEeomw6Lz35y7/mnm3ylqNOGv+aOmd3CVkFEpOMqpESrqKzQzm8cGQMH+emxqLOg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757394096;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=TO3v4VcMN5jFOEoVCx0uIH7StyuzE0TsktzYy6dcckk=;
	b=PKUzDq6BqYzszn5D8FA81MRk3pncxzyACmxorPt0caO/2thkYr6AbGAabrW1MDKQ
	Zy5HyfZ6GcKw1M4leXQ/H3pI2tu/tYeGSfDbQ5JHTbtwXWU5cx4/6TNenHeQEEsN8yL
	xFKTJQ9q4gSrqDPE4faCKecGwDGHO2ohjWdI56SY=
Received: by mx.zohomail.com with SMTPS id 1757394089805127.05153328891538;
	Mon, 8 Sep 2025 22:01:29 -0700 (PDT)
Message-ID: <cae7ecf5-0d15-4b8c-9c4d-cdf1e6275c38@zohomail.com>
Date: Tue, 9 Sep 2025 13:01:10 +0800
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
 <0947d9cc-86ba-46e0-92aa-04f4714e7a20@zohomail.com> <aL-WMT2YuGagGNQj@pie>
From: Xukai Wang <kingxukai@zohomail.com>
Content-Language: en-US
In-Reply-To: <aL-WMT2YuGagGNQj@pie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227aa221a156567d3a27eae5395000078f7d80b44c21a74b72e157bf82007e909b86de7490f3c71b9:zu08011227d0aaa54f68050705a5288bcb00009f49836e1e434ce18a3cd3e82bbb5df4344356b339f31a5b84:rf0801122ca0a0ec50fe343fc062c5fd0e0000ab7f2a350f13bc62ad9b3f2ffbee39811b9ee7ab91053af214c85025cb89:ZohoMail
X-ZohoMailClient: External


On 2025/9/9 10:51, Yao Zi wrote:
> On Mon, Sep 08, 2025 at 10:13:15PM +0800, Xukai Wang wrote:
>> On 2025/9/7 11:13, Yao Zi wrote:
>>>> On Fri, Sep 05, 2025 at 11:10:23AM +0800, Xukai Wang wrote:
>>>> This patch provides basic support for the K230 clock, which covers
>>>> all clocks in K230 SoC.
>>>>
>>>> The clock tree of the K230 SoC consists of a 24MHZ external crystal
>>>> oscillator, PLLs and an external pulse input for timerX, and their
>>>> derived clocks.
>>>>
>>>> Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
>>>> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
>>>> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
>>>> ---
>>>>  drivers/clk/Kconfig    |    6 +
>>>>  drivers/clk/Makefile   |    1 +
>>>>  drivers/clk/clk-k230.c | 2456 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 2463 insertions(+)
> ...
>>>> +static int k230_clk_set_rate_mul(struct clk_hw *hw, unsigned long rate,
>>>> +				 unsigned long parent_rate)
>>>> +{
>>>> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
>>>> +	struct k230_clk_rate_self *rate_self = &clk->clk;
>>>> +	u32 div, mul, mul_reg;
>>>> +
>>>> +	if (rate > parent_rate)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (rate_self->read_only)
>>>> +		return 0;
>>>> +
>>>> +	if (k230_clk_find_approximate_mul(rate_self->mul_min, rate_self->mul_max,
>>>> +					  rate_self->div_min, rate_self->div_max,
>>>> +					  rate, parent_rate, &div, &mul))
>>>> +		return -EINVAL;
>>>> +
>>>> +	guard(spinlock)(rate_self->lock);
>>>> +
>>>> +	mul_reg = readl(rate_self->reg + clk->mul_reg_off);
>>>> +	mul_reg |= ((mul - 1) & rate_self->mul_mask) << (rate_self->mul_shift);
>>>> +	mul_reg |= BIT(rate_self->write_enable_bit);
>>>> +	writel(mul_reg, rate_self->reg + clk->mul_reg_off);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int k230_clk_set_rate_div(struct clk_hw *hw, unsigned long rate,
>>>> +				 unsigned long parent_rate)
>>>> +{
>>>> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
>>>> +	struct k230_clk_rate_self *rate_self = &clk->clk;
>>>> +	u32 div, mul, div_reg;
>>>> +
>>>> +	if (rate > parent_rate)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (rate_self->read_only)
>>>> +		return 0;
>>>> +
>>>> +	if (k230_clk_find_approximate_div(rate_self->mul_min, rate_self->mul_max,
>>>> +					  rate_self->div_min, rate_self->div_max,
>>>> +					  rate, parent_rate, &div, &mul))
>>>> +		return -EINVAL;
>>>> +
>>>> +	guard(spinlock)(rate_self->lock);
>>>> +
>>>> +	div_reg = readl(rate_self->reg + clk->div_reg_off);
>>>> +	div_reg |= ((div - 1) & rate_self->div_mask) << (rate_self->div_shift);
>>>> +	div_reg |= BIT(rate_self->write_enable_bit);
>>>> +	writel(div_reg, rate_self->reg + clk->div_reg_off);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int k230_clk_set_rate_mul_div(struct clk_hw *hw, unsigned long rate,
>>>> +				     unsigned long parent_rate)
>>>> +{
>>>> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
>>>> +	struct k230_clk_rate_self *rate_self = &clk->clk;
>>>> +	u32 div, mul, div_reg, mul_reg;
>>>> +
>>>> +	if (rate > parent_rate)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (rate_self->read_only)
>>>> +		return 0;
>>>> +
>>>> +	if (k230_clk_find_approximate_mul_div(rate_self->mul_min, rate_self->mul_max,
>>>> +					      rate_self->div_min, rate_self->div_max,
>>>> +					      rate, parent_rate, &div, &mul))
>>>> +		return -EINVAL;
>>>> +
>>>> +	guard(spinlock)(rate_self->lock);
>>>> +
>>>> +	div_reg = readl(rate_self->reg + clk->div_reg_off);
>>>> +	div_reg |= ((div - 1) & rate_self->div_mask) << (rate_self->div_shift);
>>>> +	div_reg |= BIT(rate_self->write_enable_bit);
>>>> +	writel(div_reg, rate_self->reg + clk->div_reg_off);
>>>> +
>>>> +	mul_reg = readl(rate_self->reg + clk->mul_reg_off);
>>>> +	mul_reg |= ((mul - 1) & rate_self->mul_mask) << (rate_self->mul_shift);
>>>> +	mul_reg |= BIT(rate_self->write_enable_bit);
>>>> +	writel(mul_reg, rate_self->reg + clk->mul_reg_off);
>>>> +
>>>> +	return 0;
>>>> +}
>>> There are three variants of rate clocks, mul-only, div-only and mul-div
>>> ones, which are similar to clk-multiplier, clk-divider,
>>> clk-fractional-divider.
>>>
>>> The only difference is to setup new parameters for K230's rate clocks,
>>> a register bit, described as k230_clk_rate_self.write_enable_bit, must
>>> be set first.
>> Actually, I think the differences are not limited to just the
>> write_enable_bit. There are also distinct mul_min, mul_max, div_min, and
>> div_max values, which are not typically just 1 and (1 << bit_width) as
>> in standard clock divider or multiplier structures.
> Oops, I missed these members, so there're more differences, but...
>
>> For example, the div_min for hs_sd_card_src_rate is 2, not 1. This
>> affects the calculation of the approximate divider, and cannot be fully
>> represented if we only use the clk_divider structure.
> Reading through the TRM[1], I cannot find why using one as divisor isn't
> valid for hs_sd_card_src_rate. The clock corresponds to field
> hs_SDCLK_CFG.sd_cclk_div, and is described as "Sd card clock divider.
> N: (N+1) divider. Sd0、sd1 cclk is divided from this clock".
>
> Do you have any extra information about the limitation?

This limitation comes from the vendor's hardware reference code[2],
which indicates this constraint, but unfortunately it's not documented
in the public TRM[1].

>
>> Another example is ls_codec_adc_rate, where mul_min is 0x10, mul_max is
>> 0x1B9, div_min is 0xC35, and div_max is 0x3D09. These specific ranges
>> cannot be described using the normal clk_fractional_divider structure.
> According to the TRM, the two fields in control of the fractional clock
> are described as
>
>> codec clock stup. For example, audio_clk: 25644.1K, source clock:
>> 400M, 400M/(25644.1K) can be simplied
> to : 15625/441. sum is set to :
>> 15625, step is set to 441
> and
>
>> codec clock sum
> still I cannot find any information about the range you described with
> mul_min and div_min. Could you confirm whether they're really
> necessary?
>
>>> What do you think of introducing support for such "write enable bit" to
>>> the generic implementation of multipler/divider/fractional? Then you
>>> could reuse the generic implementation in K230's driver, avoiding code
>>> duplication.
>> Therefore, in addition to the requirement of setting the
>> write_enable_bit, the customizable ranges for these parameters are also
>> important differences that should be considered.
> Best regards,
> Yao Zi
>
> [1]: https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
[2]:
https://github.com/ruyisdk/linux-xuantie-kernel/blob/4d69bb363fd873f2b0ac7daa488ca0206d0b6760/arch/riscv/boot/dts/canaan/k230_clock_provider.dtsi#L918


