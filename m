Return-Path: <linux-kernel+bounces-790490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F7CB3A899
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815AE462C24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800AD33EB1A;
	Thu, 28 Aug 2025 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnb9zVDv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42C33277A4;
	Thu, 28 Aug 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756403221; cv=none; b=On+BEGhUoInlNcZ2o0fjv42NeQoBNZrAz967kEQjGrgGdstJAngKSIYMCxNbzZNnIaMVYt2ZyUmUp3o5E3ZBGdAZSlNzMXzCxD5lz9XfTH7p1u9mE05gM4OhXRWw4+QFjFB8jxd5vjz/r5nMIudAHOyrazD2ZhWN7dl0ym3fUBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756403221; c=relaxed/simple;
	bh=2JX7tSgJLW61q55pctHadBppSEilC51VA6QlhnLswIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnmEviyc/T8CMQm5iB0pNYTTr9CXyC/FQrjwkKQ9lCay7i2PEIAhZhnJAJ3Qrf3x9Sa7e30dOpj8Kdf9uR0vjaFOAWADi0nn/weRuWQNIg11Yh0fAk9TizlnLtZ8tgKqNoqmpD3FGd3thaq9AuIywF1dTMMSQqAqLkohRpFVZrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnb9zVDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2197EC4CEEB;
	Thu, 28 Aug 2025 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756403220;
	bh=2JX7tSgJLW61q55pctHadBppSEilC51VA6QlhnLswIM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nnb9zVDvViLmXtS7BibaXkG9jWjT2Zo6Qgp8/GK8padJW0jkqiG54Lf8TyuKwAsXx
	 P5/uWOZPgZ8FMs38ZZrlFY2Ez8UOnkklzFdXT9MsB/HrCbZHWWER0EbvS7//GA3YY5
	 iXfemu1i8KRJjBAdN6TSTFnEwxUdRCqwJzSxuFxh7+0JWWThZcljwB6LZBRPTqYksz
	 fLxsDrZEQSw8lm5WfNbd5uTQ77Lh8do9+bxkLjXWhjqil8E2vMHaqrTEaIZSWc55mt
	 YqVnmq+7dZ0Nkmsr/l3JFz/ssyz8zC/Aq8NJaOdyhoYZXbgpECYFyvXMwci5iZPmgR
	 DAxAA0yFzHABA==
Message-ID: <2b1eb8fd-2a64-4745-ad93-abc53d240b69@kernel.org>
Date: Thu, 28 Aug 2025 19:46:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] riscv: dts: microchip: add a device tree for
 Discovery Kit
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
 conor.dooley@microchip.com, daire.mcnamara@microchip.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, robh@kernel.org,
 krzk+dt@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
 <20250825161952.3902672-6-valentina.fernandezalanis@microchip.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250825161952.3902672-6-valentina.fernandezalanis@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/08/2025 18:19, Valentina Fernandez wrote:
> +++ b/arch/riscv/boot/dts/microchip/mpfs-disco-kit-fabric.dtsi
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2020-2025 Microchip Technology Inc */
> +
> +/ {
> +	core_pwm0: pwm@40000000 {
> +		compatible = "microchip,corepwm-rtl-v4";
> +		reg = <0x0 0x40000000 0x0 0xF0>;
> +		microchip,sync-update-mask = /bits/ 32 <0>;
> +		#pwm-cells = <3>;
> +		clocks = <&ccc_sw CLK_CCC_PLL0_OUT3>;
> +		status = "disabled";
> +	};
> +
> +	i2c2: i2c@40000200 {
> +		compatible = "microchip,corei2c-rtl-v7";
> +		reg = <0x0 0x40000200 0x0 0x100>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&ccc_sw CLK_CCC_PLL0_OUT3>;
> +		interrupt-parent = <&plic>;
> +		interrupts = <122>;
> +		clock-frequency = <100000>;
> +		status = "disabled";
> +	};
> +
> +	ihc: mailbox {
> +		compatible = "microchip,sbi-ipc";
> +		interrupt-parent = <&plic>;
> +		interrupts = <180>, <179>, <178>, <177>;
> +		interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
> +		#mbox-cells = <1>;
> +		status = "disabled";
> +	};
> +
> +	mailbox@50000000 {
> +		compatible = "microchip,miv-ihc-rtl-v2";
> +		microchip,ihc-chan-disabled-mask = /bits/ 16 <0>;

Does not look like following DTS coding style - order of properties.

> +		reg = <0x0 0x50000000 0x0 0x1c000>;
> +		interrupt-parent = <&plic>;
> +		interrupts = <180>, <179>, <178>, <177>;
> +		interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
> +		#mbox-cells = <1>;
> +		status = "disabled";
> +	};
> +
> +	refclk_ccc: cccrefclk {

Please use name for all fixed clocks which matches current format
recommendation: 'clock-<freq>' (see also the pattern in the binding for
any other options).

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml

Or anything more reasonable than just bunch of letters.

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;


> +	};
> +};
> +
> +&ccc_sw {
> +	clocks = <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>,
> +		 <&refclk_ccc>, <&refclk_ccc>;
> +	clock-names = "pll0_ref0", "pll0_ref1", "pll1_ref0", "pll1_ref1",
> +		      "dll0_ref", "dll1_ref";
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts
> new file mode 100644
> index 000000000000..742369470ab0
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2020-2025 Microchip Technology Inc */
> +
> +/dts-v1/;
> +
> +#include "mpfs.dtsi"
> +#include "mpfs-disco-kit-fabric.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "Microchip PolarFire-SoC Discovery Kit";
> +	compatible = "microchip,mpfs-disco-kit-reference-rtl-v2507",
> +		     "microchip,mpfs-disco-kit",
> +		     "microchip,mpfs";
> +
> +	aliases {
> +		ethernet0 = &mac0;
> +		serial4 = &mmuart4;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial4:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-1 {
> +			gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_AMBER>;
> +			label = "led1";
> +		};
> +
> +		led-2 {
> +			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_RED>;
> +			label = "led2";
> +		};
> +
> +		led-3 {
> +			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_AMBER>;
> +			label = "led3";
> +		};
> +
> +		led-4 {
> +			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_RED>;
> +			label = "led4";
> +		};
> +
> +		led-5 {
> +			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_AMBER>;
> +			label = "led5";
> +		};
> +
> +		led-6 {
> +			gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_RED>;
> +			label = "led6";
> +		};
> +
> +		led-7 {
> +			gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_AMBER>;
> +			label = "led7";
> +		};
> +
> +		led-8 {
> +			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_RED>;
> +			label = "led8";
> +		};
> +	};
> +
> +	ddrc_cache_lo: memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x40000000>;
> +		status = "okay";

Why? Did you disable it anywhere?

> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		hss_payload: region@BFC00000 {

Don't mix cases. Should be lowercase hex everywhere.

Best regards,
Krzysztof

