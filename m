Return-Path: <linux-kernel+bounces-727122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6382CB0154F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A981C46550
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA11F6679;
	Fri, 11 Jul 2025 08:00:32 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCF21E9B08;
	Fri, 11 Jul 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220832; cv=none; b=T2zddxKTeAfFGp1gnoTnVmjLJVRhZN36MPrLwg223PvqbmNYhsvWAeUPNonr1kY5si44Bug4j1SUJLuYIrI1i9OaRT6Wss1l6w7j3dJwVk4fLEjwqop3wzfFp/CBgX/MNoorRtFDQH+cEQcdrhdP6KJrG0Bot7apoGKHe00VFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220832; c=relaxed/simple;
	bh=PtrlMtavRD5NCB50wytIPNOu7gsnyAX5xXauOMT+jQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o8Xa2VMx0e8vhkLVcdlcETPg03B1PT9OZ7ji9ubux2G8rKT7CBoZzPbmeS1Je7rnXKcEjFhh973EsEop+ycZelaNoL/2u+o+O+VxqB4gAkgr94aHOLB7hWCwxrIc7SlvCQ7Pvg42F6pHx9R08e9P2DAJvG1Fq37b7OmsR6L5MF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.98])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1baf2e80d;
	Fri, 11 Jul 2025 16:00:15 +0800 (GMT+08:00)
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
	ziyao@disroot.org
Subject: Re: [PATCH v2 4/6] arm64: dts: rockchip: Add ArmSoM Sige1
Date: Fri, 11 Jul 2025 16:00:09 +0800
Message-Id: <20250711080009.72677-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710202958.3717181-5-jonas@kwiboo.se>
References: <20250710202958.3717181-5-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEwdVktLHR1KSBpJTUxIGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VCQ1lXWRYaDxIVHRRZQVlPS0hVSktJT09PS1VKS0tVS1
	kG
X-HM-Tid: 0a97f87fd03a03a2kunm1c8745eb5f1e92
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ni46Eyo*GDE*Lx8aEA0fHwso
	NjdPCQNVSlVKTE5JSUlLQ0pNQktLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUJDWVdZCAFZQUpMQkk3Bg++

Hi,

> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&g_led>, <&r_led>;
> +
> +		led-green {

Should this label be named as led-0/led-1?

> +&sdio0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	disable-wp;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	no-mmc;
> +	no-sd;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>;

This pinctrl is the same as that of rk3528.dtsi, we can remove it.

BTW there is a fan connector on the board (connected to pwm6m2),
so pwm6 should be enabled.

> +&uart2 {
> +	dma-names = "tx", "rx";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2m1_xfer>, <&uart2m1_ctsn>, <&uart2m1_rtsn>;
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		clocks = <&cru CLK_DEEPSLOW>;
> +		clock-names = "lpo";
> +		device-wakeup-gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;

Is host-wakeup-gpios needed?

Thanks,
Chukun

--
2.25.1


