Return-Path: <linux-kernel+bounces-800024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94508B43296
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531951C24DE5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F64276020;
	Thu,  4 Sep 2025 06:37:53 +0000 (UTC)
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A752750FA;
	Thu,  4 Sep 2025 06:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967872; cv=none; b=d7GphbcYkvGrdsoNN2PVN7KlOa+4A8ZV0LvgKiYYoQyUyyz5XoU8mxhj3ZEThq/TX8KXAkE06gqzenQ8kN0bMwVs5ryEgmIFch1uC1pDBUN7iZ2Tanr2biF63ed0bKBO0QHg5D1u5KtJVoAAx8EsnPDB3tBFBYnfgXLVkd33ehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967872; c=relaxed/simple;
	bh=vUGlY+hNULhLDP5pVQSbJNryp1EuZPrtBO5w/sTFHeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQh2L4qBF1DUVk1ky8i7xiWWJB/2vh6lEqTOz/JtCLcWXXoAUm0ZDI799H+nTi3nvEfwl2xK9/RfpJ6sR6FDWEdpKRqMbXDj1mE9G+LCjS/ZAEBa1JwKqT5v+UbdsVDjcQwl+L6m9VBnbNuMDzHAHP0eHDqX5jpPWWVggNY1Eyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006800LT.eswin.cn (unknown [10.12.96.77])
	by app2 (Coremail) with SMTP id TQJkCgCHJpWkM7loOUvIAA--.53344S2;
	Thu, 04 Sep 2025 14:37:27 +0800 (CST)
From: Yulin Lu <luyulin@eswincomputing.com>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	linux-phy@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	zhengyu@eswincomputing.com,
	linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com,
	lianghujun@eswincomputing.com,
	Yulin Lu <luyulin@eswincomputing.com>
Subject: [PATCH v3 1/3] dt-bindings: ata: eswin: Document for EIC7700 SoC ahci
Date: Thu,  4 Sep 2025 14:37:18 +0800
Message-Id: <20250904063718.421-1-luyulin@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20250904063427.1954-1-luyulin@eswincomputing.com>
References: <20250904063427.1954-1-luyulin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgCHJpWkM7loOUvIAA--.53344S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4UAw4rWw48JrW5Zw1DZFb_yoW8tFy3pF
	s7GrZrJF4SgryxXay8GF10kF1ftws7CF1Ykr97J3WUKFWqgasYqrsIk3W5Aa47Jw1xXa43
	XFyagw1ayw42vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRKZX5UUUUU==
X-CM-SenderInfo: pox13z1lq6v25zlqu0xpsx3x1qjou0bp/

Add document for the SATA AHCI controller on the EIC7700 SoC platform,
including descriptions of its hardware configurations.

Signed-off-by: Yulin Lu <luyulin@eswincomputing.com>
---
 .../bindings/ata/eswin,eic7700-ahci.yaml      | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml b/Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
new file mode 100644
index 000000000000..9266f8f2543e
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/eswin,eic7700-ahci.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/eswin,eic7700-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Eswin EIC7700 SoC SATA Controller
+
+maintainers:
+  - Yulin Lu <luyulin@eswincomputing.com>
+  - Huan He <hehuan1@eswincomputing.com>
+
+description:
+  This document defines device tree bindings for the Synopsys DWC
+  implementation of the AHCI SATA controller found in Eswin's
+  Eic7700 SoC platform.
+
+select:
+  properties:
+    compatible:
+      const: eswin,eic7700-ahci
+  required:
+    - compatible
+
+allOf:
+  - $ref: snps,dwc-ahci-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: eswin,eic7700-ahci
+      - const: snps,dwc-ahci
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: aclk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: arst
+
+  ports-implemented:
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - phys
+  - phy-names
+  - ports-implemented
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sata@50420000 {
+        compatible = "eswin,eic7700-ahci", "snps,dwc-ahci";
+        reg = <0x50420000 0x10000>;
+        interrupt-parent = <&plic>;
+        interrupts = <58>;
+        clocks = <&clock 171>, <&clock 186>;
+        clock-names = "pclk", "aclk";
+        phys = <&sata_phy>;
+        phy-names = "sata-phy";
+        ports-implemented = <0x1>;
+        resets = <&reset 96>;
+        reset-names = "arst";
+    };
-- 
2.25.1


