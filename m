Return-Path: <linux-kernel+bounces-750355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0678B15A85
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB46318A5265
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B340A265CBB;
	Wed, 30 Jul 2025 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="QZci9RvH"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2045.outbound.protection.outlook.com [40.92.19.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5B25A34F;
	Wed, 30 Jul 2025 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753863975; cv=fail; b=twW23EPq2G7HavCNVL9BHTC0vPk6laNk4inYfSv+X5BdRrvU3F7bPNzyGpPvSGqWgnff9tfkW9CzVY7Er2a1Du51DhGmt17lZrANz/U7w1VdVtFJX3JUnJlKkL9uGqGZnRoMmlVSEnJTHTPX2jqPCZKVVKTM7UvaQg17vvBHMRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753863975; c=relaxed/simple;
	bh=AeMKJsJz1XlVU0gU8kGeYYyaN8OqhT7DZE6qCo2BkL8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qy/feqSGfjBV1hoQwiRuPBu1gdMpZTMMs+L9Yq6e9k4AgqEY/ut2EdOp/eUkUV9tbocuo7/oTgHP0QwNqXgjbbfor+kEKP3XYH3NxpUDW6YR3BPZQwt5bOPBoJFdVcL62kc7cq6X/htRzFvD9wPj/Wfqlp7d3PLBn6r4sOPObkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=QZci9RvH; arc=fail smtp.client-ip=40.92.19.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oyw7tseb4yWvbMfvLcR5se+0wkPwRS4UshQZ1rx+bMs5E9kUv+JNbBrVyw9jTeizuVO+C9GuYfDZwwYyKRwaL90Q4Yh8pUMuB0iya+FW0SUyq5YF+EIz8Ad0aFE2lH4TvpYiEvfOPS1kN21i1wQZKcqqYCE3kvtu2y/8MCuC/BZifgUAaCN46ILwM3ks5zLx1CP+od8CXCKYMDypxWTY6rJtD7ByIOpS78RDTA7a/XwzNg01OniKPL5q00TVP6mMuDvbcZU0SSOLYO+Dqq/uy9VQEp/zs+A3Pj6esea3hy9kcHeL12VDD8hiVOS6nzhn0pXK+bC/FU8q+LM2D8byjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9grFlUwGitlzrUt+N1gItpK4rCMiceLXgGcVD4yHWQA=;
 b=el23LvXv6JM40NtgX7ohrnHlmPzI3jjilBzRSAwZefpolNVXNDLuTvchXhmbEbb0KXRRZgSGhjAuVEes4EMheQVtMGLMxpm6X65tnkVMfFiWgPeC9BFEvLb4sLpv6HgZCoJW3Zjke9EOCBJPX7Q//aIAdpjvhVtEld3FQlcrvduYIPep+2Vuh9qffqUHZUt67Qs5EXtDFHAhdX9ZTb83YTS7BerEpATQwxRJK90gi7xBsX9bqcvw+lLC8zPHOJaJxu4ZNoDgoJj4CBljnBroRwXwOGq01IpsEhiMo4UnX2kkd79ZggkTMgi7f8sLTf58gVy1atpS5MnvBvMtxjak0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9grFlUwGitlzrUt+N1gItpK4rCMiceLXgGcVD4yHWQA=;
 b=QZci9RvHqxLwQWzmkTWI3C3HSryHQ+a6xWVkv2DwoTmEsys6lteFbpEk/5J/pDKJH0oD+MFEJv+5voM2h1bntuOeXnHgwUWgziKAt9eM4E3LwzOtt1Op/nBhoo0q1RfFt+P66+XHq2t51u+b6s/R1TDmxXkrH7AFsvJiQvF2aos4VjBWwoZs1I1XOl3WR0Y+is6xXWpdZu5ZhS9Xtdq8i0wNJUloDiZQVhjk0xWFyFsT+u1F0yW/QYEMzgi5V6FFJ2DOXmFn6icCpVZpzEZc5zCAjIA8nK6hQ3rpKB83h5kiqn0knsiqiUM1t3fApmKaCgyM/kRwBZIMdAb1stv7qA==
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 08:26:10 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%6]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 08:26:10 +0000
Message-ID:
 <CH3PR12MB90797F5DFD93753FFDA0312D9724A@CH3PR12MB9079.namprd12.prod.outlook.com>
Date: Wed, 30 Jul 2025 16:26:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] rust: allocator: add KUnit tests for alignment
 guarantees
Content-Language: en-US
To: Hui Zhu <hui.zhu@linux.dev>, Danilo Krummrich <dakr@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 vitaly.wool@konsulko.se
Cc: Hui Zhu <zhuhui@kylinos.cn>, Geliang Tang <geliang@kernel.org>
References: <cover.1753841900.git.zhuhui@kylinos.cn>
 <3ad14f15b6d2639d6e998ecd03158313414b69dd.1753841900.git.zhuhui@kylinos.cn>
From: Kunwu Chan <kunwu.chan@hotmail.com>
In-Reply-To: <3ad14f15b6d2639d6e998ecd03158313414b69dd.1753841900.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::30) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
X-Microsoft-Original-Message-ID:
 <883e55c4-9628-4131-acd6-e495d60ee8c4@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 13019b18-3b1b-4d1d-0136-08ddcf42bc17
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|41001999006|19110799012|461199028|5072599009|6090799003|440099028|39105399003|3412199025|40105399003|41105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmEvQXZJTUxMdnB6a0M4NGtVbjEyZmkwZTdUbStIREJFNDhlOGd6czJJeU9q?=
 =?utf-8?B?Q3dINVNocWZnb0kzZmhnMzdhRzd1YUdkcGhmOXNsWmZ4RUc1UG1ad0xMaUtK?=
 =?utf-8?B?K1NDMURlNFZJNHJZU1JqbXVKamUwMk1HV0JHQi8yQnQ4Ty9MbW5PclViU2dt?=
 =?utf-8?B?Tkc3VzZjRTlWUGtQSWE1ak5MLzFKTUVjekVkZ3NZbUFKRFllSnNxVm5wb2pL?=
 =?utf-8?B?am9FcFRxei90NW4xQmVsdm5kMnYxbHpENVNJNGx6ZmRoa3FERytyRHRWZCtP?=
 =?utf-8?B?ZUVzbm1yVEtNTzdsTFFOZmloZDgveHBhSVc2K2hCL25RdW1vRG5qYVhkTzN3?=
 =?utf-8?B?UXNlczEzbjVyN1JVRGEvU21iSlhIQ2JjUkhOeDJZM2JYRFlvUGM1dHVEdGll?=
 =?utf-8?B?b01xU0FXTmtvU3RYWnFJSWlvZnpIdlBsN25ER093NE9kNUV0c2hiamEvbDk1?=
 =?utf-8?B?UHovaEtTaDVpY05NeEZoalcyWEpMWGlDTXJuNDgrUkI4T0h3dWpGZUo3Q2dE?=
 =?utf-8?B?VEs1dGtXeHVxejF4UXR5RDVMYk5za1F6TGUvd0NEM2RTcnpQV0U2OFhWTHdQ?=
 =?utf-8?B?VDdkRXE0MkRVNmMvQWF2b0dmUVdQWHc5S2RNSlRJNnhZRWZMN0VPSlZSZlYx?=
 =?utf-8?B?VGVYMDJZWGozbUN2UnY3UTh1ZVlzRFFJM1R1dzNrRk5iaVBQbFFOWkk0SEV1?=
 =?utf-8?B?SGdwbEl3Y2VaTUgrWngwMmJCNUlNOGxsNmgzR05wYm1jT0l5TWlXaWtZNlN2?=
 =?utf-8?B?NklpVE5QbkxhRVZIcWNiMzF6TGxJSHpDYXE5OUJtSHVLUmQrSUVubWYyWXNa?=
 =?utf-8?B?ZGVvekJNMHZGNmFzb282V0R2OFNjOW0xZFQvU0s2dWVUcWdESklwWVVpeUVX?=
 =?utf-8?B?YXJCWHQrc0RNQS9FckNUa1NTZEovZW9BSHczK29qck55czU5Q2RDUm5tVEg0?=
 =?utf-8?B?Qk52NVdBSE5WMW5jeVErakhOZU1LV21qWEJpQ3VsaXp4dHMzVUluREE0TEV2?=
 =?utf-8?B?YjlMSHN2dEU5ZWxsSDBSakNWWGxBYnFvMU93bHFyZWZ3OGJVTjZHL2IyQkZY?=
 =?utf-8?B?RDlyd1Zqc1ZoU3lSNzBBU003SHEyTVhoUkdIb1U5YkRBcitnVmJXVmpiMHhN?=
 =?utf-8?B?aFVUdzZFOXZyK1NWWkgraUIrVVBENDYwbS9yYmQ5bmZvWk5BSWFCZG52Zlhv?=
 =?utf-8?B?UW9iYW5uNFlIbjZKTWo1a3h6bncyVUhpN2tqeUcyTXNDeVN0eHpuWEEzb1I2?=
 =?utf-8?B?MUswUG5aWEVUWlBSTFFkMjFuYnF0ckVTMXZISGV0azdqT0lickg3ZEVyQ2pD?=
 =?utf-8?B?bHpleFp4RzgzTGl1SHArN0lUSHdUQXVjQ2pHQ1F5Y0w1UmNZcXZKL2JvbW5y?=
 =?utf-8?B?TWxhU0NGblFpOTlxWWFKenpHd09mT2l5eEd5N3RqODNNV1lWQ3gyb2RLQ3Fr?=
 =?utf-8?B?UERQcTZBWDErdENOYzBOSGJnVEtHVkMrUjEwYW9JUzJxQjFNVUlwZ3Y1aU5P?=
 =?utf-8?B?TmxZeEdzSzBDK0tpZmI5SUNWRDEveGR1bnJHRFQvT29TZmw3MzJZOTFLNng0?=
 =?utf-8?B?bVg4WmtzbStxQWV1alhtZEg2QVk3YnR5YnpuSmFyUmIzS1JVc3RXem9OYzZB?=
 =?utf-8?Q?KcZ3XzJ1MSQ2K7aOn2LXn0ehV0JnvxKTXCZFbKWtcaVs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWJMTVQyak1uOU1mT2dOWDBmTHJ4aHZ0bUZVb1pSdTV4TFEzU1JQemUvdWUr?=
 =?utf-8?B?SUIzbzZlSXlqNk1SUC9GeU5Db0ZrRS9SL0d4cEZPMk9ReWtSVm5VU0poYXVp?=
 =?utf-8?B?ei9heGxzN0xHZk5ib3lwbU13Y3NrZjEzWEtJMnNzY0JnODZ2S3g4TW1FQnJi?=
 =?utf-8?B?QlV3Zlcrd05leGxVeFNMaEFKL0xOTFpDTjZXKy90WXA3a2kyeUkvRERrTlNP?=
 =?utf-8?B?dEVISUE0Yzg5VmZrZXNjT1R0NEhaVVF2SndvRWROTi81OWhwSXhYdVFqYnQy?=
 =?utf-8?B?MHE1eUJCUzFmVU9ocWo3QjJWZ01LdGl4WTY2T2xXTjNNRmpES3QzM1dRRU1z?=
 =?utf-8?B?Vm4rOEVqcmdWbUZqQnhycHRnSnlNM0p5WjFyL3BRUEVweUUrZWRXMmtYbGpC?=
 =?utf-8?B?eWh1aEsxSlNPUnF6UHQwS3F6MUNoN3FxZVF0dXNTQ0VMaUJyK0hrZVk2UUkv?=
 =?utf-8?B?dU5ZeGpJVXpMM0RWbEttY0dpbFZEbE95NzBEdHBJUEpBY2NUYWtvVHJTOUlj?=
 =?utf-8?B?VDlGWWVUQzNGV3FvQVljWVdISkR1SVlyTFN4Rno1NGhLYVVlajI2WC9pVGk4?=
 =?utf-8?B?YmVBRGxXbjRtQUphVDc2cnN1QVY5MWdIWjFjdEZaRXFxeUJYWG5VK01lN3Av?=
 =?utf-8?B?ZnRMeE1lRTdsOWRRNXV0b2EwTDBNdHpySUJEWGwyMDBza3VxczVsYXJkcEJ4?=
 =?utf-8?B?RW12cVlhNUg3dG9DdU5va1dKejFSTlNSWURueTV3anNobnZ1emRLQytaMXNq?=
 =?utf-8?B?TEEzNU1McFVON0RmcEZwalpqQTdQajYrUlBaMFRSWklsQ2ZBUm5tdnBMOEhh?=
 =?utf-8?B?TUh4cWNTK2FkTm5CaGw2ZzhLZmlOcWVZM2N3QmZud3lvVk5SdGVWK3g3RWhZ?=
 =?utf-8?B?a0RiVU5JQ05LbWxFYld1YXFzTHEwemJ1QWZ0UWkvM25BSWVhV3Y3NkxPYWE1?=
 =?utf-8?B?RG8rRW02aGJ3emkwK3NGbVBudnorYWNSVTBJV3Nvell2T29hNng2ZW8wQVNT?=
 =?utf-8?B?MFB5Mmg5S0d1SkEyWjZSblk2eGlreHRNWEsxaWlGc0VhY2pmMks4U1NEemdL?=
 =?utf-8?B?TDR5RTBQR1FCMCs3enh5NExzSzdBbVBaZytjbDhOVUNDODMyWlU1cjhUZ1VF?=
 =?utf-8?B?ZGRWc1crcStrNDJaY09XMFlBcmRTL1JTRXQwbS94LzJNWVhFRjRUdlBIOE5u?=
 =?utf-8?B?Z1BLNTVxTXZBU2dsejlEZXQyMzFFTlBWM3F6aVZ0SDg2dHBQazdSdFBoUHg4?=
 =?utf-8?B?blBKT0s4RVJyQkt4S051S0tuZ2tnam5vbE5NK0lOcmhlVklpK3ZEL3ppVGFW?=
 =?utf-8?B?MVFuWmY0SDVaK3duSzMvSDdBcGtUMVZEOUE1dWNUQlpneWhjWitUUVdOZFgr?=
 =?utf-8?B?dnJoemlkSEhiWkFrcE8xSkwrQlpOZ1gzWGIzZXNwTUxFTjd2aGwrdDgyT1FD?=
 =?utf-8?B?L0x6RVV5RU41d28rQlRoZzRBd0IrbC8zeTAvcE9MS2haR1BBK3VZakFlRkJW?=
 =?utf-8?B?RUFXTkV5dkRCaXA2a0ZBdU0xUk01T0w1WTVEcEtrcXIxc0k3aDZpR3A0bG1n?=
 =?utf-8?B?MEttNjBJcEh2YmlqRytqRWQ2L3E1NE9ES3VIcmV4bVpaVW5DRTBwOFBhcE8r?=
 =?utf-8?B?SWdxUkNJazVaVElld1ZMQXVrYzBDUFdUWHExYzZkMFF2Q0YyNjFpUktpQkNU?=
 =?utf-8?Q?4O9eM4t0nBpI8kM1tx3G?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-ecb43.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 13019b18-3b1b-4d1d-0136-08ddcf42bc17
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 08:26:09.3620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785

On 2025/7/30 11:35, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Add a test module to verify memory alignment guarantees for Rust kernel
> allocators.
> The tests cover `Kmalloc`, `Vmalloc` and `KVmalloc` allocators
> with both standard and large page-aligned allocations.
>
> Key features of the tests:
> 1. Creates alignment-constrained types:
>     - 128-byte aligned `Blob`
>     - 8192-byte (4-page) aligned `LargeAlignBlob`
> 2. Validates allocators using `TestAlign` helper which:
>     - Checks address alignment masks
>     - Supports uninitialized allocations
> 3. Tests all three allocators with both alignment requirements:
>     - Kmalloc with 128B and 8192B
>     - Vmalloc with 128B and 8192B
>     - KVmalloc with 128B and 8192B
>
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   rust/kernel/alloc/allocator.rs | 56 ++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
>
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> index 63f271624428..1f173038cec9 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -184,3 +184,59 @@ unsafe fn realloc(
>           unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags, nid) }
>       }
>   }
> +
> +#[macros::kunit_tests(rust_allocator_kunit)]
> +mod tests {
> +    use super::*;
> +    use core::mem::MaybeUninit;
> +    use kernel::prelude::*;
> +
> +    #[test]
> +    fn test_alignment() -> Result<()> {
> +        const TEST_SIZE: usize = 1024;
> +        const TEST_LARGE_ALIGN_SIZE: usize = kernel::page::PAGE_SIZE * 4;
> +
> +        // These two structs are used to test allocating aligned memory.
> +        // they don't need to be accessed, so they're marked as dead_code.
> +        #[expect(dead_code)]
> +        #[repr(align(128))]
> +        struct Blob([u8; TEST_SIZE]);
> +        #[expect(dead_code)]
> +        #[repr(align(8192))]
> +        struct LargeAlignBlob([u8; TEST_LARGE_ALIGN_SIZE]);
> +
> +        struct TestAlign<T, A: Allocator>(Box<MaybeUninit<T>, A>);
> +        impl<T, A: Allocator> TestAlign<T, A> {
> +            fn new() -> Result<Self> {
> +                Ok(Self(Box::<_, A>::new_uninit(GFP_KERNEL)?))
> +            }
> +
> +            fn alignment_valid(&self, align: usize) -> bool {
> +                assert!(align.is_power_of_two());
> +
> +                let addr = self.0.as_ptr() as usize;
> +                addr & (align - 1) == 0
> +            }
> +        }
> +
> +        let ta = TestAlign::<Blob, Kmalloc>::new()?;
> +        assert!(ta.alignment_valid(128));
> +
> +        let ta = TestAlign::<LargeAlignBlob, Kmalloc>::new()?;
> +        assert!(ta.alignment_valid(8192));
> +
> +        let ta = TestAlign::<Blob, Vmalloc>::new()?;
> +        assert!(ta.alignment_valid(128));
> +
> +        let ta = TestAlign::<LargeAlignBlob, Vmalloc>::new()?;
> +        assert!(ta.alignment_valid(8192));
> +
> +        let ta = TestAlign::<Blob, KVmalloc>::new()?;
> +        assert!(ta.alignment_valid(128));
> +
> +        let ta = TestAlign::<LargeAlignBlob, KVmalloc>::new()?;
> +        assert!(ta.alignment_valid(8192));
> +
> +        Ok(())
> +    }
> +}

Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

-- 
Thanks,
   Kunwu.Chan(Tao.Chan)


