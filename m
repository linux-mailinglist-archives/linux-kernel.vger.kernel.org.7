Return-Path: <linux-kernel+bounces-827577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9DBB92221
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2B217CE8E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EBF3112B6;
	Mon, 22 Sep 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rXecb9j4"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102C48CFC;
	Mon, 22 Sep 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557242; cv=none; b=foEx+axqWn9uIobD8YAN+7z4khF1ZNDcJ5PPvXVUph73empzcXAjd5KAlcHOQYnmhUmcpr8LO7ygDSRoA7A1IjRLTn6deAgr4eLF/Dx0dwGZqkd3cgc7rp9F244RrT5Hk6TkT0gR5PvvEo+OckLA6cjKAK4jzfsfVIJ+EiPnn1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557242; c=relaxed/simple;
	bh=cFPW0IZq1rBkyUXFprmIaajnCWU9o4KusfDEtLW5HFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h+8nSfsbF0keHKGB2wcucDuB5lOGbvAKCnX2gZMmEDG9J9OWChTWbcEu1jW42SlepVDZv0Rffndjbs9TJ1kzCG49P4iRgyi+HarfDTZaWyPWatrvyaRlj5t3nABUIv6yIPCPOZUTFrQl/CxsCxANcwsNPIGWijZ+/Dnwnkzb/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rXecb9j4; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58MG7GC41288610;
	Mon, 22 Sep 2025 11:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758557236;
	bh=9RSHxLeqpXlN2s7pR0h1fwieZD6Mruz/96jceE054Dg=;
	h=From:To:CC:Subject:Date;
	b=rXecb9j4xkSWCxyNPlrmpG1XYEeTxMURs2ccowmcgBJ+to/dMo0tnjr4tMPjWx/yz
	 fznC9MRPNPfkv/fNZTcoWPzUGnnRbjNKrsBfK4vT/LW58LLR5HQkP9QNZTR6UWfr+r
	 FV2Uy75yuVgmYE/M+44bpVy25mzlEc/KHDWrVvxo=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58MG7GmT1000339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 22 Sep 2025 11:07:16 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 22
 Sep 2025 11:07:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 11:07:15 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58MG7FY62789608;
	Mon, 22 Sep 2025 11:07:15 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Srinivas Kandagatla <srini@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bryan
 Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>
Subject: [RFC PATCH v2] dt-bindings: nvmem: Introduce nvmem efuse binding for TI K3 SoCs
Date: Mon, 22 Sep 2025 11:07:15 -0500
Message-ID: <20250922160715.346137-1-jm@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On K3 SoCs there are efuse registers scattered across the memory
map. In order to reference these efuse registers like gp-sw which
may store SW REV information or other general purpose information
for drivers to consume, treat them appropriately as efuse devices
with nvmem framework.

Signed-off-by: Judith Mendez <jm@ti.com>
---
This patch is not complete and is sent as an RFC to get some initial
thoughts on this implementation to solve [0].

[0] https://lore.kernel.org/linux-mmc/736f09e0-075a-48e0-9b32-6b8805a7ee2a@kernel.org

Changes since v1 RFC:
- Drop depreciated nvmem-deprecated-cells.yaml since nvmem.yaml
  already includes nvmem-layout.yaml.
- gp-sw efused-backed reg is 128 bits, so update size of example
  to 0x10.

Link to RFC v1:
https://lore.kernel.org/linux-devicetree/20250916154809.545283-1-jm@ti.com/
---
 .../devicetree/bindings/nvmem/ti,efuses.yaml  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/ti,efuses.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml b/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml
new file mode 100644
index 0000000000000..c632f47b7b4cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/ti,efuses.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI SoC eFuse-based NVMEM
+
+maintainers:
+  - Judith Mendez <jm@ti.com>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    - const: ti,am62p-efuse
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse@43000230 {
+        compatible = "ti,am62p-efuse";
+        reg = <0x43000230 0x10>;
+    };
+
+...
-- 
2.51.0


