Return-Path: <linux-kernel+bounces-893653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B07FFC47F77
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D25734A21F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6C27E07E;
	Mon, 10 Nov 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YqfJ5p4j"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5792749D2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792499; cv=fail; b=fkzUowm5JpoZcEuA0JASVZl5z208QprqJdM0oTPTAKGdQ6lwi8K5S9rTBwn4O4lxQeTLRsbTWkdDB3AbLDG4ooNT+I4Qo454W0PxRCJ3o/BF9m0CfhdLQ23FKsuvd1HErtzlC1xHI+rvdcF1uORy14LwaATAKE3/hep2MlzB73I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792499; c=relaxed/simple;
	bh=vz6TEWpQysA3ugs0Nr8b1mnn92AQs967lcEq5OD1Gxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dLFKf0lEiiz9hLMVDH3CVmDQwY8u9HkEALsks5dA8qsI+jCubEhqIKbzQ8wbbEeVfcqZc9TbPVBTlyE5q8ZgUhkRAd0bgeD9vIG0s1EhocqgtmIaRRcBOGkOClOhfyb9biWeTu0YW3JHQ2AHaUFadQUJPC9fY7U1esCmZxDOf+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YqfJ5p4j; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxJPfNvD5j51T4b/E8PkYJWKg+2V5FAkiP1PrlQPq51Wkja90inFT6ZVXDfgoo6jqk53agDfshqG51LTAJP3KPxBfIBfMyxrhQnwGwT8bf6g3Y8KXlACYunIhxGkEQYoyfB+ysdFR7pfRSl8wi9iGzzScGVwngW5zt2mhJ0XCRTvimnlO42EgSsasHetCFyV7oYYSCqRgAHvEL+cOfBstze6Dcbg5Q8D8OreOsOxxO+0hB7zzoI3rPzis2TAIzW8Ps89YLqoqKMbP57/+OVfR3yyr3cY6+HRJ0CrOTiPp8I0ys5Or7+4Bit7IrEtpzH404LpUAWUu4asKwpeef2CPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNymquxe0ZdCR5nRNj+KFqKaMNIcjC/pUm0pGrcBplM=;
 b=WnAiGGzO9ZU2WXmwqpdvnwaeHOEKDGFjnx5pAvXtUBMzXduiVvFuErCgbmRcUAzZc8ZTEfiysagRHvEJRTbn0ub9EKfxkQFhmLw+Ko3nxbaf4IFAzC8yCRfpSxNkpJpA4/shKPT0kDQCU2WIAuECpPxIkORGe3hfN/XZZ1+3vZlhYfJBAL5VuTa5AHZru6bW9kHOwQ2b5+bu+xRPn5EbEqLXP6k4fOICml9U/qLpu8fPhpF7sEG7zxs8+4FFK+v61al8DSOQ6MzUVMC3belRLfJfNLfXZnqG+xkhCle2ryKCBaHpNG/9APq8LPj3Xt2/WCRNEAHHOIacpFLhZoHCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNymquxe0ZdCR5nRNj+KFqKaMNIcjC/pUm0pGrcBplM=;
 b=YqfJ5p4jhs46h5lsDzNMT5/JKHnHULSl2QoS8K2qeDglsIUCOG6xiIU2VZ1XZ6Ipa8gmf0Ztiuu8zePbjSNYY98GKhs9PbBuwheHePM46OrrJcoeMIEhb1RNFp/8AO7l99mUSIBNKl0s1y0CQ1K+X9xGCa9a46SKctC8kipHpJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by PH7PR12MB8180.namprd12.prod.outlook.com
 (2603:10b6:510:2b6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:34:51 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 16:34:51 +0000
Message-ID: <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
Date: Mon, 10 Nov 2025 10:34:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tony.luck@intel.com, reinette.chatre@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, babu.moger@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
Content-Language: en-US
From: Babu Moger <bmoger@amd.com>
In-Reply-To: <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0182.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::20) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b8e99c-f21f-40a4-eab1-08de2077120e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFpacGxnakFKY0thZDJIR0FrUWQ5eE5JV09qREFqNktySkFnUzV5U1lvbkJZ?=
 =?utf-8?B?TTZjNmM3NElSb0x5VWhGTEZQL3hXU1lzMWczaFJyd2ZjUFQrSnNNSTQreTJh?=
 =?utf-8?B?QWljQ1drdTFxZTdhcVhTTm1IWHlGOFNlVlEzV2pZUVVBRk1weS9vZXlDZHA1?=
 =?utf-8?B?ZU1GUEl6dWx5OXhuT1NUSjJFcUJSeVIvbzQ1Ny9nUkJLc2llK0JTRzcxS1Jy?=
 =?utf-8?B?cFNwS3RJVEVsR0VSbzhsS3dqL2RIOEJvRW5yeEZWRXNQNUlFV0t0dXQzU3Qx?=
 =?utf-8?B?bzRtUjJCMTdJQ3dZZHZndktVWHNSeGtvd0xoTlVXT3I2blF1Z25lN0tzYjlu?=
 =?utf-8?B?ZGR6MGlpTVpNOVV2YXJUQi93dnRUdCtENStaQ2NPYk5RUmhEeGNqSlY0WTVk?=
 =?utf-8?B?cldTUCticjNSTG5kVVZicjNVT3BqQ2FPZXFYNWNycWc0MjNqY1c5M2RYcFdh?=
 =?utf-8?B?L3puQUZkK1JXT25mVFdIZzErVTVNa2Z2WUdyamh4Rmd3NWxDSFlHNzZseDk3?=
 =?utf-8?B?TnlidXhVRTdBUFQ4aG1lTlpDQVpERUp6VUNCRmQraStKdmNPL0g3THZKdmRV?=
 =?utf-8?B?MUhzV2s1dlgwVFlNeGZOM3ZzVmtKR3RyMDVCbVJKV2F4cHFWL05mZnVYYVlz?=
 =?utf-8?B?TUx4dWdIS3NXWmZrelRLV2g1c2Q2Z1p1L0hSMy9adVY5dk5hcnhzaUc5cmdv?=
 =?utf-8?B?dHdEOVcrWXBlUVJtb1V0Uk1kR0gyaUtOZzlFcVRjRkdmNHg3K0Z3ZElBTEtL?=
 =?utf-8?B?UWk2alJsRWRUcHlEN1NsNmVuOFN0emhLQjY2b3hITTFsVDdZVW9sSjdodHJk?=
 =?utf-8?B?WHlsbkQ1VmtZUFkwK0p1SmlCUFE2RjU0SjVDSGpUNnkwVVNCbUxXS1NyVVBi?=
 =?utf-8?B?bFQ5MkYxcm5jT2lwdnhHdXVPdG9MWWkzM0EzWmwyT0JLSzN4OHM3WlVYdVdG?=
 =?utf-8?B?QlBUdU43clorK2RESWN6bm4zT1hpdkJLSVJIL0NNcTd0VC9iQXRKaUpsQ2d1?=
 =?utf-8?B?OGo5WEoxOC9NTWg3aVJCcG1OZXRMRTR3RWlFUjhtY0NrMHhMRjdjaGVlWGl3?=
 =?utf-8?B?ZDlxajZXWHFWeUU5aTZCSE5RWHowc0Y0eHpYM0UxUkVGWko1RzVhTG56NTRD?=
 =?utf-8?B?WjgyVUxoRWZHdHFxTGl2QmRCbGtpdVliRjN6QWpMazRSZ3NrQktUSjdGZUc2?=
 =?utf-8?B?WWdiT1FUTC8yY090QlgrWVJ4cFUvT2doTHBuUVluV2t3NDlJVERCdUxZSFpy?=
 =?utf-8?B?MmVlRmJUc2IwN1Q0cmVHeVNvWGFuaCt0Zy9sRDFZajBWRDFsK3BuaDlPYW04?=
 =?utf-8?B?UkFlc0ZSNzBZeTFDT3A5UWhOSWVoVlF1VE00d0NWSUN1eGxOb1NjVTFUOWEw?=
 =?utf-8?B?UGQrR1k2eEprOXk4UnZpMDVBNzVRUmZIYnpRdVF4eTJPZHdjbGIwMzFSNGlm?=
 =?utf-8?B?R0F2SjFTWXNzUnJINVE2bGJ0MjNYSGJSeEo1bEZXYnoyTElBaXg5VWhkbTlI?=
 =?utf-8?B?bjRaOWJkYXZwNFNENGd5V2l1VWhMVU9QTjBxamNHSnlIbUZjNTVTQVFudXV6?=
 =?utf-8?B?MDQ3MTFqSGE5TFU4ditNQ0dpN1BSWlQzYWhVajZqQ3FESFllWVdwd0tUWlIx?=
 =?utf-8?B?NEFteXkvemtLTTA4aFBCSEhFVjNoc3E0KzJqdUpXZTgrbFZwT0VXd0J5NU14?=
 =?utf-8?B?M3dJbmlGRHprWXNDMFZqeWZxdXd0Qk1yS1E4UU02UWVRNFdQM2NUNitwZDdw?=
 =?utf-8?B?Y0Q4NVkvcWVGU0Nualg3SWJDQ05FNXBvek5CZVFpeVl3cU11ekRORjlxU1VJ?=
 =?utf-8?B?OXF2bndvVnBTYnVRYlFwUEYrekdNL2J6N09QbFZZcE9CS05pU0FxOStvWXJT?=
 =?utf-8?B?Y0Z4ay9DMGNzRDJzZUNWTis5R29UbGIzbS9YdmpFMWMzYTI2ZTMvbEJiRERl?=
 =?utf-8?B?MDZ4T0hVOVN5c1RpdkZuU1U2K0lidzlFWjBldXE4LzNOSndpUmR1aTViWTEw?=
 =?utf-8?B?ME9zWnFueXV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmpObnI1ZCtqd0IwK1JzUkVLVlE1S2RhbEVjMkNWbXZIVFFzSDl2R3hJMTJp?=
 =?utf-8?B?eklhQjJZbFhCVUJxMXZ6aUZWVDNkUnVFZHJ0V0VEYWRLVzYxSTlEYnNoN3RW?=
 =?utf-8?B?QXFyVnYrakVuazE3ZFVMQ01FYVhPeE52UkpGYm1hTHNCblBnSzRncWlJQ2Mz?=
 =?utf-8?B?eGFqNjJxdGl0OEYrc1hJa1RkVXdBWDh6c25tSlFkaVl5WHZyc3NCdFgrbzRI?=
 =?utf-8?B?Qy9Jd3FwRkErQjJrK3RHdU43dmZRWEVhcm9yUTdpMFdKVHNFWHJLZGFYLys5?=
 =?utf-8?B?TWVTMWcyemJSMUZNaVo1V2UyaEM4ekp4L2p6TFhXeURTTUIwOCs5NmhUYklw?=
 =?utf-8?B?a2p5ZHArYWxMaXZmS1JsRFlXODVVZnZ4ZGRiVWtvZHl6bU1kREQ1cDliTEtt?=
 =?utf-8?B?K3pmMS9xUENMZlZCcW04OXgzZmV4OVlWZmUrU1I5UXF2YUdzU3JseVFTTzVZ?=
 =?utf-8?B?RGtlNnFMZWJWZk44MG1sMUxaSE9NR0JWeVVOZFpYZVMzYWFrSU1DelNWdGlW?=
 =?utf-8?B?b2wwcTZuWXA0ejBYQ2lTNmlWZS9ob2l4NEQyNld0NlNmV056N0hWMWNjNEU3?=
 =?utf-8?B?RDBTcHo4eWZVWk51bGlrSzhxN3RibUwxTzhHQjg5YzNHeC9JZFZSY2ZuTkpH?=
 =?utf-8?B?b3EzeVVtKzhmcnNTL0pxWTVYMUc3Si81OHJTdW1hcG01YXUycFMvMmVJQVRM?=
 =?utf-8?B?endLck5Ea1A0ZFpqOCtpU0t4UTQ3Tm5neVI4L2RHdXlIckVQU09XOGZMUFFN?=
 =?utf-8?B?eW40NHlXZWdmc0txemdZQ3VhSmRLV2tWdkdScndqYjdQTHZ5S2tzRzFZbHc5?=
 =?utf-8?B?bGxrSjA1NGxYNkhEMVZBK1VuWm1XMmt3V1NVMXNsMGl6NVROUGRGeDFjQm5R?=
 =?utf-8?B?YTQ3YXk4ZUpRdkVIWm1BTjJ2dkI4YkN6NDJsM0ZPeGg2Y1MvNWdBdXNkNGxQ?=
 =?utf-8?B?YkwzVHpRNFVmY3p2TkhrSWpkMXRjR21XY2RoZWsrVjMxNlFRalVMZUlMa2hj?=
 =?utf-8?B?RmFmUkRuN1BGUzhpQnhJK3QyM1p6L2JNYit4RjRnbTBqQlBsYjAxaXF4ekwy?=
 =?utf-8?B?eGZoQ1dsM0xpbU9PQmpKL2VXakNnd2J2Q2hCQXZQYzRiRVJtdTZkRGJrVXZi?=
 =?utf-8?B?ZzAzUXZCYkk4VXZZc1Y3eS9EUU1VSm8wV1ptQXNEa0VqblhEbmdhSndjckxY?=
 =?utf-8?B?NHEyNHZjT1ZhenBmWE9DNm8wVERXRFFPcWQ5MDdTd296cWVHOUZTTmdxV1hm?=
 =?utf-8?B?YVE0bGJPU1FtT3hCN0tnT0J5VXRYcWRYaTdGVHA5SHI5ZDRyOUFpaUdvZVNa?=
 =?utf-8?B?MXFjTVJORU9McTl5bEt2Q2lWZy82Z3dqeXd1dElPYkVWYXNJejJXTmcyb2Vm?=
 =?utf-8?B?WFpySjhCZnlsVGp6QmpHV3BRS3N0M05lR2xHam5UZktFMW0yK0hJd2gwaUc5?=
 =?utf-8?B?elhDVGp3RG43Q3pmT2hNaEFEeFc0djd1ejZ1ZTRSSXA5K1hFZU9ueXRLUnU2?=
 =?utf-8?B?YVl3eUt1OXJRRnY4Q3pDY21LeENvalJRUEI3eW10SGFlNWoreUpnVldkVWVn?=
 =?utf-8?B?dFMxTmUxVkhrOUg3c29qdnlDaUVGZWJsSEk4VkpEMkRUT3Q2Ynh3eDJiQm5j?=
 =?utf-8?B?NEQ1TkF1Rnhxd0ltSXNHbFpjZGo1bjFlM3NqUngwcDhZNnlOU2dsTkNWMWxU?=
 =?utf-8?B?MHAzWlJyQTJaanE1enE0TTBxNW5VQ0kvU2N3SHNWaXErL2RkcitYY3V4R2lr?=
 =?utf-8?B?UzY1TXhVcmQ1Sm4xc0tpUm93MHhsU21pZDI5OXE5cGpWeFlMOWNPemk5S2ZH?=
 =?utf-8?B?dmNteHZEY0Y1NXB4TE1EWlR4TjhsQk1MSW1ON1VscEpDOFBEc0U3aGsrUU5h?=
 =?utf-8?B?eitrR1ZKS09OUmJ5RHI1OWl6TnIwaHlZWlV4R0U0UDVLUTFLVmRlY293cUl0?=
 =?utf-8?B?K2Q5bnI5MnVKd3BpNDJjMmQyeGRXZ2dUb0J4REtsRGJxWi9CYmFtMTcwN2ly?=
 =?utf-8?B?L0hibTdYVitLVHdlQTlwS1RiMnZuUjVtUUFjcVI0WVpUZDJ1TDdibTVzRTZP?=
 =?utf-8?B?aFZVc0J6aGZLUkJJbUd6L21ySUFmU2VDd05BNGlBRjAwcEhaSFBrTzJVKzRV?=
 =?utf-8?Q?F/J8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b8e99c-f21f-40a4-eab1-08de2077120e
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:34:51.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5bHD3Y3/C/snZ8EOuKT8IjzJc8oQ47o7qEaLu+8K2JXuxNa5rpbiHXCEuIYVBUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180

Hi Aaron,

On 11/7/25 18:19, Aaron Tomlin wrote:
> On Fri, Nov 07, 2025 at 05:08:03PM -0600, Moger, Babu wrote:
>> No, I don’t agree with introducing this new interface.
>>
>> These settings are intended to be modified only by system administrators,
>> not general users.
>>
>> Administrators are already expected to have complete knowledge of the
>> hardware and corresponding configuration details. They also typically rely
>> on benchmark data to determine appropriate settings.
>>
>> Additionally, this approach is not consistent with our existing CBM setting
>> model.
> Hi Babu,
>
> I fully appreciate your point that system administrators are expected to
> have complete knowledge of the hardware configuration. I believe my initial
> motivation may have been unclear, so let me clarify the intention behind
> "io_alloc_min_cbm_all".
>
> The intention of this new interface is not to hide lower-level details from
> the administrator, but rather to simplify a specific, high-overhead
> administration task and prevent human error, which I encountered during
> testing of your series.
>
>
>
> By default, it is my understanding that when I/O allocation CBM is enabled,
> all applicable shared L3 resources typically have their CBM bits set (e.g.,
> ffff). If an administrator wishes to revert to a clean baseline before
> applying a subset of dedicated bits, the manual process requires them to
> not only have knowledge of every single Domain ID
> applicable to the shared L3 resource but manually construct a long,
> error-prone input string.
>
> The objective of "io_alloc_min_cbm_all" is to provide a quick and accurate
> medium to revert this topology-dependent default configuration to the
> minimal supported state, thereby avoiding possible miscalculation or
> omission of a Domain ID in the CBM string. As shown in the usage flow
> below, the new interface drastically reduces the complexity of setting up a
> specific configuration:
>
> # cat /sys/fs/resctrl/info/L3/io_alloc_cbm
> 0=ffff;2=ffff;4=ffff;6=ffff;8=ffff;10=ffff;12=ffff;14=ffff;16=ffff;18=ffff;20=ffff;22=ffff;24=ffff;26=ffff;28=ffff;30=ffff;32=ffff;34=ffff;36=ffff;38=ffff;40=ffff;42=ffff;44=ffff;46=ffff;48=ffff;50=ffff;52=ffff
>
> # echo 0=0;2=0;4=0;6=4;8=4;10=0;12=0;14=0;16=ffff;18=ffff;20=0;22=0;24=0;26=0;28=0;30=0;32=0;34=4;36=0;38=0;40=0;42=0;44=0;46=0;48=0;50=0;52=0 > /sys/fs/resctrl/info/L3/io_alloc_cbm


Does the following option work for you?

# echo "*=0" > /sys/fs/resctrl/info/L3/io_alloc_cbm


Here,|*| represents all domains.


This functionality was introduced when adding support for the*"mbm_event" assign mode* (see [1]).
[1]https://lore.kernel.org/lkml/b894ad853e6757d40da1469bf9fca4c64684df65.1757108044.git.babu.moger@amd.com/ <https://lore.kernel.org/lkml/b894ad853e6757d40da1469bf9fca4c64684df65.1757108044.git.babu.moger@amd.com/> <https://lore.kernel.org/lkml/b894ad853e6757d40da1469bf9fca4c64684df65.1757108044.git.babu.moger@amd.com/>
Also, this needs to be done for all the settings like L3, MBA also SMBA.

# echo "L3:*=f" > /sys/fs/resctrl/schemata

# echo "MB:*=128" > /sys/fs/resctrl/schemata

I’d like to hear from Reinette and Tony if this seems like an acceptable 
approach.

Thanks

Babu


