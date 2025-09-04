Return-Path: <linux-kernel+bounces-801617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA3B4479E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A967C586FD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF7B2857F8;
	Thu,  4 Sep 2025 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAT5B6tm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB80E284693;
	Thu,  4 Sep 2025 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018682; cv=none; b=cOrrKhrseUybFtyLMudhKx7w1pbk6nu65tcvdDkeqPNtn65WJtfDqBApJAmgsE76V0x9XyS1XZzs9qmq3mDywAl3cDwZoLLGnmHrKJYJE9JxTnjfJhfjoyl+kt9s4zOsa7exvTEjorF7PVu2JvbiOJJ9/uzprtgrGLt4TxECpTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018682; c=relaxed/simple;
	bh=p642EHzHm4x6WUg9UMriU9fjSVNTsDhBO060GMkUkPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTt6HaMLksPzCbALhPv5nsBv95IHoW+AZNpkEBdyMw8m8hRdIghgcvrdOqGQ/YAW9mFsKhu8teyhCGRsGuYyALpo3FflSjAFqJNqZiWLeuWShXl184V+6iICef9uDO/IWKxJLaflnrEUuXrv/SZcyuWBccIpGqRqrEj0oJr/xSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAT5B6tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90320C4CEF6;
	Thu,  4 Sep 2025 20:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757018681;
	bh=p642EHzHm4x6WUg9UMriU9fjSVNTsDhBO060GMkUkPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bAT5B6tmcKucj5UrLsmUb139CXI9XG5rTJFe7HmxeLmz9IOBz8i6xB2O1p+K/OjZY
	 bcLPNPwbllvJa5RKT2dfF5NfqrRImorGEiljobIVdqXETbcN5vE1+FLLu/uIJb/UC9
	 6Iopy2JTd5vt6/KBZSrzBQHlh32gk0bp1mA97uc044gy6CXwVq/Bfyia9VYmtnNrGB
	 VTjBTS+XhhK2T8rU/K5l7mL5u/+T+aPAhIyS9Yb2cl4/bKZX21ye/0GcyDc9m/lYNA
	 0Yz4Z3nY0OZRqcNtIytuhixni/2+87qKR6AytC1s/I1BBQd8V1XMIaXOHRGf9UAeQM
	 aGxVtb91SLRXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F3CCA1012;
	Thu,  4 Sep 2025 20:44:41 +0000 (UTC)
From: Woodrow Douglass via B4 Relay <devnull+wdouglass.carnegierobotics.com@kernel.org>
Date: Thu, 04 Sep 2025 16:44:35 -0400
Subject: [PATCH v6 1/2] regulator: pf530x: dt-bindings:
 nxp,pf530x-regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pf530x-v6-1-ae5efea2198d@carnegierobotics.com>
References: <20250902-pf530x-v6-0-ae5efea2198d@carnegierobotics.com>
In-Reply-To: <20250902-pf530x-v6-0-ae5efea2198d@carnegierobotics.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Woodrow Douglass <wdouglass@carnegierobotics.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954;
 i=wdouglass@carnegierobotics.com; h=from:subject:message-id;
 bh=Ltyt1DbuiWkawifRpmJUYq01xxDkOrXle2C+GGe+I+Y=;
 b=owEBbQGS/pANAwAKAewLuLlPNh4UAcsmYgBoufo4UXlGhoVBkmPhfiOp8qT8NFUuAvVwOblPm
 QeIaUEX/Z+JATMEAAEKAB0WIQSIUqjrbDLQw0mgxHLsC7i5TzYeFAUCaLn6OAAKCRDsC7i5TzYe
 FAqIB/9OCZWELHI72du5/94P/xPyQ0YyjcqXPDB8EWCwahbXGr472p7TqoTcJkGOy0GreCSNabJ
 yDfFyQTnNSo80qgpyV9robwos9n+Mfb/ttTPNMkrz9an2QndRyRwddPnRL3bULlNZ6RPMOrC3qF
 HQdZNtlzNDysM1Pxk49LaTSV802p2Ztg82+PVK4C2wqMN5wXlEb/fm2vCRf5hKgdCVKxeLp/Fte
 VjFtLhn+oweHvtIaHt8mNFkhMy0109Pao5R6n3xUTVztstaKKue80A0b9lauEDe6mSlAdCMRDgP
 exRfa2bKozlLWRFDOThcp5s5gJ3ow4YgT02MkYOjTIrxdzfN
X-Developer-Key: i=wdouglass@carnegierobotics.com; a=openpgp;
 fpr=8852A8EB6C32D0C349A0C472EC0BB8B94F361E14
X-Endpoint-Received: by B4 Relay for wdouglass@carnegierobotics.com/default
 with auth_id=514
X-Original-From: Woodrow Douglass <wdouglass@carnegierobotics.com>
Reply-To: wdouglass@carnegierobotics.com

From: Woodrow Douglass <wdouglass@carnegierobotics.com>

Bindings for the pf530x series of voltage regulators

Signed-off-by: Woodrow Douglass <wdouglass@carnegierobotics.com>
---
 .../devicetree/bindings/regulator/nxp,pf5300.yaml  | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
new file mode 100644
index 000000000000..5b9d5d4e48d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
@@ -0,0 +1,54 @@
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
+allOf:
+  - $ref: regulator.yaml#
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
+unevaluatedProperties: false
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



