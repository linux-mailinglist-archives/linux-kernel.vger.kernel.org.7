Return-Path: <linux-kernel+bounces-863886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0E6BF969A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3555E1198
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E452EA48E;
	Tue, 21 Oct 2025 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R5A+A3ey"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED82E6CBE;
	Tue, 21 Oct 2025 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090969; cv=fail; b=SSVWPQ0+LtiV7XzUkc5krlOWEq5aII8Wq+WZTr0f9T0CZOUOQA2quvsbu5HsucOkE1hrcndklF1F3FK2gMH1lXVLJhibNCMgtloxH0DPahfID71v7tW39pGaOVg5BFThKPuSEwM0oksQGqtlUGQsevVlzp0gH7Hh3mnD0vMx6wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090969; c=relaxed/simple;
	bh=Yjpux/DEJOLFOzi/L9KXjO02Ttr8Tc3eq9z7xK0kAXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z20ZP9ToR9sCaRsXCxF9Y7jd+RRrWqUtGo5RAUl+St4yfWEIJCNJOILipJC8BoWlqYAeNjCqtPHogpa2qzY9UrrdrWdNFLT2fEX0MZbNQPGGLXLzXoU8SoJpJEm3Y5F+BgB8W1E66AfD4hFLPFGAP0P4A2f6pkZ1Tb/hH3/NvDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R5A+A3ey; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxL66vpriD5AHb3K3B16rGshAIf6yCdUppT5uEyuYjRDeG1FbLuAA9+vSPocKeHweMd/cUos6IU3br5myv82HPK8jYVbOXGtCPh+ECVTT1L1f8I1hINUAUmFCFqiLgfFDzXXpDQsV2S4PMl/V2MKoY9eBuGprlAVMD/3lTmseJWaKAhzm07qebdtxtaVXKlTrGHSHEIg79dBdh9o+KdL2G+Xjaczrxme2FJxwAm9MaZwJnmtRJiWVVJd3gF3Jx9wTiMiG+m+gvUEmeYyj+Rya5nwLpwseaqC4kUEqMPnUH25oFJqgpgIJwlLs1EXKcR/aguUfppztKTrpxItjFrVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5dIXXbcO+Y40+NpFdqE5LVPoeOKJj7wBucGswqYX8k=;
 b=ngzP910U4Ch5BLNXPz+AYr78GDYseeBdfuiL7xEkegrZ5+TjSJDANY5XxVjFTQCdtVQ045PdSJTc9j1T2ZTYSwkPWvSXlur0bdcoVaIs39iu1hEXf58i1drVSrAM7p2xat+WoIHoUAkaBat55RGfI0TaQqdCGoG+W1avZb4AWJqfacmdLNmxF5xpI5DtXSc+mciK1SJ1ZLeGN4B9S7ieQ1uohuzElYWWUA5NUhi1iZHbqxutFlocFO+TF6Hlq06EMa6Zn1bpWdXiFI2zcPLcY/RDYheZjJsVRUnXt0mvd6BzrOb23UgehoR+aINPQYJy3itQsN1etd3ADT6ImtYExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5dIXXbcO+Y40+NpFdqE5LVPoeOKJj7wBucGswqYX8k=;
 b=R5A+A3eyOBBHuhf1UpsM3twC2ETeGFcqAAl5OPmo5lv1fmEviEYs7onmNNPg8dPsGOTrujcw7gqAuqh+m55nbGB4NfmurVZpkcVzFK4XAUUKUUiIDz38KfHol/QzZA11P+NQ8sDpppddFqNsu/ZYcTwc86wXjElyxXwlpQJMytw=
Received: from BN0PR04CA0148.namprd04.prod.outlook.com (2603:10b6:408:ed::33)
 by SJ5PPFA5F0E981D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 23:56:02 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::b6) by BN0PR04CA0148.outlook.office365.com
 (2603:10b6:408:ed::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 23:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Tue, 21 Oct 2025 23:56:02 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 16:55:59 -0700
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
Subject: [PATCH v10 05/10] fs/resctrl: Introduce interface to display "io_alloc" support
Date: Tue, 21 Oct 2025 18:54:48 -0500
Message-ID: <a47ba310e232e01d9d892ea30d570f73de3f8d8d.1761090860.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SJ5PPFA5F0E981D:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ede131a-794c-49ea-d2c8-08de10fd63ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Emm3eBM98KkaSqvWCDGzymoht5cvoBpaIqSs1L18NghF+3STOnRTAYeK/9iG?=
 =?us-ascii?Q?fwsNYonS8ndHeizd+lkXsOPIHm7CGfivf7yClPbclD1un0kU9Gz/vdv6lM32?=
 =?us-ascii?Q?Ekiagt5uTH3UyhhMuCdWMaoQwliEP5HW17ugqE2+rzWXCzX7cANiZ/htrdgd?=
 =?us-ascii?Q?3vBA+QIkBeagpjsK7piD0G3FJMStCUYtFoEIVmYRzt9d7H2nkQqFBQqROFGX?=
 =?us-ascii?Q?BgdpSc3Ch/ejQ3XHPbuOOJqmKanm9gMEV2fHT2wjQmi8f8MDOBTXuxi/Ty5l?=
 =?us-ascii?Q?Tg/n+XXtuE7VVDvaQHQislxSDMmrBOysW4+ihnIABVsCr3HjQ1Pcx0ssHTfY?=
 =?us-ascii?Q?i8w9j+JrwA+xXt6a7aHMTtEh4ICtHj3OSUzT9qqLfLNmZSauUPyYAGkoDq9t?=
 =?us-ascii?Q?JZtghsWVBjymkb4ljQZkir/DeZWFOUAt2PbaFn8Yess1MZItouwRhKECr+Et?=
 =?us-ascii?Q?NdqsCf167r2wO6L8REaenDKvblHBVj+cg07YQdGxxWjNvlEpP9ZXhaFfGsEj?=
 =?us-ascii?Q?evHDTQnG8T0qjx42TK1KLDAqxgVE8ooF3Dbyqfkmr6QOguROpPlVp0oeHIeh?=
 =?us-ascii?Q?uYmwdNWGhrb5i8puU1/9HYV4ZCCYDV6VSXLQrdJbq41WDPKw1K/1dRFqTC2R?=
 =?us-ascii?Q?kXcutlc3kplsHY3S/l3wV40kKA7QwXXYm5QZi1iE7PvQD5BDIkSXjb8uUiGv?=
 =?us-ascii?Q?gC4W7EzcB0A5DLtqLJqJllEKRs8kx0/JNPnCyZKI0H3xmFzsiuvxRFixeEgY?=
 =?us-ascii?Q?YT4t9ipdHxY1REUvDvbG7IwCeBit5Gk5NClMufPqH9fUDyEljtuaA0Prb95e?=
 =?us-ascii?Q?6+Xzrp9UBdKbKjGJvAFAzwKiSNNQ5JC5VB1kVHRINISAt4XJ4qN9lsV6c1zo?=
 =?us-ascii?Q?DG09/R9vF17OSCEjii2DQTRsrrgsxcaYslLx5lScOUKWYaMQD6OP7XR7AUB7?=
 =?us-ascii?Q?/ct9qZcLIuRijCO25wjrkGAX6k9TbNoAutHIZmyhIqhEQ9tVQSVQ2sqYh7yZ?=
 =?us-ascii?Q?H4uU9w53L/mK+0MCLpqS3xEQYydXKrD3cRwGgzGV9pCpxyqkbRzS2FI0EHw1?=
 =?us-ascii?Q?U/2SK03zHcaqO8PonbQ+eAgXzmOX8qi8Z2KIurq10OJLeM2D9MpPXWiqs2PD?=
 =?us-ascii?Q?XkftDXS4uzIsKcXQWqGkXLJVKg/+QoEYYgxBpyEmDcJnmI962LN/5GOHxSt5?=
 =?us-ascii?Q?fvrQjEqfa2x4zWZ+CsiBbEvzn+Y7rJ1TUBQC1XFPxQM/992SoPrKwlGFKMuL?=
 =?us-ascii?Q?ER8kmSRFor25hGZ2XFdOP3q0lVaJx3Fi+HjOAeSnIxq6QJSgilZbdYk8+4Rr?=
 =?us-ascii?Q?Yz/QtASOUdd0/ZP7U0r2RVaYeh+GRkQ5/OWdhzHXTAB46FX3O145YoAvBbhM?=
 =?us-ascii?Q?INLpT49dWS+13O3FfFMPIXbbJNvrUFIwjqZHU57AssZ0eb1Bm6fBaS/IooIg?=
 =?us-ascii?Q?j0XjqhQBcISSQp8U217AxMGsfSsFBbz4w1M5Yem0s/hqyeZvo77wDmbt5gr8?=
 =?us-ascii?Q?YdklstrVj1/X5fSxrgLbZJsqGUeWg/MgNstEPQu8ulseojKUtoW7kkSuoTDL?=
 =?us-ascii?Q?5slaIR9OY7Dzmvmb/aI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 23:56:02.1873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ede131a-794c-49ea-d2c8-08de10fd63ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA5F0E981D

Introduce the "io_alloc" resctrl file to the "info" area of a cache
resource, for example /sys/fs/resctrl/info/L3/io_alloc. "io_alloc"
indicates support for the "io_alloc" feature that allows direct insertion
of data from I/O devices into the cache.

Restrict exposing support for "io_alloc" to the L3 resource that is the
only resource where this feature can be backed by AMD's L3 Smart Data Cache
Injection Allocation Enforcement (SDCIAE). With that, the "io_alloc" file
is only visible to user space if the L3 resource supports "io_alloc". Doing
so makes the file visible for all cache resources though, for example also
L2 cache (if it supports cache allocation). As a consequence, add
capability for file to report expected "enabled" and "disabled", as well as
"not supported".

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Changelog update.
     Removed the h/w specific details from this patch and will add to the next patch.

v9: Minor user doc(resctrl.rst) update.

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
 Documentation/filesystems/resctrl.rst | 15 +++++++++++++++
 fs/resctrl/ctrlmondata.c              | 21 +++++++++++++++++++++
 fs/resctrl/internal.h                 |  1 +
 fs/resctrl/rdtgroup.c                 | 22 ++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index d7a51cae6b26..108995640ca5 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -137,6 +137,21 @@ related to allocation:
 			"1":
 			      Non-contiguous 1s value in CBM is supported.
 
+"io_alloc":
+		"io_alloc" enables system software to configure the portion of
+		the cache allocated for I/O traffic. File may only exist if the
+		system supports this feature on some of its cache resources.
+
+			"disabled":
+			      Resource supports "io_alloc" but the feature is disabled.
+			      Portions of cache used for allocation of I/O traffic cannot
+			      be configured.
+			"enabled":
+			      Portions of cache used for allocation of I/O traffic
+			      can be configured using "io_alloc_cbm".
+			"not supported":
+			      Support not available for this resource.
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
 
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 0d0ef54fc4de..78a8e7b4ba24 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -676,3 +676,24 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
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
index cf1fd82dc5a9..a18ed8889396 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -426,6 +426,7 @@ int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file *s, voi
 
 ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
 				 loff_t off);
+int resctrl_io_alloc_show(struct kernfs_open_file *of, struct seq_file *seq, void *v);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 0320360cd7a6..6d89160ebd11 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1947,6 +1947,12 @@ static struct rftype res_common_files[] = {
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
@@ -2138,6 +2144,20 @@ static void thread_throttle_mode_init(void)
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
@@ -4408,6 +4428,8 @@ int resctrl_init(void)
 
 	thread_throttle_mode_init();
 
+	io_alloc_init();
+
 	ret = resctrl_mon_resource_init();
 	if (ret)
 		return ret;
-- 
2.34.1


