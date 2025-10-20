Return-Path: <linux-kernel+bounces-859953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0610BEF08A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15FEB34875D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56601B81D3;
	Mon, 20 Oct 2025 01:52:12 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5015A86D;
	Mon, 20 Oct 2025 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760925132; cv=none; b=lVJRbXrwoWzU6ZJinuR6zN6+ZxT0UpgT2aiQGJ09o/ogOdAQyaZhkkL5dASXyXeYdE9lML1NXky/orcaFk6nZA+RWDKNI0ziPJg1iRiwwMPJ8GxB0adwh7NcKlegi3gxZEivuv87Gu2hhFd7Oe/yb20xH3bK8Te/1mTMQYUO5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760925132; c=relaxed/simple;
	bh=+BqNPlnJZucWLPsYuw/9JaOVHs4p5MfWP+ez/XuG3O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e83d9v8+M1gCUoNZFnM30lqImeNa0oxHoapINOvXH6WQNJsRGf7OttVMT/hj7IiQmUv/52Ys4xFi2u3brzOUny9IlCQsXnfOej7Y9Bn9DeF8k11HR9mK0ajl3kpDNt2BeeG6AVVusAra0Ym0ErwKWO70LhomGAz/RUMYvaLKyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id F010A341F00;
	Mon, 20 Oct 2025 01:52:08 +0000 (UTC)
Date: Mon, 20 Oct 2025 09:52:04 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] riscv: dts: spacemit: add MusePi Pro board device
 tree
Message-ID: <20251020015204-GYF1506524@gentoo.org>
References: <20251017-k1-musepi-pro-dts-v3-0-40b05491699f@linux.spacemit.com>
 <20251017-k1-musepi-pro-dts-v3-2-40b05491699f@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017-k1-musepi-pro-dts-v3-2-40b05491699f@linux.spacemit.com>

Hi Troy,

On 13:52 Fri 17 Oct     , Troy Mitchell wrote:
> Add initial device tree support for the MusePi Pro board [1].
> The board is using the SpacemiT K1/M1 SoC.
> 
> The device tree is adapted from the SpacemiT vendor tree [2].
> 
> Here's a refined list of its core features for consideration:
>   - SoC: SpacemiT M1/K1, 8-core 64-bit RISC-V with 2.0 TOPS AI power.
>          This suggests potential for light AI/ML workloads on-device.
>   - Memory: LPDDR4X @ 2400MT/s, available in 8GB & 16GB options.
>             Sufficient for various workloads.
>   - Storage: Onboard eMMC 5.1 (64GB/128GB options). M.2 M-Key for NVMe
>              SSD (2230 size), and a microSD slot (UHS-II) for expansion.
>              Good variety for boot and data.
>   - Display: HDMI 1.4 (1080P@60Hz) and 2-lane MIPI DSI FPC (1080P@60Hz).
>              Standard display options.
>   - Connectivity: Onboard Wi-Fi 6 & Bluetooth 5.2. A single Gigabit
>                   Ethernet port (RJ45). Given the stated markets,
>                   this should cover basic networking.
>   - USB: 4x USB 3.0 Type-A (host) and 1x USB 2.0 Type-C (device/OTG).
>          Decent host capabilities.
>   - Expansion: Full-size miniPCIe slot for assorted modules
>                (4G/5G, wireless etc.). A second M.2 M-Key (2230) for more
>                general PCIe devices (SSD, PCIe-to-SATA, comm boards).
>   - GPIO: Standard 40-pin GPIO interface, as expected for an SBC.
>   - MIPI: Includes 1x 4-lane MIPI CSI FPC and 2x MIPI DSI FPC interfaces
>           for cameras and displays.
>   - Clock: Onboard RTC with battery support.
I think you've already gave an overall description for MusePi board in
patch [1/2] which is sufficient, in this patch you could better focus on
what it actually done here? enabling mmc, ethernet, led, pdma, uart..

> 
> This minimal device tree enables booting into a serial console with UART
> output and a blinking LED.
> 
> Link: https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
> Link: https://gitee.com/bianbu-linux/linux-6.6/blob/k1-bl-v2.2.y/arch/riscv/boot/dts/spacemit/k1-x_MUSE-Pi-Pro.dts [2]
> 
ditto
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
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
>  arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 78 ++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+)
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
> index 0000000000000000000000000000000000000000..590c9bdbdfda4d6ddd97a96e10fcaef0a75f3390
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
..
> + * Copyright (C) 2025 Troy Mitchell <troy.mitchell@linux.spacemit.com>
this isn't a big problem, but I think it would be better to use SpacemiT
Corp's Copyright, to reflect you're not doing as individual contributor..
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
> -- 
> 2.51.0
> 

-- 
Yixun Lan (dlan)

