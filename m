Return-Path: <linux-kernel+bounces-850218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A6CBD2470
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5D03BD39D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312772FD7C3;
	Mon, 13 Oct 2025 09:23:43 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E340C2F28EF;
	Mon, 13 Oct 2025 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347422; cv=none; b=Hi19Jr/6tU5DvzbbykTcnsWut45MqSA6LgNSQuiVIFP4y9u1ztOzFq1R+2R8saRQpCqWM9vqwxJ3N6PXXnssSSxHzHWEGDqnhLX2/4FmSAQyzZo3AVsTQmw2ih3kcj6oZuDrKR6RxRTa3Utp3AV7vpYGV9BJihm4CUA8DpxHeH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347422; c=relaxed/simple;
	bh=XU5ZmPKC8+pr2IZ7+FXw3w0ys0RSsYms3cTEpv3ws6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuB9pqa0CqkStIo4Twh7XbRni/EUN8+r2WlYIvlpBGFpyb++MuvMw9KFBZ1Mw3BtYZ4nH6WG4CJL6DjLuhyZK/GUpa9QJ2XmmVsk1H+pPNPyAKDNwLhb5oYl3jSlF/8G3zYIZaCGBz/NICohnUtsIXvtXX+dbDR15CJ1s5p87fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [116.25.94.88])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25b01d132;
	Mon, 13 Oct 2025 15:01:11 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jjm2473@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
Date: Mon, 13 Oct 2025 15:00:36 +0800
Message-Id: <20251013070036.66901-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251009084416.45542-4-jjm2473@gmail.com>
References: <20251009084416.45542-4-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99dc5f845b03a2kunm65153ab079944d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGE5IVhpJSkJNS0JITE4dH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk1VSU5VQk9VQ0NZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVUtZBg
	++

Hi,

> +	regulator-vdd0v95-25glan {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwr_25g_pin>;
> +		enable-active-high;
> +		gpio = <&gpio3 RK_PB1 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vdd0v95_25glan";
> +		regulator-min-microvolt = <950000>;
> +		regulator-max-microvolt = <950000>;
> +		regulator-boot-on;
> +		regulator-always-on;

The property order should be consistent with other nodes.

> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vcc3v3_nvme: regulator-vcc3v3-nvme {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_nvme";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&dc_12v>;

Same here, keep alphabetical order.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc3v3_nvme_en>;
> +	};

> +		status_led: led-status {
> +			gpios = <&gpio2 RK_PD7 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_STATUS;
> +			label = "green:status";

The "label" property is deprecated.

> +&pcie2x1 {
> +	reset-gpios = <&gpio3 RK_PA4 GPIO_ACTIVE_HIGH>;

vpcie3v3-supply is missing.

> +	status = "okay";
> +};

> +&pcie3x1 {
> +	num-lanes = <1>;
> +	reset-gpios = <&gpio3 RK_PA3 GPIO_ACTIVE_HIGH>;

vpcie3v3-supply is missing.

> +	status = "okay";
> +};

> +&sdmmc0 {
> +	max-frequency = <150000000>;

max-frequency has been defined in rk356x-base.dtsi

> +	no-sdio;
> +	no-mmc;

no-mmc and cap-mmc-highspeed are mutually exclusive.

> +	bus-width = <4>;
> +	cap-mmc-highspeed;

> +/* Micro SD card slot is not populated */
> +/* Wifi module is not populated */

Why would you define them if they aren't on the board?

> +&sdmmc2 {
> +	max-frequency = <150000000>;

max-frequency has been defined in rk356x-base.dtsi

> +	bus-width = <4>;
> +	disable-wp;

disable-wp does not work with sdio

> +&usb2phy0_otg {

phy-supply is missing.

> +	status = "okay";
> +};

