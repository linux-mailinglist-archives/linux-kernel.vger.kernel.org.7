Return-Path: <linux-kernel+bounces-850719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EA7BD3A29
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D3C84F72BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AED30ACF2;
	Mon, 13 Oct 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JkZ2D4Tk"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2E7083C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366131; cv=fail; b=IumyCMWWEjHAIGaH+WvMMOxHE7+GUTZeMhKFKG6/KoJVgYo/DJ2WeyJhrlFRN0l8hz43mCGTRuu1BQz2ob9vlK+BqLaDLDTHV3e2FWdzkyD56uW7bX9mMZpubA8bJ3JRMVoLm/NwOGnF5CKmZHSsJ2tVyKyQe6MK3eNZx6fxin4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366131; c=relaxed/simple;
	bh=cgdDGsFGt936HtydQonq7k9dT0YqIiUi5ZqRlJBZzww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9B+OqihY5UbMia0HqMZIS85J954tqjg5LMGanaZcQIGVFPYeekpDK1ukzyxP48/OFCnmZJiRD1HCMsjOqSPIn2putpiVQUdeDzsvWSDkbtPoTGgOMJXc8IGDal1PA5i1dSXovhXjOElIzPKKCHduLkLoYZYmb96Y0WQQk6Cwkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JkZ2D4Tk; arc=fail smtp.client-ip=40.93.195.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=be8Rbnt2sw0IEhm3pqHw1ZFUw3Hk0QTgSlHc5E2reWixM9lZ1FrGbFT/K6xrWdKzo6Xvw+qcg+QnxYOqeEKSKmXx4k9mBK2zmXGJfpeZ2MDYaJQZ+q2yKVGjTSkYqvkO8pCY86LMtiDJbGvVKQ6to20aXY5Zm8NgtR/oF7t4Y4BoicnVIOci1slT9DAjq5L6M3mWcfZofxh2/u1OQu1debP47q3pHDQy33zuDeAp1KCcnc5rEsPmvS8nKR2yprETEa41rK58DLH9TB+NLojGjRZU+A2k/ymV4sFZi+gc28pTSyDG4fmuBSf19Tl28+zXQyLGrr//yHdrQ//LaVqpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11snZfGBiYa/PY6UG823fK3mM7asVpcClI7HuI2G9ok=;
 b=fyRVaUzDS88dIxb1gacFnm22Qa2/tohTUEmlOowghlF+Xln+w6io8k9yj5f6bvj5okWZ9RM9UWpxUOcptUvXzNCLs3Wdj0pcCZWAONbsSnc/dpuQVDoKUKXJhh8DLqR6zE3rfMHphJ5y5CSOwvHkQoG74Wq1uiOu1he0e9ibp76nVQGy/Y+Y2jRNPPTmmqbMOiKwAOnM/ueYW1djeExl2XMdDb4ZTaSI4+UsnQRBojUO4TzPIm3v8iCvxo87+VA5OB2BxoLg6QtTxSeRdLyBB9qKSS2UY0697+a1IS+/qvtPhro8VkUJ6dygZtPSS4Gl+H7RctGOwnhoMOTyg/DlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11snZfGBiYa/PY6UG823fK3mM7asVpcClI7HuI2G9ok=;
 b=JkZ2D4TkwhM22dzKpx4kjAtKeT47kYAvAFdnj7MQgtq+Bwll7vice3l1qVCRi+ZEYse6GabtBAFYdGpg2n7IwW+ZkQm47XYS4pvG8qoI1F8ng5szG5l+xT+NY55hCGTmlyMqyGKDGi+5gqYaj9HVe3iZFmcy3IW0+StNQtLG5GQ=
Received: from PH8PR02CA0026.namprd02.prod.outlook.com (2603:10b6:510:2da::22)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:24 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::4c) by PH8PR02CA0026.outlook.office365.com
 (2603:10b6:510:2da::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:23 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:22 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 08/56] x86/bugs: Reset SSB mitigations
Date: Mon, 13 Oct 2025 09:33:56 -0500
Message-ID: <20251013143444.3999-9-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013143444.3999-1-david.kaplan@amd.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 567f09a5-14cf-4c4f-f336-08de0a65be6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D/Ksy72QndHDpyNAF1UdN9xAUt6qj569xysPYe68cyprl31srSttp1xC8WOZ?=
 =?us-ascii?Q?fycowzxzTQuRG+MxAXCB5NdURlPcMGgnMlImTP5YYIipMpXooCrNVihxHfUA?=
 =?us-ascii?Q?Y1B6jNJ9/zDzi/C7YUo8xI9o/EjUMdpkOBu6U7IKndbhZj20vC5feXTXEeI9?=
 =?us-ascii?Q?zkvZhJJSTeMSEd7B8QIndyAsaKzBpFY4V86U+QIbDLNpnNyjBSb7i9DsI5Tg?=
 =?us-ascii?Q?HqoEAUYzJrC92V1xdT1qBBlMGDBYTOKYgRCWdz9W498wK70+KcngxI8dPzex?=
 =?us-ascii?Q?6fYU3UwR+b6c8nOmN2ADqjXgacy0S0SizmQ/flq2U+EWfHRtMjX2LtlvjOgI?=
 =?us-ascii?Q?V9F7VWonKlYmtDIWefv0Z9H4eJS5p8Hqs7NtrXU09a+LpOx6Ma9+xqNhTRO7?=
 =?us-ascii?Q?BtScsFRcOzAHfumppP/pGVzPyPj4JBPsiKW3HO3ExvRI1kz+3hq31TpoGUgC?=
 =?us-ascii?Q?b6zksWKg5w+Nhs2eBZ/gBz3xc97V7qoT86k2exrkp3M3GAzEln126ewPrQEs?=
 =?us-ascii?Q?EGC2HWwI7EOOz0XituASN7Nl0zFgNll0gN2vpSRalVOAB33JxSdAmg9AzKgR?=
 =?us-ascii?Q?jBYyHoFvTyX1DGpoRNNW43Uji0xOzwnxzQ6f8yRaxab6M3bkI6gn7PMjNqAV?=
 =?us-ascii?Q?GOScdX4zhjzay7XWUr4eYv2rtifIf0kiyDJo7N2OLwmuBcJ+zdtB/7L3I8DZ?=
 =?us-ascii?Q?VIFDhVpRbd0HYK1yF5M9AqgLszJ1FTxnxkCFM4taGxtZRZ99dcaa0avRG5vp?=
 =?us-ascii?Q?0/UgqUIp4A2N4R8XplqJOvD+kFgFJoAPAGrCf14wlpV8xNM12ujpeDrdn7h0?=
 =?us-ascii?Q?kg0n90iPog+9P/SMgq0Vtwe7TvZi+wL9mbxoPGflancLuYOuiHHVRpgRbr2o?=
 =?us-ascii?Q?00M0asVDwttvOs9V892tpRMJfbuTrVDGJpSSDjPbCiKXjgdKuxKApEI0cS1T?=
 =?us-ascii?Q?eMoa9Ws2sThAE+Y1LrEcWm8mgdJy2zeD7SIV9eCaAHSaUiuFdHsrIJfv+0mk?=
 =?us-ascii?Q?3O1t7WBfvBCxch6AwyJfbqI09BuciZ8i/gHXcqbjg5ung/nQc7O8F8vD6QDS?=
 =?us-ascii?Q?nNNxYDtANCkLV4XxeIazA3WAvQqsurD45h9ie7a/O/D59e4miVxu2aGv+6lm?=
 =?us-ascii?Q?AjxsrlrjlqscVMrSZmsTZTC+73iY991Rs2zYZwoo0gCAJ2SdRdSXoAQ5jNzG?=
 =?us-ascii?Q?xSpiVjqKKMSCSINfEpyh9QxYrgTMEUfO+/iP/Ona4EWgj6ZipENpYmW73ad6?=
 =?us-ascii?Q?xgsy1n4tkg8Dtpg7xHspqBqjfJSloVL/qNPAgfUY+9HXqo0Tc/3siUjbc4vo?=
 =?us-ascii?Q?Obo759r2WlH9/UIm0bnIfLyfeAb0vSPVSdkMjasf1lREp12U8gIqj6PvffVS?=
 =?us-ascii?Q?WLhzCdME+/LW69HdBGoXdKe28zhQDO5PHbO1Njo7Be+sQeFZRkU/UcnyjfGb?=
 =?us-ascii?Q?CR12mBkQfHSiGeL84NZ8jjg8ob51hL4Cccej4ygMaMlFxYFJHdTHz7npZNnS?=
 =?us-ascii?Q?Z7acF1xWiGcTO6yAzSgsRqmK1GqIFmr6+dgLKNaOGHY8YSet4HPz4jg5MLtw?=
 =?us-ascii?Q?0P/PuRTKNJ0z7GLMAkQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:23.5190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 567f09a5-14cf-4c4f-f336-08de0a65be6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889

Add function to reset SSB mitigations back to their boot-time defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4ca46f58e384..cc7b1b67d22d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -380,6 +380,16 @@ static void x86_amd_ssb_disable(void)
 		wrmsrq(MSR_AMD64_LS_CFG, msrval);
 }
 
+static void x86_amd_ssb_enable(void)
+{
+	u64 msrval = x86_amd_ls_cfg_base;
+
+	if (boot_cpu_has(X86_FEATURE_VIRT_SSBD))
+		wrmsrl(MSR_AMD64_VIRT_SPEC_CTRL, 0);
+	else if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+		wrmsrl(MSR_AMD64_LS_CFG, msrval);
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"MDS: " fmt
 
@@ -2672,6 +2682,17 @@ static void __init ssb_apply_mitigation(void)
 	}
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void ssb_reset_mitigation(void)
+{
+	setup_clear_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
+	x86_spec_ctrl_base &= ~SPEC_CTRL_SSBD;
+	nossb = false;
+	ssb_mode = IS_ENABLED(CONFIG_MITIGATION_SSB) ?
+		SPEC_STORE_BYPASS_AUTO : SPEC_STORE_BYPASS_NONE;
+}
+#endif
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "Speculation prctl: " fmt
 
@@ -2916,6 +2937,8 @@ void x86_spec_ctrl_setup_ap(void)
 
 	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
 		x86_amd_ssb_disable();
+	else
+		x86_amd_ssb_enable();
 }
 
 bool itlb_multihit_kvm_mitigation;
@@ -3857,5 +3880,6 @@ void arch_cpu_reset_mitigations(void)
 	spectre_v2_reset_mitigation();
 	retbleed_reset_mitigation();
 	spectre_v2_user_reset_mitigation();
+	ssb_reset_mitigation();
 }
 #endif
-- 
2.34.1


