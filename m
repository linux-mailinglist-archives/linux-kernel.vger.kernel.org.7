Return-Path: <linux-kernel+bounces-859082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D9BECAD0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E10719C7F4D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36A22EB85E;
	Sat, 18 Oct 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F0CUNsP+"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E043BB5A
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760777303; cv=none; b=qwrUJR52r0qwvdT/bXB7UwJWf3twWqpvM5emqeUoWsB2x6DPpfg1fmNWDlZgST8P0B1CjTkilcqFqWgtpY1IDLQRnJQh8LWvguE4OPrB595DwWcViNglXohWrU3U0Eo/UFDpPD8gU3QG/jLHv5rXu0G8L5anxUSrCUkK9HXtZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760777303; c=relaxed/simple;
	bh=a6yt1sYHO7l+2ZazczYgE+U9g3OwKpv0qcoao/VU/Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcZ/qb0QjUfQ1bHrOOrhVOcjYJMyxBDq8Oixpj9SrssxMAIdOBADB9J0bc7IM8PEYH/qnu3k/wwAUYj9eYR6SifG5hdgUBkfF/gXSsvFe8P8CcnP4Hk7TepwPrGjxIzoDl3Ou1aIa+I/jm+KR29CEW8kf2F9FW5mhWqB1qhvNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F0CUNsP+; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B83804E4117F;
	Sat, 18 Oct 2025 08:39:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 77B976069D;
	Sat, 18 Oct 2025 08:39:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD248102F2381;
	Sat, 18 Oct 2025 10:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760776751; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=8S3Aw7T2SB9A7fRoHuqc65RzNYJ3PgdKFOvKJcYpYTI=;
	b=F0CUNsP+knRQ2UXE8tq1L2AV80AjADHWTSIojOOI2xe+QHdG44FUdTlNnFK/vdZwoLRw7A
	rWIO1cweAfRFp+VUKts/rcKRCvaaO6Jl9uEBHhCMwVDYPanDTI/g4Rk5K5O/OrakL2dtTc
	ffv23e4KMA4WuKv8JQr/DtjCkM1qqFu1Bafuy6tMW5gkg1e4Mr7xpA+keZ9Hxy5EYs1b52
	WNkWAF/3NKUlVzIlBRQRZQT64jATLbsHw/zTyl9/54fJeGjXMBza6aepec33CRxpIzao50
	oUH4JOSw8ctzjaRrbR/1cHSkKQ5hE7W0+YfeJH4k+iDU/w8S10X0K25iz874jQ==
Message-ID: <86845e2f-92a8-4d1f-aa78-11ad0545a32c@bootlin.com>
Date: Sat, 18 Oct 2025 10:38:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-net v2 2/7] net: dsa: lantiq_gswip: convert accessors
 to use regmap
To: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Peter Christen <peter.christen@siemens.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu
 <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
 Juraj Povazanec <jpovazanec@maxlinear.com>,
 "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
 "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 "Livia M. Rosu" <lrosu@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1760753833.git.daniel@makrotopia.org>
 <a9138cef298126eeecf2536d55e0670068217332.1760753833.git.daniel@makrotopia.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <a9138cef298126eeecf2536d55e0670068217332.1760753833.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Daniel,

On 18/10/2025 04:31, Daniel Golle wrote:
> Use regmap for register access in preparation for supporting the MaxLinear
> GSW1xx family of switches connected via MDIO or SPI.
> Rewrite the existing accessor read-poll-timeout functions to use calls to
> the regmap API for now.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Looks like the typo in the target tree (net-net instead of net-next)
confuses patchwork :)

Maxime

> ---
> v2: drop error handling, it wasn't there before and it would anyway be
>     removed again by a follow-up change
> 
>  drivers/net/dsa/lantiq/Kconfig        |   1 +
>  drivers/net/dsa/lantiq/lantiq_gswip.c | 109 +++++++++++++++-----------
>  drivers/net/dsa/lantiq/lantiq_gswip.h |   6 +-
>  3 files changed, 69 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/net/dsa/lantiq/Kconfig b/drivers/net/dsa/lantiq/Kconfig
> index 1cb053c823f7..3cfa16840cf5 100644
> --- a/drivers/net/dsa/lantiq/Kconfig
> +++ b/drivers/net/dsa/lantiq/Kconfig
> @@ -2,6 +2,7 @@ config NET_DSA_LANTIQ_GSWIP
>  	tristate "Lantiq / Intel GSWIP"
>  	depends on HAS_IOMEM
>  	select NET_DSA_TAG_GSWIP
> +	select REGMAP
>  	help
>  	  This enables support for the Lantiq / Intel GSWIP 2.1 found in
>  	  the xrx200 / VR9 SoC.
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
> index 86b410a40d32..3727cce92708 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
> @@ -113,22 +113,22 @@ static const struct gswip_rmon_cnt_desc gswip_rmon_cnt[] = {
>  
>  static u32 gswip_switch_r(struct gswip_priv *priv, u32 offset)
>  {
> -	return __raw_readl(priv->gswip + (offset * 4));
> +	u32 val;
> +
> +	regmap_read(priv->gswip, offset, &val);
> +
> +	return val;
>  }
>  
>  static void gswip_switch_w(struct gswip_priv *priv, u32 val, u32 offset)
>  {
> -	__raw_writel(val, priv->gswip + (offset * 4));
> +	regmap_write(priv->gswip, offset, val);
>  }
>  
>  static void gswip_switch_mask(struct gswip_priv *priv, u32 clear, u32 set,
>  			      u32 offset)
>  {
> -	u32 val = gswip_switch_r(priv, offset);
> -
> -	val &= ~(clear);
> -	val |= set;
> -	gswip_switch_w(priv, val, offset);
> +	regmap_write_bits(priv->gswip, offset, clear | set, set);
>  }
>  
>  static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
> @@ -136,48 +136,36 @@ static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
>  {
>  	u32 val;
>  
> -	return readx_poll_timeout(__raw_readl, priv->gswip + (offset * 4), val,
> -				  (val & cleared) == 0, 20, 50000);
> +	return regmap_read_poll_timeout(priv->gswip, offset, val,
> +					!(val & cleared), 20, 50000);
>  }
>  
>  static u32 gswip_mdio_r(struct gswip_priv *priv, u32 offset)
>  {
> -	return __raw_readl(priv->mdio + (offset * 4));
> +	u32 val;
> +
> +	regmap_read(priv->mdio, offset, &val);
> +
> +	return val;
>  }
>  
>  static void gswip_mdio_w(struct gswip_priv *priv, u32 val, u32 offset)
>  {
> -	__raw_writel(val, priv->mdio + (offset * 4));
> +	int ret;
> +
> +	regmap_write(priv->mdio, offset, val);
>  }
>  
>  static void gswip_mdio_mask(struct gswip_priv *priv, u32 clear, u32 set,
>  			    u32 offset)
>  {
> -	u32 val = gswip_mdio_r(priv, offset);
> -
> -	val &= ~(clear);
> -	val |= set;
> -	gswip_mdio_w(priv, val, offset);
> -}
> -
> -static u32 gswip_mii_r(struct gswip_priv *priv, u32 offset)
> -{
> -	return __raw_readl(priv->mii + (offset * 4));
> -}
> -
> -static void gswip_mii_w(struct gswip_priv *priv, u32 val, u32 offset)
> -{
> -	__raw_writel(val, priv->mii + (offset * 4));
> +	regmap_write_bits(priv->mdio, offset, clear | set, set);
>  }
>  
>  static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
>  			   u32 offset)
>  {
> -	u32 val = gswip_mii_r(priv, offset);
> -
> -	val &= ~(clear);
> -	val |= set;
> -	gswip_mii_w(priv, val, offset);
> +	regmap_write_bits(priv->mii, offset, clear | set, set);
>  }
>  
>  static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
> @@ -220,17 +208,10 @@ static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
>  
>  static int gswip_mdio_poll(struct gswip_priv *priv)
>  {
> -	int cnt = 100;
> +	u32 ctrl;
>  
> -	while (likely(cnt--)) {
> -		u32 ctrl = gswip_mdio_r(priv, GSWIP_MDIO_CTRL);
> -
> -		if ((ctrl & GSWIP_MDIO_CTRL_BUSY) == 0)
> -			return 0;
> -		usleep_range(20, 40);
> -	}
> -
> -	return -ETIMEDOUT;
> +	return regmap_read_poll_timeout(priv->mdio, GSWIP_MDIO_CTRL, ctrl,
> +					!(ctrl & GSWIP_MDIO_CTRL_BUSY), 40, 4000);
>  }
>  
>  static int gswip_mdio_wr(struct mii_bus *bus, int addr, int reg, u16 val)
> @@ -1893,9 +1874,37 @@ static int gswip_validate_cpu_port(struct dsa_switch *ds)
>  	return 0;
>  }
>  
> +static const struct regmap_config sw_regmap_config = {
> +	.name = "switch",
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_shift = -2,

For clarity, it would be better to use the dedicated macro :

  .reg_shift = REGMAP_UPSHIFT(2),

> +	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> +	.max_register = GSWIP_SDMA_PCTRLp(6),
> +};
> +
> +static const struct regmap_config mdio_regmap_config = {
> +	.name = "mdio",
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_shift = -2,

same here

> +	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> +	.max_register = GSWIP_MDIO_PHYp(0),
> +};
> +
> +static const struct regmap_config mii_regmap_config = {
> +	.name = "mii",
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_shift = -2,

same here

> +	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> +	.max_register = GSWIP_MII_CFGp(6),
> +};
> +

Thanks,

Maxime

