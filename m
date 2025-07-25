Return-Path: <linux-kernel+bounces-746174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FDFB123E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644F6AC369E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD81254845;
	Fri, 25 Jul 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YbuoaD+X"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE49824A07C;
	Fri, 25 Jul 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468334; cv=fail; b=ESnOodWMaHIP+FaeFMYO2GtcK2bcHB0Z1/pp9hTT23mVQaZ8TkXNspdOQYAakEzyueKYqO7/nZku25aU/fNENRQMMP3a6Wdob/flotEb8kPobQAIFU4tlha15UgnSsDQqfYScK1ECUgXE3e2eP9Bw377h0gNK+W1C6AMa8gIlak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468334; c=relaxed/simple;
	bh=fzzC/NEf3swrC1CGBjn5epmhlUCmEux49UloIKmPnM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgfmvDMyk09w5NZ727nnicF2ALWWPzp/FKd5eylSzQ2WyQN0IH3d02jt3BdtH6kO0jDOpdQXVjcybb7Aea+WXPD5uKwXIIXrbkdbOFReTII2gsgAE+q/6A33te2ADc8ND7Hnff2+fkv98BVbltIKRNSquXFK3WqMZ1FnciCA6K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YbuoaD+X; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8/BJF/E27Xsfj/MEPpE7i21jNrjsqBGziobkMGEmCrtiL9JObnNnUkloMCbu+looUItLM4kFlXrjrJRCZqi35dx3l8CYuli5bG93mXnRB/r12sJA2Zm+AUY5sHki1xDw3+srUKoWC9aUQ8udd1WV9D1hG8omVDPHSndL9eR7WuKvdEju0tEF7ny1OwYX37UeijmH2lRyPb7r5i4iJcAa6Es4Qa39Bt8Is5JzOa8025tL2lanS+wvlSQIUfUtFtGwQFNzzhZ/ksDaRSBHCatAjgWqn645Guo5eZ6lmEJUb5aVkLPh8kkVOg3W0fXfE5xIP+kQmIzaVNy9uQF3wwscQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrGXLFenwx8KsMTHO1AZBAzxA2JWkVPR4NJaJnmZylo=;
 b=okC/Pd8owIBfukMsjFdKqypmWxI3X+k+KkfmrMvrvqvGv4pQtaJkbDegMRbUFgB3z+UVLO022gw0DeCxJmSDbMu2Zy7C+qGxP2oKWJqcWO3Rd33tjkuuZGbgfJwP9eB3/ywGMzkhYDV23rTH7FKjcKNWoQT1m1qkFK2Ugkg29Z+KQYHRaDmgDYw8IFTDcHNnenAMNcH8/HSvGroXMqRcE7wrj3SwAo2eb7pC8zj24Jtm2thtkjWNeMEMFzvUEktC1MCoQrjzMO1KAi5mBEh6nhF+j78B1vEj3ykeyLNMULFKxKLcbEm/3C1b4nfDbaAb9N+HfryFNC419JZ8UKcxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrGXLFenwx8KsMTHO1AZBAzxA2JWkVPR4NJaJnmZylo=;
 b=YbuoaD+X/7tyE//2R4CzTP6Hbq6RgkYde/jZTJuZVU1206HNEPLfAgyhrnvjguQxa8n25jrPsQ6WpyyFYKPdWDc8rknXk/poMKkQDp10Pyr48t/HDhhEwUKto97fud9WIlrXqMeCsZXkwv6bd331HhA4xA2o2Crx2fvMggZl0n8=
Received: from SA1P222CA0160.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::6)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 18:32:09 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::e0) by SA1P222CA0160.outlook.office365.com
 (2603:10b6:806:3c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.24 via Frontend Transport; Fri,
 25 Jul 2025 18:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:32:09 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:32:04 -0500
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
Subject: [PATCH v16 11/34] fs/resctrl: Add resctrl file to display number of assignable counters
Date: Fri, 25 Jul 2025 13:29:30 -0500
Message-ID: <d1073b4bc959cd57c40d26bd80b0cccc39748123.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1bfaca-db1d-49d4-5331-08ddcba99099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pGrbJGHRjROc/XYXqm0J22JAcpI7IFS5KAuNi7nqPxuLuniAmoOTg/Y4ajMR?=
 =?us-ascii?Q?vwr8TEbDaL8nb8eFJukhUVZNNVj/DbFU+NcXoZwK48e4Ds9Ry35l0l6ZgKHv?=
 =?us-ascii?Q?3smqDEm+1MoF5aVH0lCW8ZT/3rLRvBA4GVlv9AT/FGpX45GxJxzpufj6+Jxa?=
 =?us-ascii?Q?HRxWKocK4Tyht++hLZzBM+quS/t/Oj5uVP2Eup0qZXS/I30cezbbEmTTl3iQ?=
 =?us-ascii?Q?6JskfKxxQFCXHSCfJZc5Uz+q6DAJr7nirzCgmch6KNqT6YInuSmkGq0xYqWk?=
 =?us-ascii?Q?3psuUHtJ8pVJ0asgkNzlAbqmdGMtFNs60NfK3XMp/5UKXJj3NEygVHfIC528?=
 =?us-ascii?Q?ACQoq5x5K1V1IuHL4zdQTGIGCBPF8bEPX9zNXMypsxzZOGbh//jMXQO7oCxj?=
 =?us-ascii?Q?FFXDkTY6J9dZ6bW0czq4nqB2YyB+R1tTVEFCjLDsPXX8JvPX2uPHswehKeaD?=
 =?us-ascii?Q?kin33dxkIb8F2NM8lI9weI8td7zklSkyUmHOdQlAQip4HwYEDM26JNf80OIJ?=
 =?us-ascii?Q?8z/9DfFo3pToVzce/h2kWd2UrLsLH2MX8MZW077pGOINWFdQ2ZAdWo9Qkb26?=
 =?us-ascii?Q?KCX+36YgVejCgkfKNK0lGAT/IrbZyowYp6lpYZY5AKoFhHTziZSgcv6ANXJw?=
 =?us-ascii?Q?L7WFT4PCNI9Xe/2i3JdM9WEco8zVavVY0PNcX/cOFVBJpkfwNf8w4B/CE9X+?=
 =?us-ascii?Q?DP6Mxsqk3Ogl5+RsVbJIR0qtzyWEXqb+v3Z0OYgXfWnE7nagp9k/Mk/732qu?=
 =?us-ascii?Q?8YnfDNs5VZC0plV2J4bHMAsXiXEHxPNXG5yFB0H47iIY7vXn8C4EfvE0E89A?=
 =?us-ascii?Q?KiqIhmZ6EY2GqRrsbRu3sw6wcEKVE2AajsXe1ZQWCgqQKeGLhhl7VOl2z3nB?=
 =?us-ascii?Q?1I2uT5U1aSCKBnp/RWJS/0FkVGe+07Wr7P57bzeYIEjvBb2CIsc++EjQonoY?=
 =?us-ascii?Q?l0Jn2xNuSNTAbEruz7Rr/EXXi9zhOkpirJo8rep8hHfwVfD+xDmz0vQ02G87?=
 =?us-ascii?Q?1FjVrSA7tbvZcTwYZ0/SAhGvFdaz8LD2JQS3xsAgA312D27bisxjiGkTQxh3?=
 =?us-ascii?Q?Ubw7NX2gCEGpMjlm3URxjogawkvkfLEmGrsRACgaOfPxzWOSOC6aUSOJfAcZ?=
 =?us-ascii?Q?u+8guMsfOC4+fFdgPQqbOvw3e99VyLbPDSCmNbVdDsDfGtZxyPZAAZWrFPrs?=
 =?us-ascii?Q?boN8dbHuvYAajZ7VQjLGLIHOmkJC+oiApRbKp2XHXjOLxEXu7qhtWXw25eLf?=
 =?us-ascii?Q?ass9nCSXb9ZV0yYN7Qbho0H/YxmPtwaTgzH0FE+gYSckkqBeeY+RSAdP83A3?=
 =?us-ascii?Q?GFYIqNoMVumLBC1oA1S7QNdrbG9HPWh/qgE9z3+3rbh1gLAn1TXzHjmMtY0U?=
 =?us-ascii?Q?+aDqA1wYrqd80toXtn2xnct+G+VbUJF4Wg0JbLlH3j3IzedPnlBK1w3+Cq5v?=
 =?us-ascii?Q?zGrVEEF8/drZzNOG+G3e1KT/i7vtVIVDR7g2NiAeb0uDwMRbBDKj7l/9oUnw?=
 =?us-ascii?Q?pUqhHVPHuoURxkFdD2/JLbosYcd7peCgLKsP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:32:09.1683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1bfaca-db1d-49d4-5331-08ddcba99099
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor bandwidth usage as long as it is
assigned.  The hardware continues to track the assigned counter until it is
explicitly unassigned by the user.

Create 'num_mbm_cntrs' resctrl file that displays the number of counters
supported in each domain. 'num_mbm_cntrs' is only visible to user space
when the system supports "mbm_event" mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
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
 Documentation/filesystems/resctrl.rst | 11 ++++++++++
 fs/resctrl/monitor.c                  |  2 ++
 fs/resctrl/rdtgroup.c                 | 30 +++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

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
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 66c8c635f4b3..4539b08db7b9 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -929,6 +929,8 @@ int resctrl_mon_resource_init(void)
 			resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
 		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+		resctrl_file_fflags_init("num_mbm_cntrs",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index c7ca9113a12a..acbda73a9b9d 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1829,6 +1829,30 @@ static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
+				      struct seq_file *s, void *v)
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
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1866,6 +1890,12 @@ static struct rftype res_common_files[] = {
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


