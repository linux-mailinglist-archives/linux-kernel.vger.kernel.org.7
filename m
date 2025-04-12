Return-Path: <linux-kernel+bounces-601375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10BBA86D10
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 14:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1989A08BB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 12:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3C71E5B8B;
	Sat, 12 Apr 2025 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7S/0h80"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3E18A6A6;
	Sat, 12 Apr 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744462589; cv=none; b=hXM5InyaTB/555i+zsJuYc192ukwtszxKBIDDVLtyXBqOvK64IEizjjwCGgXGJwkDceJz+U3JHYFCPUdAKSxCaMDyisbRSshqgw/hq9+z9OJFvXDhyvldAjMtL2Lm+QMN0olBxLGri9UTdriH63W+wbuiYDdvYOLtk6pRTAFrXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744462589; c=relaxed/simple;
	bh=SHnwNWu7xt8fZuwaZKfVYCSk1BP9AwdiVTAa2k1Ud58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZC4pyhXSY8YBrNLKxVAnwjoTXT07cwxWLEI84baIxZAUFVu3APCrqwOyT+zu2DrcnbrvjpNaVAEFOGXVHHbGR3O/UGonHReHBwuP1efmiKvemJv/vRlrhmShr76fTj3qZXnkT/HTx2IXseVzhPVOn2adqhkTdQuS3Sd3N9S5PJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7S/0h80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6A66C4CEE3;
	Sat, 12 Apr 2025 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744462588;
	bh=SHnwNWu7xt8fZuwaZKfVYCSk1BP9AwdiVTAa2k1Ud58=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=R7S/0h80VKGMnhyRPw1Ey4P1fHvAbJhh7FEUlbHfLkwh0FHqI7il55aM3KPClXWz+
	 g0bH3kHuSkORqJGHZMkiw4JOI2wt4JwgYtLL/KP5TBM+alClgpEeC0Xx4jtrpSGHx0
	 W1aXb3YSgLcaDYkO/c00o5746pmtnlHveCgCi8aPQbSMAnGZFGFPXR+NrT4zBN911h
	 fLYlXDBItpwYJCuZ5vGwoYTPzTwpSH4HvFBK6Ui2ApX7Q0L80kQwn62ac0NJMNWQ8n
	 s9c9VmQe2u/esUDT7kssFc3DaZ/d4bqu66mlJoob6Ti66DtlO+G+FGkn7J1EkhEm87
	 c10Fsf/iIiAIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB20C369A1;
	Sat, 12 Apr 2025 12:56:28 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sat, 12 Apr 2025 14:56:20 +0200
Subject: [PATCH v2] dt-bindings: timer: Convert fsl,gtm to YAML
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250412-gtm-yaml-v2-1-e4d2292ffefc@posteo.net>
X-B4-Tracking: v=1; b=H4sIAPNi+mcC/0XMQQrDIBCF4auEWXeKGiXYVe8RsjB1mghNDCrSE
 Lx7bSh0+T8e3wGRgqMIt+aAQNlF59ca4tLAYzbrROhsbRBMKCY4wyktuJvlhaPkRstOWTa2UO9
 boKd7n1Q/1J5dTD7sp5z5d/0hQv2RzJGjJWVNJ7SWLbtvPiby15USDKWUD0ThHumhAAAA
X-Change-ID: 20250210-gtm-yaml-b41a9475d0b3
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744462587; l=4462;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=9whPopX6S651IhYCNC5/C4r5vNx8pM5oAbuAUI21Hkk=;
 b=RekIsWZBByF0qTa57/6Jump/9caAL+Qr6JFsGCnxao65Vijt3l3H+yW7HThnUe8W0rWzlQ3Ub
 mYZxuxI9qp8DGEiGZMz8XcbJlIFzAocgFhcZFsjDZFM1Qa19pNASMBM
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Convert fsl,gtm.txt to YAML so that device trees using a Freescale
General-purpose Timers Module can be properly validated.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v2:
- Add Rob Herring's review tag
- Rebase on v6.15-rc1
- Link to v1: https://lore.kernel.org/r/20250225-gtm-yaml-v1-1-de5da7299430@posteo.net
---
 .../devicetree/bindings/timer/fsl,gtm.txt          | 30 --------
 .../devicetree/bindings/timer/fsl,gtm.yaml         | 83 ++++++++++++++++++++++
 2 files changed, 83 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,gtm.txt b/Documentation/devicetree/bindings/timer/fsl,gtm.txt
deleted file mode 100644
index fc1c571f74123d2293bf5c3af3197000d46a07ee..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/timer/fsl,gtm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Freescale General-purpose Timers Module
-
-Required properties:
-  - compatible : should be
-    "fsl,<chip>-gtm", "fsl,gtm" for SOC GTMs
-    "fsl,<chip>-qe-gtm", "fsl,qe-gtm", "fsl,gtm" for QE GTMs
-    "fsl,<chip>-cpm2-gtm", "fsl,cpm2-gtm", "fsl,gtm" for CPM2 GTMs
-  - reg : should contain gtm registers location and length (0x40).
-  - interrupts : should contain four interrupts.
-  - clock-frequency : specifies the frequency driving the timer.
-
-Example:
-
-timer@500 {
-	compatible = "fsl,mpc8360-gtm", "fsl,gtm";
-	reg = <0x500 0x40>;
-	interrupts = <90 8 78 8 84 8 72 8>;
-	interrupt-parent = <&ipic>;
-	/* filled by u-boot */
-	clock-frequency = <0>;
-};
-
-timer@440 {
-	compatible = "fsl,mpc8360-qe-gtm", "fsl,qe-gtm", "fsl,gtm";
-	reg = <0x440 0x40>;
-	interrupts = <12 13 14 15>;
-	interrupt-parent = <&qeic>;
-	/* filled by u-boot */
-	clock-frequency = <0>;
-};
diff --git a/Documentation/devicetree/bindings/timer/fsl,gtm.yaml b/Documentation/devicetree/bindings/timer/fsl,gtm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1f35f1ee0be2a947ad241f4ba0be391e7e0d0882
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,gtm.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/fsl,gtm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale General-purpose Timers Module
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+properties:
+  compatible:
+    oneOf:
+      # for SoC GTMs
+      - items:
+          - enum:
+              - fsl,mpc8308-gtm
+              - fsl,mpc8313-gtm
+              - fsl,mpc8315-gtm
+              - fsl,mpc8360-gtm
+          - const: fsl,gtm
+
+      # for QE GTMs
+      - items:
+          - enum:
+              - fsl,mpc8360-qe-gtm
+              - fsl,mpc8569-qe-gtm
+          - const: fsl,qe-gtm
+          - const: fsl,gtm
+
+      # for CPM2 GTMs (no known examples)
+      - items:
+          # - enum:
+          #     - fsl,<chip>-cpm2-gtm
+          - const: fsl,cpm2-gtm
+          - const: fsl,gtm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Interrupt for timer 1 (e.g. GTM1 or GTM5)
+      - description: Interrupt for timer 2 (e.g. GTM2 or GTM6)
+      - description: Interrupt for timer 3 (e.g. GTM3 or GTM7)
+      - description: Interrupt for timer 4 (e.g. GTM4 or GTM8)
+
+  clock-frequency: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@500 {
+        compatible = "fsl,mpc8360-gtm", "fsl,gtm";
+        reg = <0x500 0x40>;
+        interrupts = <90 IRQ_TYPE_LEVEL_LOW>,
+                     <78 IRQ_TYPE_LEVEL_LOW>,
+                     <84 IRQ_TYPE_LEVEL_LOW>,
+                     <72 IRQ_TYPE_LEVEL_LOW>;
+        /* filled by u-boot */
+        clock-frequency = <0>;
+    };
+
+  - |
+    timer@440 {
+        compatible = "fsl,mpc8360-qe-gtm", "fsl,qe-gtm", "fsl,gtm";
+        reg = <0x440 0x40>;
+        interrupts = <12>, <13>, <14>, <15>;
+        /* filled by u-boot */
+        clock-frequency = <0>;
+    };
+
+...

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250210-gtm-yaml-b41a9475d0b3

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



