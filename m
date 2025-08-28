Return-Path: <linux-kernel+bounces-790767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E804B3ACBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E953A7BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B7265CAD;
	Thu, 28 Aug 2025 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0nDTyTz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5B283FFD;
	Thu, 28 Aug 2025 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416640; cv=none; b=rJGC4lZSNHIurh8iX4NdcvAvrJCSk/vER9sj7H76UzCI1lyLu5fdzJpr1FM9Dk9WfrNt+qhK6PO1v93C2RlUrbLQPn+JcFXFaBwLP5siR8YOw83H5CYX9ZgkC0Yifz3CQipKZlfbUDctTa9+p3Om4rD2N0dok8QWrMOHbwTNzCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416640; c=relaxed/simple;
	bh=Rd0xr0MhBmCf+FWFWjFdTrfsK8O7aobr0QTSWX9i//w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oiVuKLlLOrX6FK71ypPcUnjX/RVHq7GYxO0XBWufuxDzIDllrZpg0z3XRHpWPb/FGySYJRnNkRPDfNAIe8H0iMvKrB86UC6JXy+L2xAdwMyE6UT/Tw8bDyiiKvB2AcxWqiaexHpHCdu4pxVyRzwmfvZYnUku1YokMOx5+5CwV6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0nDTyTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2C9C4CEEB;
	Thu, 28 Aug 2025 21:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756416640;
	bh=Rd0xr0MhBmCf+FWFWjFdTrfsK8O7aobr0QTSWX9i//w=;
	h=From:To:Cc:Subject:Date:From;
	b=Q0nDTyTzp4ovb908QABKBN+Cl6h+PdlrrI4t2TYunvmoH8hXmeU2HbxjQfHXsT0qs
	 Yk+KMAwAF04QXlrF3i+fMVSRK3/UNj/qrtCrOTD3y4DTGst/Gon6ATnt5+I0tgT/Wi
	 Uc90I3mPhP+4lmHsFyqQe5jJcvqGSbsa3vAEvCRoO6PI2FS/UvEezMHCTsfq2H35YW
	 dY0eFExRfdZwRhPKfpvb65Md6iy/wXqO6vBsiItGQIUyoahsstTgbS72AkGyd0OfOy
	 z4kP2b0MMeWBxtdkCrsNhY6Fm0ZQYO2Q44xOdwQ4pHmnt6hasyPd5hisjofPftcrbV
	 kDdiitq0guDaw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: xilinx: Drop undocumented "always-on" properties
Date: Thu, 28 Aug 2025 16:30:26 -0500
Message-ID: <20250828213028.2266805-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "always-on" properties are not documented for "silabs,si5341"
binding nor used by the Linux driver, so drop them.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 8 --------
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 6 ------
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 6 ------
 3 files changed, 20 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index e172a30e7b21..6bee21d4fa4d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -552,42 +552,34 @@ si5341: clock-generator@36 { /* SI5341 - u69 */
 				si5341_0: out@0 {
 					/* refclk0 for PS-GT, used for DP */
 					reg = <0>;
-					always-on;
 				};
 				si5341_2: out@2 {
 					/* refclk2 for PS-GT, used for USB3 */
 					reg = <2>;
-					always-on;
 				};
 				si5341_3: out@3 {
 					/* refclk3 for PS-GT, used for SATA */
 					reg = <3>;
-					always-on;
 				};
 				si5341_4: out@4 {
 					/* refclk4 for PS-GT, used for PCIE slot */
 					reg = <4>;
-					always-on;
 				};
 				si5341_5: out@5 {
 					/* refclk5 for PS-GT, used for PCIE */
 					reg = <5>;
-					always-on;
 				};
 				si5341_6: out@6 {
 					/* refclk6 PL CLK125 */
 					reg = <6>;
-					always-on;
 				};
 				si5341_7: out@7 {
 					/* refclk7 PL CLK74 */
 					reg = <7>;
-					always-on;
 				};
 				si5341_9: out@9 {
 					/* refclk9 used for PS_REF_CLK 33.3 MHz */
 					reg = <9>;
-					always-on;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index cd132abf6e00..f450fad0edf8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -551,32 +551,26 @@ si5341: clock-generator@36 { /* SI5341 - u69 */
 				si5341_0: out@0 {
 					/* refclk0 for PS-GT, used for DP */
 					reg = <0>;
-					always-on;
 				};
 				si5341_2: out@2 {
 					/* refclk2 for PS-GT, used for USB3 */
 					reg = <2>;
-					always-on;
 				};
 				si5341_3: out@3 {
 					/* refclk3 for PS-GT, used for SATA */
 					reg = <3>;
-					always-on;
 				};
 				si5341_6: out@6 {
 					/* refclk6 PL CLK125 */
 					reg = <6>;
-					always-on;
 				};
 				si5341_7: out@7 {
 					/* refclk7 PL CLK74 */
 					reg = <7>;
-					always-on;
 				};
 				si5341_9: out@9 {
 					/* refclk9 used for PS_REF_CLK 33.3 MHz */
 					reg = <9>;
-					always-on;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 428b5558fbba..b4768f615182 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -439,32 +439,26 @@ si5341: clock-generator@36 { /* SI5341 - u46 */
 				si5341_0: out@0 {
 					/* refclk0 for PS-GT, used for DP */
 					reg = <0>;
-					always-on;
 				};
 				si5341_2: out@2 {
 					/* refclk2 for PS-GT, used for USB3 */
 					reg = <2>;
-					always-on;
 				};
 				si5341_3: out@3 {
 					/* refclk3 for PS-GT, used for SATA */
 					reg = <3>;
-					always-on;
 				};
 				si5341_5: out@5 {
 					/* refclk5 PL CLK100 */
 					reg = <5>;
-					always-on;
 				};
 				si5341_6: out@6 {
 					/* refclk6 PL CLK125 */
 					reg = <6>;
-					always-on;
 				};
 				si5341_9: out@9 {
 					/* refclk9 used for PS_REF_CLK 33.3 MHz */
 					reg = <9>;
-					always-on;
 				};
 			};
 		};
-- 
2.50.1


