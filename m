Return-Path: <linux-kernel+bounces-807062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3240B49F6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE74E3A1F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C432F2571BE;
	Tue,  9 Sep 2025 02:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BZ+79DwK"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04261D61BB;
	Tue,  9 Sep 2025 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386322; cv=none; b=OcFMRarY11BX29K5Gc00iS4tQCn7HiTbWxU9RjBT2KycOFhDa7NbCNnoBXsuLAHMnH06gCzR/DKOus/jzG26qAbft9ildZCnJ5nppWpdYPPkaJ9P2bXUOpeEwWy9E13apdSNKJLDD+a6XAviy9Cp/BhZfyuRaUn91x669HZ9fl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386322; c=relaxed/simple;
	bh=rJ6zql9GvPc0S5blprEyBy/gNctD4hMQy6wVOb34PiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbukWs2xbOyBHt4pFm6YkXiplto6n5f1X3dJEONmV5APUx52fCF/EUdmTcIpY2fi3bCb45ef4/5KOdXVXm9ydfllBw4hsoMZc2nYVpmjfYOc7bo32AVI8g5i9Hma8OZ1yuQGBFRkSn4iK587cBZtwPpQBCJ0uiXi4IsuD+d3MAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BZ+79DwK; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 44B7722EC1;
	Tue,  9 Sep 2025 04:51:51 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cUb3k8BRjNKs; Tue,  9 Sep 2025 04:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757386310; bh=rJ6zql9GvPc0S5blprEyBy/gNctD4hMQy6wVOb34PiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BZ+79DwKXgux9NaOekFldf3z1TrMwFEm5nfKU+qzQSyY830UhXQ6opPaz84xdu9hg
	 mCT1KAYwdlE0GlY2OnqzLe0Cp+zMPGP0HVeQ2YexIEOPRMtDuphvlYB8CW+SjNxoCc
	 YVfDV/DRbwJlXp/sRajBkp+sqPXEOdGylGJpGanCf33sLWnbeG7+pqNR2pKuBz/DVq
	 fYVyJ5G9BQXfyyEbq2haMwMtOX7y7HV47Efaf04IaFlncZFiMrHEy5JuxNU9J+rFhJ
	 0UrIZOI/gmhffSGm78Sb2rZyElO0GsdDww5TuQVe+cW56KHd3WRBaPbA9Wd6fvpraR
	 vhDWRujn73Hjg==
Date: Tue, 9 Sep 2025 02:51:29 +0000
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
Message-ID: <aL-WMT2YuGagGNQj@pie>
References: <20250905-b4-k230-clk-v8-0-96caa02d5428@zohomail.com>
 <20250905-b4-k230-clk-v8-2-96caa02d5428@zohomail.com>
 <aLz4Q7LZFEfQQGUj@pie>
 <0947d9cc-86ba-46e0-92aa-04f4714e7a20@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0947d9cc-86ba-46e0-92aa-04f4714e7a20@zohomail.com>

On Mon, Sep 08, 2025 at 10:13:15PM +0800, Xukai Wang wrote:
> 
> On 2025/9/7 11:13, Yao Zi wrote:
> >> On Fri, Sep 05, 2025 at 11:10:23AM +0800, Xukai Wang wrote:
> >> This patch provides basic support for the K230 clock, which covers
> >> all clocks in K230 SoC.
> >>
> >> The clock tree of the K230 SoC consists of a 24MHZ external crystal
> >> oscillator, PLLs and an external pulse input for timerX, and their
> >> derived clocks.
> >>
> >> Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
> >> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
> >> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
> >> ---
> >>  drivers/clk/Kconfig    |    6 +
> >>  drivers/clk/Makefile   |    1 +
> >>  drivers/clk/clk-k230.c | 2456 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 2463 insertions(+)

...

> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..2ba74c008b30ae3400acbd8c08550e8315dfe205
> >> --- /dev/null
> >> +++ b/drivers/clk/clk-k230.c
> >> @@ -0,0 +1,2456 @@

...

> >
> >> +static int k230_clk_set_rate_mul(struct clk_hw *hw, unsigned long rate,
> >> +				 unsigned long parent_rate)
> >> +{
> >> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
> >> +	struct k230_clk_rate_self *rate_self = &clk->clk;
> >> +	u32 div, mul, mul_reg;
> >> +
> >> +	if (rate > parent_rate)
> >> +		return -EINVAL;
> >> +
> >> +	if (rate_self->read_only)
> >> +		return 0;
> >> +
> >> +	if (k230_clk_find_approximate_mul(rate_self->mul_min, rate_self->mul_max,
> >> +					  rate_self->div_min, rate_self->div_max,
> >> +					  rate, parent_rate, &div, &mul))
> >> +		return -EINVAL;
> >> +
> >> +	guard(spinlock)(rate_self->lock);
> >> +
> >> +	mul_reg = readl(rate_self->reg + clk->mul_reg_off);
> >> +	mul_reg |= ((mul - 1) & rate_self->mul_mask) << (rate_self->mul_shift);
> >> +	mul_reg |= BIT(rate_self->write_enable_bit);
> >> +	writel(mul_reg, rate_self->reg + clk->mul_reg_off);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int k230_clk_set_rate_div(struct clk_hw *hw, unsigned long rate,
> >> +				 unsigned long parent_rate)
> >> +{
> >> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
> >> +	struct k230_clk_rate_self *rate_self = &clk->clk;
> >> +	u32 div, mul, div_reg;
> >> +
> >> +	if (rate > parent_rate)
> >> +		return -EINVAL;
> >> +
> >> +	if (rate_self->read_only)
> >> +		return 0;
> >> +
> >> +	if (k230_clk_find_approximate_div(rate_self->mul_min, rate_self->mul_max,
> >> +					  rate_self->div_min, rate_self->div_max,
> >> +					  rate, parent_rate, &div, &mul))
> >> +		return -EINVAL;
> >> +
> >> +	guard(spinlock)(rate_self->lock);
> >> +
> >> +	div_reg = readl(rate_self->reg + clk->div_reg_off);
> >> +	div_reg |= ((div - 1) & rate_self->div_mask) << (rate_self->div_shift);
> >> +	div_reg |= BIT(rate_self->write_enable_bit);
> >> +	writel(div_reg, rate_self->reg + clk->div_reg_off);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int k230_clk_set_rate_mul_div(struct clk_hw *hw, unsigned long rate,
> >> +				     unsigned long parent_rate)
> >> +{
> >> +	struct k230_clk_rate *clk = hw_to_k230_clk_rate(hw);
> >> +	struct k230_clk_rate_self *rate_self = &clk->clk;
> >> +	u32 div, mul, div_reg, mul_reg;
> >> +
> >> +	if (rate > parent_rate)
> >> +		return -EINVAL;
> >> +
> >> +	if (rate_self->read_only)
> >> +		return 0;
> >> +
> >> +	if (k230_clk_find_approximate_mul_div(rate_self->mul_min, rate_self->mul_max,
> >> +					      rate_self->div_min, rate_self->div_max,
> >> +					      rate, parent_rate, &div, &mul))
> >> +		return -EINVAL;
> >> +
> >> +	guard(spinlock)(rate_self->lock);
> >> +
> >> +	div_reg = readl(rate_self->reg + clk->div_reg_off);
> >> +	div_reg |= ((div - 1) & rate_self->div_mask) << (rate_self->div_shift);
> >> +	div_reg |= BIT(rate_self->write_enable_bit);
> >> +	writel(div_reg, rate_self->reg + clk->div_reg_off);
> >> +
> >> +	mul_reg = readl(rate_self->reg + clk->mul_reg_off);
> >> +	mul_reg |= ((mul - 1) & rate_self->mul_mask) << (rate_self->mul_shift);
> >> +	mul_reg |= BIT(rate_self->write_enable_bit);
> >> +	writel(mul_reg, rate_self->reg + clk->mul_reg_off);
> >> +
> >> +	return 0;
> >> +}
> > There are three variants of rate clocks, mul-only, div-only and mul-div
> > ones, which are similar to clk-multiplier, clk-divider,
> > clk-fractional-divider.
> >
> > The only difference is to setup new parameters for K230's rate clocks,
> > a register bit, described as k230_clk_rate_self.write_enable_bit, must
> > be set first.
> Actually, I think the differences are not limited to just the
> write_enable_bit. There are also distinct mul_min, mul_max, div_min, and
> div_max values, which are not typically just 1 and (1 << bit_width) as
> in standard clock divider or multiplier structures.

Oops, I missed these members, so there're more differences, but...

> For example, the div_min for hs_sd_card_src_rate is 2, not 1. This
> affects the calculation of the approximate divider, and cannot be fully
> represented if we only use the clk_divider structure.

Reading through the TRM[1], I cannot find why using one as divisor isn't
valid for hs_sd_card_src_rate. The clock corresponds to field
hs_SDCLK_CFG.sd_cclk_div, and is described as "Sd card clock divider.
N: (N+1) divider. Sd0、sd1 cclk is divided from this clock".

Do you have any extra information about the limitation?

> Another example is ls_codec_adc_rate, where mul_min is 0x10, mul_max is
> 0x1B9, div_min is 0xC35, and div_max is 0x3D09. These specific ranges
> cannot be described using the normal clk_fractional_divider structure.

According to the TRM, the two fields in control of the fractional clock
are described as

> codec clock stup. For example, audio_clk: 25644.1K, source clock:
> 400M, 400M/(25644.1K) can be simplied
to : 15625/441. sum is set to :
> 15625, step is set to 441

and

> codec clock sum

still I cannot find any information about the range you described with
mul_min and div_min. Could you confirm whether they're really
necessary?

> >
> > What do you think of introducing support for such "write enable bit" to
> > the generic implementation of multipler/divider/fractional? Then you
> > could reuse the generic implementation in K230's driver, avoiding code
> > duplication.
> Therefore, in addition to the requirement of setting the
> write_enable_bit, the customizable ranges for these parameters are also
> important differences that should be considered.

Best regards,
Yao Zi

[1]: https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf

