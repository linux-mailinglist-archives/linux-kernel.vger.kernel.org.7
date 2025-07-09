Return-Path: <linux-kernel+bounces-722919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D051AFE0AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612A21C27311
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38B626B757;
	Wed,  9 Jul 2025 07:00:27 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE05625;
	Wed,  9 Jul 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044427; cv=none; b=JGm7TqWkWRTKxJqZ+1FHsuqL0svpMAP7nQmO71uiUy+DCtYmoCio64d/6hG91OWBE0ICo62YhON4Ol+AM2k1pVbD4C07JKH+KVCaSS1uSdfbxBSCsQzHgGA+GX0RvcamcCVOjkHtcwlu4f6NV09wOt4Vb05z4j7ztI2yHQu3ETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044427; c=relaxed/simple;
	bh=EE1j3ZkDxYaFNgntcMx/KSXBWv/ZDwKLGegsQFgHJww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kr5rHrfrX5TxMI7yRN5ZE9Y5PFf33WAFOYTcNjpMLqTizy7vFGwdLxO6g8ugZ66M05w3CLg+/D2heiw9Sow8iAAx5bpJbtmyn+8lEaYm4L56luOwCna/WZKWZvjFFJk8vXweHwPd83co/MM2REJXlM6ILzcz0Feta/apG8iQSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.98])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1b68dd445;
	Wed, 9 Jul 2025 15:00:08 +0800 (GMT+08:00)
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
Subject: Re: [PATCH 4/6] arm64: dts: rockchip: Add ArmSoM Sige1
Date: Wed,  9 Jul 2025 15:00:03 +0800
Message-Id: <20250709070003.53484-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250708224921.2254116-5-jonas@kwiboo.se>
References: <20250708224921.2254116-5-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSkpKVkwaSk1MQ0IeGE9LTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VCQ1lXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
X-HM-Tid: 0a97edfc0df903a2kunm4d206f074e8f19
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBw6CCo5DDE3CS8cFwIDMS4*
	FyIaFA9VSlVKTE5JS09PT0pITEJCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUJDWVdZCAFZQUlDTEg3Bg++

Hi,

> +	vcc5v0_usb1_host: regulator-5v0-vcc-usb1-host {
> +		compatible = "regulator-fixed";
> ...
> +		regulator-always-on;
> +		regulator-boot-on;
> ...
> +	vcc5v0_usb2_host: regulator-5v0-vcc-usb2-host {
> +		regulator-always-on;
> +		regulator-boot-on;
> ...

I think these two regulators do not need boot-on?

> +	rfkill {
> +		compatible = "rfkill-gpio";
> +		label = "rfkill-wlan";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_reg_on_h>;
> +		radio-type = "wlan";
> +		shutdown-gpios = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
> +	};

Why not use mmc-pwrseq instead of rfkill?

> +	rfkill-bt {
> +		compatible = "rfkill-gpio";
> +		label = "rfkill-bt";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_reg_on_h>;
> +		radio-type = "bluetooth";
> +		shutdown-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> +	};

Why not use shutdown-gpios of bcm43438-bt?

> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0m0_xfer>;
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-output-names = "hym8563";

CLKOUT pin is not connected.

> +&sdio0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	disable-wp;
> +	keep-power-in-suspend;
> +	no-mmc;
> +	no-sd;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>, <&clkm1_32k_out>;

I recommend using clkm1_32k_out at the sdio-pwrseq node.

> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";

Maybe `brcm,bcm4329-fmac` nodes can be added here?

> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2m1_xfer>, <&uart2m1_ctsn>, <&uart2m1_rtsn>;
> +	uart-has-rtscts;
> +	status = "okay";

You can add `brcm,bcm43438-bt` nodes here:

	bluetooth {
		compatible = "brcm,bcm43438-bt";
		device-wakeup-gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
		host-wakeup-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
		shutdown-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
		...
	};

Thanks,
Chukun

--
2.25.1


