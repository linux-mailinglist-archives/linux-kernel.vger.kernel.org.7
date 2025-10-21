Return-Path: <linux-kernel+bounces-863887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46463BF96A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26FF5E3B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9FB2EBDCA;
	Tue, 21 Oct 2025 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="APssuXHF"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A042E6CBE;
	Tue, 21 Oct 2025 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090983; cv=fail; b=uWpobMqIlYahQj06PaUGqIiapUGX8SvNT09T+0O3cQ9fQWrxez31CySbGSDxhMgIn2gHFRgKfI+jvPs3x5qB9oF0/ZU/P4xpk9BAvcTxY3TuB4JBmQahGpD4SqYG3nxp9aEqT1p6xFSbMjADTAwLC3VQKdhTfFaj+sf28RkmfAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090983; c=relaxed/simple;
	bh=V4Ay9+FmYuN2SbCmeK5vexiM4KIS+1pf+CE5RE74zjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OShmWxsEuvzcdSfnK255f7ovpFBdPxZ7L7R7AI25O88zOpS2u61HxEljW4vJSrvPTeh8jUEQOj3bdp81mugxxdj6k9LdtvTYwl8o+szAnf8y8JC46EGvxXZb2+DjRRCdk4pHrYNO7xan+gnQTu7HgxIOVzSM3HChOCFART8pVcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=APssuXHF; arc=fail smtp.client-ip=52.101.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sq20TUbR4RRZSYk8XdoWkXEfGCbavJMVNAd1v6gCJdugwGIk3f3VR/GI/V6AZH7eLxE5tX47SQK9bk8I2N7i8yxKvw4/nZ1zUi8yw19EPZ8tDVXg+EIPRc3zUAqT2h0Vz87mHkDEVUqf+b+TFza8e/asilGqROed8lmm5BFTgHLpXGggpkm0a8PEprAkOvyFK1FvXbZx8EISJMze9VITvC+vGjcG2aT9nyl255bkuAq3eJV+UyyKmt/tQFgLdf4gJp5iLQjZgenhYK87x85iNbmpZTe5iSxb4y8euvxdDVrFf9sseogBlLsbZfRo9vKd0WS77eJbIUJ/nGMrlkj4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFTpzOXDFYwUePn82JH0TUjsweYXZxhsDMM6MUZjSgY=;
 b=r/gk+n2rj5ONMvu8A2QkWKsrh01MdGwQv/qbJfB2vjK/PQeSu/VqfuMbTyERhI/YBKZDQOqj6EWL2ayUGF0f5d/HwwMYykROfSo+nn+1wqJ3xnFToKCoRvK8LJBKop7mniuI45c2LWI0vGjsmlBEke9/MkLnvyJVks+MRvgidpHC3h2p8VOZ0x38O+YY7+B7tDdwzfhEFqODCZSUqynDnh6fapiThTVDxZikO2F5dkkeNYcMLO3G0UkcOHQbEqJAVhej1MPqNdsrIjyG4LoUdsmQQjr5Q4UTPhU5pRPm/EscO3dfpRYDPOxj6tkK40gZ3hsuBY9KdX+F/AXbaR0AUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFTpzOXDFYwUePn82JH0TUjsweYXZxhsDMM6MUZjSgY=;
 b=APssuXHFzKzAO25WiEg0ABk+Qjgpj77eV4zCa2HQZADjEvE+SPkbZo+wL318JLub5vwHnLLAktY4R9jU3qOUYzptNWBtbt7uaoE7ku1tw2x9pGw1btRzvOAWQUlSs8LImydl9W6gPJtSltrUqbrWmcbn9wNfMeP7qLcDk+hPIqM=
Received: from MN0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:52c::15)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 23:56:18 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::18) by MN0PR05CA0016.outlook.office365.com
 (2603:10b6:208:52c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 23:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 23:56:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 16:56:13 -0700
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
	<peternewman@google.com>
Subject: [PATCH v10 06/10] fs/resctrl: Add user interface to enable/disable io_alloc feature
Date: Tue, 21 Oct 2025 18:54:49 -0500
Message-ID: <dd444497162c38f81858ba3b3f95c29058d38232.1761090860.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761090859.git.babu.moger@amd.com>
References: <cover.1761090859.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 865a36f9-5844-48b5-4f28-08de10fd6ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nR/Xouq4bKM3gZKsdHR8jMs+Cegjt+q1eTBVH3+fI/c3sJ0VHXyuuZqxXukz?=
 =?us-ascii?Q?GRbJtrw59/J7b7M/EbUWntQpyJPZ96ORH0s2C84j8/Bk2G8wndMxLLCUyivb?=
 =?us-ascii?Q?AbDeW/yOnKwz7uY/J9h7tgCWNFWpqXh413CGPPZxzoAKL7UOWEJdWNk060Dm?=
 =?us-ascii?Q?AbYTGyBMAh4mOud66PK48i4EbtpK99fm3HSc0UPeZfY/2lq54h5BJl2goUXe?=
 =?us-ascii?Q?VWGEa4m954Xf+NfWFuGnJTwNCi1V6rujR7kAue8pDufMtkM2/YqGegmzVMok?=
 =?us-ascii?Q?Yua+aQGich58PGmVRFFi7L5wSbnPHaigYZIf/8D3/5J44Y7HduwujHhtFmYH?=
 =?us-ascii?Q?Fj7ELU1IvPfz30zgx8kbvWOtCPFmktZCfQxmtjyy7wUvWWWc+bP90YrXUku7?=
 =?us-ascii?Q?D2+cHh4MIb8NanFySTL4UThA6+t8URoDX6JpQTcC6ZM5wOYYc9ryDWJGmQPT?=
 =?us-ascii?Q?WAvsxvZ7Rm+cHDIu4P8UpaYog09bIctjyLrCf19EInwV6IkEvgaeUjrNC4mT?=
 =?us-ascii?Q?7zB9E/r4+X2guQSxeXx3SG6z9S6bUTdOC0dw7c1zc0vS+l8TGyfe2vSl7Tbo?=
 =?us-ascii?Q?wpoZGVQ0jnw5horfOSG3blevVeGRneh1Y8ab8uSupBz2Q5NE7hCsmA4EU9ML?=
 =?us-ascii?Q?pBBTTNXuI0U3LWVXzewGXihVcNaLig7mNWH0QUMQzumes4L5ubXAV7Dd3CZ9?=
 =?us-ascii?Q?cnNFuepEF34is8arHM5eCxUwSERR7kB2gRA+ya21Lvw2UkrJs+MIXExkRccu?=
 =?us-ascii?Q?/g2D5r3FIPHzVaCAAR/6EsMfsAyfRriKHDqnseMiBHye8mU1YSxrll0jDeSm?=
 =?us-ascii?Q?4JxiRw/XuyJL7qZZiMw90zsskgKP+bn+N2vA61++RjvCkp4rPS+rl5KO86Fp?=
 =?us-ascii?Q?WapcLqPWMMkLnrvqvysYdD/ipBVVg5MTH9ItYIs/HUryZrgh2ZF86A7cNGJh?=
 =?us-ascii?Q?eTnT40Z7lN7a2u5Fkbjm20p9aNqoBkfl3SYE3K8HGTwT8WthuwmWWxuZZEhl?=
 =?us-ascii?Q?EqjNQe2+KxZ9XIbbVxizxYlTrYGY1B8dNKOKgNlgbvJr8GZVb0jGUtez5FkY?=
 =?us-ascii?Q?Wi1Au5+Fe+yiWkmBySEkkIi8/H7sErWQSSWEE6pHDzIIneqF6lsV/6iW19C0?=
 =?us-ascii?Q?+GNtQwaBgIA4bGhpS0Xk/7nNHqXmAgzep85csRHfm2kHjhoe0xDZcL8R4MRJ?=
 =?us-ascii?Q?rVqJlE6fNxTJI3kmwKuZaGwzNpbBOG5vw0iXCDhbncxGWVlNQzHGL1Ne7b1N?=
 =?us-ascii?Q?fXVIAvID9nEB09ZUIFJiOsQFlG6vgIRIwd7u8msDO3fAKBJYBkksVLkiM7i9?=
 =?us-ascii?Q?r7HAs/No2PxltXULefaVJ6mFlSgj0rYMWc3kgVmz4DQUNapl1n1+UlbJXX9w?=
 =?us-ascii?Q?k796V9bleh4k+dim8FLBetnga9YBigrdALHARCYqjYWTvxLeJXSYPRW3Yzez?=
 =?us-ascii?Q?kMR5UlTulSE+uZFyCwgPjQKq3mAEZ1C2xTv3U46nBPZxS+sFXaEo5QoB0nur?=
 =?us-ascii?Q?XC9g60u148amPeYY/JkUrexeUp2OMmXHiaxbRnmI4gENDt3FSZL0v7LbFmAP?=
 =?us-ascii?Q?pzjCrVoMXH6DP9MHowU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 23:56:17.3024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865a36f9-5844-48b5-4f28-08de10fd6ced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340

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
vice-versa, and keep the I/O allocation CBMs of CDP_CODE and CDP_3DATA in
sync.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 fs/resctrl/ctrlmondata.c              | 122 ++++++++++++++++++++++++++
 fs/resctrl/internal.h                 |  11 +++
 fs/resctrl/rdtgroup.c                 |  24 ++++-
 4 files changed, 177 insertions(+), 3 deletions(-)

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
index 78a8e7b4ba24..bdec06bcf3e3 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -697,3 +697,125 @@ int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq, voi
 
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
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index a18ed8889396..26ab8f9b30d8 100644
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
+const char *rdtgroup_name_by_closid(int closid);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 6d89160ebd11..5dec581336dd 100644
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
 
+const char *rdtgroup_name_by_closid(int closid)
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


