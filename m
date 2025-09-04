Return-Path: <linux-kernel+bounces-800910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B15B43D9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD1BE4E5A91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D343303C8F;
	Thu,  4 Sep 2025 13:47:16 +0000 (UTC)
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3927C3002B7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993635; cv=none; b=i0Xo8/AbJuXCXYWFuoqN9Lg63P48IJ39FdctOp7vwtKztiBUPKUymPBL2c5QveKTuY+dKobcwYCZRYci9S/6L3kylbo45Z96pKk+pHAdyVZpWtg8ZkO6DulxXK4x0ojgfLRsTySsbEW5YO813QZyZsQXesrCFi6y77/r7J/YxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993635; c=relaxed/simple;
	bh=313xgOa50TqeHlIyjdVLh5YsJ07aec4ygcAkRRcDZNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+nmnoQRsT04iK33KG0yR5ohsxC97TlSTeOxYzvjQcPCbiUgLs2QGlPAbsdMrcVibBFm1U1Agjgr5hkGtjx86PbSxyWnJCm5AlrT7TQgQznJLUUL9sPpEwNx5v5j9oPdBSAe0tNZ7gUx9NaN9F/fh2LZRLF5u5/GVLY0TvGUjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com; spf=pass smtp.mailfrom=douglass.dev; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=douglass.dev
Feedback-ID: 3578:1022:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 240022050;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 04 Sep 2025 13:47:00 +0000 (UTC)
From: Woodrow Douglass <wdouglass@carnegierobotics.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Woodrow Douglass <wdouglass@carnegierobotics.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 1/2] regulator: pf530x: dt-bindings: nxp,pf530x-regulator
Date: Thu,  4 Sep 2025 09:46:50 -0400
Message-Id: <20250902-pf530x-v5-1-658c403e6a52@carnegierobotics.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902-pf530x-v5-0-658c403e6a52@carnegierobotics.com>
References: <20250902-pf530x-v5-0-658c403e6a52@carnegierobotics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=wdouglass@carnegierobotics.com; h=from:subject:message-id; bh=313xgOa50TqeHlIyjdVLh5YsJ07aec4ygcAkRRcDZNc=; b=owEBbQGS/pANAwAKAewLuLlPNh4UAcsmYgBouZU5PFoE7KcLpFUch/tGXJw87ePS2B89GQVpW Bu9Q6w/UgOJATMEAAEKAB0WIQSIUqjrbDLQw0mgxHLsC7i5TzYeFAUCaLmVOQAKCRDsC7i5TzYe FIYNCACZJ+va/QooNoLqtJFwbhtLUbwl9uhvVTR36FE8nUYGK1TM6H7vqI0hm6P7EATxTlrKy8O +3SedifBJCLF29FQr3mOfZSbOifxxmw6HCeg1FSRCpoyhyM0oeBIWjCJWC20TF7e1HlcpnTu1oY j0+siLLCMtZwzuMjrM5+/yXPzVBnFITabwUUX69kFIW6m69TzKsXk961Y7HfyU/k+LWcRoNTYzx uVhDqbQ3av1rA760hoGftImwhGOVwAvWh/119TjcDmKEI93KK6zS8tvqYFw5sEhM/0QkeiiDDeC wSWf8WQMw1BvvcqTzSK1nvHvVhhDWqg795j7iJKDJuWsIoFJ
X-Developer-Key: i=wdouglass@carnegierobotics.com; a=openpgp; fpr=8852A8EB6C32D0C349A0C472EC0BB8B94F361E14
Content-Transfer-Encoding: 8bit

Bindings for the pf530x series of voltage regulators

Signed-off-by: Woodrow Douglass <wdouglass@carnegierobotics.com>
---
 .../devicetree/bindings/regulator/nxp,pf5300.yaml  | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
new file mode 100644
index 000000000000..72f2f7fd2c68
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/nxp,pf5300.yaml#
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
+    oneOf:
+      - const: nxp,pf5300
+      - items:
+          - enum:
+              - nxp,pf5301
+              - nxp,pf5302
+          - const: nxp,pf5300
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: true
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@28 {
+            compatible = "nxp,pf5302", "nxp,pf5300";
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


