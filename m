Return-Path: <linux-kernel+bounces-785976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC8BB35315
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7864124196E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F32E7F16;
	Tue, 26 Aug 2025 05:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZuvACJr+"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E09F1A23B9;
	Tue, 26 Aug 2025 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185260; cv=fail; b=N7AkkCQbN8TJNpqwvDSqRFhLmcBesBruJAH8dXe49JyUTOssH6vVphwzn3VDrlyNFayhS5L/MqgchDi1K6GOe96mq7g+zD008efaARfHPfvm0kVpXP18voXmqz7ukjpCbcmp26qVKx4lvBhb3NwKZKfD5ulSO094UbBo1dkfSD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185260; c=relaxed/simple;
	bh=oJxD9HD7rdyJGgnHN2gjkU3Lff8G/dTRLSuyQK3Z/Zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1EpCb/Frs0WxHdeF00/R4xbXALb+6KXLULF1iJ7HSXRq35ry67SGc76Elq6qyNsDBbIVrQDTnOCJXjYt88mWYO8IUKmvheoJmpTew15gWtKQu17QRKxEAZquQKW8JG9nWjPcqtpiIyAidGaQluCiE3k2N7mCaMxfkxEx2pEa1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZuvACJr+; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqBvXDV8J+lby6eyT6D9QB1D9m0WEoMEF7Q/GqumvpsvxbWj1l+d00c3mVMqaDfXbX2qjkyy5san7vFV9BgDT286blgKKp63fEnNqTnCMNRU7je4Li8w8Rle7zX9n2MnpAjq2SpxIyHdaEu5BWzJbmKiPB7HXMH6TtR6X+g09JnMvKGyB3nlU8+dPGvS6USJ6v8ZHUyohOVRK1eTdXm1aZXYXi3wCSArmO240HomP8cxnx5OkhJHyKo6WTPwBiK7X/kYtgUiGRECBotYPcbHA1iVw4mMNx3zSngSSnDZJRX50iW+VdtwWXK3E9e5WIePG9pzjJevKaqglbOCJtkang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuH4Jc2ohVg1C3/9sqpJ9GnIhkjwQPX1zsqKJUfarPQ=;
 b=AVUXZlb4nV3bzwTlDe36bUu2bDlJF2QbcVf7dFoZEuG/PcnImktP+oDLs7xRUJr2hWuadq8SBcPI8L/U41AkgIisqTIaIl0dl+0qOCdXw4W3+cjemZoe0MebU2zLAoBXRe/6dUNqVDy+JHhtRYQ8xfHDP/lazExXBLf7qKNI4IDQaj0mCjp1EXoPPfoipSwRtuieXV9DeDGicplLwIdfwH61f2xvwcdAzg4v1cOJ4n7M2G+vCtwkqIYnKhbibGdSIH1Eoip3esX1kydf4A6S25J9ycup74bw5BH/tV3ieVE5XZ9c6rEKldtaaKooTbPFHUQ10lZADtHnqZC6wcMtwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuH4Jc2ohVg1C3/9sqpJ9GnIhkjwQPX1zsqKJUfarPQ=;
 b=ZuvACJr+CBEp+M7jkmQUjXFLndnCRuYhQbsOhTd7LgI/ychLkTV1v/XwDg8Wv20olr5G1fcAYO2lX3GXdGCno/pa88usCoV57iR74d0nIbvwwC6qRXyFvC0n9FSIglpO/sm6zqOtevgjY+WO5wBZXvZvqobJAkNB86EdTP05RVQ=
Received: from MW4PR04CA0135.namprd04.prod.outlook.com (2603:10b6:303:84::20)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Tue, 26 Aug 2025 05:14:13 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::18) by MW4PR04CA0135.outlook.office365.com
 (2603:10b6:303:84::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 05:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:14:12 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:14:06 -0500
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
Subject: [PATCH v4 08/11] perf sched stats: Add support for live mode
Date: Tue, 26 Aug 2025 05:10:36 +0000
Message-ID: <20250826051039.2626894-9-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b00340-63a5-43fb-8715-08dde45f6557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QUpV3i7gfqyOmQsB0c+xFuzW11z8xpQtIKwMyZ1P4TJBu3YDRZHvtBYB+WGQ?=
 =?us-ascii?Q?6zcUSFytH5DDVNsLNzldQVnSO74ztIaWA4cmmPmQK7UELXcfqmgAe/LWKknB?=
 =?us-ascii?Q?tQYH5gqnVyyEqjr/iyVXuqRXjbOa5XRIWzVQtqlK65LoZNdgTYcG6IQbspsm?=
 =?us-ascii?Q?ZWLf4hJ2uQC5Z6pJCpFWQ1IyZYK+eGG7m5VY/1pY9/ROzVj9La5OJJ5SzYd7?=
 =?us-ascii?Q?HZhUaRVydvhsR6iBUs43U5qGgwXl/PPfXP5L7rd63rj+5w3jU8i9iDt8gWP3?=
 =?us-ascii?Q?VDsosLX8cQosqmmXa8zynocXA4dYwK0QXJOI3Cp8fW0UwnagkAnbSmrIGXlJ?=
 =?us-ascii?Q?PQKZEXSKZp7MOzwzGvRBxri3hF8jAFlHNX18vajgQfYg7+08zOaamuglx6De?=
 =?us-ascii?Q?u3jSPG+G9ZzhkDNThgaPEfQ6XtbJ7F/MhBBxRD00XPg/wb/coCNm8rCCzQxu?=
 =?us-ascii?Q?5ht6ceE9hD9a57+BsxqI+RD7cHl2J+E0O39pCkgU2KbNFbDkpSCHTXX1k95x?=
 =?us-ascii?Q?hx7p17QmIhfg+B0Tc0c6T78QEUIGjQfiIkGnrf4bb2uPwDfSKdGHtPSQIuwg?=
 =?us-ascii?Q?wSzW030jXYxwn/byg4nsME0rEUY2Jtmb3Xx4W6MpdjEey9zGIyChnhIwXSqn?=
 =?us-ascii?Q?XdkrqdD9f7JKFrZ3v/lgw+n0yLq/SQw9bVKhbMSWjrb+wm5V0GXd6brAJ+Rq?=
 =?us-ascii?Q?BluyducGVXGWcYpZRam0AxZie5XXl6QT+rLDKoJ9Tf7sEPtjm1pLge27BoCs?=
 =?us-ascii?Q?IqrMPyDr+kLZt4grAUXEyXcadzrvmCdLklKOI2ezYlmhG8t75Wt7vg86qcHL?=
 =?us-ascii?Q?RPcV9XNzkB8bhAUkA5KO8OMXB/GOn2MrLvxvh9w1vVBidtN3vUxaWqxkxtj6?=
 =?us-ascii?Q?Fe3k/QkXoangtWiAAVjgNsMC37BPM6vP3TOIxk+Wb+sbWwQICgp6HfC6xEOa?=
 =?us-ascii?Q?QVNfZmUQkMsBCazBb1PxdRbSYsije6uDHiLBjF9qcXOD9WVTeElXCT7PlTPS?=
 =?us-ascii?Q?L1RgwiwZvs8b/MfnScqqdz9YhxrNB+XfjkE4gWP5274dZ361fNA8jRtRMapM?=
 =?us-ascii?Q?WIXf6SRaQaLAXsxoCtl5IN9On2XRhCDOOIOkYjBEO8CCk7m6UkDjjK9BX5+X?=
 =?us-ascii?Q?/EGncRQsnRLqzpJWP+UtzWnwUZ54XZGFND7IULsCMGS/4q28J7ZVXU1AFEaB?=
 =?us-ascii?Q?9vERYuAmmGVvGOPW2s0t/UvNM5PohD5Bauxqo2uv1f6yQfnbNp0mUa1VAsO1?=
 =?us-ascii?Q?XQCs6sN2Znf6A6g3DDx9XaJJk5y2/EnxdnOqtzH+UVqMsSvEi69U05MKa0d7?=
 =?us-ascii?Q?fhQWP6XBEb0WbtoDaERV1Fg7KvZoPUvTWMSDMmUe3j953OyMjsQM4tfROxPO?=
 =?us-ascii?Q?op9f2/+WOlQk3cwYUV1q9lMZUdGXeOg/2V9Bi3cmzMSgHdw20YhPAac5H2hn?=
 =?us-ascii?Q?AfZzyauU2iGF1UMZp9WL4lHOdMgjYQkH0ecuJQ18KGTsV8nURF/nEXxxnXz+?=
 =?us-ascii?Q?geioX2o6Dm4V5tery/1ySuT1QRQUH2/ITHS0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:14:12.8435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b00340-63a5-43fb-8715-08dde45f6557
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096

The live mode works similar to simple `perf stat` command, by profiling
the target and printing results on the terminal as soon as the target
finishes.

Example usage:

  # perf sched stats -- sleep 10

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 99 +++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.c   |  6 +--
 tools/perf/util/header.h   |  5 ++
 3 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index e23018798f5b..ce04349cc4ff 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4439,6 +4439,103 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 	return err;
 }
 
+static int process_synthesized_event_live(const struct perf_tool *tool __maybe_unused,
+					  union perf_event *event,
+					  struct perf_sample *sample __maybe_unused,
+					  struct machine *machine __maybe_unused)
+{
+	return perf_sched__process_schedstat(NULL, event);
+}
+
+static int perf_sched__schedstat_live(struct perf_sched *sched,
+				      int argc, const char **argv)
+{
+	struct cpu_domain_map **cd_map = NULL;
+	struct target target = {};
+	u32 __maybe_unused md;
+	struct evlist *evlist;
+	u32 nr = 0, sv;
+	int reset = 0;
+	int err = 0;
+
+	signal(SIGINT, sighandler);
+	signal(SIGCHLD, sighandler);
+	signal(SIGTERM, sighandler);
+
+	evlist = evlist__new();
+	if (!evlist)
+		return -ENOMEM;
+
+	/*
+	 * `perf sched schedstat` does not support workload profiling (-p pid)
+	 * since /proc/schedstat file contains cpu specific data only. Hence, a
+	 * profile target is either set of cpus or systemwide, never a process.
+	 * Note that, although `-- <workload>` is supported, profile data are
+	 * still cpu/systemwide.
+	 */
+	if (cpu_list)
+		target.cpu_list = cpu_list;
+	else
+		target.system_wide = true;
+
+	if (argc) {
+		err = evlist__prepare_workload(evlist, &target, argv, false, NULL);
+		if (err)
+			goto out;
+	}
+
+	err = evlist__create_maps(evlist, &target);
+	if (err < 0)
+		goto out;
+
+	user_requested_cpus = evlist->core.user_requested_cpus;
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_event_live,
+					       user_requested_cpus);
+	if (err < 0)
+		goto out;
+
+	err = enable_sched_schedstats(&reset);
+	if (err < 0)
+		goto out;
+
+	if (argc)
+		evlist__start_workload(evlist);
+
+	/* wait for signal */
+	pause();
+
+	if (reset) {
+		err = disable_sched_schedstat();
+		if (err < 0)
+			goto out;
+	}
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_event_live,
+					       user_requested_cpus);
+	if (err)
+		goto out;
+
+	setup_pager();
+
+	if (list_empty(&cpu_head)) {
+		pr_err("Data is not available\n");
+		err = -1;
+		goto out;
+	}
+
+	nr = cpu__max_present_cpu().cpu;
+	cd_map = build_cpu_domain_map(&sv, &md, nr);
+	show_schedstat_data(&cpu_head, cd_map);
+out:
+	free_cpu_domain_info(cd_map, sv, nr);
+	free_schedstat(&cpu_head);
+	evlist__delete(evlist);
+	return err;
+}
+
 static bool schedstat_events_exposed(void)
 {
 	/*
@@ -4764,7 +4861,7 @@ int cmd_sched(int argc, const char **argv)
 						     stats_usage, 0);
 			return perf_sched__schedstat_report(&sched);
 		}
-		usage_with_options(stats_usage, stats_options);
+		return perf_sched__schedstat_live(&sched, argc, argv);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7ff7434bac2c..e8f4d00b5261 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1621,7 +1621,7 @@ static int write_pmu_caps(struct feat_fd *ff,
 	return 0;
 }
 
-static void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr)
+void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr)
 {
 	for (u32 i = 0; i < nr; i++) {
 		if (cd_map[i]->domains) {
@@ -1641,8 +1641,8 @@ static void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_v
 	free(cd_map);
 }
 
-static struct cpu_domain_map  **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
-						     u32 nr)
+struct cpu_domain_map  **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
+					      u32 nr)
 {
 	struct domain_info *domain_info;
 	struct cpu_domain_map **cd_map;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index edcb95e0dc49..d67d26dad88e 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -209,4 +209,9 @@ char *get_cpuid_str(struct perf_cpu cpu);
 char *get_cpuid_allow_env_override(struct perf_cpu cpu);
 
 int strcmp_cpuid_str(const char *s1, const char *s2);
+
+struct cpu_domain_map  **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
+					      u32 nr);
+
+void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr);
 #endif /* __PERF_HEADER_H */
-- 
2.43.0


