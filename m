Return-Path: <linux-kernel+bounces-748903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01842B1476F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221F81AA2155
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DC5231C91;
	Tue, 29 Jul 2025 05:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kpPkkyWO"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043872634;
	Tue, 29 Jul 2025 05:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753765735; cv=fail; b=LK3BxBmL3T5LQhzznTczUN8mASbEMgKLy0OcTSEyVkbJyLVPrP60mo6aINbKkAFnKZ6PLznuHXJoBrhZBfqNOhOwjsRnqBlN1RDqslFGWjAILB7EfMG9+ZeGUtZTYeBXNx4Ed6D3aiUozj0UuCHl7fiAkbIg7NtgshNZDEppYVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753765735; c=relaxed/simple;
	bh=VwfMVHZCRXwQbT/HEkYVvKHciHNs3XD0ggf4PK5DGTI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gvsFVbdZbM5yPrWeh7X0BDmJ9ZBTUsIZiMDebfLR2msCuOVVeFi4N01X9e2NNPcWUhWIxBzgphT3qpJ5P01nATu4ozW1CKrzFZHzPffkRkZO5ajk1pZer25T3kVNSpNMsQMz5MuauKe+jDCKll2dgMIOnQdVCzitscRiv5L1Auk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kpPkkyWO; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pukebIqMiajSExouEat2pg5x7w8lHx3sMB9vPjnJqCfLNQXxaMomlmVm6N+18/vnUKS1TBicnI7z5aohrvZeGWTiiCgEjwqTVlfVonX28frT34lGAqJo3+vb2pgmfQ4KBuEEi0PuuL+O1MSO2hTvMKK8OFeI0WQq+F26WFr0aPbipl06/djnlfm0KPZTnneqhg5oPcV0sJG476A2JnR44ozBIKNRkXw+MSHbvHATDiCRrR2VYMtcgpW5bw1RT8p+yEwwNMMkRmGF/BuVjtAEgzAcM5t4Yej6uw7FaRiTj8oRXNHi3qpTpI7I6nzly/xbfKY085mEg9U77An0P8RZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/yAfheUGGNsIAo+F6B3+k+24Q7xl+87WMGz6GsZ8Is=;
 b=TjtcRKPs6qYa8UNtiVpYz9gjjOenlK/2Ob6NLq2IjvLGi1Fw+D1aRPXeCzvA2dSrTpcDIRMMb8iirAnq9a6UmgP7ohK8Sfhu9QVPIYS9MHKmYLXUgASwTsX4AX8LMSp0tLHvJ5+tSPQWpyJPmQws7gBk7QASN+/OXXM+UhsUSruQhc9S0xZvMvjHa2XqHC165/DsKRwGaQ04lQvyHi7CEDuGW/4aR/BadXKE9hB6iaodyQxgrXma3r/CizeA2c8bSR/1gYG13l/XJWSM877Dvrjfa50yKnxjwWFLGiUqGNvOLXISeE+pPyo1gDAVxLky1vakVWnG9+10h90ZpHVquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/yAfheUGGNsIAo+F6B3+k+24Q7xl+87WMGz6GsZ8Is=;
 b=kpPkkyWO754uI7xNfHRf8DNZMZu4g1IM4k0iWDCuTJL8EPhtA1TDAFykBp+h6Ecbx6sbT2vLZjdHqd2c1xTN5JmIy1nDKBBJGI/gu2zSwxgfPoPTE4jIDZA10bhc5gnDd3h4V6qwyWoCijtlOGPh8tM1G5jPbp9wzW5HQlgSznM=
Received: from BLAPR03CA0167.namprd03.prod.outlook.com (2603:10b6:208:32f::23)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 05:08:47 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::12) by BLAPR03CA0167.outlook.office365.com
 (2603:10b6:208:32f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Tue,
 29 Jul 2025 05:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 05:08:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 00:08:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 00:08:44 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Jul 2025 00:08:42 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <git@amd.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Michal Simek <michal.simek@amd.com>, Shubhrajyoti Datta
	<shubhrajyoti.datta@amd.com>
Subject: [PATCH] clk: xilinx: Optimize divisor search in clk_wzrd_get_divisors_ver()
Date: Tue, 29 Jul 2025 10:38:42 +0530
Message-ID: <20250729050842.1522-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e9ee57-8af8-4186-b484-08ddce5dff81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L4iYRPctAfCbJtZN/xCIHjlGqKlCltmCKwmYybJbRy52PEgBj6omssqVZbyt?=
 =?us-ascii?Q?6ipWhf++Kb2J6+/dZQRn54uZ0pFTetJQ8y/qR0J0upMzofr5PHxMkm2kjB6A?=
 =?us-ascii?Q?3L0d09E2weBo1t8+RrOKL8y6xHJwXSVWAKN/riUUWQrFNyZFbWAfkiYX+OUv?=
 =?us-ascii?Q?DPRMO0ZupU5kaWVS5CSBt+BqREdHQqdi3GARv0XJgB7P9TZN8903/RQ3CZcP?=
 =?us-ascii?Q?dQWP4BujdqTu0wb6WNntKB/EUTyjkDm/aTfwbxg1vBrn2KkCAwgXvFPkwNdE?=
 =?us-ascii?Q?0yFHDCg3HygPvw2p2otMTVc78q/MPTBWwbjHmU1U5zuBO/uGrjMOh/xialOr?=
 =?us-ascii?Q?A8rgN/QyWH4rwFry5zOyh0Ptahm205hS3pVVuOYa/moCJihjA0OE9dzOhzE4?=
 =?us-ascii?Q?pEB5H72FV+eRSZueUzYg/By4CSsvixPDOKnS8BXmsM14P04P9P1QqBVku4Se?=
 =?us-ascii?Q?EJwuDpY8rTX8YfRfd86vIWdNypiQ3TI5Tk2dLJMkeX4h7ZVa+dGxipJHm4Rd?=
 =?us-ascii?Q?oBO68iwDxUWvm1GiqJFiKbmxRj3CLH/JcTreNeDEHk/RsXETrshVkR0vJDUn?=
 =?us-ascii?Q?nA7IPCWr3u/mfFMy1016ohSbm+ReV9Zn5ikhgi803wUttgisKpqxR7yI911F?=
 =?us-ascii?Q?4JcfOjpqVMcXfpv46NWYamsJakdfv42BZwiGRRRk3SuTNJUur2gaQ2GDmgm3?=
 =?us-ascii?Q?crW+SOq9oqjlBmhmvXZ+XwNWTj2+Jh33Nubw6G0+j+cZxCXIe1QLtTswfako?=
 =?us-ascii?Q?PvfjTFeqhbiXlFQPdMjXa8Cc2kkkcEx5L8BSpzvKihEUDubBWxwwR3srIP8r?=
 =?us-ascii?Q?TF3AGv+Ap3rrvzoQEEF5/YqTlggrftrFmScdrsg1aRwHcxsZZFcuQBg/Mari?=
 =?us-ascii?Q?IFYf2ofEAbnxk/gcpeeBqzGVReBSs34GHv5ksIgZJh+ugAgIPzsOOKsUmH6z?=
 =?us-ascii?Q?KYtpNMguePnDF4NxNe5JZJwtI4GVXEdXBkdXomZ4GBFi4lIczv/oRJEaGyD0?=
 =?us-ascii?Q?UOWOmSPq/EhFRVQzD5iOMERD4jnQ9gUt6wqLIvJLvCwx3kw9t2YzjUHFMXOt?=
 =?us-ascii?Q?TdqzGHaXylcsJnRU4wrTgt0Ky0JSxra0A6Q6N6KM07NELU29/sjZkMS/bXnm?=
 =?us-ascii?Q?vOPpHqtCL4vKmpWfRgdTcs4ityTSiKWuJhUy7nmIk1Zhl35ez3Mhp0o65r0w?=
 =?us-ascii?Q?q38aYxdVGAoO2x0cDDmQOjNwVttgbxFErhfQCqRvA5tO2+y5BscTCy2JrKfz?=
 =?us-ascii?Q?JvDNXZT9rryrI6ynGqXXdaoisdjS94m0Y3V/7/EkmYaf10sWOMovbpI+tmj8?=
 =?us-ascii?Q?0vjDTRfQU1B7jn6s2Is0JekKaDJ4MhtyZDw/Fwd3crnccS30Hm7OBS2XJ5ou?=
 =?us-ascii?Q?Dl2yL2OdbJFtt3HmB5Quynu1gwORYCmiJrT1tI/X1/ASi8BfrfGLXI8LZ3L7?=
 =?us-ascii?Q?gRwUC6jr6asWC3s6UbDmxb828bLvFxD3J2eWCt+RuAqCg378MuntQXSNYJdG?=
 =?us-ascii?Q?5rFK7TChCtygKRKr9TPD2cobKyRec4nYQrXA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 05:08:47.0014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e9ee57-8af8-4186-b484-08ddce5dff81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

Optimise the clock wizard divisor calculation by eliminating the innermost
loop over output divider o. Earlier there was an error that is returned
if the WZRD_MIN_ERR is not achieved error is returned now it computes
the best possible frequency.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
For someof the input frequency choices
setting 233250000 -> 233331003 diff is 81003
if minerr is 20000 it was returning error now it will 
compute the nearest frequency. 


 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 32 ++++++++++++----------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index 3efce7b88906..4775cde45e21 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -344,7 +344,7 @@ static int clk_wzrd_get_divisors_ver(struct clk_hw *hw, unsigned long rate,
 				     unsigned long parent_rate)
 {
 	struct clk_wzrd_divider *divider = to_clk_wzrd_divider(hw);
-	u64 vco_freq, freq, diff, vcomin, vcomax;
+	u64 vco_freq, freq, diff, vcomin, vcomax, best_diff = -1ULL;
 	u32 m, d, o;
 	u32 mmin, mmax, dmin, dmax, omin, omax;
 
@@ -360,22 +360,26 @@ static int clk_wzrd_get_divisors_ver(struct clk_hw *hw, unsigned long rate,
 	for (m = mmin; m <= mmax; m++) {
 		for (d = dmin; d <= dmax; d++) {
 			vco_freq = DIV_ROUND_CLOSEST((parent_rate * m), d);
-			if (vco_freq >= vcomin && vco_freq <= vcomax) {
-				for (o = omin; o <= omax; o++) {
-					freq = DIV_ROUND_CLOSEST_ULL(vco_freq, o);
-					diff = abs(freq - rate);
-
-					if (diff < WZRD_MIN_ERR) {
-						divider->m = m;
-						divider->d = d;
-						divider->o = o;
-						return 0;
-					}
-				}
+			if (vco_freq < vcomin || vco_freq > vcomax)
+				continue;
+
+			o = DIV_ROUND_CLOSEST_ULL(vco_freq, rate);
+			if (o < omin || o > omax)
+				continue;
+			freq = DIV_ROUND_CLOSEST_ULL(vco_freq, o);
+			diff = abs(freq - rate);
+
+			if (diff < best_diff) {
+				best_diff = diff;
+				divider->m = m;
+				divider->d = d;
+				divider->o = o;
+				if (!diff)
+					return 0;
 			}
 		}
 	}
-	return -EBUSY;
+	return 0;
 }
 
 static int clk_wzrd_get_divisors(struct clk_hw *hw, unsigned long rate,
-- 
2.34.1


