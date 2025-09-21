Return-Path: <linux-kernel+bounces-826384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1CCB8E5EE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29263BA93B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2631299948;
	Sun, 21 Sep 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw6KmPvm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1A275861;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488762; cv=none; b=JSQKzkiWo5sb5ioIN24D1keHlU3g0O7I2OMWHjcwo04yWrmtf1tpoKYMU64zEsD6bm7YearKOlJ6PNnIgj9qzHusxshkz8yy1Nl36XUPUttGQLobwcQZr0B8eC1qonODxWhTY61b7il2vDIEHaLNWDHAtrqdPbd3M8KhSFZdTWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488762; c=relaxed/simple;
	bh=UybcLaOkymoniVqkOhi1dIJsOwx69s4glA8eqYum1Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0HFdIGSsx7C7QrLwVWOCDU94Tg3bESQ1fJYJyx7Y0gQ+6b4AHT9t1awd/PJyrwnyIYpZ3LuB70yAdHP4QC6VROjVzr8/ZNKASDzeNQsNTt4udXy9HMSHMqEIy24ZVvNI6tKs8G8qXoR1+ZDfYPirGXkQKsKcCYtnVir+1rmbow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw6KmPvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D680C116B1;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758488761;
	bh=UybcLaOkymoniVqkOhi1dIJsOwx69s4glA8eqYum1Fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qw6KmPvm7Qhb4YIYn4lmPvoVg6T2xU/rZYEJRL20Am71XUPgZlxQL1ehq7ZTye1Sd
	 QhtEhkx+9LJui3WneYcGR3uJ3dDWwudx152XsFCj1TJd7p3bl1PkzFRLy3Dy3fbS8h
	 BexU1EbnwK0HHpfUc0ah5XWiCR9aFYiVlKeGGvYu8JgzqPmvuaEgnDrbmKfM7WXHwV
	 pchmyJlhhQZbhxwJ2/kN4aRWWgisU7SAfpUAE3+UXxh9A+n7PJiTtudnzP2lcSlnnC
	 J+FuYl3KErzl4E/0RqOAtHPisc/D7QxWJ5bKeHYo5tQcibSmRIHOBp5bC9OiTltlwI
	 M10rmdAHliIyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9083DCAC5AE;
	Sun, 21 Sep 2025 21:06:01 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sun, 21 Sep 2025 14:05:56 -0700
Subject: [PATCH v3 3/5] arm64: dts: rk3399-pinephone-pro: Add magnetometer
 sensor support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-ppp_light_accel_mag_vol-down-v3-3-7af6651f77e4@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758488760; l=951;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=kj5gC9w53IltD4i1gA/bywfiCknL042/7ef/++JJoRY=;
 b=7hK39amHNFdmeI+Vo4u3YSTxpFPIfRC9zC7EpXNa62rYasOMJ7S9uzMPUahKaAHdkcY+FltrX
 72hrawMaw9MDwkh5u4OoLizMizv2t7AIz+RKX5t3N1UfAnx1OTk5DfN
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



