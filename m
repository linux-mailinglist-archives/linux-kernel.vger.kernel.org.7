Return-Path: <linux-kernel+bounces-736719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0ABB0A0E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69267A86913
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9562BE023;
	Fri, 18 Jul 2025 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mIkaEbhy"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783892BDC20;
	Fri, 18 Jul 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835541; cv=fail; b=E/MIy0Uv1tDpThN4mMaP2Jg9xMMMr/AF60H3nIbPkE7hPwBwXZTglPqKK3Q6ZA7Px3B8GcLwhgiRirjOoFfKAYah4a0eoiHQO33jiwpXdwDkFglXzeW29USUeNo7wILDspy0r8uxW350qdpHh1mhyPhaR4tyhWDpUPaIw6d+YtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835541; c=relaxed/simple;
	bh=w7kn53DQfyjaBAuEzrXSBcx46hx/PAYsHi7SHcVh9tI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuvH1dvOYtER+WDlN5+7HHrfv6D34tjuZz+/KtdNiEDwCtLSN+AWt+W3efS+IQxRej48vJgKVRjbEca1iA5u8224oBRvHKnHLdGieXA+lS/AGl3EYg0ihPiUAj+X+A1K7v39yOuXFY6a+p6NQEyGBrHf8inpEseN8HOB6haABR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mIkaEbhy; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+mbUqPwsinnQbJN1oyayzcsEfaVRyeOaHBVip/yhguTdXjJ9Dxyqdz6fu8QhcFI1gQLjaPd7C9wy17h/Zf1defMIkVNcy4pWyAC9ubWiHQsMzSxuTYNsa2UmvSMI25b5PgxNOXbgtY44iqB48ypceEJ5+T0KxV13sMb/RViL7HVV3FQi+rMNSc8jU6ds9Uky6njgg7IgO7WXLs5T7f8pR824MLlJ9vAixnWojn4Sr+Uod81lEiIk8+L7J1PN0lw50luqQK9XMai/1wyEZeP0jsR6o2PZIByEB/OGq2LGWwHXg6GO+jAlmIrNcn5mxzxgjqFtGSGl7eW1xwBgoIwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNIQNvhfCw7etbaIyI5S0NQ4ys+UQX3cxRkonYcRNQ0=;
 b=I9OFnAmgXF8AW6mnD77myKPafAGSyxTa6EbdJxvawwKy+SPeD+zFWBqQFxFWJgeDs+/TamgJPEQeabYl2bgnlRGZXWG+3Fpy8gzf8wZM0iPaGl20Zpi24outyHBp5EJ9/tJ2pK7Y7AcYCsliccjSKf3WvAKeO5LHYOGO3B/FUmDzS48fWWaLkRFi/De3r8PqDCPJQCVROOr5Js1XfAUm5S4cwJG/DZC+Td6yD3DmqMKZcCNWV22eM5xp0Awuq1sOhCwpiukya4enJGTMeappvTKoIkeOrd/A1K3YiFNQBcSIloHDsIMqjYDQ0ZnGbHw3mhvVTn0GIQ1SdjxWn2Rv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNIQNvhfCw7etbaIyI5S0NQ4ys+UQX3cxRkonYcRNQ0=;
 b=mIkaEbhyMbi+izukoiwcEHPCPwUhIwZYnGNpE6jvONOa5ZZNXFa4fE6ltLia7ZY1ncsGxj75ZWHL1MrqmVDQQIKlaOivT8sIm/5IC7krKnuHXgeeH38uwgRjEgyNC2HVknZS9OblafFIgYAa8u+oNBJNsxdxN/bvkTMzJuqdWtY=
Received: from CH5P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::15)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 18 Jul
 2025 10:45:35 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::37) by CH5P222CA0001.outlook.office365.com
 (2603:10b6:610:1ee::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 10:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 10:45:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 05:45:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 05:45:32 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 05:45:32 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Paul Alvin <alvin.paulp@amd.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/7] arm64: zynqmp: Add cap-mmc-hw-reset and no-sd, no-sdio property to eMMC
Date: Fri, 18 Jul 2025 12:45:08 +0200
Message-ID: <10132834c0509539b0d01ff5097591cd2e3ae125.1752835501.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752835501.git.michal.simek@amd.com>
References: <cover.1752835501.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=michal.simek@amd.com; h=from:subject:message-id; bh=wN7QVdJRflMJoH3tQ9WyTOuD52xlLFrI0B8EWs+tMpc=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRUqe4oD+/ylzXiqvbU95Q3epN4NbLVMHt3xElu8zMSx /etL5ndUcrCIMbBICumyDKdScdhzbdrS8WWR+bDzGFlAhnCwMUpABP518jIsCht4vLrvokKqlt6 p04x9LjjeCD+7LFvfGaSrOzHWdTCGhgZPgmcZ7u98lFWoN6q5LndHeoR894Isbfv7T269sTcjKd GHAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: fa48c3d7-d773-46e1-7908-08ddc5e839f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CubvoO4bTmYjKlFPeQkgZzOH7x43Vys4ktIUZ9m+5Hh2ZxukPkAf778s8+HC?=
 =?us-ascii?Q?0QAYd+nSR7Zsn7tsVZIc6Jp77TqDJ2yWLLsODOmgAsRcm3DniBHVPXrTBp1e?=
 =?us-ascii?Q?ZyE6Oo91n7Xzym122qYnfMUPKIF0kYpIgj+B6zeGstzyKV9oLWzV/agJvJcs?=
 =?us-ascii?Q?RIapQ66WHwUeiVsT2PIOcpsfcWH3+thurPtaeOZ+EnAybUk3NKw1PiLmJLBB?=
 =?us-ascii?Q?pv32IOLOzliVgzD5URyBW0r+f0VjB1osIgXV9/CarhUmhBXCQBs0bjLsLd+4?=
 =?us-ascii?Q?+f3pNLJNPmsPMS001gzke7WGy4B+g36sqsPYfdEpoOLRNZtOTSiEUUf9Q5jQ?=
 =?us-ascii?Q?MtC/7GmX3qin1mKpW2TfC4OmTP6dZAo3eb04BxDcx01gWm2eNWF7HMgxuHNh?=
 =?us-ascii?Q?WGrj02VYcWhNv7c3iiIz77Zdy/F/Hh7zX53c1wOCjVhw+dUvr+pR5e7+ot+c?=
 =?us-ascii?Q?1/yMq/5/KzE+ieW2MLHtP2+U3TqEtsPTQAweoA+/+xoIk8jFVLIKXCfwesMn?=
 =?us-ascii?Q?uVUV/3nkN1fLRh/QiBWatlJlxLNWQ9bm53sPYooQ92WThFUDAZfu9ar/uD2M?=
 =?us-ascii?Q?lVSQCyC3SYhwmT3AtcYtlRogpanAURp1c8Azeglxt/zZjOvjtcqnncaEoSHB?=
 =?us-ascii?Q?RQtk2KO4J3Tm0YqZrsbj9lDxQg08cy+byiGR15j5zCCiIgaQkInl87IGwFDa?=
 =?us-ascii?Q?QizfczedngHZX/TZ5PZFydclvlGE3M24DldoONUd1orHeFkBZtc2nwtsE9jn?=
 =?us-ascii?Q?7AZi08Hh6PfRIxXyw0sU+d8xh0ipfOQ0JT7mmtXFyQHsrIbQABQVIHtR6o4I?=
 =?us-ascii?Q?wDED6HzrA8O552gmFZ/ml/kTCX6LUMgmAfnRDHFITvWMZ1xJVBAAW/lyqlZT?=
 =?us-ascii?Q?XxvFrz1vRDTKR4oBh1vjGvb59VIJN1WGurae6ji70C27rE3pzD8vtq8hibyT?=
 =?us-ascii?Q?xQLbRVLagv/GhXAXcVoxQ/bVXdjUVrlVvI7xxWW4JhF6nBq2zlLGiw81FHAn?=
 =?us-ascii?Q?CRyo1Ldfr+cmWym4oFuxhZdOdReqPU0WJedF/1W3MsBTPp/z0r4d0m3pOe+M?=
 =?us-ascii?Q?YFd/+6p6rkgKj3MfKE8+TXp/Sns0l42XPEfAL8wpkNha8m0IVPHVKbsPpNxN?=
 =?us-ascii?Q?X8fCvvuxzYGtE5g1Czxfkwn0Fzk3x7DS02QGIqh5AEDg57pP8FTvOOov/ms0?=
 =?us-ascii?Q?Hgg/n45fk2oTDGyVLPK7W0sUHk4rGeI/pkqy32gsvdAumDy5f6bHSXxHpxv6?=
 =?us-ascii?Q?pcTi3WoyOt/YraHhPtFb39eQGCQ+rZb0FjnFFIRPZS5tYar28JhwBLZ2lrWe?=
 =?us-ascii?Q?UG9U4Lp9qkyO+ah6URjlYruOK66Cu7s2empxpq4nPIeENdVX47lr3lT96+qc?=
 =?us-ascii?Q?nmX9lIKZeNF+FWHoXhBW3NzbQGQtRtVoaX0ylScEA9eaWxNLyjdiQYvhZOy1?=
 =?us-ascii?Q?yxkeBXXq8VzeJ+dga9IsmPCijtzTPUXCthyR9mk9HP1brKKhvvuCCMskfFDP?=
 =?us-ascii?Q?2Z6vlvLuS2JjJTPFpmqA44yLnJ52q7r8WH7A?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 10:45:35.1465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa48c3d7-d773-46e1-7908-08ddc5e839f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547

From: Paul Alvin <alvin.paulp@amd.com>

Add "cap-mmc-hw-reset" property to the eMMC DT node to perform the
eMMC device hardware reset.
Also, add "no-sd", "no-sdio" properties to eMMC DT node to skip
unwanted sd, sdio related commands during initialization for eMMC
device as this may lead to unnecessary register dump.

Signed-off-by: Paul Alvin <alvin.paulp@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 3 +++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index bfa7ea6b9224..51778df5540c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -233,6 +233,9 @@ &sdhci0 { /* MIO13-23 - 16GB emmc MTFC16GAPALBH-IT - U133A */
 	pinctrl-0 = <&pinctrl_sdhci0_default>;
 	non-removable;
 	disable-wp;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	bus-width = <8>;
 	xlnx,mio-bank = <0>;
 	assigned-clock-rates = <187498123>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 62c2503a502a..3542844e6977 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -509,6 +509,9 @@ &sdhci1 {
 	xlnx,mio-bank = <0>;
 	non-removable;
 	disable-wp;
+	no-sd;
+	no-sdio;
+	cap-mmc-hw-reset;
 	cap-power-off-card;
 	mmc-pwrseq = <&sdio_pwrseq>;
 	vqmmc-supply = <&wmmcsdio_fixed>;
-- 
2.43.0


