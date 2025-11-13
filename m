Return-Path: <linux-kernel+bounces-898399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F5C55337
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E25C94E87DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA019D8AC;
	Thu, 13 Nov 2025 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t3p+qJLB"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D5221F39;
	Thu, 13 Nov 2025 00:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995528; cv=fail; b=UGeiLbnpRZQiH6AedSIhmgy2TeKLO48yw12Qg8WB+8Q6uSzilpt00yjzP54I9QWpr48odynqiwfWTOD/+wJ8TPnRe2hbm0GF81W78+AVRFPo8YV+FZ7O3aLq8WLcChhoW+7qJpwOAZFAdJwuIUEp/sbjpXxx6HxZwRuzbOIej8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995528; c=relaxed/simple;
	bh=ztR94mA+yCpdn2SSPqZb/USsxWWqEc479/hRYXg3i4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEjJn5ZCq56fwEcJ0LSh91RL7vunJIlRtcJi654isc65diDZq2alkc4KMWdhFDGAZKJCXrGmJ5StO0uW6HzdxvyhzivDHKHvrKF+6h6kttB31uHFaHoEYcoEsCWhvOjyMnst4oMcG+JPSvyJWIIh2hyWDRSC2kJmBYTRdJ757Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t3p+qJLB; arc=fail smtp.client-ip=52.101.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAPI0qT+NhA15pj8U6CW+YlCmzoQtcVsAzfGmyRpljWmRdkFsyXEF9z/YEiyYQR2PIZ7bTcuwlxJRFydQz3KOBLQlYdszdxS8Vof0YG3QaXTQRJ0R30HrLYsXAo4sSjkykqqYPjO0jmwAoreJ2Sfn4KrLZ97xoKGM5jIuKrfYevjS07kuGYY0ZBfjlSEC3FG446Lv2q7xxPItcbqIa9t0MqWS4GRaAkqEnAdj3wZ1k/XObjAN/0AQls+mz26gwSoXj9YUflmLY+o6tSu8T09ae8MlMjWRcTyNAKwJJGE6DfuoqM1rDQj4HA61RG/3ojgO5rYs0E5qflf5tYU4S2kzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PzoCF03s9K7wgARpWruMZFOW+RgyQeGoeH4xGtBZ2U=;
 b=HoJltyTB59AqkYuEYQ8yNLm6SJgTnzb1N7Uoq09/36+i7mVmAMA7Pwa2JkENV6Zsv62WcmAUnB1aZ/5hsGtorIN0MCvnjJamXWMpW44sQRK+yht/T9RC8i00rgy7XkDT25f6BxCPK4kzmAs0cHfP5oVgPnvyORlwENYYtaD627f8bnrYbpQMZzKDeWS4Qt9mEIfz3lgUREEmnQbZDrlv6Xg8G2hRCJj0RdgxHjB0r1bga8gedlAjnNH1GEIU5FjmBHi7Hg7ANjKHcvm7jKedDAs9Uh+D/sZ1+6sbnpzoi5both8YGmcNhe8ASzehcNnTP41loUeQhuC7VOmbkQDp9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PzoCF03s9K7wgARpWruMZFOW+RgyQeGoeH4xGtBZ2U=;
 b=t3p+qJLBqr+H/6fH/ISiw0eqK2T7ZWHl6P/jnEGznkknMlY5B4P7i82Pz2Te8kvPfhqMlDggYeoq74rZyhTRjvUJOvfdmxMT2myOYZsfBo2kLTxtKpoWtAkU6Ccc7+KW9y2OQ72i1wnhZUKH7TEEq3h/7wqBH2iFvgLsuvmFfRU=
Received: from CH2PR10CA0024.namprd10.prod.outlook.com (2603:10b6:610:4c::34)
 by IA1PR12MB9523.namprd12.prod.outlook.com (2603:10b6:208:595::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 00:58:40 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::db) by CH2PR10CA0024.outlook.office365.com
 (2603:10b6:610:4c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Thu,
 13 Nov 2025 00:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 00:58:40 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:58:39 -0800
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
	<pmladek@suse.com>, <kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>,
	<seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <feng.tang@linux.alibaba.com>
Subject: [PATCH v12 06/10] fs/resctrl: Add user interface to enable/disable io_alloc feature
Date: Wed, 12 Nov 2025 18:57:32 -0600
Message-ID: <c7d3037795e653e22b02d8fc73ca80d9b075031c.1762995456.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1762995456.git.babu.moger@amd.com>
References: <cover.1762995456.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|IA1PR12MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 4574eee5-fd1d-43c9-7a1f-08de224fc93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/8tvsNVk1jS78QP4MEPRB04FlM/gi2234DfcCynUnel2C48bbxSAtHPLHeRH?=
 =?us-ascii?Q?khvDEr5kgFNDzhc5SLSC9StVnToAmF9fvNZPSf+QpuHlGFGuHMFwotQvQU80?=
 =?us-ascii?Q?rO7nxsF2DvI+IQPQtm84gcp6XTYxTC8JBu+hE6wvLoBou7dQQG0sQDgy01p2?=
 =?us-ascii?Q?Yjpu6d17DY1txGe3btJP+e320QQN/zu2FGTP6HO7Btct82BIVHOAW69gZcdI?=
 =?us-ascii?Q?/HTcv6qhJ+wtO7nXCls5DmmxvakxrqHP9aAzps4swUuhE5/mnzioNRHrCGU3?=
 =?us-ascii?Q?RK8KONARcrWNhmrwmdLKpFOWFf0rjrpCrqb/wFLVYYykiz2YjpS/qpdlSkze?=
 =?us-ascii?Q?oYjb2RGeOglijHCNPOMmvRJlDfYplDyyVwlvnpr+0AdZk5TxFHOgLvu+Hucv?=
 =?us-ascii?Q?EzUX43RvSSd1qAJnbePTYQLwTbl/lPz44cZD8Qxtj+O5HsrAc1fyt8whhtyj?=
 =?us-ascii?Q?FT1ctaK1c5yDF1dW4LF/+yGfVJEJIpQeak4jCX0EK9txNoMCODvTwRcEMsgj?=
 =?us-ascii?Q?joTYfNVt9ezKoBySmYs80sALp0eh9G331kD6JUKmIpiA0POaf1KGvpG1AXMy?=
 =?us-ascii?Q?3eX+GTR230B/60d7afhrdMOX3M6ZeDtRmcJxukThBBao5wHCZczKUx6CN/oR?=
 =?us-ascii?Q?l0yf7TY+LfH2LG7tB/av9bkYkXWQa+eHSGg18eVtztUUgNArPZQ4fvEbCOlk?=
 =?us-ascii?Q?oC0RrWmnfhsDahpg0xA9T3rScyDur7RTWyc3Q0nGdHk4yWdd5J5jySeiQ1g8?=
 =?us-ascii?Q?sdGa1xv+NzGQW3N5D5XecPrhpDrRf23QK6ErZ7MBWMTR+WxHs8jbxqrr79Ql?=
 =?us-ascii?Q?UaS2vi8S3wKQvnvo9GWvmwi9EZk7iEV5MGP+8k2ScY/znKWrzvXTo04WyyOs?=
 =?us-ascii?Q?HdA8j/vpYrOYUguwWLfnlqm+0OqqadgcKDAtTafwrqNjRIrRGJQ2raY5vovX?=
 =?us-ascii?Q?ksbN4Hfo6KhrHfBxwmymopjoMdAMInI8l01o+Fxl/HSMCLx5kGhDf4d4cMrJ?=
 =?us-ascii?Q?0+WGQ1jFHKZktEs3UzfgF3JtWJU2+mBzF58R5Mx57Qs2f1rgJspSYVbE7FpM?=
 =?us-ascii?Q?FxCwFhfXUk6FMMGFViKa0M9wjF9ZbZHQFElofQG+/PvNVcJ/RrXx2DijdFKz?=
 =?us-ascii?Q?GQ4S3VSxAsvjn4fNb0er8MipFYx2t2S7YED1VcuYwz214jHWjiMLM9W9V4Dr?=
 =?us-ascii?Q?IciQ6U7YbNQ51S/DC76IrjNbyzUj0Ag06+truVQnWbOhYO/0lNNQQCixowOR?=
 =?us-ascii?Q?9hwjIqso9vygbvS8Nk/j2uNcsvCKTfY3TlfZi8Bg5L74dLmRHsiZHvOF+SA2?=
 =?us-ascii?Q?N2d8yvvxulx/umvQ5f+dtqDv1WsJc8Fqn01n5hATMFzNQf2mVJzXwO6PbOYj?=
 =?us-ascii?Q?XRXdpWghfDWKo4ruDJn72CIKCuNWx5auTf183+YP5VG3XdzE2xV5rDZQ08Ra?=
 =?us-ascii?Q?FIZWCEHn2eyTF+P5DIsARh0Cgoe36Jpi6BZf3ZndCVSNUNxTXLjRDBWM/wnP?=
 =?us-ascii?Q?DoNUkQK0F471H6dimaXsQncrlNlKq/f8uGfBe8nxM22cRRTnF68GEAtD9TuL?=
 =?us-ascii?Q?Ob7uA8jtmZ05ohuXGns=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 00:58:40.6454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4574eee5-fd1d-43c9-7a1f-08de224fc93a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9523

AMD's SDCIAE forces all SDCI lines to be placed into the L3 cache portions
identified by the highest-supported L3_MASK_n register, where n is the
maximum supported CLOSID.

To support AMD's SDCIAE, when io_alloc resctrl feature is enabled, reserve
the highest CLOSID exclusively for I/O allocation traffic making it no
longer available for general CPU cache allocation.

Introduce user interface to enable/disable io_alloc feature and encourage
users to enable io_alloc only when running workloads that can benefit from
this functionality. On enable, initialize the io_alloc CLOSID with all
usable CBMs across all the domains.

Since CLOSIDs are managed by resctrl fs, it is least invasive to make
"io_alloc is supported by maximum supported CLOSID" part of the initial
resctrl fs support for io_alloc. Take care to minimally (only in error
messages) expose this use of CLOSID for io_alloc to user space so that this
is not required from other architectures that may support io_alloc
differently in the future.

When resctrl is mounted with "-o cdp" to enable code/data prioritization,
there are two L3 resources that can support I/O allocation: L3CODE and
L3DATA.  From resctrl fs perspective the two resources share a CLOSID and
the architecture's available CLOSID are halved to support this.  The
architecture's underlying CLOSID used by SDCIAE when CDP is enabled is the
CLOSID associated with the CDP_CODE resource, but from resctrl's perspective
there is only one CLOSID for both CDP_CODE and CDP_DATA. CDP_DATA is thus
not usable for general (CPU) cache allocation nor I/O allocation. Keep the
CDP_CODE and CDP_DATA I/O alloc status in sync to avoid any confusion to
user space. That is, enabling io_alloc on CDP_CODE does so on CDP_DATA and
vice-versa, and keep the I/O allocation CBMs of CDP_CODE and CDP_DATA in
sync.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v12: Minor format fix in resctrl.rst.
     Added text about writable files in the info section.
     Removed Reviewed-by tag from Reinette as there are some new text changes from Dave.

v11: Fixed typo CDP_3DATA -> CDP_DATA.
     Added code to free the CLOSID on resctrl_arch_io_alloc_enable() failure.
     Fixed the prototype of rdtgroup_name_by_closid().

v10: Rephrase of the whole changelog to avoid repetion. Thanks to Reinette.
     Minor print format changes.
     Moved the hardware specific detail to resctrl.rst.
     Changed the text L3CODE to CDP_CODE and L3DATA to CDP_DATA

v9: Updated the changelog.
    Moved resctrl_arch_get_io_alloc_enabled() check earlier in the
    Removed resctrl_get_schema().
    Copied staged_config from peer when CDP is enabled.

v8: Updated the changelog.
    Renamed resctrl_io_alloc_init_cat() to resctrl_io_alloc_init_cbm().
    Moved resctrl_io_alloc_write() and all its dependancies to fs/resctrl/ctrlmondata.c.
    Added prototypes for all the functions in fs/resctrl/internal.h.

v7: Separated resctrl_io_alloc_show and bit_usage changes in two separate
    patches.
    Added resctrl_io_alloc_closid_supported() to verify io_alloc CLOSID.
    Initialized the schema for both CDP_DATA and CDP_CODE when CDP is enabled.

v6: Changed the subject to fs/resctrl:

v5: Resolved conflicts due to recent resctrl FS/ARCH code restructure.
    Used rdt_kn_name to get the rdtgroup name instead of accesssing it directly
    while printing group name used by the io_alloc_closid.

    Updated bit_usage to reflect the io_alloc CBM as discussed in the thread:
    https://lore.kernel.org/lkml/3ca0a5dc-ad9c-4767-9011-b79d986e1e8d@intel.com/
    Modified rdt_bit_usage_show() to read io_alloc_cbm in hw_shareable, ensuring
    that bit_usage accurately represents the CBMs.

    Updated the code to modify io_alloc either with L3CODE or L3DATA.
    https://lore.kernel.org/lkml/c00c00ea-a9ac-4c56-961c-dc5bf633476b@intel.com/

v4: Updated the change log.
    Updated the user doc.
    The "io_alloc" interface will report "enabled/disabled/not supported".
    Updated resctrl_io_alloc_closid_get() to verify the max closid availability.
    Updated the documentation for "shareable_bits" and "bit_usage".
    Introduced io_alloc_init() to initialize fflags.
    Printed the group name when io_alloc enablement fails.

    NOTE: io_alloc is about specific CLOS. rdt_bit_usage_show() is not designed
    handle bit_usage for specific CLOS. Its about overall system. So, we cannot
    really tell the user which CLOS is shared across both hardware and software.
    We need to discuss this.

v3: Rewrote the change to make it generic.
    Rewrote the documentation in resctrl.rst to be generic and added
    AMD feature details in the end.
    Added the check to verify if MAX CLOSID availability on the system.
    Added CDP check to make sure io_alloc is configured in CDP_CODE.
    Added resctrl_io_alloc_closid_free() to free the io_alloc CLOSID.
    Added errors in few cases when CLOSID allocation fails.
    Fixes splat reported when info/L3/bit_usage is accesed when io_alloc
    is enabled.
    https://lore.kernel.org/lkml/SJ1PR11MB60837B532254E7B23BC27E84FC052@SJ1PR11MB6083.namprd11.prod.outlook.com/

v2: Renamed the feature to "io_alloc".
    Added generic texts for the feature in commit log and resctrl.rst doc.
    Added resctrl_io_alloc_init_cat() to initialize io_alloc to default
    values when enabled.
    Fixed io_alloc show functinality to display only on L3 resource.
---
 Documentation/filesystems/resctrl.rst |  30 ++++++
 fs/resctrl/ctrlmondata.c              | 126 ++++++++++++++++++++++++++
 fs/resctrl/internal.h                 |  11 +++
 fs/resctrl/rdtgroup.c                 |  24 ++++-
 4 files changed, 188 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 108995640ca5..91c71e254bbd 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -73,6 +73,11 @@ The 'info' directory contains information about the enabled
 resources. Each resource has its own subdirectory. The subdirectory
 names reflect the resource names.
 
+Most of the files in the resource's subdirectory are read-only, and
+describe properties of the resource. Resources that support global
+configuration options also include writable files that can be used
+to modify those settings.
+
 Each subdirectory contains the following files with respect to
 allocation:
 
@@ -152,6 +157,31 @@ related to allocation:
 			"not supported":
 			      Support not available for this resource.
 
+		The feature can be modified by writing to the interface, for example:
+
+		To enable::
+
+			# echo 1 > /sys/fs/resctrl/info/L3/io_alloc
+
+		To disable::
+
+			# echo 0 > /sys/fs/resctrl/info/L3/io_alloc
+
+		The underlying implementation may reduce resources available to
+		general (CPU) cache allocation. See architecture specific notes
+		below. Depending on usage requirements the feature can be enabled
+		or disabled.
+
+		On AMD systems, io_alloc feature is supported by the L3 Smart
+		Data Cache Injection Allocation Enforcement (SDCIAE). The CLOSID for
+		io_alloc is the highest CLOSID supported by the resource. When
+		io_alloc is enabled, the highest CLOSID is dedicated to io_alloc and
+		no longer available for general (CPU) cache allocation. When CDP is
+		enabled, io_alloc routes I/O traffic using the highest CLOSID allocated
+		for the instruction cache (CDP_CODE), making this CLOSID no longer
+		available for general (CPU) cache allocation for both the CDP_CODE
+		and CDP_DATA resources.
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
 
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 78a8e7b4ba24..454fdf3b9f3c 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -697,3 +697,129 @@ int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq, voi
 
 	return 0;
 }
+
+/*
+ * resctrl_io_alloc_closid_supported() - io_alloc feature utilizes the
+ * highest CLOSID value to direct I/O traffic. Ensure that io_alloc_closid
+ * is in the supported range.
+ */
+static bool resctrl_io_alloc_closid_supported(u32 io_alloc_closid)
+{
+	return io_alloc_closid < closids_supported();
+}
+
+/*
+ * Initialize io_alloc CLOSID cache resource CBM with all usable (shared
+ * and unused) cache portions.
+ */
+static int resctrl_io_alloc_init_cbm(struct resctrl_schema *s, u32 closid)
+{
+	enum resctrl_conf_type peer_type;
+	struct rdt_resource *r = s->res;
+	struct rdt_ctrl_domain *d;
+	int ret;
+
+	rdt_staged_configs_clear();
+
+	ret = rdtgroup_init_cat(s, closid);
+	if (ret < 0)
+		goto out;
+
+	/* Keep CDP_CODE and CDP_DATA of io_alloc CLOSID's CBM in sync. */
+	if (resctrl_arch_get_cdp_enabled(r->rid)) {
+		peer_type = resctrl_peer_type(s->conf_type);
+		list_for_each_entry(d, &s->res->ctrl_domains, hdr.list)
+			memcpy(&d->staged_config[peer_type],
+			       &d->staged_config[s->conf_type],
+			       sizeof(d->staged_config[0]));
+	}
+
+	ret = resctrl_arch_update_domains(r, closid);
+out:
+	rdt_staged_configs_clear();
+	return ret;
+}
+
+/*
+ * resctrl_io_alloc_closid() - io_alloc feature routes I/O traffic using
+ * the highest available CLOSID. Retrieve the maximum CLOSID supported by the
+ * resource. Note that if Code Data Prioritization (CDP) is enabled, the number
+ * of available CLOSIDs is reduced by half.
+ */
+static u32 resctrl_io_alloc_closid(struct rdt_resource *r)
+{
+	if (resctrl_arch_get_cdp_enabled(r->rid))
+		return resctrl_arch_get_num_closid(r) / 2  - 1;
+	else
+		return resctrl_arch_get_num_closid(r) - 1;
+}
+
+ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
+			       size_t nbytes, loff_t off)
+{
+	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r = s->res;
+	char const *grp_name;
+	u32 io_alloc_closid;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!r->cache.io_alloc_capable) {
+		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	/* If the feature is already up to date, no action is needed. */
+	if (resctrl_arch_get_io_alloc_enabled(r) == enable)
+		goto out_unlock;
+
+	io_alloc_closid = resctrl_io_alloc_closid(r);
+	if (!resctrl_io_alloc_closid_supported(io_alloc_closid)) {
+		rdt_last_cmd_printf("io_alloc CLOSID (ctrl_hw_id) %u is not available\n",
+				    io_alloc_closid);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (enable) {
+		if (!closid_alloc_fixed(io_alloc_closid)) {
+			grp_name = rdtgroup_name_by_closid(io_alloc_closid);
+			WARN_ON_ONCE(!grp_name);
+			rdt_last_cmd_printf("CLOSID (ctrl_hw_id) %u for io_alloc is used by %s group\n",
+					    io_alloc_closid, grp_name ? grp_name : "another");
+			ret = -ENOSPC;
+			goto out_unlock;
+		}
+
+		ret = resctrl_io_alloc_init_cbm(s, io_alloc_closid);
+		if (ret) {
+			rdt_last_cmd_puts("Failed to initialize io_alloc allocations\n");
+			closid_free(io_alloc_closid);
+			goto out_unlock;
+		}
+	} else {
+		closid_free(io_alloc_closid);
+	}
+
+	ret = resctrl_arch_io_alloc_enable(r, enable);
+	if (enable && ret) {
+		rdt_last_cmd_puts("Failed to enable io_alloc feature\n");
+		closid_free(io_alloc_closid);
+	}
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index a18ed8889396..145e22f9a350 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -390,6 +390,8 @@ void rdt_staged_configs_clear(void);
 
 bool closid_allocated(unsigned int closid);
 
+bool closid_alloc_fixed(u32 closid);
+
 int resctrl_find_cleanest_closid(void);
 
 void *rdt_kn_parent_priv(struct kernfs_node *kn);
@@ -428,6 +430,15 @@ ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf, size_t
 				 loff_t off);
 int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq, void *v);
 
+int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid);
+
+enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type);
+
+ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
+			       size_t nbytes, loff_t off);
+
+const char *rdtgroup_name_by_closid(u32 closid);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 6d89160ebd11..95d47b4b6505 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -226,6 +226,11 @@ bool closid_allocated(unsigned int closid)
 	return !test_bit(closid, closid_free_map);
 }
 
+bool closid_alloc_fixed(u32 closid)
+{
+	return __test_and_clear_bit(closid, closid_free_map);
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1247,7 +1252,7 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
+enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
 {
 	switch (my_type) {
 	case CDP_CODE:
@@ -1838,6 +1843,18 @@ void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_mon_
 		kernfs_put(mon_kn);
 }
 
+const char *rdtgroup_name_by_closid(u32 closid)
+{
+	struct rdtgroup *rdtgrp;
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (rdtgrp->closid == closid)
+			return rdt_kn_name(rdtgrp->kn);
+	}
+
+	return NULL;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1949,9 +1966,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "io_alloc",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= resctrl_io_alloc_show,
+		.write          = resctrl_io_alloc_write,
 	},
 	{
 		.name		= "max_threshold_occupancy",
@@ -3500,7 +3518,7 @@ static int __init_one_rdt_domain(struct rdt_ctrl_domain *d, struct resctrl_schem
  * If there are no more shareable bits available on any domain then
  * the entire allocation will fail.
  */
-static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
+int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 {
 	struct rdt_ctrl_domain *d;
 	int ret;
-- 
2.34.1


