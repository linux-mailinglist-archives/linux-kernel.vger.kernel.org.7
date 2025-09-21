Return-Path: <linux-kernel+bounces-826029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1CB8D5CF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A486617BEA1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 06:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EDF2D12F3;
	Sun, 21 Sep 2025 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spAv/1pu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03D2C235D;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758436864; cv=none; b=eSYd39nnuomngjuIV+o5E8Y7tygjYBqcKsNLaa2FNSYEKGAtafbPVjiktCweiewQ+ayA8oQ+CxvjEj92PwiwMVqMhQKBNDAef+zRIAalTEerc1BjKukzLsE/bAviZP2ERaVF8xzExa/QymyWNGdTUQ1Vftujutdi571kba5O0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758436864; c=relaxed/simple;
	bh=qoQ+yve2riPpB8NUbLUlshhAjihUp6BZIJr/KoWf+4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHrZ4qdIJ+A48qgUozB9ZFBw4ge+Pbo9ZiOjIJ+Q44DQRUsMySfxqq3X+ZK9T2rAnl8/0rfpioTF6MvKt7vI7H6W7hnSjxphcVrFHvfwT/vtFYG5TrCob4gNXDDlYh5T8c59DVkoA/TDFkHZQke19e2yvnuA13+afnfx/kqCSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spAv/1pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54857C116D0;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758436864;
	bh=qoQ+yve2riPpB8NUbLUlshhAjihUp6BZIJr/KoWf+4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=spAv/1purKWhX8mwgJCdGvjfYGRa96gMp8IelzkXcluCjkOIipTfDmHDyYov/0tGO
	 f25bFp9vS+pVNxCq7ShkmeAfMWN24fOWj43sJN0ihR/8aK3hv1F9slMUujn18uTM99
	 +t4GfuARiTLX5g4LDjRCj1ooyNn3hzt3h44MDAfSW3bGtIL3Ul4zHq5y4RgdCQgh6R
	 v4FMaxiIPpnUPjmmQalaV7TeOFO8tX0XJYkeOluZvut/8aaHQ4SYF2AfWUa+1CcuUq
	 o6pipmk/8B/botQJtcBRqXZKHaEXDycEeIaZI6mOxrVH7zd/AxyrWnR8L8BfhPyO2r
	 WzcXpPL/ECO5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C40BCAC5AD;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sat, 20 Sep 2025 23:41:05 -0700
Subject: [PATCH 3/5] arm64: dts: rk3399-pinephone-pro: Add magnetometer
 sensor support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-ppp_light_accel_mag_vol-down-v1-3-c8bbcd3e2e94@gmail.com>
References: <20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com>
In-Reply-To: <20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758436863; l=951;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=wSHZVGZ9qrlEPPZHlSZ6Qbj5ALGWmEdjOpZJyyV9V+U=;
 b=eG3548BOMxtSMycqYzD+DvhagcA1WASuzyqgec6R8tkaCYY2uqGIcaViHjc5/ioRNmsM7Ckes
 OPZJzTMpFTHBXRj6He8S6K1gL0TfnIzjhZjhpmTasYWxW6pXRRv3dvq
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Ondrej Jirman <megi@xff.cz>

Pinephone Pro uses AF8133J.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index da7ce905152269436410b959be937e07c23772b2..8ff64004b0a6e3b472077516ab360c29852d7c9f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -554,6 +554,16 @@ mpu6500@68 {
 	};
 };
 
+&i2c4 {
+	af8133j: compass@1c {
+		compatible = "voltafield,af8133j";
+		reg = <0x1c>;
+		reset-gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_LOW>;
+		avdd-supply = <&vcc_3v0>;
+		dvdd-supply = <&vcc_1v8>;
+	};
+};
+
 &io_domains {
 	bt656-supply = <&vcc1v8_dvp>;
 	audio-supply = <&vcca1v8_codec>;

-- 
2.51.0



