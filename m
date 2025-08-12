Return-Path: <linux-kernel+bounces-765403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD5CB2322B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890567AEF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87D92FE597;
	Tue, 12 Aug 2025 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIDlMPs7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051162FDC35;
	Tue, 12 Aug 2025 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022458; cv=none; b=GXB+Ragcs9nUveiXONP5+Bfwr64cBnBnwwGkKsyfVr6gE8yLMLoeeRUl0hzeeD8ijKKlsTCXW3s4OZibAsu6o6uzXwjucLNRvzkwydcFxqHkUOE583CLPPO6yJpN71+0Vt5J/9HmsQ97tKVktlgfzx4nUOkaNl+QHD3ZMVt2jgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022458; c=relaxed/simple;
	bh=ThHGHTyzwNeckqRjA6jFRanhR25pKbOAfjn7DiPYiL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5LjBxHbIKlJa+O1r/mQMrorAQ8kWIse6J/JJdc3U8tsWQ7GacHWf/R/8oxngzHGPz9/Q5n171XNqTNXvIXPT85TA/oihKbJksMq/YEDjKB51m8R9D6gaBet3pDW/BxHWzuefbN4bXswKQkdoZGG0X4KyJCPjdTKh1AXKGsvqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIDlMPs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC5DC4CEF0;
	Tue, 12 Aug 2025 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755022457;
	bh=ThHGHTyzwNeckqRjA6jFRanhR25pKbOAfjn7DiPYiL8=;
	h=From:To:Cc:Subject:Date:From;
	b=XIDlMPs7R+aaNs2og+lWVsCgec3C3MWWFZeOVfXg4PzYpKJwQ6KMkQR+F2qwxadaY
	 KlSTJbOS+PDCCnbObUpzc/HpBCXAZo8QMZRGmspB1PWGMFiG4pUJxt5/uB54N714Gq
	 ha7chKgIWEYnu2Gf/gGmPorB7hpTCldAgfuYYwYmHe2Q1vu/hlPJ3WPF/VH5OX2WRl
	 /HU0Jd9IwNdim9WiYUSzaF0tRpMmdllCqLNcU1OcqhEr4BDW7WRIIkUr4mLIQ9w5o8
	 vOGvR1ekdEL7TdkOmqIRZCXHs+Hdb7oMr20YWxVLzB69WFF8Unt5Y0Rsd9Hyn+u42p
	 efwIboJK1vWkQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: mailbox: Convert brcm,iproc-flexrm-mbox to DT schema
Date: Tue, 12 Aug 2025 13:14:13 -0500
Message-ID: <20250812181415.66923-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Broadcom FlexRM Ring Manager binding to DT schema format.
It's a straightforward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../mailbox/brcm,iproc-flexrm-mbox.txt        | 59 -----------------
 .../mailbox/brcm,iproc-flexrm-mbox.yaml       | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
deleted file mode 100644
index bf0c998b8603..000000000000
--- a/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-Broadcom FlexRM Ring Manager
-============================
-The Broadcom FlexRM ring manager provides a set of rings which can be
-used to submit work to offload engines. An SoC may have multiple FlexRM
-hardware blocks. There is one device tree entry per FlexRM block. The
-FlexRM driver will create a mailbox-controller instance for given FlexRM
-hardware block where each mailbox channel is a separate FlexRM ring.
-
-Required properties:
---------------------
-- compatible:	Should be "brcm,iproc-flexrm-mbox"
-- reg:		Specifies base physical address and size of the FlexRM
-		ring registers
-- msi-parent:	Phandles (and potential Device IDs) to MSI controllers
-		The FlexRM engine will send MSIs (instead of wired
-		interrupts) to CPU. There is one MSI for each FlexRM ring.
-		Refer devicetree/bindings/interrupt-controller/msi.txt
-- #mbox-cells:	Specifies the number of cells needed to encode a mailbox
-		channel. This should be 3.
-
-		The 1st cell is the mailbox channel number.
-
-		The 2nd cell contains MSI completion threshold. This is the
-		number of completion messages for which FlexRM will inject
-		one MSI interrupt to CPU.
-
-		The 3rd cell contains MSI timer value representing time for
-		which FlexRM will wait to accumulate N completion messages
-		where N is the value specified by 2nd cell above. If FlexRM
-		does not get required number of completion messages in time
-		specified by this cell then it will inject one MSI interrupt
-		to CPU provided at least one completion message is available.
-
-Optional properties:
---------------------
-- dma-coherent:	Present if DMA operations made by the FlexRM engine (such
-		as DMA descriptor access, access to buffers pointed by DMA
-		descriptors and read/write pointer updates to DDR) are
-		cache coherent with the CPU.
-
-Example:
---------
-crypto_mbox: mbox@67000000 {
-	compatible = "brcm,iproc-flexrm-mbox";
-	reg = <0x67000000 0x200000>;
-	msi-parent = <&gic_its 0x7f00>;
-	#mbox-cells = <3>;
-};
-
-crypto@672c0000 {
-	compatible = "brcm,spu2-v2-crypto";
-	reg = <0x672c0000 0x1000>;
-	mboxes = <&crypto_mbox 0 0x1 0xffff>,
-		 <&crypto_mbox 1 0x1 0xffff>,
-		 <&crypto_mbox 16 0x1 0xffff>,
-		 <&crypto_mbox 17 0x1 0xffff>,
-		 <&crypto_mbox 30 0x1 0xffff>,
-		 <&crypto_mbox 31 0x1 0xffff>;
-};
diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.yaml b/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.yaml
new file mode 100644
index 000000000000..c801bd2e95f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/brcm,iproc-flexrm-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom FlexRM Ring Manager
+
+maintainers:
+  - Ray Jui <rjui@broadcom.com>
+  - Scott Branden <sbranden@broadcom.com>
+
+description:
+  The Broadcom FlexRM ring manager provides a set of rings which can be used to
+  submit work to offload engines. An SoC may have multiple FlexRM hardware
+  blocks. There is one device tree entry per FlexRM block. The FlexRM driver
+  will create a mailbox-controller instance for given FlexRM hardware block
+  where each mailbox channel is a separate FlexRM ring.
+
+properties:
+  compatible:
+    const: brcm,iproc-flexrm-mbox
+
+  reg:
+    maxItems: 1
+
+  msi-parent:
+    maxItems: 1
+
+  '#mbox-cells':
+    description: >
+      The 1st cell is the mailbox channel number.
+
+      The 2nd cell contains MSI completion threshold. This is the number of
+      completion messages for which FlexRM will inject one MSI interrupt to CPU.
+
+      The 3rd cell contains MSI timer value representing time for which FlexRM
+      will wait to accumulate N completion messages where N is the value
+      specified by 2nd cell above. If FlexRM does not get required number of
+      completion messages in time specified by this cell then it will inject one
+      MSI interrupt to CPU provided at least one completion message is
+      available.
+    const: 3
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - msi-parent
+  - '#mbox-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    mailbox@67000000 {
+        compatible = "brcm,iproc-flexrm-mbox";
+        reg = <0x67000000 0x200000>;
+        msi-parent = <&gic_its 0x7f00>;
+        #mbox-cells = <3>;
+        dma-coherent;
+    };
-- 
2.47.2


