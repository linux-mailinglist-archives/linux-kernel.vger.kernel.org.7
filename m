Return-Path: <linux-kernel+bounces-785537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E0BB34C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AC23AFC8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72DD28C006;
	Mon, 25 Aug 2025 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1BmHyCJQ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC3926290;
	Mon, 25 Aug 2025 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154607; cv=fail; b=Og6bT4XkEp+Ohe8r2iRk59/5H8IftmeNia/+XtqeuuixRtsHE37Df1IpIlNHuVVMo2uBCrxRk6mIag4o/xnxTiJozuSW/NkUziY/PWUoSXE1PLadrDJJh21HbLfGqoh+cZHK+iaPqZtmd/7iymwK1JpeTfiFOE8lrTlaHywCPHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154607; c=relaxed/simple;
	bh=sRZinkgsfgasrjRyfsJd6kuZvTYbdjX/5la+teqhY8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f0zJZffb3y8Rbb0NowqkYODy1WfPuuz7XPM4S4ewnXpkkrnGb/sSJ4GFaJLLlX/n9nVlOO401uDlFbhVkX7m3Qkc72aqrSnaddeAonRTSODOAK2W3cye7QSISKVeyC6BXCa3S8yx4HNhdLpAG5FM96dMDoTyfk3TgH53gejauWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1BmHyCJQ; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbmK0WU+7UNCoQV/PCIYpKPb5fqGqAFwHxoLtXydL2s3d9EF7QeUY6Yp6PrLCmk3OMLeuXBT4TGb9HnwrDb/fd09yL67J65yOVH22jFaX3vKs8c8nXOG+zkrlwKQ/x52Sw/wOo/8fPfwofOLWUqlWmg03g09wCnAe/ig3qwTjr94DZcTb3LQRgqP0AuLwYmNqf+te0woxZ5W/bWuoa5gdbmuwY7idKFnJpEKmm2+OGKh4Kn1dTuv0zDMLP2X2MT6bnajOox6kYvogN8UyKWkqOhcaXnpeKkKqojcqt8j9Yu3xyxNJ4NJwi8VQ8fCRwBsl5FA49lKIP9Kx1XMqWx15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxcoGK5jVhJ/JjVKX29dvhYDd0sJyeuntqk/JjhHacQ=;
 b=PqSzISGdN/sNdu5+qp1Std0ZW2wXwDMZGTQFq2sTr0qkts6OCjxqk496AZR1JaXzyGpQQ0QbWqcTZN+Zl1l7y/L7HAyd7cDxZdV3PM+v4E/iKPR6rf+Fo6R3HRG2LirWxL+qNSLiQIQSlubWFqR4haTBUYfn++Plh+WcGuhSvbilyPpeHMkgz7HbTWiPLKBSCxA1zAL0i+ww4Mb5Cv8NzCynPR+xpKjRsWUME92HaZm9fKUN3+SAodH0DkEno05Nxfzn4TTP1bkz9gofr0L1zaXomsszG54l9dciQ+1FW0ZO7LTFzZSM9NTLs65FfNmjGZ9QnE/B+wUDz4G+2YiYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxcoGK5jVhJ/JjVKX29dvhYDd0sJyeuntqk/JjhHacQ=;
 b=1BmHyCJQ+3JinELWO3vVjjTSzIllk8zdLGRGs5C1EKLI4c9GJtavoH7xIabBLypPb5MEvPC3ygWYhamxVR2MSNUJKUllh25/kiQSyx4beDCzVxBEe0z8ND7HtsikWzEK3YIsg/4q8xwUc5FWC/qquCivAbCE30ZslhAww8VF0m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Mon, 25 Aug
 2025 20:43:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9052.017; Mon, 25 Aug 2025
 20:43:21 +0000
Message-ID: <9843500a-9e7e-4d5b-a06b-5fe012aed22c@amd.com>
Date: Mon, 25 Aug 2025 15:43:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (k10temp) Add device ID for Strix Halo
To: Rong Zhang <i@rong.moe>, Clemens Ladisch <clemens@ladisch.de>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250823180443.85512-1-i@rong.moe>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250823180443.85512-1-i@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:806:122::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ab3a29-7547-417a-c529-08dde4180765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzVwOVNUenNObHV6QTJqcW16dTVBVEx4L2s1TzZ4V1BKa2xhN3I1a1BRNFp0?=
 =?utf-8?B?ZDNRUVAxbitCLzRLb2cxVVhMdVJxcTZjRDFtcXVmME9CM2NFL25tNTNMVkFv?=
 =?utf-8?B?MFlhbkk4MWh4UVhzQ3dmNndpaFlVVjAyZ2JXVVUwVldPT3h4SGRnc0lSeWg2?=
 =?utf-8?B?NVNja3c4SElweUxhd0t1dzdYNDdnMUMzL3A0WnRhNjQ5ODNsY2RueWdTcE1O?=
 =?utf-8?B?MUpGNFdnbVFBeXJHcGlDTDl1QUY4MDRLVUNTR2ZkODZvVFRQWlNXejB2b0J0?=
 =?utf-8?B?b1pma1hvUVJReHU2WUdNMGYybmxZS1BKRTBLOXptNGdVSkRBRUNjeFZ4QS9S?=
 =?utf-8?B?OERXbW5xTmNZRVg1Q2tGK2F2TTVmOSt2Ykxmb0Y2WnVBd3p6Y0Y5Y05NbU5v?=
 =?utf-8?B?YTAyZU1OVEdMbWhZUGNGdlVBMmZ3N1hEcHdQN1E0QmY3VEhSTlVXQnBBcDM0?=
 =?utf-8?B?ZlQ4NUoxcm9WQWQ5RWJ2VGo1TkxSTkZick9wdDd1WlRpVmt6Y2FUL0Q1cGI5?=
 =?utf-8?B?VUhBS2FTMXFFNVdXeVNEVGpmZVV1OFhZSE5pNWFxL0JnNnJXT1lvK1QrMVFz?=
 =?utf-8?B?U0MzWjFuUTR6UHhUTE5jWHFNRlhsaEVWRHFKa0tnRjN2NXM5T1pvcWtyb2RR?=
 =?utf-8?B?US9pOGxqL3dnbytjZEM0VldjNDI3SkNoN2RXOGdXUGg3cGV6b09JWG8rUU1R?=
 =?utf-8?B?aExqQnZsb09HU2dFSTVEYktkZFc3NEtvcDdSa0xWbnUvQmZ4NmN4dVRVN3Jv?=
 =?utf-8?B?VnJOTU5CeWtYRjB6dk1ncnZ3c2VVZ25WN2F1NnR4UnYxVWRlQ1pwalR4NEFJ?=
 =?utf-8?B?UTZPcnRIdkxIR0ZsdFEzTmsyb3RCSFFZTS90aktZcC9SMndSOTJ5bk1td1I0?=
 =?utf-8?B?MkdrVkpEbGxQVHNOUGhxYmFDTUI4V3o0bm5ZTzBsUkNvbkZaNU16MzdoWkNq?=
 =?utf-8?B?dEJ3dEhNZU5tQTc0OGR3WHVhbDlEY0NWMDRTRE1EN3U4Vk9XcndMaFR0YnAx?=
 =?utf-8?B?L05hQW5pWlU2b21FNGQ2TzFnazBrNkhRUFVMbFVQOTVUZ3l1VjUvWEtseVNT?=
 =?utf-8?B?cjMzMDBwenN3Ym51enJRWEloMVZSWG9weUd6cVFVSW12MUcveVRlM3RPZzNT?=
 =?utf-8?B?ZXVPTUtDQXhzM0RqdGJMaWwyZFR5SE9VSFBYVSsyR1ArcWRVaXhvUktIa0Iz?=
 =?utf-8?B?a1NGajk3Qkk1bDlOc25DZm0vOXlvR3cwRUNrNjNUR2t2cnJaM2tEeWkvcytl?=
 =?utf-8?B?Sm1mQmdNRk53dGZXYWdVWTljZG14dmx1NDN4dmlKQnRDWWhQNDZxR1RQU3hW?=
 =?utf-8?B?UDI4Nzg2bHNPcDMxbGczYjJaZ2ZkL3hpeGZxcnd3cDM2Z3phbmsvd1VuRFpS?=
 =?utf-8?B?SmNDZVlQdUpsNHpZQnc5TE1VckdMWk5xaER3RGZnWURsN2dDYi9KZnA0ay8v?=
 =?utf-8?B?N09sbEcyQzU4cGZQZU5NUVFuSE5WUURFM0FWdCtOYWtkMFdvNEVvOW1vQnNn?=
 =?utf-8?B?eElpTUZrSzdxNitacE5KdnNXS1B6eWRGWnF1dFdTMDZHSUo3eVI3ZHVrVG5j?=
 =?utf-8?B?YUNhOW4vd0RBeFlzUDhjUTR6ejY3ZUE5dDRGYStJMVNWRUlTWUZEV0w5ZTcv?=
 =?utf-8?B?UkFRcUVPWURTSW15aU5MeTJlY1E5UDhjVEp3YlZOWjNaY2JtQ3pUb0FPejBk?=
 =?utf-8?B?L2xzb1BRdDdvRlVKTTNUaC9HMEtpYlBzU3p2c0c2di9sVkZ4QlBzTjhiZ1Bz?=
 =?utf-8?B?azZuTkdUQzQ3S0dhaVJ5M1UvNktlcG5hVHRHLzdHYTBZRmlNT3FVYy9yTEhH?=
 =?utf-8?B?cUlscGx3dzBCR0dsa010TndPSTdsRGhzVVVBQzdqR1FMMWtyVU85OFlyNUkw?=
 =?utf-8?B?UVFNbWFqSlFEOXczMytPbndJdUZuSzMvdUVpVlYxa3BidGsrdkhnM1pSMStG?=
 =?utf-8?Q?SP325+KXvyI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEpvQkk0b2gvaWZjVUc4cmZFcm5lRmh6cStyd0Zjc1d5WDdDOXpNc1ZxMmho?=
 =?utf-8?B?SXMxbXZiT21SeU9oaTlLU2lMWkNJTWxQaVgwMnNEblhxa01xWFN6cGU2UTVW?=
 =?utf-8?B?eWdyVkZsMnZmNkprSkxmRWp0TVlBVHRDTnE1SU9zWmFLZ2JWQ3JES1NNQzRQ?=
 =?utf-8?B?RkdqVUFKQ0F5RTNxektmeGxoLzI1U21LZlZVOC9ENEllVHBBQ1hBRVhZa1NY?=
 =?utf-8?B?K3JpQW04bTRTTkxUUUlRSmJ3ZlFaVHhma0pNNnVLcHRWUExJeVRRdjVtZTB1?=
 =?utf-8?B?VExZR2p4RXJhWDhEWGczTmd4ektoVktuWVcyQXZuYUdqeXIzcEFiVDFBSTRn?=
 =?utf-8?B?MndWQzkwRE91WVlESWZYdURZN3J3NDNhOTF4OXU5VzlBaUYxc3VoTUFBWTFE?=
 =?utf-8?B?Q29YbWVPcTd1QnRzVTNQWjQ4MG1qcDRiNVd1L3pCdzFjM05seXlsaUd4ZDVZ?=
 =?utf-8?B?SHVWZmZaRFkrMVZ6VXZOaCtnRWhobDI5R2hqeVNLeHFUUFNlWDJ6cGppb2Z4?=
 =?utf-8?B?MjlqdjNyWFc4TmcyUms3MVVua05Fam1DMTBkbkZFYkFSUVpmVUUrakVpVER4?=
 =?utf-8?B?OGk5bDh2VjN6Yk5FZWNNS0NhNnJHczc4VXJKYjBqenRGa3VjOFhNWVRaY2E5?=
 =?utf-8?B?M3l3QzQxTXV6L2tvRnJjV211aFpRd0tVa2tobmhTUGZncTNBV0syWWJYMzJ5?=
 =?utf-8?B?K2hUeUN6QmY1U0FKR0FYUTAzMnhBSGI0MWw2ejNEV1NWc2ZuemlERy9FdjN2?=
 =?utf-8?B?d2dPSm5mY1F1YzVSWGlISElUWGtNZE5Yelc5eXNESkFPNkxqOVRZWTlUQmNR?=
 =?utf-8?B?MVNwZzNqTWR1RXhVRC9SWWF4bkRMaCtjTEtZWU8zc3dPSzNnbUNOVlpFcGww?=
 =?utf-8?B?Y0h6Nk10dUk0elh5a0hEcmkxT2dzOHFMTzFFekFRSFNyb2ZvaXN5MXBCTzlk?=
 =?utf-8?B?K0RUMk93KzBPWXVxMTduT0hUODdUV0s5Snlnd05keUVIdWp3SEprWFpMS056?=
 =?utf-8?B?T2hFekpSdlg2TlNZeThSMXUwOFVrTGJvUjlYNUdsWTdPaGp1dFNSRVFMSDhT?=
 =?utf-8?B?WkU5NEpQM2F5SUZaNkowTGpRL040V2R5UGFnamhyKzByTDkvb3hQdkJRcEtE?=
 =?utf-8?B?bUhMcGYza05uQWxwY0NtRWMvdHg1QlRmTGhyMWRTdXNGaXBrNFlnRG9LajB0?=
 =?utf-8?B?U2VNZ1lVQTZrTkxhSXptTmJ5Zk9CL01EWDZoY1Y2QzV6SG1rc2lkeWVYOWlF?=
 =?utf-8?B?QlB5YkpBNXpocmZBUXQ0SFBWWjZHN0JxZkhqT3FnTzBTQk5zcXBqOUFIT1JZ?=
 =?utf-8?B?R3VFVzF5RURPY3VRb1YxVDg5d0hXUlZSR2UxSXFOaEtIL1ZyYThPaDZGRUhY?=
 =?utf-8?B?R3BOclNKamxBSVVXdGllL2hnRUdKRW9ZNmFDWWJpek9RZG1ML0JSZUIydmh4?=
 =?utf-8?B?TzFUR0NjRUpGNE9STm44OVhuNTIvOHJJM0w2VnlFR0VUeUFUclBwZXNlNzJ0?=
 =?utf-8?B?U0dqeDFzQlJtSGlXN2YzMTBEK05WVE8xdU1FRmVISmJjdGd4QW5jTFBUU1pB?=
 =?utf-8?B?N3FNcU9nVFhGSDZHWVhJbmhMSTQrUEdLMGZzZDhZY1dhZnlzNkk1V3lyZkJT?=
 =?utf-8?B?MVNBMGRHTkRKWmpScFMzZkFjeFl2eFBBUG1oTVdGUVRIbEdSVVRVbWZRZUxl?=
 =?utf-8?B?eTlqQXhZVnFybkFuU0Y4ZG9vd0pZaTVJanFPaWdnS2p6Sm5DZmpUcU94VDN1?=
 =?utf-8?B?bkRIMGthMExxYkhRMHE0WVRmSHBFbGxCVUl0Q2g3ekNuRnl0ajBjM2JLT0sx?=
 =?utf-8?B?a0tJSXVIV3hlNHpVbU0wT1JmblhGaWdvcnZsUUkyWXhIMWdsemppWURkTUdC?=
 =?utf-8?B?bmswclJtbjFMaDdRS3FCcXNvMU9Qa3IrUm5IVDZJVzNIbkJSM2JjUEdMRHNW?=
 =?utf-8?B?NXNGYSt3YkRJSndCYkdyTXQ4dWdaOEhVNXp1Sk03L21IVHYxQ2lhUVYzME91?=
 =?utf-8?B?SWM5QTRTNlJDc1gwTUFRanBPT1BETUtIc244djZmWEdzSUNNN2lUcGttMWVL?=
 =?utf-8?B?aUNjRGhWTCt6d1c1WTNaVnc3MUt1SXdzM0FpMEt0TmRyN3BINDdzcEV4WHkv?=
 =?utf-8?Q?MNjBsjinlH+9lIBDCBIYdJPg9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ab3a29-7547-417a-c529-08dde4180765
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 20:43:21.2867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Q8Lj/1crjlekhbZuBNl6WrkPC2Y0ztyRe8nqyTot26yvmmYk30dqSPf3P8vVV6kU5fgb89nvGu7WPUwvxFifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

On 8/23/2025 1:04 PM, Rong Zhang wrote:
> The device ID of Strix Halo Data Fabric Function 3 has been in the tree
> since commit 0e640f0a47d8 ("x86/amd_nb: Add new PCI IDs for AMD family
> 0x1a"), but is somehow missing from k10temp_id_table.
> 
> Add it so that it works out of the box.
> 
> Tested on Beelink GTR9 Pro Mini PC.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/hwmon/k10temp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 2f90a2e9ad49..b98d5ec72c4f 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -565,6 +565,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
>   	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>   	{}
> 
> base-commit: 9703c672af8dd3573c76ce509dfff26bf6c4768d


