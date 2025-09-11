Return-Path: <linux-kernel+bounces-811668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BD4B52C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554711B28302
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0572E7198;
	Thu, 11 Sep 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0xaqUZmp"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029622638AF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580926; cv=none; b=kSCoW8wWL3Sf+liUYmXPyKh6wrm4DSB50o8Ew/LodGTRCNmAH+puJaryliHZ8SXA3nOaTq23sFkbTpeLkg2hU89xdp/3tan2G1VvZFUXuW2HGXKK61SKMujwQ6ZEYM+m+Inr5avlEo9uYBFxGmJQ88vShyo10VodO72AXrnCbKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580926; c=relaxed/simple;
	bh=WSsPdKfsK234bl/7O9owH/NrxVV0vhzUs0XXnMfI1mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhT+n1+T4SQqnUkoLcXFBCU1KV44Zu+pPFrC1CjVsS2qHuh4B/PIWpgriiVF9Iy7dJirBDRtrda2cj4TT8n+dVr3Hz8j3sZkJs6yrKfbu/D3Lc3L7tTWqXW5E3Pbiz3wK0yhUnmj2/QNYvM1KmXN5flUM5txjmqssWSgH4IpWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0xaqUZmp; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=XJUXPxCcIdLyjtfU8oLHAw5Mz9mWtXhRUXrgxmlyQhc=; b=0xaqUZmpSGMQIauSG4v6OVj8wQ
	nJBIJCrzyCZnP+OiqdAhDNBV2UZaxsXE1tmicZyPcqv+ZIsLDMz1abLeXGBzuJphRChOLxz0kYAnT
	19z9Fp4PcdDQg0UcdQhT7pGyfHvYZFYrUfv6t0UxmJSZoTpT1Rwmk+cnoSnvFxnDW59RTiIjyeBge
	2ANVCgC9Z190tSoopNSXKZ3kdWBiDw6ITGvr8vUbH+Np0VZAz2YXd6bSR9bUnnnwhAEA8kiEFzlES
	204E4h4Zj/ENbZyWSZrPLWxXNSyu4aXaMXWaUCqglQoGZGviuz8If38m2Qm8kshvJTR4Yj6bUo8GZ
	jgytAELg==;
Received: from i53875b0e.versanet.de ([83.135.91.14] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uwd5K-0008SP-Jd; Thu, 11 Sep 2025 10:55:18 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: Yao Zi <ziyao@disroot.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chukun Pan <amadeus@jmu.edu.cn>
Subject:
 Re: [PATCH 1/1] phy: rockchip: naneng-combphy: use existing DT property check
 for rk3528
Date: Thu, 11 Sep 2025 10:55:17 +0200
Message-ID: <2049032.8hb0ThOEGa@diego>
In-Reply-To: <20250910122000.951100-1-amadeus@jmu.edu.cn>
References: <20250910122000.951100-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 10. September 2025, 14:20:00 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Chukun Pan:
> The naneng-combphy driver already has DT property checks for
> "rockchip,enable-ssc" and "rockchip,ext-refclk", use it for
> the rk3528_combphy_cfg. Also aligned the indentation of the
> rk3528_combphy_grfcfgs parameters (using tabs).
>=20
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers=
/phy/rockchip/phy-rockchip-naneng-combphy.c
> index a3ef19807b9e..ad6c8a11951b 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -518,7 +518,7 @@ static int rk3528_combphy_cfg(struct rockchip_combphy=
_priv *priv)
>  		return -EINVAL;
>  	}
> =20
> -	if (device_property_read_bool(priv->dev, "rockchip,ext-refclk")) {
> +	if (priv->ext_refclk) {
>  		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
> =20
>  		if (priv->type =3D=3D PHY_TYPE_PCIE && rate =3D=3D REF_CLOCK_100MHz) {
> @@ -543,11 +543,9 @@ static int rk3528_combphy_cfg(struct rockchip_combph=
y_priv *priv)
>  		}
>  	}
> =20
> -	if (priv->type =3D=3D PHY_TYPE_PCIE) {
> -		if (device_property_read_bool(priv->dev, "rockchip,enable-ssc"))
> -			rockchip_combphy_updatel(priv, RK3528_PHYREG40_SSC_EN,
> -						 RK3528_PHYREG40_SSC_EN, RK3528_PHYREG40);
> -	}
> +	if (priv->type =3D=3D PHY_TYPE_PCIE && priv->enable_ssc)
> +		rockchip_combphy_updatel(priv, RK3528_PHYREG40_SSC_EN,
> +					 RK3528_PHYREG40_SSC_EN, RK3528_PHYREG40);
> =20
>  	return 0;
>  }
> @@ -571,7 +569,7 @@ static const struct rockchip_combphy_grfcfg rk3528_co=
mbphy_grfcfgs =3D {
>  	.con2_for_pcie		=3D { 0x0008, 15, 0, 0x00, 0x101 },
>  	.con3_for_pcie		=3D { 0x000c, 15, 0, 0x00, 0x0200 },
>  	/* pipe-grf */
> -	.u3otg0_port_en         =3D { 0x0044, 15, 0, 0x0181, 0x1100 },
> +	.u3otg0_port_en		=3D { 0x0044, 15, 0, 0x0181, 0x1100 },
>  };
> =20
>  static const struct rockchip_combphy_cfg rk3528_combphy_cfgs =3D {
>=20





