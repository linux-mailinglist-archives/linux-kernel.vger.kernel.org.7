Return-Path: <linux-kernel+bounces-850718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 686D7BD3A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6081D4F7186
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211130ACE9;
	Mon, 13 Oct 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="be6CLSuL"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E643081CF
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366131; cv=fail; b=RW3eQDcAe1AdG7MaV6eIAhDW26NMuJLY5sEmaabHdJTzXGDrCmcThbKGe7zahC6nC5YQjnJqTFPthrVKHsAQ4EIHqJMuiGVDarSw/dyUA2/etc3U6qnfksBI2Bkno6ECPebXbo8crmRi0eemFO9+hLpgjWg7gM2O90Z8gXz7I+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366131; c=relaxed/simple;
	bh=eYqTmc/56jr8w5jGfqO3SlNprUqAjhZ6Iw2VtnklVaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6WO8noZ1+8ZMA6TM2nUtthc83ph7dS9VL9ncIicKOp3UtRDna9Ip2sgPrRxA/uTxeUEe88GYGEpAclkmn4aSWczGIHGOEe4tEnBjhr49JDGvXgYQ56E+WMuS+Te4tAzBE7xecsEPvMcV2DPpn/TatB8FZyxZhw1ZOEWxuZKujA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=be6CLSuL; arc=fail smtp.client-ip=52.101.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoZeYGup+3O9Pb6FcKMZtZseEdYNeaRobef//rFsApDhHjwdnNnSc/CTG0X9O8g2aT3heoe4r+NpKCQvTa1Pv1MJ4nhGp14AlXjOrPdYl53ksKmZrHAyG9pHmkaBQGCVRRyAhPpPnv6SvYyDMhmaiv5yCzhQXnuQ43oGYyZR4hk4FqXSXC77hk7tv6DS0Z5N/mt/01y9ErQIxieJ++f2IuqepT4dnlRzhR1FXu1qPIIBJMA+SupxCYltGNHaNtRs7Fgl+D1EP2zcSZJTOezfUuiNo7pQzvx8WYJ9alfhbpcQAvdKp69zkL+tqb2+olNLaJXEKusfaNeallDGskvKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaE903t4OSb67DeUTo3o9mWCAhyDdJx1T4Iap3VKmG0=;
 b=UOhrhDb5w6ynINDLx2Ul/uSyrzPgSwvYRiZyU9hXMr15T7BvX3fi9NZDBCNkXseI6SunJmhFRWf5VAqFHSUSD5ZngMFZxsc2sHd2ldui+8J5JQeuR7zjPC3GcI3+2SkurWcfpA2ELx7xJl2Psxs1qdzAqTD6ZsIeNaT1/a7XFjsVv3y05Ca17655iSg8igulHJ77X2TgZa/twY78PnJRwmeix1AXf+jPWLQ6LwDFnXVGMgazuXC3emVdt4Lh9NnNtpR8Zs2acdhp9SXyGihEuji9MFbY8jui3E2bQeUhC6s01dn/CbUSMEAENCSLMAVgHf1XoLc8JrCRI7zRHuWXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaE903t4OSb67DeUTo3o9mWCAhyDdJx1T4Iap3VKmG0=;
 b=be6CLSuLiDXSjLZAu7XA2o6TH/ldYoeizt2LeOyml7l+PTioFA666SKR/orK0FNjO3elRwwovAD6srcAQ/VVCrSPLUnDCw6E06TyG1AdiXFhie9hcUAAcuP3pu/Jm+kbIG1bkjnxNGsB22bJEuZFIqy6Xg1n1Am+g1t4mTCyZDw=
Received: from PH8PR02CA0038.namprd02.prod.outlook.com (2603:10b6:510:2da::10)
 by IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:26 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::72) by PH8PR02CA0038.outlook.office365.com
 (2603:10b6:510:2da::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:26 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:25 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 12/56] x86/bugs: Reset SRBDS mitigations
Date: Mon, 13 Oct 2025 09:34:00 -0500
Message-ID: <20251013143444.3999-13-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee10389-eaa1-4420-e63e-08de0a65c000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WO6a1bMbPEX5OF/z6Z8X8LMutDOSi2DpovBO5EpcMkWeXnrTAMKguHhXe2r/?=
 =?us-ascii?Q?iE5Bqi1xze/y8VORVFLRxM3d6I6xW09dLVWM5r2wJyX0wz+/53Na31PVIPVX?=
 =?us-ascii?Q?1AuCrZ1whLymhvrBHOQ3yAjrDFpK7QPiJ8hWq11lF45UD13FmL41G1AkJsbN?=
 =?us-ascii?Q?VW9WHW5JrHgewZUBY88TPZ29LQESP6AI7sAyCwvNItOVXaIwFzVJg0UuTGXk?=
 =?us-ascii?Q?0GtNccO/aDcOlSvqAHxwRFnSwxRA0oxlXYrpXjowvG9nBNOSbm3w1Z6rBuAR?=
 =?us-ascii?Q?fvrOTNeSIrS+8BbWbjltX6FWIg5mHhm2I7c5LxS/XCv+oVv3o4RyzEJenPV3?=
 =?us-ascii?Q?0OIpsZ96vVV26+MY8bvLK2pniw78RR5pw6tEeU98YNkkSsj4C8Zjka83zk0z?=
 =?us-ascii?Q?Mg63ZdCVzToBOeUNEjjFHjTkqOzycxsYCUJ/6CU9PMCwyjXIbmEzD0pWquoB?=
 =?us-ascii?Q?uvWELCYhK9xCM8wV0Y5gl6M5wpxPV8D0ZDvLhVJMdYH01CWnB3TOwByDJzEh?=
 =?us-ascii?Q?CQpTY0hrlNHLpvCOo9e47DKX0KjVdKhv2DhCOHVgqkKhkcq4odwdKKoDKrBW?=
 =?us-ascii?Q?uPEMy5DVuk9J5D4MbCH3GHmyku9vM3kLUPjgtBHKlCkworb3aoV+Nd5UYjqC?=
 =?us-ascii?Q?0R8hyX8bMORd0UMYnUmpe8xxOAOOQ77cMWR6GWtXwQil6F/cOdsj1s/4VVcv?=
 =?us-ascii?Q?J6Id8WfrlJD7iS2TpJ6BcwtvF0FaQhsPr+pwLRkzaMMbpsAxybpwLup0yaJv?=
 =?us-ascii?Q?weC1bvw1bnyu4bSeprprGO1sXio/epLW9pUDoe18C8y7N2r+xZfPBtm6eJn0?=
 =?us-ascii?Q?lNTvvoX6M4ECqta8Wiu7iUMaB4G840JajDk3u15SqghjsEvelh7oZsYj9H4x?=
 =?us-ascii?Q?JgqI7A+/NGJIoo5L8OZ8+dTdzmRQ6q1kfjP3Kf3RJWyVMH98REDbWORq/jEk?=
 =?us-ascii?Q?cKcBhR6aF4yko/ezysy44YpukT7f2unvc0Guk3WiXDEfL1Jest5k+gOqEQSc?=
 =?us-ascii?Q?ZCdfqGaEdBPIi+gyocEOzGFtUVKJ1CIa9/CXFVEw+vLzmSvGfgHJFBbjSpaK?=
 =?us-ascii?Q?Om5tRundp/z3XfqbbcdtEmYZREb3bifyfDAm9scrFgitBFfhB4lCN6kZyjlW?=
 =?us-ascii?Q?8Clw/sqJ+L/7/Y4DCelBRrs5dPLNlJcbG7V/YILQbMoZJQokpKR4C0mhqFVq?=
 =?us-ascii?Q?MWEwWR9JQEvEeiF26Jb/sH/sgA3mCx6/cvlIvfqfCJRnATq7PZAczxa+gUIW?=
 =?us-ascii?Q?aQleheMBbKdaUiNkF9uM9TCs55qhcb2KYbEOkLot8QMmrdMwgirfDP6aNMJR?=
 =?us-ascii?Q?cwByYl88C6m5PWw0XX63P7dSzmLwr/CsgEr2hj2KQz7qX7NGdBD10U4418+7?=
 =?us-ascii?Q?AzSCJxiqZsvCIs32mknC1M+7Gr4yAPCRNjxebuHz+8rrLc9hjSBKKwb3Y9tp?=
 =?us-ascii?Q?GywrC7EIZuGYH0lGlwWgZJQ2vrzn40qkCkAwdOHfiki6hzaxpxaxTu5P+KdE?=
 =?us-ascii?Q?vz6rLP+4G0uZjTxgyvxB5vrWbIpl3SQUfYVDzJweDBRpwwohSTBKECCMWR67?=
 =?us-ascii?Q?RRWtW+i8CHiUMznZjDg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:26.1794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee10389-eaa1-4420-e63e-08de0a65c000
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189

Add function to reset SRBDS mitigations back to their boot-time defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9139c8187913..9a9d5309aa56 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -993,6 +993,17 @@ static void __init srbds_apply_mitigation(void)
 	update_srbds_msr();
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void srbds_reset_mitigation(void)
+{
+	/* To cause the MSR bit to be cleared */
+	srbds_mitigation = SRBDS_MITIGATION_FULL;
+	update_srbds_msr();
+	srbds_mitigation = IS_ENABLED(CONFIG_MITIGATION_SRBDS) ?
+		SRBDS_MITIGATION_AUTO : SRBDS_MITIGATION_OFF;
+}
+#endif
+
 static int __init srbds_parse_cmdline(char *str)
 {
 	if (!str)
@@ -3913,5 +3924,6 @@ void arch_cpu_reset_mitigations(void)
 	l1tf_reset_mitigation();
 	mds_reset_mitigation();
 	mmio_reset_mitigation();
+	srbds_reset_mitigation();
 }
 #endif
-- 
2.34.1


