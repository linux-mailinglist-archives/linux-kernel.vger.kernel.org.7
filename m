Return-Path: <linux-kernel+bounces-812400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C483DB537B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E1D189AB54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB5834F473;
	Thu, 11 Sep 2025 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F8dV/yg5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF9533A004;
	Thu, 11 Sep 2025 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604480; cv=none; b=S3VHTg0hftwFKgXzj81WRlpZ62NEhIc0wCE+gZBvDdx4X7FbCOG9GMRD7QeDan4+NEBmWY17d6iOG5kC/HihD/XuNaL5Hk8V9j7tZeIacl4MLFhMlKiez0tNsmYnd4hhEfMzxLqmVu3SUQvmkOE1AcS4ioduj+8WrQZ2Ll4l7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604480; c=relaxed/simple;
	bh=vPI8d+Ewn3tGtC66dDnYrvhtUwCZSoHr3JQkHahYKWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qwsr0m+2+l6Di/zxcDHZBLCfYliBp1lTUoWcEFHJ8VpHvn/iG8Zd/mVawROhm2BUEkOePeYEVXlCkfU6XxejwWtvamyGT59pjnBD7a3ioMu8z+E6VjNXU61CFZwdCSWaoVcOjcDMXUOpX8DEPKDCsCF/MxRfMjfJz8qm87WulGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F8dV/yg5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757604479; x=1789140479;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vPI8d+Ewn3tGtC66dDnYrvhtUwCZSoHr3JQkHahYKWs=;
  b=F8dV/yg55PRLcwMvJzUTz2XmudoI7JSZ+PVGJQ6Umylk2LIBBnpXFhaM
   EVfF0KfpCek+MUFBWvM1CEdJZZnsRybUjnPm3Jy6sioiPjHAjvPAZyEi1
   3VbkU/0NyYL+iZF6DSokBGbNIV7vI2WOwH3ZHVnt3s5wyD3/EqDCwaSaP
   fKyjmto3VI1SxbIIGk3VFkCbflr0TYSyAsX41wAtW4+lZuFVjg0EVEmUV
   ZBBd88k2gjw1GQG+EQrWJNFhU1BjYV3t+O6lGfKSgj9HEXqaMg67xNK7y
   sksCY/moJWKXmxvzPe9OK5KD2cNgdq5Aw+2701NYPg01eB3JgH8VVQz2v
   w==;
X-CSE-ConnectionGUID: GfrnwuRcTGGvDy+5ZTnmUQ==
X-CSE-MsgGUID: mleIvvMGQdmn2L4xn2amqA==
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="277761655"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2025 08:27:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 11 Sep 2025 08:27:44 -0700
Received: from ROU-LL-M19942.mpu32.int (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 11 Sep 2025 08:27:41 -0700
From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Date: Thu, 11 Sep 2025 17:26:25 +0200
Subject: [PATCH 1/5] dt-bindings: gpu: add bindings for the Microchip GFX2D
 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250911-cpitchen-mainline_gfx2d-v1-1-d7fab1a381ee@microchip.com>
References: <20250911-cpitchen-mainline_gfx2d-v1-0-d7fab1a381ee@microchip.com>
In-Reply-To: <20250911-cpitchen-mainline_gfx2d-v1-0-d7fab1a381ee@microchip.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Russell King <linux@armlinux.org.uk>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Cyrille Pitchen <cyrille.pitchen@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819;
 i=cyrille.pitchen@microchip.com; h=from:subject:message-id;
 bh=vPI8d+Ewn3tGtC66dDnYrvhtUwCZSoHr3JQkHahYKWs=;
 b=owGbwMvMwCXmf6yzKqEsVIbxtFoSQ8ahV+mhj7ms1RXWHHLc7+u6KW72C9Mv29e84n9xblrpI
 /aFRkendJSyMIhxMciKKbIcerO1N/P4q8d2r0SlYOawMoEMYeDiFICJVEgx/DN5MDcj3pWhbzGv
 b0RvasW9MqeDv17Kdt7Zv2B7xo/0R8qMDC/3uTTFt/OYNZu93G+sdXWf3skTFx/e2qtrf/vSuRK
 dPh4A
X-Developer-Key: i=cyrille.pitchen@microchip.com; a=openpgp;
 fpr=7A21115D7D6026585D0E183E0EF12AA1BFAC073D

The Microchip GFX2D GPU is embedded in the SAM9X60 and SAM9X7 SoC family.
Describe how the GFX2D GPU is integrated in these SoCs, including
register space, interrupt and clock.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
---
 .../devicetree/bindings/gpu/microchip,gfx2d.yaml   | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/microchip,gfx2d.yaml b/Documentation/devicetree/bindings/gpu/microchip,gfx2d.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e416e13bc6627a0fef3c70625a6a3e2d91636ffc
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/microchip,gfx2d.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/microchip,gfx2d.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip GFX2D GPU
+
+maintainers:
+  - Cyrille Pitchen <cyrille.pitchen@microchip.com>
+
+properties:
+  compatible:
+    enum:
+      - microchip,sam9x60-gfx2d
+      - microchip,sam9x7-gfx2d
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      const: periph_clk
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/at91.h>
+    gfx2d@f0018000 {
+      compatible = "microchip,sam9x60-gfx2d";
+      reg = <0xf0018000 0x4000>;
+      interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 36>;
+      clock-names = "periph_clk";
+    };
+
+...

-- 
2.48.1


