Return-Path: <linux-kernel+bounces-823791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37853B87722
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E8B7C5C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC5537160;
	Fri, 19 Sep 2025 00:01:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A7D1F4297;
	Fri, 19 Sep 2025 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758240092; cv=none; b=N7yC8t1iqei5tDP09tCdUMc+zDfCgHGQS9rbPZ5WCyFzn7koes0d3xjqAZ8DaPRZy6DNMI+EiPMG2bSoz7uzaEQFExgTUNzXOkAyos2lzv+FwnnVa47hLNUjvJ8wtItg6mgrT0efNREHRaiOJ8kyCaGImELbEMtaXegZVpKsTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758240092; c=relaxed/simple;
	bh=Tg1ld0C9aJV9Taesd/GOIbrFd9dLKzMX+uwTJypScp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo3l14ivi6SQDQ3/aeqdXv+sR9x3zfEATTMjrFzLOQYzldAYzYCXPTjC+z1NZunWOD8GgXtt7KmTkg6JNkKiU10e/JH6udrauORVQP9ndPS6xpWxD22edd99C5dSRUxb6OWtgumAi1yLNlQ4F0GHY6Pov1Mlpq4N+VA67V6isoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1148B1762;
	Thu, 18 Sep 2025 17:01:22 -0700 (PDT)
Received: from minigeek.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 058443F673;
	Thu, 18 Sep 2025 17:01:27 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [RFC PATCH 5/5] arm64: dts: allwinner: a523: Mark dual-phased regulators
Date: Fri, 19 Sep 2025 01:00:20 +0100
Message-ID: <20250919000020.16969-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20250919000020.16969-1-andre.przywara@arm.com>
References: <20250919000020.16969-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X-Powers AXP323 PMIC on the boards with a SoC from the Allwinner
A523 family typically uses DCDC1 and DCDC2 in a dual-phase setup to
supply the "big" CPU cluster. For some reason this dual-phase
configuration is not the PMIC's reset default, but needs to be actively
programmed at runtime.

Add the newly introduced x-powers,polyphased property in the board DTs,
to mark this connection and let drivers program the dual-phase setup.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts   | 5 ++++-
 arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts    | 5 ++++-
 arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts   | 5 ++++-
 arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts | 5 ++++-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
index 4ad91b6f01d34..a51446482927c 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
@@ -269,9 +269,12 @@ reg_dcdc1_323: dcdc1 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpub";
+				x-powers,polyphased = <&reg_dcdc2_323>;
 			};
 
-			/* DCDC2 is polyphased with DCDC1 */
+			reg_dcdc2_323: dcdc2 {
+				/* dual-phased with DCDC1 */
+			};
 
 			/* RISC-V management core supply */
 			reg_dcdc3_323: dcdc3 {
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts b/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
index 68c5765c2e919..848b5abb4203f 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
@@ -285,9 +285,12 @@ reg_dcdc1_323: dcdc1 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpub";
+				x-powers,polyphased = <&reg_dcdc2_323>;
 			};
 
-			/* DCDC2 is polyphased with DCDC1 */
+			reg_dcdc2_323: dcdc2 {
+				/* dual-phased with DCDC1 */
+			};
 
 			reg_dcdc3_323: dcdc3 {
 				regulator-always-on;
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index 7b7ef54ec7684..ec69b409ac47f 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -291,9 +291,12 @@ reg_dcdc1_323: dcdc1 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpub";
+				x-powers,polyphased = <&reg_dcdc2_323>;
 			};
 
-			/* DCDC2 is polyphased with DCDC1 */
+			reg_dcdc2_323: dcdc2 {
+				/* dual-phased with DCDC1 */
+			};
 
 			/* Some RISC-V management core related voltage */
 			reg_dcdc3_323: dcdc3 {
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
index d07bb9193b438..e9e6d85fb84f7 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
@@ -322,9 +322,12 @@ reg_dcdc1_323: dcdc1 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1150000>;
 				regulator-name = "vdd-cpub";
+				x-powers,polyphased = <&reg_dcdc2_323>;
 			};
 
-			/* DCDC2 is polyphased with DCDC1 */
+			reg_dcdc2_323: dcdc2 {
+				/* dual-phased with DCDC1 */
+			};
 
 			/* Some RISC-V management core related voltage */
 			reg_dcdc3_323: dcdc3 {
-- 
2.46.4


