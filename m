Return-Path: <linux-kernel+bounces-747968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88BEB13AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DC816623A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07307265CC5;
	Mon, 28 Jul 2025 12:50:30 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00254739;
	Mon, 28 Jul 2025 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753707029; cv=none; b=cBGz9W+sPhDNxlAmMp+jgMQsd+RZ8hOpFF3lip79QKcx9ckjAFBBrSUXRGNDI6Tzvu2/4R4ADBw9zyyTaotYAjDq0qekcVQXn6DUxvwrl5l/DiQ0ycl4DlrJzOVxCvm8b0zquCRqRtCzZE6OcicPpj4rrKRhltUI+Sb7Yil8F5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753707029; c=relaxed/simple;
	bh=HY9n34Ah89ROtpzeuMOXAoMWkIaoA4TzHSvROnIU9DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfOdoayDM9pv9rfRmL8Uv62FwQEsIXrXhVaY703b/22wY8NFJcDFKsFT071lGxmaRsces3+APUDgFKzS0AdicCIWVOBM9Ov/ONmwDKW0a0b9icd6AAY3R9/Dteopqe1DEkCwgMUJu5izVUmHi1PwvPmipgS47G5ZFhf4L0L5go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.139])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1d7dd7885;
	Mon, 28 Jul 2025 20:50:20 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	ziyao@disroot.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
Date: Mon, 28 Jul 2025 20:50:15 +0800
Message-Id: <20250728125015.988357-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727144409.327740-4-jonas@kwiboo.se>
References: <20250727144409.327740-4-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a985115803303a2kunm2afc03fb162f34
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTU8dVkxMSxhKTR9MTRpDGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKSEJZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVU
	pCS0tZBg++

Hi,

> +	avddl_1v1: avddh_3v3: avdd_rtl8367rb: regulator-avdd-rtl8367rb {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_8367_en>;
> +		regulator-name = "avdd_rtl8367rb";

I don't see the avdd_rtl8367rb regulator in the schematics. It looks like
DVDDIO (RTL8367RB power) is connected to AVDDH_3V3 via a magnetic bead.

> +&gmac1 {
> +	clock_in_out = "output";
> +	phy-mode = "rgmii-id";
> +	phy-supply = <&avdd_rtl8367rb>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_miim>, <&rgmii_tx_bus2>, <&rgmii_rx_bus2>,
> +		    <&rgmii_rgmii_clk>, <&rgmii_rgmii_bus>, <&gmac1_rstn_l>;

Should the pinctrl of gmac1_rstn_l be written together with the
reset-gpios of the rtl8367rb switch?

```
reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
pinctrl-0 = <&gmac1_rstn_l>;
```

> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0m0_xfer>;
> +	status = "okay";
> +
> +	rk805: pmic@18 {
> +		compatible = "rockchip,rk805";
> +		reg = <0x18>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
> +		#clock-cells = <1>;
> +		clock-output-names = "rk805-clkout1", "rk805-clkout2";

The clkout pin is not connected, but the dt-bindings require it.
Maybe clock-output-names could be made optional?

+&mdio1 {
+	reset-delay-us = <25000>;
+	reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
+	reset-post-delay-us = <100000>;
+};

I don't think this is correct, reset-gpios should be written on the
rtl8365mb switch node. The switch driver has defined the reset time.

```
&mdio1 {
	switch@29 {
		compatible = "realtek,rtl8365mb";
		reg = <29>;
		reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
```

Thanks,
Chukun

--
2.25.1



