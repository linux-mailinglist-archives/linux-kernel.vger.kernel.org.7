Return-Path: <linux-kernel+bounces-776406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 357FDB2CCED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD47F1C212B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D64E341AC5;
	Tue, 19 Aug 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mhV8Td/v"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063F33CEBD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631345; cv=fail; b=NkVcNY8ciIRgSPlmq1aOqAoo8IZgUpYBupxV96vkiu/gNrizMSZ+z8OVf2TGD7boi4zVhGIV/CDm0k7+rPf2QxzO7qmypYQv0UArJQOJNUzKVBxN8CKMkV82DRPulIV8kaRTckNFGG8XKZGq0JlJPOqlbeiJ72MQXkaMBOD27/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631345; c=relaxed/simple;
	bh=unOjYS+CtZZYzGHhplnALDGLMuN6GmLfmrMMksJneIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzAnusaq/Rwp4hQQSQ3QwA9eQs9bC1e7DAD4b6NalUhojFjoRDzt7rtYVyOM2qfe82mX3+mRE7IjP5KWWUxCsHggzrWi811Qo8PKyvs80RG7JsMTdus9xV30J1mwgcLAqzAjxkDdTBcQD0levkBPK0+BoedBTfs+/n9l9+4acwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mhV8Td/v; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=du9NPt68GzLcqu8IgzdO+kcy2B/mqjyQ2Swdq7I5rUCXNNicN9E1Slr4osqOQW6jjtvygL3Ni9TCig5cYA1g1qjGKiBn3RWcKyUA3w4ok7QWUILEZCN1ekBcv2mfz9mJY1hIHSBRLtmcXc+OZ2ZAmEgX/LNnZR2omm9x4v9dNn8Y4dYadzt7ffK1PapSW1MDA7/AUL4QVCF8Nu1u5MVa2c6HPo3u97jIQQV151gj8qeUzODqiG3JSKbdlQMUyF8qExFnltq95ZjYTtGlq/JCJKsUzMI5ZXeE7FeNu2Y1L87XoknBOJwXeJa7Kie09v/o/4h6v/SGUQy5KB7Q7RR5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTspkcIIDxp0S3vfzT2+66CFZcg3RyEk3kt/iCG2tJo=;
 b=k/pNuQysi7g79zvPwybOgwqcGRarIhl00hKWHKDQ+GZ+R41kgl74RNwHJmt1RR+LXlcybzb8C2U0qPlyv+vJccU++Gfrjv8xDClI0/+n96NJyek7PXZGlHbYhhkQJW+iGkoBeB6CDQBeaxbhnkcIEsnY0ucUvNd0/YIP5h9ZISg7f1ZyhiECumfQpoZpT2u/IBEpwPkG719kJWmImlLo75J+3V19Mnd+a4vBzHJzZerYX7eMIIbeFrfjvEdDXKEU9agQ62+x7ZCgjkAzdNaBxaTpRZhElUnl8V/gc126Xgs52dJk2B8sH/1RKmLqCBURR6wJhCOHOg6hAsbQVMmMyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTspkcIIDxp0S3vfzT2+66CFZcg3RyEk3kt/iCG2tJo=;
 b=mhV8Td/vyZe2SM0iQw4lDGzxPKF19TZyXmEHEcIQe54CEmndPn6oY/B8QmN5tvL7BKRX+BMk2mUB/dA9ji7qmgbRfQqWC2WGgmNkv65XgOaM9mOdJmK/CidIwBvjO3TJRIkB+fxZ8Ef83uE468fpOtiY9ijSkhDPtNgfaW7WVRM=
Received: from BYAPR07CA0105.namprd07.prod.outlook.com (2603:10b6:a03:12b::46)
 by SA5PPFB1A5CE29A.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 19:22:20 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::17) by BYAPR07CA0105.outlook.office365.com
 (2603:10b6:a03:12b::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Tue,
 19 Aug 2025 19:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 19:22:20 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 14:22:18 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/5] x86/bugs: Remove uses of cpu_mitigations_off()
Date: Tue, 19 Aug 2025 14:22:00 -0500
Message-ID: <20250819192200.2003074-6-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819192200.2003074-1-david.kaplan@amd.com>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SA5PPFB1A5CE29A:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a9212e-f076-4366-ba35-08dddf55b7a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VTebWXJ0yFsnzQOCSTVpu2ZUaRs86BAWtFbz17nB0p/vo00fCUAVVl8QE3IK?=
 =?us-ascii?Q?neiZVlama0VvqAgcXgbgu+/AGj3qAqrcDNOYZT5rlENwzdIavpn3WsXs+6/X?=
 =?us-ascii?Q?k2JHleE/wzSi4LkJcp9l5uyW7xxQQpSp4/wB8NRyGxawpeC3Z9et7r5d2mSU?=
 =?us-ascii?Q?NRDI2226Flw50+gPJx5TJ1Ow/2O+s8n9jN1TCo/8QGorT1/x4daWtS/62iUv?=
 =?us-ascii?Q?zZb2WfObeJXYftPVYCreZmBLGAsYmv1ul2FM8IjEYhqHGhfr/i0xscnd6TMy?=
 =?us-ascii?Q?G49Me2XUbU9yBsJX1DOlfT382KNCuDTFcMNC9mv2WRjdmAnx8E/F9JRAMyqs?=
 =?us-ascii?Q?UaGnMYUAJs7YSaT9cn31cqgttSAK0AGThvWO4l4BT/ioVK0aiN+O4Swa74od?=
 =?us-ascii?Q?xKwYJKAewn7ATlOlQl/SEooeV7bytjZIe6xHxw/T++YVlBk+hL7y4LwB2QI4?=
 =?us-ascii?Q?vmCkeNHna12zeW9m0U9EcLMy6eciEdke99Phj+uxfAd5DGiss691q0DW4VL8?=
 =?us-ascii?Q?9oS4BOP8RnI7kcznov5lfQHig4GD9+h7GMUTlA20XF4VQwGmSELu8NEUTzuC?=
 =?us-ascii?Q?HLhwfHC23qqyPiRLqwigdq3xA3Djv+F1NvTaqcs6mSo7UGjNFx13g89Ss5T+?=
 =?us-ascii?Q?e+ZVyKCIa/pb1rwNNvGgj2wvh5Snsm466vWvL+fzDPsS4hH0qmeauNayfvzj?=
 =?us-ascii?Q?JsqDNoB+4vELhwWd2IRH/Vwk2zVOve9HnQtSBdmQniIPLC678X0XyttoSGQ1?=
 =?us-ascii?Q?AvJFprzE310G0h+UvdFIMWV1RrxWmlIGedm/cdpoepjBGZNDmqNY00sMMsWe?=
 =?us-ascii?Q?TjVvfTBfoPMHsAJ84YcrtjaZYgXTjOOUgErap05aaH2maZmFdOTddST8lVz0?=
 =?us-ascii?Q?pkX75s96x2kTLtFQ5kRoanCU6bixxuGGV0+HLeiar5VTMCIC1SEhviPq0/Z1?=
 =?us-ascii?Q?hxq092hfyVf+UMU/NF+2MTolC+GGv1QTCPrbyXcp4GgEZNnht509m/t6byL1?=
 =?us-ascii?Q?w2Y2i8XOTPlg/JbCiYzmwZt+vbMSVvnIIBncKVtohbPgVTOstCxNsHw+CJDH?=
 =?us-ascii?Q?o7gT2P3mo1FzLl4P2zOd0E0ytdpmKXuYhMdI1qLNCKsOLbxmPBnq9JoU65vu?=
 =?us-ascii?Q?aF7jJDrOEsyklHY/6ORK+QzD3K3+SSqdPyATWchN7oEIgdE6Fj5IEMK/Rn/S?=
 =?us-ascii?Q?DYh9DGe63Ck/OxUqonH17E/CTlKvvp4tTStoTV77iZFf4lH9R863aGieWLml?=
 =?us-ascii?Q?uqw+916gDMhzb5TcnV64s2rWWhmFqEaUhZs3GaBl5aiSP7qtWybsLItdLc1G?=
 =?us-ascii?Q?bKfn7Hp9/9Yo9GvMZNJSJHg/9kOVKef+x8Y5z3HKxGY8Ntqa2IGTb6M3iW8d?=
 =?us-ascii?Q?h55tu6B+OdvZIera6IO7FKOatDqrmjIUlSmzZp1YT/NSc/r/gUeY5hOEGUnv?=
 =?us-ascii?Q?3RHnD8fPMq4XxzQVg3567cpRZAdBPhh6riY7XEsGfyOPu3S0F8MB0bveME8+?=
 =?us-ascii?Q?MCHtu0ZdVtKlliAgpT+25/Cy9NJiCt16LnzD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:22:20.1175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a9212e-f076-4366-ba35-08dddf55b7a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB1A5CE29A

cpu_mitigations_off() is no longer needed because all bugs use attack
vector controls to select a mitigation, and cpu_mitigations_off() is
equivalent to no attack vectors being selected.

Remove the few remaining unnecessary uses of this function in this file.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 059269f3f56f..556b3ba638f0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -670,8 +670,7 @@ static const char * const mmio_strings[] = {
 
 static void __init mmio_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
-	     cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
 		mmio_mitigation = MMIO_MITIGATION_OFF;
 		return;
 	}
@@ -3201,14 +3200,15 @@ static void __init srso_select_mitigation(void)
 
 static void __init srso_update_mitigation(void)
 {
+	if (!boot_cpu_has_bug(X86_BUG_SRSO))
+		return;
+
 	/* If retbleed is using IBPB, that works for SRSO as well */
 	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB &&
 	    boot_cpu_has(X86_FEATURE_IBPB_BRTYPE))
 		srso_mitigation = SRSO_MITIGATION_IBPB;
 
-	if (boot_cpu_has_bug(X86_BUG_SRSO) &&
-	    !cpu_mitigations_off())
-		pr_info("%s\n", srso_strings[srso_mitigation]);
+	pr_info("%s\n", srso_strings[srso_mitigation]);
 }
 
 static void __init srso_apply_mitigation(void)
-- 
2.34.1


