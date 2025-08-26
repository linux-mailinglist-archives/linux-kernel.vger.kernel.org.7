Return-Path: <linux-kernel+bounces-785979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C7B3531C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9377B19DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E532E7F3A;
	Tue, 26 Aug 2025 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wMhdVVEy"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63F2D738F;
	Tue, 26 Aug 2025 05:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185328; cv=fail; b=KKBaDhLILlzYCLWs1qtj7+V4ES9++nrFAO12ppwf9up50uz3nzwTgrx9ackDr/2rZrHncoRcJnJFZ3EiR6tvmSg5Y5SU/3jRN8taYxgrvoMbSGfJvXUJ66mLdvt8NCtGwXD0JrhkVwieTxgOXvO4EMabOgxLWLMYKN2HJ6Xr2Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185328; c=relaxed/simple;
	bh=gqAZxoZKLiec3qn/670jAHkQUcHad5CAYPsvx7cZ5xo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRwSuHgNnM2nDyglFnxHlUfa24LIUboHaRPAayJe7X1DpPQc5NO8RAAh7b61NtuZumwhpGXUMxjqUDS6G96ra8tKA1Vo+6ESgZm65xTeBzRqWsTR24Trwwh+VxNCiqOLBE1hl5KDOUnk05+GymcJSn6pMlGfxrTn0npXTSzbmng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wMhdVVEy; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrwIb4OfJ+ImT+xQqGsnaqtzy9pDZ5bHhrHAtcLr0c+JJYVEp26PIjUo/Yb/U1r4yq3LlG9JEfOD+IC+B7FDlakVLvUpzLeT2FJBLcTqp0tjSQVl8YeUckTN3bhGvg1ayuLMhRLXlsUJGgGjsz4/m7C8uNmr8mUndi50eTQ6FL5gmElfL55tO8lfC3Wsc8hb/dsZfC798ROiYL6fYtBQhWgBQsmA1Q0W8UWOrCJmdhCeHOQh1WIEwJ0ZUVyCTNoDyg+u7l2U7dkfj6kx4xYNrWbf9aoREoK//Z3bvzsVRI9VBbnaRo0VwaxPn+1/4WdG2Y0HkU+yWflLUKLOW/j+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR5lwR7ocSYg9xggvlfqb4UMGVkz4dpo1j/gcmPJlg0=;
 b=YFLh9uRuStgoII/SQP7ybvZZVbpUR2hIV+zevikjNhIYQaxzPU7mqXBOKEbg1JTErz+WscZTCu+p8ry8J4nDHL/33f4+HPXMmPYrnPSxw3CzHs96sgs0GYkq1J3zqg1qElr97mfYSwwG0rysurx5TihW6424C2brq9y+O9OO7uJ9yQLBrv7z6IjdzT4vpYJUTLxNfB7xLZMwJOQUOaOYMck0aw4qZLQGqQL2fqiSBJBmEbs3qQAS2m/doxAtPgjzu9IMe/migmAhNqPkJxQud3v11wDsVXN7n7nkt+SKZYskvVea+etNYzUab/fSDzu3AFq8MvN1v8AymlLtXsUecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR5lwR7ocSYg9xggvlfqb4UMGVkz4dpo1j/gcmPJlg0=;
 b=wMhdVVEyUY0yk3IwSOtMydKmQ+IA4KSBBlVjP5gMzwgpI6TacpYRY9fGwBTjNoxrv+BnTzdrZlrw3zsg7L1kOPk0yFU9ZwgkSqxFhsaOdvNn5JbbIs46JgyuBoExN3KLVG0Ih+amMTSmQoqmPfwpA8NGhqyCmwml2hj8wbivD3c=
Received: from BN9PR03CA0688.namprd03.prod.outlook.com (2603:10b6:408:10e::33)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 05:15:18 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::17) by BN9PR03CA0688.outlook.office365.com
 (2603:10b6:408:10e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 05:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:15:17 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:15:11 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <corbet@lwn.net>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <iamjoonsoo.kim@lge.com>,
	<qyousef@layalina.io>, <sshegde@linux.ibm.com>, <alexs@kernel.org>,
	<lukasz.luba@arm.com>, <cpru@amazon.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v4 11/11] perf sched stats: Add details in man page
Date: Tue, 26 Aug 2025 05:10:39 +0000
Message-ID: <20250826051039.2626894-12-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4d03d0-7a0c-4b4e-1e18-08dde45f8bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k0f6FRhaU2ry8h33LKkmOGyVuuCg5JgqmgARgd11/dcpMGD3GBlDe7PEHMd7?=
 =?us-ascii?Q?qx5Oq9+ErCzBdDll0p86yCDRcNkZQOcOaRR8LSdW5diP3OIUon7YV8tsDngw?=
 =?us-ascii?Q?cB9VOtHHQUzS9iOBpPzg9dCZtP870ovgG5DGZO037JWska3vhN+IVC4ttvAk?=
 =?us-ascii?Q?5hmr2gcNsHzcPtqOJRi2A6aOXXBEf/Pk1+4OguOQk0DZCxEessut97MABLaA?=
 =?us-ascii?Q?+9eBU+p7O5GM/QBhi/Sb2233ADKK6jh2McTlVs0mBzuWiJmKVmwU/DO0jlP8?=
 =?us-ascii?Q?DSNKHCWAYCDJGSlV7lqHCY+d5tSYaakAr6CPnE5utqqv/5FpNna39i27oCZQ?=
 =?us-ascii?Q?ktndAqHJWpDoV5dONdtdzwHgc3KicL0Ce7tr/MKYOIFWVO/10P/Y8Rp10TH3?=
 =?us-ascii?Q?/kGi4ckhvGqpyyPQpRdQV0w76dVbe/gCOjpPsdGZnOIzpUGbjJu3VjHb8f7G?=
 =?us-ascii?Q?SVKI4JVFv75hqHSxI/W6rXb5Yk1FGDgiTBM9A75Xbmh+aQmz02EpgAiQddMY?=
 =?us-ascii?Q?Gg+j6g4jI+WaDSM6MYKp5pPITd5Wgxv+8MJtSF29xB6inUuLHcD7gtVlgcoQ?=
 =?us-ascii?Q?4ss6bYFEeWzOodDxPjNDLYBqpujptxWhw5JkMIuU8hKu4G2q8ZJQlyGo4To5?=
 =?us-ascii?Q?bgPawnC8McWSa3E4LvhokSWn7Gac/pi+N+FZm1lRgrSYCnBCipFZgixVb2RA?=
 =?us-ascii?Q?XB/AA2lhVB5gRsylWaQF6OeSNuND0hunof/PjhXzkDhtFBDAV1XFomiQXL39?=
 =?us-ascii?Q?hHJntbrY9zxX1g/rZJ/KHaCWaetGRyBQKNXkT1LZpoe0ZnAAmw8BWudDx2Ho?=
 =?us-ascii?Q?4pmo2dgqsSMcHq46PWmn0Fzn3Snb4ikAB79zDGgaQ4LSCY+DyhQwSJNKhA1Y?=
 =?us-ascii?Q?LlZDRThN8FGQo3B0Bhavz6W1+kZy6wEm/WLhXM/ORAD5F/q//iFN3IAbufE7?=
 =?us-ascii?Q?LqMFr7UUfrdh/s6cw/6GoE9H2mTfg8BEI7Kh7U/91Ve0hZxf9wsMgMsETelm?=
 =?us-ascii?Q?ctd6GsyJMJSrXS7arCrCUqLsu8Nv3VINxp4ZXp9c3wziJpGQoYdWZpNUvoFI?=
 =?us-ascii?Q?qXNicHy18yCR3tT4jkqCZTYLgDwYwMeEB0jOEAH30M41mVO2uRJLYD899yuM?=
 =?us-ascii?Q?zefhKCUcAi6wiv+mtBBTMiRYJnkbqWtZJKmtPMjgBaQ3vHWtp1RTaqJhjRPn?=
 =?us-ascii?Q?jtaDd/D1d5Om0PEDWOZggzCkZ/GmETzIUcE/husxejzW3VvoS8eHcr7WR85c?=
 =?us-ascii?Q?2Qgccxt+P3MUQ4WuoPVm7hV9Tzm26UitOsvppEhZEtL2mZwQBLB2IrcvDNDQ?=
 =?us-ascii?Q?2Y8WHWlbDMtv+XQme5zCQBq/iCrTWiw45bMsRYtmNau6GN3dtcN+dusDd6UT?=
 =?us-ascii?Q?4jxXPrbUmBQ3tMyikoEk+lOkApm/OLmdnCGMsFPaXmeSyOLUeWdx/Da7B/HP?=
 =?us-ascii?Q?nW+QagBoArkScbhh3RcbHBBwKj3zFeFQmugf0pCCIB3spCDAqbBMB6gfxsgP?=
 =?us-ascii?Q?os8tdOhAxDQckXFFyHKLlKevmxolzXqnLDM9eTfvzlmqRcGXscCWKtkFSQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:15:17.4555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4d03d0-7a0c-4b4e-1e18-08dde45f8bcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992

Document perf sched stats purpose, usage examples and guide on
how to interpret the report data in the perf-sched man page.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/Documentation/perf-sched.txt | 261 +++++++++++++++++++++++-
 1 file changed, 260 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 6dbbddb6464d..5bfb7bb6c633 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -8,7 +8,7 @@ perf-sched - Tool to trace/measure scheduler properties (latencies)
 SYNOPSIS
 --------
 [verse]
-'perf sched' {record|latency|map|replay|script|timehist}
+'perf sched' {record|latency|map|replay|script|timehist|stats}
 
 DESCRIPTION
 -----------
@@ -80,8 +80,267 @@ There are several variants of 'perf sched':
     
    Times are in msec.usec.
 
+   'perf sched stats {record | report | diff} <command>' to capture, report the diff
+   in schedstat counters and show the difference between perf sched stats report
+   respectively. schedstat counters which are present in the linux kernel and are
+   exposed through the file ``/proc/schedstat``. These counters are enabled or disabled
+   via the sysctl governed by the file ``/proc/sys/kernel/sched_schedstats``. These
+   counters accounts for many scheduler events such as ``schedule()`` calls, load-balancing
+   events, ``try_to_wakeup()`` call among others. This is useful in understading the
+   scheduler behavior for the workload.
+
+   Note: The tool will not give correct results if there is topological reordering or
+         online/offline of cpus in between capturing snapshots of `/proc/schedstat`.
+
+    Example usage:
+        perf sched stats record -- sleep 1
+        perf sched stats report
+        perf sched stats diff
+
+   A detailed description of the schedstats can be found in the Kernel Documentation:
+   https://www.kernel.org/doc/html/latest/scheduler/sched-stats.html
+
+   The result can be interprested as follows:
+
+   The `perf sched stats report` starts with description of the columns present in
+   the report. These column names are given before cpu and domain stats to improve
+   the readability of the report.
+
+   ----------------------------------------------------------------------------------------------------
+   DESC                    -> Description of the field
+   COUNT                   -> Value of the field
+   PCT_CHANGE              -> Percent change with corresponding base value
+   AVG_JIFFIES             -> Avg time in jiffies between two consecutive occurrence of event
+   ----------------------------------------------------------------------------------------------------
+
+   Next is the total profiling time in terms of jiffies:
+
+   ----------------------------------------------------------------------------------------------------
+   Time elapsed (in jiffies)                                   :       24537
+   ----------------------------------------------------------------------------------------------------
+
+   Next is CPU scheduling statistics. These are simple diffs of /proc/schedstat CPU lines
+   along with description. The report also prints % relative to base stat.
+
+   In the example below, schedule() left the CPU0 idle 36.58% of the time. 0.45% of total
+   try_to_wake_up() was to wakeup local CPU. And, the total waittime by tasks on CPU0 is
+   48.70% of the total runtime by tasks on the same CPU.
+
+   ----------------------------------------------------------------------------------------------------
+   CPU 0
+   ----------------------------------------------------------------------------------------------------
+   DESC                                                                     COUNT   PCT_CHANGE
+   ----------------------------------------------------------------------------------------------------
+   yld_count                                                        :           0
+   array_exp                                                        :           0
+   sched_count                                                      :      402267
+   sched_goidle                                                     :      147161  (    36.58% )
+   ttwu_count                                                       :      236309
+   ttwu_local                                                       :        1062  (     0.45% )
+   rq_cpu_time                                                      :  7083791148
+   run_delay                                                        :  3449973971  (    48.70% )
+   pcount                                                           :      255035
+   ----------------------------------------------------------------------------------------------------
+
+   Next is load balancing statistics. For each of the sched domains
+   (eg: `SMT`, `MC`, `DIE`...), the scheduler computes statistics under
+   the following three categories:
+
+   1) Idle Load Balance: Load balancing performed on behalf of a long
+                         idling CPU by some other CPU.
+   2) Busy Load Balance: Load balancing performed when the CPU was busy.
+   3) New Idle Balance : Load balancing performed when a CPU just became
+                        idle.
+
+   Under each of these three categories, sched stats report provides
+   different load balancing statistics. Along with direct stats, the
+   report also contains derived metrics prefixed with *. Example:
+
+   ----------------------------------------------------------------------------------------------------
+   CPU 0, DOMAIN SMT CPUS 0,64
+   ----------------------------------------------------------------------------------------------------
+   DESC                                                                     COUNT    AVG_JIFFIES
+   ----------------------------------------- <Category busy> ------------------------------------------
+   busy_lb_count                                                    :         136  $       17.08 $
+   busy_lb_balanced                                                 :         131  $       17.73 $
+   busy_lb_failed                                                   :           0  $        0.00 $
+   busy_lb_imbalance_load                                           :          58
+   busy_lb_imbalance_util                                           :           0
+   busy_lb_imbalance_task                                           :           0
+   busy_lb_imbalance_misfit                                         :           0
+   busy_lb_gained                                                   :           7
+   busy_lb_hot_gained                                               :           0
+   busy_lb_nobusyq                                                  :           2  $     1161.50 $
+   busy_lb_nobusyg                                                  :         129  $       18.01 $
+   *busy_lb_success_count                                           :           5
+   *busy_lb_avg_pulled                                              :        1.40
+   ----------------------------------------- <Category idle> ------------------------------------------
+   idle_lb_count                                                    :         449  $        5.17 $
+   idle_lb_balanced                                                 :         382  $        6.08 $
+   idle_lb_failed                                                   :           3  $      774.33 $
+   idle_lb_imbalance_load                                           :           0
+   idle_lb_imbalance_util                                           :           0
+   idle_lb_imbalance_task                                           :          71
+   idle_lb_imbalance_misfit                                         :           0
+   idle_lb_gained                                                   :          67
+   idle_lb_hot_gained                                               :           0
+   idle_lb_nobusyq                                                  :           0  $        0.00 $
+   idle_lb_nobusyg                                                  :         382  $        6.08 $
+   *idle_lb_success_count                                           :          64
+   *idle_lb_avg_pulled                                              :        1.05
+   ---------------------------------------- <Category newidle> ----------------------------------------
+   newidle_lb_count                                                 :       30471  $        0.08 $
+   newidle_lb_balanced                                              :       28490  $        0.08 $
+   newidle_lb_failed                                                :         633  $        3.67 $
+   newidle_lb_imbalance_load                                        :           0
+   newidle_lb_imbalance_util                                        :           0
+   newidle_lb_imbalance_task                                        :        2040
+   newidle_lb_imbalance_misfit                                      :           0
+   newidle_lb_gained                                                :        1348
+   newidle_lb_hot_gained                                            :           0
+   newidle_lb_nobusyq                                               :           6  $      387.17 $
+   newidle_lb_nobusyg                                               :       26634  $        0.09 $
+   *newidle_lb_success_count                                        :        1348
+   *newidle_lb_avg_pulled                                           :        1.00
+   ----------------------------------------------------------------------------------------------------
+
+   Consider following line:
+
+   newidle_lb_balanced                                              :       28490  $        0.08 $
+
+   While profiling was active, the load-balancer found 28490 times the load
+   needs to be balanced on a newly idle CPU 0. Following value encapsulated
+   inside $ is average jiffies between two events (28490 / 24537 = 0.08).
+
+   Next are active_load_balance() stats. alb did not trigger while the
+   profiling was active, hence it's all 0s.
+
+   --------------------------------- <Category active_load_balance()> ---------------------------------
+   alb_count                                                        :           0
+   alb_failed                                                       :           0
+   alb_pushed                                                       :           0
+   ----------------------------------------------------------------------------------------------------
+
+   Next are sched_balance_exec() and sched_balance_fork() stats. They are
+   not used but we kept it in RFC just for legacy purpose. Unless opposed,
+   we plan to remove them in next revision.
+
+   Next are wakeup statistics. For every domain, the report also shows
+   task-wakeup statistics. Example:
+
+   ------------------------------------------ <Wakeup Info> -------------------------------------------
+   ttwu_wake_remote                                                 :        1590
+   ttwu_move_affine                                                 :          84
+   ttwu_move_balance                                                :           0
+   ----------------------------------------------------------------------------------------------------
+
+   Same set of stats are reported for each CPU and each domain level.
+
+   How to interpret the diff
+   ~~~~~~~~~~~~~~~~~~~~~~~~~
+
+   The `perf sched stats diff` will also start with explaining the columns
+   present in the diff. Then it will show the diff in time in terms of
+   jiffies. The order of the values depends on the order of input data
+   files. It will take `perf.data.old` and `perf.data` respectively as the
+   defaults for comparison. Example:
+
+   ----------------------------------------------------------------------------------------------------
+   Time elapsed (in jiffies)                                        :        2009,       2001
+   ----------------------------------------------------------------------------------------------------
+
+   Below is the sample representing the difference in cpu and domain stats of
+   two runs. Here third column or the values enclosed in `|...|` shows the
+   percent change between the two. Second and fourth columns shows the
+   side-by-side representions of the corresponding fields from `perf sched
+   stats report`.
+
+   ----------------------------------------------------------------------------------------------------
+   CPU <ALL CPUS SUMMARY>
+   ----------------------------------------------------------------------------------------------------
+   DESC                                                                    COUNT1      COUNT2   PCT_CHANG>
+   ----------------------------------------------------------------------------------------------------
+   yld_count                                                        :           0,          0  |     0.00>
+   array_exp                                                        :           0,          0  |     0.00>
+   sched_count                                                      :      528533,     412573  |   -21.94>
+   sched_goidle                                                     :      193426,     146082  |   -24.48>
+   ttwu_count                                                       :      313134,     385975  |    23.26>
+   ttwu_local                                                       :        1126,       1282  |    13.85>
+   rq_cpu_time                                                      :  8257200244, 8301250047  |     0.53>
+   run_delay                                                        :  4728347053, 3997100703  |   -15.47>
+   pcount                                                           :      335031,     266396  |   -20.49>
+   ----------------------------------------------------------------------------------------------------
+
+   Below is the sample of domain stats diff:
+
+   ----------------------------------------------------------------------------------------------------
+   CPU <ALL CPUS SUMMARY>, DOMAIN SMT
+   ----------------------------------------------------------------------------------------------------
+   DESC                                                                    COUNT1      COUNT2   PCT_CHANG>
+   ----------------------------------------- <Category busy> ------------------------------------------
+   busy_lb_count                                                    :         122,         80  |   -34.43>
+   busy_lb_balanced                                                 :         115,         76  |   -33.91>
+   busy_lb_failed                                                   :           1,          3  |   200.00>
+   busy_lb_imbalance_load                                           :          35,         49  |    40.00>
+   busy_lb_imbalance_util                                           :           0,          0  |     0.00>
+   busy_lb_imbalance_task                                           :           0,          0  |     0.00>
+   busy_lb_imbalance_misfit                                         :           0,          0  |     0.00>
+   busy_lb_gained                                                   :           7,          2  |   -71.43>
+   busy_lb_hot_gained                                               :           0,          0  |     0.00>
+   busy_lb_nobusyq                                                  :           0,          0  |     0.00>
+   busy_lb_nobusyg                                                  :         115,         76  |   -33.91>
+   *busy_lb_success_count                                           :           6,          1  |   -83.33>
+   *busy_lb_avg_pulled                                              :        1.17,       2.00  |    71.43>
+   ----------------------------------------- <Category idle> ------------------------------------------
+   idle_lb_count                                                    :         568,        620  |     9.15>
+   idle_lb_balanced                                                 :         462,        449  |    -2.81>
+   idle_lb_failed                                                   :          11,         21  |    90.91>
+   idle_lb_imbalance_load                                           :           0,          0  |     0.00>
+   idle_lb_imbalance_util                                           :           0,          0  |     0.00>
+   idle_lb_imbalance_task                                           :         115,        189  |    64.35>
+   idle_lb_imbalance_misfit                                         :           0,          0  |     0.00>
+   idle_lb_gained                                                   :         103,        169  |    64.08>
+   idle_lb_hot_gained                                               :           0,          0  |     0.00>
+   idle_lb_nobusyq                                                  :           0,          0  |     0.00>
+   idle_lb_nobusyg                                                  :         462,        449  |    -2.81>
+   *idle_lb_success_count                                           :          95,        150  |    57.89>
+   *idle_lb_avg_pulled                                              :        1.08,       1.13  |     3.92>
+   ---------------------------------------- <Category newidle> ----------------------------------------
+   newidle_lb_count                                                 :       16961,       3155  |   -81.40>
+   newidle_lb_balanced                                              :       15646,       2556  |   -83.66>
+   newidle_lb_failed                                                :         397,        142  |   -64.23>
+   newidle_lb_imbalance_load                                        :           0,          0  |     0.00>
+   newidle_lb_imbalance_util                                        :           0,          0  |     0.00>
+   newidle_lb_imbalance_task                                        :        1376,        655  |   -52.40>
+   newidle_lb_imbalance_misfit                                      :           0,          0  |     0.00>
+   newidle_lb_gained                                                :         917,        457  |   -50.16>
+   newidle_lb_hot_gained                                            :           0,          0  |     0.00>
+   newidle_lb_nobusyq                                               :           3,          1  |   -66.67>
+   newidle_lb_nobusyg                                               :       14480,       2103  |   -85.48>
+   *newidle_lb_success_count                                        :         918,        457  |   -50.22>
+   *newidle_lb_avg_pulled                                           :        1.00,       1.00  |     0.11>
+   --------------------------------- <Category active_load_balance()> ---------------------------------
+   alb_count                                                        :           0,          1  |     0.00>
+   alb_failed                                                       :           0,          0  |     0.00>
+   alb_pushed                                                       :           0,          1  |     0.00>
+   --------------------------------- <Category sched_balance_exec()> ----------------------------------
+   sbe_count                                                        :           0,          0  |     0.00>
+   sbe_balanced                                                     :           0,          0  |     0.00>
+   sbe_pushed                                                       :           0,          0  |     0.00>
+   --------------------------------- <Category sched_balance_fork()> ----------------------------------
+   sbf_count                                                        :           0,          0  |     0.00>
+   sbf_balanced                                                     :           0,          0  |     0.00>
+   sbf_pushed                                                       :           0,          0  |     0.00>
+   ------------------------------------------ <Wakeup Info> -------------------------------------------
+   ttwu_wake_remote                                                 :        2031,       2914  |    43.48>
+   ttwu_move_affine                                                 :          73,        124  |    69.86>
+   ttwu_move_balance                                                :           0,          0  |     0.00>
+   ----------------------------------------------------------------------------------------------------
+
 OPTIONS
 -------
+Applicable to {record|latency|map|replay|script}
+
 -i::
 --input=<file>::
         Input file name. (default: perf.data unless stdin is a fifo)
-- 
2.43.0


