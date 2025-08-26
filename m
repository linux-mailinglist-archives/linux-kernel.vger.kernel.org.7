Return-Path: <linux-kernel+bounces-785967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191FFB35301
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEC93AED27
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149AD2DFA3A;
	Tue, 26 Aug 2025 05:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nx80w3uq"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47071F8723;
	Tue, 26 Aug 2025 05:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185089; cv=fail; b=RRK9PJcLWvLeTlG/CRSrOn6MciCzf97WLwIEab+GCnoqWbfDqaABNC14knAadAxWq0bBqCYiYMZDIkTf+22kBs0ez7breVMXzJ0uB4UcF5cyEtwdKb6DQqkBYSOqwV+60mAbqW4HiR+55MSSEBzouoDzCdlNkCPdA3+xE2dWWko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185089; c=relaxed/simple;
	bh=Fa2FImu/OZDoDcyXEYlCrb0D4VsSgjSj6wooiDD9vog=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=duEdRJpXBsH9BJQjYfkvaRlczkJ5Dn5UV8MrLEm0acFji+FFkUCJ1vtQHZ0D/LGA9Lt2owsqgwsNPO+Abci9aOzEN3qYrdgcc5FKlzx3IOPzQZZpCoglE3gFFhkPlZVb/occFhZjiHRcxaC2hvKewtw3Mid6QuM+DLjCSOaPXCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nx80w3uq; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qt/bVeJH+B5xNhU+keNcUUevW5RWfWZsJRhhVF5iPdlG2E/9DRZZFA42s1kUEiI3mNpioRthlqYi9fC04qreAShJmwi6MwLNLVs59HHjcBhRFZd57rpkN32rLHF0BaplMhtCOq2wt69uLmyS5CFXrrHRURkcmSu/bJ5cYQGG37ZnAqYfAwFLnmQSdPW+d+GCeGsvQ0E7PZpmHMCR8+t5Nz3hWYxwVcalPzBbyHuKi2j2MniKdK4V89K8sz5tsPdv2lpRMfWBRFWZt1fF7ePkF7ygnhTZty1fsnWfregROBzIdVQ1zkJPusIpPcfOa2hSBPgVwxZoE1xnYIxHGS92qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NW2L1eTkL9r7Iat2CKfZx6H+h2tgcmqGpB4AfWXY04=;
 b=p8giAOxY8qyB77CRzr7CuyC2RjpbSweq1NfB/S/8UVPk7EXZ96rVtsPPfi0x9nh1GKZHQUYk2h8u2wSmgmt5Bcu41pCjvxglc8cMJN6DWMzlCmhGppQLB+p9HOXENlF9Ra3B/ZVuv1jTB8neJzfmy6kEtFVxiIhHMnZynkuIURCFXaVbdzA6pOWGshWAc6O835HKhaOU88LNwOmwsvwvdvL0EJNmP64VnDGm6utyoxfnxpusJ0ykrDXSJs6JkXkQjTwyye3YC6vManZ0SMrZVhAs1yqgQhGYXEEb4D3V6lN9gAaKArhBSn3aCD0S+sSukFJPU5M/Cdbkn9DRJSFJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NW2L1eTkL9r7Iat2CKfZx6H+h2tgcmqGpB4AfWXY04=;
 b=nx80w3uqdxAUueiy+ucxsuFtTIxv0uk81MudM6eLgU21YgLwUgcGU3MY3RYUXMroisdy/jaj7FFjaGZ9rXqxhFol6vjer5VT3zAhNaNwZx+FW01Zyv83pwgxPjbw8zA6+A/PTXamoCNFdAdjgITu7yevHpghlaff6q/8RLgW4ts=
Received: from BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 05:11:17 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::a3) by BYAPR11CA0099.outlook.office365.com
 (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 05:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:11:17 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:11:09 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <corbet@lwn.net>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <iamjoonsoo.kim@lge.com>,
	<qyousef@layalina.io>, <sshegde@linux.ibm.com>, <alexs@kernel.org>,
	<lukasz.luba@arm.com>, <cpru@amazon.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v4 00/11] perf sched: Introduce stats tool
Date: Tue, 26 Aug 2025 05:10:28 +0000
Message-ID: <20250826051039.2626894-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fd16c9-be62-4adf-37e4-08dde45efc8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8NQgCx1x+sIKQ1pUTb/4IxcZTr5LfkvTT7WNbNTqN7YMKrcgVWN4dpdjTdQP?=
 =?us-ascii?Q?tSrYulZoleoxCU2CxSnFiY1+kcfOituuxGZz1KaWlD1z/l4YFggZkw+4sr6k?=
 =?us-ascii?Q?IXcHO3yZWHe4GpoBTmaEmR5E2ucAsay34/lEo+pqbsIuo+qcfOPMRSmSv0Bi?=
 =?us-ascii?Q?8ZglScO0J/xfMkxx2UIbe1bHUGOsMUm9ywpRM3wrSx3dpa63AW1poaLtMqHg?=
 =?us-ascii?Q?hPcipofKqy+9MWzdam7F55k6Hf+xg/ZrqDqtR6nkB6Tn32JI20eBjHDfV6cc?=
 =?us-ascii?Q?F4YdEuSV0z7apyKKAkxq7w5WgzYah+H4Gn1iE8KzsrI/vhcAvh55Xtiv6v7o?=
 =?us-ascii?Q?V3IPaqaANfDkKKtVugCjmIPekr3K3GRQndurP4fuT4fIXIVrpgOaaPlqPLRD?=
 =?us-ascii?Q?Vnin+2F4AWBtlS8EhQJ5uvAuQoT4Q1MCh1gv5R66VKHC2sVI1wSFA5uicoQr?=
 =?us-ascii?Q?7vpCiaT7gNblLK/2apjAFD+x7o9ithA3TIH73onA20OOxieUypvrauAOisg1?=
 =?us-ascii?Q?Q9AliLCAPWvDvEgPuWCoRE8XIygAtoRj93GL+Bmx5ivGSeodaTARI0cLCkum?=
 =?us-ascii?Q?LSbhawAfo0XcT2OSLDwqk0Q6TZUz7ys0DtotfUAO1Kfk6nspkZBsTFp9polT?=
 =?us-ascii?Q?V1XEEmeSEnFyVc0KjgPYGgOE0D+ZoyuBYonBVJ4ob99tTqGLO96/Q7PM2zE0?=
 =?us-ascii?Q?aXYWd1o/rdPSqh1e42e5lENl7AJeQ5Em2tWprtV+FA5jivp2rbSkP5+XUjIo?=
 =?us-ascii?Q?F+XM2gjcanHrh/KLhw5VbJ/cHj12x44fQQhrp7YLAx8SSKhSyk0P/Vog9One?=
 =?us-ascii?Q?6bAsMsduGraefYp0pHB83SBqK9zqUn/y7CCgRqPzVpm/om434rXEqcdnVO20?=
 =?us-ascii?Q?x3WAZjk0saMTIEnoBZQB7+OIiFzyH0KZaFpQ9Vp+PR3lXZ+GzArJwkWgKce+?=
 =?us-ascii?Q?66GaDwA/TJpTOasX42eifPu4Irix4kl0UFoGAlpv0cEDoy6gKcPncUIumHfq?=
 =?us-ascii?Q?6tTJ6x1wHgR9X88RlHpfOpm9zbnCxs7r05OlfMxmSWzRLiEi+s6HRmORuxbq?=
 =?us-ascii?Q?EL+5ewT2bhTRnQHOt6CgodJU539easAWolCeofjddoOPVP1/huYkj2N+G+hB?=
 =?us-ascii?Q?AhHFx+LMKOn2ZoUSBAOxEZOPJBAAvHIXA7lm1HypV1Ugg1SN5xDFiskrctmQ?=
 =?us-ascii?Q?A0o9Nsvgil4dhdPDNAWO/2Nd6tmiE7zKLON0wO3/sZgZZoG78N6IGcrf2+uU?=
 =?us-ascii?Q?R0YS6XB1K18L/5Xk3m3XlMyVRpI6T+ikiNjwNp8qsSxwv4hlCkg9YUV+E4mE?=
 =?us-ascii?Q?7es/VH9mNCKaSwPw3LG+X9eePp9zsUfQ+Mu7lOxMbs27DH+KgFPjJZAr2bYI?=
 =?us-ascii?Q?68A7rMUqGMnVic2I7GAOHuU2nkfFLfCIhfz82aqDiG2kalP5+MtLf9Y89v4J?=
 =?us-ascii?Q?XlwO1kDYEzT7J/jASIF1R7P2IOyZY/YQwSDzifrpl9E2iVwFQ/Tslw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:11:17.0434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fd16c9-be62-4adf-37e4-08dde45efc8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331

Apologies for long delay, I was side tracked on some other items. I was
not able to focus on this.

MOTIVATION
----------

Existing `perf sched` is quite exhaustive and provides lot of insights
into scheduler behavior but it quickly becomes impractical to use for
long running or scheduler intensive workload. For ex, `perf sched record`
has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
generates huge 56G perf.data for which perf takes ~137 mins to prepare
and write it to disk [1].

Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
and generates samples on a tracepoint hit, `perf sched stats record` takes
snapshot of the /proc/schedstat file before and after the workload, i.e.
there is almost zero interference on workload run. Also, it takes very
minimal time to parse /proc/schedstat, convert it into perf samples and
save those samples into perf.data file. Result perf.data file is much
smaller. So, overall `perf sched stats record` is much more light weight
compare to `perf sched record`.

We, internally at AMD, have been using this (a variant of this, known as
"sched-scoreboard"[2]) and found it to be very useful to analyse impact
of any scheduler code changes[3][4]. Prateek used v2[5] of this patch
series to report the analysis[6][7].

Please note that, this is not a replacement of perf sched record/report.
The intended users of the new tool are scheduler developers, not regular
users.

USAGE
-----

  # perf sched stats record
  # perf sched stats report
  # perf sched stats diff

Note: Although `perf sched stats` tool supports workload profiling syntax
(i.e. -- <workload> ), the recorded profile is still systemwide since the
/proc/schedstat is a systemwide file.

HOW TO INTERPRET THE REPORT
---------------------------

The `perf sched stats report` starts with description of the columns
present in the report. These column names are given before cpu and
domain stats to improve the readability of the report.

  ----------------------------------------------------------------------------------------------------
  DESC                    -> Description of the field
  COUNT                   -> Value of the field
  PCT_CHANGE              -> Percent change with corresponding base value
  AVG_JIFFIES             -> Avg time in jiffies between two consecutive occurrence of event
  ----------------------------------------------------------------------------------------------------

Next is the total profiling time in terms of jiffies:

  ----------------------------------------------------------------------------------------------------
  Time elapsed (in jiffies)                                   :       24537
  ----------------------------------------------------------------------------------------------------

Next is CPU scheduling statistics. These are simple diffs of
/proc/schedstat CPU lines along with description. The report also
prints % relative to base stat.

In the example below, schedule() left the CPU0 idle 36.58% of the time.
0.45% of total try_to_wake_up() was to wakeup local CPU. And, the total
waittime by tasks on CPU0 is 48.70% of the total runtime by tasks on the
same CPU.

  ----------------------------------------------------------------------------------------------------
  CPU 0
  ----------------------------------------------------------------------------------------------------
  DESC                                                                     COUNT   PCT_CHANGE
  ----------------------------------------------------------------------------------------------------
  yld_count                                                        :           0
  array_exp                                                        :           0
  sched_count                                                      :      402267
  sched_goidle                                                     :      147161  (    36.58% )
  ttwu_count                                                       :      236309
  ttwu_local                                                       :        1062  (     0.45% )
  rq_cpu_time                                                      :  7083791148
  run_delay                                                        :  3449973971  (    48.70% )
  pcount                                                           :      255035
  ----------------------------------------------------------------------------------------------------

Next is load balancing statistics. For each of the sched domains
(eg: `SMT`, `MC`, `DIE`...), the scheduler computes statistics under
the following three categories:

  1) Idle Load Balance: Load balancing performed on behalf of a long
                        idling CPU by some other CPU.
  2) Busy Load Balance: Load balancing performed when the CPU was busy.
  3) New Idle Balance : Load balancing performed when a CPU just became
                        idle.

Under each of these three categories, sched stats report provides
different load balancing statistics. Along with direct stats, the
report also contains derived metrics prefixed with *. Example:

  ----------------------------------------------------------------------------------------------------
  CPU 0, DOMAIN SMT CPUS 0,64
  ----------------------------------------------------------------------------------------------------
  DESC                                                                     COUNT    AVG_JIFFIES
  ----------------------------------------- <Category busy> ------------------------------------------
  busy_lb_count                                                    :         136  $       17.08 $
  busy_lb_balanced                                                 :         131  $       17.73 $
  busy_lb_failed                                                   :           0  $        0.00 $
  busy_lb_imbalance_load                                           :          58
  busy_lb_imbalance_util                                           :           0
  busy_lb_imbalance_task                                           :           0
  busy_lb_imbalance_misfit                                         :           0
  busy_lb_gained                                                   :           7
  busy_lb_hot_gained                                               :           0
  busy_lb_nobusyq                                                  :           2  $     1161.50 $
  busy_lb_nobusyg                                                  :         129  $       18.01 $
  *busy_lb_success_count                                           :           5
  *busy_lb_avg_pulled                                              :        1.40
  ----------------------------------------- <Category idle> ------------------------------------------
  idle_lb_count                                                    :         449  $        5.17 $
  idle_lb_balanced                                                 :         382  $        6.08 $
  idle_lb_failed                                                   :           3  $      774.33 $
  idle_lb_imbalance_load                                           :           0
  idle_lb_imbalance_util                                           :           0
  idle_lb_imbalance_task                                           :          71
  idle_lb_imbalance_misfit                                         :           0
  idle_lb_gained                                                   :          67
  idle_lb_hot_gained                                               :           0
  idle_lb_nobusyq                                                  :           0  $        0.00 $
  idle_lb_nobusyg                                                  :         382  $        6.08 $
  *idle_lb_success_count                                           :          64
  *idle_lb_avg_pulled                                              :        1.05
  ---------------------------------------- <Category newidle> ----------------------------------------
  newidle_lb_count                                                 :       30471  $        0.08 $
  newidle_lb_balanced                                              :       28490  $        0.08 $
  newidle_lb_failed                                                :         633  $        3.67 $
  newidle_lb_imbalance_load                                        :           0
  newidle_lb_imbalance_util                                        :           0
  newidle_lb_imbalance_task                                        :        2040
  newidle_lb_imbalance_misfit                                      :           0
  newidle_lb_gained                                                :        1348
  newidle_lb_hot_gained                                            :           0
  newidle_lb_nobusyq                                               :           6  $      387.17 $
  newidle_lb_nobusyg                                               :       26634  $        0.09 $
  *newidle_lb_success_count                                        :        1348
  *newidle_lb_avg_pulled                                           :        1.00
  ----------------------------------------------------------------------------------------------------

Consider following line:

newidle_lb_balanced                                              :       28490  $        0.08 $

While profiling was active, the load-balancer found 28490 times the load
needs to be balanced on a newly idle CPU 0. Following value encapsulated
inside $ is average jiffies between two events (28490 / 24537 = 0.08).

Next are active_load_balance() stats. alb did not trigger while the
profiling was active, hence it's all 0s.


  --------------------------------- <Category active_load_balance()> ---------------------------------
  alb_count                                                        :           0
  alb_failed                                                       :           0
  alb_pushed                                                       :           0
  ----------------------------------------------------------------------------------------------------

Next are sched_balance_exec() and sched_balance_fork() stats. They are
not used but we kept it in RFC just for legacy purpose. Unless opposed,
we plan to remove them in next revision.

Next are wakeup statistics. For every domain, the report also shows
task-wakeup statistics. Example:

  ------------------------------------------ <Wakeup Info> -------------------------------------------
  ttwu_wake_remote                                                 :        1590
  ttwu_move_affine                                                 :          84
  ttwu_move_balance                                                :           0
  ----------------------------------------------------------------------------------------------------

Same set of stats are reported for each CPU and each domain level.

HOW TO INTERPRET THE DIFF
-------------------------

The `perf sched stats diff` will also start with explaining the columns
present in the diff. Then it will show the diff in time in terms of
jiffies. The order of the values depends on the order of input data
files. Example:

  ----------------------------------------------------------------------------------------------------
  Time elapsed (in jiffies)                                        :        2763,       2763
  ----------------------------------------------------------------------------------------------------

Below is the sample representing the difference in cpu and domain stats of
two runs. Here third column or the values enclosed in `|...|` shows the
percent change between the two. Second and fourth columns shows the
side-by-side representions of the corresponding fields from `perf sched
stats report`.

  ----------------------------------------------------------------------------------------------------
  CPU <ALL CPUS SUMMARY>
  ----------------------------------------------------------------------------------------------------
  DESC                                                                    COUNT1      COUNT2   PCT_CHANG>
  ----------------------------------------------------------------------------------------------------
  yld_count                                                        :           0,          0  |     0.00>
  array_exp                                                        :           0,          0  |     0.00>
  sched_count                                                      :      528533,     412573  |   -21.94>
  sched_goidle                                                     :      193426,     146082  |   -24.48>
  ttwu_count                                                       :      313134,     385975  |    23.26>
  ttwu_local                                                       :        1126,       1282  |    13.85>
  rq_cpu_time                                                      :  8257200244, 8301250047  |     0.53>
  run_delay                                                        :  4728347053, 3997100703  |   -15.47>
  pcount                                                           :      335031,     266396  |   -20.49>
  ----------------------------------------------------------------------------------------------------

Below is the sample of domain stats diff:

  ----------------------------------------------------------------------------------------------------
  CPU <ALL CPUS SUMMARY>, DOMAIN SMT
  ----------------------------------------------------------------------------------------------------
  DESC                                                                    COUNT1      COUNT2   PCT_CHANG>
  ----------------------------------------- <Category busy> ------------------------------------------
  busy_lb_count                                                    :         122,         80  |   -34.43>
  busy_lb_balanced                                                 :         115,         76  |   -33.91>
  busy_lb_failed                                                   :           1,          3  |   200.00>
  busy_lb_imbalance_load                                           :          35,         49  |    40.00>
  busy_lb_imbalance_util                                           :           0,          0  |     0.00>
  busy_lb_imbalance_task                                           :           0,          0  |     0.00>
  busy_lb_imbalance_misfit                                         :           0,          0  |     0.00>
  busy_lb_gained                                                   :           7,          2  |   -71.43>
  busy_lb_hot_gained                                               :           0,          0  |     0.00>
  busy_lb_nobusyq                                                  :           0,          0  |     0.00>
  busy_lb_nobusyg                                                  :         115,         76  |   -33.91>
  *busy_lb_success_count                                           :           6,          1  |   -83.33>
  *busy_lb_avg_pulled                                              :        1.17,       2.00  |    71.43>
  ----------------------------------------- <Category idle> ------------------------------------------
  idle_lb_count                                                    :         568,        620  |     9.15>
  idle_lb_balanced                                                 :         462,        449  |    -2.81>
  idle_lb_failed                                                   :          11,         21  |    90.91>
  idle_lb_imbalance_load                                           :           0,          0  |     0.00>
  idle_lb_imbalance_util                                           :           0,          0  |     0.00>
  idle_lb_imbalance_task                                           :         115,        189  |    64.35>
  idle_lb_imbalance_misfit                                         :           0,          0  |     0.00>
  idle_lb_gained                                                   :         103,        169  |    64.08>
  idle_lb_hot_gained                                               :           0,          0  |     0.00>
  idle_lb_nobusyq                                                  :           0,          0  |     0.00>
  idle_lb_nobusyg                                                  :         462,        449  |    -2.81>
  *idle_lb_success_count                                           :          95,        150  |    57.89>
  *idle_lb_avg_pulled                                              :        1.08,       1.13  |     3.92>
  ---------------------------------------- <Category newidle> ----------------------------------------
  newidle_lb_count                                                 :       16961,       3155  |   -81.40>
  newidle_lb_balanced                                              :       15646,       2556  |   -83.66>
  newidle_lb_failed                                                :         397,        142  |   -64.23>
  newidle_lb_imbalance_load                                        :           0,          0  |     0.00>
  newidle_lb_imbalance_util                                        :           0,          0  |     0.00>
  newidle_lb_imbalance_task                                        :        1376,        655  |   -52.40>
  newidle_lb_imbalance_misfit                                      :           0,          0  |     0.00>
  newidle_lb_gained                                                :         917,        457  |   -50.16>
  newidle_lb_hot_gained                                            :           0,          0  |     0.00>
  newidle_lb_nobusyq                                               :           3,          1  |   -66.67>
  newidle_lb_nobusyg                                               :       14480,       2103  |   -85.48>
  *newidle_lb_success_count                                        :         918,        457  |   -50.22>
  *newidle_lb_avg_pulled                                           :        1.00,       1.00  |     0.11>
  --------------------------------- <Category active_load_balance()> ---------------------------------
  alb_count                                                        :           0,          1  |     0.00>
  alb_failed                                                       :           0,          0  |     0.00>
  alb_pushed                                                       :           0,          1  |     0.00>
  --------------------------------- <Category sched_balance_exec()> ----------------------------------
  sbe_count                                                        :           0,          0  |     0.00>
  sbe_balanced                                                     :           0,          0  |     0.00>
  sbe_pushed                                                       :           0,          0  |     0.00>
  --------------------------------- <Category sched_balance_fork()> ----------------------------------
  sbf_count                                                        :           0,          0  |     0.00>
  sbf_balanced                                                     :           0,          0  |     0.00>
  sbf_pushed                                                       :           0,          0  |     0.00>
  ------------------------------------------ <Wakeup Info> -------------------------------------------
  ttwu_wake_remote                                                 :        2031,       2914  |    43.48>
  ttwu_move_affine                                                 :          73,        124  |    69.86>
  ttwu_move_balance                                                :           0,          0  |     0.00>
  ----------------------------------------------------------------------------------------------------

v3: https://lore.kernel.org/all/20250311120230.61774-1-swapnil.sapkal@amd.com/
v3->v4:
 - All the review comments from v3 are addressed [Namhyung Kim].
 - Print short names instead of field descripion in the report [Peter Zijlstra]
 - Fix the double free issue [Cristian Prundeanu]
 - Documentation update related to `perf sched stats diff` [Chen yu]
 - Bail out `perf sched stats diff` if perf.data files have different schedstat
   versions [Peter Zijlstra]

v2: https://lore.kernel.org/all/20241122084452.1064968-1-swapnil.sapkal@amd.com/
v2->v3:
 - Add perf unit test for basic sched stats functionalities
 - Describe new tool, it's usage and interpretation of report data in the
   perf-sched man page.
 - Add /proc/schedstat version 17 support.

v1: https://lore.kernel.org/lkml/20240916164722.1838-1-ravi.bangoria@amd.com
v1->v2
 - Add the support for `perf sched stats diff`
 - Add column header in report for better readability. Use
   procfs__mountpoint for consistency. Add hint for enabling
   CONFIG_SCHEDSTAT if disabled. [James Clark]
 - Use a single header file for both cpu and domain fileds. Change
   the layout of structs to minimise the padding. I tried changing
   `v15` to `15` in the header files but it was not giving any
   benefits so drop the idea. [Namhyung Kim]
 - Add tested-by.

RFC: https://lore.kernel.org/r/20240508060427.417-1-ravi.bangoria@amd.com
RFC->v1:
 - [Kernel] Print domain name along with domain number in /proc/schedstat
   file.
 - s/schedstat/stats/ for the subcommand.
 - Record domain name and cpumask details, also show them in report.
 - Add CPU filtering capability at record and report time.
 - Add /proc/schedstat v16 support.
 - Live mode support. Similar to perf stat command, live mode prints the
   sched stats on the stdout.
 - Add pager support in `perf sched stats report` for better scrolling.
 - Some minor cosmetic changes in report output to improve readability.
 - Rebase to latest perf-tools-next/perf-tools-next (1de5b5dcb835).

TODO:
 - perf sched stats records /proc/schedstat which is a CPU and domain
   level scheduler statistic. We are planning to add taskstat tool which
   reads task stats from procfs and generate scheduler statistic report
   at task granularity. this will probably a standalone tool, something
   like `perf sched taskstat record/report`.
 - Except pre-processor related checkpatch warnings, we have addressed
   most of the other possible warnings.
 - This version supports diff for two perf.data files captured for same
   schedstats version but the target is to show diff for multiple
   perf.data files. Plan is to support diff if perf.data files provided
   has different schedstat versions.

Patches are prepared on v6.17-rc3 (1b237f190eb3).

[1] https://youtu.be/lg-9aG2ajA0?t=283
[2] https://github.com/AMDESE/sched-scoreboard
[3] https://lore.kernel.org/lkml/c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com/
[4] https://lore.kernel.org/lkml/3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com/
[5] https://lore.kernel.org/all/20241122084452.1064968-1-swapnil.sapkal@amd.com/
[6] https://lore.kernel.org/lkml/3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com/
[7] https://lore.kernel.org/lkml/feb31b6e-6457-454c-a4f3-ce8ad96bf8de@amd.com/

Swapnil Sapkal (11):
  perf: Add print_separator to util
  tools/lib: Add list_is_first()
  perf header: Support CPU DOMAIN relation info
  perf sched stats: Add record and rawdump support
  perf sched stats: Add schedstat v16 support
  perf sched stats: Add schedstat v17 support
  perf sched stats: Add support for report subcommand
  perf sched stats: Add support for live mode
  perf sched stats: Add support for diff subcommand
  perf sched stats: Add basic perf sched stats test
  perf sched stats: Add details in man page

 tools/include/linux/list.h                    |   10 +
 tools/lib/perf/Documentation/libperf.txt      |    2 +
 tools/lib/perf/Makefile                       |    1 +
 tools/lib/perf/include/perf/event.h           |   69 ++
 tools/lib/perf/include/perf/schedstat-v15.h   |  146 +++
 tools/lib/perf/include/perf/schedstat-v16.h   |  146 +++
 tools/lib/perf/include/perf/schedstat-v17.h   |  164 +++
 tools/perf/Documentation/perf-sched.txt       |  261 ++++-
 .../Documentation/perf.data-file-format.txt   |   17 +
 tools/perf/builtin-inject.c                   |    3 +
 tools/perf/builtin-kwork.c                    |   13 +-
 tools/perf/builtin-sched.c                    | 1027 ++++++++++++++++-
 tools/perf/tests/shell/perf_sched_stats.sh    |   64 +
 tools/perf/util/env.h                         |   16 +
 tools/perf/util/event.c                       |   52 +
 tools/perf/util/event.h                       |    2 +
 tools/perf/util/header.c                      |  304 +++++
 tools/perf/util/header.h                      |    6 +
 tools/perf/util/session.c                     |   22 +
 tools/perf/util/synthetic-events.c            |  196 ++++
 tools/perf/util/synthetic-events.h            |    3 +
 tools/perf/util/tool.c                        |   18 +
 tools/perf/util/tool.h                        |    4 +-
 tools/perf/util/util.c                        |   48 +
 tools/perf/util/util.h                        |    5 +
 25 files changed, 2587 insertions(+), 12 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-v15.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-v16.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-v17.h
 create mode 100755 tools/perf/tests/shell/perf_sched_stats.sh

-- 
2.43.0


