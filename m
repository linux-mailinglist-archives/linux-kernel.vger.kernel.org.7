Return-Path: <linux-kernel+bounces-736723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF0DB0A0F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B931C4851A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C872BEFE3;
	Fri, 18 Jul 2025 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wKBFVKda"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30712BE7B5;
	Fri, 18 Jul 2025 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835559; cv=fail; b=poqsFopHfQQkiDwnJSm5dLjUgguvyk5pVjchYXTOx9TSIVo2mQe2FTm/PqDctkN1vlvHg36UxCcRnUiKsOjG4Y2vUfEsGICvy6KIKYjp41T84rrNjwb3Tfr9ESpv/nDteDfQuBL2AUe+B//rUMvK/oFDb14mzDWlYULk53RRqmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835559; c=relaxed/simple;
	bh=PHgrzrXRduF5tSkfGbXu/ulnPH8BTGBNuf2o+TuO8OA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9ll/yqvJKxPsb3oZ7pflT5q/Czx3nhAnsQYNeXVUMT41WaYHfaO2vwsB4T+10RISTSx0+WXnAtNi86OHxLae9/Y2BtCeeFg/t3Pid2QarLZWAx2w3ENOjWGV3GjGKOASh2X8ctPlsjpVqSaA+uekK6tXjMttGrEakXvilWTGX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wKBFVKda; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRUtivAlAKWs3Z59RFAv0+qJA7yqSBragrsnoNUPXuOC7LiO7K9JWHMf9qhNS2s1VJtef1KlBtBgrFwA5ne3dEdQRp1t34v/+6ibw3xsU4iIY2VctT47s1yfpsr0YIZL3N90UsMz+qQnft0PXw4pAEw0gGmdn/juaV5QFSUVzr17mcDimKpSLwCLG8y1p9tPEAYOAsmrFgCUY5vDpbnfv+H47golo6fWTIv78SP7Lw6r6+MGmRrl20sTWHLZiv7xs8wA+9sNT9bGpQHLui37YqF6l8HixkK0cHOrK1XA3ygUp8NVT6P/MZ/4kXRfuoPi+wcX+hhyC2u0lBYEYmaeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FRRGi/xM1mO5oVMzhKO7Kt4lzmCe9snMZQ/wiaZCfU=;
 b=OFz5CZgCYoyybxbICT2EK1LKgl5Sz+Km2KObxPx1R3yaKTWkRTIMuxDylHeVr7pIXeszsaOsnIuy2491M/U/3OtpdOXs/dgi7pY+eu+OBJ5sKquRvoTBTGC2BeKfzqY9It+D0D+BQsmk2O3kp45Q+655DLw9ivYpft8aXWSxm5qL55p6S7zF+2VPYpNZFJvPugE7HiJwdCwMaRk+Gaemp59LLw/q+qd0IRu0u9mntAjS40ufbTn3gYFa+NF/JuMCAc9WjOrq5HgzRXZjNzGVQCUk2HGRl756H9B4jOkHCKUnQTlAHyvVwUGcc4NOA1t6Tj5rYnysEeaAqRQ5e8Mc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FRRGi/xM1mO5oVMzhKO7Kt4lzmCe9snMZQ/wiaZCfU=;
 b=wKBFVKdakPypehR6H9T0RMouoAqfXCFLfA3RHLVkbYJnkWMxi6LTw1xzdXABvJ3w2iENfQ1dLfleej2lt8sdVsv2wtMo4nz+xr1omRav1kecs/2LaPigxEq1WqMkNYDuqdfnVp8jTMV8dYx6jEGBr/AjkVbDc4xUYLlb0g7hr14=
Received: from CH0PR04CA0086.namprd04.prod.outlook.com (2603:10b6:610:74::31)
 by SJ5PPF4D350AC80.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::993) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 10:45:53 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::33) by CH0PR04CA0086.outlook.office365.com
 (2603:10b6:610:74::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 10:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 10:45:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 05:45:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 05:45:50 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 05:45:50 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Rohit Visavalia <rohit.visavalia@amd.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring
	<robh@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 7/7] arm64: zynqmp: Enable DP for zcu100, zcu102, zcu104, zcu111
Date: Fri, 18 Jul 2025 12:45:12 +0200
Message-ID: <0ac8df0c942ed9068e0b60a840fee6b9f7df2293.1752835502.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752835501.git.michal.simek@amd.com>
References: <cover.1752835501.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4608; i=michal.simek@amd.com; h=from:subject:message-id; bh=jyMvlXoDIpLHyFB6zsnug6Un9bdzJMUf/3BsBmtH9O8=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRUqe7ep7tGnOtnRrj8lHMZ1ildu1X3+zdPPnz7e8Tlz R3fypwvdZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBELOcxMnwXFp+nd0LacO+k p/ySVc/u31g8481V53l7wt828ywUusPN8E/lt8nz5piXT75f/cdeFRJm2Ga+8IXliRW+a7/2Tt9 +XoURAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SJ5PPF4D350AC80:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f33675e-207e-4d2d-144d-08ddc5e84487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kGwUilBCiNUvdqN1rlrYYtWu3SrY2LDsNCQmAlyhuolyiw6SVMqiB3cM2GJP?=
 =?us-ascii?Q?aTR4oe+heazDX5OyE3IbTnMGeNsChRWFIDK7Kp9DIjusW4WP0YCOpo5baZm6?=
 =?us-ascii?Q?JrLeW+inxFig7deBxbPtFzMudcteY5KDoe5UTD4mihfAZorHztTmZGgARKm6?=
 =?us-ascii?Q?aZ+yNL9+Yvs7sDYHnXfCQmJ7BCipdY8utBZyTHz4fAeUm544c2kZSYNrhq3t?=
 =?us-ascii?Q?bLZzVyKHUq2k55ekI8cYnR+knHCMSAnpzl/ENbqW0rSHGhX6W16jQsbsbca3?=
 =?us-ascii?Q?PucYkMT9iteZe2nvcHiCR9zNyMPdOZH8CpVyqV+7O2swuh/dp/W1LI/HAASa?=
 =?us-ascii?Q?1Gzms3U9fG6owLpMkDfmw6NG/iFrT4hURSBSmHVBHN66mGnlMCOQbW4Njmv+?=
 =?us-ascii?Q?WI++F2DfKZCbsG+9i/aUWOZ2C1Av1XOEaPJIEbzoRsfPjGbigCO7UxfrKgxN?=
 =?us-ascii?Q?IyLrfMTf1p3o0rqcauKfXxOZfDOFPeLV1OQk0wg1uyKjYp8a5cp/QgKG8nCL?=
 =?us-ascii?Q?4ky7QPtBbQqxqcMDdWVnWPH+DDQM9vI4PObQJ6DRGJEXl0Rze9FWLfpfNi5s?=
 =?us-ascii?Q?tkGLybzE8SrvJoHJBCFu7pREKUvuzUESl6zhO0yll0ycdXTyPaPd+XYqfByJ?=
 =?us-ascii?Q?+mrhYxP2T06sRgWIZOGXTkwghGgCxV0Y8hL9+RcxN70rGA4u4akgEVsgST+L?=
 =?us-ascii?Q?r/IGC4/mvK6BdcYetkquAmS8Lb9DZDdixA9Tf0jFNP7jYqpsPHbdddEaLUvt?=
 =?us-ascii?Q?ZwL9V3Q5VweBaHvFyKtmmpy512mASKYdzMQibYN2l0UCLNi23nTvViyljwDQ?=
 =?us-ascii?Q?qhk3JPfZjBOm4zM8WHkqZeMc/4zGX++pbAhdb7uEKRRE6Cgz+sBlysjzsDaC?=
 =?us-ascii?Q?L/SZ8LaEE5ft9MGmnM9YYJ8RHRG2W/UiHHRG0KZsADBp5yoUAQw0zmthWKf3?=
 =?us-ascii?Q?3AOFg77lGg9A2BOWax/UfNJQyp8WR9kGCs3D3akWn9vZGhCirEQTREBz/Tgp?=
 =?us-ascii?Q?qndhPQB+hX0SQaOOL86B2pRkSQGey1B9dvfVfHXxwFU6NLwjHA2fpgTc92Or?=
 =?us-ascii?Q?gvDsLplkcLidqqhb4VnXsUVXHGkB6nADOA6UVjTUzi+FCDHYFonJZZizHVYw?=
 =?us-ascii?Q?BC1YFwjenA3Mk3Bh6UZkPHDxwsQuUUlS5BTdTBr/VVRJSsdE5RXdT01taFSQ?=
 =?us-ascii?Q?0BQ4IeIR/79rB2ZI8G290EBbzDoJm+wpmHTUR07ZbiSpXIzIgnU70lMrrXyr?=
 =?us-ascii?Q?jwVPfl3kcztuLb1XJWcl8n3Fd61wBjFs9IXm2YVFDuI4Gj258bUsQ4aFNe/y?=
 =?us-ascii?Q?Qn65QFHd2ujLB2d4wSjeFy/ABVlcX/mywe/1avNFmVXE0Txd3cpHoNtOgxpo?=
 =?us-ascii?Q?TVDZxcigtZBaGAO0ia1twuWQNOTaGigK3pLmOx1wQhzyz1xrLfcKrqJPaQdK?=
 =?us-ascii?Q?YQAYQeF/QV/MtQ33biVqL2wM/stkcjBP65DHu6CAKm+l7TE5vRd4ao4+/4R3?=
 =?us-ascii?Q?Z1ce9DzFn9EmwBfzX/8BSWZVgckRgxgJY6Ou?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 10:45:52.8736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f33675e-207e-4d2d-144d-08ddc5e84487
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4D350AC80

From: Rohit Visavalia <rohit.visavalia@amd.com>

Upstream DP DT binding enforcing dp-connector and port description to
operate properly.

Signed-off-by: Rohit Visavalia <rohit.visavalia@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts     | 18 ++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts     | 18 ++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts     | 18 ++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts     | 18 ++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts     | 18 ++++++++++++++++++
 5 files changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 3542844e6977..4ec8a400494e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -134,6 +134,18 @@ si5335_1: si5335-1 { /* clk1_dp - u23 */
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
 	};
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
 };
 
 &dcc {
@@ -607,3 +619,9 @@ &zynqmp_dpsub {
 	phys = <&psgtr 1 PHY_TYPE_DP 0 1>,
 	       <&psgtr 0 PHY_TYPE_DP 1 1>;
 };
+
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 7e26489a1539..e172a30e7b21 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -151,6 +151,18 @@ refhdmi: refhdmi {
 		#clock-cells = <0>;
 		clock-frequency = <114285000>;
 	};
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
 };
 
 &can1 {
@@ -1045,3 +1057,9 @@ &zynqmp_dpsub {
 	phy-names = "dp-phy0";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 3>;
 };
+
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index eb2090673ec1..fe8f151ed706 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -60,6 +60,18 @@ clock_8t49n287_3: clk27 {
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
 	};
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
 };
 
 &can1 {
@@ -529,3 +541,9 @@ &zynqmp_dpsub {
 	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
 	       <&psgtr 0 PHY_TYPE_DP 1 3>;
 };
+
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index 4694d0a841f1..3ee8ab224722 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -65,6 +65,18 @@ clock_8t49n287_3: clk27 {
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
 	};
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
 };
 
 &can1 {
@@ -541,3 +553,9 @@ &zynqmp_dpsub {
 	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
 	       <&psgtr 0 PHY_TYPE_DP 1 3>;
 };
+
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index a0cddaa64424..428b5558fbba 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -129,6 +129,18 @@ ref48: ref48M {
 		#clock-cells = <0>;
 		clock-frequency = <48000000>;
 	};
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
 };
 
 &dcc {
@@ -864,3 +876,9 @@ &zynqmp_dpsub {
 	phys = <&psgtr 1 PHY_TYPE_DP 0 1>,
 	       <&psgtr 0 PHY_TYPE_DP 1 1>;
 };
+
+&out_dp {
+	dpsub_dp_out: endpoint {
+		remote-endpoint = <&dpcon_in>;
+	};
+};
-- 
2.43.0


