Return-Path: <linux-kernel+bounces-876671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4567C1BFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E6D188592C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7864433F38C;
	Wed, 29 Oct 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA2O1tJp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B520F283FC3;
	Wed, 29 Oct 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754301; cv=none; b=clan4dQkNVQZkbo9RXblvQq0dZ6QvrxLBc9wrCGP32v4wtaX1By5JQkAYR/BwVErScGvJfjrzIqyXRfyOzxk6ZCsgJV/2oSglq58NliUhFC61JmuF1DZdl+nbobZFWgL3OO2gsQN0Rp7GF2eJS0909xIwzUEAB3lCPRV1omFvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754301; c=relaxed/simple;
	bh=4kdgWfgvg7oJNRXLjBlOXle1kvB7aBe2YNXbD+Y8Wc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ2830+4hfG7WWfovn4tOsg3Mul/6aIPW7iZZBsZfBJdQ/VLfsFjfmQBaEedX90FxXSSK0Drx+k8sgd5yejYmxMbT5/fvHkNHczutmMsk0+eXYGVIihLug1C4cLCYGraIBTllTWfb6pp6zYu7U5eCzoZIwulk8/LEzAR11oJWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fA2O1tJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E642C116B1;
	Wed, 29 Oct 2025 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761754301;
	bh=4kdgWfgvg7oJNRXLjBlOXle1kvB7aBe2YNXbD+Y8Wc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fA2O1tJpjhyVcByXd5DncoIYTApookFFqCDKIZGPVqRjefyNz4lrk7Rn+AF3Lk5VR
	 9NoEKm4rKP6AztvLlrZPxedFaP/t8UHp5gfE/Qw9OPlqvqCSOvHyeAObXn18N5ACZp
	 vFl0KHqwQ/xKYOpYSIGpuTbLDxguUuuWMXYsfjWynbaw3+oyqT9OugWoI3aDfOfhDd
	 JQSKj8Qwd6dJTn8mjf2vmtvL7p5mRPEe7jr9C/AVmiimIRwiCkGXbkzU4qeFRCVnoR
	 77pbvRmEk9yQfbK63TTqZqUDqJrQ0q1Q3MK2lTUkHFqiGyowEnPoZ2F59LR842+qpK
	 xSNokMN91RH9A==
From: Conor Dooley <conor@kernel.org>
To: claudiu.beznea@tuxon.dev
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/7] dt-bindings: clk: microchip: mpfs: remove first reg region
Date: Wed, 29 Oct 2025 16:11:18 +0000
Message-ID: <20251029-unwatched-family-e47cb29ea815@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
References: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3159; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=3LZvSpbfmHa0zvD2pQSWl0P8VI7zypG9G9PgJJXjfzU=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlMNuvyX8YrL94jPHv+yWCr81IVlppiJ7tZn344oM587 8Oza/m1HaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiI0HOG/5X5vVL37hzODdGf YG7z0qlfe86G+Vym82wVl3PESe/a/Y/hf9bsWT1XuxveGhf63J14a9tP+/U7G579TWr89v3XnZ2 +C3kA
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
index e4e1c31267d2..ee4f31596d97 100644
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
2.51.0


