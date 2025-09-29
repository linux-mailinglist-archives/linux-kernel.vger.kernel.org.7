Return-Path: <linux-kernel+bounces-835878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6F6BA841A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B509517319B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9342C08DC;
	Mon, 29 Sep 2025 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmSdGKUz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2551684B0;
	Mon, 29 Sep 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131314; cv=none; b=dJh1LoRHqDF/FXmACjfoYsocEIUqYBTXfYgsqsdQEilq9kPLFV/5W5dlzFBOA4ENSmiipTSQIEgIIwRkOqmPg39h+LCJn8e89pkUSnQjbmTRczHHzkHIDDP7GCYgjtaZ5rJulR1IpPPSLn0qUKHZk5oOifNbvRA8WLYfGMzXfcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131314; c=relaxed/simple;
	bh=8VBQdbInkyT4SO9ZYbFABhR/xaRBu7JaZ6KrCbUKrbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etgLG6/NL5e7aXjV7zPpQMjBzAYJeR8tcZaUI2gGJGBPEQZVuMh0O//qslTpC66+RR/tlf7nQtpYZ5776Yp5jBo5uyZpr50mIkvX2Ysmw6pRXqVajGEHsTh+d/mdegiehpHCQOZn2Np4bnearKI4+2IBgA11i+AHniDhhXcPKVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmSdGKUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79224C116B1;
	Mon, 29 Sep 2025 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759131313;
	bh=8VBQdbInkyT4SO9ZYbFABhR/xaRBu7JaZ6KrCbUKrbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tmSdGKUzYR8fczBUyshYTpijLbi5HxJfpYRcuUwdk901/GJCfU/P+dkyCWFElp98g
	 Z7nL82rt4QJGF3rOuK8mRCplIzIXRqy6CsntPMGGREq3KLUHMkunDnm92MIPdXUhwD
	 67m7cFHm0BQIbmnVjr5snY4LK8156YauIM1hILdKe+gn7IEoa30zGzmXPjvOsiyPVc
	 Fw5OAu/wKd3lhg70v27e2qVmmAYomRI1FE0b9jE/1QpeUaEm/216XrcGT7CEsgABNq
	 AZuSr9TtipN7Hirz+OP/5lK0YXJl96tFHg3HWjrc13NjClCY/tsYUDcvLDuzeqXt+5
	 cfinOgOw6OyvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692A2CAC5B0;
	Mon, 29 Sep 2025 07:35:13 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Mon, 29 Sep 2025 00:35:12 -0700
Subject: [PATCH v4 1/4] arm64: dts: rk3399-pinephone-pro: Add
 light/proximity sensor support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250929-ppp_light_accel_mag_vol-down-v4-1-6598f22d3451@gmail.com>
References: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
In-Reply-To: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>, 
 Martijn Braam <martijn@brixit.nl>, 
 =?utf-8?q?Kamil_Trzci=C5=84ski?= <ayufan@ayufan.eu>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759131312; l=2306;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=/lKiD65MbRWEXijfwwhiyC0MPS0vO7bZZUd/tftK3Ok=;
 b=Mv7RMAhsAjMFMpCjbxt8lewBE9asnKX3oaeMWL7sBzt7hMppyU5mfnZhti464TMiN9hm7Ljat
 +f9sM8uRhuRBLoBty12REVq3oa6cAf/qo1sMPKytS5CdRSZYLCcTm3+
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Ondrej Jirman <megi@xff.cz>

Pinephone Pro uses STK3311 according to the schematics.

Tests:
~ $ hwtest # output tweaked to fit in 80 chars
Category  proximity
Model     stk3310
Path      /sys/bus/iio/devices/iio:device0
Status    working
Value     59.3 (when covered) and 2.2 (when uncovered)

Category  illuminance
Model     stk3310
Path      /sys/bus/iio/devices/iio:device0
Status    working
Value     1 (when covered) and 101 (when uncovered)

~ $ monitor-sensor
    // When the sensor is exposed, it get's fluctating values such as
    Light changed: 1.800000 (lux)
    Light changed: 1.700000 (lux)
    Light changed: 1.800000 (lux)
    Light changed: 1.700000 (lux)
    Light changed: 1.600000 (lux)
    Light changed: 1.100000 (lux)
    // When covering the sensor, it prints a low value and stops printing
    Light changed: 0.200000 (lux)

Co-developed-by: Martijn Braam <martijn@brixit.nl>
Signed-off-by: Martijn Braam <martijn@brixit.nl>
Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
Signed-off-by: Kamil Trzciński <ayufan@ayufan.eu>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 6f97e57f36f5599f4027a0f3db98bcbc69cef5e5..71d32c4bae0d0336ac0c912043618fc9b94919ef 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -520,6 +520,15 @@ touchscreen@14 {
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
+	};
 };
 
 &i2c4 {
@@ -689,6 +698,12 @@ vcc1v8_codec_en: vcc1v8-codec-en {
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



