Return-Path: <linux-kernel+bounces-851116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49821BD594B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9674A18A5DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53CA28E571;
	Mon, 13 Oct 2025 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqZ4NnGy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DAD299AAA;
	Mon, 13 Oct 2025 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377678; cv=none; b=KWfpc4VX1/gFEU725UMOH6dqSGxOCmTXRACqnNj+1vEutHpiRpcDtu8qrqzNFDpgZIB4NxLRSNeFvA3zHc4cIDO7aFtpJkaxfbZuNt2y1faCmKjkFzS5S8WefRp+B3EsyOlzEdALM4mxJxpG0om9rkDOVxq2Ir6p8Oe2b8JuOnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377678; c=relaxed/simple;
	bh=4kdgWfgvg7oJNRXLjBlOXle1kvB7aBe2YNXbD+Y8Wc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2U/t5Qqgf3h/UEk+fr87soVqsWn3XqzROEua+/5KCi2Sz1xhleZq01GymO40+qYAPTgzRTgxs0uM2CWFXSS8zI5rbiGn0uLp3XG4UXPH/9CXufZfUF7czuQzvSp8beTY1UqG46eD5edn17QRME2hZEmu/0FoirH8/mfe21pJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqZ4NnGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC26C19421;
	Mon, 13 Oct 2025 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377677;
	bh=4kdgWfgvg7oJNRXLjBlOXle1kvB7aBe2YNXbD+Y8Wc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqZ4NnGyMwYhSkM/nSuGxuHjq3fWTwzsRZxzEyVAUVhf9arf3dX/y6hC7v55UTF5/
	 8EsYK8utRcv2vv5zjNkr4kg1ityxzfF5eux69k3PptY0a2fk3jY1S+ZQ3dBjBSRde7
	 YDJSovrhifkZDI4fEmBh5GyamWrPownKJXbXkhbNn8J4AxVBCjzqrlGCilBtENHYR5
	 +/TNWXuqLE2t0FLbauoZ7X0qGej56BKtoLzHfb+u6Mkjdda/p8IUSpIUcGXMYSmVn0
	 Q2GPxgjBKbIM2CwH3aHN2Gz6UIHcW0/zFTEoUQ2jDPVO2aIAkr6eNX3vhtG6fLFZ97
	 irluD7npJEZXA==
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
Subject: [PATCH v5 4/9] dt-bindings: clk: microchip: mpfs: remove first reg region
Date: Mon, 13 Oct 2025 18:45:36 +0100
Message-ID: <20251013-spectacle-slacks-86d498db7d60@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013-album-bovine-faf9f5ebc5d4@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3159; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=3LZvSpbfmHa0zvD2pQSWl0P8VI7zypG9G9PgJJXjfzU=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlvrQ40OHiq/XJ44fGo0PM9q3nZyUUtCnWhFbYigYf0T 5ydo+TTUcrCIMbFICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIlsPc7wP8n12/yfjmH/LMvn X+Eyr7b7Gz/7RkbvB9PTE79E1OQaODL8r4h2/b99eXvC0RIbw+ffza/EtM/559PxxucvR9mmA0t 72AE=
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


