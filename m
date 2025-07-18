Return-Path: <linux-kernel+bounces-736789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B15B0A1E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B387ACEE4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3492D9494;
	Fri, 18 Jul 2025 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fwlHTVVs"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44352D8DA0;
	Fri, 18 Jul 2025 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837875; cv=fail; b=FqxoTFSYtS5lLbcVRFOqCulhr9HAjm4uY26zgACsFC/6RvDy27UJWJYGgtFEpm0hwHD0JQz/adGxx5XiIhzkg5ntz6AIVjYdzxL0ld8VNJh1Pr4GnWteJ1BBKQbUXKC17aEleHLsX7r0bkb+vjBA2NODAVJKNqEpoe6LQ+TjcHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837875; c=relaxed/simple;
	bh=AsdZuJVYhvvcz7Vn8iBGJJqMVW4b+Unr5J5Uht6sC8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkC35xxyanRf8o/uJt6CQOmCAn48SwOQLbO81mtQwKLmq97BSpk4g1YDDOXvee6h95iIuJvgV7Ir7VbmfZXruC43+QwW04Z8G0MLo0iihaYCytOyh2dG1K5Ez2/IVPpTzmjNUF0LgJwIfTa2ls79fn6cANfqICjDcyzwcCxDKNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fwlHTVVs; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlb8B0u1RJGBMIx80adKIclqI0ed5kI4nwzJHpDUGTulhfGA6qIfavI2+WiLPDygWuPQsWU3t42RkUXvh/s7jnAnWPMbV26lNSi+HmygEbimBErPyLwtNUN+wUi6glo+FY8oF4Rz9nldygjL3g7M3F+sl9PSvsr+a/OfAFwWikmFwelGcVMR70jyzaQs0INDh3DwXDb0egd5CoFuKWaF2dY2e8DNXRoGOIz80j4mjgxtB4iK5ZOF2mnsk9VGc/IZfVi2alwtApe+nYrw1lCDhE3vMk4q22sPG+T2airo2bevy3LIsk7XMhXILsa9/3LpAwkwH5aPTicKgxvGABlnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDMfDh+do25HPOXP2/p2fqJNvLHU5GUi3cdw2CGutZ8=;
 b=u7ximrD+RTDBZgHueMKQVXXmBiRfFW+JCVx6gfoPo0kyX2hlUdEf7M9KhJzrxC9Rv+8YpISItf4uJDKsi3bAI0eXZJzyT5hj4dznJ6uummtsz8ryat24HeK0zNyGB+Z94Dgpwt4+DstSje8+ufPNWdEB6kOLujV5smhjCG+ApO0smBfVNqEqj1eShPavlviyO0cm/kYQpznkI85VK0hYAEMPZImBKFy+y3/eleTiL/RW7mUfSXKnRIG/EN4DxmjTQdv1tZaN8R8+0nmpCLqEJMlEFvIwHAsgS3IaXqqbLwerpUIflXuBmOwjHM64MbZgevKwBtVEXJHgM57zd+Mx2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDMfDh+do25HPOXP2/p2fqJNvLHU5GUi3cdw2CGutZ8=;
 b=fwlHTVVshXLUJNV7wGYym9KwWlobGVBlU/o3Qu9qCmo2feB3sRCHpqwgIq4RvScNZWomaLCNw+iz/RpRkA0YDo7XgURt/AQHSCmqJMMOVkWEOnBRT6UJZtLc+6c14qDlSOJ8S4qpufXHL8YZif4oYOnkMELYKrRdDEKcKe1I/Og=
Received: from SN7P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::26)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Fri, 18 Jul
 2025 11:24:29 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::f7) by SN7P220CA0021.outlook.office365.com
 (2603:10b6:806:123::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 11:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 11:24:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 06:24:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 06:24:22 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 06:24:22 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] arm64: zynqmp: Add support for kr260 board
Date: Fri, 18 Jul 2025 13:24:07 +0200
Message-ID: <650ff5407528b8a90867ff1ac072b4112c91c866.1752837842.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752837842.git.michal.simek@amd.com>
References: <cover.1752837842.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22626; i=michal.simek@amd.com; h=from:subject:message-id; bh=AsdZuJVYhvvcz7Vn8iBGJJqMVW4b+Unr5J5Uht6sC8c=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRU6d1Im1/9ZNWd+vTISPb2R9VhSZtKC1y4t2bkXTpzW MyyLMS/o5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACbCEMbwP7nG0evvw+k3Xdkc rjT8jG/sP73DZXoh4/pppySk6w3V5zP8T1t0ydrJccZ/nw2rzy1IO7bq9vqq0Pec9xYZOBb0Xqp U4gEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6e34f4-66c9-4c69-4a8f-08ddc5eda930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Z+hbFtH74TTXFYCXQF/tI7cLnacXY4628EelzV4pOV1AsNbhdGNbk/d6EMT?=
 =?us-ascii?Q?ZdTkcR/pRf1MiJ82+tFUHcF0xNXcPNw+M7XdsK6WD4hh7gq5gxpwdZLSQbqT?=
 =?us-ascii?Q?pzqVX58AWe6AOYy/qc4Y0vtyUef6cwSsWGSCm/wOeffAuBJMU2Gsnme7OBUF?=
 =?us-ascii?Q?GF/eC6FVgfKiMeT1SEG50FLxwxDbBT4C3QvBp1OTLK2M75UL8Y2nW/K1ZY6y?=
 =?us-ascii?Q?e5t+g4VxzVZyRdPTvC7vErU0eatm6O8LPAuXsoRK4VkSrRaVmikJY9wHtrpo?=
 =?us-ascii?Q?T9cVK5udnHrQahCAe9J4i5e2tOyiGxMYvmf79DUmkpyvAVZoQomaXzel3yHW?=
 =?us-ascii?Q?xThh3BUOB4i7caXBN96rFBDcoUVM/Qu5QRgN506ZroOIIlq90PfcNwyMPJcY?=
 =?us-ascii?Q?+CYqyk7vGkPRkZf3thJl5muMiQoOEE/91X7EceDu1XieRL4ou3wbaFxvSGLa?=
 =?us-ascii?Q?UObQhxSZcP6OhwMOjCfJBno6FH6+QcyPguXNhtRC77KDLjrI0aTu8lOLNLLu?=
 =?us-ascii?Q?WOr3i3+dwNXVLT6oR9T02CNNrdzpEeOsxq5vBD1hdEbGQDSIFq1cu1NWnRgt?=
 =?us-ascii?Q?Q9leZES3ei+N1MAC7aJ/AxoCyOw/Gn60/DvtoMoegsWa8VTj/+uy/Y2deUz/?=
 =?us-ascii?Q?Bn6iIR2SjoZ8b4cr9mLytI1kH5tlU1zKXkTWhvnKpJ0L2YxHknl/TRQFSGoq?=
 =?us-ascii?Q?if9Ss5O7At0gZtxuLokGOMZMAWevGONBXH/c0m5f4KdG6WPiWCHMNbno3Jup?=
 =?us-ascii?Q?3sQJM2iJb/uJ+XY+mzBRvyuvD3jaKFkUWXrcgTxhpjrwvIyRanekZqCnBO2V?=
 =?us-ascii?Q?r7VmTEfb2kJwDmynCwDJ5YNkYf6UkfLi8MgsqtB/XDZk4xgL/FNnvt+/lghx?=
 =?us-ascii?Q?Z1fyAhC7XQBqrHzZ8DGkdC7qY10t73+jDoHH+S6bnpT5dZG5uZfQYKfh3QhC?=
 =?us-ascii?Q?E1yJ63VkNLE07Exi+FvgYJR0d/vMySLBhPrNBoeuYVOO2UpLBur0LMBVvYYc?=
 =?us-ascii?Q?iMPbTzJt7a8nDZxs74WRTKgrSdAB4kEaDaxJsQiiZUQPlZqm6PtESlKJPYoI?=
 =?us-ascii?Q?My/isdV9b2UbsgRatdfxzWyQm2N+tD7bCkrLWsOhDN12DJyaoEYjsQDE5+Yc?=
 =?us-ascii?Q?8etw3yBd1MIpU6CegFgP3PB8YvyGvVQL9eEqTzM64nlhtbNuNmy9tuu/oNWk?=
 =?us-ascii?Q?DDexs+dAThryRC9VHZsxJpHP+uCQpsjYdz0sA7ueTEiLhfBULvZlzMIrXvEo?=
 =?us-ascii?Q?ayLTvh1Nr95Qx3xqH4WieeN6HEIrt267Gi1e5pU0ABONKSboROjr0c1Y/kzl?=
 =?us-ascii?Q?zET+XXxCSTp/MSf4j3IvukGbDx0YtfEGhSeGbEbAn45kmiBTNm/5FxnrjT+P?=
 =?us-ascii?Q?2gImW1WmDvG8IqxBXRdxYz6Xgz46lqs/O+SFGKr8RaJinOMF6AX95Tj1Pxbm?=
 =?us-ascii?Q?mts22x9Dz0vydo2YCb207d8aXS9lzEMrDzFpAyV1Oc5Wq+lvWVE18ko7xwQ9?=
 =?us-ascii?Q?KnTYY2fVCbgk+rtImloq03d9hYdLeuypS0W0wANJFcRhyU161UMqH65hag?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 11:24:29.2267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6e34f4-66c9-4c69-4a8f-08ddc5eda930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

The kit based on K26 SOM is built for robotics and industrial application.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

https://www.amd.com/en/products/system-on-modules/kria/k26/kr260-robotics-starter-kit.html
---
 arch/arm64/boot/dts/xilinx/Makefile           |   9 +
 .../boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso | 438 +++++++++++++++++
 .../boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso | 451 ++++++++++++++++++
 3 files changed, 898 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso

diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index 7f5a8801cad1..5e84e3c725e2 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -30,4 +30,13 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kv-g-revA.dtb
 zynqmp-smk-k26-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kv-g-revB.dtb
 
+zynqmp-sm-k26-revA-sck-kr-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kr-g-revA.dtbo
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kr-g-revA.dtb
+zynqmp-sm-k26-revA-sck-kr-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kr-g-revB.dtbo
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kr-g-revB.dtb
+zynqmp-smk-k26-revA-sck-kr-g-revA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kr-g-revA.dtbo
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kr-g-revA.dtb
+zynqmp-smk-k26-revA-sck-kr-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kr-g-revB.dtbo
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kr-g-revB.dtb
+
 dtb-$(CONFIG_ARCH_ZYNQMP) += versal-net-vn-x-b2197-01-revA.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso
new file mode 100644
index 000000000000..fbacfa984d76
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for KR260 revA Carrier Card
+ *
+ * (C) Copyright 2021, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "xlnx,zynqmp-sk-kr260-revA",
+		     "xlnx,zynqmp-sk-kr260", "xlnx,zynqmp";
+	model = "ZynqMP KR260 revA";
+
+	aliases {
+		ethernet0 = "/axi/ethernet@ff0b0000"; /* &gem0 */
+		ethernet1 = "/axi/ethernet@ff0c0000"; /* &gem1 */
+	};
+
+	ina260-u14 {
+		compatible = "iio-hwmon";
+		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
+	};
+
+	clk_27: clock0 { /* u86 - DP */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+	};
+
+	clk_125: si5332-0 { /* u17 - GEM0/1 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	clk_74: si5332-5 { /* u17 - SLVC-EC */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <74250000>;
+	};
+
+	clk_26: si5332-2 { /* u17 - USB */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+
+	clk_156: si5332-3 { /* u17 - SFP+ */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <156250000>;
+	};
+
+	clk_25_0: si5332-1 { /* u17 - GEM2 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	clk_25_1: si5332-4 { /* u17 - GEM3 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
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
+	u14: ina260@40 { /* u14 */
+		compatible = "ti,ina260";
+		#io-channel-cells = <1>;
+		label = "ina260-u14";
+		reg = <0x40>;
+	};
+
+	slg7xl45106: gpio@11 { /* u19 - reset logic */
+		compatible = "dlg,slg7xl45106";
+		reg = <0x11>;
+		label = "resetchip";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "USB0_PHY_RESET_B", "USB1_PHY_RESET_B",
+				  "SD_RESET_B", "USB0_HUB_RESET_B",
+				  "USB1_HUB_RESET_B", "PS_GEM0_RESET_B",
+				  "PS_GEM1_RESET_B", "";
+	};
+
+	i2c-mux@74 { /* u18 */
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+		usbhub_i2c0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			hub_1: usb-hub@2d {
+				compatible = "microchip,usb5744";
+				reg = <0x2d>;
+			};
+		};
+		usbhub_i2c1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			hub_2: usb-hub@2d {
+				compatible = "microchip,usb5744";
+				reg = <0x2d>;
+			};
+		};
+		/* Bus 2/3 are not connected */
+	};
+
+	/* si5332@6a - u17 - clock-generator */
+};
+
+/* GEM SGMII/DP and USB 3.0 */
+&psgtr {
+	status = "okay";
+	/* gem0/1, dp, usb */
+	clocks = <&clk_125>, <&clk_27>, <&clk_26>;
+	clock-names = "ref0", "ref1", "ref2";
+};
+
+&zynqmp_dpsub {
+	status = "okay";
+	phy-names = "dp-phy0";
+	phys = <&psgtr 1 PHY_TYPE_DP 0 1>;
+	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
+};
+
+&zynqmp_dpdma {
+	status = "okay";
+	assigned-clock-rates = <600000000>;
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
+		i2c-bus = <&hub_1>;
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		i2c-bus = <&hub_1>;
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&usb1 { /* mio64 - mio75 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1_default>;
+	phy-names = "usb3-phy";
+	phys = <&psgtr 3 PHY_TYPE_USB3 1 2>;
+	reset-gpios = <&slg7xl45106 1 GPIO_ACTIVE_LOW>;
+	assigned-clock-rates = <250000000>, <20000000>;
+};
+
+&dwc3_1 {
+	status = "okay";
+	dr_mode = "host";
+	snps,usb3_lpm_capable;
+	maximum-speed = "super-speed";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub1_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub1_3_0>;
+		i2c-bus = <&hub_2>;
+		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub1_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub1_2_0>;
+		i2c-bus = <&hub_2>;
+		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&gem0 { /* mdio mio50/51 */
+	status = "okay";
+	phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>;
+	phy-handle = <&phy0>;
+	phy-mode = "sgmii";
+	assigned-clock-rates = <250000000>;
+};
+
+&gem1 { /* mdio mio50/51, gem mio38 - mio49 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem1_default>;
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii-id";
+	assigned-clock-rates = <250000000>;
+
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@4 { /* u81 */
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id2000.a231";
+			reg = <4>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,dp83867-rxctrl-strap-quirk;
+			reset-assert-us = <300>;
+			reset-deassert-us = <280>;
+			reset-gpios = <&slg7xl45106 5 GPIO_ACTIVE_LOW>;
+		};
+		phy1: ethernet-phy@8 { /* u36 */
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id2000.a231";
+			reg = <8>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,dp83867-rxctrl-strap-quirk;
+			reset-assert-us = <100>;
+			reset-deassert-us = <280>;
+			reset-gpios = <&slg7xl45106 6 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+/* gem2/gem3 via PL with phys u79@2 and u80@3 */
+
+&pinctrl0 {
+	status = "okay";
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
+			pins = "MIO44", "MIO46", "MIO48";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-bootstrap {
+			pins = "MIO45", "MIO47", "MIO49";
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
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso
new file mode 100644
index 000000000000..b7cda216b179
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for KR260 revB Carrier Card (A03 revision)
+ *
+ * (C) Copyright 2021 - 2022, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "xlnx,zynqmp-sk-kr260-revB",
+		     "xlnx,zynqmp-sk-kr260", "xlnx,zynqmp";
+	model = "ZynqMP KR260 revB";
+
+	ina260-u14 {
+		compatible = "iio-hwmon";
+		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
+	};
+
+	clk_125: clock0 { /* u87 - GEM0/1 */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	clk_27: clock1 { /* u86 - DP */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+	};
+
+	clk_26: clock2 { /* u89 - USB */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+
+	clk_156: clock3 { /* u90 - SFP+ */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <156250000>;
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
+
+	clk_74: clock6 { /* u88 - SLVC-EC */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <74250000>;
+	};
+
+	dpcon {
+		compatible = "dp-connector";
+		label = "P11";
+		type = "full-size";
+
+		port {
+			dpcon_in: endpoint {
+				remote-endpoint = <&dpsub_dp_out>;
+			};
+		};
+	};
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
+	u14: ina260@40 { /* u14 */
+		compatible = "ti,ina260";
+		#io-channel-cells = <1>;
+		label = "ina260-u14";
+		reg = <0x40>;
+	};
+
+	slg7xl45106: gpio@11 { /* u19 - reset logic */
+		compatible = "dlg,slg7xl45106";
+		reg = <0x11>;
+		label = "resetchip";
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "USB0_PHY_RESET_B", "USB1_PHY_RESET_B",
+				  "SD_RESET_B", "USB0_HUB_RESET_B",
+				  "USB1_HUB_RESET_B", "PS_GEM0_RESET_B",
+				  "PS_GEM1_RESET_B", "";
+	};
+
+	i2c-mux@74 { /* u18 */
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+		usbhub_i2c0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			hub_1: usb-hub@2d {
+				compatible = "microchip,usb5744";
+				reg = <0x2d>;
+			};
+		};
+		usbhub_i2c1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			hub_2: usb-hub@2d {
+				compatible = "microchip,usb5744";
+				reg = <0x2d>;
+			};
+		};
+		/* Bus 2/3 are not connected */
+	};
+
+	/* si5332@6a - u17 - clock-generator */
+};
+
+/* GEM SGMII/DP and USB 3.0 */
+&psgtr {
+	status = "okay";
+	/* gem0/1, dp, usb */
+	clocks = <&clk_125>, <&clk_27>, <&clk_26>;
+	clock-names = "ref0", "ref1", "ref2";
+};
+
+&zynqmp_dpsub {
+	status = "okay";
+	phy-names = "dp-phy0";
+	phys = <&psgtr 1 PHY_TYPE_DP 0 1>;
+	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
+};
+
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
+
+&zynqmp_dpdma {
+	status = "okay";
+	assigned-clock-rates = <600000000>;
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
+		i2c-bus = <&hub_1>;
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		i2c-bus = <&hub_1>;
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&usb1 { /* mio64 - mio75 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1_default>;
+	phy-names = "usb3-phy";
+	phys = <&psgtr 3 PHY_TYPE_USB3 1 2>;
+	reset-gpios = <&slg7xl45106 1 GPIO_ACTIVE_LOW>;
+	assigned-clock-rates = <250000000>, <20000000>;
+};
+
+&dwc3_1 {
+	status = "okay";
+	dr_mode = "host";
+	snps,usb3_lpm_capable;
+	maximum-speed = "super-speed";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub1_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub1_3_0>;
+		i2c-bus = <&hub_2>;
+		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub1_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub1_2_0>;
+		i2c-bus = <&hub_2>;
+		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&gem0 { /* mdio mio50/51 */
+	status = "okay";
+	phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>;
+	phy-handle = <&phy0>;
+	phy-mode = "sgmii";
+	assigned-clock-rates = <250000000>;
+};
+
+&gem1 { /* mdio mio50/51, gem mio38 - mio49 */
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gem1_default>;
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii-id";
+	assigned-clock-rates = <250000000>;
+
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@4 { /* u81 */
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id2000.a231";
+			reg = <4>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,dp83867-rxctrl-strap-quirk;
+			reset-assert-us = <300>;
+			reset-deassert-us = <280>;
+			reset-gpios = <&slg7xl45106 5 GPIO_ACTIVE_LOW>;
+		};
+		phy1: ethernet-phy@8 { /* u36 */
+			#phy-cells = <1>;
+			compatible = "ethernet-phy-id2000.a231";
+			reg = <8>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,dp83867-rxctrl-strap-quirk;
+			reset-assert-us = <100>;
+			reset-deassert-us = <280>;
+			reset-gpios = <&slg7xl45106 6 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+/* gem2/gem3 via PL with phys u79@2 and u80@3 */
+
+&pinctrl0 {
+	status = "okay";
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
+			pins = "MIO44", "MIO46", "MIO48";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-bootstrap {
+			pins = "MIO45", "MIO47", "MIO49";
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
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_default>;
+};
-- 
2.43.0


