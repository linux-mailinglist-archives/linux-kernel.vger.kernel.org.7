Return-Path: <linux-kernel+bounces-722454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B50BAFDAE9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B8C561DB5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1774825A33E;
	Tue,  8 Jul 2025 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IcE1d3Mb"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB525A337;
	Tue,  8 Jul 2025 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013217; cv=fail; b=X23p4lb16zwM+Q9uHYcqO9fkKi0u0OXUmTKpPQUegmVlKOtxZLQK8LFuQsYtBzAa652B0NrtrWkbgGj3EGWPyZzYetjHXL7u/5DFLTeYbswAE5f23rqqGdI1Tl5YXNExzH3hf/EoeXf44sa2xMXghpFwJjaau9v0+bcWtmPxxxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013217; c=relaxed/simple;
	bh=KMGINIUF9JdO9OOP3qREMqyptU/KtyZODm1dwNAd/7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lODGGozVYMqBmox0UH2ChmAr0/w/r0pFXH4eLdzKok0wD783tPR1unugPLJ7bTf6FA2IeVgDCg1hRRYKlbnepZsshW+20xqK3B6lZ8ghoDv5uTcV3FvaH4YsF7arZ3prj6QK8R/hkO87fRIn/xO/YBtf9RS1td0NvbnTOMq2XJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IcE1d3Mb; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxCInQstBBB2TK4/ArpHYTh28uOUuBeHh+LsI3fYRuT8l3F2XLLqjiZW0Hg7l/8tcJC0bwjpVhawA4He26JB0ZamaL+NoB78s/KvvzztcRUIpq0Of6+umn7przil1yZdXxqPeQOfLChO0Fp3/gE5lsiQ1XhNFZ+a/9/RWdzGinGFlpJ/TQUTw4ipYbeHXbtMN8/ynxr6XKWTM1s93xi+dDV56e0Z9/IibDUQ4RWgM61NNap7bcx3II5Q0UFrhzGvqwA1o4bNbU0eBIdZow+ij/O0Oij4IewCYca6du5pwYKQeV8cx/OM/7PuUmSty6c2C2bcGu3BBgFsAx5rt1EFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDAMcx/RGQJ3ZorxR2ZiSTQV/G4jzowUx9dSXdG/91Y=;
 b=EEbh9teiLvD1KTwjY29D3raE1uieV2jpjR+yv4BpWFm16rUCaxfgYEKX3seDfD6yPSgNDM88lkbSR7oyB8mukvposhJMIRjYpS14AEv0aNtNHDkSQwFY4JbXnEapVgvX7j8iqtA7uP+LfWpu0q2D3MNf/lQFOPcR38gN0H0EkMmJ4wHAQUsDS8ktOZHEvua4OaVfxBViOHG8wIDynuzdayOfArX5V96O5P8Lfyv5luB+UJ4TmCpzPyajrZRpwGPwYBrnkZjx2EH+YYP5bbtCXOv6gFtqbAOha7tgZmFNQmHG38U2J2EjQka3+FjTvzJyWhfSegNndjtB41uquHU5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDAMcx/RGQJ3ZorxR2ZiSTQV/G4jzowUx9dSXdG/91Y=;
 b=IcE1d3Mb06dbVBcgBIChL0wI4Jtj3bigVND6k0atkarrpkPOgPyOLVH9Fde8j3FScUOjs4pT4RCn/PcXHho4zTw8p6joJJjMrWciNgU0PiPD0FHe9cgX8rQSPBc2TaqFwGqqlcWjuUtM2EjPdM6HgaBzuUlQuxMGak+BsYNeh9s=
Received: from SJ0PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:2c2::10)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 8 Jul
 2025 22:20:06 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::aa) by SJ0PR13CA0035.outlook.office365.com
 (2603:10b6:a03:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.19 via Frontend Transport; Tue,
 8 Jul 2025 22:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:20:06 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:19:59 -0500
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
Subject: [PATCH v15 14/34] x86/resctrl: Add data structures and definitions for ABMC assignment
Date: Tue, 8 Jul 2025 17:17:23 -0500
Message-ID: <994417126eae21f7ceb7994a875b9ec9bc553784.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 291dd652-6ad0-4901-3b23-08ddbe6d97d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEZBd3MwUElERnNiWmY3Z0FUWm5tdXFaSlp1YjdOTjhUbmtjNStna251VWxn?=
 =?utf-8?B?MndGSnBGbXcrVTdCeXVQUDNpd3BPclVRRkwvUjlKbkUvZlZyRFZhU1NIUTlV?=
 =?utf-8?B?UFkvRjhlZDloQmF5ci9XMWRBQzRHQWFieUl4Y1EyNkJwRXQ1MTc3TGdjMkZ1?=
 =?utf-8?B?UGhOemtHdisxS0NydHhzWERncnQ0cWQ3cFZwWEpPdURNNE1qOGNHR0hoSGQx?=
 =?utf-8?B?dGNvSVZ0a0VNMDhUdUg4djA2c1d4MjVKbG5HeXVtWFRpdjd3ZjFoWlNUdEhT?=
 =?utf-8?B?cU0xZDRFcDhLRW9ta0sweHFKN1NPTVpzRUVrU0FOLzR5SzFxVHZXbXpUSUVy?=
 =?utf-8?B?aEs1ZU9JVWtUMFNLblYwUFdCdXNiSG1vdzc1NGwxR3FvSHNjUjh3Q1RPWkVv?=
 =?utf-8?B?bXVDbGh5cjFvL0VqeVR3QmljN21kRWd3RVpOMWJQaFR4NnFWTjB1TktQK3U3?=
 =?utf-8?B?OXFLYUJCZXg0TXRCaHoyTjkySWVvcHFodkkzQUlTTkkyU1pWN0g0c3JaaUIv?=
 =?utf-8?B?SXVSd3MzSktZRTliMUhnWW1BNm5YakYzSGcrSkVBZzhUaENCRkhFcE83cWxu?=
 =?utf-8?B?UDlMWW9VSkpMRGFtd2tSTHVJK1BiNDlVdjV6WnVGSjdmQTBIM0UyYVJ1UFhs?=
 =?utf-8?B?NXMrUWNqbVJyTmhjcmE2Uk5LMno2WVB1R01PMU9LZjlyNElTNGpKcEVQRkw5?=
 =?utf-8?B?amJza3d1UDU0bXZFN1VidXBrSFdRWEZrMTAvZzQ5MVRHZTdEZDlLeXNHMWVZ?=
 =?utf-8?B?VlRqenkyZk8zT2FFMERMTzFRTjI0SkxzWmRZTytQQ1lNelhESSs4ZkNWNU91?=
 =?utf-8?B?d3o1VlliNC9ETmkrTjFQck90V0pOMmxjWndNbk1jeW94ZUc0d0EyMEpuVFpX?=
 =?utf-8?B?Z0kvNG8zcUd1cDZteWdxUmNOV3BRanVjalhKNW53UWt5NlVtbmdKSElib0Ro?=
 =?utf-8?B?dVZCRkVIK3FZSTl6dk5JTHVzY2tyRDlmZG8zU3VVNjlJL2dXUkpqbTlmdDVn?=
 =?utf-8?B?LzNxd1FjNUFOaHNpajJDSm5ySk5tamtUNWJ5UEYyZnpObEJXdURWZjdjUlZS?=
 =?utf-8?B?T09yUkk4a0JmN01CWTJiOEVoWUFtRzRnb0xWaTdnT1hWK09IQTFwN2pIV2hi?=
 =?utf-8?B?aC9BOStoTU5iNXR1cGRsM1dmYkZKNFFpVVpuVzZlcFl2bzlkamsxOVd1bzBL?=
 =?utf-8?B?MlRSa3JPUWo3WFVSc2hoRk1qL3d2VjVnNXY5QjJueGdOelZGaFBGdHh2TWN3?=
 =?utf-8?B?RjhGbmNmdWpXdzNEbUROdUhhbHVzeGRCMFVmeXJ4ZXdWaUpXYnhZQTV4bnd0?=
 =?utf-8?B?QVB2Q011NFp2UjY0a0cvSE53VFNHWkI1RnB2Zk9LZlNWenNrN3ozRFhXaXVv?=
 =?utf-8?B?aXpRZGJ6bFQ3aXJKTThaY1h5SlhIa3ZiblRtcGN1SHNwY2kzM3hoeHlUTFRo?=
 =?utf-8?B?czBiMmlTdWtERCtkY2x3alRFUm90dytyZkFMdlY2MVJuZGlQRVhnNmNxKzZq?=
 =?utf-8?B?WHVWREt6RVFGMFlNSG1BQkdZQ2lhdkNicUVZWDZmaHVURk5hYnoxZGtDZ3FO?=
 =?utf-8?B?UVQ5ZGp5dkNxZjRzdStNM1JFc0RhU0ROR2JJUndmOVk1Y3k4RHd6ckhlNFRv?=
 =?utf-8?B?NmdRSFE4VTlwcTV3M2V0c2pIK2cxNnJTS0NrSit0K3BBaDUxM2tqeUlqWmhE?=
 =?utf-8?B?K2R4eU9uazd5d1RJZ2JETTF0MTRBQ3Z2VzZyd2lEcFlmRitVaEVFK2hhc1Zo?=
 =?utf-8?B?ZGYxcXN3bnF2NCsyZDBFL0daL05kQlhNZkxlK0wwL1JTNlU2NWZuKzczZnNa?=
 =?utf-8?B?U0trV0NXVml1cmNxd3l2eGlQeUlxOFBKSlhLc0U0TnR3WFBkY3RaTldBaUZV?=
 =?utf-8?B?V2JhcW9kU3F5UXpYOXdSK3hSSmc3UEg3djU1QURWL0ZiYzJUV3BtM1grVmcz?=
 =?utf-8?B?SzYwRFBrYjlQeFgzenA4ZjVoYWxDZXFiRC96Y2ZHWWZsVUNQbWREZDBqSnJO?=
 =?utf-8?B?c3FBTmVianE5SVBjbTRpdkd6Ykl2d21GdjI2Zk9OSVBjYTRFMkNUM3p2YU5a?=
 =?utf-8?B?L0hVNHVidUQzV2ordWRxUVdYTTNuczQ5Y0dHdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:20:06.3106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291dd652-6ad0-4901-3b23-08ddbe6d97d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

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
---
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
index a98367a353a5..0f513f186fc6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1216,6 +1216,7 @@
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


