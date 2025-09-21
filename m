Return-Path: <linux-kernel+bounces-826381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E667DB8E5EB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C473BBFEF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B952929993D;
	Sun, 21 Sep 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ejk0hhK+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128031A9FB9;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488762; cv=none; b=LRcqyhxDZU5CMVEnQVTYolwk2+7D3wSWQU/bC5UrdEqUHyWAJVkg5rmTHrQwKGgT8+xUKXPKhUne7rQuUdqfgoPoLRX/KyykNkTh6b5g9GjQeSFvEO2YS7P2m0Z2mK2C1gtVM4ap6vdI6IK2LN60BgYUczmJBHZUJVkApqQNmlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488762; c=relaxed/simple;
	bh=dANZ/yuM6waYGQYmdVXqTPNlVvALmVGnbkrSGvC8deE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRsezurpC+uKosC4JG/hEv12jSWZ6/C9Gx83OFdm/VWO1sgPDq5vxIb3vN+rbZmoMawOUTJkQDizzcZgvavdk1U1Lq5yZVXFO3a9U3f6SjIkEd0YOf92aaMr3xGqQsVWT/L9K7+eLWh0D9w7Tq8LLzFyDWOpqr9JALp8N58LZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ejk0hhK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D03EC113D0;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758488761;
	bh=dANZ/yuM6waYGQYmdVXqTPNlVvALmVGnbkrSGvC8deE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ejk0hhK+C1lIOEwgkwrMYRmC5+iC6m2vmJDchvYkrWpIRXaIy4SpAnWi9A3Cz1e4b
	 GsPwjowzeenYDQ/3j4fLddjpVfQZ/PlbPRru4+3Tfdx4PTNHBeqc/ZQQmtPpOZHGQL
	 mWgrbeaIpqWpV3GZ9hD0+Ce+kzmM2zm8bycmClG7270d10GUl5ggwFQkv8NDtcpFnT
	 BP01DHiHGxl6JzZrnRxOKPdAvXddk7H503cHgksLsw5E1umtK392q/5FzINngGEDDO
	 x9HI7Q0micklUMyh9/3F+9p9T1uITlOxM8g2rdaENoRqZpcCZZTQxe7/2rpz95fKwZ
	 ETmO5wvzv5ehQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B3CCAC59A;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sun, 21 Sep 2025 14:05:54 -0700
Subject: [PATCH v3 1/5] arm64: dts: rk3399-pinephone-pro: Add
 light/proximity sensor support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-ppp_light_accel_mag_vol-down-v3-1-7af6651f77e4@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758488760; l=1340;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=hhqVOo3Ifd3acg7mEDnoZwYQLjaVIlSiKU2AQ4pfc+I=;
 b=Iz7chLhmfOKM7UyNgH0NP3gXEWA0iE2KP8/hOLfAP9GU0SsCEKVYzWe6cv8yb7+xpTNl+agtZ
 KLXnvxE+mLlDpqubw8IamHS9iAc4lbGW2jhEsEzVMTJzNkL6F/us+4/
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



