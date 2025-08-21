Return-Path: <linux-kernel+bounces-779444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68581B2F42C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8D6AA3F01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81C42E0905;
	Thu, 21 Aug 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="FrGb2y+b"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010005.outbound.protection.outlook.com [52.103.33.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A541DF74F;
	Thu, 21 Aug 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769096; cv=fail; b=QVh/5Kt/n3R4HJwAodryrmW55OROMVe37d2aYXkWCuPH26969OoR+8bgowX8I/SpORHFxw4Hb5RNTiwkKiHpPEVp9zVg1PUG39LWbZ1rEqR7UNUmlpfsuO1qyBMfXTIrBlkoH2T1Cj6Xb0uha/djWBDeMSm0Rx45JRtk7eLUVVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769096; c=relaxed/simple;
	bh=Pnnhen5eVQk3u0C7Gb4JDddvh/ybiu3V/dF5ilUuFaU=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DOYUObi6dulky2hIeg/MR6gmO9qguqcc0QMAyf7HuKgbFRnx3yZJA26LLmvACWd8Dys2ZQZqqy2YloaIZcYFp5O2bYwy78mkkTEASqNvhoGzxhdaDZ7aUO+3mzMxsZbwD/KZ0lFnRUUuoU2f4FneNZ/9p8TcZ7OA0c4sd+p7i5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=FrGb2y+b; arc=fail smtp.client-ip=52.103.33.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWLoC2Ke0I78PSckKR8RRDUc4BM7/JBx1NiAabzO5kap9YEyR+pTfKs8wpc/6RgLGqLov3O2Rsk7LW7kFSR9AeApY5v/AV5ryauVFkL5lSA8hwrK2kS61JKeNDJgbeGduBBEo2N8JC507ZEaChJ8WG6xrg1dEU+GNIGTuHgFcfg0M0lzAHLWu4hSq3ooEA4NEpzoVf+uFa43iNctKC/Lq/QpPK1kzyPiuJpYkATjUlcgKLwyJF6N+UcxTR1IjCcOYmXL4La3LXVzERBtOY9QVSrcJD5+F5xDmS/ShuwoZkWCoucVCAsdqkdRoHjSJt8EpzwRa2st9k/Wt/By6crwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UZjtB7vQAdM/g6aTFpRM079Lxv8llGUqsgW77vm2Vc=;
 b=MAu6QfK3nBz9s6T/5VYqOlvwcn3oTSKAuwFkSXd8PA/gbYn2miLXHEft7Ue5IghEs7pFBxWaV8Zq/t3FNovon6kSfFyew6Xd3hsowtsIRB/TqcTTQWeYkVsvxukSQIO8SWlCHpzX1t3P6NIei+053EWwy5PDFfY8urZ1fonnVIBPMoPjVnP8tYvZRvJ+h6hnwB+j9+kc/j10BZChCUGf4WQO7ROTCWpum886AzpXFEiMuuS+6AHGbUu2r+fbEFhMhLP3DOtecs8EceI3ehKyBAM3U6Dn1/H3LL//dsfFXheV2UpOYrgr7ddcV4Gxp4psITuqKqyItHc40eN2Kf5yng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UZjtB7vQAdM/g6aTFpRM079Lxv8llGUqsgW77vm2Vc=;
 b=FrGb2y+byDFVoS1zCgzc9oIIkDLYd5r+ulxobZfe5dT7uH2T44z5hzDiE+5UYH3z1oH7zagwBXJtgSvB7T94iLCCGTZTpBxz/C77ItuFBM/BHRnOxIYdpaA4f3EhYJLpeOoDrKe1xnFPLCUXny6ZCdizXm3pR8wYgpNs/PB8vYmeFN2Vr8ChH4OQzFxX3mcpYoji9p38x9mLQWses/zA94iA6OQL6C8Lp6KbzS+oFzUlw+7SLm9NNNOF+EueYBmw228AqukN4vdLQVxXct4k3y1Lwqa2gRTx/KWvVB4D0y0gbQ3bIcr1Z01UjqTP46xZVoctdwxGbSD03KbVSTVHrw==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by VI0P189MB3116.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 09:38:10 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13%4]) with mapi id 15.20.9009.018; Thu, 21 Aug 2025
 09:38:10 +0000
Message-ID:
 <AM7P189MB10098641C0B58ACFA3502A03E332A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Thu, 21 Aug 2025 11:38:08 +0200
User-Agent: Mozilla Thunderbird
To: m.wilczynski@samsung.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 andrzej.hajda@intel.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, fustini@kernel.org, guoren@kernel.org,
 heiko@sntech.de, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, neil.armstrong@linaro.org, p.zabel@pengutronix.de,
 rabenda.cn@gmail.com, rfoss@kernel.org, robh@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, uwu@icenowy.me, wefu@redhat.com, ziyao@disroot.org
References: <4e6d1a0f-4270-4d25-86c5-e4ec3721c451@samsung.com>
Subject: Re: [RFC PATCH 3/8] drm: verisilicon: add a driver for Verisilicon
 display controllers
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <4e6d1a0f-4270-4d25-86c5-e4ec3721c451@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P193CA0007.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::12) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <e55d883a-d549-4c0b-9aa3-19db0e2914e5@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|VI0P189MB3116:EE_
X-MS-Office365-Filtering-Correlation-Id: 2963d4bb-ea1d-4d02-fde9-08dde096702c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|6090799003|23021999003|19110799012|461199028|8060799015|5072599009|51005399003|40105399003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXkrZzRhSEJDWEJkSVVOa3V4OUlwc1lFckp1MW4wT0l5OU12UmYrV1NJcG44?=
 =?utf-8?B?VjRtdnRJdFJ0Y3pZTkZuK0ttOERuem1pQWdQUVhEcy81ak10ajRoanBhK2c2?=
 =?utf-8?B?ZEhBcUNkTU01NHNZT0RCQzN3K0dSR3pwNTJXNytSZUdtZXFFRURtcXhKYmts?=
 =?utf-8?B?aTNEK1NaS3JyT1RVakFob0x4ZW80Qno3WGdwSmt3bmhBblY3d1lBcHJocUc1?=
 =?utf-8?B?Qzd2NTcxV1ZDd2xVeFhaaWpHVlRjbHRQVVhDVXZUUjJwYnBLZUxSOEpEZjhN?=
 =?utf-8?B?cUU5TzJhOUN0SE1WRUpXeVpLQ2VENGt6VVFaNldKWVAyWDRBMnhIWlovS0xz?=
 =?utf-8?B?YzY3ZzFWVUs3M0JTWVNCcXE4cE1WcVZWVnA5dmNxMUNpZHlCT3lMcDVOZ1NH?=
 =?utf-8?B?NFBtQkJlSUc4aVNGMysxaXVuVk5NLzJCeGJjbW41aWxkNldxWFliVUtydEtS?=
 =?utf-8?B?aUJpeDk5VWIxM0pYK21mdHQ1Z0xzZ0Z6WThLcG5rTUVpU0p0M1pzbnVQQmQx?=
 =?utf-8?B?TnI2cW4vbDFsWkkwSnpvdlZoZms1cnhHdzRrYjhMWS91V3JMR0tiZlJjaXhP?=
 =?utf-8?B?VXhjRTdKN25TUmZnQ1lENzJOYThBVlh2c3N5YkxTUFpoZTRLTDJoRW5RVjdl?=
 =?utf-8?B?T3dGQWxtV09hU281dW0rVUNxZGpyeDNlbVdpZ1RyVnhqTmhCTG4ySkdlSXY1?=
 =?utf-8?B?MUJTaHdCeUVwNmM4VzliV2swa2ZNcGZwK3JKSXZmUnB4UkozZTdRSFFHOHMy?=
 =?utf-8?B?bUp3T1M1MXE5dzcvM09zUVA5ckpQamhSMy9IbXRtM1NDZTRjcDNxQkE0S1lw?=
 =?utf-8?B?Um9SU2lrNG51ZVduZ0dvQ3o3cVV5bk8zbVNnUUdITkxZK2hoOUF4aTdmdWVH?=
 =?utf-8?B?KzJ6UHk3QmErekQ2TWNJTzZPWjlpZGpiOVhtYWdxdGRCUkFwYjN5VStrU016?=
 =?utf-8?B?UDA3VEpCQ1RncXlhSHg5UUN5YTVMUTgrRWxKYmtFeHllaEhnSDRhRUtlK28y?=
 =?utf-8?B?aGk2WXFDMWU1bHFKcWJaaTVHVnN0UVIyMzZyTzhSUitpMWpZR3hJaFlqdDlO?=
 =?utf-8?B?SDUwOVc4RDdmQWRueTdhKzZ0alp5R1ZUeU5Ed0M3NHNlRnF4cHREZ1AwbG9T?=
 =?utf-8?B?WVc2V3VEY0Y1VDJieko3bUgrRzkzTnFjSXBUR3BOZXVZMVdnTzkxekVickVY?=
 =?utf-8?B?MHRkb2hsTm9DVC9UMWkzcUZCQW1VRS9OTExMQ0xJdGxnaTZPeVAxTkFyOVYz?=
 =?utf-8?B?M0tKRUw4VmNpVWQ4YmNWZ2k5OFIxc01XYXZGSU8xcnhsVjhBVGN2SEt5RXpV?=
 =?utf-8?B?cU9heDBBNkNaMC9FVkIxUFBjcjJXYzFja3kzRk5HT2ZpL002cXJKdUtUSEpv?=
 =?utf-8?B?bHV4cUhOVmYyVG1WYm5EdzVlU0NjYW50RnNYZ0tWM2tjemViWkdwZGVDMkxo?=
 =?utf-8?B?aWFNVmh1MThSWEJoWXQ5bzlOR0FPWXQ0TktxOHd3WWg4b2ZYdXhUVDVRa1hU?=
 =?utf-8?B?cHpER0Y3cU50WHJyMFJxd3BaKzFma0NQMTZDVEN4eEFGTllYYnVrb1hQSEVj?=
 =?utf-8?B?ZUFuQVdMdVQ4MTN6L3BDUTA5Myt2NjQxbkU1dnJDczlUbHlhN0lVc0hNd2dt?=
 =?utf-8?Q?ZchRkleLR20H9kXurxgLHFSHKNXzTLURuK9MMwmDl+d0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlFOTWpHM0JqLzJ2SXhNRzhROWRlY096SmRvSlJRQmNjQW5wWnN0RUl6V3BY?=
 =?utf-8?B?YVlZTEVVYUoxYTVuZHdhSWdlKzc3VDBNQlBTYW9hN3pvWDlCdGhCWlE4N1hi?=
 =?utf-8?B?VnZCU1hsaE93c2JuUWo1WFprSGR1YUNENVFoa0JONzBGSmdMWkFoc2x1V3pL?=
 =?utf-8?B?a3krc2tteVg1elFLeC9CVnlUNHhnOVlYMFZUU29FbnNjbkk4dFRwOFBCMzRo?=
 =?utf-8?B?NWdXTXpZMXUzR1VLYm9IbzJzNE5iZ1pyOUNEeHl1SnBQL2xMOWdoSHVzV21K?=
 =?utf-8?B?TzU3QkF3VitBN3JiTW9uUXcvaUFrTEdmK1VrTlZocDJqdGxudzZHZFhpVmV4?=
 =?utf-8?B?ZlF3RjBMY3YyTUhWdDBKNHZ6RDIwbzV3d3dyV2phbERjV1ZBTXBMdzB5bnI2?=
 =?utf-8?B?TUVHN3lvcFJaeng4YW9LRkpNSkx5amhSaytHMjZZdHBvWk04Ynl0OU9Gbzcv?=
 =?utf-8?B?eVhIRjUrKzZuZkt1aTVnL1dXV1lXcStpWVprRFV0UUZzVlhtRUUyS3hGc0pU?=
 =?utf-8?B?NXRHSS9jKzl4NzVSMkhURHNnYnpRb2toRDR0bGYvTFE0Q1pEc3NwRkxjT0FW?=
 =?utf-8?B?VURZT2tMWml2MTJiY1JTQUZEeXlXVmNhaGVtaW5TQUliekhQY1lKRmRjeDVi?=
 =?utf-8?B?K1F4NVo1QnRKNVZrMzBGWVhMd2RSeU9JdzZlbmhwdVVDMkFpQk5xRmVLejA3?=
 =?utf-8?B?RUZsWmhSZGJYUis2R2k4RGJBRmpsU2lZeEpJTW5melgwcW85TDB6ak5Nd2lH?=
 =?utf-8?B?UkZQall3TlRmZ21iTXAxcHNjeWVOQXFTRGxnVUdGOUhWQXZRMDlMWnRWdmZM?=
 =?utf-8?B?VFh3NGpMY3F5UVBMODh1UmNVc2M3L0l6TGd2Ni94YkwxR2NUcklORC9mWmov?=
 =?utf-8?B?Qm5VOVlKTXozd29yVnBGb0ovTG56RXRKNXg0a3ZXRXpCMnEzb29VOGU4K3My?=
 =?utf-8?B?TXF6M2oxVlRBVFRvdG91L2lpYTBDbC9NTU14U3JFUHZyblB3NDVzTG40NWgz?=
 =?utf-8?B?d3ozZ1Y1NEM1NmlaeEF3ejFIWmNTSnhiRmRLVHhYLzZTZ1ZRVUIwdlVTZmMr?=
 =?utf-8?B?VmZKTU1nVGE1UnZ0bkwzT0x6TXprSHZTVVYvQ1JzM3EzWEU4UE1TdXhWVGZ3?=
 =?utf-8?B?dmtxZERuRWIwdVV4TFZBNG9lM1hNYzVqdGtYTzY3U2t4c3BtUitvQmxBWkh2?=
 =?utf-8?B?UzdUY0I2MFRxczl6MklmbGVGdUFndE5DRzJjVUFaSG9FTUVIbnk0cm1wRzRs?=
 =?utf-8?B?eUpiVktQdHliZWx5bERyQ1VBRlVmRmpRbU9sVDVxcEtHZGlWblhzTy9EZ3Bh?=
 =?utf-8?B?YnBMMDFLVHd5aDhiNkVCUGtuVjBUNWI1czUwQ1pGYk80eDB2WURlVXRud0lj?=
 =?utf-8?B?TUcxWDJHaFdLSHJ0UmxMQ3R3VElTZmtXUGxlQk1nRGNvRzhrUFVXR2lJdTZR?=
 =?utf-8?B?Z2ZPQ2JOWTNRRmNjajRscmdmeGpUTTNHVHVBYmZqWGRkRVJPRTAxK2Ird2tW?=
 =?utf-8?B?bGpqcUhrWkF6a053ay9SUkFvTmRoTFF1K0R1QXVLRnVMenh5QitDbDZ4dElQ?=
 =?utf-8?B?WkwyblEyQURhSVRsenA4dDR6V2poSTZUWTgwRmpFb3M2WFB5UzJGbFluMHA2?=
 =?utf-8?B?MHRNL3RUZkhDcWh1VFhmNFE5MHR4R3o2SS9XMHpLUGw0bTNsbTBDV3IwdFR3?=
 =?utf-8?B?Y2hDWlJGS2JjL0lqcjZ0dmpXekxkWHFZeGltTkIrMmZoKzUzMmxycWtBd0Z6?=
 =?utf-8?Q?nxC2zO7odMS6VafQIBUUloW2n248e8yosYaU6RG?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2963d4bb-ea1d-4d02-fde9-08dde096702c
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 09:38:10.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB3116

> So I am trying to make it work on JH7110 as well, and here is the
> problem:
> 
> [    5.564433] ------------[ cut here ]------------                                                                                                                                           
> [    5.569161] refcount_t: addition on 0; use-after-free.                                                                                                                                     
> [    5.574485] WARNING: CPU: 2 PID: 71 at lib/refcount.c:25 refcount_warn_saturate+0x110/0x162                                                                                                
> [    5.574537] Modules linked in:                                                                                                                                                             
> [    5.574560] CPU: 2 UID: 0 PID: 71 Comm: kworker/u17:2 Not tainted 6.17.0-rc1-g60ec647ec20c-dirty #77 NONE                                                                                  
> [    5.574596] Hardware name: StarFive VisionFive 2 v1.2A (DT)                                                                                                                                
> [    5.574613] Workqueue: events_unbound deferred_probe_work_func                                                                                                                             
> [    5.574654] epc : refcount_warn_saturate+0x110/0x162                                                                                                                                       
> [    5.574682]  ra : refcount_warn_saturate+0x110/0x162                                                                                                                                       
> [    5.574710] epc : ffffffff81336608 ra : ffffffff81336608 sp : ffffffc6006e7530                                                                                                             
> [    5.574732]  gp : ffffffff8514c1c0 tp : ffffffd6c14ba580 t0 : ffffffc6006e7134                                                                                                             
> [    5.574753]  t1 : fffffffef0a29898 t2 : 5f746e756f636665 s0 : ffffffc6006e7550                                                                                                             
> [    5.574774]  s1 : ffffffff83c058a8 a0 : 000000000000002a a1 : 0000000000000004                                                                                                             
> [    5.574794]  a2 : 0000000000000000 a3 : ffffffff801ef586 a4 : 0000000000000000                                                                                                             
> [    5.574813]  a5 : 0000000000000000 a6 : fffffffef0a29899 a7 : 0000000000000003                                                                                                             
> [    5.574833]  s2 : ffffffd6c35e68e8 s3 : ffffffd6c35e6990 s4 : ffffffd6c33dc008                                                                                                             
> [    5.574854]  s5 : 0000000000000000 s6 : 1ffffffad867b801 s7 : 0000000000000000                                                                                                             
> [    5.574873]  s8 : ffffffd6c35e6990 s9 : 0000000000000000 s10: ffffffd6c3099058                                                                                                             
> [    5.574894]  s11: 1ffffffad861320b t3 : 1ffffff8c00dce34 t4 : fffffffef0a29898                                                                                                             
> [    5.574915]  t5 : fffffffef0a29899 t6 : ffffffc6006e6f38                                                                                                                                   
> [    5.574933] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003                                                                                                     
> [    5.574952] [<ffffffff81336608>] refcount_warn_saturate+0x110/0x162                                                                                                                        
> [    5.574985] [<ffffffff8193a506>] drm_bridge_get+0x66/0x6e                                                                                                                                  
> [    5.575022] [<ffffffff8001f26e>] drm_bridge_attach+0x54/0x5a2                                                                                                                              
> [    5.575055] [<ffffffff8002740e>] vs_bridge_init+0x3bc/0x4ba                                                                                                                                
> [    5.575087] [<ffffffff82313026>] vs_drm_initialize+0xe0/0x2f2                                                                                                                              
> [    5.575126] [<ffffffff80027ca4>] vs_dc_probe+0x758/0x85c                                                                                                                                   
> [    5.575156] [<ffffffff8233123c>] platform_probe+0xac/0x138                                                                                                                                 
> [    5.575186] [<ffffffff8232b2a8>] really_probe+0x164/0x59e                                                                                                                                  
> [    5.575221] [<ffffffff8232b818>] __driver_probe_device+0x136/0x266
> [    5.575257] [<ffffffff8232bb18>] driver_probe_device+0x56/0x214
> [    5.575292] [<ffffffff8232bdf0>] __device_attach_driver+0x11a/0x278
> [    5.575329] [<ffffffff823272d8>] bus_for_each_drv+0xea/0x16e
> [    5.575363] [<ffffffff8232c680>] __device_attach+0x160/0x2d4
> [    5.575398] [<ffffffff8232ca06>] device_initial_probe+0xe/0x16
> [    5.575434] [<ffffffff823291d8>] bus_probe_device+0xfe/0x134
> [    5.575468] [<ffffffff82329c62>] deferred_probe_work_func+0x128/0x1d6
> [    5.575503] [<ffffffff80126aae>] process_one_work+0x5c0/0xe76
> [    5.575543] [<ffffffff80129da6>] worker_thread+0x6d4/0x1316
> [    5.575572] [<ffffffff801429ce>] kthread+0x29a/0x570
> [    5.575608] [<ffffffff8004693e>] ret_from_fork_kernel+0x10/0x9a
> [    5.575643] [<ffffffff835f55f6>] ret_from_fork_kernel_asm+0x16/0x18
> [    5.575682] ---[ end trace 0000000000000000 ]---
> 
> 
> When a bridge is allocated with kzalloc, its kref count is initialized
> to zero. The drm_bridge_attach() function then calls drm_bridge_get() on
> this bridge, which sees the zero refcount and triggers a use-after-free
> warning because it assumes the object has already been freed.
> 
> To fix this, the bridge's refcount must be initialized with kref_init()
> after allocation and before it's attached.

Do you have a tree I can look at? I am very interested in getting this 
working on the jh7110. looked at it myself a week ago, but got lost 
quite quickly. If you end up upstreaming it I will definetly be there to 
test it.

Did you actually manage to get display out over hdmi? The hdmi output 
from last years starfive driver gave me some strange output issues that 
I'm currently just living with, but would love to see it gone.

