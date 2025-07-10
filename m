Return-Path: <linux-kernel+bounces-726228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2EFB009C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145497610C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF4E2F19B8;
	Thu, 10 Jul 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AbClu1Kc"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045322F19B3;
	Thu, 10 Jul 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167893; cv=fail; b=igv+cAJl5yl1Oo91v/RrxnXQCqDmGq4DJ1uSegkZgB8bk70WzCJG49i+8nWOMAwviykzvnXZsxkulEvcsHhNoZdpcb5Bl2q+Mi/6Fa9lawXxaeo7C0Ks1ME3f2zf9uLdJjfknDFiroUfAtC7FSWspm0OV/NjYm4XMxG09rzTAdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167893; c=relaxed/simple;
	bh=dMsC3i6V0gWuV7YWdK9jAPL74ZChVb+p7niD5XsUrKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ybgo5aSFDn3WqsTvEcWgMKx1cti21HXyp9IW5YDCncUqYLOYym7jZaKsG1n08w/McDS0SVgOgZVfv76RHkO8aCcWZVnhLsbCsmkIqXm8nEL+E4ZzcDzFLWhKzvt2z0nhptbZJBXqdDjqy/G+s3ATpSEZ0MDNUnXl4KV/u5mOIIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AbClu1Kc; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5NaWyUb5LSqUqKt4xkCggtwOUI/KGzSOVV0jU8vBlxhrJAf3uXINI2hQPTPsl9r7exg24c3P1RZ+Ye9P+XsUsUE7XxdZ+v7kAMGo2RHw4BMecT1YIsELgUyj7o/3gIZn5JFPpCmC02K0zwMPLYQymTf5QCJlPB+GvNMKbbf+Tw/PZQ2l8KoZUT32+pmBVnnbwEYQPnVN52MD7NDVz0w3++OHSZnQM+4MnwgG28uGjep06PvQ+5efFDxrOkpIOeLe47j1RwfmcR0vDJ5snWOzKi0SirEwPj4T42DfeXg1hHuXGKX6buJl2U0VtlMQH358JR6RWo/c/wkrn4nhNqRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1P99AnkPN8ifVdABFqhQegfd9GPMuB2TA74NLuutgI=;
 b=fnLOU0xabhvLqub/Kb1DMaLOXoHmWXjgEGneJoKFqbnW2mzNKZTfy63zrqMwvd5XG42Qnti3VYUHRqtGC+7BoAj41Ta1ro29s5jxEzhMSXzBT81mPYwKvJWSrNVeI5mowu1/YPbPrh3NZPfgIp5si7siIJA+eL8w/qSHma4Wt2ISNWkLPyZAjYuV+K3hE9CJgtaJ1unGK+aT3wX8NRJkhISDbNtU2IKu9/4S3fNvBzXECDo3n2SVVkEaUFuxUW7xxfLdepwyd5N0vB4E/m4F/v24TUJoYqa0JspuHyVAMNAisVxaZOOJ4ybQvSxBhBTKcUiofhNOguccVkrhMRcwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1P99AnkPN8ifVdABFqhQegfd9GPMuB2TA74NLuutgI=;
 b=AbClu1KcS/3fi8xJwuWP9ygbZ3MVaMSqtpjhpmuC5RNIsNzR+0yBeXde73vU7SUTSBJ7F3oNE6Cp3VWwPTMBB4PKoO4qdPv7g3D8qAENlSFefppNCBA+vpwaydzul9UQGIJnb5LDYPIVXfPb1W/HyJDMVPiKQTjqurg9yGbOtlI=
Received: from BYAPR02CA0056.namprd02.prod.outlook.com (2603:10b6:a03:54::33)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 17:18:03 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::63) by BYAPR02CA0056.outlook.office365.com
 (2603:10b6:a03:54::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 17:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:18:01 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 12:17:57 -0500
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
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 10/10] fs/resctrl: Introduce interface to modify io_alloc Capacity Bit Masks
Date: Thu, 10 Jul 2025 12:16:24 -0500
Message-ID: <a6f4ae3a709185e2c0904d53267e99e395a492ed.1752167718.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752167718.git.babu.moger@amd.com>
References: <cover.1752167718.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|MN2PR12MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 094daa52-fc69-4e56-a5db-08ddbfd5b9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FeL3GvqLfMzfhW85MnlyBttvAc3Z797krvsYi5hA//WmrYSwjJae82+9b9dg?=
 =?us-ascii?Q?6kbV8d1ldkU65Y6OIR+EjaSethfWTVedpQnEVOT6k/K/cHCbB7C4ymgIyzmJ?=
 =?us-ascii?Q?wUZkINbf/iya0nxdVMX2znyztij2cTlODN51zQm6cCQZIsdc/5M2RgA+Eqjn?=
 =?us-ascii?Q?eoCrw1D2LJsSHzpAQcFEWHmxE3B0KXEcbcWf8J4euV15bqJI/Jn953uQmOZo?=
 =?us-ascii?Q?v2jIj7WXZu9W/Z6hlRyUjnlvl7I4+6hnNp77VizG9hLkO53ir1czqOCrb54L?=
 =?us-ascii?Q?KJBbinE0UPQUKYSk58RpgQcQKDcXSy9skSAjTYAjXYrElIDQ1RCBuL7qIMTj?=
 =?us-ascii?Q?FOhnbdhgR3jy5v8zYEd8J9SlKB3BrtBoMwkKPgCGLA29XQEkFzdufKudW5C8?=
 =?us-ascii?Q?xyCcOujLdirB/c+sg9xc2FwD6yiTujr764ToYv+85jqL6dpilaseFbgRl6nT?=
 =?us-ascii?Q?OAiAxBYs/wxhsJcfJg6mmim+rdIs5H3Un0IsatCEXZoZfADogVKU5p8Spmta?=
 =?us-ascii?Q?wWq7V5jexZhzMwkqW0LjrkTaBOMKhe300VEB9i7YazGE9m+wJ64qqwpI/hjv?=
 =?us-ascii?Q?jSzRQuGOw3s8hNvHC5KaPj0+SLpAKZ7950fZdoPTZk/1mC6FK9/DgKi3VBUF?=
 =?us-ascii?Q?n9bWG/z6dCOP3OSWapGLFi3V1L4Pf2c+ABclAauiteHEl73crr2YXf9dSSPf?=
 =?us-ascii?Q?Su7hi93P13JmFMV1TCIILeIWUerW5d0IhupS4XD/T6RYsow7LRwgs4VuogbE?=
 =?us-ascii?Q?bMhP7OrxxwmtbG1wBtJlpfRV4Og/ysLDxBiDDdprIQvRazZ7+D4k9Dh5zMHv?=
 =?us-ascii?Q?KwPJL2LU3tyPeiYk5i5XaOoM1muFCnQytWQgQCn0p1kJcBV5eU2YJChq1NzE?=
 =?us-ascii?Q?tgaCGxRy9ZzAeGijpW3h7pvjm4VU0kYhjkq7MbBKOua0lgZyV4UqjCi0zKiJ?=
 =?us-ascii?Q?SPFnDU5YXW7A+zj6eMh950oKklANLjNuoNZ05Yf0bB4dTnsn0GcHxnvAvwpW?=
 =?us-ascii?Q?qfvjiTp1d62vPXsaBJxRy9Gajr/DHGWkHsDT3Ndfa7CugZ+t5v9ESZDKyXvT?=
 =?us-ascii?Q?PFyC7XAOx7Ipxs8KYnHlHxvz5cOZwGA7QcvO6kdYr5OlnlUCqYa0OXQkMzSQ?=
 =?us-ascii?Q?gGBlEIlfLUJdPf0tiqvuE93qkd9xZIeDflgQbg5jPTTCDSLBGcQTaK+ww/0b?=
 =?us-ascii?Q?LwcMZ/2F+o2rRPeKnia88KlrZB5du6MLj73fZ2QfYkfanOJ2KHpBfVUztRf8?=
 =?us-ascii?Q?/sAvzLKVApC8+VZQAA/2avbT4uh/RSbVHLAbxAJ7Xo7rDyxP7zqTQplF97Lu?=
 =?us-ascii?Q?WweYBQL2+Aw2+GTpNVojriKxny+r91LWOTWhvkWXlARefUe6f/uzLqqTAgIW?=
 =?us-ascii?Q?OlKD4KAbi6SA2DHkBcs2rcfFeTrzeeiQOso1cyHzO06rASmP0aw2dRTn4DPQ?=
 =?us-ascii?Q?NrqSkTIDlbpk/K0DRIfsmgLHdxXD1aQB3ebfKGaBQ21hSLeYeUgsZbT7883g?=
 =?us-ascii?Q?LlPK/zsHs8fxZ2aZbsS55iNqtKZas5SpXBNA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:18:01.8710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 094daa52-fc69-4e56-a5db-08ddbfd5b9a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438

"io_alloc" feature enables direct insertion of data from I/O devices into
the cache. By directly caching data from I/O devices rather than first
storing the I/O data in DRAM, it reduces the demands on DRAM bandwidth and
reduces latency to the processor consuming the I/O data.

Provide the interface to modify io_alloc CBMs (Capacity Bit Mask) when
feature is enabled. Update the CBMs for both CDP_DATA and CDP_CODE when CDP
is enabled.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Updated changelog.
    Updated CBMs for both CDP_DATA and CDP_CODE when CDP is enabled.

v6: Updated the user doc restctr.doc for minor texts.
    Changed the subject to fs/resctrl.

v5: Changes due to FS/ARCH code restructure. The files monitor.c/rdtgroup.c
    have been split between FS and ARCH directories.
    Changed the code to access the CBMs via either L3CODE or L3DATA resources.

v4: Removed resctrl_io_alloc_parse_cbm and called parse_cbm() directly.

v3: Minor changes due to changes in resctrl_arch_get_io_alloc_enabled()
    and resctrl_io_alloc_closid_get().
    Taken care of handling the CBM update when CDP is enabled.
    Updated the commit log to make it generic.

v2: Added more generic text in documentation.
---
 Documentation/filesystems/resctrl.rst |   8 ++
 fs/resctrl/ctrlmondata.c              |   4 +-
 fs/resctrl/internal.h                 |   2 +
 fs/resctrl/rdtgroup.c                 | 112 +++++++++++++++++++++++++-
 4 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c22a9dd667cd..b9c3ffdec27f 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -189,6 +189,14 @@ related to allocation:
 			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
 			0=ffff;1=ffff
 
+		CBMs can be configured by writing to the interface.
+
+		Example::
+
+			# echo 1=FF > /sys/fs/resctrl/info/L3/io_alloc_cbm
+			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
+			0=ffff;1=00ff
+
 		When CDP is enabled "io_alloc_cbm" associated with the DATA and CODE
 		resources may reflect the same values. For example, values read from and
 		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 5c16557fb7a8..23c72a5ac043 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -148,8 +148,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-		     struct rdt_ctrl_domain *d)
+int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
+	      struct rdt_ctrl_domain *d)
 {
 	enum rdtgrp_mode mode = data->mode;
 	struct resctrl_staged_config *cfg;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index ab76a1e2e679..011564e69ed5 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -382,6 +382,8 @@ bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
 void show_doms(struct seq_file *s, struct resctrl_schema *schema,
 	       char *name, int closid);
+int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
+	      struct rdt_ctrl_domain *d);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 008657e43656..1093ec5e385b 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2036,6 +2036,115 @@ static int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int resctrl_io_alloc_parse_line(char *line,  struct rdt_resource *r,
+				       struct resctrl_schema *s, u32 closid)
+{
+	struct rdt_parse_data data;
+	struct rdt_ctrl_domain *d;
+	char *dom = NULL, *id;
+	unsigned long dom_id;
+
+next:
+	if (!line || line[0] == '\0')
+		return 0;
+
+	dom = strsep(&line, ";");
+	id = strsep(&dom, "=");
+	if (!dom || kstrtoul(id, 10, &dom_id)) {
+		rdt_last_cmd_puts("Missing '=' or non-numeric domain\n");
+		return -EINVAL;
+	}
+
+	dom = strim(dom);
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		if (d->hdr.id == dom_id) {
+			data.buf = dom;
+			data.mode = RDT_MODE_SHAREABLE;
+			data.closid = closid;
+			if (parse_cbm(&data, s, d))
+				return -EINVAL;
+			goto next;
+		}
+	}
+	return -EINVAL;
+}
+
+static ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes, loff_t off)
+{
+	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
+	enum resctrl_conf_type peer_type;
+	struct rdt_resource *r = s->res;
+	struct resctrl_schema *peer_s;
+	u32 io_alloc_closid;
+	char *peer_buf;
+	int ret = 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	if (!r->cache.io_alloc_capable) {
+		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	rdt_last_cmd_clear();
+	rdt_staged_configs_clear();
+
+	if (!resctrl_arch_get_io_alloc_enabled(r)) {
+		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	io_alloc_closid = resctrl_io_alloc_closid(r);
+
+	/*
+	 * When CDP is enabled, update the schema for both CDP_DATA and CDP_CODE.
+	 * Since the buffer is altered during parsing, create a copy to handle
+	 * peer schemata separately.
+	 */
+	if (resctrl_arch_get_cdp_enabled(r->rid)) {
+		peer_type = resctrl_peer_type(s->conf_type);
+		peer_s = resctrl_get_schema(peer_type);
+		peer_buf = kmalloc(nbytes, GFP_KERNEL);
+		if (!peer_buf) {
+			rdt_last_cmd_puts("Out of Memory - io_alloc update failed\n");
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
+
+		memcpy(peer_buf, buf, nbytes);
+
+		if (peer_s)
+			ret = resctrl_io_alloc_parse_line(peer_buf, r, peer_s, io_alloc_closid);
+
+		kfree(peer_buf);
+	}
+
+	if (!ret)
+		ret = resctrl_io_alloc_parse_line(buf, r, s, io_alloc_closid);
+
+	if (ret)
+		goto out_unlock;
+
+	ret = resctrl_arch_update_domains(r, io_alloc_closid);
+
+out_unlock:
+	rdt_staged_configs_clear();
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -2135,9 +2244,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "io_alloc_cbm",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= resctrl_io_alloc_cbm_show,
+		.write		= resctrl_io_alloc_cbm_write,
 	},
 	{
 		.name		= "max_threshold_occupancy",
-- 
2.34.1


