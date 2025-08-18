Return-Path: <linux-kernel+bounces-772730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1CCB296E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D10D20051F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D636824A046;
	Mon, 18 Aug 2025 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="jKd7RZRO";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="1So0BoUQ"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3625E242D9D;
	Mon, 18 Aug 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483615; cv=none; b=n/gPzg0zSphdDl7XyAnJ3ozHczTHY2cRoDNpYROF0hUSJmKN7OMBRoSo3NFfOMDEgUiCKz5YnYE/IvIZy1bs8iD9yzgN548aYfLOd5vmu7BS8KOypiVZpov6ZqdqTUZVCkZwSTByk8Yfsh/o/09q2ZbK5LR28E5ah+5T0OkrIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483615; c=relaxed/simple;
	bh=CosjTx8va6pZLipoVSMb7IfvL5LyoiBbXc+YFlVKM3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBupm3hiHs4/fu/YfXeHYSAm0OoI6F7QK5irsQ/Ftw28DGAwP6EDWm+xQ+cagLuJanYlyxvgsLCtdVQwiKK59NmGKLYohouNGcWFTXaCwPO8IkDwxmLbsOVPz85qDfyKLA0QoR2yO4TP6CQ4CTNdMOEFqdQmHkG1WkiCQ7DHYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=jKd7RZRO; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=1So0BoUQ; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from localhost (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 601D212FB9DF;
	Sun, 17 Aug 2025 19:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1755483611; bh=CosjTx8va6pZLipoVSMb7IfvL5LyoiBbXc+YFlVKM3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKd7RZROZzJo+OndANBCZgUnVOskBkHpvNFl2tjW6XtsX/3nFvkp+mgtnGy/rNYpL
	 YwdW5LavHind787x7HHooeG3JpRPh3c7DMTHI0QFLxG3z80IcduQqZOABVrjVRiLJ+
	 aN1Jn6cy/8qUUfraB293lKCpj5C/cTZTqfG11cphRYLXuh5ZBPYuRNtmU3GK8/Soh6
	 R8rofEidDDM0WbnYD88xSfR7hiirO6+xjSCZKkGYObtN6ND92/Ra3NcLkuDGos+C2q
	 WGCJDBn0g+DVPv9bKK1FES9OoWWrtIPgjYXJ8/ncZt9i7i9HqWmOCpR+0dlrf9w3Pj
	 Ep7NKXPxD1hRg==
X-Virus-Scanned: amavis at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by localhost (bayard.4d2.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B96bH3ge1wco; Sun, 17 Aug 2025 19:20:09 -0700 (PDT)
Received: from ketchup (unknown [117.171.67.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 1347812FB42D;
	Sun, 17 Aug 2025 19:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1755483609; bh=CosjTx8va6pZLipoVSMb7IfvL5LyoiBbXc+YFlVKM3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1So0BoUQ6dU7KkwneIlzTB4pXnuu2j4nsFqptUv6c3xjIB3hz34lVn4WNAxUjqPOb
	 oK4XoIteGigE85GdgWeRIT8vCWIxcOJtDzQfPB+lyVcEBnyIj65OPCTd/W7mpfItKn
	 msze26BBfucHXBRvbiIpo1c09u5o4POp9jZzHLFsuq3+Yx5ubo1Sn+fBHiEsgdfoRy
	 QBFfjjzUtOI6UGZuWgMeYAfH4DGyqYUmalhh6/Sm6bYx4f46Z3AvTWxuCYnsvycs0p
	 WpLd6cKbXtZkPpu4ZfHHt4lYr5J/raj/5uQsRO2KceMEPCDuRe0QMXQ3hc3fYjjXsr
	 OC6n5P9nsJZwQ==
Date: Mon, 18 Aug 2025 02:20:03 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Alex Elder <elder@riscstar.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH v2 3/4] clk: spacemit: introduce factor for div clock
Message-ID: <aKKN05w88uKP_HY7@ketchup>
References: <20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com>
 <20250811-k1-clk-i2s-generation-v2-3-e4d3ec268b7a@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-k1-clk-i2s-generation-v2-3-e4d3ec268b7a@linux.spacemit.com>

On Mon, Aug 11, 2025 at 10:04:29PM +0800, Troy Mitchell wrote:
> From the definition of register, The i2s_bclk is a non-linear,
> discrete divider clock.
> 
> The following table shows the correspondence between index
> and frequency division coefficients:
> 
> | index |  div  |
> |-------|-------|
> |   0   |   2   |
> |   1   |   4   |
> |   2   |   6   |
> |   3   |   8   |
> 
> But from a software perspective and this table, dividing the
> actual div value by 2 is sufficient to obtain a continuous
> divider clock.
> 
> Rather than introducing a new clock type to handle this case,
> a factor parameter has been added to CCU_DIV_GATE_DEFINE.

Actually, I expected you to represent the factor simply with
CCU_FACTOR_DEFINE, introducing no new clock-calculation code...

> Suggested-by: Haylen Chu <heylenay@4d2.org>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  drivers/clk/spacemit/ccu_mix.c | 7 ++++++-
>  drivers/clk/spacemit/ccu_mix.h | 4 +++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
> index 9b852aa61f78aed5256bfe6fc3b01932d6db6256..dbd2cf234bf81d8e110b19868ff9af7373e2ab55 100644
> --- a/drivers/clk/spacemit/ccu_mix.c
> +++ b/drivers/clk/spacemit/ccu_mix.c
> @@ -56,7 +56,10 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
>  	val = ccu_read(&mix->common, ctrl) >> div->shift;
>  	val &= (1 << div->width) - 1;
>  
> -	return divider_recalc_rate(hw, parent_rate, val, NULL, 0, div->width);
> +	if (!div->factor)
> +		return divider_recalc_rate(hw, parent_rate, val, NULL, 0, div->width);

Please adapt all div-related macros to make them assign one to the
factor, which helps you get rid of this if and the one in
ccu_mix_calc_best_rate().

> +	return divider_recalc_rate(hw, parent_rate, val, NULL, 0, div->width) / div->factor;
>  }
>  
>  /*
> @@ -115,6 +118,8 @@ ccu_mix_calc_best_rate(struct clk_hw *hw, unsigned long rate,
>  
>  		for (int j = 1; j <= div_max; j++) {
>  			unsigned long tmp = DIV_ROUND_CLOSEST_ULL(parent_rate, j);
> +			if (mix->div.factor)
			---- this if ------

> +				tmp /= mix->div.factor;
>  
>  			if (abs(tmp - rate) < abs(best_rate - rate)) {
>  				best_rate = tmp;
> diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
> index 54d40cd39b2752260f57d2a96eb8d3eed8116ecd..7dd00d24ec4b1dab70663b9cb7b9ebb02abeaecb 100644
> --- a/drivers/clk/spacemit/ccu_mix.h
> +++ b/drivers/clk/spacemit/ccu_mix.h
> @@ -34,6 +34,7 @@ struct ccu_mux_config {
>  struct ccu_div_config {
>  	u8 shift;
>  	u8 width;
> +	unsigned int factor;
>  };
>  
>  struct ccu_mix {
> @@ -130,10 +131,11 @@ static struct ccu_mix _name = {							\
>  }
>  
>  #define CCU_DIV_GATE_DEFINE(_name, _parent, _reg_ctrl, _shift, _width,		\
> -			    _mask_gate,	_flags)					\
> +			    _mask_gate,	_factor, _flags)			\

This isn't that consistent: why could only divider-gate come with a
factor? This is another reason why I think representing the factor
separately with the CCU_FACTOR_DEFINE() macro is better.

>  static struct ccu_mix _name = {							\
>  	.gate	= CCU_GATE_INIT(_mask_gate),					\
>  	.div	= CCU_DIV_INIT(_shift, _width),					\
> +	.div.factor = _factor,						\
>  	.common = {								\
>  		.reg_ctrl	= _reg_ctrl,					\
>  		CCU_MIX_INITHW(_name, _parent, spacemit_ccu_div_gate_ops,	\
> 
> -- 
> 2.50.1
> 

Best regards,
Haylen Chu

