Return-Path: <linux-kernel+bounces-821659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F18B81E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD811189C256
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246922E92AB;
	Wed, 17 Sep 2025 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jzmqQ6yI"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879022D0626;
	Wed, 17 Sep 2025 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143104; cv=none; b=Bjm3waqedTE3sZPKeaMv7L4HOjJKsm7o+QQ+YNrOEc5U5TWEF4mhueMEQ72vxrq3o2QTloBKlEqMRgQL0nVmKWW9Eh725Ki1sfdBFHDMxQIx6Jhn7JwQsW6NxT9vYRN0u463LwdZRfvIviweeIqhoB53zkZmR49+QcZOuLcFrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143104; c=relaxed/simple;
	bh=5niVyKSUAzBe7bKqk5WL8/s3TWnbCi+pdhmUtgwwVhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6Z+5Dh7f6NvrpFexxxHSu3hrMbYyJrMhVJAzT/nLXacQU/My6kr4Y4wiZtCPDLNz5R8z/L8FAjGu64xPZEybRcXh0Tu22XHfdFljUG5a9vWtSJ1RuyxwQnRuOPx/jMkOr+zhGcaOQlmLIqbH7JjR2ar44UpCmcWGBtErcyMEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jzmqQ6yI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o6w4t3UC27bwnN6JWA8ZdKSrOmat1bxK0b+u8I2fnrs=; b=jzmqQ6yIl7UUKBiq97RnIjKZj7
	p34gFEmXC9MwDRV9+6uLT4qFjXNHIf76KL5Y84EFWs4Uce2LBIombd4RQtFq40iJbn+w9qMGhBElA
	cU4fBSc1/vemnhXbuckLVN2/RGWKQr/p3rb9O2IsS03Toq0H5cgnRB7R52igr/ntkn8o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyzKX-008jg4-51; Wed, 17 Sep 2025 23:04:45 +0200
Date: Wed, 17 Sep 2025 23:04:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
Message-ID: <8b5625a5-56bf-49bc-b4cf-82c60460db65@lunn.ch>
References: <20250917180428.810751-1-rebecca@bsdio.com>
 <20250917180428.810751-3-rebecca@bsdio.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917180428.810751-3-rebecca@bsdio.com>

Hi Rebecca

> +// Connected to host Intel X550 (ALTRAD8UD-1L2T) or
> +// Broadcom BCM57414 (ALTRAD8UD2-1L2Q) interface
> +&mac0 {

Thanks for the comments.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii1_default>;
> +
> +	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
> +		 <&syscon ASPEED_CLK_MAC1RCLK>;
> +	clock-names = "MACCLK", "RCLK";
> +
> +	use-ncsi;
> +
> +	nvmem-cells = <&eth0_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +};
> +
> +// Connected to Realtek RTL8211E
> +&mac1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
> +
> +	nvmem-cells = <&eth1_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +};

I see you did not manage to get phy-handle to work.

The problem i have is the lack of phy-mode = "rgmii-id".

Aspeed has a long history have getting phy-mode wrong. This has mainly
affected 2600, but as far as i understand, this is a 2500?

I've been pushing back on any 2600 DT using phy-mode = "rgmii". This
is 99% of the time wrong, since it indicates that the PCB has extra
long clock lines.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

What aspeed get wrong is that they configure the MAC to insert 2ns
delay. And this is hidden way, in the bootloader. As a result,
PHY_INTERFACE_MODE_RGMII gets passed to phy_connect(), when
PHY_INTERFACE_MODE_RGMII_ID should be passed. Its a case of two wrongs
combine to give a working system.

I've been pushing aspeed to clean up this mess. And to do that, i've
been rejecting DT with phy-mode = "rgmii". Most submissions has ended
up dropping ethernet support, and are now twiddling their thumbs
waiting for aspeed to cleanup the mess. Or anybody actually, there is
enough public information anybody could fix it, and probably end up
with a crate of beer/box of wine, etc.

Now, it is slightly different here. You don't have a phy-mode at
all. And all the other 2500 i looked at also don't have phy-mode
properties. You are relying on

        /* Default to RGMII. It's a gigabit part after all */
        err = of_get_phy_mode(np, &phy_intf);
        if (err)
                phy_intf = PHY_INTERFACE_MODE_RGMII;

This is equally wrong :-(

Now, there was somebody who tried getting around my push back on 2600
by simply deleting the phy-mode, and relying on this fallback code. I
said don't do that. Its just going to cause more problems when the code
gets cleaned up, and we have to remember there is an oddball platform.

At the time, i did not know 2500 was different, and none of the DTs
use phy-mode. So, i'm humming and harring. I set a precedent, no
phy-mode should get a patch rejected. But this is 2500, not 2600.

O.K. I will accept it, for 2500. Since none of the 2500 boards have
it, this is not an oddball platform. If the cleanup breaks it, it will
break all 2500 and that should get noticed pretty quickly.

So, for these two nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

