Return-Path: <linux-kernel+bounces-746177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97CFB123EA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0E116A770
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAC52550CC;
	Fri, 25 Jul 2025 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p+Cps2go"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE699254864;
	Fri, 25 Jul 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468363; cv=fail; b=Hc+AG69kEfuHTGdxQUlV3P0IyyLWcH164DP+h+qWuNgK75pJUjYt+sVUdT84C53CP1+CbTEk4wBw6GymO6TwAmDE8OziivOLYDZHv+/VycGCFkJRirbTvp5tssy5jyotnp0EXCmxXK2QjuB/HjNiIiTnTnP0HjyIoX98HXDvXqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468363; c=relaxed/simple;
	bh=WJyYblKy+ddvhJQ0Qva/5p3LtXCkk3lnu/DCMQNuPhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juC4eLlS/fuR/gqPH3Y6oWixC41PQ42LcdNdcOZEVrNhloGtjYdDed9x79dmq077ThchIdcrkxwFfuqCdfITbv7iUBHnt+0iF0OjcKUDmiTcS3SsNCcQbeKJsumUZiagnQAV4vMutodpmHEePWTWht1H6P8YHc/fDXA7kE72o3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p+Cps2go; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8nFaMr2mXMmmQ5m7CZTG9nAIA+RLJB7QabWCwdenAyMqY8DMVSK5NDnDunBysgFM2ND0FBLEQORjOIkW0FMxiBtGX/14IOgU3ohih1WGxZmTLnR92LNtd/uiNQ8YtSaAgRhG4JykryP+DEvNfRC8JIGUeBlw/XWUVjOoxHcWRS8LyB18WVyfzmYBS7p22Ez2O8cyiUf65WjJDZ7HUf59GrGWkxXitnzC7xJiA7QWs5yXBBacBrBsasibMKvMLMcAOrFA1By2jkcEM6Tfa+679LNNQahbgGPDvSSoXuwrwLoJ6RWdD9zZ+fckiTOxVIi/X0RnKr66p4Tg+XbktGD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxIlwY8lnMP8NxETCGCi2aCSKXQcbDe9K89Hky00SiM=;
 b=qP42xRtxqGbysRLAH2Bvnsvofo4d9KVUiMmpIB0Snlx1LC6UhucmsOvrkappVqmJtEe7GqUQBubiNcbnqfs09EzmiiiJtmDa8nWJDBfuFRWUE0yy1kPhhp6LrLv918SokcF3k03vugFlCJxjW8cHFlkbq5Plu+uyCH4caUocYCs6XIjCitDDmQZmBVSfcDDaLBYTC6IqJoSBbDTUlMXCBs1sqZ4kw7m4JudRCukBJMu5AJk5APkkuIpRz1yTG8ZpgvtZnToCiG5uZxxYbYLoBCiOCl2JS/Tjm3l6gw15YLFg9PdAKIF3LzOu4qhhqz95U69SJgh3rCxcHe1LpqYmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxIlwY8lnMP8NxETCGCi2aCSKXQcbDe9K89Hky00SiM=;
 b=p+Cps2goDLVy2QIQWTQlv646erqwlcPmKNjI2D+dU1P5CfCMHBuKujiTV1D0rmoTvK5rEHKkSWxk/50MLbkjlMeyijQmLYmqw2HggEbUyeGyI5DTg0MIuLDRVp6dChD18OoxTs0c6pQNf4GjdJuqYS1b6Au3aQ/ks6BGY8i7nk4=
Received: from DM6PR08CA0035.namprd08.prod.outlook.com (2603:10b6:5:80::48) by
 SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.22; Fri, 25 Jul 2025 18:32:38 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::d9) by DM6PR08CA0035.outlook.office365.com
 (2603:10b6:5:80::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 18:32:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:32:38 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:32:35 -0500
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
Subject: [PATCH v16 14/34] x86/resctrl: Add data structures and definitions for ABMC assignment
Date: Fri, 25 Jul 2025 13:29:33 -0500
Message-ID: <300b8b39e670546cce44ee4d079a0b1d6e6386ea.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b7c5ca-8c5d-4050-8139-08ddcba9a213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1ROZWFOWGxmQWZRQmJjS3hUYUEwVW5aQjR6a3JQNFBSa3d5WVVISWtmd0p2?=
 =?utf-8?B?QmJubkZpUzZlaWh1WVBCbisya2Y5VkJkZ2JNSWRPSklZdC90dnVLZjhyQm9v?=
 =?utf-8?B?VEpjTDl0cVZUTW8xSHdUYUNrcHBuY1RLanNaNXl0L3lZRW56cXVyOUk3dXdp?=
 =?utf-8?B?T0ZEMmthYkRJMjlQeGM0WXZiM0hzZ3IwM0J6RjRoa25WR2NHaEhiQmpZclB4?=
 =?utf-8?B?TE42dW8wWGtTVk9sajVqWEF6dHJWZnphVnlUNzQ0ZEpLQXlVb0psL00zd3Zz?=
 =?utf-8?B?RnFzZkt3VURyQ1JKWm0rdklPTlpnaGZHMmZXQWJ1aDNRdUZVVktIQ09rbnBv?=
 =?utf-8?B?bTVyVjMwdHp6ZHdyWnZ5OGlGRTVTQXdWbG41akZlMSt6TVVoM2tqemxUZWhY?=
 =?utf-8?B?UjA0UENZcWRsbVhFTGtyYjBXQ0dGSHcrOXJPdUtuSGhwb1BRRnhDUjI3Z1dj?=
 =?utf-8?B?aUtGcy9rSVlTQUpjQndEUEpTdXVCNmRTcEJkV2RUQ0tzMXNUUTFtZUZrZjRK?=
 =?utf-8?B?dUVQbU9ZRFVES2k4c2pyakdhSURvZFRWTUt2cHp1ZVlNVVo2dmVUbUx1NXRy?=
 =?utf-8?B?T3VIMDVFekFWL0JCQnNTbC84TTNYcENJdWNNeW1rTERZWGY1STdldStmVUZN?=
 =?utf-8?B?TE83STBpVzFZcStPZjNyYWlzNU5mT3AvUCtGeExmR25KZk1kNEFoRXZJYzdl?=
 =?utf-8?B?UldPVEVLOGE1YkR4WDBiWEhPZEdsUm9TL0dLNDhURHNKS1o5dWczdS9QZVRi?=
 =?utf-8?B?bnBnaHRIWGZYL3hKalN1WEluTldOY0N6M00rUENCVFhlUXA3Qi9WNHBnQjZB?=
 =?utf-8?B?TkozOGdVdml3ZmlmQ3VPMnR2TEE5MExJY2kxaWNMNmVxWmxnR0dEM2NMNlJN?=
 =?utf-8?B?NVNWQWlqOExsbFB1dnZGdGxxWjlmWDRhcW1sWFB0WHAvNktldFJCcC92dVI1?=
 =?utf-8?B?Z3B6Ny9mTWppUDduVTZmNGNzMzQwUzdxdGk4ZEJQS08zWEFZQnZJWHc2U2p3?=
 =?utf-8?B?RXFkKzFadEFCK29uYjhTQlJtcVJHWGloY3NZYTdTUmUvU2Q2bVZiWmMxZllp?=
 =?utf-8?B?QmpQbUdqQ3pnclFoQUpQc3RzRS9xeHl1SmUvbWxjWTZONDk0czVTQnJscyts?=
 =?utf-8?B?b240WktlRnp5STNDSld5UnNxcjNMcUwxbVhkZVJkR09NV2pacTkzcFF6a0NT?=
 =?utf-8?B?NXh6Nm5NalZPK3RHVlRQMFBtS3Z2L3R4V1JON1RZTWhXeXZSQytCelZhczQ3?=
 =?utf-8?B?MGV5eTBValdKSEREd0hLVmtleTJ6K2tDMHVndE5qdkxUUXdneTZra1p6Qmh2?=
 =?utf-8?B?VGc5eEhINmJMVENXV1RYQkkrRCtQamxZeXR5RTJmYnYwRGxIcXE4Y1RNUElN?=
 =?utf-8?B?UEZMOG5GU1UrVWJBYzdmdytlNVRQd1RzSE1EMzh3ZVFURVpmdUJsWks0aC9K?=
 =?utf-8?B?Zm9lUnVOSjdPQmM3ajJvZ2UxdU5TQ3hKenMyZHNwQTgzTGNOWEJtS1QxRWsv?=
 =?utf-8?B?N3JVS3VYWFJIU0RwenIxOU5hMnBLZEFXTSsybDVoSTl5dXlHV1hKYXVzTVJE?=
 =?utf-8?B?am9zelFoUlNZUTYvZGs1WVkvQnNDUVluZWVwOGtYclJ2WEM5dDJtNGRyOXNN?=
 =?utf-8?B?WkxESUNNd0crNTV0NXFsOXViTDh2eFRYdnR2NW1tYkRXT00zTnVkSk4wWWZX?=
 =?utf-8?B?bldyTHI2Ui9vdHdBQXpEcjdLSkZ1M1phOUl6ZmdNaURjRERmalVRc3FXR0lU?=
 =?utf-8?B?b2V3TjluckJNTENoRWxuUG4wekorSDJLRE1iZHVZSDRUU2ZkcFpxT3hya2lz?=
 =?utf-8?B?N2QyUFZsUG9aNm90VzFGNHRNY1hHZ1JKNWgvUFN1eVAwUnJRb09hNjRsVEcz?=
 =?utf-8?B?TmZZUDlxMVJnLzdkUnR0WTNiTXRJQktTZWdEZyt1N3lEMDhLNldIc1lBc0hQ?=
 =?utf-8?B?WmNqczd1VTI1bEtzREVmSmkxYS9WeVlJNWswL3E4amNicHIrdWtWTmtleExE?=
 =?utf-8?B?RnlwS1FtNzcwODhqNGR0TXhWSVpFbld5M2pSMThWcFZCUGVFaHp0NGxBLzZX?=
 =?utf-8?B?WlUrbTdQRFFCanNqc0xHWWc3Q3BxejRzSFU2dz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:32:38.4690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b7c5ca-8c5d-4050-8139-08ddcba9a213
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400

The ABMC feature allows users to assign a hardware counter to an RMID,
event pair and monitor bandwidth usage as long as it is assigned. The
hardware continues to track the assigned counter until it is explicitly
unassigned by the user.

The ABMC feature implements an MSR L3_QOS_ABMC_CFG (C000_03FDh).
ABMC counter assignment is done by setting the counter id, bandwidth
source (RMID) and bandwidth configuration.

Attempts to read or write the MSR when ABMC is not enabled will result
in a #GP(0) exception.

Introduce the data structures and definitions for MSR L3_QOS_ABMC_CFG
(0xC000_03FDh):
=========================================================================
Bits 	Mnemonic	Description			Access Reset
							Type   Value
=========================================================================
63 	CfgEn 		Configuration Enable 		R/W 	0

62 	CtrEn 		Enable/disable counting		R/W 	0

61:53 	– 		Reserved 			MBZ 	0

52:48 	CtrID 		Counter Identifier		R/W	0

47 	IsCOS		BwSrc field is a CLOSID		R/W	0
			(not an RMID)

46:44 	–		Reserved			MBZ	0

43:32	BwSrc		Bandwidth Source		R/W	0
			(RMID or CLOSID)

31:0	BwType		Bandwidth configuration		R/W	0
			tracked by the CtrID
==========================================================================

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v16: Added Reviewed-by tag.

v15: Minor changelog update.

v14: Removed BMEC reference internal.h.
     Updated the changelog and code documentation.

v13: Removed the Reviewed-by tag as there is commit log change to remove
     BMEC reference.

v12: No changes.

v11: No changes.

v10: No changes.

v9: Removed the references of L3_QOS_ABMC_DSC.
    Text changes about configuration in kernel doc.

v8: Update the configuration notes in kernel_doc.
    Few commit message update.

v7: Removed the reference of L3_QOS_ABMC_DSC as it is not used anymore.
    Moved the configuration notes to kernel_doc.
    Adjusted the tabs for l3_qos_abmc_cfg and checkpatch seems happy.

v6: Removed all the fs related changes.
    Added note on CfgEn,CtrEn.
    Removed the definitions which are not used.
    Removed cntr_id initialization.

v5: Moved assignment flags here (path 10/19 of v4).
    Added MON_CNTR_UNSET definition to initialize cntr_id's.
    More details in commit log.
    Renamed few fields in l3_qos_abmc_cfg for readability.

v4: Added more descriptions.
    Changed the name abmc_ctr_id to ctr_id.
    Added L3_QOS_ABMC_DSC. Used for reading the configuration.

v3: No changes.

v2: No changes.
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 36 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index c998cf0e1375..3ad7f37b8ad8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1222,6 +1222,7 @@
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
+#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
 #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a79a487e639c..6bf6042f11b6 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -164,6 +164,42 @@ union cpuid_0x10_x_edx {
 	unsigned int full;
 };
 
+/*
+ * ABMC counters are configured by writing to L3_QOS_ABMC_CFG.
+ *
+ * @bw_type		: Event configuration that represent the memory
+ *			  transactions being tracked by the @cntr_id.
+ * @bw_src		: Bandwidth source (RMID or CLOSID).
+ * @reserved1		: Reserved.
+ * @is_clos		: @bw_src field is a CLOSID (not an RMID).
+ * @cntr_id		: Counter identifier.
+ * @reserved		: Reserved.
+ * @cntr_en		: Counting enable bit.
+ * @cfg_en		: Configuration enable bit.
+ *
+ * Configuration and counting:
+ * Counter can be configured across multiple writes to MSR. Configuration
+ * is applied only when @cfg_en = 1. Counter @cntr_id is reset when the
+ * configuration is applied.
+ * @cfg_en = 1, @cntr_en = 0 : Apply @cntr_id configuration but do not
+ *                             count events.
+ * @cfg_en = 1, @cntr_en = 1 : Apply @cntr_id configuration and start
+ *                             counting events.
+ */
+union l3_qos_abmc_cfg {
+	struct {
+		unsigned long bw_type  :32,
+			      bw_src   :12,
+			      reserved1: 3,
+			      is_clos  : 1,
+			      cntr_id  : 5,
+			      reserved : 9,
+			      cntr_en  : 1,
+			      cfg_en   : 1;
+	} split;
+	unsigned long full;
+};
+
 void rdt_ctrl_update(void *arg);
 
 int rdt_get_mon_l3_config(struct rdt_resource *r);
-- 
2.34.1


