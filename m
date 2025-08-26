Return-Path: <linux-kernel+bounces-785973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2898B3530F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E941B2534B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEE61A23B9;
	Tue, 26 Aug 2025 05:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GpS4rBS5"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAC42D0626;
	Tue, 26 Aug 2025 05:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185200; cv=fail; b=vDs39AOEfYkln4/VzUsWoY1XeqW7KT3K6OV8nZ9pCNrBmjM0ikTVYugjeooOyJR6IoXlAcCXV0hsmPLTocLk0/Mb54dD3AfwqpwutihZjyBSeAaIMxQrLfez60dELBo9NAJOBh2pvn6/FCHjCTvGmYCwqhdziukZDTMvu/BIBIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185200; c=relaxed/simple;
	bh=vKV6NaUO442kFlnCg4C8uUnEYRNc5N7H49DEps2ILW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHhQ1LCnBX68PNmYu+Av30cybT4FLlKyWAVEwoEhxaLe3zdrLMMNhJ+iagq5m/E6MCOVJCJSaQi+6IH9KEaEFmuLT8ZTVbfvHqUV4AD52R5/YQ9BIYanIh/xw7UJy2MxYBHX3rgGFHGzvEjOWAN1XPjJuaJAeaknf0R7h1qxkQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GpS4rBS5; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMdVC02iRj+dG3DHELdYjqLCpLPIVuMaEj/knLZKqWvgk+hWgoJw02GaAbnYHtI/9lJ62WwUirqhTCHyuX7AET1t/sXyB0M80pHAOy5WC4JuC07kVI4JkPRW5Ls0I46NZVU5NGmqycERFRsO51VJBtKLOe7eOnLVUR90is32oM5WLWOVF/fbVtpyRH7AstyF45yRP7WfPPJSiLu3Ts7cQwunAiyfZ2HmddNDXV4Ld6YsWXO3G8k9SMO2+Ytu9uPG0bO8bdhn1pELi/Zz0US1/+a8L5HTlVOj7qk3hHJwOilz0Ujn47ju2vZyBuNUkCxMX5RKmqCOGCa6AUM8sZWqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg0v0ou/wPwPGrMYM9TW31+l8rxd8UhKVT2fU6INr5E=;
 b=dJvxV4l/WPQLcr5JINNcp289MnVN/KEq32N3avcth892ZSJbEWqAx0Wj2qMb5FcWaP5vB+CWK2DVWRKTbfhx69CeIF4+k43hDUU1SaO/bk0vzu6vF6pk0qgaeqh4i5hwdj4c+W7Bo/jwWYj/Nju3rtpmDihhbH0rkGn6la5CdRSgmo+zhYmQg2lFgI6pTfv4qfCEdvzd9RuRVbtcVlBtBFk7ooyR8yECz6bKyj5eTKyPsEb8dRkqqxwtqcmZANz0CfqENmKJngMSMAdENoIizUMvsYcDBA8D1tPYtwvaorIpTKHRIpj/1SJpVfEb0bWwsLa2xOjur/sjzEO4UVc3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg0v0ou/wPwPGrMYM9TW31+l8rxd8UhKVT2fU6INr5E=;
 b=GpS4rBS5VYEYVbYkEH2fWgTSoifdCQDMVzGhriH9sVI8/GGYu1iZ0AZYWgU2Q7zjQWCNIhoYyWhkwScVphsaNR/0/P+573GYc8h89o8Y2OMHqPdonZkQR44qdG5LXaLZQ6pM9S8/lbseafFOQJ6AFRV8MpVV3J3mmYy66ei7yS8=
Received: from MW4PR04CA0191.namprd04.prod.outlook.com (2603:10b6:303:86::16)
 by LV9PR12MB9759.namprd12.prod.outlook.com (2603:10b6:408:2ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 05:13:11 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::f) by MW4PR04CA0191.outlook.office365.com
 (2603:10b6:303:86::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 05:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:13:10 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:13:03 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <corbet@lwn.net>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <iamjoonsoo.kim@lge.com>,
	<qyousef@layalina.io>, <sshegde@linux.ibm.com>, <alexs@kernel.org>,
	<lukasz.luba@arm.com>, <cpru@amazon.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, James Clark
	<james.clark@linaro.org>
Subject: [PATCH v4 05/11] perf sched stats: Add schedstat v16 support
Date: Tue, 26 Aug 2025 05:10:33 +0000
Message-ID: <20250826051039.2626894-6-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|LV9PR12MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: a090cfec-2f7f-4c82-a422-08dde45f4062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jT5AGbU5J7I1ImSFZ6k81vn1NdMkEz6QACciQhZxGgRVMMnfz1GnNpKZ6xM9?=
 =?us-ascii?Q?0DzIX7U8KBhISB+HrMm/HcaxDXQHS2XB6QqQuHrhoyCcgzV2X6otIxOOuyor?=
 =?us-ascii?Q?0FvSrmZqMJ5hLPH5amqZ/n7xH2h/Rmig92tsxCzpPe4va3OzW+0vga0XWrbY?=
 =?us-ascii?Q?ZI65TL07WrQYeKgOy7QW/dkeB/16swkQ0Kl1L+IJVKlE9e+zoigulU8BJbJN?=
 =?us-ascii?Q?GDkzYLV/D6ZiIFXSrDLqRqMKWFX93wn1aScCULM7phmfTycRwKXqbxyLXmf9?=
 =?us-ascii?Q?PGqhPkBBbAuvNQKxuW9Kstgg3LsYNuSnxroR0uuIaOqnrJvpSsFidNqCZ7UQ?=
 =?us-ascii?Q?o0CcTW4oPaRf+2KaJuIEEuyXTp8yLQI9AN8IyDFRXOfdGiMjJyqCJ4KzVVBE?=
 =?us-ascii?Q?HCdDiTyvNQAUATykzJrHAKpGJBLYfbQOyPM2FuD1l/feZEk1e+LQcS8CNcsR?=
 =?us-ascii?Q?1Qdc5Yqh+lZoM7oG4d1w1IykbkKeuQHZSCxyeYqCsGsvgOtiWIszI7zrtYRj?=
 =?us-ascii?Q?snRHMjcIofXsV9hut5ytrRyIoPYYxOMK5L6PuNRAk0or64FjA23qVj1mZ4Ct?=
 =?us-ascii?Q?kIYSdYTr+hou1OkYyuvrfWPQnHmQ+PeFUMEl89LfDU75c6dK2PBnpigpIXIY?=
 =?us-ascii?Q?8LR5PAHh5QQa0WQLFcDij1hbgywP9lLSchwy1Fj+moiZLIKu+9kfGqkVYbIW?=
 =?us-ascii?Q?dKmd3vb1OdVxsQG0KNRIu3Q77bF+SynRGmyP8QB++B7md0xe7MNR/nPCG7tn?=
 =?us-ascii?Q?1h/bAQQgxX//FuZY/ldFPcSi5HbTG29wDRwLkItD0gi2xMyLzDfuX5CBiTb8?=
 =?us-ascii?Q?H2pGv2QNcdMCQN5jxq/YINMDgUqCfhR125+iPtz8qKNEaeXh7t7gSWT4gF6k?=
 =?us-ascii?Q?MZQuDWvnhq/2xLYaAEkzBF1oQMrTiS85yvibUUIl41SCRMK5AzWjxk7gZbp0?=
 =?us-ascii?Q?O9Nt0+Y/dhoqibQYNcwMxrm+tPl4RMADCN3lzhBN6A+gZJAkypEJr9TiWQPp?=
 =?us-ascii?Q?fxyTvDHPxIDU3bdP8OvwogccQ2wFnT6scFDSRYxSPgVHaBIdu081nvXjZPpQ?=
 =?us-ascii?Q?GTBLOFpfdLXEv+wRf76owkQXpkh+o+xPm9DOilf4UvXVlIWtqrbKdrKsdlfF?=
 =?us-ascii?Q?vb/PMJb5zyF2c+rQUexyAGL2acZ3kYv/7Y4aQnGGqxpS450DRM7nfqahCKm1?=
 =?us-ascii?Q?fH3U/hFqWirBDFoZ90yuHQ7Q3e7THGI6wa0867aQ6fdmIuhwn7YUzZVQ2Dt1?=
 =?us-ascii?Q?O4BGerGac5gWB+9BeOHdwEGL10oWt203HOlSSzQB+HZDAyXFw7Wa48U3tFj0?=
 =?us-ascii?Q?UtdU02Ba/v59X3c4fg9ZZI7tl2AhEDF1BmZEkbkZgdAPD4zDLmQqbd9wnQgd?=
 =?us-ascii?Q?8AQNIfzmWSb3chnQdZlzQoZpMWNOmweyYJS1ND4q6kRcJQxRPUg2iRoyW2HT?=
 =?us-ascii?Q?RtxT+a0KTCWDrOFwKuqMo7In5YjA0vuvDTwkD9zuayoXP5+aXxZ5NyY//vXP?=
 =?us-ascii?Q?+Ko0cLe93lnP5Vfk1f5R4LL9Y+zknrRSV6L3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:13:10.8440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a090cfec-2f7f-4c82-a422-08dde45f4062
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9759

/proc/schedstat file output is standardized with version number.
Add support to record and raw dump v16 version layout.

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/lib/perf/Makefile                     |   2 +-
 tools/lib/perf/include/perf/event.h         |  14 ++
 tools/lib/perf/include/perf/schedstat-v16.h | 146 ++++++++++++++++++++
 tools/perf/util/event.c                     |   6 +
 tools/perf/util/synthetic-events.c          |   6 +
 5 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-v16.h

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 9fa28e512ca8..965e066fd780 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -179,7 +179,7 @@ install_lib: libs
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
 HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
-HDRS += schedstat-v15.h
+HDRS += schedstat-v15.h schedstat-v16.h
 INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
 
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 7ed7bae73b55..4c38a58e19c3 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -489,6 +489,12 @@ struct perf_record_schedstat_cpu_v15 {
 #undef CPU_FIELD
 };
 
+struct perf_record_schedstat_cpu_v16 {
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		_type _name
+#include "schedstat-v16.h"
+#undef CPU_FIELD
+};
+
 struct perf_record_schedstat_cpu {
 	struct perf_event_header header;
 	__u64			 timestamp;
@@ -498,6 +504,7 @@ struct perf_record_schedstat_cpu {
 	char			 __pad[2];
 	union {
 		struct perf_record_schedstat_cpu_v15 v15;
+		struct perf_record_schedstat_cpu_v16 v16;
 	};
 };
 
@@ -507,6 +514,12 @@ struct perf_record_schedstat_domain_v15 {
 #undef DOMAIN_FIELD
 };
 
+struct perf_record_schedstat_domain_v16 {
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		_type _name
+#include "schedstat-v16.h"
+#undef DOMAIN_FIELD
+};
+
 #define DOMAIN_NAME_LEN		16
 
 struct perf_record_schedstat_domain {
@@ -517,6 +530,7 @@ struct perf_record_schedstat_domain {
 	__u16			 domain;
 	union {
 		struct perf_record_schedstat_domain_v15 v15;
+		struct perf_record_schedstat_domain_v16 v16;
 	};
 };
 
diff --git a/tools/lib/perf/include/perf/schedstat-v16.h b/tools/lib/perf/include/perf/schedstat-v16.h
new file mode 100644
index 000000000000..3462b79c29af
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-v16.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CPU_FIELD
+CPU_FIELD(__u32, yld_count, "sched_yield() count",
+	  "%11u", false, yld_count, v16);
+CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
+	  "%11u", false, array_exp, v16);
+CPU_FIELD(__u32, sched_count, "schedule() called",
+	  "%11u", false, sched_count, v16);
+CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
+	  "%11u", true, sched_count, v16);
+CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
+	  "%11u", false, ttwu_count, v16);
+CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
+	  "%11u", true, ttwu_count, v16);
+CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
+	  "%11llu", false, rq_cpu_time, v16);
+CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
+	  "%11llu", true, rq_cpu_time, v16);
+CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
+	  "%11llu", false, pcount, v16);
+#endif /* CPU_FIELD */
+
+#ifdef DOMAIN_FIELD
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category busy> ");
+#endif
+DOMAIN_FIELD(__u32, busy_lb_count,
+	     "load_balance() count on cpu busy", "%11u", true, v16);
+DOMAIN_FIELD(__u32, busy_lb_balanced,
+	     "load_balance() found balanced on cpu busy", "%11u", true, v16);
+DOMAIN_FIELD(__u32, busy_lb_failed,
+	     "load_balance() move task failed on cpu busy", "%11u", true, v16);
+DOMAIN_FIELD(__u32, busy_lb_imbalance,
+	     "imbalance sum on cpu busy", "%11u", false, v16);
+DOMAIN_FIELD(__u32, busy_lb_gained,
+	     "pull_task() count on cpu busy", "%11u", false, v16);
+DOMAIN_FIELD(__u32, busy_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v16);
+DOMAIN_FIELD(__u32, busy_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v16);
+DOMAIN_FIELD(__u32, busy_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v16);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(busy_lb_success_count, "load_balance() success count on cpu busy", "%11u",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v16);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(busy_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v16);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category idle> ");
+#endif
+DOMAIN_FIELD(__u32, idle_lb_count,
+	     "load_balance() count on cpu idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, idle_lb_balanced,
+	     "load_balance() found balanced on cpu idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, idle_lb_failed,
+	     "load_balance() move task failed on cpu idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, idle_lb_imbalance,
+	     "imbalance sum on cpu idle", "%11u", false, v16);
+DOMAIN_FIELD(__u32, idle_lb_gained,
+	     "pull_task() count on cpu idle", "%11u", false, v16);
+DOMAIN_FIELD(__u32, idle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v16);
+DOMAIN_FIELD(__u32, idle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, idle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v16);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(idle_lb_success_count, "load_balance() success count on cpu idle", "%11u",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v16);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(idle_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v16);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category newidle> ");
+#endif
+DOMAIN_FIELD(__u32, newidle_lb_count,
+	     "load_balance() count on cpu newly idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, newidle_lb_balanced,
+	     "load_balance() found balanced on cpu newly idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, newidle_lb_failed,
+	     "load_balance() move task failed on cpu newly idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance,
+	     "imbalance sum on cpu newly idle", "%11u", false, v16);
+DOMAIN_FIELD(__u32, newidle_lb_gained,
+	     "pull_task() count on cpu newly idle", "%11u", false, v16);
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v16);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v16);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(newidle_lb_success_count,
+		  "load_balance() success count on cpu newly idle", "%11u",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v16);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(newidle_lb_avg_count,
+		  "avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v16);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category active_load_balance()> ");
+#endif
+DOMAIN_FIELD(__u32, alb_count,
+	     "active_load_balance() count", "%11u", false, v16);
+DOMAIN_FIELD(__u32, alb_failed,
+	     "active_load_balance() move task failed", "%11u", false, v16);
+DOMAIN_FIELD(__u32, alb_pushed,
+	     "active_load_balance() successfully moved a task", "%11u", false, v16);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_exec()> ");
+#endif
+DOMAIN_FIELD(__u32, sbe_count,
+	     "sbe_count is not used", "%11u", false, v16);
+DOMAIN_FIELD(__u32, sbe_balanced,
+	     "sbe_balanced is not used", "%11u", false, v16);
+DOMAIN_FIELD(__u32, sbe_pushed,
+	     "sbe_pushed is not used", "%11u", false, v16);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_fork()> ");
+#endif
+DOMAIN_FIELD(__u32, sbf_count,
+	     "sbf_count is not used", "%11u", false, v16);
+DOMAIN_FIELD(__u32, sbf_balanced,
+	     "sbf_balanced is not used", "%11u", false, v16);
+DOMAIN_FIELD(__u32, sbf_pushed,
+	     "sbf_pushed is not used", "%11u", false, v16);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Wakeup Info> ");
+#endif
+DOMAIN_FIELD(__u32, ttwu_wake_remote,
+	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v16);
+DOMAIN_FIELD(__u32, ttwu_move_affine,
+	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v16);
+DOMAIN_FIELD(__u32, ttwu_move_balance,
+	     "try_to_wake_up() started passive balancing", "%11u", false, v16);
+#endif /* DOMAIN_FIELD */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 41fb942ef701..88a5dad240ac 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -584,6 +584,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
 		return size;
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+		return size;
 	}
 #undef CPU_FIELD
 
@@ -603,6 +606,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
 		return size;
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+		return size;
 	}
 #undef DOMAIN_FIELD
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index ef8d9613eab1..ebaaf53c1024 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2567,6 +2567,8 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
 
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
 	}
 #undef CPU_FIELD
 
@@ -2620,6 +2622,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
 	}
 #undef DOMAIN_FIELD
 
@@ -2661,6 +2665,8 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
 
 	if (!strcmp(line, "version 15\n")) {
 		version = 15;
+	} else if (!strcmp(line, "version 16\n")) {
+		version = 16;
 	} else {
 		pr_err("Unsupported %s version: %s", path, line + 8);
 		goto out_free_line;
-- 
2.43.0


