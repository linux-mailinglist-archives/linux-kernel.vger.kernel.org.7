Return-Path: <linux-kernel+bounces-777394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C625DB2D8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06C65A4F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A342E427F;
	Wed, 20 Aug 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O1jwZ7JC"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E8275865;
	Wed, 20 Aug 2025 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682683; cv=none; b=rdDMgH7setrAx6B/Wt13pOsXZJE8vKuBx8DvIWJ+++nNh/DU8l1/pKGvbdDYpt9Aweq95KEQ+zfnNZMJ4zUQN3xeSB7qXTR3QG9XdyK4wrMQFMi0djth/dwYb9ORI7gAA2kDpbodDiUaI7SPb3bSDRDYDqARWbrTD3SpuPRk8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682683; c=relaxed/simple;
	bh=xKa0O/SngrtF2YaSdM2z+vQ1VXaK3fatis0FtdVUw0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3+iKp4uBCJ8chWKmvLnSObbCiFUW6RuxA69bN0IkyctZU4W9ByI6PiV96kXNQgl7QStr9eBjQoLyg1AbBamzrM/4LXAELgDsMK/IAHc3BbND8w9oG1/7Sx+HKt9bqiynRUU8nORm4iU1I5gUIlTmTqowZoM/6K8eX4WYabOvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O1jwZ7JC; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57K9brrN3165901;
	Wed, 20 Aug 2025 04:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755682673;
	bh=VjsUd7nv0GPIjNDND7mWWJy38PU6jOtmXtrIPRTVCCA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=O1jwZ7JCIQTtetRC2Mhco++BfCnWhsRlmM1lT5wP+tkWtSANus4eviWcd8G4GF0lb
	 hIBzRaojmsqKwWeYqhaLcVzgOydNBO2QSSjW2Y+bUiLl7eWELqd9t89B4xzKlVqyr3
	 hrz4H+VkrpxNeFhtuagbkP77DtVPk78JCfuQ2cc0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57K9bqVF1098620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 04:37:52 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 04:37:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 04:37:52 -0500
Received: from pratham-Workstation-PC (pratham-workstation-pc.dhcp.ti.com [10.24.69.191])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57K9bopl020385;
	Wed, 20 Aug 2025 04:37:51 -0500
From: T Pratham <t-pratham@ti.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller"
	<davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: T Pratham <t-pratham@ti.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kamlesh
 Gurudasani <kamlesh@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Vishal
 Mahaveer <vishalm@ti.com>,
        Kavitha Malarvizhi <k-malarvizhi@ti.com>
Subject: [PATCH v7 1/2] dt-bindings: crypto: Add binding for TI DTHE V2
Date: Wed, 20 Aug 2025 14:42:26 +0530
Message-ID: <20250820092710.3510788-2-t-pratham@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820092710.3510788-1-t-pratham@ti.com>
References: <20250820092710.3510788-1-t-pratham@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add DT binding for Texas Instruments DTHE V2 cryptography engine.

DTHE V2 is introduced as a part of TI AM62L SoC and can currently be
only found in it.

Signed-off-by: T Pratham <t-pratham@ti.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/crypto/ti,am62l-dthev2.yaml      | 50 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/ti,am62l-dthev2.yaml

diff --git a/Documentation/devicetree/bindings/crypto/ti,am62l-dthev2.yaml b/Documentation/devicetree/bindings/crypto/ti,am62l-dthev2.yaml
new file mode 100644
index 000000000000..5486bfeb2fe8
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/ti,am62l-dthev2.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/ti,am62l-dthev2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: K3 SoC DTHE V2 crypto module
+
+maintainers:
+  - T Pratham <t-pratham@ti.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,am62l-dthev2
+
+  reg:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: AES Engine RX DMA Channel
+      - description: AES Engine TX DMA Channel
+      - description: SHA Engine TX DMA Channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx1
+      - const: tx2
+
+required:
+  - compatible
+  - reg
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    crypto@40800000 {
+        compatible = "ti,am62l-dthev2";
+        reg = <0x40800000 0x10000>;
+
+        dmas = <&main_bcdma 0 0 0x4700 0>,
+               <&main_bcdma 0 0 0xc701 0>,
+               <&main_bcdma 0 0 0xc700 0>;
+        dma-names = "rx", "tx1", "tx2";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..0f5bb8ad7653 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25169,6 +25169,12 @@ S:	Odd Fixes
 F:	drivers/clk/ti/
 F:	include/linux/clk/ti.h
 
+TI DATA TRANSFORM AND HASHING ENGINE (DTHE) V2 CRYPTO DRIVER
+M:	T Pratham <t-pratham@ti.com>
+L:	linux-crypto@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/crypto/ti,am62l-dthev2.yaml
+
 TI DAVINCI MACHINE SUPPORT
 M:	Bartosz Golaszewski <brgl@bgdev.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.43.0


