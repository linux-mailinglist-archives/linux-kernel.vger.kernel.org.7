Return-Path: <linux-kernel+bounces-881251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ED0C27D4D
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39C1C4E3527
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F882F658F;
	Sat,  1 Nov 2025 12:00:31 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C271520FA9C;
	Sat,  1 Nov 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998431; cv=none; b=SG5kur4t1McjSSdx0Ad2sFXfCVQVlX6rSq3a2vS3OvAzn3nR/Yc2xbE7St7OzaGm/g47ynT0byQhZMAyVwTESp/N8GZS977x94ogB9raGRrwN+etwbxOeP66ntCRkZ5Y4UTLiCC2R5K0NKam5G/wYOqNbhX2mOU2fqFK+YHRvAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998431; c=relaxed/simple;
	bh=nvdBVlgDdFZxY2D6uEJbdIRrUpNJ3v2yYi/HRe89CiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BfloFx8UJgN4dUKp40HKVg1MMIezruxxDFA360VJemXQu/F7HTKRpoGrUQXnJFhBusLPi4BaHrcfOEMaR8HFjPyD2gEIBbG/GrFzL1YKlql6QHmTnhy8v7D2ayQN1q7tkZnRSPWlJnnO/O9WwqetlQw2XdSSfqDeoGqJ8oLWQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [58.61.140.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2801cc498;
	Sat, 1 Nov 2025 20:00:22 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
	Hsun Lai <i@chainsx.cn>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 4/6] arm64: dts: rockchip: fixes supply for 100ASK DshanPi A1
Date: Sat,  1 Nov 2025 20:00:08 +0800
Message-Id: <20251101120010.41729-4-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251101120010.41729-1-amadeus@jmu.edu.cn>
References: <20251101120010.41729-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a3f4a42d503a2kunmfa682f8b2d36c2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQxoaVk5NGB9MSRlOSUhIH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0tVSkhPWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1VLWQ
	Y+

From the schematic, the supply of ES8388 chip and the vmmc-supply
of SD card both originate from the VCC3V3_S0 regulator, fix it.

Fixes: d809417c5a40 ("arm64: dts: rockchip: add DTs for 100ASK DShanPi A1")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
index 425a78db9522..7c961cb27032 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
@@ -606,9 +606,9 @@ es8388: audio-codec@10 {
 		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x10>;
 		clocks = <&cru CLK_SAI1_MCLKOUT_TO_IO>;
-		AVDD-supply = <&vcca_3v3_s0>;
+		AVDD-supply = <&vcc_3v3_s0>;
 		DVDD-supply = <&vcc_3v3_s0>;
-		HPVDD-supply = <&vcca_3v3_s0>;
+		HPVDD-supply = <&vcc_3v3_s0>;
 		PVDD-supply = <&vcc_3v3_s0>;
 		assigned-clocks = <&cru CLK_SAI1_MCLKOUT_TO_IO>;
 		assigned-clock-rates = <12288000>;
@@ -710,7 +710,7 @@ &sdmmc {
 	cap-sd-highspeed;
 	disable-wp;
 	sd-uhs-sdr104;
-	vmmc-supply = <&vcc_3v3_s3>;
+	vmmc-supply = <&vcc_3v3_s0>;
 	vqmmc-supply = <&vccio_sd_s0>;
 	status = "okay";
 };
-- 
2.25.1


