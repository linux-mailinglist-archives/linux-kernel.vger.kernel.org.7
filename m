Return-Path: <linux-kernel+bounces-746175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE4B123E6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6EEAC178F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5035224A07C;
	Fri, 25 Jul 2025 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RPcpQ1RM"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9224729D;
	Fri, 25 Jul 2025 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468346; cv=fail; b=K5Wd4grwlvosF66S58+Ta+BM/DflCq2mfpXvZmihZrj7/3qJSx+PzOOieJtk51MTIog8nqzTmfrV1wsm7OjMn8hR72FLuFMlo2UoFGnx3tPvunsWZ0zAXI23XIZcqy8fHYDlYmwIzO6yp676YQuqUs98w4Lb5Pz7OK+WVfdpS0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468346; c=relaxed/simple;
	bh=2hAPdB0sgzxeEx0KkYUOydRyZzOzW6oUKTgn00mirGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpoYB26/uYhlVLWeI27y2OR8w2LxYJt/W7eSuLcd9PCEc/hzac7Dv8cuWVMNfsM5Z1w7LVMTBFw2RvHAyhgGFPRK7lrK0quF4U0uiRoat5inB3mSpL+yK/WjzgdAiItc3Zku6TUD0TQWj6Wl+ssbvjPjHJrf/iO3VvW3KJYb2Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RPcpQ1RM; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spbWFdqIzOWWnRg+ZJ9/jxVkyee/Q8mT3nJLMjAPyy9Rmv+zSWNzvlYzNPeyET10vZmznZiwo6Q1quGU9L9gkMlIH9wf9fyxxZZcux40cX+36e7t/+HHVbxAdZBbs0xNyeRSF3YgAWXDmJ8HBKCE/OVGP6ZwgVCg6qwVhy8/yRbkDiTyPaicxZSzrXW9E3JzOvMWGAPKpxRN083dPCQIBqTfp1dorwzSUvs259aj5BOnWsnYUl+8HBZfn7lGcAVf2WUWnAlh4vACCytusSLRp4SYJ7TJUhQQk/GenS87UfOjujawIHxbips3id8vt9Rsa7LsT1kxo4V3T3GGs+g67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQIlrq4JU/vwNUqBC13EkTRkEIbIsEUWd+H7bkxLP4o=;
 b=Kz2fZoZg/+72Fa1RWBAyF9I57n8Tjcvux1pDGo/0hPeOrxVfkzovzPlGulU/ddJuM4+G2uo7j1X4V5CU3aDzwRdnSkvx1aEjz+ylvcq+RWvF1XTnxlkHPD5cUw4jXN5mqhkTj8nfCtb3QkAJbp6Dqi+EzXd6oLQlW5CaLv9qoOql91qlatKpfHMgt2VIQFNE0LsiKkn8GMTwV8HX0t1vqJAMJcg3OYmFrNfLCYDMfTpfhDwozBfcJMUVV0hVZ1GVkDZpiUdPPze5xGWy9Ja+X1rgaDowdKbzoyAzvHj/nsa5I1lrpgswUxSibzgf0vRKlC8aMVBP3+IfW7Igharlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQIlrq4JU/vwNUqBC13EkTRkEIbIsEUWd+H7bkxLP4o=;
 b=RPcpQ1RM96mfygFJLBSUwWQNl+5k/9Yhwc7BLrpQAPKhAyWXOjriyCjXjO0YF1h8ue8luhCFDoUEZlRWZcAxhGNiZDz54rlWwN7bnGJxHrZBdnn0bT7hycHqKMAa9cvZsYqLdO2ukUBJBVW80NGs4Wq/CCpd7zxgVfOORSu7sq0=
Received: from DM6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:5:80::32) by
 DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Fri, 25 Jul 2025 18:32:21 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::d9) by DM6PR08CA0019.outlook.office365.com
 (2603:10b6:5:80::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 18:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:32:20 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:32:18 -0500
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
Subject: [PATCH v16 12/34] fs/resctrl: Introduce mbm_cntr_cfg to track assignable counters per domain
Date: Fri, 25 Jul 2025 13:29:31 -0500
Message-ID: <be5ba5e3b97440321c0d420d8ac3c03b2fded59e.1753467772.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753467772.git.babu.moger@amd.com>
References: <cover.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: c375febd-2305-4d40-182c-08ddcba9979e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xSkY0UVOK9XjN5eJVLtdIVU/arUwJ7qXYzxJ84bSVA/o7Jd7LZc5ZUemsg+5?=
 =?us-ascii?Q?ijA4257FdBdn2SH97bCphT8XGVF+l9dW0IgNfJ277j/7PF73IC22MnkbAbK+?=
 =?us-ascii?Q?WNzxzGJXMsK8Hr/msOLa09dugmx2jyU/YtvS8xJnnz9XIXX3MbbXVWgHdcAl?=
 =?us-ascii?Q?alhtt5EQ4cF5zu1jctm9VNhdtlG91fDZwVLDicDYcXEX+KUumVNaNtVkZBS9?=
 =?us-ascii?Q?nbxb6OlVHJ7LBY0vmRrTYM7DMlF0TwaoUcUecs68k6uHgWw+27IfUO3vzNPo?=
 =?us-ascii?Q?OW6hFLM+XGDJs8d4AKnRP53gXJgidbXrdV28ZS6E5X7oDUuPmJN4lwGyNOJF?=
 =?us-ascii?Q?pHAYUxgKFZhCdFfvFjcboK+Uew8U5m2t8s/5ZAOqax9IFTgDmx8cldmQ7clz?=
 =?us-ascii?Q?sTCjIhikZyfY98CAtmdjiNM4ju2gxd6o0G3U98zBDJcy32WguKOW0LqoKa7C?=
 =?us-ascii?Q?CRzMSvIz5C5myRfrpprH8zA7BwiMzs76Y2NDdqKk+xcr99C85tQKbMyOqIXo?=
 =?us-ascii?Q?dX8KHGDPj62mQLXZtiGP7OvBm7Ns/vPBsJ1xFLJAghgWYvqpeSz4hWcbN16a?=
 =?us-ascii?Q?yrsvUdKWJNl2fMmlDMnn3wSeR6SDoKRwMWn3vZu5eaiFVi2iz3cwA0gS+rwN?=
 =?us-ascii?Q?H+hvOJmlWSaPK2R3jqxtDVe4y8/3qtmZifmMwH4umzisHm7SRlAbA6E8KiPb?=
 =?us-ascii?Q?JXewBF8lvl0XT8rfhyRhkhsDLoF0JNetRADbTwtTw+PocAtWLsoaQY9tb+fv?=
 =?us-ascii?Q?b575NNVP2mICpKRiBE0F5bmcJ6fP24SSBQ3f2ECy/41LSHmjIKcKFBh2EsC8?=
 =?us-ascii?Q?GSApiXfy6vBQxA5GpkyopwsVlsybrb0zxXV9DOIu2Ag536ZMI/70Kxflvl6l?=
 =?us-ascii?Q?ffEn+2qijDQ187hy5E/0os/aAsHV6/iyBG+/V+xEvsUbBqo8DXGyE1f5s5pn?=
 =?us-ascii?Q?F+RlNWF1bOms/XmatKPvWiWLF0db/jyxHMvNOxzMj7OqJAwwhvNeFNQHB+3h?=
 =?us-ascii?Q?jqXfh66UUJQNcT/F8CDrEB+xgdHxxNgOsUA1dhZYS1eTY5D400AGFhuJN9NL?=
 =?us-ascii?Q?zMDimrww+NlIEZ6Tn+xuPb2JoGo9m8TiRQIxpoNdEZEwcR7OVuyddIy4Ng5q?=
 =?us-ascii?Q?n9P4m7JvUGnh6h4T/H27bT0b3Nh4iZVgYd2vOYxhEPoUL5kFA43EzxRGlplP?=
 =?us-ascii?Q?uAM5euod9NdVNN9FfhbtgdPFapbjln+U1RwPsOQ589AkIANqbJ4E0NFa8tSP?=
 =?us-ascii?Q?3kem95B19dih7KxfZ35a8UDkL9zsUYk6qnuqsx72AKtsI1Hpy035WM9houRL?=
 =?us-ascii?Q?ftmRKfPu9sr3jnDSydRRVoVQbpyQgjlK6+xvgczrTEKm9GEX7TYXi7f1qcEm?=
 =?us-ascii?Q?73/vHyYORvz/ZeOmbf/v29IFdIXQcf+VJo1v36hP9ywjWdE0zbQemlcqW2fZ?=
 =?us-ascii?Q?Oqr1coLwXQx9o50DSfSdILlXwyXWSS7E5UAr+KhvlHAdZGvRFmhcV/nLUfJf?=
 =?us-ascii?Q?prb8a4KdTXUruizVxYrzWNmgDEVAQbt6dJ+TfzBQvP6gq259AvgZ/0GmHw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:32:20.9225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c375febd-2305-4d40-182c-08ddcba9979e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722

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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v16: Added Reviewed-by tag.

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


