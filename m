Return-Path: <linux-kernel+bounces-868392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE7CC05191
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8435508F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17DC30C62D;
	Fri, 24 Oct 2025 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ArIb3gtt"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6930BF6D;
	Fri, 24 Oct 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294798; cv=none; b=eSF2B4cKnW2Q9QdXZ3o151jI5iJr8AUQ3UgT9Oqu5SKlg1EHFwUmQcUE5PCng2zyrYCI/5x7fOZTDJR+urz14hxouvPPVgFbbT1tD9Bxq7jRuI67s3nGv8+MalZVdfLOFfCZIXN9BnoiSPPG55xeb9rC6lmoWRxy/6o+PYMRHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294798; c=relaxed/simple;
	bh=Pq/WVq/FGnJf2qadaqsCrtJV3uFB5eNBkvBYl74ASqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubp5TE+2JMMJB8QilfU58H3gfX7pLUmaVV4Q/COX/l9Jn3lZUx9pySDM0C3iN/LArO5F3f46IlMmF7RJZG8pBr51LmpixyAChMd8Rk3g2XuFJ90S3L46ubI9LT0g0N1ln+Hb0iS7IfmdC8bsLJDWd8QpjUwGTrNp1p0PZtFjQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ArIb3gtt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761294794;
	bh=Pq/WVq/FGnJf2qadaqsCrtJV3uFB5eNBkvBYl74ASqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ArIb3gttdjn8noxzoE8GYtvAKDWjPg0sw7ynaiy9liIGxkqY/aVXv2WZHqHdLWqyh
	 xXmTcCXJQLoifGNHkWBhsRT+zzXxQfOtvBPKc3eAe0ThB94EkccwEG6Q+v3ucmquIE
	 f1cnzrEyFqzLThek1qjVoLnNxE9r0z3YHGKhbchvlVliF8VMs6bgzqevA7bMkBef6A
	 AvM+LJoGfr5p91gEaziyoqyLdKyaL2e6/arDFJRjjshrdcvFcLu8URfRLTtmcoiQwn
	 CHLUqdAKiQxcLworG88tEHojiBt7+N010Kn6KA4WaPChIULKSfG5n5i0+sfbQKqwuv
	 QKOSrZ5KhM7Cw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 134F417E141C;
	Fri, 24 Oct 2025 10:33:14 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: mturquette@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	laura.nao@collabora.com,
	nfraprado@collabora.com,
	wenst@chromium.org,
	y.oudjana@protonmail.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 6/7] dt-bindings: clock: Describe MT6685 PM/Clock IC Clock Controller
Date: Fri, 24 Oct 2025 10:33:00 +0200
Message-ID: <20251024083301.25845-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024083301.25845-1-angelogioacchino.delregno@collabora.com>
References: <20251024083301.25845-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings to describe the SCK_TOP clock controller embedded
in the MT6685 IC, reachable over the SPMI bus.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

NOTE: This does not contain any example because the MT6685 RTC
      will be added to the mfd binding for MediaTek SPMI PMICs
      and examples will be there.

** For reviewing purposes, this is how the example will look like: **

  - |
    #include <dt-bindings/interrupt-controller/irq.h>
    #include <dt-bindings/spmi/spmi.h>

    spmi {
      #address-cells = <2>;
      #size-cells = <0>;

      pmic@9 {
        compatible = "mediatek,mt6363";
        reg = <0x9 SPMI_USID>;
        interrupts = <9 1 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-controller;
        #address-cells = <1>;
        #interrupt-cells = <3>;
        #size-cells = <0>;

        clock-controller@514 {
          compatible = "mediatek,mt6685-sck-top";
          reg = <0x514>;
          #clock-cells = <1>;
        };

        rtc@580 {
          compatible = "mediatek,mt6685-rtc";
          reg = <0x580>;
          interrupts = <9 0 IRQ_TYPE_LEVEL_HIGH>;
        };
      };
    };

 .../bindings/clock/mediatek,mt6685-clock.yaml | 37 +++++++++++++++++++
 .../dt-bindings/clock/mediatek,mt6685-clock.h | 17 +++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
 create mode 100644 include/dt-bindings/clock/mediatek,mt6685-clock.h

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
new file mode 100644
index 000000000000..5407ebf2f3b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt6685-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Clock Controller for MT6685 SPMI PM/Clock IC
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description: |
+  The clock architecture in MediaTek PMICs+Clock ICs is structured like below:
+  Crystal(XO) or Internal ClockGen -->
+          dividers -->
+                      muxes
+                           -->
+                              clock gate
+
+  The device nodes provide clock gate control in different IP blocks.
+
+properties:
+  compatible:
+    const: mediatek,mt6685-sck-top
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
diff --git a/include/dt-bindings/clock/mediatek,mt6685-clock.h b/include/dt-bindings/clock/mediatek,mt6685-clock.h
new file mode 100644
index 000000000000..acc5e2e15ce1
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6685-clock.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MT6685_H
+#define _DT_BINDINGS_CLK_MT6685_H
+
+/* SCK_TOP_CKPDN */
+#define CLK_RTC_SEC_MCLK		0
+#define CLK_RTC_EOSC32			1
+#define CLK_RTC_SEC_32K			2
+#define CLK_RTC_MCLK			3
+#define CLK_RTC_32K			4
+
+#endif /* _DT_BINDINGS_CLK_MT6685_H */
-- 
2.51.1


