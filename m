Return-Path: <linux-kernel+bounces-805938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25221B48FAE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF771616E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9E130AD14;
	Mon,  8 Sep 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GKNUZWl+"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E235273F9;
	Mon,  8 Sep 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338468; cv=fail; b=LPyIvrH3fbCf43wlbh4kYHibEudvkeFBowFJc3tZ3J/UiKvfszbV64J2W45PCL7sSg9uudKxw+aNjVOlfSZldtLWFbLFgXbWHNo+qQJsMZA9f1qePbkg3tMAmPIzxT/MVlTkgRah85NwKtvvGzLM2WUjgKO72yePvTAZybaVGP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338468; c=relaxed/simple;
	bh=lAcBb2o+ARELk8yGn199HCcilo9zAgThtJdG4+fQ5tY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cwWp6lZ4TszlkM+ZveWy66GOmDrl8ypzCv0i4cFaaMhA61Dv6y1UWIpN9rJlYQKVUKERSO1I9EvulAyXDBweGtKWdv4j2I6ZV78cFkal69qxON1fMVOgJ0kvHPi1jX9CUjD8py0RblqGQ3uz1MGD26+VCimmXeCk8fh2D1LSgFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GKNUZWl+; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEj2xQ4ISL+rQJLZuJ0dTjz5bd0TLxpmcT5U6PutpWYEjdDVWLGFyFmT0RdmmlP5UovaTntt0ZxwKXCNBoYnXGEp2ond3Ny5SnIf0o1uKRgv01ppk0aB4zxoV75T/4CY8qI0Yc952TJl89QgkmtiiD5on8Wofjgew0UoSARRhH+LL97SUNX1ep8jnFttiUxp/6tRzoWcMBvuiCBs1jriuuZj5lUXuUodjtOlFgA8msWcxigfAbFU13gE8XIK+vT9m2ffT6TzebHRIiYYvvv6HVO5S46vC2hTU/Gq42kFULboPtOzDChq9KbAqK4OoK6OUFRWpyeQOn25HeAofHd+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNMNm/d/jCXefib072cH1jjpOoDHvBd27GEHqnZpOJI=;
 b=osL95TI6p43alCy4zHkWVTgIowPz0t9DWUVrtn/SPOCWi8YNTqaT4IWRkBfCEyhZwEWxRq46B4vz7wYfSy1Xy6a4K1z913SrMauYAwlXBm3+/Q8Ju1KyyBU0z+h7XdTW1njz4Rid5XoWbRgNp1wqPRnt3MTKnobMTkbpRK7+ikmNzwK9eQ95dpns2C/3krP+V1sDtHs8IvzTZ5dP2lnb+0iUnif8RQUpu4/PD0wTtNYwbi2bCBfoou5AeK941kG+BJpPB1wQq7yUW4jBZnjQaftoisya7nv9qfpQAKWOw3kHhUeI0SeosAf5/Id3vY0WO+yFD3HH5zIerKIxDdsnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNMNm/d/jCXefib072cH1jjpOoDHvBd27GEHqnZpOJI=;
 b=GKNUZWl+3HdYiiqSCcnigomwzoKzZwk03nEBnI7d49f3Ex34mnKMST7OMs18vEITwQWv8UTZJXDpPSFzR+ujXlb9crEn88dsbEOXD9l6/IjmF0QNszUOnr2z1E4+v8aaNVIPG7mhYNS+uHpYU2PmS784Msmn/hUr3gPxIt5jetI=
Received: from SN7PR04CA0119.namprd04.prod.outlook.com (2603:10b6:806:122::34)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 13:34:23 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::98) by SN7PR04CA0119.outlook.office365.com
 (2603:10b6:806:122::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 13:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 13:34:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 06:34:08 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Sep 2025 06:34:07 -0700
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] arm64: versal-net: Describe L1/L2/L3/LLC caches
Date: Mon, 8 Sep 2025 15:33:48 +0200
Message-ID: <f740bf2d0af1e7e50d76196ec050c0fdbeceb049.1757338426.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17906; i=michal.simek@amd.com; h=from:subject:message-id; bh=lAcBb2o+ARELk8yGn199HCcilo9zAgThtJdG4+fQ5tY=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTsu23nt3fRVXNGnijf26XbzwqpqVsX9/FM39J+pUlpQ Xt2pBNnRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAExEsZCRoYs3pO2tve6bl7WR VuJPL2tLKO+YkOW/Tf7PiauT5mRMc2T4H/T25i/2wJ0mM1d7feP6wfjpTtgV2/1rS/+n/zTL8P+ izAIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: 0742c671-2218-4dcf-3d89-08ddeedc6c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yhTkxHs0Ow9EddBmW29CWXSfJ9z9qS5vhN6vJOfQ55DzUEpk0JI1cxuhaw6T?=
 =?us-ascii?Q?VzMVGSRGV9rbXcio4UVbFFMWHyEZbfGWHxZu5nWhOoQgyHIHm3L1+tsOnaZN?=
 =?us-ascii?Q?40Nz1lBGS9BlR7LoxqDwigPcokijllxrh3SBnLA7pmZsG2qRf4nA0SPHnTSH?=
 =?us-ascii?Q?vd2Hwr7d2/gDObuycuvgC3vu4WpXDDqcvitUpHUUpOEm8A41k3Nn0Tgh3NTF?=
 =?us-ascii?Q?IqXaauWSsPnHH3m9n1JD2uY9JTff+y5ymo4b1T6U24oME0NwsAys0eKCL9mX?=
 =?us-ascii?Q?7XIMwylR1l+6T+hn82uFMMMrNeA4UajbcjWeeeQG+CDdWWhmrDYGHfrPqCNC?=
 =?us-ascii?Q?CqwHU3GLD8EbKVl2vhEUfjw2bEGe/SoBOysvSf6UNAjVrc7AxvpVZlo31SR+?=
 =?us-ascii?Q?K+lxQZe3gIHNnVVG2tNRHJr+4tJsUegVdDS8qwiygdZDeGvMHG+/U2N8wgsn?=
 =?us-ascii?Q?Vv2bWQjVyLcxM3gXfOepoJqNE82Qd5VqRtq2pixRMrLAupY7cN1aOVGMQAX0?=
 =?us-ascii?Q?YBoEk8xL3/FXpi/RLtc4asjDHm7hde6+0Dp/4eNomGuEsXGIVq4Qw2A1g5fc?=
 =?us-ascii?Q?SFFk2AbaAdcQKDkf1XEUZWNfovfUlHfluqt/anQL1QuidATqfhgHqea/69Av?=
 =?us-ascii?Q?h6kxy4wOUb6heCflXxtnwh1cq9gEnFEvx7Qbb79AtRrQtoB84XQdA44hlALE?=
 =?us-ascii?Q?LegMSagoI45lNEqm4lclWeGMEDtw82RmaTV6zqwD8Kgjsjf9wcWEJN5T7y65?=
 =?us-ascii?Q?uxVNiL4HL2r5wZMgk+0z7+4fX4kK1bFoY0dbNVD5Fq3D7Jzz21K1VMKN9APh?=
 =?us-ascii?Q?RbspayIsiyu/4Jto3pzx90ryi+/0lUFr9+We9IwnyZ/cIdV6HEC11MYRdctN?=
 =?us-ascii?Q?YbfLQoSU9I7bKbWyM3plmZTmKQWnHrgXUclHO1OOEFUG2TLiVY3//0QBIMcv?=
 =?us-ascii?Q?hbrMIvxQylVQhjLjHlnb1dgpVG3Tf+30s6Qjm306SoWqiT/DlWM0pcV1XURP?=
 =?us-ascii?Q?fk0B0laMRm+vuw3NVR6zSFixcZJM3zhVbH0h/HTu3f6cIZpJI7Plnuj8urkf?=
 =?us-ascii?Q?11X+q7qOHG4by15Qi5iV9B2zzr0xTaFi/UjC1Byou+G6LByY4OLS5tLaU+HE?=
 =?us-ascii?Q?3QfbTUbKCbr4Y23kQkW0T218ge3HFo6tYv56cqPqkRVrL1Hv5aIGtnHbHDQ+?=
 =?us-ascii?Q?yksjbX8mWjxVvYcAVpalJlYU/bdx4jBJ/2GSmO6703HMxk4We9YZwpf3rLRW?=
 =?us-ascii?Q?NTvevYVFTPjCOjLd834jbxbSUnz/8RIohRbfu01vSKBJw6dm3XtTyqPUe2Jh?=
 =?us-ascii?Q?td/+cJTZhl4DdSnrkcIzhfDa2EUCXWQ5MWLsqeHUvk049IkkiqYXaonY7eSV?=
 =?us-ascii?Q?F8QP48yb8THGp+6+aaIEJUqMP12QIKUYCb1gBThAiVuz7eoSHTfjtZoRcEpf?=
 =?us-ascii?Q?hdvglC3zQ9iLw5oUE8U5hQwHiRqzucRO0JTV7Bw8tue+jKElbaTcmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:34:23.1971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0742c671-2218-4dcf-3d89-08ddeedc6c3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623

Add missing cache layout description.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Also describe L1 caches
- Add L1 to subject too

v1:
https://lore.kernel.org/r/f2ee23526349a0674149c969a2176c906e529402.1756825388.git.michal.simek@amd.com

> lscpu --cache
NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL SETS PHY-LINE COHERENCY-SIZE
L1d       64K       1M    4 Data            1  256                      64
L1i       64K       1M    4 Instruction     1  256                      64
L2       512K       8M    8 Unified         2 1024                      64
L3         2M       8M   16 Unified         3 2048                      64
L4        16M      16M      Unified         4

---
 arch/arm64/boot/dts/xilinx/versal-net.dtsi | 408 +++++++++++++++++++++
 1 file changed, 408 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/versal-net.dtsi b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
index c037a7819967..412af9a394aa 100644
--- a/arch/arm64/boot/dts/xilinx/versal-net.dtsi
+++ b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
@@ -104,6 +104,28 @@ cpu0: cpu@0 {
 			reg = <0>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -112,6 +134,28 @@ cpu100: cpu@100 {
 			reg = <0x100>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -120,6 +164,28 @@ cpu200: cpu@200 {
 			reg = <0x200>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -128,6 +194,28 @@ cpu300: cpu@300 {
 			reg = <0x300>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -136,6 +224,28 @@ cpu10000: cpu@10000 {
 			reg = <0x10000>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -144,6 +254,28 @@ cpu10100: cpu@10100 {
 			reg = <0x10100>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -152,6 +284,28 @@ cpu10200: cpu@10200 {
 			reg = <0x10200>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -160,6 +314,28 @@ cpu10300: cpu@10300 {
 			reg = <0x10300>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -168,6 +344,28 @@ cpu20000: cpu@20000 {
 			reg = <0x20000>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -176,6 +374,28 @@ cpu20100: cpu@20100 {
 			reg = <0x20100>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -184,6 +404,28 @@ cpu20200: cpu@20200 {
 			reg = <0x20200>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -192,6 +434,28 @@ cpu20300: cpu@20300 {
 			reg = <0x20300>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -200,6 +464,28 @@ cpu30000: cpu@30000 {
 			reg = <0x30000>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -208,6 +494,28 @@ cpu30100: cpu@30100 {
 			reg = <0x30100>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -216,6 +524,28 @@ cpu30200: cpu@30200 {
 			reg = <0x30200>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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
@@ -224,7 +554,85 @@ cpu30300: cpu@30300 {
 			reg = <0x30300>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			d-cache-size = <0x10000>; /* 64kB */
+			d-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			d-cache-sets = <256>;
+			i-cache-size = <0x10000>; /* 64kB */
+			i-cache-line-size = <64>;
+			/* 4 ways set associativity */
+			/* cache_size / (line_size / associativity) */
+			i-cache-sets = <256>;
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

