Return-Path: <linux-kernel+bounces-758278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6A2B1CD2A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2CE47B3510
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEDE2BCF75;
	Wed,  6 Aug 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuF/qgy7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D51F4CB7;
	Wed,  6 Aug 2025 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510513; cv=none; b=RtkeT4kJIRyW292ycqBUzPffjq7RG2Hd/7xqdYGgvBsK6rYG6XtwH5f/mwfSVR+qfP1d09LFULR8eWbSZB94oygI8Qkt/cpa38E2WNCR6KbukE8ERS77OHbxWceNgwWhbKmJK/nBbUJWdO1CB3ebz4afYjB7OjCKbMnfZtARniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510513; c=relaxed/simple;
	bh=ENuhQnWSBLUUvO045kXVHvexc+1xjK+dZXnhyBbllu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axWSih+KQ0yoarDgXEd+QCmX4b3glEbCA8sQ6/U8bmvGfYkx/rTq/zisfTOBIbtO0yd2pNktON+6LQD69dqTTA6Kz/tXDkKnDQEk/MNv1YtuXk0wB4Ol0bdF1oT0c0olPft1avGMSDfYEn1GqNO5tBvS8Vu68ZCqo6ufaV7GVc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuF/qgy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43537C4CEE7;
	Wed,  6 Aug 2025 20:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754510512;
	bh=ENuhQnWSBLUUvO045kXVHvexc+1xjK+dZXnhyBbllu0=;
	h=From:To:Cc:Subject:Date:From;
	b=RuF/qgy79ZAcqA3EvIwTtm8CJbW1KeU0eGbyAHeCfztqsZ2OU/zVIeGldN/QX/2KF
	 jRsF97QjqSAIIUOb40ZvAHnIbVCMdHLrSuhTG6S7M6CYBvUhD8y0kZr/NyrNUvR/+H
	 OHjv7CAKdjIujhUgyqgB2Btyfm3yxogNytbwBxmF7ntIt9BSPL5/CuFQ96Po5AYMMZ
	 KflyaztP5HxKEiKAioCz0s03Jf1eHoq7gQm29UcaUIk7aZrKdAYfpRERXk6zPfEk8W
	 wC8zyjXiPS0ihkPdktn9IqBk8RINnuGxnDMT3BQa9nrAYGzHILY1uXLFLmnXmx47Hw
	 nr6eMvhXuebmQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: marvell,comphy-cp110: Fix clock and child node constraints
Date: Wed,  6 Aug 2025 15:01:37 -0500
Message-ID: <20250806200138.1366189-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In converting marvell,comphy-cp110 to schema, the constraints for clocks on
marvell,comphy-a3700 are wrong, the maximum number of child nodes are wrong,
and the phy nodes may have a 'connector' child node:

phy@18300 (marvell,comphy-a3700): clock-names: False schema does not allow ['xtal']
phy@120000 (marvell,comphy-cp110): 'phy@3', 'phy@4', 'phy@5' do not match any of the regexes: '^phy@[0-2]$', '^pinctrl-[0-9]+$'
phy@120000 (marvell,comphy-cp110): phy@2: 'connector' does not match any of the regexes: '^pinctrl-[0-9]+$'

Fixes: 50355ac70d4f ("dt-bindings: phy: Convert marvell,comphy-cp110 to DT schema")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/phy/marvell,comphy-cp110.yaml    | 29 ++++++++++++++-----
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/marvell,comphy-cp110.yaml b/Documentation/devicetree/bindings/phy/marvell,comphy-cp110.yaml
index d9501df42886..c35d31642805 100644
--- a/Documentation/devicetree/bindings/phy/marvell,comphy-cp110.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,comphy-cp110.yaml
@@ -47,21 +47,19 @@ properties:
     const: 0
 
   clocks:
+    minItems: 1
     maxItems: 3
-    description: Reference clocks for CP110; MG clock, MG Core clock, AXI clock
 
   clock-names:
-    items:
-      - const: mg_clk
-      - const: mg_core_clk
-      - const: axi_clk
+    minItems: 1
+    maxItems: 3
 
   marvell,system-controller:
     description: Phandle to the Marvell system controller (CP110 only)
     $ref: /schemas/types.yaml#/definitions/phandle
 
 patternProperties:
-  '^phy@[0-2]$':
+  '^phy@[0-5]$':
     description: A COMPHY lane child node
     type: object
     additionalProperties: false
@@ -69,10 +67,14 @@ patternProperties:
     properties:
       reg:
         description: COMPHY lane number
+        maximum: 5
 
       '#phy-cells':
         const: 1
 
+      connector:
+        type: object
+
     required:
       - reg
       - '#phy-cells'
@@ -91,13 +93,24 @@ allOf:
 
     then:
       properties:
-        clocks: false
-        clock-names: false
+        clocks:
+          maxItems: 1
+        clock-names:
+          const: xtal
 
       required:
         - reg-names
 
     else:
+      properties:
+        clocks:
+          minItems: 3
+        clock-names:
+          items:
+            - const: mg_clk
+            - const: mg_core_clk
+            - const: axi_clk
+
       required:
         - marvell,system-controller
 
-- 
2.47.2


