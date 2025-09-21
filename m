Return-Path: <linux-kernel+bounces-826069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB15AB8D72C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99E684E01F5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D735246781;
	Sun, 21 Sep 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy2xoBbV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03551E5B78;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758441861; cv=none; b=WfUVomJ8lqqrG6D3HBOjkTG4XN1uh9KbcYIKj1Z6umRw6EFuFSjh3AJh+x5mMO3bj747xhkoZ68lLrsMSXXz+fxtdxRPDN7CvDpQf3NP2SpiqMfFSwAoeHee6v+iPHvpiHTQ69yOsYxDqlxxnPn7RbhdoJ/L9ECLhp1y6XnPu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758441861; c=relaxed/simple;
	bh=AhixuexTrd59t99WLu4pyplL2ezihsPR8JW2sbv+/SA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHSKDDQi01kcV2eu4rkr2xonrNtsQxwqR2WIYWESCfw2HmIJN/W82hcCPt1wyLeI9Kau5VJym5xPG4EcDTHpVVd69Am9WcSAzGdIimAVhEO22VLkSxQ8nirKUnIJRox2r5/G90NpaiDouvG4vws/tbWRMs1s1d9VkhT5/Lj6HRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy2xoBbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91E9CC19423;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758441860;
	bh=AhixuexTrd59t99WLu4pyplL2ezihsPR8JW2sbv+/SA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Wy2xoBbVTEIsS5TeoEuyTvwUbZdZQKlSIXQPxXo2dZWY46gHH10bM+CoP7AlgJlGU
	 mox/wc52T8hyNWWnOMb32+5Rapb2F2c4GQd0mfQOyu1YWW0XZDBg2v0+kOAwZOvvlY
	 TiyQbJUW4IeLuq77BwHvtFtVbw4iIuGY3Y2v6ZCgsADDu9AhMW+Tik/VYEca3TRzgc
	 P7EGmU7XYrJ+KfjWKZTxTV2fme6YphP6QOCOeC/pxXU7Sx+n2vkTbJ/ew9M1TVKdhY
	 C+Wap4l/rVjRi9lOwIqjbGbdO8p4K3BcmLfyJkISyKSr3JkIbrVC247/CEj9D4fxEA
	 eM8GYQ9eUnq0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87682CAC5AA;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sun, 21 Sep 2025 01:04:22 -0700
Subject: [PATCH v2 4/5] arm64: dts: rk3399-pinephone-pro: Add mount-matrix
 for magnetometer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-ppp_light_accel_mag_vol-down-v2-4-e6bcc6ca74ae@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, 
 "Leonardo G. Trombetta" <lgtrombetta@gmx.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758441859; l=1257;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=qrBum6tpCbh5Y3lzHoCw8XU7jiTEUSu/XrnJwPQpgTg=;
 b=nT1qSpLmqXY3kXf2eAa35+OKQBlh5iRWQO4vaVL7iV01eONxB+4kQpEtGFWzg9/72TXS4ZKzv
 g1/JjIWOpo8BN80x3urFZK67WJF+LMFbE/0xGVJV1I57sbL0jFI4AAq
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: "Leonardo G. Trombetta" <lgtrombetta@gmx.com>

After experimenting with the magnetometer on the Pinephone Pro I found
out the mount-matrix currently reported by the AF8133J driver is just
the identity matrix (no rotation), which is wrong. It would seem to me
that there is currently no `mount-matrix` info and that's why the driver
reports a trivial answer. As far as I can tell from my tests, a 90
degree clockwise rotation in the XY plane would align it properly.

Signed-off-by: Leonardo G. Trombetta <lgtrombetta@gmx.com>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 266a08540dd0fe099319ec703bb0828c8c5c2c25..0a4121b05d36c5a7e05eddbd3514a11ae4f7d3eb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -561,6 +561,11 @@ af8133j: compass@1c {
 		reset-gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_LOW>;
 		avdd-supply = <&vcc_3v0>;
 		dvdd-supply = <&vcc_1v8>;
+
+		mount-matrix =
+			"0", "1", "0",
+			"-1", "0", "0",
+			"0", "0", "1";
 	};
 };
 

-- 
2.51.0



