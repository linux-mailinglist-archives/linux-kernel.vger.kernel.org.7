Return-Path: <linux-kernel+bounces-811378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63391B52842
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E3016A814
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7075124DD13;
	Thu, 11 Sep 2025 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="RYRfsaYM"
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B568329F29;
	Thu, 11 Sep 2025 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757569673; cv=none; b=gKQXfcq4D8tPzPN5ay7PsT5jIhZ1yHsNk6M0Cn5Zc4Xo+jzHFjtQKBmMpBRn6bPRI/NdWfcyc1bj90Bj4KbUiz4jor+gwkajRFJI0c9qAXrqpCa/nLlb7bsl1qntolJs6TOVobCKCZWcbSrH43CvKx4jFiGuQXH57j/w7DEaXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757569673; c=relaxed/simple;
	bh=MZyNehkEDO+xrWPj2ZXjZEeu4YgI8vPyjedZrtrtDWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cY9XpVVKaM1N+HJ8ufvYrLaFz4yqEzzbaZYzYEGJ+/slzUTNsjyUty7UnhXFmkpHdjFQVkj731MSZ+tcoLovTsrOBECti4zXq5aM85flsPDgmE4NR24RpjgQUFerwqzSZsFN/xfnVa+5nQjq5C56jFwvZjR02E5rqTLpR93wZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=RYRfsaYM; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1757569650;
	bh=Pd8E5nwso3tDIIp7ab7uxQOFaM7OtDLMcKjQtOfLAWA=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=RYRfsaYMsG9WaX6QfF9V2PDpNBsqfSgVgPVZBRMmsOhWHRArJut60gKPcyZgkPEfe
	 KJ2QdjdVrr9k0b24O4u3qJara7moqvF1xIPS3i0BVSf6ZwjGL9Mq6Of6BRjjtsFf2D
	 QHK07tQvQC+K8OIOw3uIYHB3TtqNz5GK694fTrP0=
X-QQ-mid: esmtpsz18t1757569645tbae29400
X-QQ-Originating-IP: sDZRU4N6vZL21xBIP2dp/dXDI3uIkBybEVLTmW+dvvg=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Sep 2025 13:47:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16154328192209350849
EX-QQ-RecipientCnt: 15
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 11 Sep 2025 13:47:10 +0800
Subject: [PATCH v3 1/2] ASoC: dt-bindings: Add bindings for SpacemiT K1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-k1-i2s-v3-1-57f173732f9c@linux.spacemit.com>
References: <20250911-k1-i2s-v3-0-57f173732f9c@linux.spacemit.com>
In-Reply-To: <20250911-k1-i2s-v3-0-57f173732f9c@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757569637; l=2552;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=MZyNehkEDO+xrWPj2ZXjZEeu4YgI8vPyjedZrtrtDWs=;
 b=mGBVFiExQ0QO9T+P2Au+nmTf7TOKFhgkQB2q33d8wdm16gjBqxAViQU8m01yMF5WAg6AZEqQc
 303tdXTjQNQAxEPHGlPxDVxIdss5utvuKzTiMVT/N24cLnQ0LhOoc8z
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N23fUA7tbDKk8aTdHiDiRP8Aps/pnmoZlhs9HVmCq2v9v/pKcxi/TWE9
	kSUKsUTRzuSrx7UjcjfH7AI1tV2VLcAQqeoj7FR5pDBTEqCvu8Xle+9/Zk41olQ3KQIZcBw
	L79GCQC9b/FIaENGIAVZldBpt5el+EjG736OdLyv8wdHLlfRT2Dej1qTWRV9mG5yWEm2DWB
	0eCRk4u+MPNL1J6R8MHFySJeLWRV7LRqxzBjbSqEo1Gf+EGTbGxqNTMVQ9sOtz0RM5K3CXg
	TsG400gbiQNsY5iRckFN3yb658pwTpaxrxvV0RKEdHtBFq69ytnU2zF6inkAPNrGmKmdt1o
	nCio5NDyOE4TUWcW0pfONBzsOqmQli3fZxz1zFLUhK3Irrk+JGYAEgGyp9HD8R5yghxf4by
	9KEQazxFvdRgo67He1hoO1pIT8t4AL1XUUbo/ZjFpZfZ5Efi2BOa2LvhaVfd1UkYzhFiH4M
	o8/hRFjUNHD2I6Aiv1Eb+cXi4oj99Elnox+OtCOxz2lFdhnPFFNkS6GmhDInic8y0VPRnny
	Gvb5F574LVvWEMJF1canEP1c1HarolLreAaJOAy7/uI52wuYYd4s0IodZkecp9cXhZgbdwD
	Vu3z0hhilD9bZ3/eHX77WsWK5ikfxaFOAldj3Asrwc/ACeG/2hkotWexLtyI6wugFMUTFMS
	Ugo0BtmX2/DwKAr0AYobve8yPVI5lBpL6Lvc/kGE6yN04unGKT9Tv/nscurMNGwIqIYpnRF
	pKDsbJ5eWOvs7DeZGkbwwFYWGSNCFd0V+8LuyiWyYdyJOt1+PHhp9d4zyPBs7wzuVOSrIWu
	RAOzculnPJ0Y/Egqo9yBPVHhz6E9Zv7DH/neCBdcnitVxSThwTEGjeWzgkfCFR44RPI397C
	Mfq9EdvdIpqx7KWJu7/4+BkTcz5tXBs7aAdPdhhZV1vDHVwIgetpi3qNxf9e5PP9hnIo+vS
	rP2/AcgPppilzk+ueSQ1x/N0pPbtXMNkG6op/db6O4vsJjZqgHI/fM2JovPkjEiug3hlc8b
	ghe+xEYtCXY09M52AYtQuHYvGAA6ykXL1pvAVBUDYkD0hJLbYFm7waufok1n4w9tS7WwmM5
	YcB298fvd/ubMa25ZDxqaI=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Add dt-binding for the i2s driver of SpacemiT's K1 SoC.

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


