Return-Path: <linux-kernel+bounces-866877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E04C00E91
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05CF3A6B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C813330C610;
	Thu, 23 Oct 2025 11:54:10 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA812F3C02;
	Thu, 23 Oct 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220450; cv=none; b=UkDMn8qpmd9nReB5T0e/DHXHKiJSz5Dl9qY8HwCH1Oa9goAdJz66oK6DQmssIbP3mfPlgHsyBV4ISrqLPoV9g5wQoV6sr4YrnykxsKZOyHQLuf520jvd5Uy0YwjLB9/CYY0C5RTtXoTnCa0nDOzDBlq4CTsd3ZBT1BVno2CQGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220450; c=relaxed/simple;
	bh=S3Nr6LQGbZd2jvsFaTLQAqwk2Ri8H/TuFcRTEn5DogM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdfKqpOkBGPSqF8hFe4Q3aKt2AFxS/RvSS8hXcTyZsVAnUB8Kj5AEH2JorZB7yEzs3ZWHD/08psUerE1QNjlkixMhSosnTBTZcxgCHTC16tYQ5ic9Pn7mQ74fbwlIr92/TRES3spPLMueqqMTM+GKg0BQSUIRuvzXP8tQCEmW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [143.105.117.17])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 5C752B220A1E;
	Thu, 23 Oct 2025 13:53:56 +0200 (CEST)
Message-ID: <eaa5347b-af52-4de3-be58-f7b932c8fe01@freeshell.de>
Date: Thu, 23 Oct 2025 04:53:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] riscv: dts: spacemit: add MusePi Pro board device
 tree
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>,
 Paul Walmsley <pjw@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251023-k1-musepi-pro-dts-v4-0-01836303e10f@linux.spacemit.com>
 <20251023-k1-musepi-pro-dts-v4-2-01836303e10f@linux.spacemit.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251023-k1-musepi-pro-dts-v4-2-01836303e10f@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/23/25 00:28, Troy Mitchell wrote:
> Add initial device tree support for the MusePi Pro board [1].
> The board is using the SpacemiT K1/M1 SoC.
> 
> This device tree is adapted from the SpacemiT vendor tree [2] and
> enables basic board functionality, including UART console, LED, eMMC,
> Ethernet, and PDMA.
> 
> Link: https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
> Link: https://gitee.com/bianbu-linux/linux-6.6/blob/k1-bl-v2.2.y/arch/riscv/boot/dts/spacemit/k1-x_MUSE-Pi-Pro.dts [2]
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
> Changelog in v4:
> - modify commit message
> - add SpacemiT copyright
> - Link to v3: https://lore.kernel.org/all/20251017-k1-musepi-pro-dts-v3-2-40b05491699f@linux.spacemit.com/
> 
> Changelog in v3:
> - sort dts node
> - add ethernet alias
> - add emmc, pdma, and eth0 node (a squash of patches 3–5 from v2)
> - Link to v2: https://lore.kernel.org/all/20251010-k1-musepi-pro-dts-v2-2-6e1b491f6f3e@linux.spacemit.com/
> 
> Changelog in v2:
> - modify commit message
> - swap pinctrl-names and pinctrl-0 properties in uart0 node
> - rename model: "MusePi Pro" -> "SpacemiT MusePi Pro"
> - keep the dtb-$(CONFIG_ARCH_SPACEMIT) entries in alphabetical order
> - Link to v1: https://lore.kernel.org/all/20250928-k1-musepi-pro-dts-v1-2-5efcca0ce3ae@linux.spacemit.com/
> ---
>  arch/riscv/boot/dts/spacemit/Makefile          |  1 +
>  arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 79 ++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
> index 152832644870624d8fd77684ef33addb42b0baf3..942ecb38bea034ef5fbf2cef74e682ee0b6ad8f4 100644
> --- a/arch/riscv/boot/dts/spacemit/Makefile
> +++ b/arch/riscv/boot/dts/spacemit/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-bananapi-f3.dtb
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
> +dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
> diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..29e333b670cf0a5c4ed852668460db475b9c44cb
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + * Copyright (C) 2025 SpacemiT, Inc
> + * Copyright (C) 2025 Troy Mitchell <troy.mitchell@linux.spacemit.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "k1.dtsi"
> +#include "k1-pinctrl.dtsi"
> +
> +/ {
> +	model = "SpacemiT MusePi Pro";
> +	compatible = "spacemit,musepi-pro", "spacemit,k1";
> +
> +	aliases {
> +		ethernet0 = &eth0;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led1 {
> +			label = "sys-led";
> +			gpios = <&gpio K1_GPIO(96) GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "on";
> +		};
> +	};
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	non-removable;
> +	no-sd;
> +	no-sdio;

I doubt very much that 'no-sd' or 'no-sdio' are appropriate here. These
are not general properties, they are useful only for specific
workarounds of hardware that reacts badly to commands. Is the hardware
broken that it needs these properties?

-E

> +	status = "okay";
> +};
> +
> +&eth0 {
> +	phy-handle = <&rgmii0>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&gmac0_cfg>;
> +	pinctrl-names = "default";
> +	rx-internal-delay-ps = <0>;
> +	tx-internal-delay-ps = <0>;
> +	status = "okay";
> +
> +	mdio-bus {
> +		#address-cells = <0x1>;
> +		#size-cells = <0x0>;
> +
> +		reset-gpios = <&gpio K1_GPIO(110) GPIO_ACTIVE_LOW>;
> +		reset-delay-us = <10000>;
> +		reset-post-delay-us = <100000>;
> +
> +		rgmii0: phy@1 {
> +			reg = <0x1>;
> +		};
> +	};
> +};
> +
> +&pdma {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-0 = <&uart0_2_cfg>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> 


