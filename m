Return-Path: <linux-kernel+bounces-770026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61135B27607
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5FF3AFE5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B905298CCF;
	Fri, 15 Aug 2025 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FG7cuQ6Y"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2A2D0C95;
	Fri, 15 Aug 2025 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225029; cv=fail; b=IS7C759ATqwuImfJ6RAQzbUoEl0ItBIaCP0+PBhj8GM70xPMcoj+tnUyb0AENcghYTk8IquQ8gM4/qAICh5L9sIVKUYYXhgZj3nX3j1uuDXX34vl5AOYYjnw7wXLhJxB3/jTqk/A+h5ZSEj3WcZbfrffQQxmbKDe9KAbnZ6zNbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225029; c=relaxed/simple;
	bh=awUYiVHp1Glflr8vN2rhOAHd0kSrhz264TM+K3NXgp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Th+4yXvlGAU1tg/RhtGLFv2Vy6J8RdEaAqwRF9n5SMTXynta6QoOrDCswRQ81T+gY/ZL0XHnDmxdmMA+Xz8PhwWwCKAz7iEWoany4L1Saic/kM05EpqOtKc18Fn5dZehP0HeB+M7Gbu3sgUxD/8yKwF++lCipSnxYIK37LUFGg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FG7cuQ6Y; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bt1ELK4q3StQdBldKzv7PUMwkupRDWdPxUp+oZyx4L1RJbLH/BIKj16Olr/mr5gr+9Rj69ikI1XykDe3qOfmYz/iu70+SvKzlcl84rcElSfKXcC/uZqXgHHblGeZHM3dQWnka+OmK+xXlOfarzQPJU6VU431/rSOzddlvF5Bm2/3fOvrE89b1HHD8+KTdVUr7BVIrIlNVwvmoIV9YL4gV09yKScOY3p1GqQ6oOENrz7KfxrtPRfZ/sk/g+fL7K13IzBy2I18+leME5FR1EcAmaxGtPlLv+I8WepKR18K+eQ/QHQQ48adSaMCsKfic8MpeebSWYGCSMxmduvueeMlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M+i28BgWtbd0E69Hzks82MI3t5QyzeC5Dn+9wxI6Qc=;
 b=BywCUgH7Awgs3xGCh39C+zSdlDZAlnDMmBpl/mJxzSNWDxKysF7NzzV8Ob/jZjW5mTpo2UUGYiWay18PRdPAcExlsZz+aXJi37IAC+Vxk0mZs1puK7NQTflOga8oYnUCnc+dqo6e0BWjott0AttHi8wTXCbiXWPHLnaxg+jLyhuCudGBTq1geGEkZI4VuZyLiNEvflWrvFDSrytSLW7WX9CrrZAfgH78jfjKjCftlhOAHpR7hdJBZNPlk9QqusSiSsYD/G8t+voUdK3R9T2YILorbhI5v9Y40XqBWbIx6C1UCk1xO1/hnCwzQaZs7LGsuEig8C5T1d1Lhyn2/MzpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M+i28BgWtbd0E69Hzks82MI3t5QyzeC5Dn+9wxI6Qc=;
 b=FG7cuQ6Ydv6xBch0U7aqgz57eUd5oCxl+eKSFtPHDuFb90HBYeDb4ROWkDigfvqyCaNRThkIuWwdqxM5ZKuCGPnTNHuXFDcyQCsV/kx8gjHSVP4Hdl14gqRbtQDi/UkpboHZYDco7qQW6UTv4YPTOSybVMJnAhkD7UyEvVqOAVY=
Received: from MW4PR03CA0213.namprd03.prod.outlook.com (2603:10b6:303:b9::8)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 02:30:22 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::c5) by MW4PR03CA0213.outlook.office365.com
 (2603:10b6:303:b9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 02:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:30:22 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:30:07 -0500
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
Subject: [PATCH v17 30/33] fs/resctrl: Disable BMEC event configuration when mbm_event mode is enabled
Date: Thu, 14 Aug 2025 21:25:34 -0500
Message-ID: <ad05cc52241731d5ae0546e4a632b264ccfb839c.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: df6ce3b6-36e5-4574-5b65-08dddba3af2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0k0SHpzeG1hdE9INHQxVW80K1lwNUdzdjBXR0RIOWMwdkhMVVYyVnhNeVpw?=
 =?utf-8?B?OGxTanFqWUVEMmxlT0htOHJjTFFmUlI1Z2NlNGc3R2pIOTgvSThGbjNMRExU?=
 =?utf-8?B?TXVieHlrNGxsYjFOUVU0LzI4SEJyMWRmSUMwVHJoKzR3ZHEvUXZhbUVZKy9U?=
 =?utf-8?B?Z292T0I5cWhVc29MNVZlMU8rVGVXemtsai9TMEdXVEpNV3RVY1FzMVB1V3Yw?=
 =?utf-8?B?c2F6NjlUeUo5NjVnNHROYWxlbmxvQkhpTW5EU1RLZ3VzSWI4RTV2ZDZMYWRS?=
 =?utf-8?B?WGZQYWJpTFhxcTdERitOVjkrM2I2VXZ1MUlsWWxrT1pubXRyT3cxaDN2ZEtu?=
 =?utf-8?B?Y29veGoxaytUN2wzNzk3TzJIcUxhbzhxU2NoV01DUU42SnprRzJpT1V5bTRV?=
 =?utf-8?B?TTZWYmp0TmEyNjZnYit5bVBqaWU4THJCVUlPZVl1b1pDdkh6aHlDRGE2OEdO?=
 =?utf-8?B?bWM3cUNTdWVmN1o2cDhHZ1NORzN2cnVJYitzVENzS25ldVRpaUpwQy9PS0dL?=
 =?utf-8?B?ZXNWUHhvY05ybFJQL2lTZ1BqTUlxUmQ0blNZV0k3aVZBUDNaV0pwYnVLVThJ?=
 =?utf-8?B?aGZoaFVQTzRxM2NCdWtKQ2hYTHlqTExFZmNDeGpIQ0FnTDRxZVdkc0hvZlhW?=
 =?utf-8?B?RGdJWlhBMDF6TGpObGZLSTN3ZkVQQVNRY2s4d3dHWUMxVml2S2VJTVN0VXdU?=
 =?utf-8?B?OG0zallUZjR1VC9YYkhmbkE4TUZrLzJFNk96dE9jdGRqRzhpVUszVHVkK0Z2?=
 =?utf-8?B?NndBbjd6MjFtd2dCUk5Tam1VU3ZvaEVoTnI4TE13aTBOeFNHdi9rSjJKam1o?=
 =?utf-8?B?MlpHY0JsaTA2V1BjT0l2eDJFOURnUnV1SHY5UlpudmVsS0pqT3V0alMwcFYw?=
 =?utf-8?B?VzhGanVicDU1a1QzeWRxeS9zNmUyRlBDKzQ0Q1FvNlhldmoyTlF4Nlk4cVAv?=
 =?utf-8?B?QUFycVE4VnVZV3hmZHZya1BEVlpCdXM2QjYzZXFscWp4S1BVd1J3T0UwOStv?=
 =?utf-8?B?U25tNU03MVF1dHFVenNOT3V2dlBhV2RmdzUzMXNQdzY5aHEvUEtiOGY5Zjd5?=
 =?utf-8?B?REk3VG5XQThMNHZHWlFJbDMxVE00aEE0MnZSWnpneHJtNDdoN0N6aWpFQmdu?=
 =?utf-8?B?c1NSUk1oaGZtUnRrQnBuTXJPaHloVW9WMzlsbHFJVFg1VTJvdHo4ays4MElq?=
 =?utf-8?B?K0F1a0hWVEVFSVRzY3VKaEtOdmJHYis3Q29PLytldi9hRVFTRk0weEVPZHpG?=
 =?utf-8?B?d3JwY3FEQlU4cGZ1eXJ4d3BpQ2FUNkpIK0EreDU1Q25KdFNLV3JTdDF1bCtr?=
 =?utf-8?B?U0xPYUgzZDgyRjAxUXRKY21CdTdzL1RROS9hUGFLUDhYbzdrNFhzREJqWFor?=
 =?utf-8?B?eXdBNGM0dGcwTkI5UWtiSmo3UE43YWJUanU4eWxnbGRhbnU2MXdDeHg3b1lR?=
 =?utf-8?B?cHc3M1ZLQVhJTmRZMHV2L0MvZ2dwM1EwWDNacUZUeDBpeE9wbURRcTg0T2x4?=
 =?utf-8?B?SWUwVmJSNmFVTWpjMlpnT1VUZzV0SkFvUzdjakFlQWlyS3E5b2MvbTMvd0RT?=
 =?utf-8?B?NjlZWGUxREw5ZUtZcDliazJMc215bnpSd1JZNFdZTTJxc216aGpxbFRUTlpl?=
 =?utf-8?B?UUxmUFNac3FST1pTMFh1cXJQVW5HQ0wvWkQxUktBK2ZFbnVhODhZZElGY2d1?=
 =?utf-8?B?Z1IyOEFVTEMrV29SOWt6QVhZeWxsbFFhY09BcWN0azVWRFY4K1VOSFV3QWRX?=
 =?utf-8?B?QzNqZVpGVUx6UHRwWWROUTlQbS9kRGJKQjVXdXFNcytNY3AxTGN5SlYweVVM?=
 =?utf-8?B?RFBxdEk1WmM0eHpVckJoWGFWQUtvOWFSaFlqcmdaTzdvWjVTNlBWM1JrUDFK?=
 =?utf-8?B?TUpkdDY5RElFeG4yVUtQUGhYWTAzUFh5cHB0dld6NTJFTGtRTjRCaUt3M2Fo?=
 =?utf-8?B?azBudkord3RCNlg0b0ViRjBBdWFqSmtEZlI1bkZTTnptdGl5dXFjQy9NWTl6?=
 =?utf-8?B?bnh5dmQvb3ovanlFY2g4OVM0M3JhU0I5UnpJWElpT3RZby85ODZhVGdhNHhu?=
 =?utf-8?Q?qiyfhx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:30:22.0167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df6ce3b6-36e5-4574-5b65-08dddba3af2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211

The BMEC (Bandwidth Monitoring Event Configuration) feature enables
per-domain event configuration. With BMEC the MBM events are configured
using the mbm_total_bytes_config or mbm_local_bytes_config files in
/sys/fs/resctrl/info/L3_MON/ and the per-domain event configuration affects
all monitor resource groups.

The mbm_event counter assignment mode enables counters to be assigned to
RMID (i.e a monitor resource group), event pairs, with potentially unique
event configurations associated with every counter.

There may be systems that support both BMEC and mbm_event counter
assignment mode, but resctrl supporting both concurrently will present a
conflicting interface to the user with both per-domain and per RMID, event
configurations active at the same time.

The mbm_event counter assignment provides most flexibility to user space
and aligns with Arm's counter support. On systems that support both,
disable BMEC event configuration when mbm_event mode is enabled by hiding
the mbm_total_bytes_config or mbm_local_bytes_config files when mbm_event
mode is enabled. Ensure mon_features always displays accurate information
about monitor features.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Fixed the extra reference release in resctrl_bmec_files_show().

v16: Added new comment in resctrl_bmec_files_show() about kernfs_find_and_get failure.
     Added the parameter to resctrl_bmec_files_show() to pass the kernfs_node.

v15: Updated the changelog.
     Moved resctrl_bmec_files_show() inside rdtgroup_mkdir_info_resdir().
     Removed the unnecessary kernfs_get() call.

v14: Updated the changelog for change in mbm_assign_modes.
     Added check in rdt_mon_features_show to hide bmec related feature.

v13: New patch to hide BMEC related files.
---
 fs/resctrl/rdtgroup.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index dd5e6f720b98..72a19e0e4fc2 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1150,7 +1150,8 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 		if (mevt->rid != r->rid || !mevt->enabled)
 			continue;
 		seq_printf(seq, "%s\n", mevt->name);
-		if (mevt->configurable)
+		if (mevt->configurable &&
+		    !resctrl_arch_mbm_cntr_assign_enabled(r))
 			seq_printf(seq, "%s_config\n", mevt->name);
 	}
 
@@ -1799,6 +1800,44 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+/*
+ * resctrl_bmec_files_show() — Controls the visibility of BMEC-related resctrl
+ * files. When @show is true, the files are displayed; when false, the files
+ * are hidden.
+ * Don't treat kernfs_find_and_get failure as an error, since this function may
+ * be called regardless of whether BMEC is supported or the event is enabled.
+ */
+static void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_mon_kn,
+				    bool show)
+{
+	struct kernfs_node *kn_config, *mon_kn = NULL;
+	char name[32];
+
+	if (!l3_mon_kn) {
+		sprintf(name, "%s_MON", r->name);
+		mon_kn = kernfs_find_and_get(kn_info, name);
+		if (!mon_kn)
+			return;
+		l3_mon_kn = mon_kn;
+	}
+
+	kn_config = kernfs_find_and_get(l3_mon_kn, "mbm_total_bytes_config");
+	if (kn_config) {
+		kernfs_show(kn_config, show);
+		kernfs_put(kn_config);
+	}
+
+	kn_config = kernfs_find_and_get(l3_mon_kn, "mbm_local_bytes_config");
+	if (kn_config) {
+		kernfs_show(kn_config, show);
+		kernfs_put(kn_config);
+	}
+
+	/* Release the reference only if it was acquired */
+	if (mon_kn)
+		kernfs_put(mon_kn);
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -2267,6 +2306,12 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 			ret = resctrl_mkdir_event_configs(r, kn_subdir);
 			if (ret)
 				return ret;
+			/*
+			 * Hide BMEC related files if mbm_event mode
+			 * is enabled.
+			 */
+			if (resctrl_arch_mbm_cntr_assign_enabled(r))
+				resctrl_bmec_files_show(r, kn_subdir, false);
 		}
 	}
 
-- 
2.34.1


