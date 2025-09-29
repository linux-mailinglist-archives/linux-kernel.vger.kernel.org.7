Return-Path: <linux-kernel+bounces-835880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB073BA841D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F994174916
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BEA2C0F7F;
	Mon, 29 Sep 2025 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUrCWLjh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A842BEFF8;
	Mon, 29 Sep 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131314; cv=none; b=J9y+1xDqW1VPKDfh+H3QY8V6bB2NOuCvMmzXO2U/FLu7qM4Y/yZ4X/mzmJu+xssW24NVRRXoAwx/oj3MoA9PzMOoavC8tsWxMeSsQlDHAJI7etGNANLzEglW3ysrpcz9HN46DvmUsq255UWIAOGefuw0+9EdzDNY5xxWRYkizcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131314; c=relaxed/simple;
	bh=ihi3rYla53IgJpcZ5+Rg8bD/8aOc1SIfXRzrBf28D1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOyNNrCtWDABehtTyBK06v8yZQshKgH941aeVVvTWG+aUgFzWoISQBdmo7EvV3KlkAiI5iv2iQrg9TVyofdY/t0QiJq6+UF7Qa5ZcGOdonfL3ZGjMS+VfA7tDOxv2S205DIuJu7lQA79b/jNFWKtO8oDYecvzcmc3vUtQu7ZAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUrCWLjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A536AC19423;
	Mon, 29 Sep 2025 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759131313;
	bh=ihi3rYla53IgJpcZ5+Rg8bD/8aOc1SIfXRzrBf28D1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IUrCWLjhlUyXCqlWiUUBi93SzYibO2iSA3sqGvCMjcINkd6gBzRtjdt3N30hkqnv4
	 ErOVCCoJ+uT207gngLCwNpIuqNwnY1BBFshFz87zNRhmb4YtM4oEKLBligbHpYHkq9
	 O3XKauKyttEgAa2z1VLuOU4XMZJx/hSkMhQ7uo1DKAo98U6eS+G09dPp01LqT0hH+u
	 MIY9tLX94mkd6k9TM+D07gIdKPNpftrWvfAKoIwKdfPQzE2XTWciAJFn58HKI4FrhU
	 W3ydoRY9DBTe5g8u7qWaQM6H+ZYAv6DNsphWqFufHRkSs+hr+bamAxnndm89KmLZJE
	 rrHB+96UlW+xg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE7ECCA468;
	Mon, 29 Sep 2025 07:35:13 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Mon, 29 Sep 2025 00:35:14 -0700
Subject: [PATCH v4 3/4] arm64: dts: rk3399-pinephone-pro: Add magnetometer
 sensor support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-ppp_light_accel_mag_vol-down-v4-3-6598f22d3451@gmail.com>
References: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
In-Reply-To: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>, 
 "Leonardo G. Trombetta" <lgtrombetta@gmx.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759131312; l=4263;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=S5umEu3plIvdlAlu0DHnlI56aihH8rzrPou0aCxlWwA=;
 b=8A+MabpmYTKjEWg8Kdhs+k4P7zheIaYFrC3Dy3SKD6aShC215FksWT1sZq/X/9j+p7JN/alAD
 C8NAQmZqzsfA4uEwZU39mjFYc8HgGC31p31CBwFsm5M62i9VJZVm1hn
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Ondrej Jirman <megi@xff.cz>

Pinephone Pro uses AF8133J according to the schematic.

The mount-matrix was added by Leonardo on top of Ondrej's work of adding
the magnetometer.

Test:

Script:
```
DEVICE="/sys/bus/iio/devices/iio:device2"

X=$(cat $DEVICE/in_magn_x_raw)
Y=$(cat $DEVICE/in_magn_y_raw)
Z=$(cat $DEVICE/in_magn_z_raw)

X_MIN=$X; X_MAX=$X
Y_MIN=$Y; Y_MAX=$Y
Z_MIN=$Z; Z_MAX=$Z

START_TIME=$(date +%s)

while [ $(($(date +%s) - START_TIME)) -lt 10 ]; do
    X=$(cat $DEVICE/in_magn_x_raw)
    Y=$(cat $DEVICE/in_magn_y_raw)
    Z=$(cat $DEVICE/in_magn_z_raw)

    [ "$X" -lt "$X_MIN" ] && X_MIN=$X
    [ "$X" -gt "$X_MAX" ] && X_MAX=$X

    [ "$Y" -lt "$Y_MIN" ] && Y_MIN=$Y
    [ "$Y" -gt "$Y_MAX" ] && Y_MAX=$Y

    [ "$Z" -lt "$Z_MIN" ] && Z_MIN=$Z
    [ "$Z" -gt "$Z_MAX" ] && Z_MAX=$Z
done

echo "X_MIN: $X_MIN  X_MAX: $X_MAX"
echo "Y_MIN: $Y_MIN  Y_MAX: $Y_MAX"
echo "Z_MIN: $Z_MIN  Z_MAX: $Z_MAX"
```

Link: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/iio/mount-matrix.txt#L93

// phone on a flat surface
top of the phone pointing north and bottom of phone pointing south
x (between -2379 and -2263)
y (between 109 and 207)
z (between -2340 and -2132)
top of the phone pointing south and bottom of phone pointing north
x (between -1079 and -956)
y (between -54 and 46)
z (between -1831 and -1621)
top of the phone pointing east and bottom of phone pointing west
x (between -1587 and -1473)
y (between -448 and -339)
z (between -1850 and -1602)
top of the phone pointing west and bottom of phone pointing east
x (between -1426 and -1300)
y (between 554 and 661)
z (between -1917 and -1706)

// the following tests are where the phone is tilted at a 45 degree
// angle and the top of phone is pointing up to the sky:
top of the phone pointing north and bottom of phone pointing south
x (between -1300 and -1189)
y (between 117 and 227)
z (between -1819 and -1614)
top of the phone pointing south and bottom of phone pointing north
x (between -539 and -422)
y (between 23 and 143)
z (between -1160 and -922)
top of the phone pointing east and bottom of phone pointing west
x (between -1038 and -915)
y (between -408 and -313)
z (between -1570 and -1345)
top of the phone pointing west and bottom of phone pointing east
x (between -965 and -849)
y (between 540 and 641)
z (between -1542 and -1336)

// the following tests are where the phone is tilted at a 45 degree
// angle and the top of phone is pointing down to the ground:
top of the phone pointing north and bottom of phone pointing south
x (between -2345 and -2237)
y (between 80 and 189)
z (between -1207 and -971)
top of the phone pointing south and bottom of phone pointing north
x (between -1805 and -1691)
y (between 5 and 112)
z (between -1896 and -1651)
top of the phone pointing east and bottom of phone pointing west
x (between -2127 and -2013)
y (between 460 and 563)
z (between -1621 and -1378)
top of the phone pointing west and bottom of phone pointing east
x (between -2158 and -2054)
y (between -376 and -264)
z (between -1540 and -1262)

Co-developed-by: Leonardo G. Trombetta <lgtrombetta@gmx.com>
Signed-off-by: Leonardo G. Trombetta <lgtrombetta@gmx.com>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index d9f18a8005f15f3ec26e086e5b451bf1bbdc21c0..05aaf152b5efa5a87663fc97ce034e75131670bb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -552,6 +552,21 @@ mpu6500@68 {
 	};
 };
 
+&i2c4 {
+	af8133j: compass@1c {
+		compatible = "voltafield,af8133j";
+		reg = <0x1c>;
+		reset-gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_LOW>;
+		avdd-supply = <&vcc_3v0>;
+		dvdd-supply = <&vcc_1v8>;
+
+		mount-matrix =
+			"0", "1", "0",
+			"1", "0", "0",
+			"0", "0", "-1";
+	};
+};
+
 &io_domains {
 	bt656-supply = <&vcc1v8_dvp>;
 	audio-supply = <&vcca1v8_codec>;

-- 
2.51.0



