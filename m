Return-Path: <linux-kernel+bounces-736718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F42EB0A0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC9A1C46392
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0132BCF66;
	Fri, 18 Jul 2025 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lWbjzEKd"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9319B2BDC02;
	Fri, 18 Jul 2025 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835536; cv=fail; b=l6j8VcCgJH+jI4bHYuauZzm5Fg/9Sy16mPISYYBPC1fGXrSKimtSCEmwCWxLTF+zk0FaroIfze/z3BadKbTkO4sTZAbMEVu/rSJ1SbAE277RNm0bXxFAKdAttnl58cjEe0YiFbv4T2glfrDd1mTPqqYe3ms2xqQZH6PEAVm7S1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835536; c=relaxed/simple;
	bh=lu54kFv+xXSN72T7GgpVOnDQpZAcMHFK/XfnU8b68T0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWhgbblqCYvsD+GUQeoF6z+nIrIX851SBU7BA3kxAGi+eCU2gBivVv8/aO549ZNfu5HLXKdbIlSWMUpvn2wh16AWFWutGzYfEi4XMGHGq1l8Ix8pK5K+fn+Q6FR6lTnnq8x2ggWIuDbNuUzAwYhRBNa/sOzGHZnxNIQFu+6P7o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lWbjzEKd; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeQDxnNv0o89DfEOfscVGbh+2+KKU9X7uaww2hNbzF6gKjA8FstZDSg5RznI9r/J75JWf/8thYCB2Q3lH4E8xiMhyTGFKg39wbgWeHlEly+T9Fm3kKyy5zTZVAG/Q+xccGuhU5IQEtRBG5CrDQFc5cktYRN5mIgMjeUy8o5i9S+Q8zM6yCDMrSTVAFjHzr5lNwO/Z045Dnc/maUhU/RcZuB05Q9o1lky0WA1DbD6p/QjC7nvtZDQQvJ0o8fdWBKDtwmapqblpx/OGPG4V5DPCkSFeoYmRtt+TDsrWox6ha/q8KVW9YuleGtDwR2Ethn+Vq33ItoXwjyGu3chilQ/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJbmqPoi0XrUEBsjnvwlELctu7zump00Hou5LrzAWTA=;
 b=fbkGvqp1AguDgxbWra48gUAsdDxwPJfht4jGxcANhiCVQaZnh30St6CJ0Sz6//udxgSrD3+8GYO7EqUo75GSP+awvp+QD5dS9OFhReZWwmASSPU/bZ5Oss7qdwWOm7mazGvfHw/OAB2RDC0v75r3xEfpeCF2C3nbCGHR9n1Wp9U6bqi5mmAZxaA5oJbcy95AoTL1NsgO3KstgAW+Sn/NR2k+LBkR6OoIf0Ch8sOPqI824BH5UCqWTWUTxf/uEZ6M/nbyRnnfu53hefDdFcjAW0Tce5C7iXp4xKbxQgO+0xaQ/c8bkNEkKf0pdp0yLRyYCx9BVAtWtpcHV6KYeu+o1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJbmqPoi0XrUEBsjnvwlELctu7zump00Hou5LrzAWTA=;
 b=lWbjzEKdZlxayTUzqRaOIj7Erd5otKKBfKb/XDD7xzt9gl6IZ4afuvOmOO5jXyiIt4F3XMZ9WjGeQJrEmf+kwZQUpB2m/cRZBVV9vLLnPyOkcAuvgE5jnnotjFSBxCVqJ/itxzIjkgC43ReUafPlskHfhx/37eNxiPDaue+ObnM=
Received: from BYAPR08CA0015.namprd08.prod.outlook.com (2603:10b6:a03:100::28)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 10:45:32 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::38) by BYAPR08CA0015.outlook.office365.com
 (2603:10b6:a03:100::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Fri,
 18 Jul 2025 10:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 10:45:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 05:45:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 05:45:29 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 05:45:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/7] arm64: zynqmp: Remove undocumented arasan,has-mdma property
Date: Fri, 18 Jul 2025 12:45:07 +0200
Message-ID: <6567a0855ad73b5ff01d9945063014fbacdcc845.1752835501.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752835501.git.michal.simek@amd.com>
References: <cover.1752835501.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=michal.simek@amd.com; h=from:subject:message-id; bh=lu54kFv+xXSN72T7GgpVOnDQpZAcMHFK/XfnU8b68T0=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRUqW5n2b4lbY5LcbLelfrla6Kk4q32LnmnnnVYdO20q tNnvh7X6yhlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJeK1hZHiUFvH8YpMiq1qx 3mym10wLv0uvDHGKUXY6uv1Ryqz3d4oYGT5ePcPTrdxy2yo1xXr6zWxZrY61VkVLLtl8jGK5JKT Qxg0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b58ddb9-e040-4ec8-9263-08ddc5e837c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F+4IS21CE8UbiKT0uTuzs7EbeYm+B0onu8kufPykg5+QXH+oaNzxUMducpbl?=
 =?us-ascii?Q?VdBXnD6WCX68ufuhe8esKiu/ot5xgrSyvk3z3IvCMOupOqyCGME24Tbr5Q59?=
 =?us-ascii?Q?KyThxpi+EAVIlMzr+H3nmmvx0b1Gc4voNIbznQUDyKi4Eu8Vo2nXaYy/nkkQ?=
 =?us-ascii?Q?qEAdu8CY0B3mCllWu9OUYKPjwtPDYZYo04ea9D3SbeGwVOi2+bwHHGTGtt+2?=
 =?us-ascii?Q?CZHBzLktFCxc3x7tmE4kdrd58UHA/boONr/jM++4xLxB08CJQxMf2L221OH9?=
 =?us-ascii?Q?UGfMron9X1lNnEwqn5t+o3uqBP8qUci6ielKXMDzEXgofkYEgosK3FTNak+e?=
 =?us-ascii?Q?5F5BdAZdHfMGLSwF8dgcuT1dLflD4FqeF4mkiN84sKJRg0AmypHKEO6f3nvb?=
 =?us-ascii?Q?/uduzWEdEhVlaRfiIdcg1QWRKoHAOgDcskw7WIbEmn/j4AqtDUuHEYM6Q7qU?=
 =?us-ascii?Q?scwSr0sB/3ozWcgoUr6+ViX3o7/0hK9/+6iTbmN1n/9GXI9TuRVD/BpSW52t?=
 =?us-ascii?Q?NWQc1m0/zEiEYlvOFT+mEUg4UGcYCLWZDApOi7ngz5DFwybnxT4LX6nzix5F?=
 =?us-ascii?Q?nF7ZEGMtJEeinKFYYknRERxHVhoft2LZeLWIDuNKhx8mdwoh5+h4TRHhHJVQ?=
 =?us-ascii?Q?hqQ5B6jkRpw+sUAnlNxmK0ocuNMEZ+K2ja1XPGiLM7aJti0YBwfkU0zssp4z?=
 =?us-ascii?Q?RAX1+/i2jnFfPtg0EIWf/9bAtzfXiwiIkEkiNIwsQ/TLPY7Umbmi9XrJQE3Q?=
 =?us-ascii?Q?gWxSY3H0rreh+pzo7llrcQE4+deTkR+eDARI5yqF2+MpB4oO0ILg3eVgaJnp?=
 =?us-ascii?Q?pmWQNH3gh0uSVQOSS9m6+b4XKJm3Njppla8FA/uNUN7q5cG45ihvLvVaJ2jj?=
 =?us-ascii?Q?BVl7NivJs9ppm2upH2qp3dhGLl2lwxcNy77pOVTnTm7w9dizlhWIIzinV0z2?=
 =?us-ascii?Q?iUgHDTd1tkVbjXcI80G+NY4WzUhI49N5rOweHeRsRPT2nSDO/+DxWNapW6vI?=
 =?us-ascii?Q?dJyNeGQ7Gh2ecRHOFIfZk77G5gQWGBY0xlB2Q+dHcAZ1x7uj5cytYg+5XaTb?=
 =?us-ascii?Q?xjjOu4wBqFfpN/UW7HdtKI5/ph8MpcuwVIvj5CDWnndXNLvTGC+2R3Xn05Mz?=
 =?us-ascii?Q?EtVIDXZXPFnPxQcZ1pwA/p0BozsOTJyKEtSBKgIi5n4D5ihYJNGHL85ewng/?=
 =?us-ascii?Q?B70W7I6ur2MnmC2y+KuRGZNcHVWM9LsDWR9PGVHrkJeoz75I+2UZgvWg6PJX?=
 =?us-ascii?Q?3Ma73kTLpoeNdxOoiZkn3XRdj8DCOPHXSxaE4XtlMm5/pYW+vsG51RI79bCp?=
 =?us-ascii?Q?mrdJe302E8b5/0etYcpPNMsTOG2dq/NUURImql2jP4afQQsBKB8swIAuutLU?=
 =?us-ascii?Q?+zw43NRscvOoTjM3yxuZuh2GZcIioobzA/7w5TzZG1tAuQVjYHTNyw6r4xhE?=
 =?us-ascii?Q?yBPRtWkI+ddw37JBH9DC7rBtDW3L6oM+p0fAaxiK5r/XBRDBNagNP5UnDLxX?=
 =?us-ascii?Q?7Yeyk8xkGmPdy+JOaaWfe09rf2uEHw+dW2xh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 10:45:31.4524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b58ddb9-e040-4ec8-9263-08ddc5e837c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662

arasan,has-mdma is not described in DT binding that's why remove it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 1 -
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index 1850325e1d6c..2ad7423c2f05 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -135,7 +135,6 @@ &nand0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_nand0_default>;
-	arasan,has-mdma;
 
 	nand@0 {
 		reg = <0x0>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
index f553b317e6b2..8fbc33562bc4 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
@@ -129,7 +129,6 @@ &i2c1 {
 /* MT29F64G08AECDBJ4-6 */
 &nand0 {
 	status = "okay";
-	arasan,has-mdma;
 	num-cs = <2>;
 };
 
-- 
2.43.0


