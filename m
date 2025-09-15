Return-Path: <linux-kernel+bounces-817095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E230B57DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8751020268B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3791A1F3D56;
	Mon, 15 Sep 2025 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mcTxwESi"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62D731AF0A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944055; cv=fail; b=A7Sx3dJ38ue7d9va7xwezJn5iDljc7wz024PcV6Ff46J5bqdPmfdyixt111c+8hUEfJd6ly569URWrwwOC//EFJlpyyLerESPocOtQacYOiXeNWkyB2OH7cgYC3uuSpZG8+DcA4p9GoX2jxO6VrYAF5hJ3lL7lOVF7/KqZvmSEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944055; c=relaxed/simple;
	bh=A5pwLm93xoGOAI4NXu2ZGIs3tn76LRDVqc8WLNIS04Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vpx3i5c6BzIRVx0CH9yHIDpjTbj2FUQIPqAqFEKeI+j8P9DGVEBs2mgGAXcBvEVtHKaRJDEOCdg2iPUFw4cLSMoBYFiuCCUotI6FDa+vOZMEC2p5TjfsIyQe4h+NZK1buqwEBsefPdMXuNlsMihg21D1b5cwAdvfzF20vLAm+Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mcTxwESi; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e333NDpjfHdzQi1FQjFw4wNIS6cYHXrkRj7fua8TCYMb6PLQTRWLr5QHriO4PFzhvd3Bl3hMDgVLqJUi1iHpoBTZzsLySmijTWBL1PECWWV3vR3jMHgzASMQbciuORdZXm2cvgseppKqa9mpa287gaKqXRxllhYG5o74QzD3MltgaDdIrCMvtKpciamSC4G8M5BmMRahHlxPdtMd0msVWUlkY/JAS7konRb/LAT52gzLN8tW6hwtUpmYumTLh5yIIHAAhmjIPP80lUM5/ypZEe9rcgAubiC/DUXp2KNok7/gWg0CcHcnFAewtu+lqqLufPqW1zuHzlcP8fi/ODerbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7ajok5/qeNK4VVR8z5sS/GOIcZpGwAicu8NSM8XSmM=;
 b=Bx831inLOv6fDuGVNlqyQf/lArgBQqMTnhx3T3nGo9xdfHWa4QUeGPPrdzKc2LNKR8Q/WIGGaYpbid1TzAvA9MNO2mkOeHFCWHAlW4iN48dge9DawHvRmCb0aQP/xIzUpdWlHZbnQF+qaj/QzumdXgY97gpsi81+VtXbZ0jbKOgjHYgyX7su5G/86X4e/WKGMJiXG0l6vrIIzYCgF3pH1FWxJp7C01d7Z1ss1MiqWfpw91IJT3CdUAdLN5YhJRyujTvmsSBveaYaHktyz+mSBxrZB93QogeXD5kuaEbnX8K3Y8qKHzATYBXfxgiUKiY/kjsGmADgVZEtpgo5gQeKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7ajok5/qeNK4VVR8z5sS/GOIcZpGwAicu8NSM8XSmM=;
 b=mcTxwESidGl2dFIZTwKuW1rArSQ37AloFQ14nLVUwYjNv3CrQEmW8SwAZ3Jyn4QnXdHFIVLc7qk+qavoxGRKx4nk3lkncBv2XOqf+i8mPUzVf6rM4Ibz33OorCU29wjaptl+ERXoPn5FkrUEU0JFAZH35yQbbtguBimonWQSiLA=
Received: from SJ0PR03CA0109.namprd03.prod.outlook.com (2603:10b6:a03:333::24)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 13:47:28 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::54) by SJ0PR03CA0109.outlook.office365.com
 (2603:10b6:a03:333::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 13:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:47:28 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:47:25 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/7] x86/bugs: Report correct retbleed mitigation status
Date: Mon, 15 Sep 2025 08:47:06 -0500
Message-ID: <20250915134706.3201818-8-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915134706.3201818-1-david.kaplan@amd.com>
References: <20250915134706.3201818-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: a79a2ed3-587e-4d45-6782-08ddf45e692e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9VcuKWXi5ww6A7xxjjVhEiGXnzLzRS7J7DPKGoh1VL4fK5zo8wJJ+/qAnHzq?=
 =?us-ascii?Q?YHAJqbxZwTUaiommI4RwGv8Gvz5wSRfy5jcbhqzmV5xX0MxtpOE5f5hL2rmv?=
 =?us-ascii?Q?FpTtBe0eDrULg3Ufpz0kWzz+PY6NfX3EfbaZSzdH8dW/y8j92blV9OjbZJCF?=
 =?us-ascii?Q?L3slP0G/uE/v0XNOPVdRI2v5t+Td+Ub/effmMYLg+WfbikaXScZDpE/4CS+g?=
 =?us-ascii?Q?3PLLm1VcXMflq4jbv0yfRNwSHuhgR3Ota7ZDkJ9ZRBa0haeAV2JbgakT/jBJ?=
 =?us-ascii?Q?/Lyc7tHhDzxpZpA0x/6GqclGxj7pMfj6e4WLWUH5tU+0+jhlvKINs3tensMZ?=
 =?us-ascii?Q?4HqCcvfSBzdMvnuSOl1GYtvwYAUBSFcyibYj2Y3xjEZCfQYkGGGFvL3dZoZN?=
 =?us-ascii?Q?rOCNFoBvJJteL2qhRn3ZZ6C0/D9uvwd/CXpSzh+1jDW4jcCWdVthNpmQrVAJ?=
 =?us-ascii?Q?TPyfAwuP1ZadJsG0cdBqyGeYBdxQwUpQI8cPRsol9decQ5/Dbbv1IqPIYjwV?=
 =?us-ascii?Q?ElJYXuV1xkZ07mM7W5BNuQU31duYzmOHTlTiG70YgX/u/+24mCJ5JvCkodrl?=
 =?us-ascii?Q?nEUhz9DYJQAxG87lKPVrKgfBjcDaLOU+gs0UYvuIJk6bAzta8OAr4iWoJie0?=
 =?us-ascii?Q?KsiuTrin6mRMqapvkvwuhCJDtH6ZFBpnFoIhUTCnwgc3dJdn6rCD8bz1KPQ0?=
 =?us-ascii?Q?ML4Cabr+nSpv+nhaPTQKPiw15QoIXYBCtzW9axWBi2w/ameXx6O37epg9+Pk?=
 =?us-ascii?Q?d1nrsFo6GZc1lqf8gkzFxdcrlK2WRl1sUZOEtWW5VrCeKCcjzAua1eyx4zG1?=
 =?us-ascii?Q?1VQ82M8R9mmFqr9vgAlEmeE6gn9vktPjuGNoyQpeP9pNgfe3drpiYFmvArqi?=
 =?us-ascii?Q?Xwe5sSbpABwNWS2qh3Ygb8SA5d9jg8uCqCq1VfNISNRBu15elo4XUH14tbpz?=
 =?us-ascii?Q?36j1cBL078NOAlncR8Cr0Sh+wuCl5jNhVqYubslUIenBt06nrcVIAoj15yQk?=
 =?us-ascii?Q?AAL0BC2abViCHb90Sv4132ky7tnmYlZVvL+6gxWvRCVlG6sXhkKY68B0Lb1A?=
 =?us-ascii?Q?a9MfniO5hAXEvblPpPGpuFGYdt1qhuXbna1N/Sf/fRMNcEv8oe9M9UpH7nHc?=
 =?us-ascii?Q?ydrklEbSIXrJz0Dr1IaxpjCWVp73SdMaXPKIGFW5rxqOuVCqjR3zNIvo3EFK?=
 =?us-ascii?Q?7mZcfwHRIbgHRB5f8umpbukfUPCJU5gUnvhdcnbEKYe6GqlnqbGnO91eZrRE?=
 =?us-ascii?Q?DtdTV52WRjEUqGLqFTTm49silXiLREKGPXnMovzlsEg6ucLJBeZXnacKiCrm?=
 =?us-ascii?Q?htlXOvDOR9RRliDZVo3YgwodOs1wlrqQi3KQrJwzgdBivAt/1XSsTgL0pr6Q?=
 =?us-ascii?Q?Yrrbr9Vw0Wv1ND4/VcrpAgwrV8LHZuHNBHfsnnfUzpvluaDtIrmll2uh9y1p?=
 =?us-ascii?Q?Ss+GZ0sdddso7dBv+RMtDDCwNL3dKP11eFW+CnnapUQZ4hDhUgp5cZcSUA1q?=
 =?us-ascii?Q?KusLPMuBKXLkrnjionRoC2klM2eKgxaKDknJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:47:28.3883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79a2ed3-587e-4d45-6782-08ddf45e692e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310

On Intel CPUs, the default retbleed mitigation is IBRS/eIBRS but this
requires that a similar spectre_v2 mitigation is applied.  If the user
selects a different spectre_v2 mitigation (like spectre_v2=retpoline) a
warning is printed but sysfs will still report 'Mitigation: IBRS' or
'Mitigation: Enhanced IBRS'.  This is incorrect because retbleed is not
mitigated, and IBRS is not actually set.

Fix this by choosing RETBLEED_MITIGATION_NONE in this scenario so the
kernel correctly reports the system as vulnerable to retbleed.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1f3a20f6fac0..45c9605fc5c3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1462,8 +1462,10 @@ static void __init retbleed_update_mitigation(void)
 			retbleed_mitigation = RETBLEED_MITIGATION_EIBRS;
 			break;
 		default:
-			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
+			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF) {
 				pr_err(RETBLEED_INTEL_MSG);
+				retbleed_mitigation = RETBLEED_MITIGATION_NONE;
+			}
 		}
 	}
 
-- 
2.34.1


