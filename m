Return-Path: <linux-kernel+bounces-831267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A8AB9C3CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694DE4C7975
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D3B28724D;
	Wed, 24 Sep 2025 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dk0IiyPb"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C921286883;
	Wed, 24 Sep 2025 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748062; cv=none; b=PFUZrwYwlZZ4vMHlSCgs5DJNVZT3ayQSTbwR/eeTPA/MlNZUyw48trbtTzghR8UDnVDGL0PYzF2ZtXV392sDAEARpGYJUwI1bX68PF3Ti0SsmMpsornPLHgZJaFzwEngr75/RSC2JeNL3L9vkUN2jYpX2YRyslt8lGM5g5SpWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748062; c=relaxed/simple;
	bh=RrqwfI+qSHG3pjgjY62xN6PUYZ9J0YNLv5urWcUhVo8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uxrfo4lTnmCGm4og5OdOOA+0QG8wVv/CVowrvECXLeUVqH1NX7f1pn6JXmx+xZ5J3vXLq4Ju7SIPQ/fSVh29Jiexz3NPYLqdTj8+PUs5h506OE4zVVrAE5XhHNcBY998iLIdhS9lKFrGb5C0C9CCgj28jhRN60ImcJm23K5JUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dk0IiyPb; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58OL7a1P1312134;
	Wed, 24 Sep 2025 16:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758748056;
	bh=doH4KUIPza/iQ9G4dHJvoa5CwBU/j+Pj6k3xLIPVITo=;
	h=From:To:CC:Subject:Date;
	b=Dk0IiyPbC1Va6OrsH61QkFGGbV1VpB+0PkudKwPoomOn2TT3Y4HFGOib+j//OeOPy
	 UZ1GoCk/Mk3D4DHNTZ6CDK/t2Gf61Q8UudnVrkCyvi3Awd4iXxBuSl8GigN/oju29k
	 UMwa9It17J/RdeilpREBZWFcwzbQ1qnXzPQwyXb4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58OL7acb2141896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 24 Sep 2025 16:07:36 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 24
 Sep 2025 16:07:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 16:07:35 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58OL7Z2t2631292;
	Wed, 24 Sep 2025 16:07:35 -0500
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
Subject: [RFC PATCH v3] dt-bindings: nvmem: Introduce nvmem efuse binding for TI K3 SoCs
Date: Wed, 24 Sep 2025 16:07:35 -0500
Message-ID: <20250924210735.1732423-1-jm@ti.com>
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

Changes since v2 RFC:
- Fix yamllint warnings/errors
- Rebase against next/master

Link to RFC v2:
https://lore.kernel.org/linux-devicetree/20250922160715.346137-1-jm@ti.com/
Link to RFC v1:
https://lore.kernel.org/linux-devicetree/20250916154809.545283-1-jm@ti.com/
---
 .../devicetree/bindings/nvmem/ti,efuses.yaml  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/ti,efuses.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml b/Documentation/devicetree/bindings/nvmem/ti,efuses.yaml
new file mode 100644
index 0000000000000..c6c66016b9d44
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
+
+properties:
+  compatible:
+    enum:
+      - ti,am62p-efuse
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


