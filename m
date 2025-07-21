Return-Path: <linux-kernel+bounces-739426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB82B0C62B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5071AA6661
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C82DCC03;
	Mon, 21 Jul 2025 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mExpQ9Hi"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A02DA77B;
	Mon, 21 Jul 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107772; cv=none; b=YuYdpyaz8eRC3RgobWDEcB6g2n6Y3xq/SC8c/e/7qQKAl8eMV6dQDMxgRs8GvED4xOOY/clh7wUkIa69HskVNbXMCqS/iTf7HV+bO3sVv/rjIJ2RkLesWKvl7Mu9jEKteD0EFmxXTZzE3822P7Mh/YfRIxVaJF8nTu9bBVJPOPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107772; c=relaxed/simple;
	bh=xzItkeRrbcsA7vr8YA6l+8FKhQJ22uASZV+GlNgFXQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CADja0bf0/VTQnBY1ryn0OgP4zFRJ23HfWaMt1cIKT3aFiVzEPfFpe6SMKIQ8PtiMq5R70eTgCYYWfYBImuwkEjywsKQYI3p/SYK312g1whfMJcPOF+++kHsBTlEI/fb34QiE2sKwqKi6OWlSTqgNaM/Z/MAZBPfQJe+6FiCp2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mExpQ9Hi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZM0jXh/69aSK5O/qFPL6WwO8DTU6rGWPNC15GTR25mw=; b=mExpQ9HiAC++gjjmqVf4jktAXv
	5a2enOybfuUeppqdllVT4opgV+Eh3IOWD6jbk/LltMA67PjGA0F+H2tES970SJXfiILQsc8tXDGRf
	WygSYtW7mrMRk5xUT6TgequMFn/RAN2qWltQZxA7R30/w6yN7YTNZt/jv5Zm63fhunI0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udrPZ-002MhS-4Y; Mon, 21 Jul 2025 16:22:37 +0200
Date: Mon, 21 Jul 2025 16:22:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	o.rempel@pengutronix.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan8842
Message-ID: <4dd62a56-517a-4011-8a13-95f6c9ad2198@lunn.ch>
References: <20250721071405.1859491-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721071405.1859491-1-horatiu.vultur@microchip.com>

> +static struct lan8842_hw_stat lan8842_hw_stats[] = {
> +	{ "phy_rx_correct_count", 2, 3, {88, 61, 60}},
> +	{ "phy_rx_crc_count", 2, 2, {63, 62}},
> +	{ "phy_tx_correct_count", 2, 3, {89, 85, 84}},
> +	{ "phy_tx_crc_count", 2, 2, {87, 86}},
> +};

Hi Horatiu

Please could you look at using ethtool_phy_stats via the
.get_phy_stats() phy driver op.

> +static int lan8842_config_init(struct phy_device *phydev)
> +{
> +	int val;
> +	int ret;
> +
> +	/* Reset the PHY */
> +	val = lanphy_read_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET);
> +	if (val < 0)
> +		return val;
> +	val |= LAN8814_QSGMII_SOFT_RESET_BIT;
> +	lanphy_write_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET, val);

It looks like there are sufficient pairs of
lanphy_read_page_reg()/lanphy_write_page_reg() you would be justified
adding a lanphy_modify_page_reg().

> +}, {
> +	.phy_id		= PHY_ID_LAN8842,
> +	.phy_id_mask	= MICREL_PHY_ID_MASK,

I think you could use PHY_ID_MATCH_MODEL() here.  It would make it
different to every other PHY, but maybe you could start with some
cleanup patches, adding the _modify_ call etc?

	Andrew

