Return-Path: <linux-kernel+bounces-728321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27850B02693
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590304A6B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C299220F20;
	Fri, 11 Jul 2025 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWT0ZP64"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BA21B9FF;
	Fri, 11 Jul 2025 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271042; cv=none; b=ub3LQwIwwOgpxrA3GqxiAbEiiEluBXycB+xrOs4GCLTZ2K58QmhBVGW2PivmsMiS8OZj2Chk3sk2f7eZYzkHOlBfNNpjbJPT6ymKEuRXnl8aM+OSZ3yxBJKQ79SLhDDw3tu3ZVIq1BpoodGSAMOT66CfCgD9bT29G3bwPV1jY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271042; c=relaxed/simple;
	bh=q5Owo6hsBlGPBSb5fRPgpzE0VZYnU59Bln6pEWHCh2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XfhQN3GyxyKSgh5WoLRZKpItlV3Q81fEkqEgXVb9jMCjjwc28STwValR2kFK9bqobtGT0CfCb4lHNnrDO2Qp2xGQkR2mroCaD2qjGV9xgmB/+4xooCQena5/fLpPdzVMHDSM2ZUKBV4zAHE88gm9BZPjZkEJOrH18Mob22G3+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWT0ZP64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 092F0C4CEF4;
	Fri, 11 Jul 2025 21:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752271042;
	bh=q5Owo6hsBlGPBSb5fRPgpzE0VZYnU59Bln6pEWHCh2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LWT0ZP648ikP6750gFCRD10iyw87Nhwyd1SSolL7hz3gkg8eNhiRvT/xzw2UeaC3Z
	 gXJ+UVeaVDgQxgVTbBc1UU2v75zV8Nx2CKAmZKJYCYDiSKlcExWDzIbMM16aYHA8Ws
	 jJLOJ4AHNe3j9eHLl+XGNt+fuL7Z1UNYhlmFk5uCHb5Ea9W4bqWn96nYznNN0im/3M
	 yKULm9CoiLRjc4S2RqaisCib9B8SLnK6ppk0mEC0tdKs++QPaH1Nex0VdHI3VRvmUE
	 xAPeT2/OEZLDfPfXaRuQwxMhDVe0x6uAiHDo9YJVXlK4xV/dmG6+JG4KSb1ivVsSlx
	 qkU5BUhJ6bAjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BEAC83F1B;
	Fri, 11 Jul 2025 21:57:21 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Date: Fri, 11 Jul 2025 23:56:45 +0200
Subject: [PATCH v5 1/2] dt-bindings: timer: mti,gcru
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-riscv-time-mmio-v5-1-9ed1f825ad5e@htecgroup.com>
References: <20250711-riscv-time-mmio-v5-0-9ed1f825ad5e@htecgroup.com>
In-Reply-To: <20250711-riscv-time-mmio-v5-0-9ed1f825ad5e@htecgroup.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Djordje Todorovic <djordje.todorovic@htecgroup.com>, 
 Aleksa Paunovic <aleksa.paunovic@htecgroup.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752271040; l=1784;
 i=aleksa.paunovic@htecgroup.com; s=20250514; h=from:subject:message-id;
 bh=/RHTs/dV8mK/r/ATCMy9xGEu8RznHBlNizMjaxes10Y=;
 b=oI3VZOfvBk9iNRCP9pJILM0FDdGES1Zpw+I5p/t4/+vK/OLwUC9L6nIK4WxhmEhnYP6j6Z/7J
 RomrV/dRnyPCm87Fei9SDZn7Ne70mYLU6Yj+FVhd6baabG0pO6qyC7w
X-Developer-Key: i=aleksa.paunovic@htecgroup.com; a=ed25519;
 pk=gFVSVYLKAgJiS5qCnDyUMGOFuczv8C6o0UmRs+fgisA=
X-Endpoint-Received: by B4 Relay for aleksa.paunovic@htecgroup.com/20250514
 with auth_id=403
X-Original-From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reply-To: aleksa.paunovic@htecgroup.com

From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>

Add dt-bindings for the GCR.U memory mapped timer device for RISC-V
platforms. The GCR.U memory region contains shadow copies of the RISC-V
mtime register and the hrtime Global Configuration Register.

Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/timer/mti,gcru.yaml        | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/mti,gcru.yaml b/Documentation/devicetree/bindings/timer/mti,gcru.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ceaf90bad5332b64f3c1f28bebdc28d78443898a
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/mti,gcru.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/mti,gcru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GCR.U timer device for RISC-V platforms
+
+maintainers:
+  - Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
+
+description:
+  The GCR.U memory region contains memory mapped shadow copies of
+  mtime and hrtime Global Configuration Registers,
+  which software can choose to make accessible from user mode.
+
+properties:
+  compatible:
+    const: mti,gcru
+
+  reg:
+    items:
+      - description: Read-only shadow copy of the RISC-V mtime register.
+      - description: Read-only shadow copy of the high resolution timer register.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@1617f000 {
+        compatible = "mti,gcru";
+        reg = <0x1617f050 0x8>,
+              <0x1617f090 0x8>;
+    };

-- 
2.34.1



