Return-Path: <linux-kernel+bounces-869985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71103C093E4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17F644EFA3B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B05303A19;
	Sat, 25 Oct 2025 16:11:26 +0000 (UTC)
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020101.outbound.protection.outlook.com [52.101.195.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3075827280E
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408686; cv=fail; b=UkI9imBOX4E/NXTzxN+Kiv0xURb5BHTJtW5uSS4Bx86RNF4aMv10UoWnsAC77hFrIECvxPA3kVJBcK0HzKWmYXNSvOzjnxR9XDcanwBMk9X2IJFCsTvDqMt9GdL1Or7UCVKvTmXR+7XpnW2Dw0OhotlM2FDSqHTFcjwCvFG+wjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408686; c=relaxed/simple;
	bh=sb898pj1GCFdDZg+i8Nt4SxwEJSNPpG0P6y/mw9LlP4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mqpk8emky/6tAhWx9szPfH9r1pqRy0tzMmbtbzoSMg3WXRbHVNAzfGWO2AvrwCcwHXjd2VCLIvipj0aV2DWX8GcqO8alGPDsCbHbDQ4ultj4R7+Hqz6wiQsnXnaHjXkBE8u4pIQEqgcFOlkAw7Ade6FrP6mDvHhCS+oxxzMO2pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHHDMXf0ZiW+kYg40gZu23sxtlvA7odqO1538ocKLmENpH47WEfR/X6MQYazLRcflwnOm0aeaTtcVmgZ7tltgatGvhiPqeJzbKI+3SDm//mALEUWnFPktOV774qbubikX4/vkTCJAV5y3dPRp5GAQ2mk5Th0i/8c1eklg/X8hAWMAjLGMLwUBXPUUmLukZGJhUQWzo4F26uuubZrOPDCEOLfy2mwzu9UKWH9WZnsvVkXapw+1Bz5UEZKzL6Grc3ng+kzUm7OUdP4Rugojq9xnVnO0g9eTOD/4mgThdJ8sU/MyO+yhwboudH82xQmkdbChaz6wWPAzTBu8YOoSCYf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/+qkCxC04kL82SAVOYuHeZfJ6wcFwaG788QGxfzAOU=;
 b=cJLTrl7yZLwal23CxiIZLhEkalUJVg5mcnZRz97l8kfmHRkbf0s2xb/SqL0RyqtXoCU5gdPoSwk4COFKu6owQOGad8RFVFoBSvu/7Ktq1cI9qcSD80cyX0Clm3jBNrA8b+TJiWmgbWRixWq1T1wHxTCDS1MUQ2tQE1UAGn9vVx5iTnSRYQi6PfJDV8lG2nnVDYzuyBvdxFU14mtxI1CnJK1R0IF07qRIigRVYQU6PSlY4KFdH9OikWe96KM7ngj6L05/8Bsg86DSd7S+PxAGxtUDUvzUGcZ0AsoODkeEsgGEgvHrsQsfu4QNAs3fabnwgc5AjZ1AaMXRDbsRm0g2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:be::10)
 by CWXP123MB4293.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Sat, 25 Oct
 2025 16:11:18 +0000
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::8242:da40:efa0:8375]) by LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::8242:da40:efa0:8375%4]) with mapi id 15.20.9253.013; Sat, 25 Oct 2025
 16:11:17 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: atomlin@atomlin.com,
	pauld@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/isolation: Enforce at least one housekeeping CPU per node unless maxcpus limits
Date: Sat, 25 Oct 2025 12:11:13 -0400
Message-ID: <20251025161113.14313-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:408:e1::28) To LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:be::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO3P123MB3531:EE_|CWXP123MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e28e34-695b-48e0-1cd4-08de13e120b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZEPueq05xhKITwWhiBBYI1efQCT00RxN1mCD/wy9YnooyB0uFgFdtjYA4onm?=
 =?us-ascii?Q?b1UfQ30cvei2c4fr1avMnczXxMT23wu7M5Odb8PqQyb8R9kNz6JNDiD5Ogve?=
 =?us-ascii?Q?QSP9Z8kjKM1X07FVIZxMwA/clq82l5OB20sFPaga01gtj5GtEXNxd7mjpGoJ?=
 =?us-ascii?Q?m5CqD3YeElyyVTZJe52CGvz0AYrmgTiWTbhZlx0zo/6lVoxn4Aov7fH2UFhP?=
 =?us-ascii?Q?dv3WjarrV6qCEfGAVQo20VftUNxNQ05jD/YhZXMrPMgrUOGXnPegr9wohF9f?=
 =?us-ascii?Q?l7QROl46UKSpcEkA2AjN607BQs2ZGJYwYhaDP7HLIm44BCWEXOzUqeKa+p2Y?=
 =?us-ascii?Q?VGxRrqXjoRjKsNyeTdnB/Bk0Bg5XrZYqCYBKfoZ89Ch/EysWgTAEjeMLH8N/?=
 =?us-ascii?Q?MEDhoYKjO9LagHn8/1Cz7IPnf+zI/4EloNLtSVHP/AqMBytvsNjUSF/6dWp5?=
 =?us-ascii?Q?tSmQLkDNzIIa3J/XB6VWuI8XNo9XmR9UcDy7MAeTSQNPAKCQofG7IarDwKkM?=
 =?us-ascii?Q?z8f+JIHWP9K9ds6o/BGLI3Yjmh9lGbOfgwLeKp+AB+uUlq5vyElL61Hvt8qX?=
 =?us-ascii?Q?xkKIHoMPBtQDSJMMsUIfNfB4ZgR+xzhUExZbobxBczG3iL31F8woGkmOCH5u?=
 =?us-ascii?Q?Q5yWnLqvBoByGEhrp9EOytI3joB1Rg58y3j1Or93vgpi0gFad5bNDHil07Mb?=
 =?us-ascii?Q?1zxN92WbysM3/rcQQvdHDxABYZsVkbvlIMzckq8kI751t6oGm3r9f6dTmTn9?=
 =?us-ascii?Q?jbwSMB9qHvFLO+pMXswfhpiRGQSiKK9/smUhqI82amaviE3RBa0Bmry0IgW9?=
 =?us-ascii?Q?OObCw2Ve3eWtrBEGnYT2sUz0Maf63JI2uSIhYH8B7jhcog2N7wQr0SvezKIk?=
 =?us-ascii?Q?3tpnBrmF8G7Kt+TwJlZ9jJgVUvl2wWsdqAzVhPozOka9K3HYTZymIk6d5Yfn?=
 =?us-ascii?Q?3HteMOxhzHWtV+W6zBVJVb1eRh2vseQEzzJaEIRiESXkWsCfBMAnxAxD0EoU?=
 =?us-ascii?Q?vVWxRpoJz8LJZ/wkeEjfaX2eD0u34aHGbcimoeI3ZNEJe0tdrphdfQ/2KRwf?=
 =?us-ascii?Q?uTnAlSMTdPVepZhbJCt5GVBAJLP0V6Xc1ornZ+MN5KNZNxNVjR8fHH6R29Ok?=
 =?us-ascii?Q?DeCSLNlZMcK73FidsUqH2VTS1Gvxe3fOx1G0u4gfENmduM2lIHU9rhQYgZmc?=
 =?us-ascii?Q?vmw1BOg2b9sDMOuOe+TrUgaIOWlgUTaMUUdg2RCS5k0+G8qhm62yjFvjmR4H?=
 =?us-ascii?Q?QGDf/b1Rhlc8/t6byY8UuNxmzep3rxN/nnQvbeNVWjAdGk3FYrdASC2hKIpR?=
 =?us-ascii?Q?XpTp8yKQzu+pbIMNnm1s5rIHvWjowH8IZbr4fd4h6sklvwtqeiVTz4UuJSzq?=
 =?us-ascii?Q?JkRxVW9CIDwp9zUZ5MHLm5yV3TBUAv9Xy1SN1ZHzhbEAn7w1coOHPPw36dhc?=
 =?us-ascii?Q?IO1Rl9v6oTlUYN/DnRP8IIKWdmjoYeVu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Q4wkkiLGPaqldbN22dSjfm0L5n7JveBUhL8uEYr2KW7wh+j4Min8eGtM5Bm?=
 =?us-ascii?Q?QOReRGt7LQWdces8s6AdUyhjG8CdLHUgQSQs3h/lo/iN/5NnYLWzWf5UveXK?=
 =?us-ascii?Q?NxToB4m+4b35hHdO6EM2P8JXMnBs25cIb7C+hrBm2AjRJCJt7JyostrejxXw?=
 =?us-ascii?Q?Djo9VDt28dbR98kcjK3X13QtCATlD9yYYAu/JDnSBweUhncXOVLFRmw6xsXG?=
 =?us-ascii?Q?cKR6RBYqZPqcFeF/Rba/ThyOyDf5GCsnWCfoKuGzaKuZP0e7DJvvFPUdm/AF?=
 =?us-ascii?Q?OM/Gn566LPJVKXA+7HmMC9vODMwFFPB3WOFvv8MCt7oI12D63MF8miUa5mKz?=
 =?us-ascii?Q?T0nKP5xSuG3JSKU208fuqyc/5TVsCJCLzcm8KmXNEUiWsETJkWcJR3+3X1o7?=
 =?us-ascii?Q?7PgQJOJqCXnaU1IPNuWPum4BQ57F6UhowGPcuK1u0GcbpHfSQL0a25sJrlvr?=
 =?us-ascii?Q?UKjSs/pcR9zLzwoiAKGA/lk0c3S/CwufPX+pbAuJzOmQ1toMSDOhaKjQ+hwi?=
 =?us-ascii?Q?mDIDHk+QByY2y1LG8Qhy+AcmzCELGnKwAd6x4pyDHEF+01FoCaIlckKCFQSQ?=
 =?us-ascii?Q?/woqo5i8eJl3BnfPWtsjyXAYojR5FkAPQ/HHkDF4ecI+3VvGdNjjmp1YmKUB?=
 =?us-ascii?Q?WIk52zcZMhNR3s8xwEOdyvvuiWr9wEaBdscl4pFTq+wJeCiBzK4Uy3QuuCbJ?=
 =?us-ascii?Q?4LQ9nSGubZOZomFQI+2vwTSgpS4VW3dFTzXjVoTs9hRNh5xzHRiNNI/+klv2?=
 =?us-ascii?Q?UP2guKJaf3/78a4PmBkDrgFN1H0fHiXL69FsknWoRFvSDJFUc8vVGMh4FpkR?=
 =?us-ascii?Q?E1lSiZWpZ1kPZFO54JWDgCdLnmvJ7tzbhMXZBCUxORBb+e4/p6VEGcFNT1fR?=
 =?us-ascii?Q?iLZSDHDd8HtkZPYjRLpnKaNtuf1HIrrUJNVE6zACTuU33HSRZI07zDgRQh6H?=
 =?us-ascii?Q?A6pkgWZAOcvgG0kpbpRmJ4G3YUId6KT5aZVKaBvQ5XQ3A+ZGXhKOiw10BTHa?=
 =?us-ascii?Q?wxLboQZPdvSPUUS06T19bRuuAFim07BiaqDR3Mq8zdAoMMgVV2mqa1IAWhT4?=
 =?us-ascii?Q?TGlbTeQfX01UrYhkaHiYKt0B2X37TepU64JhG1dAstXgE6i3g9ZC3JLpfHKN?=
 =?us-ascii?Q?sNCWeI5Rvw6smmL9WDPUO5ZvYplKyFo6Xic0OrpNjNjBw86Dg0ihY0xs/e2B?=
 =?us-ascii?Q?vFLwW1Y8DTDOfRwv6jsl5EblbDClYCFRbPuNaxQhCJ3GQ2E3zf9cmS+8X8Jt?=
 =?us-ascii?Q?JD4LKnbjPl/NFSv+LxniuE+7TTsUc+h3uLu8zo2OoPOk7WgdqtjQ3+jCAyJC?=
 =?us-ascii?Q?rXyOlcv5wLPPxqPte3wapIyWxFRHVx2eeBuhfus7xzrjPxfJ50Lv2tAx8xZU?=
 =?us-ascii?Q?u8DQX+gHuaIED9kzsQM9oOpQnvJR75yXusVeo6TSv3w6RJeZLf1yb8l3C+5D?=
 =?us-ascii?Q?V+VnIo5k96efEoxULM2wCjQ86kzcknJ/tKQifOiIL/tGjosCAtA79X/1xCZw?=
 =?us-ascii?Q?LAUZC2HEqK3vU6rKwGqzNUREYES2nWXnLoOHm7mN61MlucV59AhgTGMGAw+v?=
 =?us-ascii?Q?sOSdUzcqcFw5ETU3VDvm4is4gXFb9NtfUIWZRfVz?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e28e34-695b-48e0-1cd4-08de13e120b6
X-MS-Exchange-CrossTenant-AuthSource: LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 16:11:17.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGR2Z2yN+YKleJKyVAFNkqTZDWuHuHNaZptU+tzAPtWuDSbWrdT8IJrQi4wAzSHr+Ik3KYy/nFg1dgbNfcrRrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB4293

This patch improves housekeeping CPU selection logic by enforcing that
each online NUMA node has at least one dedicated housekeeping CPU,
ensuring better NUMA locality for kernel threads and timed work.

Before assigning additional housekeeping CPUs, the patch checks if any
online NUMA node contains CPUs with logical IDs greater than or equal to
max_cpus=. If so, per-node NUMA enforcement is skipped and a
warning is issued, since some nodes would be unserviceable given the CPU
limit.

If NUMA enforcement is possible, each online node lacking a housekeeping
CPU will have one present CPU (the lowest logical ID) assigned and
included in the housekeeping staging mask, with a warning logged for
visibility. The final guarantee that at least one present housekeeping
CPU is assigned across the system remains intact.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/sched/isolation.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a4cf17b1fab0..87b7f20d76b1 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -114,8 +114,10 @@ static void __init housekeeping_setup_type(enum hk_type type,
 static int __init housekeeping_setup(char *str, unsigned long flags)
 {
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
-	unsigned int first_cpu;
-	int err = 0;
+	const struct cpumask *node_cpus;
+	unsigned int first_cpu, last_cpu;
+	int node, node_cpu, err = 0;
+	bool skip_numa_enforcement = false;
 
 	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping.flags & HK_FLAG_KERNEL_NOISE)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
@@ -135,6 +137,40 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	cpumask_andnot(housekeeping_staging,
 		       cpu_possible_mask, non_housekeeping_mask);
 
+	for_each_online_node(node) {
+		node_cpus = cpumask_of_node(node);
+
+		if (cpumask_empty(node_cpus))
+			continue;
+
+		last_cpu = cpumask_last(node_cpus);
+		if (last_cpu >= setup_max_cpus) {
+			skip_numa_enforcement = true;
+			pr_warn("Housekeeping: NUMA node %d has CPU %d >= "
+				"max_cpus=%d. Skipping NUMA enforcement\n",
+				node, last_cpu, setup_max_cpus);
+			break;
+		}
+	}
+
+	if (!skip_numa_enforcement) {
+		for_each_online_node(node) {
+			node_cpus = cpumask_of_node(node);
+
+			if (cpumask_intersects(node_cpus, housekeeping_staging))
+				continue;
+
+			for_each_cpu_and(node_cpu, node_cpus, cpu_present_mask) {
+				pr_warn("Housekeeping: Adding CPU %d "
+					"from node %d to ensure NUMA "
+					"coverage\n", node_cpu, node);
+				__cpumask_set_cpu(node_cpu, housekeeping_staging);
+				__cpumask_clear_cpu(node_cpu, non_housekeeping_mask);
+				break;
+			}
+		}
+	}
+
 	first_cpu = cpumask_first_and(cpu_present_mask, housekeeping_staging);
 	if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
 		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
-- 
2.51.0


