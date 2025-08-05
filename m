Return-Path: <linux-kernel+bounces-757073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25250B1BD5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC5718C013D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859522A1E1;
	Tue,  5 Aug 2025 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="voszSRrF"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27C1C5D44;
	Tue,  5 Aug 2025 23:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436725; cv=fail; b=OxoX7C6pypFXIyyex3sLf5RIbP64POjKottN9Cly8MkDko2DPxHvd6+MRk1hxopkjexIUCHSQ1N/+NvNVIcuhp5XV5G0Hoz2YCf7aWifSd8HOJirZJ1yhAmH5KGec8wte9oa3EsImnxkoOg2YN8o38S9BMGm8FYXheYuaJuSdaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436725; c=relaxed/simple;
	bh=iaxoWRPg+eurxLs3XrKfTyfW13evo9pJ63LVJsFlb/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNajnxgv0fhEzGECz5Gw4wpgooS6PwM0g0Z13sWghthON0yXiLMCVvKwVJHUXFxEoNrjkTzPZvS/yexLpL37qvf7rmkbur2Ay957finbYwd0obC5cDtJMKKECg9fU2wiYs8AIYPknYpBImO+ti+5x3rCE5u/v7rLcHCDmFq3Hks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=voszSRrF; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VympCtUlrQTpylkq1KHZZxYq+K5lG0B432BQg44YVe8O4CJ6q7Vt/LWNvmOX4AXV16vEWsqSWwC0e7lPJj50IwgFGbchzcskCsBlH1ekQoa+hqzH8BnSsfc1FA+nl1/YB2ipYinsaBxUCU1RDAv16rqiBxwnP9b6HShDAmr9yL/zP0Gp7nt2XIdzfRGH55/NzaKIDXigptJ7pA5PF71oP9kGKhC+f0hQchIPHaeTSKiMkq0N7J4LdAVyFKjr4ZwksXts6d2+nvOuLR9RNfeOhlLwKQ6ZauBhg26fhFzW3eVtybFQrW8JhTTUOjfx+Ww1/WLV9u33JLB9IVg8XS291Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfpGEC95mod1xXZVCssAwaHqHRp/J/sYJKeILDwWN+Q=;
 b=IZIhLNMSruZuEGv83vuF0GjzTyOLeMtoZ7TTKGmnKmLyecbNw1CLY204ESTqBkuLpqb1uhUTFBNi3BBZb3WiXpRBZU4SMWDCc62n44H8GdvEUoJAf3X9zhKkyBin3HsyCM34anfcaKMgtgYoMG5JbxGrw33VpiL6jAzZFgQg0x85stwoxNErD6jfimTdsc2hnnwQHLdimHlh45trny9hl47fLPLKGBADepP9GrYSDBcKf0lVe9DqbZy1ZLGBPe7sPGAUnDhzsIJeaXaUL0cqdsVuDeiAkLRib5fRwcF1rypTzg+8wF5Yde2+OHRgdwJVbtaRrCwogvKUZmA19ym5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfpGEC95mod1xXZVCssAwaHqHRp/J/sYJKeILDwWN+Q=;
 b=voszSRrF/FK67Bpo4yuq4gYj5hUu9BsoGxIMHzCyBIQ7MRllWVlTWoV/b1qTWpNAnWTwpMZ6EXpMIbqvjTMTcpG0Yq0kwl0/s86lhCe7E1LJ+l51GlZ5flPuetj9EH5fil0MfbcRcQmAmMAID7ACdmCKe/BFelHxeoq9zalxysA=
Received: from SN6PR04CA0083.namprd04.prod.outlook.com (2603:10b6:805:f2::24)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 23:31:59 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:805:f2:cafe::69) by SN6PR04CA0083.outlook.office365.com
 (2603:10b6:805:f2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Tue,
 5 Aug 2025 23:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 23:31:58 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 18:31:55 -0500
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
Subject: [PATCH v8 07/10] fs/resctrl: Introduce interface to display io_alloc CBMs
Date: Tue, 5 Aug 2025 18:30:27 -0500
Message-ID: <a5bc5ecf27c229a0cf429dba6a174e39cf83357b.1754436586.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b04f52-f049-4a82-c301-08ddd47845be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hvpwr11Z7wFRL5bMV0QinZQMtAQD1PvEWUfy1Xp4Ir2/trvYiS5oE4kakj0r?=
 =?us-ascii?Q?1ECVdjcYJytS+t5vla4ZbNhLHlIJAjfPj/dj8kh4tMfVF1SPDJqqocBAt6i1?=
 =?us-ascii?Q?4UZ6MZc5eZg3qvQaa12vJEyJeNhCKvMryKbG38O2I0Ajt3lg9bWprZS8k+QP?=
 =?us-ascii?Q?4aWFELcHXMOEq6W07CGpMYVY/ooDZiDwXg5NQ+yDjX0Y5VMKvRLllZcd4MMf?=
 =?us-ascii?Q?/jm2mxXOLhv2J5/giLAHcWi4hkmBu/CYBCIN+JVMEYTRA/1d1MQnTx/xqQ5A?=
 =?us-ascii?Q?LGUEpfXaI35zYjd10YYhjd4lCIp/AIKtVVHs+zEFfp7B48SJRTpWNqSE8low?=
 =?us-ascii?Q?36LNtFy8tKiYLo3zlI746Hf+J/vNYTLz8/70sSaCFCKNzEMUfyw54scZFeZc?=
 =?us-ascii?Q?n/1pMw3BI70jzOSeEYw96O1AzVliCv3OiBy0vwtCgZHnw/QQrbAQO2VpYj+s?=
 =?us-ascii?Q?PaaRfS7Meo8msUvnlIFh+n4+I1FR+MB3huz5AYHMG+ivzEL4dSvVmuEIhGX/?=
 =?us-ascii?Q?DWifr9gcRc5RkA80X5j8fjPYge3BW6uClov8JwBr7729MPhCpQZ/xgecHPHU?=
 =?us-ascii?Q?vFMQwcN58tMeSq8EEhEhK4C5+OZn1ytpqH3zmeBJC8/723X7FVBg0sLvqteT?=
 =?us-ascii?Q?qVgDRe3O3wlTMfiexx82DqQfLgZzTWnS53hIj4VgN8/yZ5eW76+eiZYYJnr+?=
 =?us-ascii?Q?TEJTEAu/VJTlA4TP/dTMknOy5hx4ht3t2z89yhGj6EU2Lg08dC90ItC92Rg8?=
 =?us-ascii?Q?CKmF5KnlYvR0hmDvs+xpJ82XTTEqW/vhFVwhj3HWHJhijfCjZXpMmkTqWpzl?=
 =?us-ascii?Q?llfUck3YNJ8e96IwT69DXZ3mOpv+Wn3F0d649GiM1jtZ0Dvyn84dsxzYU5R4?=
 =?us-ascii?Q?tFYN3XuO8IxLWgImGzXalH9lEI+EUBby5FaVPPKPbk31UoWHQ7KNYnvonoo2?=
 =?us-ascii?Q?m/ZLte6B0+WDBIE3tbGXx4xW1OpsnVaJky1aZttuTHLFk0UOg1T/8sdmdwP6?=
 =?us-ascii?Q?hYjNRuSMK5563vD7N+ZIyVMA86pSlJ6Ltwa9HT+PD3kZ3YZSMmy4BH5y1dxe?=
 =?us-ascii?Q?BwiCMlpDZ5eGgpy1/EzY/LzFXxeGV31f8y9fJjgJShRSV5yn0VkGd8B+mEcB?=
 =?us-ascii?Q?PZq3lSTy+p6WEvK2NvTaiGviKBvFGtNShFYWz+buIhc3UoZATuWZ+hKGlbO/?=
 =?us-ascii?Q?pq8QxJOhDn91nRwXCX1BI3Q2VQL8ARQgiyRFCOddBXsYjFhX+q1Q0E5O0UIn?=
 =?us-ascii?Q?G6sZJN9NFkfbHlYT+b/pQUonU/s+VPUY+Yzw+jZfEVZsqds1pkjWGywYrT46?=
 =?us-ascii?Q?IfBld3hRXVSpmaxZynmn1AKk74B8/zcsvrJX8flglF47r7/Bu/NmRuOS+YbJ?=
 =?us-ascii?Q?DKYk/00uGCdrB7Ziai0xS2Ro7db2D625p2wZwvqt5Kz9zZbSrRoGuQrzK5PI?=
 =?us-ascii?Q?okwjmghXSv6k4w6+kNolpSIRSqUImT3iq5m6uRIlpD+n0eD/K9TK6Np5yW7M?=
 =?us-ascii?Q?vlp42VI2+vhhi79lkap5DIxJU92j8VSNPlIR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:31:58.7042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b04f52-f049-4a82-c301-08ddd47845be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727

The io_alloc feature in resctrl enables system software to configure
the portion of the cache allocated for I/O traffic.

Add "io_alloc_cbm" resctrl file to display CBMs (Capacity Bit Mask) of
io_alloc feature.

The CBM interface file io_alloc_cbm resides in the info directory
(e.g., /sys/fs/resctrl/info/L3/). Displaying the resource name is not
necessary. Pass the resource name to show_doms() and print it only if
the name is valid. For io_alloc, pass NULL to suppress printing the
resource name.

When CDP is enabled, io_alloc routes traffic using the highest CLOSID
associated with the L3CODE resource. To ensure consistent cache allocation
behavior, the L3CODE and L3DATA resources must remain synchronized.
rdtgroup_init_cat() function takes both L3CODE and L3DATA into account when
initializing CBMs for new groups.  The io_alloc feature adheres to this
same principle, meaning that the Cache Bit Masks (CBMs) accessed through
either L3CODE or L3DATA will reflect identical values.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 Documentation/filesystems/resctrl.rst | 19 +++++++++++++
 fs/resctrl/ctrlmondata.c              | 39 ++++++++++++++++++++++++---
 fs/resctrl/internal.h                 |  3 +++
 fs/resctrl/rdtgroup.c                 | 11 +++++++-
 4 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index bd0a633afbb9..3002f7fdb2fe 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -173,6 +173,25 @@ related to allocation:
 		available for general (CPU) cache allocation for both the L3CODE and
 		L3DATA resources.
 
+"io_alloc_cbm":
+		CBMs(Capacity Bit Masks) that describe the portions of cache instances
+		to which I/O traffic from supported I/O devices are routed when "io_alloc"
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
+		When CDP is enabled "io_alloc_cbm" associated with the DATA and CODE
+		resources may reflect the same values. For example, values read from and
+		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
+		/sys/fs/resctrl/info/L3CODE/io_alloc_cbm and vice versa.
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
 
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index bf982eab7b18..edb9dd131eed 100644
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
@@ -822,3 +824,34 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 
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
+	show_doms(seq, s, NULL, resctrl_io_alloc_closid(r));
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return ret;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 335def7af1f6..49934cd3dc40 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -389,6 +389,9 @@ enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type);
 ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 			       size_t nbytes, loff_t off);
 
+int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
+			      void *v);
+
 const char *rdtgroup_name_by_closid(int closid);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 380ebc86c748..6af8ff6c8385 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1917,6 +1917,12 @@ static struct rftype res_common_files[] = {
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
@@ -2095,9 +2101,12 @@ static void io_alloc_init(void)
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


