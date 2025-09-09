Return-Path: <linux-kernel+bounces-807289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D78B4A29A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA224E3281
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C491FE44A;
	Tue,  9 Sep 2025 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx9wTbph"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D1518AFF;
	Tue,  9 Sep 2025 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400358; cv=none; b=WbayP68ZXIS15fd0pyPvGa6WXKAvoUOqk0hFBaGqdwK/QKYEqI+NBmOB1EfBRTJ40vhQuXk28+5wJ3wLjSPTm9uxl4LybKxuxQ7526kbqSS6fUVujBHJx8lVcQ5QNWylZuodGUyeX1aaZZ7FBEM5yvcxKczqQD0ek6NM6xICON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400358; c=relaxed/simple;
	bh=edrXmlk4eHvLItc8XVCNCwu7g7elJlOJiImhVQidN4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niOpVXFbNB/Hox+dqye4M6YR0vGPk7XJP7aZU1ntYpcHnafwbcTHCA0RgB0PT1jIKo3kTp5Ftfy7uzyp9Wn8MFnAKiep/mYvACCV0cmGt19t+s7j0U9guxEKem6AlycxiNOvo8wJBpDNAuYqbhXwVS+cksyBxvnJbnqRWNSVtgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx9wTbph; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so5807475a12.2;
        Mon, 08 Sep 2025 23:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757400355; x=1758005155; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6DyBSxWmm9na4mfTkZqI3l8MVVrtqBO96WL+y7f6wA4=;
        b=fx9wTbphLhyqirc9dr6NsfnEQssktoeelXN4ROf0HCfFVnqhTkz3iHuF21IqdnqAQP
         xncTjqh/pTY2Iu6g9UIp57lWsFovjy8fjot9p9zOniW/ridWdGlfj0Tm0FMNd3/oiRWR
         XGU68LZGcu4qdYt3U92MmHS2Sc1DZZP7Y2WQCzk351HTuEz7b9I/FWDdPxa1kKQrgmF1
         HcYXN19LPn5DQRFMrFv09oIxwInxTpSqycb5NeKYhTerI2oFhUqiws+XxpU5vG1U6qJy
         /kl8V5EgqW7jUsMjYmrBHNogzUFKankOkopG2+CSfUO3NSprxdLJo5Vf9f52Tn0gV3Gn
         hNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757400355; x=1758005155;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DyBSxWmm9na4mfTkZqI3l8MVVrtqBO96WL+y7f6wA4=;
        b=w8a0GgN589LAwJo8kOiG7sLePwtbp6bZ1p0J687VtF+EH5Gr8hDJnByioeKOgI6Ah+
         dV1kCbDpjoXeLk4j2J9WfNReuXjpOIPC9rUFjG9rEZIlrW9pOWHsS0hTmUGP/eO5SAc4
         1I5Hf5w78maP5fGyrHOM7YYWV874+lRXLb00zMq6GA8XwlkE1PjYDlERmNTeHXsuyATr
         Ekl9PSLQmD8k83+N/ZREWIhbxOi9+FycXIGTq3BbOQdRNzm050tuUt2sqGZqsCMmO4uC
         F/fHY7wwvjypEK+bwKC3JGz0/SfrdJGnsOAVDEycmAXamch1rxZAj2yAvUoKzr6IYxge
         ya4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOhdjc2+OO9bUog8/kYPCv38UpMDJEvX02DspJsfXU/FQ2Mybyilddv2VFqL+0+FlfZRPwTrEQolOcmhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOrvfWRiAH91nvHoHhPSVQB5ggEnvROnFs9EjO17OHbaNBW9K+
	zBPDivf6H7lVKVJGwoUbWyzrNzXAa80wYmpg2v1fRwiA5dNbM331+5Hf
X-Gm-Gg: ASbGncu8nxcn5Cme77vxXJa8FdoVVkbWKIp8SQ2HbmeXMfWiYqbJGFpYN9IjU7aL/X7
	22eO4E0Dyw3YwbmRKGp3NVDS+0LbxgRgrBi/fpVrb36lxigNv3nN7yf5lsw/WcP4Jxon68/x2zR
	9o6apVR9UGj4toqG2SKCV2VgsuGplsV9pGoCw7nzzfQ74MZ1/FNdudW7TLE9u8kJtJuM8MctX+9
	84ulMFYKJ3aClAKvqFP1pLD8dRNGO4nNdPwKrLR2OaE4EPWsuQQT/BUuZ8s+4YnmuaPD42Hu7k0
	lbqY+oEQLY2KxCVDOhFUXWtCBxnPeivVkTIx0v/Ypz5Z7utM2+hshyp94clTQa4S2sd3qVAjZki
	Eads2kDlqLafBzWQajApg/1LvzmP9J/qgQnYVLwRkAdx3
X-Google-Smtp-Source: AGHT+IGCFYStrTgNsjnRmsc7GGbG3y8oz3uwUGJuqr4aQmwKSso45JAx4LX8aRRELrdAr5XUuZa8kw==
X-Received: by 2002:a05:6402:1e88:b0:628:a4fb:3b1c with SMTP id 4fb4d7f45d1cf-628a4fb3dd2mr6227268a12.13.1757400354285;
        Mon, 08 Sep 2025 23:45:54 -0700 (PDT)
Received: from GLaDOS ([37.77.97.75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfef68af8sm671681a12.19.2025.09.08.23.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:45:53 -0700 (PDT)
Date: Tue, 9 Sep 2025 08:45:51 +0200
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: Judith Mendez <jm@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/3] arm64: dts: ti: Add support for Variscite
 VAR-SOM-AM62P
Message-ID: <aL_NHwomoCdJwa_1@GLaDOS>
References: <20250904132240.36819-1-stefano.radaelli21@gmail.com>
 <20250904132240.36819-3-stefano.radaelli21@gmail.com>
 <d140fb99-d830-4aad-9312-b0eaa714e30f@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d140fb99-d830-4aad-9312-b0eaa714e30f@ti.com>

Hi Judith,

On Mon, Sep 08, 2025 at 01:06:45PM -0500, Judith Mendez wrote:
> Hi Stefano,
> 
> On 9/4/25 8:22 AM, Stefano Radaelli wrote:
> > Add device tree support for the Variscite VAR-SOM-AM62P system on module.
> > This SOM is designed to be used with various carrier boards.
> > 
> > The module includes:
> > - AM62P Sitara MPU processor
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
> > v6:
> >   - Removed unnecessary sdhci properties
> > v5:
> >   - Update to match up with coding guidelines for device tree
> > v4:
> >   - Moved every MCUs-related node into the SOM dtsi
> >   - Removed unused audio node
> > v3:
> >   - Change compatible string to match existing mainline format
> >   - Lower case hex digits
> >   - Generic node names
> > v2:
> >   - Fixed warnings and cleanup
> > 
> >   arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 385 ++++++++++++++++++
> >   1 file changed, 385 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> > new file mode 100644
> > index 000000000000..da037993574f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> > @@ -0,0 +1,385 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Common dtsi for Variscite VAR-SOM-AM62P
> > + *
> > + * Link: https://www.variscite.com/product/system-on-module-som/cortex-a53-krait/var-som-am62p-ti-sitara-am62px/
> > + *
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
> > +	compatible = "variscite,var-som-am62p", "ti,am62p5";
> > +
> > +	wifi_pwrseq: wifi-pwrseq {
> > +		compatible = "mmc-pwrseq-simple";
> > +		post-power-on-delay-ms = <100>;
> > +		power-off-delay-us = <10000>;
> > +		reset-gpios = <&main_gpio0 54 GPIO_ACTIVE_LOW>,	/* WIFI_PWR_EN */
> > +			      <&main_gpio0 59 GPIO_ACTIVE_LOW>;	/* WIFI_EN */
> > +	};
> > +
> > +	mmc_pwrseq: mmc-pwrseq {
> > +		compatible = "mmc-pwrseq-emmc";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_mmc_pwrseq>;
> > +		reset-gpios = <&main_gpio0 49 GPIO_ACTIVE_LOW>;
> > +	};
> > +
> > +	memory@80000000 {
> > +		/* 8G RAM */
> > +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> > +		      <0x00000008 0x80000000 0x00000001 0x80000000>;
> > +		device_type = "memory";
> > +		bootph-pre-ram;
> > +	};
> > +
> > +	opp-table {
> > +		/* Add 1.4GHz OPP for am62p5-sk board. Requires VDD_CORE at 0v85 */
> > +		opp-1400000000 {
> > +			opp-hz = /bits/ 64 <1400000000>;
> > +			opp-supported-hw = <0x01 0x0004>;
> > +			clock-latency-ns = <6000000>;
> > +		};
> > +	};
> > +
> > +	reserved_memory: reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		rtos_ipc_memory_region: rtos-ipc-memory@9b500000 {
> > +			compatible = "shared-dma-pool";
> > +			reg = <0x00 0x9b500000 0x00 0x00300000>;
> > +			no-map;
> > +		};
> > +
> > +		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
> > +			compatible = "shared-dma-pool";
> > +			reg = <0x00 0x9b800000 0x00 0x00100000>;
> > +			no-map;
> > +		};
> > +
> > +		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
> > +			compatible = "shared-dma-pool";
> > +			reg = <0x00 0x9b900000 0x00 0x00f00000>;
> > +			no-map;
> > +		};
> 
> Perhaps it will be a good idea to do the same refactoring as this:
> 
> https://lore.kernel.org/linux-arm-kernel/20250905051846.1189612-30-b-padhi@ti.com/
> 
> Meaning we drop the memory carve-outs for MCU R5SS here.
> 
> 
> > +
> > +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
> > +			compatible = "shared-dma-pool";
> > +			reg = <0x00 0x9c800000 0x00 0x00100000>;
> > +			no-map;
> > +		};
> > +
> > +		wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
> > +			compatible = "shared-dma-pool";
> > +			reg = <0x00 0x9c900000 0x00 0x01e00000>;
> > +			no-map;
> > +		};
> > +
> > +		secure_tfa_ddr: tfa@9e780000 {
> > +			reg = <0x00 0x9e780000 0x00 0x80000>;
> > +			no-map;
> > +		};
> > +
> > +		secure_ddr: optee@9e800000 {
> > +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> > +			no-map;
> > +		};
> > +	};
> > +
> > +	reg_3v3: regulator-3v3 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "On-module +V3.3";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +	};
> > +
> > +	reg_1v8: regulator-1v8 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "On-module +V1.8";
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		vin-supply = <&reg_3v3>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +	};
> > +
> > +	reg_3v3_phy: regulator-3v3-phy {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "On-module +V3.3_PHY";
> > +		gpios = <&main_gpio0 45 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +		regulator-always-on;
> > +	};
> > +};
> > +
> > +&cpsw3g {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_rgmii1>;
> > +};
> > +
> > +&cpsw3g_mdio {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_mdio1>;
> > +	status = "okay";
> > +
> > +	cpsw3g_phy0: ethernet-phy@4 {
> > +		compatible = "ethernet-phy-id0283.bc30";
> > +		reg = <4>;
> > +		reset-gpios = <&main_gpio0 46 GPIO_ACTIVE_LOW>;
> > +		reset-assert-us = <10000>;
> > +		reset-deassert-us = <100000>;
> > +	};
> > +};
> > +
> > +&cpsw_port1 {
> > +	/*
> > +	 * The required RGMII TX and RX 2ns delays are implemented directly
> > +	 * in hardware via passive delay elements on the SOM PCB.
> > +	 * No delay configuration is needed in software via PHY driver.
> > +	 */
> > +	phy-mode = "rgmii";
> > +	phy-handle = <&cpsw3g_phy0>;
> > +	status = "okay";
> > +};
> > +
> > +&main_i2c2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c2>;
> > +	clock-frequency = <400000>;
> > +	status = "okay";
> > +};
> > +
> > +&main_i2c3 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c3>;
> > +	clock-frequency = <400000>;
> > +	status = "okay";
> > +};
> > +
> > +&main_pmx0 {
> > +	pinctrl_mmc_pwrseq: main-emmc-pwrseq-pins {
> > +		pinctrl-single,pins = <
> > +			AM62PX_IOPAD(0x00c8, PIN_OUTPUT, 7) /* (AB23) VOUT0_DATA4.GPIO0_49 */
> > +		>;
> > +	};
> > +
> > +	pinctrl_i2c2: main-i2c2-default-pins {
> > +		pinctrl-single,pins = <
> > +			AM62PX_IOPAD(0x00b0, PIN_INPUT_PULLUP, 1) /* (T22) GPMC0_CSn2.I2C2_SCL */
> > +			AM62PX_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (U25) GPMC0_CSn3.I2C2_SDA */
> > +		>;
> > +	};
> > +
> > +	pinctrl_i2c3: main-i2c3-default-pins {
> > +		pinctrl-single,pins = <
> > +			AM62PX_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A23) UART0_CTSn.I2C3_SCL */
> > +			AM62PX_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (C22) UART0_RTSn.I2C3_SDA */
> > +		>;
> > +	};
> > +
> > +	pinctrl_mdio1: main-mdio1-default-pins {
> > +		pinctrl-single,pins = <
> > +			AM62PX_IOPAD(0x0160, PIN_OUTPUT, 0) /* (F17) MDIO0_MDC */
> > +			AM62PX_IOPAD(0x015c, PIN_INPUT, 0) /* (F16) MDIO0_MDIO */
> > +		>;
> > +	};
> > +
> > +	pinctrl_mmc2: main-mmc2-default-pins {
> > +		pinctrl-single,pins = <
> > +			AM62PX_IOPAD(0x0120, PIN_INPUT_PULLUP, 0) /* (K24) MMC2_CMD */
> > +			AM62PX_IOPAD(0x0118, PIN_INPUT_PULLDOWN, 0) /* (K21) MMC2_CLK */
> > +			AM62PX_IOPAD(0x011c, PIN_INPUT_PULLUP, 0) /* () MMC2_CLKLB */
> > +			AM62PX_IOPAD(0x0114, PIN_INPUT_PULLUP, 0) /* (K23) MMC2_DAT0 */
> > +			AM62PX_IOPAD(0x0110, PIN_INPUT_PULLUP, 0) /* (K22) MMC2_DAT1 */
> > +			AM62PX_IOPAD(0x010c, PIN_INPUT_PULLUP, 0) /* (L20) MMC2_DAT2 */
> > +			AM62PX_IOPAD(0x0108, PIN_INPUT_PULLUP, 0) /* (L21) MMC2_DAT3 */
> > +		>;
> > +	};
> > +
> > +	pinctrl_rgmii1: main-rgmii1-default-pins {
> > +		pinctrl-single,pins = <
> > +			AM62PX_IOPAD(0x014c, PIN_INPUT, 0) /* (B15) RGMII1_RD0 */
> > +			AM62PX_IOPAD(0x0150, PIN_INPUT, 0) /* (B16) RGMII1_RD1 */
> > +			AM62PX_IOPAD(0x0154, PIN_INPUT, 0) /* (A14) RGMII1_RD2 */
> > +			AM62PX_IOPAD(0x0158, PIN_INPUT, 0) /* (B14) RGMII1_RD3 */
> > +			AM62PX_IOPAD(0x0148, PIN_INPUT, 0) /* (A16) RGMII1_RXC */
> > +			AM62PX_IOPAD(0x0144, PIN_INPUT, 0) /* (A15) RGMII1_RX_CTL */
> > +			AM62PX_IOPAD(0x0134, PIN_INPUT, 0) /* (A18) RGMII1_TD0 */
> > +			AM62PX_IOPAD(0x0138, PIN_INPUT, 0) /* (C17) RGMII1_TD1 */
> > +			AM62PX_IOPAD(0x013c, PIN_INPUT, 0) /* (A17) RGMII1_TD2 */
> > +			AM62PX_IOPAD(0x0140, PIN_INPUT, 0) /* (C16) RGMII1_TD3 */
> > +			AM62PX_IOPAD(0x0130, PIN_INPUT, 0) /* (B17) RGMII1_TXC */
> > +			AM62PX_IOPAD(0x012c, PIN_INPUT, 0) /* (B18) RGMII1_TX_CTL */
> > +		>;
> > +		bootph-all;
> > +	};
> > +
> > +	pinctrl_spi0: main-spi0-default-pins {
> > +		pinctrl-single,pins = <
> > +			AM62PX_IOPAD(0x01bc, PIN_OUTPUT, 0) /* (B21) SPI0_CLK */
> > +			AM62PX_IOPAD(0x01b4, PIN_OUTPUT, 0) /* (D20) SPI0_CS0 */
> > +			AM62PX_IOPAD(0x01c0, PIN_OUTPUT, 0) /* (B20) SPI0_D0 */
> > +			AM62PX_IOPAD(0x01c4, PIN_INPUT, 0) /* (C21) SPI0_D1 */
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart5: main-uart5-default-pins {
> > +		pinctrl-single,pins = <
> > +			AM62PX_IOPAD(0x00ec, PIN_INPUT, 4) /* (AC21) VOUT0_DATA13.UART5_CTSn */
> > +			AM62PX_IOPAD(0x00e8, PIN_OUTPUT, 4) /* (AD21) VOUT0_DATA12.UART5_RTSn */
> > +			AM62PX_IOPAD(0x00d0, PIN_INPUT, 4) /* (AC23) VOUT0_DATA6.UART5_RXD */
> > +			AM62PX_IOPAD(0x00d4, PIN_OUTPUT, 4) /* (AE23) VOUT0_DATA7.UART5_TXD */
> > +		>;
> > +	};
> > +
> > +	pinctrl_bt: main-btgrp-pins {
> > +		pinctrl-single,pins = <
> > +			AM62PX_IOPAD(0x00f4, PIN_OUTPUT, 7) /* (Y20) VOUT0_DATA15.GPIO0_60 (BT_EN) */
> > +		>;
> > +	};
> > +
> > +	pinctrl_restouch: main-restouch-pins {
> > +		pinctrl-single,pins = <
> > +			AM62PX_IOPAD(0x00c4, PIN_INPUT_PULLUP, 7) /* (Y23) VOUT0_DATA3.GPIO0_48 */
> > +		>;
> > +	};
> > +
> > +	pinctrl_wifi: main-wifi-default-pins {
> > +		pinctrl-single,pins = <
> > +			AM62PX_IOPAD(0x00dc, PIN_OUTPUT, 7) /* (AC22) VOUT0_DATA9.GPIO0_54 - WIFI_PWR_EN - */
> > +			AM62PX_IOPAD(0x00f0, PIN_OUTPUT, 7) /* (AA20) VOUT0_DATA14.GPIO0_59 - WIFI_EN - */
> > +		>;
> > +	};
> > +};
> > +
> > +&mcu_pmx0 {
> > +	pinctrl_wkup_clkout0: wkup-clkout0-default-pins {
> > +		pinctrl-single,pins = <
> > +			AM62PX_MCU_IOPAD(0x0084, PIN_OUTPUT, 0) /* (F13) WKUP_CLKOUT0 */
> > +		>;
> > +	};
> > +};
> > +
> > +&main_spi0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_spi0>;
> > +	ti,pindir-d0-out-d1-in;
> > +	status = "okay";
> > +};
> > +
> > +&main_uart5 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart5>, <&pinctrl_bt>;
> > +	uart-has-rtscts;
> > +	status = "okay";
> > +
> > +	bluetooth {
> > +		compatible = "nxp,88w8987-bt";
> > +	};
> > +};
> > +
> > +&sdhci0 {
> > +	ti,driver-strength-ohm = <50>;
> > +	mmc-pwrseq = <&mmc_pwrseq>;
> > +	bootph-all;
> > +	status = "okay";
> > +};
> > +
> > +&sdhci2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_mmc2>, <&pinctrl_wifi>;
> > +	bus-width = <4>;
> > +	non-removable;
> > +	keep-power-in-suspend;
> > +	mmc-pwrseq = <&wifi_pwrseq>;
> > +	ti,fails-without-test-cd;
> > +	status = "okay";
> > +};
> > +
> > +&usbss0 {
> > +	ti,vbus-divider;
> > +};
> > +
> > +&usbss1 {
> > +	ti,vbus-divider;
> > +};
> > +
> > +&mailbox0_cluster0 {
> > +	status = "okay";
> > +
> > +	mbox_r5_0: mbox-r5-0 {
> > +		ti,mbox-rx = <0 0 0>;
> > +		ti,mbox-tx = <1 0 0>;
> > +	};
> > +};
> > +
> > +&mailbox0_cluster1 {
> > +	status = "okay";
> > +
> > +	mbox_mcu_r5_0: mbox-mcu-r5-0 {
> > +		ti,mbox-rx = <0 0 0>;
> > +		ti,mbox-tx = <1 0 0>;
> > +	};
> > +};
> > +
> > +&mcu_r5fss0 {
> > +	status = "okay";
> > +};
> > +
> > +&mcu_r5fss0_core0 {
> > +	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
> > +	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
> > +			<&mcu_r5fss0_core0_memory_region>;
> > +};
> > +
> > +&wkup_r5fss0 {
> > +	status = "okay";
> > +};
> > +
> > +&wkup_r5fss0_core0 {
> > +	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
> > +	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
> > +			<&wkup_r5fss0_core0_memory_region>;
> > +};
> > +
> > +/* mcu_gpio0 and mcu_gpio_intr are reserved for mcu firmware usage */
> > +&mcu_gpio0 {
> > +	status = "reserved";
> > +};
> 
> And also drop the IPC stuff above.
> 
> 
> > +
> > +&mcu_gpio_intr {
> > +	status = "reserved";
> > +};
> > +
> > +&wkup_rtc0 {
> > +	status = "disabled";
> > +};
> > +
> > +&wkup_rti0 {
> > +	/* WKUP RTI0 is used by DM firmware */
> > +	status = "reserved";
> > +};
> > +
> > +&wkup_uart0 {
> > +	/* WKUP UART0 is used by DM firmware */
> > +	status = "reserved";
> > +};
> > +
> > +&main_uart1 {
> > +	/* Main UART1 is used by TIFS firmware */
> > +	status = "reserved";
> > +};
> 
> And include:
> 
> +#include "k3-am62p-ti-ipc-firmware.dtsi"
> 
> 
> so that this SOM can be left in a refactored state like all other DT.
> Of course, this means this series would have a dependency on beleswar's
> series:
> https://lore.kernel.org/linux-arm-kernel/20250905051846.1189612-1-b-padhi@ti.com/
> 
> Just a suggestion here. (:
> 
> ~ Judith

thank you very much for the review! That does make sense, you are right.

Would you think it makes sense to leave this refactoring for a follow‑up,
so that this series can go in without depending on Beleswar’s?
That way the patch could be merged right away, and later we include:

#include "k3-am62p-ti-ipc-firmware.dtsi"

to bring the DT in line with the others.

Just checking if that sounds reasonable to you. (:

Thanks again,
Stefano

> 
> 

