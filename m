Return-Path: <linux-kernel+bounces-720867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CD3AFC159
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679EE7B0B4B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360E0238D57;
	Tue,  8 Jul 2025 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="EzSrw4gA"
Received: from lf-2-13.ptr.blmpb.com (lf-2-13.ptr.blmpb.com [101.36.218.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F88217719
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944949; cv=none; b=GEiq4WRHYSB0xIs8NCaRwsLrrLAX8EhDUl4gXvviPk5VlL/gUQlzXPIZ9vry2hEfCCnikZdPLG8tAHB23PUIt6km5sOd7tEJ5WVwbeIQPuJ07lLggR7Jm6EySFR9HjmYZ+6M/QnzOoxdJu0z86eDAdmiY3qwp+/t+n+o6Mv0V5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944949; c=relaxed/simple;
	bh=WQZKwypkZrCF+/DhG7S/1KUaqssSv7W18WeRUduYiOE=;
	h=References:Subject:Date:Cc:Mime-Version:In-Reply-To:Content-Type:
	 To:Message-Id:From; b=mESXfl9BpoUn+brmjILBNLQFuzMTF0usZ6AtIdJL7oeLlEGYe1UJbNdUzuGzr5dWhNsifrliNLyOm9d5WJFDG9swgNuuluAuJtct7PlWqiI/QikWeQX/OUALUozgURhGNhRnz4RIicBfqARyM29tVg7YzYez02z4pqNWLGRb07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=EzSrw4gA; arc=none smtp.client-ip=101.36.218.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751944859;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=nVxAK1p5Sjn1pa+f8rh0kQXv3kG+RwEoJSIwBTfC/x8=;
 b=EzSrw4gA5uQL1GjOcnwI3cz6hkdgMmSdQDxiuXqryZ5J68k/pSVtWsPu6bxBf5ZKJc3QEF
 616cYCTa+DDvfYG4NDEc+I+1lNISzqsLl/tn3VdCEPA1PlOIwEH767f4LharV+9jVdvuxv
 ytGFqTIKWQ56Z5ZlLLVf2xYxMZcX78ydNkMCG/eP/iyBBY7DY6erLvuKCTVGcgi5gjgt51
 YBKFedYttRkkxq/8ISHCiDHacWklSdT5V2D2b4MpRn+7xFWLSEut7jI/k3PMf6OrY+Mtkk
 7mTDSjO4PRXkmObemFcYSrLbiYRme6MIdwTU4Jp9d95/IRQddTGN9SHbxwrylQ==
References: <cover.1751700954.git.rabenda.cn@gmail.com> <27091134ce1f8a6541a349afc324d6f7402ea606.1751700954.git.rabenda.cn@gmail.com>
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Content-Language: en-US
Subject: Re: [PATCH v3 2/3] riscv: dts: sophgo: add Sophgo SG2042_EVB_V1.X board device tree
Date: Tue, 8 Jul 2025 11:20:53 +0800
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Cc: "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	"Chen Wang" <unicorn_wang@outlook.com>, 
	"Inochi Amaoto" <inochiama@gmail.com>, 
	"Thomas Bonnefille" <thomas.bonnefille@bootlin.com>, 
	"Guo Ren" <guoren@kernel.org>, "Chao Wei" <chao.wei@sophgo.com>, 
	<linux-riscv@lists.infradead.org>, <sophgo@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <27091134ce1f8a6541a349afc324d6f7402ea606.1751700954.git.rabenda.cn@gmail.com>
X-Lms-Return-Path: <lba+2686c8e99+3e9431+vger.kernel.org+liujingqi@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
To: "Han Gao" <rabenda.cn@gmail.com>, <devicetree@vger.kernel.org>
Message-Id: <0f5b623d-64d3-4ad8-8540-e10fb6e055a2@lanxincomputing.com>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Tue, 08 Jul 2025 11:20:56 +0800

On 7/5/2025 3:39 PM, Han Gao wrote:
> Sophgo SG2042_EVB_V1.X [1] is a prototype development board based on SG2042
>
> Currently supports serial port, sdcard/emmc, pwm, fan speed control.
>
> Link: https://github.com/sophgo/sophgo-hardware/tree/master/SG2042/SG2042-x8-EVB [1]
>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

> ---
>   arch/riscv/boot/dts/sophgo/Makefile          |   1 +
>   arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts | 245 +++++++++++++++++++
>   2 files changed, 246 insertions(+)
>   create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
>
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> index 85966306801e..6c9b29681cad 100644
> --- a/arch/riscv/boot/dts/sophgo/Makefile
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -3,4 +3,5 @@ dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2002-licheerv-nano-b.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
> +dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-evb-v1.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2044-sophgo-srd3-10.dtb
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
> new file mode 100644
> index 000000000000..3320bc1dd2c6
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +#include "sg2042.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Sophgo SG2042 EVB V1.X";
> +	compatible = "sophgo,sg2042-evb-v1", "sophgo,sg2042";
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	gpio-power {
> +		compatible = "gpio-keys";
> +
> +		key-power {
> +			label = "Power Key";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&port0a 22 GPIO_ACTIVE_HIGH>;
> +			linux,input-type = <EV_KEY>;
> +			debounce-interval = <100>;
> +		};
> +	};
> +
> +	pwmfan: pwm-fan {
> +		compatible = "pwm-fan";
> +		cooling-levels = <103 128 179 230 255>;
> +		pwms = <&pwm 0 40000 0>;
> +		#cooling-cells = <2>;
> +	};
> +
> +	thermal-zones {
> +		soc-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&mcu 0>;
> +
> +			trips {
> +				soc_active1: soc-active1 {
> +					temperature = <30000>;
> +					hysteresis = <8000>;
> +					type = "active";
> +				};
> +
> +				soc_active2: soc-active2 {
> +					temperature = <58000>;
> +					hysteresis = <12000>;
> +					type = "active";
> +				};
> +
> +				soc_active3: soc-active3 {
> +					temperature = <70000>;
> +					hysteresis = <10000>;
> +					type = "active";
> +				};
> +
> +				soc_hot: soc-hot {
> +					temperature = <80000>;
> +					hysteresis = <5000>;
> +					type = "hot";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&soc_active1>;
> +					cooling-device = <&pwmfan 0 1>;
> +				};
> +
> +				map1 {
> +					trip = <&soc_active2>;
> +					cooling-device = <&pwmfan 1 2>;
> +				};
> +
> +				map2 {
> +					trip = <&soc_active3>;
> +					cooling-device = <&pwmfan 2 3>;
> +				};
> +
> +				map3 {
> +					trip = <&soc_hot>;
> +					cooling-device = <&pwmfan 3 4>;
> +				};
> +			};
> +		};
> +
> +		board-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&mcu 1>;
> +
> +			trips {
> +				board_active: board-active {
> +					temperature = <75000>;
> +					hysteresis = <8000>;
> +					type = "active";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map4 {
> +					trip = <&board_active>;
> +					cooling-device = <&pwmfan 3 4>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&cgi_main {
> +	clock-frequency = <25000000>;
> +};
> +
> +&cgi_dpll0 {
> +	clock-frequency = <25000000>;
> +};
> +
> +&cgi_dpll1 {
> +	clock-frequency = <25000000>;
> +};
> +
> +&emmc {
> +	pinctrl-0 = <&emmc_cfg>;
> +	pinctrl-names = "default";
> +	bus-width = <4>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	wp-inverted;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-0 = <&i2c1_cfg>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	mcu: syscon@17 {
> +		compatible = "sophgo,sg2042-hwmon-mcu";
> +		reg = <0x17>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +};
> +
> +&gmac0 {
> +	phy-handle = <&phy0>;
> +	phy-mode = "rgmii-id";
> +	status = "okay";
> +
> +	mdio {
> +		phy0: phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			reset-gpios = <&port0a 27 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <100000>;
> +			reset-deassert-us = <100000>;
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	emmc_cfg: sdhci-emmc-cfg {
> +		sdhci-emmc-wp-pins {
> +			pinmux = <PINMUX(PIN_EMMC_WP, 0)>;
> +			bias-disable;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-disable;
> +		};
> +
> +		sdhci-emmc-cd-pins {
> +			pinmux = <PINMUX(PIN_EMMC_CD, 0)>;
> +			bias-pull-up;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-enable;
> +		};
> +
> +		sdhci-emmc-rst-pwr-pins {
> +			pinmux = <PINMUX(PIN_EMMC_RST, 0)>,
> +				 <PINMUX(PIN_EMMC_PWR_EN, 0)>;
> +			bias-disable;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-disable;
> +		};
> +	};
> +
> +	i2c1_cfg: i2c1-cfg {
> +		i2c1-pins {
> +			pinmux = <PINMUX(PIN_IIC1_SDA, 0)>,
> +				 <PINMUX(PIN_IIC1_SCL, 0)>;
> +			bias-pull-up;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-enable;
> +		};
> +	};
> +
> +	sd_cfg: sdhci-sd-cfg {
> +		sdhci-sd-cd-wp-pins {
> +			pinmux = <PINMUX(PIN_SDIO_CD, 0)>,
> +				 <PINMUX(PIN_SDIO_WP, 0)>;
> +			bias-pull-up;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-enable;
> +		};
> +
> +		sdhci-sd-rst-pwr-pins {
> +			pinmux = <PINMUX(PIN_SDIO_RST, 0)>,
> +				 <PINMUX(PIN_SDIO_PWR_EN, 0)>;
> +			bias-disable;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-disable;
> +		};
> +	};
> +
> +	uart0_cfg: uart0-cfg {
> +		uart0-rx-pins {
> +			pinmux = <PINMUX(PIN_UART0_TX, 0)>,
> +				 <PINMUX(PIN_UART0_RX, 0)>;
> +			bias-pull-up;
> +			drive-strength-microamp = <26800>;
> +			input-schmitt-enable;
> +		};
> +	};
> +};
> +
> +&sd {
> +	pinctrl-0 = <&sd_cfg>;
> +	pinctrl-names = "default";
> +	bus-width = <4>;
> +	no-sdio;
> +	no-mmc;
> +	wp-inverted;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-0 = <&uart0_cfg>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};

