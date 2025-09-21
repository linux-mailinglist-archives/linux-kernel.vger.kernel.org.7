Return-Path: <linux-kernel+bounces-826382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1302B8E5E5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD69A17B594
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9463298CDC;
	Sun, 21 Sep 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPBlu7SJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128621C84A0;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488762; cv=none; b=GONVkkW+YCeKicbttbf4bauk3o99PWB/aimFq8Wr5ladUqhRWbTqNiDZrJibhjhk6h9y0zOcCI/+sawMa0FxFbJDxKIIuNe7EUG8+8iW+ja8wHufcRODDTrI57yPfOuWnlan54Zvm2S+LZteLglTnOJwPAr06/sl6itw2bkKGvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488762; c=relaxed/simple;
	bh=A62YsqWjZSe9kXXL1MOBMy1Bo5w7CmZKPebVTxOJmPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZCsT2+uHSB/Mx/D9dv5q3LJRc4vs6PgXKMZVqF9ty2uG/Lw0sOMXRkl7wktT+8yMkl4HiMXvgfqXXoqpcSiWQyJxek1HYDXBvvxv4XwinWOZJ3jZMVgB1VHBWWcGL7JwRHsEJEXWxXuAN6sTqqtm58TEicuiA3yF8rHqsQ+iaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPBlu7SJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 952A3C116C6;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758488761;
	bh=A62YsqWjZSe9kXXL1MOBMy1Bo5w7CmZKPebVTxOJmPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MPBlu7SJ8nFiDSjHY0xvI/Vp/R1avwaw8HJcWjP5VeHWp1KHO3Mlo+oip87zvYAED
	 mviP/Cnr0+uQrYkF0IAywvs0xxvgYbmNglu7HVldqt1lqc0GlnsZf8DLuwPr/jpuTo
	 4WD0JHy85IUtCrQqyMgrQAXezSrtiOmnQQuZn5sQ90QhYmVHt1Xx+Q5vkGfJWOKFIq
	 hvEXoz356mfnsEreXomR6zInCJDW7wQAmE9T49DHPNkmkMZ+nX0cM1JUNKgTiCYqLn
	 JHdOIDyRq3cOU0B2+BbaZQycgLJCiH6u6DdL1WOv5s/hHrGxBWdVwKwNc8u+oZrFbk
	 a7IfKkk+6jWPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EEDCAC5A7;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sun, 21 Sep 2025 14:05:55 -0700
Subject: [PATCH v3 2/5] arm64: dts: rk3399-pinephone-pro: Add accelerometer
 sensor support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-ppp_light_accel_mag_vol-down-v3-2-7af6651f77e4@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758488760; l=883;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=yqTWC7jKpb8I52PhxolHfv7gF8MtXmXISaUnHuJbdvQ=;
 b=SxrpwB2hOxDIb2lKlv+QTgKIX8QHC0UN4pNbVBFkISr/PPSkY4PbMxYF4+r0kxqOFYBtyqrKs
 xqmC4O599h/D5UVc5nk96J4JGrFPO6hyFVhsYoOyTFJYZktLGrk+iWP
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Ondrej Jirman <megi@xff.cz>

Pinephone Pro uses mpu6500.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 65ee0b805034a4357a766d4f1f9efa2d4a843d77..21ff12ac5f6e52041f485c9f2702f5a15ee831f9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -544,7 +544,13 @@ mpu6500@68 {
 		reg = <0x68>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <RK_PC6 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vcc_1v8>;
 		vddio-supply = <&vcc_1v8>;
+
+		mount-matrix =
+			"1", "0", "0",
+			"0", "-1", "0",
+			"0", "0", "1";
 	};
 };
 

-- 
2.51.0



