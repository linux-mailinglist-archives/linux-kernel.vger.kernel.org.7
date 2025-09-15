Return-Path: <linux-kernel+bounces-816640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BCB576A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A40200C33
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F8A2FD1BF;
	Mon, 15 Sep 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fJkX6105"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFFD2FD1B5;
	Mon, 15 Sep 2025 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932659; cv=fail; b=I8HXMFnzWGEV3B9uFhmdlT3VUqslpiKoA6BL9uEe6RsNM3YCJ21TcudtjE3CmLucUFy0MHC1LkFLMOxdk7crBM0VD+1d2LNijK9VNuTYhkgM0wLgQ2DlZW9hjyf4XhyJmHgg/JHPGPGWMIRdggN8y7ZfIwmaFhz0Lz4RASYCZdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932659; c=relaxed/simple;
	bh=BYb3JuLlqLVahz4nASs3/Ex4GDBcccAqht56DDBvkZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8FN0a9jncUrUh/3f2qLSTFMTkxZisUJ3g2iSIM3oda2lbCU246PPfBfSfUrwHFUPWg/Er/thz0E7A+CtZ6jN/4k0wf1Y9ZapUS/y4JfhlkbDJ0iv5GWcO+JvdwM3Dd08oa39NKXg8Zh/uLdioghAJeiG30vz1cQ4rnLOiHFgwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fJkX6105; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kg4nYjPz2/cw0NOAIl/PyCwfVAGY/6Ht8svD1K4tJXeT82qekKafg4OoYPimj8Sg1oEe4usDOZAUnJUWKQIPdYxJtdFcwRRFORxW17/7dUJ7UiZrkfnVErfDvHjc2dzBPgBH0hNietU7JtS54nD50765YPHCe2NQ29b8m3EAIXo2CUZAHAN95YiH3ngbp8bY+eIa4PDyJNTduKRsN/OqeL649OGwC300VksP8dl7Rt8qieRSRluEPK0PE+p+TSjPXhB2nYy0qak6Jm+prXhHtncmjMqEF9zQArbGfvVsFUJr+G6i0hAkgObwx3xcUmxppPe+JGvNjypF8ae9u7YH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNDaXg8FQM4NI1aUFnG3ka0DAF8eUjGCVBK4HzLculI=;
 b=rDgYD1YdTFF7dvA4lLsu/yII2HQBTkmJG+7XPNELWYOL3clE2NZs1sWv2ZyepZ6TeoQbrGEs/VfMNxqmj4UJ4r5l6wlByGkmpAFSKyjhKOVu9BH2ntpRYHP8azBV5C0v1LpkQOSkn2SozPt+5GFuMnm1koNzpmfaEI70K0YKQx2k9jJMMA7Tk4J5fAf6h2U8Am/d5/38/j3AQ6Fkh6gt3iBecctBtcUZjT8OAsM207+jNO3Qbix41tk210QS6OsWfceTUNurj0s2Sr2qlqQLtCDgWcW76Y5j9yKEobrbvKDDUqJO8yaJmY88hjFh1quY8zsuxKNEqkC3r59mZpt2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNDaXg8FQM4NI1aUFnG3ka0DAF8eUjGCVBK4HzLculI=;
 b=fJkX6105hhdCsAmzmgvO6tBPH0WUEdmnuPtO0IEm7t2q66mC2nYdxewugu4JAcRDHEmYpEMSsxkY5cqBUJTDXJAnTd8kjN3Ukmn47xpahKFPwlkafPmuhpfYzj2xBHzeawXN44v+Of+QPVJu0UISDOZk/cK/cPPzHteh6fBBYB0=
Received: from BY3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:39a::7)
 by CH3PR12MB7737.namprd12.prod.outlook.com (2603:10b6:610:14d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 15 Sep
 2025 10:37:32 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::ae) by BY3PR03CA0002.outlook.office365.com
 (2603:10b6:a03:39a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 10:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 10:37:32 +0000
Received: from amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 03:37:28 -0700
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <linux@roeck-us.net>,
	<Anand.Umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>, "Naveen Krishna
 Chatradhi" <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v2 4/6] misc: amd-sbi: CPUID/MCAMSR protocol for Revision 0x21
Date: Mon, 15 Sep 2025 10:36:47 +0000
Message-ID: <20250915103649.1705078-4-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915103649.1705078-1-akshay.gupta@amd.com>
References: <20250915103649.1705078-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 3574028f-5ef7-4043-c4f4-08ddf443e074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OuhJqmpqZTvG1GXQMeVEvDeRvXD3RjDRQ1V7W22e7jfXr2wDN016/ju933N0?=
 =?us-ascii?Q?XPLS4Rhof+uzb8LDSbnV/95FvPtbc2dVIrPEzSxayGKqCP9fY/Eb4UAdQ212?=
 =?us-ascii?Q?mTvIwLLpfz3Jx/muX66++w0VbTelaIJi3aSLS6p/a+BK6dnzXXmhrvPMvZnB?=
 =?us-ascii?Q?lBlvQFX0xbyT6NrjiGht9EGnO4ta6JjveGUnkro8mdmj1qaDw93Qg1Zmm4gQ?=
 =?us-ascii?Q?tvIdZCNyX1a50x9REw98N+/X0S535FxieAB7ffzCNtxtOHdiHDVoJhN/QS7C?=
 =?us-ascii?Q?niB2+P0uJUgtZmuMWZV534pkbCmD/Ks3p32ytrwwcFgO3MZNlGQCVogwsz9t?=
 =?us-ascii?Q?V90179QdykKxxB1xFuxQPJ9l7pwKUVLgpZEQWUPrm3XGwPcoDMCsiFAcE4vo?=
 =?us-ascii?Q?15IP77LWmrsqEduOdKoGjOUDEWws6rk9gDC1ZYqS5yRvHibWYj/jatsmKMr2?=
 =?us-ascii?Q?/QqYXrhL5Vf59/2sX9ogq2jXO1l3iaJ4pr9Ef4st4Hw0ZzMIgPrTTW7+cqYr?=
 =?us-ascii?Q?o7qyN1Cm9XAbTsJkm7APR6rGTftYP/+/XlxWUnob+sefyuMc4n6O+Xz8KZ3P?=
 =?us-ascii?Q?TdP1YcrJ2qTOw39YI43dmILdqPejwLYTisBGe8YccAFATXcMzPrZ2RX68MAQ?=
 =?us-ascii?Q?vGLKyY9JBZZV2BSxJmpZzSBtxCtGTvudaEskGkDMOgjOc+H2q2FSX99C0yCg?=
 =?us-ascii?Q?ZYvc18gtprahvsAJlyPBc7BRROJP3aXcXvx2nowBdj4j5jSLps3PP9KePQlb?=
 =?us-ascii?Q?tTBvaOe9hAugWGFQwcx10hXp0qT+e0J8xqszaYrE6xI2rUdTva/iq6987BJx?=
 =?us-ascii?Q?NC239bRRcUgNJYCbvzt+QB/xVtRBHR0WnI1vRpT1joOd8SDKjSy4Mt5Y4IZ4?=
 =?us-ascii?Q?ZW5M5+JGHf0EsNSAfB00hWkaeAkg001izrIaRzhg+DfsvQ83YIYceyuvDR/G?=
 =?us-ascii?Q?kidBOyqXG28CcHAGY0huoFec/bxFWRmhkhmYaFt1VDWlSltIX2HcWWuj0498?=
 =?us-ascii?Q?F7YwJQgw0WM0frgfFg7Y8GwjwLkZtO+Kb/XhTQJZrHoRfQfZpWal1KFWZSfp?=
 =?us-ascii?Q?+Xs2Ssg99PCK9BYa7czuQ3Er4ThVqfUQ3gvpKxZo9IBDQNqKTCJx2lyswz6W?=
 =?us-ascii?Q?YsLn4oWNphXJc7llLW5/06UpDybJXEGukJyeb/GS7qtLqJjnA+LLGw6X1dYA?=
 =?us-ascii?Q?izC4P6IlEEnRaF2ltGm62+3IutKay4DkOBMlCQ367w8Wqp/Y6VYJU+lUN8Vf?=
 =?us-ascii?Q?K5Tumea9VP9cnEOseGlx7U443cpJVeHFNMh4YgTU1rxzzuIXq5zcOyYjK5BO?=
 =?us-ascii?Q?sfto06RK6ISV1hMa1LHvHmPZi7TkXT/ZDAECxktGWLB/josqkEeChu+KsuDu?=
 =?us-ascii?Q?q6Xt55NLgwKYQNb31VO8ZhEGN3Mytz0vSAespsk1CiqgimS86pqzhNaql7Sg?=
 =?us-ascii?Q?ek5zI3A0L/xS9+mBxvo3Ds9ynjpjqqVniuSwPtDyf+xh1d7j+E2hwbek0zx9?=
 =?us-ascii?Q?BTs02/C5qPjdxf1AQz7M2Eos7AhyEZ1vP/A7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:37:32.0889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3574028f-5ef7-4043-c4f4-08ddf443e074
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737

- CPUID and MCAMSR protocol for newer platform with revision
  0x21 and later is modified as per two byte register address size.
- Modify the CPUID and MCAMSR protocol to return error, "-EOPNOTSUPP",
  for revision 0x21.
- Next set of patches will add support for CPUID and MCAMSR for Turin and
  later platforms.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v1:
 - New patch
 drivers/misc/amd-sbi/rmi-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 3dec2fc00124..bf534ba757db 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -122,8 +122,8 @@ static int rmi_cpuid_read(struct sbrmi_data *data,
 		if (ret < 0)
 			goto exit_unlock;
 	}
-	/* CPUID protocol for REV 0x10 is not supported*/
-	if (data->rev == 0x10) {
+	/* CPUID protocol for REV 0x20 is only supported*/
+	if (data->rev != 0x20) {
 		ret = -EOPNOTSUPP;
 		goto exit_unlock;
 	}
@@ -203,8 +203,8 @@ static int rmi_mca_msr_read(struct sbrmi_data *data,
 		if (ret < 0)
 			goto exit_unlock;
 	}
-	/* MCA MSR protocol for REV 0x10 is not supported*/
-	if (data->rev == 0x10) {
+	/* MCA MSR protocol for REV 0x20 is supported*/
+	if (data->rev != 0x20) {
 		ret = -EOPNOTSUPP;
 		goto exit_unlock;
 	}
-- 
2.25.1


