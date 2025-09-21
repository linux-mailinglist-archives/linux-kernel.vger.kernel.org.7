Return-Path: <linux-kernel+bounces-826027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77794B8D5CC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3615317BC98
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 06:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ACB2D0C8F;
	Sun, 21 Sep 2025 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBQiy3JY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D892C21FB;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758436864; cv=none; b=eLwOah4zrSReie9Ggh8Bo0SbBiqDpfnR8ADFPLOjY4Xufr/iMxa7I3hISQuL9XCzzeqTel8nkKnW5Y5oXwRobwkQ8kHhuNF7cSw1WYOcEGKqXREH1o/qhSpavauI+jmGKHjMnCMfN/UbK2tCEMc0n6BZIrMGHbqKb6iWkHYTWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758436864; c=relaxed/simple;
	bh=dpMCyDlLrMjqNyEMn2d/knBNROB+36tFMBCYSuWvdN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFDz7TC/N6r7LqN0ZQHyPoPLx5WcatoQqJ0eaD6SqYtbydaKvQMGSvBWM6luf3M8PRKVm3mLX6LTFkQkIur7y0FKnpIgsCNA0LCZqOIOyWqmSBjKHb2o2gzalj46rTI/xXWf+DQbkREpDnYHgLqxX8gOzi2nuy/mOR8ueTkDBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBQiy3JY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 360F2C116B1;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758436864;
	bh=dpMCyDlLrMjqNyEMn2d/knBNROB+36tFMBCYSuWvdN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aBQiy3JYAY13mq7NvRCVQGibHeJ4AV67qcIMigT40p3klnpSZyGq6TSlZeJ/i5VLq
	 AoxsKSGkdzJw3OGUAkSyGexTM3Y5aJ/hmPY8DUucOSdPTz0NZuZsXM9PU27rZNuSQf
	 +Sk1jkaZyXH+tPt4gJ44iypJ9vQFI8DDqpqjewmzQRxVcieFB1rWaP3EsI5Tv9WkRh
	 TNc+DBTmK+8ngreCElAEJ7aqSUYHceOnpe1YxExnqxqQVfwOlswrBUFd9Vdl0M9WgP
	 6XcHc8TTwjVMP5YFz//dRmDZBrtnzCAp3PN1HUg0lEszjhEUA+aoz/7FAal47104RJ
	 b4mpVcbLuEqwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E16DCAC5A7;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sat, 20 Sep 2025 23:41:03 -0700
Subject: [PATCH 1/5] arm64: dts: rk3399-pinephone-pro: Add light/proximity
 sensor support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-ppp_light_accel_mag_vol-down-v1-1-c8bbcd3e2e94@gmail.com>
References: <20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com>
In-Reply-To: <20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758436863; l=1472;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=ks68MUyQQda7AjNnXGwABWbW3lR6/whmVOZyQ+ajuGI=;
 b=dqa2Fp1uC6sf5XwT284Z4SXruwxHgvjJ7k76+4Dr52VxQuBteFzB1VM+2rrk2Skr7rudcBTRC
 OOjEZ4jhWbnCI6LkGsZ+DdbELvw4rkNbaFXpzn4RQp5LoWcxNyoXihC
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Ondrej Jirman <megi@xff.cz>

Pinephone Pro uses STK3311

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 6f97e57f36f5599f4027a0f3db98bcbc69cef5e5..7d1257a3f2e0cbdc65a810062ecd5117f9f5b687 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -520,6 +520,17 @@ touchscreen@14 {
 		touchscreen-size-x = <720>;
 		touchscreen-size-y = <1440>;
 	};
+
+	light-sensor@48 {
+		compatible = "sensortek,stk3311";
+		reg = <0x48>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PD3 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&stk3311_int>;
+		vdd-supply = <&vcc_3v0>;
+		leda-supply = <&vcc_3v0>;
+	};
 };
 
 &i2c4 {
@@ -689,6 +700,18 @@ vcc1v8_codec_en: vcc1v8-codec-en {
 		};
 	};
 
+	stk3311 {
+		stk3311_int: stk3311-int {
+			rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO &pcfg_input_pull_up>;
+		};
+	};
+
+	usb-typec {
+		vcc5v0_typec_en: vcc5v0_typec_en {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	wireless-bluetooth {
 		bt_wake_pin: bt-wake-pin {
 			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;

-- 
2.51.0



