Return-Path: <linux-kernel+bounces-783005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB67EB32844
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13F31BC8082
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 10:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A4C244678;
	Sat, 23 Aug 2025 10:50:24 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9D4D599;
	Sat, 23 Aug 2025 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755946224; cv=none; b=ODtml2AWAXbakGP0hNmR5id2F2CJ7O7JNTzseehURCI+8veO1JLNHH7C3NV4sGDRcfM6a7ZpiW5ClIbFOTdz66oa8FGar2DKpc6v/0beiJoDVe5gx4D8hwwBZN74mNBPmitTBrc2WgMVMamEreHkjowqJB3DW1/uicOU792CDLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755946224; c=relaxed/simple;
	bh=Azy+vftJGzriG6kQi7H98IVXnL/FB6SLuQaGMnYdIxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k47iKWzWxhPS1TBDm8AX89q3NRjei4r1vziC+wezwDAY41qmTEvjjN7x18Tm/+9u6LE17CeEiV0jC6dAEHUYLRnwPB/sv92KJnQXhGz8c9KI2uZ2IsbU1Z55OQ7qxthk/Mj4yFiOukyQ583YRmLcZOlWIXKp7x7W57TJon7409U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.212.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 205a25682;
	Sat, 23 Aug 2025 18:50:08 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: i@chainsx.cn
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH v1 2/2] arm64: dts: rockchip: add DTs for 100ASK DShanPi A1
Date: Sat, 23 Aug 2025 18:50:01 +0800
Message-Id: <20250823105001.970560-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821110942.172150-3-i@chainsx.cn>
References: <20250821110942.172150-3-i@chainsx.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98d68cccdf03a2kunm9dc74748625589
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0tLVkNDHUxDSRkZSRpPTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09LVUpLS1VLWQ
	Y+

Hi,

> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/pwm/pwm.h>

It seems that pwm is not used?

> +	vcc_12v0_dcin: regulator-vcc-12v0-dcin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_12v0_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;

> +	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_1v1_nldo_s3";
> +		regulator-boot-on;
> +		regulator-always-on;

The order of properties should be consistent, e.g.
```
		regulator-name = ...;
		regulator-always-on;
		regulator-boot-on;
```

> +	vcc3v3_pcie: regulator-vcc3v3-pcie {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 RK_PB7 GPIO_ACTIVE_HIGH>;

`gpios = ...`

> +&combphy1_psu {
> +	status = "okay";
> +};
> +
> +&combphy0_ps {
> +	status = "okay";
> +};

combphy0 should be above combphy1

> +&gmac0 {
> +	phy-mode = "rgmii-id";
> +	clock_in_out = "output";

clock_in_out should be above phy-mode

> +&gmac1 {
> +	phy-mode = "rgmii-id";
> +	clock_in_out = "output";

Same here.

> ...
> +&i2c1 {
> +	status = "okay";
> +
> +	pmic@23 {
> ...
> +		gpio-controller;
> +		#gpio-cells = <2>;

gpio-xxx should be above interrupt

> +		regulators {
> +			vdd_cpu_big_s0: dcdc-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_cpu_big_s0";
> +				regulator-enable-ramp-delay = <400>;

It would be better to add a blank line here.

> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> ...

> +&i2c4 {
> ...
> +		#sound-dai-cells = <0>;

This should be put last.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sai1m0_mclk>;
> +	};
> +};
> ...

> +&pinctrl {
> +	gmac {
> +		gmac0_rst: gmac0-rst {
> +			rockchip,pins = <0 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};

It would be better to add a blank line here.

> +		gmac1_rst: gmac1-rst {
> +			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> ...

> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	max-frequency = <200000000>;
> +	no-sdio;
> +	no-mmc;

cap-mmc-highspeed and no-mmc are mutually exclusive.
And the sdmmc controller supports sdio devices.

> +&u2phy0_otg {
> +	status = "okay";

Maybe lack of phy-supply?
And the usb node is not enabled?

--
2.25.1



