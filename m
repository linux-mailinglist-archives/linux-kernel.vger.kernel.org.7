Return-Path: <linux-kernel+bounces-839377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099CCBB1824
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A7E175B2C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BCA2D59FA;
	Wed,  1 Oct 2025 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="Bus2fud+"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B442D3A86;
	Wed,  1 Oct 2025 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343743; cv=pass; b=deKC9AgTuTludLkan0i1RXPZrUjfnBRSAOsyvk4uYLuaVye7Yh1m3WzujqmVerOHMub3UFqTjJzmT49/8+wFh+UUnL9tae3o65UWn51f+XO2+cAygg6jHiIJQj7R5s2lAzn09GaSnaDCmrQW4EP4C4UQaGvjo8mzsj7cVxwimSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343743; c=relaxed/simple;
	bh=cPkgOhY3OViY8Eh82gk3+c/8Fz+KXpaf5MpYzxqGKLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfKkGEjT3R8CRLRybTzpqX+xhqw7Rsudc7bEJUkFJCYvcXW9NmZuEOGCRWL4MkbY+sO6QilzZFjzrTzrMeGS8t8yJPvvssuOUi4TX6tJPDjYNlSlDLtMqHqk+31UHriW2hm6zaBjFW51P0ii9+rY1nK6pwEea/c6F0ZlJWeWI60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=Bus2fud+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759343728; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GO4M1NUWW6TWSbDNpVVaR40eptHIMXCdh2YjC997tWUHghEYAviXb7B2JKiHPx6ak2zqbvcohnzvplGJ0yiSZHZ5PiNeTAqXhZ74jQM4eiuy8ET7BrITFys0Mw3euZHo721CFIwsHdO5OdF3WiVHzIsf6aIx5jOZDyyW+kgLg1s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759343728; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Eih+Gvrl/V/M1VLTYZoN9wZ1OWt0+vDKt9t9071sjq8=; 
	b=HxL6LvSjBZX0g6EJdxuatweoVCdWVSedspO8pUQ0LceXTUsGP2xbBOpWIwTxNFt3dR7t3c60oQ/qVfHc955QgrNAJnJ7yBuu/ppOc9Zoxc1OvJR2h58LhFp5pRxZJf2A8eQsLr8EguO4SCxvwd6FN8z80LERLbeFK/H7uzyRv+0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759343728;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Eih+Gvrl/V/M1VLTYZoN9wZ1OWt0+vDKt9t9071sjq8=;
	b=Bus2fud+WrXA21LkdBDB7ozBil6sVjRukemB2tKN9DqEPvcIj4itNHtZuQYhDxpy
	E2AnanCOAQzgGPBM2OGiSOUh2voGxTwx2Ti521mKjUQ6Dde3GKUxorirWs7TqkqTIkk
	DUgWf5zeUMJpbH0VWTOwgcR9DHPrh2bECZGCOOHA=
Received: by mx.zohomail.com with SMTPS id 175934372619585.09151494021478;
	Wed, 1 Oct 2025 11:35:26 -0700 (PDT)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: angelogioacchino.delregno@collabora.com,
	ariel.dalessandro@collabora.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	lgirdwood@gmail.com,
	matthias.bgg@gmail.com,
	robh@kernel.org
Cc: devicetree@vger.kernel.org,
	kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v3] dt-bindings: ASoC: Convert MediaTek RT5650 codecs bindings to DT schema
Date: Wed,  1 Oct 2025 15:35:17 -0300
Message-ID: <20251001183517.83278-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Convert the existing text-based DT bindings for Mediatek MT8173 RT5650
codecs to a DT schema.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../sound/mediatek,mt8173-rt5650.yaml         | 73 +++++++++++++++++++
 .../bindings/sound/mt8173-rt5650.txt          | 31 --------
 2 files changed, 73 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8173-rt5650.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/mt8173-rt5650.txt

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8173-rt5650.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8173-rt5650.yaml
new file mode 100644
index 0000000000000..a3166cc40a206
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8173-rt5650.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt8173-rt5650.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT8173 with RT5650 codecs and HDMI via I2S
+
+maintainers:
+  - Ariel D'Alessandro <ariel.dalessandro@collabora.com>
+
+properties:
+  compatible:
+    const: mediatek,mt8173-rt5650
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  mediatek,audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      The phandles of rt5650 codecs and of the HDMI encoder node.
+    minItems: 2
+
+  mediatek,platform:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle of MT8173 ASoC platform.
+
+  mediatek,mclk:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The MCLK source.
+      0: external oscillator, MCLK = 12.288M
+      1: internal source from mt8173, MCLK = sampling rate * 256
+
+  codec-capture:
+    description: Subnode of rt5650 codec capture.
+    type: object
+
+    properties:
+      sound-dai:
+        maxItems: 1
+        description: phandle of the CPU DAI
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - mediatek,audio-codec
+  - mediatek,platform
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "mediatek,mt8173-rt5650";
+        mediatek,audio-codec = <&rt5650 &hdmi0>;
+        mediatek,platform = <&afe>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&aud_i2s2>;
+
+        mediatek,mclk = <1>;
+        codec-capture {
+            sound-dai = <&rt5650 1>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
deleted file mode 100644
index 29dce2ac8773a..0000000000000
--- a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-MT8173 with RT5650 CODECS and HDMI via I2S
-
-Required properties:
-- compatible : "mediatek,mt8173-rt5650"
-- mediatek,audio-codec: the phandles of rt5650 codecs
-                        and of the hdmi encoder node
-- mediatek,platform: the phandle of MT8173 ASoC platform
-
-Optional subnodes:
-- codec-capture : the subnode of rt5650 codec capture
-Required codec-capture subnode properties:
-- sound-dai: audio codec dai name on capture path
-  <&rt5650 0> : Default setting. Connect rt5650 I2S1 for capture. (dai_name = rt5645-aif1)
-  <&rt5650 1> : Connect rt5650 I2S2 for capture. (dai_name = rt5645-aif2)
-
-- mediatek,mclk: the MCLK source
-  0 : external oscillator, MCLK = 12.288M
-  1 : internal source from mt8173, MCLK = sampling rate*256
-
-Example:
-
-	sound {
-		compatible = "mediatek,mt8173-rt5650";
-		mediatek,audio-codec = <&rt5650 &hdmi0>;
-		mediatek,platform = <&afe>;
-		mediatek,mclk = <0>;
-		codec-capture {
-			sound-dai = <&rt5650 1>;
-		};
-	};
-
-- 
2.51.0


