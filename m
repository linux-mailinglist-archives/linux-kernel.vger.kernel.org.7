Return-Path: <linux-kernel+bounces-770014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E988DB275E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253677BDBD1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E915029ACC8;
	Fri, 15 Aug 2025 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3+33vRNb"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F329ACC2;
	Fri, 15 Aug 2025 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224962; cv=fail; b=YeHI4yMmEQjUVGw2dMHbMZYYTnQDcCHOQX2q8OTIdSQ7AVEkANUqaw+M3Yb9oXskckadJWmUHR4921VzynvDabK+RoQkqXYfML2PIwnbpJFh7uMdC3P/1AaICeMB1Bjp7DzlSBeJN261ba1xyi/GUCkQWRuQJ6eFT14IpJ2D7Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224962; c=relaxed/simple;
	bh=H/yaSx5fJt3J016Q/FgSHMUjGQoGxJMCxCyasAG0IF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlQR6C9UoZKMFqKy+ZNj/k1ePvJSiTTE0pSkdcR1VmyJMAaKo1eChMSLajg0QJdO/Mp68qslM8VOsQ3FKbTvLw3IMSvU4PKWVQrZCJEpwiu5dYzKNfgSOXaNyqlgtf5yO42s1gEsLVUFIRKHz7nZfwT6ucyTwSSdtyKPGMgTWhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3+33vRNb; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rckpMpnU8+ZyIvI2JK9smvw0BQ4cDJxFPxsYSnUZJlH/oWlHL3k+HuTCSSQu4zImJyJuOHTPct+Qb1GYdaDjuOctdSpMpsxg+negMEb7YtEQGJXpuK5vzAkMM0ZEWnCDZNQzqGRUUR3arh+F6fmllF0LoH5kbLHgC5z6rdncb2O1lLsT7m8o0Z14Ad35eKcplkEanNZsUdFyLFIsh/JsyHdldbpDDj3I2VKUKg7G7Rnq3AHEmCUjpY4uLNiZLTyjiWqaOikp4QJNf7Burl0kNahXa6pZhJv2YGHTC8riwmHenGhbw+ITXneuv/Mm3hBU62IDJgYSevgUtPf74nntnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXIYlUP485fRqil1tr1o8ITGAVCSYZ4sJtNhB82ZsNc=;
 b=x7gN5SFZ4Z2a4wz1hCzm5h3RRjvvvjmUMEFEJ+oZh+QJYY1q305SGOygvjuPWy5+xnd6jCba3lpfrNwYZ7SyRMUc2L+/y58xWIqvEGXChuOJxeXzboN9Ndv+H+Qs7jIVPvwECF0jfmPriMsCuSEuAkV5pNop5F3N8SqomYtV2DKYFbuYFPFEMNDcg7ooBnVK3IvVmTAU5MhxKM+Hm9PStL8dg0veu3/KNHqpNh3Fkg71/FCqdmWhdeOawb5leOVoYt8WNIhEd5Mo+YtrGjvY8rTPibi2vylQwxgMsbD4tZeFsKmYZpNiTISRm9s5JYONiro0C66IuC/yaQjdfY5egA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXIYlUP485fRqil1tr1o8ITGAVCSYZ4sJtNhB82ZsNc=;
 b=3+33vRNb4n864IXmy9FH+wNXrrRR44TpDlwyBpRWxETKuLOiQvwKijq/gN+iF/TmrhAZgMa1otaA0txtgPdetFvhAWZQT4+yqraz5I5TgYYmX6wb/XwVcU8UxmonPDkGlsneX1V83DhJZ9dR4WIVzJkVehszQoDD5X8uTptiBdA=
Received: from SJ0PR13CA0079.namprd13.prod.outlook.com (2603:10b6:a03:2c4::24)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 02:29:14 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::24) by SJ0PR13CA0079.outlook.office365.com
 (2603:10b6:a03:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 02:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:29:14 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:29:06 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<rostedt@goodmis.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <thomas.lendacky@amd.com>,
	<yosry.ahmed@linux.dev>, <xin@zytor.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<mario.limonciello@amd.com>, <xin3.li@intel.com>, <perry.yuan@amd.com>,
	<chang.seok.bae@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v17 23/33] fs/resctrl: Support counter read/reset with mbm_event assignment mode
Date: Thu, 14 Aug 2025 21:25:27 -0500
Message-ID: <2aaa25da49e8fad9d6c71b7baf476f2d7977e8f0.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 589bee74-0e35-4e20-8c38-08dddba386df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xVwvjCrBTsrZf6pJZay3mD20E1M/g6/Ci/WYwWF69+rCQuabAe/GdF04LYuR?=
 =?us-ascii?Q?1xemRBTWXxennAP9v9KKbUDRAFVzxVJaqSTvPVxv6tgQJLdSPDaDtdDVIoZc?=
 =?us-ascii?Q?5v8lMHbyczItfLfib4TpTbFOSvcsELDmRc+VURjTGanxx/qwrrCpjuZY32Ha?=
 =?us-ascii?Q?5m/suOzjqyxCt2Mxqi9xkxDfwMzrwT2GH6X7WA63mxSg3CaOA/taGF3wQG7r?=
 =?us-ascii?Q?wI6/rJjGb0Zyguqf5HrnWETLnhiljywg/LbPK6B0Hriy2P3PK6CJTBBYasmp?=
 =?us-ascii?Q?nrXc6qKdwpyTUit+sHnCvBSGXT5z85cTpg/fsHBvgH0+CQsqyh/N69KZtnan?=
 =?us-ascii?Q?R/hpUr+xsFlHMgbdOrYZCIzTw37e9aoeoGDGYY4WaNH64nOxRFL6gMjORY8w?=
 =?us-ascii?Q?rvgBEFzKZOCmn3RMP6jOB/MhV1YMBAL4QStf/lUACqNlM9+Jyy0j6+nE2RcE?=
 =?us-ascii?Q?AaJTfWEnfap9tmg8t9u/zgTpWwoTxuzhhlWVdNivvNKNmMjGhpXbyFS4/W1b?=
 =?us-ascii?Q?wbVF6yqowJNd7zq3D4BO7VYJPusA93qo/ufh9tZK3Ng/g6C8xdfnhbxT2Lnv?=
 =?us-ascii?Q?czPpUMAr0Uxme19ROSYjJ2YT0bYZH2lcjT2vhNZiwZxuKfTPMAc5OOZpPik4?=
 =?us-ascii?Q?gU86ePsrt6jj9PQECKdFwpPI+mjnxjRtsnbAvlrUbIVhT6G+veWTjiVTb6lz?=
 =?us-ascii?Q?/lHYMwlWoL9B/i9rQNzGpHGLBMIueeEPNrmVHXZUe6ysWDs14+j2Ss4VGiNr?=
 =?us-ascii?Q?FOg7qWPhOmKVzhch89SraBpTtblZB6ArWn/T4Szr6yieh1bBoIYfe4/QMQ8a?=
 =?us-ascii?Q?st7ZnYF1KO/IQNmQ+SSlX3Uo1S6qzYLXCgCspf9l2eL6NXx92UaIYfIIsJE+?=
 =?us-ascii?Q?LfedUhiHoB8N37pTgQZJUyDaVLTc1dxN22cALI8RdzXfaP3sx+pOIo90hYpJ?=
 =?us-ascii?Q?gKY7BU3LHe+25R0kYW6ZCwOIyM1PKmou1ViiY1VD4K4hWGEtjfKHVnJnFPTf?=
 =?us-ascii?Q?wxJyuwEXDXQ5Q3rll7oWer4zaWSxROKFFC+GC5Ijq89cNCEot2yEWO7pbHkC?=
 =?us-ascii?Q?dcbd+QDYFDXBxHW3Q7Wst2IpL5YvCp7Ezlvmr+ilRRdlFaN9oFuMh3qWku99?=
 =?us-ascii?Q?0iFkabKPxYJ1P18UmkvgAgv+nNkP+g2EqEc8oTKo2W0vzHiIjVTH6oruTqje?=
 =?us-ascii?Q?fOWlkoqsIVz5seBxGxB9niz/Z8kOwZ5NBjdPHDCEzDi4hmUo8WwOsOBNFBoK?=
 =?us-ascii?Q?urOwz4oL2jmM1Ky2A2Iq9y+iW3aYdf3AKnUqr5x4Bcmjb2tdqLDM/IH2cndn?=
 =?us-ascii?Q?OsLOAYUIANXQw1E/XgFmzmTof1pUNiYk590vI9IPUQA5EqwMjiY8hMPLz2vT?=
 =?us-ascii?Q?YL0fkQwGwU1APQzV6anNaWE2mIgQsZIg3EgoTRMG9U/AZ889hSkS4JUiIKmR?=
 =?us-ascii?Q?iCAGCWjAY0YhzoiTgOaQnI1RRIDdB0B92qPv7/qV6Cfudzy9NitVitYlP1l1?=
 =?us-ascii?Q?+gbhX0bkdM0BEfebTw6hq8tZlkrZtJxvvXmC6ai7d7Y/ZCmYSCMy6QkU6A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:29:14.4096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589bee74-0e35-4e20-8c38-08dddba386df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446

When "mbm_event" counter assignment mode is enabled, the architecture
requires a counter ID to read the event data.

Introduce an is_mbm_cntr field in struct rmid_read to indicate whether
counter assignment mode is in use.

Update the logic to call resctrl_arch_cntr_read() and
resctrl_arch_reset_cntr() when the assignment mode is active. Report
'Unassigned' in case the user attempts to read an event without assigning
a hardware counter.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Updated the changelog.
     Removed duplicate resctrl_arch_mbm_cntr_assign_enabled() check.
     mbm_cntr_get() need not be static anymore.

v16: Squashed two patches here.
     https://lore.kernel.org/lkml/df215f02db88cad714755cd5275f20cf0ee4ae26.1752013061.git.babu.moger@amd.com/
     https://lore.kernel.org/lkml/296c435e9bf63fc5031114cced00fbb4837ad327.1752013061.git.babu.moger@amd.com/
     Changed is_cntr field in struct rmid_read to is_mbm_cntr.
     Fixed the memory leak with arch_mon_ctx.
     Updated the resctrl.rst user doc.
     Updated the changelog.
     Report Unassigned only if none of the events in CTRL_MON and MON are assigned.

v15: New patch to add is_cntr in rmid_read as discussed in
     https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
---
 Documentation/filesystems/resctrl.rst |  6 ++++
 fs/resctrl/ctrlmondata.c              | 22 ++++++++++---
 fs/resctrl/internal.h                 |  3 ++
 fs/resctrl/monitor.c                  | 47 ++++++++++++++++++++-------
 4 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 446736dbd97f..4c24c5f3f4c1 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -434,6 +434,12 @@ When monitoring is enabled all MON groups will also contain:
 	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
 	where "YY" is the node number.
 
+	When the 'mbm_event' counter assignment mode is enabled, reading
+	an MBM event of a MON group returns 'Unassigned' if no hardware
+	counter is assigned to it. For CTRL_MON groups, 'Unassigned' is
+	returned if the MBM event does not have an assigned counter in the
+	CTRL_MON group nor in any of its associated MON groups.
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index ad7ffc6acf13..31787ce6ec91 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -563,10 +563,15 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	rr->r = r;
 	rr->d = d;
 	rr->first = first;
-	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
-	if (IS_ERR(rr->arch_mon_ctx)) {
-		rr->err = -EINVAL;
-		return;
+	if (resctrl_arch_mbm_cntr_assign_enabled(r) &&
+	    resctrl_is_mbm_event(evtid)) {
+		rr->is_mbm_cntr = true;
+	} else {
+		rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
+		if (IS_ERR(rr->arch_mon_ctx)) {
+			rr->err = -EINVAL;
+			return;
+		}
 	}
 
 	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
@@ -582,7 +587,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	else
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
 
-	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
+	if (rr->arch_mon_ctx)
+		resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
 }
 
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
@@ -653,10 +659,16 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 checkresult:
 
+	/*
+	 * -ENOENT is a special case, set only when "mbm_event" counter assignment
+	 * mode is enabled and no counter has been assigned.
+	 */
 	if (rr.err == -EIO)
 		seq_puts(m, "Error\n");
 	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
+	else if (rr.err == -ENOENT)
+		seq_puts(m, "Unassigned\n");
 	else
 		seq_printf(m, "%llu\n", rr.val);
 
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index c11f2751acf5..88e1a800417d 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -110,6 +110,8 @@ struct mon_data {
  *	   domains in @r sharing L3 @ci.id
  * @evtid: Which monitor event to read.
  * @first: Initialize MBM counter when true.
+ * @is_mbm_cntr: true if "mbm_event" counter assignment mode is enabled and it
+ *	   is an MBM event.
  * @ci_id: Cacheinfo id for L3. Only set when @d is NULL. Used when summing domains.
  * @err:   Error encountered when reading counter.
  * @val:   Returned value of event counter. If @rgrp is a parent resource group,
@@ -124,6 +126,7 @@ struct rmid_read {
 	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
+	bool			is_mbm_cntr;
 	unsigned int		ci_id;
 	int			err;
 	u64			val;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 85187273d562..0a9d257e27a2 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -419,13 +419,25 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 	u32 closid = rdtgrp->closid;
 	u32 rmid = rdtgrp->mon.rmid;
 	struct rdt_mon_domain *d;
+	int cntr_id = -ENOENT;
 	struct cacheinfo *ci;
 	struct mbm_state *m;
 	int err, ret;
 	u64 tval = 0;
 
+	if (rr->is_mbm_cntr) {
+		cntr_id = mbm_cntr_get(rr->r, rr->d, rdtgrp, rr->evtid);
+		if (cntr_id < 0) {
+			rr->err = -ENOENT;
+			return -EINVAL;
+		}
+	}
+
 	if (rr->first) {
-		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
+		if (rr->is_mbm_cntr)
+			resctrl_arch_reset_cntr(rr->r, rr->d, closid, rmid, cntr_id, rr->evtid);
+		else
+			resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
 		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
 		if (m)
 			memset(m, 0, sizeof(struct mbm_state));
@@ -436,8 +448,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 		/* Reading a single domain, must be on a CPU in that domain. */
 		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
 			return -EINVAL;
-		rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
-						 rr->evtid, &tval, rr->arch_mon_ctx);
+		if (rr->is_mbm_cntr)
+			rr->err = resctrl_arch_cntr_read(rr->r, rr->d, closid, rmid, cntr_id,
+							 rr->evtid, &tval);
+		else
+			rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
+							 rr->evtid, &tval, rr->arch_mon_ctx);
 		if (rr->err)
 			return rr->err;
 
@@ -462,8 +478,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
 		if (d->ci_id != rr->ci_id)
 			continue;
-		err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
-					     rr->evtid, &tval, rr->arch_mon_ctx);
+		if (rr->is_mbm_cntr)
+			err = resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
+						     rr->evtid, &tval);
+		else
+			err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
+						     rr->evtid, &tval, rr->arch_mon_ctx);
 		if (!err) {
 			rr->val += tval;
 			ret = 0;
@@ -670,11 +690,15 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
 	rr.r = r;
 	rr.d = d;
 	rr.evtid = evtid;
-	rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
-	if (IS_ERR(rr.arch_mon_ctx)) {
-		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
-				    PTR_ERR(rr.arch_mon_ctx));
-		return;
+	if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rr.is_mbm_cntr = true;
+	} else {
+		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
+		if (IS_ERR(rr.arch_mon_ctx)) {
+			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
+					    PTR_ERR(rr.arch_mon_ctx));
+			return;
+		}
 	}
 
 	__mon_event_count(rdtgrp, &rr);
@@ -686,7 +710,8 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
 	if (is_mba_sc(NULL))
 		mbm_bw_count(rdtgrp, &rr);
 
-	resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
+	if (rr.arch_mon_ctx)
+		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 }
 
 static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
-- 
2.34.1


