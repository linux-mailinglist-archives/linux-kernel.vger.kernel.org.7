Return-Path: <linux-kernel+bounces-854207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AB2BDDD28
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75BC74EA0F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BA431A078;
	Wed, 15 Oct 2025 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ePkeyCKe"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011039.outbound.protection.outlook.com [52.103.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952473195F2;
	Wed, 15 Oct 2025 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521215; cv=fail; b=Qzuonu5du9YKlW+NoyCuXRQU2Pwym7JZdtr8B+WBkc73PQPOuPcGKjYRUe7T9mNH1eHSXhvgVcADSbm7kZ7koY3BP72g2Dtor9sx+iJWhwiXiUdP57Q08kd0I8r7DV8Exu4Tf1Q8bDA3VulrXNgvB7VejxKtf3UU1bJjK6yDUkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521215; c=relaxed/simple;
	bh=of062/o+2mpP2qpG1o7AD/bE+OOrIWa+/XN4Y4Aoi6E=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=pJNpSZfap9p+3njGRD4lf2SYTDa7HHva61eI4bAsJr4srOT90IU6ToVGOZlhw5JttK7/ErLWuz61eD8yip3sZKe5fDoUHt1mVckec76L6ydaAVgm4hzyqcW0o8FqIaBvHm9Mu4hqNOPZoW5ULcDJ1JlDs2mZ4tB7hNu4HJmTpXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ePkeyCKe; arc=fail smtp.client-ip=52.103.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zR1/832SdfShJB42GNsCj342nwua8UEY69qqy+fJCG+WL5XxTlw3RJfMxMBIJfN5HPV5Jvolzb0+XKdpd4EzpsrD3o7Es4JWg32qrCaj4lwhcRYgqdSJPyFKHxPgtq8IS7797QMcW3RSb3azeTSygFgm1QNDj6WMOVoQkBYneXCtfAt6kvckQIyey8f04qymHbBksimLM7wr0Bhwkrkvk8zB889t3r5BDAI6F5G4XdmK8m34X5krC8oQufrtSGlGVSmzVT94LGRb8I+fi/tN3mdwt6bDu3uYxz0MRjAPY3s9QVkk4qyrV1nnXKYR4eOLF67gM4OOBJ5GeWUVjoGoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si2Q3n4+M0dsg3/LBq4AZx9kvgqRIT/eOtXFU9W2fyk=;
 b=M6gogLd8jNiD581d0XWD9z05ryUfWrY7NX3ctVTRRWBrcsbEbDdX+cMl/toKtrtFyXcxAh3GEwzVXFviUWLbQOGZvPXOBsMgnICjJ+nR9/5SruhCzgfS9+vSe0F7UWfFz3RHxAucSwjakPJfX+WMICfi7HRs7Ye2MbM5he3e+TGIRO10muWFLNFWU41syOUv8yrWJCU87b0ai6kzQdQWWN/CZcqyIPYocXuYtSpzo2K5u82R5HX7YeLCnfN1onnMRdcinSwujfO90Hxn5hKYhLWEs3azGiiPbzvSUnyG3J0eBfcjjKgXjQl81fwifz1FisGlLtWnmRnZatzFvkeBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si2Q3n4+M0dsg3/LBq4AZx9kvgqRIT/eOtXFU9W2fyk=;
 b=ePkeyCKeWPBjYgW88lLdJQFC+glc7igRUAV1lq9JiQLNQQkOKthty+Mq6tVVjraUiNbmPec1y/h9H7YGwxc218fqXZaO+YIb+VJm1lNqz2fUiewozzVlhMhqDpnyZNiA6oUpWmiWTXcK7aPmhx/BTLRWHd4ycYysxrRemKCYgbvpj0ihpyy+FhgJTbi1br8f/fFp4/6Mn9zUUn4eOg7zUB6zO5ceLoHvgfsrXgDI14jTeiMiHNB7FtgJsMBNO5rPLX6WyohTVxVFlXKFXqz/PMvFuPMGrRAnq7A2XelZvUPIFkIFekr6pzwPqTI1KK2bpqEkEWqEKmNBc6P1Moo4+Q==
Received: from TY3PR01MB11798.jpnprd01.prod.outlook.com
 (2603:1096:400:372::11) by TYWPR01MB11828.jpnprd01.prod.outlook.com
 (2603:1096:400:402::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 09:40:08 +0000
Received: from TY3PR01MB11798.jpnprd01.prod.outlook.com
 ([fe80::96d:5da4:b512:efe3]) by TY3PR01MB11798.jpnprd01.prod.outlook.com
 ([fe80::96d:5da4:b512:efe3%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 09:40:08 +0000
Message-ID:
 <TY3PR01MB117988C4C4470CF84A0201F0096E8A@TY3PR01MB11798.jpnprd01.prod.outlook.com>
Date: Wed, 15 Oct 2025 17:39:41 +0800
User-Agent: Mozilla Thunderbird
From: Ston Jia <ston.jia@outlook.com>
Subject: [PATCH v2] platform/x86: huawei-wmi: add keys for HONOR models
Reply-To: OSRPR01MB11808FC73C557CED90DDD839996EBA@OSRPR01MB11808.jpnprd01.prod.outlook.com
To: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYXPR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:403:a::36) To TY3PR01MB11798.jpnprd01.prod.outlook.com
 (2603:1096:400:372::11)
X-Microsoft-Original-Message-ID:
 <a7f797ec-1ce3-47e0-a779-928e846a987a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11798:EE_|TYWPR01MB11828:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dec32e2-745d-4398-dd73-08de0bced3e1
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayF0bP0FcI6aESyZnZAIXMvqCtf7Ly4v2VSKhWgiR/TDqsRlEOh1Wr3qMBx5qarjRfMiXBxJgfIWtPsfmQmF/c88NULimlEfV9ncKSqfFJe+v3QWRF06GEFeyW/imw+fQlaTCL0kCGcbP6S37dP0muOWLDofle8vvhBVRUlHTbwK3YvkmpPrSdJBeKsEjy0E9OJ0dwp/YWpUGrEfT6c9UDxUfJLBsNf1xZ1fUgr2NRHqaX5ppccoKkUgKPyolvMi3BG/0m7oxuys+RsrALBHOXGhusbD5bj8mL4v+lLZ5VSq9DgbfbhBwccRfbOptvaF0UBMSnp5qv3z04EE4nRo9akZdpPx7/R7Vzzv3uHjBEo445IR2GHIiM+nSRczbeGEJ36/4A52oilR3AKrB3/G4KYbNT3WBQO3NofrDhehy3Ge4zExzQaavGtk0116f5QSo8P1UEHhE/DBAJ8Sh50Ia03O89yESqlMb57Kvhrl+iSCXUjv+letwwumr9nOiCdF26lk21DdDquM05dO5sHSiXqM//PQ2OHHaY3cWYqo/ysVA0Qhx1DEEGdsuG05QRMobRx/A44fGXmBzSK+5Swe5iHmZpjjwhiFx6IB4sDyoUg5xLqQ5Q5XByhUpgCs+3wgP+TbrpiCxmFpKZ48HV+Laio/fX+qUW2xm/Z96OOOlUY2HcbhxAmxbpEu9DIoPpu6acgXZjpoAVZbmNanDy2I19TZLyRVYPufmgk=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|41001999006|19110799012|5072599009|8060799015|6090799003|461199028|23021999003|15080799012|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L25OakJ3NDhzcFBTZ0MwakticVFpdFlFRXZHZlNiOEptaGV5Y1JNbitMbkdQ?=
 =?utf-8?B?ZXNrUi9JS25lT1hMQWlNbnJQQjV3T0JNMVlFMk1lVXoyZEp2ODgwRmJFMWhi?=
 =?utf-8?B?Nlc5SW1BMzJ3SG9FY1gyS0doMDJKLzFoMDQ3aE9xQ3Y0TS85bnNpMzVKUmFv?=
 =?utf-8?B?ZkFlS3FhVGdJMEswMUdHMG1YVzZNM3h0c09KYkI0RHhwVk1JM2NuaVpTcGhp?=
 =?utf-8?B?b1RjbEtHVWFESC93TTBDQ2ZPeHRPUnYzZ2JBelROTjVwQ0ltRU01V2RhWnlW?=
 =?utf-8?B?eFdpUkZvT0lGYVFpMlF2UkJWYjVGR0duMExTS0g5KzJLM0M3THRaWlB3bWtp?=
 =?utf-8?B?TnBKUGlhVm1hRkVxOFhITW5VYm43TVVSQ1Z2UFA5NXYrajZBM3VYVjRiK2d4?=
 =?utf-8?B?TkZoY1l1Vnh3Q20xcmUyUENDWUpXWHhDSGltSVk4bVY5WExlV0hVTGxZL0xx?=
 =?utf-8?B?TVNqZnNCTHdiMVhiVVBXUHZQSzlzejVXSmoweEJwK0JCdmJOU0pzOEtvNDY3?=
 =?utf-8?B?N3NBTmZyNEUzdGs5cXB6MCtzRmJscVIxWXdyRU5CdGFVRlZHeU5CbmcwMm5j?=
 =?utf-8?B?U2dIeUlNaDZUMkJlZlRoc01YNVNUdkVEWjY5SHl1YmZBVUJwakg5UDJhZkVw?=
 =?utf-8?B?M2JORmxhOVM0TEQyYXlSZTlQcGVWU1MyY0VOT3hNS09DM0RkLzFBWk5yYUd5?=
 =?utf-8?B?UHowdFFGTkNQYVFQNVBpL2Q5UkRhK3EvMzNmK0pmSGxOQVU4MmoxQytHZmNX?=
 =?utf-8?B?UEtTZEczZFlxTFBtZzJaYzd5bSsvbmF6K0VwYkI1LzlHUkhtVEtOMXJCeHFt?=
 =?utf-8?B?RXBjcW1kR3RaVW1XYUNucytZcmpxeTBzMXBud2RWYkt3Wko4Q3NQVUNGbzZM?=
 =?utf-8?B?ODNTMlgrQktoS3FpZzJWRWNJcFQvTTRXVFBPT3VwODB2RkxKUHZBNFlQb0Q5?=
 =?utf-8?B?Mys3OWF3Z2xNV1hqbU9JdER3NHFSSzBWb09FTzZZTFA3dklOS3hPcW9vYzZo?=
 =?utf-8?B?WTNkTFhMRDkvZXgrakZGNzZGQWlrcFlzRnRZUklJZU8xMHRXbnNHZmVMaVpI?=
 =?utf-8?B?OGYxb3NFMUNSZEN0NzU4WmN5Y0owV3hjeWxxekVVNEYwa1JDN0kxWFVTakJi?=
 =?utf-8?B?WGxpbTVGT3hJNm1JaFdQKzltRXFCRjFQbmZJSmdOOUcxS2xhbGZvV2RXMFVJ?=
 =?utf-8?B?Z2xjTlk0Skd2VXVEazFyZ2xQOGJxZS9uL2tRMUhkOWl3eDR6bEpvZys4YjBI?=
 =?utf-8?B?bHk0bVhHOTNLTlJuSWU1aUxOQXY0UExLWCs3YXJLbVM1cTFHclIrSytGZkds?=
 =?utf-8?B?Wm40RlB3MkNWdDMyNkJrNU53ZERxT2hla1JDbXhZL3hLSEFObnV1bFE5Z1c3?=
 =?utf-8?B?ekRtQzBRdUNURzNPVzEyZ2FIZ21FdDJ0M1BiNjNEbVhXWVVhUk5PanJwSWwx?=
 =?utf-8?B?LzVQK2R0MXV2aFR3cUdGekI4SGVPMmVEbWFkdTB4d3MyMEk3VHZJRDdFVEtZ?=
 =?utf-8?B?MURDSG5HZnVkQ1l4RG4zdTNlT1Z4VEpiSDIwYTZLT3YwZS9ETE93dXdvRHZY?=
 =?utf-8?B?OGpOZ2FOVlJNaVI3SlVCVG93Rk42cTlhcnlYenB3Zm5HQktqT1E1RENXMjhm?=
 =?utf-8?Q?GSswleSU+Yvc2TzJcYPDTWDhDlsKHl9BUfxD8umYkzO0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkgraE5INXBKU3VaajFxeFFESkRDekJaYzFqQVQ1UXptQy9tK0hTRS93MGhp?=
 =?utf-8?B?S2FSYk51YUt2bFEwVUFFcUpJZXFuQ1BhcWhRZkdWV2tFbUt6OUQ0R1VjcWVa?=
 =?utf-8?B?RHlkMUFabmhTalU4VUYrTU1sVEMyUDFCT2txQzNFTHBJMmpUb2dpcXBvWVV4?=
 =?utf-8?B?cnVFSmJaMzJZWk5NNDkzZ24xMFZzaWFwNXN5MGNkRWdHM2xROHhTWlZJNUxP?=
 =?utf-8?B?RU96RGZ3dUNINHVodUhHVXZrR0prbGdxWmNVbm9Pc2htc2FTV0lTVkVMdnRh?=
 =?utf-8?B?UVo3NDJGZjgzME5iSkZrL1Fac0hmbjdFbmpRSlVUUFdkbCt1cDYybzYyc2VM?=
 =?utf-8?B?L1J4bVBkLzM0cWk2b01aUnVvUWg0bTd5dzdXQTV3cjZTZmJtWGx6SFF6bDh2?=
 =?utf-8?B?bEZnRk80RDM0aVE5bjRIRXdDNnpObVo2Ym5JMS8zQVhBamt0NmVBM0xIdFM3?=
 =?utf-8?B?U29taFIvTDlwVW16MDJVem0yaFMyWGZpOGQ5bTNGOTFycnZpcUpacU4zNmpP?=
 =?utf-8?B?YlZ3ZkdSRHpqQjlHUEdaQmFxWTNpemkwQVNFeVBaSklZMHF4ZU9KaFBYeGtm?=
 =?utf-8?B?SDdXVm52NDE3dmtkY0dwWDJsL0ZkQkVmY0xoZ2tCTS9ycm5SUnIyTDVWemFj?=
 =?utf-8?B?K0J3d0ZPcTM0bzZ5emZMbFArbWEvRXlCemNRcWJTNHVjR213SFFMMEVTQS8v?=
 =?utf-8?B?b1I1QWQ5UG1vT3FURHlOUktZTjFVYXV0Q0kvVGY1UGttbFFRZHVUWFErRzNI?=
 =?utf-8?B?algraFhldG5NZjRUN0NsczYrUjF1NlRQdXJnWUhqYTE1MUdVZUZNWEJISnJw?=
 =?utf-8?B?VUpxaHJXb05oMVRqT092eEE5MkFrVS9SYmNVdzJaYzFyS0dkZmRIRGE3UVJo?=
 =?utf-8?B?dk4rNk1VYjlpYWgwMzdLcDFZTzNrb3BkUzBIa2QvcERVLzNYeDJsT2NwUHBw?=
 =?utf-8?B?UFNPK25KenFSTXdnOWRseXNJL2ExaVhJZk52cit6eEh2SGZDVkQrNXpwODJ1?=
 =?utf-8?B?Y1ZZdHE2S041NHBRUVBSUm44ZjFyRjZ2SmlldlRucjlYcDFneGgzb21zVmZq?=
 =?utf-8?B?RUVvUkhZZ0JraG5hTEFhUnkzSWVIVitFdC9YRWlqRFhMcmlRSXorQzB6L3Fl?=
 =?utf-8?B?RkthaXhXZTVNUjFwVzRoQm4rSnVnN3V2MG1MbEE5T2lJUlFHcTdmOXBJcXFv?=
 =?utf-8?B?YW9FcUpuYWdheUxJZHU4V3AyT2picXVpcC9hZjZyRE5na2w5cCtuY0xFVkRE?=
 =?utf-8?B?eXoxQzlkNFFWZ3BVaVhLWUNPTlRMdUUzSmtqMDdqQ1drNlV1UExkTE11bFlt?=
 =?utf-8?B?S0o2MGE2SHdRVjB1MHFlNmVYa0tBT0hld1pBV1lWS1IyNHprTnRIVlNrTThx?=
 =?utf-8?B?NHhqanA5TDNPSmxTSGtzWFFoWGlLMTNPcTRWNEFCcFVqZDIvZCtnd01sTlJo?=
 =?utf-8?B?eUdaMkJOT0FhZkN5OWNGdVQ0TThaclhWZlRNa3VzOVBEaTdCcFg1N251K0kw?=
 =?utf-8?B?U2tXeEhKWHdaSTRySjJyMmJqR1V1RmpWcHZtYnVKUVRlRmRHTVcxVUFWRkp2?=
 =?utf-8?B?Nngra2FHcGJ3a0VkT0tyWTdkZ3VKYUZSMkdoSFkwK3dYbDg0M1hJK1BpNUlZ?=
 =?utf-8?Q?na7wckPxHBiF/ZjqXrQSGxh2uo1Ginq1ZS1DXSDK3KUI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dec32e2-745d-4398-dd73-08de0bced3e1
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:40:08.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11828

From 940eaac1a1e3dedfc885e94af2fe717aea5d74c1 Mon Sep 17 00:00:00 2001
From: ston <ston.jia@outlook.com>
Date: Tue, 14 Oct 2025 21:19:26 +0800
Subject: [PATCH v2] platform/x86: huawei-wmi: add keys for HONOR models

HONOR MagicBook X16/X14 models produced in 2025 cannot use the print and YOYO key properly.

This change add key_entry for HONOR printscreen key and HONOR YOYO key.
It maps the key code 0x28b to KEY_NOTIFICATION_CENTER.
It maps the key code 0x28e to KEY_PRINT.

Signed-off-by: Ston Jia <ston.jia@outlook.com>
---
V1 -> V2: Add key_entry changes to commit message

 drivers/platform/x86/huawei-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index c3772df34..8a4c54089 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -81,6 +81,10 @@ static const struct key_entry huawei_wmi_keymap[] = {
        { KE_KEY,    0x289, { KEY_WLAN } },
        // Huawei |M| key
        { KE_KEY,    0x28a, { KEY_CONFIG } },
+       // HONOR YOYO key
+       { KE_KEY,    0x28b, { KEY_NOTIFICATION_CENTER } },
+       // HONOR print screen
+       { KE_KEY,    0x28e, { KEY_PRINT } },
        // Keyboard backlit
        { KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
        { KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
--
2.51.0

