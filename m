Return-Path: <linux-kernel+bounces-789212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D2BB39246
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFEE1B20DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4FF25C81E;
	Thu, 28 Aug 2025 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="xOnTYvXr"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2572E1E98EF;
	Thu, 28 Aug 2025 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756352290; cv=none; b=vDHGNvGjnFGn1jWK2lFGuA618Xz1EVOo4wY4l0nr0Q5LN66szzKUWj66ZRkUjLM3tib65kbQ4DVCTMrDYRIRk1aTWa5h3CmZ/b5Kh86t0ViGKUQr+qNAqCsaKbKneAZmIPhZAW2XXkz8GTN6WeNRM2QUjENcpvu6RReVu5ei1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756352290; c=relaxed/simple;
	bh=CkNn0yDL13rr5OJKQbYKy/stqZi1+aPvUUVgjgqZkSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVpo9pSNrqqYWf7e12VDsnTTzPM3TRH+zpKZadIHVNDtrMRVJtLZ3hlSWK4RVPTB4Db6qv7ZD/LVXwc26+nj1QY6xiXLBXxKhFEarv/yOYiIqOZ9/48QKuJS9r/YIcc6PyaF09dnn9oyHK5Yi+K1Z0NQtcVZSkpQxi4gbkBcVrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=xOnTYvXr; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1756352272;
	bh=9c0tv56+rT8tv2KQ+mcHIp/y5vpqdKkP6eFUTFvbv/8=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=xOnTYvXrntvwzGnEN73PaIxuGS2YcZMgeYynBfhdyne+Hnadjgydy/LfyLwT4zpIg
	 BQfoJJdliIFVSZN28dbwkyWLNZumA4tOl9JWe/GQ+KlNTNNMv0oPi3dDdXwwJvVElf
	 2p0gAEBbXzz28IT3/VJZbts4yOdeHqeOOU1MtKWM=
X-QQ-mid: zesmtpgz6t1756352267t6e5a7142
X-QQ-Originating-IP: m9DJSiBShAsNywwCR295jUkpl9aTxaAu+e6LGjr+BAk=
Received: from = ( [14.123.253.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 Aug 2025 11:37:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15134818412140859297
EX-QQ-RecipientCnt: 15
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 28 Aug 2025 11:37:32 +0800
Subject: [PATCH v2 1/2] ASoC: dt-bindings: Add bindings for SpacemiT K1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-k1-i2s-v2-1-09e7b40f002c@linux.spacemit.com>
References: <20250828-k1-i2s-v2-0-09e7b40f002c@linux.spacemit.com>
In-Reply-To: <20250828-k1-i2s-v2-0-09e7b40f002c@linux.spacemit.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756352261; l=2579;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=CkNn0yDL13rr5OJKQbYKy/stqZi1+aPvUUVgjgqZkSA=;
 b=aFZZbs56Cse6B+seILibSRbSjeKcbMDqar8IQlJTVAo1xo4I4mjC/Ro5SsIWrWM6YYoVF5rO3
 wk968wv7GNqAzOmT1h77KPbYihuCtEh8yEYkMi7cddjlmJSIrn9etbW
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MH+mSh2Uo1NkYMJZGtXB+yocc9AEIdi9UPqlHHgZefKYdLOQBcPwoLQF
	i5JGidbpvR0COtOYjMYfArUc/WOAHIIFkAZGt3NalbdkZnFyVZoH/GnJmzAXznziLssAcWV
	df9lCVtqNM/y309eGZV3G+EX1akVV8M0r336H7vWoofKHpvaVbsL81k3mIjAWwY5c7Qa8CL
	/HVL50AIhe/LN4bMrrVyBGD3ryorAfUNRK/ahqzkxxI3+W03xsYmhoc/GNzralAwIYMcxHW
	D7LzIpRpUExKrKHtOQLQoy6gIBlgm1x2DyrJQkneeC22AfcF8c6wvaY2KNsxnzFCfSRo4UF
	0pTa3QXIxWIaJpwGDfNb+W82XfUpiX//xnulXaZll13RUUwWGRtp93pOWxg2secMp6NiOFb
	AkvDCq4v5OqirM9rXgQOpxEGHNaKOI7CR4bQgbEFpoOMFjGN8JRm7VPR3SdRo2CvnPk6RIZ
	pg8b6d/yHW26KVL3SUQ8wYr4zvuQLC3vpFTuThsAIVjBv1LTEmZJFSnMZx97FQGwMwyjcdH
	c9PRzVIAq5NWycZKhGnWfclKKfzuED6y8U/SC+U/dgwd0w56+i38qGvtqVRCCEx80Wfr61b
	VG5xzJlVfdQBScWbhCM+l8UoiQ4/0DjpoTQbgbqkhh+KC7WUmizGXMKvvr1PR27g2haJxcM
	XbHOldnIWOlOSa2Wy7gD0/vUDjLbY7N682xKEK2zZM+5Js4tU4j6nuRdjy7uyEJ8XrhUUlX
	SC8O+zA4Bd0B0hkcIV6v1Q6y7GrTB0FlctZd0K73lmUx6UqW6j1BjSrraeobpZ2MN9tIauD
	avX3Chkt0zZoWyqOzM8trXQYBs8MGEETGNGELOxujgCd8a99ezwbW31z7/OJSY6twmN/QyR
	3N0ezi/Y/m3aWWjK77VKIvBzK740QNxgQVogr4OQxIABUEQBmoQJ+DFFB1nX+weGKSmnfwD
	IX0A/UZHWZk7dgk6m2MlsTrlRzwy0fbyokfp4XkRj+aQRtFUrRqd2MCy3URvU6lqyk/GVIh
	77wTwAgqi1IOKZSeJuqjkyWTCg5fzGAntlZX9ZAJX1gELgSn8E0ofoXdeJYbS6DMlSV9SoZ
	0manLEM5TS8lUhFkklI+ln+RfrmvZsDf2G7JhkhfldIg/NWLFH+RE8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Add dt-binding for the i2s driver of SpacemiT's K1 SoC.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 .../devicetree/bindings/sound/spacemit,k1-i2s.yaml | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml b/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..042001c38ed8d434889183831e44289ea9c5aef2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/spacemit,k1-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: K1 I2S controller
+
+description:
+  The I2S bus (Inter-IC sound bus) is a serial link for digital
+  audio data transfer between devices in the system.
+
+maintainers:
+  - Troy Mitchell <troy.mitchell@linux.spacemit.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-i2s
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock for I2S sysclk
+      - description: clock for I2S bclk
+      - description: clock for I2S bus
+      - description: clock for I2S controller
+
+  clock-names:
+    items:
+      - const: sysclk
+      - const: bclk
+      - const: bus
+      - const: func
+
+  dmas:
+    minItems: 1
+    maxItems: 2
+
+  dma-names:
+    oneOf:
+      - const: rx
+      - items:
+          - const: tx
+          - const: rx
+
+  resets:
+    maxItems: 1
+
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - resets
+  - "#sound-dai-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+    i2s@d4026000 {
+      compatible = "spacemit,k1-i2s";
+      reg = <0xd4026000 0x30>;
+      clocks = <&syscon_mpmu CLK_I2S_SYSCLK>,
+               <&syscon_mpmu CLK_I2S_BCLK>,
+               <&syscon_apbc CLK_SSPA0_BUS>,
+               <&syscon_apbc CLK_SSPA0>;
+      clock-names = "sysclk", "bclk", "bus", "func";
+      dmas = <&pdma0 21>, <&pdma0 22>;
+      dma-names = "tx", "rx";
+      resets = <&syscon_apbc RESET_SSPA0>;
+      #sound-dai-cells = <0>;
+    };

-- 
2.50.1


