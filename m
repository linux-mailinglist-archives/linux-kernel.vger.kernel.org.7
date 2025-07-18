Return-Path: <linux-kernel+bounces-736949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13004B0A598
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E23D5A34CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88CF29CB40;
	Fri, 18 Jul 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="SDHQy7LN"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617415E5C2;
	Fri, 18 Jul 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846677; cv=none; b=kMxYIDWsHMy+IajfjpCHL9FEEJ1o7evySqUtySdLApT06SWIPeqen3kEE7ucy+tBLwANVbMPoYnano/ZjKmsGdkwuweZidMXzGE0sFTwyoIQ2bFUPwZByckpJ5/TkAmyO0mXPjm7xperNRNXmRsE5zcGRIezCmJFHz13/qR49Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846677; c=relaxed/simple;
	bh=491v+R/9aAalxlW2/npiuH6ZX5WxUuvvz8p2ygbC/U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ng3aEtNEy9dmvftr71RQwL+kIrgp0fTcMBgtV///QIS7rhJhdLJ383KgdA/jBqv04fNZuKtyOBtsM/+/XavXa/BsYwecly3Bmttr7xMJNljQlt/6dRZ+4M/WzZSG2qnj2wAMWHJbpLzlTy1AgjUUTbUptrqzJtBG4QZKjot0ONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=SDHQy7LN; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1752846589;
	bh=cJqeSBMSX2nzmX5QN44zXeJEkxmT125WTWJpHT1Zyw8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=SDHQy7LNirlcyBl2/LU5gjmY4hyBiiQSm0E3ZK+seN6fcJxLfvsTKpbQJh3ai7m+1
	 584UogP/RsOPts67d3Tx3m2gAGYbBm9+l2a2+V5/QLVs4U4CjANO23i3qXJ+FMdymy
	 hBgYFax4neAM8mFOrdCA1/QJbSnAc+LBzYbIswK0=
X-QQ-mid: zesmtpip4t1752846587t0ae73125
X-QQ-Originating-IP: AOdaLkoW5D0ShAIDYcZ6Iul4+7LzVVGChRqIFZVoWd8=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Jul 2025 21:49:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2453416834159754480
EX-QQ-RecipientCnt: 8
Date: Fri, 18 Jul 2025 21:49:40 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: spacemit: fix sspax_clk
Message-ID: <B4EF5817ECF41CE8+aHpQ9FFEoJj7EIwU@troy-wujie14pro-arch>
References: <20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com>
 <20250718105120-GYB695709@gentoo>
 <CBB594905CF0674E+aHpLqh2vVhTdzbEc@troy-wujie14pro-arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBB594905CF0674E+aHpLqh2vVhTdzbEc@troy-wujie14pro-arch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NJYnAvh5o174gPg+hTQYBiJcWDJZTPbcqhUntfhb2hByC0PO7WvfbRxZ
	K+Za2YC+J8b4Bl9nd8Yd5K3XAmSS2txmVSMURNuTmdTPFQNarSWWfwTqgBu6FUiBBvdevtY
	thLFN9Jr+3fGe4/6f68X1OhyN4jtgL8/XrVBllewsDavIzFfSpVHWlXcXj1x7P7KGyhxo80
	ra6amV1PURdFb7ZboywjvwUCjYLmNhewUR6S4DdTAXQGxkFmVxYALJ3SFP6ebQ76EsQzIIy
	RFCc6CR8q3CGE+1opZnwoGVujky2UORSwwdKYzXV7hYc/dRGNd/x96QrUY8TT8EiOPgWXI8
	NfpC52wjpdsc2jfmQsXQAb4zyUtjLxl8Z/Mrn9iZvkqQZ8xokIuVXobYk0Rx/G1C3vgarhx
	o7mZWNr7o1wJwdTKKdtQMHYR6x2fNqJs8HlrVDsBE4/G3rwIilgoBdEaIqcxqUWIIMgbzil
	ww/a/uMElW5NtLk5Guuw0cSmfQIJUGM4RU/qhmwQkZPrmMZIcd+JN9LfKkwC9n+2DUVkib+
	3UPyvDdJXxHYHgjPLgV/S+sr5L5LCXmO4t14JusQMTbAN8CMUVjVtI6fPC1jPtDQvq3T3Ii
	TLrn0vcfy/tmVJFe70/vL+s4qUpFT3Z/iTLQ4bZ3y6Yyz36Q4tjjHsU5nt9Ic2hZfY1WRUH
	6WTjAPs5zKf5TV8gb9QrlU60bBn75j9BCcUir9nNo3n//LDgIPB988lkGGVQ+61fnYJgKs2
	tT16xkjsEgEzkErr78mSyaAMiCuUqasGcDG/A7iIyAF5456/Fhcut6M7F6HIBMEEcmVVMD8
	GqU3rtqxshvXWHFk+3psWNwTz0H6+dFdRVSBfsSsKtlQqS2L5/UmpSH2RN6IliYqye6WaYd
	36KNCh4F8DB0SdsoWg6NRQqsVgKx6+pB8ptUj+JS7LgP7rrRqM1s53Rs6A1HK85z3SSGnBU
	vLvVYj41ivfgS058rhtdHYSqTGWx1Xnke7QiKLM0ez3CXwhyo4VbyNkzMAQUf4TunEWsqyJ
	EGQok36hWYv1/aa7sVRvdvSwnewkNu4d6K7Bamv6QsX9c3rPYEosvxx0CyXGo=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Fri, Jul 18, 2025 at 09:27:06PM +0800, Troy Mitchell wrote:
> On Fri, Jul 18, 2025 at 06:51:20PM +0800, Yixun Lan wrote:
> > Hi Troy,
> > 
> > On 09:54 Fri 18 Jul     , Troy Mitchell wrote:
> > > In the SpacemiT public document, when the FNCLKSEL field of
> > > the APBC_SSPAX_CLK_RST register is 7 (3'b111),
> > > which is a reserved value. And BIT3 of the same register is
> > > a reserved bit.
> > > 
> > so, if I parse above correctly, it describe current public document?
> > which value 7 of FNCLKSEL and BIT3 is wrongly marked as reserved.
> > 
> > https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb#10.2.3.2-resource-reset-schemes
> > 10.2.4.3.16 SSPAX CLOCK RESET CONTROL REGISTER (APBC_SSPAX_CLK_RST)
> > 
> yes, correct summary
> 
> > > But the document is wrong, the actual situation is:
> > > when FNCLKSEL is 7 (3'b111), and the purpose of bit 3 is
> > > if to select i2s_bclk as the parent clock.
> > > 
> > > And only when FNCLKSEL is 7 (3'b111), The bit 3 is not a reserved bit.
> > > 
> > so what's the difference of value 7 from other 0-6? has additional ops to
> > select i2s_bclk as parent? otherwise just say they are not reserved
> > 
> > please have more explanation for BIT3, it's quite obscure and unclear
> Bit 3 is only valid when FNCLKSEL is 7,
> indicating whether i2s_bclk is selected as the clock source.
> And when FNCLKSEL is 7, bit 3 must be 1, otherwise it will cause unknown errors.
> When FNCLKSEL is other values, bit 3 has no effect
> 
> I'll explain more in the next version
> 
> > 
> > anyway, can you coordinate with SpacemiT internal to update the docs?
> > 
> I have already told them. I think the document will be updated ASAP.
> 
> > > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > ---
> > >  drivers/clk/spacemit/ccu-k1.c  |  4 ++--
> > >  drivers/clk/spacemit/ccu_mix.c | 29 +++++++++++++++++++++++++++++
> > >  drivers/clk/spacemit/ccu_mix.h | 14 ++++++++++++++
> > >  3 files changed, 45 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> > > index cdde37a0523537c2f436e481ae8d6ec5a581b87e..0e22f6fb2c45b68ab20a9b1563a1a6dec1a7e16c 100644
> > > --- a/drivers/clk/spacemit/ccu-k1.c
> > > +++ b/drivers/clk/spacemit/ccu-k1.c
> > > @@ -359,8 +359,8 @@ static const struct clk_parent_data sspa_parents[] = {
> > >  	CCU_PARENT_HW(pll1_d3072_0p8),
> > >  	CCU_PARENT_HW(i2s_bclk),
> > >  };
> > > -CCU_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
> > > -CCU_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
> > > +CCU_SSPA_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
> > > +CCU_SSPA_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
> > >  CCU_GATE_DEFINE(dro_clk, CCU_PARENT_HW(apb_clk), APBC_DRO_CLK_RST, BIT(1), 0);
> > >  CCU_GATE_DEFINE(ir_clk, CCU_PARENT_HW(apb_clk), APBC_IR_CLK_RST, BIT(1), 0);
> > >  CCU_GATE_DEFINE(tsen_clk, CCU_PARENT_HW(apb_clk), APBC_TSEN_CLK_RST, BIT(1), 0);
> > > diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
> > > index 9b852aa61f78aed5256bfe6fc3b01932d6db6256..bfc65fc00df67299523eb5d1d2ed479c61fc6141 100644
> > > --- a/drivers/clk/spacemit/ccu_mix.c
> > > +++ b/drivers/clk/spacemit/ccu_mix.c
> > > @@ -191,6 +191,25 @@ static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
> > >  	return ccu_mix_trigger_fc(hw);
> > >  }
> > >  
> > > +static int ccu_mux_set_sspa_parent(struct clk_hw *hw, u8 index)
> > > +{
> > > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > > +	struct ccu_mux_config *mux = &mix->mux;
> > > +	u32 mask, val;
> > > +
> > > +	mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> > > +	val = index << mux->shift;
> > > +
> > > +	if (index == 7) {
> > > +		mask |= BIT(3);
> > > +		val |= BIT(3);
> > > +	}
> > it occur to me, BIT(3) is kind of a conditional BIT..
> > 
> > what's the behavior of reading/writing to BIT3 when index != 7?
> > write value will be ignored, read will return zero?
> I don't know. I haven't tested it, and I don't think it's worth testing.
> I've written a function to set the parent using BIT(3) and an index.
> Therefore, when the caller invokes get_parent, BIT(3) is not considered; only the index is.
>
Sry, Yixun, We really need to test it!
If BIT(3) has no effct when FNCLKSEL is set to other values,
then we can avoid introducing a new function.
> 
>                 - Troy
> 
> > 
> > > +
> > > +	ccu_update(&mix->common, ctrl, mask, val);
> > > +
> > > +	return ccu_mix_trigger_fc(hw);
> > > +}
> > > +
> > >  const struct clk_ops spacemit_ccu_gate_ops = {
> > >  	.disable	= ccu_gate_disable,
> > >  	.enable		= ccu_gate_enable,
> > > @@ -235,6 +254,16 @@ const struct clk_ops spacemit_ccu_mux_gate_ops = {
> > >  	.set_parent	= ccu_mux_set_parent,
> > >  };
> > >  
> > > +const struct clk_ops spacemit_ccu_sspa_mux_gate_ops = {
> > > +	.disable	= ccu_gate_disable,
> > > +	.enable		= ccu_gate_enable,
> > > +	.is_enabled	= ccu_gate_is_enabled,
> > > +
> > > +	.determine_rate = ccu_mix_determine_rate,
> > > +	.get_parent	= ccu_mux_get_parent,
> > > +	.set_parent	= ccu_mux_set_sspa_parent,
> > > +};
> > > +
> > >  const struct clk_ops spacemit_ccu_div_gate_ops = {
> > >  	.disable	= ccu_gate_disable,
> > >  	.enable		= ccu_gate_enable,
> > > diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
> > > index 51d19f5d6aacb7203d1eddf96047cf3174533601..7753446386353bf849787ed4ec7c85c298238ab5 100644
> > > --- a/drivers/clk/spacemit/ccu_mix.h
> > > +++ b/drivers/clk/spacemit/ccu_mix.h
> > > @@ -124,6 +124,19 @@ static struct ccu_mix _name = {							\
> > >  	}									\
> > >  }
> > >  
> > > +#define CCU_SSPA_MUX_GATE_DEFINE(_name, _parents, _reg_ctrl,			\
> > > +				     _shift, _width, _mask_gate, _flags)	\
> > > +static struct ccu_mix _name = {							\
> > > +	.gate	= CCU_GATE_INIT(_mask_gate),					\
> > > +	.mux	= CCU_MUX_INIT(_shift, _width),					\
> > > +	.common = {								\
> > > +		.reg_ctrl	= _reg_ctrl,					\
> > > +		CCU_MIX_INITHW_PARENTS(_name, _parents,				\
> > > +				       spacemit_ccu_sspa_mux_gate_ops,		\
> > > +				       _flags),					\
> > > +	}									\
> > > +}
> > > +
> > >  #define CCU_DIV_GATE_DEFINE(_name, _parent, _reg_ctrl, _shift, _width,		\
> > >  			    _mask_gate,	_flags)					\
> > >  static struct ccu_mix _name = {							\
> > > @@ -213,6 +226,7 @@ extern const struct clk_ops spacemit_ccu_div_ops;
> > >  extern const struct clk_ops spacemit_ccu_factor_gate_ops;
> > >  extern const struct clk_ops spacemit_ccu_div_gate_ops;
> > >  extern const struct clk_ops spacemit_ccu_mux_gate_ops;
> > > +extern const struct clk_ops spacemit_ccu_sspa_mux_gate_ops;
> > >  extern const struct clk_ops spacemit_ccu_mux_div_ops;
> > >  extern const struct clk_ops spacemit_ccu_mux_div_gate_ops;
> > >  #endif /* _CCU_DIV_H_ */
> > > 
> > > ---
> > > base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
> > > change-id: 20250717-k1-clk-i2s-e4272f1f915b
> > > 
> > > Best regards,
> > > -- 
> > > Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > 
> > > 
> > 
> > -- 
> > Yixun Lan (dlan)
> > 

