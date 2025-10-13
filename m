Return-Path: <linux-kernel+bounces-851465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF7FBD693C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7CBF4F8B08
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727F830BBAA;
	Mon, 13 Oct 2025 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbcNeNUo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461630BBB8;
	Mon, 13 Oct 2025 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392718; cv=none; b=eBZfMuzRluDoIgs3xzDZ5iEBj6j23JrxBaF/o9d8cHu0uFYBH283z0E8x6d0sjs2SboK7O3jwqI30rnWWOqAtr4zSw18uDZY1rkqtljMnnKH0Iab/yTpeODy//RK8IrYbXkXD9D2bFtll1z3ReQ+KyVHRACtjBqxnW+03LmL87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392718; c=relaxed/simple;
	bh=uMSlsf/xN9vHLyFVY6jJ6GNcfRBsfLxq7F6h7Yydqj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cn3npodjeNeGajUZPopzss8W7vZX0GO0k9GfhULWvPs3JAgwzY0e5dFgNRhN76kT5K3Ze8EMJIA7y9J4CypyB6LgF+EO4Jau272vHSyoqAF9nhOtTmUUoXrYzylmEJ5g5CBBKDMx8XWmcIgzWIHK65pli5lvKTpofFuTfPBABhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbcNeNUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2492AC2BCF5;
	Mon, 13 Oct 2025 21:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760392718;
	bh=uMSlsf/xN9vHLyFVY6jJ6GNcfRBsfLxq7F6h7Yydqj8=;
	h=From:To:Cc:Subject:Date:From;
	b=PbcNeNUo1FKc2UvUI7YDnXTnyDKjC43hHFLexLDnzv7WqC2acJRNtwpuigf+K5Ibz
	 Fodg5hFve2XRbxjjijJ5FtYGtY9eYjK5P62o0+kH2fH18Vkqp9cH3PVyWQ2EgxXfh4
	 wmUy5QFXtUNbUMfRFx+9bQGc3sNvY/JCERQ7NaaML5/ucA8IgXSzBoMm0C30PmX/Ww
	 lDt6XYbwvJtoow0tTF10C7CwvE9cYA9I1Ed1jBTMIfYprKCjs0kg79D9J2fR6kZsE3
	 3DFiaDdDqOFWUNXu7acfLWBnlEXX1ZL5Kl6qD544bHCEdCk7RQFo5Pu6VHA8d4Ydv/
	 VOfc8hLk+0N4Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: power: Convert Actions Owl SPS to DT schema
Date: Mon, 13 Oct 2025 16:58:26 -0500
Message-ID: <20251013215834.783501-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Actions S500/S700/S900 Smart Power System binding to DT
schema format. It's a straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/power/actions,owl-sps.txt        | 21 ----------
 .../bindings/power/actions,s500-sps.yaml      | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
 create mode 100644 Documentation/devicetree/bindings/power/actions,s500-sps.yaml

diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.txt b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
deleted file mode 100644
index a3571937b019..000000000000
--- a/Documentation/devicetree/bindings/power/actions,owl-sps.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Actions Semi Owl Smart Power System (SPS)
-
-Required properties:
-- compatible          :  "actions,s500-sps" for S500
-                         "actions,s700-sps" for S700
-                         "actions,s900-sps" for S900
-- reg                 :  Offset and length of the register set for the device.
-- #power-domain-cells :  Must be 1.
-                         See macros in:
-                          include/dt-bindings/power/owl-s500-powergate.h for S500
-                          include/dt-bindings/power/owl-s700-powergate.h for S700
-                          include/dt-bindings/power/owl-s900-powergate.h for S900
-
-
-Example:
-
-		sps: power-controller@b01b0100 {
-			compatible = "actions,s500-sps";
-			reg = <0xb01b0100 0x100>;
-			#power-domain-cells = <1>;
-		};
diff --git a/Documentation/devicetree/bindings/power/actions,s500-sps.yaml b/Documentation/devicetree/bindings/power/actions,s500-sps.yaml
new file mode 100644
index 000000000000..bb942817b3db
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/actions,s500-sps.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/actions,s500-sps.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl Smart Power System (SPS)
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-sps
+      - actions,s700-sps
+      - actions,s900-sps
+
+  reg:
+    maxItems: 1
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    power-controller@b01b0100 {
+        compatible = "actions,s500-sps";
+        reg = <0xb01b0100 0x100>;
+        #power-domain-cells = <1>;
+    };
-- 
2.51.0


