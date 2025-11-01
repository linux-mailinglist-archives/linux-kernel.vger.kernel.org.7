Return-Path: <linux-kernel+bounces-881252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B359C27D53
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CDD1A239FD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD7D2F6933;
	Sat,  1 Nov 2025 12:00:31 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7629A309;
	Sat,  1 Nov 2025 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998431; cv=none; b=B3oD4TAo53oEDvMs4p5RVJJdwNYKC7cZl22xd0ATp+n3EhML2+lzS4ODHLFcqZOpArKuPabuNpWYskPhjMLsViMsHDkQN7AtqxLyWjW0klAe8yOzU3EF9FHi24QnAc+4HCC6cLmZCdqWV3bJWERtSaESs+9vs0rHpW3Lyh0yDRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998431; c=relaxed/simple;
	bh=yBPoyy/ui4vCxWIPK9/82yI4j1WwnDa3RS3h/F5hnW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SyG71sOo0DAttu4JmAVIq9sGE1yMVP3kUZ8sVDc68z2O6Qft/3X9u638p74OyOMcNgpvcVSLBzxRa3UB6KsJPnDse5CuwYLK0SaNVManrHZvFQVax6e8LoR3E3o0jCaZptHGA/UGXwIxvsSSG/hlvQMPmiapfe1LtJothVBX8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [58.61.140.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2801cc494;
	Sat, 1 Nov 2025 20:00:17 +0800 (GMT+08:00)
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
Subject: [PATCH 2/6] arm64: dts: rockchip: fixes regulator for 100ASK DshanPi A1
Date: Sat,  1 Nov 2025 20:00:06 +0800
Message-Id: <20251101120010.41729-2-amadeus@jmu.edu.cn>
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
X-HM-Tid: 0a9a3f4a2ee703a2kunmfa682f8b2d3678
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTxlKVk0dT0IYTxhOShlDQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0tVSkhPWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1VLWQ
	Y+

Referencing the schematic [1], correct the names of the USB
regulator, remove these non-existent RTC and UFS regulators.

[1] https://dl.100ask.net/Hardware/MPU/RK3576-DshanPi-A1/DshanPi-A1-RK3576-SCH_V1.1.pdf

Fixes: d809417c5a40 ("arm64: dts: rockchip: add DTs for 100ASK DShanPi A1")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../dts/rockchip/rk3576-100ask-dshanpi-a1.dts | 46 ++-----------------
 1 file changed, 3 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
index 9cbd3fae16ab..f8bc401e796f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
@@ -85,16 +85,6 @@ vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
 		vin-supply = <&vcc_5v0_sys>;
 	};
 
-	vcc_1v2_ufs_vccq_s0: regulator-vcc-1v2-ufs-vccq-s0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_1v2_ufs_vccq_s0";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-		vin-supply = <&vcc_5v0_sys>;
-	};
-
 	vcc_1v8_s0: regulator-vcc-1v8-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v8_s0";
@@ -105,16 +95,6 @@ vcc_1v8_s0: regulator-vcc-1v8-s0 {
 		vin-supply = <&vcc_1v8_s3>;
 	};
 
-	vcc_1v8_ufs_vccq2_s0: regulator-vcc-1v8-ufs-vccq2-s0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_1v8_ufs_vccq2_s0";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_1v8_s3>;
-	};
-
 	vcc_2v0_pldo_s3: regulator-vcc-2v0-pldo-s3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_2v0_pldo_s3";
@@ -135,16 +115,6 @@ vcc_3v3_m2: regulator-vcc-3v3-m2 {
 		vin-supply = <&vcc_5v0_sys>;
 	};
 
-	vcc_3v3_rtc_s5: regulator-vcc-3v3-rtc-s5 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v3_rtc_s5";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc_5v0_sys>;
-	};
-
 	vcc_3v3_s0: regulator-vcc-3v3-s0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3_s0";
@@ -165,27 +135,17 @@ vcc_5v0_sys: regulator-vcc-5v0-sys {
 		vin-supply = <&vcc_in>;
 	};
 
-	vcc_5v0_typec0: regulator-vcc-5v0-typec0 {
+	vbus5v0_typec: regulator-vbus5v0-typec {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&typec5v_pwren_h>;
-		regulator-name = "vcc_5v0_typec0";
+		regulator-name = "vbus5v0_typec";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc_5v0_sys>;
 	};
-
-	vcc_3v3_ufs_s0: regulator-vcc-ufs-s0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v3_ufs_s0";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc_5v0_sys>;
-	};
 };
 
 &combphy0_ps {
@@ -761,7 +721,7 @@ &u2phy0 {
 };
 
 &u2phy0_otg {
-	phy-supply = <&vcc_5v0_typec0>;
+	phy-supply = <&vbus5v0_typec>;
 	status = "okay";
 };
 
-- 
2.25.1


