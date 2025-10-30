Return-Path: <linux-kernel+bounces-878776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE7C2170F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D191898E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6B1368F29;
	Thu, 30 Oct 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CSa3ucnx"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C932548E;
	Thu, 30 Oct 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844614; cv=fail; b=mNZmmk0aRR29FdwccO8ztqEY2xsD8S0zBH0x2P24/ygNwJ3Lfg8xeg7vq6M/OL0Mg16bRlnsPUJy9t/c8Hj4xn2he1I1KSlp+sfmxKwUYMmfQH1bFNEp243ve3bNBOJEWNsGztn6UetPBYsxx/NsUlYAiJUCQwbtFxYTmFpy8gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844614; c=relaxed/simple;
	bh=5AkWoPmiGSYQ3Wf8UoNaQ5UPu74eHEYkt+UhVMgnRiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFYGcV6DEg230BQ7m5uZD/Z9tpTNXEY67BWQMQlflth5pqqKiXlsmqYOETpCmn3pWsXh7rnw2HxuDQ/csrn88xopgzreU4AWtJsAp12ls7lPI706SPPALQkdiuuA+DF//ySgW341Fw5sxnhH3W9gb3YH4Pq9czZ7bDBS4HMq7TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CSa3ucnx; arc=fail smtp.client-ip=40.93.195.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbNxZXj4ZvXLjgS7kRtrx2+BeDWAtFgE2SXL1NTjEiZADQXOH9vCeMOMg3608kqTT5JAtppPdi3w6/AXR+M7KjVfQVEKx5SJTnYcU9ChfK10qGaDTXdw9f4CDcg1SaGlEN+i4Kws8Bc1+4x35Lm4TQptlqS/8tyD3Rx3RUCJ6bJotsarNYgzzv/h8dwAsQmxGEStDe+tAP8d7JZMWzciK8Ru9aFwW9MblusqruGvkoovpzasPm3GEiM5DS+6397usTx6UoNXrd1X9pTR38qxKyiL0+A2R4zuWe/8I2OqmZlXxBwwn55W3Un+UhH9pdyxmDdIPcZs8Uv8fjOUY8xmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DV4NtUWsJUSWo1a7q5nrK7B3v+M0DGqEV0mHkY+DlMM=;
 b=l9/uJRyqoDUsgHewr2aW8f/KJxWxbM+GDozdL3RnFIU2Z3XqkvHUGvrVfimF4B5SGxuEGmi+Izy1KA1+PuMEBQxTlhpn0gSIwtQ07gJmiJKMGy5HvPSjlDLuutGkCybzvyNlDVTWv3wLfoelmCeBgdUAeXmClVIsr589UZF6AK/JQTE8Y9kZeypzPQyoJipGejWJKMP6eOm2ORDUfDLrEo5j1KbCzNjK85rfRQlK3qudNImW69Kv+pacHvUi5P8gHiBr+Qp3tgoG3odN1lKw+vDO1D8SlJvQbOgzFe9xvC8D8uoieqFuAORYMMxISuVlhZFKUx2yTbAV2TMJDjfSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV4NtUWsJUSWo1a7q5nrK7B3v+M0DGqEV0mHkY+DlMM=;
 b=CSa3ucnx+dxcjdyayrNjSH+LQkcudkG+E5nGt/Z6fwkOY0vOwWj1qJJPtNTL1NSO5CVC96+JBhasNoWujUVYZbydoPFVvOw/RH0ZwPMTtzvcBJMMyFxcZvkGNVvPXBqR8mQ2yhs79s9K/VVDKR+ivx8MQjjml2TeT4Ok362XBHg=
Received: from BL1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:256::21)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 17:16:45 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::4e) by BL1PR13CA0016.outlook.office365.com
 (2603:10b6:208:256::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Thu,
 30 Oct 2025 17:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:16:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 10:16:42 -0700
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
Subject: [PATCH v11 06/10] fs/resctrl: Add user interface to enable/disable io_alloc feature
Date: Thu, 30 Oct 2025 12:15:35 -0500
Message-ID: <deb3a4f19d6e138a502b136034fb88ad8b8c9c75.1761844489.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761844489.git.babu.moger@amd.com>
References: <cover.1761844489.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb7cd9d-7b5b-4503-e672-08de17d81941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v0qLDjkSYDeNdnie6U4b/T5oXmyzWHC4txhe7TrQpMb+U7x5RUECWv2PzOTN?=
 =?us-ascii?Q?9j4jSpFXDdfLQCZzyMqOfNN+Y8sJq46ys2LxLC9IeJmSHxtG+bacU/MgDLvx?=
 =?us-ascii?Q?HZqPUaxr2XIkyMUt5OiCZmfEwBVy2nh46ov0g9+3O0LEORQ+5f3f3EUDmcee?=
 =?us-ascii?Q?YhsO6I69w9sEletu0YX7w39DeNpM22/s3NXNAA13r0+9zn/NrwSMpYZE6t+e?=
 =?us-ascii?Q?YjuxXTOLgMWFqrHIQN/XHtfmHtZ6Uy1EYTheOOlXzgDYgydG+gb9/4HyLPcW?=
 =?us-ascii?Q?lLGq2sy90KPud3+n71fcDukyP/5reb3K+qndtedtDhDnbpOmQs7M5eH1U7MG?=
 =?us-ascii?Q?ZNBVCAyZlqScou8Wwjwe3volaPdGIKywaOzPnt3gNzh6bbKIU1C8o0vgJHDv?=
 =?us-ascii?Q?2O+w+tyVqL+Kmyb6k8GoE1N/cvJ+9LRYm7icWsTiOHQupzJ83XXXGYwyZW8g?=
 =?us-ascii?Q?DlWZh8hkm/wUeTntx/Kj+26M6JIyJBrU5tkQMmcthtTs/UH3RBoykWrRS1pP?=
 =?us-ascii?Q?cOA1ln9slg/giQaKSn9k+OBtwEkzM894W2mEys8YOdMJOHTF/BZ6B0GwF8ML?=
 =?us-ascii?Q?98Nzs1GemY31ESrGibixEBI7J++tMdQtf2hEhFVH2wyPMhgmriBK0Hk585Dm?=
 =?us-ascii?Q?9rDpUu9c9iREaqmwA5TxK9a1n8veXbAQaOSTLhPbtFgS/7U3Z3ivcaBNvxQw?=
 =?us-ascii?Q?kIHrZZNtRytmjhtLMhzcj/WS0sj8QLAErjL8AnrMJU5oJn3SBtCbv0ue10mB?=
 =?us-ascii?Q?swlXgf1DFE1NaB4IaaDk+3shecteXLvvr3M7AAyAK0fSWA+bZl1I/UMjq2G3?=
 =?us-ascii?Q?Obp9Zf4Vu4hLaKYYAapqSO6P3Nrwz67CI4nCMmAkjFnrBe4B9EnZCnbdTwfD?=
 =?us-ascii?Q?APUAOTrmANs/ijQzUjLgCCBL6bU3PJq619w+6hnA+XCx6XW6R3UZl1MYwpuo?=
 =?us-ascii?Q?+Y+KbvtUIgPRZxA6sRxcrAWMFSB5McoviWBroiVvVTp6VlgiPq/cYvk4ENRw?=
 =?us-ascii?Q?4EokFqW/C+nr70v4hFEqorsrhqmewJTd1fZXePS3kcN1I47UNOtKtgdhVrNo?=
 =?us-ascii?Q?GNeAaOkbY6M/hXI9ywcvjxlWrpj1hmQ0DyYaeRzknlg3MfjswubyD9NScvfT?=
 =?us-ascii?Q?jQadJps6rUHHh+3CCPM0PkUBLkKG+Am1d3XDffGYp6rYLurtM9Zk6Ep13TMp?=
 =?us-ascii?Q?zqfkM29mXfoYp/q3tuR0qH6y6nn2GVxoh4intlS7D3xAUl+NE1rQYWJHH1Ys?=
 =?us-ascii?Q?Azh3dBxj6bif+ykoYXVl5vjSWrP0398sU0MLMyBmxJqOIsRoGsGH9LCHwI2v?=
 =?us-ascii?Q?Bzklu8n9oSazM6CfPFEpZhyj23vW0DvTSQJL/uDelSfp6A+oyKgcvG7JZ65N?=
 =?us-ascii?Q?nujkozIl5TTYTKbIgEo1IKQVnJg92vTer/4XproS0xiKsb14arCaVF7MH06e?=
 =?us-ascii?Q?d0Tyg0id86stl0WN+bi5H3bnxQ2mnBnpqywTwwuLeIVG3Dmz7s5oMuy1aTG0?=
 =?us-ascii?Q?6lpHKhrxqs1D8VL2T34HwvDzb0FOXs64TY1wo6+MO1uAIlNmrQl/cDTLiZZf?=
 =?us-ascii?Q?AgiCQeVhLeCT5Ipyqh4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:16:43.6868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb7cd9d-7b5b-4503-e672-08de17d81941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150

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
 Documentation/filesystems/resctrl.rst |  23 +++++
 fs/resctrl/ctrlmondata.c              | 126 ++++++++++++++++++++++++++
 fs/resctrl/internal.h                 |  11 +++
 fs/resctrl/rdtgroup.c                 |  24 ++++-
 4 files changed, 181 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 108995640ca5..89e856e6892c 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -152,6 +152,29 @@ related to allocation:
 			"not supported":
 			      Support not available for this resource.
 
+		The feature can be modified by writing to the interface, for example:
+
+		To enable:
+			# echo 1 > /sys/fs/resctrl/info/L3/io_alloc
+
+		To disable:
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


