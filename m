Return-Path: <linux-kernel+bounces-736733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61570B0A10F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03051C80DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3476B2BD00C;
	Fri, 18 Jul 2025 10:51:29 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4E72605;
	Fri, 18 Jul 2025 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835888; cv=none; b=l7SdHrPCEx1Cq0jIBcu73QDWEFL3PUtKWr+5afapswq5NzUhkdP1T5ZiP9n1Bdc3Vyc2wu6S0RZVdGETK2im0bUBI9f/caEUrhoH1Cpy+xUMFU22dG6qjBPEi/6C8iWKWtB/0Fo1RoWfKqSZ9sjrAJaZC//v4lKGAwAvrfP67x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835888; c=relaxed/simple;
	bh=/Gsx+ts3YpKYIwk8gzls0dG4v3RZACWf5rg9HyyxU6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K91fFw28mGOJ/jKF6l8wpId/7k4XvrwoXyYefBngg5SLYfQKWcBoxgFk3LGxoioTGpJRKSzM+upDuqAtFiXhJJwox36I8URcOORzhd9fcW7JQBldsaj/3ynlS8fewUd9sGkxHVjToAuYUbh8KBSu/oBPfrbcvz3NkcA6EqClaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2E48833C84E;
	Fri, 18 Jul 2025 10:51:24 +0000 (UTC)
Date: Fri, 18 Jul 2025 18:51:20 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: spacemit: fix sspax_clk
Message-ID: <20250718105120-GYB695709@gentoo>
References: <20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com>

Hi Troy,

On 09:54 Fri 18 Jul     , Troy Mitchell wrote:
> In the SpacemiT public document, when the FNCLKSEL field of
> the APBC_SSPAX_CLK_RST register is 7 (3'b111),
> which is a reserved value. And BIT3 of the same register is
> a reserved bit.
> 
so, if I parse above correctly, it describe current public document?
which value 7 of FNCLKSEL and BIT3 is wrongly marked as reserved.

https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb#10.2.3.2-resource-reset-schemes
10.2.4.3.16 SSPAX CLOCK RESET CONTROL REGISTER (APBC_SSPAX_CLK_RST)

> But the document is wrong, the actual situation is:
> when FNCLKSEL is 7 (3'b111), and the purpose of bit 3 is
> if to select i2s_bclk as the parent clock.
> 
> And only when FNCLKSEL is 7 (3'b111), The bit 3 is not a reserved bit.
> 
so what's the difference of value 7 from other 0-6? has additional ops to
select i2s_bclk as parent? otherwise just say they are not reserved

please have more explanation for BIT3, it's quite obscure and unclear

anyway, can you coordinate with SpacemiT internal to update the docs?

> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  drivers/clk/spacemit/ccu-k1.c  |  4 ++--
>  drivers/clk/spacemit/ccu_mix.c | 29 +++++++++++++++++++++++++++++
>  drivers/clk/spacemit/ccu_mix.h | 14 ++++++++++++++
>  3 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> index cdde37a0523537c2f436e481ae8d6ec5a581b87e..0e22f6fb2c45b68ab20a9b1563a1a6dec1a7e16c 100644
> --- a/drivers/clk/spacemit/ccu-k1.c
> +++ b/drivers/clk/spacemit/ccu-k1.c
> @@ -359,8 +359,8 @@ static const struct clk_parent_data sspa_parents[] = {
>  	CCU_PARENT_HW(pll1_d3072_0p8),
>  	CCU_PARENT_HW(i2s_bclk),
>  };
> -CCU_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
> -CCU_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
> +CCU_SSPA_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
> +CCU_SSPA_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
>  CCU_GATE_DEFINE(dro_clk, CCU_PARENT_HW(apb_clk), APBC_DRO_CLK_RST, BIT(1), 0);
>  CCU_GATE_DEFINE(ir_clk, CCU_PARENT_HW(apb_clk), APBC_IR_CLK_RST, BIT(1), 0);
>  CCU_GATE_DEFINE(tsen_clk, CCU_PARENT_HW(apb_clk), APBC_TSEN_CLK_RST, BIT(1), 0);
> diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
> index 9b852aa61f78aed5256bfe6fc3b01932d6db6256..bfc65fc00df67299523eb5d1d2ed479c61fc6141 100644
> --- a/drivers/clk/spacemit/ccu_mix.c
> +++ b/drivers/clk/spacemit/ccu_mix.c
> @@ -191,6 +191,25 @@ static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
>  	return ccu_mix_trigger_fc(hw);
>  }
>  
> +static int ccu_mux_set_sspa_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_mux_config *mux = &mix->mux;
> +	u32 mask, val;
> +
> +	mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> +	val = index << mux->shift;
> +
> +	if (index == 7) {
> +		mask |= BIT(3);
> +		val |= BIT(3);
> +	}
it occur to me, BIT(3) is kind of a conditional BIT..

what's the behavior of reading/writing to BIT3 when index != 7?
write value will be ignored, read will return zero?

> +
> +	ccu_update(&mix->common, ctrl, mask, val);
> +
> +	return ccu_mix_trigger_fc(hw);
> +}
> +
>  const struct clk_ops spacemit_ccu_gate_ops = {
>  	.disable	= ccu_gate_disable,
>  	.enable		= ccu_gate_enable,
> @@ -235,6 +254,16 @@ const struct clk_ops spacemit_ccu_mux_gate_ops = {
>  	.set_parent	= ccu_mux_set_parent,
>  };
>  
> +const struct clk_ops spacemit_ccu_sspa_mux_gate_ops = {
> +	.disable	= ccu_gate_disable,
> +	.enable		= ccu_gate_enable,
> +	.is_enabled	= ccu_gate_is_enabled,
> +
> +	.determine_rate = ccu_mix_determine_rate,
> +	.get_parent	= ccu_mux_get_parent,
> +	.set_parent	= ccu_mux_set_sspa_parent,
> +};
> +
>  const struct clk_ops spacemit_ccu_div_gate_ops = {
>  	.disable	= ccu_gate_disable,
>  	.enable		= ccu_gate_enable,
> diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
> index 51d19f5d6aacb7203d1eddf96047cf3174533601..7753446386353bf849787ed4ec7c85c298238ab5 100644
> --- a/drivers/clk/spacemit/ccu_mix.h
> +++ b/drivers/clk/spacemit/ccu_mix.h
> @@ -124,6 +124,19 @@ static struct ccu_mix _name = {							\
>  	}									\
>  }
>  
> +#define CCU_SSPA_MUX_GATE_DEFINE(_name, _parents, _reg_ctrl,			\
> +				     _shift, _width, _mask_gate, _flags)	\
> +static struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_mask_gate),					\
> +	.mux	= CCU_MUX_INIT(_shift, _width),					\
> +	.common = {								\
> +		.reg_ctrl	= _reg_ctrl,					\
> +		CCU_MIX_INITHW_PARENTS(_name, _parents,				\
> +				       spacemit_ccu_sspa_mux_gate_ops,		\
> +				       _flags),					\
> +	}									\
> +}
> +
>  #define CCU_DIV_GATE_DEFINE(_name, _parent, _reg_ctrl, _shift, _width,		\
>  			    _mask_gate,	_flags)					\
>  static struct ccu_mix _name = {							\
> @@ -213,6 +226,7 @@ extern const struct clk_ops spacemit_ccu_div_ops;
>  extern const struct clk_ops spacemit_ccu_factor_gate_ops;
>  extern const struct clk_ops spacemit_ccu_div_gate_ops;
>  extern const struct clk_ops spacemit_ccu_mux_gate_ops;
> +extern const struct clk_ops spacemit_ccu_sspa_mux_gate_ops;
>  extern const struct clk_ops spacemit_ccu_mux_div_ops;
>  extern const struct clk_ops spacemit_ccu_mux_div_gate_ops;
>  #endif /* _CCU_DIV_H_ */
> 
> ---
> base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
> change-id: 20250717-k1-clk-i2s-e4272f1f915b
> 
> Best regards,
> -- 
> Troy Mitchell <troy.mitchell@linux.spacemit.com>
> 
> 

-- 
Yixun Lan (dlan)

