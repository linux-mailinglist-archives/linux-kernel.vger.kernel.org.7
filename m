Return-Path: <linux-kernel+bounces-795733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28223B3F72E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDAD16E620
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63842E8B72;
	Tue,  2 Sep 2025 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1cV5Yw/C"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB02E7BDA;
	Tue,  2 Sep 2025 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799799; cv=fail; b=eR12J1l52avkGEEQHgfzekBn5+kIkI5OTGez6rADFKmu2uOZjex1M0iiba6GO1khUaYjFDkr6uKNWmyr1KCrNe76zXNhJRwbYa5VPNh8hMdYbf0W/OJl/dztoXFtQpWDVlQ/OnLnqFsKvO/Hpgnfaq6VZVRvLL5/9NyEpoVhvEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799799; c=relaxed/simple;
	bh=HJE07Ncd+u5zRM3umwiWnw9AIVFifdT2eUAFT/M0m40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lS+BLkg51vkJ3NkvEQ4jmAa5PaFfAcbHlYOdktsS7G37RStP9dIYKzEk23zLuvO3cutlHDC8wOU+YRYYrpMzbj31q0uTijsIKd7UWORaCHhIa6dMRBVmcpm5nRvTerBPiI1MNvRL/P1yeyl+bRxU2Jym/5/VPTbtaq+MxWT5jzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1cV5Yw/C; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYGGnkQWPtCdxpbIFFBXfPMGfjpK0ZsaZ9E4HUn4Gpj2f3Ui21Hpah5BHx6Bl+VZ9FmdY2PT2e6hLbVcNOW3qlsi6svIkSsbseNso1zkjKiJkuzftL2rTf0H1NlURDWw7mcdK7iZFiCUl48HqgZ1ey0e3res9+Q+ZYkyhQ448SuePBjA52ol3KdurXEeY2tWQCwKYQNWbXtISSO9p7TQoV24uQ4nPgAombYUT75cpLvttxtULdDwKoRy/i0tlbbzs58j2p0nKv6NyilpnnPDD5avREWJH2Qx9/hlf78oX3h22CylBDXt/p0I6sd2jYeevJUtsJ5VG0ZfpNWkwBUo7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rqkByc0jcgGmIempquzeuZVTUdtIdrSyq8yebHSqXo=;
 b=oLpwsdu2L6/Lm33HTMU4hek6C7PwoItN23HPAYPPxUTUB01gEMFvMyvWRZnkia4C87MHNioSFLZXwlxf1mTdGMwGU4oPF9AP3MzI87wnnwubzGnENPNf9Nvcb51LLFwE+vn0eNGX9UeHnYgxrAZ1bzdVRqCkJO4ISvdSbU8HI462L246UBpqyoD98FpCyiNMKXKOUpATR11ZSgdtHvcwOGpTLlTrNR9Ve7mIgofrCGQ4AZSaDsS03NQJQGAC5Hy1hAOJf7KKbscAm+QrcY42MGw9O0pDmMPFDAv5br61arMzNAwd2CWGv1j3FxkylXJjbuG15NuA+hhkyIuIJYVHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rqkByc0jcgGmIempquzeuZVTUdtIdrSyq8yebHSqXo=;
 b=1cV5Yw/CqfDsImjNiPDgazejyA4z3TdTGPIvD5q8EjqrlIZ69R1xnz3dlJ/WHV5uUJIgLTaPVxYgIGM8wzgtDBXm2meGo0Zi9EODEeYtp/w7dR7THllZgjZsvWV6o+/1RnEr8AlJRlrocL4WmGlUcFF1O0OUtHZ9u7Tm2Kr+630=
Received: from BY3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:254::10)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:56:35 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::52) by BY3PR05CA0005.outlook.office365.com
 (2603:10b6:a03:254::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.15 via Frontend Transport; Tue,
 2 Sep 2025 07:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 07:56:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 02:56:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 00:56:32 -0700
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 02:56:31 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Quanyang Wang <quanyang.wang@windriver.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring
	<robh@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/4] arm64: zynqmp: Disable coresight by default
Date: Tue, 2 Sep 2025 09:56:18 +0200
Message-ID: <7e308b8efe977c4912079b4d1b1ab3d24908559e.1756799774.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756799774.git.michal.simek@amd.com>
References: <cover.1756799774.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=michal.simek@amd.com; h=from:subject:message-id; bh=TYsqEefDGjNyozfb/G0JJAC6zN+zOsI97PTO5fmYW34=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRsW6z8VqaeWeyGcuJZW5l318q6bsxwdYzX3XSaQ/q7k G3OjHLbjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZiImTXD/6T+z2YBV4892lb5 MpPd9dH/aezJZ+/4sXIxHf54ZvvJlIcM/1P4H3mV/2z9Vanxpuuc8uVjFwsL115341G+OTk6qM7 ZkBUA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4cc545-53a3-4bce-0064-08dde9f63cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dibG0XKohGGoCV+6k2w2yRvZMkssR/v6Lm+GAPlgssZfPnLXr9yFsNI2xYEh?=
 =?us-ascii?Q?J3fWfKO35zneNGSeLwMYWVre86tgXxRFpLB8fgA/khLe4i7B46E6enztU32Q?=
 =?us-ascii?Q?UwwBdSh9klpqCnwAW4UlvoUDnUFTOPEAG5tV2GzVBhsVMOBWKnIt14X/P2U7?=
 =?us-ascii?Q?bjxV+rjL9HdTcqw8xktE+v5KSclHFWqYNpqiP/kj0DgTBQuUfCL4qnisMxFx?=
 =?us-ascii?Q?EKtW+xSGKlCCmPTZ4TR/j09TlMhVCDGGPMY8f76cqrr4TIAad7Pbo2h/j4Zf?=
 =?us-ascii?Q?NYbJmmFpCDpJ+mm7RFeTvdM5y/LE6hr5enXY0YdBB+X6TB60bqOASvAOJd61?=
 =?us-ascii?Q?NGtOK83N5OoVgK+CerBL53+N9Pq1QzvJ14TliVfUAl1xDDbXWkefo1zn9XCX?=
 =?us-ascii?Q?RZH2JWeRGH4FPJmYwgnwn+MlQvQNmI0n4EeqGit1auZ821PE6n2gesXp1zeQ?=
 =?us-ascii?Q?B/rE/y7KylRd9No21JrOFOLOaEwFJXbKwVeCL924RhslYOGb1aIDVnzroLCT?=
 =?us-ascii?Q?Cl56hy0TV3dD3iugvALW67eKrCmz9F9kAx7UtRxeQVWdQTqNzui1VOFdLAbA?=
 =?us-ascii?Q?Ht/SfYluu+y5/6QEod3SjnIkiwn5zMYjAqH97L+UfAr/qmznNuS+NCPPh8pp?=
 =?us-ascii?Q?kcn6hr4BWL3I4+kBFRFySXIVLAysO8l77ppcx5UelMIty13w2tFi2MIj1vRT?=
 =?us-ascii?Q?meGS/RwWSdWJYSdrfpubbixPr3OieN6z5ZkB1gg1yJj6pufaJoOsHX7/8br9?=
 =?us-ascii?Q?Z51w7O7bZN1Sc7EQ3Z/AYQgNimDP9TSyrOrW00VJyxl03UY6+/7xhNB1QJ2d?=
 =?us-ascii?Q?r47/g9fs6KHplfJncLw3FzRZx4yw5EYkm8Cuzr6DzTTfznYetK9Fz05hVVwp?=
 =?us-ascii?Q?L7q51OMcUXl8tK3GiWy6RJ72PudySPr1MEuYUAmPjMRgg9YQ5SwE1i+Os8+I?=
 =?us-ascii?Q?2GACyIGn0/4LzgY46KL/+Zial42Yn1+/4Rapey5xlpyS8VgejhvgCNIL8/vT?=
 =?us-ascii?Q?BinBq2e7aWVnssGVflszi1iYNMzPfYYGjULGlb1EsSWcE1PrPOATQRI2LMTn?=
 =?us-ascii?Q?T0bTDjBaccGr6eIprXPoBbA3gQ/O5cZGxTvaBTA3tS9Rb11wePW/UeteXD+j?=
 =?us-ascii?Q?VTHQAqOhf2zxyPu1HTlM6mGNA9Fe7tyVf4C7FPm3eEfbdiLlSZG2r0jODlRY?=
 =?us-ascii?Q?teFJNmMNNUnUDY1WsCBKxsercLK8xkpxK99JXGAsRluOA7DV8UUREDMs9/jo?=
 =?us-ascii?Q?HCArTCtFUzoNXEjsTCyNmB9XZvsWZfgPM4Raok9JY2mOjJBfd0M7sB5pGUdf?=
 =?us-ascii?Q?3rIfrGDBHo38jxD5arDp/n+x3xJSyqWWSsABu70hmMnYRQW6jSEXhm4KROQW?=
 =?us-ascii?Q?B/8EqvYa2udlWsvlGZOaamWzgcS43LQW2wKZhXAnszY/WLVG+kLnX4WtQgO7?=
 =?us-ascii?Q?38uAQHMJQq/03hSF365yOwEY1ySgqJzk+iNY33I5gqgV1nbf+QdDUS/9EDmq?=
 =?us-ascii?Q?bp5cR7p4CobO4QpwA2PD7CAbFdqpClr204QR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:56:34.7221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4cc545-53a3-4bce-0064-08dde9f63cd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482

From: Quanyang Wang <quanyang.wang@windriver.com>

When secure-boot mode of bootloader is enabled, the registers of
coresight are not permitted to access that's why disable it by default.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 5f26649c9e11..938b014ca923 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -550,6 +550,7 @@ cpu0_debug: debug@fec10000 {
 			reg = <0x0 0xfec10000 0x0 0x1000>;
 			clock-names = "apb_pclk";
 			cpu = <&cpu0>;
+			status = "disabled";
 		};
 
 		cpu1_debug: debug@fed10000 {
@@ -557,6 +558,7 @@ cpu1_debug: debug@fed10000 {
 			reg = <0x0 0xfed10000 0x0 0x1000>;
 			clock-names = "apb_pclk";
 			cpu = <&cpu1>;
+			status = "disabled";
 		};
 
 		cpu2_debug: debug@fee10000 {
@@ -564,6 +566,7 @@ cpu2_debug: debug@fee10000 {
 			reg = <0x0 0xfee10000 0x0 0x1000>;
 			clock-names = "apb_pclk";
 			cpu = <&cpu2>;
+			status = "disabled";
 		};
 
 		cpu3_debug: debug@fef10000 {
@@ -571,6 +574,7 @@ cpu3_debug: debug@fef10000 {
 			reg = <0x0 0xfef10000 0x0 0x1000>;
 			clock-names = "apb_pclk";
 			cpu = <&cpu3>;
+			status = "disabled";
 		};
 
 		/* GDMA */
-- 
2.43.0


