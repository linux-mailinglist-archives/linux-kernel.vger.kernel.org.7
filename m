Return-Path: <linux-kernel+bounces-723016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EF4AFE1D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512925A0549
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974CD22B8C2;
	Wed,  9 Jul 2025 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpG1NOWh"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894F21ADAE;
	Wed,  9 Jul 2025 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048169; cv=none; b=CCBY98JHWeUUFVmd9/aWMrkhN89P89ural6JqqqymXFNlMQxssLAzmb2XpvTPiXNqGKphUwqG9cRsJCz7C4O1rqgXtITyy4AvH8sdHW1wLqXM2eP/olJnhTuCxTjk0jDGf+mXGxwDYNlwMfuLKLumnJBleZRfj6VBbR9nN+kTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048169; c=relaxed/simple;
	bh=Is5ItbNqFwQvFiMymGntYFX6/M+CfWU7KxpjnIWap5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cd35fRwO2ZpHwEu6Ih9C+Er+XyphKgN1sOfGQ/OKHNIA8Z00Nt8Kf57y5gp1DM5QFrzV2iqbb+cxQpABMJ5K74wUerRkcvjVggwftQUiaSfbWzDWD1zYwjHW6OaSsVA9RNG1IV3Ymj+lL/8+wwVyj//qrsjbzVn9S/PfSzujzoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpG1NOWh; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8b3cc05665so2970780276.2;
        Wed, 09 Jul 2025 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752048166; x=1752652966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yATPmOJ9OWkUtgidVpJWhXW/bSTBOOmlD2hct+WSePs=;
        b=WpG1NOWhQHwTcqnsN7AmLieUV6K6Y1SwRLXCLynArifikIGDIYi3UYoRx+p9h3YLSG
         zy9/3ZDYAznlLoIcixFzVoqCrJpulBOG/g7oNsbAArGlx7c3u59Avp6h0rybQM5akNtV
         2t6Xblo8wswj3OcRYOagcykVp8gYX+Uca3nBLKVClmHlLF9b/As2WH0Ad5ztKb14Sb6B
         ME8XdqHV6gbVoWoADkn/FMTwEVOMPE0EmrW9jypL32egBTUWclQuhKM0ovxzlcqbSF3O
         8zecNz2pigze32BJhrYD7umpkrlndGHgQMWSTNOOswkZWzczw1WINBYLfXXUGGPglyB2
         mt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048166; x=1752652966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yATPmOJ9OWkUtgidVpJWhXW/bSTBOOmlD2hct+WSePs=;
        b=H1bAgAc8DAYhglWrHt3AX/gprvYgaQgpbNZecj7giRFGnGPEY0PfK518M41oLui6Rp
         TJswb+fVYV2qNMgkQny0P2nwy6xGU/gW2vQRSzs7DRTC3KPyw6dlEGzi6JNbclGiYVYd
         kTZwJOc9FsDpcOmIpSCKiZRdsCSA1sYGOzBWvpnnum/ZCvU/eB4dZg2g3ZzcATEzrDI5
         XEX1cKQCkrXEhccJLqLnMcK6rTnCwXYBD1eoBIK5oXvzLkgu1uF1ADjiDWjNzpgq5bd5
         gU77VltCVTsGNZTmTehF+dDPAxpVcIsYwC+VgSwPEsVfVAw66cVCjAan2JaRQw2pVSJl
         EQfA==
X-Forwarded-Encrypted: i=1; AJvYcCU3pmTSzw/FLt9Kr52nBtVPGJfKe/eo9R9xbc33eLKWf41+BdgniNoND3DhUIv9OOwCArleJVSGl/BtxOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu90fuIt3W1DfTnzuhdVUSq+P9p/mffZwTaU6luQoNeMWh8C6q
	c3GrjCo0rUSCXGyXmBSjJ1ysTcwS3WsMKlouSmaqwHOn4Mfx0BGq9XeVPFnFEDk+kCjFl9GOyhG
	b8QRA2DnEUb2z8iHlledJDMneW4Lohuw=
X-Gm-Gg: ASbGncv36F+C09OuZGthICFH9XazZgGLg30lgLChPOmhWW2Qemt182JASxUii0vfkGd
	haqSzFgUvvStDfakzdnLZzoaqIJNqKXm59xICcL6I5KSsIFSxSE+3utQgevupwvKVax2d+8bpsY
	Rj4ZI+ANXGk9rJzh+b5X6xY4BlBpqdQbk/lUatNhiichsRNB5iNGLr
X-Google-Smtp-Source: AGHT+IFGpt6J0H8CQUxjwUxnTBiD6rrHmvp65uaeZMHRsJnS4HxRTMA6MZltFxevyxDt5SjC3aYf6BLRImSwy75tylw=
X-Received: by 2002:a05:690c:dc8:b0:70e:29af:844a with SMTP id
 00721157ae682-717b19647bdmr22238557b3.18.1752048166224; Wed, 09 Jul 2025
 01:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708184841.72933-1-stefano.radaelli21@gmail.com>
 <20250708184841.72933-3-stefano.radaelli21@gmail.com> <3ab061ca-1d2e-468f-a1c8-ac0ad0433103@ti.com>
In-Reply-To: <3ab061ca-1d2e-468f-a1c8-ac0ad0433103@ti.com>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Wed, 9 Jul 2025 10:02:30 +0200
X-Gm-Features: Ac12FXzoqijcYZPvK1vcDVnyFQdExXLKeRuIBSKjGuodjwZO7s0cTmbkEfYlPKc
Message-ID: <CAK+owojKH8H30r=xm6BDM-i0mf4e+CnTERpu2YrOD7gZyY6n0w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello Vignesh,

thank you for your corrections, I completely forgot to compile with
the W=1 flag.

I'll take care of everything,

Best Regards,

Stefano

Il giorno mer 9 lug 2025 alle ore 06:14 Vignesh Raghavendra
<vigneshr@ti.com> ha scritto:
>
>
>
> On 09/07/25 00:18, Stefano Radaelli wrote:
> > Add device tree support for the Variscite VAR-SOM-AM62P system on module.
> > This SOM is designed to be used with various carrier boards.
> >
> > The module includes:
> > - AM62Px Sitara MPU processor
> > - Up to 8GB of DDR4-3733 memory
> > - eMMC storage memory
> > - PS6522430 chip as a Power Management Integrated circuit (PMIC)
> > - Integrated 10/100/1000 Mbps Ethernet Transceiver Analog Devices ADIN1300
> > - Resistive touch panel interface controller TI TSC2046
> > - I2C interfaces
> >
> > Only SOM-specific peripherals are enabled by default. Carrier board
> > specific interfaces are left disabled to be enabled in the respective
> > carrier board device trees.
> >
> > Link: https://www.variscite.it/product/system-on-module-som/cortex-a53-krait/var-som-am62p-ti-sitara-am62px/
> >
> > Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 379 ++++++++++++++++++
> >  1 file changed, 379 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> > new file mode 100644
> > index 000000000000..1d4ebc484d55
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> > @@ -0,0 +1,379 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Common dtsi for Variscite VAR-SOM-AM62P
> > + *
> > + * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
> > + * Copyright (C) 2025 Variscite Ltd. - https://www.variscite.com/
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/pwm/pwm.h>
> > +#include "k3-am62p5.dtsi"
> > +
> > +/ {
> > +     compatible = "variscite,am62p-var-som", "ti,am62p5";
> > +
> > +     iw612_pwrseq: iw612_pwrseq {
>
> No underscore in node names please
>
> > +             compatible = "mmc-pwrseq-simple";
> > +             post-power-on-delay-ms = <100>;
> > +             power-off-delay-us = <10000>;
> > +             reset-gpios = <&main_gpio0 54 GPIO_ACTIVE_LOW>, /* WIFI_PWR_EN */
> > +                           <&main_gpio0 59 GPIO_ACTIVE_LOW>; /* WIFI_EN */
> > +             status = "okay";
> > +     };
> > +
> > +     emmc_pwrseq: pwrseq@0 {
>
> There isnt a reg property to have a unit addresss
>
> > +             compatible = "mmc-pwrseq-emmc";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&emmc_pwrseq_pins>;
> > +             reset-gpios = <&main_gpio0 49 GPIO_ACTIVE_LOW>;
> > +     };
> > +
> > +     memory@80000000 {
> > +             /* 8G RAM */
> > +             reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> > +                   <0x00000008 0x80000000 0x00000001 0x80000000>;
> > +             device_type = "memory";
> > +             bootph-pre-ram;
> > +     };
> > +
> > +     opp-table {
> > +             /* Add 1.4GHz OPP for am62p5-sk board. Requires VDD_CORE at 0v85 */
> > +             opp-1400000000 {
> > +                     opp-hz = /bits/ 64 <1400000000>;
> > +                     opp-supported-hw = <0x01 0x0004>;
> > +                     clock-latency-ns = <6000000>;
> > +             };
> > +     };
> > +
> > +     reserved_memory: reserved-memory {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             rtos_ipc_memory_region: rtos-ipc-memory@9b500000 {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0x00 0x9b500000 0x00 0x00300000>;
> > +                     no-map;
> > +             };
> > +
> > +             mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0x00 0x9b800000 0x00 0x00100000>;
> > +                     no-map;
> > +             };
> > +
> > +             mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0x00 0x9b900000 0x00 0x00f00000>;
> > +                     no-map;
> > +             };
> > +
> > +             wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0x00 0x9c800000 0x00 0x00100000>;
> > +                     no-map;
> > +             };
> > +
> > +             wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0x00 0x9c900000 0x00 0x01e00000>;
> > +                     no-map;
> > +             };
> > +
> > +             secure_tfa_ddr: tfa@9e780000 {
> > +                     reg = <0x00 0x9e780000 0x00 0x80000>;
> > +                     no-map;
> > +             };
> > +
> > +             secure_ddr: optee@9e800000 {
> > +                     reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> > +                     no-map;
> > +             };
> > +     };
> > +
> > +     vcc_3v3: vcc-3v3 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vcc_3v3";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +     };
> > +
> > +     vcc_1v8: vcc-1v8 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vcc_1v8";
> > +             regulator-min-microvolt = <1800000>;
> > +             regulator-max-microvolt = <1800000>;
> > +             vin-supply = <&vcc_3v3>;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +     };
> > +
> > +     vdd_phy_3v3: regulator-8 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vdd_phy_3v3";
> > +             gpios = <&main_gpio0 45 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +             regulator-always-on;
> > +             status="okay";
> > +     };
> > +};
> > +
> > +&cpsw3g {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&main_rgmii1_pins_default>;
> > +};
> > +
> > +&cpsw3g_mdio {
> > +     status = "okay";
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&main_mdio1_pins_default>;
> > +     cpsw3g_phy0: ethernet-phy@4 {
> > +             reg = <4>;
> > +             compatible = "ethernet-phy-id0283.bc30";
> > +             reset-gpios = <&main_gpio0 46 GPIO_ACTIVE_LOW>;
> > +             reset-assert-us = <10000>;
> > +             reset-deassert-us = <100000>;
> > +     };
> > +};
> > +
> > +&cpsw_port1 {
> > +     /*
> > +      * The required RGMII TX and RX 2ns delays are implemented directly
> > +      * in hardware via passive delay elements on the SOM PCB.
> > +      * No delay configuration is needed in software via PHY driver.
> > +      */
> > +     phy-mode = "rgmii";
> > +     phy-handle = <&cpsw3g_phy0>;
> > +     status = "okay";
> > +};
> > +
> > +&main_i2c2 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&main_i2c2_pins_default>;
> > +     clock-frequency = <400000>;
> > +     status = "okay";
> > +};
> > +
> > +&main_i2c3 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&main_i2c3_pins_default>;
> > +     clock-frequency = <400000>;
> > +     status = "okay";
> > +};
> > +
> > +&main_pmx0 {
> > +     emmc_pwrseq_pins: pinmux_emmc_pwrseq_pins {
>
> Same here
>
> > +             pinctrl-single,pins = <
> > +                     AM62PX_IOPAD(0x00c8, PIN_OUTPUT, 7) /* (AB23) VOUT0_DATA4.GPIO0_49 */
> > +             >;
> > +     };
> > +
> > +     main_i2c2_pins_default: main-i2c2-default-pins {
> > +             pinctrl-single,pins = <
> > +                     AM62PX_IOPAD(0x00b0, PIN_INPUT_PULLUP, 1) /* (T22) GPMC0_CSn2.I2C2_SCL */
> > +                     AM62PX_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (U25) GPMC0_CSn3.I2C2_SDA */
> > +             >;
> > +     };
> > +
> > +     main_i2c3_pins_default: main-i2c3-pins-default {
> > +             pinctrl-single,pins = <
> > +                     AM62PX_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A23) UART0_CTSn.I2C3_SCL */
> > +                     AM62PX_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (C22) UART0_RTSn.I2C3_SDA */
> > +             >;
> > +     };
> > +
> > +     main_mcasp1_pins_default: main-mcasp1-pins-default {
> > +             pinctrl-single,pins = <
> > +                     AM62PX_IOPAD(0x0090, PIN_INPUT, 2) /* (U24) GPMC0_BE0n_CLE.MCASP1_ACLKX */
> > +                     AM62PX_IOPAD(0x0098, PIN_INPUT, 2) /* (AA24) GPMC0_WAIT0.MCASP1_AFSX */
> > +                     AM62PX_IOPAD(0x008c, PIN_OUTPUT, 2) /* (T25) GPMC0_WEn.MCASP1_AXR0 */
> > +                     AM62PX_IOPAD(0x0084, PIN_INPUT, 2) /* (R25) GPMC0_ADVn_ALE.MCASP1_AXR2 */
> > +                     AM62PX_IOPAD(0x00a0, PIN_OUTPUT, 1) /* (P24) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
> > +             >;
> > +     };
> > +
> > +     main_mdio1_pins_default: main-mdio1-pins-default {
>
> This fails make dtbs_check (node name needs to end in -pins)
>
> > +             pinctrl-single,pins = <
> > +                     AM62PX_IOPAD(0x0160, PIN_OUTPUT, 0) /* (F17) MDIO0_MDC */
> > +                     AM62PX_IOPAD(0x015c, PIN_INPUT, 0) /* (F16) MDIO0_MDIO */
> > +             >;
> > +     };
> > +
> > +     main_mmc2_pins_default: main-mmc2-pins-default {
> > +             pinctrl-single,pins = <
> > +                     AM62PX_IOPAD(0x0120, PIN_INPUT_PULLUP, 0) /* (K24) MMC2_CMD */
> > +                     AM62PX_IOPAD(0x0118, PIN_INPUT_PULLDOWN, 0) /* (K21) MMC2_CLK */
> > +                     AM62PX_IOPAD(0x011C, PIN_INPUT_PULLUP, 0) /* () MMC2_CLKLB */
> > +                     AM62PX_IOPAD(0x0114, PIN_INPUT_PULLUP, 0) /* (K23) MMC2_DAT0 */
> > +                     AM62PX_IOPAD(0x0110, PIN_INPUT_PULLUP, 0) /* (K22) MMC2_DAT1 */
> > +                     AM62PX_IOPAD(0x010c, PIN_INPUT_PULLUP, 0) /* (L20) MMC2_DAT2 */
> > +                     AM62PX_IOPAD(0x0108, PIN_INPUT_PULLUP, 0) /* (L21) MMC2_DAT3 */
> > +             >;
> > +     };
> > +
> > +     main_rgmii1_pins_default: main-rgmii1-default-pins {
> > +             pinctrl-single,pins = <
> > +                     AM62PX_IOPAD(0x014c, PIN_INPUT, 0) /* (B15) RGMII1_RD0 */
> > +                     AM62PX_IOPAD(0x0150, PIN_INPUT, 0) /* (B16) RGMII1_RD1 */
> > +                     AM62PX_IOPAD(0x0154, PIN_INPUT, 0) /* (A14) RGMII1_RD2 */
> > +                     AM62PX_IOPAD(0x0158, PIN_INPUT, 0) /* (B14) RGMII1_RD3 */
> > +                     AM62PX_IOPAD(0x0148, PIN_INPUT, 0) /* (A16) RGMII1_RXC */
> > +                     AM62PX_IOPAD(0x0144, PIN_INPUT, 0) /* (A15) RGMII1_RX_CTL */
> > +                     AM62PX_IOPAD(0x0134, PIN_INPUT, 0) /* (A18) RGMII1_TD0 */
> > +                     AM62PX_IOPAD(0x0138, PIN_INPUT, 0) /* (C17) RGMII1_TD1 */
> > +                     AM62PX_IOPAD(0x013c, PIN_INPUT, 0) /* (A17) RGMII1_TD2 */
> > +                     AM62PX_IOPAD(0x0140, PIN_INPUT, 0) /* (C16) RGMII1_TD3 */
> > +                     AM62PX_IOPAD(0x0130, PIN_INPUT, 0) /* (B17) RGMII1_TXC */
> > +                     AM62PX_IOPAD(0x012c, PIN_INPUT, 0) /* (B18) RGMII1_TX_CTL */
> > +             >;
> > +             bootph-all;
> > +     };
> > +
> > +     main_spi0_pins_default: main_spi0-pins-default {
>
> Same here
>
> > +             pinctrl-single,pins = <
> > +                     AM62PX_IOPAD(0x01bc, PIN_OUTPUT, 0) /* (B21) SPI0_CLK */
> > +                     AM62PX_IOPAD(0x01b4, PIN_OUTPUT, 0) /* (D20) SPI0_CS0 */
> > +                     AM62PX_IOPAD(0x01c0, PIN_OUTPUT, 0) /* (B20) SPI0_D0 */
> > +                     AM62PX_IOPAD(0x01c4, PIN_INPUT, 0) /* (C21) SPI0_D1 */
> > +             >;
> > +     };
> > +
> > +     main_uart5_pins_default: uart5-pins-default {
> > +             pinctrl-single,pins = <
> > +                     AM62PX_IOPAD(0x00ec, PIN_INPUT, 4) /* (AC21) VOUT0_DATA13.UART5_CTSn */
> > +                     AM62PX_IOPAD(0x00e8, PIN_OUTPUT, 4) /* (AD21) VOUT0_DATA12.UART5_RTSn */
> > +                     AM62PX_IOPAD(0x00d0, PIN_INPUT, 4) /* (AC23) VOUT0_DATA6.UART5_RXD */
> > +                     AM62PX_IOPAD(0x00d4, PIN_OUTPUT, 4) /* (AE23) VOUT0_DATA7.UART5_TXD */
> > +             >;
> > +     };
> > +
> > +     pinctrl_bt: btgrp {
>
> More such issues
>
> > +             pinctrl-single,pins = <
> > +                     AM62PX_IOPAD(0x00f4, PIN_OUTPUT, 7) /* (Y20) VOUT0_DATA15.GPIO0_60 (BT_EN) */
> > +             >;
> > +     };
> > +
> > +     pinctrl_restouch: restouchgrp {
> > +             pinctrl-single,pins = <
> > +                     AM62PX_IOPAD(0x00c4, PIN_INPUT_PULLUP, 7) /* (Y23) VOUT0_DATA3.GPIO0_48 */
> > +             >;
> > +     };
> > +
> > +     pinctrl_wifi: pinctrl-wifi-default {
> > +             pinctrl-single,pins = <
> > +                     AM62PX_IOPAD(0x00dc, PIN_OUTPUT, 7) /* (AC22) VOUT0_DATA9.GPIO0_54 - WIFI_PWR_EN - */
> > +                     AM62PX_IOPAD(0x00f0, PIN_OUTPUT, 7) /* (AA20) VOUT0_DATA14.GPIO0_59 - WIFI_EN - */
> > +             >;
> > +     };
> > +};
> > +
> > +&main_spi0 {
> > +     status = "okay";
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&main_spi0_pins_default>;
> > +     ti,pindir-d0-out-d1-in = <1>;
> > +
> > +     /* Resistive touch controller */
> > +     ads7846@0 {
> > +             compatible = "ti,ads7846";
> > +             reg = <0>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_restouch>;
> > +             interrupt-parent = <&main_gpio0>;
> > +             interrupts = <48 IRQ_TYPE_EDGE_FALLING>;
> > +             spi-max-frequency = <1500000>;
> > +             pendown-gpio = <&main_gpio0 48 GPIO_ACTIVE_LOW>;
> > +             ti,x-min = /bits/ 16 <125>;
> > +             ti,x-max = /bits/ 16 <4008>;
> > +             ti,y-min = /bits/ 16 <282>;
> > +             ti,y-max = /bits/ 16 <3864>;
> > +             ti,x-plate-ohms = /bits/ 16 <180>;
> > +             ti,pressure-max = /bits/ 16 <255>;
> > +             ti,debounce-max = /bits/ 16 <10>;
> > +             ti,debounce-tol = /bits/ 16 <3>;
> > +             ti,debounce-rep = /bits/ 16 <1>;
> > +             ti,settle-delay-usec = /bits/ 16 <150>;
> > +             ti,keep-vref-on;
> > +             wakeup-source;
> > +             status = "okay";
> > +     };
> > +};
> > +
> > +&main_uart5 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&main_uart5_pins_default>, <&pinctrl_bt>;
> > +     uart-has-rtscts;
> > +     status = "okay";
> > +
> > +     bluetooth_iw61x: bluetooth_iw61x {
>
> Please run
> make dtbs W=1
> make CHECK_DTBS=y
>
> and fix all the issues
>
> > +             compatible = "nxp,88w8987-bt";
> > +             status = "okay";
> > +     };
> > +};
> > +
> > +&mcasp1 {
> > +     status = "okay";
> > +     #sound-dai-cells = <0>;
> > +
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&main_mcasp1_pins_default>;
> > +
> > +     op-mode = <0>;          /* MCASP_IIS_MODE */
> > +     tdm-slots = <2>;
> > +
> > +     serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
> > +            1 0 2 0
> > +            0 0 0 0
> > +            0 0 0 0
> > +            0 0 0 0
> > +     >;
> > +     tx-num-evt = <0>;
> > +     rx-num-evt = <0>;
> > +};
> > +
> > +&mcu_pmx0 {
> > +     wkup_clkout0_pins_default: wkup_clkout0_pins_default {
> > +             pinctrl-single,pins = <
> > +                     AM62PX_MCU_IOPAD(0x0084, PIN_OUTPUT, 0) /* (F13) WKUP_CLKOUT0 */
> > +             >;
> > +     };
> > +};
> > +
> > +/* eMMC */
> > +&sdhci0 {
> > +     status = "okay";
> > +     ti,driver-strength-ohm = <50>;
> > +     mmc-pwrseq = <&emmc_pwrseq>;
> > +     disable-wp;
> > +     bootph-all;
> > +};
> > +
> > +/* WIFI */
> > +&sdhci2 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&main_mmc2_pins_default>, <&pinctrl_wifi>;
> > +     bus-width = <4>;
> > +     disable-wp;
> > +     non-removable;
> > +     keep-power-in-suspend;
> > +     mmc-pwrseq = <&iw612_pwrseq>;
> > +     ti,fails-without-test-cd;
> > +     status = "okay";
> > +};
> > +
> > +&usbss0 {
> > +     ti,vbus-divider;
> > +};
> > +
> > +&usbss1 {
> > +     ti,vbus-divider;
> > +};
>
> --
> Regards
> Vignesh
> https://ti.com/opensource
>

