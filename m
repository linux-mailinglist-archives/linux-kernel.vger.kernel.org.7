Return-Path: <linux-kernel+bounces-851402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7400BD65CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7A154EE989
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2F12DE1E6;
	Mon, 13 Oct 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQ8AXQfr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC2134BD;
	Mon, 13 Oct 2025 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391077; cv=none; b=KIls3L1ulcaRXrCFXzNAsWesym0Zq6j6oYmA+82jprkpPE4wnx4M2APx0BNRQLKs+7oa2HNsqn5yFaHqWzDmZwqWhxZ80rZh2LyYqBYLS7eC/tQsn7hyokgFzfnmzJeS6e5mrFAigE7WccQ+Y6w+1q+ot1Xp+TUnlntGd+wcqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391077; c=relaxed/simple;
	bh=CrWinxKED+CCWSwECbbyB6qKhfNCpqxMy3lPdpUdWaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DY0fVdhffzw2+npeatsu4FkVnCMoSEJkLSiyiZowlSDmOXF7nLHujoG4vTVUMVt3ezuQaHRaOaq//oJFnJXQhdrWFDIfDbIYveya4XXvaeTkAXqcWJSnwvetGAbUdxHjKk5oVmHqmRBWmwZ3Pwb8zJl8EsXIKVGe96Vm2R9bano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQ8AXQfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0518DC4CEE7;
	Mon, 13 Oct 2025 21:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760391076;
	bh=CrWinxKED+CCWSwECbbyB6qKhfNCpqxMy3lPdpUdWaU=;
	h=From:To:Cc:Subject:Date:From;
	b=pQ8AXQfrUMz1ufS6fSWiFVWAsIaw/PGCSbdQWbgi+9jgXxlWNjYzHNH6hj4qxWVgE
	 V/Ker9JbYB1u3hoAubbLgVeDawBiJkpP7on97fwxnoyZjuAuagTIhrDIhmoFVwFaDx
	 VPyiuqLmUr4WhZoPDwuFivqj/qaxVpO/PTdxBd0i5QmfkInDJAliPXeRHiSkRHGV25
	 6bhKr/mIbwqwxRLlu4GWrnPvj5pwIJ7lfyUQePsP47CwsjjR1XER+j2ReH4ThGVV3/
	 j1jIrV32S31EFttvZWZogfLnaCRbh2Rm/Skm3HD+z1RDslDTogqcvJn7xBIyc9ZF9M
	 5mgF+5Yp1nZUA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: mailbox: Convert apm,xgene-slimpro-mbox to DT schema
Date: Mon, 13 Oct 2025 16:31:10 -0500
Message-ID: <20251013213112.690055-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert APM X-Gene slimpro-mbox binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../mailbox/apm,xgene-slimpro-mbox.yaml       | 62 +++++++++++++++++++
 .../mailbox/xgene-slimpro-mailbox.txt         | 35 -----------
 2 files changed, 62 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/apm,xgene-slimpro-mbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/apm,xgene-slimpro-mbox.yaml b/Documentation/devicetree/bindings/mailbox/apm,xgene-slimpro-mbox.yaml
new file mode 100644
index 000000000000..815f08d61de8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/apm,xgene-slimpro-mbox.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/apm,xgene-slimpro-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: APM X-Gene SLIMpro mailbox
+
+maintainers:
+  - Khuong Dinh <khuong@os.amperecomputing.com>
+
+description:
+  The APM X-Gene SLIMpro mailbox is used to communicate messages between
+  the ARM64 processors and the Cortex M3 (dubbed SLIMpro). It uses a simple
+  interrupt based door bell mechanism and can exchange simple messages using the
+  internal registers.
+
+properties:
+  compatible:
+    const: apm,xgene-slimpro-mbox
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: mailbox channel 0 doorbell
+      - description: mailbox channel 1 doorbell
+      - description: mailbox channel 2 doorbell
+      - description: mailbox channel 3 doorbell
+      - description: mailbox channel 4 doorbell
+      - description: mailbox channel 5 doorbell
+      - description: mailbox channel 6 doorbell
+      - description: mailbox channel 7 doorbell
+
+  '#mbox-cells':
+    description: Number of mailbox channel.
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
+    mailbox@10540000 {
+        compatible = "apm,xgene-slimpro-mbox";
+        reg = <0x10540000 0xa000>;
+        #mbox-cells = <1>;
+        interrupts = <0x0 0x0 0x4>,
+                     <0x0 0x1 0x4>,
+                     <0x0 0x2 0x4>,
+                     <0x0 0x3 0x4>,
+                     <0x0 0x4 0x4>,
+                     <0x0 0x5 0x4>,
+                     <0x0 0x6 0x4>,
+                     <0x0 0x7 0x4>;
+    };
diff --git a/Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
deleted file mode 100644
index e46451bb242f..000000000000
--- a/Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-The APM X-Gene SLIMpro mailbox is used to communicate messages between
-the ARM64 processors and the Cortex M3 (dubbed SLIMpro). It uses a simple
-interrupt based door bell mechanism and can exchange simple messages using the
-internal registers.
-
-There are total of 8 interrupts in this mailbox. Each used for an individual
-door bell (or mailbox channel).
-
-Required properties:
-- compatible:	Should be as "apm,xgene-slimpro-mbox".
-
-- reg:		Contains the mailbox register address range.
-
-- interrupts:	8 interrupts must be from 0 to 7, interrupt 0 define the
-		the interrupt for mailbox channel 0 and interrupt 1 for
-		mailbox channel 1 and so likewise for the reminder.
-
-- #mbox-cells:	only one to specify the mailbox channel number.
-
-Example:
-
-Mailbox Node:
-		mailbox: mailbox@10540000 {
-			compatible = "apm,xgene-slimpro-mbox";
-			reg = <0x0 0x10540000 0x0 0xa000>;
-			#mbox-cells = <1>;
-			interrupts =  	<0x0 0x0 0x4>,
-					<0x0 0x1 0x4>,
-					<0x0 0x2 0x4>,
-					<0x0 0x3 0x4>,
-					<0x0 0x4 0x4>,
-					<0x0 0x5 0x4>,
-					<0x0 0x6 0x4>,
-					<0x0 0x7 0x4>,
-		};
-- 
2.51.0


