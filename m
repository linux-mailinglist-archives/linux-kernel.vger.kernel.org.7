Return-Path: <linux-kernel+bounces-765401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA298B23285
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF22188D9D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92E32F83A1;
	Tue, 12 Aug 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDaSZs++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7892882CE;
	Tue, 12 Aug 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022440; cv=none; b=IwZS4c4o/rejoVOMINr18YNA54ljODtW3LKHKift+z32gCXYuVtd4sm6DHCZDUtB+ucTpZi9cImiX+0BZRzq0uONMDoR+IERtmu6YqFdqjWpE+evGI8DQOodtkaY1syJw3o4YODCKXrOtPANJg/DWR1MVTJ2EMiqizWw99+m1Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022440; c=relaxed/simple;
	bh=3v9Hv4uuLaErrRPz9Jm/wIREVS1+3NyzGODuvf0X8iU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BLtDGW7Nd8SvquCxiel6Xa8WiLOK1TXpC0psQP6tUvD8bL85feZKl5Kktmz4DH7GgnwCM/fNraQR8yY80XUTFGgqqIC3bQ0SdZHGN0Y1MSjKaSId7j8L6d14jFFUP0DcAXq1xGUMtsPljZ2pMaYm7uXKbgJQuUVLvVDpHZb3wBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDaSZs++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC604C4CEF1;
	Tue, 12 Aug 2025 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755022439;
	bh=3v9Hv4uuLaErrRPz9Jm/wIREVS1+3NyzGODuvf0X8iU=;
	h=From:To:Cc:Subject:Date:From;
	b=mDaSZs++4mAijcpbD8kzKL/ZHgFTE79gRmcDdm5vtZpr9uuqYq4SgmmUPIbJf6JaA
	 DS/MLIbNdCPGq8YM2ieCeAdK0Uk8aTtl0n/qBDgKJYrfS0WAHDXUXbnic5LYF8Gvvb
	 0ZJ0VWBHCmtsR3yrnB9MhVjAnflEKR50Sqy9c0u5HNMKce/tDesDhW3NPAzxHMJrf5
	 a2O1BjkT5oWCQlCONyrE3F5uZ7coWbV83Ky9YKoIvqE5p8zs7s3XqGDdDeSreZZeRX
	 /z7ZXoKHAKn+ycXf7H7SlJH3+jxSjzsmgid1rhLN+FXBGAxU2I/aWwfdWrMEOcIZ2B
	 LjRiZ/iYVuM2Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: mailbox: Convert marvell,armada-3700-rwtm-mailbox to DT schema
Date: Tue, 12 Aug 2025 13:13:53 -0500
Message-ID: <20250812181357.63395-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Marvell Armada 3700 rWTM mailbox binding to DT schema
format. It's a straightforward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../marvell,armada-3700-rwtm-mailbox.txt      | 16 -------
 .../marvell,armada-3700-rwtm-mailbox.yaml     | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mailbox/marvell,armada-3700-rwtm-mailbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,armada-3700-rwtm-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/marvell,armada-3700-rwtm-mailbox.txt b/Documentation/devicetree/bindings/mailbox/marvell,armada-3700-rwtm-mailbox.txt
deleted file mode 100644
index 282ab81a4ea6..000000000000
--- a/Documentation/devicetree/bindings/mailbox/marvell,armada-3700-rwtm-mailbox.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-* rWTM BIU Mailbox driver for Armada 37xx
-
-Required properties:
-- compatible:	must be "marvell,armada-3700-rwtm-mailbox"
-- reg:		physical base address of the mailbox and length of memory mapped
-		region
-- interrupts:	the IRQ line for the mailbox
-- #mbox-cells:	must be 1
-
-Example:
-	rwtm: mailbox@b0000 {
-		compatible = "marvell,armada-3700-rwtm-mailbox";
-		reg = <0xb0000 0x100>;
-		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
-		#mbox-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/mailbox/marvell,armada-3700-rwtm-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/marvell,armada-3700-rwtm-mailbox.yaml
new file mode 100644
index 000000000000..0a07ed1b1beb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/marvell,armada-3700-rwtm-mailbox.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/marvell,armada-3700-rwtm-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 3700 rWTM Mailbox
+
+maintainers:
+  - Marek Behún <kabel@kernel.org>
+
+properties:
+  compatible:
+    const: marvell,armada-3700-rwtm-mailbox
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#mbox-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#mbox-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mailbox@b0000 {
+        compatible = "marvell,armada-3700-rwtm-mailbox";
+        reg = <0xb0000 0x100>;
+        interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+        #mbox-cells = <1>;
+    };
-- 
2.47.2


