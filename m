Return-Path: <linux-kernel+bounces-744041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F3B1073C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B8B7BA1A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430DA256C89;
	Thu, 24 Jul 2025 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ELleoyH0"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013045.outbound.protection.outlook.com [52.101.127.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF778F51
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351308; cv=fail; b=JOzT3mKeBsyg1Sny7y3h8YfXtQz4mICPwOxfYUzggU6ONq0JjLN8RI4XC8EyQG945fBK1IxEEsC8l3LNwHJcc2gG0KIuqYBa5Cxq52lzs3TX/e0IWR6hNvi5CYyv8Tn8t6VA7rEm4Z3lvfSaEHmQgEhnYcPvRzeWGuY7BYGIXjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351308; c=relaxed/simple;
	bh=3YYvecIOSE1fMvwPWfBygj9h85HjlXQ7v16IwoD6RjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wj4Y/K8AHK8REOLJmiLyLhvjBJSbqi9mvGluJ5vzDZP6wMoBns07kKPfThuvewtwi01GSzumKLWPIFYY7l1U88+kLKXJXeYh0ULftR0cAIQ+g+3CpNxh3Cvd/ZeXl4JSWhqEz8N3nBIIPhQmiKiPAHiGX5CylMgCTsd5bLCj87Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ELleoyH0; arc=fail smtp.client-ip=52.101.127.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qyn5ddpVpCZWGbyMHRm2Rk+6oOqTGnQ2VK+kLMMczo8rYGDzqfoL1aPueyuOT2LNb9wrj7iILNQSPe6kT8a8n3OUOQpo5uuPr8tjFGmkd3p0GKJQK7/9oVzX0gxPoEho5lixODu1ZwEnWBuZmFb/xnpGnP1xleT/MHKFP42rmfNcrXbxrdAz377GNICktm6o+fQ6GkmN2lXgx14NjoSvy+Q4QJJYUqkiqhvXmi/1ni4N/IMVDzXyvwKTkmRrTa0mFrfehhTHAtK95GFX/4/PRbtPCtAIjZGtLwm7PPCQR8B1imRJzTKLIKlJ566wGhD4oo44ugm5LqjbynxaD+Gsqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3C9R4jl3GsCdZu295tvsEcCGkD7WiHsUqV/cbDeyHw=;
 b=IOYnw0FJnnUqv1Laeb/x5BJ4dQNpWoYyZoCpknN8JGEnoKv5y5yCfiMwdXtWvakMnhJObBfhgRsrUT3Aimuu/iRGxqHt6nFYwHFOCQCDWy4NhNe7qcV6LpWXEG0oRjC7NHXrCl2tyyEjSl+vyC5Pth7SlmkAvK8J2s6l1dR7xcwtjFoVlH3tSb/y6MgMEGnMvQo/HX0mufq0CcM5gbZ6yy5Kj8P7jkbT2a9utTIor6cUKabAapNDNPugRi3lONoszrhTINslz0QPqK4MuM1FiUZI/osV4TdvEg5D1n5TFtLBF0f57Opv0mEvr1t8asbbVZa5tJ3rTJ7x+5CZi2TuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3C9R4jl3GsCdZu295tvsEcCGkD7WiHsUqV/cbDeyHw=;
 b=ELleoyH0p+gsOmNunCnyevsi6Wc6yjtzedxrw7Xq2sbbWM9pWe2s+PQ7J1GcwBdR4QatPb9AtAr+zU90bqBIdRhrhbSYFljdWOI2B/yBreW5GOjXKNKuWOdWwJvqlkXhYoIgghS2vwZ54k96LZde3u2JvWIajBjk6+BLeYQQl4IGIJMrvDBxyK1nmmD+FF9ebMO3RwLoNW8NnUKS2uO0UDaKym8TNTl9CZYuXMKWiwxMIz19HQMMyFnIrXfp5/dJ9J7IXsnHgg9jnAGrq6soYWrCydWQGrDu3Oq2jyM8akg+oQh5QpNL7WmVwprqxuH6OGtSfIphT5F7MkAUObjpKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB6022.apcprd06.prod.outlook.com (2603:1096:400:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 10:01:41 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 10:01:41 +0000
Message-ID: <4917880f-df55-4c5e-af06-95b408021b71@vivo.com>
Date: Thu, 24 Jul 2025 18:01:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] introduce PGTY_mgt_entry page_type
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
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
 <cd253bcb-3ffa-4871-ae11-59d158fafada@vivo.com>
 <f21b75f9-0650-44c2-bf47-516390364a8b@lucifer.local>
 <10484264-e863-46e9-9797-d2d76a531557@vivo.com>
 <a7f8b628-14f0-49ae-bf71-14c4a3f4fd89@lucifer.local>
From: Huan Yang <link@vivo.com>
In-Reply-To: <a7f8b628-14f0-49ae-bf71-14c4a3f4fd89@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f13eb4e-63e9-4dbf-7fb8-08ddca9916ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vi9iV1hOOTNmTGI0ZDhLeWJGL0hUTzZGTUFGZ1NEQ0JCcUp2M0xFYW16M3J6?=
 =?utf-8?B?ejBwOHByZ3lkbExHeW5PdUxTRHZ6Wi9RL2FodVgrYjc3bWdtN0hvNUVFMWZk?=
 =?utf-8?B?RktJNWVLMGI1Z2F4WGxGVmdSbmdqTXBTd3luRjFuall1Q2p6UkpnaTU5TENm?=
 =?utf-8?B?d3hyL0hPSU9PVWNraCs5endhY0puUWgxRk1KMGlITTZ4c00rcjFUNW1CODRP?=
 =?utf-8?B?UGhLM2x1TW5WQldjdVpPZlgxRDhHeTltRXVNNzJzK3Uvais5V1lvSFFmbEFP?=
 =?utf-8?B?dWNsR3pVZUJKeTc2RFp4aVlRYU9DWExNTTdIZjU3SG5PRUJQSFpmZXJFTW9u?=
 =?utf-8?B?YVhqSmMzK2tndTZUUVIybWVOM2RtMXF1ZFJpb1NNenpGTTZ3TjV2a0JjMUR2?=
 =?utf-8?B?M3duQ1pSeHI2N0tSVVZ0Sm1ZRHVRQlhKbC8yYUlDOXZqSDJMaEJxRm9Jb0FS?=
 =?utf-8?B?YlBUY2V1bktqKyt3YldFdU96YndDL296ekN4b3VTQjN0anpuVzRpT2J2RDVm?=
 =?utf-8?B?K0ZiakdXQ01QV0w2d3JlMXl5RGpaZnBXb0xCQ2hHM2t3VG5LMEtHcU9hbEJS?=
 =?utf-8?B?aUc3a1BYN2xzdytkZDVMWGI2MTJxYnlGOGczWXRsMGRyK2ZaeExlcHJIaDAz?=
 =?utf-8?B?dzBDZzI5QTAzQTJ1YmNSOENjSnE4ekVsNVZLVzNCVFFRclZQcW04UllBTG1L?=
 =?utf-8?B?UUtzaFFRaGkzMVlwZmhoZUFOUUthd2lXUEdBbEZHaFlON3hwWmpSYXZFOWdT?=
 =?utf-8?B?TFRaaWFYRW9sb2RxSDVIKzFmYTIrVzhWTi9UU3MvVFhkV3hRNHNpa1hPOXFV?=
 =?utf-8?B?Mmp5Qy94Q1B3eEVsZEJ0a01RODVqVGJEaFM4aXhWbnB3MVdlQVR0bytCY2lx?=
 =?utf-8?B?MW90L0t0dVZWM3dOcVVuL1J0Zll1R1phNGJHcU0yejhBTmFRT1NEeHRINms0?=
 =?utf-8?B?clZpUG0xS1dMaGV2WE1TY0ZsMDEzUWtwdk9tUFVYRlhtSnRJZmFiWU9Uc1pP?=
 =?utf-8?B?QWlCMFMvQko3U2hTUFVZSVdLY2JjMzYvYlJ5RVNQc1gvTytaNVVWdHJURVdS?=
 =?utf-8?B?em54UmZnVTF0WXFCWVo0YWRBS1Y2NUtwYjhjeFE1empvb0o2YlAreHAwRjBT?=
 =?utf-8?B?aU1jOXZjblhMUjBkeDc0Y3p5VWNscXdMN21ubFJiRGIxN01xQWpST1BRMDlT?=
 =?utf-8?B?ZjZLa3pVaElSbDR1VnlCaDdXLzFGL0RGUk5XMm44QXRwRkVFcTIyWGxlSStH?=
 =?utf-8?B?M00wRWVmbXVjVkE3WFh1bm16akpJY0xJclZrSVdNZFpjOUpMdEp5STVRRENJ?=
 =?utf-8?B?SUVwR2h2SXhjMnd4Nis5Njc4Vk94T2JxWUluenErUGw5MERHRXFrNmF5S3ZK?=
 =?utf-8?B?VjBLd3RGczFYNmZPN2ZtcW14MWhhMlFoNlA1bzNBQU42K0xhaVlpeWlyZnB4?=
 =?utf-8?B?R0prTExVcjRDbW9uRk1oeWJDQytOTTZ2SjNSTVhpVjVGRXJjNmFFakU4N2lx?=
 =?utf-8?B?c25EanZLQkU5d2Nsa05BRkpTTlRpbS9EQ0tSdEdWcGgzMlVHOWJIYStNczJ1?=
 =?utf-8?B?VWo1WnNtemdDQ3E2akxNT0RQUUdWS24xblpwWjdqQlR1eCtXSm53b2c0MmNT?=
 =?utf-8?B?L29RbDNjRlRHRWFvZjRxNlgrWU9FL3d6MytldUdNOUdOdDFaaHI4WU1za3dK?=
 =?utf-8?B?bFgzbEp6UmU5czhuays0NElJbG41Z1pnQUxOb2lMY09oWG1ncllDT0JpWTE2?=
 =?utf-8?B?TlFNenFIdkJCejZWQlJmQTJidkdqem0rMWJENTB1TjNZM1NadnBML0Npc0gr?=
 =?utf-8?B?cUpUU0xpSmhWMEFyZytVa3VaVEFpVHM4ZTE4OHVabE1EOFJudXQyZGo5bEYz?=
 =?utf-8?B?ZWQ3UTVEdkJlYVduNzN1ZFpvU0hGQXlHc2J2dTBTOGg1ZTZSa05QdkFpVHFD?=
 =?utf-8?B?V25idkZtSFlVR1drMzdoaUJqRzZNMzJraWFCeHkvTkExWFVzblFwZEFaNVo3?=
 =?utf-8?Q?9S9MF/v3FhBP2W8eBi6mgsqnipRU38=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEJNOTN0Tzdrdjg5dEhHWDV5Zm1KUTBtMjNHTjk5dFg4WUxSeWVISm9JaVA3?=
 =?utf-8?B?NGZ1U2JpTXF3djY2WWJVRUt3NDN5MGxSeTRIeEZLejBFVDNoMkViL3A2dmJI?=
 =?utf-8?B?SmdIVURFUnZyTHRZUHo3MkhLWkxLdnJuSnV1OEZxanhKdEdLZjNJZHdKRDhw?=
 =?utf-8?B?T3JEVTdHbG5Rd2g4b0Z6TWthT3ZlNnBpS2VYam1zQ0hITE1rcVpOc0V0eklR?=
 =?utf-8?B?RWFsSFRMdENwMkR3SHltbzk5cmhYTDdZdTFrWFhTSkJzWk81b0ltTGM1dmk4?=
 =?utf-8?B?YjhPeFlzRVZCWXhad3I3UVBjSVd1c2RncnZZMkpPbzUwTGZId00zSXNLY1Q0?=
 =?utf-8?B?a080Um5obGp1K2lrRzB6cUJ5ZTMzM0krc0g1MDlaK0Yrdy9iWm9pblh4U3hn?=
 =?utf-8?B?TGsrWlJ4UmVXczhKL3VwMGF0RG93VnZpei9QaWhySHIwRS9CNTVyc1pnRWJm?=
 =?utf-8?B?d2xoT0ZIK0JrMVhkSUNaM2szQmNuMXdSL3FDY1dQUmpVSVZ1TGZnc0svZld6?=
 =?utf-8?B?b2R4ZWtDZnVzZ0pYWEh5bmd5ek81V2hmY240ZUJkdS9tc0pIdjFpbmtzcmVX?=
 =?utf-8?B?QjFFRzlRbkVOWlVLb2pFOWlLUk1FbHdJcW94SUxvM0I4ZVhKRnZEaUdjNEsy?=
 =?utf-8?B?ckFERFdEY2drNStRUXd6aklvQnQycmVZUGgzeWtreTRGUnZIcDVrODhMNzdt?=
 =?utf-8?B?SzZGYTJCNExzSThpRXIwUVlWQkJpR3hsaUVqeXd0V1FBTktjREVXb1g5RitY?=
 =?utf-8?B?L1hmYzJnQUhjZ3ppV0t2N1MvZXVXalF3Z0pOcFpuaS9kTHhMY24rQXVqVysz?=
 =?utf-8?B?M0wwdE9XbGxZeU1GZTRHdFg5b2VtTFpkZVUzWlEzZ0hZenRXYklvUzIwWkhx?=
 =?utf-8?B?TWdobUdlTHNmaC9TVmNkTElieE1uYm5GZ2VWTGF4eXAxRURGdEdhMlpLOFAw?=
 =?utf-8?B?U0ZIcmZOVHFPSXNLYXR4MG0yaVVuQjJiTkUwRnM0Z3FwRkNnY0kzV1dmQ2RI?=
 =?utf-8?B?S2pUbVdLeWZid2RYajhEYU80Sk4vY2NqMWl1VmdzTVJ4c3pzZHFoWXZvZEVK?=
 =?utf-8?B?S2kxTTkzZ1RmMThqVU00eGtXTFNvT0lkODQrZE1TMUJiM0kvcDdmemowSXFT?=
 =?utf-8?B?cXl3UU05SFZrSFhhREM4VElTbnF6OVBHbzlIME5TeEtNTjdkaUs1a2laTzAx?=
 =?utf-8?B?RGZXLzlBRmRMTXB4akRJVHJWSVlBdkIyUGpZRVVjb29YRCtjR3UzYW1nWk1P?=
 =?utf-8?B?VGFFaE0rMm9TVS81WEpqUUU1bjl5SnRVSy82bkg3Z1paV2pjK2VDUDMrSFlW?=
 =?utf-8?B?bnBWK09FK1BzamVBamtGYnJvSmdkb2NsendwbDZtMHB3bC9xM0ZnQVFDZWlV?=
 =?utf-8?B?OFBNNkcxMFlFV1E2ajBtRmV5MVhWMTZXVXgvMktNa0NwbitES1o0MUtiV1ZY?=
 =?utf-8?B?L2JobzFVWElHMlVrUkVkWlU0Q2RxbGU4dUxsUStPOEFEVERtQTlkOGpaTkRm?=
 =?utf-8?B?ZGNiM3diUDhkNHk2ZDltZ0pNYlRwNDlWNzJVSVJ0SWVYZWdpUHFmYzAvbEZn?=
 =?utf-8?B?U0E4eW80eW81YWVMZm1FWHdIQ2NPallVSXFoOHAvZjVVSHVKaTdPK2dZL21E?=
 =?utf-8?B?amlERTRGUWlnWFo4OWNudFhXNjVXS3ZJaGFaYUxCNmg5bU9IS28wUlREZ1dC?=
 =?utf-8?B?eFZHKzA1dzQ2VHJzcHo4NmU5VDJRTWJ3VjZlWGMvOXJ3OU9DTzNuOWtrNC81?=
 =?utf-8?B?Q1NYNTFsRndPSjBTaEIrb2xzUVNUV1FyaGxma0xaRmloeVFOOEdxVS80cm5z?=
 =?utf-8?B?TFhvenlkZjdWUzFLb2E1K1k1eFN2QzdkeHZMaGk2blBJc1FOYy9ucFpWT3pG?=
 =?utf-8?B?V2d0NjJkV1dtV1FrNTBLOXRMVTVkUjR4eXA5ZUdHbDZ4T1IzeXlzb2IyeVgy?=
 =?utf-8?B?NkJjbnYxOVB6SXhPY001UTNLUEhNWEFUVk4reVpZRmRhdUl1eUUrVXk1Um9Y?=
 =?utf-8?B?ZWtOYTY1VkVkVXVkVk5nSTdlUnZFejdQZFdtV3Qxc3ZhS1NhZ2hUMGlIaHNk?=
 =?utf-8?B?enBVUXdvVzhlZzYybUZjTkI1TEszMGs4bGZIeVI0WnBkazYzQXZkMFVtL0J3?=
 =?utf-8?Q?GpJbUfY2/T19vpNp86BoZN4aB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f13eb4e-63e9-4dbf-7fb8-08ddca9916ac
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 10:01:41.7734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spMd5hH4x7xpgh7BD2rQkqqcxDpIu7SC8cG5pj6oeGF8GMKp9j15ZkH+cFjZEwQ+meWE45kN9M389WpfSGUHgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6022


在 2025/7/24 17:58, Lorenzo Stoakes 写道:
> On Thu, Jul 24, 2025 at 05:56:09PM +0800, Huan Yang wrote:
>> 在 2025/7/24 17:45, Lorenzo Stoakes 写道:
>>> Having looked at anon rmap in detail, I have come to think the only sensible way
>>> forward is something fairly bold.
>> Woo, that's really interesting. I'm looking forward to this.
> Haha thanks, I found the one person in the world who's excited by anon rmap :P
>
> Or rather, the only OTHER person ;)

Not only is this interesting, but the efficiency of anonymous page 
reclamation also frequently affects the performance of our products.

In our flame graphs, we can see that many anonymous page reverse mapping 
paths are among the hotspots.

Therefore, please continue your work—I’m really looking forward to the 
results.

Additionally, if there’s anything I can do to help, I’d be happy to 
participate.

Thanks.

>
> Cheers, Lorenzo
>

