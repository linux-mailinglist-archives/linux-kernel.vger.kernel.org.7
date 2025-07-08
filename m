Return-Path: <linux-kernel+bounces-722472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34851AFDB0C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D63C1C401A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7E9283FDC;
	Tue,  8 Jul 2025 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HHO7nx2Q"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A6271A71;
	Tue,  8 Jul 2025 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013364; cv=fail; b=T74JAmGdtGZIWHq62EFLxgzTlVw2UJLSYxUYeE2YyLtUrO24kGfw+Hrh6R8uOR1aXLEEtK3ES8Wshp6BURWohSO2qZaHovUWYxoTXkRNzTMVefY24Q3PXchx2X+4ybrNNuz6IrQaQdKYZDxm2KAHXOVLZrMHAxB5N0IXBrKshLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013364; c=relaxed/simple;
	bh=rJksbkdYtxvFebK4LGCf9tG2coj8TX0CdPfGR+Hj6HQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNYOMlj+LcPgB6GJFQLLmCXt2R35JzDRJ+GIRunQutc5ytEWgxjMZTK47/0UVzgqKbzKS0kbyxjzl9eNCKvyRDjPoepj1Gm1a2XawmxdWbMekciQndpSV8AwNNxzcY19qiB+EfrhE/4XM5JGfAOMgjs5j9gbDelwnsff5MEnXzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HHO7nx2Q; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Znz4WUkh4CfaXQXBvnZ9A+eN8IrmN6qmjOTQltTLsO/wx8O4ifBOnfyNbXcFecSCemy05PigB7YAywXBw1MoBUVuuzyPJ65M2rt+G2sW9RcnhzawmED0ezs8Lkcvo0x+OrcRPmsbwQPhaVzShseHVkeCQBbw5kHmO8xj+Vq0aMt3PeksbVbUHu3jKX/eonlcxzcez4UUaB7cOkIlkNFroLbenqN0IHLDVIUltml5CsPO09u3uhsgrrTAdK2+Rs8XGRQlC1IOD78UllUEU7gjCAQqge5zCyyPKo2DlTuKkC039PywSHpUxYqy46ClPAdIqee76bjZNhaM4w3u0yuzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M25C+KEuiouIXLQPn8xHRjFn7mlqufV1KUl6io4pphM=;
 b=yyL+j228J+BS/bNKrbjT6XD1Dr6KAF2yoTPZLht5gLPQt2LMzt4tN1Bay7eAgTt42ic7P+cC8UZZNgqT3JL13uwwvB668w6nekeqvAva+U0dwt7za5oiCZgbMp8ycrq5Oo0yNIbcD/M0ljLeBA55Pf/CWNN3KV5P6WcZsE3YKVizcZVrKU5pUtl0tGAoDasnFisxa580779aAW0cNJh+OPCzvAqvIjQ8b/PxBxgKajETS4LmDAL8JZRmzI2zejrK+5pH8IrgcYJTcs8gE/tQI5VAyvp5UIxc1bmMDfugASkETMHbvmWECt1Fqflefa83jdb/ruHCjbfi186AMNjhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M25C+KEuiouIXLQPn8xHRjFn7mlqufV1KUl6io4pphM=;
 b=HHO7nx2QSBx2wWlwincDdxZd3Fdd9AmcEF/5/cYxLvDmfa4evDdtjp920j1vk68P2F/KuhYENk89Rt6o/KS4J4u2l8ArOY0wDQ26mDA3Ltjwk0VVuPKASAxTt9aLyAELHZPo9n0LdGsiKzrQGOUfNSdt+Fm1LvFAw2NMvprIxfw=
Received: from BL1PR13CA0091.namprd13.prod.outlook.com (2603:10b6:208:2b9::6)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 22:22:39 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::15) by BL1PR13CA0091.outlook.office365.com
 (2603:10b6:208:2b9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:22:39 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:22:37 -0500
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
Subject: [PATCH v15 32/34] fs/resctrl: Disable BMEC event configuration when mbm_event mode is enabled
Date: Tue, 8 Jul 2025 17:17:41 -0500
Message-ID: <6aee8abeef1bdc5b88f8c3142a702a9d683f5f66.1752013061.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752013061.git.babu.moger@amd.com>
References: <cover.1752013061.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f4751b-783f-411b-015d-08ddbe6df2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1lSQ0h4RkdUTjAwRHBhK1R3czB6d1JYTFVXUENhS1JiYTlhQzE3RS9ocUhp?=
 =?utf-8?B?OTdLUFZJQmw1azNLMXZkQmsySzdXemNYaEM1R3J4MGovWDZqaXpGVFl4L1pS?=
 =?utf-8?B?d3Y2V3BFdDdYNjVtS2ljNXhuWGxvcE5DSDk5KzVOMDMrNGR4cGhnREw0Y0s2?=
 =?utf-8?B?T1ZqclE4cjZmZk9VQ1N5NDdQNzgvNnZvbGFtVm1EUWFzVkR0QjZZOG1UZVpC?=
 =?utf-8?B?S1hBQUFGNmZyajZZYjJsaTNIL2RVaTRMZG9aVGNBSnRQN3N1M2xmeUtEVHpz?=
 =?utf-8?B?S01kZzFXV0pPOExLU0J5NDBubHRwR2h3bjZzZGpmWTBCMWZWaVM3TkMzVXN6?=
 =?utf-8?B?TitqMVJmc2dWOGlEaGc1WSt3MUZOUEFwbVdOL0hMUWNyMVZJSzNEZS85WUx3?=
 =?utf-8?B?YkxPbzM4UGhKUlN5N3pjV2dhYkR0dFZMQ241QVE0dGR4M1NrV1V5KzUrajhm?=
 =?utf-8?B?dUptaS9vQ294WTJJei9BRjExQnpheXdvTDM2eThrQzlKVFNvRDE2Z25jM3JR?=
 =?utf-8?B?WVVwaHd0anpHRUV4d3BhdGl3MnB4b0VUMjdEY2dlZHRjQUI3WHM4YjZKQWJk?=
 =?utf-8?B?N0tlMzJzZkpZeVJHUmorU0x2SEY1MlpmY0h5NVdsdXp6dlhOejNzQU9pU1Ix?=
 =?utf-8?B?SmdMcHFobXVZOU0zM21QRnZzWUZYWDMyUlE3ZmtxRHZaYjFFZHJYc05Odlcr?=
 =?utf-8?B?NTBZTVBBUk4rRnFydUJOMXI0M1BIb2RiK0NHTWFEOHpaRzVLSXpBNDI2N3hk?=
 =?utf-8?B?UFFJNmYyMGxTNEd0RXVVdm1HQU5ra3BtRUtOME13MG1sbFZCQ251R3VQMEpN?=
 =?utf-8?B?UG5jRVJ5MzJLaG8rQTBXOTZRWG9vSXZYNWRsZHJyUTV3QTc0SFdBQ0srUHBB?=
 =?utf-8?B?NjIvcERzT0hUWjYwbloydllLdEsvelo3aWFZYmtGaTVvVmxrSlhJT2dWdnZU?=
 =?utf-8?B?eThCWUQ1WnhLbjdkUnVISmZXNkZMcG9SN3AwOTVlRElqTHl1V2luVlljdTFk?=
 =?utf-8?B?V0gvU1VNZExBMHo0azJ2OWhOYjZmOEhVN2w3YVNGaFZnQ2NEL3pMbFc3SS8z?=
 =?utf-8?B?NktDNzZKbUkzMjllRFBmM0hDeVZhZnNsYlpZQ2VQVUZ5WG5TSWllWmw5eFZT?=
 =?utf-8?B?VE1CS2tNTGh1ME8xOFQ5VU8yL3pPNEV6d0l3ZmtrUXZONFBGeEl0Y2haTVZx?=
 =?utf-8?B?c0tQUE1vcUt6Qi8zNDQ0dGVndlRwTFp0WVB0WWNockNLQ3JldGc2c2liRkor?=
 =?utf-8?B?d0ZVQTcxZzhuR0xYVUF1dVM5a2Y0WWJkZ0RpMmtreTJKNDlGQ0h4bHRIMXc2?=
 =?utf-8?B?NzRXYkN4R0tMTmRjVFBhczYrLzhoTzI1bzdoQ3ZldlJpbGc2SlVHWmxmMVF5?=
 =?utf-8?B?S2ZtbHk3WW5xTWhxUm1WNzZlcTNFR21BakNLRFBLaGtTbHIwalJQMVZRSm5N?=
 =?utf-8?B?OGNjbisrem5XZjRpUllRK1NaN1hZdWpENDhMRXQwdEgxcnJyU0VqakZsZ2dl?=
 =?utf-8?B?aXdkSkdCdEtSUzNaY2ZEc3REbW5mNFE0cC9nb2V3aTlUT1pRUlliQy8vVFd6?=
 =?utf-8?B?Rk0zT0lpNnBmUG9qZExMOWtEeUV3UDgvUG9YYW9mL2FSM1FHaXJka1NvWGFP?=
 =?utf-8?B?SS9iMHRVd0NodGxKWFlJblB3YjFzaDM2THExZUFYdE9wVE9rTHJJUVB3eHBy?=
 =?utf-8?B?TUR5eDB0NWcvTXRhTW1yUTZadEdhK2htS3RTbjQ5QnBESEpzd0xwQVRuOFhh?=
 =?utf-8?B?ODV2WHo5aVF0Y1YrWjhkWCs3VFI1UDN6T3Fxbm1QSG13a0xkb3Y0ZHhPeTBO?=
 =?utf-8?B?dWVpSVhwUjVpMGRxUXRoMml4VEoxL0xGQ21vNjdDbVYvWndVQ29kTVV6QUtw?=
 =?utf-8?B?VCtHSEd4bnMzNU12dHZqMDFaUzVEeDBVQW1KNlJZWGRwYU05YnNabU5NM1Z1?=
 =?utf-8?B?QTJFY2RhekkvSnRpampYQUhVVStiQ2tBYVROL2xLeUQrQWwzaFIwZkRsQjFs?=
 =?utf-8?B?ckNUeDMwa1czNUgrbFVrK0xSczlsdnl5bzFETUQvVXlkcWFXMDFEeXRFN2x3?=
 =?utf-8?Q?7bMJxu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:22:39.2971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f4751b-783f-411b-015d-08ddbe6df2f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680

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
v15: Updated the changelog.
     Moved resctrl_bmec_files_show() inside rdtgroup_mkdir_info_resdir().
     Removed the unnecessary kernfs_get() call.

v14: Updated the changelog for change in mbm_assign_modes.
     Added check in rdt_mon_features_show to hide bmec related feature.

v13: New patch to hide BMEC related files.
---
 fs/resctrl/rdtgroup.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index b26baca389bb..d73057b96d1d 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1152,7 +1152,8 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 		if (mevt->rid != r->rid || !mevt->enabled)
 			continue;
 		seq_printf(seq, "%s\n", mevt->name);
-		if (mevt->configurable)
+		if (mevt->configurable &&
+		    !resctrl_arch_mbm_cntr_assign_enabled(r))
 			seq_printf(seq, "%s_config\n", mevt->name);
 	}
 
@@ -1801,6 +1802,36 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+/*
+ * resctrl_bmec_files_show() — Controls the visibility of BMEC-related resctrl
+ * files. When @show is true, the files are displayed; when false, the files
+ * are hidden.
+ */
+static void resctrl_bmec_files_show(struct rdt_resource *r, bool show)
+{
+	struct kernfs_node *kn_config, *l3_mon_kn;
+	char name[32];
+
+	sprintf(name, "%s_MON", r->name);
+	l3_mon_kn = kernfs_find_and_get(kn_info, name);
+	if (!l3_mon_kn)
+		return;
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
@@ -2659,6 +2690,12 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 			ret = resctrl_mkdir_event_configs(r, kn_subdir);
 			if (ret)
 				return ret;
+			/*
+			 * Hide BMEC related files if mbm_event mode
+			 * is enabled.
+			 */
+			if (resctrl_arch_mbm_cntr_assign_enabled(r))
+				resctrl_bmec_files_show(r, false);
 		}
 	}
 
-- 
2.34.1


