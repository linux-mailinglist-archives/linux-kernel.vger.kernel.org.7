Return-Path: <linux-kernel+bounces-736788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC10FB0A1E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346F27AD954
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D3F2D836C;
	Fri, 18 Jul 2025 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sbYYfUac"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC532D8DA1;
	Fri, 18 Jul 2025 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837875; cv=fail; b=QyRYEcHlsuXsUhe5ViMn9JnSid6bK8KBfuh5ef0WqlY2h5uY/lq1NejBZAauyP5JAGO2var520dSJOmEJYKw66b6mcPkcdTjOGVW3Gi3avJ7AOhkSe7UKtN9ZMu8BIiCkqVcSms97ATQHHLAv6/94w98NTlfAX2BWrmQ60jIZt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837875; c=relaxed/simple;
	bh=jIUZUlHT7s5cIOBFbdeB/PWThVqOU+TSdbF2sxzfa3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVAhlugM78IxyvKvZuu4hF8yYvVwZK7IfKFJ2UrFn1bUAE0DX6/HLrSh7MoS+JQL+MS4ah16cGwBpRhiB68Bl2pKxYwQgvo18blpL5jAUfvBW1PxOBXlb9I7K3FI00nEHFkf4VuO2mNcWzleHBdd3n/4VTkD8XYATwmIERkDmwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sbYYfUac; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQeIiiQCqP4CBTzBePNVvCXV1vuG3/RqvZYAAWQa1gnO3h4s78N81Z2WfwmzSO0QhaaWPRvf0cEsSO2XMlvZzTkWnT/r2wGuT02o5897honRlTnjCKBPVSM4+rU+c24a6LNmnbt+SG7dkvSbNlwYdEfdb3emPLiaHIzLhSIbGvaDnwgRtFZ7ix5ueg4E4kkaU1sxTIToYfVTm9RKYgbGkq72OvpHnVLuOxbKEY2xU5bkcp4YsNdE/pYBeaVd8OtspytYTDctl+hnPhzuqXOEgjUp5FeWIVHsJYz/MjRWpZ9J5tdnjruE0s+Sb8dChb1HCg536kpd9Xid20Ev2MuoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+J7i+QNvf36wOIqSZ6unwmt5DktLmKFsOj0EAaS4kY=;
 b=DGUBLZIu/Od9EbWuCKqLr4v1bdemIctOGfuQGICTp+h7sg2IT5gTsZ66n3XPJtp4+Vq5KvJxu9xUm9O3wiXdsazVygD6d8a4/1f6qQvQxsoF7b4H4kpBFYQbVcim4+Emi3qWTfmacNqPYS2+R4Hue4UFwy4RYs336C/zWOdOHxbEKBAyrG4zTV7skQG7l81HtbOj/yawCSlN8dSD8wGeIZkWsXFufhiq24PJMaG0OunqH6knBLHwe809EZ76CELT1UtNhTsJ3bKu2F8PuDZx/dsvazdZ8gR4XlCDeOxR6n+JVeFv6y/llP1G11ErsO854YGnSs+UdaYjV6YPKalCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+J7i+QNvf36wOIqSZ6unwmt5DktLmKFsOj0EAaS4kY=;
 b=sbYYfUacJvu8E0Yy0wH/m80sE9n1G+GbQK6v69Vu5JzwS10W7mVgraBy2b+us1CMjHkmiz5dVnfpkm/L+0gyHfNxZ6KVX3hda3O4ISBUMmYcidIZ7gvFpaYykmbYi7gcfioIwGa9lFj/578peXuetr0wrbwsADMGWGn45UHjqg4=
Received: from CH0P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::20)
 by DS0PR12MB9728.namprd12.prod.outlook.com (2603:10b6:8:226::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 18 Jul
 2025 11:24:31 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::74) by CH0P223CA0010.outlook.office365.com
 (2603:10b6:610:116::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 11:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 11:24:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 06:24:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 06:24:26 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 06:24:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/3] arm64: zynqmp: Add support for kd240 board
Date: Fri, 18 Jul 2025 13:24:08 +0200
Message-ID: <05ff505c6b6517e3aba983a21454c568c5e86389.1752837842.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752837842.git.michal.simek@amd.com>
References: <cover.1752837842.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12562; i=michal.simek@amd.com; h=from:subject:message-id; bh=jIUZUlHT7s5cIOBFbdeB/PWThVqOU+TSdbF2sxzfa3U=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRU6d34cfLQJy7NnlsBwmkM69aa9Qewv5HtkJo1KSzl+ vHIpfkrOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiInwM/+wPNMZPs9nCnLPe cXLvMpV7CUpTnHcrrOwKsl2pafpOQZXhn0150tk7m9e3NXvckpwTWd0585+O8IIWo2gzrR1fe2X 52QE=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DS0PR12MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: afdf6543-2e21-4047-0bb2-08ddc5edaaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KH2ywSR/kKCe+ArMZFC4ePaWlfhZOr3ZiXkATloEGhBia6DqgzCu6IV3qll+?=
 =?us-ascii?Q?qnphArPgKbP/KkEviOeCgGo+McMRG+C/CUSAvVu7rLEjS8svJtYpRWhKpzGr?=
 =?us-ascii?Q?sceDsQkARj+aSjOE0TNH2cOBjn0qZ1utuxYvMXDBd6sH99be4LIV9BwHa9B/?=
 =?us-ascii?Q?FnxUr85e9HbE0UbItUiP+gfs6QVnTveenkFvPPiIVB2mF+HbhCKMIynQ4s1A?=
 =?us-ascii?Q?dQlcIAz0yONJ7oloeX+/wwKUpDbdENARqR7OWAheTNzdPCq+PojYv3bxuWn1?=
 =?us-ascii?Q?n/9RmHE6qS8KsqQTycLFjQA3Hzscf1kmI8Y7uUxtiyMWOfSYJTsp3623S42i?=
 =?us-ascii?Q?yF6IX8JzoioaRzOF2Y+/q1lJjo0yWoiG+xyFaq4z/GP466ta0TmI4MT7WPKV?=
 =?us-ascii?Q?Gz6uwZoCz72titSheA8ZMb6gwjMCUpomdjMblkvsmo6mkyls4zo+Q4XMCRha?=
 =?us-ascii?Q?94WbJ14KXIkOyLwhyQd9CakLA8OlkpravEmILiL+q1qfrWLKwaHsxmOJeL+Q?=
 =?us-ascii?Q?mpnnTwZ5Z32tdI17W8fMM8QvNdtfq/YMfmdpYeyn1S9INUKx2CKezE10fudW?=
 =?us-ascii?Q?NTocOeURhKNAjcP4GlnHvgBgjiBAjCB6svTfpKPGafywFftIfKAneaC6pDPF?=
 =?us-ascii?Q?CSsGmD3JmUpeISgTGVbJvhrmRASXgCC/0ZjI5fol2IwM+1CA2frsuc0/Ur3z?=
 =?us-ascii?Q?bM5O4H37Xz8XpCr2iXLEIe99FHaNTtKC5Fu9niivDxCS2TMLksdMob/PmOTP?=
 =?us-ascii?Q?mQb9u9RFFliO1QCEiJxCtLkiPll21un2/M0tO6IU260IMJoWVqMjQHH+87Ep?=
 =?us-ascii?Q?93HHiVy32qUfehYGSIxMv6s0BFRjeKYFIvRuyDzM+3U3u/5e+oMSd3SW/Jf5?=
 =?us-ascii?Q?iokPEss8SIM7ZeypEaWkRhhNQNUcXQBm/EfdkTVffVDyx4gV8/1mirutDPol?=
 =?us-ascii?Q?UKvFndcQTfGTCROxbqQlPrjAmra+Wb2Fi7NyBBGWvRC94AHBXTu1F9Z2qRxZ?=
 =?us-ascii?Q?5sXR9958AOvn9LBcZqR/r6JB8xrgR1J9p5QOoKAyGaKiw57axo06Ld2z/eD6?=
 =?us-ascii?Q?M3RhRAGCbtZ7Ptt6VVCPjfYxio6/gNia1PHjCaI4YDK0DenAHCoB1SSP3edC?=
 =?us-ascii?Q?Bg8RBkiDVTXiKRVmxAS3qEDOedr+GwhupJ66+iNmS84pH+1VYnt6O/Ni7ZC7?=
 =?us-ascii?Q?B4es2DfzFWCrVWTaQNv/E5OJt+SuE0jIdoy94tF5SM3Fz6led/Ra5C9iReB/?=
 =?us-ascii?Q?gYHm+UUWttwm4xK3G7PtGHSMSLuz/MdeLVW2/o2hIOmoUzeBpDKK6nv9Y0Ju?=
 =?us-ascii?Q?CnxZgkR/AuPBSWNzWPa89h0FFV0VplywzVsuLbu2hUdnYzqUGmdOOPPuUDf1?=
 =?us-ascii?Q?cUo5CYxx8GLpCvlajs7CYrkhrc0CfIvjfx4erX0R5NDXvvali9EyrDI7sqqm?=
 =?us-ascii?Q?atHerijF6Xavsv1eL3gQ4iw1ZBl3jRKA885oarOMPGm/LjuqE/07jrxOi2HY?=
 =?us-ascii?Q?cRGksBVVkgcFsrrThy4TZ52CozfwpgWulXsgSKlnsnayC2tTtZZ6Ja6cKQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 11:24:31.7216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afdf6543-2e21-4047-0bb2-08ddc5edaaaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9728

The kit is using k24 SOM by default and it is used for motor control and
DSP applications.

K24 SOM is also possible to used with kv260 and kr260 CC which are also
wired in Makefile.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

https://www.amd.com/en/products/system-on-modules/kria/k24/k24i-industrial.html
https://www.amd.com/en/products/system-on-modules/kria/k24/kd240-drives-starter-kit.html

---
 arch/arm64/boot/dts/xilinx/Makefile           |  15 +
 .../boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso | 390 ++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-sm-k24-revA.dts    |  23 ++
 .../boot/dts/xilinx/zynqmp-smk-k24-revA.dts   |  21 +
 4 files changed, 449 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts

diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index 5e84e3c725e2..70fac0b276df 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -39,4 +39,19 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kr-g-revA.dtb
 zynqmp-smk-k26-revA-sck-kr-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kr-g-revB.dtbo
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kr-g-revB.dtb
 
+zynqmp-sm-k24-revA-sck-kd-g-revA-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kd-g-revA.dtbo
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kd-g-revA.dtb
+zynqmp-smk-k24-revA-sck-kd-g-revA-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kd-g-revA.dtbo
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kd-g-revA.dtb
+
+zynqmp-sm-k24-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kv-g-revB.dtbo
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kv-g-revB.dtb
+zynqmp-smk-k24-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kv-g-revB.dtbo
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
+
+zynqmp-sm-k24-revA-sck-kr-g-revB-dtbs := zynqmp-sm-k24-revA.dtb zynqmp-sck-kr-g-revB.dtbo
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k24-revA-sck-kr-g-revB.dtb
+zynqmp-smk-k24-revA-sck-kr-g-revB-dtbs := zynqmp-smk-k24-revA.dtb zynqmp-sck-kr-g-revB.dtbo
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k24-revA-sck-kr-g-revB.dtb
+
 dtb-$(CONFIG_ARCH_ZYNQMP) += versal-net-vn-x-b2197-01-revA.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
new file mode 100644
index 000000000000..02be5e1e8686
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for KD240 revA Carrier Card
+ *
+ * Copyright (C) 2021 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "xlnx,zynqmp-sk-kd240-rev1",
+		     "xlnx,zynqmp-sk-kd240-revB",
+		     "xlnx,zynqmp-sk-kd240-revA",
+		     "xlnx,zynqmp-sk-kd240", "xlnx,zynqmp";
+	model = "ZynqMP KD240 revA/B/1";
+
+	aliases {
+		ethernet0 = "/axi/ethernet@ff0c0000"; /* &gem1 */
+	};
+
+	ina260-u3 {
+		compatible = "iio-hwmon";
+		io-channels = <&u3 0>, <&u3 1>, <&u3 2>;
+	};
+
+	clk_26: clock2 { /* u17 - USB */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+
+	clk_25_0: clock4 { /* u92/u91 - GEM2 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	clk_25_1: clock5 { /* u92/u91 - GEM3 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+};
+
+&can0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can0_default>;
+};
+
+&i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	u3: ina260@40 { /* u3 */
+		compatible = "ti,ina260";
+		#io-channel-cells = <1>;
+		label = "ina260-u14";
+		reg = <0x40>;
+	};
+
+	slg7xl45106: gpio@11 { /* u13 - reset logic */
+		compatible = "dlg,slg7xl45106";
+		reg = <0x11>;
+		label = "resetchip";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "USB0_PHY_RESET_B", "",
+				  "SD_RESET_B", "USB0_HUB_RESET_B",
+				  "", "PS_GEM0_RESET_B",
+				  "", "";
+	};
+
+	hub: usb-hub@2d { /* u36 */
+		compatible = "microchip,usb5744";
+		reg = <0x2d>;
+	};
+};
+
+/* USB 3.0 */
+&psgtr {
+	status = "okay";
+	/* usb */
+	clocks = <&clk_26>;
+	clock-names = "ref2";
+};
+
+&usb0 { /* mio52 - mio63 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_default>;
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
+	assigned-clock-rates = <250000000>, <20000000>;
+};
+
+&dwc3_0 {
+	status = "okay";
+	dr_mode = "host";
+	snps,usb3_lpm_capable;
+	maximum-speed = "super-speed";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		i2c-bus = <&hub>;
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		i2c-bus = <&hub>;
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&gem1 { /* mdio mio50/51 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem1_default>;
+	assigned-clock-rates = <250000000>;
+
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@8 { /* Adin u31 */
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id0283.bc30";
+			reg = <8>;
+			adi,rx-internal-delay-ps = <2000>;
+			adi,tx-internal-delay-ps = <2000>;
+			adi,fifo-depth-bits = <8>;
+			reset-assert-us = <10>;
+			reset-deassert-us = <5000>;
+			reset-gpios = <&gpio 77 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+/* 2 more ethernet phys u32@2 and u34@3 */
+
+&pinctrl0 { /* required by spec */
+	status = "okay";
+
+	pinctrl_can0_default: can0-default {
+		mux {
+			function = "can0";
+			groups = "can0_16_grp";
+		};
+
+		conf {
+			groups = "can0_16_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO66";
+			bias-pull-up;
+		};
+
+		conf-tx {
+			pins = "MIO67";
+			bias-pull-up;
+			drive-strength = <4>;
+		};
+	};
+
+	pinctrl_uart0_default: uart0-default {
+		conf {
+			groups = "uart0_17_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO70";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO71";
+			bias-disable;
+		};
+
+		mux {
+			groups = "uart0_17_grp";
+			function = "uart0";
+		};
+	};
+
+	pinctrl_uart1_default: uart1-default {
+		conf {
+			groups = "uart1_9_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			drive-strength = <12>;
+		};
+
+		conf-rx {
+			pins = "MIO37";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins = "MIO36";
+			bias-disable;
+			output-enable;
+		};
+
+		mux {
+			groups = "uart1_9_grp";
+			function = "uart1";
+		};
+	};
+
+	pinctrl_i2c1_default: i2c1-default {
+		conf {
+			groups = "i2c1_6_grp";
+			bias-pull-up;
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux {
+			groups = "i2c1_6_grp";
+			function = "i2c1";
+		};
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
+		conf {
+			groups = "gpio0_24_grp", "gpio0_25_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux {
+			groups = "gpio0_24_grp", "gpio0_25_grp";
+			function = "gpio0";
+		};
+	};
+
+	pinctrl_gem1_default: gem1-default {
+		conf {
+			groups = "ethernet1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO45", "MIO46", "MIO47", "MIO48";
+			bias-disable;
+			low-power-disable;
+		};
+
+		conf-bootstrap {
+			pins = "MIO44", "MIO49";
+			bias-disable;
+			output-enable;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins = "MIO38", "MIO39", "MIO40",
+				"MIO41", "MIO42", "MIO43";
+			bias-disable;
+			output-enable;
+			low-power-enable;
+		};
+
+		conf-mdio {
+			groups = "mdio1_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+			output-enable;
+		};
+
+		mux-mdio {
+			function = "mdio1";
+			groups = "mdio1_0_grp";
+		};
+
+		mux {
+			function = "ethernet1";
+			groups = "ethernet1_0_grp";
+		};
+	};
+
+	pinctrl_usb0_default: usb0-default {
+		conf {
+			groups = "usb0_0_grp";
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO52", "MIO53", "MIO55";
+			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
+		};
+
+		conf-tx {
+			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
+			"MIO60", "MIO61", "MIO62", "MIO63";
+			bias-disable;
+			output-enable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
+		};
+
+		mux {
+			groups = "usb0_0_grp";
+			function = "usb0";
+		};
+	};
+
+	pinctrl_usb1_default: usb1-default {
+		conf {
+			groups = "usb1_0_grp";
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		conf-rx {
+			pins = "MIO64", "MIO65", "MIO67";
+			bias-high-impedance;
+			drive-strength = <12>;
+			slew-rate = <SLEW_RATE_FAST>;
+		};
+
+		conf-tx {
+			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
+			"MIO72", "MIO73", "MIO74", "MIO75";
+			bias-disable;
+			output-enable;
+			drive-strength = <4>;
+			slew-rate = <SLEW_RATE_SLOW>;
+		};
+
+		mux {
+			groups = "usb1_0_grp";
+			function = "usb1";
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+	rts-gpios = <&gpio 72 GPIO_ACTIVE_HIGH>;
+	linux,rs485-enabled-at-boot-time;
+	rs485-rts-delay = <10 10>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0_default>;
+	assigned-clock-rates = <100000000>;
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
+};
+
+&zynqmp_dpsub {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts
new file mode 100644
index 000000000000..653bd9362264
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP SM-K24 RevA
+ *
+ * (C) Copyright 2020 - 2021, Xilinx, Inc.
+ * (C) Copyright 2022, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include "zynqmp-sm-k26-revA.dts"
+
+/ {
+	model = "ZynqMP SM-K24 RevA/B/1";
+	compatible = "xlnx,zynqmp-sm-k24-rev1", "xlnx,zynqmp-sm-k24-revB",
+		     "xlnx,zynqmp-sm-k24-revA", "xlnx,zynqmp-sm-k24",
+		     "xlnx,zynqmp";
+
+	memory@0 {
+		device_type = "memory"; /* 2GB */
+		reg = <0 0 0 0x80000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts
new file mode 100644
index 000000000000..7308983b15a0
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Xilinx ZynqMP SMK-K24 RevA
+ *
+ * (C) Copyright 2020 - 2021, Xilinx, Inc.
+ * (C) Copyright 2022, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include "zynqmp-sm-k24-revA.dts"
+
+/ {
+	model = "ZynqMP SMK-K24 RevA";
+	compatible = "xlnx,zynqmp-smk-k24-revA", "xlnx,zynqmp-smk-k24",
+		     "xlnx,zynqmp";
+};
+
+&sdhci0 {
+	status = "disabled";
+};
-- 
2.43.0


