Return-Path: <linux-kernel+bounces-772934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83BBB29987
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404A916FC80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C82271465;
	Mon, 18 Aug 2025 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rje7y8kd"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651C14AD0D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497786; cv=fail; b=ErLlW8meabTCsJFsaDYyfvr0i2k+8q5my0OtkMfDt/RkA6xPeOXBzfDF9Kij7S1H8PnD1zK0zmmM8hx4kRYFiARMqPMLh33VyheYLHNyUkid6QT4Cx+Xp3xaX6x2Oqhl4vZmgUHPt02vR90ljZ7/FmaXNNKvzpobDqQENlMe4P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497786; c=relaxed/simple;
	bh=+Jn4gcVeVfzDVQbvlFmNkC+BQ/cHI8ALoVtC8c2ZmcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s/7sE9F+oo1LAuVa8KVvK1ds35ved2NoHVlptLZESwz2aaYsGsJBSgAeobAax9NtlNm9aPcGaZhHInB6vGagd/jDr51jxv8DtnXpUF/aLmYQZrHzge3h71ZwyW8jPl7xDlO7y3pnpOqjKxWevGCKk2DnDkeszfeYJONdYNY7xVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rje7y8kd; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2wNQcD18isMZJq94v4VHT/NZjSlFCIWwaQYFJJvrnYfQcuo1vZ0ICeaHSvih2GkuolmwnFzrMlkovy+T8lLiuktgio2oufU2FLoMx6C7qDzQDp7HtfJ61spbfkY6OsLI7nX8JYFpPt5+EepmJGsgjAVMTLBjsBuz4fT100k0CzHNUJP9QrdeUh2oXV0guRyjMqUf7azDnXMWcyTP4hBF9JsHfWAhA2E4zJHllUhFCTqbeEQKZ/Br6LUb21/FDuLLqzuvGborj79mpF3yh4j/X2xiNpNvcXdM9MM2l21sNKXOCjJqRxcowLSQLCP+j/Zr5dzPI67kRMV4ep67RsDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWmDyCb2B6rK5KS76EjTWsmaP4gUXuDUr68mp9BIDtw=;
 b=JnAOUfXDDPHHa/n1aDyQhyhb2GhHRdGH2yZHtzccK4vkTxmn/gV0ddSzR4qXM+TTn2hc169TPo1G07I4M+hZnn6tpknA0rMjQ1E1kYgS2RV3JajWW7IWmrqAjacTO1xFNz0VsI2qkq6UqymiW9+gt6nSvRQViAxG2cSycmHfk2cKo8VbFptgvoICCyxvhO1b6Qi02f8sZw8K+6AfXNNj6l9dXWksS50ZHZ/8b08HB985pFx/5LV2Mo8ofhePIG03VWkZ0bLrV0F88MuUaQu1tzAlPrKdD+b1C3rwnLNAsd9nwzCjMVXoJGZOd0AYvZOR8qFOgK8kXb2Ry52J6LIdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWmDyCb2B6rK5KS76EjTWsmaP4gUXuDUr68mp9BIDtw=;
 b=rje7y8kdbrs9YxqReqGDv2pWjetnhocow0vXYMZ0kdNFabBVAl0Z/8n2N0q7BIa8az9RX6KOLvW8yC61yMVaCloMLBKTND/8kmIpEDEwb3WMqACIUp+0TA+wzj9xnSOqA4wIPGm+nUJJbYuy8VqxjyopHwA2QXDX12ervUFOtDI=
Received: from CH0PR04CA0005.namprd04.prod.outlook.com (2603:10b6:610:76::10)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 06:16:20 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::cb) by CH0PR04CA0005.outlook.office365.com
 (2603:10b6:610:76::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 06:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 06:16:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 01:16:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Sun, 17 Aug
 2025 23:16:19 -0700
Received: from [10.252.207.152] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 01:16:16 -0500
Message-ID: <4918f481-bbee-4337-870d-e62d8d2d86cf@amd.com>
Date: Mon, 18 Aug 2025 11:46:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [sos-linux-ext-patches] [PATCH] x86/sev: Ensure SVSM reserved
 fields are initialized to zero
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Joerg Roedel <Joerg.Roedel@amd.com>
References: <7cde412f8b057ea13a646fb166b1ca023f6a5031.1755098819.git.thomas.lendacky@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <7cde412f8b057ea13a646fb166b1ca023f6a5031.1755098819.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af90796-7716-419d-bad8-08ddde1ebf77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVQzQjZPV0xEcGgxdUpkdmNjTFUvVVZjZXl2bHlLaS9VaUo4d2w5Zm80VjFU?=
 =?utf-8?B?NC8xeE5KOFY5QzNXZ29na0JRNDlUK0VQTEpGS1Qwb0QzTU5EZXJEcERUZnJx?=
 =?utf-8?B?Ujc1aXI4a0xXeDFUNllMZjM3Tk5rWHlMNTdaU0hMRCtBaHZ5MURMQkUwTXhP?=
 =?utf-8?B?ZHhidTluMDB4RTM3SE9UVDB2THdpT29uRVhLNUs4MWpsL1JhTEtFVGhObGkx?=
 =?utf-8?B?U0RwT0V5MzJpZEZKZkY4TWRVQXhIbGtqR2RwQXk3N1VSM0k1N2lpWXhMNm8v?=
 =?utf-8?B?RjBaZVd5RnVObTBaUjAzZ1Rwb2JyQzlyWDVkcm0wbElJbzhtQVBGRDRzYnlP?=
 =?utf-8?B?L2REelV6MVNZZkl3U0FLQ0NMZWJEWEZnWGNsQVg0ZE9OdGY1K2xZMGJkSFJJ?=
 =?utf-8?B?RE5Jbk8vU05FbTBJSGxVSG9lUXVjaHlldEVGczNyZVI5ZFhlSXNQU3M1OTlm?=
 =?utf-8?B?Smc4WTliS01xOHNsWjIzZktCSGJoL1NyM0ZBTHN5Rm5maDlwQmxFNGgzL29Q?=
 =?utf-8?B?RTB2blRqbFRIS3pwU3NrcnYxaE9aM1R4NVl6YXNObTVnSCt5cXJMclYvRERh?=
 =?utf-8?B?bVFrOXFVazEzcGIrenovL3BucnQ2VnlHL2l0WDUyYktJUEVEL1RsdEt3V2xw?=
 =?utf-8?B?d0ROYSswaFhQNTdyUHhZOUZlT1p6WWs1cFgyc1BheisraEw1WEYvVG5uamdO?=
 =?utf-8?B?RVdjQUpHSkl3M2IrNzJVbFVvamFFVTJCSDh4enh1bUUwYXl2elMzQWpwS1RQ?=
 =?utf-8?B?NDBrU3BtcVNUcWdhcUV0QmZHQWRjYmFvRXlwLzlld0NWcGhQOEZxRUphTHNt?=
 =?utf-8?B?Qmp2NEVPaFJuanVMc0xUS3RIVTI0TUh5TDVQSDlpV2wyc0F0QngySGpxZElh?=
 =?utf-8?B?bWh4VjJaci84ZkhLUWQ1QlgwTncvVEhYdldBVklROVNaekhEaU5ScFN4UXAy?=
 =?utf-8?B?cWJma01jL3p2aDlPZ3NVbkhpNVZES0JISEhoVkJMK2lhQ25neFpxWlRzTHBB?=
 =?utf-8?B?b3o2ZnRSODVvMXlMc2NQY1pBME1RdXE3RVlJaFpoa1M3anY4V3VhQ2l2KzNR?=
 =?utf-8?B?cURBVWV3bnNPNEUxRWtKV0ZsUkRIQU15QnY4VVZ6VEN3bUx1TlhMbGRRK3hI?=
 =?utf-8?B?Sit3ZFNseHErRk85RlF4NmphbndKeTkzMkpESGxkeGFWaUpNcE01V1JwL1c5?=
 =?utf-8?B?S3pGZ1QrTGl0bGwxZmRFcTBaazlFZ3RVQ2p4Q255YXpNS1JGQzlzLzVxZElR?=
 =?utf-8?B?S1l3V0FEaUtpZFBQVFNlaFpvNmRVMVExNDlVYkp3YytJWXEwc2FzK0RENU9t?=
 =?utf-8?B?dkVJeFp5a01FMkt6QS91dktyRm10VWlTQW1BRzI5Y0pOc1Rka1NxVVRkVFlp?=
 =?utf-8?B?YlVkSVpSQnltWjdGUjVZZTh0SHZBUHlQNWFENk53M25NMzJFVWVoMDFVK2cr?=
 =?utf-8?B?czZnaEdBVGY2c1BodWFseTRUNDVseHh1ZUNDNHhLYjVtcGU4dk8xV1RBT0xN?=
 =?utf-8?B?VmllZFBqZ0RSWjNXUW50R1docDJRbjRwZWV2Qnh1WmdwN1o0VjYzOERFWTB3?=
 =?utf-8?B?UzJsbTYweXZFNnFZZU1YNEJTMGhrS0ozYm9nZ0VncWQ3a0QzdExESnJ0REhU?=
 =?utf-8?B?OWRnWHU2ZTdYVHpCSUUycUFqRGlEa1JhWm0zZGdpczY1S3JiZ2ZXZkVmdEVk?=
 =?utf-8?B?bCt3TXpLa09ab0s5L0Y0MVJwaUpRTzlaUExlczJFUk9aRTRLeE5yc04zSGJj?=
 =?utf-8?B?Wk90SVN3cE45SDVCWXMxZjZHMi9Kc3hnamdXcXg4VFJEWEkwZ0ZrUWlNcTcr?=
 =?utf-8?B?bEozSnVNVU1OL0RhL1oyYzFWK2lWaktPWEJVNThWejA5Zlc1OXpQSUtySmlT?=
 =?utf-8?B?YVpEYVBtZERYMmVjZGFmemZkUXhBNGk3aFNNandvU2JhUi9nVlhodzRTdnFq?=
 =?utf-8?B?N2FtRlFGZzZnQUhRb2dPUWZxN1lzODlIWDV5bDdDMHRWV1B4ZElkY28wbGpk?=
 =?utf-8?B?R2NoeDF4TUtoQTcwVHRlMjV1TExUSXloNTBaVUhUb3B4VjlFcU5kTkFxdWp1?=
 =?utf-8?Q?/d/bHC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:16:19.8612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af90796-7716-419d-bad8-08ddde1ebf77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850



On 8/13/2025 8:56 PM, Tom Lendacky wrote:

> In order to support future versions of the SVSM_CORE_PVALIDATE call,
> all reserved fields within a PVALIDATE entry must be set to zero as an
> SVSM should be ensuring all reserved fields are zero in order to support

Does "an SVSM" mean here an implementation like Coconut SVSM ?

> future usage of reserved areas based on the protocol version.> 
> Fixes: fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/boot/startup/sev-shared.c | 1 +
>  arch/x86/coco/sev/core.c           | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index ac7dfd21ddd4..a34cd19796f9 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -785,6 +785,7 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
>  	pc->entry[0].page_size = RMP_PG_SIZE_4K;
>  	pc->entry[0].action    = validate;
>  	pc->entry[0].ignore_cf = 0;
> +	pc->entry[0].rsvd      = 0;
>  	pc->entry[0].pfn       = paddr >> PAGE_SHIFT;
>  
>  	/* Protocol 0, Call ID 1 */
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 400a6ab75d45..14ef5908fb27 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -227,6 +227,7 @@ static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
>  		pe->page_size = RMP_PG_SIZE_4K;
>  		pe->action    = action;
>  		pe->ignore_cf = 0;
> +		pe->rsvd      = 0;
>  		pe->pfn       = pfn;
>  
>  		pe++;
> @@ -257,6 +258,7 @@ static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned int d
>  		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
>  		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
>  		pe->ignore_cf = 0;
> +		pe->rsvd      = 0;
>  		pe->pfn       = e->gfn;
>  
>  		pe++;
> 
> base-commit: 4c699535a3d483562354432a945a035f15dfceeb


