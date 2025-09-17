Return-Path: <linux-kernel+bounces-820284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55ABB7D8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284764E3924
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC03630CDB9;
	Wed, 17 Sep 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WJkxqMh6"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C48930EF9D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099061; cv=none; b=Zc8k8GBf4TGHYVHYx26KFzb+a2rEGXB078O995NJ0y41Y4EdhCHLQGjdbG/xi3Cvfj0dklYQ3C7ww2mMw7GomYVs+st7jJs0/6ETHGO3iuv+2BLA6wlU7b4l2ZZTFebBnpIRwf7+bZaP00QaJr+ZOkQ70mRslThu8vvyZHzFOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099061; c=relaxed/simple;
	bh=v5mdKVNA2fXREnhbIPNmxtZMo2leiCFd4QyPhWq6K+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kbJmbrhIt1l6Z197R0pkC8OREKE5EG5MnGaRsaqEBm/fVhyV2+Se50gImUoFcVUO3q3xCaeECjndjzSiAx/K7VUdqm3PyedkluvAC2Gp+et8RNAHpw53F5Vm6D2SZ9PL+W1xdHXC80LTRy828L5mFq/AayPh1W5wPKrbhiMbv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WJkxqMh6; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250917085058epoutp0156798cc58169fdb2f21185c42fb825bd~mBcdiBjfy2880328803epoutp01K
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:50:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250917085058epoutp0156798cc58169fdb2f21185c42fb825bd~mBcdiBjfy2880328803epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758099058;
	bh=ZxOhlbK8ICcydhIlDZVWYfe0fihW305v0TiO0t+kvAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJkxqMh6Krjz/03T2upycOWw3ekoAVceI9zgBbIXmljVexRj1KdViGkU4m1jZDag5
	 uPEkSJR8Du5wHKPZIx7cn3KvlhMFNuzeSztgkNIafgFKL6Qi55+xswUVcNn11WhYfH
	 pzZzSs2qaU3usgl8UdiwLvcQmF68E77A6BhwTyIU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250917085057epcas5p308d4f45d547411642dfef2587e150140~mBcc7T9-F0100501005epcas5p3i;
	Wed, 17 Sep 2025 08:50:57 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cRXYD5ZHkz2SSKh; Wed, 17 Sep
	2025 08:50:56 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250917085055epcas5p18e688864c8e9fd788f8073510ae0d0b3~mBca209kD0062500625epcas5p14;
	Wed, 17 Sep 2025 08:50:55 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250917085050epsmtip2c958afcf2fe3877c052fcc208b38fa0c~mBcWiN0GB2771327713epsmtip2v;
	Wed, 17 Sep 2025 08:50:50 +0000 (GMT)
From: Ravi Patel <ravi.patel@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jesper.nilsson@axis.com, lars.persson@axis.com, mturquette@baylibre.com,
	sboyd@kernel.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com,
	cw00.choi@samsung.com
Cc: ravi.patel@samsung.com, ksk4725@coasia.com, smn1196@coasia.com,
	linux-arm-kernel@axis.com, krzk@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	pjsin865@coasia.com, gwk1013@coasia.com, bread@coasia.com,
	jspark@coasia.com, limjh0823@coasia.com, lightwise@coasia.com,
	hgkim05@coasia.com, mingyoungbo@coasia.com, shradha.t@samsung.com,
	swathi.ks@samsung.com, kenkim@coasia.com
Subject: [PATCH 7/7] arm64: dts: axis: Add ARTPEC-9 Alfred board support
Date: Wed, 17 Sep 2025 14:20:04 +0530
Message-ID: <20250917085005.89819-8-ravi.patel@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250917085005.89819-1-ravi.patel@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250917085055epcas5p18e688864c8e9fd788f8073510ae0d0b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917085055epcas5p18e688864c8e9fd788f8073510ae0d0b3
References: <20250917085005.89819-1-ravi.patel@samsung.com>
	<CGME20250917085055epcas5p18e688864c8e9fd788f8073510ae0d0b3@epcas5p1.samsung.com>

Add initial devcie tree for the ARTPEC-9 Alfred board.
The ARTPEC-9 Alfred is a board developed by Axis,
based on the Axis ARTPEC-9 SoC.

Signed-off-by: SungMin Park <smn1196@coasia.com>
Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
---
 arch/arm64/boot/dts/exynos/axis/Makefile      |  3 +-
 .../boot/dts/exynos/axis/artpec9-alfred.dts   | 36 +++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/exynos/axis/artpec9-alfred.dts

diff --git a/arch/arm64/boot/dts/exynos/axis/Makefile b/arch/arm64/boot/dts/exynos/axis/Makefile
index ccf00de64016..da6a426516fc 100644
--- a/arch/arm64/boot/dts/exynos/axis/Makefile
+++ b/arch/arm64/boot/dts/exynos/axis/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 dtb-$(CONFIG_ARCH_ARTPEC) += \
-	artpec8-grizzly.dtb
+	artpec8-grizzly.dtb \
+	artpec9-alfred.dtb
diff --git a/arch/arm64/boot/dts/exynos/axis/artpec9-alfred.dts b/arch/arm64/boot/dts/exynos/axis/artpec9-alfred.dts
new file mode 100644
index 000000000000..5a779f1acf3b
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/axis/artpec9-alfred.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Axis ARTPEC-9 Alfred board device tree source
+ *
+ * Copyright (c) 2025 Samsung Electronics Co., Ltd.
+ *             https://www.samsung.com
+ * Copyright (c) 2025  Axis Communications AB.
+ *             https://www.axis.com
+ */
+
+/dts-v1/;
+#include "artpec9.dtsi"
+#include "artpec9-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "ARTPEC-9 alfred board";
+	compatible = "axis,artpec9-alfred", "axis,artpec9";
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
2.17.1


