Return-Path: <linux-kernel+bounces-785977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAD1B35318
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0991F1B261F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A968E2BDC25;
	Tue, 26 Aug 2025 05:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1v6KHbPL"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020A284678;
	Tue, 26 Aug 2025 05:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185281; cv=fail; b=cUgptQVmOcg4JTZwLS2EzQzsXdDLx96L2MFizeH1VjJPLT8cc37+vHRyQ3tK68YvP58ACXQLoJiUlCuqzPwujDfdbiHi7pmfkHIgoJoRP5vIHQQifG1Ul5wp71SCj/rtFOvdTcIXrRU9VG7CbdD+4KM/rHtl9y7ytWTDcoOFAUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185281; c=relaxed/simple;
	bh=SBsqX4CeInj4sWuL7kZmsQuwMKuDg09fvMlG1BX+VWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owuEJXTJbiecbfJe03lwHYKwGgmlV/w9cThsFlyEFVgAQTfPSMMD8HWemyH45jBgIQfTaV9YF+oL9Rzx+dh75naSnfeKpL/SCIXhBg6lhdPQhSwDlgK86Zpw3XYWKXVrdCHzKhENnY+eRF/c4Ka7a4+hAz0u6IP/jaaWiEbBzfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1v6KHbPL; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgwrcRAQAOPnr11gH1xAqJmH93BdNGDX5usKszEuKQdrAYbQc/ZTu0vHQ8zLic7hDDo+sptykoW0LrM0TdnHz8JlTIwH5tVBuQEXs0+wY/Z9fEYbLASHdfQyAiZtOsB9IIMoaeVFK7wrR3tSjYOTKdOtk5lCcgYOEmLWOjws7nladzVEEIXNHsg7X7N3tdvuKsoo21LbdIpDSVP3MAWuFTUACr2HEBWSVgQJdDfEZn3/uEuiYKojjUgrl0lVsv/jP7loT3ZU8rzcKO5WmNKa6jWzYrVK9gauSh2DvEyDjyyijKIDvJosVuHju+37tVzFYJ71FsCmLmcfGC+EsjjbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIE5Gw/1BIn5T1u0lQSCQIA2+Z8heWmoReYZku0YHWc=;
 b=TRQVcvH+QkdQOqe8hnLr4Ji3MPycgKlWLK/BHrBhQ6pF2p3fOgTosujyF137/GlU0U913uGUWLOJsmLdro3EVYsQz4Cy9bxLf4R5apkmnm5mT6Ls88qI4xprMR00L9VPOSEYLd2d48Zly2g1VvWUniucwKLhwz847S5heOdK7HH0OYhKM/Sx/gF8+lV5kalsI1ttHSO4SPyKSWRAlyMGjdb6/x7YMFGKHaVmTJ+R0owTJ2MStJ0tBUMtB9wgGYcYJ8GfR9S12eeYhh7QC33xd2ml4PFqZwIgZ+7qf2Z2eQhNigOK3Kq7nDHPVMwaTxl0RXjjHWyTQ4S+81LtKQlFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIE5Gw/1BIn5T1u0lQSCQIA2+Z8heWmoReYZku0YHWc=;
 b=1v6KHbPL5aNlrWO87g5OReBen2V4L0Zn/4gSoEMBak7Jtv+O0wSjLdSqcKi7NQXbj+vRBaOQvZLNxvxnCd4SxBGOXfHwDc/lQixpWiAl6eKAAfNXNKzrXvsL3GfzHWyYYFsQRXWCzjgwJdq82V1hoNrBn7EUTBtBhv3W26O1Peo=
Received: from SJ0PR03CA0161.namprd03.prod.outlook.com (2603:10b6:a03:338::16)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 05:14:34 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::57) by SJ0PR03CA0161.outlook.office365.com
 (2603:10b6:a03:338::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Tue,
 26 Aug 2025 05:14:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:14:33 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:14:27 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <corbet@lwn.net>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <iamjoonsoo.kim@lge.com>,
	<qyousef@layalina.io>, <sshegde@linux.ibm.com>, <alexs@kernel.org>,
	<lukasz.luba@arm.com>, <cpru@amazon.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v4 09/11] perf sched stats: Add support for diff subcommand
Date: Tue, 26 Aug 2025 05:10:37 +0000
Message-ID: <20250826051039.2626894-10-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a20f596-e8e6-4479-844e-08dde45f71d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FDMCHFTo5O2yKc4WT9Fc90AiLLHCMmCeGLisnLeZKw1RHDzHEftajke6M1Am?=
 =?us-ascii?Q?GHQn823nK12vcyCMM/jWsfhXDt9vwME3jJIaRxNCiFqCQ5LSK20R1r3dJzgg?=
 =?us-ascii?Q?OFOMRXozioGCQVuJeQZSaSOcZQ6pp8p8T6htl1e04D7FFDVhRTOVhQkhhvqW?=
 =?us-ascii?Q?0kEXVYpNtZEoKMCLqcYdPRWGv0P2m1JcZCg3XUe2qngRn21mAYWVz6m6DJu1?=
 =?us-ascii?Q?2/RrqNPLWbseqORL76Vci1kLp3C06yPnNt6EDXxY2F0PfKBM2tiNdGDRQEoW?=
 =?us-ascii?Q?at118XuuZtWNpR7Ofe/1MMH4F0DSwBm1otY919JSapdCos+wZOGCdcFEv8QX?=
 =?us-ascii?Q?AfJJakhiyAKMaibqZZGBaG7tneEfowOSRMVt4WLTbszZ4hX4uf9oJBtkHRHh?=
 =?us-ascii?Q?ysZKFlEIOh35am7hXLoCn+RiANDdlt2WqpTg7Oi3ukEFq1kZ8sz/a1D+v9hV?=
 =?us-ascii?Q?8u0CcP+ZQI6pk+mStXQd2ljGzEcx6JZHyAZmVosxJL633f7opV7zm44TZtsp?=
 =?us-ascii?Q?yl1TXoJg+msdAYVqo71gplLkv3qn3nBj68aInCuVjgkPK677A28kMEZSdZc7?=
 =?us-ascii?Q?s2cWcR/dVMRq2hf/cBUJY3+kgFr+h6fcZMroAMKjYQers751qgOafaax7CKo?=
 =?us-ascii?Q?7unDH3mwHdhwldd49RPxfpWq1+mF4sVV07CY61+jInOsmda0HjXU/OYes1fR?=
 =?us-ascii?Q?queODo9kFh3jH0aHmrXP7kt+4ocCNrx+GRNkw2xcI16JXrvAZvOr2d7TsckE?=
 =?us-ascii?Q?Ba6kMASSthXwDsChyjAmM2C9rRUVy77txQDD+nDkgICcEOjGj3fske5VMjgP?=
 =?us-ascii?Q?3JBSJ7RufSNsC9OiyNMw5DFrMYE+jqTFoKqsGZepo4hGSMw4+L/TmLXUzLn3?=
 =?us-ascii?Q?gDIvlj1dCvXsEajT8FhFV+qwOaLWWRinIHh6PC/ZpoApVbBaYA2vGFrqr0GG?=
 =?us-ascii?Q?bSl10vAeVaFH8mwaf0XdP4pj/vFKcQg/cyvC49rgEP+Lq3yjh0dNxqy2Kq8q?=
 =?us-ascii?Q?Fo+ivfGiXpW4jzjbS1wRf85Of+PkEVWa8xFbrWX0qTiNY72ng2dITLcCPpNx?=
 =?us-ascii?Q?ic3MlKkf8cnveR6EqPZdv48cayFubP1qA+GGGMUlMBOVO7AoNe9NI1Flv53i?=
 =?us-ascii?Q?iFFm0AUgJS2FANBN8KnkIGZE473VRQatyZ22lxNGK8E6NnOfjgX4REFkHf2X?=
 =?us-ascii?Q?fltUrZZK8g2nsHlitTuY/h6k+kRoIPkEuRqf+eC0U2C9mA7xBEOVP7N7rIWb?=
 =?us-ascii?Q?jRy5mwThY1jNoeYFcbdJBLkFDRrnFM5kbnR5T25zUAGLXXjf0hMF95159gm7?=
 =?us-ascii?Q?kS9h9l4+Gt36I2CXZNIZgkaMrvuSnM5n0nyyZcSCeMsl5ZrayX88FPKhV1bi?=
 =?us-ascii?Q?+wPhhINhcoXmgrOwzGBAp9wOP2yaIJEweiR8Gaepf9/4z8kCCtNgxazQpPIK?=
 =?us-ascii?Q?hN1z31tRFDfYGaMupzlc3k3RESUDOs2EtmQP+2C3DM7N14hcaNX6u5m8fIBE?=
 =?us-ascii?Q?Q5FelEZLM+dEiAqiwdfZGWpybP5mhqaXACxn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:14:33.7925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a20f596-e8e6-4479-844e-08dde45f71d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400

`perf sched stats diff` subcommand will take two perf.data files as an
input and it will print the diff between the two perf.data files. The
default input to this subcommnd is perf.data.old and perf.data.

Example usage:

 # perf sched stats diff sample1.data sample2.data

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 315 ++++++++++++++++++++++++++++++-------
 1 file changed, 258 insertions(+), 57 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index ce04349cc4ff..ebce69180330 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3996,29 +3996,46 @@ static void store_schedstat_domain_diff(struct schedstat_domain *after_workload)
 #undef DOMAIN_FIELD
 }
 
-static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
+#define PCT_CHNG(_x, _y)        ((_x) ? ((double)((double)(_y) - (_x)) / (_x)) * 100 : 0.0)
+static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs1,
+				   struct perf_record_schedstat_cpu *cs2)
 {
-	printf("%-65s %12s %12s\n", "DESC", "COUNT", "PCT_CHANGE");
-	printf("%.*s\n", 100, graph_dotted_line);
+	printf("%-65s ", "DESC");
+	if (!cs2)
+		printf("%12s %12s", "COUNT", "PCT_CHANGE");
+	else
+		printf("%12s %11s %12s %14s %10s", "COUNT1", "COUNT2", "PCT_CHANGE",
+		       "PCT_CHANGE1", "PCT_CHANGE2");
+
+	printf("\n");
+	print_separator(100, "", 0);
 
 #define CALC_PCT(_x, _y)	((_y) ? ((double)(_x) / (_y)) * 100 : 0.0)
 
-#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
-	do {									\
-		printf("%-65s: " _format, verbose_field ? _desc : #_name,	\
-		       cs->_ver._name);						\
-		if (_is_pct) {							\
-			printf("  ( %8.2lf%% )",				\
-			       CALC_PCT(cs->_ver._name, cs->_ver._pct_of));	\
-		}								\
-		printf("\n");							\
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)			\
+	do {										\
+		printf("%-65s: " _format, verbose_field ? _desc : #_name,		\
+		       cs1->_ver._name);						\
+		if (!cs2) {								\
+			if (_is_pct)							\
+				printf("  ( %8.2lf%% )",				\
+				       CALC_PCT(cs1->_ver._name, cs1->_ver._pct_of));	\
+		} else {								\
+			printf("," _format "  | %8.2lf%% |", cs2->_ver._name,		\
+			       PCT_CHNG(cs1->_ver._name, cs2->_ver._name));		\
+			if (_is_pct)							\
+				printf("  ( %8.2lf%%,  %8.2lf%% )",			\
+				       CALC_PCT(cs1->_ver._name, cs1->_ver._pct_of),	\
+				       CALC_PCT(cs2->_ver._name, cs2->_ver._pct_of));	\
+		}									\
+		printf("\n");								\
 	} while (0)
 
-	if (cs->version == 15) {
+	if (cs1->version == 15) {
 #include <perf/schedstat-v15.h>
-	} else if (cs->version == 16) {
+	} else if (cs1->version == 16) {
 #include <perf/schedstat-v16.h>
-	} else if (cs->version == 17) {
+	} else if (cs1->version == 17) {
 #include <perf/schedstat-v17.h>
 	}
 
@@ -4026,10 +4043,17 @@ static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
 #undef CALC_PCT
 }
 
-static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
-				      __u64 jiffies)
+static inline void print_domain_stats(struct perf_record_schedstat_domain *ds1,
+				      struct perf_record_schedstat_domain *ds2,
+				      __u64 jiffies1, __u64 jiffies2)
 {
-	printf("%-65s %12s %14s\n", "DESC", "COUNT", "AVG_JIFFIES");
+	printf("%-65s ", "DESC");
+	if (!ds2)
+		printf("%12s %14s", "COUNT", "AVG_JIFFIES");
+	else
+		printf("%12s %11s %12s %16s %12s", "COUNT1", "COUNT2", "PCT_CHANGE",
+		       "AVG_JIFFIES1", "AVG_JIFFIES2");
+	printf("\n");
 
 #define DOMAIN_CATEGORY(_desc)							\
 	do {									\
@@ -4044,28 +4068,54 @@ static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
 #define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
 	do {									\
 		printf("%-65s: " _format, verbose_field ? _desc : #_name,	\
-		       ds->_ver._name);						\
-		if (_is_jiffies) {						\
-			printf("  $ %11.2Lf $",					\
-			       CALC_AVG(jiffies, ds->_ver._name));		\
+		       ds1->_ver._name);					\
+		if (!ds2) {							\
+			if (_is_jiffies)					\
+				printf("  $ %11.2Lf $",				\
+				       CALC_AVG(jiffies1, ds1->_ver._name));	\
+		} else {							\
+			printf("," _format "  | %8.2lf%% |", ds2->_ver._name,	\
+			       PCT_CHNG(ds1->_ver._name, ds2->_ver._name));	\
+			if (_is_jiffies)					\
+				printf("  $ %11.2Lf, %11.2Lf $",		\
+				       CALC_AVG(jiffies1, ds1->_ver._name),	\
+				       CALC_AVG(jiffies2, ds2->_ver._name));	\
 		}								\
 		printf("\n");							\
 	} while (0)
 
 #define DERIVED_CNT_FIELD(_name, _desc, _format, _x, _y, _z, _ver)		\
-	printf("*%-64s: " _format "\n", verbose_field ? _desc : #_name,		\
-	       (ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))
+	do {									\
+		__u32 t1 = ds1->_ver._x - ds1->_ver._y - ds1->_ver._z;		\
+		printf("*%-64s: " _format, verbose_field ? _desc : #_name, t1);	\
+		if (ds2) {							\
+			__u32 t2 = ds2->_ver._x - ds2->_ver._y - ds2->_ver._z;	\
+			printf("," _format "  | %8.2lf%% |", t2,		\
+			       PCT_CHNG(t1, t2));				\
+		}								\
+		printf("\n");							\
+	} while (0)
 
 #define DERIVED_AVG_FIELD(_name, _desc, _format, _x, _y, _z, _w, _ver)		\
-	printf("*%-64s: " _format "\n", verbose_field ? _desc : #_name,		\
-	       CALC_AVG(ds->_ver._w,						\
-			((ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))))
+	do {									\
+		__u32 t1 = ds1->_ver._x - ds1->_ver._y - ds1->_ver._z;		\
+		printf("*%-64s: " _format, verbose_field ? _desc : #_name,	\
+		       CALC_AVG(ds1->_ver._w, t1));				\
+		if (ds2) {							\
+			__u32 t2 = ds2->_ver._x - ds2->_ver._y - ds2->_ver._z;	\
+			printf("," _format "  | %8.2Lf%% |",			\
+			       CALC_AVG(ds2->_ver._w, t2),			\
+			       PCT_CHNG(CALC_AVG(ds1->_ver._w, t1),		\
+					CALC_AVG(ds2->_ver._w, t2)));		\
+		}								\
+		printf("\n");							\
+	} while (0)
 
-	if (ds->version == 15) {
+	if (ds1->version == 15) {
 #include <perf/schedstat-v15.h>
-	} else if (ds->version == 16) {
+	} else if (ds1->version == 16) {
 #include <perf/schedstat-v16.h>
-	} else if (ds->version == 17) {
+	} else if (ds1->version == 17) {
 #include <perf/schedstat-v17.h>
 	}
 
@@ -4075,6 +4125,7 @@ static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
 #undef CALC_AVG
 #undef DOMAIN_CATEGORY
 }
+#undef PCT_CHNG
 
 static void summarize_schedstat_cpu(struct schedstat_cpu *summary_cpu,
 				    struct schedstat_cpu *cptr,
@@ -4219,13 +4270,16 @@ static void print_field_description(struct schedstat_cpu *cptr)
 #undef DOMAIN_FIELD
 }
 
-static int show_schedstat_data(struct list_head *head, struct cpu_domain_map **cd_map)
+static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **cd_map1,
+			       struct list_head *head2, struct cpu_domain_map **cd_map2,
+			       bool summary_only)
 {
-	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
-	__u64 jiffies = cptr->cpu_data->timestamp;
-	struct perf_record_schedstat_domain *ds;
-	struct perf_record_schedstat_cpu *cs;
-	struct schedstat_domain *dptr;
+	struct schedstat_cpu *cptr1 = list_first_entry(head1, struct schedstat_cpu, cpu_list);
+	struct perf_record_schedstat_domain *ds1 = NULL, *ds2 = NULL;
+	struct perf_record_schedstat_cpu *cs1 = NULL, *cs2 = NULL;
+	struct schedstat_domain *dptr1 = NULL, *dptr2 = NULL;
+	struct schedstat_cpu *cptr2 = NULL;
+	__u64 jiffies1 = 0, jiffies2 = 0;
 	bool is_summary = true;
 	int ret = 0;
 
@@ -4239,53 +4293,103 @@ static int show_schedstat_data(struct list_head *head, struct cpu_domain_map **c
 
 	if (!verbose_field) {
 		print_separator(100, "", 0);
-		print_field_description(cptr);
+		print_field_description(cptr1);
 	}
 
 	print_separator(100, "", 0);
 	printf("\n");
 
-	printf("%-65s: %11llu\n", "Time elapsed (in jiffies)", jiffies);
+	printf("%-65s: ", "Time elapsed (in jiffies)");
+	jiffies1 = cptr1->cpu_data->timestamp;
+	printf("%11llu", jiffies1);
+	if (head2) {
+		cptr2 = list_first_entry(head2, struct schedstat_cpu, cpu_list);
+		jiffies2 = cptr2->cpu_data->timestamp;
+		printf(",%11llu", jiffies2);
+	}
+	printf("\n");
+
 	print_separator(100, "", 0);
 
-	ret = get_all_cpu_stats(head);
+	ret = get_all_cpu_stats(head1);
+	if (cptr2)
+		ret = get_all_cpu_stats(head2);
+
+	list_for_each_entry(cptr1, head1, cpu_list) {
+		struct cpu_domain_map *cd_info1 = NULL, *cd_info2 = NULL;
+
+		cs1 = cptr1->cpu_data;
+		cd_info1 = cd_map1[cs1->cpu];
+		if (cptr2) {
+			cs2 = cptr2->cpu_data;
+			cd_info2 = cd_map2[cs2->cpu];
+			dptr2 = list_first_entry(&cptr2->domain_head, struct schedstat_domain,
+						 domain_list);
+		}
+
+		if (cs2 && cs1->cpu != cs2->cpu) {
+			pr_err("Failed because matching cpus not found for diff\n");
+			return -1;
+		}
+
+		if (cd_info2 && cd_info1->nr_domains != cd_info2->nr_domains) {
+			pr_err("Failed because nr_domains is not same for cpus\n");
+			return -1;
+		}
 
-	list_for_each_entry(cptr, head, cpu_list) {
-		cs = cptr->cpu_data;
 		printf("\n");
 		print_separator(100, "", 0);
 
 		if (is_summary)
 			printf("CPU <ALL CPUS SUMMARY>\n");
 		else
-			printf("CPU %d\n", cs->cpu);
+			printf("CPU %d\n", cs1->cpu);
 
 		print_separator(100, "", 0);
-		print_cpu_stats(cs);
+		print_cpu_stats(cs1, cs2);
 		print_separator(100, "", 0);
 
-		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
-			struct domain_info *dinfo;
+		list_for_each_entry(dptr1, &cptr1->domain_head, domain_list) {
+			struct domain_info *dinfo1 = NULL, *dinfo2 = NULL;
+
+			ds1 = dptr1->domain_data;
+			dinfo1 = cd_info1->domains[ds1->domain];
+			if (dptr2) {
+				ds2 = dptr2->domain_data;
+				dinfo2 = cd_info2->domains[ds2->domain];
+			}
+
+			if (dinfo2 && dinfo1->domain != dinfo2->domain) {
+				pr_err("Failed because matching domain not found for diff\n");
+				return -1;
+			}
 
-			ds = dptr->domain_data;
-			dinfo = cd_map[ds->cpu]->domains[ds->domain];
 			if (is_summary)
-				if (dinfo->dname)
-					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %s\n", dinfo->dname);
+				if (dinfo1->dname)
+					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %s\n", dinfo1->dname);
 				else
-					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %d\n", dinfo->domain);
+					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %d\n", dinfo1->domain);
 			else {
-				if (dinfo->dname)
-					printf("CPU %d, DOMAIN %s CPUS ", cs->cpu, dinfo->dname);
+				if (dinfo1->dname)
+					printf("CPU %d, DOMAIN %s CPUS ", cs1->cpu, dinfo1->dname);
 				else
-					printf("CPU %d, DOMAIN %d CPUS ", cs->cpu, dinfo->domain);
+					printf("CPU %d, DOMAIN %d CPUS ", cs1->cpu, dinfo1->domain);
 
-				printf("%s\n", dinfo->cpulist);
+				printf("%s\n", dinfo1->cpulist);
 			}
 			print_separator(100, "", 0);
-			print_domain_stats(ds, jiffies);
+			print_domain_stats(ds1, ds2, jiffies1, jiffies2);
 			print_separator(100, "", 0);
+
+			if (dptr2)
+				dptr2 = list_next_entry(dptr2, domain_list);
 		}
+		if (summary_only)
+			break;
+
+		if (cptr2)
+			cptr2 = list_next_entry(cptr2, cpu_list);
+
 		is_summary = false;
 	}
 	return ret;
@@ -4430,7 +4534,7 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 		}
 
 		cd_map = session->header.env.cpu_domain;
-		err = show_schedstat_data(&cpu_head, cd_map);
+		err = show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
 	}
 
 out:
@@ -4439,6 +4543,98 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 	return err;
 }
 
+static int perf_sched__schedstat_diff(struct perf_sched *sched,
+				      int argc, const char **argv)
+{
+	struct list_head *cpu_head_ses0 = NULL, *cpu_head_ses1 = NULL;
+	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
+	struct perf_session *session[2];
+	struct perf_data data[2];
+	int ret = 0, err = 0;
+	static const char *defaults[] = {
+		"perf.data.old",
+		"perf.data",
+	};
+
+	if (argc) {
+		if (argc == 1)
+			defaults[1] = argv[0];
+		else if (argc == 2) {
+			defaults[0] = argv[0];
+			defaults[1] = argv[1];
+		} else {
+			pr_err("perf sched stats diff is not supported with more than 2 files.\n");
+			goto out_ret;
+		}
+	}
+
+	sched->tool.schedstat_cpu = perf_sched__process_schedstat;
+	sched->tool.schedstat_domain = perf_sched__process_schedstat;
+
+	data[0].path = defaults[0];
+	data[0].mode  = PERF_DATA_MODE_READ;
+	session[0] = perf_session__new(&data[0], &sched->tool);
+	if (IS_ERR(session[0])) {
+		ret = PTR_ERR(session[0]);
+		pr_err("Failed to open %s\n", data[0].path);
+		goto out_delete_ses0;
+	}
+
+	err = perf_session__process_events(session[0]);
+	if (err)
+		goto out_delete_ses0;
+
+	cd_map0 = session[0]->header.env.cpu_domain;
+	cpu_head_ses0 = &cpu_head;
+	after_workload_flag = false;
+	INIT_LIST_HEAD(&cpu_head);
+
+	data[1].path = defaults[1];
+	data[1].mode  = PERF_DATA_MODE_READ;
+	session[1] = perf_session__new(&data[1], &sched->tool);
+	if (IS_ERR(session[1])) {
+		ret = PTR_ERR(session[1]);
+		pr_err("Failed to open %s\n", data[1].path);
+		goto out_delete_ses1;
+	}
+
+	err = perf_session__process_events(session[1]);
+	if (err)
+		goto out_delete_ses1;
+
+	cd_map1 = session[1]->header.env.cpu_domain;
+	cpu_head_ses1 = &cpu_head;
+	after_workload_flag = false;
+	setup_pager();
+
+	if (list_empty(cpu_head_ses1)) {
+		pr_err("Data is not available\n");
+		ret = -1;
+		goto out_delete_ses1;
+	}
+
+	if (list_empty(cpu_head_ses0)) {
+		pr_err("Data is not available\n");
+		ret = -1;
+		goto out_delete_ses0;
+	}
+
+	show_schedstat_data(cpu_head_ses0, cd_map0, cpu_head_ses1, cd_map1, true);
+
+out_delete_ses1:
+	free_schedstat(cpu_head_ses1);
+	if (!IS_ERR(session[1]))
+		perf_session__delete(session[1]);
+
+out_delete_ses0:
+	free_schedstat(cpu_head_ses0);
+	if (!IS_ERR(session[0]))
+		perf_session__delete(session[0]);
+
+out_ret:
+	return ret;
+}
+
 static int process_synthesized_event_live(const struct perf_tool *tool __maybe_unused,
 					  union perf_event *event,
 					  struct perf_sample *sample __maybe_unused,
@@ -4528,7 +4724,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 
 	nr = cpu__max_present_cpu().cpu;
 	cd_map = build_cpu_domain_map(&sv, &md, nr);
-	show_schedstat_data(&cpu_head, cd_map);
+	show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
 out:
 	free_cpu_domain_info(cd_map, sv, nr);
 	free_schedstat(&cpu_head);
@@ -4860,6 +5056,11 @@ int cmd_sched(int argc, const char **argv)
 				argc = parse_options(argc, argv, stats_options,
 						     stats_usage, 0);
 			return perf_sched__schedstat_report(&sched);
+		} else if (argv[0] && !strcmp(argv[0], "diff")) {
+			if (argc)
+				argc = parse_options(argc, argv, stats_options,
+						     stats_usage, 0);
+			return perf_sched__schedstat_diff(&sched, argc, argv);
 		}
 		return perf_sched__schedstat_live(&sched, argc, argv);
 	} else {
-- 
2.43.0


