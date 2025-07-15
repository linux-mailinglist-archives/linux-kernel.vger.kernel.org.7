Return-Path: <linux-kernel+bounces-731161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E0DB0502B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2037F1AA579A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF7E26E705;
	Tue, 15 Jul 2025 04:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5gYIKNQu"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FBA2D23A4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552534; cv=fail; b=hpzxjLlQKJotgWFHQD+MRYc8xdB+MJ3OZiJhLZ26XDuxLDCly3yIDapGjhYfcOx7XFXTLIN8x7h5vlmD8qGPArK2Ukc2SH9Y17H0UXFNoM5o7ANvOFljNJq6jsfk36BUWhS9QIZdL89c5BG3jc8GUg+8gaaHSFVtkkbrb+dKpx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552534; c=relaxed/simple;
	bh=PxfsyUDRHUVe+3nnzcpHia5WN5dXxCiFe9YlwCPNPOs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZhUKnjEzcmvaEcu+rxWzEXrjoQq3uhjVEhnYOQ6LaieUQ0HmfahYGSMoEqRa39B7ezfHwJTi1cYJco2/4EfCGNRFHY9EDiDl6ysoZVOBYufFXHLd3bYfisNfrb7I/2S+BCN/RFn67LGyyPMdqwVAtqZXxObn8PaLzT4byBs7JDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5gYIKNQu; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTCYJvlU3VjE0cx8xOvkiL3cPwcDslo+e0a2b7lHJnkKeKX/tvfwLAjXEM3cFNGmC/dzVHuillsvneFC+4nsjk3+xDopu2xzcKZT6DF6UHyVHTosvmYhJYRTmkrgiGCJ/Wq9Vo+UvTU4nP5nuT99m+CpzcSWke/nJsMzEychx+J20kPDr7k5NrymnKDSksXpuB1bYczO0zdsYyHg1wNTpPbtaW/KcdlCWNWf09E5iWiq6YkBzoGQ/kULDcUOq5S10tLOe3pSZppnnDWSowRpLUGkLYuzV9yCATcqw0Ln6v1BefO4tT67TMXj0Y7q2Kj9zI/yh16O4j1MERY2yNGGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygYsE/ohGA2csej/FzS8oK5GUb5qMINEcyuczjCIc1A=;
 b=B5HaxnfknsRTiAUT5PW8Fc8Q0zfqAlwVi2Au/P0anlvX3d6522SN5iDbiXmCqE0Hrj+InlktHq3qWQV9d93CTjdZ0CobJa3N2bTeJNbgR6FbIzAW5PP9nfvvJV/LepIg+sO1ibHId68gEAj7xBs5BMPhGZPAnIvSw/N77U6ieluAm+lvx1feHkk9EuH4ITOP2akMHHSlXoXvJQs6R2BUPV5OX3gaBdegN5qWZAxVFfKPGzK0dZ2/toO/gPPFtMdyLJgy1DQ/L7nhHtpOn8qj/PryLaHAt7XXMOFwCy6ih5t7XPEbBeh2h1o2d90n+z4UyEXrEsqidrFSRNQhak8GNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygYsE/ohGA2csej/FzS8oK5GUb5qMINEcyuczjCIc1A=;
 b=5gYIKNQuyGw4Udtwn9tfbF/mZspKdWUdRnkL2Kw5Pmy1zOfCCuIQFOgp+/tcQbxmb9oXzfgLHgXK0ICHvswNpGyyasbru6YmmUK7dgRmRWp5f60h4FofDo2jpUeGBHx3yU71v9RP7aSTBuPjLFz+lPJ7PEd63OraIUGTLD9Qr3I=
Received: from BYAPR11CA0038.namprd11.prod.outlook.com (2603:10b6:a03:80::15)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 15 Jul
 2025 04:08:45 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::8a) by BYAPR11CA0038.outlook.office365.com
 (2603:10b6:a03:80::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 04:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 04:08:45 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Jul
 2025 23:08:40 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Valentin Schneider <vschneid@redhat.com>, "Leon
 Romanovsky" <leon@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@alien8.de>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>
Subject: [PATCH v5] sched/fair: Use sched_domain_span() for topology_span_sane()
Date: Tue, 15 Jul 2025 04:08:24 +0000
Message-ID: <20250715040824.893-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7bc08a-3c89-45cb-5cf0-08ddc3554afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Se+gVhedpe6EwSKflsc4GGMAJpNziCZ9EL9isQSRAYUoQAt6D/+gE7j4pjGF?=
 =?us-ascii?Q?+gcbF6jeerUqtk/JeAq66gQuTqtO8A0dlELRSA1qtXRMPpc2XkP6oMqnIzWn?=
 =?us-ascii?Q?Nxtgo6x9i7AdSiNyjBOZJ9SImAlDonYg9+ueQQUww/sz5qK9TOD0sZPJmWoB?=
 =?us-ascii?Q?bOxc4I53j767cDJEj4vDtx5QLHJsVj40KBKFKG6Yw4Gx+Koi3W9V2fPLzXmf?=
 =?us-ascii?Q?ngolUJkcIt/lXFHZN8dOLNJ2RgV8cUQCeIbtr9M5jHYecSjcSGkOH9pTeM6c?=
 =?us-ascii?Q?v4LUADwjRzbK3TQB/A8/Y8O5Fl9aycYTqJ/pOJPeQYFye+mg/HsKNfxXb6Eg?=
 =?us-ascii?Q?nB320sghWQQtyB2OmRQXfb5rAmtoaoDZ80FFjMGBrocXAdBRSC5BkOxRKgHw?=
 =?us-ascii?Q?VYsd5WqS1CgDhPiJ7DHtYUWpzg/wdWGBK4B05S3uxC8LHJFzeeBgYo5eQ4Fz?=
 =?us-ascii?Q?JW3xafZbp91+j3bJarK+sz8/xOkx70ogMj0j0d94hPlk5mqc38LI/njPHFF+?=
 =?us-ascii?Q?HWOyHsTxwLkj7CgNkBepCrhte2YcLOETWyigZnzZxchcdH+6TA2dRrQIox6V?=
 =?us-ascii?Q?gZDSjRjsXWkp/nA/fp6E6/HybYebqwAmIAJsRlLbjMzVYDkwq1k7N24kueCp?=
 =?us-ascii?Q?01TyckL+F3t00IejqJoA70nUPLMSEGikr+OSuNviiXak37gMu3CDeNjJWjUE?=
 =?us-ascii?Q?N3ymrCSKyvy/UxULftx/+nY67SGOzQbUF+ml1PrLl3/rQNB4PoZtn5T37CnN?=
 =?us-ascii?Q?6Um2eVjICOe44NPc80yJWogp867BzeWfdplAbr4tqQqAcJsfJ2jTj+d+SZty?=
 =?us-ascii?Q?5KjL0W0lpS5CDnoRE7Rm9mCMfdbONm+Wna1rb/DnKYI1SDoMN8UgdjcW6Q8/?=
 =?us-ascii?Q?FrZa9PwB5ENiH02LEmlF2UiTjShd2uDsTvO1jeisIqQ3hF0rMXulSqMSYs2+?=
 =?us-ascii?Q?yCiprzYWdBm5UR+80UlCqQifxKwccfnS8Fa4sE+Co7Twb3UhpCoB/uYoQPbZ?=
 =?us-ascii?Q?E9KynNP2GkWIOJHjYc9jCbxqUlD2GuYjF1kytYXlOFeit0h6Hm2Z39jnINA3?=
 =?us-ascii?Q?18035nmXvy6WkD0JCeGtgyjaU/6mw8R1yrNB5MWi7BiyXSl9obWxuf/gSbpl?=
 =?us-ascii?Q?nq/Uv/q8TqSv7vslR56M4wAzmGK5CzPjE/smP3Ga2V0dG4ckz8PXjJ3cqrCo?=
 =?us-ascii?Q?34vV203/uc8DrYB/V9w7Q+0AXrTDGA7B+jRZlmy8/bhDsDVtny8dvf2+93ie?=
 =?us-ascii?Q?ily3LgSxG2xoVlRHg7YkxY3gALZLutZzey9K47Mf1SmnP7MOofkkMhMXVbLL?=
 =?us-ascii?Q?Vda5oJrXKXZR/DYHeT1eMsZSENv7/CtpEGWhGLNCVrtMyxnfhDvnNZOy5osy?=
 =?us-ascii?Q?wWAbJMcy9JgV+OIviQDiFNBeTGGHqiZyeiQDu+WIa9ZZ+5KxEtyFKTfNJ5XR?=
 =?us-ascii?Q?GVjOvcvQPr7RUaC5lzRmqwqd62GP0z8BA+cihKChrqv/uKgJcfOtCPG8yDJE?=
 =?us-ascii?Q?75p2agKxjGrT+u8wTOTi90nGizDd4/567FqmUdEn8VjnI5RB9FyoRa3d0g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 04:08:45.3219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7bc08a-3c89-45cb-5cf0-08ddc3554afb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153

Leon noted a topology_span_sane() warning in their guest deployment
starting from v6.16-rc1 [1]. Debug that followed pointed to the
tl->mask() for the NODE domain being incorrectly resolved to that of the
highest NUMA domain.

tl->mask() for NODE is set to the sd_numa_mask() which depends on the
global "sched_domains_curr_level" hack. "sched_domains_curr_level" is
set to the "tl->numa_level" during tl traversal in build_sched_domains()
calling sd_init() but was not reset before topology_span_sane().

Since "tl->numa_level" still reflected the old value from
build_sched_domains(), topology_span_sane() for the NODE domain trips
when the span of the last NUMA domain overlaps.

Instead of replicating the "sched_domains_curr_level" hack, Valentin
suggested using the spans from the sched_domain objects constructed
during build_sched_domains() which can also catch overlaps when the
domain spans are fixed up by build_sched_domain().

Since build_sched_domain() is skipped when tl->mask() of a child domain
already covers the entire cpumap, skip the domains that have an empty
span.

The original warning was reproducible on the following NUMA topology
reported by Leon:

    $ sudo numactl -H
    available: 5 nodes (0-4)
    node 0 cpus: 0 1
    node 0 size: 2927 MB
    node 0 free: 1603 MB
    node 1 cpus: 2 3
    node 1 size: 3023 MB
    node 1 free: 3008 MB
    node 2 cpus: 4 5
    node 2 size: 3023 MB
    node 2 free: 3007 MB
    node 3 cpus: 6 7
    node 3 size: 3023 MB
    node 3 free: 3002 MB
    node 4 cpus: 8 9
    node 4 size: 3022 MB
    node 4 free: 2718 MB
    node distances:
    node   0   1   2   3   4
      0:  10  39  38  37  36
      1:  39  10  38  37  36
      2:  38  38  10  37  36
      3:  37  37  37  10  36
      4:  36  36  36  36  10

The above topology can be mimicked using the following QEMU cmd that was
used to reproduce the warning and test the fix:

     sudo qemu-system-x86_64 -enable-kvm -cpu host \
     -m 20G -smp cpus=10,sockets=10 -machine q35 \
     -object memory-backend-ram,size=4G,id=m0 \
     -object memory-backend-ram,size=4G,id=m1 \
     -object memory-backend-ram,size=4G,id=m2 \
     -object memory-backend-ram,size=4G,id=m3 \
     -object memory-backend-ram,size=4G,id=m4 \
     -numa node,cpus=0-1,memdev=m0,nodeid=0 \
     -numa node,cpus=2-3,memdev=m1,nodeid=1 \
     -numa node,cpus=4-5,memdev=m2,nodeid=2 \
     -numa node,cpus=6-7,memdev=m3,nodeid=3 \
     -numa node,cpus=8-9,memdev=m4,nodeid=4 \
     -numa dist,src=0,dst=1,val=39 \
     -numa dist,src=0,dst=2,val=38 \
     -numa dist,src=0,dst=3,val=37 \
     -numa dist,src=0,dst=4,val=36 \
     -numa dist,src=1,dst=0,val=39 \
     -numa dist,src=1,dst=2,val=38 \
     -numa dist,src=1,dst=3,val=37 \
     -numa dist,src=1,dst=4,val=36 \
     -numa dist,src=2,dst=0,val=38 \
     -numa dist,src=2,dst=1,val=38 \
     -numa dist,src=2,dst=3,val=37 \
     -numa dist,src=2,dst=4,val=36 \
     -numa dist,src=3,dst=0,val=37 \
     -numa dist,src=3,dst=1,val=37 \
     -numa dist,src=3,dst=2,val=37 \
     -numa dist,src=3,dst=4,val=36 \
     -numa dist,src=4,dst=0,val=36 \
     -numa dist,src=4,dst=1,val=36 \
     -numa dist,src=4,dst=2,val=36 \
     -numa dist,src=4,dst=3,val=36 \
     ...

Suggested-by: Valentin Schneider <vschneid@redhat.com>
Reported-by: Leon Romanovsky <leon@kernel.org>
Closes: https://lore.kernel.org/lkml/20250610110701.GA256154@unreal/ [1]
Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap") # ce29a7da84cd, f55dac1dafb3
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changes are based on tip:sched/core at commit 1eec89a67141
("sched/topology: Remove sched_domain_topology_level::flags")

Changelog v4..v5:

o Rebased the series on top of tip:sched/core to resolve conflicts.

v4: https://lore.kernel.org/lkml/20250709161917.14298-1-kprateek.nayak@amd.com/
---
 kernel/sched/topology.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 977e133bb8a4..980b4b75b656 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2392,6 +2392,7 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 	id_seen = sched_domains_tmpmask2;
 
 	for_each_sd_topology(tl) {
+		struct sd_data *sdd = &tl->data;
 		int tl_common_flags = 0;
 
 		if (tl->sd_flags)
@@ -2411,22 +2412,33 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 		 * breaks the linking done for an earlier span.
 		 */
 		for_each_cpu(cpu, cpu_map) {
-			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
+			struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
+			struct cpumask *sd_span = sched_domain_span(sd);
 			int id;
 
 			/* lowest bit set in this mask is used as a unique id */
-			id = cpumask_first(tl_cpu_mask);
+			id = cpumask_first(sd_span);
+
+			/*
+			 * Span can be empty if that topology level won't be
+			 * used for this CPU, i.e. a lower level already fully
+			 * describes the topology and build_sched_domain()
+			 * stopped there.
+			 */
+			if (id >= nr_cpu_ids)
+				continue;
 
 			if (cpumask_test_cpu(id, id_seen)) {
-				/* First CPU has already been seen, ensure identical spans */
-				if (!cpumask_equal(tl->mask(id), tl_cpu_mask))
+				/* First CPU has already been seen, ensure identical sd spans */
+				sd = *per_cpu_ptr(sdd->sd, id);
+				if (!cpumask_equal(sched_domain_span(sd), sd_span))
 					return false;
 			} else {
 				/* First CPU hasn't been seen before, ensure it's a completely new span */
-				if (cpumask_intersects(tl_cpu_mask, covered))
+				if (cpumask_intersects(sd_span, covered))
 					return false;
 
-				cpumask_or(covered, covered, tl_cpu_mask);
+				cpumask_or(covered, covered, sd_span);
 				cpumask_set_cpu(id, id_seen);
 			}
 		}

base-commit: 1eec89a671413ce38df9fe9e70f5130a9eb79a59
-- 
2.34.1


