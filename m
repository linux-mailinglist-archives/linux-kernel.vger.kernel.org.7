Return-Path: <linux-kernel+bounces-746195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5665B12415
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743B01CC6831
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F24155C97;
	Fri, 25 Jul 2025 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CGYH/BsS"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A478F24886C;
	Fri, 25 Jul 2025 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468546; cv=fail; b=oJuGayPj1wx0YGIEAHWkxndcgHNuj4K0TROJ9rqQlosOD8hqslTFK+pZOx5wNmG2/63T+nJvCsekzeqZTkoB/KXf1euW35yxDt68ztj/PZJhR871YDVXP1FcSULVZhCI8ljhebq2O4fd2mgy7pJeV50csje98E3VxTp3wCI83nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468546; c=relaxed/simple;
	bh=ztjT5IHH+3hpBhLIlID60K78MV/GmgVMRXLGtGo2iUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOtlQ8PbNq1YLO1IJrMzR0AY6NPqoxh8OF1T5zlIjJEeQF9ZbZsqiOGWtaNMAH70t/E6f/Vu5mVt2o7nuB10iIAhfaNs2qdJlK+a+kJDYW3ELa88Qofg3UMnwxY4BwQlNxYInJRWJMScsE0fz9qvi78Pgp3+/QgO2QUTpR8jHwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CGYH/BsS; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lt8Rva0wdZEFLPaQwEUZirEXauK1n2fWGBR/daG2CZj4bFRONvOzkllEWYA7eP4BMq2gccqq08/XvIT1naskHHwxV66aGzbKSpe1lXNagOWgZnZOsqTcSTPr9EQMCIhfdjEZ2ouwyKyAnxir7YKQU6XGdbKoejdEjfhUps40Wdnhilb8iTjD9FU5iQ1VOyBMD/ivJtPyLZrBrzxdrrwsmp4nUz8ljqW/o5uaZBRyryvs0qUlUUIikDapS+qOPvRdrDJkINFYrDyu6n5qMuYh3mwqFuoJWqO7MbPrtKgszZugCVePx2aInOFq1AcKhhixoz+YZjxUuKr83nHHWDKQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+d+xGTA/oscjHZ2ge0bwl2gNA7vk1ivfQKwPJe4URPU=;
 b=M7MxT9Qtcf6A2+Ha29vMl6THAky4MnoWNbIQdeauDUA04KFLvVKn2bJ5ipMGAG9GxDZdWhW5A7vNWL4jaMeBRF7jFj2fG7pruhCLoQbX1aKLFu5o8T3NqXqfHQmN4/sYmK/vdCoIjwxR94P7IGpOfJvkuziCEl5XtYjdiD+R+TAtyhH7s4fsKok5x0T+X7SqkhjsO8Rn0Fs7ChLB2IX0wMF0Bd86vjCX7zYbqNqotXiI2tRotsiigOg9ne76X2fFf7csABzpH08w3yIXn/0x8WKB88U6pOxE7QBCwEJS2QAqJw1hBKydZP6gfenLqpB8gXHkO9Q9mtdC8mebwuiGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d+xGTA/oscjHZ2ge0bwl2gNA7vk1ivfQKwPJe4URPU=;
 b=CGYH/BsSLK7syPSXqKVO0blGHvOl8TPCpJYjLS91wtOTuw79jm62CrALs9Agm2Vy1fgcmBg4Yz9MyiL5IMb7Pke8F/Tf/75AhJSYBZgswrZWqn+rvZuiB1NwzQHX0CxvBPceStwdXAjlO0QjNUFE0cVTvTQ/KUTfgV6KdO1yN/w=
Received: from SJ0PR03CA0145.namprd03.prod.outlook.com (2603:10b6:a03:33c::30)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 18:35:38 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::3b) by SJ0PR03CA0145.outlook.office365.com
 (2603:10b6:a03:33c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 18:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:35:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:35:35 -0500
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
Subject: [PATCH v16 31/34] fs/resctrl: Disable BMEC event configuration when mbm_event mode is enabled
Date: Fri, 25 Jul 2025 13:29:50 -0500
Message-ID: <a5509fabd688c9bd1ee14571c9e00793f34afabd.1753467772.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753467772.git.babu.moger@amd.com>
References: <cover.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 92118b7c-1d7b-4845-553c-08ddcbaa0ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUs0NmZPNkhjRjB1TlplMFJEZzMxMlhJV1lzQVhpVytRVGY5Z2RMZUg4Yno4?=
 =?utf-8?B?Q2lSaXkrMk9vcHVxM21qREx4cW9PNUZPRlo0NFB1SzlsU2w2S1pacmdzN2li?=
 =?utf-8?B?ZFNwTmQrbTdpVTFJWmZ6c0xsRzE3WTQxMlRCL3V0WXBDMDNOVlFFOHVaa2dr?=
 =?utf-8?B?emVJODNkWmZHZ2R6TUhtQmpQd2oyWjNzVDZPek9WTUVIUU5WK3p5cHQ5dm1r?=
 =?utf-8?B?K1lIYTZyWlNtZk9HY0VUTVJZT1d3Mjg4a3VzMm44a3FGSi90SmpFUzZIZFVL?=
 =?utf-8?B?VTI4aVNHTDI4VmNNTUVzd25wVzhwSjJ4QWVuM1VPTHVoRDdxbW9ocTdvbG9Y?=
 =?utf-8?B?S1IwYk55aS9IaEpKVCtnWHF0MzN4L3RRUmtyK09wRWx3WFhXd1FQSWxWMXhm?=
 =?utf-8?B?VnF4eWFUYVBWamZIMmJRaXRLc0xNWDFyK1lpVjNPTHZNWUFIZ0dMTFE3cTRB?=
 =?utf-8?B?SjRKcmt5d1RLNnEzSzUyZjlGMWYwOEhuUGhYVEVJdUx3Q21jaFVXWjNON04r?=
 =?utf-8?B?RU9TVnprbm54MUlneGJLaWZpMVRlL2xDSmtIVUtxaDhKRjIxYTRLMjFyU1VT?=
 =?utf-8?B?U0hZb0xOR1E2MUp3aDVSNytvMFBkcnFvTHlxZWJpSXRKTEpLTjFDQ0JFVWRh?=
 =?utf-8?B?eGg1NTNHOSszTzVZSkhmTllCeElXM05ITWZHbW4xd1J6WnBxcDc4bERZRWlV?=
 =?utf-8?B?UHU4N1crSFpTNHVXVHBXeFVYblZrd2dBY0Y1SmJSQ2c2cGZaNjhySC9GUTlT?=
 =?utf-8?B?ejRuU0pDZ3hLVTV6M0Q5RkZRcG9lZFNycHVzd2Rsc3dHNW9qbzErUHNRTDE0?=
 =?utf-8?B?ZnU2SmdRNEhxaHJoeG1HUmwzVGdRQVZrS2VJOWpyRUhKRUdpS1dDSVVwWkkr?=
 =?utf-8?B?V01mZ1pvbldRTC9rdUc5aXc4V2swQ3ZnOENPRW14U29yM3d6VUlUSml6ejY0?=
 =?utf-8?B?L3RDZEpJR2h0NmRlUW9GQVd6NkFTV2oyWVBYaTI1QTE3d2hmUVZycWlBZnRM?=
 =?utf-8?B?dnpYd3NyaE4wSzJBZnRRV0hFZ0QwQkdIZElPRll5N2NjSmQ3bjRvWUExcDJK?=
 =?utf-8?B?aldKeGZNU2RqZC8yTmRyRnplQWJvUTE2TllqVEVGc1liWjA0MWJJVkNSQVpV?=
 =?utf-8?B?cDhVOTFRWFFNTHkvenBtc2kwdk9NdDFXalNzZWdOQi94S2tNN2NuNG91bkdR?=
 =?utf-8?B?cWMySU5hMHRoVm52RVorWVpiMDdROS9uQ0NLTjZscitBTkRXN0hlcFJlN2wy?=
 =?utf-8?B?dHdwbEN6T0MydEJ2N2s2bjJWMjNjU2ZDQmJUd0lqQ3pKRGp1NldqRVBHN1Ni?=
 =?utf-8?B?dWlnRlZYWnIyeHZ4R2Q4ZnRIMkJ4dlhnWVpRYktybFJ3NnZ2Q0VSaUZkeFZ0?=
 =?utf-8?B?VVlvU3FlNVJjOGsxUHQ0ak1ST3VTdmZ0NENWRCtaTUM1dDFCMUtHbXdsUFFM?=
 =?utf-8?B?amVEdHhNeXZmd21DK2RaRWVrSWdRcGxhL2lzSHJzUW54bThGZldGOHkyZWh3?=
 =?utf-8?B?bTJaTncrNWpBd1hqSUIydm5CMVF3cTRFRGxrcjFRYXRSaXc1N2FzZXc0QmNE?=
 =?utf-8?B?S2h6bkxvOFBnUk1RUjJFeU8yaGphaWdVbG40NlB4Uk9GWk9uNEdUTXFpUjB5?=
 =?utf-8?B?WjJYV3FDQ1ZjUWJ2RXdjSnpKK3I5eTdHbGdxRnUyZW1lcURQSUdkSGhxMll0?=
 =?utf-8?B?N2FkY1RTSm5HSWxWc2U5SXhPVXJtRWpxSGJkWm5JQnh3MGJpK2hiTG5pRkFh?=
 =?utf-8?B?T08rWmtKV0hrZ0xXb2kxMDdINXJnbE1KS3VYcmtlcUE2Rkk1S1Nmb0tmV1BY?=
 =?utf-8?B?Tm1DOEM0RXhKWnRpTHZjbjRSOGRNQkZSc1ZlNjJadERDZGcwU3hZYVFFc1Rp?=
 =?utf-8?B?RU1hV3JTTy9Xc2s3dDBPeWZrdDQxTUtGcVBQSkdLRG9BWmJpSDl6akVIMVEz?=
 =?utf-8?B?RFRCMDhXQUZUWUVDaXV3bW5HNUZaV0FaZXhQU0xYd0JOK1V2eis0SXg5c3o0?=
 =?utf-8?B?ZFIwM3NwUnVORkNVYUFPL2ZWcnBySjNDWnpPWjJVY0FKZWlLdVh0ZlpjZHB1?=
 =?utf-8?Q?OpmZSg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:35:37.5202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92118b7c-1d7b-4845-553c-08ddcbaa0ccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677

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
v16: Added new comment in resctrl_bmec_files_show() about kernfs_find_and_get failure.
     Added the parameter to resctrl_bmec_files_show() to pass the kernfs_node.

v15: Updated the changelog.
     Moved resctrl_bmec_files_show() inside rdtgroup_mkdir_info_resdir().
     Removed the unnecessary kernfs_get() call.

v14: Updated the changelog for change in mbm_assign_modes.
     Added check in rdt_mon_features_show to hide bmec related feature.

v13: New patch to hide BMEC related files.
---
 fs/resctrl/rdtgroup.c | 44 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 2d2b91cd1f67..1aeac350774d 100644
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
 
@@ -1799,6 +1800,41 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
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
+	struct kernfs_node *kn_config;
+	char name[32];
+
+	if (!l3_mon_kn) {
+		sprintf(name, "%s_MON", r->name);
+		l3_mon_kn = kernfs_find_and_get(kn_info, name);
+		if (!l3_mon_kn)
+			return;
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
+	kernfs_put(l3_mon_kn);
+}
+
 static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 					struct seq_file *s, void *v)
 {
@@ -2492,6 +2528,12 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
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


