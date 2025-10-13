Return-Path: <linux-kernel+bounces-850713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 262C6BD399F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDEF189FC84
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580382FF642;
	Mon, 13 Oct 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kwrwRBvj"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E75277CA4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366126; cv=fail; b=fc0mRopc+exCy3W2MOBZRb6YlXVtFszAtBqnPYXQ+oUzZZI75QvEMva4yWFeQxqrBvpddb/rQNzqwxI+BBZc67so14ey39pQnfyw34vgjLT4ecYFAhx9qHZKKRYxd2wO3of+RN1xB7Lp8UOdAu5cOlWr8LyvfUgXLbTMtlbZVK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366126; c=relaxed/simple;
	bh=6W5cfXXcKxUUzEoyp+YnlFaFfNsbxMNuDCKAeWJL04c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atkWV3t9bTaJcSnFgz9LNw4Q/oJvUg7K+kK3uoi0lU01rD0qXXuqY3QSsHy3Z28XbAfPYuBoYJ+46sZ+WZXs0XpfpwzulUIBNkEKzqGEPN2b61kYz4PvJcWog7Rq8KsnsnO8V7p/P99rxhOTvzIIDAmNXshQh3ZwioUAwgD5/f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kwrwRBvj; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Otgugg8tpSshNAJn08wwp7dX6Wp6zsWTITziJIsvp7GUqoZe3xS6JfaXpNg04xEMgDA+WNeaCE33J7Ce9NDAPcZhCqbwbuD5OmboUIMu57z5e6QONVGioAxhwC++N9kq9eCuV7c5OAs7+T8u/mGt6aU/Q2+swMWpHTz9evEbp/itVy5ke0vH00I3aGa6xDGa6URJ2uqrR5CvFZbiZZhC4W/f1Hgx8Nokel2XohjGlsQTTixKX2anLGoqXYWIYUs5Mc2rhVKZW89y4fBybuQFzGt0cDzpK4uawX8xxLc8xhqtBgODDAZGQ5UPCoLWkE+5xDget1WyxgNKfZeJ+Pp8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka8rhuthJsOtNPdGiRo/OMLZ4bF/UpJWco6Ay/JGOgA=;
 b=ts9bqQHHbDhhpZuJzOqxOkWBm/VL4zskx6BQLLuiMztFsKR7QcQ4LSvxjhfLCZ0KMNofHlfoAnXx6u0dETQKIfxGunxUDPkl2TLpVl0lh+5Hss9wNXs1IGgpDrS3ZrjIUZ0qTWP4WRuwKwXGkUphFKus8W7j893ki3wXUhrCJqu0P9H/Os5B5New0XZmQSH3cn9KMZ3p4oAsMJ76su9A7O+QJqR2cMJ66sTYFVJ8KwqUOTu8Cgsycqz7jtwj09HUBy7/SBln9UUzpWGifeKNWXdWiAMxGYDi1FfN+QQDBmXdB0hwoZgk0mFKYLfvk/pv/jHbBDvtMTrCcERBYR2qkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ka8rhuthJsOtNPdGiRo/OMLZ4bF/UpJWco6Ay/JGOgA=;
 b=kwrwRBvjaOjBllvce7ZtWcjD8CKgPWky2TepPI7aVUUVn7bE755RyYkc7jOa2qgUDcQirsYHQWQIOkd7oiBpahE50n86qCQHVuYB2DX+tSRTxoqv2L4XKo4KteseewJn4A2ZTtAOu9GVGCTsdDMJhn1q8B6PQQLFACIpP/jzDQg=
Received: from SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::12)
 by DS2PR12MB9822.namprd12.prod.outlook.com (2603:10b6:8:2ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:22 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::5b) by SA1P222CA0124.outlook.office365.com
 (2603:10b6:806:3c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:22 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:21 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 07/56] x86/bugs: Reset spectre_v2_user mitigations
Date: Mon, 13 Oct 2025 09:33:55 -0500
Message-ID: <20251013143444.3999-8-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS2PR12MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9c9796-2383-4816-9aa4-08de0a65bdc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0vSVwov+jFS9ZE18nE64ZP4UqyUzB1r9B/YGkk8H6OKKOdKZpraOggaEOOby?=
 =?us-ascii?Q?xkvIgKRVRCdMoTXFSISJoGtgnk4oiqE3/UCRSZYy+XozGOWk540I4iP40EwC?=
 =?us-ascii?Q?uTQ8C3yUcXS/1plZyomXBeoZQSJsFTSihpfLrq38ei2lmov1NjRGD4vWJilL?=
 =?us-ascii?Q?oNrl8QiXfzwh1EN1CBQwn4v4PnoGhRkjPx3jhgEEs5VFmsA4XPsHNK1H0vJj?=
 =?us-ascii?Q?aXwHQmcvPeuuiNEVE3eoKXDrv5K/yDFxxR4HwTx4GaYBTGZHoIivBik6pcrf?=
 =?us-ascii?Q?Pfm1tJRTKOKPj3pjGW73u2L6FbgM4dc5uAUj4fzg8aMMQIW/COn2ut1kMDyz?=
 =?us-ascii?Q?JRxMWuTsi3J6RZ5iXpfetJAa4PPdrLgrQuBGeReGZs9PsZYZSJMcQwpfHtUk?=
 =?us-ascii?Q?39im0u6ldZp0vYdNAKKV5X15f1XfHKQtC8al+lc4zA/0zHGy1pu5Hd2xNfa2?=
 =?us-ascii?Q?CJ955zu61ZPx30HHg9gzeYY8S5sIE3p/kuBv3VW7mCJzaIu0Ut+8LQoRM5Pv?=
 =?us-ascii?Q?G9y2+BugKTR0GBBvljzTIRewM3p/mDbJwlRuSatd5JiaCHjRb40g/RRszRZ5?=
 =?us-ascii?Q?nQ9J+I8hMNlOY2UEql8W3PjnD28I6xo0tT8sppkRKzy2HcTZFNLBdkR5e2fm?=
 =?us-ascii?Q?n+0Fteicrxhqx+3RSLmOMizFmLA6EAaw75nof4nBSxILvI6/PGs6i8YCJUCK?=
 =?us-ascii?Q?7NwrXrsN1UYhFFhzSYzOJhlsIxbcU/f/BoNcokwUxLiHxKmDGoR5QnH7zCPS?=
 =?us-ascii?Q?7abHrAL86GNnHX+KMxaWwdAlxAGKtUiAdH/xAZNRWR7aYVfC8vxSXvfL8aBQ?=
 =?us-ascii?Q?M1agzPaM0j9wKS1RfLhfN74nyE+ty20N8EEmiakCsBNokm2PdGl1ZnVDogia?=
 =?us-ascii?Q?0RVktFk06vqV/CKK1letZxicQ0tsAehhsN6n6GmhGoK0K2sJC/ntfN5duCdP?=
 =?us-ascii?Q?IIGzDGcDi8/MQv3zbINYN82cnAvQA0mQsT3PlIolTQ5BgsXTgdFreYdCU3Xq?=
 =?us-ascii?Q?230s5zxpzPvuxUFwfOprKzf4SbhhIjrdVgtF6IMt3FBZfaB+uZKc9z3weIAJ?=
 =?us-ascii?Q?BrENTKhFzhycj7/1EF3WelW31TRmsOpNpShhkLRCv8E22Rzl3V9RJcMbvKRh?=
 =?us-ascii?Q?3skl57Huco/rh6nEuCMLwFD9o5kNnQx59QtmnnCMdWiDuUoqjtWETP7yGdFx?=
 =?us-ascii?Q?U+pazvrS1t4QAL7SDBWHpGQ7ZF46oATx3NDJZxdR0GjurtoeSHlY1AU6k478?=
 =?us-ascii?Q?E7jmTdRPPJSUpyWANMf5vFc50+4uRnu2RGl+rUmfwKOfT+28yFOrfEfo+GO4?=
 =?us-ascii?Q?+Juol8kLffiHnMSJSRqrbWOrDBGHHrKHVehlq37S48C+87WVEmrxD0xjhBV/?=
 =?us-ascii?Q?BfAVYMijUtJUe3bTavyDVaYBuLSdevBWQy44WW3ioeJhctEmZrkS6fZQ3Ph4?=
 =?us-ascii?Q?qAqy/bfKMphxhK+Rqay5DxuvvILWigK9Fe/sAjxOgqhEudjNNqZ9FRJTWxaj?=
 =?us-ascii?Q?dPWpG5zv4NG069zl5lWO3XBLfvyT0B/jP7IAwZU53gNK0Ql8osKvTJKg8pzU?=
 =?us-ascii?Q?rvUoxvuVakHgiCPipns=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:22.4337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9c9796-2383-4816-9aa4-08de0a65bdc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9822

Add function to reset spectre_v2_user mitigations back to their boot-time
defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1f56ccb5f641..4ca46f58e384 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2056,6 +2056,18 @@ static void __init spectre_v2_user_apply_mitigation(void)
 	}
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void spectre_v2_user_reset_mitigation(void)
+{
+	static_branch_disable(&switch_vcpu_ibpb);
+	static_branch_disable(&switch_mm_always_ibpb);
+	static_branch_disable(&switch_mm_cond_ibpb);
+	spectre_v2_user_stibp = SPECTRE_V2_USER_NONE;
+	spectre_v2_user_ibpb = SPECTRE_V2_USER_NONE;
+	spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_AUTO;
+}
+#endif
+
 static const char * const spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
 	[SPECTRE_V2_RETPOLINE]			= "Mitigation: Retpolines",
@@ -3844,5 +3856,6 @@ void arch_cpu_reset_mitigations(void)
 	spectre_v1_reset_mitigation();
 	spectre_v2_reset_mitigation();
 	retbleed_reset_mitigation();
+	spectre_v2_user_reset_mitigation();
 }
 #endif
-- 
2.34.1


