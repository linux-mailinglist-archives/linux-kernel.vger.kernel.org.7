Return-Path: <linux-kernel+bounces-757072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED28B1BD5B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B2B18C00CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AC623372C;
	Tue,  5 Aug 2025 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Eq8ZEUMr"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B55246BB9;
	Tue,  5 Aug 2025 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436715; cv=fail; b=bIpRBgyLAuZQ1eVStfcT/MDbYKMxZsZTjd0nhz8rqtfKMrZgm0oCc72XsKXfbs61NsRYMwUHzxpc/bmMrqUK1xPW7JMXGcELiWGyGvWzPOYXRBBlqVF3gFEsyGgQQqfx3xfiyCLHM7kbQv+p8mtO5wE1AW0NRKDS0zzuMMbdbFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436715; c=relaxed/simple;
	bh=E41Hewj2pbytTi9YSIkcDdY2GPuuJW3hN0IDIugnqmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHLNjRLlm0zyabkiGpzodwfmgqKiV/s0luQa85O9slH8v0CcAPEUsTlpCweuyaVLZ6XU3MaaUAtKEkKXmSi1HafTZTf9fFhgxp/Kc1c9Whd0to8+8oHpFnwYnVrJvzlhHTFJ51FULv5bttWXxe7aCmpAEQu4wKJFs8hi7WrVxA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Eq8ZEUMr; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvYlN20g1xMN5/qR4jwbMlH4293Gz01RqrqTmW25kJXsP+ZAyilWRWiIUch5cY4Y/6Nsv9EVXwUkX9ATYyxFRV8N8zhN2bAxfnZGHXdWlH1kFH4eOYhZaKiDF6XJ4/LDNiiYf5cUDhIuYxjIdMM3Kld1lsJ+fN54HaNpUqPrLJp8RfOUiZ1dkzeFsf7iNzGogE/PxWk6rZ5UGr2nufKeX0bcRAm7FlvQekp/6qqCXZukAt7mPWD7sELepFLgsIONPKgPF+mk21/fEipHf6xj8pm5y45LQq1UoKK6/9nDJZELprawMmSS+kRq1fmZrfcTc27iiyczUAhvFxsxJuIy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP66G2Eqcob6Gu+eW8SunYiQmmZRj8FuDUK6OsgVJ/Q=;
 b=WkbV7sL2xSjzmZyqp/R0mBTdzLuUNnA4VHoDnERptvSo3WcbZA8pv6LBtoabLlsPU2vH/UORyzqSOAsnyc7x38fkh0dXvg4sqzvOIJUdzykKRgG3hJWilbw+VyNaS4Rq6Ch8HFYU9qPyN91Gys9kVctXLZnpOgCAJHCHCQJBYVv6qphJb/pxaVn8O4BKxJLef26/pLyAzMzGXblz2q8uPVlEFDxFMiWyIwgZ7hESQ/6zXrS/Pcp1knNrBye7vZXi++3rd2ljjvdtWXoiOMxZPLQ7HpdPrfT55tqY3Bu/5LX3991TZZIjKT3pOH4qtE8Q904ZgRFwA57LfpXwDN6F9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP66G2Eqcob6Gu+eW8SunYiQmmZRj8FuDUK6OsgVJ/Q=;
 b=Eq8ZEUMrzNNWMdP9tY/7WgwKRr2Vjq56Lor9Bi4UQeWw56n5r6jg52kRlwheryiiOT2+zTIcHxJZHIuQzNazTVyO3VyVnDdHg9fEOGT+qeXuRDSMw+B6+Bfsa3VFEwDyEmzUYOBc/j4PBu3IQ92xIaMw3q6cCaFy/tvm/nPWAMM=
Received: from SN6PR04CA0086.namprd04.prod.outlook.com (2603:10b6:805:f2::27)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Tue, 5 Aug
 2025 23:31:49 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:805:f2:cafe::cf) by SN6PR04CA0086.outlook.office365.com
 (2603:10b6:805:f2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 23:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 23:31:49 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 18:31:46 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<babu.moger@amd.com>, <yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>,
	<xin@zytor.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <me@mixaill.net>, <mario.limonciello@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <ak@linux.intel.com>,
	<chang.seok.bae@intel.com>, <andrew.cooper3@citrix.com>,
	<perry.yuan@amd.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <manali.shukla@amd.com>,
	<gautham.shenoy@amd.com>
Subject: [PATCH v8 06/10] fs/resctrl: Add user interface to enable/disable io_alloc feature
Date: Tue, 5 Aug 2025 18:30:26 -0500
Message-ID: <f53db5c6dd7d0580c0cb1f252d947357d097842b.1754436586.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1754436586.git.babu.moger@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f92cb40-f780-4022-af93-08ddd4784009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nqj584yTJS++qaxh+s+pgJNN1K5mNcNoKvF6WSx2VPoFfE60H2RSQvKVuVKx?=
 =?us-ascii?Q?YHpmSMc6cHimF5HQimTn/gKoJHL2yRVpigHLxw0IVS1MLCB41l54qHSLKFie?=
 =?us-ascii?Q?+ceLgk+/KluTJ2X35ng+KJ4RtWpYBO66LGvrLS3B62JmXujCD0SJrIzOJmKZ?=
 =?us-ascii?Q?Oy536llLCKiyhBtcOqpjysBTgwtzjazl1+XJcc83MgLapiM9fGVWOWgRXDu8?=
 =?us-ascii?Q?xsKzL7vVJC4Jiy6vrn06A+p4kXP9UQQ3XWfSd+FkCNrrjbnxAUy6y1glnlhn?=
 =?us-ascii?Q?J+1Xm1wp1LIpT9lQ3fr8Z0wTIa8QwXZ4nr2IentLGGZtm0oQdlsuAbw/+ajI?=
 =?us-ascii?Q?7g5E/6v+MWIRVWIH2hmiSsL/ECSa6tmSOYlfxJcENp9GyNL8i2Q4f3kMCUfs?=
 =?us-ascii?Q?ByBE2bEuctGfV/jd/xOAg9Zl65WgU2upvE3ibtJ2kNl4FIjnaJnQ2TplhdCg?=
 =?us-ascii?Q?POD/9fLeVCYqdEDMjuv2ob1S0qXXe81at7w8lQfv+MPKFyAPmAP0eL8clbbV?=
 =?us-ascii?Q?hGRR3+hd6aW1x4jWivTho5FMaLoeoWz4F7O1FOnCKZDezQjztbG1qYUGL8rL?=
 =?us-ascii?Q?VR2oxVPjubiHLdIwQziox52WdNCmMj9jiYMN8chxVa6t/9WxJghfZqs2MlS8?=
 =?us-ascii?Q?lySg1pkZuW0iGq8O03TUKWE9SYOVXRL2/5W/xCpMjZDIierFBbX9AKNsU1qf?=
 =?us-ascii?Q?/SJ68DEvhwoF1eqjfQZDWIy8RHMTi72NbT8QaSbCYF4FvAf9ujl93wImrHeD?=
 =?us-ascii?Q?olUJ+PF8jUJiamJXe85uEtwsokMgDwHVbV5N9vcHiImBSqYUvBtHJw+6WiNI?=
 =?us-ascii?Q?2McROcChxgow8r6GEsg6xFrG9dH15eUh+31aaHDNqJFmPyCOCyUXorYKUbDQ?=
 =?us-ascii?Q?y7SZ0/aJ1+uYQOMRvfRj5plqbqqmYoDqA8FdXMKb3NZJwhfzHjpRg4tnjvvg?=
 =?us-ascii?Q?PBZwZ4bsvCSYj3vg50qhofHQmDZZm41tg0gQeLCg1qtSsqp2+yYIqG9TuM5b?=
 =?us-ascii?Q?bZKM7j0+dSuGCQXUg8ajfJ7CnkmfbxPYheqNdXdTPYGlXtuu52l3bazTBh0s?=
 =?us-ascii?Q?SehaA0oq6uxd7852kTRSMPnzIIZWHfJLetu4A/iDjGs3R3lAVkoBUeE6ExaW?=
 =?us-ascii?Q?R7mIF7qMm/jJLNSMbIgUVOVI39B6Om2I78ziRx+rYoV+JmFDnF17WiwhjgKt?=
 =?us-ascii?Q?QfcwV63eNcQJJj1kxdd6ccCIIaD+75y0vYKhVZ060xaDEizZpB/Hoh/EplYx?=
 =?us-ascii?Q?KFBZdhKsQ+uW2KEMGlMcJ1DuAd7dlpnWNenKIEJe04Hw+Bj8AN+1SAKbfBsg?=
 =?us-ascii?Q?rTgMFN8vMrV9H0hnQug61xU1dY6gZBXIQyKMa14arV6WwLvUWxpjJozNNANh?=
 =?us-ascii?Q?GG++trb15fUTvyLOZsDYUvH8FIGw0pzqUdisiVDF3ZwGHJcRISc8WkH3acCO?=
 =?us-ascii?Q?c1xRGd2jruBtWS3X5nKz+4xCc2QPaiFdY6xnLuxDQBs8GWfhJvl+4iyJhJZi?=
 =?us-ascii?Q?u0t3PjSCoSqvcieZkpxtDgpneWoweLLVLXj6Abc+9INsfNbCmAxyVVJhmg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:31:49.1370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f92cb40-f780-4022-af93-08ddd4784009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6

"io_alloc" feature in resctrl enables direct insertion of data from I/O
devices into the cache.

On AMD systems, when io_alloc is enabled, the highest CLOSID is reserved
exclusively for I/O allocation traffic and is no longer available for
general CPU cache allocation. Users are encouraged to enable it only when
running workloads that can benefit from this functionality.

Since CLOSIDs are managed by resctrl fs, it is least invasive to make the
"io_alloc is supported by maximum supported CLOSID" part of the initial
resctrl fs support for io_alloc. Take care not to expose this use of CLOSID
for io_alloc to user space so that this is not required from other
architectures that may support io_alloc differently in the future.

Introduce user interface to enable/disable io_alloc feature.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 Documentation/filesystems/resctrl.rst |   8 ++
 fs/resctrl/ctrlmondata.c              | 137 ++++++++++++++++++++++++++
 fs/resctrl/internal.h                 |  11 +++
 fs/resctrl/rdtgroup.c                 |  24 ++++-
 4 files changed, 177 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index fff7e04d1e2a..bd0a633afbb9 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -150,6 +150,14 @@ related to allocation:
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
 		The underlying implementation may reduce resources available to
 		general (CPU) cache allocation. See architecture specific notes
 		below. Depending on usage requirements the feature can be enabled
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index d495a5d5c9d5..bf982eab7b18 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -685,3 +685,140 @@ int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq, voi
 
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
+static struct resctrl_schema *resctrl_get_schema(enum resctrl_conf_type type)
+{
+	struct resctrl_schema *schema;
+
+	list_for_each_entry(schema, &resctrl_schema_all, list) {
+		if (schema->conf_type == type)
+			return schema;
+	}
+
+	return NULL;
+}
+
+/*
+ * Initialize io_alloc CLOSID cache resource CBM with all usable (shared
+ * and unused) cache portions.
+ */
+static int resctrl_io_alloc_init_cbm(struct resctrl_schema *s, u32 closid)
+{
+	struct rdt_resource *r = s->res;
+	enum resctrl_conf_type peer_type;
+	struct resctrl_schema *peer_s;
+	int ret;
+
+	rdt_staged_configs_clear();
+
+	ret = rdtgroup_init_cat(s, closid);
+	if (ret < 0)
+		goto out;
+
+	/* Initialize schema for both CDP_DATA and CDP_CODE when CDP is enabled */
+	if (resctrl_arch_get_cdp_enabled(r->rid)) {
+		peer_type = resctrl_peer_type(s->conf_type);
+		peer_s = resctrl_get_schema(peer_type);
+		if (peer_s) {
+			ret = rdtgroup_init_cat(peer_s, closid);
+			if (ret < 0)
+				goto out;
+		}
+	}
+
+	ret = resctrl_arch_update_domains(r, closid);
+
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
+	io_alloc_closid = resctrl_io_alloc_closid(r);
+	if (!resctrl_io_alloc_closid_supported(io_alloc_closid)) {
+		rdt_last_cmd_printf("io_alloc CLOSID (ctrl_hw_id) %d is not available\n",
+				    io_alloc_closid);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* If the feature is already up to date, no action is needed. */
+	if (resctrl_arch_get_io_alloc_enabled(r) == enable)
+		goto out_unlock;
+
+	if (enable) {
+		if (!closid_alloc_fixed(io_alloc_closid)) {
+			grp_name = rdtgroup_name_by_closid(io_alloc_closid);
+			WARN_ON_ONCE(!grp_name);
+			rdt_last_cmd_printf("CLOSID (ctrl_hw_id) %d for io_alloc is used by %s group\n",
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
index 1a4543c2b988..335def7af1f6 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -373,6 +373,8 @@ void rdt_staged_configs_clear(void);
 
 bool closid_allocated(unsigned int closid);
 
+bool closid_alloc_fixed(u32 closid);
+
 int resctrl_find_cleanest_closid(void);
 
 int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq,
@@ -380,6 +382,15 @@ int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq,
 
 void *rdt_kn_parent_priv(struct kernfs_node *kn);
 
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
index acc9edc1a268..380ebc86c748 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -232,6 +232,11 @@ bool closid_allocated(unsigned int closid)
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
@@ -1250,7 +1255,7 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
+enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
 {
 	switch (my_type) {
 	case CDP_CODE:
@@ -1803,6 +1808,18 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
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
@@ -1895,9 +1912,10 @@ static struct rftype res_common_files[] = {
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
@@ -3365,7 +3383,7 @@ static int __init_one_rdt_domain(struct rdt_ctrl_domain *d, struct resctrl_schem
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


