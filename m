Return-Path: <linux-kernel+bounces-850737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C35F5BD3A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E8F3E355E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55D930CD8B;
	Mon, 13 Oct 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j0RXrwI7"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C683090FB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366158; cv=fail; b=iZ1/BbD3tRKyOIBxwTQB0yJB28tHpCQvWA8jLR1+tAqDguQG1NbBiBIsaA2iJshCCWWFIw45tZz2Pl/IEPRLg5W+pcfBr31QPI8T7DmbPskAHwLawEZ97sovW0BxEAfuVFIwOYDrDOic9AqyVkVB1Wm066joewHQg/LaoTNgMGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366158; c=relaxed/simple;
	bh=C/KtUEUHzlOvTynESaOS4tkML6kExob+y/0Miy1nN84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XO6K6lDzl+bz9AQXfyf2oxE3ch/PDrygk48wuBVGaIHRVF8aup/1lIMVy4CXituEmd4/+idsfCf3iJP32faCfcBuIWqyWpzPEBuxhW5lX873ThzzbxEdflQxellAsK1Fznj1kHMLw29rJxRlHgV98zFJxgQDhC+eiPK4LCY+Hr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j0RXrwI7; arc=fail smtp.client-ip=52.101.56.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaepYwaE+A39v2W3bx8glj+ZmA/7bkc9Tmlb9i0WHLWuTHcgtOH9dlwMnU3pau85PnZcreG2SjPb+Wij2c9lpSdwrYnba6GuTKat4wjCS7YQgHhTz2i1eEbF0AG5flr8fxtGiDR5Y2l/JH4BhQe34QHM+wHUrIOHFx5IHJ7BIC0sIsgbn5dakgaxEFP8lKGMDsbzXK4n26os/MWQ04XCJmPxsq1rikmWDtnbwdnUjG/d/73gHlSkFL7FIG6JewT3x95ynIrt/pDFsxPoH03KSQP2hHMffnQeiWdqGOT+PCpBkdPA0M6c64Qxm1wQQcTFjEVano0kuJFpeEg+lFbk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbCFpsUFF7imEsdKB/3boU7ERFIZ2V/HeOVORv/aKxk=;
 b=RYrcZFc6Y7CKxFu7IUqB/70Eo4Zxv8VnawDkFmgW3hJNsRki7j9kakBuiUaZgSheTJLHSSjXmkwNd0MCuy7yNDpdn5Fh779SCnSgSnW5qqc8WbKNPBxB3IRqO9KO5g+5kAPc35OM7iCEHpgavfAqbZuc3q/9hn+vfLZkVoRnz0ZEWpr4kyqj9KbI4B4oQLVGnODF9yV49vVyF9ANoSSGPCTr71bzSvwyiRPfbXRg/p5vH+6BMcVm9VIYlhYodH0GNMaRTOo/lZ14Azq+/QRVumpd+cwXLnrxmKVV/B82Ogmab9O7o5BaNAv6/OS6Wq3uco71QaZWJu+vZMbITg28aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbCFpsUFF7imEsdKB/3boU7ERFIZ2V/HeOVORv/aKxk=;
 b=j0RXrwI7OAH4mgnffXutBdS/E3+iQU5Mux7Gh7ZXaYEx8PXV41T/RABZE8PLnmhfpiMq2/qIH4YJOvhVA4AqZIAI0T7tNVW5ygt7Ml36hRL437BpIf593Wn5irJBGE+Z+2p9PcE0OorIapynTlDQdu3i+TzCAzjaSZgNFD1GU2g=
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:52 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::c1) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:52 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:37 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 27/56] x86/mm: Conditionally free alternative sections
Date: Mon, 13 Oct 2025 09:34:15 -0500
Message-ID: <20251013143444.3999-28-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ff8443-75c5-46ab-a035-08de0a65cfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KlBrC6eMVQTQUNyLMGh/njtxD+3I+6HBTKgvocJOiuOx367AFkH1nq4lfHzf?=
 =?us-ascii?Q?yI8Gfdo+PusiMK3dvDJLgnP5InL4IEGLl3urRvjEiU89pumTPgqMxdr71Pxs?=
 =?us-ascii?Q?L549gLWV5ALaLifk79bHmfZCBuP9Tp0HfziiXoR+qXEXDeJIK4U7KcwGDZlg?=
 =?us-ascii?Q?Ne+N5zikciSOqo5ZfKITM1Wg/XpnSWlPgSClLa9Dm9sykCszMbs3yobmpRn3?=
 =?us-ascii?Q?oAXo6gzLaYG3u0XaKxRSjd/cn18hW3S7o1des5+MKFF36EUObWoc10X2DeHk?=
 =?us-ascii?Q?LxsN4e9BbA/erqGDgv/pmlPbNxZeFXxKRsbYNz/Fhk/Znip9Cj2FM+aIXUwk?=
 =?us-ascii?Q?oFv/MVqgO0M0bGMYMbO4puPlIi6fESvU7w9d50aaRtjq+fYhDZ2yF2z2QUIY?=
 =?us-ascii?Q?JICmyKGzWKdwLVIfM8iAX3AUyL5ZcibfFWAlF10nZO8llxemvI42Qapx7YOj?=
 =?us-ascii?Q?U3DDm+5tNiWLoXmhRVPfneAW6L08I9y2TExaA2dzRNh3Egz7Epe/mmjYUpLw?=
 =?us-ascii?Q?gjYREYfYoNvmRnivUtkHPDYfajUblqpb1qh92JQZQydMVdMVhOSHXxg5Kdsq?=
 =?us-ascii?Q?iLBdp8M5OxQk36quVZGWAZmqh/lW6derzGGE1Wx0QP0WpmrRp48Kpx3BkFBn?=
 =?us-ascii?Q?suorCkgB3TDxs5YEQkYHpczVUE/fuFX5gucuLJPW8cpeEdB7Dx1wzK1ExwoH?=
 =?us-ascii?Q?mRq2GnAuABaEe1t9Nz3Lu9hpfQ9XdOxhuIgTIDgWP9jvVX9OMuFQwhtEqBT9?=
 =?us-ascii?Q?blFNVwqvsXMzrl9Gqsj6jtCuruGZM9kxA8duQs99lJpM9zzSsBSa9hkqI33x?=
 =?us-ascii?Q?pm7plr4VfsAGpIFZDzLH1kCT/O7PHEYDgbUpPfBk0YIcdkF8LzSb72i5AvXL?=
 =?us-ascii?Q?VuGInkz4UKio5bmujfZjEhY2zYNIp01HE4FSoBCA58/nw/+5Pn9ySBxGDRxf?=
 =?us-ascii?Q?P+s3WOWUZDhJWWDrlYiGuGiLpmYmO8UIE6Cll/VRnTWt6V9IJkQaW6OtuA4R?=
 =?us-ascii?Q?iKcsXfhyXimO6byVOFh/3eW7fBBcIQ82kD2UlG29w2/wwL38KB762zLa/IhP?=
 =?us-ascii?Q?RVJk0kaYspNL/uB2yhPYKd7wvF02sbV/UOW2DZsCkWLGYWXmp+LJyIVQea+I?=
 =?us-ascii?Q?V0GQIkUavwWPQhjaaftBFbZpQePtXKXPqh50aIbFpw1Olc3vQrUz5FSkj+Df?=
 =?us-ascii?Q?nXFoH3uKTXj6L4RvJJPgcLQrQghyd7iANEJvYjKudhdYPK1DzdDzrJpCevh+?=
 =?us-ascii?Q?d2DHNJuFXV9qVQXYW8qFd0ob+Od5rx92Qp676kdxIU3zUMnpxWivUa9Uehls?=
 =?us-ascii?Q?JgG2jleyGaw+X57mz84+Dl6MpCT+JxLo2c1bSlP5VsEIrgVKQiw1pUz97sYi?=
 =?us-ascii?Q?DjPDeH6BtesIuwW5MqHAEsjw6/9QEi65xs+0OLjX87HfosIVeBT7bLwHqA0p?=
 =?us-ascii?Q?EutTqpzuVo4vSGlPKXLqoImeP4LnPHXIa99ShuSPJRquu/d3Zc6IVu1LDSVy?=
 =?us-ascii?Q?RbKXR9vIBcEjiAE5qdjNZuUtmX1pB0osKG8BxH5vgl7ffUBGybOx9K6XPbje?=
 =?us-ascii?Q?t2PJQF9ngqzhvblDf14=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:52.5797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ff8443-75c5-46ab-a035-08de0a65cfc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599

Keep the alternative related sections, located at the beginning of the
.init section, around if needed.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/mm/init.c        | 12 ++++++++++--
 arch/x86/mm/mm_internal.h |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8bf6ad4b9400..8dfde4889a09 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -977,8 +977,16 @@ void __ref free_initmem(void)
 
 	mem_encrypt_free_decrypted_mem();
 
-	free_kernel_image_pages("unused kernel image (initmem)",
-				&__init_begin, &__init_end);
+	/*
+	 * __init_alt_end is after the alternative sections in case we need to
+	 * keep that around to support runtime patching.
+	 */
+	if (IS_ENABLED(CONFIG_DYNAMIC_MITIGATIONS))
+		free_kernel_image_pages("unused kernel image (initmem)",
+					&__init_alt_end, &__init_end);
+	else
+		free_kernel_image_pages("unused kernel image (initmem)",
+					&__init_begin, &__init_end);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 097aadc250f7..e961f2257009 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -29,4 +29,6 @@ extern unsigned long tlb_single_page_flush_ceiling;
 void __init x86_numa_init(void);
 #endif
 
+extern void *__init_alt_end;
+
 #endif	/* __X86_MM_INTERNAL_H */
-- 
2.34.1


