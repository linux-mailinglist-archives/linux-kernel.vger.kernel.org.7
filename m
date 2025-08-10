Return-Path: <linux-kernel+bounces-761598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A70B1FC53
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FFD7AD5AE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D088221283;
	Sun, 10 Aug 2025 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cVyOHyIQ"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557A21FF46
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 21:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754860471; cv=none; b=YpQTgM6j3amSTdnGMt0Mlmdksw1fFwA9SAD0gnI6lSQo7ovvAsUgkyuswfq2V0qcA52gIaqHUj8IA9I9CsWpuSd7LNo9B9OLYQpm8at8fgTcXPv+iLSUCb7v2TbR/Y1Qk6f6KFNo3muPhZRmTCXRnDLST3XKvyGpnNxwCcgL8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754860471; c=relaxed/simple;
	bh=yGYrchwGkyJIbY/pz17RU576Sc5ujkbF9b9k9H59f+4=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type:
	 References; b=QX3aCoHgi+f82tPWE7NvskTFAm52PKFkNW+5291qFJT3iqmI37/fEh6rHPmfAWedoWw4R4Pk+KYQSkD1WdOYFYDutNxA8TUvJ6+VsP5HU+tMBCyh4Yt8vz0iPzK3huceriNkOgdQCvvM29rCFFLo371qEYzy9vGXpV8ybrngMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cVyOHyIQ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250810211421euoutp019392ee274ea690584febb660ac6fe4e1~ahEq32y5M0758607586euoutp01c
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 21:14:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250810211421euoutp019392ee274ea690584febb660ac6fe4e1~ahEq32y5M0758607586euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754860461;
	bh=Mo+HO+WEp9bez+G5fTqLRqhZXEMypwaCdWht1NAhUv4=;
	h=From:Date:Subject:To:Cc:References:From;
	b=cVyOHyIQfTcKZRY6JDjMBM2Nni2T792hxqo7RUmnxSzeIT3ztE8ElXVhf2j9KVHFB
	 s4ADlvfAyriXQgFyyafbNw3JQacKszaRDmkY2wLNS8D8SOO9iJ2HoW8HahdkjEE78i
	 Drapgn7p1WDDKJzVSWGslylM/wjKDl//7MX+n20Y=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250810211419eucas1p173e5fefcfaae437d8b5531d1406ff6a6~ahEpnR34i2363123631eucas1p1d;
	Sun, 10 Aug 2025 21:14:19 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250810211419eusmtip23c5f82de8db4cfef0d66c6c2bdb7bc5f~ahEo-hH4_0966009660eusmtip2_;
	Sun, 10 Aug 2025 21:14:19 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Sun, 10 Aug 2025 23:14:19 +0200
Subject: [PATCH] reset: thead: Scope TH1520 reset driver to VO subsystem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-fix_reset_2-v1-1-b0d1900ba578@samsung.com>
X-B4-Tracking: v=1; b=H4sIAKoLmWgC/x2MQQqAIBAAvyJ7TlBTk74SIZJb7cVCIwLp70nHY
	ZipUDATFhhZhYw3FTpSA9kxWPaQNuQUG4MSyggnBV/p8RkLXl7xYKWLg1bW9BpacWZs+r9N8/t
	+bDYyql0AAAA=
X-Change-ID: 20250810-fix_reset_2-a618d7426534
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,  Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
	<conor+dt@kernel.org>,  Paul Walmsley <paul.walmsley@sifive.com>,  Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,  Alexandre
	Ghiti <alex@ghiti.fr>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,  Michal
	Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250810211419eucas1p173e5fefcfaae437d8b5531d1406ff6a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250810211419eucas1p173e5fefcfaae437d8b5531d1406ff6a6
X-EPHeader: CA
X-CMS-RootMailID: 20250810211419eucas1p173e5fefcfaae437d8b5531d1406ff6a6
References: <CGME20250810211419eucas1p173e5fefcfaae437d8b5531d1406ff6a6@eucas1p1.samsung.com>

The reset controller driver for the TH1520 was using the generic
compatible string "thead,th1520-reset". However, the current
implementation only manages the resets for the Video Output (VO)
subsystem.

Using a generic compatible is incorrect as it implies control over all
reset units on the SoC. This could lead to conflicts if support for
other reset controllers on the TH1520 is added in the future like AP.

To ensure correctness and prevent future issues, this patch renames the
compatible string to "thead,th1520-reset-vo". The device tree bindings,
the th1520.dtsi file, and the driver itself are updated to use this new,
more specific compatible. The device tree node label is also renamed
from 'rst' to 'rst_vo' for clarity.

Fixes: 30e7573babdc ("dt-bindings: reset: Add T-HEAD TH1520 SoC Reset Controller")
Reported-by: Icenowy Zheng <uwu@icenowy.me>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml | 6 +++---
 arch/riscv/boot/dts/thead/th1520.dtsi                           | 6 +++---
 drivers/reset/reset-th1520.c                                    | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
index f2e91d0add7a60e12973c216bb5a989857c3c47c..f84c5ae8bc3569cb1d4e8f07999888ea26e175d0 100644
--- a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
@@ -16,7 +16,7 @@ maintainers:
 properties:
   compatible:
     enum:
-      - thead,th1520-reset
+      - thead,th1520-reset-vo
 
   reg:
     maxItems: 1
@@ -36,8 +36,8 @@ examples:
     soc {
       #address-cells = <2>;
       #size-cells = <2>;
-      rst: reset-controller@ffef528000 {
-        compatible = "thead,th1520-reset";
+      rst_vo: reset-controller@ffef528000 {
+        compatible = "thead,th1520-reset-vo";
         reg = <0xff 0xef528000 0x0 0x1000>;
         #reset-cells = <1>;
       };
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 42724bf7e90e08fac326c464d0f080e3bd2cd59b..9cc2f1adf489ac432b2f3fbb06b655490d9e14b3 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -235,7 +235,7 @@ aon: aon {
 		compatible = "thead,th1520-aon";
 		mboxes = <&mbox_910t 1>;
 		mbox-names = "aon";
-		resets = <&rst TH1520_RESET_ID_GPU_CLKGEN>;
+		resets = <&rst_vo TH1520_RESET_ID_GPU_CLKGEN>;
 		reset-names = "gpu-clkgen";
 		#power-domain-cells = <1>;
 	};
@@ -500,8 +500,8 @@ clk: clock-controller@ffef010000 {
 			#clock-cells = <1>;
 		};
 
-		rst: reset-controller@ffef528000 {
-			compatible = "thead,th1520-reset";
+		rst_vo: reset-controller@ffef528000 {
+			compatible = "thead,th1520-reset-vo";
 			reg = <0xff 0xef528000 0x0 0x4f>;
 			#reset-cells = <1>;
 		};
diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
index 7874f0693e1b427a094a68f2b6d783985e789bf8..05ed11972774618df4512b7c9f9f12e71455e48b 100644
--- a/drivers/reset/reset-th1520.c
+++ b/drivers/reset/reset-th1520.c
@@ -116,7 +116,7 @@ static int th1520_reset_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id th1520_reset_match[] = {
-	{ .compatible = "thead,th1520-reset" },
+	{ .compatible = "thead,th1520-reset-vo" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, th1520_reset_match);

---
base-commit: 561c80369df0733ba0574882a1635287b20f9de2
change-id: 20250810-fix_reset_2-a618d7426534

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


