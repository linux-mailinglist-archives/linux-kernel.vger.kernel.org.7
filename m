Return-Path: <linux-kernel+bounces-785974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7F5B35311
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760C71B25892
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0838E2E8DFE;
	Tue, 26 Aug 2025 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4INrHuoM"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BFE284678;
	Tue, 26 Aug 2025 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185218; cv=fail; b=I8h9eZp6H1Ey0xqINTxWEcYxdfegVtHCkAdpF9QPlVaFCRXUY0RY2kutHmJT2q/P0pr40LyvrmcacRiKXnyWesu3PcERSd+3U1yhD7ovSAecYfRpiayxbnm14YDPtXb2h7nqfq8ZRY2Wwr3dvHUpsf+TejdHWi5vddDd9tgAS9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185218; c=relaxed/simple;
	bh=HCQZKcsiEL84YPldV8QD86GCd5b4A7w5j7uFq/TRjEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZLhYux2xBCptD3wmhOJebBAMFpOLnncehcGbV88Zr+rTybwISym1vodNyQcXo1r3DD/nqdiXLBt5uLVU4MoZENkj7l0lCn/ESCU9HRTa+nARcB6aKWmbkjbHgerQyEcFCuHd4ZuKskFNm6MInMoKveYmMUNfLlCMl6nRC/mJHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4INrHuoM; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2/F1sIOmsCeHouWdAtNyLCKAKOzIWLEn+sS5xnK8I7lA3/BWA7PmgH93zFICME9e7sHyghDyxU6zIueXkPF/iv6q5SEDwu+2mmNegwX1csbUXOL3FVt2umJSpIq50aLHZlpmJIHeGnapAiH2zpns8LJ/RmlTUq0zL6Kxgh60sqfyT3WmdE3CD0h78X9zkvQijdMjDnz6guEqzxsu7rz/viUCSQTLm1WNl2l/+d8Z3DAM1OptjR9uRMtLClq7uXuSCNh+EL80geQB4TI++mWTxs7rN49tMttsPYJcjNf5sDirA8zZmpEFR51q/qlNHGzTTT3Z34UwqlJVt3PJxMFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k30ZTWe9h/LUwmNGVMMCzCHQbI+Kmngu7heDy4sTBQQ=;
 b=qQBQUndvzntl0W+6+G3WA2aSgEN1qZDnxFLtMbw02fD6eQyOQq7MojNFxXFMpcZ7sLqL/saJzMAgSuiUlWcH0bOBw2aCL444WdH6ommt2Xd9BdOscEu/lyBrsRq24/8mhxFpLwYDbBHHzaPi6Unz/eBY1Nvh8QZ3ht91Amsp+NiCaQhRvQi4ffH+OHY1zj3A+HIGdRlZLQwwAbxF5JyvjEYUCYwA5APjtLkBz6yLhcvpdpK4JfaE4jjK40SBlNk65jC9TJVkNFOS5jsAaid3Y07KdP+WVqVDE1qHxZGClBLVmqbQBCORn7lti12cPQdK4ztcoJTb5/M4Hyh9vW0HXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k30ZTWe9h/LUwmNGVMMCzCHQbI+Kmngu7heDy4sTBQQ=;
 b=4INrHuoMoukiSJexcOYHtXmqS1ZSNHJrITly2fF5WJpJovKvLsMkn/C2ki9khJ93elwGHPoQFCLrMFb9I8e2aTRJBk/pCVZjRC7jIBQAndC1GheeviX3FjZ+oGpevYtKyxsHh044cE7gVQxcqReoErOoBO2GexORE0xc/mB/bmw=
Received: from MW3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:303:2b::25)
 by BN7PPFCEE68E7BF.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 26 Aug
 2025 05:13:32 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::82) by MW3PR05CA0020.outlook.office365.com
 (2603:10b6:303:2b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Tue,
 26 Aug 2025 05:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:13:31 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:13:24 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <corbet@lwn.net>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <iamjoonsoo.kim@lge.com>,
	<qyousef@layalina.io>, <sshegde@linux.ibm.com>, <alexs@kernel.org>,
	<lukasz.luba@arm.com>, <cpru@amazon.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v4 06/11] perf sched stats: Add schedstat v17 support
Date: Tue, 26 Aug 2025 05:10:34 +0000
Message-ID: <20250826051039.2626894-7-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826051039.2626894-1-swapnil.sapkal@amd.com>
References: <20250826051039.2626894-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|BN7PPFCEE68E7BF:EE_
X-MS-Office365-Filtering-Correlation-Id: a54e4e85-92ee-40ec-8325-08dde45f4cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F0cttzgXufFEYggZfRnyW22Tef44iIS4QYXQfvBGfbTimNtUoh3RgWjjyfXV?=
 =?us-ascii?Q?Wvg5HEQDtoCFURTMpKpcJtexZ9key31sWUPgA8mtyofq2gTvPWQdi8oK9Jlm?=
 =?us-ascii?Q?F5wn3ffxyuZHe6zGLQFrEvja1XKInUrcyoXVatTF+9H1IbyJmWWEN+/xUCo2?=
 =?us-ascii?Q?IFPLrKXZcrLjfpMQP5JlRVUq6QeXYZMlUlDUrHnjZD279ziadXXhnNzkncCh?=
 =?us-ascii?Q?IK1/iyhFmj7WE1NilffwPbx0/pWBwDjwMJU754c18vmwmlGuY1xeUOIa27De?=
 =?us-ascii?Q?KGNdGBMuFOH0g71MbKkOAgycfSqlWXUnQlcIJmftgcqJ36DhjNYB1mTwCsP2?=
 =?us-ascii?Q?cP7lHwvQkwVmdsP5ZdonugaUpmNbLVWm6YFnGjspZhq4oQtg45pbNCpSRVuM?=
 =?us-ascii?Q?doeRsYvy6NjasyUsR+2TF6fdAk67N+kyehOBOX66kIuVvtqDHbeQrCr7XflG?=
 =?us-ascii?Q?xS/cg35M3MLgfXt6yNXjn3yzr9LFXim+vEsZW+A/WM+nNKvCspWqocZex2p0?=
 =?us-ascii?Q?g/LXo1Rm4u7d9cXqIi+xYN8LJ0kmVy0fY4gvU6fkZyZzzqals3hDOvxTvx6O?=
 =?us-ascii?Q?eXpmFviVMgBGrn/HjIypFzAq6QEBFjK/XCKMIxmcdZO/X5ZeLeXLdrVK1irb?=
 =?us-ascii?Q?eYfmRwDvvIqaAzvWcvNScNWziKA0R/8U8qnaIq0EG0b2CVUoS1o/rNnmgMKZ?=
 =?us-ascii?Q?rGuTRZXuHj8YB6R/MPj9XAuRPzR96uqyrLqRqQNPDtfqSK0Gj2letN+074yb?=
 =?us-ascii?Q?+EntP2mokTVcVbhAK/hPQ8a0q3ffykn6uR/RkgXDIOV+wtk121D6jTHCW98d?=
 =?us-ascii?Q?pL8OfNRJw54UC9qxCebJ0mO4BDfnS9BWvvZnS67m3qEYfwrpNr7p5DBpzG1J?=
 =?us-ascii?Q?W769kToq6AMRft+r1RgaSX0c3Y03Fu+qVLIWZdta62j2/Cz+CPGVemFEhCtT?=
 =?us-ascii?Q?exkBnT1+I3IYm+IufKWv/tweNs2HK4Kk8gQwXqowANd86h9mAFH1GPzS+ABp?=
 =?us-ascii?Q?zKYSk3rqg7yLzi4Z5mr+hU1iBfzO1zxUR3aWN3O23/CA1XebU6POKO2daysf?=
 =?us-ascii?Q?uIEXagf3V3w6d+TK5jzUshfRyWCGmRe+IlUBchBFQ1GLpMEIc6oWNZ4MMhhc?=
 =?us-ascii?Q?p0sV1p8hzgGbAW6/P9UBI3F3JbCIFQTnPooy/NG+QBPFNxEIvZRAEVug6igF?=
 =?us-ascii?Q?kLUwx4uy07lo6oe4qNtglLghG9l85gsOFgiY3fIz/K1fc9wThTTL7HT/of53?=
 =?us-ascii?Q?q/HiuUZF5gBZVQHZT748Xt65beLBL0/Ci4rBWMxaTtXmS96Ht9QUtHzaB7C+?=
 =?us-ascii?Q?uFwqakCrZZP/zGeBDRBfSMSJ/6cihh5XsU61jfH+twQU/tJPLGe37QrGRZYE?=
 =?us-ascii?Q?YkjQNLipma4OX6bzr0RI3Ch/p/n6Pxfmcre9tSJKD7ZJVQb0bM9LfbWnI9d7?=
 =?us-ascii?Q?ER1kn+leXOA+pjUXSLFT1hd/O7wkyJCDiOzmin6hoW54LdXnJ/iFpmA8U/G0?=
 =?us-ascii?Q?/0ivJ9nRuiPx4tnaIBzI+hxsu0PglLvREKqk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:13:31.8814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a54e4e85-92ee-40ec-8325-08dde45f4cec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCEE68E7BF

/proc/schedstat file output is standardized with version number.
Add support to record and raw dump v17 version layout.

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/lib/perf/Makefile                     |   2 +-
 tools/lib/perf/include/perf/event.h         |  14 ++
 tools/lib/perf/include/perf/schedstat-v17.h | 164 ++++++++++++++++++++
 tools/perf/util/event.c                     |   6 +
 tools/perf/util/synthetic-events.c          |  11 ++
 5 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-v17.h

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 965e066fd780..27e6490f64dc 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -179,7 +179,7 @@ install_lib: libs
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
 HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
-HDRS += schedstat-v15.h schedstat-v16.h
+HDRS += schedstat-v15.h schedstat-v16.h schedstat-v17.h
 INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
 
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 4c38a58e19c3..5a93a84f49f8 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -495,6 +495,12 @@ struct perf_record_schedstat_cpu_v16 {
 #undef CPU_FIELD
 };
 
+struct perf_record_schedstat_cpu_v17 {
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		_type _name
+#include "schedstat-v17.h"
+#undef CPU_FIELD
+};
+
 struct perf_record_schedstat_cpu {
 	struct perf_event_header header;
 	__u64			 timestamp;
@@ -505,6 +511,7 @@ struct perf_record_schedstat_cpu {
 	union {
 		struct perf_record_schedstat_cpu_v15 v15;
 		struct perf_record_schedstat_cpu_v16 v16;
+		struct perf_record_schedstat_cpu_v17 v17;
 	};
 };
 
@@ -520,6 +527,12 @@ struct perf_record_schedstat_domain_v16 {
 #undef DOMAIN_FIELD
 };
 
+struct perf_record_schedstat_domain_v17 {
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		_type _name
+#include "schedstat-v17.h"
+#undef DOMAIN_FIELD
+};
+
 #define DOMAIN_NAME_LEN		16
 
 struct perf_record_schedstat_domain {
@@ -531,6 +544,7 @@ struct perf_record_schedstat_domain {
 	union {
 		struct perf_record_schedstat_domain_v15 v15;
 		struct perf_record_schedstat_domain_v16 v16;
+		struct perf_record_schedstat_domain_v17 v17;
 	};
 };
 
diff --git a/tools/lib/perf/include/perf/schedstat-v17.h b/tools/lib/perf/include/perf/schedstat-v17.h
new file mode 100644
index 000000000000..865dc7c1039c
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-v17.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CPU_FIELD
+CPU_FIELD(__u32, yld_count, "sched_yield() count",
+	  "%11u", false, yld_count, v17);
+CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
+	  "%11u", false, array_exp, v17);
+CPU_FIELD(__u32, sched_count, "schedule() called",
+	  "%11u", false, sched_count, v17);
+CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
+	  "%11u", true, sched_count, v17);
+CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
+	  "%11u", false, ttwu_count, v17);
+CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
+	  "%11u", true, ttwu_count, v17);
+CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
+	  "%11llu", false, rq_cpu_time, v17);
+CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
+	  "%11llu", true, rq_cpu_time, v17);
+CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
+	  "%11llu", false, pcount, v17);
+#endif /* CPU_FIELD */
+
+#ifdef DOMAIN_FIELD
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category busy> ");
+#endif
+DOMAIN_FIELD(__u32, busy_lb_count,
+	     "load_balance() count on cpu busy", "%11u", true, v17);
+DOMAIN_FIELD(__u32, busy_lb_balanced,
+	     "load_balance() found balanced on cpu busy", "%11u", true, v17);
+DOMAIN_FIELD(__u32, busy_lb_failed,
+	     "load_balance() move task failed on cpu busy", "%11u", true, v17);
+DOMAIN_FIELD(__u32, busy_lb_imbalance_load,
+	     "imbalance in load on cpu busy", "%11u", false, v17);
+DOMAIN_FIELD(__u32, busy_lb_imbalance_util,
+	     "imbalance in utilization on cpu busy", "%11u", false, v17);
+DOMAIN_FIELD(__u32, busy_lb_imbalance_task,
+	     "imbalance in number of tasks on cpu busy", "%11u", false, v17);
+DOMAIN_FIELD(__u32, busy_lb_imbalance_misfit,
+	     "imbalance in misfit tasks on cpu busy", "%11u", false, v17);
+DOMAIN_FIELD(__u32, busy_lb_gained,
+	     "pull_task() count on cpu busy", "%11u", false, v17);
+DOMAIN_FIELD(__u32, busy_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v17);
+DOMAIN_FIELD(__u32, busy_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v17);
+DOMAIN_FIELD(__u32, busy_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v17);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(busy_lb_success_count, "load_balance() success count on cpu busy", "%11u",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v17);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(busy_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v17);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category idle> ");
+#endif
+DOMAIN_FIELD(__u32, idle_lb_count,
+	     "load_balance() count on cpu idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, idle_lb_balanced,
+	     "load_balance() found balanced on cpu idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, idle_lb_failed,
+	     "load_balance() move task failed on cpu idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, idle_lb_imbalance_load,
+	     "imbalance in load on cpu idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, idle_lb_imbalance_util,
+	     "imbalance in utilization on cpu idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, idle_lb_imbalance_task,
+	     "imbalance in number of tasks on cpu idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, idle_lb_imbalance_misfit,
+	     "imbalance in misfit tasks on cpu idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, idle_lb_gained,
+	     "pull_task() count on cpu idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, idle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, idle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, idle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v17);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(idle_lb_success_count, "load_balance() success count on cpu idle", "%11u",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v17);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(idle_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v17);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category newidle> ");
+#endif
+DOMAIN_FIELD(__u32, newidle_lb_count,
+	     "load_balance() count on cpu newly idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, newidle_lb_balanced,
+	     "load_balance() found balanced on cpu newly idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, newidle_lb_failed,
+	     "load_balance() move task failed on cpu newly idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance_load,
+	     "imbalance in load on cpu newly idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance_util,
+	     "imbalance in utilization on cpu newly idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance_task,
+	     "imbalance in number of tasks on cpu newly idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance_misfit,
+	     "imbalance in misfit tasks on cpu newly idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, newidle_lb_gained,
+	     "pull_task() count on cpu newly idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v17);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(newidle_lb_success_count,
+		  "load_balance() success count on cpu newly idle", "%11u",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v17);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(newidle_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v17);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category active_load_balance()> ");
+#endif
+DOMAIN_FIELD(__u32, alb_count,
+	     "active_load_balance() count", "%11u", false, v17);
+DOMAIN_FIELD(__u32, alb_failed,
+	     "active_load_balance() move task failed", "%11u", false, v17);
+DOMAIN_FIELD(__u32, alb_pushed,
+	     "active_load_balance() successfully moved a task", "%11u", false, v17);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_exec()> ");
+#endif
+DOMAIN_FIELD(__u32, sbe_count,
+	     "sbe_count is not used", "%11u", false, v17);
+DOMAIN_FIELD(__u32, sbe_balanced,
+	     "sbe_balanced is not used", "%11u", false, v17);
+DOMAIN_FIELD(__u32, sbe_pushed,
+	     "sbe_pushed is not used", "%11u", false, v17);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_fork()> ");
+#endif
+DOMAIN_FIELD(__u32, sbf_count,
+	     "sbf_count is not used", "%11u", false, v17);
+DOMAIN_FIELD(__u32, sbf_balanced,
+	     "sbf_balanced is not used", "%11u", false, v17);
+DOMAIN_FIELD(__u32, sbf_pushed,
+	     "sbf_pushed is not used", "%11u", false, v17);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Wakeup Info> ");
+#endif
+DOMAIN_FIELD(__u32, ttwu_wake_remote,
+	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v17);
+DOMAIN_FIELD(__u32, ttwu_move_affine,
+	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v17);
+DOMAIN_FIELD(__u32, ttwu_move_balance,
+	     "try_to_wake_up() started passive balancing", "%11u", false, v17);
+#endif /* DOMAIN_FIELD */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 88a5dad240ac..d50fd1c00dfc 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -587,6 +587,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
 		return size;
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
+		return size;
 	}
 #undef CPU_FIELD
 
@@ -609,6 +612,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
 		return size;
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
+		return size;
 	}
 #undef DOMAIN_FIELD
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index ebaaf53c1024..3052c9afae1f 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2569,6 +2569,8 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
 #include <perf/schedstat-v15.h>
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
 	}
 #undef CPU_FIELD
 
@@ -2595,6 +2597,11 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 		return NULL;
 
 	ch = io__get_dec(io, &d_num);
+	if (version >= 17) {
+		/* Skip domain name as it can be extracted from perf header */
+		while (io__get_char(io) != ' ')
+			continue;
+	}
 
 	/* Skip cpumask as it can be extracted from perf header */
 	while (io__get_char(io) != ' ')
@@ -2624,6 +2631,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 #include <perf/schedstat-v15.h>
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
 	}
 #undef DOMAIN_FIELD
 
@@ -2667,6 +2676,8 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
 		version = 15;
 	} else if (!strcmp(line, "version 16\n")) {
 		version = 16;
+	} else if (!strcmp(line, "version 17\n")) {
+		version = 17;
 	} else {
 		pr_err("Unsupported %s version: %s", path, line + 8);
 		goto out_free_line;
-- 
2.43.0


