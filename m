Return-Path: <linux-kernel+bounces-826067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE74B8D72F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0028817D703
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935FF246770;
	Sun, 21 Sep 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIICuYqw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED7E1419A9;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758441861; cv=none; b=NcPX8HwmG/nkii8OMLcuDHGrFpMc+Th+pJfktffLYvVzDAocK0gYRVm0htkzhdiDJ+GVUGT5EmZyk7OpxsFtPIRRSfPxKsg8ljfA/YYppB7/4ZMkaAkiFpDftlbV5XlHE+hP1Van0oiP1MkdGurdjLgq/9rBzQIWGpOTgqFop0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758441861; c=relaxed/simple;
	bh=UybcLaOkymoniVqkOhi1dIJsOwx69s4glA8eqYum1Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mTon3RRQ/ZTcU/SQxC5bexSK4MlDyqCM0X+t4ghEVsP3whSrPZykEGMb6XhKM3fNkDK65VJF56uqoLmXMa5F5bd1yK5xHPlFzgU65AGd1JSgUVMT2nqDpgZZ1rhbF9IPEekD9D2Cv5YUdsiQ7hkAF0dGhkP5uoz0fmMPiEEzYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIICuYqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82BE7C4AF09;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758441860;
	bh=UybcLaOkymoniVqkOhi1dIJsOwx69s4glA8eqYum1Fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VIICuYqwYaVCkYyTmNhJ7edOlO5w94DxLr3U3N9hjnO5Li6KWAb4jYnaFiEv12Ng5
	 rm+tiKNZUE2o/TvRaG/TPozeCNfdur4MKzzUJPL7B9VFmFv4ndY/EN//H/EPgKjn2Z
	 OI4CMaJ2xssrgwqW5GdizrW2Xp40h4jl4DMjft2xl9oOzSUtF5qlwxBcGmyR1LBnxU
	 FsXbLtdMLppg8Skd/3m9URMdy37gP5F1E1rIx2YVQCfmCbL4r264R6qdH06/8L3Jyi
	 tc0ZfO9TEbWw7mB8xgLDvB/eTL2+Y6nujrOI3D01nS11Oh93WcQRXgCxUQhdExn1EW
	 zLCcFq1S38cAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75947CAC5AC;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sun, 21 Sep 2025 01:04:21 -0700
Subject: [PATCH v2 3/5] arm64: dts: rk3399-pinephone-pro: Add magnetometer
 sensor support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-ppp_light_accel_mag_vol-down-v2-3-e6bcc6ca74ae@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758441859; l=951;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=kj5gC9w53IltD4i1gA/bywfiCknL042/7ef/++JJoRY=;
 b=UqzF3/MQI2OHSbCUkIhxdxODJaVOYLczY3yCnHaOrlzoA+p185xGGbKpbJxtaHe4CidZlX3ST
 a+xMF3P46+7BLY+bMX4kAY9XmManFa8pmzA3ZJLUOsvmULgcsgfJ98R
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
index 21ff12ac5f6e52041f485c9f2702f5a15ee831f9..266a08540dd0fe099319ec703bb0828c8c5c2c25 100644
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



