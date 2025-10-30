Return-Path: <linux-kernel+bounces-878775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DDBC2173B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9C9A4F14DA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AB43683B3;
	Thu, 30 Oct 2025 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HnMOgQUn"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599C32C938;
	Thu, 30 Oct 2025 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844602; cv=fail; b=ZJqCVsXNnVGt/Q+9CUQQaP1ej/bcdcfj5Sq9EeeSY+O8omjv/OV/AAO6asJcrQ0oXxraG15BNlyvOlmtX/zUUhOliE5C+aPmM92nTxObq1W3mQLmaCiGD2XZK5r2axUs/JhN78z32bTAdi3nX5Cc8nz4loakKNKiB6/HR0nXlOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844602; c=relaxed/simple;
	bh=HG2LibzwGN4Gb5ADJ6rurfZXEljHCvuDaJ/3fGzrb6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOpeEF6jLDQlRKk6MA19FpAHqMsTqFFsMeBSEy2inpcvTaczY5S+nllhPO+s7WZfmHSGxjY0/i5I4DUIL1XzrWGY7DmELOHKow06ojljxCOhm5JZbXzG95Hurwwe7Dw80n1W8QT2NWSe0vMi7z9oPjCR1w5xhBUM5idy0LlXbJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HnMOgQUn; arc=fail smtp.client-ip=40.93.194.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0i0zgm3Mph/k+WrGXrEbtkFNlgqw4+tPQS61HUAdw1yzLl9tMKTl7PZi8qTMv2LAcVK2jMsa9iTYnkLE61VNIhc5Y0MaByorhW8GEG8Zk/d+lvIjjcPUmkv2nFD1pqv3KYweppT8Rvi7ROOmkfwdIkmupG4CE+cYgVu9Uy1uXXuV5pnM49s2LbEBjb7+QfPJOEUl22V/JH/0Bx96eBsYWE43szJeLK8lfPwIzbkPuIj5jlYAyhmcCP3cyk9bc3H4NAe0KPTUAcnBxlpLtCr6NSSWyYSO6y7xSYVMr34VcWETzw6m3vrCP1psl/r7JQKRwYqlLK5UH4Ys1WNNnC8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqGjzoEGvHdjZggrL4CpPTGGv0Cc5HYgC88Qis6H2cU=;
 b=IIfFBDVzd4o7uf5U5KySK5UJLOprc2hO47j9zqAeF0Q3TbEmEdXyXsjm9VOWNCYHVB2x3PY46dAzmGIzf5rskEnDW9hLwOeRovAXpXZvlEBLJIpgr/lqZKJURGf1X4YIL7rBkWTSvmrzofUeuliJHAAPdiJAtFACvD41uCdcbKP0J+z1A5nlHlZAFY/X0T/zfAJTWPHdja4/hLjtO5o0BaInGmAmvt11HXK2zQucFgk0qU7heM2kYpetF+MbU6kaMjjqh1DBe2RnRJVgkxsbf1kvjNl7fjQh9cqsk76CAP08JQeiP/yNETKwh4DcjjkmuwE9X1593j8axHwFNjeuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqGjzoEGvHdjZggrL4CpPTGGv0Cc5HYgC88Qis6H2cU=;
 b=HnMOgQUnZdDPAqa/EIVemUWwqZHaKURkMVbb95Bm5FKVXf0XX58fE9kBu5tyn8IGoSWpI52zTn6PVi0Gj4wtARWcpb2kg30xMs3eNLwbS6us32xjzMBGeQB6kfPKwClXhATZGUVksvKLapX6wWbe4ZPV/C+8cAEhV/S4pg/e2pI=
Received: from BN9PR03CA0961.namprd03.prod.outlook.com (2603:10b6:408:109::6)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:16:36 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::de) by BN9PR03CA0961.outlook.office365.com
 (2603:10b6:408:109::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.17 via Frontend Transport; Thu,
 30 Oct 2025 17:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:16:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 10:16:34 -0700
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
Subject: [PATCH v11 05/10] fs/resctrl: Introduce interface to display "io_alloc" support
Date: Thu, 30 Oct 2025 12:15:34 -0500
Message-ID: <f0ee216e76fd5b81119f31f07db7990cd240fbc7.1761844489.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 863e441b-c2d2-4e5c-eb2b-08de17d81480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C5/52HbfmhB5ipYHWS+CwrQlo6Vf+KLW37O6olDMQIC6peYeuGzAd+n3gg44?=
 =?us-ascii?Q?PujqzTKW3nsZtCG/009t3hH58TLF/KXKS8ir7/g3cj4siW3XqqGJ3ETdqAwX?=
 =?us-ascii?Q?PFhDERwVz6NDgRm2pnFkPPlNuOMJTpZ+r9lCtuegBzvKeHeiSsR2sXomu89U?=
 =?us-ascii?Q?zb9caYG9DRa9zIdw+2fIts1JBO3zqB8JMpf6U43wvUhHpbHSZg11x74V7Tbt?=
 =?us-ascii?Q?FGvaynqV+sKQlLh01cCQeSCQF2VAZlcaeTxzhs+QmplyYYFkRL8FhM+nv7XX?=
 =?us-ascii?Q?ZBllnQgN6/+VY3luJEJPAYJnRcXDDzE12LOoBBk55/qkJpapQyS37B//yGFK?=
 =?us-ascii?Q?mI8tC7sjjUbwFwMaXTLr0YnKUOCnvGqag5SQ/k9P6fIpXPbVadsgQFKKhcwi?=
 =?us-ascii?Q?nvXaCFMZ4kf+aoXj0BKvzAS3pAvhDc2VRbBBg1RVTVuKFzJ6zZS3R2roaz2r?=
 =?us-ascii?Q?YeHkD/nXuYMAqM1SKVdN50l8FDxEgk+tk0W1H9YbX13knBt5eyh1KUc9rQlm?=
 =?us-ascii?Q?bE7ZxIUHUn2lIqenmjxBBRIKek1wWb3VKuLRBknvzEhx2WuAo//s74ipVlw/?=
 =?us-ascii?Q?oJDGoaz6eqqtiRCHJ+jYWkgoRVPXCYDJvNmvdNbtp14YB3ebKRecwFHyaZBv?=
 =?us-ascii?Q?BnNgh9aLokJCFmJxX0x/IxXMyQ3nkpfFT2q1nhh4lMIoXUH0e9w01bm7yO5a?=
 =?us-ascii?Q?O3HsLNH8N8V3YM0NiB1vS3ByKIUBamwMWNFcXGRANompkIyhYZVErNSDVcW9?=
 =?us-ascii?Q?83cxc7EkaZUZ+hP+C65bs2B1sGC4aJzoxqaTFrXy4prS3dj6tv43pYKWqGXL?=
 =?us-ascii?Q?35MIO8Akp4mm0OnHAI1rL7YCFJj6Y9UWp8QF5LEGTzZ0c8pfHCvzucoShZm5?=
 =?us-ascii?Q?FmsOFbulwJ6iXQejQStPj0vW06tWHZPfD0qZ9vCFsKjuxDHuAVuhiCBehlCb?=
 =?us-ascii?Q?DoK/jpjJ959Szu8XSIWEHgzfpqdbPIPjinWEh8olZhsvsk3gIhguhMR8qJW1?=
 =?us-ascii?Q?WykyPENSV3SqDulm07+yj1XPFmUDv/eiuj8lANfW37YqxgKp0fFFwbKr8/nF?=
 =?us-ascii?Q?UhlCR8/KiypanI6APrI37mIBOPd8APrd36qBeaKPdmuSZQxwt4unr78Rxoef?=
 =?us-ascii?Q?yWdGfdeY5dssgx72U7c1vquuIjzwyPfx6KvMg/0AfvyOTupnDusArEyW52HQ?=
 =?us-ascii?Q?Pp51spMn3oNL6K6//aH7/fvsQnYhbEdqfsgaLhJWv35GKLRza+xo8Yj/GT8K?=
 =?us-ascii?Q?PIU9tW+YsIvi5cxM8vCnyYi82DbirdCEhcq3h7CJkMMIGoTNzxPzn6ZGfKis?=
 =?us-ascii?Q?rqkQdKcQl9th9rT4z4PdMxuF17TN1xCC2ZXlXs9PMU8g5RfvI5p2NPVpuXUB?=
 =?us-ascii?Q?LVKFVHYd2iOESbUBymQuv+pHQdHdHPr2JBqXqeSGLndoinFLdYe3JGNl5epW?=
 =?us-ascii?Q?17d/PzYqeiyL14lDMX0Dl55jJBtoXb3Kt9jPYouQzHVHr4F0NQ0DaU9HUzJH?=
 =?us-ascii?Q?uwvrUWNJkuUKR5ieJZib+SfN39BxD7b54E7tx5w3/qJyrgUaETuSHasas3HA?=
 =?us-ascii?Q?CVpf2RjqujB7JIgmEnU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:16:35.7105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 863e441b-c2d2-4e5c-eb2b-08de17d81480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455

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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v11:Added Reviewed-by: tag.

v10:Changelog update.
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


