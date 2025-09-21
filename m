Return-Path: <linux-kernel+bounces-826065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37465B8D723
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C496189FA34
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ADB2459DC;
	Sun, 21 Sep 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBIMznq0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676554791;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758441860; cv=none; b=jeVXbO+OILBQMFJocnwNRWDijWXTPwgfaF8wH2Y8u9lw44t0MrKmXwApjPUWR62J73rxNXob4rLea8YepJ7ae9TFFzrKmzL9U0rOMapLPaZKuFrR7NPELZl1Sf0JjNN3Vy09diI96mOrn8KURQRmYiVs1BgL0YWTz3yFNhIf9nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758441860; c=relaxed/simple;
	bh=dANZ/yuM6waYGQYmdVXqTPNlVvALmVGnbkrSGvC8deE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUfzKZxOfzX4cF5XXDohfpos+ttfcVkIlbDPmIQ03J8REEayaR9QgJVuM1iSvX6KV/fi20e2IWJsFNah5NPs55nWKR/rZaTEh+LGwxfyiHOHkiAxej5q2UwVAjA+WMiO7aQ9yDo3PXoL5yc1TWY6/bla5+vp1L5dy0hbvrKQqFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBIMznq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61073C116B1;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758441860;
	bh=dANZ/yuM6waYGQYmdVXqTPNlVvALmVGnbkrSGvC8deE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EBIMznq0xw0ydGyfCLGv0To5LHKyv1jWcTTSxOhIeXONqVCbRf14rqEAbpI1WPMXD
	 iYy5M2B29yuUJdfH/mduYmqqB8MkrFvYfUqeYdFlU+JH/weDwwaLdE3PHdkf1Pz0pZ
	 Yoj1TsjJhgOX3fV/M0XpoMlZaSgCQKFTb/h5ghaw9W6/QWptGSQZQcArvD2acPGaUu
	 A8EzT/j69KhNWlVxdiSQXr8RazmCK3ATtUh+rwDuslHzzkZSa8XHNuLr9tKbIkAYdT
	 XNjIa4URjeHgmn2LJfJD4d/G1W2G6NEOJ9GLPJuhud2B5nfkgCvkmVosqNGJCbYEvV
	 8b3dwNienerVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE86CAC59A;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sun, 21 Sep 2025 01:04:19 -0700
Subject: [PATCH v2 1/5] arm64: dts: rk3399-pinephone-pro: Add
 light/proximity sensor support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-ppp_light_accel_mag_vol-down-v2-1-e6bcc6ca74ae@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758441859; l=1340;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=hhqVOo3Ifd3acg7mEDnoZwYQLjaVIlSiKU2AQ4pfc+I=;
 b=UrgSS7vdcFXLI0RXR1tdG25kUnXIyw2IlIePrzpv0P1vtHhUYI1IP5lBSe64iJMyZ6/8/7gdv
 QLo/qVo8+lrCDgqChZB/yIWE9aOv5UK5Bt8cofhlRs4YvzbVrHOHgD2
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
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 6f97e57f36f5599f4027a0f3db98bcbc69cef5e5..65ee0b805034a4357a766d4f1f9efa2d4a843d77 100644
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
@@ -689,6 +700,12 @@ vcc1v8_codec_en: vcc1v8-codec-en {
 		};
 	};
 
+	stk3311 {
+		stk3311_int: stk3311-int {
+			rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO &pcfg_input_pull_up>;
+		};
+	};
+
 	wireless-bluetooth {
 		bt_wake_pin: bt-wake-pin {
 			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;

-- 
2.51.0



