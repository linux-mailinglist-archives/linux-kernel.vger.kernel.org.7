Return-Path: <linux-kernel+bounces-757071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E19FB1BD59
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5683A3082
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9DA243964;
	Tue,  5 Aug 2025 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BuYuuoeQ"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A1218ACA;
	Tue,  5 Aug 2025 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436707; cv=fail; b=GSBfiHURS1XbL003rpnUfhhqWET//h0GTwAZ7RzXsKtJQ5xfV6Sb+0NL4r7rw72BkIFRTqBLOj8tKQg163OkJOoOd+0k3AlMdHUMOVQlvb8v7u6AhrJvmDkonpSwm6q+sf2luijO9uoPPM1dI1eNlSzAE3jkYOicGP+WFHStekU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436707; c=relaxed/simple;
	bh=wzZEjXMDz6RhRFPqArn90Vpm1eKU1HS53fmixaQS4bU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikgg6hpt9cUhH3XqFocfKKvyEbq0MR+YI5N5jujR6zWWmyHmiWOpL56SPqvN6Ko8/gRwJYkcEkBsxSTFCPRkF14WpyM71r/6dLaoAjzW0n+7p9Co3UKgOGh9CpjFtAFtFWcbVPGdV0ra5X+DUTmcefyxkpFrLps0GCBHfT87chE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BuYuuoeQ; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxjZSQBfB0K5Aq+LGqOI6iLWOGtMPDjRwdb+NPfFrrKqOB+z1ocYkR9Pq2IU+RlYAnMxzY0ExpieQ8gk3d5j5+ksitd1lWfOjA4OY+7HBsUlEAc+W6qgnGMSKwD+jXlL22wlg2J5ZK3X0XuIxRs8H4JEn5YkFKn+kuyB/7GQk+JDI1cpe2Ik85I6CM+2TQBcD4Yh3zHlhL7aKk9ZyoDxKzIYyrtnGI2yod9STMQYkgA2nf7Gnbh5/1TPf+J3vPzEkoTsmjvyW0lNjahrtU6B5mpj3UBl+kYI2EFblhzcWvaBTn45vAeQRog9sVheRgxeX6LSyc5BnrBY3j5M17eJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cObPwRkxQUaZcZnnqABTldZ9J5UXHtWz3KJkrDsG2bo=;
 b=j9Lm+RCG13+V+wfJvFQ+hDCEr39UF1+T2TD53+mscgHkObsDpk0BtjodOcvdt3gVmh2pdYLu94BR7Snum2JGqsMf4cvAya+tGwToCWpfvF5b2Jq7qKIbu8BQ9Pzb5SxHFyup23+e8306OHrY67ligj5bXxBGihbFMe0rBWiZw4LaEyZ/a7veC54oMXVboELiVsuY86s7PpF7AFbWtC/Sb5I77x671oHxPjULXjEnLqT4P6z7awHcSbVe0r48z5V9KeN4JZWn6GBUHrIPGvST6AvOwaQowDrTwaqZ8tBEref8IlePxesJArM04vIPIrPWL7lFZnokOlL6yBv+ocFXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cObPwRkxQUaZcZnnqABTldZ9J5UXHtWz3KJkrDsG2bo=;
 b=BuYuuoeQax6tSaaYXPaSmwkGHQ7s7LusnuIhDEhZB8pY/Sc2bheRjaN+0mSFCXOFfvqlOIJnAAlL8u1TPh9NlME2AVa8mxNcq2xquyMUWuzrifAMEzIPDPBwWd2Udo4/MWzClSuNtgkjFjvZq4Qq34VGvKZlgEQnvpB81jqmpwU=
Received: from SN6PR05CA0033.namprd05.prod.outlook.com (2603:10b6:805:de::46)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Tue, 5 Aug
 2025 23:31:40 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::a1) by SN6PR05CA0033.outlook.office365.com
 (2603:10b6:805:de::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Tue,
 5 Aug 2025 23:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 23:31:40 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 18:31:38 -0500
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
Subject: [PATCH v8 05/10] fs/resctrl: Introduce interface to display "io_alloc" support
Date: Tue, 5 Aug 2025 18:30:25 -0500
Message-ID: <1004ca25abe2f7460960f08bf9bacacbb5b07b3b.1754436586.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: c24bf093-c7fd-4f43-db7b-08ddd4783abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DtcpvD8TaDADuSsHn7ojr+OqATTy5+mRxNxhWp/J/1WfFmq/bFX+QXh3tIsp?=
 =?us-ascii?Q?CFTLJFFqrKpVQwYmdTmr7C6uiJtIqV9psB6Tp4PvvbSVvlViBwg49X9TYjvr?=
 =?us-ascii?Q?gPupn56oEb8DFbcsnoztAFU7upqrajIFolpYdCJRjsXcpvk9eYblOvFmTm4S?=
 =?us-ascii?Q?c/gDrnIICh3sJI0nyTUWsESxB4OfMJz10A2WZE/TU8sGMALL/3wFo3GQj/n9?=
 =?us-ascii?Q?JzloWsDR3QD05gjh/4r/UeEcjjrX89WudIalMPIepepV7kClA1joS7NEXnF5?=
 =?us-ascii?Q?GFBYvEeUWmPNx6flCEsMtcDl6XPLGB3T8hhp/aDB54YQsoU0kgfDbPGKSPJ2?=
 =?us-ascii?Q?E85iQX7ogf+2kud7ibJ8nwdKQkZ+31gsk0+9C9rSi7A/8/xoOQW4S8PNt0+U?=
 =?us-ascii?Q?nTRgCvTj29B9zRh+SJyF1kxV8oO4ohjVj1/6OWHyKwYpQFXf3Qda+cOZ//lf?=
 =?us-ascii?Q?fJoeXQFzRql9hKdoiTbymKp5qV2cTk4fHQH3RjRi5zWuqKNi2ot0x3EkmOBz?=
 =?us-ascii?Q?3I29nHFjGwdypQ8F99tk8WTyubR6Hm6mo/zZEzbSRvZeQ/uypvgzEYWyL+mb?=
 =?us-ascii?Q?2JNxxdKsjX1PXv77Zx5bH6K6MdGvjkNP8Sc/hg94A4LTFWR2SMHEcKlK1h0Y?=
 =?us-ascii?Q?1yiIQ+WccRiuWZj1LoU3+Ja1ZbE3VQJ9B4iv5y+gitE5n6WCROLyiKmuPBLB?=
 =?us-ascii?Q?2F/q2jV1meChy921iYjgtU1pOpg0MzXt9poOXmfk7Ww5+6OQhan7Qx63JD5H?=
 =?us-ascii?Q?Papp/hq+vak9Stwe5Z7MWPcSQbutaY2VeTB4v6xwJwzGGupc1wCIhjpncLdh?=
 =?us-ascii?Q?DHM68y/70DcHey93GbBMi+XZnfEneJRRnKig9c/peGJR5kQ97irYE7OTwTBb?=
 =?us-ascii?Q?u8Ncc5kW5htuNBwqtPaiNbK10UOSryxIGuTjgdNmTqMiabJLTROHW/KbjRGG?=
 =?us-ascii?Q?7XMwF2MLBvyF4tCXl2ourLtCnb29v8V9Y+r7yBx4X7nhmwnvTSlAd2N/ukMl?=
 =?us-ascii?Q?3cbfnRkJ49k4l2Iy/koxMPoMhPH2d9ReVRBjQezELukrkDbrt2QWcEaL1X7y?=
 =?us-ascii?Q?7igq09aipldsXnjhjirAseYOe2HfzRXUB3ZGbIN8azyJW5DjKUV533gUxPSf?=
 =?us-ascii?Q?6qm1uTjOMK5gNJ0NWyqFEt1Em0IbChh85TmLeU2LVw2FbmlgjFXQxawZ61ZQ?=
 =?us-ascii?Q?NT34LphXn8qN+dcfHj8LS3KAvoix4u8mf6TEIWCk9RI0ULqOXzlkPbzfougJ?=
 =?us-ascii?Q?7Z//B1K9P6OqTmXnwv6X08JonXpbvt79fZvWoeDKPf9DmJNKjPBkNR1jRNeg?=
 =?us-ascii?Q?iZZoZ530HtKidvcFhMaHKQURH70BDwfl+W0TbdJ3QkKw2F4lx5wNA5xFwCgp?=
 =?us-ascii?Q?I+05na5pGUUFgzazAxyCJk4S/j2qPiVOnDbYRCuoiHi6Xi275rIoajwslOhH?=
 =?us-ascii?Q?2l78VCwBrT+YhM1nH0RPAqwL7eq+DDLKq4qkr/sh7rozQ1W+08CRhwXwPcNU?=
 =?us-ascii?Q?Iy9QGlARXRV3SkwfcVcdRkwVQ35PpcJsidYr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:31:40.2517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c24bf093-c7fd-4f43-db7b-08ddd4783abd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456

"io_alloc" feature in resctrl allows direct insertion of data from I/O
devices into the cache.

Introduce the 'io_alloc' resctrl file to indicate the support for the
feature.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Updated Documentation/filesystems/resctrl.rst.
    Moved resctrl_io_alloc_show() to fs/resctrl/ctrlmondata.c.
    Added prototype for rdt_kn_parent_priv() in fs/resctrl/internal.h
    so, it can be uses in other fs/resctrl/ files.
    Added comment for io_alloc_init().

v7: Updated the changelog.
    Updated user doc for io_alloc in resctrl.rst.
    Added mutex rdtgroup_mutex in resctrl_io_alloc_show();

v6: Added "io_alloc_cbm" details in user doc resctrl.rst.
    Resource name is not printed in CBM now. Corrected the texts about it
    in resctrl.rst.

v5: Resolved conflicts due to recent resctrl FS/ARCH code restructure.
    Updated show_doms() to print the resource if only it is valid. Pass NULL while
    printing io_alloc CBM.
    Changed the code to access the CBMs via either L3CODE or L3DATA resources.

v4: Updated the change log.
    Added rdtgroup_mutex before rdt_last_cmd_puts().
    Returned -ENODEV when resource type is CDP_DATA.
    Kept the resource name while printing the CBM (L3:0=fff) that way
    I dont have to change show_doms() just for this feature and it is
    consistant across all the schemata display.

v3: Minor changes due to changes in resctrl_arch_get_io_alloc_enabled()
    and resctrl_io_alloc_closid_get().
    Added the check to verify CDP resource type.
    Updated the commit log.

v2: Fixed to display only on L3 resources.
    Added the locks while processing.
    Rename the displat to io_alloc_cbm (from sdciae_cmd).
---
 Documentation/filesystems/resctrl.rst | 29 +++++++++++++++++++++++++++
 fs/resctrl/ctrlmondata.c              | 21 +++++++++++++++++++
 fs/resctrl/internal.h                 |  5 +++++
 fs/resctrl/rdtgroup.c                 | 24 +++++++++++++++++++++-
 4 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index f08699030312..fff7e04d1e2a 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -136,6 +136,35 @@ related to allocation:
 			"1":
 			      Non-contiguous 1s value in CBM is supported.
 
+"io_alloc":
+		"io_alloc" enables system software to configure the portion of
+		the cache allocated for I/O traffic. File may only exist if the
+		system supports this feature on some of its cache resources.
+
+			"disabled":
+			      Portions of cache used for allocation of I/O traffic
+			      cannot be configured.
+			"enabled":
+			      Portions of cache used for allocation of I/O traffic
+			      can be configured using "io_alloc_cbm".
+			"not supported":
+			      Support not available for this resource.
+
+		The underlying implementation may reduce resources available to
+		general (CPU) cache allocation. See architecture specific notes
+		below. Depending on usage requirements the feature can be enabled
+		or disabled.
+
+		On AMD systems, the io_alloc feature is supported by the L3 Smart
+		Data Cache Injection Allocation Enforcement (SDCIAE). The CLOSID for
+		io_alloc is the highest CLOSID supported by the resource. When
+		io_alloc is enabled, the highest CLOSID is dedicated to io_alloc and
+		no longer available for general (CPU) cache allocation. When CDP is
+		enabled, io_alloc routes I/O traffic using the highest CLOSID allocated
+		for the instruction cache (L3CODE), making this CLOSID no longer
+		available for general (CPU) cache allocation for both the L3CODE and
+		L3DATA resources.
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
 
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index d98e0d2de09f..d495a5d5c9d5 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -664,3 +664,24 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	rdtgroup_kn_unlock(of->kn);
 	return ret;
 }
+
+int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r = s->res;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if (r->cache.io_alloc_capable) {
+		if (resctrl_arch_get_io_alloc_enabled(r))
+			seq_puts(seq, "enabled\n");
+		else
+			seq_puts(seq, "disabled\n");
+	} else {
+		seq_puts(seq, "not supported\n");
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 0a1eedba2b03..1a4543c2b988 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -375,6 +375,11 @@ bool closid_allocated(unsigned int closid);
 
 int resctrl_find_cleanest_closid(void);
 
+int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq,
+			  void *v);
+
+void *rdt_kn_parent_priv(struct kernfs_node *kn);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 77d08229d855..acc9edc1a268 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -981,7 +981,7 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-static void *rdt_kn_parent_priv(struct kernfs_node *kn)
+void *rdt_kn_parent_priv(struct kernfs_node *kn)
 {
 	/*
 	 * The parent pointer is only valid within RCU section since it can be
@@ -1893,6 +1893,12 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_thread_throttle_mode_show,
 	},
+	{
+		.name		= "io_alloc",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_io_alloc_show,
+	},
 	{
 		.name		= "max_threshold_occupancy",
 		.mode		= 0644,
@@ -2062,6 +2068,20 @@ static void thread_throttle_mode_init(void)
 				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
 }
 
+/*
+ * The resctrl file "io_alloc" is added using L3 resource. However, it results
+ * in this file being visible for *all* cache resources (eg. L2 cache),
+ * whether it supports "io_alloc" or not.
+ */
+static void io_alloc_init(void)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+
+	if (r->cache.io_alloc_capable)
+		resctrl_file_fflags_init("io_alloc", RFTYPE_CTRL_INFO |
+					 RFTYPE_RES_CACHE);
+}
+
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)
 {
 	struct rftype *rft;
@@ -4249,6 +4269,8 @@ int resctrl_init(void)
 
 	thread_throttle_mode_init();
 
+	io_alloc_init();
+
 	ret = resctrl_mon_resource_init();
 	if (ret)
 		return ret;
-- 
2.34.1


