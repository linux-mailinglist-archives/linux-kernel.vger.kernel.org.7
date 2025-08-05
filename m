Return-Path: <linux-kernel+bounces-757075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0A4B1BD62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09AE721315
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD77124467A;
	Tue,  5 Aug 2025 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2diwfDE3"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2987A24113D;
	Tue,  5 Aug 2025 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436747; cv=fail; b=dXyEtVbeK158v/U6TsAzLybRhMWrtbg3XrOJHoxxu5lF4irrUcuAxqLGkDe/aTFgOvdoCh5mw1Hnemw6qZ42NJt0+KprnZw71Uiudwbsj36McH97IxlW5oa8BTH1vVgUycc7If11tIYUqxJYbbfjM9TUeJCaUxgEkL8Y0V/moGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436747; c=relaxed/simple;
	bh=TQVlUE3XDbeWmgJnCZ4SjU2D6K1RTarpCDW5RLJ2oQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5eVmscs/zcXoWwCbjHLA98ou0gdBvZFEQ0GgzShD74dIDz9AUKxGsH6ZzSenhwN4BWHvAptKdYlwW03X5FnZvl+xau0D4J0LLOi4ZJl8VLEaCUMcljflzxUa4TOXlennqa9YhPVotke0zugoUJ/hlmNupsuJaM9N5y/4jmjkkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2diwfDE3; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaEKRR+XzWnGBGZ8wT3xxTF6m3MH98BFoJI/2NcoALefyqcnUwzonsS0qP6lHfHiPo1dhJUlwjDkb8Mu+Da5nNl1HJQ5DC90jhiBSYN2PSZl3p1RcGJHza840kGZFEPL+Gkv+ZP5PBj+2sRZzXBkSH6EDmjTAwvGE/ylnNgpfjrE/ABSUEiS/my8ytD/o5mfaIA/cEqn+gdaVWCN8IVQ9/t4V0bxL4zjzZZM5mt8lwdktmbbmZdUZ9XMJzeVddcuNIri26A4L/akRK/+CeePWQMQpL/myI+0m2pw3QCuiIw7lgwXoEuQPmm0d0vwgT+eJT8j307QO2c1A6EbOYWe7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=129nbOb02JvF545lYCbT0Cidi8N6bOg/Wn4/tfubb94=;
 b=xPIDlggXdL0W/LOSSucjP2fiNMsMpYtzE/8cgaUmxwRE9SsQFr8Qz8s3GDqpBQHUDt3Iblo+QW6pDFWYOZpzpUEEBPnNdJQZRXKsG5D3wnkmBsuGhwDpDHXmMKHjqbDL5NUTnFfO2pOtlp8E2ZZHZ+7VxRp2tTZxMz/6INVA7VMTD3utipZHINBwT3Q30tHL2GkOaHpGjtck690BPbL88FG9Qr2G8G3UxQCYMk4jlrMrZhgY9SmpXKQAXaEH/wWpvoS8K7s82lEWZkSDbWpZm30YOvPv65BqJCIbFO0MdYP48eWA625Tz6+3UbgDGF38PYj0me4GzP5NtzL2+KioYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=129nbOb02JvF545lYCbT0Cidi8N6bOg/Wn4/tfubb94=;
 b=2diwfDE3bqF1maw5vR6wK2dvKgT3XHnwfJ72D/16SSV4Uve4eeUcjEw//1TnzCt5S1Ow2+5n0vHfDCk2jKpcMwRAZ4g8iqsSJMPCOaQU3aq+xTqpYowikq/BESeXFigAeTcLLD3u9wXdSWAavcwBy+xgz4q90WRLl696Dvuf22I=
Received: from SA1PR02CA0003.namprd02.prod.outlook.com (2603:10b6:806:2cf::9)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 23:32:22 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::58) by SA1PR02CA0003.outlook.office365.com
 (2603:10b6:806:2cf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 23:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 23:32:21 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 18:32:18 -0500
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
Subject: [PATCH v8 09/10] fs/resctrl: Introduce interface to modify io_alloc Capacity Bit Masks
Date: Tue, 5 Aug 2025 18:30:29 -0500
Message-ID: <4652b5d8fac8ecad90b3eb734851916036246140.1754436586.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e8fe9c-de45-43eb-c967-08ddd478530d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bXbpGiQ4xuve+CaC344Px7YUqIN2igQsk7Ke0UNrXhgEhvOWCUGhzsB3AzDU?=
 =?us-ascii?Q?lbVucTXKpUNqwS+qCLd4wy91fZvlnkKQ75UV372FUTrCnHil5cUiO5hE2Jed?=
 =?us-ascii?Q?IcSl+L31xXzHeigxG4Vr0/jzXgqUvjsxA3SQWbCQWs12Rh6aZKSgApc8p6GN?=
 =?us-ascii?Q?uZhQlZKKdDC7sw1bXXg+QnzEWJVzB7fCdBmd7imgSXVscCH7P3a8kpgbk1ki?=
 =?us-ascii?Q?xpIvJ/IglKv4L9rLWrLlbMFy5fXlk7VmhNVIfQoxktuVnctMGh62O98tZOPb?=
 =?us-ascii?Q?+NFDOgt2XiaTnqU9J5B673Riq2c8HjDQzPdWfA1w+Th6sugsPjH+j1S5KULP?=
 =?us-ascii?Q?wPVmHRCXgoTGBY3Q2AhDkFEO94DiY78crIgshlNrb9350itfAUJXucFrK6bi?=
 =?us-ascii?Q?rf0O+Ct9CPSbxM7ix0KdUGvG8k05cWR575G4HPdoIcYWuteljsaJAzv/H1qd?=
 =?us-ascii?Q?k+abAAX26uLC/irjeaoObRIVwof/QBoT+qEO3DBYiTcRVbLdvyo64Dohmhmd?=
 =?us-ascii?Q?r/xP02mL/VnzqQnhVwAaCSMkIY3GggbD3fSYnCrWK1MDencaetbgTS4OmqIF?=
 =?us-ascii?Q?RVrc9KQSz/A4uYbtV05R6uovqMYxGacYYJBF7YgKfz30BZuavY4RRCeLXsmK?=
 =?us-ascii?Q?9sCu5NBjg+AIiWIiehj1QWlpDLCGNm0cbHTS9hb1+UwiNsaJ/MaJOqKKAB8B?=
 =?us-ascii?Q?Op5i8YWSH4CcBJUsXMQ2okfcv2+EaFirKva2qn0ga8EIjCgxpsmeqBsJUdgC?=
 =?us-ascii?Q?h7XY450izmDzbq1Kd4Yx31IX86fYAx1SHC3P3sxTQZC8g3llrE3arvYRVYN4?=
 =?us-ascii?Q?yjaDIWEeF22j6/REu1+/8mimLVT0A8sqqdkLarLLuP2ouu0Ko3gi1TCVgFMd?=
 =?us-ascii?Q?ALgyZ3IcYFcsdQO9fy/4/mzItPcDdbcPSiDh19kpn9G3nQM0SVsoSavJWMyP?=
 =?us-ascii?Q?2PS2sLhAPw9Yf+3z15W4Ul7iP1AHxXRFRlDgZAmHQkl5PoLVLngzaQndl2vj?=
 =?us-ascii?Q?aHOSHx1GG9LzezWUUQbSgNHUSu8G7uuExVFLFSXKfRGxnArK3iL2ZZzwhsnm?=
 =?us-ascii?Q?tsHUni38mS54C8b6jikFNrDX65Sqk3yPF683OfvV/60TsZWilAUU020mKkSy?=
 =?us-ascii?Q?tXwjK9B35fyU7RV7xAZGyV7+O5w9eVt/AiavVdQh53MJ3sX/Fu1ttpP7V6Yx?=
 =?us-ascii?Q?GNKtm2fr8ezaLLlhRma+drzxmDu24EXaDRIVFBCNa+dKGaB/C7sc21NFXehq?=
 =?us-ascii?Q?W+vDH2dtjjPxReGWHPFf3IVcrPsUyhjRQNy9onC0UJTL+ZPoS7BwrFqkQwkh?=
 =?us-ascii?Q?eveseqs9LRy+1tkjX41FOuRwGucPTOh8eB8Poey75QIxHGHO25lXwTAZ4aeZ?=
 =?us-ascii?Q?rtoNHcPtlrfMaIrO30XvHs9rSgseqobe5RIR7HpxtGo7nqni0/eKjs/M47gh?=
 =?us-ascii?Q?qay8MMOWmumzt0481SENE3KoqKrOwqyYZNqwEBzRcbyUggHd+DS2DoRtP6lz?=
 =?us-ascii?Q?AfsWKtFm8iJ25pJBYrvBgCz176VeZB77zyDh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:32:21.0320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e8fe9c-de45-43eb-c967-08ddd478530d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206

"io_alloc" feature enables direct insertion of data from I/O devices into
the cache. By directly caching data from I/O devices rather than first
storing the I/O data in DRAM, it reduces the demands on DRAM bandwidth and
reduces latency to the processor consuming the I/O data.

When CDP is enabled, io_alloc routes traffic using the highest CLOSID
associated with the L3CODE resource. To ensure consistent cache allocation
behavior, the L3CODE and L3DATA resources must remain synchronized.
rdtgroup_init_cat() function takes both L3CODE and L3DATA into account when
initializing CBMs for new groups.  The io_alloc feature must maintain the
same behavior, ensuring that the Cache Bit Masks (CBMs) for both L3CODE and
L3DATA are updated together.

Enable users to modify io_alloc CBMs (Capacity Bit Masks) via the
io_alloc_cbm resctrl file when io_alloc is enabled.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Updated changelog.
    Moved resctrl_io_alloc_parse_line() and resctrl_io_alloc_cbm_write() to
    fs/resctrl/ctrlmondata.c.
    Added resctrl_arch_get_cdp_enabled() check inside resctrl_io_alloc_parse_line().
    Made parse_cbm() static again as everything moved to ctrlmondata.c.

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
 Documentation/filesystems/resctrl.rst |  8 +++
 fs/resctrl/ctrlmondata.c              | 97 +++++++++++++++++++++++++++
 fs/resctrl/internal.h                 |  3 +
 fs/resctrl/rdtgroup.c                 |  3 +-
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 3002f7fdb2fe..d955e8525af0 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -187,6 +187,14 @@ related to allocation:
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
index 641094aac322..1f69117f96f8 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -858,3 +858,100 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
 	cpus_read_unlock();
 	return ret;
 }
+
+static int resctrl_io_alloc_parse_line(char *line,  struct rdt_resource *r,
+				       struct resctrl_schema *s, u32 closid)
+{
+	enum resctrl_conf_type peer_type;
+	struct resctrl_schema *peer_s;
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
+			/*
+			 * When CDP is enabled, update the schema for both CDP_DATA
+			 * and CDP_CODE.
+			 */
+			if (resctrl_arch_get_cdp_enabled(r->rid)) {
+				peer_type = resctrl_peer_type(s->conf_type);
+				peer_s = resctrl_get_schema(peer_type);
+				if (parse_cbm(&data, peer_s, d))
+					return -EINVAL;
+			}
+			goto next;
+		}
+	}
+
+	return -EINVAL;
+}
+
+ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
+				   size_t nbytes, loff_t off)
+{
+	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r = s->res;
+	u32 io_alloc_closid;
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
+	rdt_last_cmd_clear();
+
+	if (!r->cache.io_alloc_capable) {
+		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	rdt_last_cmd_clear();
+	rdt_staged_configs_clear();
+
+	if (!resctrl_arch_get_io_alloc_enabled(r)) {
+		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	io_alloc_closid = resctrl_io_alloc_closid(r);
+
+	ret = resctrl_io_alloc_parse_line(buf, r, s, io_alloc_closid);
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
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 49934cd3dc40..5467c3ad1b6d 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -392,6 +392,9 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
 			      void *v);
 
+ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
+				   size_t nbytes, loff_t off);
+
 const char *rdtgroup_name_by_closid(int closid);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 6af8ff6c8385..a3ab2851c6da 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1919,9 +1919,10 @@ static struct rftype res_common_files[] = {
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


