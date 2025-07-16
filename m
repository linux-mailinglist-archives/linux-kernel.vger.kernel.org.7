Return-Path: <linux-kernel+bounces-732928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D99BB06DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB7718917C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FC228506E;
	Wed, 16 Jul 2025 06:20:30 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7D13AA2D;
	Wed, 16 Jul 2025 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646829; cv=none; b=QgDfG0AAEbsuOpOWH64SX7SYfJoaYT9sM+s2H+IWpjLmBteykPvqCHAnexacRIlXnkA/SbJp7prNGP+kkYXPxXQL5L4QYHJdYEPixic3ARMlx6c7F1dKVlzDaUjvudpuPOYMckh2VDTeGjzD45e7FRb2QxyGuzhxHfH0Pds1yj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646829; c=relaxed/simple;
	bh=EBrhFUwJsab3Y6fi5jNlI86t2Te4yDIjlfY3y5kTf84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJRZpbQ4t8B4k603rh1G4YHTL1lHvEX2qJJEomOCIKSV1KNx6irlnGIiwEKhVyCrWWEa2a99mG6bEq5wYrQ2zlCKllOrS1sorlA+EiYIQngIXF8kaqJ/FnHUx2MAnXhpuwpvtfATvxwIXE471SEvav3zXGuGKtF1ZH9TPxSY2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 150B5B4D0E8F;
	Wed, 16 Jul 2025 08:20:20 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: E Shattow <e@freeshell.de>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: starfive: jh7110-milkv-mars sort properties
Date: Tue, 15 Jul 2025 23:19:33 -0700
Message-ID: <20250716061940.180231-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve style with node property order sort of common properties before
vendor prefixes

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
index 3bd62ab78523..fdaf6b4557da 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -12,9 +12,9 @@ / {
 };
 
 &gmac0 {
-	starfive,tx-use-rgmii-clk;
 	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
 	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+	starfive,tx-use-rgmii-clk;
 	status = "okay";
 };
 
@@ -31,14 +31,14 @@ &pcie1 {
 };
 
 &phy0 {
-	motorcomm,tx-clk-adj-enabled;
+	rx-internal-delay-ps = <1500>;
+	tx-internal-delay-ps = <1500>;
+	motorcomm,rx-clk-drv-microamp = <3970>;
+	motorcomm,rx-data-drv-microamp = <2910>;
 	motorcomm,tx-clk-10-inverted;
 	motorcomm,tx-clk-100-inverted;
 	motorcomm,tx-clk-1000-inverted;
-	motorcomm,rx-clk-drv-microamp = <3970>;
-	motorcomm,rx-data-drv-microamp = <2910>;
-	rx-internal-delay-ps = <1500>;
-	tx-internal-delay-ps = <1500>;
+	motorcomm,tx-clk-adj-enabled;
 };
 
 &pwm {

base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
-- 
2.50.0


