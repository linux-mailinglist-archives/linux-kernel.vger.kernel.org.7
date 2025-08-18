Return-Path: <linux-kernel+bounces-774292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E2B2B0E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFF4684D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BFE273D73;
	Mon, 18 Aug 2025 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="adJ7g3Kj"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655325485F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543225; cv=none; b=K93fT/9oiQ/Gy6D1HVwU+zOGtsyrY/9RPCKRWcymwTgdJvKOmnmOqRMblYlFFUmLy/TBI5e7W3m35gkS5rn/ZaMW1rA5cgFO1slkoxRXSQmIYtNRoXJBbEibDzZX+pyHXGiFFBnalJ6PEjyGT8F7vwSh1zQ7bJyM8Eb9qT07aKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543225; c=relaxed/simple;
	bh=DK1eafKflS1VMkgKFpYRZQJtGcCG+9RUeQyxkEG/CZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xkm4zIEH6eEte8uxvb0hqB1M57IK4tfF08K1yGEX7X5GicwfIaK/nBWN9o66bOdEAXmtmbXuAyL1J3MJR6XvMchPvKLbNrsCPZegbMFPWIfzS6MMdigxRj/e4+0LFl2X20/XsvhHxevFQcH01dWjEmzSAz2+RHOix9sSqSTejEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=adJ7g3Kj; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=OH1cdcIwLbHj9b9TDgmclt0bqqFEVSxJAiUw7x5ysn8=; b=adJ7g3Kjn4P3LsdRmu3hk6HtaR
	DrZGWCSghynMpZaa3+n+fwAGPMmSNxpR+z6JzqraYuEqykZSoccVE3GIeaNBzottpN+cDc9Xv/p2m
	NW17PtYVdgEMzbEveSZSbS2suFgeq/uCC763qnGqtFJoR1Wd1zi4crI3N5Mc6M0dgVaGCJkYr9sVU
	K7HtTcMHhMPlr/c21kjAO7RgH2rsd4WDBM0JQYbLsDYBMyHNxI+UwKAMocos1ZQieiOQ/B6CUSX6z
	YUF361pd9RfG8FYQhNhpy2Qz9SDUZP+KGZHy6UxT2oijRDzy/6uM2Jb2A32wBcx01V9lT6Eos+QQn
	HuUQoEoA==;
Received: from i53875ad4.versanet.de ([83.135.90.212] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uo4zE-0000jH-Qm; Mon, 18 Aug 2025 20:53:40 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: move cpu_thermal node to the correct position
Date: Mon, 18 Aug 2025 20:53:36 +0200
Message-ID: <20250818185337.2584590-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818185337.2584590-1-heiko@sntech.de>
References: <20250818185337.2584590-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The &cpu_thermal node was added at the wrong position, move it to
the correctly sorted one.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 96 +++++++++----------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 6ae4316761c4..5656554ca284 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -196,6 +196,54 @@ &cpu3 {
 	cpu-supply = <&vdd_cpu>;
 };
 
+/*
+ * The MCU can provide system temperature too, but only by polling and of
+ * course also cannot set trip points. So attach to the cpu thermal-zone
+ * instead to control the fan.
+ */
+&cpu_thermal {
+	trips {
+		case_fan0: case-fan0 {
+			hysteresis = <2000>;
+			temperature = <35000>;
+			type = "active";
+		};
+
+		case_fan1: case-fan1 {
+			hysteresis = <2000>;
+			temperature = <45000>;
+			type = "active";
+		};
+
+		case_fan2: case-fan2 {
+			hysteresis = <2000>;
+			temperature = <65000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		/*
+		 * Always provide some air movement, due to small case
+		 * full of harddrives.
+		 */
+		map1 {
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+			trip = <&case_fan0>;
+		};
+
+		map2 {
+			cooling-device = <&fan 2 3>;
+			trip = <&case_fan1>;
+		};
+
+		map3 {
+			cooling-device = <&fan 4 THERMAL_NO_LIMIT>;
+			trip = <&case_fan2>;
+		};
+	};
+};
+
 &gmac0 {
 	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
 	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
@@ -492,54 +540,6 @@ rgmii_phy0: ethernet-phy@3 {
 	};
 };
 
-/*
- * The MCU can provide system temperature too, but only by polling and of
- * course also cannot set trip points. So attach to the cpu thermal-zone
- * instead to control the fan.
- */
-&cpu_thermal {
-	trips {
-		case_fan0: case-fan0 {
-			hysteresis = <2000>;
-			temperature = <35000>;
-			type = "active";
-		};
-
-		case_fan1: case-fan1 {
-			hysteresis = <2000>;
-			temperature = <45000>;
-			type = "active";
-		};
-
-		case_fan2: case-fan2 {
-			hysteresis = <2000>;
-			temperature = <65000>;
-			type = "active";
-		};
-	};
-
-	cooling-maps {
-		/*
-		 * Always provide some air movement, due to small case
-		 * full of harddrives.
-		 */
-		map1 {
-			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
-			trip = <&case_fan0>;
-		};
-
-		map2 {
-			cooling-device = <&fan 2 3>;
-			trip = <&case_fan1>;
-		};
-
-		map3 {
-			cooling-device = <&fan 4 THERMAL_NO_LIMIT>;
-			trip = <&case_fan2>;
-		};
-	};
-};
-
 &pcie30phy {
 	data-lanes = <1 2>;
 	status = "okay";
-- 
2.47.2


