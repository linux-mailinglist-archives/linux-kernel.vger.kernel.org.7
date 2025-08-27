Return-Path: <linux-kernel+bounces-788474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B786AB38518
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DCC3B8EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F2C1FBCB1;
	Wed, 27 Aug 2025 14:35:28 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A920E1B4F1F;
	Wed, 27 Aug 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305327; cv=none; b=ZqPiO+JrDogW38V1b+e+UXA8p6ktzHgrQ/Pk1cL/A0IZDdOfU2nJ4N9v5dPHl5tJYr1yH6VE5gyV2XYgjy3H2O6vhERHJgaZ42jxI51+/Yvbar29We8Dj1FogajSb8pGcSyKnnw7kyz+h+xsl46yX8KAhEHf/u4dVH8hrTE3WjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305327; c=relaxed/simple;
	bh=PecF4UO1LlgpEqiKtANTp/rHL1SU6W6O3gnIXaIbjZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ULH62k7BtZkbJTjTt+NW1kzXt747Up1tE/41mcM6E2SIapyqGD4u/naFZlkXZeReangugbkoipDJqmxruvqXVJBjZoTjQG9HPFilqARbrNIyNOPxkG06Dw0GBN5oR+tq+6QyPpdHfMcQqZowI3Cj7Y3h1/gLJo2iINFUQr7IN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.212.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 20cf0b9eb;
	Wed, 27 Aug 2025 22:30:12 +0800 (GMT+08:00)
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
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: add DTs for 100ASK DShanPi A1
Date: Wed, 27 Aug 2025 22:30:06 +0800
Message-Id: <20250827143006.1001952-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826030818.3485927-3-i@chainsx.cn>
References: <20250826030818.3485927-3-i@chainsx.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98ebefb66a03a2kunm352c1d009efdf
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDS05OVkhKGhkZSUtOSkNKSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09LVUpLS1VLWQ
	Y+

Hi,

> +	vcc_12v0_dcin: regulator-vcc-12v0-dcin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_12v0_dcin";

From the schematic [1], it should be called vcc_in?

> +	vcc3v3_pcie: regulator-vcc3v3-pcie {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PB7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_pwren_h>;

Schematic: "PCIE0_PERSTn"
It seems that it should be the reset gpio of pcie
instead of the enable of regulator.

> +		regulator-name = "vcc3v3_pcie";
> +		vin-supply = <&vcc_12v0_dcin>;

From the schematic, it should be called vcc3v3_m2?
VCC5V0_SYS -> VCC3V3_M2

> +	vcc_5v0_sys: regulator-vcc-5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_5v0_sys";

Schematic: "VCC5V0_SYS_S5" / "VCC5V0_SYS"

> +	vcc_5v0_typec0: regulator-vcc-5v0-typec0 {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_otg0_pwren>;

Schematic: "TYPEC5V_PWREN_H"

> +		regulator-name = "vcc_5v0_typec0";
> +		vin-supply = <&vcc_5v0_device>;

Schematic: "VBUS5V0_TYPEC"
VCC5V0_SYS -> VBUS5V0_TYPEC

> +	vcc_5v0_usbhost: regulator-vcc-5v0-usbhost {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;

Does this regulator really exist?
GPIO0_C7_d -> ETH1_INTn

The power supply of USB3 host comes from
USB1_P1_PWR/USB1_P2_PWR - VCC5V0_SYS

> +	vcc_3v3_ufs_s0: regulator-vcc-ufs-s0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3_ufs_s0";
> +		regulator-boot-on;
> +		regulator-always-on;

The order of properties should be consistent:
```
		regulator-always-on;
		regulator-boot-on;
```

> +&i2c2 {
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		clock-output-names = "hym8563";
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_LOW>;

GPIO0_A0 is connected to the button in the schematic [1]

[1] https://dl.100ask.net/Hardware/MPU/RK3576-DshanPi-A1/DshanPi-A1-RK3576-SCH_V1.0.pdf

--
2.25.1



