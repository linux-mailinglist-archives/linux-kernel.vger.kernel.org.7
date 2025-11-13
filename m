Return-Path: <linux-kernel+bounces-899332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E8C576E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BBB234BDCF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB834E765;
	Thu, 13 Nov 2025 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lQFE+ko9"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271635979;
	Thu, 13 Nov 2025 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037195; cv=none; b=lVUMxA0wbcQN2KTDpvyZaF8Rv9PHtjPHXn2JoADjS2LW1yKj1qIzJ/yQ2fXEHAsr9w5Qn4L0zKKAhBV6lNfH368NwaAVz2aM0PDfYYuQ6RUd6koCL9h8NCKM6MpeXBbFl23w6i3/g3foJY0lMgndz6SsrmbUiP5s+iR1Kt12nGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037195; c=relaxed/simple;
	bh=k8oj2NRsa3Gg0TPGmJHmLNMnEXpYruViflwDEMkLHDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBHtlsIWJxVBz8RokfdiBQBhI3G5QskwS1pvh2niBUb00LkYfd7prCOttHRp5+IFVUzCBZPko13Zujms+PtoAUT0USgD1O6A1gXmOncniyiUHhtaS6gxTjo5P2f5Kunp77FyPNrJDu86k17nLGIS0cesF0qcMhwis9RkNrg8G8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lQFE+ko9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5ADCUALZ03591312, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763037010; bh=AYAit9wpd1qdDJLaAzEIICqIfVUgl1o6lvxXggMuD/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=lQFE+ko9mVOj55EeQ+eu7nQXcqmPtZsrytG0otXYV54GoJnG/VzWM2ctJVO3uXqPH
	 B9DtJxL8fQT4sEq3LW3+yvX9SFDt/P+pcM/H7lwobs6loBZ00CIbnuCF2zTZBpGbXW
	 M2aR1e6tqoZkChak25FgcrziwaabHoAEI0FvdgNQUH7OPnpvLL27QbHKT/PXTUEMaL
	 ckGx1Mexil3o+j4p8jFophL8yMeLPUrwCAVXhGgC8IzmjYUghZPT/A92FJYbsGFNjy
	 mM9bRAWQ7Ojz9cGSKgCdzDceSBsXr53DLtQoUdPSxcgqg1z2jDALEXLJMGEgAJziIE
	 5yoKx3tFeDFJA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5ADCUALZ03591312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 20:30:10 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 20:30:10 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 20:30:10 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <afaerber@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <lee@kernel.org>, <james.tai@realtek.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cy.huang@realtek.com>,
        <stanley_chang@realtek.com>, <eleanor.lin@realtek.com>
Subject: [PATCH v2 2/3] dt-bindings: mfd: Add Realtek MISC system controller
Date: Thu, 13 Nov 2025 20:30:08 +0800
Message-ID: <20251113123009.26568-3-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251113123009.26568-1-eleanor.lin@realtek.com>
References: <20251113123009.26568-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add DT binding schema for Realtek system controller.

Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
 .../devicetree/bindings/mfd/realtek,misc.yaml | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/realtek,misc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/realtek,misc.yaml b/Documentation/devicetree/bindings/mfd/realtek,misc.yaml
new file mode 100644
index 000000000000..4f4a9ae250be
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/realtek,misc.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/realtek,misc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek MISC System Controller
+
+description:
+  The Realtek MISC System Controller is a register area that contains
+  miscellaneous system registers for the SoC and serves as a parent node
+  for other functions.
+
+maintainers:
+  - James Tai <james.tai@realtek.com>
+  - Yu-Chun Lin <eleanor.lin@realtek.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - realtek,misc
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  ranges:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^serial@[0-9a-f]+$":
+    type: object
+    description: UART controllers inside MISC area
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    syscon@7000 {
+        compatible = "realtek,misc", "syscon", "simple-mfd";
+        reg = <0x7000 0x1000>;
+        ranges = <0x0 0x7000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        uart0: serial@800 {
+            compatible = "snps,dw-apb-uart";
+            reg = <0x800 0x100>;
+            clock-frequency = <432000000>;
+            interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+            reg-io-width = <4>;
+            reg-shift = <2>;
+            status = "disabled";
+        };
+    };
-- 
2.34.1


