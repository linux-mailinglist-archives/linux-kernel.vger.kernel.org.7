Return-Path: <linux-kernel+bounces-886300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FC3C35316
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D62E34E1C1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19850309F18;
	Wed,  5 Nov 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mMzTYUMy"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA8305957;
	Wed,  5 Nov 2025 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339657; cv=none; b=FRwnnO3Q498W/5Zv5WZTxA8Dr3j4kWe3nKDm32sqe89rJvpB2pEJ/hQOkNb2SJ2wVOoyvfwGvMmn78WoFscXV/1Al9JuRrqhaWllVFT/ylTZ9jf1odPTJEMLLcZlke6cRbTF7UlxgOJfvypJyi9VhgcEDs4992k6+zb8KuIvXPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339657; c=relaxed/simple;
	bh=pUWPrSQnvqoCHyCRhBjVJByjLkm0TUCQRDFW0IRaknc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=an9iiBoNs7aVWKiA0Kk6WttnpMVoEO7C9q0C7ndtfFTkgvOb6YcjcBwDpb4dm+ooG2h0bDUC/LaU5GMMBr5X/VSM55KNp+OxS8ClfqIvS+y1ZUdXkqWt5SeATMWDhezMSFOtsy7HL+m58Pa/fJvtpUylee1p1MuZoaRW+XC130w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mMzTYUMy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A5AirJ73984690, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762339493; bh=7/L3eZ/L1mPobVbqQZCng5K7GDFMf1rAOmQO81QwdWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mMzTYUMyko5T+g9cC2FsoMEUc2VxjJ+IZtL/LzUhQ9jI4Yml84+uBcBEfNjAXVl8R
	 44fMivOXSBqGf1ZNmF/j1dAM410JpaBAKZzvETURcaUUp5ocWIutRaOFOGYlATPdYM
	 6Gn8zMZ3PO1uhdCBx6D6dtiJ7PMUvfxO3tUyP7DRlconcZZmN4Wrpq91K7hhgAzmTx
	 dHR/oS9+g1QaLOsIRg8PU4FqPAgR1YnN+/RJpnWE3UFUZWt8UxFAat/zPXx5wSL5g0
	 YfKgQ2n2K1h2OKAb4dJvooxL02aQY+fb/Kq9misPqCDGn7PovVVrciHYE8pOCfRwvC
	 xAwVxyFrrrMGg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A5AirJ73984690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 18:44:53 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 18:44:53 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 18:44:53 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server id 15.2.1544.27 via Frontend
 Transport; Wed, 5 Nov 2025 18:44:52 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <afaerber@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <lee@kernel.org>, <james.tai@realtek.com>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cy.huang@realtek.com>,
        <stanley_chang@realtek.com>, <eleanor.lin@realtek.com>
Subject: [PATCH 2/3] dt-bindings: mfd: Add Realtek ISO system controller
Date: Wed, 5 Nov 2025 18:44:51 +0800
Message-ID: <20251105104452.6336-3-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251105104452.6336-1-eleanor.lin@realtek.com>
References: <20251105104452.6336-1-eleanor.lin@realtek.com>
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
 .../bindings/mfd/realtek,iso-system.yaml      | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/realtek,iso-system.yaml

diff --git a/Documentation/devicetree/bindings/mfd/realtek,iso-system.yaml b/Documentation/devicetree/bindings/mfd/realtek,iso-system.yaml
new file mode 100644
index 000000000000..6fbdedd3ee5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/realtek,iso-system.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/realtek,iso-system.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek ISO System Controller
+
+description: |
+  The Realtek ISO System Controller is a register area that contains
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
+          - realtek,iso-system
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
+  reg-io-width:
+    const: 4
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    description: Catch-all for other sub-devices in the ISO area.
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+  - reg-io-width
+
+additionalProperties: false
+
+examples:
+  - |
+    iso: syscon@7000 {
+        compatible = "realtek,iso-system", "syscon", "simple-mfd";
+        reg = <0x7000 0x1000>;
+        ranges = <0x0 0x7000 0x1000>;
+        reg-io-width = <4>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+    };
-- 
2.34.1


