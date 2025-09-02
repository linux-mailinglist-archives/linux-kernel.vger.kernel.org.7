Return-Path: <linux-kernel+bounces-796856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 481A1B40864
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956C01883CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451EE313E04;
	Tue,  2 Sep 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BdDt7jYl"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482752DFA26;
	Tue,  2 Sep 2025 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825424; cv=fail; b=CxA90vTOFw+6UjdvvS3TklH0u/AjpILXSnNKwIWv5Y0MtfAJ1W0o4t1UA6fpZKNOaQUMArboyJG54LbKzYxeb9ElOu4f3MxVFnUbGIQ3QljmL1Cu2Fr8nEOeef4bspdQxXiOl8/Jam/MaUSkQfVGvge1OlXwic/H56Vd8ZuQSW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825424; c=relaxed/simple;
	bh=ewz4w44qG8bsdtiUORF3cJqFxzCzReNDxhy/WSoGmhg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IVoErjOF1oaI2V7wVzRN8t/5Brttv9b7AibOIWxBL54OEAAP0Hgfru58dLQi5eaeQWVG4XdR0mIv0FGxGI74ppw0DTh8v2dxkBTJAlLf7ZFQ2Z7ldx+MJSLhsotFbwoGDuiMcjVJehmKoOGIl430zVQVxxJ1w1Kh92k5G9sDWls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BdDt7jYl; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jbf8wdE+eXTaMum8nFxu5OJ8IWlApWDZuet1tYezbXEQGjR1dIzwtLMz4QVW1MfzqCmgnP0U5tWu0E4BsNwlzKxU/141BHBJWJkfJb2FsQceRqE3gmMw2bELCIdEj9KFib3OSipKIBqpI6MdDfgLjukPhj1OYrCQX3wNOwAAbR+QHo64451iCRqbeI8cSCZ2jXot5+OSsuxaD1GDKI+SAAPnoktP6m8diYOIezYSFLAXQmISh7yi7My5EkK5lw/fkVwyqIYYge4c+nItEJMrx7Oa8YAW6MM3T+gmKVRq1QvZJWJXn33es9NXfvSk3R2PsK8Qh8oYGySR8+AB41mNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQW3/aY2u9o1vyBBGFhdfMivnRKVOreRPGLjsgiFn70=;
 b=fiLZsmXkWHGDojZY+8rrH0+DNTMiktJrjJVunxqjrc6TUPzwVA6Ei7cofaoLNVdqM9ktx/tcIOE2XFEdv1hS0oBQZroUXh+W02wNVQLSyN8g/inCYoCaiZQVGvoD4X61w8LuUkWMoTEK10t7lBQhRNRQ0ICYUZ9yzl/r0oSqYt1eBCvYMUqEntEn34PDPZCNN/Uc8AE8FCY676h3FCS5YXv47WljOGjwVmOMSVJ3dY019+ryKwQn5JSr57VoUozxWoIHjt6Z2vwnNw2C8Y97N1zPu6+zTkbA1uxI5NfNzHeAPY6VfSXk3vtAGoE/lVQXtRyLQM7+TfOhHjz+GTFOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQW3/aY2u9o1vyBBGFhdfMivnRKVOreRPGLjsgiFn70=;
 b=BdDt7jYlGu2TjPTLdwfsYhRgDdqsj8SrYzlS1Esv6x/qAwBjzfu3wFtWibfVZxlue4+16CTIjXxNJcbs5XwflMK/VSpiOxqWmQlFwQxSt/XkmRsfokr3HSWzJPiuDIKeLU9uQmY+Us002VOmxqAen+iejD7S6Zk09ph4M0Yl0WE=
Received: from MW4PR04CA0349.namprd04.prod.outlook.com (2603:10b6:303:8a::24)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Tue, 2 Sep
 2025 15:03:39 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::b2) by MW4PR04CA0349.outlook.office365.com
 (2603:10b6:303:8a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 15:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 15:03:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 10:03:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 10:03:24 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 10:03:23 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: versal-net: Describe L2/L3/LLC caches
Date: Tue, 2 Sep 2025 17:03:10 +0200
Message-ID: <f2ee23526349a0674149c969a2176c906e529402.1756825388.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11258; i=michal.simek@amd.com; h=from:subject:message-id; bh=ewz4w44qG8bsdtiUORF3cJqFxzCzReNDxhy/WSoGmhg=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRsZzeouOXzuZ7lXbOC2aF/Diypp5QDp6za4a/swlG89 P6TZTtmdpSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEuk4yMjTvZQ1t2lE0p0ZS ap+kwMtDf66/bTpZsn3r0o2OBiwnxM4x/GY3OMUYnp1WnTDB+sdFQ1WfTJ83jk8EpT/Pj5t0sHF yNTcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c063834-9419-4146-dd5d-08ddea31e626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4osb2w2oWeBQzTdJZRGwDo/egoQutaEdXrhTohYEhohtlleplM8xAF5U0VWX?=
 =?us-ascii?Q?aCv93HeFGCUrU4hBT9f4WQGrze/aVCraB+JghDXsrNNVtWeWyyRFgJWYT3gn?=
 =?us-ascii?Q?4CCOa9Ch3UhfLGLQbPdjXtGo05LgqXb86pAWa3zFnypI2NbsHnIfFo+neunA?=
 =?us-ascii?Q?cO/zw8k6OaJ+2GyxgpFdN9enIBw0yfvwKH4Zn/dtVrqH5ReuP/K1nstEjWLA?=
 =?us-ascii?Q?tqJz7R9CCATvaWDMUDxb0Q1S3DCT3k5V+wkQzgZnGMFXiLforRlCjCHIMwnh?=
 =?us-ascii?Q?kSts5C7vKGsahJOeInM2kgUFplHJtxdjqgkFLd0uTRvZbIN7hQMepyN51dQm?=
 =?us-ascii?Q?41+yf+0IMDpi+tXiaZpSPNQIKyqQfhcgH7g2O1xd18/5cl5FBSwnxYgPG794?=
 =?us-ascii?Q?KqgrixzIR8FwqiVTb9dZixXUTZRbbUOM66C58StrWxgj2WY1oEvYJGdS7P80?=
 =?us-ascii?Q?M/Bw38nixuNimvT/ryJvAOn+rYfyymTuWCaIcvkXv96hZEbektDeFhAQ8IYx?=
 =?us-ascii?Q?uoLuKEEBFh2/RqhPx81LBi8h0bCqvoCfNdE43OGYna7d05iJ5dmj4JTyk29j?=
 =?us-ascii?Q?s1zOT2jiFZL6Azn0hHOKZPKg5+FlVztgsrSaupKCijJzV3MkirnUvBFhrCDT?=
 =?us-ascii?Q?20s1VOGDGzQG4xCSW1TaeUgzWIzaRphrvDyX6UB1gFlx7N4JCPPbCwqTVVSc?=
 =?us-ascii?Q?NELJLa9bF6NToaJKAxciEJGPlcGM12EXf1TXABH58OcMyt8P+FTxx0iZ2Svq?=
 =?us-ascii?Q?OBGozYVm9DIWjVi4ffFDGQ82dmdE4kh6cbSZ+uqFkKlhSHyrbPviavh/snQq?=
 =?us-ascii?Q?taCPFsUy4OwoW0g1YLzy0EOXE1nRxZo23fpizEVdi2Vgbw1VwK1NE/gZQjvF?=
 =?us-ascii?Q?P6YBPkTNLcwxeQ4cS3Z1dMhRJ2rVxJOkAel5QCFcwCKbZvlcHlC53A8ClTey?=
 =?us-ascii?Q?/hXifz+JMWv49RGuA3LtI3/fSdjR2tv9/0It1tXiGOMYiSvGqCVWgubJ9FmK?=
 =?us-ascii?Q?HNrkpY6zzyQn7H+/qr5rzT8Swc3ZccW0+e4o4q291YBcQJ0zuLA+YpzT0Jar?=
 =?us-ascii?Q?xYhOlLOy19az3nq2W+CY17F5ziVJGLZv3/Tkb8VFk9EqtnWVdDYWZjmFtmyi?=
 =?us-ascii?Q?vbVK/OWI4rija0qhpmjsNV5Fjb/XsP4KVj/ctP+ayUk+gXqYpRroZsQKE65d?=
 =?us-ascii?Q?lfmhigmBhC18yz+L8Vt6LhNlV78ER52tU+43nq/XT/CnOlB0TDUCfvZKoBgj?=
 =?us-ascii?Q?FqxhnbI6Y4Rr+M+8aWRioWbbrh4QyDG8Jq8U7pQI96shUFyFtz2xVuKL6+e1?=
 =?us-ascii?Q?Lz0+cxXI4suAfcRVy88llAu44uBE9UVNqK+YNecIeRTzy/FQ457SOicAIR+o?=
 =?us-ascii?Q?1eV/68YCCcBd/fcz+LDiEFUqehqSHwf4KGjaQzwLDv2kGrzwJL+tPX3INQ0a?=
 =?us-ascii?Q?K7fgXBJGaoq2f7SqOAoo7F5uOoI4pa4gE9xfiFGVKfEOOaIdGZY3xDznZ5VH?=
 =?us-ascii?Q?KelYk1xpuXH441k94owbxqldwCwj6rzzNd2t?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:03:39.0731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c063834-9419-4146-dd5d-08ddea31e626
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274

Add missing cache layout description.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/versal-net.dtsi | 248 +++++++++++++++++++++
 1 file changed, 248 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/versal-net.dtsi b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
index c037a7819967..62861138c8f4 100644
--- a/arch/arm64/boot/dts/xilinx/versal-net.dtsi
+++ b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
@@ -104,6 +104,18 @@ cpu0: cpu@0 {
 			reg = <0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_00>;
+			l2_00: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
 		};
 		cpu100: cpu@100 {
 			compatible = "arm,cortex-a78";
@@ -112,6 +124,18 @@ cpu100: cpu@100 {
 			reg = <0x100>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_01>;
+			l2_01: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
 		};
 		cpu200: cpu@200 {
 			compatible = "arm,cortex-a78";
@@ -120,6 +144,18 @@ cpu200: cpu@200 {
 			reg = <0x200>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_02>;
+			l2_02: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
 		};
 		cpu300: cpu@300 {
 			compatible = "arm,cortex-a78";
@@ -128,6 +164,18 @@ cpu300: cpu@300 {
 			reg = <0x300>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_03>;
+			l2_03: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
 		};
 		cpu10000: cpu@10000 {
 			compatible = "arm,cortex-a78";
@@ -136,6 +184,18 @@ cpu10000: cpu@10000 {
 			reg = <0x10000>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_10>;
+			l2_10: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_1>;
+			};
 		};
 		cpu10100: cpu@10100 {
 			compatible = "arm,cortex-a78";
@@ -144,6 +204,18 @@ cpu10100: cpu@10100 {
 			reg = <0x10100>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_11>;
+			l2_11: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_1>;
+			};
 		};
 		cpu10200: cpu@10200 {
 			compatible = "arm,cortex-a78";
@@ -152,6 +224,18 @@ cpu10200: cpu@10200 {
 			reg = <0x10200>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_12>;
+			l2_12: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_1>;
+			};
 		};
 		cpu10300: cpu@10300 {
 			compatible = "arm,cortex-a78";
@@ -160,6 +244,18 @@ cpu10300: cpu@10300 {
 			reg = <0x10300>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_13>;
+			l2_13: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_1>;
+			};
 		};
 		cpu20000: cpu@20000 {
 			compatible = "arm,cortex-a78";
@@ -168,6 +264,18 @@ cpu20000: cpu@20000 {
 			reg = <0x20000>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_20>;
+			l2_20: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_2>;
+			};
 		};
 		cpu20100: cpu@20100 {
 			compatible = "arm,cortex-a78";
@@ -176,6 +284,18 @@ cpu20100: cpu@20100 {
 			reg = <0x20100>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_21>;
+			l2_21: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_2>;
+			};
 		};
 		cpu20200: cpu@20200 {
 			compatible = "arm,cortex-a78";
@@ -184,6 +304,18 @@ cpu20200: cpu@20200 {
 			reg = <0x20200>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_22>;
+			l2_22: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_2>;
+			};
 		};
 		cpu20300: cpu@20300 {
 			compatible = "arm,cortex-a78";
@@ -192,6 +324,18 @@ cpu20300: cpu@20300 {
 			reg = <0x20300>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_23>;
+			l2_23: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_2>;
+			};
 		};
 		cpu30000: cpu@30000 {
 			compatible = "arm,cortex-a78";
@@ -200,6 +344,18 @@ cpu30000: cpu@30000 {
 			reg = <0x30000>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_30>;
+			l2_30: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_3>;
+			};
 		};
 		cpu30100: cpu@30100 {
 			compatible = "arm,cortex-a78";
@@ -208,6 +364,18 @@ cpu30100: cpu@30100 {
 			reg = <0x30100>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_31>;
+			l2_31: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_3>;
+			};
 		};
 		cpu30200: cpu@30200 {
 			compatible = "arm,cortex-a78";
@@ -216,6 +384,18 @@ cpu30200: cpu@30200 {
 			reg = <0x30200>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_32>;
+			l2_32: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_3>;
+			};
 		};
 		cpu30300: cpu@30300 {
 			compatible = "arm,cortex-a78";
@@ -224,7 +404,75 @@ cpu30300: cpu@30300 {
 			reg = <0x30300>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&l2_33>;
+			l2_33: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <0x80000>; /* 512kB */
+				cache-line-size = <64>;
+				/* 8 ways set associativity */
+				/* cache_size / (line_size/associativity) */
+				cache-sets = <1024>;
+				cache-unified;
+				next-level-cache = <&l3_3>;
+			};
+		};
+
+		l3_0: l3-0-cache { /* cluster private */
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <0x200000>; /* 2MB */
+			cache-line-size = <64>;
+			/* 16 ways set associativity */
+			/* cache_size / (line_size/associativity) */
+			cache-sets = <2048>;
+			cache-unified;
+			next-level-cache = <&llc>;
+		};
+
+		l3_1: l3-1-cache { /* cluster private */
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <0x200000>; /* 2MB */
+			cache-line-size = <64>;
+			/* 16 ways set associativity */
+			/* cache_size / (line_size/associativity) */
+			cache-sets = <2048>;
+			cache-unified;
+			next-level-cache = <&llc>;
+		};
+
+		l3_2: l3-2-cache { /* cluster private */
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <0x200000>; /* 2MB */
+			cache-line-size = <64>;
+			/* 16 ways set associativity */
+			/* cache_size / (line_size/associativity) */
+			cache-sets = <2048>;
+			cache-unified;
+			next-level-cache = <&llc>;
+		};
+
+		l3_3: l3-3-cache { /* cluster private */
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <0x200000>; /* 2MB */
+			cache-line-size = <64>;
+			/* 16 ways set associativity */
+			/* cache_size / (line_size/associativity) */
+			cache-sets = <2048>;
+			cache-unified;
+			next-level-cache = <&llc>;
+		};
+
+		llc: l4-cache { /* LLC inside CMN */
+			compatible = "cache";
+			cache-level = <4>;
+			cache-size = <0x1000000>; /* 16MB */
+			cache-unified;
 		};
+
 		idle-states {
 			entry-method = "psci";
 
-- 
2.43.0

base-commit: 3160658ea2c4dd09a1d68918271177cf55437a8f

