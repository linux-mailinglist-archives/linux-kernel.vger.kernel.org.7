Return-Path: <linux-kernel+bounces-826092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ADAB8D7F3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A798189F0BA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA38252287;
	Sun, 21 Sep 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="m4jf2+4Q"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A82D22A808;
	Sun, 21 Sep 2025 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758444772; cv=none; b=JN7WBpkrAs/CUUHU8vfEXE41RDNR+qhMkVrJpcNjVgxZjksKw43lSHDvcF0FpMl7FqfDV1dUY19z6uRasySPyVRlmSJPBz0XfSEYyeL95l7hBzK1TwN3oPUOBmncme4hjhBL70M8DVv23ebpRLNO61NCanBiGUjE+w1ahQ95YBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758444772; c=relaxed/simple;
	bh=76HDuGO/++wYQY6OBZ6UZ1PVv6SNT6/hCuPuH7hW1LM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3Y+2X3AXG6pv67WNtdCzaUONLMRfA9PDkqVgQe9EhYpJaoxRb4mMBmfPeVqPafCbIq4s1Byufq1uqE11s+rQFt+2DS2CQEcrjmkzzzoOFWNu2K/zMYd/JcAHbObWj5Ef9/Xmd/XtvhZz8uehB+LqEzCRFPdAborzxYdkU1H6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=m4jf2+4Q; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758444751;
	bh=2k5TB4fCGa99Tt+YiRV5hnuUcMUd7EkCwZPqTsiSIzg=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=m4jf2+4QEY8E0LE2gwCrmI0lPKyASbv71MiUq8Uquuba1hLYHBhrY6mI8SF/sU4lF
	 pj1prIrW/ubokWpT1tqysukSEH208Nctq+Tn2gU1uN5zNMbtsS+e5JaMGE0i/RKsPh
	 p8y94Wttv54he84uxxPY4NSnUNTqdbB8U8U2Jx/0=
X-QQ-mid: zesmtpip2t1758444746t50d5cce6
X-QQ-Originating-IP: YTbr4bF4fXXgOVGW6cQbxzmvzTq87tzsqIC72RSrILU=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 21 Sep 2025 16:52:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11772700704362527638
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Sun, 21 Sep 2025 16:52:16 +0800
Subject: [PATCH v4 1/2] ASoC: dt-bindings: Add bindings for SpacemiT K1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-k1-i2s-v4-1-4f819f50e468@linux.spacemit.com>
References: <20250921-k1-i2s-v4-0-4f819f50e468@linux.spacemit.com>
In-Reply-To: <20250921-k1-i2s-v4-0-4f819f50e468@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758444738; l=2619;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=76HDuGO/++wYQY6OBZ6UZ1PVv6SNT6/hCuPuH7hW1LM=;
 b=QxEY1Pde0pS2iIBEaP61bZHv3W2NEtVTUquVa3ksdKOW3j7eXHewA82pyuP7xgj1vZmzOpUmO
 bmyd/x0pM0rC3VDgV1/aVc5LPmHJVNNOwTloG99/krigYRJqYqaXp+q
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MJZjqT37aNo/U9bvTU1QUMlDKX1NTdf++3vI+bOq4cbdWbulmz/fBeU8
	zgGf1Cgl29/uz7BJakcSXScfWRpu3K7Z19w1JwdrSAKbQtmd/bwQWHxwdjWvd72KUJlGnj9
	CsDFkJ3yPgV2HrhRKDYekWiZ1PM3Pfxo5tAYtwiHaX+s5bTdO/TPUiHlY3QJj6r6I665Kbt
	+Go15uyPhrcTpMD6Hczx6egbOOqODdSZD57JHotAbsyegeYQJaH5G80gTJmhS6T4RUaKvPS
	j8p5D3JS+OTA+ApiDZH+7SuN2BlVNDhru9LrRq2Q5ZWcFWcx2mLpdR+dq4y7uVr//6n9KTF
	zO4VWjKTP32tHpg0uRoxYwJ6a7j2beUZd5gRLLn24auxKtTOVvaSIU/MnD+mdG+9nlumLHR
	5PIF19ZV1wdTHLX7rIrg3MZaSlxOvNsDTJfGpptZBrhsex/kAVcj5mHemY65spNE/3FC+oh
	ETqcArJf5nAAsDwaZQvXWWR2q3aRpcra6Eps38rt/LATK6s1HtDBYWKeH+yFzSxLQ2JGrBF
	YVFsWdhKDrPE2H5rolJ5t3Y3869CBQW9X+EmfYvckSlWli44ANlaKj/rU5CXp/6CzdRqncn
	3wqvY6XesukptxCGiRcgLFkDkDoThL3J2RrHA6Raiksbg0gDIY1apc1L2FObZpk6qKnKZIK
	mCtd5LNfprOir+DmGko4vhJmpTDJv8CmHMB9ITCE3GudgQCINnMJ9eH75zXN6BMwDt6vVaA
	wLbYZJqMlWwpntfbAITE6HstFzRmc1rkNqzmi9HXs3oiPDf4HkjeR6PtyB3ob5keSkjmrTe
	Mnw0e1SnVJeL/t8ZIn99j8EStlpftg8cXPXWfwrloNANZUgRD9P9r4BQY2+p4oCxdo/UHVF
	75pbqYukZ8IUysWBzzWxZdDqGgbvogYa53BGjgUB456bAAt1LZ/u64TdTzujVcDs9qKbnVx
	GgFLYNeKnzUHX6+rOOXX/jxqBzQ2BShQQqt9RyQy/dPrLfuUxFfH6uqUFs8TsFrAwgiE2bz
	S7MTqyYSYm2kTw3Y0StPvtQcuNUDSgAjfwmoCfVLL2RRGh/16kUYkGek+RtMZC8MTftQPLj
	pGwMry2QhCXW9J6j0G/6gJoUWHsHGZGuR1zxO6p5uLMGM6dFNsW75Y=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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


