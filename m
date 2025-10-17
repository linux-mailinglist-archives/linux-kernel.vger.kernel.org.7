Return-Path: <linux-kernel+bounces-857210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9841BE6338
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D96E5E71B2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DE525D528;
	Fri, 17 Oct 2025 03:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="EAf/u4Bn"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6C247DE1;
	Fri, 17 Oct 2025 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760671014; cv=none; b=t6d78PQv8yhxwdxj3mbNrWNf0XKXb6dwAHS8XmCh7/tmPBeBnAtRfHmJ4sgwRcMv87MGo2OqgEUR4uuoqpp5sINlk3FdQdmS5h9mApLnug4hx5CE0WAMrhp1VXextVeQonIMMK1ihyjtDQIuEW8lBUIuLuH6KrjrNgghMJeTEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760671014; c=relaxed/simple;
	bh=76HDuGO/++wYQY6OBZ6UZ1PVv6SNT6/hCuPuH7hW1LM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SvtnRsrAOufFiGju1jYWqhb/k5Ge2V8fvl0f5GvNkKrV72gU7AFvEf+BLcmcxc7Q5C3XOBQ0Oxd0kPUq+0ThNemXG1kJgB7xQizu5tKTaoN9/GlJSiDO/03AWV3wQRREOLpsCTK2q/gRtgKaO0RKndMVea4Kdt7fJkqsQVNlQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=EAf/u4Bn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760670994;
	bh=2k5TB4fCGa99Tt+YiRV5hnuUcMUd7EkCwZPqTsiSIzg=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=EAf/u4Bn9o/SssApJDpi9cdKSX/IH+SfXgmr2oH5b5knhced0cFTQF2eqKC5zog0M
	 iWPlkz+dSiq9ngTRdbmA+mmB7GPUNt1faCM52fHnp483WcmnFT8tI+S1kz1GNqTZgN
	 hjMxRBbxqawuF6vbZ8IguoITqDJRuIgYBevIQIuA=
X-QQ-mid: esmtpsz17t1760670989t67f1a881
X-QQ-Originating-IP: bNF06A/ELp2eIpzH8vwQ9twel8f+wOMr8u4xsk3Tm/0=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Oct 2025 11:16:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16559823875224781238
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 17 Oct 2025 11:16:17 +0800
Subject: [PATCH v5 1/2] ASoC: dt-bindings: Add bindings for SpacemiT K1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-k1-i2s-v5-1-401ae3775fcd@linux.spacemit.com>
References: <20251017-k1-i2s-v5-0-401ae3775fcd@linux.spacemit.com>
In-Reply-To: <20251017-k1-i2s-v5-0-401ae3775fcd@linux.spacemit.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760670980; l=2619;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=76HDuGO/++wYQY6OBZ6UZ1PVv6SNT6/hCuPuH7hW1LM=;
 b=v0rNyuCf2QOTXtFsX8Swg2RRC4XPK6XUoOaIx9wMTk/my8Yyth3WBX42qzb0jm0IB3sJI9Hll
 fsuGXSOlz9QCs77zZKuI4+e5dmhGH60vN2YraVUyRTSzzTfIQSiETwc
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OLPPkukr/NyPzGMqr0DFQPhbhOR2XYtE6M94qm3z5r41XvItl/yXw1rZ
	3fHWmH/3gHHxz09a8WyaI6Euw+YRILdklcgeVzIHThZdVrIiJ8HjO5xMiV4Hp8TZvemsimt
	vpt2Gidkwl5JbiYwlHRjENeoY7dIJ31YZqtdng3nbPIkHwJte3yjR1Kt8vnflRkgeQI9erE
	RTp1QDtziE2AkQ95xtCwCFWUqKxUdEfu52XJ472IsguLMzDLzgII4h3GKyb1LZBn83zm73P
	2/7eBvyi9XcVchAPta3/3cCvocSep7PGCr4qRDYEktTFSOtoXfbq+x7HQq5RR7kipIq6m7Y
	YXDqiVMm5cOGvdBmIYp8PX5XC/Ltct+jidkiIUiKhqrY3q16daOlzH7mWS9SDFAzc8QcSGS
	j3kBWANIb+H/FlYaBPN2bgokp9VkhneLY5g/ej1FyZd+1fTo+YFM6suqXK+SIr1nE395TDi
	M9C5Igmgp3wRWqQgXFm6PckQWhWID8bzBcnmd51It0hWEObLxQcrvImjHD8kuN+0lJi3TW+
	u1RFvSX7N+f7+JYc6xZRAOfinXHnOM5mV0eCQobYyWiP0UotLcPTiaIDUVPqqKuo7x8Cwpp
	IJFfUcJs2Cab8yv60x6xutn7A2y5ponwxJFoJ5A8ROtbg8ya133nIlBwYikelGHG5oGQ+6W
	wBYHBE4mpC75e2ZS+cJjgp+3uRlvWfZpZI6fj/yTnrK6ZSJ4YNuiMVzmbhXV9YC3iBZNDLp
	E2kFIRd/A0d250D89edaRf9Esb1hOlvRJp4bhAo1Mp7fZ2TOws6yJEZcxhQ54qgs0KwEU8V
	M1A50SWHjZSsFOByakE0/MdFpOw98BT/tHuOO2GySsdxluwUCuigcyuX8P98HTlZIdUI58W
	X4+zqlz/6TkZ2qvtBFNlH5G13Sm0IFvaMZr6lfyRDblf1BBtsvBo6Mbl9GdSylDC5PgHCgT
	acOSotzJuo6jKb3rJ8gH4hpVAobuust2CxnAxlDs/5hD2pj/hGdDi7ttYHAlTesa0F3QYAf
	upIi7pmL6tGNDwNjeBNgiSQUEMSOVYuK7iJ0VtumoA51tT9FXTf6nk+YqUKy5YWXk13tYLN
	06pKxlEwoE20+nVk/pV1UzqKwWG038JNUUELBMCCirei31/hS2ILahGbb9mfecN5A/M0CMX
	RFcI
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Add dt-binding for the i2s driver of SpacemiT's K1 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 .../devicetree/bindings/sound/spacemit,k1-i2s.yaml | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml b/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..55bd0b307d22b3611d0fefb1e925e56812848dd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
@@ -0,0 +1,87 @@
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
+    minItems: 1
+    items:
+      - const: tx
+      - const: rx
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
2.51.0


