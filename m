Return-Path: <linux-kernel+bounces-835879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BA7BA8423
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E083A5308
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF412C0F64;
	Mon, 29 Sep 2025 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaAg0DaB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BEF23D7E5;
	Mon, 29 Sep 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131314; cv=none; b=aG4MMpwiYQRgC2P1U0UWYWo8v7xDXf0py2lgL3McT4py/x8X/1RLHDqyttH/1L8tb3FrT2sa1i7/Q4MYDwT6+0/RJ2f1RCdzS7xZvYR4wP2StBr6WRgxQTwIJxyQ8gqIQV6C/tSBadwKh6gm5isJL+eKIm5N0a+jUCwpIHYbPEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131314; c=relaxed/simple;
	bh=Bay7gvRD8WEKKONQKFBF0O+fwmVm+YlEq+tKHT0KRKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mm2UXpJa8eK+ifyLqi5xgYAFCMLUBIC0v7sWpxIXVZm8go8N3eqNrmmEYpq+g8IVQMcpGv2Ua3qvXJiHHojjUQjQdrtrVKbpYIqNFfTCi5e+VDnj9CqrbvdbCntlSj1NDNeF8pPXmQ21Zz1fUNNA5hON2eUtn9hef/wEq7nPus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaAg0DaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DFE7C4AF0B;
	Mon, 29 Sep 2025 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759131313;
	bh=Bay7gvRD8WEKKONQKFBF0O+fwmVm+YlEq+tKHT0KRKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CaAg0DaBk5igaM4TpFf1Au1liTovydHaKRSmeHMjrQndyPaQw//SrhK55m5PfGPFT
	 Y75bhR+ulDCix/+e3cjFIVBgyA2kbATTNzy3Y88lLyyHBzU1KzM0HAVhmH2DiLRj1+
	 rKIcE+yKlSGYg5K8mEYBKrqrRboZ2XsALfrL9mEzDn4omnmMNRjWiLbt/2YcFxn2bf
	 PuNUTZodimMQ/ssoCXIg/K+5+ruIhXOFR8qVHdx/oycZZ6aXiYpFxv4jtJFFG741pS
	 D6IqXKMDKTXjlvHPiW67gabuuZlBmV063n7LPTQ3ZhUzxx8ihDWb/3czQQvdch8VZt
	 SOkrtRiPAFoyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8A4CAC5B5;
	Mon, 29 Sep 2025 07:35:13 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Mon, 29 Sep 2025 00:35:13 -0700
Subject: [PATCH v4 2/4] arm64: dts: rk3399-pinephone-pro: Add accelerometer
 sensor support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250929-ppp_light_accel_mag_vol-down-v4-2-6598f22d3451@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759131312; l=1864;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=BRZsP1UdL6OFWqM2mRykWAS8dysAco3k6Kyv3eBDv+E=;
 b=qUkXHOgkg9QDIAccXCuh9iCn8uQ3DvTVFAEX5pjOxmDyP/Lb8YzSzOTQ9g1e2KPPpd/59qbKB
 g0enuB+eYi2Cnr3VE6toJhAopuGqneFWjEEu9KY9/XFj1TSugfTHMNz
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Ondrej Jirman <megi@xff.cz>

Pinephone Pro uses mpu6500 according to the schematic.

Tests:
// Setup: This watches the raw values from the device. The variable with
// the biggest magnitude and its sign will be recorded
$ sudo systemctl stop iio-sensor-proxy
$ cat /sys/bus/iio/devices/iio:device3/in_accel_{x,y,z}_raw

// Let's start with phone screen facing up to the sky and the charger
// port closer to you than the front camera.
z: -16000

// Tilt the phone onto it's left edge
x: -16000

// Tilt the phone onto it's right edge
x: 16000

// Tilt the phone so that the charger port is pointing straight up to
// the sky
y: -16000

// Tilt the phone so that the top of the phone is pointing straight up
// to the sky
y: 16000

// Put the phone face down so the screen is touching the table
z: 16000

Co-developed-by: Martijn Braam <martijn@brixit.nl>
Signed-off-by: Martijn Braam <martijn@brixit.nl>
Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
Signed-off-by: Kamil Trzciński <ayufan@ayufan.eu>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 71d32c4bae0d0336ac0c912043618fc9b94919ef..d9f18a8005f15f3ec26e086e5b451bf1bbdc21c0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -542,7 +542,13 @@ mpu6500@68 {
 		reg = <0x68>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <RK_PC6 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vcc_1v8>;
 		vddio-supply = <&vcc_1v8>;
+
+		mount-matrix =
+			"1", "0", "0",
+			"0", "1", "0",
+			"0", "0", "-1";
 	};
 };
 

-- 
2.51.0



