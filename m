Return-Path: <linux-kernel+bounces-837052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3633BAB2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EE619230C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C906247284;
	Tue, 30 Sep 2025 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ifyQouFS"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07319241664
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759204528; cv=none; b=VcjXyuKltel96JvUuiDEG/S+v3/EnGAvAucV7py1Vm8TmBtSum+/r0eZOlorrVi3Nf1QgGptj3R+WY2C9FGY3atQlPEtZtsR1AofVKLGX4gqIuedqa8nl/YYB9782W7TVHa5LGoycLpl4W9LSjZ+UmZyiPH++YfDtp+iz0dsYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759204528; c=relaxed/simple;
	bh=/bZiWZ58aCldGJC8t/nRfCKBq5N7NH0IgEUv4RdZGEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=HnhKnzBlKVx9rMiCMUapxMI51tuqMuyVSWDZoXEwG3E0H7FV+GPM851SgYZBIFvqBvUc2S4WYNyuXg69w9hkOhnQJkvik5c6q4ormyFN77wvRPEohbzvdnzgdOuv8no4sOLztdkgp4uj2pjgOelxZSsvd3l/DuCwvvWtTtoWfdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ifyQouFS; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250930035523epoutp020083add01a07103341bb5d494417c2c0~p8zF8qH0M2603326033epoutp02L
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:55:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250930035523epoutp020083add01a07103341bb5d494417c2c0~p8zF8qH0M2603326033epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759204523;
	bh=OAKHIMC+SGgb607BRAlenii1CobqGR9qOX07bcaTIu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifyQouFSGONTM7Qqzq+msnwCGfAhGfONx4PDxuP83CVvFnrzLo8TvsZjFHNq+mhdA
	 ouTs1fgA0IQeOUghS71iWxf/2PjnCqo09nBN+wSAwoLU8e71ZQUg1qmEuWpLu7AEgb
	 T408bQus/Cr4pQrlUmbH6ztIxLJVLJKu6TiHikcA=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250930035523epcas5p23c238981ff1efe5bf2c24f04766373e8~p8zFo_kiA2195921959epcas5p2G;
	Tue, 30 Sep 2025 03:55:23 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cbPN967Dtz3hhT3; Tue, 30 Sep
	2025 03:55:21 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250930035521epcas5p428367b20b9498eb8862d17f4bb75f663~p8zEG_8yz2319723197epcas5p4h;
	Tue, 30 Sep 2025 03:55:21 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250930035518epsmtip13069665488924124e1d46773ced32431~p8zBxTW5-2942629426epsmtip1Q;
	Tue, 30 Sep 2025 03:55:18 +0000 (GMT)
From: Himanshu Dewangan <h.dewangan@samsung.com>
To: mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
	alim.akhtar@samsung.com, manjun@samsung.com, nagaraju.s@samsung.com,
	ih0206.lee@samsung.com, jehyung.lee@samsung.com
Cc: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Himanshu Dewangan <h.dewangan@samsung.com>
Subject: [PATCH 01/29] dt-bindings: media: mfc: Add Exynos MFC devicetree
 binding
Date: Tue, 30 Sep 2025 09:33:20 +0530
Message-Id: <20250930040348.3702923-2-h.dewangan@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930040348.3702923-1-h.dewangan@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250930035521epcas5p428367b20b9498eb8862d17f4bb75f663
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250930035521epcas5p428367b20b9498eb8862d17f4bb75f663
References: <20250930040348.3702923-1-h.dewangan@samsung.com>
	<CGME20250930035521epcas5p428367b20b9498eb8862d17f4bb75f663@epcas5p4.samsung.com>

From: Nagaraju Siddineni <nagaraju.s@samsung.com>

Introduce a new DT binding file for exynos-mfc

Documentation/devicetree/bindings/media/samsung,exynos-mfc.yaml
which describes the Exynos Multi‑Format Codec (MFC) IP.  The schema
covers the core node properties, required fields, and provides an
example snippet.

Signed-off-by: Himanshu Dewangan <h.dewangan@samsung.com>
Signed-off-by: Nagaraju Siddineni <nagaraju.s@samsung.com>
---
 .../bindings/media/samsung,exynos-mfc.yaml    | 77 +++++++++++++++++++
 MAINTAINERS                                   | 10 +++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos-mfc.yaml

diff --git a/Documentation/devicetree/bindings/media/samsung,exynos-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,exynos-mfc.yaml
new file mode 100644
index 000000000000..fbed987fb9cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,exynos-mfc.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/samsung,exynos-mfc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos Multi Format Codec (MFC)
+
+maintainers:
+  - Nagaraju Siddineni <nagaraju.s@samsung.com>
+  - Himanshu Dewangan <h.dewangan@samsung.com>
+
+description:
+  Multi Format Codec (MFC) is the IP present in Samsung SoCs which
+  supports high resolution decoding and encoding functionalities.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - samsung,exynos-mfc            # Exynos920
+          - samsung,mfc_core0_mem         # Reserved Memory
+          - samsung,mfc_core1_mem         # Reserved Memory
+
+  power-domains:
+    maximum: 1
+
+  memory-region:
+    minimum: 1
+    maximum: 2
+
+additionalProperties: true
+
+patternProperties:
+  "^mfc_core[0-9]$":
+    type: object
+    properties:
+      compatible:
+        enum:
+          - samsung,exynos-mfc-core
+      reg:
+        maximum: 1
+      interrupts:
+        maximum: 1
+      clocks:
+        minimum: 1
+        maximum: 1
+      clock-names:
+        items:
+          - const: aclk_mfc
+
+    required:
+      - compatible
+      - reg
+      - clocks
+      - clock-names
+      - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mfc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        compatible = "samsung,exynos-mfc";
+        mfc_core0: MFC-0@19cd0000 {
+          #address-cells = <2>;
+          #size-cells = <2>;
+          compatible = "samsung,exynos-mfc-core";
+          reg = <0x0 0x19ED0000 0x0 0x10000>;
+          interrupts = <GIC_SPI 660 IRQ_TYPE_LEVEL_HIGH>;
+          power-domains = <&pd_mfc>;
+          clocks = <&cmu_top 2000>;
+          clock-names = "aclk_mfc";
+          };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 156fa8eefa69..e47016804ac8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3374,6 +3374,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
 F:	drivers/media/platform/samsung/s5p-mfc/
 
+ARM/SAMSUNG EXYNOS SERIES Multi Format Codec (MFC) SUPPORT
+M:	Nagaraju Siddineni <nagaraju.s@samsung.com>
+M:	Himanshu Dewangan <h.dewangan@samsung.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/samsung,exynos-mfc.yaml
+F:	drivers/media/platform/samsung/exynos-mfc/
+F:	drivers/media/platform/samsung/exynos-mfc/base/
+
 ARM/SOCFPGA ARCHITECTURE
 M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
-- 
2.34.1


