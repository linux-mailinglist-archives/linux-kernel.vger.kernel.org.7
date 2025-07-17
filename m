Return-Path: <linux-kernel+bounces-734800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDE2B0867D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD91A1A6062F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F48224244;
	Thu, 17 Jul 2025 07:22:22 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023078.outbound.protection.outlook.com [40.107.44.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230921A420;
	Thu, 17 Jul 2025 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736940; cv=fail; b=ISQmB3Q/+n1bYtJQAxwGgHbYCom2RvOrgQWI5TUP4KFWE9VnjznYrR74xnW3lou7AtgHWCU30xtIL/X9M9zyiNfVNwYB0SE7EnhXoCMXS47FxyGFY/kLGcIXXnDvcim9bLKEphQXIhoACOhyCQ5mzYk4AsxS06laV4Z62vTpYx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736940; c=relaxed/simple;
	bh=JRN2ljHVBBY7ai/t/BpovGaTgvK1+v9AdYv6ZRiliW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tf9SG6m53+AbyTB7lCl5A56jF+PZE6UNrDRRKhKmTC40/LKesst6ReAiCtfUZImh8VpPJFhpPs4T+5Ln8gjHVK0SeGKbOy5O5v6ExMdB0OzAk/6756MQPuy8FWA/vVR+NFOc/arc785fD0PX6VpZhHPlGguOB8JPjHXUeJJPNeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6OfNCLtYdRi3GgfgkbqQQEf4X9w9lPvpmBdDOzDel4wHdLRofS0prLtN597n9xyJNZGq3eq0QWW+NaJFygUSZMnxMiLuu17cXJFuLp677McANf/Ts4GGm/hOkt9vNvtsqsKjYfMUXdMjgEuq1rINEru8mFJgGzOxHkKukIxo+S+VLtIBa2NEeDac9kJ5yQcurBCgCutXZkhlz1OGMUnYE3IKX7Mpw/wRg1hU7+mq4Veak2bytOIaO0+dZq1j3rnFVMs+W8ngd4lDJfStW0VuVMLNFUMOZygZ+ziZrnb9CcphYIfL/EqlpWVtKN1N267tcZv3NzXuH1HN+rNVuPaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3euCWX6pwPggQv/zGyKbELE85jUTcbFEKYVVbed01E=;
 b=H536PR3rwhF43gbao+mXRKbZaMEJd3pW3yHz3zLMRZLe0Opq2sUZgFAzUd0YzUdR0ajApV/GJbu6SxEyDyZgqwalxF3W/3tsGeEF9vFWdlXN5/AtK67Q3NKh4PnkT+foJCXGwZLuu1ZmYj0oqdcOt1PXkYy6mSsYTXK8a+Fy5MHFFeoQFeeyzH57Q+y6uhex2olcmm6OdJPYnP8zQ1tRxHjAlRyC2grpDZg/PKI4IQ3h8vkFLehyDH+15GUaR8dfzRj4ElU/m5glhygCNGOeYly8yz2konQvpzrHxWYfw0/u+95/7MCb+loLTQqhqRJ2zIf4f/V9hQVpWZTQUFO0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0030.apcprd02.prod.outlook.com (2603:1096:4:195::17)
 by KL1PR0601MB5702.apcprd06.prod.outlook.com (2603:1096:820:b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 17 Jul
 2025 07:22:12 +0000
Received: from SG1PEPF000082E8.apcprd02.prod.outlook.com
 (2603:1096:4:195:cafe::dd) by SI2PR02CA0030.outlook.office365.com
 (2603:1096:4:195::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 07:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E8.mail.protection.outlook.com (10.167.240.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 07:22:12 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1FF714160507;
	Thu, 17 Jul 2025 15:22:10 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	jassisinghbrar@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	maz@kernel.org,
	sudeep.holla@arm.com,
	kajetan.puchalski@arm.com,
	eballetb@redhat.com,
	Peter Chen <peter.chen@cixtech.com>,
	Guomin Chen <Guomin.Chen@cixtech.com>,
	Gary Yang <gary.yang@cixtech.com>
Subject: [PATCH v10 8/9] arm64: dts: cix: Add sky1 base dts initial support
Date: Thu, 17 Jul 2025 15:22:08 +0800
Message-Id: <20250717072209.176807-9-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250717072209.176807-1-peter.chen@cixtech.com>
References: <20250717072209.176807-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E8:EE_|KL1PR0601MB5702:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0aeef978-1aa0-42dc-f071-08ddc502a61f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s328FXK3LDAkspFaD36SrhFqwIWAAzltNhhnqyd4pdc3L0PS4OXYHEYcXT1h?=
 =?us-ascii?Q?tNG/2y+hHwZoDeSSIcJx8CeJaVbxnczRSD/dDfFN614Yl9VKGTIjcKHEix8d?=
 =?us-ascii?Q?LNBwhLS5MPvx1qoD4oUn3mVaut3V4120btRU8JXdeasOPWx5MvmNEbGRUbU7?=
 =?us-ascii?Q?fKbJrbKJZe2ekMPjqGynwigEjeqIoaBu4XxqUjV18r9DoagBXkalJ+T4x/kT?=
 =?us-ascii?Q?53w3L3XCMeMGMVp7ROxjuZuVWIRk/LQnhbXrB5M+znR5EeiOBkGAeMu9DOfK?=
 =?us-ascii?Q?GbzZnevvgN+cT+qzkvCyUsgiEcUtC5mRyrNfgzJM5UCnwZw8pQimHgefTD8L?=
 =?us-ascii?Q?ZZFH+XW6eN4Dexc5M/eHYV8WYc+xwdfx7aTFZBXSLEmRUaCqO1eMGxy0N7wv?=
 =?us-ascii?Q?INq4CgxXqMrYkZ0PTfGmvkT93iqLv3ySnF6qT7O5skokuZ0rp018tjB48jgD?=
 =?us-ascii?Q?AHV0nHFsG7Jbq2guGhpPXDJpYTxBlsA4vcbqqmjUT9VvaYNR9UXx9Pn6uJuN?=
 =?us-ascii?Q?ldP4JQJE4XY/zkOH10OHe3DuTmu+bQ0J4E1Fi6RUS+Kb82f4ib9UuFg4+cmq?=
 =?us-ascii?Q?m1g6y31A1KbV1YsUIeUid+dA1IFW44yEJ/+Qgz/UwYL3XPESXWd13WNO7SdT?=
 =?us-ascii?Q?IN1uhvKMoP6h71sa+MCw5ZI3E0Kx5JY64Cm1Imlbll4rHowfLaVo+YorpAL1?=
 =?us-ascii?Q?iMIt24C5KhyfNZHY2Zk9Std4oqCQP2pX5kZrFptrTfFWUW9G5etKVgrEBlx0?=
 =?us-ascii?Q?kb8fR80MHRffQEUcc0IUsNR0mlwns4aY7+PqwLmjfsQqV8n96a8go0MmI2Rw?=
 =?us-ascii?Q?PepZ2ewlBnspEUNo0qBaSfCQyAfgCPopiiL+W1h5lM4PsnUr7W4N0N/cEMIh?=
 =?us-ascii?Q?rq9tXnM35kC/16CCmkeieEPQotA1+FtJfSuqGWplJy1FCQ8rPLorIKojwXI0?=
 =?us-ascii?Q?9Uj3S3mysxj+iDKyynLP9XjRW+HZRO7UaZUkOc6UG7Oufha6QbzhHu99StRi?=
 =?us-ascii?Q?9FCvN3MT7vnD5u9h6D/kwnF4Zv2kfYblpx536ax6mOZgUHbfo0IwUZHi+RpD?=
 =?us-ascii?Q?0kCgvPJRBkbXhUDs5IU9Ki0oC+vv1StqegjdETmhccVkjhw9Ps1AnqFRCbsI?=
 =?us-ascii?Q?1iUQAwqbTblMNrR2GdnAbHQ5ZNsMwkABvXKICC5r76mKjQ1Ixn5u0rSgmXtd?=
 =?us-ascii?Q?ilo/SLBlD/CP7GKfT7CAZYGz7/VOZcsTpUhjWrVa7V4tPGv5fX6khizuLdt2?=
 =?us-ascii?Q?OVCwUR4wEbDm8FGCrfWETwFTyQm8lma1BvXb1tYnWk6iCZUVmBmI3f39qgWV?=
 =?us-ascii?Q?v6/Y2n2NU0inAQw1fcMkKTHM508IyzRRgZhoUm0D4tSRYYfKn0wDFSCQxI7U?=
 =?us-ascii?Q?vqxYv3LCwh55rMmSc90r0RwW6W9Hkx4N/Vz/64mINt2rklvN3tGOxp0IO9FV?=
 =?us-ascii?Q?BabFcgvAgeWKT+pEoWSo4mD5tXrXxbslzdPphohfFDkvGrjGpolAKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 07:22:12.2414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aeef978-1aa0-42dc-f071-08ddc502a61f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5702

CIX SKY1 SoC is high performance Armv9 SoC designed by Cixtech,
and Orion O6 is the motherboard launched by Radxa. See below for
detail:
https://docs.radxa.com/en/orion/o6/getting-started/introduction

In this commit, it only adds limited components for running initramfs
at Orion O6.

Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
Tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
Signed-off-by: Gary Yang <gary.yang@cixtech.com>
---
Changes for v10:
- Address comments from Krzysztof about "shmem" node and delete two blank lines.

Changes for v7:
- Refine *_scmi_mem nodes for their properties ordering
- Delete Krzysztof Kozlowski and Fugang Duan's tag due to substantial changes
- Add two Tested-by tags from Enric Balletbo i Serra and Kajetan Puchalski

Changes for v6:
- Add mailbox, scmi and uart support

Changes for v5:
- Delete pmu-spe node which need to refine, and add it in future

Changes for v4:
- Add ppi-partition entry for gic-v3 node, and let pmu-a520 and pmu-a720's interrupt entry
get its handle
- Remove gic-v3's #redistributor-regions and redistributor-stride properties
- Change gic-v3's #interrupt-cells as 4, and change all interrupt specifiers accordingly
- Remove "arm,no-tick-in-suspend" for timer due to global counter is at always-on power domain
- Remove timer's clock frequency due to firmware has already set it
- Add Krzysztof Kozlowski's reviewed-by

Changes for v3:
- Fix two dts coding sytle issues 

Changes for v2:
- Corrects the SoF tag's name
- Fix several coding sytle issues
- move linux,cma node to dts file
- delete memory node, memory size is passed by firmware
- delete uart2 node which will be added in future patches
- Improve for pmu and cpu node to stands for more specific cpu model
- Improve the timer node and add hypervisor virtual timer irq
- Pass "make O=$OUTKNL CHECK_DTBS=y W=1 cix/sky1-orion-o6.dtb"

 arch/arm64/boot/dts/Makefile              |   1 +
 arch/arm64/boot/dts/cix/Makefile          |   2 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts |  39 +++
 arch/arm64/boot/dts/cix/sky1.dtsi         | 330 ++++++++++++++++++++++
 4 files changed, 372 insertions(+)
 create mode 100644 arch/arm64/boot/dts/cix/Makefile
 create mode 100644 arch/arm64/boot/dts/cix/sky1-orion-o6.dts
 create mode 100644 arch/arm64/boot/dts/cix/sky1.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 79b73a21ddc2..8e7ccd0027bd 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -13,6 +13,7 @@ subdir-y += bitmain
 subdir-y += blaize
 subdir-y += broadcom
 subdir-y += cavium
+subdir-y += cix
 subdir-y += exynos
 subdir-y += freescale
 subdir-y += hisilicon
diff --git a/arch/arm64/boot/dts/cix/Makefile b/arch/arm64/boot/dts/cix/Makefile
new file mode 100644
index 000000000000..ed3713982012
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_CIX) += sky1-orion-o6.dtb
diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
new file mode 100644
index 000000000000..d74964d53c3b
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright 2025 Cix Technology Group Co., Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include "sky1.dtsi"
+/ {
+	model = "Radxa Orion O6";
+	compatible = "radxa,orion-o6", "cix,sky1";
+
+	aliases {
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x28000000>;
+			linux,cma-default;
+		};
+	};
+
+};
+
+&uart2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
new file mode 100644
index 000000000000..7dfe7677e649
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright 2025 Cix Technology Group Co., Ltd.
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/cix,sky1.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x0>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu1: cpu@100 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x100>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu2: cpu@200 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x200>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu3: cpu@300 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x300>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu4: cpu@400 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x400>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu5: cpu@500 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x500>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu6: cpu@600 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x600>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu7: cpu@700 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x700>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu8: cpu@800 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x800>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu9: cpu@900 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x900>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu10: cpu@a00 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0xa00>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu11: cpu@b00 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0xb00>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+				core4 {
+					cpu = <&cpu4>;
+				};
+				core5 {
+					cpu = <&cpu5>;
+				};
+				core6 {
+					cpu = <&cpu6>;
+				};
+				core7 {
+					cpu = <&cpu7>;
+				};
+				core8 {
+					cpu = <&cpu8>;
+				};
+				core9 {
+					cpu = <&cpu9>;
+				};
+				core10 {
+					cpu = <&cpu10>;
+				};
+				core11 {
+					cpu = <&cpu11>;
+				};
+			};
+		};
+	};
+
+	firmware {
+		ap_to_pm_scmi: scmi {
+			compatible = "arm,scmi";
+			mbox-names = "tx", "rx";
+			mboxes = <&mbox_ap2pm 8>, <&mbox_pm2ap 8>;
+			shmem = <&ap2pm_scmi_mem>, <&pm2ap_scmi_mem>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+	};
+
+	pmu-a520 {
+		compatible = "arm,cortex-a520-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_partition0>;
+	};
+
+	pmu-a720 {
+		compatible = "arm,cortex-a720-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_partition1>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		ranges = <0 0 0 0 0x20 0>;
+		dma-ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		uart0: serial@40b0000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0x040b0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&scmi_clk CLK_TREE_FCH_UART0_FUNC>, <&scmi_clk CLK_TREE_FCH_UART0_APB>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart1: serial@40c0000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0x040c0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&scmi_clk CLK_TREE_FCH_UART1_FUNC>, <&scmi_clk CLK_TREE_FCH_UART1_APB>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart2: serial@40d0000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0x040d0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&scmi_clk CLK_TREE_FCH_UART2_FUNC>, <&scmi_clk CLK_TREE_FCH_UART2_APB>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart3: serial@40e0000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0x040e0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&scmi_clk CLK_TREE_FCH_UART3_FUNC>, <&scmi_clk CLK_TREE_FCH_UART3_APB>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		mbox_ap2se: mailbox@5060000 {
+			compatible = "cix,sky1-mbox";
+			reg = <0x0 0x05060000 0x0 0x10000>;
+			interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <1>;
+			cix,mbox-dir = "tx";
+		};
+
+		mbox_se2ap: mailbox@5070000 {
+			compatible = "cix,sky1-mbox";
+			reg = <0x0 0x05070000 0x0 0x10000>;
+			interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <1>;
+			cix,mbox-dir = "rx";
+		};
+
+		ap2pm_scmi_mem: shmem@6590000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x06590000 0x0 0x80>;
+			reg-io-width = <4>;
+		};
+
+		mbox_ap2pm: mailbox@6590080 {
+			compatible = "cix,sky1-mbox";
+			reg = <0x0 0x06590080 0x0 0xff80>;
+			interrupts = <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <1>;
+			cix,mbox-dir = "tx";
+		};
+
+		pm2ap_scmi_mem: shmem@65a0000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x065a0000 0x0 0x80>;
+			reg-io-width = <4>;
+		};
+
+		mbox_pm2ap: mailbox@65a0080 {
+			compatible = "cix,sky1-mbox";
+			reg = <0x0 0x065a0080 0x0 0xff80>;
+			interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <1>;
+			cix,mbox-dir = "rx";
+		};
+
+		mbox_sfh2ap: mailbox@8090000 {
+			compatible = "cix,sky1-mbox";
+			reg = <0x0 0x08090000 0x0 0x10000>;
+			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <1>;
+			cix,mbox-dir = "rx";
+		};
+
+		mbox_ap2sfh: mailbox@80a0000 {
+			compatible = "cix,sky1-mbox";
+			reg = <0x0 0x080a0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <1>;
+			cix,mbox-dir = "tx";
+		};
+
+		gic: interrupt-controller@e010000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x0e010000 0 0x10000>,	/* GICD */
+			      <0x0 0x0e090000 0 0x300000>;       /* GICR * 12 */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW 0>;
+			#interrupt-cells = <4>;
+			interrupt-controller;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			gic_its: msi-controller@e050000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0x0 0x0e050000 0x0 0x30000>;
+				msi-controller;
+				#msi-cells = <1>;
+			};
+
+			ppi-partitions {
+				ppi_partition0: interrupt-partition-0 {
+					affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
+				};
+
+				ppi_partition1: interrupt-partition-1 {
+					affinity = <&cpu4 &cpu5 &cpu6 &cpu7 &cpu8 &cpu9 &cpu10 &cpu11>;
+				};
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-names = "sec-phys", "phys", "virt", "hyp-phys", "hyp-virt";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW 0>;
+	};
+};
-- 
2.25.1


