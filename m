Return-Path: <linux-kernel+bounces-808640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FDDB502AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DC15E1B3D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAB5353341;
	Tue,  9 Sep 2025 16:31:24 +0000 (UTC)
Received: from mail.grinn-global.com (mail.grinn-global.com [77.55.128.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8B450F2;
	Tue,  9 Sep 2025 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.55.128.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435484; cv=none; b=MEFFXYwp21H4k75yevnNBRwY2OyXVcPnqpozUdoFhieR7MFYoUBBny8uqgBCgUkLW+9uMVSQfrWAIuwNr1H7IuBfH85rwhR17B2rGaITWtzszZeOoII5RnUhoHJJW9b56RCKvfqh2NroBhEkhEnaxJL9mHKzQ+GpqnJPgU/It5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435484; c=relaxed/simple;
	bh=IUqpVBVIqQYl49CVM3hUVMSC4giUxzJbWRYyKOQxobs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBKbrOUMhSl0UNUx7lSZYokS3AfeWDmAnc8vWNIpEDB2SXc41gg3pUTmohQajtxvc1nE/FF1lyBXwPGzLMogwEeTVpYTp2eFLcMO8qgD1eVEcw5B6+SO4gdPqLOKCK7KxVKBYubO3YiiKc+CmtKJQDA1i0fkUnSV3F435jXawzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com; spf=pass smtp.mailfrom=grinn-global.com; arc=none smtp.client-ip=77.55.128.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grinn-global.com
X-Virus-Scanned: by amavisd-new using ClamAV (10)
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
Received: from mateusz.int.grinn-global.com (f90-187.icpnet.pl [46.228.90.187])
	by server220076.nazwa.pl (Postfix) with ESMTP id 687F21BCC27;
	Tue, 09 Sep 2025 18:31:18 +0200 (CEST)
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
	b.bilas@grinn-global.com,
	mateusz.koza@grinn-global.com,
	andrew@lunn.ch
Subject: [PATCH v5 3/4] arm64: dts: mediatek: mt8370-grinn-genio-510-sbc: Add Grinn GenioSBC-510
Date: Tue,  9 Sep 2025 18:30:49 +0200
Message-ID: <20250909163052.446723-4-mateusz.koza@grinn-global.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909163052.446723-1-mateusz.koza@grinn-global.com>
References: <20250909163052.446723-1-mateusz.koza@grinn-global.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-NA-AI-Spam-Probability: 0.51
X-NA-AI-Is-Spam: no

From: Bartosz Bilas <b.bilas@grinn-global.com>

Add support for Grinn GenioSBC-510. Based on the commit introducing
support for the Grinn GenioSBC-700, this change adds support for the
Grinn GenioSBC-510, a single-board computer based on the MediaTek Genio
510 SoC.

More details about the hardware:
- https://grinn-global.com/products/grinn-geniosom-510
- https://grinn-global.com/products/grinn-genioboard-edge-ai-sbc

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Bartosz Bilas <b.bilas@grinn-global.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mediatek/mt8370-grinn-genio-510-sbc.dts   | 20 +++++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index b37a8c65e724..4b8ee6970f40 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -99,6 +99,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-genio-510-evk.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-grinn-genio-510-sbc.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-grinn-genio-700-sbc.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts b/arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
new file mode 100644
index 000000000000..92ff80e60974
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
@@ -0,0 +1,20 @@
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
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 1 0x00000000>;
+	};
+};
-- 
2.43.0


