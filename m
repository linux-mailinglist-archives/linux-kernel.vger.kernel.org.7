Return-Path: <linux-kernel+bounces-724114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B21AFEECB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CED3AF86F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F99C204C3B;
	Wed,  9 Jul 2025 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kn9Ug2kC"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A620127D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077985; cv=fail; b=W4M5j+7ijCqlx22RnqEoawZOX5ZN25/aRWo8FT7cFHjA9qwfOd4YjxZZY4c+7FbplMP+2GyPI8Ogxq7/zZgUaxekJDzXK5HGU4pyyg6UXYNqoEc8ABgwQCm6qvnnM3SZz6I4uPBk0Z8yYtLW2mI8CWeZnIjcBliT9jeOq6z1dLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077985; c=relaxed/simple;
	bh=7UQLV9GyyPMHi+Z1b7Voyg2dJF9bWudSfjkRy7s4o5A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IiZoLg/kcrUVCnZTe6dT0dL/UBBu2aSR/y6XIEUO1Ha4B7akuUqAI8CJH5tLuaW1VkAFe40PkNPemtiOLgTdgrseD8kKb8dgUwAdE4UBk8KpYJTcNlPNUwlfrzzFj7pG14HTpysa9QoPLZ/WjIv7UyOkSrQo8nvIvAUp+i0ITDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kn9Ug2kC; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0lvJBfvKA/nKbbO5GwUoK9wsaySF+2JS/dXRrLJFhw88/x8EDomh5lvUsTdGdqZiIT1VEohFIfPj5cEVEiA8hWgnxUr2cm0M9gwd/waym78dDSuuaTY/Se9pIMQ4ctIoT5+yi2FnXKs2wX/Bq2NO/8QjzgG6YiE0jE4cXa1rtbaYslQFzT+JaWBga9Dg+b3Yo/lbYKHMddnAGFS+mvKDAFGsiGNees1RZFhVSIGo/P2vTpLtrVFMOAGZCEGF+zhtGPwssDTFY1TzYvRkCvnYoWKWK4PB+zom4P57jPVDfsj1oWoUgc1XDS5XfA2pwcUxDUmfSllm/RnUL2nmTRSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWCA/5a22QdFYzOXyQ1GAl5SFGFpxaaSQDtqPRJhDYo=;
 b=sdXhqMS+c3sH3tjDhy2ncyrZrQE11efQiXWD5+ggo2ib23wmSLljJn8finu46VEYaGUkscUxZlZWFq+qPjcfjWoaUoDgc+6yPFHBSvxuRBvdMgRcOwbgi9yjEAuHgIvqYRCjYmmh6klHWHtK8h5ig1lIIQJR3kRHuGeAGEUdXn7j/aUR8WBYLU3GmllnaZxz4/8pj39XhyU3ypFz6OUL1TumhIuLi7Apmrq/KQdBwnMU0mVZvxVvbSwyreBIs3TQeHVyLxum1W3JTMUI4tkIHNyf6p4OPIz7lSXMryjOmCaAt/6efRezx+foUvvSrFYXbcp+7ntRm7/ND8WlZXGC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWCA/5a22QdFYzOXyQ1GAl5SFGFpxaaSQDtqPRJhDYo=;
 b=kn9Ug2kCLaSTKytn4ZPNkD+cjqNA8gXZMaGDznT2helAFcbNJFbMDpxHG85/X1Nry/5kkIhwd8jWhGARS/Or1vRlNAMFnM4Uad+2ud3rvbOQwtuAfE/yDFJs8ZflAfqDtKZVe0hmu5dUX2mZg3NdkiSZ2pFA45LXzIkBET4CVGM=
Received: from CH0PR04CA0059.namprd04.prod.outlook.com (2603:10b6:610:77::34)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 9 Jul
 2025 16:19:39 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::f9) by CH0PR04CA0059.outlook.office365.com
 (2603:10b6:610:77::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 16:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 16:19:39 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 11:19:33 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Valentin Schneider <vschneid@redhat.com>, "Leon
 Romanovsky" <leon@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@alien8.de>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>
Subject: [PATCH v4] sched/fair: Use sched_domain_span() for topology_span_sane()
Date: Wed, 9 Jul 2025 16:19:17 +0000
Message-ID: <20250709161917.14298-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1d4524-6302-4be6-504c-08ddbf046758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tFuBrYvCb3bhPeJsfoFSZjQ1csOCX9s4iAXZ6l2hCBM9GmIbhKcgQ5EDNyFQ?=
 =?us-ascii?Q?h21BvAinFXpG+dmLn3eryZlRhTjnmMyEcVirN3AyXQ19ubaYC3pf70HhPrSn?=
 =?us-ascii?Q?+jQvTp8q6VtG6oeamQUpmuN5DC1IguEq9x01nufBcnt/r3uaN5MJ47/d6uxY?=
 =?us-ascii?Q?iIFkzQjzDOAaYeGe0Ho8wO2cNs9XJarmzvES6PbzYcT7Oyny1KziS6Kv/jlD?=
 =?us-ascii?Q?ZX2P4vYw/aAZCuYnzTHJFmU88Gf9XtFEJ5kHeaxpmchruFU/G4Y96WMN7BVi?=
 =?us-ascii?Q?S2H5O9oxWxWWsIReqQVdT2MfnYsLY22ZVElSBG3izJdIwgwPzAHEvcigkbcM?=
 =?us-ascii?Q?ZxITksu0ya06cefnubveyna4ac9CdSXAVTzlLbSN7B9lO1p67kh8QNaFp5k7?=
 =?us-ascii?Q?tRK9WcaqTU6/sKfXXKOQCi+YlYsN2PIvUYCwMUfg6PohDQelIWftWl6FaaH9?=
 =?us-ascii?Q?hh1SGdq92EkcV6+FYWDrdIKrigpip4TRy/v/LJKbzUB7/ts8Elb+t4tafrB4?=
 =?us-ascii?Q?kCblBdbTLJcBiiyceVRn8rOkvv9aUr89W8TnCJkWaVJhCL83gxBe0rEBWzA+?=
 =?us-ascii?Q?7X34KNJG01Rq8yncEsxjwNvvTtipPVsWFBOJR7Hb8B9IIJFbXTiW/x44OIK4?=
 =?us-ascii?Q?kcyFWqKJ/NlGtf2O4lLCJwk94hmXL26YXp4RzuLrtwau2IMeiMaZH+V5wK0p?=
 =?us-ascii?Q?Whh7YS/Sfn29bd8TBLvBZym1kxqxccsVKcG6C56OrVjz03epka8FIFO7Zenz?=
 =?us-ascii?Q?P6Y7ePf266VumgOZidfGPoHve4vWFCwKgHTvwApuNfO9aiCIxGQjdsY/p4+W?=
 =?us-ascii?Q?OYhEDETufRYoaiusZmzwVtqSLnXE6hk8mDTwoWqVmGbI/BPWGFfNgiHkljei?=
 =?us-ascii?Q?f8lu8qFxXEqfETNIhov25RKMGlIvSaimaKxOSyJjhoMs7GTpk1XbWa2T6lmi?=
 =?us-ascii?Q?1fG7XoiIUpTvArInxmXHVri212GDNUAsHyr3ZTJXS+BsoCAU4t0mUpKIwiPz?=
 =?us-ascii?Q?MaDInT1UbTL0e65gNxZDd/DYpXBHSE757B24NgM1R7oaCOnsNiY53alDoyP/?=
 =?us-ascii?Q?wLErxHEX/YdE8dYALPbqYLnVJn0+z8Io/CfBTM2EjbDVcfRhBR4EqG7rqAj6?=
 =?us-ascii?Q?KI+Wz1b8ZsK/n8eFzDil7ivw+V90nZoUzdOTippQenyNdq+RwV9G9XkfIjRU?=
 =?us-ascii?Q?r7asunnBn1+qPOxgGDR1qz9k8RH90hMC6WGvC5/BRtrmtHQdOmJaCaSYFZct?=
 =?us-ascii?Q?JdrzCwL79LoO4MPfAvze/MR5GkdDFMXHP6H1JFuoW5Pj89KiCc5MDFDIybiz?=
 =?us-ascii?Q?ayFd5HuFCefBqRlFI5atsPzxhWXsNsCIlvNh5GAT0Bn5GexrKdiJpp+pKmLS?=
 =?us-ascii?Q?znsg7oLLJgYvcXyBuan6ObiC7f4mx9h9e8u8Iph/NsCfCAYegYyNwKh3Pbar?=
 =?us-ascii?Q?VETuHco/Cziv69LArm3nc/JWnv+Qi8ihG6JUcrnpeSwIQhtGb2DHlZeDAWC3?=
 =?us-ascii?Q?UOOChieAU1wQrLO0U+CckboK4EeYfQEzzj7i+0LV/zgtLSxStTTTxIbbjQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 16:19:39.0539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1d4524-6302-4be6-504c-08ddbf046758
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B

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
Changes are based on tip:sched/urgent at commit fc975cfb3639
("sched/deadline: Fix dl_server runtime calculation formula")

Changelog v3..v4:

o Use empty span to detect sd objects that haven't been initialized
  instead of using "sd->private" (Valentin).

v3: https://lore.kernel.org/lkml/20250707105302.11029-1-kprateek.nayak@amd.com/
---
 kernel/sched/topology.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b958fe48e020..37b310116d19 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2403,6 +2403,7 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 	id_seen = sched_domains_tmpmask2;
 
 	for_each_sd_topology(tl) {
+		struct sd_data *sdd = &tl->data;
 
 		/* NUMA levels are allowed to overlap */
 		if (tl->flags & SDTL_OVERLAP)
@@ -2418,22 +2419,33 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
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

base-commit: fc975cfb36393db1db517fbbe366e550bcdcff14
-- 
2.34.1


