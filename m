Return-Path: <linux-kernel+bounces-819172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC5B59C70
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E5B7B6D63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223E33191B9;
	Tue, 16 Sep 2025 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JIg06L8A"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78326F28C;
	Tue, 16 Sep 2025 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037695; cv=none; b=YHCeOR/XmXW5WrT8oYGBOfhQCj+l/yH5TalZuPgGDJNJ28W0q76mRCMbsKjMDPv3fm4v1esTWtaz8f9hHIN1FKC1hwjKhfsMjZWh94PU3oE80hv8eyFA7DjY8e47CGXGq0oBI0EmuGEOIIKORy+CXieuQ2A2DEJRAaOoJK8YlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037695; c=relaxed/simple;
	bh=7Seova7f1FdwTYEdl9A3x25173eB7Rgo+htFEANmtp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gwWsMvTybL/HJPigXhD3JP13CTiEYOq/8mbeZBoxOUumIQZXlbGjwoy/+BpcWi3tR6iAcmUESylZyCzfG44SadytHh3GV9fe2LT/2jUOq3Q7yY1szXBM/Frl1up/ipYRCVgP8g7XnBcF5xdJjeyQKjhNyFxbF+yWSX3R3ZZRW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JIg06L8A; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GFm9mg1401955;
	Tue, 16 Sep 2025 10:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758037689;
	bh=AEu+dn/J3RK8yWZKjm7l+G1BmqZenbC5WbVfow5BK14=;
	h=From:To:CC:Subject:Date;
	b=JIg06L8A477IbFeL1o1Wlji/4MjK4nEDANNEdg5NWNCAB75POdqdq2saqRCUo5l3x
	 9vx75+jC5/eBGOfc/8MbOpY1/nhuhWySjhp8xdbkxPQeLJAEUjcdiKlMoeSZFrtuP0
	 t0PBRk4FoBbW87BB3AvfRiNobl+LDe/kmaoaB9rM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GFm9cI1639105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 16 Sep 2025 10:48:09 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 10:48:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 10:48:09 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GFm9FM1848594;
	Tue, 16 Sep 2025 10:48:09 -0500
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
Subject: [RFC PATCH] dt-bindings: nvmem: Introduce nvmem efuse binding for TI K3 SoCs
Date: Tue, 16 Sep 2025 10:48:09 -0500
Message-ID: <20250916154809.545283-1-jm@ti.com>
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
---
 .../devicetree/bindings/nvmem/ti,efuses.yaml  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/ti,efuses.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml b/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml
new file mode 100644
index 0000000000000..fffca65cdbfe0
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml
@@ -0,0 +1,36 @@
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
+  - $ref: nvmem-deprecated-cells.yaml#
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
+        reg = <0x43000230 0x4>;
+    };
+
+...
-- 
2.51.0


