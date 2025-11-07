Return-Path: <linux-kernel+bounces-890254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDF3C3F9D5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1423B16B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC71310782;
	Fri,  7 Nov 2025 11:00:35 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795A31D759;
	Fri,  7 Nov 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513235; cv=none; b=HhXDwNR4fp8e5PXMZcQ27ENMyUyzmqfyyrypm2cTB4U5G5V2Pt1pB/qzyDPLuKzduNINMzG3qk3cFWq4RhZmqcXnciT8E/l3t9oSbTEZwBFJ6TcZo9B+solWFIlew39vVzm7zeYhOQQpkOq2JSIAWA9UhLod+uyuKBinngrGx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513235; c=relaxed/simple;
	bh=1DrKTJrt3lnl5mEQZLIpQOU8knPiSSkwwx4gXViXhsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lTr9kDwx+CQMuDK/TJRacqZyBEft7U8wD9thV8oflxgK+C5PD5GboLMcqu2//vHrzF0ch2nDF+gcj93uZ6FsKAO4PoDamDjxwlW9MK37ooVLCuUHwuAwfR+BZP/N6ZuaBtR3Hfpx8tnqCwyq+nzWatP9+t9WRLgSWc8nr+JqX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [58.61.140.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28c95884c;
	Fri, 7 Nov 2025 19:00:25 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: coiaprant@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: Add devicetree for the 9Tripod X3568 v4
Date: Fri,  7 Nov 2025 19:00:20 +0800
Message-Id: <20251107110020.226562-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251103171702.1518730-4-coiaprant@gmail.com>
References: <20251103171702.1518730-4-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a5df9865003a2kunm70c19c3b637495
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0xOVk9CHhkZTUpDSxgfS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0tVSkhPWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUtKVUpLS1VLWQ
	Y+

Hi,

> +++ b/arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-camera-demo.dtso
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +
> +// This is a sample reference, due to lack of hardware can not be tested, at your own risk

> +++ b/arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4-video-demo.dtso
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +
> +// This is a sample reference, due to lack of hardware can not be tested, at your own risk

Why are these demo DT Overlays needed? Are these optional accessories?
These untested DT Overlays should be removed.

> +	vcc3v3_pcie: regulator-vcc3v3-pcie {
> +		compatible = "regulator-gpio";

This should use regulator-fixed.

> +		regulator-name = "vcc3v3_pcie";
> +		regulator-min-microvolt = <100000>;
> +		regulator-max-microvolt = <3300000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc3v3_pcie_en_pin>;

Is this the name from the schematic?

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim
> +			&gmac0_tx_bus2
> +			&gmac0_rx_bus2
> +			&gmac0_rgmii_clk
> +			&gmac0_rgmii_bus
> +			&gmac0_clkinout>;

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1m1_miim
> +			&gmac1m1_tx_bus2
> +			&gmac1m1_rx_bus2
> +			&gmac1m1_rgmii_clk
> +			&gmac1m1_rgmii_bus
> +			&gmac1m1_clkinout>;

Align Indentation.

> +		codec {
> +			rockchip,mic-in-differential;
> +		};

Is it confirmed to be differential signaling?

> +	pmic {
> +		pmic_int: pmic_int {
> +			rockchip,pins =
> +				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;

No line break is needed here.

> +/* Required remotectl for IR receiver */
> +&pwm7 {
> +	status = "disabled";
> +};

This should be replaced with gpio-ir-receiver.

> +&sdmmc2 {
> +	bus-width = <4>;
> +	disable-wp;

The disable-wp property does not apply to SDIO cards.

> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;

Just declare the highest supported speed.

