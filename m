Return-Path: <linux-kernel+bounces-798987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688A4B42582
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27125446DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CD42417D4;
	Wed,  3 Sep 2025 15:32:30 +0000 (UTC)
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A991A9F82
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913550; cv=none; b=r3wwM1cdkAE6y8iod37RLmj7Hkhe5qe2DiSpT1eGC73ckmuD/nAQrRyRs92SrwUBbgHxT6tTFUi6GO0VFciorGItsfhxePUQIHbKVgaZ/4zo2lwDZ/eYzQow0jAhv+cwFCvnfdwqlcw+al0k1BJEhYhbblkyj8F73XrZJNf80ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913550; c=relaxed/simple;
	bh=/d6w8eDXv10T8ns9vcqYSr+6RWs1H1c46XHcDTHIQSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhILIQnyGFRcxC1TinbKem3jhAligQJO51oa15ZZ2KSDm9THH+AnfkpqgmOOHgdlR3TTcJgFog/H5xFOYwwNH95o0NxgLsTdvi6dg1C+gg+Q/h3XrJhWMTRagd3V3OyXRRHQy0DN7bJBfbhUDkvkVeiTpbaKYMn9zTvfDHw6XZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com; spf=pass smtp.mailfrom=douglass.dev; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=douglass.dev
Feedback-ID: 3578:1022:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -360649041;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 03 Sep 2025 15:31:53 +0000 (UTC)
From: Woodrow Douglass <wdouglass@carnegierobotics.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Woodrow Douglass <wdouglass@carnegierobotics.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] regulator: pf530x: dt-bindings: nxp,pf530x-regulator
Date: Wed,  3 Sep 2025 11:31:38 -0400
Message-Id: <20250902-pf530x-v3-2-4242e7687761@carnegierobotics.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902-pf530x-v3-0-4242e7687761@carnegierobotics.com>
References: <20250902-pf530x-v3-0-4242e7687761@carnegierobotics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=wdouglass@carnegierobotics.com; h=from:subject:message-id; bh=/d6w8eDXv10T8ns9vcqYSr+6RWs1H1c46XHcDTHIQSQ=; b=owGbwMvMwMX4hnvHTn8zORHG02pJDBk7YsPmsc3td/y4I6I/uPIOD7euvqLE1MW2/8UvH17zz 0o9MfN5J6MxCwMjF4OsmCJLR9CK1zlGFw57LjhSBDOIlQlkCgMXpwBMRE2K/X+1W6tkeUTsZO89 16yNuQyniC92OfM6Nc/c+SbbLqPDAdJHpgvptYim6aX/EQvv0Uz9zsmvfnKhr/l6/ytz/AV7snY d4BG3W7hKpJklfp+44KqOI5uja94WRHmGv7p+YD17u9z0sJX9i6unTxDsTvpqepzlR5X5EoE1nf sfaq4SDO9xawyzm+Flnx0SsXI6dxFzounlnE0cle89p0zqNM16IX58csY7Cdsi8STOQKVDbPeTl 0uuepTf/pfp6dJ123WWPRfllJAW335N/97Jmie16+zKV6eVd36K2ej6bE/Nsq0hk/7EHynh/yhl NLdY3sfbysw1rpPv32mrJFPDPwfT869eDt136sS+/lupAA==
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


