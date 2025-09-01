Return-Path: <linux-kernel+bounces-794278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA83B3DF63
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964977A35F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE093101A2;
	Mon,  1 Sep 2025 10:00:50 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A930E0E6;
	Mon,  1 Sep 2025 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720849; cv=none; b=WTYti18zqprz+m5KU3aWtYdODgbbbWQrHBLsf88wVbj8k5cusAF7jelacncSJ4F/MOi5jBYDyUw3ZIMll+pFDzcMMOTec1/39v8iRzpzOsyJ3llVW/glluTn7I5ZylHoJOsRvz9p7q3QosOv9tBJxKm8a7A133KR1YxM/gaape4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720849; c=relaxed/simple;
	bh=4dQUBOKZIBBSZfLj6pRbUgdaT9e4PlLlqSBRVoezHWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VOx7cpxZe8mW7nBBFooAk/FX4v1yyH5QjZ9lspB9lJoQsqGgy7tUvMIdXGCJi978VwQRF1YJWxkH8PAuVy1nLYQoUxsER6IePiqgvf7MduACR8Fof+CsUvolkACw7S90UCmsVlnKgcoktcQOILk2vyqOR8SWaCuhWUVxTEP6XWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.212.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2148c25b2;
	Mon, 1 Sep 2025 18:00:38 +0800 (GMT+08:00)
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
Subject: [PATCH v3 3/3] arm64: dts: rockchip: update pinctrl names for Radxa E52C
Date: Mon,  1 Sep 2025 18:00:27 +0800
Message-Id: <20250901100027.164594-4-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250901100027.164594-1-amadeus@jmu.edu.cn>
References: <20250901100027.164594-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9904b8b73803a2kunmfa64e5773746df
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUpKVkNLHkhLHxgaGUoeTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVCWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+

Updated the pinctrl names of the user key and power LED according
to the schematic. Also updated the nodenames of other pinctrls.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
index 302a30e423ad..5d000b9e49a8 100644
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


