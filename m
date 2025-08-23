Return-Path: <linux-kernel+bounces-783224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38852B32ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA78E1BC6F5C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E63218AB4;
	Sat, 23 Aug 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oiv07CJ7"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362F1F0E39;
	Sat, 23 Aug 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755966684; cv=none; b=EseSt8SAmDVlz3ckhKkpTFzoFFUc8DaFEAnqZmOi4N4JRY6HXdEXD/aj27oOYJGSrXQkE3jqzBjGENgB3tdB5UYpbmgvS17nx8rxfmfUpgb7onvAl1xdl/EFXYj73Dvg2qGcWS6g74RtAaXFunTohk/joG/+gZPiWszzEIAiRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755966684; c=relaxed/simple;
	bh=lmyqhIrw+YcSr05/64OhZB7+iiD1HfpSSuVskGLxp8Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yt0cc2TNDehHGLTJHzD2qx955aFuJ/JLyNIv99SI72Q3WxYQV3YW1s5Em6I+qDdP2+/vNrvE/TTDpWRYoECWMa1ESjD3opE+huvbps7UoKo6L1G4oXrZtvLjlS5kzXEGriOrMdoIL5MokKss5JGioz1w/olib0KviLnHtf2WHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oiv07CJ7; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57NGVHU8467550;
	Sat, 23 Aug 2025 11:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755966677;
	bh=DcoXsYIjaBtcL7QL8FUHWo9FxoVRQus5TrRk0YzmKTk=;
	h=From:To:CC:Subject:Date;
	b=oiv07CJ7vGqx2aenMP28t8spnWA5guxVqEQ8tYFDsuCGWc9eyOGP0RJYm7cVGUNxd
	 PNqLl1c01gb6jeOq0pCEU5fViD1zjjeIvTgg9g+uNNl5G/h4X/sbEPVRdpiCOQQUB7
	 8VOVn7w6qlJq9qJ3jL7mnLvANZGN5gbSPqcYro9w=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57NGVG4k249151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 23 Aug 2025 11:31:16 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 23
 Aug 2025 11:31:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 23 Aug 2025 11:31:16 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57NGVBxV1006218;
	Sat, 23 Aug 2025 11:31:12 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] arm64: dts: ti: k3-j742s2-mcu-wakeup: Override firmware-name for MCU R5F cores
Date: Sat, 23 Aug 2025 22:01:11 +0530
Message-ID: <20250823163111.2237199-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The J742S2 SoC reuses the common k3-j784s4-j742s2-mcu-wakeup-common.dtsi
for its MCU domain, but it does not override the firmware-name property
for its R5F cores. This causes the wrong firmware binaries to be
referenced.

Introduce a new k3-j742s2-mcu-wakeup.dtsi file to override the
firmware-name property with correct names for J742s2.

Fixes: 38fd90a3e1ac ("arm64: dts: ti: Introduce J742S2 SoC family")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v2: Changelog:
1. Posted this patch as a fix as decided in v1, so added Fixes tag.

Link to v1:
https://lore.kernel.org/all/20250522073426.329344-2-b-padhi@ti.com/

 .../arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi           |  1 +
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi
new file mode 100644
index 000000000000..61db2348d6a4
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for J742S2 SoC Family
+ *
+ * TRM: https://www.ti.com/lit/pdf/spruje3
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+&mcu_r5fss0_core0 {
+	firmware-name = "j742s2-mcu-r5f0_0-fw";
+};
+
+&mcu_r5fss0_core1 {
+	firmware-name = "j742s2-mcu-r5f0_1-fw";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j742s2.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
index 7a72f82f56d6..d265df1abade 100644
--- a/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
@@ -96,3 +96,4 @@ cpu3: cpu@3 {
 };
 
 #include "k3-j742s2-main.dtsi"
+#include "k3-j742s2-mcu-wakeup.dtsi"
-- 
2.34.1


