Return-Path: <linux-kernel+bounces-721446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033D6AFC950
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0FA3BE57B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20AA2D8DDF;
	Tue,  8 Jul 2025 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mYc4QfWo"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72712215F48
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973444; cv=fail; b=qeMcVIuhx+4c9zBoLNLtaLv+0Ll/575Y6Ck334l7Trh1jtSZ50iRRSEfWgAtBxgczeDKNrQexJ85Gq1JeWz7FhXhgigFfEKo92v6uWSmGpxyem33rmIDTcrjNjIQHFL74frV9Bq/vKxntIZhsxaUq+m2MHtxYpBgz4XvDqcpa0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973444; c=relaxed/simple;
	bh=22ZRA5gNhnFBmsy/4ZgmV7UtjbtXV6N54M+vuYed6rQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MRSfMDTL3tI8/OiExsdwy+7WtmAX//RJqpzudrEMgU5g54amNR+O4gKC/F249r2blYtqM4pYEFHOAESsRmyXetCCOCAPY+L2KhV/hLL7tVN/kS9ckrRKZgNIn6sRFYM7ASC/ihRG4RNHwN8s4+rnyu8T4Y3fRvuCSZWmzYsvgeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mYc4QfWo; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/zqb9TDtMvGYczJM8cHIOdTZ0GuDr8EVz4+WU4iay+VilqLO79gnqtmHS1YuhKRpMHDZT+lPjnT8LcHT2iWQSXyLQFbahCnvrSw+0uYhkbO4erOGbUfGVNCkL5h/7TPq6g7iXDNAMZUyChJ4bhEh9lo5RT5PywkjQkjs1EbSO9vMoGv4Zq3lHPFnLQyWxLrl0Wf37IvLHcJ2wDSqTGRn8Zqqd89Z/PT2oAOo9rQfiMeW/pK0Nt8T4SBBsNA4gDGwo3THoLKkdwheLXFP4Wf8g0MIQNwy9M6THeaz4n5QauEr2qIU3rSSUKbQ/Nd5HEG6PFm4j829NWBGnLM9MlwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyZh3+i3rVOsGmO5Bt8eE63jEwYRfYQ+U19JDcWwGNw=;
 b=F0xGpbcWV1f3FyGvj1xTLIIVCBFOb+pXg2zgBBhanphe6UkgMn/JYnz8FbPc25rAteuKonwIdorZgbWSxPbRFDw7p+RVkFZ+FwD2+MZpVIPqqfPmlWnMHBuwYizISnQiB0EOvaib1oQ2MmeOqEUOLB8bLZ43Mi8z8l/UXGamkeiYspot/YF9GJJZRj79SEe4bOrI/DZqsns5IXEXdkwY8EPDUQIvv6zKShyLtx6gcxMeMhQ2XmG2q/b9EPYxz7qLEdikBxd8z/cvXwrLt9889MkR8RtoV6F8cao65DJfr2AAl0Q8EZILVdbkgtb6m6me81vSNcvq8wtIhMTkIIsGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyZh3+i3rVOsGmO5Bt8eE63jEwYRfYQ+U19JDcWwGNw=;
 b=mYc4QfWo5REnd7VuhX1bqwLyyxxeE0PaDy68URg3qxHHXCHGYijWfxNd/dScIaW8fxOwww+sGf0JN73+rRophsjIm81FnAoKGIskiKqvNgEqqlHVD0hcTsyX1NK45jROzhc2+pvsGsnUCSdCPVwrBaTCYaBRZJy8hKEimNJr6yU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 11:17:18 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%5]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 11:17:18 +0000
Message-ID: <95242ba0-e7a6-40c4-ae43-dab2d61555b6@amd.com>
Date: Tue, 8 Jul 2025 16:47:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 03/13] mm: Scan the mm and create a migration list
From: Raghavendra K T <raghavendra.kt@amd.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Michael.Day@amd.com, akpm@linux-foundation.org, bharata@amd.com,
 dave.hansen@intel.com, david@redhat.com, dongjoo.linux.dev@gmail.com,
 feng.tang@intel.com, gourry@gourry.net, hannes@cmpxchg.org,
 honggyu.kim@sk.com, hughd@google.com, jhubbard@nvidia.com,
 jon.grimm@amd.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
 nphamcs@gmail.com, peterz@infradead.org, riel@surriel.com,
 rientjes@google.com, rppt@kernel.org, santosh.shukla@amd.com,
 shivankg@amd.com, shy828301@gmail.com, sj@kernel.org, vbabka@suse.cz,
 weixugc@google.com, willy@infradead.org, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 yuanchu@google.com, kinseyho@google.com, hdanton@sina.com
References: <20250624055617.1291159-1-raghavendra.kt@amd.com>
 <20250624055617.1291159-4-raghavendra.kt@amd.com> <aFxzEFhTDOyL4y0e@hyeyoo>
 <02c6c58f-2c2c-42eb-bde6-175de71f7d47@amd.com>
Content-Language: en-US
In-Reply-To: <02c6c58f-2c2c-42eb-bde6-175de71f7d47@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0241.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::12) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e21f63d-a2b8-4f29-b1ab-08ddbe10ffdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1J1d0pGSWE5Q0J0a3RYR1lLZTlZY2pTV01mRXJPdzNBVDR6dTJLejNmYjdZ?=
 =?utf-8?B?R3VMWnkwVk1pRm5DbHNqczBLb0lRYytXWnQrM0c0K21PZ2xUM21iWkZwQ3pB?=
 =?utf-8?B?TVZ3cUFxeVA0WXV0RFNNRjNCT2Fub1Q3Tm15VXBnUWxpTzNsYlUxbG9maGdi?=
 =?utf-8?B?K2c3Zm5OOGcxc21aTVdWOTh0STNKT3g4ekpSQ3JCZmZ4d3BpVmFzdVowMlBk?=
 =?utf-8?B?VURwcGhjcG1aWFNnaG84cUtuN3lGZVZOWERDVWY5ZTRuMDJVQmNQdGs2ZGRV?=
 =?utf-8?B?SndZNW5nZ05PVG5GOEV1UFV1YnFId0c4T1M3ZS8vQUNGQUVmb2FkOFdtOG02?=
 =?utf-8?B?OUJyMTh6RzR5Rm5vaXFDRU4wSnQxTUpLOUVEWDcyZEd4UHBaTkdGZGJoNE11?=
 =?utf-8?B?TnNWT0M3ZHFtUG1Lb2NLMzBQcCtkbENBMzZSdWE2N1ZMYTlGWC9acUIxZjZm?=
 =?utf-8?B?aVF4U3hXa08wN0FhZ3cyUW9hSUlFOEtldXArRUpESitBWm4rS1VkM0t5UGI5?=
 =?utf-8?B?akM1YzFSYWV4UDhPQ0NCOGwwK3dKT3pZaEtNR1A2WHhmNlpMTS9EQmxZT3VO?=
 =?utf-8?B?aVRVZzQ3djJxVzBGaHp4em42OXYwZWFpTlREVW41RTJzMGczeVVla3diS08w?=
 =?utf-8?B?empMeG90cUVNMnlXcHRaZU9rU3lXSXoycXJzOHJyb2VUMW9Lc2NwaDRXS200?=
 =?utf-8?B?ZzBWNjRhbHlRblBTTGNNOUF6aWVQQmFQcEx3YTIvaWlPRHhhMzdmTk9NVFN3?=
 =?utf-8?B?TGQyUGZSQXBLMnZrVHFMUEZ5T2RJK3RTbGZLWFVzdzVUc2ZXOWVrWU41Mmdj?=
 =?utf-8?B?R1E4elpOVlZsMWJTTU56dlc1ZlhGaDVxQ3Nkc3d3UDI0YzhjZjMxUWpLbGpW?=
 =?utf-8?B?cnRRYUlhRDJNQWY2dEQ3cWYvZ0FPVU9PZGlTMmppdVcyUWpxYWg4NU1kN09F?=
 =?utf-8?B?V2dPWlNCVUEwSENPd09kL0o2eUtqS01YeXhzcVc5QVQ2YWdIbUIxbGlwKzRt?=
 =?utf-8?B?dFNkenhZVE9ZNVprUnBDT2xpc0xNbjFDZmZWNTl3UDY3cEJVdU5XV3lock1w?=
 =?utf-8?B?RmFiWFRKd29YNFRHRUs0azZmdDNOV0R2QTNVVk1IdDhiOTRHRGtoSldaREZs?=
 =?utf-8?B?VDcxVkV6T0RYdndwaVZwOXk1Q2pLazNYeFdscW1aNCtnRG1XUTRQWmxzQWJ1?=
 =?utf-8?B?OENIMGNJOGxmL2dGeDdhNUNWcThMOU5sUm1aYkU0TnlvVE9abVR6OVVEdXRF?=
 =?utf-8?B?Y29nRXlabFc0M3FqWnU3UCtsY3l6TzBBQzhRakgwUTRHOVJzOFhEUDJxVWdP?=
 =?utf-8?B?V3ZpUmxEMDcxd1A5LytWaDZEdTZwU2orYnlUa2RtL0VKZ3lHY1BYWkhsUEt1?=
 =?utf-8?B?LzlYd3FXTjhQWXc1VVoyN29yREdNNXFvZkFCTE04NnZFWFVSNzliRnFQVGx6?=
 =?utf-8?B?NnFFQW1jR2VLNlVrVnBDMHFOdUFueEVxRWIweW5mM2JkK0s2Tlg2YUFPS2t3?=
 =?utf-8?B?QmplT1FzMWdCc0EveGhZa0NZRHNvZFFZNEkrNmR4MENWMGJpUVRLaUNML1VM?=
 =?utf-8?B?b3J1QXM1czdmUkFybXBEVHIweWhYdjRIVElBL0UwdkJQTTY3QmE4RXZsZlNS?=
 =?utf-8?B?VWRzRDhnb0M2RFNwU1N5dElmcUNNZkVJQXNUSElRSGFTS3BEb3hWaWY3aStJ?=
 =?utf-8?B?WlVQSkZCTFQ1K2xPeVNMcnlVb2NQMWI2K0xKRWFmMStLVkgrS1h5OXBEU3or?=
 =?utf-8?B?cEJuaDU2dFBEUERCVHJWMkVrS1Qxck51YkNmK0puUE55Q00vNjZweUZDZkha?=
 =?utf-8?B?cWo2THpuSG5LOWlINmtuQXpjWUltVnpwNGppaWw3SFF1OStKS29WTERyZTNV?=
 =?utf-8?B?a2JoazF2UzhmNUlYL0FRRjJSMlpSN3IxeDdFTWFqREoxYzVCU3NWUm9LdDA4?=
 =?utf-8?Q?Kq04OWumV/8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QldIclJ4anBNS3MzcCtFRmV3R1kxRG5IUlh6UlpKd0ViZEZVNTdmUDFSSEFG?=
 =?utf-8?B?b1ZEWkt2NENsaWs4UjBIODE4NFNzWUxoc3N6YmJydm9XcTdlcjVCSkJJNDlz?=
 =?utf-8?B?V25tVStHR0xHSXFLMDVXQmd3M0E0VXlKbjZlQ2lEamM4QXZhVFZ5MHpRS3Bv?=
 =?utf-8?B?bGxneXdoeEY3K0JMZ2IzSkpHek9JOW4wK0xBZm5TNXN0TDVmQm9QdWJHNXpu?=
 =?utf-8?B?c29xK1lUUUFMeXQ3UENCNHl0NE9BcEoxQ1pYZTJha09lcTVxcFpWcFkwa0JP?=
 =?utf-8?B?U2x5VWtrbjlDZFFIdjFCanVlb2Z5bHg2R1dmTHhEQjl0RitsNm10Rk1sclg2?=
 =?utf-8?B?aWpLQVRmRG9sdEk5TlkrTFc4U2dqNk9ydHhmVmFCYlVkUjVhRmR3clE0ckh4?=
 =?utf-8?B?eWlORmFRMldBT3YrTUNBczRNbjlybHA1SXRmRHozY1BMVnZCRG9JMnRoQlRq?=
 =?utf-8?B?YW9Od3NFUGVVUzlQU0h3N0Z3dkwwWlYzUjM1b0tBMm5BK0FHYTdxR3ZRbFlH?=
 =?utf-8?B?ZC9zMm9RWFVjMlhYemQvUFUrd3BLUm4wdzFzZjJ2ZEJwbnFCRVArb1o3WS9w?=
 =?utf-8?B?c3ZPMnJhNHovdnZpWmxwZ2FHbkZpaW5mb0FkT3ZoczBBSjVKYWFsQjFpU1JH?=
 =?utf-8?B?dmNvaUN3eVZOVXQyeHdmRFFMRTNIVmJHd3V2NzhnUjhhbHFoUTdFTXZQTXh4?=
 =?utf-8?B?ZEgxQ3NETEdoczdKbmJRWHUvSVE1U1hHYWR6RllsdXNLK0N5eE1JYTVUT1Mr?=
 =?utf-8?B?Q2FucENSVjh1S0pIYnVuVkc2VnR2NXh3T1d5dndUZG9iSEc3VFUrSkVIczlE?=
 =?utf-8?B?OVlYZzIwdTJ4ejBBUHd1TlN3d0NadlIrcW5nOWU1V20zQ25DQitDWklqdVpT?=
 =?utf-8?B?c0w5eWpudElPOHZLeDBWb1ZEMFloQTUyOG8zR2FRd3NMaExORGxhT2Z3dU1G?=
 =?utf-8?B?SSt6ZHNDQlRzeGNhVDEwclJ4Z2pvVjdrQjdZdmFWaXFiWXlnTTc1bDlpRncr?=
 =?utf-8?B?b2w0ZkZVbUdyOTdZQW0vSlVjYklCazMwY25qbDRPemNWakVpSlJKelE5RWFL?=
 =?utf-8?B?T1dFSTRjaG5nRFJzaDNnbVFvbi90QjU0NE10RGwwcmYvUXFhM0duTURrM2p0?=
 =?utf-8?B?bktPd1YwY3ZSQkwvYW1GdGh0MktCZHNBTkUzN05iVHRFMVZESjk1WjVEcWJn?=
 =?utf-8?B?WE0vL2JTYjNPTExYaVlNb1lOcTljakhmNGN6Qi9iL3VhVitrRFo3ekt1VEx2?=
 =?utf-8?B?dlppcDJqdldCRmE4bEFidWFzaWFIRDh0L0JEMXltdVhlbGRXbjg4Y1dKSHNq?=
 =?utf-8?B?VVQ2ODVTbDJMMnJRamVFblBWbUdjS01uaHJDa1BVMUlGdmFnNVIwY2pvd29M?=
 =?utf-8?B?RnF2clkycDJVN29GUHZwbEU1RDZLMHova2VkVHpWOS80eW5nNFdlZUJiMWt3?=
 =?utf-8?B?aVhleXVGS0dEcm5aTiszZmkycTdmTXZQQXdObU4wZ1hVYy9PaXpkZ3d0dWZI?=
 =?utf-8?B?T0dIWG9XaWExUWJ2QlR6NW5vcjVFM3lBRDVMSVFxQlNqNk4rRnBSTXRRaHlD?=
 =?utf-8?B?OW1Xd2oyZ09JN2FBZ2pSV1pmaVkyQ0hRWWxmVy9sZVNRdWsrVktQUzdWYTB1?=
 =?utf-8?B?ZUh5eW9BTXVBU0hwc0JTZ1N6SXNJRU5rT1l1SXphZkpNN1FWZ1NnQ2xIRlc2?=
 =?utf-8?B?QXFFcHFPd3hZNU9DdmZJdDNETjJuK3VPVGY1OXJzenI2ZVZrdUVpaUhHZHox?=
 =?utf-8?B?cGw4b1F5VGhXNEpoZHhrUUt4ejZGUVVPRDVTaFNiT3dLMm9rNFAybS9PeXN2?=
 =?utf-8?B?NmVhZlQzc2FacDFVSGdnQVc4K3hnYTF6V1NDM2tlM3JkS2Q5Ui95VmxKc3kz?=
 =?utf-8?B?UTRzTm92anJyRkhrK01WTXFscjEvWjFlcUluN2JwU0lRRXczN2FBNGhjZmpQ?=
 =?utf-8?B?a3ZsemVNVk9FNG1Tei9Ra3BZUWNTQS94MEdNMnlKOXZKYnlvS0RORjlwWEpv?=
 =?utf-8?B?UVJlRjFsdk9UKy9HOUMwUFJvc1VDVkVJczl2TGNJU0x2YmUvS0tIdmNUUkxH?=
 =?utf-8?B?RTcvRUZhWmFFNHpBcFlBWXNaZXJCUjBWYncwcm0yRTZIWERaMmpPdWtMWm8v?=
 =?utf-8?Q?de3ZUXY1JOkBdnOrplGncXZKf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e21f63d-a2b8-4f29-b1ab-08ddbe10ffdd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 11:17:18.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32zJaZ+z7L4nOxpunTvmnUwGrOMDZa+Z5zYB9zMshM0W3EMVGGjIuWG61+xt2rXI0OaVG5/iv/p+XdogaRn+HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446



On 6/26/2025 11:57 AM, Raghavendra K T wrote:
> 
> On 6/26/2025 3:37 AM, Harry Yoo wrote:
>> On Tue, Jun 24, 2025 at 05:56:07AM +0000, Raghavendra K T wrote:
>>> Since we already have the list of mm_struct in the system, add a 
>>> module to
>>> scan each mm that walks VMAs of each mm_struct and scan all the pages
>>> associated with that.
>>>
>>>   In the scan path: Check for the recently acccessed pages (folios) 
>>> belonging
>>> to slowtier nodes. Add all those folios to a list.
>>>
>>> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
>>> ---
>>
>> Hi, just taking a quick look...
> 
> Hello Harry,
> Thanks for taking a look at the patches.
>>
>>>   mm/kscand.c | 319 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 318 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/kscand.c b/mm/kscand.c
>>> index d5b0d3041b0f..0edec1b7730d 100644
>>> --- a/mm/kscand.c
>>> +++ b/mm/kscand.c
>>> @@ -42,6 +55,8 @@ static struct kmem_cache *kscand_slot_cache 
>>> __read_mostly;
>>> @@ -84,11 +122,275 @@ static void kscand_wait_work(void)
>>>               scan_sleep_jiffies);
>>>   }
>>> +static inline bool is_valid_folio(struct folio *folio)
>>> +{
>>> +    if (!folio || folio_test_unevictable(folio) || ! 
>>> folio_mapped(folio) ||
>>> +        folio_is_zone_device(folio) || 
>>> folio_maybe_mapped_shared(folio))
>>> +        return false;
>>> +
>>> +    return true;
>>> +}
>>
>> What makes it undesirable to migrate shared folios?
> 
> This was mostly to avoid shared libraries, but yes this also
> should have accompanied with EXEC flag to refine further.
> This also avoids moving around shared data. I will experiment more
> and add additional filters OR remove the check.
>

Atleast experiment with microbenchmark gives a positive benefit if I
remove check for folio_maybe_mapped_shared() folios. Will respin
accordingly.
(also after checking some real workloads).

- Raghu


