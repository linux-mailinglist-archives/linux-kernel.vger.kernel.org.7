Return-Path: <linux-kernel+bounces-737593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CABB0AE25
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 07:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2D11C40BEE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2593225419;
	Sat, 19 Jul 2025 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cY2+o8B2"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB52171CD;
	Sat, 19 Jul 2025 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752904337; cv=none; b=XbjLSD2rZdoVEEp24M3meRR37kYKndjpZkV134PpHJ92vqrKBvZ4vpTzEifjA5p7HfdFQlUHq09IFIm/mEmUtO81pi1/EZors26fBijqb1i1y8E1H1qnHybo3z2pJjMYOaTQhORn1hxBjRI0IZu1WVJELp7enb6d0sMKWa/ncgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752904337; c=relaxed/simple;
	bh=cteh37v3r96xQ7jAxpWaJ3GdLFB1B5kSQPbsAyuPGAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBcXUBubJSKfEVVnK6ZmbuZ4CfPHh0yQSHl8f5oVnKOpKNdUT+iICpl0yrruWNswwT371E/KENbtyLc2+hVFgbZBhN3LKamwSFGYqhZbZB5CVVkWn5skxIAqel+w2Ir0cT4sOlP0P+71hZhN/nE+KqaVBzXDlJs7BpJKtFmOGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cY2+o8B2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CD3BE25CB7;
	Sat, 19 Jul 2025 07:52:05 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0iV7Ez6XikUP; Sat, 19 Jul 2025 07:52:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752904321; bh=cteh37v3r96xQ7jAxpWaJ3GdLFB1B5kSQPbsAyuPGAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cY2+o8B2n8jwslpxEtgtPxVR+hvsKrtURoaFsPfQh1P+K/Lw81m1HFjWvn+2jKPOX
	 xkFOXqfTdXRcTobLGZMSVm76qQ+aaJ7J+ALbUrOz3CulkkC+s+WgKfT4uYUJ2grc8k
	 cNUO4sxzAeCodEEiYjA7zUsJWyxv+CValKsHNNI1G1v27McCDcormubkuMRHeyzJSW
	 ybvKqjqm7YyfPMg53s1JL58CYx+T7oOia0HI6cOobN+4depO04EvfF5as7gES/njOF
	 mVUyuMJgsAG1xdVnZlnXU8vsgYdPdp7S70TDb94icgfsTlCKMMeQgsl9cqXIQq6YFZ
	 SaQOrd/JijwkA==
Date: Sat, 19 Jul 2025 05:51:50 +0000
From: Yao Zi <ziyao@disroot.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: spacemit: fix sspax_clk
Message-ID: <aHswUN_p78a9JCWC@pie>
References: <20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com>
 <20250718105120-GYB695709@gentoo>
 <CBB594905CF0674E+aHpLqh2vVhTdzbEc@troy-wujie14pro-arch>
 <B4EF5817ECF41CE8+aHpQ9FFEoJj7EIwU@troy-wujie14pro-arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B4EF5817ECF41CE8+aHpQ9FFEoJj7EIwU@troy-wujie14pro-arch>

On Fri, Jul 18, 2025 at 09:49:40PM +0800, Troy Mitchell wrote:
> On Fri, Jul 18, 2025 at 09:27:06PM +0800, Troy Mitchell wrote:
> > On Fri, Jul 18, 2025 at 06:51:20PM +0800, Yixun Lan wrote:
> > > Hi Troy,
> > > 
> > > On 09:54 Fri 18 Jul     , Troy Mitchell wrote:
> > > > In the SpacemiT public document, when the FNCLKSEL field of
> > > > the APBC_SSPAX_CLK_RST register is 7 (3'b111),
> > > > which is a reserved value. And BIT3 of the same register is
> > > > a reserved bit.
> > > > 
> > > so, if I parse above correctly, it describe current public document?
> > > which value 7 of FNCLKSEL and BIT3 is wrongly marked as reserved.
> > > 
> > > https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb#10.2.3.2-resource-reset-schemes
> > > 10.2.4.3.16 SSPAX CLOCK RESET CONTROL REGISTER (APBC_SSPAX_CLK_RST)
> > > 
> > yes, correct summary
> > 
> > > > But the document is wrong, the actual situation is:
> > > > when FNCLKSEL is 7 (3'b111), and the purpose of bit 3 is
> > > > if to select i2s_bclk as the parent clock.
> > > > 
> > > > And only when FNCLKSEL is 7 (3'b111), The bit 3 is not a reserved bit.
> > > > 
> > > so what's the difference of value 7 from other 0-6? has additional ops to
> > > select i2s_bclk as parent? otherwise just say they are not reserved
> > > 
> > > please have more explanation for BIT3, it's quite obscure and unclear
> > Bit 3 is only valid when FNCLKSEL is 7,
> > indicating whether i2s_bclk is selected as the clock source.
> > And when FNCLKSEL is 7, bit 3 must be 1, otherwise it will cause unknown errors.
> > When FNCLKSEL is other values, bit 3 has no effect

Suggest introducing a dummy gate clock utilizing BIT(3) as the enable
bit. Instead directly taking i2s_bclk as parent, you could change the
eighth parent of sspaX_clk to the new dummy gate, which ensures BIT(3)
is set when the FNCLKSEL == 7 and requires no specific handling in code.

Regards,
Yao Zi

> > I'll explain more in the next version
> > 
> > > 
> > > anyway, can you coordinate with SpacemiT internal to update the docs?
> > > 
> > I have already told them. I think the document will be updated ASAP.
> > 
> > > > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > > ---
> > > >  drivers/clk/spacemit/ccu-k1.c  |  4 ++--
> > > >  drivers/clk/spacemit/ccu_mix.c | 29 +++++++++++++++++++++++++++++
> > > >  drivers/clk/spacemit/ccu_mix.h | 14 ++++++++++++++
> > > >  3 files changed, 45 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> > > > index cdde37a0523537c2f436e481ae8d6ec5a581b87e..0e22f6fb2c45b68ab20a9b1563a1a6dec1a7e16c 100644
> > > > --- a/drivers/clk/spacemit/ccu-k1.c
> > > > +++ b/drivers/clk/spacemit/ccu-k1.c
> > > > @@ -359,8 +359,8 @@ static const struct clk_parent_data sspa_parents[] = {
> > > >  	CCU_PARENT_HW(pll1_d3072_0p8),
> > > >  	CCU_PARENT_HW(i2s_bclk),
> > > >  };
> > > > -CCU_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
> > > > -CCU_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
> > > > +CCU_SSPA_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
> > > > +CCU_SSPA_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
> > > >  CCU_GATE_DEFINE(dro_clk, CCU_PARENT_HW(apb_clk), APBC_DRO_CLK_RST, BIT(1), 0);
> > > >  CCU_GATE_DEFINE(ir_clk, CCU_PARENT_HW(apb_clk), APBC_IR_CLK_RST, BIT(1), 0);
> > > >  CCU_GATE_DEFINE(tsen_clk, CCU_PARENT_HW(apb_clk), APBC_TSEN_CLK_RST, BIT(1), 0);
> > > > diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
> > > > index 9b852aa61f78aed5256bfe6fc3b01932d6db6256..bfc65fc00df67299523eb5d1d2ed479c61fc6141 100644
> > > > --- a/drivers/clk/spacemit/ccu_mix.c
> > > > +++ b/drivers/clk/spacemit/ccu_mix.c
> > > > @@ -191,6 +191,25 @@ static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
> > > >  	return ccu_mix_trigger_fc(hw);
> > > >  }
> > > >  
> > > > +static int ccu_mux_set_sspa_parent(struct clk_hw *hw, u8 index)
> > > > +{
> > > > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > > > +	struct ccu_mux_config *mux = &mix->mux;
> > > > +	u32 mask, val;
> > > > +
> > > > +	mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> > > > +	val = index << mux->shift;
> > > > +
> > > > +	if (index == 7) {
> > > > +		mask |= BIT(3);
> > > > +		val |= BIT(3);
> > > > +	}
> > > it occur to me, BIT(3) is kind of a conditional BIT..
> > > 
> > > what's the behavior of reading/writing to BIT3 when index != 7?
> > > write value will be ignored, read will return zero?
> > I don't know. I haven't tested it, and I don't think it's worth testing.
> > I've written a function to set the parent using BIT(3) and an index.
> > Therefore, when the caller invokes get_parent, BIT(3) is not considered; only the index is.
> >
> Sry, Yixun, We really need to test it!
> If BIT(3) has no effct when FNCLKSEL is set to other values,
> then we can avoid introducing a new function.
> > 
> >                 - Troy
> > 
> > > 
> > > > +
> > > > +	ccu_update(&mix->common, ctrl, mask, val);
> > > > +
> > > > +	return ccu_mix_trigger_fc(hw);
> > > > +}
> > > > +
> > > >  const struct clk_ops spacemit_ccu_gate_ops = {
> > > >  	.disable	= ccu_gate_disable,
> > > >  	.enable		= ccu_gate_enable,
> > > > @@ -235,6 +254,16 @@ const struct clk_ops spacemit_ccu_mux_gate_ops = {
> > > >  	.set_parent	= ccu_mux_set_parent,
> > > >  };
> > > >  
> > > > +const struct clk_ops spacemit_ccu_sspa_mux_gate_ops = {
> > > > +	.disable	= ccu_gate_disable,
> > > > +	.enable		= ccu_gate_enable,
> > > > +	.is_enabled	= ccu_gate_is_enabled,
> > > > +
> > > > +	.determine_rate = ccu_mix_determine_rate,
> > > > +	.get_parent	= ccu_mux_get_parent,
> > > > +	.set_parent	= ccu_mux_set_sspa_parent,
> > > > +};
> > > > +
> > > >  const struct clk_ops spacemit_ccu_div_gate_ops = {
> > > >  	.disable	= ccu_gate_disable,
> > > >  	.enable		= ccu_gate_enable,
> > > > diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
> > > > index 51d19f5d6aacb7203d1eddf96047cf3174533601..7753446386353bf849787ed4ec7c85c298238ab5 100644
> > > > --- a/drivers/clk/spacemit/ccu_mix.h
> > > > +++ b/drivers/clk/spacemit/ccu_mix.h
> > > > @@ -124,6 +124,19 @@ static struct ccu_mix _name = {							\
> > > >  	}									\
> > > >  }
> > > >  
> > > > +#define CCU_SSPA_MUX_GATE_DEFINE(_name, _parents, _reg_ctrl,			\
> > > > +				     _shift, _width, _mask_gate, _flags)	\
> > > > +static struct ccu_mix _name = {							\
> > > > +	.gate	= CCU_GATE_INIT(_mask_gate),					\
> > > > +	.mux	= CCU_MUX_INIT(_shift, _width),					\
> > > > +	.common = {								\
> > > > +		.reg_ctrl	= _reg_ctrl,					\
> > > > +		CCU_MIX_INITHW_PARENTS(_name, _parents,				\
> > > > +				       spacemit_ccu_sspa_mux_gate_ops,		\
> > > > +				       _flags),					\
> > > > +	}									\
> > > > +}
> > > > +
> > > >  #define CCU_DIV_GATE_DEFINE(_name, _parent, _reg_ctrl, _shift, _width,		\
> > > >  			    _mask_gate,	_flags)					\
> > > >  static struct ccu_mix _name = {							\
> > > > @@ -213,6 +226,7 @@ extern const struct clk_ops spacemit_ccu_div_ops;
> > > >  extern const struct clk_ops spacemit_ccu_factor_gate_ops;
> > > >  extern const struct clk_ops spacemit_ccu_div_gate_ops;
> > > >  extern const struct clk_ops spacemit_ccu_mux_gate_ops;
> > > > +extern const struct clk_ops spacemit_ccu_sspa_mux_gate_ops;
> > > >  extern const struct clk_ops spacemit_ccu_mux_div_ops;
> > > >  extern const struct clk_ops spacemit_ccu_mux_div_gate_ops;
> > > >  #endif /* _CCU_DIV_H_ */
> > > > 
> > > > ---
> > > > base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
> > > > change-id: 20250717-k1-clk-i2s-e4272f1f915b
> > > > 
> > > > Best regards,
> > > > -- 
> > > > Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > > 
> > > > 
> > > 
> > > -- 
> > > Yixun Lan (dlan)
> > > 
> 

