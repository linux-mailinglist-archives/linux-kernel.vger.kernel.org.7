Return-Path: <linux-kernel+bounces-647426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CE9AB6826
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 11:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FDD3B1CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F00269830;
	Wed, 14 May 2025 09:54:40 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6626560D
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747216479; cv=none; b=uuXzNOaUJRuwTJxbrz8EjlhVZBrEC5EXYwcTYW9kQOg+EahrsK2DmyPKfZbC60FD2f5AQumiVFljOxy3z0q6ret8DL63GKNU8UwuxjZYKEog2gVQTrAe0gq9pWMREMtH5vIrVPkNeW+wbUkYgTawROVRvC85vcnsj0fwqBNtda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747216479; c=relaxed/simple;
	bh=63SOELCORMxrKVDUUIzKKFTRBqKDHRIy+LUddzrAvg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WI7GybW0qatp8B73T1Htrir8VUDJspXRAufHAC+0HH64HRT0H6Dz7ijrBXCZ+v8IDgD9FlcujPV08RxLEyA5UhyQASwSsGVX0iwcwYIU4UudhrWUewygbffmpivmw4gXHOpvruacDrWfF61l5XJIdUAypgkRhg17tm7wtlfnHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 54E9s3iV092466
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 17:54:03 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 14 May 2025
 17:54:02 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To:
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <alex@ghiti.fr>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <geert+renesas@glider.be>, <magnus.damm@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tim609@andestech.com>,
        Ben Zong-You Xie <ben717@andestech.com>
Subject: [PATCH v4 8/9] riscv: dts: andes: add Voyager board device tree
Date: Wed, 14 May 2025 17:53:49 +0800
Message-ID: <20250514095350.3765716-9-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514095350.3765716-1-ben717@andestech.com>
References: <20250514095350.3765716-1-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 54E9s3iV092466

Introduce the device tree support for Voyager development board.

Currently only support booting into console with only uart,
other features will be added later.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 arch/riscv/boot/dts/Makefile                |  1 +
 arch/riscv/boot/dts/andes/Makefile          |  2 ++
 arch/riscv/boot/dts/andes/qilai-voyager.dts | 28 +++++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 arch/riscv/boot/dts/andes/Makefile
 create mode 100644 arch/riscv/boot/dts/andes/qilai-voyager.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 64a898da9aee..3b99e91efa25 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 subdir-y += allwinner
+subdir-y += andes
 subdir-y += canaan
 subdir-y += microchip
 subdir-y += renesas
diff --git a/arch/riscv/boot/dts/andes/Makefile b/arch/riscv/boot/dts/andes/Makefile
new file mode 100644
index 000000000000..c545c668ef70
--- /dev/null
+++ b/arch/riscv/boot/dts/andes/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_ANDES) += qilai-voyager.dtb
diff --git a/arch/riscv/boot/dts/andes/qilai-voyager.dts b/arch/riscv/boot/dts/andes/qilai-voyager.dts
new file mode 100644
index 000000000000..fa7d2b32a9b4
--- /dev/null
+++ b/arch/riscv/boot/dts/andes/qilai-voyager.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 Andes Technology Corporation. All rights reserved.
+ */
+
+#include "qilai.dtsi"
+
+/ {
+	model = "Voyager";
+	compatible = "andestech,voyager", "andestech,qilai";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@400000000 {
+		device_type = "memory";
+		reg = <0x4 0x00000000 0x4 0x00000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.34.1


