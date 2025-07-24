Return-Path: <linux-kernel+bounces-744002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA252B106C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA001CE592B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D702D257AEE;
	Thu, 24 Jul 2025 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="boEcYcKN"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012033.outbound.protection.outlook.com [40.107.75.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E1257AD1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349801; cv=fail; b=BIJlCXPD1RAJeHD2EEzUEBAT9sXbbKgXW9dibzP5EnOeF4B5J6g83EeVAbtHfYvNoAqtcqGkgWF3eeJhEZMz0t5MKNSjiRsX32Cd12ZwOZu0+GaAdBgRDEUeC3HeHcakp96UI7QjDtdb7c7qwqJTuWi/IiSBK4frS/2/R6qgdIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349801; c=relaxed/simple;
	bh=e25ZLurLwMAxhUTKp36beO6UYzvdnErRAybShGYzIhc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pEf64+W5UkVqmObhEF9dltOUYEYpUnNdOrXx9QAYP9NnwBg5CJ7P1WRPhtYYjbeAKEUSyIOdL+1wtCWoor1oN5AbjV4huJZbjCmomQ8K5bK/KuwRjYSv+DJEgab9YY4LAEhtVz/ayjrz2Xyci4nxajY5qV1JuNSRZbb2Ameba84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=boEcYcKN; arc=fail smtp.client-ip=40.107.75.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCN9E+9P1s0/FenY9Oj3lm04iBJp3uG6Gav5E5vqtOgfmTf5RlzRZGjXDA2NLnLT8enqhNpw6l+jY2BTM8Q3IFxG8HCo7EgBJUsWf77DoSmJtHPhSyJuZMS24JQKvDzsbauouZTOS+88/pjwfP/qp4Mwbz4q0YhZQKStWwX4wddUUWd+u5F1hK0+NlpF61f3rvuSRpUO5fgBuatpdLMHEY9ULtUBahYHoapG/4vQBe3urYLZBVQNuEGKAfh7ddWTDwkewiXHOmCt1dKF3jMi532X6+ni02EZmT9xWovOzu2n9jHYWR3YXeATCl48VfkARct+HjR3w3Q3v682mzoqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53mHRHbnkcaXOexWL8cDGwbwJVeVOlA1WgPgWe77P8I=;
 b=PViW71Qud+dsM/eBun3kuQ1Rn6j35vjdS2h4nVwP8X20tEYLJfasRRO/V+2NnLofxiSvEarHpuqJHuLpn2+U8VrKIy6CpyBYn1B+qyVuJic7G+MfzBoePkGBMm8nMAW2amla7rqxbd4ExcINE7N1oxbl4kA5D8UMRi+zpi42QslIjlWWCJUhygvT8tUYEQLwj4VBk44Wmf91lfTrR9NguaIWVTiNrTG7h0cftRZdqRYCqfbJRHQH56nXg2bNwtyuVabeSuwn2YVLqWrBNJhQv2ihqBzwQ4lzT5gapwhX6Tr++UQpnrRzMv/pbrmwdiP0KslG3bkyP9aMx41ONMitsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53mHRHbnkcaXOexWL8cDGwbwJVeVOlA1WgPgWe77P8I=;
 b=boEcYcKN5KWurihwON3sU4pPJZO75WCrNP7dK39YXmxRE4VNd1L/MMcnI0yP/ah2a9itRPy3I0NQV/QgwVQMt/VH93S0OnptTxBaHBGo02doBTioN29GN8z6rCSWYfY+MvnOgKzvImqCVL33l5c/pOLn8gydP29FuCkXGbkAIXgSjWPIhF7UOy/5KSyCJtHsFPYhIU8EHsl7yDgCE0EWrVasapeJqBRUyJKWwph6zege/u7zMKPA8xCoHrl73v9ZmpvZxNhkkw0j2MJJX+pCgMBBBB9TiiNLCHLOU8iUe6ZjDijmvzxK9UbgF0uQAF8oK4jJBtdQwLUG0kR8thQYaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB6639.apcprd06.prod.outlook.com (2603:1096:400:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 09:36:34 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 09:36:34 +0000
Message-ID: <cd253bcb-3ffa-4871-ae11-59d158fafada@vivo.com>
Date: Thu, 24 Jul 2025 17:36:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] introduce PGTY_mgt_entry page_type
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Yu Zhao <yuzhao@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250724084441.380404-1-link@vivo.com>
 <86516155-f2d9-4e8d-9d27-bdcb59e2d129@redhat.com>
 <cc560d48-884d-4c8f-9fb0-565d74ad769a@vivo.com>
 <e9bb93a6-1e95-40e5-ad10-a60d80735432@redhat.com>
 <6d14e212-418e-4734-b256-b75c6fade25c@redhat.com>
 <23b986e2-80d6-432f-8188-7a11d6915c9f@redhat.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <23b986e2-80d6-432f-8188-7a11d6915c9f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dcd1412-e546-4c9d-5f3c-08ddca95941a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXZOTzZJd2tEV3M3VXJPSEJpVmw2STkwdk9OMzVma1ozeTZ2QnNkSUpPL295?=
 =?utf-8?B?MEFJaDhNQlF4WngzSDdLdXhxc1kvMndZVVFrc0dXc1FoK0ZYcGhVNlBRTkxN?=
 =?utf-8?B?OXJlMnJPZXZVSFR3eDVpSGpJRWViZlJZellWT0UvSC9KLzRiQjY0WTVmOUhX?=
 =?utf-8?B?ZFZCKyt6UStIaSs3U3U2a3VPbmZxSnlpT1EyY0ptZFNibkhNZkZRMXVPVHlT?=
 =?utf-8?B?aSsrdWNNQ2hBNXAwY0ZZYUw3Tll3YkpxdHdiRERPc2w0Mjk4VUJhN2x4S1Fn?=
 =?utf-8?B?QWZxQVhINXRkNlFtZ2tFNmZEWmNrdXl6N1dpWjY2L3paYkJPUGkzaTVOcThx?=
 =?utf-8?B?ZzFBR0JvR2lTRkNWanJ6b1MxTm9IbUt4YiszZmdIMWpmVlZ0bmhmS1hkOFM3?=
 =?utf-8?B?ZDVRQmxVdHdjejh2dmpia1JaSk1ZSDNnMXpma0o3QWJvZUhkYlFVbkJQY09I?=
 =?utf-8?B?c20vR1Rib1hBN0xuQmZ6dERobFIyd1BtUWd6VUFsWHBzYlA1RFllVXJUUUtq?=
 =?utf-8?B?RHhpZEVQYXkwcWtCS0s0UDBTUk5wRFpPOUZGdjhoQzBEalRObUpQRUIxN2Jq?=
 =?utf-8?B?c0tWMit0ZTFRbFFLQklyUGZqUW51ZlIzYytLT0R0aTltUVRkamt0RWxWRmM4?=
 =?utf-8?B?dFM5QngzTTZkbkg5NmsrV2NWaHd4eHBCU0VqMnRJeVFZdVIyeUlxd09tWXVQ?=
 =?utf-8?B?WjllN1hDa2hId1gvMUVha2psbnNPcWt2UnZBaVZLdnFJQzcwUFV5SCs0bkc2?=
 =?utf-8?B?bHRHNE8zOWtYTk9tSTF4UVJMZ3E5N0dMdG9aTG9JK1VkMU5DaVBoSGdvZjBv?=
 =?utf-8?B?cGE2cmRMd2l2RzhyZFFaN29oSzI5dlNmRW1qUHkrZmNFM3NWOHFISzFXeVFD?=
 =?utf-8?B?T3ZNc3NhSXFvNmM5M0VoSnFvd0ZUVXV1M3lVWG5LKzVWT2M5SlY3eTIxWUxX?=
 =?utf-8?B?TE9DY1RGdGpqVkhIbit1M1ZPdTdGb2dYUlZNV2lFbnZhTlU2NTNjVysvZVcv?=
 =?utf-8?B?MTZzVVVzR3lpNG5lQlgwNWE5VzdFS3pJekwzckw1NDQrZHJpc1hIY2kyVUUx?=
 =?utf-8?B?TWdBMkhLQzJ1RzYwdWxad0FZT3lsOC9TVElsalV1czVsck1OL0VnUGg2MmlW?=
 =?utf-8?B?Sjh2YUNseXd1bmhabm1Wek91ZmV3SmdsSkl6RWVYcEVDODVQRUlMSmJzYWkx?=
 =?utf-8?B?NmV4Nm9sVE91b0V2NnBjbGRxbTArUkdBcWJ3eEk3UUlWTXFQMWNLcHNVV1J2?=
 =?utf-8?B?c0c3VStrd3hsRTVMRnBERHhuWk15d0d3eXJGSmpISmFyNTJsVG1VaFVHQXND?=
 =?utf-8?B?dm5vZnpnK1psRVBPbkxobU42Vk9VOHl0WTNrSUVGYzBha0ZtbkhqcE9QTENk?=
 =?utf-8?B?c1RmNmc3VDJLS0VZTWV2SnRZcEZZcjlmRWtWc2EzTGJoemtJWmw5c1RnU0Ry?=
 =?utf-8?B?WjAvb3ZPcE9UakhYbDJhc0hjSERDMkk4Sk4yTU5Kc0Y5dVVueExqbjRVWFdt?=
 =?utf-8?B?eGNrTk5qMzFPZHRQV1lBMklLek1PV3REWGc3QkcwQXNoLzllWmpEaCtZZ1J0?=
 =?utf-8?B?MGJKWTVyL1JpanFvcjRhcy9ld01BdVlPR0tSS0JBM3M1S0VuV25GbnpubVRM?=
 =?utf-8?B?MjRvTk9Vbk1yRUF6ck5VYnpjb1dzZG9EK3R1ZzdJMTdQdGxXVTdyMWh4bWt4?=
 =?utf-8?B?bTBHN2QyRWxjeFowMFdFMDd1UFBDMHZ5UEt2QlFSQTdVOGxVTXlralROSjBk?=
 =?utf-8?B?YVhScE5HbWJ3ZGFrby9tWk1OY3p5MVp2djRLUUpybFBLVjlacUJLa2NjMytI?=
 =?utf-8?B?cUJlWHZvSDZmdVFFR21RV3JlVXJWWTNzQ2tCSEhHT1Q4c2dzVlpFUGF5Yzcv?=
 =?utf-8?B?dWhCWktkM2x1VnE0RUNsS0pxcWF1c0NlSGNqUEkyTjdMRFZXRHdyYkMyVkVq?=
 =?utf-8?B?R2RIOERKT2ZJSWNPRjVpLzFPejZxczlRb1BwMVptZElYOU1jQUQwRTlQYVRX?=
 =?utf-8?Q?UHTmVRAA5kG3dhKXWyni8ajQh5JrR0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEF6SGpIa1RmSE5aSWRuQ0VLaG5LSWRBTlZGQVArUTJudENlUk1uYTVLREpN?=
 =?utf-8?B?UGNuRW5CakNCZ3JRcVFsajUzaUF5NFZZcDVMbktENHRZYXMzeXZhMERkZVF1?=
 =?utf-8?B?WXR6dytuL2ZXUVVhOG95TlNvSjQ3cE1pL3RnYkRtN2hOVTdUc1Jhd3lQdmJS?=
 =?utf-8?B?WmxuK2RVcjN0WlBFUWc5cUVQMW12bFJOWkZFbk9HcFBTdTg3dVllUityODhN?=
 =?utf-8?B?ZUVxN3k4QTRKQkhNUnZETTA0alZESk13QTlnQktJSXhpb0Q2RTVkaUVKYkth?=
 =?utf-8?B?WS9HREVXNFVxOWJnUkZuSEtBNHJ5dDI3Z3ZnNzlkQ1lpTlRPRUFvNHlOMVQ5?=
 =?utf-8?B?ZWk3dTBHdjJEVk1aVHNIamc5VDdJTmY2NWpvb3luSjFod01oVG8xQzA0dDNT?=
 =?utf-8?B?MTcxYWhoWE9ZUUFCVm5OczJjNndrSmNxdUM2MjFoV1ZkeWpKREUzN1AvU1l1?=
 =?utf-8?B?dlFnbC80dFluRmNHMGVHM1pvWlpNUG9WYjBQakJhZ2x5RWpLb1V2QWh1MWh5?=
 =?utf-8?B?emxQQnV4TjFKQXYyQVpObzdwaGVyK05sZXBZQmk5U3ZVbEVERlJNU2U1V3Qz?=
 =?utf-8?B?c2xYaVVnNnArcTZLcGhZREJvV3R1M295dzVNaU42ekx3dS9RTlRjaTBkNzQr?=
 =?utf-8?B?S080clR1UnNRTmtQcWVmZlZDMHR1TENPaWFiTkdSTE9xS3FxUmtaUWhtdTMr?=
 =?utf-8?B?N0U3SXRwRHdtVW1qcmxTQUI3OU1WcnBGd3kvMWw4TndDakM1UDV6QVB1bGdU?=
 =?utf-8?B?RXlQNkN1QUVyNnBVV3NqWjFNUFRTSWFNcnZjNlptejM1Wk9NODZudXJJd1Nq?=
 =?utf-8?B?aGFUeXpyVHJSUVo4ZzhsQzY1QkR5MHlnMG5SV2pMOFZJdmhRRlAzWTdMZC9Z?=
 =?utf-8?B?L3ZXTEhVQ2VTTU42d1A5aFRXaFVvelhmZVp3K0hQc0FCL0Y4eWdtNURqSWNz?=
 =?utf-8?B?cUJHYTZobThiNlJuTFBWcHdqMzFTQkE2OWpzVzNzaFI0Z3lKMzdqRzJ6U1hs?=
 =?utf-8?B?Z21OZjBRTjZ4MmdTUFUzNitGek5zSUhpMGlwbFluc0E2aDZSRWxSMjBXbmRR?=
 =?utf-8?B?Y1hJMzhqbEF5eXp2YnZWdklaWTVkUlpHKzJGUHY3WFFVOXViU3VRQU5PZFRr?=
 =?utf-8?B?RXhuWTltNG9lWWJ3RjRBUlg1VjYwb1JGTWRQZnFTN0pVVWl5MEoraWFJbTJE?=
 =?utf-8?B?TDNIWUd0NVV4ejRiaS9HWnk1dUtqb0VEcVk1YWdSQTNXQTVSbkVJeHhPWGp3?=
 =?utf-8?B?aHVoblpUcGFDY0dkcUszS25xRmd0Q2J3ZVNxY3Ryd1VudHdsYUJBaWJkcTRz?=
 =?utf-8?B?cHpha0hiUlRWcDJ5U1JVejRQRTBmUUxGaVhrQVFWZ2pRUUlIOUVUYms2MUl0?=
 =?utf-8?B?WU9CR2h4VDZiVG1GNjE2d0cwcWNGS1hIZ2lPWldxTnBsV0FpdFJOMlRoQXgr?=
 =?utf-8?B?L0VFL2REckhYaGJxTnNQTXc3SjJsQlhwTjRScWRHWCs1N09UQVloZ2dlb0NC?=
 =?utf-8?B?VEJwZk1vZDJVbnZVVzdLQWc0U2dVeDJ5eFRveithM00xczhWN2ZOcjN1UDhM?=
 =?utf-8?B?QjJMTnhOdHhhdGRGZHgxU2dBc1ZVVElQRTZMMTRvNEt6SHRsMlhMWEIyc0ly?=
 =?utf-8?B?TThUUEtNTHpnSmJZRHZ6S2dvc3RZSHhUYXRKaXlSQ0U3RVJUUm9pdnErV3lB?=
 =?utf-8?B?dUtqeE1Jdkcrdkl4RUtHVUxwUU5vMTFSbm9oUDhPbEpITUZNeUMxS2xYaTFt?=
 =?utf-8?B?ZVkzRXgrRHFHVmZJVU9PV21nNkxwM01DZXZGRnp5T1pqVmJsMk05YVVrYlFD?=
 =?utf-8?B?RVhxb3cyZnJrZ2R1a0xQQjJzNDBmbTkzRXRoUS9vb1BsQTJmZkZTU01sekk0?=
 =?utf-8?B?ejZXWkdPYXJZQy9oTWRHMVBYR3JJTUwvQmZDV2FsbjBoc0hqUXJWNy83d0lt?=
 =?utf-8?B?TU0wSWNZUmVmWkZPWlk5REFiT2pUQmJyV2w2M3YvOFdhZ0d0c0xSUGs5Y0ps?=
 =?utf-8?B?dHJxQkg2ZnRtUUlSekpQeFNVNHZkZjF6YWJuWmZVY1cvbmRUZ3lkTHNsV2tY?=
 =?utf-8?B?MGQyaHgrcUNEUWdCTVJlaG5nbkxVSURCWFpVUWt3bXdXd3BxaVZKS0Yzei9J?=
 =?utf-8?Q?B2JAy4kTYDjWCyRiDdF+9q49K?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcd1412-e546-4c9d-5f3c-08ddca95941a
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:36:34.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMPAcglzBUVVY3ruET39g4ObwvQ9sA+VSFkRTTMJ3tTmCTWMpn0GdqN/T3EOwv6+2MZEO7wYQqmE/4bP5ygGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6639


在 2025/7/24 17:32, David Hildenbrand 写道:
> On 24.07.25 11:20, David Hildenbrand wrote:
>> On 24.07.25 11:12, David Hildenbrand wrote:
>>> On 24.07.25 11:09, Huan Yang wrote:
>>>>
>>>> 在 2025/7/24 16:59, David Hildenbrand 写道:
>>>>> On 24.07.25 10:44, Huan Yang wrote:
>>>>>> Summary
>>>>>> ==
>>>>>> This patchset reuses page_type to store migrate entry count 
>>>>>> during the
>>>>>> period from migrate entry setup to removal, enabling accelerated VMA
>>>>>> traversal when removing migrate entries, following a similar
>>>>>> principle to
>>>>>> early termination when folio is unmapped in try_to_migrate.
>>>>>
>>>>> I absolutely detest (ab)using page types for that, so no from my side
>>>>> unless I am missing something important.
>>>>>
>>>>>>
>>>>>> In my self-constructed test scenario, the migration time can be 
>>>>>> reduced
>>>>>
>>>>> How relevant is that in practice?
>>>>
>>>> IMO, any folio mapped < nr vma in mapping(anon_vma, addresss_space),
>>>> will benefit from this.
>>>>
>>>> So, all pages that have been COW-ed by child processes can be skipped.
>>>
>>> For small anon folios, you could use the anon-exclusive marker to 
>>> derive
>>> "there can only be a single mapping".
>>>
>>> It's stored alongside the migration entry.
>>>
>>> So once you restored that single migration entry, you can just stop the
>>> walk.
>>
>> Essentially, something (untested) like this:
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 425401b2d4e14..aa5bf96b1daee 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -421,6 +421,15 @@ static bool remove_migration_pte(struct folio 
>> *folio,
>>                      /* No need to invalidate - it was non-present 
>> before */
>>                   update_mmu_cache(vma, pvmw.address, pvmw.pte);
>> +
>> +               /*
>> +                * If the small anon folio is exclusive, here can be 
>> exactly one
>> +                * page mapping -- the one we just restored.
>> +                */
>> +               if (!folio_test_large(folio) && (rmap_flags & 
>> RMAP_EXCLUSIVE)) {
>> +                       page_vma_mapped_walk_done(&pvmw);
>> +                       break;
>> +               }
>>           }
>>              return true;
>
> Probably that won't really help I assume, because __folio_set_anon() 
> will move the new anon folio under vma->anon_vma, not 
> vma->anon_vma->root.
>
> So I assume you mean that we had a COW-shared folio now mapped only 
> into some VMAs (some mappings in other processes removed due to CoW or 
> similar).
>
> In that case aborting early can help.
>
> Not in all cases though, just imagine that the very last VMA we're 
> iterating maps the page. You have to iterate through all of them 
> either way ... no way around that, really.

Indeed, whether we can exit the loop early depends on the position of 
the terminating VMA in the tree.

I think a better approach would be to remove the fully COW-ed VMAs and 
their associated AVCs from the anon_vma's tree.

I've been researching this aspect, but haven't made any progress yet.(I 
have some ideas, but the specific implementation is still challenging.)


