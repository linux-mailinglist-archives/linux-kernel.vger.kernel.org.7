Return-Path: <linux-kernel+bounces-768322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B57B25FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580037B8B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC032EF64A;
	Thu, 14 Aug 2025 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="UV1VBXXK"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8892EAB95;
	Thu, 14 Aug 2025 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161690; cv=none; b=DkxVFDxZXM7JK3IG78WTBsFqTPhsKWjpUVOFsOexbYa3Y4i2GUUFxCI7GkEu+2xsEiGefSX4xTnNoj75dNQUpaKqi3kgsHkLls+715wdByDnSifJwsQbRvwjEpt4iGcAXAMMu4VOg7a+2qjekZEL3czkrvHJmAKgE7xDYVRz0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161690; c=relaxed/simple;
	bh=4gB0KEfw0g+rxzPBSIwD5+Ui+R+cy3fzQ/z4eR/1RaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=okskq70jemZf51Lxe3abNfRxoE/VT8K320JjvKjO0bxX7NhPC5eeom4Mq2xlK/d40EH0w3pdRrFG5RJlzISlekwqsw7O9f9J2J15WSNsRgYhAa9tBtfCZVqD16cGB3Dva5XqwcFVlRoOPVmNt/OY9t/4ct2mLp/nk7adHc9lCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=UV1VBXXK; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755161675;
	bh=AchqVKRv3VvLwqCT88TPZ7GLSVaYSLxvru6E8YaYobA=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=UV1VBXXKx1P8muEMdPXvWo96wTMVQ/UjUgGDqJcht97mcH5ErIlEInwlUiCzXz9ur
	 Qdoh8E3jSWiF93tIGEGHR3DKI4yxxngoO2awe6ztKtfkGCgERPORgs8OhBsiQZ9Bgf
	 /aGEI65KCrBx0gnCEjysKOJGkeJhT/QqTBhyIBTg=
X-QQ-mid: zesmtpsz6t1755161669td8ecbc2e
X-QQ-Originating-IP: nqY6BaQvSIAYv90RyEdlu/kBBPSt0HRQyaokU8zVgYI=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 16:54:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6572590404047552844
EX-QQ-RecipientCnt: 15
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 14 Aug 2025 16:54:19 +0800
Subject: [PATCH 1/2] dt-bindings: i2s: spacemit: add support for K1 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-k1-i2s-v1-1-c31149b29041@linux.spacemit.com>
References: <20250814-k1-i2s-v1-0-c31149b29041@linux.spacemit.com>
In-Reply-To: <20250814-k1-i2s-v1-0-c31149b29041@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755161663; l=2560;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=4gB0KEfw0g+rxzPBSIwD5+Ui+R+cy3fzQ/z4eR/1RaQ=;
 b=xvssUWqqu9fg80WCBtkiGZP9cllnkzf7LFXQb35Da3wsm7eFSLKiFI10Q3XuPMA5JuMlMhYYK
 cAW4g6quRy6DOrCq4moFxVz+R9hWdi8os6gzlV0bvNkP1X2NTycJXy4
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MdyWDAxdCPcQkDfnR1NsRwhS2nja7R/CUSZWVAad721qVRQxmMDgFhO7
	0j8F6nRLIvoE9CYt4wBMaqel1amj7WSrstG26Zs/rSlLeZWvcI3gUp1AJqA20N+TghvnYmn
	2yLfUcI1Ih9J2oZJFMR3ALbGmC1yeXQuvc9fJgbU2l59KeNu21im2FOvkvIpGJxp6kturdT
	LsnIlAFdGVQzB5DKrJND26D7Zuap/8VEp3yRfHKhOJcvAWNTs/9NVJ8zjymQTf9m7dzCqzo
	pQdsSYdNSgytTv3c2v9jLg8igloZNOlFfq+6ERVt+H/+RqI72eHehLPVI7pm39lKGeBiCNr
	S4lD/pmL4EOcxAkPKvs7tbIewmjh/UiAS841T8Dm0omQZjb2sY31pIJushV5wJRtXsdSPFP
	FJ0M3m7roRDYAKLQdW8SdL5xq73RXBDeI/mNdkiYcQqC+ONG8q1A68C4hSODnndShT4XdyF
	JgAITB4oBeh1M3s/r4H+oBYBqE8zeCib9HBKWCJ2OniadSLZjYIdqYJ0P6twh7wkFcov99M
	n8nDlgEyH3D67Op0w4w34t7lFzSwiRHDBharLh+dJRuRQ0Oi/AKbcqiw/CaW8omMdpO1qsG
	rDphoxk+nnnL1y7Nc7X+ywcBn8PKSt55ZA750j9PnsTaVNOAV3pcJeZ4llVRdtN6a/pon9o
	yUpz5uPO3M8dCj9k4fKwnl1CzdsTxjF1fLYuAzltVtatFN/4XQ0rV7FR81OqAm2yB8lWqmN
	SHpsc5A7yyOXNvA5sKPNMMnPxvvbppcsCZlHCd/Hc/sPDTNXIGrF8rZ5QX76f0d1fNihVW9
	P3QHtBak4OJz40K/uCd7psY7Z3xmslEKOE1O5KmJYLxB76xIiw4VWHipklpAF9+k+afiL7S
	0TU2mC/X4RJWVTqNz9oP6r82X3hbtLaDAT+BDSLDOW3eLaVPspdOtJNP06ZAF8AQAf9xn8O
	33tVRLC8P41/ikrZiKtrUjKMcL+VXAihxME8hfbJ7ddOeTH4yuSdG9FJ+qKHj9qX4hG/ovL
	8gl+ntKVdtkvuJIptW7hX40ANtxWb3cPEF11+9tpfaIgpL65ySbOCwf6P7cJ4nmdLtMhxfU
	t/VZQlWNsSjpoUJ4IoEVc2VF6fvGInVwD7pMuOKQg0zxIBc7UYEd7RxQ+RocqcwQppgbRx9
	YuG1jhpG7/R/gkvN/KPtrxP1I9O8xj5RAETY
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Add dt-binding for the i2s driver of SpacemiT's K1 SoC.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 .../devicetree/bindings/sound/spacemit,k1-i2s.yaml | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml b/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7d9110638d71792db6e5bb72559f6abaf4cb59bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0
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
+      dmas = <&pdma0 21 1>, <&pdma0 22 1>;
+      dma-names = "tx", "rx";
+      resets = <&syscon_apbc RESET_SSPA0>;
+      #sound-dai-cells = <0>;
+    };

-- 
2.50.1


