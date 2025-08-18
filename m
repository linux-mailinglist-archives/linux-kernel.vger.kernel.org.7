Return-Path: <linux-kernel+bounces-773327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8190CB29E57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F19189C10D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB22930F7E9;
	Mon, 18 Aug 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="ehE1dNDf";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="0jyHjazn"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CE21CA0C;
	Mon, 18 Aug 2025 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510561; cv=none; b=hk5m3cbbZZCjeSv5/0QqbqAwlg9na12qRmDSbQ8RhZ/MHlZF7nXYnHtHmOBIoWSHVpa+xGEjACCLdBEvDjWEPJ75owGcmsGJ4WPEcATdUZ+1h8tkEW95wWUAtAmH61ZE74erVVWE2sli1fJmz6+mjmnoO8qAGoZ9+8keexoQ9qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510561; c=relaxed/simple;
	bh=G/TSilIIny419+wjwN/t2gGm9Hi+eIHM7DbXOJEDR/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aveHUAh8i6kVDRpFBw0oe5YhK1FSg2XAUcl1pNjrt2E1+zwzSoN9DSTRHf2HvDgKhj+P6qtlTgciBttK4wDuxKvfVY6AhatT8+TrnfZYYdM4K1AGlPG68waBrbTQh8dc1qYizOgv5+9BmokAQfa6ta+mifWa3xciE0gb4okLYoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=ehE1dNDf; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=0jyHjazn; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from localhost (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 8FF6F12FB9DF;
	Mon, 18 Aug 2025 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1755510557; bh=G/TSilIIny419+wjwN/t2gGm9Hi+eIHM7DbXOJEDR/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehE1dNDflSHrSI1XDw3/kMTk6XunMr7pZkesptPP9ZcgZ9eQHS21I5gFj65Bspvic
	 9SOilobYM2UxwooLW6ojkDUVnatWPEaYq9/DNS00ab3LmAjE840weuQeaUrUI02TTw
	 MzotrWhuc+v1vP6OOwdFNdl/AV259boFpcbE/OaMA9Ayl33hr3e04kNxtZKUq2Gi7M
	 hllbooq0QeV7EddmJZIMKnD7hL+s/fpgOfkawrCfaON1YupZUB91zVDq09y92q0/MI
	 3y8HeddVCRQi4rp92E/HKQYy2pf2m7poCJH8PIvKVJoYrJyEzx7TC0+j/gow9fESJB
	 w69GhLgWYqxwA==
X-Virus-Scanned: amavis at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by localhost (bayard.4d2.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRxjUVBxbqYv; Mon, 18 Aug 2025 02:49:16 -0700 (PDT)
Received: from ketchup (unknown [117.171.67.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 58EE012FB42D;
	Mon, 18 Aug 2025 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1755510556; bh=G/TSilIIny419+wjwN/t2gGm9Hi+eIHM7DbXOJEDR/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0jyHjaznbZLTd5hBz72tL6eH29OiPyRhhDBoTFL3eIAEJ3iQWDz+kx7mlDgQV1CK0
	 fIKTsi2ba5WbwjqD2gSVID+zmaJPLOvl8kN0JPeZjXlO9LAFeWOdDnIi0zzoRBG3/5
	 1SrbHlFceI7LpiroCT+jH1hLANLpY5ikQSWZooUN8PMmHChGOYKKRx3Vqv+CUyZ7St
	 wY3f+TlRA5n7yf1EQcn7d0mNllzO4GwrdMF0Z9PT+JEk3uNDM/mtvvLGZlE9wcC4uO
	 bPmcoKppUWojRn4/jnajtjgm+Ke1aVGMUrDTMdT6Kbikk1E9ixtpc7VKPtjoS7X8gc
	 TyOe8sQjx1VFA==
Date: Mon, 18 Aug 2025 09:49:10 +0000
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
Subject: Re: [PATCH v3 2/3] clk: spacemit: introduce pre-div for ddn clock
Message-ID: <aKL3FghKPUaQcagM@ketchup>
References: <20250818-k1-clk-i2s-generation-v3-0-8139b22ae709@linux.spacemit.com>
 <20250818-k1-clk-i2s-generation-v3-2-8139b22ae709@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-k1-clk-i2s-generation-v3-2-8139b22ae709@linux.spacemit.com>

On Mon, Aug 18, 2025 at 05:28:21PM +0800, Troy Mitchell wrote:
> The original DDN operations applied an implicit divide-by-2, which should
> not be a default behavior.
> 
> This patch removes that assumption, letting each clock define its
> actual behavior explicitly.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  drivers/clk/spacemit/ccu-k1.c  |  4 ++--
>  drivers/clk/spacemit/ccu_ddn.c | 12 ++++++------
>  drivers/clk/spacemit/ccu_ddn.h |  6 ++++--
>  3 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Haylen Chu <heylenay@4d2.org>

> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> index 65e6de030717afa60eefab7bda88f9a13b857650..7155824673fb450971439873b6b6163faf48c7e5 100644
> --- a/drivers/clk/spacemit/ccu-k1.c
> +++ b/drivers/clk/spacemit/ccu-k1.c
> @@ -136,8 +136,8 @@ CCU_GATE_DEFINE(pll1_d3_819p2, CCU_PARENT_HW(pll1_d3), MPMU_ACGR, BIT(14), 0);
>  CCU_GATE_DEFINE(pll1_d2_1228p8, CCU_PARENT_HW(pll1_d2), MPMU_ACGR, BIT(16), 0);
>  
>  CCU_GATE_DEFINE(slow_uart, CCU_PARENT_NAME(osc), MPMU_ACGR, BIT(1), CLK_IGNORE_UNUSED);
> -CCU_DDN_DEFINE(slow_uart1_14p74, pll1_d16_153p6, MPMU_SUCCR, 16, 13, 0, 13, 0);
> -CCU_DDN_DEFINE(slow_uart2_48, pll1_d4_614p4, MPMU_SUCCR_1, 16, 13, 0, 13, 0);
> +CCU_DDN_DEFINE(slow_uart1_14p74, pll1_d16_153p6, MPMU_SUCCR, 16, 13, 0, 13, 2, 0);
> +CCU_DDN_DEFINE(slow_uart2_48, pll1_d4_614p4, MPMU_SUCCR_1, 16, 13, 0, 13, 2, 0);
>  
>  CCU_GATE_DEFINE(wdt_clk, CCU_PARENT_HW(pll1_d96_25p6), MPMU_WDTPCR, BIT(1), 0);
>  
> diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_ddn.c
> index be311b045698e95a688a35858a8ac1bcfbffd2c7..06d86748182bd1959cdab5c18d0a882ee25dcade 100644
> --- a/drivers/clk/spacemit/ccu_ddn.c
> +++ b/drivers/clk/spacemit/ccu_ddn.c
> @@ -22,21 +22,21 @@
>  
>  #include "ccu_ddn.h"
>  
> -static unsigned long ccu_ddn_calc_rate(unsigned long prate,
> -				       unsigned long num, unsigned long den)
> +static unsigned long ccu_ddn_calc_rate(unsigned long prate, unsigned long num,
> +				       unsigned long den, unsigned int pre_div)
>  {
> -	return prate * den / 2 / num;
> +	return prate * den / pre_div / num;
>  }
>  
>  static unsigned long ccu_ddn_calc_best_rate(struct ccu_ddn *ddn,
>  					    unsigned long rate, unsigned long prate,
>  					    unsigned long *num, unsigned long *den)
>  {
> -	rational_best_approximation(rate, prate / 2,
> +	rational_best_approximation(rate, prate / ddn->pre_div,
>  				    ddn->den_mask >> ddn->den_shift,
>  				    ddn->num_mask >> ddn->num_shift,
>  				    den, num);
> -	return ccu_ddn_calc_rate(prate, *num, *den);
> +	return ccu_ddn_calc_rate(prate, *num, *den, ddn->pre_div);
>  }
>  
>  static long ccu_ddn_round_rate(struct clk_hw *hw, unsigned long rate,
> @@ -58,7 +58,7 @@ static unsigned long ccu_ddn_recalc_rate(struct clk_hw *hw, unsigned long prate)
>  	num = (val & ddn->num_mask) >> ddn->num_shift;
>  	den = (val & ddn->den_mask) >> ddn->den_shift;
>  
> -	return ccu_ddn_calc_rate(prate, num, den);
> +	return ccu_ddn_calc_rate(prate, num, den, ddn->pre_div);
>  }
>  
>  static int ccu_ddn_set_rate(struct clk_hw *hw, unsigned long rate,
> diff --git a/drivers/clk/spacemit/ccu_ddn.h b/drivers/clk/spacemit/ccu_ddn.h
> index a52fabe77d62eba16426867a9c13481e72f025c0..4838414a8e8dc04af49d3b8d39280efedbd75616 100644
> --- a/drivers/clk/spacemit/ccu_ddn.h
> +++ b/drivers/clk/spacemit/ccu_ddn.h
> @@ -18,13 +18,14 @@ struct ccu_ddn {
>  	unsigned int num_shift;
>  	unsigned int den_mask;
>  	unsigned int den_shift;
> +	unsigned int pre_div;
>  };
>  
>  #define CCU_DDN_INIT(_name, _parent, _flags) \
>  	CLK_HW_INIT_HW(#_name, &_parent.common.hw, &spacemit_ccu_ddn_ops, _flags)
>  
>  #define CCU_DDN_DEFINE(_name, _parent, _reg_ctrl, _num_shift, _num_width,	\
> -		       _den_shift, _den_width, _flags)				\
> +		       _den_shift, _den_width, _pre_div, _flags)		\
>  static struct ccu_ddn _name = {							\
>  	.common = {								\
>  		.reg_ctrl	= _reg_ctrl,					\
> @@ -33,7 +34,8 @@ static struct ccu_ddn _name = {							\
>  	.num_mask	= GENMASK(_num_shift + _num_width - 1, _num_shift),	\
>  	.num_shift	= _num_shift,						\
>  	.den_mask	= GENMASK(_den_shift + _den_width - 1, _den_shift),	\
> -	.den_shift	= _den_shift,					\
> +	.den_shift	= _den_shift,						\
> +	.pre_div	= _pre_div,						\
>  }
>  
>  static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)
> 
> -- 
> 2.50.1
> 

