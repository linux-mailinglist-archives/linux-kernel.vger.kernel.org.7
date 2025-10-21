Return-Path: <linux-kernel+bounces-862315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31591BF4FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D146461863
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFC1280A29;
	Tue, 21 Oct 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="szKPQfOV"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AFD27FD5B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032074; cv=none; b=Ek8d0SYDmXdyywpl/wFpxW1KUJ76JHBnnEEp11Dzr/xbauyROlM0efVl9PZ/1iJ8afG/S8UvPk+zsy/BKoH3ItwRBMv8YeMB0t0RZOsw9oU0C/D6mX/8JaFvcfADh6Mt1/+RhVqwKdSwHGXJZiHF2zHcwHLaxsSB39S44xxBios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032074; c=relaxed/simple;
	bh=LM4Hs4vlibx2m4PZlvUgsHtt/4N1l9HgqRZQEpZba7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRbCfvv7qcNMgdQ4EFMwtQDcmbxPUpg6rdT3ev+NDJhaQK+Ft10ipTNIKI4FuvcoTbthDqorUESiGmYJQw5yUwLZkId6xcMCpsp34YKtdRVObeSQ0hUMUAVkzOj+0UhuK2pbpxzI2f/pUyF1GF1jYdd2pbT2P7NE8a9WQ54tnBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=szKPQfOV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D7AE51A158B;
	Tue, 21 Oct 2025 07:34:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AAA00606DC;
	Tue, 21 Oct 2025 07:34:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2AF5102F23E1;
	Tue, 21 Oct 2025 09:34:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761032068; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=SK5U992WcNiHhzxd6gYrUFb9wH/LgMgdeebB8EqGaB8=;
	b=szKPQfOVCfCay7Q/JMT/iu4hqIFBDUTVPlI4caPMUUmRE9XDUluENSysZPN2hpcgaTdZTo
	ZVv7W250LD3BZATANzQJJDb7VWsZg//uKug65D1wW2+TOp1iQVGQB1bPUq7FKrLC11rcbA
	B4HzQTx3BectcgV/SB8YwOwwN3sS1SDW7kcAarhNdKpdQ49+0PfJZJphnRr+Er+2fPV6oI
	j7PZ5Dtu/D5Yvof58EWZ1a766HgYugAAZ5gtsqyei0z5TiCQqFY5HE5q7FFnLEO5wzi0MV
	wTGClqLCTHRt0+H/zQkqO16DHyxkoa2ZRbprVd9pOZ16KlvomdExnQl65RV1hA==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/3] dt-bindings: display: panel: Add the Leadtek LTK08QV25BYL panel
Date: Tue, 21 Oct 2025 09:34:03 +0200
Message-ID: <20251021073408.195959-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021073408.195959-1-herve.codina@bootlin.com>
References: <20251021073408.195959-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Leadtek LTK08QV25BYL is a 2.8" 240x320 DSI display.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../display/panel/leadtek,ltk028qv25byl.yaml  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk028qv25byl.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk028qv25byl.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk028qv25byl.yaml
new file mode 100644
index 000000000000..c10365984057
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk028qv25byl.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/leadtek,ltk028qv25byl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Leadtek LTK028QV25BYL 2.8in 240x320 DSI panel
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: leadtek,ltk028qv25byl
+
+  reg:
+    maxItems: 1
+
+  backlight: true
+  port: true
+  reset-gpios: true
+
+  iovcc-supply:
+    description: regulator that supplies the IOVCC voltage
+
+  vci-supply:
+    description: regulator that supplies the VCI voltage
+
+required:
+  - compatible
+  - reg
+  - backlight
+  - iovcc-supply
+  - vci-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "leadtek,ltk028qv25byl";
+            reg = <0>;
+            backlight = <&backlight>;
+            iovcc-supply = <&vcc_1v8>;
+            vci-supply = <&vcc3v3_lcd>;
+        };
+    };
+
+...
-- 
2.51.0


