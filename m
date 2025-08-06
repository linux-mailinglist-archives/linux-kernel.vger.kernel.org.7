Return-Path: <linux-kernel+bounces-758390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 410CFB1CE61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5398626DC4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B80E2264CC;
	Wed,  6 Aug 2025 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOP8XvGJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176619A;
	Wed,  6 Aug 2025 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515659; cv=none; b=qYlt0d6nbL8YexsqOjNJxdEG5cOZfa3VN6iASUAQr4VEpi9G2dLwGiEsHzcam7DdlyWia/pR3YUDzfgLeTqNCUTSjewzJnO7sL/RmjaWUK60ctfgUUF689GKYd5de/wvO/h3aJTnobpEw77VC27UrkXSOCXFt5k1VUTWD7DeDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515659; c=relaxed/simple;
	bh=08Wxxhicy7RjPrvuW2a5F8Vbn8jGqmaOXzdFx3JaNKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQYCxnVp77soX4cR0k301Rgj3y9tTUF6k/+2S464xMhWziEUyp5uDCcyVWF4h0Jrl748hMneV5Wf2/KTx/hqgtlCpXXSEvzGvtN1gfJfNe0BH6Hbs7baXNJK7dJT8G8Ps0xiCuE7EUFcHBHUcf9VLKeQPcG4FOPJQ418cHXSktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOP8XvGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BC2C4CEE7;
	Wed,  6 Aug 2025 21:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754515657;
	bh=08Wxxhicy7RjPrvuW2a5F8Vbn8jGqmaOXzdFx3JaNKM=;
	h=From:To:Cc:Subject:Date:From;
	b=EOP8XvGJv/3MRyOlEwTZgRFVggBWWEFcZE3hm4PYrEmvD/S28/i1Td1hBtJXDSMHg
	 +kjhY8eVu1lDQrOuKsVeMD/CPaAZ7AgDHcFcfc9ejXvI12EosxGo4eVzJR6vBOE8tR
	 wRr1PPMbYVjVwK5kJF6D+I9/MCDh9cnke/r/sf+RQ+GQrotLRsxxVSAFugxAuVJNX0
	 2I8s6QITnJM9Ray0HE8xrwvHB7y8SYIQlOP8R1uGbtAFWixkRGk+9OYov3RgWX20bt
	 0lFAZrlQ5ijLCz0mzfFcaN0PQCrcR/rjIioTDHs3bsRGzNTqPynKRVB1hD6nMgdQGx
	 r+MCaRWkn3Y2w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Convert marvell,berlin to DT schema
Date: Wed,  6 Aug 2025 16:27:32 -0500
Message-ID: <20250806212733.1633662-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/arm/marvell,berlin.yaml          | 45 ++++++++++
 .../devicetree/bindings/arm/syna.txt          | 89 -------------------
 2 files changed, 45 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell,berlin.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/syna.txt

diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.yaml b/Documentation/devicetree/bindings/arm/marvell,berlin.yaml
new file mode 100644
index 000000000000..4e8442980dcb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell,berlin.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell,berlin.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synaptics/Marvell Berlin SoC
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+description:
+  According to https://www.synaptics.com/company/news/conexant-marvell
+  Synaptics has acquired the Multimedia Solutions Business of Marvell, so
+  Berlin SoCs are now Synaptics' SoCs.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sony,nsz-gs7
+          - const: marvell,berlin2
+          - const: marvell,berlin
+      - items:
+          - enum:
+              - google,chromecast
+              - valve,steamlink
+          - const: marvell,berlin2cd
+          - const: marvell,berlin
+      - items:
+          - enum:
+              - marvell,berlin2q-dmp
+          - const: marvell,berlin2q
+          - const: marvell,berlin
+      - items:
+          - enum:
+              - marvell,berlin4ct-dmp
+              - marvell,berlin4ct-stb
+          - const: marvell,berlin4ct
+          - const: marvell,berlin
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
deleted file mode 100644
index f53c430f648c..000000000000
--- a/Documentation/devicetree/bindings/arm/syna.txt
+++ /dev/null
@@ -1,89 +0,0 @@
-Synaptics SoC Device Tree Bindings
-
-According to https://www.synaptics.com/company/news/conexant-marvell
-Synaptics has acquired the Multimedia Solutions Business of Marvell, so
-berlin SoCs are now Synaptics' SoCs now.
-
----------------------------------------------------------------
-
-Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
-shall have the following properties:
-
-* Required root node properties:
-compatible: must contain "marvell,berlin"
-
-In addition, the above compatible shall be extended with the specific
-SoC and board used. Currently known SoC compatibles are:
-    "marvell,berlin2"      for Marvell Armada 1500 (BG2, 88DE3100),
-    "marvell,berlin2cd"    for Marvell Armada 1500-mini (BG2CD, 88DE3005)
-    "marvell,berlin2ct"    for Marvell Armada ? (BG2CT, 88DE????)
-    "marvell,berlin2q"     for Marvell Armada 1500-pro (BG2Q, 88DE3114)
-    "marvell,berlin3"      for Marvell Armada ? (BG3, 88DE????)
-
-* Example:
-
-/ {
-	model = "Sony NSZ-GS7";
-	compatible = "sony,nsz-gs7", "marvell,berlin2", "marvell,berlin";
-
-	...
-}
-
-* Marvell Berlin CPU control bindings
-
-CPU control register allows various operations on CPUs, like resetting them
-independently.
-
-Required properties:
-- compatible: should be "marvell,berlin-cpu-ctrl"
-- reg: address and length of the register set
-
-Example:
-
-cpu-ctrl@f7dd0000 {
-	compatible = "marvell,berlin-cpu-ctrl";
-	reg = <0xf7dd0000 0x10000>;
-};
-
-* Marvell Berlin2 chip control binding
-
-Marvell Berlin SoCs have a chip control register set providing several
-individual registers dealing with pinmux, padmux, clock, reset, and secondary
-CPU boot address. Unfortunately, the individual registers are spread among the
-chip control registers, so there should be a single DT node only providing the
-different functions which are described below.
-
-Required properties:
-- compatible:
-	* the first and second values must be:
-		"simple-mfd", "syscon"
-- reg: address and length of following register sets for
-  BG2/BG2CD: chip control register set
-  BG2Q: chip control register set and cpu pll registers
-
-* Marvell Berlin2 system control binding
-
-Marvell Berlin SoCs have a system control register set providing several
-individual registers dealing with pinmux, padmux, and reset.
-
-Required properties:
-- compatible:
-	* the first and second values must be:
-		"simple-mfd", "syscon"
-- reg: address and length of the system control register set
-
-Example:
-
-chip: chip-control@ea0000 {
-	compatible = "simple-mfd", "syscon";
-	reg = <0xea0000 0x400>;
-
-	/* sub-device nodes */
-};
-
-sysctrl: system-controller@d000 {
-	compatible = "simple-mfd", "syscon";
-	reg = <0xd000 0x100>;
-
-	/* sub-device nodes */
-};
-- 
2.47.2


