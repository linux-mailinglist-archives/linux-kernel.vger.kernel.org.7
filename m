Return-Path: <linux-kernel+bounces-826068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2510CB8D732
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B668E4809E7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D324677C;
	Sun, 21 Sep 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry0taYF8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC81448E0;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758441861; cv=none; b=N4UvYJISLAs9ofEA537cYH29ju/F2oR5nlip9Rrccx+3yn1zzw0jSUINgL73PALFPqf4RTZIU3WVUbWEJ/HTBcTxRAee2ELNxP/BaLKo8UGe3C7zxYbXWJy7wDxfymFiFmMd/I2QZmEdVmeU5AvdIDC8E/KIgHT6kZAVCkQ8j4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758441861; c=relaxed/simple;
	bh=A62YsqWjZSe9kXXL1MOBMy1Bo5w7CmZKPebVTxOJmPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ep1hkhNhC86fesEhGA6XgSaokMfxfULNS088MlpXvULbFZ60RWms6lwWesdiNBxAcbzjtEukOiJab4Ds4UgyRzJiXtAjiUix2o7J2CVb4dicbNvAvlTk8VzI8Po/0wiRd3L1ORaLRAynpmri3RB4Lqy5dHiAqmiP6VTU6YKr0c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry0taYF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F40FC116C6;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758441860;
	bh=A62YsqWjZSe9kXXL1MOBMy1Bo5w7CmZKPebVTxOJmPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ry0taYF86t9zjQY20G3YIVi3jEq3Vq7WrCEWNytKVPRy7s2v+ef2yKSlzEaTrDSpI
	 EI5MdvJYjZWaenXnn5EVZwqnTfrG/BqzCDzeyo+WL9o+AGiTEg+72KNgz0sJLcVjLa
	 BW4iS6+djrhVhTw8x+IBWmlYf92rUilu6unHzDr4vUXEzwrJOB5n2JySC7EghZOtD/
	 b1stBqHfLJMQdRTRtSLdCj3Ua1ZhNxmhpxK3Ia1a0og06vZJ2uzbopvDMN7hAkG+Sj
	 sLjXSTdI+HgOR+TU5AG021G8IAY2YR8Dt7MEEyNkASMCIyQ/FtE0to71f/OAn9mt8u
	 ipSlGuA6A3faQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601BDCAC5A8;
	Sun, 21 Sep 2025 08:04:20 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sun, 21 Sep 2025 01:04:20 -0700
Subject: [PATCH v2 2/5] arm64: dts: rk3399-pinephone-pro: Add accelerometer
 sensor support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-ppp_light_accel_mag_vol-down-v2-2-e6bcc6ca74ae@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758441859; l=883;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=yqTWC7jKpb8I52PhxolHfv7gF8MtXmXISaUnHuJbdvQ=;
 b=snSHL8sMKhp8Ssd721h8sYObmysqUVUw5bq/HHvwf9OLUk+k3oZWSZddaSpvA93hbUXD+Ixo7
 Hbk8G1uTsb6AuBaLEeNrchcqXI8N5QIaPP31fVKRL7t5iBqcFVeHyzy
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



