Return-Path: <linux-kernel+bounces-850727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBABBD39E4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792FC1882416
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9309930BF73;
	Mon, 13 Oct 2025 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VevczCbS"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E830B529
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366140; cv=fail; b=otdDP1vYTXe1gw4JivjxNs54sUhcP8xBNxUuO117MVurZqab91+8hYuu0RUPSiqhhrP2dSVcTEMqYQVFAkcyL9fHbqMi0zcK5UU49yvUhPBOZ4DtfhqtjG5QrJbBMPw3CyCoYndqX8pljo+2LlJWgHgXjD0Pp+Pp4LU2Vg7xmSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366140; c=relaxed/simple;
	bh=J7RUu4OlbexnLJJ7j74UfcXk2qtS4z0F2YInfNn9Cbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U56Jh5rChLDr/qgzojK3NI1PpwE+8Ofz3ioPNy9a2EBcsPOzD4sHiKhOqcdPdplzEuSjouN/045uqhNsR8RvIfsnxYNMwO5pG8MDz74QVvKoneBRoaoLZKkkdPVBySPjfbtkGe8ukGzjYGh0QZ2So1TZSKK037DRkG17wUTt8Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VevczCbS; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6vMSOEqsWTa+CdunSBPbRS+08uW9FyUR10AJyxf469c4qW7QyK4qi2gOBTWa6YzYJTOCUNAMA2fZa/0265jgFZPsdlpO6jK7dfJgCg6QccvOA0FXAkDGp8/ABKOgDikWI0mmaxKFfbuiZH0VIeV8GgytHbHeo882UmR28AtbFWUuD5rmxbpWitz00a6I89hT2Ic0pwtVwaQ1tklZLjuTX29htvblukSAOZo5Dt/uZVoNt5vQfQTP5qidDBo/sBRa4NQooRpW9+8nx2FviEVoyf8C1gfF1wKfjvS0CxoCS9vwo3UQEsaz2naZ1nQWttTN9SwHojcWQML+aP61Q9Img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXkfqc+kyf8nXY7RtEJsI6fI8upHKGcLy4ur9yDjm8E=;
 b=KsMYLUkD8tO6U68j4ZxspwPvk9U4IuMk+k5dOlmVglGCgK4ZVG+aFFSF5uIWNdyKVe7GTUcWJfhYjPMWSsygk4h/KsoiiMk0qRr4Pi2Whsocw+3GMzkyb8+iD1XiwiMRxzcaZHDRyMKIV01gZZwXDTC/0K4VDeapkv4ATi1qFtX8KB1fnh05JzQVsjGPqiMKETTJxMfQZUYxkFWidIo8z15qCvGAtYURiLzad1YlH45e3R+tj2IHj/u3c6KckVbc/tPYdYVRTYLaJw374P1O6K2+u9F0WFZ9vn4qx6XR+39+D7vojnSD59yr7wPyacQOaQAiSGtm5tqxP73FceLobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXkfqc+kyf8nXY7RtEJsI6fI8upHKGcLy4ur9yDjm8E=;
 b=VevczCbSqkr7yxCzbVXhNKFjhqsZwCUrJWM2LLMfhhcNqVwUsGVpjm0vN7yQHKITRiuJtjYWp9/Arc8qI7BVBsfOMyJImh/Gv/1wisUAbCwZYRlQBRqvopPbCw7Qibe5sKW/H/03d2Jck1R+dOBzX17XRxs2GcD6nj6pOSeMOk0=
Received: from BYAPR08CA0071.namprd08.prod.outlook.com (2603:10b6:a03:117::48)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:30 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::56) by BYAPR08CA0071.outlook.office365.com
 (2603:10b6:a03:117::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:30 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:28 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 16/56] x86/bugs: Reset ITS mitigation
Date: Mon, 13 Oct 2025 09:34:04 -0500
Message-ID: <20251013143444.3999-17-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 95684c35-85b9-4335-e3db-08de0a65c25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DNVc2Elt59kZiIO+nHcE3gre94ZWEBDctB6OVtSFdzlYE1MxQtSfLlKnQTC+?=
 =?us-ascii?Q?qG28A/x7rxkrwWru9T/S82T/USOeGEdLShlBQRDbvo5Dx9qBaoqlg+NOcO8S?=
 =?us-ascii?Q?DdIpKAohUCF/h3SLYYqGviQldp/SxuCQT+K3PTj00qYNvSUNwL0u9OIk56mw?=
 =?us-ascii?Q?5KfRKCayREKV+bcQYyWOQnvZgEYsc8Z6etlZ7Q/vBN3HCPGfhbt7s8HWD6DV?=
 =?us-ascii?Q?ySynwVC10LkKci6LB3m/zMy2hS0MqCSNilQ21vFM7nKxUEM99fstaCX7T7KD?=
 =?us-ascii?Q?7ge6oYLxcxFx/3u3Y0Apod6XHt72bAzgWnV2E9ZZWFHDIGm5tuUcvIPww/BV?=
 =?us-ascii?Q?Ra2mtHx/UFtNgK8VI9mUN1uy2+S6BOJtD+kn/RWljgWSZLXalJbiN2hj1gMp?=
 =?us-ascii?Q?AvvKL+sc1/pCU7TmX/+05Xj5eZGI2Q7WzeueStBoxXUpe6pBX7XtM5+GVKqo?=
 =?us-ascii?Q?SmW1W2OaXkydIJsj5DhyYrvGuceWr0MAgbCdN2NdMfry/+uH/DhHqkWzLj5v?=
 =?us-ascii?Q?HQQj+WT0SvVybD4PqlTG7QOpErZtb0zO9I4d53TmBbOMRVZ0m7Q5741Bt+/U?=
 =?us-ascii?Q?fvvku5jR6PuS6LRs2kJ9kB5uTbSrXsxtkTamzF0gx69lsJxFjuYl/yOBRGjr?=
 =?us-ascii?Q?nGL07lPgtD40kDEpUXaC9jPy3wO6XCiVESKkjwxVXlZ90vhhBikNsAxRfCnT?=
 =?us-ascii?Q?6RPoJweUKwwyIVMrY/z67k1nuDYy7gF7VsQEkGG5BJeyHLWshwGnv10v7thB?=
 =?us-ascii?Q?UrvaWXF0pfsxJa0P+Qo7UIKPF328bCrRP+CGvVFPQ9TzxfYNlOtzSfH9YqKr?=
 =?us-ascii?Q?2yrd0ZfQHFbEBjdkCcYjAmIH6I8fV5hpwiz7R1B5Uk5OaPWoUWUFxEjOvMF/?=
 =?us-ascii?Q?bvkUma6CILuZHa9lBCfXlZbLp2bRpiRu49xY+oXXR5qTEa/YyXVFfrA6hT7o?=
 =?us-ascii?Q?s8ljGprGmgiUg1RV/oRMmETGzSUrRtf5F8NaiLm/MU032hQAbJRopm+jgT4n?=
 =?us-ascii?Q?rfEKZKb5iHEPFnO0UMmc7/nOusoUio5ebLqAH78etRUfjEkPZQuX2iHCqM/8?=
 =?us-ascii?Q?EAcxiIfmqId7qKjE9t2TdANDJ9uBJsTZWgs3ehyLYCdPaw0/u2ffNbuNatOC?=
 =?us-ascii?Q?+u6rGoloEVTfmnvvaAaUsZ+sC5IgUp3ulo667C1LwzAgGazi3N67UU8uzBCI?=
 =?us-ascii?Q?afdXcXlP0mQ8iztYlG5XF5V/4/rGpyeeo1RpZgZ5tcDHpAbSHMGnXubfFqKC?=
 =?us-ascii?Q?IolMXz2CCeMDxN3AvvjXwr9XQh5ZuKe4Na7mGxw2rpHPLg2bAP/PyFt2+Jp/?=
 =?us-ascii?Q?fE3Cko0T7Blrp8+TuQsphVLKMFokyQDmzYTB178D3NzUEf/5/PiXhjLZ5n3l?=
 =?us-ascii?Q?R77Rs0AKR3WO8Qy0b/s2q4fLk/O9QT8oeev/F04O5XacVLAHjReYqxembDyY?=
 =?us-ascii?Q?PyTmZK7bLGXUB6aEbSlMcS/ggG7Ye5Rutxptd8v+nO3bSAWBKHubVQoyU2/L?=
 =?us-ascii?Q?3BhVHeOvV00H5SD9p2Ds2YcfAH+8clJbVYfRYMLeiPMolK44aYxLqmXqi4n7?=
 =?us-ascii?Q?ac9N9Dab5lRqr7e76X8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:30.0822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95684c35-85b9-4335-e3db-08de0a65c25f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920

Add function to reset ITS mitigation back to boot-time default.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 67561e5c2154..bf5de097e1a9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1744,6 +1744,17 @@ static void __init its_apply_mitigation(void)
 	}
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void its_reset_mitigation(void)
+{
+	setup_clear_cpu_cap(X86_FEATURE_INDIRECT_THUNK_ITS);
+	setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
+	x86_return_thunk = __x86_return_thunk;
+	its_mitigation = IS_ENABLED(CONFIG_MITIGATION_ITS) ?
+		ITS_MITIGATION_AUTO : ITS_MITIGATION_OFF;
+}
+#endif
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"Transient Scheduler Attacks: " fmt
 
@@ -3966,5 +3977,6 @@ void arch_cpu_reset_mitigations(void)
 	srso_reset_mitigation();
 	gds_reset_mitigation();
 	bhi_reset_mitigation();
+	its_reset_mitigation();
 }
 #endif
-- 
2.34.1


