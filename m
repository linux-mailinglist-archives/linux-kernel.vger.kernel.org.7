Return-Path: <linux-kernel+bounces-837353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBC4BAC1E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B67483020
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F22F5473;
	Tue, 30 Sep 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5hpc5U6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE42F5301
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222015; cv=none; b=XP+L6FfLGl5/VvqVlSRHLHq3hVvN1JSREZ4S62S0Jk90Wm0uDrVWdunE0QjNuwoJuNb9F7qJSf+/5gU0dnuqe9Rg0ZUIaaqZOgEvlk0B/g/PTm5wJ63o3RNEDpfhPmHrb5buAO0JTWOyPbNoVgEP5C1GVnCtesWBmXzMqIiNCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222015; c=relaxed/simple;
	bh=qQyfE/HR1KEl42BgS27yYcLTdYp3wLZCK/9r2bpcFbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDRlR7pKw7YrTgbwx4sEyIjp+mgkvHIyNxTxUOvPKPyDFewS7wNy7PaHue9exfxXzwkrtPxEZv/ZxITh6fryeqQVkT4L2JUMtEI8dbGet8/hszFxWw9fL430JBwqRS0JcPFlFGa0C8p92/t1Gx6NT7UTlWtzfSnnvjEjQAlejm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5hpc5U6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso42627185e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222011; x=1759826811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQkyDL/UyU0AOlGBBg/p3sULFCOnQoFDn72vXxom41I=;
        b=S5hpc5U6O0yct39BcP3t3leeI0Aeuz7HMa3ZW7etinyUk3Bhn3NYAPB5cZkIaOGmjp
         bF4uEQSblpUM+N982VfxdTbI6XbmCVaYq+Yfzk8yKZ6YjVmnmVVQ3fxncfkQHNESX6Sx
         zQv2Fj6Yctkxo8wrTCmVcixqQeXvYxG6Dp3ow3aAJwLfeLlhJtr5Dx4MdZFmmFvZRylC
         DaaGxHn7zyT04eKl7/Kqowu0a2yWoCg0Il2g+l7JxACA0FRhFCJ2jFi/5TYRiCpM7Sjg
         by+INGPUg9oQoV+vv7cJd3h+W7SilpjPYRStcqXLr+/cO1E/ybx3ANlB8QovOiP0tZ9Z
         6sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222011; x=1759826811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQkyDL/UyU0AOlGBBg/p3sULFCOnQoFDn72vXxom41I=;
        b=QCZxMnR5PPKf+YrXA1TzO79UZx5mCk847XArzIHoKHpIU/dKmdIRcKVCEF6M3N8LmB
         BfONbwwhkKm67hjIGBF21iGdsiiUU0Kr5gJ1S/bZJWMtgJmylDfTfS1cimcX96b/u1KC
         Oz16VYNm1HkAi6jgWDiZ5D/FiopU0s4cUF28yerRmaIXq+m0aKIh6HCcanmDtI8z9AcQ
         arVXEhjjaLKZBwyBv4eGXaDDWCqicQRh90plZBwQg4VSy6KTttapBFt9Mtl5BAf6sa6h
         UWpN50FTYDtIFzTfUYG5LOK+irLqc38QjfygB4Y+vRyAAHWHxAgkboWyb+N8HZusg+xZ
         XSJg==
X-Gm-Message-State: AOJu0Yw8gJuIm76HGUY8lv/PY/uFAh4o8lJR9CgON1Uu6tlWLfU7Msxe
	dP3UX7gHhaR5QmLhbhnrSJUoE6RvxEYdLYKE6dn4MbDWXii2e9TdqaG9
X-Gm-Gg: ASbGncscmTjRlL3gVPbADahsBjR6kxFJXcRXOMXdnyoJ4yC8ml69VId0m5TufzxpAYB
	hZMYMSNwjUE5iOFENa36xOM5oiOhnSAOlw2Vy303UCyNFb5kYpe2wujzFoeGSGQuD4GCQGX60Nx
	DGHm1c7oIvPr5YUaTMyf5esAFGE6TypFBGNY+BhZMXWzxmyZfWMRPryP/4HAEZSk0AYA/bIkgDg
	hNGGe+NxIf6OLgt9pz2Mv9OFB2w7A2I0l4EYTiZLllnqubOR2Rnr9/4TNTFJJlRB8sNFZyhmqvd
	dNveh9dzAQ9kmCJa9cdi2Qvlwc4OloifyrsKrye2UQbI02C2/Ae95CgIuEQklagvm28FAGLcKGB
	BZnPf042qKKetiQ2RnPoAwhbg50mtRe+ZbzA5S/cFbu89+06BKfOa94Neie91M0e9QGZSXH+Q2g
	61byw9k4di/vmq9Jd7PDuQvd+xIbVWkK14wIc2Zzsm
X-Google-Smtp-Source: AGHT+IHUW0KY2FKWo8nrRUZMd7SAgnbVpiI5ywcibvVT2PdmAhNIG/bS07n3xK/3WjGB++9DpjRJUA==
X-Received: by 2002:a05:6000:2484:b0:3f1:2671:6d9e with SMTP id ffacd0b85a97d-40e497c346fmr16640937f8f.1.1759222011362;
        Tue, 30 Sep 2025 01:46:51 -0700 (PDT)
Received: from localhost (2a02-8440-7149-a758-f461-9bc4-1c75-ebc1.rev.sfr.net. [2a02:8440:7149:a758:f461:9bc4:1c75:ebc1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb2fcsm23116418f8f.22.2025.09.30.01.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:46:51 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 30 Sep 2025 10:46:44 +0200
Subject: [PATCH v8 1/7] dt-bindings: memory: factorise LPDDR props into
 SDRAM props
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-b4-ddr-bindings-v8-1-fe4d8c015a50@gmail.com>
References: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
In-Reply-To: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

LPDDR and DDR bindings are SDRAM types and are likely to share the same
properties (at least for density, io-width and reg).
To avoid bindings duplication, factorise the properties.

The compatible description has been updated because the MR (Mode
registers) used to get manufacturer ID and revision ID are not present
in case of DDR.
Those information should be in a SPD (Serial Presence Detect) EEPROM in
case of DIMM module or are known in case of soldered memory chips as
they are in the datasheet of the memory chips.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 .../memory-controllers/ddr/jedec,lpddr-props.yaml  | 74 -----------------
 .../memory-controllers/ddr/jedec,lpddr2.yaml       |  2 +-
 .../memory-controllers/ddr/jedec,lpddr3.yaml       |  2 +-
 .../memory-controllers/ddr/jedec,lpddr4.yaml       |  2 +-
 .../memory-controllers/ddr/jedec,lpddr5.yaml       |  2 +-
 .../memory-controllers/ddr/jedec,sdram-props.yaml  | 94 ++++++++++++++++++++++
 6 files changed, 98 insertions(+), 78 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
deleted file mode 100644
index 30267ce70124..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
+++ /dev/null
@@ -1,74 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr-props.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Common properties for LPDDR types
-
-description:
-  Different LPDDR types generally use the same properties and only differ in the
-  range of legal values for each. This file defines the common parts that can be
-  reused for each type. Nodes using this schema should generally be nested under
-  an LPDDR channel node.
-
-maintainers:
-  - Krzysztof Kozlowski <krzk@kernel.org>
-
-properties:
-  compatible:
-    description:
-      Compatible strings can be either explicit vendor names and part numbers
-      (e.g. elpida,ECB240ABACN), or generated strings of the form
-      lpddrX-YY,ZZZZ where X is the LPDDR version, YY is the manufacturer ID
-      (from MR5) and ZZZZ is the revision ID (from MR6 and MR7). Both IDs are
-      formatted in lower case hexadecimal representation with leading zeroes.
-      The latter form can be useful when LPDDR nodes are created at runtime by
-      boot firmware that doesn't have access to static part number information.
-
-  reg:
-    description:
-      The rank number of this LPDDR rank when used as a subnode to an LPDDR
-      channel.
-    minimum: 0
-    maximum: 3
-
-  revision-id:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-    description:
-      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
-    maxItems: 2
-    items:
-      minimum: 0
-      maximum: 255
-
-  density:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description:
-      Density in megabits of SDRAM chip. Decoded from Mode Register 8.
-    enum:
-      - 64
-      - 128
-      - 256
-      - 512
-      - 1024
-      - 2048
-      - 3072
-      - 4096
-      - 6144
-      - 8192
-      - 12288
-      - 16384
-      - 24576
-      - 32768
-
-  io-width:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description:
-      IO bus width in bits of SDRAM chip. Decoded from Mode Register 8.
-    enum:
-      - 8
-      - 16
-      - 32
-
-additionalProperties: true
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
index a237bc259273..704bbc562528 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 allOf:
-  - $ref: jedec,lpddr-props.yaml#
+  - $ref: jedec,sdram-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index e328a1195ba6..0d28df3d2bfa 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 allOf:
-  - $ref: jedec,lpddr-props.yaml#
+  - $ref: jedec,sdram-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
index a078892fecee..65aa07861453 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 allOf:
-  - $ref: jedec,lpddr-props.yaml#
+  - $ref: jedec,sdram-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
index e441dac5f154..cf5d5a8e94b3 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 allOf:
-  - $ref: jedec,lpddr-props.yaml#
+  - $ref: jedec,sdram-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-props.yaml
new file mode 100644
index 000000000000..eb6f429e9eb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-props.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,sdram-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for SDRAM types
+
+description:
+  Different SDRAM types generally use the same properties and only differ in the
+  range of legal values for each. This file defines the common parts that can be
+  reused for each type. Nodes using this schema should generally be nested under
+  a SDRAM channel node.
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    description: |
+      Compatible strings can be either explicit vendor names and part numbers
+      (e.g. elpida,ECB240ABACN), or generated strings of the form
+      lpddrX-YY,ZZZZ or ddrX-YYYY,AAAA...,ZZ where X, Y, and Z are lowercase
+      hexadecimal with leading zeroes, and A is lowercase ASCII.
+      For LPDDR and DDR SDRAM, X is the SDRAM version (2, 3, 4, etc.).
+      For LPDDR SDRAM:
+        - YY is the manufacturer ID (from MR5), 1 byte
+        - ZZZZ is the revision ID (from MR6 and MR7), 2 bytes
+      For DDR4 SDRAM with SPD, according to JEDEC SPD4.1.2.L-6:
+        - YYYY is the manufacturer ID, 2 bytes, from bytes 320 and 321
+        - AAAA... is the part number, 20 bytes (20 chars) from bytes 329 to 348
+          without trailing spaces
+        - ZZ is the revision ID, 1 byte, from byte 349
+      The former form is useful when the SDRAM vendor and part number are
+      known, for example, when memory is soldered on the board. The latter
+      form is useful when SDRAM nodes are created at runtime by boot firmware
+      that doesn't have access to static part number information.
+
+  reg:
+    description:
+      The rank number of this memory rank when used as a subnode to an memory
+      channel.
+    minimum: 0
+    maximum: 3
+
+  revision-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      SDRAM revision ID:
+        - LPDDR SDRAM, decoded from Mode Registers 6 and 7, always 2 bytes.
+        - DDR4 SDRAM, decoded from the SPD from byte 349 according to
+          JEDEC SPD4.1.2.L-6, always 1 byte.
+      One byte per uint32 cell (e.g., <MR6 MR7>).
+    maxItems: 2
+    items:
+      minimum: 0
+      maximum: 255
+
+  density:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Density of the SDRAM chip in megabits:
+        - LPDDR SDRAM, decoded from Mode Register 8.
+        - DDR4 SDRAM, decoded from the SPD from bits 3-0 of byte 4 according to
+          JEDEC SPD4.1.2.L-6.
+    enum:
+      - 64
+      - 128
+      - 256
+      - 512
+      - 1024
+      - 2048
+      - 3072
+      - 4096
+      - 6144
+      - 8192
+      - 12288
+      - 16384
+      - 24576
+      - 32768
+
+  io-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      I/O bus width in bits of the SDRAM chip:
+        - LPDDR SDRAM, decoded from Mode Register 8.
+        - DDR4 SDRAM, decoded from the SPD from bits 2-0 of byte 12 according to
+          JEDEC SPD4.1.2.L-6.
+    enum:
+      - 8
+      - 16
+      - 32
+
+additionalProperties: true

-- 
2.43.0


