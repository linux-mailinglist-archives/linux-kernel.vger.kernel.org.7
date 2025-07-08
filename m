Return-Path: <linux-kernel+bounces-722465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F301AFDB00
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905A34E33E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D50A2638BF;
	Tue,  8 Jul 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vmonIOPF"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CDB267AF1;
	Tue,  8 Jul 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013303; cv=fail; b=jLmUDGsfj+2wmIhJUup2+cinUQGc49smkZ29jMnVXnzRE9J9inb+1hi6DsVjELiLEIk+lgKTBKYgFYNfDMpg1ZBOzqgaxx1UfeixRfY4cJ0SxEiGCema6EFlfQmDcqkljFmK0+WFZrO+pZG0xygJ16KFis3E2IKxCFyzzAIgZ5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013303; c=relaxed/simple;
	bh=/cOvwu0tSsYz4SEV1uxpjJ+niaGXFdLYtbozeKKBAtA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Offr/evxw+HdCbIy2vk3DBV2/giC6e/G81bDXh3zgEs93+Cg96QJ07t5VJ/5ClUlXh3YDuHVdaHwebnsExZNF7+WhKCT6mfEwGWly2ds0Yx2X2AUAl+Q/tOYdqxFS+XstvhjDDkHWSQHIFMjW1j/Dddo5PBf4GnjMRGLazmd6yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vmonIOPF; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxxMWrKcmog3I2uvIDUJcDP6DmK1emxzoXze3SbvFiI3QK1NjxOsm72+02k48+jP9P/GwvkM0Egs8uSh431Iih+HJoMcac+tJixXuNaFRvfETNnQltYpU6qBsBS249/1Conbzbi8h451fAASYwu4CrR3w4T+45viXuz5iuAoIDoua3dtMO6HaHyjMwJ9KjDMDNWjggcPUKfe+YMGjex74BylLh2OuMIk10ligs3m+aA3WkbDX7Dd0pfuubIshcQlEE00XlzME4zUUJvTSKsCrPpYdNsJZ7qBJqTr2aaNhB7hj/wfr9OrxDds5nbRGQiKefdSj6B8d/r2IsYgDdxuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgzaQS5Hhgkc+DVBgvgiSQpVH7yuna6SflXnxgyJ/cE=;
 b=LdUbnwamb0MZ7g8vAEDkKtjjrTeuh5Xpk1P5NluAsb5F6SiZ5esAkyyM8xRopzOrDKpmzfRvNlCb41ZLfq3DHoOmEV4Went9Y7vNilC/OkDnYgNj97pWKVu86A/DOtY0Upi1gGNavzb1vILg2L+g2ft+43SzMy75gXRLMCiD736toDS2n4WvV5+50mq3XBt5mzwcZjUSLo7XNJmGlA2lbRRqSfk60TSiSDjNKb3RXN/bwpd+legrk160gFDtNMI+P6jaCfBTobkCan1Rvbu1KCjMlK1Nbn7dMakl4DrRemhomHaMvxwY1ixB8hvJMyYeB9XL7lWkSrc5p3KZGRkW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgzaQS5Hhgkc+DVBgvgiSQpVH7yuna6SflXnxgyJ/cE=;
 b=vmonIOPFGgycmdLtD3WGaIwsINVtrUGA05a1tQXPOEcOon6jVJO+h2WzHwxyXVLhDIB/pPB63ZV3q/prud6yxDrhwMs5Jx2AXr5jdLdMudYt08rAr/uyRejIUPCHS6xNCnnO+glpUMNDozuZH27lS0UgF/2N/4ThKgZYDN1wS4k=
Received: from SJ0PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:2c2::10)
 by CH8PR12MB9791.namprd12.prod.outlook.com (2603:10b6:610:254::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 22:21:39 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::13) by SJ0PR13CA0035.outlook.office365.com
 (2603:10b6:a03:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.19 via Frontend Transport; Tue,
 8 Jul 2025 22:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:21:38 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:21:35 -0500
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
Subject: [PATCH v15 25/34] fs/resctrl: Add definitions for MBM event configuration
Date: Tue, 8 Jul 2025 17:17:34 -0500
Message-ID: <4a08cb0b35f3f7aa759cad20cea0733f9480cb34.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CH8PR12MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc6e3cf-111a-49f9-e290-08ddbe6dcead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O7869brKGXRa/nBpBtPiPIae0wTnC+gND6MILz1kejGCP2iO3b4i6s8T48AW?=
 =?us-ascii?Q?+C/cYPy6DDX+SNhDr2M5poypYl6hjhtklxAdrWmhA10evGaHlMMC5ismM4LH?=
 =?us-ascii?Q?1VWAZS5KH7xgz2X815v+/QofQ3s3d6rxyPeDILaQoA2DBLq522BpHXdVdMP4?=
 =?us-ascii?Q?vgi0uVntCQYUXdPh8hkAExN79MDnQx6Q8s9kd3EHLMUWfTA+hUF0XPSOKjvH?=
 =?us-ascii?Q?Dyvd/mWfz4njIy5GE+czHaFtg5n89uZ1pKeQMWH0n3oj+bZOrwkRX1KSbR2/?=
 =?us-ascii?Q?B8Hx0VSPvPaf2KdXs2nqVi6DUXhCcfDQu4td2bc/3BMAXlPzyKH/ssolwJj/?=
 =?us-ascii?Q?lN58YpbbxyoDbqA0rSRL6cFBnlv7quAFGet6GENaxvvj0/XSRH+oAgehlJwJ?=
 =?us-ascii?Q?qsuy12dWIGCWoIG5gctESmYUfdSflcbaoB0wq55r7SjPTEN60Amke5981lPG?=
 =?us-ascii?Q?bodNcOEwMG7hrXlaM1EJFJKnorZ3SPnDmDGaoAwRsmbQ2cG8DckjHMG+IqZu?=
 =?us-ascii?Q?9/WRfbsZJoXV7nfSZd7Mie6n6KdQoVPfc03kbSXXtvzjMqGjnrwPYpg88EVO?=
 =?us-ascii?Q?O00uNFhZ57FmE1z3BsNBVZTHnpZzncC4RMGuhg+34Hjonq+LTgKBFC1nzC1E?=
 =?us-ascii?Q?lyDV7Zn60SaW+Vp2pL125MD6f2r3KIgManlKRK1C6TuHr1JiJBtErPqKsRQ/?=
 =?us-ascii?Q?dkvaBdztGQeo3ZovqLY9ryuIWHxrBXL+HNrv0oMeW96dSHFj51iQYEAvMrFD?=
 =?us-ascii?Q?ds70wB6T/1yzQtvI1BrBBu1+ssX1d/2KI+FWaJVfDvZu3NzKnk7YR5K7pezh?=
 =?us-ascii?Q?HURZQhokZHL1FTqpYYsva7nP8k4xrn1xxMCb8ieyM0c32QS52Wvi6Sq+Wzaj?=
 =?us-ascii?Q?+cQXknkt1WyBtbZa3yX3fENBydWrSKB6PvSGPAe86sxvA4P1PbgwfXb3RxrI?=
 =?us-ascii?Q?ZJ/SiJoOQ/Y4KYzFV+DGzhqgDpz3HWPoirg2Ks/S9m1XS/dEuEW6C3e4daku?=
 =?us-ascii?Q?8fU2EKG9b0cY42iAZ+5rvSUiA6PoNAGCdXgeoHAlvy1m6ducWr4neWkFNJxD?=
 =?us-ascii?Q?SK3ANuLPHfhRxIlN/mJZqfPh6NnN7Cg5fsq/MRJGehooJPQMxNjv3jkzpET2?=
 =?us-ascii?Q?KacqOxICJ3SxRWI/U/Ot40UoEuyDcFN1mnGAukhgvq5EaMSvuP8X6+rtfzk7?=
 =?us-ascii?Q?TlEfg8grvwjcB3C2WOQ1cp6GhxxHTjTbg2yp+39GX604dYTxoNhDzg58m4+S?=
 =?us-ascii?Q?vBqLDlAcoicTYd3VrOYGPug2ViUA84pFTmgQ2uIpUpZKPFTYRd1eiJnD/pmj?=
 =?us-ascii?Q?usgRhKDdb4FiNHcKgAQkuCw9YeuV0eVZ+wKKtCXg+cy45toKHShAO2e1lp7R?=
 =?us-ascii?Q?kx28MeHoybLp4EHOUUmbHXUOKpj/zTvW6rh9aiLP6gHCYxCNnXufGXdGCetz?=
 =?us-ascii?Q?rR1lQXtrZWrZHJ7vIIO1hpnKqwMhiPrG5MetX9flHmIEgI2XuuaKqbkG7NCA?=
 =?us-ascii?Q?pAmyohwEwxrYdHXRYCSzjIVdp/9m+hDspuoQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:21:38.3350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc6e3cf-111a-49f9-e290-08ddbe6dcead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9791

The "mbm_event" counter assignment mode allows the user to assign a
hardware counter to an RMID, event pair and monitor the bandwidth as long
as it is assigned. The user can specify the memory transaction(s) for the
counter to track.

Add the definitions for supported memory transactions (e.g., read, write,
etc.) the counter can be configured with.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Updated the changelog.
     Moved NUM_MBM_TRANSACTIONS to include/linux/resctrl_types.h
     Changed struct mbm_config_value to  struct mbm_transaction.

v14: Changed the term memory events to memory transactions to be consistant.
     Changed the name of the structure to mbm_config_value(from mbm_evt_value).
     Changed name to memory trasactions where applicable.
     Changes subject line to fs/resctrl.

v13: Updated the changelog.
     Removed the definitions from resctrl_types.h and moved to internal.h.
     Removed mbm_assign_config definition. Configurations will be part of
     mon_evt list.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The rdtgroup.c file has now been split between the FS and ARCH directories.

v12: New patch to support event configurations via new counter_configs
     method.
---
 fs/resctrl/internal.h         | 11 +++++++++++
 fs/resctrl/monitor.c          | 11 +++++++++++
 include/linux/resctrl_types.h |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index fb4fec4a4cdc..63526400e632 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -216,6 +216,17 @@ struct rdtgroup {
 	struct pseudo_lock_region	*plr;
 };
 
+/**
+ * struct mbm_transaction - Memory transaction an MBM event can be configured with.
+ * @name:	Name of memory transaction (read, write ...).
+ * @val:	The bit used to represent the memory transaction within an
+ *		event's configuration.
+ */
+struct mbm_transaction {
+	char	name[32];
+	u32	val;
+};
+
 /* rdtgroup.flags */
 #define	RDT_DELETED		1
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 35faca7ff3b1..1670163649e7 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -920,6 +920,17 @@ u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id evtid)
 	return mon_event_all[evtid].evt_cfg;
 }
 
+/* Decoded values for each type of memory transactions */
+struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
+	{"local_reads", READS_TO_LOCAL_MEM},
+	{"remote_reads", READS_TO_REMOTE_MEM},
+	{"local_non_temporal_writes", NON_TEMP_WRITE_TO_LOCAL_MEM},
+	{"remote_non_temporal_writes", NON_TEMP_WRITE_TO_REMOTE_MEM},
+	{"local_reads_slow_memory", READS_TO_LOCAL_S_MEM},
+	{"remote_reads_slow_memory", READS_TO_REMOTE_S_MEM},
+	{"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
+};
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index d98351663c2c..acfe07860b34 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -34,6 +34,9 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
+/* Number of memory transactions that an MBM event can be configured with */
+#define NUM_MBM_TRANSACTIONS		7
+
 /* Event IDs */
 enum resctrl_event_id {
 	/* Must match value of first event below */
-- 
2.34.1


