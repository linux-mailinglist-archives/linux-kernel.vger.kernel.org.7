Return-Path: <linux-kernel+bounces-750356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D936BB15A86
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE683B7AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7326657B;
	Wed, 30 Jul 2025 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="eojJ3lsD"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2023.outbound.protection.outlook.com [40.92.18.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB202512C3;
	Wed, 30 Jul 2025 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864053; cv=fail; b=MdGB7UPRQF/AGmk3wtOp/48U/FxbfaeHNhY+Uk16azUe766z9uuMeuxV8Be0hxq4TKeFzAgLbs3PUyp+hy4zQI/juDmqaJdiigYT0YZ8RxJNv+KmIOkNizYLVPf4nBWUQfjuKElis1/w5IkFlZLtkbnX+FZDvkfZmbDwoNEJQV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864053; c=relaxed/simple;
	bh=QNu2a5K0PM0pdK7V1Wg+dTxobKM+MaEKihYproqMhyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Av0DY948YIwTjDjR7vLVOrQOnfNSHqbM+g+YUkVgAKMi44Pv5EGKYczoBFMLvGX8KZ6UgDQDHlFy6TdAxxn03h/Pwko50hI4ked6qgUh1WKcjQAKRgQXLu2RmOT+jualxBRrY9PMi+tSfGnBtu4fy+lgfGIgZ8YEHmDCAeHc4Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=eojJ3lsD; arc=fail smtp.client-ip=40.92.18.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rknv/z3evsHnoKT4w0tsjbDLkst8TZAhh56P/gDtCWzpxKfKsrW+FzT/wqV34Z8z0KLOfkfjnoBcY5f9Dn899W8jCNqkqkUYaEBuNidQmTUJk7Co3mhDTVp5UaM4AXO6fhgC0D7iVTGZbgu/L6Y1nVl62EmC2Qa7pigDqWU2CVmUGICIRnKaE3uNYxyZmpTXksiwuxxezuweVILfVflCLYou5/Uaak7J9CjCa27KfmPX/LB9hvkQfpJUaicK6QanhsNfG3x12oQV84YM3LxHkzCFTlHyfR5WjDurtGEwk1fc8xslYDuhv1oiFX5sl/bC4png/b3os/etUVnL++slww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4NwuuZBTMS3h2KHKAZ+OxFBvpLyqV49g3xfQPeRZaM=;
 b=MZEbld3sTpdwgSiqwna1GNrDhsNL3JSBO1+TOLb22jjqK+gJB01q+OSIz7v27kJxfHBWF7aQ0ioJR/KNTQzCdL/9kJbJ32gEI2082P+KKXGluuHTSWefCGiw3Tyx5VRFfComGEiwrQIRbIdeeGAvzzOyglJWugNSs9ySsiorVaAqpMnqg+nPQdP0vS2RIKvyxpUSKZIpFRAbQEQMf5ocOINSn/jFF8N3zg5uFB055HqK8TnttsclpCVKnkN5nrgw2ao/uhkaqBBJ4v2Ng5Wa3F9o8kScXEdZwgO5y9hFv5QWAUVmud5lGk6P/l7LhqA7F3V93zNWtbdj6Jr4Uu2PIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4NwuuZBTMS3h2KHKAZ+OxFBvpLyqV49g3xfQPeRZaM=;
 b=eojJ3lsDvTPjLrb7DbYFl5RhJdIdMHHIOdZULXqCdL9bT3Bw0M4dQRyQXvD5Ho8TVZ26QcNZfbUyzoHjBL6WHqni7m5llvH66/5OLIPynGTO/ONZWVGae2hoMFoeYn+KRm9BQp7fegW71HUKRZr6B5Pv6d/yYjBUUKXarWbNHT4pRNWA5zMDOjQ63PYJDt4iHxBdudRcV8Ed+4Q5yUq4ZKIu18+75w+vffRGF323SdqoZ8uez/TqCJgBaMhgFAaZ5UM85FXGmus8RtKP8IHJ7/0Djk5uDFVqgBVv/gsqMwEC+56vJ32QrbdP6sdq3avQoBhodrVhKAKg4FDhJ5h/jg==
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 08:27:29 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%6]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 08:27:29 +0000
Message-ID:
 <CH3PR12MB90797749F5A623D292671E689724A@CH3PR12MB9079.namprd12.prod.outlook.com>
Date: Wed, 30 Jul 2025 16:27:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] rust: alloc: kvec: add doc example for as_slice
 method
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
 <786e88abea2557080bde65fa9892df3b956731f2.1753841900.git.zhuhui@kylinos.cn>
From: Kunwu Chan <kunwu.chan@hotmail.com>
In-Reply-To: <786e88abea2557080bde65fa9892df3b956731f2.1753841900.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0069.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::33) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
X-Microsoft-Original-Message-ID:
 <45b2eb8e-43c4-468b-9c8c-5e37e3191e21@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: edb0a39d-c4c8-47af-c96b-08ddcf42ebf2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|19110799012|461199028|5072599009|6090799003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWd5b0srbHVuUThCLzhZQWV6U2padm03U3FFeGwxNjZWN2J6VDBrYUpJaDVF?=
 =?utf-8?B?akFkY3FEaUd0SUQ3TU1uUWtCcXFUL3RHNEMwd0Q5bFhRdGpyYkVGdXNHRk4r?=
 =?utf-8?B?UU9KMFNvQWlXcGhXaU91MHVIVFhWVFg0WWNBNnV5cEEvRHdyTU9EMitDUTNK?=
 =?utf-8?B?ZnhOWHpVbHhOVnFPQ1JUOGNhK0lHOExtTzZEbEVhVFBEM0dHU0dSOHUwMitG?=
 =?utf-8?B?QnR6QVJWUFR6V1ZLcFBkNWg3NWRNd3YwTEdLZWVmSXNVSlMrUnlTQTJWVkhy?=
 =?utf-8?B?Uk9IaE1nK0dqTmVoQUExaFl5MUtJenk2bDgvay96d2gxaFNVenlFdnpaNGxx?=
 =?utf-8?B?TXZxM2lzZ1dQNVFNWkZGYTBvazVoRlRzazNtZWQzdFp1d1NUVktYblQ0blhh?=
 =?utf-8?B?MVNBUVU2MHN3bFU0MDdsS2N3NkRVcUFkV2h5WXNGcXMyV2lJL0ZPbXR3UDNl?=
 =?utf-8?B?WmlHdWUzLzB3VHkrNVkvUGx6UFNnUmNUZ0hzV25yRk82MlM5ZEhqLzE0REVu?=
 =?utf-8?B?Q0cvYWV2a0M1ZFVweldlUTc5WVR5L3ZZWDRWdkp1YVdlNkdoMEd6TUt2V2dl?=
 =?utf-8?B?Z0NMUTVybHd5S3pWdUlXYUxxUVJuVk1sOUpPTmZ4QWJUVFFSTzg4VG9GKzNq?=
 =?utf-8?B?TUtRK0xEcVFmbTBZa2Z5OU40d2FVcHhOM1podS9QS2ZMckhkeHdIWWVkdVVO?=
 =?utf-8?B?RWtpZkp6YURnbTloQ1NieVoyWGU2cnpsMWYyNCtidFZGZ2cxS1pVS3VKdm00?=
 =?utf-8?B?ZE1COVlZVGJod3R0RTZKSVNmQ2l3dHFzeHFiazFjQWNRQXh4YUE3VXZQU2Vu?=
 =?utf-8?B?Ykg3TlkxVTZPbDd3QW91ejY0T2FqYUcrMXlkaUo3Y1VSMkFUeE95YVRKRlZw?=
 =?utf-8?B?b0llYzNRdDZiOTY3aUNIbGZxSlRkUmNhUit5Y2hmeC9lNStqWkJ6WG5LTENo?=
 =?utf-8?B?cUtRYlpKQnF0TmkyU24vZWoyeVhPYXRidHlyRnJPQitpVmQzOXByZ1M2VG4w?=
 =?utf-8?B?RGlCT29EYXJSalpKNjdxckhITTdGa0ZkT0lUeWJseWhSUWFtV1NBSlFJanJj?=
 =?utf-8?B?eFZDWklTNVR1ZEpLdmFlSEJYVkRISzJxNHNQQldkSEh6dkNVejJhMzZUOHlt?=
 =?utf-8?B?RlI0a3l4V1ROWHFBRHpzOVVjemd4U0F5aVdvVEFBaWNGYmY2VTdEVEhDNE95?=
 =?utf-8?B?WXBJMEpFYmZTbHlsZk1mWEJHcnQ1OHFwZUpwZnV2WHc0c0tkV1NaWGplZnFr?=
 =?utf-8?B?NzRXQkMzdUFUWG54T0o0YWNFUjRqSDVsekZBUVA1bXJja21SN29JdzI0VFFv?=
 =?utf-8?B?OC93cU9Kc1JMUmZyeC9OdFFCbFVlQzFkRlY4SWY0R1VEUW53WGcwTTVkMVJC?=
 =?utf-8?B?eWhaN0wrelpaOVl5VnpOcURQei92eVI3bmZwZkcyUlVBRnN4SkZTckt6d0pn?=
 =?utf-8?B?d2FQSGhLVmhsZTRXb09vQWlhVjBJOFRBKy83VG1ncUxjZDdmRFpZYjZ6OUdY?=
 =?utf-8?B?YW1PZHVnZk1WUFFIOUhZK2dxa3UrUC9tL1JnZjdDakI5S3AxSThyQjJvOUx3?=
 =?utf-8?B?bXVYZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ci80dlVoV3dTcWFyeDhSdmRIY21LMCsyUFE0cUYzTktUaFZWTjJCUFBOdTNs?=
 =?utf-8?B?dXN0QWVxQVRvZWpzL1Z5NS9SUWQzejBmb0F2dXJtZ2pRMTRObFdBRnJzMFVp?=
 =?utf-8?B?NDE3K1VXeE9SU0thOHlCTWt6NGZFNlorZlA5QmFmTEsyVWMrRVJoeXZzYU42?=
 =?utf-8?B?SGtIQnZkNnk1RG43cGc1TVNhN2hwNjVoNGxKSFBqaFRuYUlqaXRDNW1IQTJL?=
 =?utf-8?B?YlZxdCsvR3hFYzZIUDVmVC9qNDE1eUx2OVdYZk5oZmZyalV1QW5IWHFkbU1H?=
 =?utf-8?B?VEtYT1J1T3JWc3dKeFg3MTJNU1dmRHB1OUlZeVhIZi9BOGVMRksrRlFCanNM?=
 =?utf-8?B?bDI5VXBmVUY1V2cxVmZwMnFIRHArZHBIeHRYZFVVeFhmNjk5dkJqaGl1c2Z0?=
 =?utf-8?B?Y1p2dGpLVVhIR1kwQ29zWHFUL1hvOWJLRjQ4eFdaLzZWbmhkbHpiS3p3UkJn?=
 =?utf-8?B?cDUvOHhwQTBsdUdIbnhBT0F5Um0zTUI5REJhTURGNVpYa0NVR0Rud0RHMytt?=
 =?utf-8?B?ZzRIcVBCbEtXU3ZxVi9vK3dvcjFTZ2xtKy9LVlgxT3dOTWpZN3ZXVEZ4dnVi?=
 =?utf-8?B?b3Y5Qk11Q2N0WENTL3dDbGpETVB2OFhKNFk3LzFxbVhSVnZTbDFVSlVPQW8x?=
 =?utf-8?B?aTVFcG5sbThYZ3RIcnFmUlhub2Y2U2Y0YU5hRithb2lxMHpRZHZDajFVNTQv?=
 =?utf-8?B?bUVINzR3dllzY3dZZ1owN3cxUVI2UXlTZE1DVGdFU0lJSlRtU0FVQU9reS9T?=
 =?utf-8?B?b3FqMmxhSzMza2xNcTJGRWtJdGJna0ZERzY2aks4RlVFdEIzVG5PSVFJdkxh?=
 =?utf-8?B?Y0cyV1hoKzRWTDZZbDFtS3FqK2FwUUZMWHgzaDlzVTA2U0RDTmVocnZCNkNa?=
 =?utf-8?B?Ui9YRTBYYUd6MGQvSHN2N1V5V3l4NHp3eHZudUU1MmwxTlhOMzRaMkordnJt?=
 =?utf-8?B?N3VpSXd5VzFBajRBUnZDek9FdjdBVEVnbnRzWHg0RjR0U1RTMjFXa0Y1VEpG?=
 =?utf-8?B?ZzlPQ3NiT1AwTDY4aUxQN2p4dXVTT3pmTExaWkw5TDczczcvY1BtWTNTK1pz?=
 =?utf-8?B?M0ozdzRBclBSZS84dkpkSHYwcG9ML3hobjV2Y3MyVHNkc2lWR0RvdXgzSllz?=
 =?utf-8?B?d3Z3dGJUZmpRV0w3S0cyZ0Q0R09tcFhuMG1FdzEyelo4TklqU1p1WjQ2L1FV?=
 =?utf-8?B?M0kvUFRsOWgxNi9SYmdUclFCc1VBK0xYZnlxYlhQSTdwb0REUVNiVWh2MjNE?=
 =?utf-8?B?aWFocXA5OVg0TjN5K3Nzemh5aVp2QTR4RXNiekpBTVlmM2NDVkN1YWRlNWsr?=
 =?utf-8?B?MHlQREorVGp5QlFtSXE0OUlzeVVXRnBTNEY3a2Yzd2hSNEh3NW16UERtQmNl?=
 =?utf-8?B?MkJUQVlwVlRBT0lsVUhBelFJUGZ2VS9vSE5ReXlYV1RTWnBkMEppbzZ3QnJt?=
 =?utf-8?B?a0g0dHhJMFZlMmxueSt1dFV0ekJ4enNEVkRaWDRvSUpqUytIRWRJbllEcVhM?=
 =?utf-8?B?UFVoeWIrRC9QSFJWU1plQitjaDRhbWJEbWpabGZRNFIzWUtBYzlHYWlacDNS?=
 =?utf-8?B?VWJKSnM0SGZFSzZwOXgybzZ5bmdvdWlwT0QxMlFGTURlYUFFalFUeFdqc3Ja?=
 =?utf-8?B?QkZjc29WS2JBOE5xczRXNnhRRVhNd1docmV4OWxiZm1BUFhUYUt6OVBaa0Ir?=
 =?utf-8?Q?KKBP0SzCO2SP+RUz0Nwk?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-ecb43.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: edb0a39d-c4c8-47af-c96b-08ddcf42ebf2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 08:27:29.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785

On 2025/7/30 11:35, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Add a practical usage example to the documentation of KVec::as_slice()
> showing how to:
> Create a new KVec.
> Push elements into it.
> Convert to a slice via as_slice().
>
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   rust/kernel/alloc/kvec.rs | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index 92d0ed3f302e..f57e08c64929 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -224,6 +224,16 @@ unsafe fn dec_len(&mut self, count: usize) -> &mut [T] {
>       }
>   
>       /// Returns a slice of the entire vector.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v = KVec::new();
> +    /// v.push(1, GFP_KERNEL)?;
> +    /// v.push(2, GFP_KERNEL)?;
> +    /// assert_eq!(v.as_slice(), &[1, 2]);
> +    /// # Ok::<(), Error>(())
> +    /// ```
>       #[inline]
>       pub fn as_slice(&self) -> &[T] {
>           self

LGTM.

Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

-- 
Thanks,
   Kunwu.Chan(Tao.Chan)


