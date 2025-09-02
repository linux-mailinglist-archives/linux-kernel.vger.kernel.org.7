Return-Path: <linux-kernel+bounces-796744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 466A8B40690
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC244E5F12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E116830C60D;
	Tue,  2 Sep 2025 14:21:55 +0000 (UTC)
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7161DF963
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822915; cv=none; b=YQEnIAcBPoXINN7MVKQ/nXaiDJA1WMQOiG+Mq/pE+qQ2jUkclRw9OD7y5cddTBva7toVJTE6oGqAHspUV5k7CaJXqjQ7Uu6JBEpBcOxgZqgVLCXI08kz74iJ+X68yg5E2hCYTjKDkvFfjVH2VFwomGuIGV4sumxyVyYhHNTYByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822915; c=relaxed/simple;
	bh=afTu4E3BiQjz02dQljkpTGIJEgmOYGGH27/Q6WQFDv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6oZQcqiWD4keU5vo8TpLZVBvmR1782L5/8VFF66N3nEoYXjis5KP4yizMXagwPREsZ1I4yf+yUfdqQWZimjH4L0tEgoUPt5A0KqC4FqlhArRpk4W2T2x4HhmTPfshvWRq8GtQTB+qz/xjdwgszDdO4M5Q/kEYWJaMsAVqQVYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com; spf=pass smtp.mailfrom=douglass.dev; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=douglass.dev
Feedback-ID: 3578:1022:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1344370180;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 02 Sep 2025 14:21:46 +0000 (UTC)
From: Woodrow Douglass <wdouglass@carnegierobotics.com>
To: linux-kernel@vger.kernel.org
Cc: Woodrow Douglass <wdouglass@carnegierobotics.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] regulator: pf530x: dt-bindings: nxp,pf530x-regulator
Date: Tue,  2 Sep 2025 10:21:34 -0400
Message-Id: <a33794ed2caeefc8a79419f35b7e28546996dec9.1756822704.git.wdouglass@carnegierobotics.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1756822704.git.wdouglass@carnegierobotics.com>
References: <cover.1756822704.git.wdouglass@carnegierobotics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bindings for the pf530x series of voltage regulators

Signed-off-by: Woodrow Douglass <wdouglass@carnegierobotics.com>
---
 .../regulator/nxp,pf530x-regulator.yaml       | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml
new file mode 100644
index 000000000000..f1065b167491
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/nxp,pf530x-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PF5300/PF5301/PF5302 PMIC regulators
+
+maintainers:
+  - Woodrow Douglass <wdouglass@carnegierobotics.com>
+
+description: |
+  The PF5300, PF5301, and PF5302 integrate high-performance buck converters, 12 A, 8 A,
+  and 15 A, respectively, to power high-end automotive and industrial processors. With adaptive
+  voltage positioning and a high-bandwidth loop, they offer transient regulation to minimize capacitor
+  requirements.
+
+properties:
+  compatible:
+    enum:
+      - nxp,pf5300
+      - nxp,pf5301
+      - nxp,pf5302
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller
+
+    properties:
+      SW1:
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for the regulator.
+
+        properties:
+          regulator-name:
+            pattern: "^SW1$"
+            description:
+              Name of the single regulator
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vddi_0_75@28 {
+            compatible = "nxp,pf5302";
+            reg = <0x28>;
+
+            regulators {
+                SW1: SW1 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-max-microvolt = <1200000>;
+                    regulator-min-microvolt = <500000>;
+                };
+            };
+        };
+    };
-- 
2.39.5


