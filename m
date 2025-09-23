Return-Path: <linux-kernel+bounces-829432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE614B9716E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B013918A0C25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1C3281503;
	Tue, 23 Sep 2025 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5gefrgCv"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52500189
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649716; cv=fail; b=MX1VGlz+xmqBqZf4Mfbb2Kr9MVcPFOEELiT3myM0T5wzF4RpfP+wiKaRHVKBTvobbksksOugSDVTrMhh56Rt6BjANqq+bN7Rh4hiz7ydi46yeMTc3RqTZ9qPi2LhiFPwqEj2q4ox2SHXzPwoYekG6VCVk4wS89sh/CZKwG4TT1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649716; c=relaxed/simple;
	bh=1q4DqwAFQrYcm9zVh6xTGj54qgc43xZTh43VIsTvxDk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D0diFqdQjfe+WEwc3JbbWR9zB6uUKF4f8fjbomLKI35Wk7y74khF/PTA4x2yaZRjTaf8+TKet+5XEe3pgQ+py2Cz4SrqKGo0L0LKQ7/Ywr0o0SVlu2FWnKu/UnotjJ3cB+yGav0XUZutHxLa7b6/Ar9G8IH1magyRwCgWbc+GjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5gefrgCv; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjdM9VcOaT3i02tAznwTsk8yMO1azZM7Q4JQByi9nKyAb1LW/VJ3uIBbf312U8LZBU198T9gvC9/ZW5j5NlfOMosWm2OkPpsb85YnbUCObKnrjO6i9uTBbn8dmk+B3KT+XoF+Ur38RGEuz1t16+M0X9g1mkSn7YBAG5kLmTnbql65WptuWGo9mQObtwdEE2ZdrfrRUwLXxKdlonwb+YkvFUYz9JLQLbMCO2l9GO4xNEbPaWB/IYZCqbliqjqZUkchPvWwQJtGHtHFgSCPy3U0bbny2fvkkWE9mztY9fcS1FFZINqPsHEN2fobbTVoAcdQEHHqhXX3ZAvy1LEHcmhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39WPSrH7adKC1DZr/QsFavtFrBRxUX33OixXrh8I5aw=;
 b=W44kx6l1ZJq4Z1QyToJzH0ckRf/Q6S0F4TzKVGjvp6mOutvr8z1U11wkb61CB1J7Ulcn+Gy44GcDU3HMFX3jdmmKbBL+7EXaKIVJBFOe8qHSC6o6T4ChUIA/MqE8M2ODBLsjPQyVOZCIgkpsFgF5lCPrYcEdHIePVotquzKKiEBSiv8YCUv2SZ2i9oweTUzAHVY8hvkdzV1yWnsVUzn/01652PulRO+NY6t00pnhe0VlGm6UwNEs/GuuFsMFSeiy5BEogMIrFzMvO8HmgHUXZdrjyk0MsI9ne8nz9wDDaBsPdsLU/U0fxbYwJ5zxYZAq0M5h0Y7MDHrLH3UyyWtd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39WPSrH7adKC1DZr/QsFavtFrBRxUX33OixXrh8I5aw=;
 b=5gefrgCv5GmZyKKRCxWxukVauQUZil7f7msJhyjORZR6ndNWz66Y/1yaO0CpGpxHCePM+b5TNarPH6Vu2nu54wBIe1I+zYmATz/K57oJGDR/wSZguqZgFOQZ+dZSBZsU/pdHOhKFgs3b1IFZzqMrpcZngoO5/vbxfoYglkwGUSc=
Received: from MN0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:52c::34)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 17:48:30 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::4a) by MN0PR05CA0020.outlook.office365.com
 (2603:10b6:208:52c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Tue,
 23 Sep 2025 17:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 17:48:30 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 10:48:21 -0700
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>
CC: <ziy@nvidia.com>, <willy@infradead.org>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<gourry@gourry.net>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<vkoul@kernel.org>, <lucas.demarchi@intel.com>, <rdunlap@infradead.org>,
	<jgg@ziepe.ca>, <kuba@kernel.org>, <justonli@chromium.org>,
	<ivecera@redhat.com>, <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dan.j.williams@intel.com>, <rientjes@google.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <bharata@amd.com>,
	<shivankg@amd.com>, <alirad.malek@zptcorp.com>, <yiannis@zptcorp.com>,
	<weixugc@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC V3 0/9] Accelerate page migration with batch copying and hardware offload
Date: Tue, 23 Sep 2025 17:47:35 +0000
Message-ID: <20250923174752.35701-1-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e042005-87d6-4e1b-72e7-08ddfac96843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0Y0am1kbFVFaDN0cGFETzF4Z09Jam91SE5rYXcxdGdmRmhHeFBodytSMFJZ?=
 =?utf-8?B?MkdManhmaGp3bngzaytra1N2TExoM016aktFVG5vYnBpd0puT0lhcXRYMnJq?=
 =?utf-8?B?QTI4ek44aEN4VzAxNmE5RGxtRWthS3ZnQXV4MkpETHZkVk9lZkVpVko2c0FH?=
 =?utf-8?B?OXF5dUZHYkJZZ29XeFBtZVkzajlWY2IwWVVkSjB2VUo0SldHYzgxZXdKQmJU?=
 =?utf-8?B?eGwrSFI4NlBwNEJUNk40cndLTXRmWXMxRVpRKzJiVnhvbGFjcEFHeTJleFkz?=
 =?utf-8?B?RUJDcWlGeDgvbDdXK0NlRjY3QzlzbFdxVk9xWTZMVjdYMVZ1OEtnM0NYZmVR?=
 =?utf-8?B?QWprazlzMkwreW9kWnhQVVliSTg3MlhDZFI4aWdKa2xIQmJIT3FramQ4WUJQ?=
 =?utf-8?B?ZkpqTG5GejJSR0dwZjFSTEliUkppZXVLeW9zcnRldU1VMjNWNkE1RHNEZnBS?=
 =?utf-8?B?SldOenZWSFE2QUxnUURnSlZJeHNaZzVDUlpuaTB6R0F1YmgxeEduYjFSV3Er?=
 =?utf-8?B?MUlOM0VzbnZDd0FKd0s5T2dEWUZEMTNlUGJMaEFvVjQxTDh0ZG5rSGJ4QWpV?=
 =?utf-8?B?aE9WaDdYQnVyL0x1V24zT3BoTEdpY3p0UHJKeVNMeWgwaEN4QnExb1oxUFBx?=
 =?utf-8?B?SnY2WmlWQTU5VHJBaGNXeG4yNXRDMHBkRlBRNGtMcmJXRktvVUd6YWpHR3J2?=
 =?utf-8?B?Nkpra2dhd2ZQSFZmQ3NabTM3WUJ3QUJtdmovbkNCbVJvL3N5bHhHVGxCc01B?=
 =?utf-8?B?UFdIQzNiUmE2Z2JjV1RnUGZvSGxiT0Z2R1U2TE5KN1hvcHF4ZVYxWExPY2Y1?=
 =?utf-8?B?VHR6RVZrZUx4Uy8rVFJWS1d2N0x6S1FpQjZ0WWIrNkNHdXJmWGJBeDJwMlJD?=
 =?utf-8?B?ZWVpdno1cnQ4UGUvMUkzMGxIcU5ySFo4YXJSbTBreC9mOXZFbTJjLzVWa0hT?=
 =?utf-8?B?K1dEQ29BMEdFV3VtY0xVbHdNVkhBZUd1aDJsdGpoUnVocVFTMTJGcjZQWWE4?=
 =?utf-8?B?bkdPZlNJT3hPZFJDZWxNZVppdE90SldTY3JoMkZFL2VGMDFRell4MUtVWTBq?=
 =?utf-8?B?MVBqWkNCMnh6NFNxR285alpWeFNkeVF2VmxLL29Qa2VXOC92dnd1WkRiUjFy?=
 =?utf-8?B?TjRlbTVWVXVSV3Z2ditWVUNFNjJ2NlRGU2dxVU1xQjBzWDF0SDRpV3o3S1JQ?=
 =?utf-8?B?RTQ2SVo2RDJVS0s2QlNuRWxhZU9UbTlWeFh6VmNnZzZOK2xyUDRUWlE1Y1NJ?=
 =?utf-8?B?TklFNVVUQzFESVFzcWVqSUJwb1ppRERVd3JSTEw2NGE2WTdJdlRlWDhFb0Ra?=
 =?utf-8?B?RDhseFJMT25sU3ErdWVlbVFndDhVejdnckJHck1FSE01UG0yRWxHMWpPVUJr?=
 =?utf-8?B?NDNtS0tpemxPUjY1RXNBSzdyRnVzYk8xcm1VVVhHNGVGSmZVMmJpa2s4bXRO?=
 =?utf-8?B?SitNQlRFVVlkVjRoRzd4VE1PL0ZrQWJuN2orWUxOMVhpVVhjZ3pPMjg0aFRR?=
 =?utf-8?B?am1Yc1hnRHh6NVNVdnJEcFVDdTI3VWNqbUpseVk1cmNvQzJHNlcvQWNyQk5t?=
 =?utf-8?B?VEVwV3lXZWJWRG9DTEI4SFNPTloyOUZ3ZEhRSVVMZWR5bzVmYWRLaVYxMllN?=
 =?utf-8?B?QUdxZms3bFY1djJUMjFKVk5zQ09Tb3BOL2xPOFpiSnliN293eDZ5UDhKRVFX?=
 =?utf-8?B?bWpDMDB4aWx2bXh6UTZ5ZnFaak9yOGpHajdzQklzLzkwRkU3MC93VjhPSVpu?=
 =?utf-8?B?aXVpUi9jNld0cmh0N3MxRUJkc1pSNi9OTUZBeVQrS25QQ29JZXFHMzAvTDlO?=
 =?utf-8?B?bklEVkVWZnVGejNieFRFMDRCWGlJVjE5STVwRzErcEVON1NFK2lzYjlrSDlQ?=
 =?utf-8?B?aXdweGhpcC9EQUZHY0U1WnpReU5JKzFGS2JLTUxBb29BeTlRcURoSmdpcWw4?=
 =?utf-8?B?S1E0TU91UGhEeG9zY2JDM0NzbUVzUEVidGptSG9wMUc3UENDV3VnK2toaytM?=
 =?utf-8?Q?IV4IP10geeiOamMXYlHqloIj7RngEs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:48:30.0660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e042005-87d6-4e1b-72e7-08ddfac96843
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687

This is the third RFC of the patchset to enhance page migration by batching
folio-copy operations and enabling acceleration via multi-threaded CPU or
DMA offload.

Single-threaded, folio-by-folio copying bottlenecks page migration
in modern systems with deep memory hierarchies, especially for large
folios where copy overhead dominates, leaving significant hardware
potential untapped. 

By batching the copy phase, we create an opportunity for significant
hardware acceleration. This series builds a framework for this acceleration
and provides two initial offload driver implementations: one using multiple
CPU threads (mtcopy) and another leveraging the DMAEngine subsystem (dcbm).

This version incorporates significant feedback to improve correctness,
robustness, and the efficiency of the DMA offload path.

Changelog since V2:

1. DMA Engine Rewrite:
   - Switched from per-folio dma_map_page() to batch dma_map_sgtable()
   - Single completion interrupt per batch (reduced overhead)
   - Order of magnitude improvement in setup time for large batches
2. Code cleanups and refactoring
3. Rebased on latest mainline (6.17-rc6+)

MOTIVATION:
-----------

Current Migration Flow:
[ move_pages(), Compaction, Tiering, etc. ]
              |
              v
     [ migrate_pages() ] // Common entry point
              |
              v
    [ migrate_pages_batch() ] // NR_MAX_BATCHED_MIGRATION (512) folios at a time
      |
      |--> [ migrate_folio_unmap() ]
      |
      |--> [ try_to_unmap_flush() ] // Perform a single, batched TLB flush
      |
      |--> [ migrate_folios_move() ] // Bottleneck: Interleaved copy
           - For each folio:
             - Metadata prep: Copy flags, mappings, etc.
             - folio_copy()  <-- Single-threaded, serial data copy.
             - Update PTEs & finalize for that single folio.
             
Understanding overheads in page migration (move_pages() syscall):

Total move_pages() overheads = folio_copy() + Other overheads
1. folio_copy() is the core copy operation that interests us.
2. The remaining operations are user/kernel transitions, page table walks,
locking, folio unmap, dst folio alloc, TLB flush, copying flags, updating
mappings and PTEs etc. that contribute to the remaining overheads.

Percentage of folio_copy() overheads in move_pages(N pages) syscall time:
Number of pages being migrated and folio size:
            4KB     2MB
1 page     <1%     ~66%
512 page   ~35%    ~97%

Based on Amdahl's Law, optimizing folio_copy() for large pages offers a
substantial performance opportunity.

move_pages() syscall speedup = 1 / ((1 - F) + (F / S))
Where F is the fraction of time spent in folio_copy() and S is the speedup of
folio_copy().

For 4KB folios, folio copy overheads are significantly small in single-page
migrations to impact overall speedup, even for 512 pages, maximum theoretical
speedup is limited to ~1.54x with infinite folio_copy() speedup.

For 2MB THPs, folio copy overheads are significant even in single page
migrations, with a theoretical speedup of ~3x with infinite folio_copy()
speedup and up to ~33x for 512 pages.

A realistic value of S (speedup of folio_copy()) is 7.5x for DMA offload
based on my measurements for copying 512 2MB pages.
This gives move_pages(), a practical speedup of 6.3x for 512 2MB page (also
observed in the experiments below).

DESIGN: A Pluggable Migrator Framework
---------------------------------------

Introduce migrate_folios_batch_move():

[ migrate_pages_batch() ]
    |
    |--> migrate_folio_unmap()
    |      
    |--> try_to_unmap_flush()
    |
    +--> [ migrate_folios_batch_move() ] // new batched design
            |
            |--> Metadata migration
            |    - Metadata prep: Copy flags, mappings, etc.
            |    - Use MIGRATE_NO_COPY to skip the actual data copy.
            |
            |--> Batch copy folio data
            |    - Migrator is configurable at runtime via sysfs.
            |
            |          static_call(_folios_copy) // Pluggable migrators
            |          /          |            \
            |         v           v             v
            | [ Default ]  [ MT CPU copy ]  [ DMA Offload ]
            |
            +--> Update PTEs to point to dst folios and complete migration.


User Control of Migrator:

# echo 1 > /sys/kernel/dcbm/offloading
   |
   +--> Driver's sysfs handler
        |
        +--> calls start_offloading(&cpu_migrator)
              |
              +--> calls offc_update_migrator()
                    |
                    +--> static_call_update(_folios_copy, mig->migrate_offc)

Later, During Migration ...
migrate_folios_batch_move()
    |
    +--> static_call(_folios_copy) // Now dispatches to the selected migrator
          |
          +-> [ mtcopy | dcbm | kernel_default ]


PERFORMANCE RESULTS:
--------------------

System Info: AMD Zen 3 EPYC server (2-sockets, 32 cores, SMT Enabled),
1 NUMA node per socket, Linux Kernel 6.16.0-rc6, DVFS set to Performance,
PTDMA hardware.

Benchmark: Use move_pages() syscall to move pages between two NUMA nodes.

1. Moving different sized folios (4KB, 16KB,..., 2MB) such that total transfer size is constant
(1GB), with different number of parallel threads/channels.
Metric: Throughput is reported in GB/s.

a. Baseline (Vanilla kernel, single-threaded, folio-by-folio migration):

Folio size|4K       | 16K       | 64K        | 128K       | 256K       | 512K       | 1M         | 2M         |
===============================================================================================================
Tput(GB/s)|3.73±0.33| 5.53±0.36 | 5.90±0.56  | 6.34±0.08  | 6.50±0.05  | 6.86±0.61  | 6.92±0.71  | 10.67±0.36 |

b. Multi-threaded CPU copy offload (mtcopy driver, use N Parallel Threads=1,2,4,8,12,16):

Thread | 4K         | 16K       | 64K        | 128K       | 256K       | 512K       | 1M         | 2M         |
===============================================================================================================
1      | 3.84±0.10  | 5.23±0.31 | 6.01±0.55  | 6.34±0.60  | 7.16±1.00  | 7.12±0.78  | 7.10±0.86  | 10.94±0.13 |
2      | 4.04±0.19  | 6.72±0.38 | 7.68±0.12  | 8.15±0.06  | 8.45±0.09  | 9.29±0.17  | 9.87±1.01  | 17.80±0.12 |
4      | 4.72±0.21  | 8.41±0.70 | 10.08±1.67 | 11.44±2.42 | 10.45±0.17 | 12.60±1.97 | 12.38±1.73 | 31.41±1.14 |
8      | 4.91±0.28  | 8.62±0.13 | 10.40±0.20 | 13.94±3.75 | 11.03±0.61 | 14.96±3.29 | 12.84±0.63 | 33.50±3.29 |
12     | 4.84±0.24  | 8.75±0.08 | 10.16±0.26 | 10.92±0.22 | 11.72±0.14 | 14.02±2.51 | 14.09±2.65 | 34.70±2.38 |
16     | 4.77±0.22  | 8.95±0.69 | 10.36±0.26 | 11.03±0.22 | 11.58±0.30 | 13.88±2.71 | 13.00±0.75 | 35.89±2.07 |

c. DMA offload (dcbm driver, use N DMA Channels=1,2,4,8,12,16):

Chan Cnt| 4K        | 16K       | 64K        | 128K       | 256K       | 512K       | 1M         | 2M         |
===============================================================================================================
1      | 2.75±0.19  | 2.86±0.13 | 3.28±0.20  | 4.57±0.72  | 5.03±0.62  | 4.69±0.25  | 4.78±0.34  | 12.50±0.24 |
2      | 3.35±0.19  | 4.57±0.19 | 5.35±0.55  | 6.71±0.71  | 7.40±1.07  | 7.38±0.61  | 7.21±0.73  | 14.23±0.34 |
4      | 4.01±0.17  | 6.36±0.26 | 7.71±0.89  | 9.40±1.35  | 10.27±1.96 | 10.60±1.42 | 12.35±2.64 | 26.84±0.91 |
8      | 4.46±0.16  | 7.74±0.13 | 9.72±1.29  | 10.88±0.16 | 12.12±2.54 | 15.62±3.96 | 13.29±2.65 | 45.27±2.60 |
12     | 4.60±0.22  | 8.90±0.84 | 11.26±2.19 | 16.00±4.41 | 14.90±4.38 | 14.57±2.84 | 13.79±3.18 | 59.94±4.19 |
16     | 4.61±0.25  | 9.08±0.79 | 11.14±1.75 | 13.95±3.85 | 13.69±3.39 | 15.47±3.44 | 15.44±4.65 | 63.69±5.01 |

- Throughput increases with folio size. Larger folios benefit more from DMA.
- Scaling shows diminishing returns beyond 8-12 threads/channels.
- Multi-threading and DMA offloading both provide significant gains - up to 3.4x and 6x respectively.

2. Varying total move size: (folio count = 1,8,..8192) for a fixed folio size of 2MB
   using only single thread/channel

folio_cnt | Baseline    | MTCPU      | DMA 
====================================================
1         | 7.96±2.22   | 6.43±0.66  | 6.52±0.45   |
8         | 8.20±0.75   | 8.82±1.10  | 8.88±0.54   |
16        | 7.54±0.61   | 9.06±0.95  | 9.03±0.62   |
32        | 8.68±0.77   | 10.11±0.42 | 10.17±0.50  |
64        | 9.08±1.03   | 10.12±0.44 | 11.21±0.24  |
256       | 10.53±0.39  | 10.77±0.28 | 12.43±0.12  |
512       | 10.59±0.29  | 10.81±0.19 | 12.61±0.07  |
2048      | 10.86±0.26  | 11.05±0.05 | 12.75±0.03  |
8192      | 10.84±0.18  | 11.12±0.05 | 12.81±0.02  |

- Throughput increases with folios count but plateaus after a threshold.
  (The migrate_pages function uses a folio batch size of 512)

Performance Analysis (V2 vs V3):

The new SG-based DMA driver dramatically reduces software overhead. By
switching from per-folio dma_map_page() to batch dma_map_sgtable(), setup
time improves by an order of magnitude for large batches.
This is most visible with 4KB folios, making DMA viable even for smaller
page sizes. For 2MB THP migrations, where hardware transfer time is more
dominant, the gains are more modest.

OPEN QUESTIONS:
---------------

User-Interface:

1. Control Interface Design:
The current interface creates separate sysfs files
for each driver, which can be confusing. Should we implement a unified interface
(/sys/kernel/mm/migration/offload_migrator), which accepts the name of the desired migrator
("kernel", "mtcopy", "dcbm"). This would ensure only one migrator is active at a time.
Is this the right approach?

2. Dynamic Migrator Selection:
Currently, active migrator is a global state, and only one can be active a time.
A more flexible approach might be for the caller of migrate_pages() to specify/hint which
offload mechanism to use, if any. This would allow a CXL driver to explicitly request DMA while a GPU driver might prefer
multi-threaded CPU copy.

3. Tuning Parameters: Expose parameters like number of threads/channels, batch size,
and thresholds for using migrators. Who should own these parameters?

4. Resources Accounting[3]:
a. CPU cgroups accounting and fairness
b. Migration cost attribution

FUTURE WORK:
------------

1. Enhance DMA drivers for bulk copying (e.g., SDXi Engine).
2. Enhance multi-threaded CPU copying for platform-specific scheduling of worker threads to optimize bandwidth utilization. Explore sched-ext for this. [2]
3. Enable kpromoted [4] to use the migration offload infrastructure.

EARLIER POSTINGS:
-----------------

- RFC V2: https://lore.kernel.org/all/20250319192211.10092-1-shivankg@amd.com
- RFC V1: https://lore.kernel.org/all/20240614221525.19170-1-shivankg@amd.com

REFERENCES:
-----------

[1] RFC from Zi Yan: https://lore.kernel.org/all/20250103172419.4148674-1-ziy@nvidia.com
[2] LSFMM: https://lore.kernel.org/all/cf6fc05d-c0b0-4de3-985e-5403977aa3aa@amd.com
[3] https://lore.kernel.org/all/CAHbLzkpoKP0fVZP5b10wdzAMDLWysDy7oH0qaUssiUXj80R6bw@mail.gmail.com
[4] https://lore.kernel.org/all/20250910144653.212066-1-bharata@amd.com

Mike Day (1):
  mm: add support for copy offload for folio Migration

Shivank Garg (4):
  mm: Introduce folios_mc_copy() for batch copying folios
  mm/migrate: add migrate_folios_batch_move to  batch the folio move
    operations
  dcbm: add dma core batch migrator for batch page offloading
  mtcopy: spread threads across die for testing

Zi Yan (4):
  mm/migrate: factor out code in move_to_new_folio() and
    migrate_folio_move()
  mm/migrate: revive MIGRATE_NO_COPY in migrate_mode
  mtcopy: introduce multi-threaded page copy routine
  adjust NR_MAX_BATCHED_MIGRATION for testing

 drivers/Kconfig                        |   2 +
 drivers/Makefile                       |   3 +
 drivers/migoffcopy/Kconfig             |  17 +
 drivers/migoffcopy/Makefile            |   2 +
 drivers/migoffcopy/dcbm/Makefile       |   1 +
 drivers/migoffcopy/dcbm/dcbm.c         | 415 +++++++++++++++++++++++++
 drivers/migoffcopy/mtcopy/Makefile     |   1 +
 drivers/migoffcopy/mtcopy/copy_pages.c | 397 +++++++++++++++++++++++
 include/linux/migrate_mode.h           |   2 +
 include/linux/migrate_offc.h           |  34 ++
 include/linux/mm.h                     |   2 +
 mm/Kconfig                             |   8 +
 mm/Makefile                            |   1 +
 mm/migrate.c                           | 358 ++++++++++++++++++---
 mm/migrate_offc.c                      |  58 ++++
 mm/util.c                              |  29 ++
 16 files changed, 1284 insertions(+), 46 deletions(-)
 create mode 100644 drivers/migoffcopy/Kconfig
 create mode 100644 drivers/migoffcopy/Makefile
 create mode 100644 drivers/migoffcopy/dcbm/Makefile
 create mode 100644 drivers/migoffcopy/dcbm/dcbm.c
 create mode 100644 drivers/migoffcopy/mtcopy/Makefile
 create mode 100644 drivers/migoffcopy/mtcopy/copy_pages.c
 create mode 100644 include/linux/migrate_offc.h
 create mode 100644 mm/migrate_offc.c

-- 
2.43.0


