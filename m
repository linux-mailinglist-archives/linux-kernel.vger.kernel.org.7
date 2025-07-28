Return-Path: <linux-kernel+bounces-748279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB81B13EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DC13A804F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B49274B53;
	Mon, 28 Jul 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHpK8ukb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014B274672;
	Mon, 28 Jul 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717179; cv=none; b=dAR4Lz/V2MO1/MQXJMcoCei0cLopsXTu8qEKnWSP6VVBTmJQBZleRUj2IcSu9U8xdBGzYbBSjuyez94K5yZxf+hcbefItOeXDAHRgpDbz+hkPRQRIdu5UiYz1JuY+LFNny7nruLmlCX8yqpjMWhvj0jJKkgbp7uRbYn53VM2BYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717179; c=relaxed/simple;
	bh=2dlmVNDzFn4SKLMFjpyPd+qPrj8XTn0qgn+ou7n4k0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mf/BXzWFIxHEE9uyhh5NIb0utsqLybbNhIqLr/+WnrazSFAVFpnZGvDn29cLR9nxob/p8YG0i3cOLvwtxq/eifc8PSKQDnuR3zu8co29EwZpBcGcfBsnotEt1zwTt52A0T7kNT95EdXbTrHwDlG1qDcdrjB3Xvm9clChpa1YZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHpK8ukb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1EC3C4CEF8;
	Mon, 28 Jul 2025 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753717178;
	bh=2dlmVNDzFn4SKLMFjpyPd+qPrj8XTn0qgn+ou7n4k0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RHpK8ukbmXFHqSRy6a9GoPtJqrX5d5xh9fGJt1jmQEcHilwQgxOlRd41GiZ/+w0l6
	 Q1wbe6gTmgpNVh83fwJBJBPKo6mz80tv+F9MarBxUqO588yKE9AakjC2jr8FIw63Qt
	 QvHDYn7upFrmTWqJJlIyS9Jh+8M/Mddx9qxi6mOGZIK7kEbvGvhD+aA+NR7KVz7ZGl
	 2rCx1gE1wbbhAc84k04ZC8FnRvvnYPv2WotOaEy6Fc0cjtGqVS8o9yDpu11tUjq2OJ
	 WryDd6VwBVYzpuM7M/3A16SxL4/8E3ACV3xJgiM3I/5ofT6sY0q9fNS12WvGTqhGKY
	 ogHt4vfhSuASQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00F0C83F17;
	Mon, 28 Jul 2025 15:39:38 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 28 Jul 2025 17:39:29 +0200
Subject: [PATCH 1/2] dt-bindings: phy: add support for NXPs TJA1145 CAN
 transceiver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-tja1145-support-v1-1-ebd8494d545c@liebherr.com>
References: <20250728-tja1145-support-v1-0-ebd8494d545c@liebherr.com>
In-Reply-To: <20250728-tja1145-support-v1-0-ebd8494d545c@liebherr.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753717177; l=2250;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=yrzBTmcx39zZhA3B4Bmom+/Ve4V+seQpPo+U7ONsiAo=;
 b=KhSNFKffrIFnWTTO5yAeLdNiDimIL6feKrhTGJYwDBLXzqpYOUY4N+2UQtYk8nL2VCutAXa6J
 Psy8g12k+CxCavpUNWBF14bOtn8HX2E64ftVkl10v0ieITrJjqSGBbK
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Adding documentation for NXPs TJA1145 CAN transceiver.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 .../devicetree/bindings/phy/nxp,tja1145-can.yaml   | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml b/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..10bf2bce1b35788b3284c42e544a56eda6d79947
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/nxp,tja1145-can.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TJA1145 CAN transceiver
+
+maintainers:
+  - Dimitri Fedrau <dimitri.fedrau@liebherr.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: nxp,tja1145
+
+  "#phy-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 4000000
+
+  spi-cpha: true
+
+  spi-cs-setup-delay-ns:
+    minimum: 50
+    default: 50
+
+  spi-cs-hold-delay-ns:
+    minimum: 50
+    default: 50
+
+  spi-cs-inactive-delay-ns:
+    minimum: 250
+    default: 250
+
+  vcc-supply:
+    description:
+      CAN transceiver supply voltage
+
+  vio-supply:
+    description:
+      Supply voltage for I/O level adaptor
+
+  vbat-supply:
+    description:
+      Battery supply voltage
+
+required:
+  - compatible
+  - "#phy-cells"
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        canphy@0 {
+            compatible = "nxp,tja1145";
+            #phy-cells = <0>;
+            reg = <0>;
+            spi-max-frequency = <4000000>;
+            spi-cpha;
+            spi-cs-setup-delay-ns = <50>;
+            spi-cs-hold-delay-ns = <50>;
+            spi-cs-inactive-delay-ns = <250>;
+            vcc-supply = <&reg_5v0>;
+            vio-supply = <&reg_3v3>;
+            vbat-supply = <&reg_24v0>;
+        };
+    };

-- 
2.39.5



