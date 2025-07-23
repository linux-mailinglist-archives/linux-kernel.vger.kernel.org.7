Return-Path: <linux-kernel+bounces-742948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 067A7B0F89D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40D01C847AF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D68E1F4CAF;
	Wed, 23 Jul 2025 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1MTos+uM"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B4149C41
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290093; cv=fail; b=qRlFiyyzDqnf+N0851W+a2W1cM61S67S5N64XOVe7Hr0o549uVEXYUan+7jy15c9SiFGLB4RSjGh9nntUrHFgnov5AGOXt1scyNNr0qeM+/gxMQL6s5MK6tdysJXyyxNwdZ5M0wTvUGNJOHllg71daQ8ndwKnAF98bR54j8h4n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290093; c=relaxed/simple;
	bh=Gf7pDzPhCaTS7yJrj3HECWYGagutpLfg3fOSOWLz+5Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=llDjhncS6cDNozfq1rbgxo6nCmM+2dVk8ZofzQhcL4To12LtAYilPXHBk4PhYOQr6WFDZ9DGE0pYl3VK69BU2Fs2t366hDtF1qZwSlBen2uYy6sRJUlMHbK31DYvFdBBIASMCq75gMi4GWnOmjcuwc9Q4EljXllk9+Og0yS8Y/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1MTos+uM; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhsodGvJ3A4LxZBcsp1HU3Psva0hbfnWWBjaGcBRzjbCL5H2fpZC322EG6bMjzs0xl+NTy3uZOG24jmJkG4g9pyb8zvqIegXQeZlf7zcxs3+pISqzZun3EU5eKXI71iESppndMpe4G8TVX2ALejz8uQAPbzCZkq6PxrJBkBplQNUMWupeK3VgS7Z5aYD2GEXKxQ4oqb2BB0JECzzh4PKTyczCcSyzYAdlyyVTGjtQgmOq/qun/gJkvurSKmmqJUhnsxxIpXT8vqQiph+YJoxveloPbzIk+c1PyxZ35BPMk4R3c8W6/IPRILcCOpN5cOKv7922NEP09EAu1kbJyxo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnnnNJLvNBPdZM0mSfhDwlDGy+X/e78zpJGKK3sebkI=;
 b=BeN/S+Ikszm3xD1e2lrL+hReuOtpB0d42IcfBq+JMBNbxDKlIjvW9cQkgPMzwqpVYC7P/B7FzbaRquNeyU9dC6AqKw5QKq+CkxNa+yvKyx4DzD/hDuo7uOskkZ0rJ9yx6yDcBDS48+KTAhGodhf9Tl7PLbDtw07j84B3pOGWRWUmvZlXOZMFemaczMtMUHTjF7at4Tc51pdkSZmf+Glkw5TK6/5Ebwlq7rZyWaU8uoh/kroUcSugxGjOrV0pgBGFqRipRO+ovi+UgUvCFOR0HVvQSdWpAQuqTqfl7Ep//jaDKGELOUOlpxT7rR6jF1bqdKPu5lSqU8Fps/2trDov6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnnnNJLvNBPdZM0mSfhDwlDGy+X/e78zpJGKK3sebkI=;
 b=1MTos+uMINrNVwg5hpXVg4zHeOnp2lewv3JonG3dHNUdpjnOUYyhmxAELk7ONrJm21QJJ66+abfZjSi+v7CtTxYbimkA6C4e//oO1rzwBulo5UgElPQrDEZrOoSzV2JX+K/JLtWnSRCPGLLMGaFqzOo8Dsg51ZLGnmc+JCePQ5Y=
Received: from BL0PR0102CA0006.prod.exchangelabs.com (2603:10b6:207:18::19) by
 DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Wed, 23 Jul 2025 17:01:27 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::80) by BL0PR0102CA0006.outlook.office365.com
 (2603:10b6:207:18::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 17:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:01:27 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:01:26 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/CPU/AMD: Perform function calls post ZEN feature check regardless
Date: Wed, 23 Jul 2025 12:01:06 -0500
Message-ID: <ee4e9ea71713cee72bb637e848c6a272f8a9e631.1753290066.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 233f550e-ab8d-49ff-6ad2-08ddca0a8ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0wGFpwl0D55prkVUClADWlcTFbtDOmrwfusGskqayTfLsGDFNKLFveTLsA9c?=
 =?us-ascii?Q?NS/5XAJ9ZLZKyMdps/zGpj4mn1YI+Ndn707tysh2EHrzxKczKrjopUKbsMV3?=
 =?us-ascii?Q?uURD54EW7NkgSeiLy7Mb0177yyGImT+aV/BadUJ7oa0YaNvkerMFfVd0nKtO?=
 =?us-ascii?Q?73Eio2e/Hbg3DF0qpOffrxMPnoK3lUcd3c0FruE6MIASERZY2DwK/Xe3JWb2?=
 =?us-ascii?Q?mZggnXx3lsz8aJ89C+18iNiDFaPGmZ0AFlbkkheOCwAlTj3EmYVUanAbqY2e?=
 =?us-ascii?Q?Odh5Uk1YsaW/qX2euU5Wd8/d2+NEq6Paxc2QAiRDJQYaPuRVUSuYjFwQSfqw?=
 =?us-ascii?Q?eI6vfn0bcaPEjDmeaFmBAEZEztO7BfMlu8sBxSnQk3JqYhPDlkrt3xM9BpyW?=
 =?us-ascii?Q?bXkkJMcrAAP0wmksBdp1MZqUqv1crFnyZ1ulaQHAXMwKpm/SKX6t/gaWJsKC?=
 =?us-ascii?Q?lP9xRFybnrfGemD3QZNlShPHWQ+Iw5qGeZUMWDRkQIDd6FXYvxJTXEfAkz+N?=
 =?us-ascii?Q?UrGqJUQ0OropL7TksT2+QGNlGMWEartZi2EGMwWfwrdfTOGm05LJoRQG+mQb?=
 =?us-ascii?Q?uHgLf9rRawjp6BASt2kHheGAWOAttnAdEykn/YB/PjGNLsSW2mzjolJK4FVP?=
 =?us-ascii?Q?sfOXnJyxzXao37FIuHfixcLIPKZO35iImoFy/Mg8i8ibzyGxcwzKx7X9Anhl?=
 =?us-ascii?Q?qRF9Eu1+oep+nOwMm5xctluTaK0CTdTOp1CvtnBzxuCfaAevkGFczLa31Wu1?=
 =?us-ascii?Q?LaU90dtnp3GF6HOqmy84xPg6EYem2++X/BaqAW6zXZz5gs2RaTZJYth8b0TA?=
 =?us-ascii?Q?Xq6IK9jAf4lBfO78wKbKidBTTPVzN/CuU/w0WEfkTCVJCL2C0pLxnxg4aEHS?=
 =?us-ascii?Q?NZPgAIcPNPDYeyOw/yXbnEmCcm8gc5w5j2NgWcoh7gp4j7vpSezV/CpULcoc?=
 =?us-ascii?Q?n+82xm5cjGZwuB8jy+fyiHnhDuSrCe76sG0wYCszTilE6+hnt904yp7Ax88P?=
 =?us-ascii?Q?Fl5UCveYbO/bWJLQSgmBt4hWS1cQjEA6awd8Np6XoIoBqomoVkBEablt8NtP?=
 =?us-ascii?Q?jeJjqH4zOO1xXUieC4vQPTSAC5F4//Wf3uZGwLuxccN3kFxymHoJLWVAmEGO?=
 =?us-ascii?Q?g/2TQcGfM7P1VyMQ3XsR57ExcdAF3xxh6dcP76f1zoZ867eU/foeRLmQr0WG?=
 =?us-ascii?Q?SFU4onQPtysxukZUrCArs7l4v14oY0PH8LAyuvDF70Ce7xGF6Rkeil3SYOG+?=
 =?us-ascii?Q?W2ZN1XNn59MykTPHczl81+kOHZo+8UaJBbwklmbVHrAyAhuS/LR9Y8x/d0+M?=
 =?us-ascii?Q?LspmtCdbMwB5Gyz43GydWuRzO3xS03O+kxVqqLABhvWegbw0RG/6OQDPSmiD?=
 =?us-ascii?Q?XWqR6+FVyAN/tSS85LCcrwZzXAiBGV7sLBeEN4LMx3ytDopCrVSoAB1jz+A7?=
 =?us-ascii?Q?LlcxpN1x78+H52dwBLrzNPLAyThGMxWPuh8RVTF+S9wM6EsZ2BYhpwkhMEcw?=
 =?us-ascii?Q?yWYaeFCiNRdeBn2to+mKAwxDF7dsvTWIzvRl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:01:27.0277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 233f550e-ab8d-49ff-6ad2-08ddca0a8ffd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295

Currently, if a ZEN family/model is not recognized in bsp_init_amd(), then
function calls after the family/model check are skipped. This can prevent
older kernels from enabling features on newer hardware, e.g., unrecognized
new hardware won't enable SEV-SNP because bsp_determine_snp() is skipped.

Rearrange the way the WARN_ONCE() is issued so that functions called after
the family/model check are still called.

Fixes: 216d106c7ff7 ("x86/sev: Add SEV-SNP host initialization support")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a5ece6ebe8a7..79ea6a0fcf8a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -420,6 +420,8 @@ static void tsa_init(struct cpuinfo_x86 *c)
 
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {
+	bool model_warn = false;
+
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
 
 		if (c->x86 > 0x10 ||
@@ -489,7 +491,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			setup_force_cpu_cap(X86_FEATURE_ZEN2);
 			break;
 		default:
-			goto warn;
+			model_warn = true;
 		}
 		break;
 
@@ -504,7 +506,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			setup_force_cpu_cap(X86_FEATURE_ZEN4);
 			break;
 		default:
-			goto warn;
+			model_warn = true;
 		}
 		break;
 
@@ -521,7 +523,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			setup_force_cpu_cap(X86_FEATURE_ZEN6);
 			break;
 		default:
-			goto warn;
+			model_warn = true;
 		}
 		break;
 
@@ -529,16 +531,13 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		break;
 	}
 
+	WARN_ONCE(model_warn, "Family 0x%x, model: 0x%x??\n", c->x86, c->x86_model);
+
 	bsp_determine_snp(c);
 	tsa_init(c);
 
 	if (cpu_has(c, X86_FEATURE_GP_ON_USER_CPUID))
 		setup_force_cpu_cap(X86_FEATURE_CPUID_FAULT);
-
-	return;
-
-warn:
-	WARN_ONCE(1, "Family 0x%x, model: 0x%x??\n", c->x86, c->x86_model);
 }
 
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)

base-commit: 804fa10c3a3c8a33ce6ffdb999f94d3a7a6c20b8
-- 
2.46.2


