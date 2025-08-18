Return-Path: <linux-kernel+bounces-772736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA7BB296F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454692024F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BB2253F14;
	Mon, 18 Aug 2025 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="ZoO947AB";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="NgVT2PLT"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8525393E;
	Mon, 18 Aug 2025 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483879; cv=none; b=CzfgtJpNcv71Vrrv0bUnPanJHG1zN6aO1vik9e42+Y0jO5NASXaAydxDb32hGvIa+7ytfxeXt7bjq3Uw6Mji7uybnfdK8ahDzvapPo127euZy6BuXVY7z5k8dcUSHpBWSxBWFC6YJhxp0HTHvpoOSpz2mOvp4PD1xv98s+cP6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483879; c=relaxed/simple;
	bh=vmgf6Iy8E5Y06hvRZJiCIQpCML8yq75/Wn8/BgaN/5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+jxF0XhvSRdhVY3VPsMIvIcSFw4WsJ4oXlaAXlLoxMp8Sdx9+VsyvpaKYzIaUWK4Ur8cz0eiCAh3FiSBCciy4lf9B5PL5CLu92exrwePsWNqvCgAbC37hPdb7ZqdIsQcDBOVw9oO9/o4YR9FF7U/zXsegfUTFwnfa8KOrhjdEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=ZoO947AB; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=NgVT2PLT; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from localhost (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 6FF9A12FB458;
	Sun, 17 Aug 2025 19:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1755482689; bh=vmgf6Iy8E5Y06hvRZJiCIQpCML8yq75/Wn8/BgaN/5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZoO947ABqI1/DEJPMNYnCSQHsTMbnmfI1Dw3WxPN60lOd+AfnT95cNlkpGN+hWtpa
	 9FK8YEcEHT/Cu6ofmanL7cwc7FjzGyIAMcAz0+p5uOLAG5kn4KKSofCeSph9hzh52l
	 1qMPUi6k+WeW/DIxRPaF1cYMLvW+32NXSSYflvoFMtsmUPiU2+s9X4GB5xR2vGHBmd
	 CbsPTQiorEseJrrqF5cOBEc7N3D1ahjiG3d/PtBOPn9FQvjTfgQHUA5BZzDetVnSan
	 dMmZdWWCE9PrKwBX4vIR/hwa1K8BGunLCQR+f1ctE+vzMulPIOqtvFP1Aoew3LzTQA
	 xFYiQUUZaVy3g==
X-Virus-Scanned: amavis at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by localhost (bayard.4d2.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4LgxnyKFoWQD; Sun, 17 Aug 2025 19:04:47 -0700 (PDT)
Received: from ketchup (unknown [117.171.67.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 4DB0F12FB42D;
	Sun, 17 Aug 2025 19:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1755482687; bh=vmgf6Iy8E5Y06hvRZJiCIQpCML8yq75/Wn8/BgaN/5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgVT2PLTL4OMlp9rouNeBHxswTSWdep5o/b02lF0rD+/ILW7rlhHbHW/SogckXhdO
	 D+l4QKgmzWKYVNiMw7q8fAAhjEWMMNyq5RUJKy7NEBk4hh7A0tOD4Hz3j0VBt83NNh
	 wyy24ZW1W13qmwRg8kptJ5+n2+KLnK5P46JCCk1nvz8BoQCYMkjLLyU0VJYLKresRe
	 t2jur8XtTJ2Gee5ziFU5CVtHXX3pBRcqbRWXD7nY6ygMhRawzrbdO0h3aRVj+q+tPI
	 VHvaJmRjtz+yCnB7MC/mVbefU6ZkqFOwMkPk0JzhQpvT7IyXCWp6JhBcruTCyJpNv8
	 C5RI6TTj8dGiA==
Date: Mon, 18 Aug 2025 02:04:39 +0000
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
Subject: Re: [PATCH v2 2/4] clk: spacemit: introduce pre-div for ddn clock
Message-ID: <aKKKNynq-w89YeAx@ketchup>
References: <20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com>
 <20250811-k1-clk-i2s-generation-v2-2-e4d3ec268b7a@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-k1-clk-i2s-generation-v2-2-e4d3ec268b7a@linux.spacemit.com>

On Mon, Aug 11, 2025 at 10:04:28PM +0800, Troy Mitchell wrote:
> The original DDN operations applied an implicit divide-by-2, which should
> not be a default behavior.
> 
> This patch removes that assumption, letting each clock define its
> actual behavior explicitly.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  drivers/clk/spacemit/ccu_ddn.c | 12 ++++++------
>  drivers/clk/spacemit/ccu_ddn.h |  6 ++++--
>  2 files changed, 10 insertions(+), 8 deletions(-)

The code change looks good to me, but

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

You changed the definition of CCU_DDN_DEFINE without adjusting consumers
of this macro. If I'm correct, this creates a build failure.

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

Best regards,
Haylen Chu

