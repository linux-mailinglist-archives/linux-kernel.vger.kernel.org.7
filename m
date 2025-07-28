Return-Path: <linux-kernel+bounces-747737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB1B1377A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2B93B9658
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E1022FF35;
	Mon, 28 Jul 2025 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="J66IDO88"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7E2222A1;
	Mon, 28 Jul 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694851; cv=none; b=VA0oic6FWom7M3tzzHhNA5eMtDLqPCAIk1sE5g3FG/rDi4Jpsy55lADItkArQP/v80fL10OmwG7S4q28MA+3uQu6tgRlfWzuE28dXLC0qeglK8GZj/00iPyxZuU6iotHlY8MAiBqYiX+2Bmg8maQmqqTc0dwRYA33y22YhIB9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694851; c=relaxed/simple;
	bh=hw4M2zRp0d0iyIeLhIR+elkP56M2HbdstMFdubAmc3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=luZvk4sbYs8JY6ceociYL8suT8s14MqjAsDulcJQzoHmYQtaWWXIH2qk+DI5OTX9UtrTv0te3cWemVPdhoFReeNNPjx101AfwvXOuXVcdbAJw0i4kyMjBb05xlZMH5JkYDxM21hGyDE7AX3yfk0rxKUu95qnRcUj/SP1zJCcpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=J66IDO88; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S8oJws028487;
	Mon, 28 Jul 2025 11:27:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	qjaap1c605DgED2OUbopq8ik8kbgxNG8ubEDxIPQs3w=; b=J66IDO88xi4/al8q
	Ti+iQHCFWOVPhBrwTbmBYQe5lcEWmXp9zd4Xf5mXq6PBMwI26Al4RNRzflKTIcV+
	+qXw8KTgZ1U90ZPpMLZ7e9wFUER4k2pWqcbsMhiHhy+9NXyYJoTSGpwdOH/UvPUm
	M627fNbwLtSmTrspEgZR3GE45Hm845B5qSf0bt6Qh2lQdX8UcR27T9OlZZUs46Xh
	r7D7Ik7sKk6HMwnPnJKbHuNjyat94BFDsv+bIVluRTHqBcuz4eJ54CIgRUDBqkGY
	RsSorRY8oohedD7HvkImbvBZDcO38qKIFoTugJRWAyNHNhugh0I8TxnoG3TTsTgZ
	cBiWmQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4859ynche2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 11:27:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DCC5540046;
	Mon, 28 Jul 2025 11:26:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3289D7530B4;
	Mon, 28 Jul 2025 11:25:47 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 11:25:46 +0200
Message-ID: <78a827ae-0b1b-4b41-94f6-e9e4418d1fe1@foss.st.com>
Date: Mon, 28 Jul 2025 11:25:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ARM: sti: drop B2120 board support
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
 <20250714-sti-rework-v2-1-f4274920858b@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250714-sti-rework-v2-1-f4274920858b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01



On 7/14/25 15:49, Raphael Gallais-Pou wrote:
> B2120 boards are internal boards which never were commercialised.
> 
> Drop them.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  arch/arm/boot/dts/st/Makefile           |   2 -
>  arch/arm/boot/dts/st/stih407-b2120.dts  |  27 -----
>  arch/arm/boot/dts/st/stih407.dtsi       | 145 ----------------------
>  arch/arm/boot/dts/st/stih410-b2120.dts  |  66 ----------
>  arch/arm/boot/dts/st/stihxxx-b2120.dtsi | 206 --------------------------------
>  5 files changed, 446 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
> index cc9948b9870f7f73629573149bfd342af75b07da..f57fc6dc48a00c9a9323b4508e5e4e161b197c47 100644
> --- a/arch/arm/boot/dts/st/Makefile
> +++ b/arch/arm/boot/dts/st/Makefile
> @@ -13,8 +13,6 @@ dtb-$(CONFIG_ARCH_SPEAR3XX) += \
>  dtb-$(CONFIG_ARCH_SPEAR6XX) += \
>  	spear600-evb.dtb
>  dtb-$(CONFIG_ARCH_STI) += \
> -	stih407-b2120.dtb \
> -	stih410-b2120.dtb \
>  	stih410-b2260.dtb \
>  	stih418-b2199.dtb \
>  	stih418-b2264.dtb
> diff --git a/arch/arm/boot/dts/st/stih407-b2120.dts b/arch/arm/boot/dts/st/stih407-b2120.dts
> deleted file mode 100644
> index 9c79982ee7ba8fadb1a2a92e732bf7f652b74c38..0000000000000000000000000000000000000000
> --- a/arch/arm/boot/dts/st/stih407-b2120.dts
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2014 STMicroelectronics (R&D) Limited.
> - * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> - */
> -/dts-v1/;
> -#include "stih407.dtsi"
> -#include "stihxxx-b2120.dtsi"
> -/ {
> -	model = "STiH407 B2120";
> -	compatible = "st,stih407-b2120", "st,stih407";
> -
> -	chosen {
> -		stdout-path = &sbc_serial0;
> -	};
> -
> -	memory@40000000 {
> -		device_type = "memory";
> -		reg = <0x40000000 0x80000000>;
> -	};
> -
> -	aliases {
> -		serial0 = &sbc_serial0;
> -		ethernet0 = &ethernet0;
> -	};
> -
> -};
> diff --git a/arch/arm/boot/dts/st/stih407.dtsi b/arch/arm/boot/dts/st/stih407.dtsi
> deleted file mode 100644
> index aca43d2bdaad44ef2a0e8a120c679c217709af44..0000000000000000000000000000000000000000
> --- a/arch/arm/boot/dts/st/stih407.dtsi
> +++ /dev/null
> @@ -1,145 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2015 STMicroelectronics Limited.
> - * Author: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> - */
> -#include "stih407-clock.dtsi"
> -#include "stih407-family.dtsi"
> -#include <dt-bindings/gpio/gpio.h>
> -/ {
> -	soc {
> -		sti-display-subsystem@0 {
> -			compatible = "st,sti-display-subsystem";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			reg = <0 0>;
> -			assigned-clocks = <&clk_s_d2_quadfs 0>,
> -					  <&clk_s_d2_quadfs 1>,
> -					  <&clk_s_c0_pll1 0>,
> -					  <&clk_s_c0_flexgen CLK_COMPO_DVP>,
> -					  <&clk_s_c0_flexgen CLK_MAIN_DISP>,
> -					  <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
> -					  <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
> -					  <&clk_s_d2_flexgen CLK_PIX_GDP1>,
> -					  <&clk_s_d2_flexgen CLK_PIX_GDP2>,
> -					  <&clk_s_d2_flexgen CLK_PIX_GDP3>,
> -					  <&clk_s_d2_flexgen CLK_PIX_GDP4>;
> -
> -			assigned-clock-parents = <0>,
> -						 <0>,
> -						 <0>,
> -						 <&clk_s_c0_pll1 0>,
> -						 <&clk_s_c0_pll1 0>,
> -						 <&clk_s_d2_quadfs 0>,
> -						 <&clk_s_d2_quadfs 1>,
> -						 <&clk_s_d2_quadfs 0>,
> -						 <&clk_s_d2_quadfs 0>,
> -						 <&clk_s_d2_quadfs 0>,
> -						 <&clk_s_d2_quadfs 0>;
> -
> -			assigned-clock-rates = <297000000>,
> -					       <108000000>,
> -					       <0>,
> -					       <400000000>,
> -					       <400000000>;
> -
> -			ranges;
> -
> -			sti-compositor@9d11000 {
> -				compatible = "st,stih407-compositor";
> -				reg = <0x9d11000 0x1000>;
> -
> -				clock-names = "compo_main",
> -					      "compo_aux",
> -					      "pix_main",
> -					      "pix_aux",
> -					      "pix_gdp1",
> -					      "pix_gdp2",
> -					      "pix_gdp3",
> -					      "pix_gdp4",
> -					      "main_parent",
> -					      "aux_parent";
> -
> -				clocks = <&clk_s_c0_flexgen CLK_COMPO_DVP>,
> -					 <&clk_s_c0_flexgen CLK_COMPO_DVP>,
> -					 <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
> -					 <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
> -					 <&clk_s_d2_flexgen CLK_PIX_GDP1>,
> -					 <&clk_s_d2_flexgen CLK_PIX_GDP2>,
> -					 <&clk_s_d2_flexgen CLK_PIX_GDP3>,
> -					 <&clk_s_d2_flexgen CLK_PIX_GDP4>,
> -					 <&clk_s_d2_quadfs 0>,
> -					 <&clk_s_d2_quadfs 1>;
> -
> -				reset-names = "compo-main", "compo-aux";
> -				resets = <&softreset STIH407_COMPO_SOFTRESET>,
> -					 <&softreset STIH407_COMPO_SOFTRESET>;
> -				st,vtg = <&vtg_main>, <&vtg_aux>;
> -			};
> -
> -			sti-tvout@8d08000 {
> -				compatible = "st,stih407-tvout";
> -				reg = <0x8d08000 0x1000>;
> -				reg-names = "tvout-reg";
> -				reset-names = "tvout";
> -				resets = <&softreset STIH407_HDTVOUT_SOFTRESET>;
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				assigned-clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
> -						  <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
> -						  <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
> -						  <&clk_s_d0_flexgen CLK_PCM_0>,
> -						  <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
> -						  <&clk_s_d2_flexgen CLK_HDDAC>;
> -
> -				assigned-clock-parents = <&clk_s_d2_quadfs 0>,
> -							 <&clk_tmdsout_hdmi>,
> -							 <&clk_s_d2_quadfs 0>,
> -							 <&clk_s_d0_quadfs 0>,
> -							 <&clk_s_d2_quadfs 0>,
> -							 <&clk_s_d2_quadfs 0>;
> -			};
> -
> -			sti_hdmi: sti-hdmi@8d04000 {
> -				compatible = "st,stih407-hdmi";
> -				reg = <0x8d04000 0x1000>;
> -				reg-names = "hdmi-reg";
> -				#sound-dai-cells = <0>;
> -				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names = "irq";
> -				clock-names = "pix",
> -					      "tmds",
> -					      "phy",
> -					      "audio",
> -					      "main_parent",
> -					      "aux_parent";
> -
> -				clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
> -					 <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
> -					 <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
> -					 <&clk_s_d0_flexgen CLK_PCM_0>,
> -					 <&clk_s_d2_quadfs 0>,
> -					 <&clk_s_d2_quadfs 1>;
> -
> -				hdmi,hpd-gpio = <&pio5 3 GPIO_ACTIVE_LOW>;
> -				reset-names = "hdmi";
> -				resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
> -				ddc = <&hdmiddc>;
> -			};
> -
> -			sti-hda@8d02000 {
> -				compatible = "st,stih407-hda";
> -				reg = <0x8d02000 0x400>, <0x92b0120 0x4>;
> -				reg-names = "hda-reg", "video-dacs-ctrl";
> -				clock-names = "pix",
> -					      "hddac",
> -					      "main_parent",
> -					      "aux_parent";
> -				clocks = <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
> -					 <&clk_s_d2_flexgen CLK_HDDAC>,
> -					 <&clk_s_d2_quadfs 0>,
> -					 <&clk_s_d2_quadfs 1>;
> -			};
> -		};
> -	};
> -};
> diff --git a/arch/arm/boot/dts/st/stih410-b2120.dts b/arch/arm/boot/dts/st/stih410-b2120.dts
> deleted file mode 100644
> index 538ff98ca1b1b6542f98a18f68968f030b8c55c0..0000000000000000000000000000000000000000
> --- a/arch/arm/boot/dts/st/stih410-b2120.dts
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2014 STMicroelectronics (R&D) Limited.
> - * Author: Peter Griffin <peter.griffin@linaro.org>
> - */
> -/dts-v1/;
> -#include "stih410.dtsi"
> -#include "stihxxx-b2120.dtsi"
> -/ {
> -	model = "STiH410 B2120";
> -	compatible = "st,stih410-b2120", "st,stih410";
> -
> -	chosen {
> -		stdout-path = &sbc_serial0;
> -	};
> -
> -	memory@40000000 {
> -		device_type = "memory";
> -		reg = <0x40000000 0x80000000>;
> -	};
> -
> -	aliases {
> -		serial0 = &sbc_serial0;
> -		ethernet0 = &ethernet0;
> -	};
> -
> -	usb2_picophy1: phy2 {
> -		status = "okay";
> -	};
> -
> -	usb2_picophy2: phy3 {
> -		status = "okay";
> -	};
> -
> -	soc {
> -
> -		mmc0: sdhci@9060000 {
> -			max-frequency = <200000000>;
> -			sd-uhs-sdr50;
> -			sd-uhs-sdr104;
> -			sd-uhs-ddr50;
> -		};
> -
> -		ohci0: usb@9a03c00 {
> -			status = "okay";
> -		};
> -
> -		ehci0: usb@9a03e00 {
> -			status = "okay";
> -		};
> -
> -		ohci1: usb@9a83c00 {
> -			status = "okay";
> -		};
> -
> -		ehci1: usb@9a83e00 {
> -			status = "okay";
> -		};
> -
> -		sti-display-subsystem@0 {
> -			sti-hda@8d02000 {
> -				status = "okay";
> -			};
> -		};
> -	};
> -};
> diff --git a/arch/arm/boot/dts/st/stihxxx-b2120.dtsi b/arch/arm/boot/dts/st/stihxxx-b2120.dtsi
> deleted file mode 100644
> index 8d9a2dfa76f1fe55b954803cab8d00003a8ebec0..0000000000000000000000000000000000000000
> --- a/arch/arm/boot/dts/st/stihxxx-b2120.dtsi
> +++ /dev/null
> @@ -1,206 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (C) 2014 STMicroelectronics (R&D) Limited.
> - * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> - */
> -#include <dt-bindings/clock/stih407-clks.h>
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/media/c8sectpfe.h>
> -/ {
> -	leds {
> -		compatible = "gpio-leds";
> -		led-red {
> -			label = "Front Panel LED";
> -			gpios = <&pio4 1 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -		led-green {
> -			gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
> -			default-state = "off";
> -		};
> -	};
> -
> -	sound: sound {
> -		compatible = "simple-audio-card";
> -		simple-audio-card,name = "STI-B2120";
> -		status = "okay";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		simple-audio-card,dai-link@0 {
> -			reg = <0>;
> -			/* HDMI */
> -			format = "i2s";
> -			mclk-fs = <128>;
> -			cpu {
> -				sound-dai = <&sti_uni_player0>;
> -			};
> -
> -			codec {
> -				sound-dai = <&sti_hdmi>;
> -			};
> -		};
> -
> -		simple-audio-card,dai-link@1 {
> -			reg = <1>;
> -			/* DAC */
> -			format = "i2s";
> -			mclk-fs = <256>;
> -			frame-inversion;
> -			cpu {
> -				sound-dai = <&sti_uni_player2>;
> -			};
> -
> -			codec {
> -				sound-dai = <&sti_sasg_codec 1>;
> -			};
> -		};
> -
> -		simple-audio-card,dai-link@2 {
> -			reg = <2>;
> -			/* SPDIF */
> -			format = "left_j";
> -			mclk-fs = <128>;
> -			cpu {
> -				sound-dai = <&sti_uni_player3>;
> -			};
> -
> -			codec {
> -				sound-dai = <&sti_sasg_codec 0>;
> -			};
> -		};
> -	};
> -
> -	miphy28lp_phy: miphy28lp {
> -
> -		phy_port0: port@9b22000 {
> -			st,osc-rdy;
> -		};
> -
> -		phy_port1: port@9b2a000 {
> -			st,osc-force-ext;
> -		};
> -	};
> -
> -	soc {
> -		sbc_serial0: serial@9530000 {
> -			status = "okay";
> -		};
> -
> -		pwm0: pwm@9810000 {
> -			status = "okay";
> -		};
> -
> -		pwm1: pwm@9510000 {
> -			status = "okay";
> -		};
> -
> -		ssc2: i2c@9842000 {
> -			status = "okay";
> -			clock-frequency = <100000>;
> -			st,i2c-min-scl-pulse-width-us = <0>;
> -			st,i2c-min-sda-pulse-width-us = <5>;
> -		};
> -
> -		ssc3: i2c@9843000 {
> -			status = "okay";
> -			clock-frequency = <100000>;
> -			st,i2c-min-scl-pulse-width-us = <0>;
> -			st,i2c-min-sda-pulse-width-us = <5>;
> -		};
> -
> -		i2c@9844000 {
> -			status = "okay";
> -		};
> -
> -		i2c@9845000 {
> -			status = "okay";
> -		};
> -
> -		i2c@9540000 {
> -			status = "okay";
> -		};
> -
> -		mmc0: sdhci@9060000 {
> -			non-removable;
> -			status = "okay";
> -		};
> -
> -		mmc1: sdhci@9080000 {
> -			status = "okay";
> -		};
> -
> -		/* SSC11 to HDMI */
> -		hdmiddc: i2c@9541000 {
> -			status = "okay";
> -			/* HDMI V1.3a supports Standard mode only */
> -			clock-frequency = <100000>;
> -			st,i2c-min-scl-pulse-width-us = <0>;
> -			st,i2c-min-sda-pulse-width-us = <5>;
> -		};
> -
> -		st_dwc3: dwc3@8f94000 {
> -			status = "okay";
> -		};
> -
> -		ethernet0: dwmac@9630000 {
> -			st,tx-retime-src = "clkgen";
> -			status = "okay";
> -			phy-mode = "rgmii";
> -			fixed-link = <0 1 1000 0 0>;
> -		};
> -
> -		demux@8a20000 {
> -			compatible	= "st,stih407-c8sectpfe";
> -			status		= "okay";
> -			reg		= <0x08a20000 0x10000>,
> -					  <0x08a00000 0x4000>;
> -			reg-names	= "c8sectpfe", "c8sectpfe-ram";
> -			interrupts	= <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> -					  <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names	= "c8sectpfe-error-irq",
> -					  "c8sectpfe-idle-irq";
> -			pinctrl-0	= <&pinctrl_tsin0_serial>;
> -			pinctrl-1	= <&pinctrl_tsin0_parallel>;
> -			pinctrl-2	= <&pinctrl_tsin3_serial>;
> -			pinctrl-3	= <&pinctrl_tsin4_serial_alt3>;
> -			pinctrl-4	= <&pinctrl_tsin5_serial_alt1>;
> -			pinctrl-names	= "tsin0-serial",
> -					  "tsin0-parallel",
> -					  "tsin3-serial",
> -					  "tsin4-serial",
> -					  "tsin5-serial";
> -			clocks		= <&clk_s_c0_flexgen CLK_PROC_STFE>;
> -			clock-names	= "c8sectpfe";
> -
> -			/* tsin0 is TSA on NIMA */
> -			tsin0: port {
> -				tsin-num = <0>;
> -				serial-not-parallel;
> -				i2c-bus = <&ssc2>;
> -				reset-gpios = <&pio15 4 GPIO_ACTIVE_LOW>;
> -				dvb-card = <STV0367_TDA18212_NIMA_1>;
> -			};
> -		};
> -
> -		sti_uni_player0: sti-uni-player@8d80000 {
> -			status = "okay";
> -		};
> -
> -		sti_uni_player2: sti-uni-player@8d82000 {
> -			status = "okay";
> -		};
> -
> -		sti_uni_player3: sti-uni-player@8d85000 {
> -			status = "okay";
> -		};
> -
> -		syscfg_core: core-syscfg@92b0000 {
> -			sti_sasg_codec: sti-sasg-codec {
> -				status = "okay";
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&pinctrl_spdif_out>;
> -			};
> -		};
> -	};
> -};
> 


Hi Rahael

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks

