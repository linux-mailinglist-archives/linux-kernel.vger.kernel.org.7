Return-Path: <linux-kernel+bounces-785975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BE2B35313
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C181B25A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA7B2E36E1;
	Tue, 26 Aug 2025 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5YaK8cXf"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44837260B;
	Tue, 26 Aug 2025 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185243; cv=fail; b=Ti5jF4mcpmoikJEi9cot6scF7+WqJ1BCleKImmmLs5nGXJlif2oF1xhd+CLiodYJUlBzZPIX0DbN30DclOxffilm6XncnPC+pjnWshJKzKcPPyO8mboOrZbMNilOBnqNn3l/NWUiuieBCIfQSjikfi28D4sg7eEkLsI/a4d2zqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185243; c=relaxed/simple;
	bh=re5aark05SAWAjeVlSOp0aljB8igxjdDGEL8eDhq6OI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/8FfP78uaJFS/lWrVOKiv0gQVK/o2EaZj6E6YnnQ2O7rMW2m+vb8SNZTGxCx7i4+mkPMkDoLeYUJVcFxs7D3fL+yiFoaylyJbGWZqgdiZKtiYNSan6bJWdbt49HZXz1hGnZXWjIEHCMHrM3lhYp/ruALef4okJrt4l1wz4yfZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5YaK8cXf; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtXmnnewJglxcqpFecghnF1O2s30kjmbHj6XqIVkuKGwDbSKfk1FYlDSybQ+l1e7/5esKMalKxZLhse5I01A3DJCq6465SYaBZB+ybwC99AvsnFfUWle4I8IjkNfKZ8RwyP4S4wb3efQp0BzZc/zuUXGvRj8x5VuBd84fPvV6SZynusTvKw18nrSXP/gqxY04T6/pIwRrA1TfvHl3j2jcrrnTLdtvhG+HFHAFrhcXOdXXFkAxwVG+utsmFzFa2wkQMehOm0v157QGFGz7VXxCNRpZ64pn+MU1Qqe+4wGnyH87R9bHvVwXMNn7eNzu1GpKhm2CBlffpu2OTBRiRmwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZDLb27WQGUgDzCconJAK6S8FtNNRDhGSDwyXo4oPCM=;
 b=GGnq5ukamC1J2N94oQr8b+GeZ+lyF0kRbYWULyXk4WSYdR/WAek37RxzjqBNR3sxGOZ8KMTkzTSxmw5EDz0VQS5SU0yEDZaf339QovbQB/TygEy++qjvecEQVXejck6ydRAtB2kSOLZPF5QO6IaUiOG5MRbb9mLkCqHoXrviIzKJbJCtVYmtZWzlHen3s+nzXcpa8aMUG0FZfRI+cIyjrk8WNRxqI4Y3u3IXAtB61OMbDrBpgKoyafqwvs52N4424mtSi9AZm0ftm/pJOu5euFXhVFIKPNR9qYEn10vkc8tVF0UceKrMj3UfQlv1ZKqNjNGrN35kld4U+Cf3slztqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZDLb27WQGUgDzCconJAK6S8FtNNRDhGSDwyXo4oPCM=;
 b=5YaK8cXfVrZki8eAAD6x83Mj61uvqv7D2CyybN9LqLofTM0c7QXhda73miM3MeKb5Qo9ZsxlvkqD57AA59gwzBttoFL5VrBTH9iy6N4FnZD2r/UNfJuC8zhjSNT1ULWnR06l+94T51rD+C1mYn1GI+nJqtXn+Roz6tsgvwdG8kI=
Received: from MW4PR04CA0144.namprd04.prod.outlook.com (2603:10b6:303:84::29)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 05:13:53 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::3b) by MW4PR04CA0144.outlook.office365.com
 (2603:10b6:303:84::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 05:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:13:52 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:13:45 -0500
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
Subject: [PATCH v4 07/11] perf sched stats: Add support for report subcommand
Date: Tue, 26 Aug 2025 05:10:35 +0000
Message-ID: <20250826051039.2626894-8-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: f049ded7-5f01-4f88-1c0b-08dde45f5951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HXAedCgNQ2ycvmI7ldmkyWqb8ZTBAVueWy1bf7GM12qnFoz0n1ccR91oUfRB?=
 =?us-ascii?Q?x9BcuEt04s8KbAqNjk4SDeFbRGn2lECWkx7LogdpsN64tH1AELVA81gkyMww?=
 =?us-ascii?Q?aZxaqiHaZq6tfTAifLkZ3aAhJiRe3vUegR41ZOSlq1h+cFWBZV56V8PXCPwC?=
 =?us-ascii?Q?vtN7K6HmVRebmyo85kBjY2wHzI9aK+kL1OL3n5nLWzglSKB+EVe2Citt4Jch?=
 =?us-ascii?Q?mGG9eT9HHqmpdkagf3fuo+kAGtA6k0Its7vzgu8xDLCH7nTaulS0pDn9XV3G?=
 =?us-ascii?Q?sefX589vClREYwvjnsNFGgV6aDD/A+0XRXdyJbOaJeikeUmnyQSOTqbY/vuw?=
 =?us-ascii?Q?/W11mrwy25halycxcAq+nesDSoUh0yTWp0iSkQW56uKsZYeAmzSI6OMoqltT?=
 =?us-ascii?Q?r+2Ya3AdQMjyB5lK+mCtkBc9gedsi95rp+S2RoYvzcliAP9i6nRRIdQX/lX9?=
 =?us-ascii?Q?ks6xaQiCIFqSPA4vMlH2WDG0wCer7BmacIaUg+5okvOUXB99BCFZmgGfJ5XU?=
 =?us-ascii?Q?bDJkKHHC9WaFFmrk6PgAaAiZHA+YjlhB8FR+IYjGyQbpNBjisi40+JFANUSu?=
 =?us-ascii?Q?HMyOoQSrPqjMiMyVpvavLGnFfeSMcH7QVJb7+LEVXqIinLiSmsPgSpHts3wX?=
 =?us-ascii?Q?u9/esA46BKvqYkQTRekW1wUuK0iLtCdQ20SmLpr3Z3DILw/2NohpfRp7zNpy?=
 =?us-ascii?Q?PsMe/SVhaxAV4wrhBnN305QzA1wHxqfY2wurpHOyjrfoJR+wfD9VQ2VIc2kD?=
 =?us-ascii?Q?d+WUYQ7nUKjTc01mOKEiKJihESTZzuZjcN/KWzqrXKkRfyE1IkmKIun3njg7?=
 =?us-ascii?Q?X/NmbzgbLrwFKlvai6esDNYhUqTE5UK/3rEh/5o2El8thHwlocr1bifd0bkm?=
 =?us-ascii?Q?fecV7Gmf8XXjzfBtKXdiFJebv5G9VcC4hnrrkcBIscA4EFvW166wuqrfhkz1?=
 =?us-ascii?Q?GPPArHGwG4Ecr352PvHIfSO8bgwqLmke0jSEf6Q/1GDuQk0TfDAxD147tBjM?=
 =?us-ascii?Q?OJefYxSZ01BrPU+RJS126Eh2rDK4gBkldOtqOywDeat9L+BKDHrQY+JVKh/n?=
 =?us-ascii?Q?7HRpTZehEZ9yivsKJrntF4EX7A9u4zribRMtzlTwMR259+wkZcCfUnpwLGWn?=
 =?us-ascii?Q?a73qwOa7s3Ye+m1/gyRE3EZNRr+zk7/BlC5dSdO1sSxSrwMcd/rBetnx5CQ8?=
 =?us-ascii?Q?Y+7TMVOwCxznkew3wzaNd6jUMwr27aWaJWtBXGnM0s0s8dy3rdyvGhPrzbTP?=
 =?us-ascii?Q?sD1QjsF29a95q1J8GkY3r5d/DGW7YckepQAsfXs+7irUzB0BT5SeLDIwjyBK?=
 =?us-ascii?Q?nE0yd7kesF3q/X7Lg1nZuSGUEMZ1FSqhKDuGdhWr9jlQwdIklaIP6fR20Kab?=
 =?us-ascii?Q?M5Tv9wp+657a+7cNcw9eNzn9NIMlawrkQb4u54mmuef367/5Tvq6pJIFIh2a?=
 =?us-ascii?Q?smJ/TN/4W2O/hsRS22OAr20l7nVxUCpwf+OS/zjWtHWc81jGCkk/Zc+B4cFh?=
 =?us-ascii?Q?qPqlKV9o0X+pueaeBCKyMTKe9vTbGMAiYOKA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:13:52.6717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f049ded7-5f01-4f88-1c0b-08dde45f5951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180

`perf sched stats record` captures two sets of samples. For workload
profile, first set right before workload starts and second set after
workload finishes. For the systemwide profile, first set at the
beginning of profile and second set on receiving SIGINT signal.

Add `perf sched stats report` subcommand that will read both the set
of samples, get the diff and render a final report. Final report prints
scheduler stat at cpu granularity as well as sched domain granularity.

Example usage:

  # perf sched stats record
  # perf sched stats report

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 509 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 508 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2573491fa5f8..e23018798f5b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3940,6 +3940,505 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 	return err;
 }
 
+struct schedstat_domain {
+	struct list_head domain_list;
+	struct perf_record_schedstat_domain *domain_data;
+};
+
+struct schedstat_cpu {
+	struct list_head cpu_list;
+	struct list_head domain_head;
+	struct perf_record_schedstat_cpu *cpu_data;
+};
+
+static struct list_head cpu_head = LIST_HEAD_INIT(cpu_head);
+static struct schedstat_cpu *cpu_second_pass;
+static struct schedstat_domain *domain_second_pass;
+static bool after_workload_flag;
+static bool verbose_field;
+
+static void store_schedtstat_cpu_diff(struct schedstat_cpu *after_workload)
+{
+	struct perf_record_schedstat_cpu *before = cpu_second_pass->cpu_data;
+	struct perf_record_schedstat_cpu *after = after_workload->cpu_data;
+	__u16 version = after_workload->cpu_data->version;
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	\
+	(before->_ver._name = after->_ver._name - before->_ver._name)
+
+	if (version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+
+#undef CPU_FIELD
+}
+
+static void store_schedstat_domain_diff(struct schedstat_domain *after_workload)
+{
+	struct perf_record_schedstat_domain *before = domain_second_pass->domain_data;
+	struct perf_record_schedstat_domain *after = after_workload->domain_data;
+	__u16 version = after_workload->domain_data->version;
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)	\
+	(before->_ver._name = after->_ver._name - before->_ver._name)
+
+	if (version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+#undef DOMAIN_FIELD
+}
+
+static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
+{
+	printf("%-65s %12s %12s\n", "DESC", "COUNT", "PCT_CHANGE");
+	printf("%.*s\n", 100, graph_dotted_line);
+
+#define CALC_PCT(_x, _y)	((_y) ? ((double)(_x) / (_y)) * 100 : 0.0)
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
+	do {									\
+		printf("%-65s: " _format, verbose_field ? _desc : #_name,	\
+		       cs->_ver._name);						\
+		if (_is_pct) {							\
+			printf("  ( %8.2lf%% )",				\
+			       CALC_PCT(cs->_ver._name, cs->_ver._pct_of));	\
+		}								\
+		printf("\n");							\
+	} while (0)
+
+	if (cs->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (cs->version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (cs->version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+
+#undef CPU_FIELD
+#undef CALC_PCT
+}
+
+static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
+				      __u64 jiffies)
+{
+	printf("%-65s %12s %14s\n", "DESC", "COUNT", "AVG_JIFFIES");
+
+#define DOMAIN_CATEGORY(_desc)							\
+	do {									\
+		size_t _len = strlen(_desc);					\
+		size_t _pre_dash_cnt = (100 - _len) / 2;			\
+		size_t _post_dash_cnt = 100 - _len - _pre_dash_cnt;		\
+		print_separator((int)_pre_dash_cnt, _desc, (int)_post_dash_cnt);\
+	} while (0)
+
+#define CALC_AVG(_x, _y)	((_y) ? (long double)(_x) / (_y) : 0.0)
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
+	do {									\
+		printf("%-65s: " _format, verbose_field ? _desc : #_name,	\
+		       ds->_ver._name);						\
+		if (_is_jiffies) {						\
+			printf("  $ %11.2Lf $",					\
+			       CALC_AVG(jiffies, ds->_ver._name));		\
+		}								\
+		printf("\n");							\
+	} while (0)
+
+#define DERIVED_CNT_FIELD(_name, _desc, _format, _x, _y, _z, _ver)		\
+	printf("*%-64s: " _format "\n", verbose_field ? _desc : #_name,		\
+	       (ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))
+
+#define DERIVED_AVG_FIELD(_name, _desc, _format, _x, _y, _z, _w, _ver)		\
+	printf("*%-64s: " _format "\n", verbose_field ? _desc : #_name,		\
+	       CALC_AVG(ds->_ver._w,						\
+			((ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))))
+
+	if (ds->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (ds->version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (ds->version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+
+#undef DERIVED_AVG_FIELD
+#undef DERIVED_CNT_FIELD
+#undef DOMAIN_FIELD
+#undef CALC_AVG
+#undef DOMAIN_CATEGORY
+}
+
+static void summarize_schedstat_cpu(struct schedstat_cpu *summary_cpu,
+				    struct schedstat_cpu *cptr,
+				    int cnt, bool is_last)
+{
+	struct perf_record_schedstat_cpu *summary_cs = summary_cpu->cpu_data,
+					 *temp_cs = cptr->cpu_data;
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
+	do {									\
+		summary_cs->_ver._name += temp_cs->_ver._name;			\
+		if (is_last)							\
+			summary_cs->_ver._name /= cnt;				\
+	} while (0)
+
+	if (cptr->cpu_data->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (cptr->cpu_data->version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (cptr->cpu_data->version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+#undef CPU_FIELD
+}
+
+static void summarize_schedstat_domain(struct schedstat_domain *summary_domain,
+				       struct schedstat_domain *dptr,
+				       int cnt, bool is_last)
+{
+	struct perf_record_schedstat_domain *summary_ds = summary_domain->domain_data,
+					    *temp_ds = dptr->domain_data;
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
+	do {									\
+		summary_ds->_ver._name += temp_ds->_ver._name;			\
+		if (is_last)							\
+			summary_ds->_ver._name /= cnt;				\
+	} while (0)
+
+	if (dptr->domain_data->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (dptr->domain_data->version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (dptr->domain_data->version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+#undef DOMAIN_FIELD
+}
+
+static int get_all_cpu_stats(struct list_head *head)
+{
+	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
+	struct schedstat_cpu *summary_head = NULL;
+	struct perf_record_schedstat_domain *ds;
+	struct perf_record_schedstat_cpu *cs;
+	struct schedstat_domain *dptr, *tdptr;
+	bool is_last = false;
+	int cnt = 1;
+	int ret = 0;
+
+	if (cptr) {
+		summary_head = zalloc(sizeof(*summary_head));
+		if (!summary_head)
+			return -ENOMEM;
+
+		summary_head->cpu_data = zalloc(sizeof(*cs));
+		memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*cs));
+
+		INIT_LIST_HEAD(&summary_head->domain_head);
+
+		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
+			tdptr = zalloc(sizeof(*tdptr));
+			if (!tdptr)
+				return -ENOMEM;
+
+			tdptr->domain_data = zalloc(sizeof(*ds));
+			if (!tdptr->domain_data)
+				return -ENOMEM;
+
+			memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*ds));
+			list_add_tail(&tdptr->domain_list, &summary_head->domain_head);
+		}
+	}
+
+
+	list_for_each_entry(cptr, head, cpu_list) {
+		if (list_is_first(&cptr->cpu_list, head))
+			continue;
+
+		if (list_is_last(&cptr->cpu_list, head))
+			is_last = true;
+
+		cnt++;
+		summarize_schedstat_cpu(summary_head, cptr, cnt, is_last);
+		tdptr = list_first_entry(&summary_head->domain_head, struct schedstat_domain,
+					 domain_list);
+
+		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
+			summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
+			tdptr = list_next_entry(tdptr, domain_list);
+		}
+	}
+
+	list_add(&summary_head->cpu_list, head);
+
+	return ret;
+}
+
+static void print_field_description(struct schedstat_cpu *cptr)
+{
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
+		printf("%-30s-> %s\n", #_name, _desc)				\
+
+#define DOMAIN_CATEGORY(_desc)							\
+	do {									\
+		size_t _len = strlen(_desc);					\
+		size_t _pre_dash_cnt = (100 - _len) / 2;			\
+		size_t _post_dash_cnt = 100 - _len - _pre_dash_cnt;		\
+		print_separator((int)_pre_dash_cnt, _desc, (int)_post_dash_cnt);\
+	} while (0)
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
+		printf("%-30s-> %s\n", #_name, _desc)				\
+
+#define DERIVED_CNT_FIELD(_name, _desc, _format, _x, _y, _z, _ver)		\
+		printf("*%-29s-> %s\n", #_name, _desc)				\
+
+#define DERIVED_AVG_FIELD(_name, _desc, _format, _x, _y, _z, _w, _ver)		\
+		printf("*%-29s-> %s\n", #_name, _desc)				\
+
+	if (cptr->cpu_data->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (cptr->cpu_data->version == 16) {
+#include <perf/schedstat-v16.h>
+	} else if (cptr->cpu_data->version == 17) {
+#include <perf/schedstat-v17.h>
+	}
+#undef CPU_FIELD
+#undef DOMAIN_CATEGORY
+#undef DERIVED_CNT_FIELD
+#undef DERIVED_AVG_FIELD
+#undef DOMAIN_FIELD
+}
+
+static int show_schedstat_data(struct list_head *head, struct cpu_domain_map **cd_map)
+{
+	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
+	__u64 jiffies = cptr->cpu_data->timestamp;
+	struct perf_record_schedstat_domain *ds;
+	struct perf_record_schedstat_cpu *cs;
+	struct schedstat_domain *dptr;
+	bool is_summary = true;
+	int ret = 0;
+
+	printf("Description\n");
+	print_separator(100, "", 0);
+	printf("%-30s-> %s\n", "DESC", "Description of the field");
+	printf("%-30s-> %s\n", "COUNT", "Value of the field");
+	printf("%-30s-> %s\n", "PCT_CHANGE", "Percent change with corresponding base value");
+	printf("%-30s-> %s\n", "AVG_JIFFIES",
+	       "Avg time in jiffies between two consecutive occurrence of event");
+
+	if (!verbose_field) {
+		print_separator(100, "", 0);
+		print_field_description(cptr);
+	}
+
+	print_separator(100, "", 0);
+	printf("\n");
+
+	printf("%-65s: %11llu\n", "Time elapsed (in jiffies)", jiffies);
+	print_separator(100, "", 0);
+
+	ret = get_all_cpu_stats(head);
+
+	list_for_each_entry(cptr, head, cpu_list) {
+		cs = cptr->cpu_data;
+		printf("\n");
+		print_separator(100, "", 0);
+
+		if (is_summary)
+			printf("CPU <ALL CPUS SUMMARY>\n");
+		else
+			printf("CPU %d\n", cs->cpu);
+
+		print_separator(100, "", 0);
+		print_cpu_stats(cs);
+		print_separator(100, "", 0);
+
+		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
+			struct domain_info *dinfo;
+
+			ds = dptr->domain_data;
+			dinfo = cd_map[ds->cpu]->domains[ds->domain];
+			if (is_summary)
+				if (dinfo->dname)
+					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %s\n", dinfo->dname);
+				else
+					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %d\n", dinfo->domain);
+			else {
+				if (dinfo->dname)
+					printf("CPU %d, DOMAIN %s CPUS ", cs->cpu, dinfo->dname);
+				else
+					printf("CPU %d, DOMAIN %d CPUS ", cs->cpu, dinfo->domain);
+
+				printf("%s\n", dinfo->cpulist);
+			}
+			print_separator(100, "", 0);
+			print_domain_stats(ds, jiffies);
+			print_separator(100, "", 0);
+		}
+		is_summary = false;
+	}
+	return ret;
+}
+
+static int perf_sched__process_schedstat(struct perf_session *session __maybe_unused,
+					 union perf_event *event)
+{
+	struct perf_cpu this_cpu;
+	static __u32 initial_cpu;
+
+	switch (event->header.type) {
+	case PERF_RECORD_SCHEDSTAT_CPU:
+		this_cpu.cpu = event->schedstat_cpu.cpu;
+		break;
+	case PERF_RECORD_SCHEDSTAT_DOMAIN:
+		this_cpu.cpu = event->schedstat_domain.cpu;
+		break;
+	default:
+		return 0;
+	}
+
+	if (user_requested_cpus && !perf_cpu_map__has(user_requested_cpus, this_cpu))
+		return 0;
+
+	if (event->header.type == PERF_RECORD_SCHEDSTAT_CPU) {
+		struct schedstat_cpu *temp = zalloc(sizeof(*temp));
+
+		if (!temp)
+			return -ENOMEM;
+
+		temp->cpu_data = zalloc(sizeof(*temp->cpu_data));
+		if (!temp->cpu_data)
+			return -ENOMEM;
+
+		memcpy(temp->cpu_data, &event->schedstat_cpu, sizeof(*temp->cpu_data));
+
+		if (!list_empty(&cpu_head) && temp->cpu_data->cpu == initial_cpu)
+			after_workload_flag = true;
+
+		if (!after_workload_flag) {
+			if (list_empty(&cpu_head))
+				initial_cpu = temp->cpu_data->cpu;
+
+			list_add_tail(&temp->cpu_list, &cpu_head);
+			INIT_LIST_HEAD(&temp->domain_head);
+		} else {
+			if (temp->cpu_data->cpu == initial_cpu) {
+				cpu_second_pass = list_first_entry(&cpu_head, struct schedstat_cpu,
+								   cpu_list);
+				cpu_second_pass->cpu_data->timestamp =
+					temp->cpu_data->timestamp - cpu_second_pass->cpu_data->timestamp;
+			} else {
+				cpu_second_pass = list_next_entry(cpu_second_pass, cpu_list);
+			}
+			domain_second_pass = list_first_entry(&cpu_second_pass->domain_head,
+							      struct schedstat_domain, domain_list);
+			store_schedtstat_cpu_diff(temp);
+			free(temp);
+		}
+	} else if (event->header.type == PERF_RECORD_SCHEDSTAT_DOMAIN) {
+		struct schedstat_cpu *cpu_tail;
+		struct schedstat_domain *temp = zalloc(sizeof(*temp));
+
+		if (!temp)
+			return -ENOMEM;
+
+		temp->domain_data = zalloc(sizeof(*temp->domain_data));
+		if (!temp->domain_data)
+			return -ENOMEM;
+
+		memcpy(temp->domain_data, &event->schedstat_domain, sizeof(*temp->domain_data));
+
+		if (!after_workload_flag) {
+			cpu_tail = list_last_entry(&cpu_head, struct schedstat_cpu, cpu_list);
+			list_add_tail(&temp->domain_list, &cpu_tail->domain_head);
+		} else {
+			store_schedstat_domain_diff(temp);
+			domain_second_pass = list_next_entry(domain_second_pass, domain_list);
+			free(temp);
+		}
+	}
+
+	return 0;
+}
+
+static void free_schedstat(struct list_head *head)
+{
+	struct schedstat_domain *dptr, *n1;
+	struct schedstat_cpu *cptr, *n2;
+
+	list_for_each_entry_safe(cptr, n2, head, cpu_list) {
+		list_for_each_entry_safe(dptr, n1, &cptr->domain_head, domain_list) {
+			list_del_init(&dptr->domain_list);
+			free(dptr);
+		}
+		list_del_init(&cptr->cpu_list);
+		free(cptr);
+	}
+}
+
+static int perf_sched__schedstat_report(struct perf_sched *sched)
+{
+	struct cpu_domain_map **cd_map;
+	struct perf_session *session;
+	struct target target = {};
+	struct perf_data data = {
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+	};
+	int err = 0;
+
+	sched->tool.schedstat_cpu = perf_sched__process_schedstat;
+	sched->tool.schedstat_domain = perf_sched__process_schedstat;
+
+	session = perf_session__new(&data, &sched->tool);
+	if (IS_ERR(session)) {
+		pr_err("Perf session creation failed.\n");
+		return PTR_ERR(session);
+	}
+
+	if (cpu_list)
+		target.cpu_list = cpu_list;
+	else
+		target.system_wide = true;
+
+	err = evlist__create_maps(session->evlist, &target);
+	if (err < 0)
+		goto out;
+
+	user_requested_cpus = session->evlist->core.user_requested_cpus;
+
+	err = perf_session__process_events(session);
+
+	if (!err) {
+		setup_pager();
+
+		if (list_empty(&cpu_head)) {
+			pr_err("Data is not available\n");
+			err = -1;
+			goto out;
+		}
+
+		cd_map = session->header.env.cpu_domain;
+		err = show_schedstat_data(&cpu_head, cd_map);
+	}
+
+out:
+	free_schedstat(&cpu_head);
+	perf_session__delete(session);
+	return err;
+}
+
 static bool schedstat_events_exposed(void)
 {
 	/*
@@ -4117,9 +4616,12 @@ int cmd_sched(int argc, const char **argv)
 	OPT_PARENT(sched_options)
 	};
 	const struct option stats_options[] = {
+	OPT_STRING('i', "input", &input_name, "file",
+		   "`stats report` with input filename"),
 	OPT_STRING('o', "output", &output_name, "file",
 		   "`stats record` with output filename"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
+	OPT_BOOLEAN('v', "verbose", &verbose_field, "Show explanation for fields in the report"),
 	OPT_END()
 	};
 
@@ -4244,7 +4746,7 @@ int cmd_sched(int argc, const char **argv)
 		if (!ret)
 			ret = perf_sched__timehist(&sched);
 	} else if (!strcmp(argv[0], "stats")) {
-		const char *const stats_subcommands[] = {"record", NULL};
+		const char *const stats_subcommands[] = {"record", "report", NULL};
 
 		argc = parse_options_subcommand(argc, argv, stats_options,
 						stats_subcommands,
@@ -4256,6 +4758,11 @@ int cmd_sched(int argc, const char **argv)
 				argc = parse_options(argc, argv, stats_options,
 						     stats_usage, 0);
 			return perf_sched__schedstat_record(&sched, argc, argv);
+		} else if (argv[0] && !strcmp(argv[0], "report")) {
+			if (argc)
+				argc = parse_options(argc, argv, stats_options,
+						     stats_usage, 0);
+			return perf_sched__schedstat_report(&sched);
 		}
 		usage_with_options(stats_usage, stats_options);
 	} else {
-- 
2.43.0


