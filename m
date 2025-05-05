Return-Path: <linux-kernel+bounces-632371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DEBAA967F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 16:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEFB189E53B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C21264A85;
	Mon,  5 May 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+xZogyr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8284E2701A8;
	Mon,  5 May 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456509; cv=none; b=pHS3l4LiREZchu7VT2QNJ/vK+D3LtHRbhUEBRfbBFkZwfevUjpXAe6KaUwUGIOtBV4nVjUpfzzkkjsejfND0rxV17EZ+4cWgvZed8IsII7XhaxeG/BnRSSyISeQ9zM6Et4pJ/2cwkLw0QEn7DRCnpxuBOnp+B8Lu4SDINQnnedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456509; c=relaxed/simple;
	bh=iJBGHt/npzUxaGLYucbYNrOJhubSXQWs8CMQPcDC/gI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9Dgp5bdgnRyePiwKb20jD7VPQPbfSVYXtqMDa8ZLVbIpjEgROjsUZXNdsvI6nzmG9CVicZUTELKXvdwvtNMrH6dVpvMdJ3OEP94tZxo+95TUufbs53l+fm1AR67xk/gF+6QcMo9TQO6X5QJB8DpXjPwzEwr3FnmSB8mSmB2gCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+xZogyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F79C4CEE4;
	Mon,  5 May 2025 14:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746456509;
	bh=iJBGHt/npzUxaGLYucbYNrOJhubSXQWs8CMQPcDC/gI=;
	h=From:To:Cc:Subject:Date:From;
	b=o+xZogyr/LVx9m9JH7TLopjZetPVbrgnx3apooVzO0krXivZBYTaRxpvMEXQBBlpn
	 oDWH0hu4+uzUqZdNn2guVbHE6ByQwJAbQxA2bLZkCgv+8V/GCh/Uq72MDWbna+8LXE
	 h3QVio3/OaEppAZp5KRFSQz23lHpW7XgkQx+QA+m9kjBJ9oCGOgbWM9Sw3MuCPhjoF
	 TAEgSIZZfepWcXoMh/YyfSTX7AUQ3hWn8KQ5CYvkqgWHNyQgQtgugkLkz3/JoL9+bS
	 SeQ3MlGLbWuBraJjYICBR1tcsUeTuNMLnXXyZDVJcGchDpjLfx99/UXLJ7T4xYcXnn
	 UIMvMpjO5YMWQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vineet Gupta <vgupta@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: interrupt-controller: Convert snps,arc700-intc to DT schema
Date: Mon,  5 May 2025 09:48:25 -0500
Message-ID: <20250505144826.1292329-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Arc Core interrupt controller binding to schema format. It's
a straight-forward conversion of the typical interrupt controller.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../interrupt-controller/snps,arc700-intc.txt | 24 -----------
 .../snps,arc700-intc.yaml                     | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,arc700-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,arc700-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,arc700-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/snps,arc700-intc.txt
deleted file mode 100644
index 9a5d562435ea..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/snps,arc700-intc.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* ARC700 incore Interrupt Controller
-
-  The core interrupt controller provides 32 prioritised interrupts (2 levels)
-  to ARC700 core.
-
-Properties:
-
-- compatible: "snps,arc700-intc"
-- interrupt-controller: This is an interrupt controller.
-- #interrupt-cells: Must be <1>.
-
-  Single Cell "interrupts" property of a device specifies the IRQ number
-  between 0 to 31
-
-  intc accessed via the special ARC AUX register interface, hence "reg" property
-  is not specified.
-
-Example:
-
-	intc: interrupt-controller {
-		compatible = "snps,arc700-intc";
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,arc700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/snps,arc700-intc.yaml
new file mode 100644
index 000000000000..000a734d997c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/snps,arc700-intc.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/snps,arc700-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARC700 incore Interrupt Controller
+
+maintainers:
+  - Vineet Gupta <vgupta@kernel.org>
+
+description: >
+  The core interrupt controller provides 32 prioritized interrupts (2 levels)
+  to ARC700 core.
+
+  intc accessed via the special ARC AUX register interface, hence "reg" property
+  is not specified.
+
+properties:
+  compatible:
+    const: snps,arc700-intc
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    description: An interrupt number 0-31
+    const: 1
+
+required:
+  - compatible
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller {
+        compatible = "snps,arc700-intc";
+        interrupt-controller;
+        #interrupt-cells = <1>;
+    };
-- 
2.47.2


