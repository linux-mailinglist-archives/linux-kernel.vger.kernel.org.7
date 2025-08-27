Return-Path: <linux-kernel+bounces-788428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A87B38432
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8236C1BA24DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74596356902;
	Wed, 27 Aug 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZwR5UJKg"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784E350D6E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303116; cv=fail; b=aeHRDHbM5LT57MmpqEGWYG2ErakMvti1kBwH2I30Fe5M7gjoEa93FXxMQX5bc73kS4NflNF2Yr32X+1F65AyJ8Rys0QiVxkCNUV9kM3gubNHPNESrBG4XfNNVCydMhvhl/jnbJ0sh5HaRz2eEMTZB705Eun83ruDm1y8MQ4RWyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303116; c=relaxed/simple;
	bh=ELgX1W9xKvPWjIsOcnudYDbniueXxkRnN1+wDCVAnCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U2x2dGyS+R/RCosw1Ofyg+HXp2TGwTN+g1iP+SNEdiwCiPyQXgmNNpesO1D7kUtIPA0H/RLwK3sZ+lf/+3ohSt7L+lPHtskMMO9ksNyTLq/8i/6WDAwOCqM278XiSKZ/I+anms3rQyfphDPKMaaFtuKidsTpKDuWlvYVKWs1Iek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZwR5UJKg; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FH8spdrE3erGTd8Njk66mnISHky2DCZZkEceK6Zihke2OQYKWo0Er4QJw1xaeXINssfAsmDOJesKXZIKppg7giHHyKlNqKYV3ijZuengg6ySd6+z9c1cnS0XvgpU5hUibxSymW8qUmebXJM77N0US8gi2gg4C2LXp36+3Imth+sKznMaiAR1Me7YxUIZ7aX1GC8hO9B6aM79lrujCM1yyopwajDX9cgm6UFcaW8YCz07wRXzpceEdRXfzogdx+2qp0jRQvGLi2bkDuV5LhQSwBGSKTeW6exBSjuHNc2rvuOYMemNQrA3HHiKmAuG3bMCjBGvfLX9X2hSp6Wr6DWPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O94bgVEIti/iD7TO9AcUNGXlXChxMCiTY0vxoPt7OKw=;
 b=xwbC8T9Fb3cB4v42hwWt+u0qipkwEWy3iWj+4scAGaAkWh/wN4xMAjZkbJnAzZ2dYHfq6i3QxZRFZtEdZ8FNujDSGyO0Ali5nahINdGyfQB1YbF3mpoEOaDNaFlIpTSAggGC362N/617NyuCv/CWFo/UG8x8d2OQh6FGwuLGWowuXN/uOroT/KXMRA0h7BYL5A5O5Qgxca6K1jyUKOPE+K/+L5uuDJKcYJv0x0S9YUeYI6CauObArL2o5eyqBjvL4GNzB3PU0KG5IsMBfqUAXxkPmvpTnhefIhkf2zFppp+zWOaKDgQtwdfq21+eLGxso/9A40nxxu25+rPTX/Qb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O94bgVEIti/iD7TO9AcUNGXlXChxMCiTY0vxoPt7OKw=;
 b=ZwR5UJKgU7ma6TNq1Cx6TojVkXKaa0dvSuFgDdy2DXozzekeTUuwcz8+blIp+58e0Y0qaMffGh6j3sQEri4+COoPVXTTOnaiaEgEiGQZZYOLbJCgbyPrC5sG48lWTjizmbUXH3oAJJ/THcQlSi4hh8Adk1bZyPebp3/GhIBzJpQ=
Received: from CH5PR05CA0017.namprd05.prod.outlook.com (2603:10b6:610:1f0::7)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 13:58:30 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::f8) by CH5PR05CA0017.outlook.office365.com
 (2603:10b6:610:1f0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.5 via Frontend Transport; Wed,
 27 Aug 2025 13:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 13:58:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 08:58:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 27 Aug
 2025 06:58:30 -0700
Received: from [172.31.63.243] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 27 Aug 2025 08:58:29 -0500
Message-ID: <c6bb835a-40dc-44b6-8f95-4254f10db98a@amd.com>
Date: Wed, 27 Aug 2025 09:59:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] xen: rework xen_pv_domain()
To: Juergen Gross <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>, "Oleksandr
 Tyshchenko" <oleksandr_tyshchenko@epam.com>, <xen-devel@lists.xenproject.org>
References: <20250826145608.10352-1-jgross@suse.com>
 <20250826145608.10352-2-jgross@suse.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20250826145608.10352-2-jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: ceabcf71-b094-4b2c-13ac-08dde571cdfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bC9PMG9kUXllMExxK1ErekZvcVVmdmIrZXFQWXNYR2JhR2RqdnEyT2lpb1V2?=
 =?utf-8?B?MUR2MXZzbTl2dnZidEpjSzhPMWtLNDFjYTZvbnQ4aVlnQitYU2xRNzBSc1h3?=
 =?utf-8?B?VHBkU01EMTBmeEhKRENtYU1BbC9wcXlKSnFzT0FkSHVRUEtwcW1SM09JOG9S?=
 =?utf-8?B?MjA4bjA5a0V0NzlXMHI3OEFsZWVvVWpHeW1zcXBkRzlpNGJpU05uQWcxVUZC?=
 =?utf-8?B?aFJ2K2IxOXcwQ3JETkdobDhxVGVkT2hvT0Q4ck5wVm9VV0R0eTEvUzc5WnVC?=
 =?utf-8?B?UVlXQ2N0VXUrbnlZQ3l4L08rZ0RCQ2o3TjdVd0xvLyt6ckM2elRuZ2ZBbUM0?=
 =?utf-8?B?WEl3NFR2TUVzM2JDWUZWTE91b1p5aTJYK1Y0Y3g4N04vRUU1UGpCQytLbzZu?=
 =?utf-8?B?MzN5ZHN1UWZaSjlNWk5Oa1dEUmFtblBYN1NqcmUvcmkrSWd5bjJHN251R2p5?=
 =?utf-8?B?QjFLSmJDTDNpQ3htVmFoV0tOWGM2Y0ttdktVK0FDTllJcmYzcGFFMzhTYUlm?=
 =?utf-8?B?SFZWZVdLYlFBcnlhcmx3bHRXcTVqRzJISjNKb3JBNC9UeGVMcll0MUlVRFRt?=
 =?utf-8?B?RVBqNjBHV1VSY0ZCa3BuYnhsZ0NOUEhIb0lwY015T1BHdFlJc3RKZ1MreEx5?=
 =?utf-8?B?L0taUnB4SVVyc1ZiWXZhSStSVThMUGsyV09UNjN6YlRTK3dGUENpRTlmKzR6?=
 =?utf-8?B?cTA2SHdPNmE3ZmFGRkNaVnBValN0TE9oT3p6SllZbDRKSHFmNllaaXVUek5L?=
 =?utf-8?B?d0NCaFFFanB5WUlKNXlrNGRndE1udWtCQVRZU0JJNnBJd2xBWTZIVUFBUnZo?=
 =?utf-8?B?d0s3c3pRRWwzRXUwSEtIQ0FvZTVZOTZzRWVwY25ETlFjamdyelE5dDBsQnhZ?=
 =?utf-8?B?YTc2emk4VWlvN2RSemtqZHUvZUUyenE4RHZjMENmRzdnVTZjNkFhSldmVk5M?=
 =?utf-8?B?RkQ4U1JRVmEzTWl5Z0N5eDUyeFhDNFFMZlR0WlpGYVFTU2o3OVNncXpiQ1NI?=
 =?utf-8?B?UUFRMFh0bXZHZkdMdUNMVlB1R2JlZlVRT3BGbGNmd3JVejRTL3F4SkU2Q2ZH?=
 =?utf-8?B?aEJxZ3JiSkhjUVZHOTBvNjhnR1VpQTlSMkpSL1lzZy9lZlFPNGdwMnk0czJL?=
 =?utf-8?B?ZGdjYzNsUzFZZEtoNm1YZyt2U0V2TDNEbERJckFoS1RqY0ZVc2ROQ1RwemMy?=
 =?utf-8?B?L1BDQ09EVGVKek92ZjE5ZnlFMlJjazJ4RkREb1R5OUt4VVRWYndib3dHVW1z?=
 =?utf-8?B?WWZ6TGo2RTVra3JSK1Jrb3N5MFVhWUs2NDdGYUJud1VkNmxaaGtpWDhJM2ZC?=
 =?utf-8?B?bWo3NlI0eUoxbWoxVkpHMUxuV0cvSXdoOW5YOGEvWXFtM1RQK3lodjg4STg3?=
 =?utf-8?B?dEdTY0luZWhvOXBMNlVqY29FSGNBeTlQMTVINmlFNEl6MmJGTmY3ZFRxc2hs?=
 =?utf-8?B?eTBLaXpzdyttK2psZDFxdU5BbTBzY29pTnZZTVNlbTA1SUc5a1NhU1F6aUZ2?=
 =?utf-8?B?QzBUbW1KUm9hZ0RkOEwyTDRMY0xKd2dVcEwwSXpneXhUbTNEMkIxOW9VZEVi?=
 =?utf-8?B?d1JrZ3MydUhNWUFpQnh6Z3ZMRFZ6aDVSQmEyeEJVQXJGUVNzVDQvRzBURG91?=
 =?utf-8?B?VnpkdDZ1eWpaaUMvazlwNG1abHo2dWg1MVpTWTdXdWN6ZTRqc09qbXBsQlhZ?=
 =?utf-8?B?N3Bic3FVMjZTT2gwWUhGbTYxckIrRWFNbENBR2hEb2FyN0ptZ2M4cjZDenlM?=
 =?utf-8?B?UTFyYUx0dUhtay9ib2xZeDN4T3RZM05ZdHgvZENibFFuc0dEOHlvV0JnVlhR?=
 =?utf-8?B?OEtNVTJNcjhGeE05dFM3bzM5aVM3anBTdWZlSEU3aTJkZ1lOakFyUE5PVTg4?=
 =?utf-8?B?ZTBQZXAxeDVmdDU4eW0wVEFGelp1THdXNW16ZUphTnVuWmtBZloyaENkVEl3?=
 =?utf-8?B?UlVVTmdhS3BicHI2TFkvWmdPR0FkR05YMCtUeFJFN2NzSGgxTThEL2xGSFdr?=
 =?utf-8?B?cVNKNm5teHVUSHlGdElkSkk2RUFWdUJIRzE3SjI5S0RKTHp1VkNpdTVJY1FO?=
 =?utf-8?Q?dPB1zL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 13:58:30.5853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceabcf71-b094-4b2c-13ac-08dde571cdfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238

On 2025-08-26 10:56, Juergen Gross wrote:
> Rework xen_pv_domain() to no longer use the xen_domain_type variable,
> but the artificial X86_FEATURE_XENPV cpu feature.
> 
> On non-x86 architectures xen_pv_domain() can be defined as "0".
> 
> This has the advantage that a kernel not built with CONFIG_XEN_PV
> will be smaller due to dead code elimination.
> 
> Set the X86_FEATURE_XENPV feature very early, as xen_pv_domain() is
> used rather early, too.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>

