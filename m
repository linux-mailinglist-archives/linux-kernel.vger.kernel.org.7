Return-Path: <linux-kernel+bounces-871390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1917C0D1AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8DE19A4C31
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B12FE05E;
	Mon, 27 Oct 2025 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FCs0edno"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB682FC871;
	Mon, 27 Oct 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563634; cv=none; b=HYKr25Yfp/ImQK7cPgK/Sc6StMTMj581nfOg3nMUoUq3qlVhJJU/FkWIORycFNhPr7NueQFYfHsYtQOPZsQL6iSeqPy4TtSLEXPTNH+iWUnhcCRDAnlqsh16ni74V0cRzOGkvY3mjrtbSw6jhjYF94V7jPainvbT/edEqDfSLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563634; c=relaxed/simple;
	bh=ucrpNpirVQvPM327pg6rTANwRDYsaRl287bHhoFYCAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYb7D6ZhweK6x49nmITjgeevyLPoNXruvgshtcj/i1BF+yZzEA0rJKIesK8zrJnJyHd1OvobVq0ttIjKwCyPiOSexgNmT9RDWR9MVOtDn12riUlVuXn0veS6r6910U0YB+kX75z89hQy5ztxhobKLvjlj1gt9m3CN/nPyy9QEjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FCs0edno; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761563630;
	bh=ucrpNpirVQvPM327pg6rTANwRDYsaRl287bHhoFYCAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCs0ednoSHr8wECBLTOdDOvYrQt2Qrw38wbiQycTkb1wWBRKSAS3ZoZfMatuoYb3l
	 aAK3pKR5dqgNdCG+svR4/JFHSVgp0xavNfvMcPNoTtGDTam1yKsf/J7cyvxGPWO3QZ
	 sphyvUi3rEfETvHN9cOl+OlUOAs4SnPve/4dnEQMISWMB1r18OZmG4lofATZrmCJtA
	 pU7zDZdWVObi20/YrUDuLgDYwv7Woy3l325lRG8VRx78yydJ3glukod4QvZ/oTPu/C
	 S3ek2WNLCeH8OpNlwOUzOvjbHNtjOkIaRLKpx8n3AaKiBZzvVX++AtdOf3v5gbFrK+
	 B9WU8JNA9DPxA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4E30C17E141E;
	Mon, 27 Oct 2025 12:13:50 +0100 (CET)
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
Subject: [PATCH v2 6/7] dt-bindings: clock: Describe MT6685 PM/Clock IC Clock Controller
Date: Mon, 27 Oct 2025 12:13:42 +0100
Message-ID: <20251027111343.21723-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027111343.21723-1-angelogioacchino.delregno@collabora.com>
References: <20251027111343.21723-1-angelogioacchino.delregno@collabora.com>
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
 .../bindings/clock/mediatek,mt6685-clock.yaml | 36 +++++++++++++++++++
 .../dt-bindings/clock/mediatek,mt6685-clock.h | 17 +++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
 create mode 100644 include/dt-bindings/clock/mediatek,mt6685-clock.h

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
new file mode 100644
index 000000000000..fb8703f7ee61
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt6685-clock.yaml
@@ -0,0 +1,36 @@
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
+                  muxes -->
+                          clock gate
+
+  This device provides clock gate control in different IP blocks.
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


