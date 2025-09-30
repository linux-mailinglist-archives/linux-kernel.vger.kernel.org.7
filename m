Return-Path: <linux-kernel+bounces-837930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EDBBAE161
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42051944ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0D12512D7;
	Tue, 30 Sep 2025 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fTfG/JAH"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83501239E80
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250855; cv=fail; b=BVM24F3s4zZO0nzs90PfPch4PeuBA4R6c7GNcIxG65tK1zCKw/n9gLW8poViscNCdNAuJQMXXwUxyuxxS012VE2jgPMh6gAq/gm890n9Fxfj66bHiNKymW5JnJWvZ6pgt0GKW8Sjg24TvLlXWGUAessGmXAE2dWo/6xkzgUmtWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250855; c=relaxed/simple;
	bh=Hn9ltMDLCbWBPMPtP0WQLpCA5XXyq+KOIzMzLDThr+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Lt7T6WAxc9FILAk6cfWhZoMfnOhEv5LhAKdgI3cp9jRuchXaZPhlflT/KDQi7HgKYATEeWJA+q/M4WqY/97KJA24cmkXiu3sZYEPq5vxujTsBikRR5Yb5vXHcp8Vmv/80ZedBG8k+FK1YgayIkv0CDMjxyyXYUQsX1W/cqmafHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fTfG/JAH; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnMxdoAd9s08c4h38Xv9nl6WHQEqR5L8DGq8HUZmtddU6GlAFz69VAlxVWM51hMcxpghEpcFc0qsXT6AFiF9hzH6N+at0jbobYGvrPGUH5FuUSDYPGRbBYx1uQUyeDWMXVJYk+nzxrrTaW1v2lFMYfjhD2smdfBLXHzHr1IMY2JypJgRZEdfj3KUKVjpg2jy+R2FH+kz/kxJnHulri0UBcECqDURo3JhNHDF1O49Tlv/UFki14PxuHIgpOrRq1XHag2Sb2lmB94iyJ4hatMvGpiPZBM46io7YEEmxXW+Ic+htxqxGDthrMZ6zQRBmVHhyHZOmv7Yi19e3CXLfqmarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRkAwCC1XkroEBbsMNBg2Ho6b4D4oTVvip7yw90r+V0=;
 b=bVX40dKznoc+fo7tMcITYkK92qFPAHDCvyK6q89LGqCkmXhV7zumdYV3j8zSj0WpE0Q3AYzVXf5qJc16gqXnd3e2D42AboEs7Iaxo4Qrs8Bx6fxubkHxArAgSDZGOBVEXLONBV/9OtayM9LMqqQSXb6cIp+c2gQYqE5MjUP/+w28gSJSOqBuLwXpV+59vIqGIVYNFY//p1NWjxMzmIDwwES6PNUjcFvMf7+V9AZHdo73KVGL3LCEIPpAq5KK6st9o96lPZ2P/DOJv9gknt49X1SbzwwQJpUk6F3WhcOWnVHbOsXw8HvEsrz8NIMkMoUHJqrAX9KuXRRaWSQsGkpxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRkAwCC1XkroEBbsMNBg2Ho6b4D4oTVvip7yw90r+V0=;
 b=fTfG/JAHkuokI4guDM1PD1CB5ywhsT15D4ia6lCFtPX8puD8iO6nMWQIY/xLidpbFaxzTdg6DSbyr0lrIQKqHzDzeW0zDe2AGexSvhKu0Ao4o2N7YGTq7z4ph2v2d53QS6xyXE20y/slsc0qJzla5hrIWuxUV4t7XxYEkNj0dQ4=
Received: from SJ0PR13CA0062.namprd13.prod.outlook.com (2603:10b6:a03:2c4::7)
 by IA1PR12MB9737.namprd12.prod.outlook.com (2603:10b6:208:465::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Tue, 30 Sep
 2025 16:47:30 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::45) by SJ0PR13CA0062.outlook.office365.com
 (2603:10b6:a03:2c4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Tue,
 30 Sep 2025 16:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 16:47:29 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 09:47:24 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 30 Sep 2025 16:45:46 +0000
Subject: [PATCH 2/2] x86/amd_node: Use new root search helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250930-fix-amd-root-v1-2-ce28731c349f@amd.com>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
In-Reply-To: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
To: <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Filip Barczyk <filip.barczyk@pico.net>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA1PR12MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: bf683be0-f54b-4607-6ff2-08de00410b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QThNSE5wZmJySVhjRWY2bVhHQTNBU2tTaWZvRTFreWp2WGtJQU9XZG1nanBB?=
 =?utf-8?B?QWE5SlgyT0Iyd2VYeURYNEx4bDlmeWVlTVdpN29uZ3RRQ3VrMFQvKzQwNVpP?=
 =?utf-8?B?c1d5ZXAydTlRTEJ4ZEFobjQzUC9nblFRWk55cVZwYzlFR1VyeFlqNXZWcU45?=
 =?utf-8?B?UlJuWWRGdEpKUWlYdGxYUkg5WXlBRm1WRjBTSm5DVm1NQzB0OGFPZjdvU2xv?=
 =?utf-8?B?dUwzc3BKOS82S2xjSk9qdGNLdERPQ0lmbzZrQUQybklPaTlkNUR5cVFHTTk2?=
 =?utf-8?B?YWxTREFxVkJzT1E5YmlFZVFzb1Y3SWZrTTBmcDVGWW9wRzA1U0NmTTZMRmxr?=
 =?utf-8?B?SThicXdpbUJESm1MR0ZiZnh2TmxSTmtBaEF4dGJtd3h1dloweFBtRExjdkM2?=
 =?utf-8?B?MXIzcEc1SDZjL1BvMlhCNDAzK0VOWXlaVkhaVHFVZCtXVmRyNmNwVWZsV3NG?=
 =?utf-8?B?NWZOdUY0MWVBRzRZc01WWGdOcEZBeVZzVGxrZ1FtUm1wOWZYRTN6dERWTGFH?=
 =?utf-8?B?R0ZHTWx5SmkrR1hVNXM0TGJ4S2JyZU9jVkFHa0VDZ0VJNUxVZGlDQ0NpQ3pH?=
 =?utf-8?B?NG1zTFlxaGtXV2RhTnVHYjZjMExDc3ZTQlF4S2NhRnBnTThMK2pHRi84VzJa?=
 =?utf-8?B?N081dzFyN3UrQk1qVVhBdkl0QXpQZi9ubEhsVWd0VHFITmZPV0lCTm8rRnBP?=
 =?utf-8?B?K3RtRnBJR0R4NGhiRytmdlFUZy9FVnJqeXVCWkZ4MC9BZGp2YWFiYUxoTFhr?=
 =?utf-8?B?V3hTOUkrOW80c0dwYTA0aEdVbXRGeWV2eGJhQ2ZIMndrakhIbVhJYWlrMHdv?=
 =?utf-8?B?RWphS1ZuZU9NUlNnbXNBNVlFNXdDVFZxVU9NY2JBTWY5ckt6bnRlS3hpVldn?=
 =?utf-8?B?eTdNZkxINjJVT1BZRkN6bDhFOEF1Y0s2c2poY0pVRmhxOVo3ZENudG9zbFdS?=
 =?utf-8?B?bHhsWmx6bGVQQnpWV3oxVG9qR1F5SWNkK2ZhQUdEblVTd3BHL3UwL3JhNmk1?=
 =?utf-8?B?czljK3oxL1VkVkdmVlpoelp6OUZvaVBhS3o4VDlUUGpCMXBRaTdZRGZ1ak5C?=
 =?utf-8?B?b0dGN09YQjlmcTJqVi9GNlpXWUw0WjdnTUtYZ2RrZFJKYmVURk5EajJtTUNr?=
 =?utf-8?B?Sk1DMm13M20xVlFKVGZuYUY0MUVJaTVEY0piZlVEa292dkliVVQ5dndKR0VS?=
 =?utf-8?B?K0lQWmtLRGQ1Sm9acG9JNnBWWDFxb2txSHpUOW05YXNuUnMrRmllSVR0SzRw?=
 =?utf-8?B?ZVdabURLNnlUV3hEUmVWVUVBWXBhbjlGSExIdnN1V3psN2g1R3M5dlFVV0kr?=
 =?utf-8?B?K25XbkIvQld3by9GZTd6bTMrV3Q2R2x4RXJaTjZGUll1WnlQK21qeWVTWW0z?=
 =?utf-8?B?cm9NR1BSSWFXcGdjYS9YNWY2ZlE3MW1obEtnSGRBbXhOQkNCZnF3NEZLeWVn?=
 =?utf-8?B?MHRVdmxWRnZzU2JVMkI3RXVwWWRQNmxibEwxUm1YUFhqLzhTVU1zYzBkWW5M?=
 =?utf-8?B?bG8xK2M4NGdONlBMVnFPUWgwL0JlYWRsZ01kTm84cHBmTUd3eGxFS1VGR3Nw?=
 =?utf-8?B?ZmVqa0RWNlVyY2JmNTFJazVJSTA4dXMrK0RVRXBsUWxSc0VLL3Z5SW5BWE1u?=
 =?utf-8?B?cXVKT3FGSEVSRUtES2ozV2RVV0JqUGFZZTJsWVBmOXNJTDlaa3FyMC85aXNu?=
 =?utf-8?B?dGF3b0dibkRxYTBKbWVRc2k5K0pjaHBramhUdC90U3BLcE41WDNrY2dRMURl?=
 =?utf-8?B?NEtwYkhUMFNlQnRBaDNESDdHZlRYWkNsQlhpSk9BN3VsZUg0MXFLUk9wK3kr?=
 =?utf-8?B?dHZLYit3UUlwaVFOaGZJZTVDaHRtTlFwSFpaZytXZWVsSWpNbFFPSU1MSVQ5?=
 =?utf-8?B?YllqY1Y3YWJub0V3ZUFGV3hpM1Z3SGVRb2VJcGNEMWhoNmU0ZCtINE90SFdv?=
 =?utf-8?B?MjRxTk9tdGNoNzVTOXlxZTJzbWl1MUJ4R2ppR0pYTFhHVHd5Tit6aS8ySzBx?=
 =?utf-8?B?OW41S3VuSGtHc1BUK2dneVBubVE0SVpHMERUdm5BVGJ3SUJwbXZZQXpDRkN4?=
 =?utf-8?B?a3Y3bTlSNjFRMG5LVnNBcDU0YnptdGc3eXZBRjFKSERIMmh2ZUpiSzhhekQ4?=
 =?utf-8?Q?l/Wc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 16:47:29.7183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf683be0-f54b-4607-6ff2-08de00410b78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9737

...to reduce code duplication.

No functional change intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/amd_node.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 4a3d9ca6e225..02254e2034bd 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -268,18 +268,8 @@ static int amd_cache_roots(void)
 static int reserve_root_config_spaces(void)
 {
 	struct pci_dev *root = NULL;
-	struct pci_bus *bus = NULL;
-
-	while ((bus = pci_find_next_bus(bus))) {
-		/* Root device is Device 0 Function 0 on each Primary Bus. */
-		root = pci_get_slot(bus, 0);
-		if (!root)
-			continue;
-
-		if (root->vendor != PCI_VENDOR_ID_AMD &&
-		    root->vendor != PCI_VENDOR_ID_HYGON)
-			continue;
 
+	while ((root = get_next_root(root))) {
 		pci_dbg(root, "Reserving PCI config space\n");
 
 		/*

-- 
2.51.0


