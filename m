Return-Path: <linux-kernel+bounces-770004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2686BB275D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782FEAA7858
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFE22BDC2E;
	Fri, 15 Aug 2025 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bOiB2PPm"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC52B634;
	Fri, 15 Aug 2025 02:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224880; cv=fail; b=cxhqPnSJMIlGY6RF0OWURW7GB+4F05w3GBg5UILiyGSEnZpmq53I6Vwd3RvwwjZEtMxQi3/CY9FTjhOxqjZjR/uqX99aSWt5uGGTqa2WiCFvHp9CHeCAJUCjYQ6C4/LarLwLAhtzxkwsE9aq98IIItxPYJCIXy17EZwFzf1eJjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224880; c=relaxed/simple;
	bh=n0W/COCCfYYn4DzjrZFXPmYU3jgB8Os6yVXZiUKQ84A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzB3YYuHjZgL7bwKJzw2WVbQxYFGFVMSn6qlPfkADLQNUllk92j1LoLjZz6tAvty53ButZQ1WTdS0X+l5jFlbbFRH6Uf+fUlWpcJV6Y+yqDeMiY5shFRlsWhYBr3XgoL7ihXDRl9//OKCgky7LcTIdfaVexNUBWAmcabJgqFtHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bOiB2PPm; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INlIIzbzZVuTgML6Fm4fzKGKHMEb9Kgx8wyFZvJHYrB+tZwV61o5WK+ggjizcNNUWMzOawTpm1WTptoQCQAGQ/gunVoiuw5kdO54TTEijdc7PjMQq6Wm7FMtf/cVjQ8kI15NJNI2YisNoQCOh5pE2C4iQJG/VIFW5CMTiNzIZ0ZkrA4NJC2DWdqPTVOqb6qoEmKoUtzbi7pDvfEuRwANgpIjsP48Mq6nXIHDeMbD20AvvGzooWGZBhSG2HCOFSBsNhGpcHiw7oQ6nDUqoC8TIjOZ8SyX5dzidSaMEcQUJi0uN01fpRjjEyPKpNqp2j8xvSOLrgeMDUJMHf9ELxSgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJoX4s9/U7XHkoI1sak89dFEeLHZMbUmK7cVCRpzhuE=;
 b=b5iCbn0HYRGtzrGzuwyu95/e/D3i4zCJtHUnSYlewJaDRWG3uEwhEXzVpmhTvSTJ7cwvO7F5OLhN3ALdaQuxoaBJvxYLJZ/Is1zxrfbr3z1+bndhIMghoAcU86O7nq+r7CpeRxuDj9sA1Go4Z3Z2nK4QBnS5DUNiIZYOEuS7K99J/iUJcYCJYBbrssvMceLlmFZham+T/NHEhQRhEbeZ07EDrXZeOFHU81ijWmFbkuvoHezEu/sNizK1Ps+2vTYXtWZ7aOyHdtkB7thUkNRnKH/lrhhMeV1meEoUwsYHjRAkGCnDFQGoxd4mAbMeCR+Ca9SKFTtUfvdyPA2/v2zHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJoX4s9/U7XHkoI1sak89dFEeLHZMbUmK7cVCRpzhuE=;
 b=bOiB2PPmKJs4Dd7Scn/17LkvCHjbEMGt3xe3Ap+r94OaiPt+xYAIxAS6ubjbG1+NmQAqUwAgZHeOuU+iGfG2D435m6c6c6wxRDJfrQalFDmKQeYv3eeCKdhucixJuxvwqvTvKm+XUAyUhoVMUK/ZYOWT/jiEmeoyUNH0GE8E0p4=
Received: from SJ0PR05CA0164.namprd05.prod.outlook.com (2603:10b6:a03:339::19)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 02:27:52 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::d3) by SJ0PR05CA0164.outlook.office365.com
 (2603:10b6:a03:339::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.6 via Frontend Transport; Fri,
 15 Aug 2025 02:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:27:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:27:49 -0500
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
Subject: [PATCH v17 14/33] x86/resctrl: Add data structures and definitions for ABMC assignment
Date: Thu, 14 Aug 2025 21:25:18 -0500
Message-ID: <17fa2819e4bd6b6fe893570cb4b8a5173722bb3b.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 895cdc41-02a2-4424-2c7c-08dddba355f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWtML041Y1I4L3AzU3lKaDFwT2gxTGlwelIyaWQyamlPbHhneml0aEpha2dJ?=
 =?utf-8?B?dFBCV2s3cTlicmt5dG5WNDlERlJoMkpmcW1yU250c2ZlOWlOOUhCYVZROHAz?=
 =?utf-8?B?K0tGMWdyWjhZMmxGanYySWFpem5mODMvMEhKOEV1RjlLUlYyZldUbDlDNkNT?=
 =?utf-8?B?V1Y4Nk45N0ovUVU0OE9VSWl2N0NHR05XenkvNGRNWitqa1J2N0JXbXpzVDJx?=
 =?utf-8?B?SkwxVjZ4MkV2aWFUUGVnc21uTTF5dkpVNFQ1dGlMRnplQ0ZwSzFDUnRhczJB?=
 =?utf-8?B?d0JnMml4QUltUHhwMVdWV25qZlNQb3FtYy9nMzA4WU1acjk5aCtZSkJNYmVE?=
 =?utf-8?B?ZFdqNFE3NnBsNmQ2RWlaUDR1TmRSUy8zUEhtWkJaVitMaHhsc0V5S0ExYmFH?=
 =?utf-8?B?ZzdubDlzd1lQaFo1dzNCenovTnNDOWRjSVdkNTRwL25meFNBckNiOSszZVhZ?=
 =?utf-8?B?T2ZYY0hTZUo1Q0RvRzBtdUxiajh1dHNtSlNOUHpTWG9xV3diV2lNeGtLbzl6?=
 =?utf-8?B?aU9RdWVYaGlVQzBrb2t0US91WGxLa0ZtWHNkR2lkSDhYV3VpZjJ4b2lOQmht?=
 =?utf-8?B?cTk5RDJ0Z09semVLc2ZOcGtabFpTUnR4Nk5FUWVPRXFjSXJBQldWQWoyeXF1?=
 =?utf-8?B?Q1RrR0xXM2RuaFdhNnliZDZHeHVLN2xNdVJaQlN5VnhqQ3IzS2ZGdUZmc0FV?=
 =?utf-8?B?RjFudnVMclV1VlJab1ppSVNSUnVjeVBTc0N2bWMvaUFjRmxHeUxKeDd1MjFK?=
 =?utf-8?B?NXRzcXV2cjk1UjNJdW1BQXZtV3J3S29ER05DU0phZzJqQ3h4VXhNYmd2RmZn?=
 =?utf-8?B?cXJEdWMvbmYzVU8ydzI2NDgxbnZabkZYczh3MFZmMFB1cnVCcUtDSHpZVjA4?=
 =?utf-8?B?ZVdGRkJ1YW5xd1Z2dzhWVCs5cCtzSEpRUnZCOVRoQXlBV0o4Q0NHSFY3WGF0?=
 =?utf-8?B?SXBrMXJIdVNxbnFOTDlBQ3BNTHEwL0RBamRwakEvcHBRaS8xNTc2bVNRQ2xT?=
 =?utf-8?B?aW9Xc3VjTUtGSEJHa3k2QUdzaGhmS1RpVW8xQ1BOZDhMV1lpbVVETEhKOE94?=
 =?utf-8?B?ZGxnY1R4WE5UUytlTDI2VTBUZmp3WUNaVWxCaElXbEgzT21zSVBNMnFTaFIz?=
 =?utf-8?B?amJ4SCttY0Vaa3NueURrc1d4aFlReWgyVDYzaGVOTFRoMTZjZjVWRlhybmwr?=
 =?utf-8?B?blYzemVGa2o3QWZoWitPV2pIbUwyMC93MHluODJyZnJnMmpBTkFQOHFWdjVs?=
 =?utf-8?B?SlVuQk84aXZXWVBvSVQ1aC92d0U3M2MxTEtjQ2RtOGlZb1lhVGtaV1BCbEJT?=
 =?utf-8?B?elk1SHo1QW8wZG9relowZGU4UTNkWEgzb0x4Y3lta2UxLzNJd25rNG1wY20x?=
 =?utf-8?B?eklFNU5kam1wc2tBSmFUR3RLVVhrTkQ5RTZjQnRxVXpXNXhIS2RqNExqdDFY?=
 =?utf-8?B?MVpyMlZtYTUzWFB3Mk5uZTZYNTNjZXlYZ1NoMVVxZWdCVG9BaVl6aytMWTB0?=
 =?utf-8?B?VlA3cnY0WFY1S25RQVVVdW5lV0IwUmZYQk9wcmFPcUZaL2JsN0NIbGpYYVRK?=
 =?utf-8?B?Mk1VQnhYMUJZQ1NIRWRzaWVuOHIyZ0VKbHM2dUVUTGxSbW5HbXBsdDcyaXpv?=
 =?utf-8?B?aVVlY2dpaXBtaWsxS00wSnhUcUlscWIxKzFqNzdld2RHTEN6aVhSNnBxSjFv?=
 =?utf-8?B?djRicnpxSlBRV1JDRnorS0RVY3hvTVNXWGZ3TktzTkJ3S1pXZHhOL0p3N25P?=
 =?utf-8?B?MFJQZEliN2oxN21hWVJtWnZHODh3YVJvRjQ4Qk80UjB2OVdVWTI5S1hiTVVY?=
 =?utf-8?B?WmlYMUhYNGhXRU1oemkzSzZ6NEl4MXRRajlkZk4yaVJEemN6bWRka25SbHVy?=
 =?utf-8?B?STN4dEtXaUhHd1ZNMjJ3RVZLTkw3c083MjN0ZW5WVXU4ZTFBb0h4N1FQWkZZ?=
 =?utf-8?B?RjBXRmJzTlk1cUdLOEJ6T3N4NzVNZnRJdTFlNWdqOThZODVvWXUxbEpHVjg3?=
 =?utf-8?B?RDgzMFdma3JycmVSUHlJRDEzVGRlY3dCbHBYbm5aTlBXTmxTcXFrWjBvUk9y?=
 =?utf-8?B?bmtDQXowcGdPcnJ1SEV4OE1qMzdaUEduRlhIUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:27:52.3412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895cdc41-02a2-4424-2c7c-08dddba355f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180

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
v17: No changes.

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
index e4945e5c92ef..e3a445b43d7d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1223,6 +1223,7 @@
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


