Return-Path: <linux-kernel+bounces-806951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FBBB49DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D796E1BC3670
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A151DF738;
	Tue,  9 Sep 2025 00:25:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F0F1D799D;
	Tue,  9 Sep 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757377527; cv=none; b=eOIWhLGB3PbEy6pBTa+4rB6jGcFwVGEYX3Kcm0L/YEBB1UFElEEdefDXnoZLBYRnne5oXPj3HxnZ00lNJGdWW4mrOKYIpD8bJv/SUu7nZ0W+SQv9ZUpS4Bcra9jDh4mU2fhXC172F5E3pZUDHyQH81jwnL8X1XPGmxep05Zv19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757377527; c=relaxed/simple;
	bh=wYHaiOgv0c3CrrngmkGXy1RIZbf87Ynod0lCMxWdIZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8bcHC4t6j/y7iO7NbRvsTqNLtDq3RG0E/LPKC0Rmlrm4oKwbOlrL4FS371mcX/nrnLdwFg24twMHRplMKYBJfVD5CASji4o/HMGplxO3IT/AOdm87FrhICEOovpTiH8HDjZNQtq73KMxQbUMU5n6Ajeb6DjgvQTQ3VKC9W6Vf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4225C1691;
	Mon,  8 Sep 2025 17:25:16 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBCBE3F66E;
	Mon,  8 Sep 2025 17:25:22 -0700 (PDT)
Date: Tue, 9 Sep 2025 01:24:22 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwiner: h5: OrangePi PC2: add ethernet
 LEDs
Message-ID: <20250909012422.43b755a4@minigeek.lan>
In-Reply-To: <20250818163520.1004528-1-olek2@wp.pl>
References: <20250818163520.1004528-1-olek2@wp.pl>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 18:35:13 +0200
Aleksander Jan Bajkowski <olek2@wp.pl> wrote:

> This patch adds support for Ethernet LEDs.

So I tried this on my OPi-PC2, but I cannot influence the LEDs. I have
CONFIG_LED_TRIGGER_PHY and CONFIG_LEDS_TRIGGER_NETDEV built in, and I
see mdio_mux-0.2:01:amber:lan and mdio_mux-0.2:01:green:lan in
/sys/class/leds, but anything I write into trigger does not seem to
change the output: it always stays on the network functionality, I
guess because it's still configured to the PHY hardware wired function?

What am I missing?

Cheers,
Andre

> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 20
> +++++++++++++++++++ 1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts index
> 0f29da7d51e6..7688f565ec9b 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts @@ -7,6
> +7,7 @@ 
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/sun4i-a10.h>
>  
>  / {
> @@ -132,6 +133,25 @@ &external_mdio {
>  	ext_rgmii_phy: ethernet-phy@1 {
>  		compatible = "ethernet-phy-ieee802.3-c22";
>  		reg = <1>;
> +
> +		leds {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			led@0 {
> +				reg = <0>;
> +				color = <LED_COLOR_ID_GREEN>;
> +				function = LED_FUNCTION_LAN;
> +				linux,default-trigger = "netdev";
> +			};
> +
> +			led@1 {
> +				reg = <1>;
> +				color = <LED_COLOR_ID_AMBER>;
> +				function = LED_FUNCTION_LAN;
> +				linux,default-trigger = "netdev";
> +			};
> +		};
>  	};
>  };
>  


