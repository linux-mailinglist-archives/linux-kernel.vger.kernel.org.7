Return-Path: <linux-kernel+bounces-769176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C6EB26B13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B385B7A7E76
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64833225402;
	Thu, 14 Aug 2025 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qJDOxJhb"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F91862
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185623; cv=fail; b=qWmdrsskns1j5PUmS09zDczrPPeKQMrWm29tnhYWfLvCtMsdJbEcvR+8yD1crrjalMsJ0AsVHi8p/xX6jFcCicolArDOoYOo3k1PYfWisCST6bAo8mbSWSVVHY3IYIoE8HpVHZfzGxvU2ksTbebJev4qqiHktrcnTThvuAr8c2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185623; c=relaxed/simple;
	bh=vW09pI74/2jNKXvRWKn5SAduNMvsnxHFx/XttXiUMd4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y5ACgGHb/HV/IqbhGPdNck5Y2rlzqh+FUXf4Z/J1EQDtSNtXHFyktWN41yo56qkrrmoqe+x3zQqifVn/ND1S+VEmdnw8y/YAvgDeTSMzS1cLidx4N3zYTPN2dGUHRZacdZmXJmlzCl2APp7TkFCzhMqEVe4yBQpwvRpfjsp0Vds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qJDOxJhb; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nc7l5OW56vUVmKcu0yLN2yBWSF1SBx/HdjxKFb6R9JUfVq/tWv1hn4wfz6do2hB3bWKuTQecULITWsWSWUrYZ0A9lDYH+VZZ8vT8upoHfPsVP7nOnnthUyUfAyBvKle0qnhELeZNYLyH7c2udS3/KOS9mt/1FKND00Xsjw37terfCFrsI1RvEu6L3k6VZ4bga4cIR0oJ91VUHq+2NUQ99PRDzclNgLmgR598b+6FuF2zPZ92A0HdI958q4VACwweVu/bXp8GuW0pGkr4wyGPEhNsAHvuZ7Guk2n34kLNdnzk7LuSDhvk0ZgPkh8ItkokbjLmjO3fRdiOsgjNy7jvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGE2DJS2OcZ1YYW2CRsS8unO2SfFvd01Lvw9o6ftf1c=;
 b=PtKZHhcZVlCDM8q/bbR1/inFiLq+B9YRrv1934D43OpppUadKO4xojHDtLocvxvL+EDqCynBF35sr1S7k500GPaSf4jnjZyqLVg/x5UhJsvRaC1GZBu/T1eiNaz2irYfzKtfl/fl+Xc60knaJ9rFzQHHNQuwSebI3zWvhFyb6tG3/U64VUvvs52xrRyCdljwI10oC9RZPnxbRLNUJXb1AvHiulFi7QYoXLUnIVmKIFHLMJlCEKPE1/REglnK9kUV9Mi4nnXVrOGNp1e4d0cAqOHcCO0H9ncfyhKSzMCP5OESKHQv0OsdCbfPeOz22m4Uts56rsU4rxyfL8JjK9axIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGE2DJS2OcZ1YYW2CRsS8unO2SfFvd01Lvw9o6ftf1c=;
 b=qJDOxJhbo3uCtFq82KJ5aIf/gsPBzCBVoJ83pfMsE1ObcW6dWn5IXv5nZBzbqgPUO16uaTvQ9fpGNa76lUHsFRLbHYLkmNT9Asu/68KIeKHcHXaZsf7TvOD9ZfpFOKDdHkajTgHVcVI3QS5cLbWtt3mevbj6aJ95jd/BC/wazc8=
Received: from BN9PR03CA0371.namprd03.prod.outlook.com (2603:10b6:408:f7::16)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 15:33:36 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::1f) by BN9PR03CA0371.outlook.office365.com
 (2603:10b6:408:f7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 15:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 15:33:36 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:33:21 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Michael.Day@amd.com>,
	<akpm@linux-foundation.org>, <bharata@amd.com>, <dave.hansen@intel.com>,
	<david@redhat.com>, <dongjoo.linux.dev@gmail.com>, <feng.tang@intel.com>,
	<gourry@gourry.net>, <hannes@cmpxchg.org>, <honggyu.kim@sk.com>,
	<hughd@google.com>, <jhubbard@nvidia.com>, <jon.grimm@amd.com>,
	<k.shutemov@gmail.com>, <kbusch@meta.com>, <kmanaouil.dev@gmail.com>,
	<leesuyeon0506@gmail.com>, <leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <nadav.amit@gmail.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <riel@surriel.com>,
	<rientjes@google.com>, <rppt@kernel.org>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
	<yuanchu@google.com>, <kinseyho@google.com>, <hdanton@sina.com>,
	<harry.yoo@oracle.com>
Subject: [RFC PATCH V3 00/17] mm: slowtier page promotion based on PTE A bit
Date: Thu, 14 Aug 2025 15:32:50 +0000
Message-ID: <20250814153307.1553061-1-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: cadffb43-47d0-4ca1-33d3-08dddb47ef8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VkHeIklZwQX+EdPcl9mGICTKACzpiCO9GiRHM9DCZTMXtQKq+PIiK9+CfX5K?=
 =?us-ascii?Q?eiiIZrIyX2F9lN+bDE9Abjuo2scKPV9RBHNYzowEBrtAbk+GcDnS5hU6n0zI?=
 =?us-ascii?Q?EsQtOQk2vybGAiepaZ6cLTzWHgQSxid85w+oNENupnFZMLXUjkW7t0AQ9hs+?=
 =?us-ascii?Q?h3UyE3mwhLV3SQOBkIVFJ+ObJDdCyoCmKQv0D8rgv1fCZGR+mP231BmiocEm?=
 =?us-ascii?Q?ECVQuOTy4loQpch+ZTTjqb+DOUe1MGhKaHqWuGdkWt4AbanhqEAbDgYlKga9?=
 =?us-ascii?Q?VyZ90MlpRrrKpsaiHAF3JWPpOVbA7rDYWzP3FAVTZPvlRTsV/Q2IAhVEPMic?=
 =?us-ascii?Q?4PX8M98ZzY2jIgysW1rC/VE/e4sLC8F/hIfbRs5LDWy/sIW839ycitbfpsOl?=
 =?us-ascii?Q?cpir2/2f8YzB2pFrTrb1Kf4hzOTYtyl/0HVhpobXMmlVkAyW0/Mfm2dNbWvb?=
 =?us-ascii?Q?vEIizYlBYA6WAzsYd6Uj7j3GFEK60hZmBdZqSrySQC3E61Hlk0LUug2eqzao?=
 =?us-ascii?Q?/Iq02dhXFFAJ1fIiprlY56cnui1pN1/bANGMzSCAiiy2tskbgzdS/HgyHfXp?=
 =?us-ascii?Q?p60odAXjhy/k9RZQtyie5bsKYAMBjrFdDReM+QFSsO96yGhYW9Mh0ybslTYi?=
 =?us-ascii?Q?tMufN6K/x3kWJaVkPGBTDmiQhHnGLYA4x1eLA+Y/I4tLHlq4jXFZVWMYn7i+?=
 =?us-ascii?Q?B14akXEVFAbM63hapZMhn282B3/Y7SIy8Sk+HTvKoiU50EoZNR+/oj1uBku4?=
 =?us-ascii?Q?nE5APMv+fqqU1QVqKHubrYgLc74Jk/FA6VbCrNlJ8pG/qYzgPN92F2eBNZms?=
 =?us-ascii?Q?qBAVUPTsuURA+LfN6bDyr5aV8N6sJLItwEmJzShmRQDRSN5zyUW8XmSaZMAS?=
 =?us-ascii?Q?YtAe3ip+I2cRYGrc0INoIu4wIrkKdbwEpxtnnk7tyxz8rkxGMfjQjTs1XJg/?=
 =?us-ascii?Q?Gw9eBjc7SIXKZA+Xdl0zGyVeJsXm2q17IvYwJR1SUgHpp/xYRrEPjgT3u3WR?=
 =?us-ascii?Q?w6whIPxMoFBSqbWJH4rtj+Pv55QmYFJd/6N8FlYprFfEyW3Eo3t/b1Q9E6cK?=
 =?us-ascii?Q?aefHUUAc+sdTG0liHevMekpxmUps25wuQ3ZLmWwstZT1bFIBdHZxO88if2g5?=
 =?us-ascii?Q?yePaS0xkaqYH0KtrvXtNNOLBalYm83i7alUMk3QNrTAxRmoWzdNRYCT5z8Ya?=
 =?us-ascii?Q?yAV6kJFyMYCRu6Qjg1jEEkO6WD7LPJ534e2pjE0PKNchHA833zsmPJIAPWFL?=
 =?us-ascii?Q?66kzysHhhtw+5pkWu/gpsOEMvjND58WbN3yNsyUy8k2HdfMl6kL4T4no5QnA?=
 =?us-ascii?Q?DPmfVCWpAlUf5YWC0A2r1xd7ObVh5c1lEGahsl4gBqVSMFyCMHgd6uA0pY33?=
 =?us-ascii?Q?VP5rIV9uwEgMM+68oN3obVcc00QT9o1bglOcIoia8xMc7euyqoGSJfXZmtyV?=
 =?us-ascii?Q?/bgVwqjQg71EDJ8b+AFNb0WOSW6tE43eA1YUeIneY5unUJi33o/T7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:33:36.4215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cadffb43-47d0-4ca1-33d3-08dddb47ef8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

The current series has additional enhancements and comments' incorporation on top of
RFC V2.

This is an additional source of hot page generator to NUMAB, IBS [4], KMGLRUD [5].

Introduction:
=============
In the current hot page promotion, all the activities including the
process address space scanning, NUMA hint fault handling and page
migration is performed in the process context. i.e., scanning overhead is
borne by applications.

This RFC V2 patch series does slow-tier page promotion by using PTE Accessed
bit scanning. Scanning is done by a global kernel thread which routinely
scans all the processes' address spaces and checks for accesses by reading
the PTE A bit.

A separate migration thread migrates/promotes the pages to the top-tier
node based on a simple heuristic that uses top-tier scan/access information
of the mm.

Additionally based on the feedback, a prctl knob with a scalar value is
provided to control per task scanning.

Changes Since RFC V2:
===================
 - Enhanced logic to migrate on second access.

 - Using prctl scalar value to further tune the scanning efficiency.

 - Using of PFN instead of folio to record hot pages for easy integration
with kpromoted/kmigrated [4].

 - Rebasing on top of fork/exec changes in v6.16.

 - Revisiting mm_walk logic and folio validation based on Harry's comments.

 - Feedback from migration system to slowdown scanning when more migration failures
 happen.

 - Masami's comment on trace patch.

 - Bug fix to overnight idle system  crash due to incorrect kmemcache usage.

 - Enhanced target node finding logic to further obtain fallback nodes to migrate.
(TBD: This needs followup patch that actually does migration to fallback target nodes)

Changes since RFC V1:
=====================
- Addressing the review comments by Jonathan (Thank you for your closer
 reviews).

- Per mm migration list with separate lock to resolve race conditions/softlockups
reported by Davidlohr.

- Add one more filter before migration for LRU_GEN case to check whether
 folio is still hot.

- Rename kmmscand ==> kscand kmmmigrated ==> kmigrated (hopefully this
 gets merged into Bharat's upcoming migration thread)

Changes since RFC V0:
======================
- A separate migration thread is used for migration, thus alleviating need for
  multi-threaded scanning (at least as per tracing).

- A simple heuristic for target node calculation is added.

- prctl (David R) interface with scalar value is added to control per task scanning.

- Steve's comment on tracing incorporated.

- Davidlohr's reported bugfix.

- Initial scan delay similar to NUMAB1 mode added.

- Got rid of migration lock during mm_walk.

A note on per mm migration list using mm_slot:
=============================================
Using per mm migration list (mm_slot) has helped to reduce contention
 and thus easing mm teardown during process exit.

It also helps to tie PFN/folio with mm to make heuristics work better
 and further it would help to throttle migration per mm (OR process) (TBD).

A note on PTE A bit scanning:
============================
Major positive: Current patchset is able to cover all the process address
 space scanning effectively with simple algorithms to tune scan_size and
 scan_period.

Thanks to Jonathan, Davidlohr, David, Harry, Masami Steve for review feedback on RFCs.

Future plans:
================
Evaluate how integration with hotness monitoring subsystem works, OR
as a standalone integration with kmigrated API* of [4]

Results:
=======
Benchmark Cbench (by Bharata) to evaluate performance promotion in
slowtier system.

Benchmark allocates memory on both regular NUMA node and  slowtier node,
then does continuous access.
Goal: Finishing fixed numaber of access in less time

SUT: Genoa+ EPYC system

base 6.16 NUMAB2 (because this has the best perf)
patched 6.16 + current series

Time taken in sec (lower is better)
               base           patched
8GB            228            206
32GB           547            534
128GB          1100           920

Links:
[1] RFC V0: https://lore.kernel.org/all/20241201153818.2633616-1-raghavendra.kt@amd.com/
[2] RFC V1: https://lore.kernel.org/linux-mm/20250319193028.29514-1-raghavendra.kt@amd.com/
[3] RFC V2: https://lore.kernel.org/linux-mm/20250624055617.1291159-1-raghavendra.kt@amd.com/
[4] Hotpage detection and promotion: https://lore.kernel.org/linux-mm/20250814134826.154003-1-bharata@amd.com/T/#t
[5] MGLRU: https://lkml.org/lkml/2025/3/24/1458

Patch organization:
patch 1-5 initial skeleton for scanning and migration
patch 6: migration
patch 7-9: scanning optimizations
patch 10: target_node heuristic
patch 11: Migration failure feedback
patch 12-14: sysfs, vmstat and tracing
patch 15-16: prctl implementation and enhancements to scanning.
patch17: Fallback target node finding

Raghavendra K T (17):
  mm: Add kscand kthread for PTE A bit scan
  mm: Maintain mm_struct list in the system
  mm: Scan the mm and create a migration list
  mm/kscand: Add only hot pages to migration list
  mm: Create a separate kthread for migration
  mm/migration: migrate accessed folios to toptier node
  mm: Add throttling of mm scanning using scan_period
  mm: Add throttling of mm scanning using scan_size
  mm: Add initial scan delay
  mm: Add a heuristic to calculate target node
  mm/kscand: Implement migration failure feedback
  sysfs: Add sysfs support to tune scanning
  mm/vmstat: Add vmstat counters
  trace/kscand: Add tracing of scanning and migration
  prctl: Introduce new prctl to control scanning
  prctl: Fine tune scan_period with prctl scale param
  mm: Create a list of fallback target nodes

 Documentation/filesystems/proc.rst |    2 +
 fs/proc/task_mmu.c                 |    4 +
 include/linux/kscand.h             |   30 +
 include/linux/migrate.h            |    2 +
 include/linux/mm.h                 |   13 +
 include/linux/mm_types.h           |    7 +
 include/linux/vm_event_item.h      |   12 +
 include/trace/events/kmem.h        |   99 ++
 include/uapi/linux/prctl.h         |    7 +
 kernel/fork.c                      |    6 +
 kernel/sys.c                       |   25 +
 mm/Kconfig                         |    8 +
 mm/Makefile                        |    1 +
 mm/internal.h                      |    1 +
 mm/kscand.c                        | 1754 ++++++++++++++++++++++++++++
 mm/migrate.c                       |    2 +-
 mm/mmap.c                          |    2 +
 mm/vma_exec.c                      |    3 +
 mm/vmstat.c                        |   12 +
 19 files changed, 1989 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/kscand.h
 create mode 100644 mm/kscand.c


base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
-- 
2.34.1


