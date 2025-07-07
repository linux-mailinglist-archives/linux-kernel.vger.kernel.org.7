Return-Path: <linux-kernel+bounces-720366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B95AAFBABD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C42D426297
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931A926A0BD;
	Mon,  7 Jul 2025 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ArGKdPDy"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA39267B19
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913224; cv=fail; b=brphN7gyMyY5bVmK1adsFnnUpd9DaHnXp70tASmIEWLJI9d5yBXLaWQbj7uBs5ChzwfTLe9XXMezNuOUqixvNw3hczquzIKCPWcFjLa1dK3YRzn0KFYTDSGq1iy9/NnCiYNTJ55CgPTM9zkzVjx3W5NtrlHDKph0rkyNr8qQ4D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913224; c=relaxed/simple;
	bh=ktOZQp7nXPYdvXXJ4zeN17TA88W9OurB0OPGt9J8qPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEgaVSHm3jU5IzdvMsyQTrUYCAApV6D1nGH0kWowIp91EsKjY06OnlEegsBRkcjcD/q73lI7t3sAq+U0AXM305NUJKrk6KkVTGZIYo/Gb+1Bi26aKa2krl9c8zBYa6FTrJGdBN5o3yO/YeAA5nOHBpTM9upt2/4PEzmrQplQGm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ArGKdPDy; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buYcnP38OPwNoJTdYo9VDg7KGI9qpO8ViD2p7bsNGbmtZiHuLd41kHUIcFr8D6HWKgbOUolSZ9SXCxb/MZIG4T6Z9JdX492QavGUIaYzRDj1gHe1gmWk2FEZGbd6WcC1ewJBa9A7Wkh28dOWfkjCr3HhW2EOIzgaP3+P+rUzXEijr+EKmDefkk9D6n8YHxU5OQZpOOtOQOkd/MtAuWwZxHwB/pz6PT1Wk1sFYbITpqrvfi4Ith2roNkL3U0f+G5bHYI8YPrA56UhicKrNNhQ+GHzVTZ7+sUI1n7pI8nhpCkTHQTkKs4CHu2CmLet00Gex/dJ5uoahkkt44YH5T9mEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbaKZzyQnysgQNXXUovBpJSGJe50o9VIWs/EAoqOalA=;
 b=mhKockofw4trspWvVBJptgtbSH7sjwTpK+N26oSIWqdH3XBDKe+D8x7qE63BeT1NnODBqSQGgLVVkzlFrfXbadEVf3UmTMJrtwauRhjSCWIksN9QGxPVDrNxwqUIN7L7CK1zUakiIgaswRO8h3nJ+MLjBLQU835cNuZq0JonDBtOT/FurdVzqHJ9kv6AQfUlzjIBKatHjg6M7iGs/kOqcoqRAoEiYRzhg4VqxpXz8SXg3ZcDxcRgn0txwWWnEGe4rMVLHBGOji8cWd72hzRdgQwkcf6v4p6qS8mBPcCnInJD7ytXpPo5T6kT3IjlruAciCBL8U9UTvnO9bmUOIpEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbaKZzyQnysgQNXXUovBpJSGJe50o9VIWs/EAoqOalA=;
 b=ArGKdPDyjkAVguwpXARtHIP+Ye5+4Y9mA4SOdOY01/YL9+PyfsNkcDdNfk4gVMJ9NBbmPsTyri4e/rF/oo+W1EivRZ8K3Ox3GblXHpn7XMR94njywtBpDi7dzd/10zVKEXo3Iv3IFG+ofuSGM5g0G4N8o4e6uAn+QVmvT9Fhvqk=
Received: from BY5PR16CA0016.namprd16.prod.outlook.com (2603:10b6:a03:1a0::29)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 7 Jul
 2025 18:33:40 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::56) by BY5PR16CA0016.outlook.office365.com
 (2603:10b6:a03:1a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:39 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:35 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 11/21] x86/bugs: Add attack vector controls for spectre_v1
Date: Mon, 7 Jul 2025 13:33:06 -0500
Message-ID: <20250707183316.1349127-12-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707183316.1349127-1-david.kaplan@amd.com>
References: <20250707183316.1349127-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ba417c-1578-44e9-9dfd-08ddbd84cb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aqkiEILLps2vPQRSpovtBmBiouTSJy0Hqv/DO5WBbiAFg/e15wShscRHoU31?=
 =?us-ascii?Q?CctK6v0qguqiUUpPSxLjofGr9rev+CmKV4MSfSKeX8hX/JOs9++it98FHznz?=
 =?us-ascii?Q?ZU835wHwgjipiSRdkUCocH/fJwbfvOx6jWxACy+nD/7Xgba5WaWcIowvBiGD?=
 =?us-ascii?Q?ie+/Z//O8OoVlapZKk6yr3MQIRrgYYpAjJ/rUiTOAWs5UtLmF0PBbgCavzHS?=
 =?us-ascii?Q?hVhW24/jZS6Q/DR/I+X0WISCDIbUbb94RXql4Q8jriXXinvszpQPkjTEoDvA?=
 =?us-ascii?Q?bmF0zwDQQm4Y+dI55LR95AGUSgUdzi0HBS7IUuYpdjSf0dF5aTyWu2/NqNYV?=
 =?us-ascii?Q?Xblr0oBDh1rrs9BcQZFZIPjbMjQ/3GU8WCpGaigGRLyv1Gut+OppSauVaaJr?=
 =?us-ascii?Q?FZ457smqQ81G/l/I6T6zkhES3H5X8f2sSPrBlVKSSnA+0LHLrUyiv9aBrDG/?=
 =?us-ascii?Q?gI7JZP5Bo1ZsVteo1Ll8jXxL0WNtYqJu5WHx3NXvalsAOzpJR9q4igZZyP7Z?=
 =?us-ascii?Q?y67v98h1GcnCf6EMmGlEBsrG/RxJ+/1YZSaj3QWWxhRIfJbnoAl47wJ+4Pop?=
 =?us-ascii?Q?eZqbKdDCBRftff2WheNViIfjOZeKPnKgXwfxWYK5c7aAvUTlFP41OYfvcDVA?=
 =?us-ascii?Q?5Wz/YdZP7VTIhr/s7kq81JWpIllXZ9fgIhh+zlJdkb/U9lV7vaHSeRQC71l7?=
 =?us-ascii?Q?8P4Q8uAOpP0AtUQXhrhX5HTRWYx4LZY6Xtu3X4vwWcX+e6UQzygJtW0c8Kbe?=
 =?us-ascii?Q?Ac0+AdK0+OYWHCe7LDmqWqiioVFi/5bWu8AaAR5fJewCD+56XpZSirzZMMaW?=
 =?us-ascii?Q?7O6OIedkQv6JA09e5xDfCfL3Trl9lKssgc6qWXflJkpSJuBeSr5As7LlTvma?=
 =?us-ascii?Q?Lt+C3IZrNb4SYLMYheOe7vawGZoeUszWAweW1FkjmC0jPf/OShXpa+Y05TuQ?=
 =?us-ascii?Q?b6ipX4OX3+iD0tsUYM+ZQ0thgYcP63Fxe7+wH33NjOB3kKspDXFPR2t2PQTH?=
 =?us-ascii?Q?YByXHvcUJQ3HNnZ1H9Nuo7moT+XisK1z+0ecepJXLofi/1xkrkPqntL1TZvf?=
 =?us-ascii?Q?BsN7xX4q8Dzd9fbq4q0ZhS3mAcifKwLZmaLk+uie9i0NSLvBwQe1RSSDWKmd?=
 =?us-ascii?Q?FEv/MYKI3cuhY9NVpMiFWXUWou6SdHOw2pNa+4bEak1mmi7juRllaWLyAViZ?=
 =?us-ascii?Q?RjIUS7bACN5ITmjI9oH/YdIUhGtELadqyueTQ5pML2Y2C9LJkbXIio5YdRCd?=
 =?us-ascii?Q?Bme2wy4b4R2ahOVFNVw0wXWOuKrMoDFysGTECRC+XtX9QGDw3rMLeyhwzais?=
 =?us-ascii?Q?oZrwwhjEJPa0HuIeViITFZoawgUETui/1Xxsj3TJyOjbMc6JO71Yf7oY84Tr?=
 =?us-ascii?Q?TInmg65+6mVZ0knGZNuW7G/9gdh++2Q0NQ1+YYB9P4vMut7r3VVSH6tXY+X3?=
 =?us-ascii?Q?CMPVRuXnykyXU5wLba2ZRkIB4s09Wjuh448FTxDcZgp6H5Lvqn2GDAIeYp+k?=
 =?us-ascii?Q?fnXsa7i/h9he+vGqSKRyKeexmlKrDNo5dWYn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:39.9038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ba417c-1578-44e9-9dfd-08ddbd84cb49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197

Use attack vector controls to determine if spectre_v1 mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dc3f9a2e6984..f4b3d879ba38 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1140,13 +1140,16 @@ static bool smap_works_speculatively(void)
 
 static void __init spectre_v1_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
+		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
+
+	if (!should_mitigate_vuln(X86_BUG_SPECTRE_V1))
 		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
 }
 
 static void __init spectre_v1_apply_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return;
 
 	if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_AUTO) {
-- 
2.34.1


