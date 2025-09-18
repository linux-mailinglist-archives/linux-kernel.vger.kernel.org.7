Return-Path: <linux-kernel+bounces-784640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12861B33EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA731A84642
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD382EA483;
	Mon, 25 Aug 2025 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k+ptjRfk"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968F2ECEA2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123672; cv=none; b=YNxcN8kFxG1ufX/Vm3Ka47mfATofvewZMYyMJgnW6FKUuqHXS6E2dzco0cCc0XRvVqocuqc9BZNbNDBf5AYYJSR9ONKx+JLzTN45ytXvjY+/ZaIOq2+YzSEVbdBucuIN1Zs4qJToX6rf5/wJuO5boMoNbRoxLV2w4rSniAt32D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123672; c=relaxed/simple;
	bh=rbBy0w9M6q9x3ha5J9MDoFowYJp2wd6lE8hvb+1vwKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=C4HWAKBTFHJ9geM4gQUeS7ZTAzgaHdsDNqrXb5Q9dorA0uafAmsaGr1LwP/XZXCTp+1vI1rwfZIQRlCSAxELOyEXtVS97JWYrmCe/xatwcwiCcXj5xA2q29XrsvP3U/4o18/uHxJEgmM/U2Y+ElATZ/pUl03WAgt0LNyVix9GYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=k+ptjRfk; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250825120744epoutp0217486a2c1c24da81d171607dff3da927~fASsPcYTP2340723407epoutp02K
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:07:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250825120744epoutp0217486a2c1c24da81d171607dff3da927~fASsPcYTP2340723407epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756123664;
	bh=yQuDkkBEvyY5Pt7iRYQ2Pcj3famUClF/QwXS+CmFsW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+ptjRfkbP4L3InbPfHnJf9pgsaPs6UgGIseEaIE7fc+N986MY4QoIhu15Kun7i9q
	 07CRGlye4NYJ8GKjDzK1PljhFntgAYSc/O9uCK8mXS2VydQ255jJynOrMwwESQPMsy
	 BMYOXezb4KozllDMcE2uiPLqcCNEY6I59HNSl4nU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250825120742epcas5p266a687acad9962b98900030f7afaf43c~fASq6yuUb2987329873epcas5p27;
	Mon, 25 Aug 2025 12:07:42 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4c9V0s5D2nz3hhT3; Mon, 25 Aug
	2025 12:07:41 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250825120740epcas5p2b43e92d4d025d267ad6386bdc2ff6af7~fASpSbEEH3099430994epcas5p2t;
	Mon, 25 Aug 2025 12:07:40 +0000 (GMT)
Received: from Jaguar.samsungds.net (unknown [107.109.115.6]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250825120736epsmtip232dfbdd1bd0c14003435fa816071f3d6~fASkvHorg0172901729epsmtip2t;
	Mon, 25 Aug 2025 12:07:35 +0000 (GMT)
From: Ravi Patel <ravi.patel@samsung.com>
To: jesper.nilsson@axis.com, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org,
	s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com,
	linus.walleij@linaro.org, tomasz.figa@gmail.com, catalin.marinas@arm.com,
	will@kernel.org, arnd@arndb.de
Cc: ksk4725@coasia.com, kenkim@coasia.com, pjsin865@coasia.com,
	gwk1013@coasia.com, hgkim05@coasia.com, mingyoungbo@coasia.com,
	smn1196@coasia.com, pankaj.dubey@samsung.com, shradha.t@samsung.com,
	ravi.patel@samsung.com, inbaraj.e@samsung.com, swathi.ks@samsung.com,
	hrishikesh.d@samsung.com, dj76.yang@samsung.com, hypmean.kim@samsung.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@axis.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, soc@lists.linux.dev
Subject: [PATCH v3 09/10] arm64: dts: axis: Add ARTPEC-8 Grizzly dts support
Date: Mon, 25 Aug 2025 17:14:35 +0530
Message-Id: <20250825114436.46882-10-ravi.patel@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250825114436.46882-1-ravi.patel@samsung.com>
X-CMS-MailID: 20250825120740epcas5p2b43e92d4d025d267ad6386bdc2ff6af7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250825120740epcas5p2b43e92d4d025d267ad6386bdc2ff6af7
References: <20250825114436.46882-1-ravi.patel@samsung.com>
	<CGME20250825120740epcas5p2b43e92d4d025d267ad6386bdc2ff6af7@epcas5p2.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: SeonGu Kang <ksk4725@coasia.com>

Add initial devcie tree for the ARTPEC-8 Grizzly board.
The ARTPEC-8 Grizzly is a small board developed by Axis,
based on the Axis ARTPEC-8 SoC.

Signed-off-by: SeonGu Kang <ksk4725@coasia.com>
Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
---
 arch/arm64/boot/dts/exynos/axis/Makefile      |  4 +++
 .../boot/dts/exynos/axis/artpec8-grizzly.dts  | 35 +++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/axis/Makefile
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec8-grizzly.dts

diff --git a/arch/arm64/boot/dts/exynos/axis/Makefile b/arch/arm64/boot/dts/exynos/axis/Makefile
new file mode 100644
index 000000000000..ccf00de64016
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/axis/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtb-$(CONFIG_ARCH_ARTPEC) += \
+	artpec8-grizzly.dtb
diff --git a/arch/arm64/boot/dts/exynos/axis/artpec8-grizzly.dts b/arch/arm64/boot/dts/exynos/axis/artpec8-grizzly.dts
new file mode 100644
index 000000000000..5ae864ec3193
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/axis/artpec8-grizzly.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Axis ARTPEC-8 Grizzly board device tree source
+ *
+ * Copyright (c) 2025 Samsung Electronics Co., Ltd.
+ *             https://www.samsung.com
+ * Copyright (c) 2025  Axis Communications AB.
+ *             https://www.axis.com
+ */
+
+/dts-v1/;
+#include "artpec8.dtsi"
+#include "artpec8-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+/ {
+	model = "ARTPEC-8 grizzly board";
+	compatible = "axis,artpec8-grizzly", "axis,artpec8";
+
+	aliases {
+		serial0 = &serial_0;
+	};
+
+	chosen {
+		stdout-path = &serial_0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+	};
+};
+
+&osc_clk {
+	clock-frequency = <50000000>;
+};
-- 
2.49.0


