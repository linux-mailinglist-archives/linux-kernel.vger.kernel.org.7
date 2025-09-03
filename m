Return-Path: <linux-kernel+bounces-799358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35261B42A76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDBB1C21CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EAA2DF124;
	Wed,  3 Sep 2025 20:04:25 +0000 (UTC)
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC632DEA93
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929864; cv=none; b=ZBzW4lEomNIiPAMlhleDGzq4dCmTqRYCxtOGEgLzxpmWSILr4NykvVKz5jPCSBXsPEbNdS+giiSLBVi+yd8eHqWOVMeIc5BZ/obDZYNVLCYuerwq+4C0rcOP2rtM0tsgjdKpRX4eetxBPB/wyIA2hbm0bj3KaWMppgg/haNOs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929864; c=relaxed/simple;
	bh=/d6w8eDXv10T8ns9vcqYSr+6RWs1H1c46XHcDTHIQSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PteYv3dEmC06iJK5iRUrfOxwqoYYNuRfhmibJ8EVezJSXzVjKPLlMtlHPj1Is5cCovIBwl858VQ2n4TWWgfmSy5X1xzo46TMCQ/Bg/pjZZRJafe2nvOlTRZKmGzbS46pux4K0NOch7Nx6X4/adPmmj+qz7MFb/sxBuxyQZ3Jtgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com; spf=pass smtp.mailfrom=douglass.dev; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=douglass.dev
Feedback-ID: 3578:1022:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 871822494;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 03 Sep 2025 20:04:04 +0000 (UTC)
From: Woodrow Douglass <wdouglass@carnegierobotics.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Woodrow Douglass <wdouglass@carnegierobotics.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 2/2] regulator: pf530x: dt-bindings: nxp,pf530x-regulator
Date: Wed,  3 Sep 2025 16:03:42 -0400
Message-Id: <20250902-pf530x-v4-2-4727f112424e@carnegierobotics.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902-pf530x-v4-0-4727f112424e@carnegierobotics.com>
References: <20250902-pf530x-v4-0-4727f112424e@carnegierobotics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=wdouglass@carnegierobotics.com; h=from:subject:message-id; bh=/d6w8eDXv10T8ns9vcqYSr+6RWs1H1c46XHcDTHIQSQ=; b=owEBbQGS/pANAwAKAewLuLlPNh4UAcsmYgBouJ7xQmuurc2RoDERn5p4uTwEgfimBdREL/UyJ 9zeScmaj3OJATMEAAEKAB0WIQSIUqjrbDLQw0mgxHLsC7i5TzYeFAUCaLie8QAKCRDsC7i5TzYe FAbUB/9lqqvAAoqYZFNxc4BQzVgmt3+Z2hLYIuQx1zitPdHGTBj2ENbTu6NNLF5j6FTBzmirJ+j 5kWQ/7N1uYYPlOnBbW/tYrNcz2IajoY4pq7YpTwHSSiEAqdJJNrouVsDwYZx+N2GjmLi/eYEPbm 7hMM3D6eM/0rqUYfYMg+CmRj1ocp+lDkbTw1Kqmpdyc9EEwhrxKucaYRFd6siGfckla8ZSl7Y/L o+ZPlF0KYu/qi0y3vSwD3/VkYSod9KokIAAMvHrTEM1lkAch7r+ZNeI8sH7Z55Kvr7oIJBdSkEk sTS/LiDN2etUj+G5F1bsAD9P4+GZ0SVdmSYPeF6p0PugqcbX
X-Developer-Key: i=wdouglass@carnegierobotics.com; a=openpgp; fpr=8852A8EB6C32D0C349A0C472EC0BB8B94F361E14
Content-Transfer-Encoding: 8bit

Bindings for the pf530x series of voltage regulators

Signed-off-by: Woodrow Douglass <wdouglass@carnegierobotics.com>
---
 .../devicetree/bindings/regulator/nxp,pf5300.yaml  | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
new file mode 100644
index 000000000000..26cba1f1af62
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
@@ -0,0 +1,52 @@
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
+  The PF5300, PF5301, and PF5302 integrate high-performance buck converters,
+  12 A, 8 A, and 15 A, respectively, to power high-end automotive and industrial
+  processors. With adaptive voltage positioning and a high-bandwidth loop, they
+  offer transient regulation to minimize capacitor requirements.
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
+  additionalProperties: false
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@28 {
+            compatible = "nxp,pf5302";
+            reg = <0x28>;
+
+            regulator-always-on;
+            regulator-boot-on;
+            regulator-max-microvolt = <1200000>;
+            regulator-min-microvolt = <500000>;
+        };
+    };

-- 
2.39.5


