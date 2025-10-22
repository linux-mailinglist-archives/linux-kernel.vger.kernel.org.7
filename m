Return-Path: <linux-kernel+bounces-865850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B33CFBFE2B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 525424F1568
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC0C2F9984;
	Wed, 22 Oct 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="SVBZsXY0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="aFdPVTw6"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2DC2EE60F;
	Wed, 22 Oct 2025 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164928; cv=pass; b=aKM8YmxCOUXz1VjegEnAwfxLH8nychCoVxK2JVrffnMyszRpIJucSf20gxyY4HbuljojjeVX+eGaImD1iPzfqP4PAYN3rXPCbYLZVErtK2y9EO3VwQc4L1nmS0BwadF3+uIiag3Bt7HlT7ZNfARXdvQwBMyjx4pVHXcv56gHLFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164928; c=relaxed/simple;
	bh=uUfGEAeYyifWrp8y/COgMEQdLshb4racSmBCT0YjRcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9ZvAcOO3IuV71ZAJv6sC72Ffqh07bNfWaVArarfGZNAQvJBzq+y8C8s4J8Sg/caxNQirRkuvrlOikV46+T0YEWtxea5Hej9P2AJyxnO6aQlGTnvYPmOyI8OKGkkXk0RLjv4v94SznZ36Z6KQeyIJwqcZ7vHNum/y2/nuvlDycA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=SVBZsXY0; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=aFdPVTw6; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-wsw7.prod.antispam.mailspamprotection.com; s=arckey; t=1761164925;
	 b=kCAwYIFv23N8VT2pXsGsaKOTnTUfg0yKnBoYLJqXM32k8JBTsyuIqgHZQW1zLnRYCc09am/HXp
	  ibumQxdktwTohbDiGHx5QC3rqh9++XPsrRgTSKMljsY+XBdbR92Xlh/VWaOc+nkMznE11//TvG
	  yS719Aufv29N2rIyWxtQUz3huaGiL14hI+ZSguSgS1lH5bJqsnn3/NYO+I66HzkF94M6zVmo12
	  rHGzaCGONlMJaeTNGcT7FEVp55DLrcP3Hx669wFdOSX1U/GT2WsbZHxK14TokEEdjZefCgS7Dc
	  FHv1IQkoiHOhiIv8Srb+GzG9aGqn3L3F1ehkper8U+9BVw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-wsw7.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-wsw7.prod.antispam.mailspamprotection.com; s=arckey; t=1761164925;
	bh=uUfGEAeYyifWrp8y/COgMEQdLshb4racSmBCT0YjRcU=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=HjecvMaCeBZlJP3BXQWlvAlrxKGv7ftxOMkDsmjuNzEdwZxxup8MMXToH6+NeCmbaS5bY5RBib
	  NfQIBzdBniU2dKIJ5cSq5efRWsiH/bY47vcYxiBo+xuN3jP/q8ciRgJxvqi7j42t69dyZ630xO
	  FW8gjkw3HrMMuM/BxSEFa7zbDMLbqXfJU3fi0wdzDWLfhLsjePbVaR+W2UO83Z/ir9uzvF3BMG
	  iwlD7BliLuGCQ9swj2hxvFikWfPTh/9ysOSgLHo/MUkgidwdOETso27T0dKMO4CKlK/vRtisC4
	  R91YgR9bQif7tU75wYluqkeAy7eL8bX0IuUKxIRxxH/z4Q==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=vBHCArIrmKWJj7F8K/MoPeEK7UtH9JL6UMvk/qyQGc8=; b=SVBZsXY0kPh17KEY+ePuYzub3k
	MQrTD2698zUCsEztDcKKfhaOz+P1UdAybxW6hp2VbLdotWrE/LWj/5t+0QM2tWvxyopw0usKFCOuS
	idiRO2ZXAk9VptE7eHsTpFkvCou4MjKNxvVcaKoCSZZ+3siVFiNwD0z9xECbRvVtVwBs=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-wsw7.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vBfRj-00000001iGO-20Ia;
	Wed, 22 Oct 2025 20:28:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=vBHCArIrmKWJj7F8K/MoPeEK7UtH9JL6UMvk/qyQGc8=; b=aFdPVTw6bihxKTm3hpC21QQXao
	DVrjJOFgrgsNdrWusnL+fNE/e7oaByxVS3VjUgLjhT1bTIk0+7G9mddyk+tUw+uf0QrQHbBqobBne
	chqfznM/4hqtUmJklPS+Xw4QtUOGJTq1X1vR/NM/IPoanB5jxsik0BiVXTEobZNEgg5I=;
Received: from [95.239.58.48] (port=63324 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vBfRc-000000008l3-06PG;
	Wed, 22 Oct 2025 20:28:28 +0000
From: Francesco Valla <francesco@valla.it>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Fabian Pflug <f.pflug@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Fabian Pflug <f.pflug@pengutronix.de>, Haidong Zheng <haidong.zheng@nxp.com>,
 Danwei Luo <danwei.luo@nxp.com>, Lei Xu <lei.xu@nxp.com>
Subject:
 Re: [PATCH v3 2/2] arm64: dts: freescale: add support for NXP i.MX93 FRDM
Date: Wed, 22 Oct 2025 22:28:22 +0200
Message-ID: <7192181.9J7NaK4W3v@fedora.fritz.box>
In-Reply-To: <20251022-fpg-nxp-imx93-frdm-v3-2-03ec40a1ccc0@pengutronix.de>
References:
 <20251022-fpg-nxp-imx93-frdm-v3-0-03ec40a1ccc0@pengutronix.de>
 <20251022-fpg-nxp-imx93-frdm-v3-2-03ec40a1ccc0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 239dd28fd21803f3dfa64e3578f87be3
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vBfRj-00000001iGO-20Ia-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-wsw7.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Fabian,

I restarted working on my FRDM just a couple of days ago, so this will
probably feel like a late review for the v2. Anyhow...

On Wednesday, 22 October 2025 at 16:05:23 Fabian Pflug <f.pflug@pengutronix.de> wrote:
> The FRDM i.MX 93 development board is a low-cost and compact development
> board featuring the i.MX93 applications processor.
> 
> It features:
> - Dual Cortex-A55
> - 2 GB LPDDR4X / LPDDR4
> - 32 GB eMMC5.1
> - MicroSD slot
> - GbE RJ45 x 2
> - USB2.0 1x Type C, 1x Type A
> 
> This file is based upon the one provided by nxp in their own kernel and
> yocto meta layer for the device, but adapted for mainline.
> 
> Signed-off-by: Haidong Zheng <haidong.zheng@nxp.com>
> Signed-off-by: Danwei Luo <danwei.luo@nxp.com>
> Signed-off-by: Lei Xu <lei.xu@nxp.com>
> Signed-off-by: Fabian Pflug <f.pflug@pengutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/Makefile             |   1 +
>  arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 658 +++++++++++++++++++++
>  2 files changed, 659 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 525ef180481d3..a7e5fdd6faff1 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -351,6 +351,7 @@ imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
>  dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb-i3c.dtb
>  
>  dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-frdm.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-14x14-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> new file mode 100644
> index 0000000000000..1f21eeb15b721
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> @@ -0,0 +1,658 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/dts-v1/;
> +
> +#include <dt-bindings/usb/pd.h>
> +#include "imx93.dtsi"
> +
> +/ {
> +	compatible = "fsl,imx93-11x11-frdm", "fsl,imx93";
> +	model = "NXP i.MX93 11X11 FRDM board";
> +
> +	aliases {
> +		ethernet0 = &fec;
> +		ethernet1 = &eqos;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		mmc0 = &usdhc1; /* EMMC */
> +		mmc1 = &usdhc2; /* uSD */
> +		rtc0 = &pcf2131;
> +		serial0 = &lpuart1;
> +	};
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		off-on-delay-us = <12000>;
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		pinctrl-names = "default";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-name = "VSD_3V3";
> +		vin-supply = <&buck4>;
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc3_vmmc: regulator-usdhc3 {

This is not used - maybe it should be disabled?

> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-name = "WLAN_EN";
> +		vin-supply = <&buck4>;
> +		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;

This does not seem to match the design files available for the FRDM on the NXP
website. The WiFi chip connected to the usdhc3 port is in fact powered by the
VPCIe_3V3 power rail, which is enabled by the EXT1_PWREN signal that is in turn
connected to GPIO 13 of the pcal6524 expander.

GPIO 20 of the pcal6524 expander should be driving M2_nDIS1 and then W2_nDIS1
and finally PDn/PCAL6408_RST, which is connected to the reset signal for a
PCAL6408 GPIO expander (U748).

This is at least what I understood, but you may have more information on the
DNP (Do Not Populated) madness inside the schematic.

> +		enable-active-high;
> +		/*
> +		 * IW612 wifi chip needs more delay than other wifi chips to complete
> +		 * the host interface initialization after power up, otherwise the
> +		 * internal state of IW612 may be unstable, resulting in the failure of
> +		 * the SDIO3.0 switch voltage.
> +		 */
> +		startup-delay-us = <20000>;
> +	};
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			alloc-ranges = <0 0x80000000 0 0x30000000>;
> +			reusable;
> +			size = <0 0x10000000>;
> +			linux,cma-default;
> +		};
> +
> +		rsc_table: rsc-table@2021e000 {
> +			reg = <0 0x2021e000 0 0x1000>;
> +			no-map;
> +		};
> +
> +		vdev0vring0: vdev0vring0@a4000000 {
> +			reg = <0 0xa4000000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: vdev0vring1@a4008000 {
> +			reg = <0 0xa4008000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring0: vdev1vring0@a4010000 {
> +			reg = <0 0xa4010000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdev1vring1: vdev1vring1@a4018000 {
> +			reg = <0 0xa4018000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		vdevbuffer: vdevbuffer@a4020000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0xa4020000 0 0x100000>;
> +			no-map;
> +		};
> +	};
> +
> +	usdhc3_pwrseq: usdhc3_pwrseq {

This is also not used.

> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&pcal6524 12 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply = <&buck5>;
> +	status = "okay";
> +};
> +
> +&mu1 {
> +	status = "okay";
> +};
> +
> +&cm33 {
> +	mboxes = <&mu1 0 1>,
> +		 <&mu1 1 1>,
> +		 <&mu1 3 1>;
> +	mbox-names = "tx", "rx", "rxdb";
> +	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> +			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> +	status = "okay";
> +};
> +
> +&eqos {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	pinctrl-1 = <&pinctrl_eqos_sleep>;
> +	phy-handle = <&ethphy1>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			reg = <1>;
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <80000>;
> +			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
> +			realtek,clkout-disable;
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	pinctrl-1 = <&pinctrl_fec_sleep>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy2>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy2: ethernet-phy@2 {
> +			reg = <2>;
> +			eee-broken-1000t;

eee-broken-1000t should not be required, see:

https://lore.kernel.org/all/20250901103632.3409896-6-joy.zou@nxp.com/

> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <80000>;
> +			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
> +			realtek,clkout-disable;
> +		};
> +	};
> +};
> +
> +&lpi2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	it6263: hdmi@4c {
> +		compatible = "ite,it6263";
> +		reg = <0x4c>;
> +		ivdd-supply = <&buck5>;
> +		ovdd-supply = <&buck4>;
> +		txavcc18-supply = <&buck5>;
> +		txavcc33-supply = <&buck4>;
> +		pvcc1-supply = <&buck5>;
> +		pvcc2-supply = <&buck5>;
> +		avcc-supply = <&buck4>;
> +		anvdd-supply = <&buck5>;
> +		apvdd-supply = <&buck5>;
> +	};
> +};
> +
> +&lpi2c2 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	pcal6524: gpio@22 {
> +		compatible = "nxp,pcal6524";
> +		reg = <0x22>;
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		pinctrl-0 = <&pinctrl_pcal6524>;
> +		pinctrl-names = "default";
> +		/* does not boot with supplier set, because it is the bucks interrupt parent */
> +		/* vcc-supply = <&buck4>; */
> +	};
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9451a";
> +		reg = <0x25>;
> +		interrupt-parent = <&pcal6524>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> +
> +		regulators {
> +
> +			buck1: BUCK1 {
> +				regulator-name = "VDD_SOC_0V8";
> +				regulator-min-microvolt = <650000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "LPD4_x_VDDQ_0V6";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <670000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck4: BUCK4 {
> +				regulator-name = "VDD_3V3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buck5: BUCK5 {
> +				regulator-name = "VDD_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "LPD4_x_VDD2_1V1";
> +				regulator-min-microvolt = <1100000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "NVCC_BBSM_1V8";
> +				regulator-min-microvolt = <1620000>;
> +				regulator-max-microvolt = <1980000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "VDD_ANA_0V8";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <840000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name = "NVCC_SD";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +		};
> +	};
> +
> +	eeprom: eeprom@50 {
> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +		pagesize = <64>;
> +		vcc-supply = <&buck4>;
> +	};
> +};
> +
> +&lpi2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	ptn5110: tcpc@50 {
> +		compatible = "nxp,ptn5110", "tcpci";
> +		reg = <0x50>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +
> +		typec1_con: connector {
> +			compatible = "usb-c-connector";
> +			data-role = "dual";
> +			label = "USB-C";
> +			op-sink-microwatt = <15000000>;
> +			power-role = "dual";
> +			self-powered;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +					PDO_VAR(5000, 20000, 3000)>;
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			try-power-role = "sink";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					typec1_dr_sw: endpoint {
> +						remote-endpoint = <&usb1_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	pcf2131: rtc@53 {
> +		compatible = "nxp,pcf2131";
> +		reg = <0x53>;
> +		interrupt-parent = <&pcal6524>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +};
> +
> +&lpuart1 { /* console */
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	adp-disable;
> +	disable-over-current;
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	usb-role-switch;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	status = "okay";
> +
> +	port {
> +

This white line should probably be removed.

> +		usb1_drd_sw: endpoint {
> +			remote-endpoint = <&typec1_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usbotg2 {
> +	disable-over-current;
> +	dr_mode = "host";
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	bus-width = <8>;
> +	non-removable;
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	vmmc-supply = <&buck4>;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	bus-width = <4>;
> +	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	no-mmc;
> +	no-sdio;
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	status = "okay";
> +};
> +
> +&wdog3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins = <
> +			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
> +			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
> +			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
> +			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
> +			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
> +			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
> +			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x58e
> +			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
> +			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
> +			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
> +			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
> +			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
> +			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
> +			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
> +		>;
> +	};
> +
> +	pinctrl_eqos_sleep: eqossleepgrp {
> +		fsl,pins = <
> +			MX93_PAD_ENET1_MDC__GPIO4_IO00			0x31e
> +			MX93_PAD_ENET1_MDIO__GPIO4_IO01			0x31e
> +			MX93_PAD_ENET1_RD0__GPIO4_IO10			0x31e
> +			MX93_PAD_ENET1_RD1__GPIO4_IO11			0x31e
> +			MX93_PAD_ENET1_RD2__GPIO4_IO12			0x31e
> +			MX93_PAD_ENET1_RD3__GPIO4_IO13			0x31e
> +			MX93_PAD_ENET1_RXC__GPIO4_IO09			0x31e
> +			MX93_PAD_ENET1_RX_CTL__GPIO4_IO08		0x31e
> +			MX93_PAD_ENET1_TD0__GPIO4_IO05			0x31e
> +			MX93_PAD_ENET1_TD1__GPIO4_IO04			0x31e
> +			MX93_PAD_ENET1_TD2__GPIO4_IO03			0x31e
> +			MX93_PAD_ENET1_TD3__GPIO4_IO02			0x31e
> +			MX93_PAD_ENET1_TXC__GPIO4_IO07			0x31e
> +			MX93_PAD_ENET1_TX_CTL__GPIO4_IO06		0x31e
> +		>;
> +	};
> +
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX93_PAD_ENET2_MDC__ENET1_MDC			0x57e
> +			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x57e
> +			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
> +			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
> +			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
> +			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
> +			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x58e
> +			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
> +			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x57e
> +			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x57e
> +			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2		0x57e
> +			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3		0x57e
> +			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x58e
> +			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
> +		>;
> +	};
> +
> +	pinctrl_fec_sleep: fecsleepgrp {
> +		fsl,pins = <
> +			MX93_PAD_ENET2_MDC__GPIO4_IO14			0x51e
> +			MX93_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
> +			MX93_PAD_ENET2_RD0__GPIO4_IO24			0x51e
> +			MX93_PAD_ENET2_RD1__GPIO4_IO25			0x51e
> +			MX93_PAD_ENET2_RD2__GPIO4_IO26			0x51e
> +			MX93_PAD_ENET2_RD3__GPIO4_IO27			0x51e
> +			MX93_PAD_ENET2_RXC__GPIO4_IO23			0x51e
> +			MX93_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
> +			MX93_PAD_ENET2_TD0__GPIO4_IO19			0x51e
> +			MX93_PAD_ENET2_TD1__GPIO4_IO18			0x51e
> +			MX93_PAD_ENET2_TD2__GPIO4_IO17			0x51e
> +			MX93_PAD_ENET2_TD3__GPIO4_IO16			0x51e
> +			MX93_PAD_ENET2_TXC__GPIO4_IO21			0x51e
> +			MX93_PAD_ENET2_TX_CTL__GPIO4_IO20		0x51e
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan2grp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO25__CAN2_TX			0x139e
> +			MX93_PAD_GPIO_IO27__CAN2_RX			0x139e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins = <
> +			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
> +			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c2: lpi2c2grp {
> +		fsl,pins = <
> +			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
> +			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c3: lpi2c3grp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
> +			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_pcal6524: pcal6524grp {
> +		fsl,pins = <
> +			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_RESET_B__GPIO3_IO07		0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
> +			MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
> +		>;
> +	};
> +
> +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX93_PAD_SD1_CLK__USDHC1_CLK		0x1582
> +			MX93_PAD_SD1_CMD__USDHC1_CMD		0x40001382
> +			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x40001382
> +			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x40001382
> +			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x40001382
> +			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x40001382
> +			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x40001382
> +			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x40001382
> +			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x40001382
> +			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x40001382
> +			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
> +		>;
> +	};
> +
> +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD1_CLK__USDHC1_CLK		0x158e
> +			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000138e
> +			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000138e
> +			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000138e
> +			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000138e
> +			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000138e
> +			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000138e
> +			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000138e
> +			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000138e
> +			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000138e
> +			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
> +		>;
> +	};
> +
> +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
> +			MX93_PAD_SD1_CMD__USDHC1_CMD		0x400013fe
> +			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x400013fe
> +			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x400013fe
> +			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x400013fe
> +			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x400013fe
> +			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x400013fe
> +			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x400013fe
> +			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x400013fe
> +			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x400013fe
> +			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x51e
> +		>;
> +	};
> +
> +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x1582
> +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x40001382
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x40001382
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x40001382
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x40001382
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x40001382
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x158e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000138e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000138e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000138e
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	/* need to config the SION for data and cmd pad, refer to ERR052021 */
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
> +			MX93_PAD_SD2_CMD__USDHC2_CMD		0x400013fe
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x400013fe
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x400013fe
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x400013fe
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x400013fe
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_sleep: usdhc2-sleepgrp {
> +		fsl,pins = <
> +			MX93_PAD_SD2_CLK__GPIO3_IO01		0x51e
> +			MX93_PAD_SD2_CMD__GPIO3_IO02		0x51e
> +			MX93_PAD_SD2_DATA0__GPIO3_IO03		0x51e
> +			MX93_PAD_SD2_DATA1__GPIO3_IO04		0x51e
> +			MX93_PAD_SD2_DATA2__GPIO3_IO05		0x51e
> +			MX93_PAD_SD2_DATA3__GPIO3_IO06		0x51e
> +			MX93_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX93_PAD_WDOG_ANY__WDOG1_WDOG_ANY	0x31e
> +		>;
> +	};
> +};
> 
> 


Just FYI: there is a open bug on v6.18-rc2 which prevent the Bluetooth chip to
work correctly. Just a heads up, as I wasted some _hours_ chasing it yesterday:

https://lore.kernel.org/all/6837167.ZASKD2KPVS@fedora.fritz.box/


Thank you!

Regards,
Francesco





