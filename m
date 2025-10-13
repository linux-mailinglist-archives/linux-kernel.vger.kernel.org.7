Return-Path: <linux-kernel+bounces-850735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDD5BD39F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88B9188FB2F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7CA30CD84;
	Mon, 13 Oct 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tHm1KAXP"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0130C601
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366158; cv=fail; b=iMNil0bybMGmCZXDpxzxkzoE9rzYgNRTAmdvOhTSgoqWEep9zx7uDKXqYEdhY9KgQbe0auQ79PSKHzDPscCwGwqSzj5WmNRv+hXywU37nLjzIbTL7V//A4XCN5Tj/8SP+xrQKT2mG20YUZtrapxVHhVDOId91eKw9ZzpzvMBupg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366158; c=relaxed/simple;
	bh=nncPqfm3Vrlj4bo4C7tH8tD2hcXl/ToMdoHQVaJD3xg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cliuBT7ml3TM513krdRQC+1AdcSMWRHBTYGP3XWb3mefaISG3HR/yCVXpcCA+KkkYQQkVpGC0ugMIKbonLRL2SbqXQnn06wN5bndxbfohXdBkF8WG8n+tGuijAgvsn/ZWiJ3FiikcX5kvAhqfZGOEdZmBhNznqFr8EgnbtZV2xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tHm1KAXP; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZ4aVXht71DHYVIX0Nr1SInwaTAvlz5zxl/vPedWyVFg3yu/BGmZM1EStsi6X8fPbK8D4QNPrbBbm68Ocuvtp0GZEjkd5oXqJD1T2i+vGpjGS5R8XiG+DF1B0aeoGle2xxiBP0gVxDpXFM6yRRCx+pE6xAN+vLn7bMPWZBhhqmsWa9SLChcFDW87RQQDU8lXmtevJ942otmEBWvKyUK8b6xUxAThiVzfgnk6bB8zQEF+5mrWRXeNCA50OwR+xD3hMA5iX8+EzOPRQl8x9kk/a+VvKP6HYc0aCnMFnse5niZ2izSl40G2Dj0Heo1tuearaitJ2xqYVbp0szPDWc4cJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRauI5YmKuKN2e0g7W72ogNR8jQthOqeMCTXIUgkTBQ=;
 b=E17XqBJP10BBRd7G15ExIHjGtTt+pZVs4gvC9rm2p7yfgjrY63AzmvbDzyzZ3RHWTya1Sp5ltucaCSiS69FnNX1BbF0UUPtt0/zrddai8DdhHykd04hHrbSJnpM+cPO7Fs0jvtge30vNwlGIZwu8ZNR07byOE23qZO07KmKy+HCgLHba+eZ0flC+niDGtw6I+U1IoHFYao8Nn33ZxvL/Fba2kIxQxsTy8HHd1TCK7fEu52qC3uz7mok3poMrtEuLQvMbofxiw9v3s2+JR72g/M40BW2othvCOrj7t5nM6/7GkC+CfAHR4UP4WWCkKYp4Zr6jHYx+dnjwReA2WP4pvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRauI5YmKuKN2e0g7W72ogNR8jQthOqeMCTXIUgkTBQ=;
 b=tHm1KAXP/8A8u6fHJGanaDgysxbYY+amsoicx7iAsa3fgsEqmXQ3M43ADBvoCAwgkxDOfh1j4+Rr7i4JVipOEIOwc/YF5l2Dsw3YLUONkYmIN7fDaCwNDWESeyzGHAW4+vL7ltX8yOx33WWaIsVCm/RE2ghDL+tOPDHTA/VDiVU=
Received: from BY3PR10CA0017.namprd10.prod.outlook.com (2603:10b6:a03:255::22)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:52 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::c1) by BY3PR10CA0017.outlook.office365.com
 (2603:10b6:a03:255::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 13 Oct 2025 14:35:52 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:36 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 26/56] module: Save module ELF info
Date: Mon, 13 Oct 2025 09:34:14 -0500
Message-ID: <20251013143444.3999-27-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 4992a4d1-86c6-4d61-6022-08de0a65cfc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o9RuPUnIxpKyDou4KSNzkMo3vgse6cQo0QUJsc5XuRPTFtEhI64zSR3VlucZ?=
 =?us-ascii?Q?6bhRvGduM7M9I76IqpW7CYiQ+LwQH5H97UkJ74UkB8oa/7+8YfF/GVPzuPja?=
 =?us-ascii?Q?w8qBsc1Ta8q2SrshrhiI47/ObpXcfWYv6PInjD3u2SRVj+32P55wBaIMVAyT?=
 =?us-ascii?Q?6hUt5C5kkI7CEH3PpbEmiWwz39zlcUDBMULwUhp9/uEEZynamnDc3SQVRUPs?=
 =?us-ascii?Q?nCjK5HeR+eb4Pm1g17yCo4vQapCgVCvFOJn5Ukl3FXQp8UKB8s8TPhxIC1UF?=
 =?us-ascii?Q?+Y6dC0uMoIZu1m++nAgPsvrV7W155JVE4TPZrH2PGgOeoZbwMzOu4lYjjw12?=
 =?us-ascii?Q?El+hL4z9/1jeGkmsX3apUC7F3Lsgrl3Xsc5jxr4n9vRNatJPTDutU0HFYbwN?=
 =?us-ascii?Q?XXEY4es5aiUIRGtVEC7jj4W0Xz9Jc5YbdrlfgKlcltorzgWIa0GU822OrSqT?=
 =?us-ascii?Q?PtAsGXt7WeinELl1QhdixcWWbT6m2R+MB8MUPcO0MSFF6Iy/YRlAh4I2kU14?=
 =?us-ascii?Q?+aGCA4uUY+/ZMtMd6DInZDBZlalJJVmHzAglY+2hvQIrOvFmbNRnZX3rRpcw?=
 =?us-ascii?Q?pk62FKgvzf8gGlqIkoRtvGsIyyzFyvMiK7hUO32Suf7kx5Yc7bWoPPjWzXk+?=
 =?us-ascii?Q?BKJdKPcYmbgS6bGQG2ws/RExVYpn/CFm9HWBsysGTbw+WvAFRlywDFfsHosq?=
 =?us-ascii?Q?xX2OHV4hU8HBp98TRnZFWuNbDZ5/QyBLs6J16G0Z2cNhFR7wKps6rCK5yleI?=
 =?us-ascii?Q?lTxZ3jGdVq5qiiKqsb00Hp1W4hTDoSRdoHjNMj9bTqmnkrYewaH0ujjqUJVi?=
 =?us-ascii?Q?zHWKOv+78yKikJ/ifWYoPf01KUQPc98IN1WHYNlgHvmkq1255YbdvglVv7q0?=
 =?us-ascii?Q?LcawIofcCyHjc2hwDichvURiHAFZ4NtdTEpUQJ5htp9aWPRkNTTejIrbxq0Q?=
 =?us-ascii?Q?Rwq7Dhij1An9pUcgGzDPBeZaEF1TEvGt5YDF5ZnnyRUNyZ3xaUzOagHqpN1o?=
 =?us-ascii?Q?6tnqHtk16kjz6sBP3nzJSKpmtyEHq9PRSgi5q1Pmi6KFHCBnLvUozg1PIdVI?=
 =?us-ascii?Q?f8OB/4ZKzKWxBSyoc07HqJD6W6mxH8PmQhj5VzbD6JjpYSM5jPWrgGqn7ULC?=
 =?us-ascii?Q?MCeCnh/s+/EB74f7a/6UwmKKkkjjNYHBc/KGkO9BwSy8tkFpApvk1UyVDJL7?=
 =?us-ascii?Q?ryVummrjEGDwsPkw7QQCEAb+rHVNZEesCR1Kv2041bATRLdmjXj3eNgZI2ks?=
 =?us-ascii?Q?cHpurAmcbpMI+vU56bPn17A60FxX6zp6g40mTELfxhMGrNY7BU6beYUMRHZO?=
 =?us-ascii?Q?wz7i4DPzzXDbM0ONGp6bfMVx6N4PTpamEwfoJMkr/zphZzLYN+yJ7rzii1hf?=
 =?us-ascii?Q?Dn/5nHLKf1Ccno+ip+arBB+SpvdX55XCqEk00u+KRCcan+HVc3qi9puWZ7io?=
 =?us-ascii?Q?QokxwttXhuESHmK5/L61S9WnQwXepc2Oe93jlU34eYHshZHAvyLaiJRgjhBN?=
 =?us-ascii?Q?leVjY7Y4R6REcekTc3o0YkzwkYZFUCUk6b1VJYTyVe10+ARQZAxs/zBpHIFB?=
 =?us-ascii?Q?b5AzIATzsBSyvzYxqU4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:52.5847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4992a4d1-86c6-4d61-6022-08de0a65cfc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334

Re-patching of module alternatives at runtime requires saving the ELF
information about where those alternatives (and returns, retpolines, etc.)
exist.  This information is already saved for livepatch modules, so save it
as well if we may be doing dynamic mitigation reconfiguration.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..088f9399af11 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3491,7 +3491,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err < 0)
 		goto coming_cleanup;
 
-	if (is_livepatch_module(mod)) {
+	if (IS_ENABLED(CONFIG_DYNAMIC_MITIGATIONS) || is_livepatch_module(mod)) {
 		err = copy_module_elf(mod, info);
 		if (err < 0)
 			goto sysfs_cleanup;
-- 
2.34.1


