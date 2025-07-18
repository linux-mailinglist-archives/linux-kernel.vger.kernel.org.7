Return-Path: <linux-kernel+bounces-736922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22922B0A52E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5515C0A56
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA99E2DC34B;
	Fri, 18 Jul 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="mGgjUE1i"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07631E48A;
	Fri, 18 Jul 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845335; cv=none; b=Hxk0goU/IX4NfmThib2jRlyslk9PfHE6yjyjUDsEv9o4XeEojDhCuC8fxPeaiIcaqMfzIwYODtQZE1bZ0ctvkEob2d0rswDNlgUBhpXnxsyWEir5BNGhOZbBhEFdSbK8ewJCXqP1mTHkGS3QKO/zUKseDFFa2sR01WZ2vwAY+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845335; c=relaxed/simple;
	bh=5qumrwKCdcMv/Nec6eU2M8mBYFnULxUd4djkyuQ8RPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qngfrz4jSUUVg4MyrIYTftMOWeCInq7UVjnvqTpDyHS3pi2/2RCO9RrECdaWM2XPcYBd8ZUobXtKOseE5oPmOZarsopSfq2t6gqxfvgAFIvOmsAu5UyjNH8uolK784pYU+J4P8RqmDRWV2YWTOp9XxSWQNK70lDQJW8nWWgJ5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=mGgjUE1i; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1752845244;
	bh=2nD1I4gcWDWbHuhAQnN5FTbrKFNVqNOqXhxHQM7OVgk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=mGgjUE1i7prVU+OqI+aYMJzXNBFbP4tjVnQolZlHQfdr5lcjTZ6clHZ2xs1BBYZ1h
	 EMin6NRTIRMnZTXQXdnuojKX8Nbl3YV0sIYSdpb7siMpkhi2xG5KG+bP++uStYeoOj
	 Lvbr0pc5UUUV5R+uxFOtkmkXsmTWTcJ9xQSxLP3c=
X-QQ-mid: zesmtpip4t1752845243t7ebf7d17
X-QQ-Originating-IP: v9RxmZrMDsrlB3mUaKXda8mSEoGjws8Wt8speHauxtw=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Jul 2025 21:27:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1174543959159516057
EX-QQ-RecipientCnt: 8
Date: Fri, 18 Jul 2025 21:27:06 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: spacemit: fix sspax_clk
Message-ID: <CBB594905CF0674E+aHpLqh2vVhTdzbEc@troy-wujie14pro-arch>
References: <20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com>
 <20250718105120-GYB695709@gentoo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718105120-GYB695709@gentoo>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N2bAIxLK0elnFQwctiE//NZRI1DelTdTvzyjqZg0PtsV7uOUGZL92uJc
	YhnfwJmI+djhRRFtFUH8rlMrSyn/2f6QHZ/LlxhCTu4nRcDHBLAUs3Xh3v+REjEApuutWVY
	458PfGerhD+Fnow79g1o1kz6AjRK9tjqpE52f05YGSma6FKOZAnYqITXqtc0EUv0nOx8mMZ
	HY9/NDyG0Nvk4Xqq6yHIsDqvhWfkFZV+xXrv+tOPk9Kk4tjAEDxdEA+HU1GJZmKHvJh7E2I
	+K6XgHB0ajJAKallzXxudIJbSXTdhjqgvGh4J3OLLnGeyob8L0lCUhFWqs8GeDq5HaYEDxK
	uaEp0tQ3RYXius8kD2u4f3gIYVl+c06JXYcxRGTSxSZy47sBCH17Te8KuMEEiuqH9CkDRQD
	RqkQ1h4Ug6hWisr2HQH1Mo1Raw41COd6iQD4zDIMNhxSqdGNgRxW021eOhN6MTnRjK+81yP
	MffwBGzHF35UBzWbSUIDVP4aCUALe2uLG90ipq5RayMbT9E10hOSp0UwlX3DFDqKStgECff
	Mx/BSaWBwP1pnbOmYM2qaSOKuBh8UnScOjMRIsFImy5Hvv308Ip/8Fm2NNCn26cWmM+Ts56
	OVdZ3arGdKfb2vlR+KlE1mQJd7+qHTjxnAirPuhLvmu0+ocVbzzvkdxPjEWlMxgV++7XRQO
	qoFE69nRZSVzMGMhAhs3FJQznm+eYHezBgfKEw9oJTgMjsEwbiZlc+dSxAhuv07xh0gcYCk
	UX9ld6vu/0VBVWArwS5aCiRyQeOeQ3SMPjTlBXhRSQ47/yAJVD8IIoiuEak3j5DU5EjNtvi
	wWgdbZGictH1d9ddQDNAchjfXNjdqPolWXEHgNX3aHEP+ZlHRvsjcz55DxqHUZgxxgj5vYX
	gj/asL1mE7xTAGdWqfjX1VgI3OGRQia9I59P7beNT0oOrKnDSEIspgs9EnHDUI9Cm9EwVVa
	Y0AvEFuG9ZkHGkX0qrQ9cvGofymOFJ+7NMF/iGv8+pzg8vXsebQjb5U61Kkd5bCv5gjZoo+
	+nBiWM83oK/2Wky/22GGLIwjmWjvMOn61/ERi/gbFmYM3vKZlz2C94LikXpdBTi94CT7N77
	CXA6NWbjTrb
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Fri, Jul 18, 2025 at 06:51:20PM +0800, Yixun Lan wrote:
> Hi Troy,
> 
> On 09:54 Fri 18 Jul     , Troy Mitchell wrote:
> > In the SpacemiT public document, when the FNCLKSEL field of
> > the APBC_SSPAX_CLK_RST register is 7 (3'b111),
> > which is a reserved value. And BIT3 of the same register is
> > a reserved bit.
> > 
> so, if I parse above correctly, it describe current public document?
> which value 7 of FNCLKSEL and BIT3 is wrongly marked as reserved.
> 
> https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb#10.2.3.2-resource-reset-schemes
> 10.2.4.3.16 SSPAX CLOCK RESET CONTROL REGISTER (APBC_SSPAX_CLK_RST)
> 
yes, correct summary

> > But the document is wrong, the actual situation is:
> > when FNCLKSEL is 7 (3'b111), and the purpose of bit 3 is
> > if to select i2s_bclk as the parent clock.
> > 
> > And only when FNCLKSEL is 7 (3'b111), The bit 3 is not a reserved bit.
> > 
> so what's the difference of value 7 from other 0-6? has additional ops to
> select i2s_bclk as parent? otherwise just say they are not reserved
> 
> please have more explanation for BIT3, it's quite obscure and unclear
Bit 3 is only valid when FNCLKSEL is 7,
indicating whether i2s_bclk is selected as the clock source.
And when FNCLKSEL is 7, bit 3 must be 1, otherwise it will cause unknown errors.
When FNCLKSEL is other values, bit 3 has no effect

I'll explain more in the next version

> 
> anyway, can you coordinate with SpacemiT internal to update the docs?
> 
I have already told them. I think the document will be updated ASAP.

> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> >  drivers/clk/spacemit/ccu-k1.c  |  4 ++--
> >  drivers/clk/spacemit/ccu_mix.c | 29 +++++++++++++++++++++++++++++
> >  drivers/clk/spacemit/ccu_mix.h | 14 ++++++++++++++
> >  3 files changed, 45 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> > index cdde37a0523537c2f436e481ae8d6ec5a581b87e..0e22f6fb2c45b68ab20a9b1563a1a6dec1a7e16c 100644
> > --- a/drivers/clk/spacemit/ccu-k1.c
> > +++ b/drivers/clk/spacemit/ccu-k1.c
> > @@ -359,8 +359,8 @@ static const struct clk_parent_data sspa_parents[] = {
> >  	CCU_PARENT_HW(pll1_d3072_0p8),
> >  	CCU_PARENT_HW(i2s_bclk),
> >  };
> > -CCU_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
> > -CCU_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
> > +CCU_SSPA_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
> > +CCU_SSPA_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
> >  CCU_GATE_DEFINE(dro_clk, CCU_PARENT_HW(apb_clk), APBC_DRO_CLK_RST, BIT(1), 0);
> >  CCU_GATE_DEFINE(ir_clk, CCU_PARENT_HW(apb_clk), APBC_IR_CLK_RST, BIT(1), 0);
> >  CCU_GATE_DEFINE(tsen_clk, CCU_PARENT_HW(apb_clk), APBC_TSEN_CLK_RST, BIT(1), 0);
> > diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
> > index 9b852aa61f78aed5256bfe6fc3b01932d6db6256..bfc65fc00df67299523eb5d1d2ed479c61fc6141 100644
> > --- a/drivers/clk/spacemit/ccu_mix.c
> > +++ b/drivers/clk/spacemit/ccu_mix.c
> > @@ -191,6 +191,25 @@ static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
> >  	return ccu_mix_trigger_fc(hw);
> >  }
> >  
> > +static int ccu_mux_set_sspa_parent(struct clk_hw *hw, u8 index)
> > +{
> > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > +	struct ccu_mux_config *mux = &mix->mux;
> > +	u32 mask, val;
> > +
> > +	mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> > +	val = index << mux->shift;
> > +
> > +	if (index == 7) {
> > +		mask |= BIT(3);
> > +		val |= BIT(3);
> > +	}
> it occur to me, BIT(3) is kind of a conditional BIT..
> 
> what's the behavior of reading/writing to BIT3 when index != 7?
> write value will be ignored, read will return zero?
I don't know. I haven't tested it, and I don't think it's worth testing.
I've written a function to set the parent using BIT(3) and an index.
Therefore, when the caller invokes get_parent, BIT(3) is not considered; only the index is.

                - Troy

> 
> > +
> > +	ccu_update(&mix->common, ctrl, mask, val);
> > +
> > +	return ccu_mix_trigger_fc(hw);
> > +}
> > +
> >  const struct clk_ops spacemit_ccu_gate_ops = {
> >  	.disable	= ccu_gate_disable,
> >  	.enable		= ccu_gate_enable,
> > @@ -235,6 +254,16 @@ const struct clk_ops spacemit_ccu_mux_gate_ops = {
> >  	.set_parent	= ccu_mux_set_parent,
> >  };
> >  
> > +const struct clk_ops spacemit_ccu_sspa_mux_gate_ops = {
> > +	.disable	= ccu_gate_disable,
> > +	.enable		= ccu_gate_enable,
> > +	.is_enabled	= ccu_gate_is_enabled,
> > +
> > +	.determine_rate = ccu_mix_determine_rate,
> > +	.get_parent	= ccu_mux_get_parent,
> > +	.set_parent	= ccu_mux_set_sspa_parent,
> > +};
> > +
> >  const struct clk_ops spacemit_ccu_div_gate_ops = {
> >  	.disable	= ccu_gate_disable,
> >  	.enable		= ccu_gate_enable,
> > diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
> > index 51d19f5d6aacb7203d1eddf96047cf3174533601..7753446386353bf849787ed4ec7c85c298238ab5 100644
> > --- a/drivers/clk/spacemit/ccu_mix.h
> > +++ b/drivers/clk/spacemit/ccu_mix.h
> > @@ -124,6 +124,19 @@ static struct ccu_mix _name = {							\
> >  	}									\
> >  }
> >  
> > +#define CCU_SSPA_MUX_GATE_DEFINE(_name, _parents, _reg_ctrl,			\
> > +				     _shift, _width, _mask_gate, _flags)	\
> > +static struct ccu_mix _name = {							\
> > +	.gate	= CCU_GATE_INIT(_mask_gate),					\
> > +	.mux	= CCU_MUX_INIT(_shift, _width),					\
> > +	.common = {								\
> > +		.reg_ctrl	= _reg_ctrl,					\
> > +		CCU_MIX_INITHW_PARENTS(_name, _parents,				\
> > +				       spacemit_ccu_sspa_mux_gate_ops,		\
> > +				       _flags),					\
> > +	}									\
> > +}
> > +
> >  #define CCU_DIV_GATE_DEFINE(_name, _parent, _reg_ctrl, _shift, _width,		\
> >  			    _mask_gate,	_flags)					\
> >  static struct ccu_mix _name = {							\
> > @@ -213,6 +226,7 @@ extern const struct clk_ops spacemit_ccu_div_ops;
> >  extern const struct clk_ops spacemit_ccu_factor_gate_ops;
> >  extern const struct clk_ops spacemit_ccu_div_gate_ops;
> >  extern const struct clk_ops spacemit_ccu_mux_gate_ops;
> > +extern const struct clk_ops spacemit_ccu_sspa_mux_gate_ops;
> >  extern const struct clk_ops spacemit_ccu_mux_div_ops;
> >  extern const struct clk_ops spacemit_ccu_mux_div_gate_ops;
> >  #endif /* _CCU_DIV_H_ */
> > 
> > ---
> > base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
> > change-id: 20250717-k1-clk-i2s-e4272f1f915b
> > 
> > Best regards,
> > -- 
> > Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > 
> > 
> 
> -- 
> Yixun Lan (dlan)
> 

