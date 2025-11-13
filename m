Return-Path: <linux-kernel+bounces-898400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A10BC55332
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE9F74E8F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CA22248A8;
	Thu, 13 Nov 2025 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a4k0RuQn"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C381E221F39;
	Thu, 13 Nov 2025 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995539; cv=fail; b=CPY6pLiNdUsAtRt6Yn3st3B2GmJda/ZXbFF8VixPD/O22xTNtcHX9J3mNLkS/dUviPBwdq9s6PKjaE0B/Hi07eA+m2yqrIuK6RExyc33fbGl+mk8ifrLLkv31PqBaDS7zFswSx72uA2Cpy7j4o3cJ1R2jCRG5rbhgTfm7Wl142A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995539; c=relaxed/simple;
	bh=L1g2lfiD2lxcE2qb9HWN+m1mZObj4DtAxJSCWPsj58M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JD4fnwik8SYRcyunaeB21FLyUSl2CHmDbitRYa2B6IqX90V87LsaZkaCu7e0hRjAfUcmCmX+glBBpKvSMlyS2UnC4q0jA2Hcou39j4ZpfRlmOybBKV0dd9M3hZsxUnIPE3woECjopwtxS3PdQEihqCVxPZK/bhyRtaQmmk1iwvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a4k0RuQn; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNW1TlzmAUBxWQ64O26ndvdknwQEz0z2jEBywDIStFUU84Pgvik7sD4fh47MD/Nf17xlR513sZ5EUTj7FkuvbMl3eaKHZv235lQhPBXDwh5HvSeC5I/+/2lxbSN7/QrD1qSfWlhb8GopvEClefvgVlFBX5zL7hlAybG8ItpKRQ3B0bpXbYITq/oGxex4s+E2zPq9fReRM9e+hAEfnjIod4jyBmcI288s9w2VZl6heV43sl3miBFTvIqORVtJPzzGgfF5bqlm706CsK091ZMsVPw0aDWnAVDJW386vYroENEj6Eg8oGUFkAKPT83kn/9ka8zzjHZpt7j6eG+ilcr8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+5AZbBTSjyRuyyontHNbtDHohCWDWOoqSvky1HxzBk=;
 b=YZqY1BJo4i//fqmc5ZVFonCDBpd08O+U000um/iLZVfE/3jv+ApelBE5zrXql6rlFcE607LLTPquJXdAIiiNd1y28qmhxc4DqlUhXUXCQMTIFMFlbutJRara2n7VYmiWbxK8mlSPci3iA4H4DV6pDOhgJgdxv6jMeNn3COhL5xzyT5RXtQYyPP6YXUv6Iv5INW+iNieI4aaXP2wSm2xG9CjRiTan6VqTX76niRHmkUFBR6h02pc6GLmIO4z0nhn0v9V1Wqka3VI5Pr/Pcpns6fZUNdU4ToLabN5Xe18352vXGLs/tQyo4QmlZsHwy9/NbIc4bEbRsPX7CqvCTZMsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+5AZbBTSjyRuyyontHNbtDHohCWDWOoqSvky1HxzBk=;
 b=a4k0RuQn5C1ETpfuWkAeFXtwGc16x0lxMDWUrRkkyB0aOOfs/NVhpGPbib73d2zLPHqBV8dcr88RCTocYu/mgClgbxNDmhs/XaCz6lOe1PZIIJd0KNLIeXyXid2lQnZK0D1i6qe1bev8s75oggjfzwOExc+Wqa7lE/EiL/QBZUo=
Received: from CH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:610:32::24)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.17; Thu, 13 Nov 2025 00:58:48 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::e6) by CH0PR07CA0019.outlook.office365.com
 (2603:10b6:610:32::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 00:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 00:58:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:58:46 -0800
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
Subject: [PATCH v12 07/10] fs/resctrl: Introduce interface to display io_alloc CBMs
Date: Wed, 12 Nov 2025 18:57:33 -0600
Message-ID: <55a3ff66a70e7ce8239f022e62b334e9d64af604.1762995456.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: a9535086-8d84-4048-cc53-08de224fcdd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CgfK0hCjYwFJ8vP7y9DJKMZmBUewQGXXu5NtVm2+2cl/CrU2ZJXrBU0yBZpA?=
 =?us-ascii?Q?IBD/Z+4JU4O+R3b+V2kFBu9RfrP7ZkgNfqsoA2LB1UFBte4FajU9ZgQK7rVZ?=
 =?us-ascii?Q?DdGD8k7rLTN2Oqu0Yn8SLE944GF86OheUSARX2ak5YgFrj8cVTOYfwgNcPQQ?=
 =?us-ascii?Q?3jPnWHgpG4ZCAgyO/bJXMElK46qAjUx2XhfQXyLn7BAwxAllRhABiy/HZJkF?=
 =?us-ascii?Q?Y8NaITfkkLXplYfIIxCxdPhAf9BkQawpj41fuDrpEOvpFGCaN2NNZJ8KjHe2?=
 =?us-ascii?Q?LgsBVSssKU+hjFcyC10MYGTLChNwDNs6lGa5orJgqKtGAoMdHbyKlxwSZVtH?=
 =?us-ascii?Q?A9KxHIkEnVlimF0qK9FBaMPzPxzA+pgyUZU0cX+p/OPFjHoUuvhM1L+hvXCI?=
 =?us-ascii?Q?cxWrDv2vthxjJFNxGMCuji0aMegoJQUtU+a5HSLCxfOPGIErKDMVXv8h2d+w?=
 =?us-ascii?Q?JiTzShISZvou/mH3Ntfpu5AoC9H7HUwGaGctXf2HsBdtKyAgR8eZhIJNs9Nq?=
 =?us-ascii?Q?rueAVKbc2Hwslvq+LVclOU5FypnZewag9rqdb9Kv+6YsuKaJavkLPcTcyGVq?=
 =?us-ascii?Q?Wjmq0NOWLxdTn39T0aL7DBSq/N6Sx4PJ1PZ6a7OF3ZIdFeCqngZIahhy2C2h?=
 =?us-ascii?Q?Du+NeMahepPeN5xVVpBdVZSDVs05EnJRji1yUEbioDVgAXqHNlrUJyp7EMoM?=
 =?us-ascii?Q?BoaUQLXZXs5vKV8j4WEATwBQ/nKJiGzLwD5sl9PDUgbUyKn9im7PWDoHhNZk?=
 =?us-ascii?Q?H+hxYxv2lJFtjWcrsJeHXik//5NkiRcoCtwr/dKGxolqUjdc9rc8htFEMWrL?=
 =?us-ascii?Q?JDDaqFwhE9Vj/ldHERI+Rjm1ECry/FO85iO2bmPDxzVAmY+TrBP4y06hQ980?=
 =?us-ascii?Q?S1grVglaakeLYONsS4fuhACeWPpfI/YjLtnTHXfDUUvWXAQfAM+PtBJF8NZX?=
 =?us-ascii?Q?ARgdU4vZ9wjd23+ENzLGyWRcrrcpErK/TZhmsGig/sSZ6AF7sDuKiiVSym+P?=
 =?us-ascii?Q?E63fLhIh2v3EShH1BiLrUz55b1KzJM3YdtFb+5VguVwfrG96UJJpzPTtGiTW?=
 =?us-ascii?Q?PgMfEh4uxcA1VFTZnLOMKE2qW68YPciivFfOrrYxR+4y6yO+DrQMLlWKjO9e?=
 =?us-ascii?Q?tWlfZ4yNGdrllG0kv9AZqbr4XXquecu4Q69+K1/rsJJloGJs5sor5BGcHnzE?=
 =?us-ascii?Q?MMZgGj7cs247NNZPOtuhEP/Sirzyqlg7Zns9zwnFx2V5w3zc79NyoJX0DdCV?=
 =?us-ascii?Q?MMNqa8H3Vf+HnCS1/lSMBgcMEEZutPp4jAJ/IN6mbNb/PDA6HhkKh6NzxEaj?=
 =?us-ascii?Q?E2BFsjTFmmzTz0yLHePTTLJe80NfYsVF+n1N+LF7L6K2pRiqr6OW3Iwath8C?=
 =?us-ascii?Q?p2tENLhvFNKQB1ZqbVva7BY4AebR6jD/gBxPN3s8XDHi32XcTc6pnLAg53dZ?=
 =?us-ascii?Q?yF4wEa2CpvENifpcNGYcO4HupQecHjOOlnfA5vQPXsoH3Et0cHnssr3CU/62?=
 =?us-ascii?Q?wu2iSTLCIM1+zL0HbrXF7CLVzTZ/9kzK3SOYXv7/C/gvVehgIIgGT3NmlP9n?=
 =?us-ascii?Q?pCeZJGsn4JSjoZO5s80=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 00:58:48.3947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9535086-8d84-4048-cc53-08de224fcdd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

Introduce the "io_alloc_cbm" resctrl file to display the capacity bitmasks
(CBMs) that represent the portions of each cache instance allocated
for I/O traffic on a cache resource that supports the "io_alloc" feature.

io_alloc_cbm resides in the info directory of a cache resource, for example,
/sys/fs/resctrl/info/L3/. Since the resource name is part of the path, it
is not necessary to display the resource name as done in the schemata file.

When CDP is enabled, io_alloc routes traffic using the highest CLOSID
associated with the CDP_CODE resource and that CLOSID becomes unusable for
the CDP_DATA resource. The highest CLOSID of CDP_CODE and CDP_DATA resources
will be kept in sync to ensure consistent user interface. In preparation for
this, access the CBMs for I/O traffic through highest CLOSID of either
CDP_CODE or CDP_DATA resource.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v12: No changes.

v11: Fixed the minor conflict due to previous patch.
     Added Reviewed-by: tag.

v10: Rephrase of changelog.
     Minor code comment change.

v9: Updated the changelog with respect to CDP.
    Added code comment in resctrl_io_alloc_cbm_show().

v8: Updated the changelog.
    Moved resctrl_io_alloc_cbm_show() to fs/resctrl/ctrlmondata.c.
    show_doms is remains static with this change.

v7: Updated changelog.
    Updated use doc (resctrl.rst).
    Removed if (io_alloc_closid < 0) check. Not required anymore.

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
 Documentation/filesystems/resctrl.rst | 19 +++++++++++
 fs/resctrl/ctrlmondata.c              | 45 +++++++++++++++++++++++++--
 fs/resctrl/internal.h                 |  2 ++
 fs/resctrl/rdtgroup.c                 | 11 ++++++-
 4 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 91c71e254bbd..e7994538e0ce 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -182,6 +182,25 @@ related to allocation:
 		available for general (CPU) cache allocation for both the CDP_CODE
 		and CDP_DATA resources.
 
+"io_alloc_cbm":
+		Capacity bitmasks that describe the portions of cache instances to
+		which I/O traffic from supported I/O devices are routed when "io_alloc"
+		is enabled.
+
+		CBMs are displayed in the following format:
+
+			<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
+
+		Example::
+
+			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
+			0=ffff;1=ffff
+
+		When CDP is enabled "io_alloc_cbm" associated with the CDP_DATA and CDP_CODE
+		resources may reflect the same values. For example, values read from and
+		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
+		/sys/fs/resctrl/info/L3CODE/io_alloc_cbm and vice versa.
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
 
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 454fdf3b9f3c..1ac89b107e6f 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -381,7 +381,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
-static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
+static void show_doms(struct seq_file *s, struct resctrl_schema *schema,
+		      char *resource_name, int closid)
 {
 	struct rdt_resource *r = schema->res;
 	struct rdt_ctrl_domain *dom;
@@ -391,7 +392,8 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
-	seq_printf(s, "%*s:", max_name_width, schema->name);
+	if (resource_name)
+		seq_printf(s, "%*s:", max_name_width, resource_name);
 	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
 		if (sep)
 			seq_puts(s, ";");
@@ -437,7 +439,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			closid = rdtgrp->closid;
 			list_for_each_entry(schema, &resctrl_schema_all, list) {
 				if (closid < schema->num_closid)
-					show_doms(s, schema, closid);
+					show_doms(s, schema, schema->name, closid);
 			}
 		}
 	} else {
@@ -823,3 +825,40 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 
 	return ret ?: nbytes;
 }
+
+int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r = s->res;
+	int ret = 0;
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
+	if (!resctrl_arch_get_io_alloc_enabled(r)) {
+		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/*
+	 * When CDP is enabled, the CBMs of the highest CLOSID of CDP_CODE and
+	 * CDP_DATA are kept in sync. As a result, the io_alloc CBMs shown for
+	 * either CDP resource are identical and accurately represent the CBMs
+	 * used for I/O.
+	 */
+	show_doms(seq, s, NULL, resctrl_io_alloc_closid(r));
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return ret;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 145e22f9a350..779a575e0828 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -438,6 +438,8 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 			       size_t nbytes, loff_t off);
 
 const char *rdtgroup_name_by_closid(u32 closid);
+int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
+			      void *v);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 95d47b4b6505..44d419e4e63c 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1971,6 +1971,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= resctrl_io_alloc_show,
 		.write          = resctrl_io_alloc_write,
 	},
+	{
+		.name		= "io_alloc_cbm",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_io_alloc_cbm_show,
+	},
 	{
 		.name		= "max_threshold_occupancy",
 		.mode		= 0644,
@@ -2171,9 +2177,12 @@ static void io_alloc_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
-	if (r->cache.io_alloc_capable)
+	if (r->cache.io_alloc_capable) {
 		resctrl_file_fflags_init("io_alloc", RFTYPE_CTRL_INFO |
 					 RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("io_alloc_cbm",
+					 RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE);
+	}
 }
 
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)
-- 
2.34.1


