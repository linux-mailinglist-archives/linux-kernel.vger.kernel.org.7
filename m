Return-Path: <linux-kernel+bounces-830393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C25B998AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718484A57F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E892E6CB4;
	Wed, 24 Sep 2025 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPQviD1m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB602D6E66;
	Wed, 24 Sep 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712269; cv=none; b=HvDqbCu6xiAcJUYdD5cglAF+GMfh7GXqsDm/guuzB2m8OfCuqhGzX/6C1ZhMLwPYXSW1ni/W0cNMsSLq13lEAI9TjahZayicQh2i1pxiW7pU3LNSEedYSupmzeZECY9uEU1Dw509jXVRYGOet+9XOPh2P6QFPDpwIMETSUHRtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712269; c=relaxed/simple;
	bh=vMA/TDrL6pX/37cIVwe+uCWPjNEkgQmBnrmcW+A7gxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oLmD8h76hq5WI17YvlDy+vfm2zXoxACdNJnM/wk0x65qZqUONsUFa+XDTvR5iHXV1/W4/S9ggTMxTE/mlWOtgDgH7Wg3oEUsz9uG2R54M+l/WP8MO4w1RaeqR+49ZgG5k6vSHAiQWJvxKjGs/N6ZHAPiWhdnf+SmtngtPkLZsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPQviD1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7408C116D0;
	Wed, 24 Sep 2025 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758712268;
	bh=vMA/TDrL6pX/37cIVwe+uCWPjNEkgQmBnrmcW+A7gxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uPQviD1mLWt+0ddgfSwMuG9qgAuS/6Dd+aUZaQ3VMk0GWJI/83I/E0mAnLdDNLNF5
	 8Bm9eDcv98Bnbk0MGN/v3c6CheiPQ19/SYJ7x713Xb5XcTPzDMubEywT2pvOHgPjd7
	 muCkKLhqXyaNlhQtQ3YCZOKpiEN1lVudAHhdB7lvDwIVn1aVoA/TxMEb/gj+LmMrjn
	 WsAktr8AHte0KZDlINpWYIXdo24Kgpre8OUtGwL4pQXtSnRUOlbPRuWJRRwk1SqlJr
	 7hBLC6rYFbQRxqJPlxphx+hBf+flcvFPfpdxO6GnmDLucEqz1+qzVG6Bvj8fPiLhew
	 ovYXpJ9+nK6yw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97214CAC5B0;
	Wed, 24 Sep 2025 11:11:08 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Date: Wed, 24 Sep 2025 13:10:37 +0200
Subject: [PATCH RESEND v6 1/2] dt-bindings: timer: mips,p8700-gcru
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-riscv-time-mmio-v6-1-9c6158a14b37@htecgroup.com>
References: <20250924-riscv-time-mmio-v6-0-9c6158a14b37@htecgroup.com>
In-Reply-To: <20250924-riscv-time-mmio-v6-0-9c6158a14b37@htecgroup.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758712265; l=1839;
 i=aleksa.paunovic@htecgroup.com; s=20250806; h=from:subject:message-id;
 bh=qlCmLDBO1Y2Dd5pfYZ/Ggi2QMtMAGxo3h0341eF3VPk=;
 b=9/N6oUFCifF/mKLDmbQ/zHuZlII107W4obDh+pdjArZxLtL09HskHd4TMeO56y9tKGysMO10C
 sgp5zpwsSIBBp8VJpuwzVzGyNhHPRu3OYRnptEP3xna+yelfFzxf4ne
X-Developer-Key: i=aleksa.paunovic@htecgroup.com; a=ed25519;
 pk=Dn4KMnDdgyhlXJNspQQrlHJ04i7/irG29p2H27Avd+8=
X-Endpoint-Received: by B4 Relay for aleksa.paunovic@htecgroup.com/20250806
 with auth_id=476
X-Original-From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reply-To: aleksa.paunovic@htecgroup.com

From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>

Add dt-bindings for the GCR.U memory mapped timer device for RISC-V
platforms. The GCR.U memory region contains shadow copies of the RISC-V
mtime register and the hrtime Global Configuration Register.

Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/timer/mips,p8700-gcru.yaml | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/mips,p8700-gcru.yaml b/Documentation/devicetree/bindings/timer/mips,p8700-gcru.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..3498255762cce6b3f491292d340d9639bb573e6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/mips,p8700-gcru.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/mips,p8700-gcru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GCR.U timer device for the MIPS P8700 platform
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
+    const: mips,p8700-gcru
+
+  reg:
+    items:
+      - description: Read-only shadow copy of the RISC-V mtime register.
+      - description: Read-only shadow copy of the P8700 high resolution timer register.
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
+        compatible = "mips,p8700-gcru";
+        reg = <0x1617f050 0x8>,
+              <0x1617f090 0x8>;
+    };

-- 
2.43.0



