Return-Path: <linux-kernel+bounces-731650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4688B057BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1651F1AA76EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBD52D781A;
	Tue, 15 Jul 2025 10:25:42 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7E28F4;
	Tue, 15 Jul 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575141; cv=none; b=RVVjWFFQ4xQ32GkY4FxnEy062/IuDVCRBza9pErfTN3gzRg44I3cL0+LTho/D1bKCRdzPFHu2Ovr7VtjMo0NIBq++IgTbmuQOpLEuyoUx03wICSm/PwWR8wL+ldtW2dNhON2c3TLccGxfWY9yc2Kyb/cpDxMZIBL6BjMih2o6t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575141; c=relaxed/simple;
	bh=wwa8tOAdGrPcbMj0Jsm5cHaAzQEuyKFmUHesGXCUd7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/Jr62Tt+iWFyn66sEDcg0UmrAmwYigN30ZZaPqhcc5bVCrqi6d8rFTinMs58NZ9RNWR63zTE+kE5cFqtnXqncpNIbN51/yvKMOZyJUPSk6SHrvMOw3AyHfQ8KdHzkhAfkga3vp+93LPoXEf5k9u53L6vfv7dTkBmy7j/9vbgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2900F340DB0;
	Tue, 15 Jul 2025 10:25:38 +0000 (UTC)
Date: Tue, 15 Jul 2025 18:25:34 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	palmer@dabbelt.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: dts: spacemit: Add OrangePi RV2 board device
 tree
Message-ID: <20250715102534-GYA542593@gentoo>
References: <20250711183245.256683-1-hendrik.hamerlinck@hammernet.be>
 <20250711183245.256683-3-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711183245.256683-3-hendrik.hamerlinck@hammernet.be>


On 20:32 Fri 11 Jul     , Hendrik Hamerlinck wrote:
> Add initial device tree support for the OrangePi RV2 board [1], which is
> marketed as using the Ky X1 SoC but has been confirmed to be 
> identical to the SpacemiT K1 [2].
> 
> The device tree is adapted from the OrangePi vendor tree [3], and similar
> integration can be found in the Banana Pi kernel tree [4], confirming SoC
> compatibility.
> 
> This minimal device tree enables booting into a serial console with UART
> output and a blinking LED.
> 
> Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-RV2.html [1]
> Link: https://www.spacemit.com/en/key-stone-k1 [2]
> Link: https://github.com/BPI-SINOVOIP/pi-linux/blob/linux-6.6.63-k1/arch/riscv/boot/dts/spacemit/k1-x_orangepi-rv2.dts [3]
> Link: https://github.com/orangepi-xunlong/linux-orangepi/tree/orange-pi-6.6-ky [4]
> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> ---
>  arch/riscv/boot/dts/spacemit/Makefile         |  1 +
>  .../boot/dts/spacemit/k1-orangepi-rv2.dts     | 43 +++++++++++++++++++
>  2 files changed, 44 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> 
> diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
> index 92e13ce1c16d..152832644870 100644
> --- a/arch/riscv/boot/dts/spacemit/Makefile
> +++ b/arch/riscv/boot/dts/spacemit/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-bananapi-f3.dtb
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
> +dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
> diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> new file mode 100644
> index 000000000000..8313f9589cd2
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
..
> +/* Copyright (c) 2023 Ky, Inc */
Copyright should cover current year, which is 2025..
what's "Ky" stand for? Can you give a full description here

> +
> +/dts-v1/;
> +
> +#include "k1.dtsi"
> +#include "k1-pinctrl.dtsi"
> +
> +/ {
> +	model = "OrangePi RV2";
> +	compatible = "xunlong,orangepi-rv2", "spacemit,k1";
> +
..
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0x0 0x80000000>;
> +	};
> +
> +	memory@100000000 {
> +		device_type = "memory";
> +		reg = <0x1 0x00000000 0x0 0x80000000>;
> +	};
> +
for the memory nodes, there are 2/4/8GB variants from the Link [1], and
you couldn't cover all of them in one dt

besides, I thought bootloader (u-boot) will populate these info, right?
so the above nodes isn't really necessary

> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led1 {
> +			label = "sys-led";
> +			gpios = <&gpio K1_GPIO(96) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "on";
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_2_cfg>;
> +	status = "okay";
> +};
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)

