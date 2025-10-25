Return-Path: <linux-kernel+bounces-870068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D6AC09C6E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CC61C62F43
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101363043DC;
	Sat, 25 Oct 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="czhAVBpv"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC932FFDCF;
	Sat, 25 Oct 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410605; cv=none; b=iz8HU+SHfRagVJxpRS4cjVVdCdfh5EzEHZOVIwYKGpmD3qbe6/o3haNpm5tD9uY3JKw6U4P+p/+xeYbeWK1zdKVuyL8UaqTssMrYTWzysYlwTT4Q7Zl2Kdn+Lt8O3mYGaYxAUxfZ2yJnUd9zGNMo6RTrXuR0oD6uIzbd62wm1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410605; c=relaxed/simple;
	bh=B/wgD2pPRPBEKHTu2+Ku4d0XEkKnFUzpozrR6KGVtYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLacT4KuuzkYyrGBoWOp9nTOZU7hXrWeFeAdk+FQUbGLOGxeONlPYX0wmzJCBslZC6KZIXP403ttOdBgyQioEUCO7os0h97RFOeBnRIH2pkbm6qOOIf02oJTcwV43pvoAikO+yqzjL5pc1BxhGK2HazbQ5nIKAfUBdteCvGCfA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=czhAVBpv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6C175C0AFE0;
	Sat, 25 Oct 2025 16:43:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 27D0060704;
	Sat, 25 Oct 2025 16:43:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57B56102F24C1;
	Sat, 25 Oct 2025 18:43:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761410599; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=aw1qygv1W1hqUe0VqpRQPvuxi9+5+ES2gFQNdmzv9Js=;
	b=czhAVBpvQtyZVbjdaYh1n+12pqhBxz7jqFBBPDc7DKhuAEUtmOui6FanjwMs3o/8aCzAna
	cLpKHpQEdoE7dR1asHJmQYXCYeMfjN3Ed/z20Kr0JlE0Cgp3EVycv83w8W3u9z8cuP1Q6I
	bdswG33Ti5NWucZMQh1uH1CZw/3fir8Gs24cIOtLHMnBmn13gU/Z4h/07BI635kAOmBmSl
	d6EpbLyccixn6L6eY0z1Fknaiut4Vq69oX+8zlCwM4/YI7aYXnP2mYpllhLzF3vCQrIw+5
	485aK+go54UgYYCpN8fgq5vnImlk4WOl/iC4Z+DwBctPWxOiUwA0jLig3aaXnA==
Message-ID: <43f20230-1e13-4952-8069-bbcb9d966a0f@bootlin.com>
Date: Sat, 25 Oct 2025 18:43:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/13] net: dsa: add driver for MaxLinear
 GSW1xx switch family
To: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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
References: <cover.1761402873.git.daniel@makrotopia.org>
 <5a586b0441a18a1e0eca9ebe77668d6ebde79d1c.1761402873.git.daniel@makrotopia.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <5a586b0441a18a1e0eca9ebe77668d6ebde79d1c.1761402873.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Daniel,

On 25/10/2025 16:51, Daniel Golle wrote:
> Add driver for the MaxLinear GSW1xx family of Ethernet switch ICs which
> are based on the same IP as the Lantiq/Intel GSWIP found in the Lantiq VR9
> and Intel GRX MIPS router SoCs. The main difference is that instead of
> using memory-mapped I/O to communicate with the host CPU these ICs are
> connected via MDIO (or SPI, which isn't supported by this driver).
> Implement the regmap API to access the switch registers over MDIO to allow
> reusing lantiq_gswip_common for all core functionality.
> 
> The GSW1xx also comes with a SerDes port capable of 1000Base-X, SGMII and
> 2500Base-X, which can either be used to connect an external PHY or SFP
> cage, or as the CPU port. Support for the SerDes interface is implemented
> in this driver using the phylink_pcs interface.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

[...]

> +static int gsw1xx_sgmii_pcs_config(struct phylink_pcs *pcs,
> +				   unsigned int neg_mode,
> +				   phy_interface_t interface,
> +				   const unsigned long *advertising,
> +				   bool permit_pause_to_mac)
> +{
> +	struct gsw1xx_priv *priv = sgmii_pcs_to_gsw1xx(pcs);
> +	bool sgmii_mac_mode = dsa_is_user_port(priv->gswip.ds, GSW1XX_SGMII_PORT);
> +	u16 txaneg, anegctl, val, nco_ctrl;
> +	int ret;
> +
> +	/* Assert and deassert SGMII shell reset */
> +	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> +			      GSW1XX_RST_REQ_SGMII_SHELL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_clear_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> +				GSW1XX_RST_REQ_SGMII_SHELL);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Hardware Bringup FSM Enable  */
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_HWBU_CTRL,
> +			   GSW1XX_SGMII_PHY_HWBU_CTRL_EN_HWBU_FSM |
> +			   GSW1XX_SGMII_PHY_HWBU_CTRL_HW_FSM_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure SGMII PHY Receiver */
> +	val = FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_EQ,
> +			 GSW1XX_SGMII_PHY_RX0_CFG2_EQ_DEF) |
> +	      GSW1XX_SGMII_PHY_RX0_CFG2_LOS_EN |
> +	      GSW1XX_SGMII_PHY_RX0_CFG2_TERM_EN |
> +	      FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT,
> +			 GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF);
> +
> +	// if (!priv->dts.sgmii_rx_invert)
> +		val |= GSW1XX_SGMII_PHY_RX0_CFG2_INVERT;

There's a leftover commented-out line here :)

Maxime



