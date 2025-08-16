Return-Path: <linux-kernel+bounces-771682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C0B28A4A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E50D1B6729C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2CF1D416E;
	Sat, 16 Aug 2025 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="gUIqK3tq"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12E634;
	Sat, 16 Aug 2025 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755315262; cv=none; b=p4hKtv+eoMURvg9XOE2LBaHmB3UedP98bPkxDmFL9XU0asfpzDyZSIzx8NgzJ1TdnupS1ZHM4a8unpFr6lAlpKZJoC3TNjYc9NGPBWYYaDLDKEYvoZmZWVz2DI1AWXRxo+mESyjtFUQZEBVngaOTGwEGEhMrUvdInGuQNPnkJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755315262; c=relaxed/simple;
	bh=yylrxDiAQOfoIt3a9mGl9RFAoxqy5iyE3xSz0HSXlEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLoBqEJB+oXx0nLuW5qxJeSd/tluP+KV503c9L2/TzKvIz/ZNCYl6tZbqyVmxGBwNVL/0S0qMtdkoAF38WPM81Sl8LzhB65cTIK6v4neQTr8OpHXQq+bnfVjenL0lz5wZUrZIpNgnYxckeTHIofh3WzfJVGOPEBpIpKKNO1pceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=gUIqK3tq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A85D725DFA;
	Sat, 16 Aug 2025 05:34:19 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qIJjVjwVHQrl; Sat, 16 Aug 2025 05:34:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755315258; bh=yylrxDiAQOfoIt3a9mGl9RFAoxqy5iyE3xSz0HSXlEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gUIqK3tquZKTtLcYjxwusDFWISpJNY56eNop71+9Rw+KOm1OIdERCwlUsRG5KDRh3
	 EDIqkmKApZ6gNdPNeflD+B9bCECAXy53acEnZOrgOZdLQBxScJw/QMrHjnfi/9IFpV
	 MRS1pwhDW4SbzKjD5CxYDL4V0gxtW+AZMejSjeAZ/aVVb6so/6wn1smW8issFM2USm
	 QyHETuah/wO5XcxSrQbX93RZRVj+bwM/g+wHeBRT68W0VQULg8epAQvMxkHNRPssNL
	 uR+3PgaIvyr20g1jc3isI8d/CAY3knQmBkNtdKojqKyn/18atIcWdU7W8frlDZotg1
	 N75PyD+nDt1uw==
From: Yao Zi <ziyao@disroot.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 1/3] dt-bindings: reset: Document reset controller of Loongson 2K0300 SoC
Date: Sat, 16 Aug 2025 03:33:26 +0000
Message-ID: <20250816033327.11359-3-ziyao@disroot.org>
In-Reply-To: <20250816033327.11359-2-ziyao@disroot.org>
References: <20250816033327.11359-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the reset controller of Loongson 2K0300 SoC.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 .../reset/loongson,ls2k0300-reset.yaml        | 35 ++++++++++
 .../reset/loongson,ls2k0300-reset.h           | 70 +++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/loongson,ls2k0300-reset.yaml
 create mode 100644 include/dt-bindings/reset/loongson,ls2k0300-reset.h

diff --git a/Documentation/devicetree/bindings/reset/loongson,ls2k0300-reset.yaml b/Documentation/devicetree/bindings/reset/loongson,ls2k0300-reset.yaml
new file mode 100644
index 000000000000..23c90b892673
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/loongson,ls2k0300-reset.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/loongson,ls2k0300-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson 2K0300 SoC Reset Controller
+
+maintainers:
+  - Yao Zi <ziyao@disroot.org>
+
+properties:
+  compatible:
+    const: loongson,ls2k0300-reset
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    rst: reset-controller@1600011c {
+        compatible = "loongson,ls2k0300-reset";
+        reg = <0x1600011c 0x8>;
+        #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/reset/loongson,ls2k0300-reset.h b/include/dt-bindings/reset/loongson,ls2k0300-reset.h
new file mode 100644
index 000000000000..d425411e6d19
--- /dev/null
+++ b/include/dt-bindings/reset/loongson,ls2k0300-reset.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
+ */
+#ifndef _DT_BINDINGS_RESET_LOONGSON_LS2K0300_H_
+#define _DT_BINDINGS_RESET_LOONGSON_LS2K0300_H_
+
+#define RST_DDR			0
+#define RST_SPI0		1
+#define RST_SPI1		2
+#define RST_LIO			3
+#define RST_DC			4
+#define RST_GMAC0		5
+#define RST_GMAC1		6
+#define RST_USBM		7
+#define RST_USB			8
+#define RST_OTG			9
+#define RST_GPIO		10
+#define RST_I2S			11
+#define RST_ADC			12
+#define RST_WDT			13
+#define RST_RTC			14
+#define RST_OTP			15
+#define RST_DMA			16
+#define RST_SPI2		17
+#define RST_SPI3		18
+#define RST_CAN0		19
+#define RST_CAN1		20
+#define RST_CAN2		21
+#define RST_CAN3		22
+#define RST_I2C0		23
+#define RST_I2C1		24
+#define RST_I2C2		25
+#define RST_I2C3		26
+#define RST_HPET0		27
+#define RST_HPET1		28
+#define RST_HPET2		29
+#define RST_HPET3		30
+#define RST_ATIMER		31
+#define RST_GTIMER		32
+#define RST_BTIMER		33
+#define RST_PWM			34
+#define RST_UART0		35
+#define RST_UART1		36
+#define RST_UART2		37
+#define RST_UART3		38
+#define RST_UART4		39
+#define RST_UART5		40
+#define RST_UART6		41
+#define RST_UART7		42
+#define RST_UART8		43
+#define RST_UART9		44
+#define RST_SDIO0		45
+#define RST_SDIO1		46
+#define RST_CANBUF0		47
+#define RST_CANBUF1		48
+#define RST_CANBUF2		49
+#define RST_CANBUF3		50
+#define RST_CANRAM		51
+#define RST_ENCDMA		52
+#define RST_SM2			53
+#define RST_RNG			54
+#define RST_AES			55
+#define RST_DES			56
+#define RST_SM3			57
+#define RST_SM4			58
+#define RST_SDIOM		59
+#define RST_APBM		60
+
+#endif /* _DT_BINDINGS_RESET_LOONGSON_LS2K0300_H_ */
-- 
2.50.1


