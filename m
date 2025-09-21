Return-Path: <linux-kernel+bounces-826025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9721B8D5C9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56DF17BCCD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 06:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B6A2D0C92;
	Sun, 21 Sep 2025 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwMfYkEv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CFD2C0299;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758436864; cv=none; b=dLeY5Ybfg2B4YaBBhm9erPko0L+laf0ip2jdosIhwXXIxy0pXtgAnxMbHuMMJ72mFBgGQyFs8goduVwJZm+HZxB/VX+FzMQsypRAPJvwWOY5bfrd08V5sspzsrFInvonuFKOLlSoIS22fjy4N06kpcQqJ6/E7P2jgVOz0ui1Byw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758436864; c=relaxed/simple;
	bh=tWkryI5Fn0tquUFMSgR7wEMVnb6X+aoYcV4XgpFoxII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bqL5V+HxjWyPmurCsZOWEEPgpsXbpVntdkERkrE8Va9f9pmrXoXaU1A1zy3K51yS45+GRA2C4Lc4ctnEtMPuLXuvGxVBXG5fDH/o8g6MOzVuft/+w5j4lEtWfIK8o0VC3thjZaD9hyx4n6m8i7ANaiU5uTxiiP5NMB7mdYBzLHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwMfYkEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 461B4C116C6;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758436864;
	bh=tWkryI5Fn0tquUFMSgR7wEMVnb6X+aoYcV4XgpFoxII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MwMfYkEv87yYuN8Gb/NL2fjhvSLiaH8sv73sBLNcVGc8TWCzD5LMN08bt4fy8rFre
	 1Ksu7ymmjMqL4iP633bXgBp+STpiwzdspBmZy0aYm8HGVtO+hsk8xzrjBu4lNIc7HC
	 FQxGowvzs22+ozT+POrqbltYI9vVBdoUNNaNVedoYN+jzVhpDWqTOTexltMkWy1vT+
	 f7Xvsfbq3SOZQ4xzPNdmGwC4YgnZ/i6MIwvc4uO4N/ecQdZJTsnZNruqHkWKIvL+7o
	 Z4sHwkOzMA64S36FortAFCLhbJKgc4eqrru4hO2LKyO+2ppgMNvzMPmnyK8URBLN9s
	 ki2Pi7RbugGjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C759CAC59A;
	Sun, 21 Sep 2025 06:41:04 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Sat, 20 Sep 2025 23:41:04 -0700
Subject: [PATCH 2/5] arm64: dts: rk3399-pinephone-pro: Add accelerometer
 sensor support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-ppp_light_accel_mag_vol-down-v1-2-c8bbcd3e2e94@gmail.com>
References: <20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com>
In-Reply-To: <20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758436863; l=883;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=SfqrwYTRcKhC1h7DV8dOsoX/vi0YcmV/gXhDpcpF9vw=;
 b=7qCe7uXU7IlkiQxeGNCcIveyXGrAhfeincuEYiMyWR3o4jwBCh7vttA2bIreRtDoMYHdckn/x
 Q6Kd7ALLhJmDazfyL4BMXqDB6MJlB20zGdduy4HUWaONbY0qPnOpsoz
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
index 7d1257a3f2e0cbdc65a810062ecd5117f9f5b687..da7ce905152269436410b959be937e07c23772b2 100644
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



