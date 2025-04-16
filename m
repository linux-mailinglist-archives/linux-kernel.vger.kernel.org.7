Return-Path: <linux-kernel+bounces-603158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B66A88430
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534A117ED29
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA728469E;
	Mon, 14 Apr 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QJ2KPLjI"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD14594A;
	Mon, 14 Apr 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637668; cv=none; b=HYLzy+WblDNpE76F2oDQZdJQttYzwizyuFovPk56PJ3ddG6VTEXJcHpwenCNN2ruY/pk3G6wrvKKoXHfc29ba9dZdF4GoM+2GSrfRsymF4d1Si8NzcCy1aeWMwSve+6MdFCCIfu8+VTIvqMqhekh59QJ8z6e9Bcvsd4LRN/oBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637668; c=relaxed/simple;
	bh=LbuHKrW8lf40fagkAGqiXq6BJNsvqjAwjtltpbnoz9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELOQS34Uo6LhQxWBF5OFyaK7ocVQcAVEq2Oi7ixJw28j+60t3GdMDzSDrhYhDRMIit4Qbn2GOPUMACsVSEA8iH+0loTkV5AcjXk1FNF+nFefPsk48qqUtzl9rAl4C2C8J1y3NpBMLMSSsiwYobYpS9/xHHrx62yKXGYkQsrYlSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QJ2KPLjI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F88PMn+KfFPQHSJv4c9qlI3FIDQbc1OFp6CRrqpwMkc=; b=QJ2KPLjI4D1ax9AF+EVe06M5rP
	HFweb3aQZofnDem9HniedQaTbKVtC5GjQ3zqXPa12Pvo1rotvQygLQdYukiZpLPZbpzi/GX3k5vCk
	63uVq5WVrJ9tl4HBPs22yNL9+pHQvdhkHwONDbGJx07ZWGkfSTuDCWXAiNIh73dOPPF0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4Jwn-009CAe-6v; Mon, 14 Apr 2025 15:34:01 +0200
Date: Mon, 14 Apr 2025 15:34:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
	tony@atomide.com, richardcochran@gmail.com, glaroque@baylibre.com,
	schnelle@linux.ibm.com, m-karicheri2@ti.com, s.hauer@pengutronix.de,
	rdunlap@infradead.org, diogo.ivo@siemens.com, basharath@couthit.com,
	horms@kernel.org, jacob.e.keller@intel.com, m-malladi@ti.com,
	javier.carrasco.cruz@gmail.com, afd@ti.com, s-anna@ti.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, praneeth@ti.com,
	srk@ti.com, rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v5 05/11] net: ti: prueth: Adds ethtool support
 for ICSSM PRUETH Driver
Message-ID: <5e394736-00c6-4671-a55e-6019ce245b01@lunn.ch>
References: <20250414113458.1913823-1-parvathi@couthit.com>
 <20250414130237.1915448-6-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414130237.1915448-6-parvathi@couthit.com>

> +static int icssm_emac_get_link_ksettings(struct net_device *ndev,
> +					 struct ethtool_link_ksettings *ecmd)
> +{
> +	return phy_ethtool_get_link_ksettings(ndev, ecmd);
> +}
> +

> +static int
> +icssm_emac_set_link_ksettings(struct net_device *ndev,
> +			      const struct ethtool_link_ksettings *ecmd)
> +{
> +	return phy_ethtool_set_link_ksettings(ndev, ecmd);
> +}

> +/* Ethtool support for EMAC adapter */
> +const struct ethtool_ops emac_ethtool_ops = {
> +	.get_drvinfo = icssm_emac_get_drvinfo,
> +	.get_link_ksettings = icssm_emac_get_link_ksettings,
> +	.set_link_ksettings = icssm_emac_set_link_ksettings,

The wrappers don't do anything, so why not just use
phy_ethtool_get_link_ksettings() and phy_ethtool_set_link_ksettings()
directly?

	Andrew

