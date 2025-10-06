Return-Path: <linux-kernel+bounces-843168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31925BBE8DB
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 298E14EF97A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241422D9494;
	Mon,  6 Oct 2025 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0cKSouln"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAEE2D8DBB;
	Mon,  6 Oct 2025 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765895; cv=none; b=C+FLWiSKf3VrA44PMZQ/7OQ/imv06ho8NraXOmgxNBJtaHPHPCXOVc4qolH92eINz1L8FINiqg+nqqj6l0K0JmK3/I2PAQnvCkyoN+qjX6dMshW3cLhMXghACN9SiwA1TVvvKATzfI7LAwPc9Q/NuW0AkpC3JOZgCw9OYxqZseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765895; c=relaxed/simple;
	bh=/OenKGRr35gNUbyLyVxQicdCNICTTtsFY0QGrKbxgfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvcwWFJr//LIqpODgLsONZdfKxkjlp8ftq5w2nScqYUUG6MzzJC5x9TJDyfM4Ay8oVSEog9ByovcjwNoecPQA7q2eSu3sh5AGVj8/7mwkwFKyujmgxTpApY4h8rzgXQNrtvz2pGBXnynXs7Yiyvv+RPzs+XIuaVR1FXbeccRy5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0cKSouln; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wdd5c/PHXgFX18ZoE3M5BpB+K9x9piTq/ykZtbdV/vs=; b=0cKSouln3fYahi+dyaR8+Yz9uV
	CXgXVf4HWqLJUlmoB648heg2O1fZ8rgmGn/F1ne3hILrCyD+TNQDDxzvVj4iO2hZRTVllVKlo1KMr
	aL+Zu3WYEcwCWPuQFBCDH4LpLnis/cxt9Ouv1iFnXC3unxAxAN+cMED+PYx2faXsGgFA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v5nUZ-00AIzL-PJ; Mon, 06 Oct 2025 17:51:15 +0200
Date: Mon, 6 Oct 2025 17:51:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liangbin Lian <jjm2473@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
	jbx6244@gmail.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
Message-ID: <d8ad476c-d0c7-4e97-9e76-540a539ffb52@lunn.ch>
References: <20250929065714.27741-1-jjm2473@gmail.com>
 <20250929065714.27741-4-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929065714.27741-4-jjm2473@gmail.com>

> +&gmac0 {
> +	phy-mode = "rgmii";

Did i really miss this patch series in its earlier version, or did you
ignore me?

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

> +	tx_delay = <0x3c>;
> +	rx_delay = <0x2f>;

Please change it to rgmii-id, and smaller tx/rx_delay values. Or show
us the schematics which clearly show extra long clock lines.

> +/* Micro SD card slot is not mounted */
> +&sdmmc0 {
> +	max-frequency = <150000000>;
> +	no-sdio;
> +	no-mmc;
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> +	vmmc-supply = <&vcc3v3_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "disabled";
> +};
> +
> +/* Wifi module is not mounted */
> +&sdmmc2 {

What do you mean by "not mounted"?

Often you would say "not populated", to indicate the PCB has all the
tracks in place, but the chip has simply not been soldered in place.

Or is there a connector here, and nothing plugged into the connector?

   Andrew

