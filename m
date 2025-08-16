Return-Path: <linux-kernel+bounces-771799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 226D7B28BA9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC17AC618B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6BC238179;
	Sat, 16 Aug 2025 08:00:55 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA2235057;
	Sat, 16 Aug 2025 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755331254; cv=none; b=HK2s4wfhzDxAZmS9NuVo+OfJOTrm12wLLT+aOSNZACQxkLGnBXmVQiZ4+9zfgZ15KN3UQVP0k2X6YBtnmN51XkG4UOeuML7pvMxPIpq9IzAfG3n7tKZJSmKhkWHdx/uppPUjc76HMCtGQ1otboRGvwBEsMPaWejLjZ2xCWrifUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755331254; c=relaxed/simple;
	bh=my4Lg23Sr8V2vIPnV0ZA7wF/pzG4vAELQ1Wsr3WUKOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gz4zwLel/v0wxE+uvVns2nkTaYcfKFSbqQ6C/5KRtkv0ekFA9NJKqyJCqUbljKUZZc5pDKVJ8ZmLgT2bcYxhXvoDrQkXCJz9gq8oczMrKAa9jSnl5D0SPcjyymk4f11tak5f05ROXdEFKFFfmnlyvHWiopK5dpErlCYnxYfD2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.212.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f93a30d1;
	Sat, 16 Aug 2025 16:00:43 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: rockchip: update pinctrl names for Radxa E52C
Date: Sat, 16 Aug 2025 16:00:30 +0800
Message-Id: <20250816080030.183931-4-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250816080030.183931-1-amadeus@jmu.edu.cn>
References: <20250816080030.183931-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98b1e52efb03a2kunm56d2169525b758
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZShgZVhlITR4fTR4ZHR9CSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVCWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+

Updated the pinctrl names of the user key and power LED according
to the schematic. Also updated the nodenames of other pinctrls.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
index 4a3ae95f122f..f93b129a0032 100644
--- a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
@@ -42,7 +42,7 @@ button-0 {
 	keys-1 {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
-		pinctrl-0 = <&btn_0>;
+		pinctrl-0 = <&pwm15_ir_m1>;
 
 		button-1 {
 			label = "User";
@@ -55,7 +55,7 @@ button-1 {
 	leds-0 {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&led_0>;
+		pinctrl-0 = <&power_led>;
 
 		led-0 {
 			color = <LED_COLOR_ID_GREEN>;
@@ -306,13 +306,13 @@ &pcie2x1l2 {
 
 &pinctrl {
 	keys {
-		btn_0: button-0 {
+		pwm15_ir_m1: pwm15-ir-m1 {
 			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 
 	leds {
-		led_0: led-0 {
+		power_led: power-led {
 			rockchip,pins = <3 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
@@ -328,19 +328,19 @@ pcie20x1_2_perstn_m0: pcie-2 {
 	};
 
 	regulators {
-		vcc_5v0_pwren_h: regulator-5v0-1 {
+		vcc_5v0_pwren_h: vcc-5v0-pwren-h {
 			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 
 	rtc {
-		rtc_int_l: rtc-0 {
+		rtc_int_l: rtc-int-l {
 			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 
 	usb {
-		usb_otg_pwren_h: regulator-5v0-0 {
+		usb_otg_pwren_h: usb-otg-pwren-h {
 			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-- 
2.25.1


