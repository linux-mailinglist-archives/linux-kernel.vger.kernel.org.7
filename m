Return-Path: <linux-kernel+bounces-799854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D77A6B430FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610061895DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E431A9F88;
	Thu,  4 Sep 2025 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ER645KWH"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC2DBA4A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959343; cv=fail; b=iWn/nfRYj8Z55cGC8aYkOLLO6GnFCq+btXA/f+X6cSFy8ie2AXk16naaVH06+vnRGyyFpPiNM3HnakZMmFBx4TibiHp1OZH5mCgmfif1voH0UzqBR1tInNQluRJLu6AYCWKgveSzRPpRpR6QPNAwtFwd9a18tJUK4WDEO6CvO7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959343; c=relaxed/simple;
	bh=LC90QD+us82Gqiy4kk55VTtCgn1puSwWbxCbEjRLCbg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZGJbt3p07vMGIXfooQl6Nez4uEq/egFuyzeStRDhqX3lxmfLjFna8oHJ/iWcQQPQkqNxiFeFIH9tY0VJ+jPYBcF6iW4XTRiYxky+283oQ/JJXshxs1oY4k/eWVjMI7If3Ybv8bDHsxYpseSeIz2ITM2zy9s1aDNXCgoiLHVPZ4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ER645KWH; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSy03QBoeU2AAKw+mmaQ6jW8VxtrXhrC8ExHj+5Q9z0kuLkA3+k5QVQ0IQKXqA+CmCKglFi4G7ADvB3cFx11nsZgwzPEYSPMyQCEPDL4ibId6SLMHOEre6ml22i5QR+Py7/AjRdk4zSxH1JOeV3aIkx1MdgcajNSIAK32iBnvL2GQPeR1dn6nVkX3SYZySm4XUwisfqnccgdPeVw5U0OC1Lor9QhwcJGUSieZ0ifTTMgfu+OzgdKyRO5xvQsGY/+E/vMC/kFhfj/ZomlTdzSk/jDJrjLKckQjqk6OYcoOAMp6zTeF65U3LKjwe12c7qtJL0rvsTjuBBqUYZCnUwNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuXFvphkQwiRV5d+/vdqUrRtOmPeFgJGc6+QH8wrEmw=;
 b=OO3ZFMao2COoF4To+mkBz44jMN07ShUVEj9OH+4Xv3Ab0kPgveUfZD2+io7dJsggMeRiXhMSHSej3VY+cs9Mciks8EE/0hT4ITLfftHG00uTIpIn2qek7bH69+adjLYAzAjmS5huAiIBYdZWDBJOqxlwNj68faHJOD0akfMkew4JQeIfQyhHNFZcu1B28W1Ne1SvJQkmgYeiYMFEdZSGA53uGga2KrJ+PbcNfQ4IAJIyEc035mIC5D3CuS7VByemo9kZu9ZtY517VUjUqf5kDJo+XVlqJPtNU52h5dXFLl1dZQbBZeqAS6iC2gDWmWytLgs1IBNWGQP0e6wbt/cPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuXFvphkQwiRV5d+/vdqUrRtOmPeFgJGc6+QH8wrEmw=;
 b=ER645KWH7+qD+qU803zKxWI/IWZVojTx71klJJaYBALzrV4eDu5FB9X94OujI6y4viVXkm9Wpgrq6NyIIy95W0YDIhJEIWVFQyTc4eF3rwt7OM9AjcClQzEHdMqsVt8qQ8rDqruW57gH6WlxIMo3xVSviBiR6LBmCvyVeCe9nNg=
Received: from SA0PR11CA0137.namprd11.prod.outlook.com (2603:10b6:806:131::22)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 04:15:35 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::70) by SA0PR11CA0137.outlook.office365.com
 (2603:10b6:806:131::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Thu,
 4 Sep 2025 04:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 04:15:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 23:15:34 -0500
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 21:15:29 -0700
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [RFC PATCH 00/19] sched/fair: Distributed nohz idle CPU tracking for idle load balancing
Date: Thu, 4 Sep 2025 04:14:56 +0000
Message-ID: <20250904041516.3046-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 910ce695-50fd-434d-ecbc-08ddeb69b1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6DMoAhnIlj9A2v+mOTzcgkYtPHdmkIn7jdHU0dNJv5ClCMpnVknjZaXh+R4b?=
 =?us-ascii?Q?cjNvod8xIt40GlO7dVIcHkNqjHuHcIRl1tFOGZTyz2K2eYQr+wO1Yn34xJIe?=
 =?us-ascii?Q?HiD0GDwau4QxjJUMPL7yWJY+nYOPvP8BwloCYPyxZybief9j0+i3IygLoupm?=
 =?us-ascii?Q?wNkZe4vugPXm00Bkfl+xm4vPNJ+1gRFsvI9ozPhTe0o8DjCR/Og02p3FYeQD?=
 =?us-ascii?Q?5yhAkZkHGo5/ledkQ+cTbrc0H+FRmHk5H++BU8Q1Y08MkA/i0wILPy3ZPzxN?=
 =?us-ascii?Q?wGoDTvC3ttkimktRD9zLoLGjLhkf0sqCiAhLNjcoKYzJuMDihHDbcS/rwtpR?=
 =?us-ascii?Q?zWYhjWbDL+01ahsE7TfqTIBnrZMxOvl+jG+fTzWXHpE99gXzLPjdy2V2/sPS?=
 =?us-ascii?Q?ECWtXhe0JazNp/QeyO3AiVMyjXGU34t3AqIMpOjmU6Qx03rzyoODQsXlM5+Q?=
 =?us-ascii?Q?bfKyvdsFEbaK6epDwU8922YnxBKS3lpT6JNtiO/LjQweqgVwPRWTTOfA74O3?=
 =?us-ascii?Q?x26oqQL4va/S3XBgBtvvcG7R7KqtNlW9DmTgJ/ITprJn6tiAme00cVkmJo/o?=
 =?us-ascii?Q?m0ThNtodHOGCFJmeUQujsTRv0lq5xw4rBgvilrtPuVxy/OAKxKuKpPeREWF6?=
 =?us-ascii?Q?WJdqirKr5zyeaKFmZTvVo04a0dz5GYPXBaMD2G69/vl5nML5w3Z9iv7HodZA?=
 =?us-ascii?Q?rtQOT3G74VvI8rvFCW7C37Ig4My5W2kk8Jc+/m3AoWtUGWBwDnDWY9t0uS2R?=
 =?us-ascii?Q?Ys9PH8fMJZJzd5UXS7UmtY+4EtvSBFmT1mJ718oLJueRVQtDgBK+pCyxEvub?=
 =?us-ascii?Q?AwKtafopAjA/rTc9AdF43GgRJWcsL+8jnMGczMgT9nENh1O+ok8jt4/N4QDd?=
 =?us-ascii?Q?AuNVcIz89DLNvDlejjjqTM+gqcsbfEBUq14Rh+n29plYQbkOveNfVpJC87Av?=
 =?us-ascii?Q?e5gmXDT5Kp5GCIb1qYxfjvtGJVRpoBa1S8CBuGvCBGgPvuZjEO0ncNX1es2d?=
 =?us-ascii?Q?cbf0EYbCWb81bllhQY0sR/VrY6EJ4yCiXbvuLdF8eM72BMJewxee2SiYMgzB?=
 =?us-ascii?Q?C9uwRs7YeI4D5oq47jy8uQtWKrcymFUzqn/RT28YOzuqHMtaY5DI0ALPXxiH?=
 =?us-ascii?Q?fCCvlBeV+8Ves6d91OtFcClBOVSLX+DABM/jui5AX7z5M/B14iCkpoAigVL6?=
 =?us-ascii?Q?/LSVb7np3eoUZPfxzAKqo24dt3LPMXCYM18CW37omFvkyqXx24T5H/hynQh1?=
 =?us-ascii?Q?nw0UjG0xJ8zqk3QbH0SOieDmfT5E89dKHgQ+Lx/FfQPbl3XrZ5aN2CMgxeqZ?=
 =?us-ascii?Q?JPgzqLzTxTuSTJYqT0iRwIG3JMqyZZog/epg4FwM4azIWVWHLAMSWjjzGbai?=
 =?us-ascii?Q?84f6VmuJwhAmGM2P3WjRlAJd/ma0iC1USi2eqVm/UacAiInExefooM6QQc5X?=
 =?us-ascii?Q?I9szhxsDoAgzl5iHj96KD3yMWRs5CbY9Spsc2jFfdnLTnFf2aujilKyEFcLK?=
 =?us-ascii?Q?Vmoqaa6nsQE/Mhw6mdrWNOCFXq/PGGqKvT/Eyt256SN4zjibrYVMfWh4ZA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 04:15:34.4081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 910ce695-50fd-434d-ecbc-08ddeb69b1de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766

Hello folks,

Introduction
============

Atomic operations on a single global variable is costly and may result
in noticeable performance overhead as highlighted by reports in
[1][2][3]. Peter noted that the "nohz.idle_cpus_maks" and "nohz.nr_cpus"
can become the next point of contention when reviewing the push based
load balancing series [4] and favored the idea of splitting the global
cpumask and the idle state indicator into per-LLC ones.

Global indicators have a few key advantages, namely:

- It is independent of the sd hierarchy and is not affected by hotplug
  or cpuset activity.

- The implementation is simple. Setting the signal is simple and the
  cpumask traversal is simple.

However, having a distributed tracking infrastructure can significantly
reduce contention when this data is frequently accessed and modified
which will be the case when it is used to implement a push-based load
balancing mechanism for the fair class based off the RFC [5].


Implementation
==============

There are few ideas to split the centralized nohz tracking using the
sched_domain topology, namely:

1. Maintain a cpumask per sd_llc_shared and starting sd_llc, propagate a
   signal up the sched domain hierarchy to indicate the presence of
   "nohz.idle_cpus" in the hierarchy.

   o PROS:

   - Distributed tracking
   - Atomic updates past the LLC level are only done at the boundary
     conditions (#idle_cpus in LLC goes from 0 -> 1 or back from 1 -> 0)
   - During hotplug, the new hierarchy automatically is initialized with
     the correct nohz idle states (idle_cpus, idle_cpus_mask).

   o CONS:

   - If there are multiple PKG/NODE/NUMA levels above the MC domain,
     there can be multiple atomic oprations and in exotic topologies
     with single CPU groups, single CPU transitioning in and out of nohz
     idle frequently can cause a storm of these atomic operations and
     interfere with other CPUs in the same hierarchy.
   - Requires constructing a sd_llc_shared hierarchy to get the full
     view of the system.
   - An equivalent view of "nohz.idle_cpus_mask" needs to be constructed
     by traversing the sd hierarchy.

2. [Implemented in this series] Maintain a cpumask per sd_llc_shared
   keep track of all sd_llc_shared in a global list.

   o PROS:

   - Distributed tracking
   - Atomic updates to the central "nohz.nr_cpus" tracking are only done
     at the boundary conditions when the number of idle_cpus in LLC goes
     from 0 -> 1 or back from 1 -> 0.

   o CONS:

   - Maintaining the central lists of all the "sd->shared" tracking the
     nohz idle states of CPUs in a domain addes more complication in the
     topology bits.
   - Correcting the nohz signals during hotplug or cpuset activity is
     tricky since the local "sd->shared" data can influence the global
     "nohz.nr_doms" indicator.
   - An equivalent view of "nohz.idle_cpus_mask" needs to be constructed
     by traversing the global RCU protected "nohz_shared_list".

Since hotplug and cpuset activities are rare, the latter approach is
implemented as it saves on several atomic operations that can happen
more frequently.


Structure
=========

The series has been divided as follows:

Patch 01-03 - Trivial cleanup and optimization of the current
              infrastructure.
Patch 03-08 - Preparation in topology.c and idle tracking infrastructure
              to support the distributed tracking.
Patch 09-11 - Introduced new members for distributed nohz tracking.
Patch 12-13 - Preparation in fair.c to convert users of
              "nohz.idle_cpus_mask" to use the new infrastructure.
Patch 14-17 - Convert the bits that use the centralized nohz tracking to
              use the distributed version.
Patch 18    - Convert "nohz.nr_cpus" to "nohz.nr_doms" and optimize the
              central tracking to only modify the global count at the
              boundary condition.
Patch 19    - Simple debug patch for sanity testing.


Benchmarking
============

Following are the results from benchmarking on a dual socket 3rd
Generation EPYC system with 128C/256T (Boost on, C2 disabled):

    ==================================================================
    Test          : hackbench
    Units         : Normalized time in seconds
    Interpretation: Lower is better
    Statistic     : AMean
    ==================================================================
    Case:           tip[pct imp](CV)       sd_nohz[pct imp](CV)
     1-groups     1.00 [ -0.00]( 8.58)     0.96 [  3.99]( 5.47)
     2-groups     1.00 [ -0.00]( 3.53)     1.00 [ -0.00]( 3.57)
     4-groups     1.00 [ -0.00]( 1.63)     0.98 [  1.88]( 1.46)
     8-groups     1.00 [ -0.00]( 1.80)     0.99 [  0.68]( 2.12)
    16-groups     1.00 [ -0.00]( 2.95)     1.01 [ -0.75]( 1.78)


    ==================================================================
    Test          : tbench
    Units         : Normalized throughput
    Interpretation: Higher is better
    Statistic     : AMean
    ==================================================================
    Clients:    tip[pct imp](CV)       sd_nohz[pct imp](CV)
        1     1.00 [  0.00]( 1.34)     1.02 [  2.00]( 0.23)
        2     1.00 [  0.00]( 0.65)     1.01 [  1.22]( 0.18)
        4     1.00 [  0.00]( 0.58)     1.00 [  0.17]( 0.77)
        8     1.00 [  0.00]( 0.55)     1.01 [  0.86]( 0.16)
       16     1.00 [  0.00]( 0.52)     0.99 [ -0.59]( 0.66)
       32     1.00 [  0.00]( 1.27)     0.99 [ -1.40]( 2.55)
       64     1.00 [  0.00]( 1.60)     1.00 [ -0.09]( 2.04)
      128     1.00 [  0.00]( 0.14)     1.02 [  1.55]( 0.79)
      256     1.00 [  0.00]( 0.75)     1.01 [  1.00]( 1.28)
      512     1.00 [  0.00]( 0.18)     1.01 [  0.60]( 0.36)
     1024     1.00 [  0.00]( 0.05)     1.01 [  1.47]( 0.44)


    ==================================================================
    Test          : stream-10
    Units         : Normalized Bandwidth, MB/s
    Interpretation: Higher is better
    Statistic     : HMean
    ==================================================================
    Test:       tip[pct imp](CV)       sd_nohz[pct imp](CV)
     Copy     1.00 [  0.00](10.72)     0.97 [ -2.76](11.31)
    Scale     1.00 [  0.00]( 5.00)     0.97 [ -3.14]( 7.20)
      Add     1.00 [  0.00]( 5.75)     0.95 [ -4.71]( 7.33)
    Triad     1.00 [  0.00]( 5.83)     0.97 [ -2.60](10.21)


    ==================================================================
    Test          : stream-100
    Units         : Normalized Bandwidth, MB/s
    Interpretation: Higher is better
    Statistic     : HMean
    ==================================================================
    Test:       tip[pct imp](CV)       sd_nohz[pct imp](CV)
     Copy     1.00 [  0.00]( 2.31)     1.01 [  0.72]( 1.21)
    Scale     1.00 [  0.00]( 4.58)     1.00 [  0.44]( 4.69)
      Add     1.00 [  0.00]( 1.12)     0.99 [ -0.54]( 4.21)
    Triad     1.00 [  0.00]( 2.21)     0.98 [ -1.82]( 5.94)


    ==================================================================
    Test          : netperf
    Units         : Normalized Througput
    Interpretation: Higher is better
    Statistic     : AMean
    ==================================================================
    Clients:         tip[pct imp](CV)       sd_nohz[pct imp](CV)
     1-clients     1.00 [  0.00]( 0.86)     1.01 [  0.71]( 0.45)
     2-clients     1.00 [  0.00]( 0.56)     1.01 [  0.86]( 0.63)
     4-clients     1.00 [  0.00]( 0.50)     1.01 [  0.74]( 0.48)
     8-clients     1.00 [  0.00]( 0.70)     1.01 [  0.61]( 0.39)
    16-clients     1.00 [  0.00]( 0.44)     1.00 [  0.49]( 0.57)
    32-clients     1.00 [  0.00]( 0.54)     1.00 [  0.16]( 0.90)
    64-clients     1.00 [  0.00]( 1.66)     1.00 [  0.45]( 1.42)
    128-clients    1.00 [  0.00]( 1.12)     1.01 [  0.57]( 0.91)
    256-clients    1.00 [  0.00]( 3.98)     0.98 [ -1.70]( 4.77)
    512-clients    1.00 [  0.00](51.74)     0.97 [ -2.58](44.26)


    ==================================================================
    Test          : schbench
    Units         : Normalized 99th percentile latency in us
    Interpretation: Lower is better
    Statistic     : Median
    ==================================================================
    #workers: tip[pct imp](CV)       sd_nohz[pct imp](CV)
      1     1.00 [ -0.00](15.32)     1.00 [ -0.00]( 8.79)
      2     1.00 [ -0.00](19.67)     1.00 [ -0.00](10.14)
      4     1.00 [ -0.00](13.01)     1.06 [ -6.38](15.61)
      8     1.00 [ -0.00](10.33)     0.98 [  1.79]( 3.21)
     16     1.00 [ -0.00]( 5.00)     1.02 [ -1.67]( 2.79)
     32     1.00 [ -0.00]( 1.05)     1.01 [ -1.05]( 8.56)
     64     1.00 [ -0.00]( 2.37)     0.94 [  5.67]( 0.83)
    128     1.00 [ -0.00](13.58)     0.90 [  9.98]( 6.67)
    256     1.00 [ -0.00](34.92)     1.88 [-88.43](12.68)
    512     1.00 [ -0.00]( 1.72)     1.03 [ -2.57]( 1.26)


    ==================================================================
    Test          : new-schbench-requests-per-second
    Units         : Normalized Requests per second
    Interpretation: Higher is better
    Statistic     : Median
    ==================================================================
    #workers: tip[pct imp](CV)       sd_nohz[pct imp](CV)
      1     1.00 [  0.00]( 0.15)     1.00 [ -0.30]( 0.55)
      2     1.00 [  0.00]( 0.30)     1.01 [  0.59]( 0.15)
      4     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.15)
      8     1.00 [  0.00]( 0.15)     1.00 [  0.29]( 0.00)
     16     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)
     32     1.00 [  0.00]( 3.80)     1.05 [  4.86]( 0.55)
     64     1.00 [  0.00]( 0.20)     0.99 [ -0.76]( 5.08)
    128     1.00 [  0.00]( 0.20)     1.00 [  0.38]( 0.20)
    256     1.00 [  0.00]( 0.70)     1.02 [  2.50]( 0.63)
    512     1.00 [  0.00]( 0.25)     1.01 [  0.95]( 0.00)


    ==================================================================
    Test          : new-schbench-wakeup-latency
    Units         : Normalized 99th percentile latency in us
    Interpretation: Lower is better
    Statistic     : Median
    ==================================================================
    #workers: tip[pct imp](CV)       sd_nohz[pct imp](CV)
      1     1.00 [ -0.00](13.47)     1.14 [-14.29](11.92)
      2     1.00 [ -0.00](16.40)     1.12 [-12.50]( 0.00)
      4     1.00 [ -0.00]( 9.94)     0.89 [ 11.11](11.92)
      8     1.00 [ -0.00]( 5.53)     1.11 [-11.11](14.13)
     16     1.00 [ -0.00](13.22)     1.00 [ -0.00]( 0.00)
     32     1.00 [ -0.00](11.71)     0.83 [ 16.67]( 0.00)
     64     1.00 [ -0.00]( 3.87)     1.08 [ -7.69]( 6.39)
    128     1.00 [ -0.00]( 3.51)     0.98 [  1.56]( 4.83)
    256     1.00 [ -0.00]( 4.91)     1.18 [-17.95]( 8.31)
    512     1.00 [ -0.00]( 0.20)     1.00 [ -0.39]( 0.20)


    ==================================================================
    Test          : new-schbench-request-latency
    Units         : Normalized 99th percentile latency in us
    Interpretation: Lower is better
    Statistic     : Median
    ==================================================================
    #workers: tip[pct imp](CV)       sd_nohz[pct imp](CV)
      1     1.00 [ -0.00]( 0.13)     0.98 [  1.78]( 2.11)
      2     1.00 [ -0.00]( 0.13)     0.94 [  6.11]( 2.83)
      4     1.00 [ -0.00]( 2.40)     0.96 [  3.82]( 1.21)
      8     1.00 [ -0.00]( 0.00)     0.96 [  3.82]( 0.55)
     16     1.00 [ -0.00]( 2.88)     0.99 [  1.32]( 1.20)
     32     1.00 [ -0.00](12.96)     0.89 [ 11.17]( 2.34)
     64     1.00 [ -0.00]( 4.80)     0.99 [  0.88]( 5.56)
    128     1.00 [ -0.00]( 2.49)     1.02 [ -1.81]( 2.72)
    256     1.00 [ -0.00]( 3.95)     1.12 [-11.52]( 7.78)
    512     1.00 [ -0.00]( 0.88)     1.00 [ -0.00]( 1.02)


    ==================================================================
    Test          : Various longer running benchmarks
    Units         : %diff in throughput reported
    Interpretation: Higher is better
    Statistic     : Median
    ==================================================================
    Benchmarks:                  %diff
    ycsb-cassandra               1.36%
    ycsb-mongodb                -1.66%
    deathstarbench-1x            0.04%
    deathstarbench-2x           -0.10%
    deathstarbench-3x            3.84%
    deathstarbench-6x            1.54%
    hammerdb+mysql 16VU          0.03%
    hammerdb+mysql 64VU          1.22%


The schbench datapoints were rerun to discover the regressions are
mostly the result of run-to-run variance. All the datapoints have
noticeable variance and the results can swing either way depending on
the noise in the system.


References
==========

[1] https://lore.kernel.org/lkml/20240531205452.65781-1-tim.c.chen@linux.intel.com/
[2] https://lore.kernel.org/lkml/20250416035823.1846307-1-tim.c.chen@linux.intel.com/
[3] https://lore.kernel.org/lkml/20250423174634.3009657-1-edumazet@google.com/
[4] https://lore.kernel.org/lkml/20250410102945.GD30687@noisy.programming.kicks-ass.net/
[5] https://lore.kernel.org/lkml/20250409111539.23791-1-kprateek.nayak@amd.com/

This series was tested on tip:sched/core at commit 1b5f1454091e
("sched/idle: Remove play_idle()") with commit 99b773d720ae ("sched/psi:
Fix psi_seq initialization") fron v6.17-rc1 cherry-picked on top.

CONFIG_HZ_PERIODIC was only build and boot tested.

The series is based on tip:sched/coreat commit 5b726e9bf954
("sched/fair: Get rid of throttled_lb_pair()")

Special thanks to Gautham for his help with the tricky bits and an early
review of the series.

---
K Prateek Nayak (19):
  sched/fair: Simplify set_cpu_sd_state_*() with guards
  sched/topology: Optimize sd->shared allocation and assignment
  sched/fair: Use rq->nohz_tick_stopped in update_nohz_stats()
  sched/fair: Use xchg() to set sd->nohz_idle state
  sched/topology: Attach new hierarchy in rq_attach_root()
  sched/fair: Fixup sd->nohz_idle state during hotplug / cpuset
  sched/fair: Account idle cpus instead of busy cpus in sd->shared
  sched/topology: Introduce fallback sd->shared assignment
  sched/topology: Introduce percpu sd_nohz for nohz state tracking
  sched/topology: Introduce "idle_cpus_mask" in sd->shared
  sched/topology: Introduce "nohz_shared_list" to keep track of
    sd->shared
  sched/fair: Reorder the barrier in nohz_balance_enter_idle()
  sched/fair: Extract the main _nohz_idle_balance() loop into a helper
  sched/fair: Convert find_new_ilb() to use nohz_shared_list
  sched/fair: Introduce sched_asym_prefer_idle() for ILB kick
  sched/fair: Convert sched_balance_nohz_idle() to use nohz_shared_list
  sched/fair: Remove "nohz.idle_cpus_mask"
  sched/fair: Optimize global "nohz.nr_cpus" tracking
  sched/topology: Add basic debug information for "nohz_shared_list"

 include/linux/sched/topology.h |  14 +-
 kernel/sched/core.c            |   2 +-
 kernel/sched/fair.c            | 432 ++++++++++++++++++++++++---------
 kernel/sched/sched.h           |   6 +-
 kernel/sched/topology.c        | 381 +++++++++++++++++++++++++----
 5 files changed, 663 insertions(+), 172 deletions(-)


base-commit: 5b726e9bf9544a349090879a513a5e00da486c14
-- 
2.34.1


