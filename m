Return-Path: <linux-kernel+bounces-794382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C04B3E0E9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B6284E25DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951183128AF;
	Mon,  1 Sep 2025 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efgIlOcA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B831159A;
	Mon,  1 Sep 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724718; cv=none; b=KeegR+pcV9iLxdv++YozCyWJavLr1G7J7BWUf44piTxk0EevXMkFHwtxI4CS0eTeY6bkrj3UwcYPTOvYOyg8tc6aHyW/ybcslGZR4QnWTKZeW0kC+sxlKNYTE3D7KAuPDzwdGy4uJYbBR1Xz9xvBUS9RJZUq1GVTuRfJP40+EAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724718; c=relaxed/simple;
	bh=fQK9+TNjOMxzSGZmUzRv58YbqcykvxbEivMK+1aMTn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdxHhMQebVeA8Mjb7moEdE6tjnnW1KucF9pgHj2Gwtkg+XHiv1VHpTxlc5LVtEMk2FjGov/Br5w0PhdGahFTavAwAyKzyHhY3TX9MwGnUkVZ5xa8jEupcGWavM3WT8GXmuHypkFtt1uUil7al3CoEdlyyPaJKq9ufDD1d9lS0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efgIlOcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8F0C4CEF4;
	Mon,  1 Sep 2025 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756724715;
	bh=fQK9+TNjOMxzSGZmUzRv58YbqcykvxbEivMK+1aMTn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=efgIlOcAI2kQOApbNt+qj1Jyf/++Vs+a1C1c4TpD/3JwgkW0e66UnxmhtmkW4Xv4r
	 8Cy+aBiWGg3flujNmmEJmFSw+VaAyvI1jNH5xT61K3+rJ0s7n/mthq+4V1yziulHpV
	 G3gwbhhlLdVS/39WRhOWcDIFdm6hBUqEPeYnmlHkPgUY7h+ocqHaf7WHNhOisf83rM
	 EUVqMf26lYscHxGuUYpm1tLXDcPHADNam7KBHmdJfRvMYAPDLSq8ypvtUEpapWiGoD
	 KUdrXBHEdXsdDdb5Qs5jaWgtszZyYJpbiNWqwg4FPrVHGMboidxybGP8Ls97ayZW1d
	 t7Q2KPVcINQyQ==
From: Conor Dooley <conor@kernel.org>
To: sboyd@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
Subject: [PATCH v4 5/9] dt-bindings: clk: microchip: mpfs: remove first reg region
Date: Mon,  1 Sep 2025 12:04:17 +0100
Message-ID: <20250901-properly-banister-ccf27886c8e6@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901-rigid-sacrifice-0039c6e6234e@spud>
References: <20250901-rigid-sacrifice-0039c6e6234e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3161; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=TTW8V6IURt0fNsC7kk6IUVDimqCXtE9Vfhk8Glza/xk=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlba9ex+L08wxr2YGfkncVTAi0qzyT//jbp7zfmvZ/uJ 0zW+mjW0VHKwiDGxSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJ1H9mZNi9/5B1//PXk7Tn zmqqmaESb1zmYs0147OXsks07/p8vycM/8ylMv7O/VL/vdvNd3PGkY5Tm2a6VMgc0px1t1lGhbN pMRMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The first reg region in this binding is not exclusively for clocks, as
evidenced by the dual role of this device as a reset controller at
present. The first region is however better described by a simple-mfd
syscon, but this would have require a significant re-write of the
devicetree for the platform, so the easy way out was chosen when reset
support was first introduced. The region doesn't just contain clock and
reset registers, it also contains pinctrl and interrupt controller
functionality, so drop the region from the clock binding so that it can
be described instead by a simple-mfd syscon rather than propagate this
incorrect description of the hardware to the new pic64gx SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/clock/microchip,mpfs-clkcfg.yaml | 36 +++++++++++--------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
index e4e1c31267d2a..ee4f31596d978 100644
--- a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
+++ b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
@@ -22,16 +22,23 @@ properties:
     const: microchip,mpfs-clkcfg
 
   reg:
-    items:
-      - description: |
-          clock config registers:
-          These registers contain enable, reset & divider tables for the, cpu,
-          axi, ahb and rtc/mtimer reference clocks as well as enable and reset
-          for the peripheral clocks.
-      - description: |
-          mss pll dri registers:
-          Block of registers responsible for dynamic reconfiguration of the mss
-          pll
+    oneOf:
+      - items:
+          - description: |
+              clock config registers:
+              These registers contain enable, reset & divider tables for the, cpu,
+              axi, ahb and rtc/mtimer reference clocks as well as enable and reset
+              for the peripheral clocks.
+          - description: |
+              mss pll dri registers:
+              Block of registers responsible for dynamic reconfiguration of the mss
+              pll
+        deprecated: true
+      - items:
+          - description: |
+              mss pll dri registers:
+              Block of registers responsible for dynamic reconfiguration of the mss
+              pll
 
   clocks:
     maxItems: 1
@@ -69,11 +76,12 @@ examples:
   - |
     #include <dt-bindings/clock/microchip,mpfs-clock.h>
     soc {
-            #address-cells = <2>;
-            #size-cells = <2>;
-            clkcfg: clock-controller@20002000 {
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            clkcfg: clock-controller@3E001000 {
                 compatible = "microchip,mpfs-clkcfg";
-                reg = <0x0 0x20002000 0x0 0x1000>, <0x0 0x3E001000 0x0 0x1000>;
+                reg = <0x3E001000 0x1000>;
                 clocks = <&ref>;
                 #clock-cells = <1>;
         };
-- 
2.47.2


