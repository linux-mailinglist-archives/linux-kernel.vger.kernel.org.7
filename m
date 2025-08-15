Return-Path: <linux-kernel+bounces-770000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34DEB275C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D99AA392F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2022BCF5C;
	Fri, 15 Aug 2025 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bXAFfcPC"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678EF2BCF67;
	Fri, 15 Aug 2025 02:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224854; cv=fail; b=AIdV/XzyamLwtt/ZDytgl/F0TUv/qoMjZvTxDVDYxWiIlr54fpB5h51Y7HgR725pLwSSTtLFxFNkl4XuLo/QO56bwwBZ68Fyj0SjmPWaC5lbbvOpIHPe/4Bz9Vzkusg1HKEqtf3al4TTMGQGqUqL8QFitbRXKHGijAimmZXEyS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224854; c=relaxed/simple;
	bh=kXes3g35Jfv81cwG1qDoPnyJRx/87+dFrOJKUNJ35+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLLdpqaAX8bT27SqsSiet09VRTFj4mvsWiwxVuIvtJ+K6KV0XMlUQAGHPZtHOlfDlV9qE3wd/BjQlJf0PR3z15B01JdMenCEkTIB33Y7umAt3vPGWClQ3yxZoNN5QNz9nx5vHvSLBezTIyBJjf6xwyro3PicLcduyW0TCQ2W1+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bXAFfcPC; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgh7nYr3bwc4uEmc8wBHskXnm/nQit+iNaX3V8HdWx2rroiK9+3qaI0+ZZyZF3rDw/X3pL87xULVsIogXLLxoNY2aSxo2pkTbw2s0755pCUfXqS1LRTTz0g7pKTv8RcLnkGc8BqQyD5bZdFOJN2DX72JYW1DGmQim/e/uF2TBOI7KVTbCkF55WvbVPGKIuVhQ1CTCcANIC3OMAfqkzwWf3nUEMw3zWcuMmxtjHs7FBIbBLuGYJJ7sKO2tRVcXjq+UqfVmVPEkcLk8ibd216ApuKnoFHfryozgsLmq/MhdM1x4ZJDZOJjmgvmrL0qVIUnJCeW7CEzFL2OTHhBVlgr5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KH6bEFz+8HT1hYc3gCIVuhDhZV03JGDpJC3UlHtLyo=;
 b=chNnP8s06ocCCbyBBfFuhqu/qf5YDkD3/41H/kd2RwJ1FSv5CIZP8iIYni4WjFUxWY+XfRIWuFtugnifqkKbB2reYbPl4EveXFSsTIorobYU75BJOxD3duuJSROumBgithEAxRyQHXEGpmu2AV0OWj4hehZKuI6n4o7J9VzAmuR7MaZE5g1K61CCgYkDl1faSjXW51vSVswluoW/DtNyLyjyK4iSRYSLFYDovWueF/Xk7eCgpaIkCd+luYjXlwfpTj+zKthNg80hNU46HZDFmxc9dLYu33aPzEh18pMoHDvIn8Ml96rfozjaP1bhGCBH8uyEh8ngylb5eY7DnNQmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KH6bEFz+8HT1hYc3gCIVuhDhZV03JGDpJC3UlHtLyo=;
 b=bXAFfcPCIJD02JBydFezhHJuz8+c7F4A05BrqgEd0NrAgBZZlxd5HOxooKuINrpWJsF9v+dwlvf5yS0yXmGQiqlRNb4WVzN9HYdASB7jPG4I6O1bUoYVWy8jVqagHcAJ7AkfJGjLTEUIS+wg4LKCw/GnAo9S7qMEV9dk+IEqpjg=
Received: from SJ0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:a03:39c::16)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 02:27:28 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::e) by SJ0PR03CA0341.outlook.office365.com
 (2603:10b6:a03:39c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 02:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:27:27 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:27:24 -0500
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
Subject: [PATCH v17 11/33] fs/resctrl: Add resctrl file to display number of assignable counters
Date: Thu, 14 Aug 2025 21:25:15 -0500
Message-ID: <b5016487a7d72cc24134a36ef1a9acaf735f59b3.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: ade9cc52-38d8-4ed4-c2df-08dddba34705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2IdY2VdxUuWGi8mtjQ+ZXYkgmXhh0HqBC1AOah3eY+Srx9YVSstE63VNy8iU?=
 =?us-ascii?Q?kgrXquj4EGZNnU7iIqiZdTESW6i4+ELp00qJDHZmU98AJXYLTLsTAww2Rlb4?=
 =?us-ascii?Q?Eda9kuk4F+jVwjlmicu63/Z2aNIxTx3lNrVLzBek0zRGzLjAkpaCYcfjSC+4?=
 =?us-ascii?Q?ELSF0buoynL2yrTM975Xiu+7fgsuGwfkUVyoLM1SgG9iRfj7quSdcYQYq/Xy?=
 =?us-ascii?Q?MbVrK+8oGrW9uVkU65/EUMvLIfwSkpCcYO7isXFycOFZn4/Yv4dm6Zrs8MT5?=
 =?us-ascii?Q?9nZaopqMwUAsukqfqdk5d1KnqLVsh7put7H5kjZJg3Cj0Cb8DQHP/XKO69wZ?=
 =?us-ascii?Q?KKumcs3vPsDZgh/H1GWSjmx69DQ1h1pyBnaGRG1GL1EdQ2SYXacilvkHICE6?=
 =?us-ascii?Q?/e7M/vc8+PYPg6KPgMAP0NcnSWXSfUtsFBw4nvm74Z0FM/QYPFG52K0C+QZK?=
 =?us-ascii?Q?A4npCgFAPM9UtvN527IWGR8H2XCjhN0nJtHyU7uY7LTSdFZFBslh7J5YQ+1Q?=
 =?us-ascii?Q?oNIkmGxJbQJWuVE9/idqtezezLw9ezt8SdQZGXFbr4dmePiqXkSiYtbQQl3a?=
 =?us-ascii?Q?fP3UKxVgh0gsN4Be6vNsi7jQsuGkPHU04m1hidZQw3r+abLO2TT5HwAxotYi?=
 =?us-ascii?Q?rdV541VB2q449HBs0K3uFrw/naTVG9ZP/S8HHlTFPy/jcBhhfkQvuNJ6Plkj?=
 =?us-ascii?Q?AeGsX/c3vHWvMTTfa1n1+j1TVzhGRKzTdjhfs8j7+DvL+vtyDsDvrL6K3mDR?=
 =?us-ascii?Q?eEJRLC8kP0L5Oz7z5EEyupGoZiLLKLAVI3Okqkc7T6WwZ14Bqde06j0PL5xe?=
 =?us-ascii?Q?AfIrtzYM3psK0mX6Pu7JnlN1X4goa59whnGZHN3zHQgoDa3EO5VrCqKlMkM1?=
 =?us-ascii?Q?kJ8pwXVn5oT3ulmqryQR8kmp25aVSsAu+/nq2LeXi0Es8DuOA+kAmi8l2UNN?=
 =?us-ascii?Q?0n4H2t6ca7/mJEk/xY9ea+70fszju8K2UoXD6XJ5IQtY7TshbVEYytvxYmvy?=
 =?us-ascii?Q?RgF2gyknz7Oxtsak7lliX8VQpNqqcL+Sb47NFdz4+2UGSnnlq9KyCIowSYSB?=
 =?us-ascii?Q?pzLgoz46/IQ0W99dZn4wPOEFjaZa6Xrtsx1MLqwY6IGRteiY+bMcI8LEhntB?=
 =?us-ascii?Q?LTZ70VDSNNZdIX0Fepm3DAVfsx5TIUOnMcGI5M1eLo2bmCuPcyzCfSLz23wN?=
 =?us-ascii?Q?xnXP4mJDfo2xKzRXD5lciYoCHmZ9RllpJskvQ5ItgSdFAL46FA1IeLXRIKkA?=
 =?us-ascii?Q?l6cg/Ks85g1d6BFuc355wIsV2+YVxd4duip6vUAmS2sOIGf7I6nW+UbidyoW?=
 =?us-ascii?Q?PAhBRyf+TyUCzd7fBc+TweHS1yFPZPkxJgBrngFRc2K7tHwNZNecS/1FyX++?=
 =?us-ascii?Q?A9XSgOJqlMdkugQVy+g5v/hqsQQ+xaWh/H8GBleovGOZZY4Ti66ksoivDr5b?=
 =?us-ascii?Q?P8esxSw7zBZHE1HGu3yq2mzqiPXmCFBTEtOjXDFoAQdlzm7S2OYqmAvtKtzK?=
 =?us-ascii?Q?xhFkl+ceI8BGd2LaUip9y8ndLOurv5foHyws?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:27:27.2850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ade9cc52-38d8-4ed4-c2df-08dddba34705
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor bandwidth usage as long as it is
assigned.  The hardware continues to track the assigned counter until it is
explicitly unassigned by the user.

Create 'num_mbm_cntrs' resctrl file that displays the number of counters
supported in each domain. 'num_mbm_cntrs' is only visible to user space
when the system supports "mbm_event" mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Moved resctrl_num_mbm_cntrs_show() to fs/resctrl/monitor.c.
     Removed Reviewed-by tag.

v16: Added Reviewed-by tag.

v15: Changed "assign a hardware counter ID" to "assign a hardware counter"
     in couple of places.

v14: Minor update to changelog and user doc (resctrl.rst).
     Changed subject line to fs/resctrl.

v13: Updated the changelog.
     Added fflags RFTYPE_RES_CACHE to the file num_mbm_cntrs.
     Replaced seq_puts from seq_putc where applicable.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The files monitor.c/rdtgroup.c have been split between FS and ARCH directories.

v12: Changed the code to display the max supported monitoring counters in
     each domain. Also updated the documentation.
     Resolved the conflict with the latest code.

v11: Renamed rdtgroup_num_mbm_cntrs_show() to resctrl_num_mbm_cntrs_show().
     Few monor text updates.

v10: No changes.

v9: Updated user document based on the comments.
    Will add a new file available_mbm_cntrs later in the series.

v8: Commit message update and documentation update.

v7: Minor commit log text changes.

v6: No changes.

v5: Changed the display name from num_cntrs to num_mbm_cntrs.
    Updated the commit message.
    Moved the patch after mbm_mode is introduced.

v4: Changed the counter name to num_cntrs. And few text changes.

v3: Changed the field name to mbm_assign_cntrs.

v2: Changed the field name to mbm_assignable_counters from abmc_counter.
---
 Documentation/filesystems/resctrl.rst | 11 +++++++++++
 fs/resctrl/internal.h                 |  2 ++
 fs/resctrl/monitor.c                  | 26 ++++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                 |  6 ++++++
 4 files changed, 45 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index b692829fec5f..4eb27530be6f 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -288,6 +288,17 @@ with the following files:
 	result in misleading values or display "Unavailable" if no counter is assigned
 	to the event.
 
+"num_mbm_cntrs":
+	The maximum number of counters (total of available and assigned counters) in
+	each domain when the system supports mbm_event mode.
+
+	For example, on a system with maximum of 32 memory bandwidth monitoring
+	counters in each of its L3 domains:
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
+	  0=32;1=32
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 4fbc809b11a6..e4d7aa1a8fd1 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -386,6 +386,8 @@ void *rdt_kn_parent_priv(struct kernfs_node *kn);
 
 int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
 
+int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 379166134f5a..667770ecfd78 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -914,6 +914,30 @@ int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
+			       struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
+	struct rdt_mon_domain *dom;
+	bool sep = false;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+		if (sep)
+			seq_putc(s, ';');
+
+		seq_printf(s, "%d=%d", dom->hdr.id, r->mon.num_mbm_cntrs);
+		sep = true;
+	}
+	seq_putc(s, '\n');
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return 0;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -959,6 +983,8 @@ int resctrl_mon_resource_init(void)
 			resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
 		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+		resctrl_file_fflags_init("num_mbm_cntrs",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 90bf57910aae..9b97cadbb5c5 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1836,6 +1836,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_default_ctrl_show,
 		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
+	{
+		.name		= "num_mbm_cntrs",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_num_mbm_cntrs_show,
+	},
 	{
 		.name		= "min_cbm_bits",
 		.mode		= 0444,
-- 
2.34.1


