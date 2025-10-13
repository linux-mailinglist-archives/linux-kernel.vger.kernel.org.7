Return-Path: <linux-kernel+bounces-850725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5D1BD3A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E03C3E05C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3830530BBA5;
	Mon, 13 Oct 2025 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SxPYztU3"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E383308F35
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366138; cv=fail; b=tFXa+kW+8ZbZkSQn681Igv95axAoXFbgBmqYC4coJplKL6/1ND0F6LhGlzNkSnPYbBaRlXlsTIugRMzT7OeWLC8znhfsOkOZRF3ztl8nX7y42rPLoKbl25IeZ1U/revkcUaotkZMZBiaf0SMyQT15ImaYlPVVmf3mDXqsd1MmbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366138; c=relaxed/simple;
	bh=qmCIiyjlfwYDB0zXeZF2sZGz0LyarSst9JTzQ/E6zGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3iWJq+0R7uWNP6bblUqWgjeGwaGb+qmvMijB3cqpi70MFL8nV5Pum41Fkcg5c2aA2ATSSMzuWfYoIrHl114bRZIVBzWX1eIbLHQNOr5QnC9k8Z64aTAsqjwKJyETV2A4vS0od4v45IXO5ZOdfyTAkVXplfPfPKVUjN349MVL+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SxPYztU3; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+Leq4TObb8khMF5tNVWoKAEFBsf7qcLiFXZw1C54Tg1ckfaFMakho/IT86f3Ax4i2xUTZDRdbBiz2MIHdLS5k5lyLr35GwmG35V9lDwHBQ5ac86EecewMG4D+zvqnhdjhTsJ8iOtwRBNsr/8c3yKw7YUe70Iy8surYdUx/tEbQ9b9DlUXT7Ej5dQVUMuRp7R9PHxBTNVnQqfANeJ+2ZXe9aBdm0A7MtrTv5DtRkcOJAyLYdGUuCN6gkkA3bVYbPh9C3e1kO3nC7+h6st1eiQculpGFxNeHJts9mi1ouRZdJ+K1mVnDBI7q03sZv7O9YYdX7DrMntIkz+gvhlIhy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3d7w5aI9tEpil39zlTImya5qz0ERv6O9ek9spIJb6CA=;
 b=F4UXxULCJF+4zGA09UZsL4fx0nJGj5cNl7GGYFeenDsUCxP/jUEJNFTwmSdbPP+iJT9bMxiPG6rKJrXBr/+HKeAj2fvCLwJRy9HZbMB4L6fwRV3qSpZrhiFz0PNQh30BgQbxAElJrlGtAzKmi9UE2FxeVdtf+TH/02tlkFTBRW0pkoEo1PijQKxeI2/QlV0sLg+N19Rl5CW1g8x+9KH52p0pX4sRC9B1dNBWqS1NttQrY69/aYPhFieEoSbwTIb+/6vpRUsKV4Smgp7o2AoxnAGCp99Bsk7/L7N5EEy6oxvm74KLaCDYnU/aOQk7EuBnP2pj/By4qpzZfCZTbd2VAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d7w5aI9tEpil39zlTImya5qz0ERv6O9ek9spIJb6CA=;
 b=SxPYztU32SmnnKdT7h9WjLo+7m1SEreB6yaGaY+E/RGn7aZJ/1LKRZtdeFTnBrOS//4hYvR7Lo2oaa0Tk5/Y5wTx6In9gO7KnfrzmTA6O+kqftrSiwoZ7A54aGDbfcBQYZ9I0sJO1Ya7CcSY4F32Qp1DqAMASB4VpOkL2Qr3Fw4=
Received: from PH8PR02CA0040.namprd02.prod.outlook.com (2603:10b6:510:2da::17)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:35:30 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::41) by PH8PR02CA0040.outlook.office365.com
 (2603:10b6:510:2da::17) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:29 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:27 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 15/56] x86/bugs: Reset BHI mitigations
Date: Mon, 13 Oct 2025 09:34:03 -0500
Message-ID: <20251013143444.3999-16-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2ec72c-5b64-4c90-0490-08de0a65c22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A8LdQkFpY7kkHIr94r+OyBugyTOR+mr6iOrzJ8mmd/9k/uhgm/SQHwJ5UYp+?=
 =?us-ascii?Q?00uQ8DZiv5xm48lhKQa2h2VbTVhYe6cc7XLIOGHzPKhk11pT0tvHBi2R+a80?=
 =?us-ascii?Q?oAGLOUXKuwWoCbga/IN3wCaIszGU+0BGUq3t8VqWKbM28LccPPCTzBIoGdVd?=
 =?us-ascii?Q?jvWl+dGlaGBa7NlPVP+j2KNQ+ZNOH6zMkXsbX6pX+Z5z1tC88P4trIehFgdd?=
 =?us-ascii?Q?iPkqp2mxqEcLD2Kv2Y9D7wVRwObcnwLc/wbINxjpyKzuWtaWj1uDj5NJ4U7s?=
 =?us-ascii?Q?wIEjGU615PbzKdczNeF9PGbat6ZWLIJn986dgVDUgCnErZUIC/IW7baD0zhJ?=
 =?us-ascii?Q?Xd86IlMoChrJi6BtroM8Dr22ZfcXhkl/V5QukvKuEyWYkoYxep2wdX9Qi2Bo?=
 =?us-ascii?Q?+3UeDx3/ZM59nTfOcxfl2ikhFR+3UuoSLbFfJ6S9EfpFQvc6Fi6ycmVqSYQH?=
 =?us-ascii?Q?TJ5GzNHOk/SZ1HdMd16pMhpcLkj6ibqCj1KvTgH+AYQX59RF4JS6HFgSXxNQ?=
 =?us-ascii?Q?ot3kHpLwzVff8JfAWTMiYNDAJANAAlEyHW2qYcn2Jas1vntxnLnYycPXC9GR?=
 =?us-ascii?Q?5ovS7aKaGubReE7AzaGraqPwPvegbMnBAI3rNo4/UrmhRm78N29VWBvZEGgI?=
 =?us-ascii?Q?8cilna4bTUxYYYtDJn8Wj2LXDcWzUKWmsyVGvjJkH9FBtXQdqFFxDA0dBhrj?=
 =?us-ascii?Q?6OlsC2NMoFg0FPc69U2h3yNZfb9jgmg8JFJAqHZlozCeiI74wooYscFUl8Ch?=
 =?us-ascii?Q?1IZ1n4ucb4xXWpbjnKns+xbcsi5cuLyJu4S/zVHYj2OTdN67VRV4l07/AcJO?=
 =?us-ascii?Q?jIqw9Pi+HXIkACFqYX9GlEdlUS8eA9nWlWdOrnYJpiuvYleLaAEkvdvoJUzC?=
 =?us-ascii?Q?9+Jud32t6TCr6JZIDd9QGlPElyI0wTmJbOeLy5VnEQl0HLuWmQW08gI+nZGW?=
 =?us-ascii?Q?XRoUZ1MM1dDfUL88d/czT9bAGFOuDfTCFBaPKBJX2JuUkYe6FvO41Dyl514S?=
 =?us-ascii?Q?1ZsrvRoYr9QDlrjRkdhjkOT69kIg40KQKPCDeqw5xHmpW/L3cX3KPuHmGNVN?=
 =?us-ascii?Q?fnSSSgsfiS2AMYWsB8xYZHaTQwy+LqzrlC31RkSNUDBNYb7hVA+hatJpdHXM?=
 =?us-ascii?Q?sfyqWMMGg1KXfKJmHz4fmFDyU5GkReO+y2iyPzD0NApZeW5DGyNMO4CSeEgz?=
 =?us-ascii?Q?Q7rUdhG0rZzl4lk+KXBuM4KqFdUSbK5eFro2QvJp0NCBUyP6NPVN08iDKKhH?=
 =?us-ascii?Q?PlJmfCYvb87F5OSEMHVmIaDJ1fAygzT0MA8Rnnezs+QVJGyMfrrrIgSofQz3?=
 =?us-ascii?Q?12OgfWmopbGlVn+z3bFe3En5M4RIHWmpL43MA1s32qXzuVEsYdGlM0NfgjCX?=
 =?us-ascii?Q?xL/63V6I/cFSwIonXnse8azV9uOPT5XsAadV/KY9WJJ3eCzgJ9zGakI9lm+D?=
 =?us-ascii?Q?HhkVdY/3icnlnmjcIuiBlZ9P3WJHWbK+pcf2WaQv4hOUGchGEXJNQW9sNTF6?=
 =?us-ascii?Q?JVzrEe1ezv7I9DeRVOkXRD22cSQdCtx/mhU34lr2mgSGo3PzXF6ET7opJw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:29.8238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2ec72c-5b64-4c90-0490-08de0a65c22d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544

Add function to reset BHI mitigations back to their boot-time defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e765ac0b9240..67561e5c2154 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2360,6 +2360,17 @@ static void __init bhi_apply_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_VMEXIT);
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void bhi_reset_mitigation(void)
+{
+	/* RRSBA already cleared in spectre_v2_reset_mitigation() */
+	setup_clear_cpu_cap(X86_FEATURE_CLEAR_BHB_VMEXIT);
+	setup_clear_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
+	bhi_mitigation = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ?
+		BHI_MITIGATION_AUTO : BHI_MITIGATION_OFF;
+}
+#endif
+
 static void __init spectre_v2_select_mitigation(void)
 {
 	if ((spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE ||
@@ -3954,5 +3965,6 @@ void arch_cpu_reset_mitigations(void)
 	srbds_reset_mitigation();
 	srso_reset_mitigation();
 	gds_reset_mitigation();
+	bhi_reset_mitigation();
 }
 #endif
-- 
2.34.1


