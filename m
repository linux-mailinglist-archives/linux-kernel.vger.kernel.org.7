Return-Path: <linux-kernel+bounces-758393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC2EB1CE67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08ED44E0193
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE37227563;
	Wed,  6 Aug 2025 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOuVpqo9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4EC22577E;
	Wed,  6 Aug 2025 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515708; cv=none; b=BvWcbYC4ljYgsDF//b7j/j/2Le/2pYoFjT2fynEGJdg3mMe5DtgcX2owzYZSkaWZ1H8xGF0UR8A1hGX6OtvP9OBDc1Wo7APBXlTD+pJDBOGI/K4qXgMHvWeeaNE8gUO1uQfD90rsDFwr46gayFCHFQCiUV4SZZjKqFF2pKkM6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515708; c=relaxed/simple;
	bh=21xpyzPK1VoPmhAptjeM1xFg2OZkfCF6vLurfNbjVkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8fBtOfzY41LxPKfuAUofiE9O59kgsF9MY15/7CPkfHFUWRClHNnkj/xD2cPpomhXTH2VmLstti+Aot3+POP3OQxqXlmZeqGVTiWBM9e8uWwsjO/qw4Yd4XJnn9jCtRA4O9N0w1deSWivmi0otQ6UFzl6zFjQUB2duSJnhbVMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOuVpqo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575F4C4CEE7;
	Wed,  6 Aug 2025 21:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754515708;
	bh=21xpyzPK1VoPmhAptjeM1xFg2OZkfCF6vLurfNbjVkQ=;
	h=From:To:Cc:Subject:Date:From;
	b=NOuVpqo9s3/+DOw8hsbxuEne6c61pq/YK6G5fsAL+W8ztYLGk9xBrnu8sc0CIejyh
	 GVNRhI3lklWnGYHTGbunYDqeqefxCIPxHAq6FLf6VADUtr73XCrCmIHhkWiraPD2gD
	 nR2Anqo7Cok0XrSj08SBLStlHE8cY6I3s3K4FuEYA2ez6ViKkvL0qMdfGr6fOGLYkr
	 q62NwIaYbXbkQqOE7SltOsP2Vy88oG9oOLIuMA2kemuNXP+aHKW1U4oTQt8Qq/piSG
	 CPaKvWZNZNy832T2bgOZkZVKnZMOhcLkXp96DxRcOJiBPDaqsk1/uN/lriILzFJLeA
	 NSewonyZzDEDA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Convert ti,keystone to DT schema
Date: Wed,  6 Aug 2025 16:28:23 -0500
Message-ID: <20250806212824.1635084-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/arm/keystone/keystone.txt        | 42 -------------------
 .../bindings/arm/ti/ti,keystone.yaml          | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/keystone/keystone.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/ti,keystone.yaml

diff --git a/Documentation/devicetree/bindings/arm/keystone/keystone.txt b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
deleted file mode 100644
index f310bad04483..000000000000
--- a/Documentation/devicetree/bindings/arm/keystone/keystone.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-TI Keystone Platforms Device Tree Bindings
------------------------------------------------
-
-Boards with Keystone2 based devices (TCI66xxK2H) SOC shall have the
-following properties.
-
-Required properties:
- - compatible: All TI specific devices present in Keystone SOC should be in
-   the form "ti,keystone-*". Generic devices like gic, arch_timers, ns16550
-   type UART should use the specified compatible for those devices.
-
-SoC families:
-
-- Keystone 2 generic SoC:
-   compatible = "ti,keystone"
-
-SoCs:
-
-- Keystone 2 Hawking/Kepler
-   compatible = "ti,k2hk", "ti,keystone"
-- Keystone 2 Lamarr
-   compatible = "ti,k2l", "ti,keystone"
-- Keystone 2 Edison
-   compatible = "ti,k2e", "ti,keystone"
-- K2G
-   compatible = "ti,k2g", "ti,keystone"
-
-Boards:
--  Keystone 2 Hawking/Kepler EVM
-   compatible = "ti,k2hk-evm", "ti,k2hk", "ti,keystone"
-
--  Keystone 2 Lamarr EVM
-   compatible = "ti,k2l-evm", "ti, k2l", "ti,keystone"
-
--  Keystone 2 Edison EVM
-   compatible = "ti,k2e-evm", "ti,k2e", "ti,keystone"
-
--  K2G EVM
-   compatible = "ti,k2g-evm", "ti,k2g", "ti-keystone"
-
--  K2G Industrial Communication Engine EVM
-   compatible = "ti,k2g-ice", "ti,k2g", "ti-keystone"
diff --git a/Documentation/devicetree/bindings/arm/ti/ti,keystone.yaml b/Documentation/devicetree/bindings/arm/ti/ti,keystone.yaml
new file mode 100644
index 000000000000..20d4084f4506
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/ti,keystone.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ti/ti,keystone.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI Keystone Platforms
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+  - Santosh Shilimkar <ssantosh@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - description: K2G
+        items:
+          - enum:
+              - ti,k2g-evm
+              - ti,k2g-ice
+          - const: ti,k2g
+          - const: ti,keystone
+      - description: Keystone 2 Edison
+        items:
+          - enum:
+              - ti,k2e-evm
+          - const: ti,k2e
+          - const: ti,keystone
+      - description: Keystone 2 Lamarr
+        items:
+          - enum:
+              - ti,k2l-evm
+          - const: ti,k2l
+          - const: ti,keystone
+      - description: Keystone 2 Hawking/Kepler
+        items:
+          - enum:
+              - ti,k2hk-evm
+          - const: ti,k2hk
+          - const: ti,keystone
+
+additionalProperties: true
-- 
2.47.2


