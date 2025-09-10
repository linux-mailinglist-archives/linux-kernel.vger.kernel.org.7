Return-Path: <linux-kernel+bounces-810201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB9B5172E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4A11891151
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED131B13F;
	Wed, 10 Sep 2025 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aOhbme1K"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5662C0266
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508295; cv=none; b=Lz8tJs+nxDD6Yq8xZzTTSYmUoGS3UHnEV+WmVIxLnHni6I19ejoEIYGijkpGiA3I4DNGHO249XjLmiZCNX1Liq6MJZUXjzj+gMD7f8d+GfNfuXEDqPEaTzJOcHFYF/gEhPVuqGd+i+tBwEs+Rb0D+MSy7+N0gmlsWB9+bEa5OO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508295; c=relaxed/simple;
	bh=1wIPiHYTTcPWjGCqP0U9W2dlBav5LMFfAO50dplnTqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0VIR6G0+rUA0+ohpCrBH9i2sdZywt+eAr8r+mc9yEAamIPwhpPxt+91BwJbxIJI8LGw82ONHKxmM5h5x6DT9gbyR09KIUM4HtT2l6XPBYmuMmwx364dZAK8aQqvapvWz0OJDsYopFWkB/awjkGjmnXAtmbOsrpcWawyhv0SSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aOhbme1K; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 97ABE22E49;
	Wed, 10 Sep 2025 14:44:49 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26e2zTYJ4SXs; Wed, 10 Sep 2025 14:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757508289; bh=1wIPiHYTTcPWjGCqP0U9W2dlBav5LMFfAO50dplnTqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aOhbme1Kk8YPSM7ceJBX1pyRtZFnV6Xzm4KQUkHwsi2ZtEfCg1D3Jmay9A8yjIuha
	 T9PfaVp1+Oj0819jIECQbSUxU90t4Q5dA/YaUZ0RirFxfdHfrqOmf3QDbJH3EbcTvW
	 HN9pjMCWYvlUi9ngYSdf4nZ+8ccCTS8xsTcBvL8tK06I7Z15350HO1M6WNGDJfSpva
	 tWycDekr4RASfamzAsOutrIeTe3vOG22Ra+QVdqBcZG/jAIDr3KLWL50FWeYdfXw1S
	 TmZs5+UwrJ3GE76Ugr2loTQexId6Fk1OQABYonEbNT6uzkeOLwh4XS6J/rrBKz5UpS
	 nftRIbWCVNHSQ==
Date: Wed, 10 Sep 2025 12:44:23 +0000
From: Yao Zi <ziyao@disroot.org>
To: Chukun Pan <amadeus@jmu.edu.cn>, Vinod Koul <vkoul@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] phy: rockchip: naneng-combphy: use existing DT
 property check for rk3528
Message-ID: <aMFyp1pn5xUJOVtj@pie>
References: <20250910122000.951100-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910122000.951100-1-amadeus@jmu.edu.cn>

On Wed, Sep 10, 2025 at 08:20:00PM +0800, Chukun Pan wrote:
> The naneng-combphy driver already has DT property checks for
> "rockchip,enable-ssc" and "rockchip,ext-refclk", use it for
> the rk3528_combphy_cfg. Also aligned the indentation of the
> rk3528_combphy_grfcfgs parameters (using tabs).
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

I should have noticed this simplification. Thanks for following up,

Reviewed-by: Yao Zi <ziyao@disroot.org>

> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index a3ef19807b9e..ad6c8a11951b 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -518,7 +518,7 @@ static int rk3528_combphy_cfg(struct rockchip_combphy_priv *priv)
>  		return -EINVAL;
>  	}
>  
> -	if (device_property_read_bool(priv->dev, "rockchip,ext-refclk")) {
> +	if (priv->ext_refclk) {
>  		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
>  
>  		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
> @@ -543,11 +543,9 @@ static int rk3528_combphy_cfg(struct rockchip_combphy_priv *priv)
>  		}
>  	}
>  
> -	if (priv->type == PHY_TYPE_PCIE) {
> -		if (device_property_read_bool(priv->dev, "rockchip,enable-ssc"))
> -			rockchip_combphy_updatel(priv, RK3528_PHYREG40_SSC_EN,
> -						 RK3528_PHYREG40_SSC_EN, RK3528_PHYREG40);
> -	}
> +	if (priv->type == PHY_TYPE_PCIE && priv->enable_ssc)
> +		rockchip_combphy_updatel(priv, RK3528_PHYREG40_SSC_EN,
> +					 RK3528_PHYREG40_SSC_EN, RK3528_PHYREG40);
>  
>  	return 0;
>  }
> @@ -571,7 +569,7 @@ static const struct rockchip_combphy_grfcfg rk3528_combphy_grfcfgs = {
>  	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x101 },
>  	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
>  	/* pipe-grf */
> -	.u3otg0_port_en         = { 0x0044, 15, 0, 0x0181, 0x1100 },
> +	.u3otg0_port_en		= { 0x0044, 15, 0, 0x0181, 0x1100 },
>  };
>  
>  static const struct rockchip_combphy_cfg rk3528_combphy_cfgs = {
> -- 
> 2.25.1
> 

