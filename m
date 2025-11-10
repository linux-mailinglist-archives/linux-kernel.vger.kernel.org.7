Return-Path: <linux-kernel+bounces-893284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69518C4701A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4382423671
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ABA30F7FE;
	Mon, 10 Nov 2025 13:41:43 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A81530100C;
	Mon, 10 Nov 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782103; cv=none; b=VgwtQlg39vnrhaYTkQpG9wZRDVC1UHXkjM0Kk4WB3XYfmz5RfIFuB7dzZNQjR4aYdluUl0ONAFRR3kss+beIY7HwcMwzw51bQDs9tndQgu2JWsDka9+9+4bvPm9nCrbdiIMAwNRypAAgYUBMUqy3875bP5u+EF1RKfImYjveWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782103; c=relaxed/simple;
	bh=JVmNN5egqZn5X4OR/MBTzKFEa1M2nzmDvB1tCKL8b0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UasAOsr6hSTyoSM7/kvY+fYzOzLjRKQ8XzDx//4ot69/w3gqlFfM5ACfWMtfynrtfuVkiVoXzKDhzzcoqsYMg/8E/0At9fqS2lrXgRz+jNlJp3uZF1CfOSp8i8DhE+4/XAkNlzbR5T531/4r5DhYrP1o7RXdKX2vOfleAFS9gqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6D29C340F7B;
	Mon, 10 Nov 2025 13:41:40 +0000 (UTC)
Date: Mon, 10 Nov 2025 21:41:34 +0800
From: Yixun Lan <dlan@gentoo.org>
To: michael.opdenacker@rootcommit.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: Add OrangePi R2S board
 device tree
Message-ID: <20251110134134-GYC1651402@gentoo.org>
References: <20251110101110.948198-1-michael.opdenacker@rootcommit.com>
 <20251110101110.948198-3-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110101110.948198-3-michael.opdenacker@rootcommit.com>

Hi Michael,

On 10:11 Mon 10 Nov     , michael.opdenacker@rootcommit.com wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> Add initial device tree support for the OrangePi RV2 board [1], which is
> marketed as using the Ky X1 SoC but has been confirmed to be
> identical to the SpacemiT K1 [2].
> 
..
> The device tree is similar to the OrangePi RV2 device tree
> (k1-orangepi-rv2.dts).
Drop above, this info is useless, will even bring more confusion

> 
> This minimal device tree enables:
> 
..
> - booting into a serial console with UART.
 Enable UART0, to boot into a serial console
> 
> - the two RGMII ethernet ports
>   supporting Gigabit Ethernet operation.
> 
>   They have an external Motorcomm YT8531C PHY attached,
>   the PHY uses GPIO for reset pin control. 
..
> Their description
>   was reused from the DTS from the OrangePi RV2 board.
As I commented in v1, please drop above which is not technical related, useless..

Two Gigabit ethernet ports with RGMII interface standard support are enabled,
each port is connected to an external Motorcomm YT8531C PHY chip which uses
the GPIO for reset control. 

(I'm no native english speaker, try to slightly rearrange above text)
> 
> - PDMA for the SpacemiT K1-based SoC.
> 
> - the 8 GB eMMC chip for storage.
..
>   It works fine with the same description as
>   on the BananaPi F3 board DTS.
ditto, useless & drop
> 
> Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-R2S.html [1]
> Link: https://www.spacemit.com/en/key-stone-k1 [2]
> 
ditto, no blank line
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> ---
>  arch/riscv/boot/dts/spacemit/Makefile         |  1 +
>  .../boot/dts/spacemit/k1-orangepi-r2s.dts     | 90 +++++++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts
> 
> diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
> index 942ecb38bea0..96b3a13a3944 100644
> --- a/arch/riscv/boot/dts/spacemit/Makefile
> +++ b/arch/riscv/boot/dts/spacemit/Makefile
> @@ -3,3 +3,4 @@ dtb-$(CONFIG_ARCH_SPACEMIT) += k1-bananapi-f3.dtb
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
> +dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-r2s.dtb
ditto, please sort
> diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts
> new file mode 100644
> index 000000000000..58098c4a2aab
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2025 Michael Opdenacker <michael.opdenacker@rootcommit.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "k1.dtsi"
> +#include "k1-pinctrl.dtsi"
> +
> +/ {
> +	model = "OrangePi R2S";
> +	compatible = "xunlong,orangepi-r2s", "spacemit,k1";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		ethernet0 = &eth0;
> +		ethernet1 = &eth1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
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
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_cfg>;
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
> +&eth1 {
> +	phy-handle = <&rgmii1>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1_cfg>;
> +	rx-internal-delay-ps = <0>;
> +	tx-internal-delay-ps = <250>;
> +	status = "okay";
> +
> +	mdio-bus {
> +		#address-cells = <0x1>;
> +		#size-cells = <0x0>;
> +
> +		reset-gpios = <&gpio K1_GPIO(115) GPIO_ACTIVE_LOW>;
> +		reset-delay-us = <10000>;
> +		reset-post-delay-us = <100000>;
> +
> +		rgmii1: phy@1 {
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
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_2_cfg>;
> +	status = "okay";
> +};

-- 
Yixun Lan (dlan)

