Return-Path: <linux-kernel+bounces-722452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7208DAFDAE4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85B57ADBE2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A492620E7;
	Tue,  8 Jul 2025 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q8xOh2On"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591242459F1;
	Tue,  8 Jul 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013195; cv=fail; b=jeQv3oFOa41tCNHEMrFB3R1xOIaRX++Oix0UaGefdj5H9uUGPTkxuPL5bE+2vVI3mVLVyh55sK7yDI4HI9msDEhZ7M9luz+U9OU8SWNmGEbwchDvhU3DTAYZAx02z0zMxxaeFbJoPepSsAS9HUkJ9CRzl9RLK1fN4iTSKrgWtmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013195; c=relaxed/simple;
	bh=pJ3W45zlEUlrPwDhTDribz3sOEAOeBhEhW9nam/uFWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5PntEeaQLV6mzradVYYFjOWvTaEfetyQbAxzWTF8lAIinlMKhgbd96Pg5H4CDiXgGGSwfkqjPcEw8m69LC7AS1seZ2p1SJl2zPpDJZaJSoi5zR5bUN6ZJCp0uLqN+fYnd/GmOYo2qF4cOkGnDk1kL9ebIIxu/HnyB6HkSs2kCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q8xOh2On; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZLeLGQghAMA5sVLV1flvfjbJlg3/GraSIZnlKptfK7WDv+gaL8md5yPatpwebUyyRFTqkAcAsdCooLb5nzz2Dnj9saocO5QbTVlR+9C089CU8Dy6T3NCnQElLqPikpzmeFXOABsvYGbp9AAd1Zsh1BEUaDL+h+LTImk7Gbfq1hTrYkaEGHjx7WcxOfilg3Q+RmvR37YF9C8zrq0VF0ViMmAUMkzDAjMqdET2q4t+YmnaEEvRU031pKGrMZK9FyWX+MZLZvUfwvyc6zmYpWCV0NKZhhr/2dCMWpE3I5T39iVHknBpfgiRugdC2J7UQYSO+kDQoUaiWkjt0ti4K+oLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4mfwfNcEJh+mWj9VNn34+A/rXqFdVDQTofI2i1yL5s=;
 b=pofKZ+2pA9Xr5V5wG0WOFGHj7BhYSIG1v+1Dp++xKYeOgSeYiV8tvVDSYvOVPqJKJ8IuUfsXzoknQ6t0SouhdZSZgoVNYgOLIEUUmfPk4NvSdISN1h/wk1q83+JE8Bsha6et6d8BC73OrbS/CpwfmSqfdoaaxnUbcok4/w4eLkIJxTtDESd/IJb/v88uPMSqn6yfEKdZxb1h7t9o8exTDf7tTf/gyNH6fZEMVqK7grGI5O0+PgzF5xldJp+ZRUcOLZ1Bi2HfhvOwXETRP+u4gn6G7vEbAmMHAYDAanemezv6yQHL3kCP1XZ+atrNaEfbH4LTJ0C0WDqNbtqXZNpLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4mfwfNcEJh+mWj9VNn34+A/rXqFdVDQTofI2i1yL5s=;
 b=q8xOh2OnJfGOMgR7rvAagbsszOL0TF4vlvhTZDhzwOSJH1MmNCMYwewBhDqXDtAQEZI6l8E0JuA7KWYkyQhMBn5zwORVEP8IXtNqzFvX/L/LPDYQ859DHmOO1anrwJvOvcnfuekwnFXsJoG/X3sObCQrLog6vaiZT6neRMj8c9Q=
Received: from SJ0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:a03:2c2::34)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.31; Tue, 8 Jul
 2025 22:19:48 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::ae) by SJ0PR13CA0059.outlook.office365.com
 (2603:10b6:a03:2c2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.19 via Frontend Transport; Tue,
 8 Jul 2025 22:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:19:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:19:42 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <babu.moger@amd.com>, <tao1.su@linux.intel.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH v15 12/34] fs/resctrl: Introduce mbm_cntr_cfg to track assignable counters per domain
Date: Tue, 8 Jul 2025 17:17:21 -0500
Message-ID: <566cf42c23f7f5548d2a96bc0339f0444f9f1d86.1752013061.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752013061.git.babu.moger@amd.com>
References: <cover.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e6f406-a1dd-47e1-997a-08ddbe6d8c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lhUAUIuXunqly939phJh5SyxmIAoIoVJBYQkCySQHWUIJLMmAU7JuFJCYh2o?=
 =?us-ascii?Q?aoubs11exq2/O82sD/dNG4jQBbO6BT+Z09Ca4C9h0QHkR7IBGE9i+AakbbE7?=
 =?us-ascii?Q?i7i2voSQC83HmvNcoqLMywPTK2Xsr898cbSqloql0CwMwGg3SWWWWJD4eQx7?=
 =?us-ascii?Q?eVnY6EpRut8h3C+W0gCmrTwgDU0NdIgH4UZp/iS1q7nmqXu2QvmFc4KMGg5F?=
 =?us-ascii?Q?HY4abNKGVzQWCGB8nRbkOjV5EPpikeL4pEMVW7sslOybr/FS5aJj6Ju9tEqJ?=
 =?us-ascii?Q?0NlCiCF0yuIrQcYTekPgZWUCBQfppGQbPGRI8lQNCqh+TWXyw8ECXVgwaK/d?=
 =?us-ascii?Q?T5IU+eC4LjuSl3MiWECPyh9AoUSZJeu3Vm/punXFjBVnfmDUAmWiblbJQSD6?=
 =?us-ascii?Q?rRJvGySioMNgYOkV8jOKSxdueRJtrt3XwjpiUPkjhkqPPY2njSzdzrAff75n?=
 =?us-ascii?Q?fk1ChA6aa0qWylWha9XGuj4WFFyptSXK/k5VnnT5YALFCPelFaCdGyRCx/Ug?=
 =?us-ascii?Q?u6jOCovcy1DDPHP4clc1CLimJVkJo0ztYzNhnzIpnkbGpxpFSXWy43U8rGXs?=
 =?us-ascii?Q?P+dRvxZC08P4WTwD70aNXGm9Q9Fi7MHV3LM6dW9geYDENQjGaI0Ih4ezfQ4o?=
 =?us-ascii?Q?CfnDwKQNWOVTwEYIieZ5OeE25xgT1a+VFOUxXWB6qN6WMffMPKj2zGfIPrS/?=
 =?us-ascii?Q?xkeMI6ZBWqRz2OEtu5/LL3EyNy6Ypsrrq8AUlZsFzQjPUS13fD9krvsDc7Hl?=
 =?us-ascii?Q?MjhKR3sf5OJh/o7yD8RFIf/t4zAB+2GVGaJz2OzucLGkGc1cazE4sFbqnKk/?=
 =?us-ascii?Q?KSvSa1UI4rV4d1xXSeQXS57dfNW4WYKN1nQSwA4VMPX+DI4/AY0rUVVbh250?=
 =?us-ascii?Q?xb5TvsCrgeAEzqVwjDF1yqMCq5hduw7rI06ZE3yg4Ew4q8yKAv59bCvahRrS?=
 =?us-ascii?Q?4AiW6oCMwze5PVZVAaW9KWxOuzJtJoZs4qQCrchtND8TfzXtMOmf7Ssy46fT?=
 =?us-ascii?Q?jz0BCULn+R6LA6XAhNYiWIggbTj9QUPhS+kb2tzXlYM3v+U1yfks9gUVLx8o?=
 =?us-ascii?Q?+PI9CBQwr64R2um1oDISAnVsFqJzR1ejH8ophfMLO64izb0bSkrRSn2x52CJ?=
 =?us-ascii?Q?Tsd0JcNKzpFSXJlDdsSky8IMWaybRcC0SjQl4HYzE+K1usy+7FfySFDLTOm2?=
 =?us-ascii?Q?zqBqR6fujzdReR1ji1Ir/Y2iMXKM5jHO20frne+wCdwWIQeLf0O/0NZ+w1vy?=
 =?us-ascii?Q?SfQnFrvCaBTHmtjoMiGqnxAfa9IGSS0su3cTvdQZwZP7thgz2NLMWO0QdTYN?=
 =?us-ascii?Q?QPDoHt+tqlFXQDH1A7ijJ99jKZqmEdCFiF9Y/+WMDb+5I6X0j18qMQDlV1pT?=
 =?us-ascii?Q?ZZBppwAFLFwlzW35DmXY6n6ElPS2UktsQZOlzwZBXHzRwE6wVQ34RHovLg6f?=
 =?us-ascii?Q?oNJzlRhbiEXjLIgzYlSEDQPWQ5bJP4DoBOoop62trmmujuuLDzZnCz3wH1A5?=
 =?us-ascii?Q?TCTVCFHZ6CRh2aayIht93zHLXsEUbsZCi2T29PRugPZ9zHVjxuGcTLYJ8w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:19:47.4269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e6f406-a1dd-47e1-997a-08ddbe6d8c92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor bandwidth usage as long as it is
assigned.  The hardware continues to track the assigned counter until it is
explicitly unassigned by the user. Counters are assigned/unassigned at
monitoring domain level.

Manage a monitoring domain's hardware counters using a per monitoring
domain array of struct mbm_cntr_cfg that is indexed by the hardware
counter ID. A hardware counter's configuration contains the MBM event
ID and points to the monitoring group that it is assigned to, with a NULL
pointer meaning that the hardware counter is available for assignment.

There is no direct way to determine which hardware counters are assigned
to a particular monitoring group. Check every entry of every hardware
counter configuration array in every monitoring domain to query which
MBM events of a monitoring group is tracked by hardware. Such queries are
acceptable because of a very small number of assignable counters (32
to 64).

Suggested-by: Peter Newman <peternewman@google.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Minor changelog update.
     Removed evt_cfg from struct mbm_cntr_cfg based on the discussion.
     https://lore.kernel.org/lkml/887bad33-7f4a-4b6d-95a7-fdfe0451f42b@intel.com/

v14: Updated code documentation and changelog.
     Fixed up the indentation in resctrl.h.
     Changed subject line to fs/resctrl.

v13: Resolved conflicts caused by the recent FS/ARCH code restructure.
     The files monitor.c/rdtgroup.c have been split between FS and ARCH directories.

v12: Fixed the struct mbm_cntr_cfg code documentation.
     Removed few strange charactors in changelog.
     Added the counter range for better understanding.
     Moved the struct mbm_cntr_cfg definition to resctrl/internal.h as
     suggested by James.

v11: Refined the change log based on Reinette's feedback.
     Fixed few style issues.

v10: Patch changed completely to handle the counters at domain level.
     https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
     Removed Reviewed-by tag.
     Did not see the need to add cntr_id in mbm_state structure. Not used in the code.

v9: Added Reviewed-by tag. No other changes.

v8: Minor commit message changes.

v7: Added check mbm_cntr_assignable for allocating bitmap mbm_cntr_map

v6: New patch to add domain level assignment.
---
 fs/resctrl/rdtgroup.c   |  8 ++++++++
 include/linux/resctrl.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index acbda73a9b9d..a09566720d4f 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4086,6 +4086,7 @@ static void domain_destroy_mon_state(struct rdt_mon_domain *d)
 {
 	int idx;
 
+	kfree(d->cntr_cfg);
 	bitmap_free(d->rmid_busy_llc);
 	for_each_mbm_idx(idx) {
 		kfree(d->mbm_states[idx]);
@@ -4169,6 +4170,13 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain
 			goto cleanup;
 	}
 
+	if (resctrl_is_mbm_enabled() && r->mon.mbm_cntr_assignable) {
+		tsize = sizeof(*d->cntr_cfg);
+		d->cntr_cfg = kcalloc(r->mon.num_mbm_cntrs, tsize, GFP_KERNEL);
+		if (!d->cntr_cfg)
+			goto cleanup;
+	}
+
 	return 0;
 cleanup:
 	bitmap_free(d->rmid_busy_llc);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 919806122c50..e013caba6641 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -156,6 +156,18 @@ struct rdt_ctrl_domain {
 	u32				*mbps_val;
 };
 
+/**
+ * struct mbm_cntr_cfg - Assignable counter configuration.
+ * @evtid:		MBM event to which the counter is assigned. Only valid
+ *			if @rdtgroup is not NULL.
+ * @rdtgrp:		resctrl group assigned to the counter. NULL if the
+ *			counter is free.
+ */
+struct mbm_cntr_cfg {
+	enum resctrl_event_id	evtid;
+	struct rdtgroup		*rdtgrp;
+};
+
 /**
  * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor resource
  * @hdr:		common header for different domain types
@@ -168,6 +180,8 @@ struct rdt_ctrl_domain {
  * @cqm_limbo:		worker to periodically read CQM h/w counters
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
+ * @cntr_cfg:		array of assignable counters' configuration (indexed
+ *			by counter ID)
  */
 struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
@@ -178,6 +192,7 @@ struct rdt_mon_domain {
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
+	struct mbm_cntr_cfg		*cntr_cfg;
 };
 
 /**
-- 
2.34.1


