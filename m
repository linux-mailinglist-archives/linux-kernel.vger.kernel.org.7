Return-Path: <linux-kernel+bounces-777650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF72B2DC35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B9D1C44C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50432F1FC8;
	Wed, 20 Aug 2025 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X185EkT0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806A2EFDAA;
	Wed, 20 Aug 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692102; cv=none; b=LE+1Q/sEdmTPSRLbi4Sqng4fXCDdcbGv2s4605IykvsPMaFvsaqwNM3yoolzhlf2PuzA9K/zaw0soNirPnEDKs5PKAWsYEg4qy64xIg9KSJQCvQfT1cBCHyr5YiF4NzhMYhEFOHvZWC3NORsJ59k1S+r1bc4YRgssdS7ZnnOa5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692102; c=relaxed/simple;
	bh=Y5P6hAA9P3PR1/js+DABIneTp1HWBxbLcQeHF0ycIN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmJKFNgWS4O9+Ji1NvT9Gk9Fhu7tTxW5f3OLR1aJHrQr2hjvu7KPY6f3l70nhwDxDr8nCgsIUnrzdME8LcbvKMakT2aZcbce4Za361Z7dVRJMpak67F9LWUcA3nXf9L6GD7Wd2aiaOGt8hYIgpZsMiBK3CfcSHcHudvPv6OxdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X185EkT0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=23JiI9Gumsb/rLx4cuVULAx/qkeZ5t8+893/fbaahsA=; b=X185EkT0rWuh6auczvYqCm1Sk6
	aOK4BsPPzEBb5mULL84/PKIqjOCJSRGE1PNIEC+cT3a3IecUMSQQLriOQboXNUzVi9V2JhJwbY7xt
	0j0WJmZWBjUB2xYlu176+q623lX+ow5OFIsQI/vpH4funOwGxcrdzvaOy+Yj8w8xjUXs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uohiR-005JoT-1m; Wed, 20 Aug 2025 14:14:55 +0200
Date: Wed, 20 Aug 2025 14:14:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mateusz Koza <mateusz.koza@grinn-global.com>
Cc: angelogioacchino.delregno@collabora.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	marcin.czarnecki@grinn-global.com, b.bilas@grinn-global.com
Subject: Re: [PATCH v3 1/4] arm64: dts: mediatek: mt8390-genio-700-evk: Add
 Grinn GenioSBC-700
Message-ID: <d72ae17f-f634-4148-9c89-d5a7ed4f6b21@lunn.ch>
References: <20250820120905.993189-1-mateusz.koza@grinn-global.com>
 <20250820120905.993189-2-mateusz.koza@grinn-global.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820120905.993189-2-mateusz.koza@grinn-global.com>

> +&eth {
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy0>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 11000 200000>;
> +	mediatek,tx-delay-ps = <30>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&eth_default_pins>;
> +	pinctrl-1 = <&eth_sleep_pins>;
> +	mediatek,mac-wol;
> +	snps,reset-gpio = <&pio 147 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&eth_mdio {
> +	ethernet_phy0: ethernet-phy@3 {
> +		reg = <3>;
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		eee-broken-1000t;
> +		interrupts-extended = <&pio 148 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};

Thanks for fixing the phy-mode.

For these two nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

