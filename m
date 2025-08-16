Return-Path: <linux-kernel+bounces-771798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5C4B28BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05983AC5F75
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83FC2376E1;
	Sat, 16 Aug 2025 08:00:54 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132791E0DFE;
	Sat, 16 Aug 2025 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755331254; cv=none; b=Cou+A+YDlSJhIQ5f6dhqm9TGZebbnnucVZ1CLNeW9+NPzr81oSLb+GZ3D76raFqIra2owB88u8e7Fw5V8pVZ3N3bqYfsxYTuGMShRu8BYZZdWh1+9JDCTO7gN5ylfqZr2721F8d6miLbh0x9QIL40Td+C/Zctsad+ntwscZfELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755331254; c=relaxed/simple;
	bh=Qr3Fl/GDfA/yXONdTYuOsl2faItIGs3u9Njp18XWdZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FRCQotLVamZHwCkFwczKBDt9sL4uVW2r9rjyWU+enQWk+OTdlAD3D/qi9iGMzl5i0G0nu54DVvTwMDaTNFpFjEuZSJqsi19JkQ+B5BbfHDjYZD0PPPNcqxEVMoDwoIXvZpszwYVuboZuvo7cHTpmR54SEsoBr2ml8p2cQu+YbAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.212.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f93a30cd;
	Sat, 16 Aug 2025 16:00:42 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: rockchip: remove vcc_3v3_pmu regulator for Radxa E52C
Date: Sat, 16 Aug 2025 16:00:29 +0800
Message-Id: <20250816080030.183931-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250816080030.183931-1-amadeus@jmu.edu.cn>
References: <20250816080030.183931-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98b1e5291803a2kunm56d2169525b731
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTUlCVhgaSUhNS0ofHRpJTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVCWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1VLWQ
	Y+

According to Radxa E52C Schematic V1.2 [1] page 5, vcc_3v3_pmu
is directly connected to vcc_3v3_s3 via a 0 ohm resistor.
The vcc_3v3_pmu is not a new regulator, so remove it.

[1] https://dl.radxa.com/e/e52c/hw/radxa_e52c_v1.2_schematic.pdf

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
index 1883bd183396..4a3ae95f122f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
@@ -98,16 +98,6 @@ vcc_1v1_nldo_s3: regulator-1v1 {
 		vin-supply = <&vcc_sysin>;
 	};
 
-	vcc_3v3_pmu: regulator-3v3-0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v3_pmu";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc_3v3_s3>;
-	};
-
 	vcc_3v3_s0: regulator-3v3-1 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3_s0";
@@ -255,7 +245,7 @@ eeprom@50 {
 		reg = <0x50>;
 		pagesize = <16>;
 		read-only;
-		vcc-supply = <&vcc_3v3_pmu>;
+		vcc-supply = <&vcc_3v3_s3>;
 	};
 };
 
-- 
2.25.1


