Return-Path: <linux-kernel+bounces-775774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B183BB2C4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74396725709
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EDD342C82;
	Tue, 19 Aug 2025 13:04:02 +0000 (UTC)
Received: from mail.grinn-global.com (mail.grinn-global.com [77.55.128.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D7341ABA;
	Tue, 19 Aug 2025 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.55.128.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608642; cv=none; b=fWAqcVAyij2j3Bx4X/bB8xbWNxm7YwkrjAIU5ExKCOee1GKhTQo9Sg24A/Ss5ZJvrgpJH5QF4lR5wZIvk/ie0WkS6i0MBSyt/o1DcQNCzZPFBEXLXIYcmtuSGGXXUNFyhD7d0EONKa8gKktvVs+1tMQN6XZliYMRF4KGAhHZXrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608642; c=relaxed/simple;
	bh=BmhGATSJATQ0TPSipOVR3WeIgcVSNNQPfWfkeR+oZh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDo5lrAhG5L5Ey9mxAKzzL007CutMpdlCR/qCR+KmvnhFovHq9YUYYb2OLtsMx7BHUb0BDQDsmzxHGx9clznoVwN2wbTQNdCrs13h6oXmiwPi+gQO7faCQN0fBp4LA/hIfcfwh2H2Qgo6bQM1ncDoBWdzGAtY22XWIS7HKuSoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com; spf=pass smtp.mailfrom=grinn-global.com; arc=none smtp.client-ip=77.55.128.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grinn-global.com
X-Virus-Scanned: by amavisd-new using ClamAV (9)
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
Received: from mateusz.int.grinn-global.com (f90-187.icpnet.pl [46.228.90.187])
	by server220076.nazwa.pl (Postfix) with ESMTP id E85241BE3BE;
	Tue, 19 Aug 2025 15:03:56 +0200 (CEST)
From: Mateusz Koza <mateusz.koza@grinn-global.com>
To: angelogioacchino.delregno@collabora.com,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	marcin.czarnecki@grinn-global.com,
	b.bilas@grinn-global.com
Subject: [PATCH v2 3/4] arm64: dts: mediatek: mt8370-grinn-genio-510-sbc: Add Grinn GenioSBC-510
Date: Tue, 19 Aug 2025 15:02:30 +0200
Message-ID: <20250819130231.181571-4-mateusz.koza@grinn-global.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819130231.181571-1-mateusz.koza@grinn-global.com>
References: <20250819130231.181571-1-mateusz.koza@grinn-global.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-NA-AI-Spam-Probability: 0.47
X-NA-AI-Is-Spam: no

From: Bartosz Bilas <b.bilas@grinn-global.com>

Add support for Grinn GenioSBC-510. Based on the commit introducing
support for the Grinn GenioSBC-700, this change adds support for the
Grinn GenioSBC-510, a single-board computer based on the MediaTek Genio
510 SoC.

More details about the hardware:
- https://grinn-global.com/products/grinn-geniosom-510
- https://grinn-global.com/products/grinn-genioboard-edge-ai-sbc

Signed-off-by: Bartosz Bilas <b.bilas@grinn-global.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mediatek/mt8370-grinn-genio-510-sbc.dts   | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 7383d75d8041..729d786b1236 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -102,6 +102,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk-eth.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk-hdmi.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-genio-510-evk.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-grinn-genio-510-sbc.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-grinn-genio-700-sbc.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts b/arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
new file mode 100644
index 000000000000..117ea694cda3
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 Grinn sp. z o.o.
+ * Author: Bartosz Bilas <bartosz.bilas@grinn-global.com>
+ */
+/dts-v1/;
+
+#include "mt8370.dtsi"
+#include "mt8390-grinn-genio-som.dtsi"
+#include "mt8390-grinn-genio-sbc.dtsi"
+
+/ {
+	model = "Grinn GenioSBC-510";
+	compatible = "grinn,genio-510-sbc", "mediatek,mt8370", "mediatek,mt8188";
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 1 0x00000000>;
+	};
+};
-- 
2.43.0


