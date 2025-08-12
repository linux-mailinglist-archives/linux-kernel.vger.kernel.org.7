Return-Path: <linux-kernel+bounces-765402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D7FB23282
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B714E16BF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1912ED17F;
	Tue, 12 Aug 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4o67Izq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A4F2E285E;
	Tue, 12 Aug 2025 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022449; cv=none; b=lyTkbCJsu3CdimLhbAi4OHm+cpc6txyYiL/xC6znF9UEycyy4uu9GhS5TGmscG0vXaZr5BirXDcTIx7giIeoL+vAV+BU8GV0u9kmnVbRrY4FEHV/4R6m3K7RXm408t4EcTgNCp8UA7l3FPs0clnDmGltYFUwCxasmuViDj7FCaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022449; c=relaxed/simple;
	bh=2HcrAtW1n+j1v5rCttzhJ6ANTPblo/LyGNkzIEeCNj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwEbtXDxAtEMBnWco23csaYoqrGac2gHF+ytJNWRw8+bQT6pvpHa+nuec5VfYTB0bgskFS4iu0Kk6uubSUOeDuVmrHYqP64Eo5GNd7dtIfqL/WLxj53swu6xHZzlmIx3IlRnANj7AwT/GAH7z5bBy7MzSOper4eYBGTdUOaTxVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4o67Izq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41965C4CEF1;
	Tue, 12 Aug 2025 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755022449;
	bh=2HcrAtW1n+j1v5rCttzhJ6ANTPblo/LyGNkzIEeCNj4=;
	h=From:To:Cc:Subject:Date:From;
	b=N4o67IzqOZ/ryfiqkNPCawiGI7IpviogOApP9QbMXTWSl0qVeiJJojDUcbqHZr/Tj
	 pjDeOjwgPF28MqVSq/WELXbLzYyx8RFYAfyF/ZGLun/HD5krkwa2m70LIo6Rqa7frH
	 nHSgsZfur/klpkbnnIv9+0O59+1CmbUXEul1fG2roD3oTd9yb5Ui0sEVXRgAOPi80e
	 S8JOX8CtZCe5YyheNTtBsFswdpmyPCkwVn9eeQUwQat6aYdxshulP4bPEAvOGTkk5h
	 Z7m5oq35QgGmCzEWFuIdceC1x7odgE8OL+4q8Fy9LZC6/UO1/tDFmMZeyD9L1hXk5k
	 7twqdQpddEf5Q==
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
Subject: [PATCH] dt-bindings: mailbox: Convert brcm,iproc-pdc-mbox to DT schema
Date: Tue, 12 Aug 2025 13:14:04 -0500
Message-ID: <20250812181406.65390-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Broadcom iProc PDC mailbox binding to DT schema format. It's
a straightforward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/mailbox/brcm,iproc-pdc-mbox.txt  | 25 -------
 .../bindings/mailbox/brcm,iproc-pdc-mbox.yaml | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
deleted file mode 100644
index 9bcdf2087625..000000000000
--- a/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-The PDC driver manages data transfer to and from various offload engines
-on some Broadcom SoCs. An SoC may have multiple PDC hardware blocks. There is
-one device tree entry per block.  On some chips, the PDC functionality is
-handled by the FA2 (Northstar Plus).
-
-Required properties:
-- compatible : Should be "brcm,iproc-pdc-mbox" or "brcm,iproc-fa2-mbox" for
-  FA2/Northstar Plus.
-- reg: Should contain PDC registers location and length.
-- interrupts: Should contain the IRQ line for the PDC.
-- #mbox-cells: 1
-- brcm,rx-status-len: Length of metadata preceding received frames, in bytes.
-
-Optional properties:
-- brcm,use-bcm-hdr:  present if a BCM header precedes each frame.
-
-Example:
-	pdc0: iproc-pdc0@612c0000 {
-		compatible = "brcm,iproc-pdc-mbox";
-		reg = <0 0x612c0000 0 0x445>;  /* PDC FS0 regs */
-		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-		#mbox-cells = <1>;   /* one cell per mailbox channel */
-		brcm,rx-status-len = <32>;
-		brcm,use-bcm-hdr;
-	};
diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.yaml b/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.yaml
new file mode 100644
index 000000000000..5534ae07c9fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/brcm,iproc-pdc-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom iProc PDC mailbox
+
+maintainers:
+  - Ray Jui <rjui@broadcom.com>
+  - Scott Branden <sbranden@broadcom.com>
+
+description:
+  The PDC driver manages data transfer to and from various offload engines on
+  some Broadcom SoCs. An SoC may have multiple PDC hardware blocks. There is one
+  device tree entry per block. On some chips, the PDC functionality is handled
+  by the FA2 (Northstar Plus).
+
+properties:
+  compatible:
+    enum:
+      - brcm,iproc-pdc-mbox
+      - brcm,iproc-fa2-mbox
+
+  reg:
+    maxItems: 1
+
+  dma-coherent: true
+
+  interrupts:
+    maxItems: 1
+
+  '#mbox-cells':
+    const: 1
+
+  brcm,rx-status-len:
+    description:
+      Length of metadata preceding received frames, in bytes.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  brcm,use-bcm-hdr:
+    type: boolean
+    description:
+      Present if a BCM header precedes each frame.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#mbox-cells'
+  - brcm,rx-status-len
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mailbox0@612c0000 {
+        compatible = "brcm,iproc-pdc-mbox";
+        reg = <0x612c0000 0x445>;
+        interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+        #mbox-cells = <1>;
+        brcm,rx-status-len = <32>;
+        brcm,use-bcm-hdr;
+    };
-- 
2.47.2


