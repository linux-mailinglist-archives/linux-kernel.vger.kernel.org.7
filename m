Return-Path: <linux-kernel+bounces-850711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB66BD3A14
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 946E14F449D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AEA2EB5D2;
	Mon, 13 Oct 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GXDPqoef"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D6221F20
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366124; cv=fail; b=Dfino3lS29snbHOJPQUe6Uos220O9mOmfC8vssY37X5k05ncVi/Su8EbgCGXAR3oFLgtOoIzmWmCZHJmHR3CRkCHeYxcTE/HYZ6VFlEvfbHv3R2PK8bBuJ4cY41JFjDaMHRG1lvJ2JMSQfQuHAw8JHv9pnSB3o03YI/bCRUb8Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366124; c=relaxed/simple;
	bh=Z+V0VqAiyUiwEPoudOXtIMOgZqXke1PpNE9TTBDXA8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOnpcqLc53fDQDho6Pg/baz/JSti4+viLn4Ln/jl7MwQ2b5eyD8iiWwdquW4UDxKGL1HpG3Hzq7ZE9oCnqRRxiOrndivXy+qKm+RT0esI65AkvWebK4RbRyqGU72gxpqMACXkjaUTlcT6DgwAql9y6bT6G/ECAMhXPoZ3yN/oew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GXDPqoef; arc=fail smtp.client-ip=52.101.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfRG0M2DzIZNZ8gdr8L2MB06zaVxi6bx1Ei9oe/eEOqgfT7ZEk75y+frrSh+IkmKrZCgPrTs29KmVpp4nJiXJtkJWhq5Za4AvbKpqEm7/P2o76ybElb+VoWETzRywXRcDlNhNMy19QUFTthE7gwAQyRLrCxyXBMaT59k+70Sv1lmq3gNI4m9F1MrGgY3YAPjZgDasCcVuDZFN25ibxRm8oXRUWc1QSKVhF738rRsC9tXLHCcrYyWl0rhIsRXLSPNLy/gljxb5xJzHGnXPqTo+RF+pzO592vGV34m6XVJ5IYHF6QjPiEhuBHa6kx1tLCYTyuMhLY8LxMWnXYNsyAeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZw7pUrCjWw5amuu4qZ+TwVr91YONnlo34UrmL5LDfM=;
 b=dbAXzGwfFiE6M5bsAkI0oEMvtOFxOOuxJLhGRngTTnjjf967BERLOCcrd1cIfRUJ1yFXAT4Ds0QCzuivr+LzFN3scr/wuZQxNVND4ieAmcwKLWskga914Spr8LI5TYpfuTnwD1PpNFpFn/CpBD8iJUKuR1Qeiavd1Qg/r/DdBPvMxeo/EaaQGoPV0UUzmwt4eArw+o0aGhxFTcmKQy4lx4q53nm3l7pMaVVLoDEouIatMm62xPzUGt/FkjZhSnJdyd4PHqos5m58nOZvoFR/D6JmpQCZNXmh4yExo/7YcPItn/PeF8o+VbUWbULB3q3nor5Iq2daau/KJVDCJJbcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZw7pUrCjWw5amuu4qZ+TwVr91YONnlo34UrmL5LDfM=;
 b=GXDPqoefW5p4F4se2iRStUIah9pXTvktR15EYput7pa4AvjMA1NP42YiIXqgmJamn9JJjiKeKGjI43pWtAjCb9/Eu71twHd9FuF1yWhUlHf/TJImu4dRJyY6kacZCUAzXzUv4i/ln5adO/gGVwxgM8ufCTgOGEhvkEbu+zQqoN0=
Received: from SA1P222CA0107.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::28)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:35:18 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::68) by SA1P222CA0107.outlook.office365.com
 (2603:10b6:806:3c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:18 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:17 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 02/56] x86/Kconfig: Add CONFIG_DYNAMIC_MITIGATIONS
Date: Mon, 13 Oct 2025 09:33:50 -0500
Message-ID: <20251013143444.3999-3-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: e16af8eb-b764-4be0-f35f-08de0a65bb78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TD9rHBbNb+VHD3Zi+FCLn/Ojykl9pdz9vCu12JHOobz7+zvCbn5ksWGHs79+?=
 =?us-ascii?Q?Q0xIr5WqzKBB7XAbOl/TOpQ4TwkXATpPc7Z7akbdXZ3FKR/Uj7aIhkUiGcah?=
 =?us-ascii?Q?qaPSk/OYA/i4kPzT/yzZx5IhzAAKqUbnohFj+7SKjI3Be79SrAZSwV9hodvF?=
 =?us-ascii?Q?5Q5RWVL/VGm7cu6vShqcCWrR15rmUla1i0u6Qx3VZBZTwsp4U+5x2MUdhNV8?=
 =?us-ascii?Q?Ijrzr+XixUYhsprwT7nqnrAwOf3PwUctJpcZ/NXiwSvdfSfje0BDGPteD5mO?=
 =?us-ascii?Q?5yE7121cIsMOdM9ppwmBPbUhb+21m14WDBY4i/LTaeMrUGiJho1hxFm8VY5R?=
 =?us-ascii?Q?lNdLo2QJK+iqksL0cBWJbkDIeXytF6GS6qBr5LzJY40oS/I3eUQQ0HakSMEP?=
 =?us-ascii?Q?0qL3gWR1XxPnRA+z4YTgJKQjQ3VzH1XcRC7m8W3upCeNlf5D09s5D4foV8oc?=
 =?us-ascii?Q?lB554hM3SI9xRKA8gQytgHDncNsTqdM0mZ4ArTwHDxm3OJcJGqwn7RnTrQlD?=
 =?us-ascii?Q?n//fu6kyFrM0oFoG5+A1/aK28getK5kSaU9LZXJvFkZAKchiDh92wXx7EO5l?=
 =?us-ascii?Q?HCxijzjq3vEz4OL7pWTfPePbqmKjfpIhhKVvFumCfsu2iqabODbi7IBuKw1z?=
 =?us-ascii?Q?hcuZW7o5ODxXwDZzScIiFgbP8cajXqfCq3heBjqE05PMfAKbvPLbNWhy6smL?=
 =?us-ascii?Q?qaRij/zqSWRxGJUJwX7N/YxW/XaO3qOndzJqlAOQUVVaMAelcozj9905mVws?=
 =?us-ascii?Q?6Fl033EgqDAoT2pCgP0n5PuzNtbiCZiUN97WzKSkM+XHSAYd3UrhX18bA1Ok?=
 =?us-ascii?Q?RV6351afB5XcThxZUl7Rv9MFMSvgoFKbGDRt1UfgW+qun8zPLAySnzlovfD2?=
 =?us-ascii?Q?vplLykRHDmb04MFLgVKuQcjtSmSfagt2SWNmoT/u3CQ8Wi9sym8RKBVsPGCI?=
 =?us-ascii?Q?Lv5eEdcwtg4NAGDiiKUFRFbh80ibzoWBinKaa/QTLKalQqlMVrMLb+F2TTht?=
 =?us-ascii?Q?sobZj875tHTHCI7fBSJayNXl0lmMiYX5xv3UqgYH3UaxrT3aAsyoJPmctZWL?=
 =?us-ascii?Q?6bslmltcNM1x/r3pkn9fL2wBSnLAADfbAm6E8sZ+r/rH4hKcI6J2zVhg2Lms?=
 =?us-ascii?Q?5JpKHXW8NXfOjtAWnoBIS+iseDrumcCUzaVGa8ZqKpUPZGLK+tQpfdF6KUoA?=
 =?us-ascii?Q?MTX7m7WWSWr6OgkI5y9DTFYm3wJSxv76IDVBy/rz063cBwiQDDPjaeGafFWX?=
 =?us-ascii?Q?HIICF4vxT9tN8u4iepwIaWnQVvhbIZ9z1yZRB39ewkSK2YKujjo0q+NuqiKW?=
 =?us-ascii?Q?N1+3Jatfsr/Cms3fBXWrQerhyNEcn9XNXfKJqz4HZfpoJNMBj9M/408cwpG1?=
 =?us-ascii?Q?E7lPV/e/Fjp68+A6kTChQ28La98EEPhtup1CoSaJzbjzuhIbCo3JGW6wCIK+?=
 =?us-ascii?Q?u33bE/XtLq0NJWCzutESG1WTLNmu9e1v7VoRY1m/uDeXocHZr2Lz0Fwl3vVa?=
 =?us-ascii?Q?hmaO/GaddwPhV3Lk9ImvIONkiJ/pojBR3nYbRJXS45NlQGkBakK0KaOsFtYa?=
 =?us-ascii?Q?QJQ9JW4nNSh7xVkWAIE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:18.5829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e16af8eb-b764-4be0-f35f-08de0a65bb78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

CONFIG_DYNAMIC_MITIGATIONS enables support for runtime re-patching of the
kernel when mitigation selections are changed.  It depends on
CONFIG_LIVEPATCH because it needs modules to preserve all their ELF
information for later re-patching.  It also depends on CONFIG_FREEZER
because re-patching must be done while all tasks are in the freezer to
avoid race conditions.

CONFIG_DEBUG_ENTRY must be false because dynamic mitigations relies on a
non-reentrant NMI handler which does not unmask NMIs early.

CONFIG_DYNAMIC_MITIGATIONS is optional because support for dynamic
mitigations does increase runtime kernel memory usage.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a..0c8c1e508223 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2711,6 +2711,18 @@ config MITIGATION_VMSCAPE
 	  Enable mitigation for VMSCAPE attacks. VMSCAPE is a hardware security
 	  vulnerability on Intel and AMD CPUs that may allow a guest to do
 	  Spectre v2 style attacks on userspace hypervisor.
+
+config DYNAMIC_MITIGATIONS
+	bool "Support dynamic reconfiguration of CPU mitigations at runtime"
+	depends on LIVEPATCH && FREEZER && !DEBUG_ENTRY
+	default y
+	help
+	  Allow CPU mitigations to be reconfigured at runtime via
+	  sysfs.  Dynamic mitigation support requires extra kernel memory
+	  to keep around alternative information after kernel boot but
+	  allows CPU mitigation settings to be modified without a
+	  kexec/reboot.
+
 endif
 
 config ARCH_HAS_ADD_PAGES
-- 
2.34.1


