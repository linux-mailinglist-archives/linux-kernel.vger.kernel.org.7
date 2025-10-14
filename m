Return-Path: <linux-kernel+bounces-852993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77285BDA76A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2D27546119
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30422303A02;
	Tue, 14 Oct 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui+5zuIW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8833009CA;
	Tue, 14 Oct 2025 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455784; cv=none; b=kSC6JEr+GQ6FuMXklLoiOKDyhvIoB+vYEKlLUxTUKoRjVeywwXq7eYxFfzfCqv+WTT0CHYgIQER2O/wqK3WUPJOHPgU3KDVjAMryhnmXpoJPAkcTg1uyJb390f+SaHVMd5XUc74M5UT7nnkt9wlanlSR4ttKUaZIjSnST+99tjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455784; c=relaxed/simple;
	bh=BCLZnlFtfyfyqV95kvnr8DLzhbdzdFCeJdir6zX5uTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dN/EBU/2Id29XX6ksZbS2alp59ZJ77GhDPDYQkStcFXBdtLD2B8D6UaDEQuokN+X6PRS75FPER2XfNLN0LnVb0GKhSsAy2Avs5+1DuQ70ccaKyzoRaNcz4eTskCVHIY4A7oTJomJXHTDrQjEuozg12U2yWVbjhRKIF90TCRkhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui+5zuIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D838AC4CEE7;
	Tue, 14 Oct 2025 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760455784;
	bh=BCLZnlFtfyfyqV95kvnr8DLzhbdzdFCeJdir6zX5uTc=;
	h=From:To:Cc:Subject:Date:From;
	b=Ui+5zuIWnH9o2ODiPohYBuH53HAXcp05rYdTb2k/l4FZoTMYVTi/zn2mHtu4w/lxw
	 4DU9Ds3qR9LCrH7/YQhG3qZKpC0uS9r88ZG//Xe/U7h5UnivDsuLe8gDRQqdqSBC1b
	 KQzYtLhIYs3yF0eT9UYpeOySOWVQKuhQ99brGjB4ZuTiTUUO+DqSGvumpszs7kE5CV
	 uNGFXL7ivKgcEL+L7Z668sMoxp8Y9RHnwP5EVJcaN9vYxuvQC1GA6yKTpTuD/s/avo
	 0zWtljnka2dgEzaAkYjQ8wcfF2tOSt9fsYmE5RWHhLKm2YHMMNsTVBCFerys4sxb7v
	 1/o2JHyUIXgZw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Corey Minyard <corey@minyard.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: openbmc@lists.ozlabs.org,
	openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ipmi: Convert nuvoton,npcm750-kcs-bmc to DT schema
Date: Tue, 14 Oct 2025 10:29:34 -0500
Message-ID: <20251014152935.3782463-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the nuvoton,npcm750-kcs-bmc binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/ipmi/npcm7xx-kcs-bmc.txt         | 40 --------------
 .../ipmi/nuvoton,npcm750-kcs-bmc.yaml         | 55 +++++++++++++++++++
 2 files changed, 55 insertions(+), 40 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
 create mode 100644 Documentation/devicetree/bindings/ipmi/nuvoton,npcm750-kcs-bmc.yaml

diff --git a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
deleted file mode 100644
index 4fda76e63396..000000000000
--- a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-* Nuvoton NPCM KCS (Keyboard Controller Style) IPMI interface
-
-The Nuvoton SOCs (NPCM) are commonly used as BMCs
-(Baseboard Management Controllers) and the KCS interface can be
-used to perform in-band IPMI communication with their host.
-
-Required properties:
-- compatible : should be one of
-    "nuvoton,npcm750-kcs-bmc"
-    "nuvoton,npcm845-kcs-bmc", "nuvoton,npcm750-kcs-bmc"
-- interrupts : interrupt generated by the controller
-- kcs_chan : The KCS channel number in the controller
-
-Example:
-
-    lpc_kcs: lpc_kcs@f0007000 {
-        compatible = "nuvoton,npcm750-lpc-kcs", "simple-mfd", "syscon";
-        reg = <0xf0007000 0x40>;
-        reg-io-width = <1>;
-
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges = <0x0 0xf0007000 0x40>;
-
-        kcs1: kcs1@0 {
-            compatible = "nuvoton,npcm750-kcs-bmc";
-            reg = <0x0 0x40>;
-            interrupts = <0 9 4>;
-            kcs_chan = <1>;
-            status = "disabled";
-        };
-
-        kcs2: kcs2@0 {
-            compatible = "nuvoton,npcm750-kcs-bmc";
-            reg = <0x0 0x40>;
-            interrupts = <0 9 4>;
-            kcs_chan = <2>;
-            status = "disabled";
-        };
-    };
diff --git a/Documentation/devicetree/bindings/ipmi/nuvoton,npcm750-kcs-bmc.yaml b/Documentation/devicetree/bindings/ipmi/nuvoton,npcm750-kcs-bmc.yaml
new file mode 100644
index 000000000000..fc5df1c5e3bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/ipmi/nuvoton,npcm750-kcs-bmc.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ipmi/nuvoton,npcm750-kcs-bmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM KCS BMC
+
+maintainers:
+  - Avi Fishman <avifishman70@gmail.com>
+  - Tomer Maimon <tmaimon77@gmail.com>
+  - Tali Perry <tali.perry1@gmail.com>
+
+description:
+  The Nuvoton SOCs (NPCM) are commonly used as BMCs (Baseboard Management
+  Controllers) and the KCS interface can be used to perform in-band IPMI
+  communication with their host.
+
+properties:
+  compatible:
+    oneOf:
+      - const: nuvoton,npcm750-kcs-bmc
+      - items:
+          - enum:
+              - nuvoton,npcm845-kcs-bmc
+          - const: nuvoton,npcm750-kcs-bmc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  kcs_chan:
+    description: The KCS channel number in the controller
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - kcs_chan
+
+additionalProperties: false
+
+examples:
+  - |
+    kcs@0 {
+        compatible = "nuvoton,npcm750-kcs-bmc";
+        reg = <0x0 0x40>;
+        interrupts = <9 4>;
+        kcs_chan = <1>;
+    };
-- 
2.51.0


