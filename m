Return-Path: <linux-kernel+bounces-783376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE11B32CBD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 02:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE57F7AAE26
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 00:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5941878F43;
	Sun, 24 Aug 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vGo9Jr+W"
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010010.outbound.protection.outlook.com [52.103.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0BB640
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755996014; cv=fail; b=OM6asSDyrqEz7EO3awfbfVpLPSyzPnELs/x8Mxq7JAxaTCRPqTxCi7kVY4T8EAr9kA7CKqngPyEdymXGTbnguYhcgy3WxNSXKGZRzVk7bUkzpSBrg5iUr7YBnJWgkXDzHxg3HXpm8rinXsMNnXEf6xtphGh1dozThrDxz9PAhpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755996014; c=relaxed/simple;
	bh=YFm6TGxBr3Rflvtzui9jPzsf+3jLCaPwC38oQdlf9Zg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oigoDQK9A58vU+/lsCBptag46eLOc/nIKByt3oE9c9/yugx90dARbZgnnpOaUlh0Q4v7c+2YxuxVtWfNGYexo9FSPtV9/XwX07EjwB/sqaF7kJhFofYEjorjeYNk4CUljhrGA02KJHqQ5aY9bKqVrD85LvXXAtNvl8IlMamNgcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vGo9Jr+W; arc=fail smtp.client-ip=52.103.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojMeq2Q7h3+z0IGlYZ0Wf5WGwG0mhDy8Sd1Z51crmU4+nONAurHJxBqv8pIFPPjeNSyTwRlq+cfMFNGU9K4+NDa+gf75OPHHbrIQ98MHeWYpmKMNQxYVdV172cWK/HNedtyVonnzgqyxqhdUdjjVLD9dHCHWmgfav1YJqmfR//IlFGPqjlDJc+sx0Ou9Cj8q8pgS1bI2VCfv4LGFWPeBF/QG32Ix1nSOE+vanwM3qYGsuoXG6B4fIYKgJwos1CwoNuYN1CHTBBttC74BksPR1cmBCQUkmqpktnwXXYoAEkoLdNR7XQTyUL9+MuNVnm4Z7fkmTI+dFzK1lej2+buKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUJikpznnlmFqtDjTyIC3bJvpCctsb9zfxlIk6HZ7Qs=;
 b=lxUHSJqJJ2uMgVxLfvmXER+rCNlNXL5sy83ekbif7f618uB8OGXL52IBtUgcN38pM5s5BRE0elrrqOW2gUSsvIt8u7VouMtAkDuyAG4QFS5O5IZEeh6jGG4FZeN0SSNF33v8f0A6YSlXHaHSeWg0fOK52gFw0RJSJ6KTG9ONvAyc05bDmoQThHD80qsPHj5wl/mWvfOkN9entZbGWTcSdfjBjuBXtDDZZ/V7nFAenkFZrnAmKanYD5UKDMNqSOej8RLw1QllM3WugT8CqKWHHR/pRH8d9fGVXqjzX8/UCChNIPizKiCUoaFRb4l+/riQn5RnRNUIwu99WNj/Yfpk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUJikpznnlmFqtDjTyIC3bJvpCctsb9zfxlIk6HZ7Qs=;
 b=vGo9Jr+WVYMRGR4Cz7rg3DPCy6+wgD4jjlR5rdDUm3YvNfGE9CZs231V1Xq3PSI5nZtAXc+zY6ZebX94hmoe3DqcWLk/FFkUJ1Yl6WF6s84NCkX+t7+VBy06Iwu+w/i69BoQh+UgOzkbSHXCMQaxGQwy3cvaeh3gR5SFcYRcQWGTbF5gI0Wv9mfuCFFdzvCJySiQU8EIcqBM0X23rH77dQ0uhHIuqSX4QpNGyCRt6f/pPhzWv8HPAMo3e+VmC64pKZnMbSRFnFicBTIgyMXUEn9n9dTna4bt+rCh54tT9++Gplq4a1ucM/E4mEcJ9NK8C3edJn4cISJnWouYAoQKWg==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by PN3PR01MB7728.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:cd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 00:40:06 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 00:40:06 +0000
Message-ID:
 <MAUPR01MB11072DF9EE680F641C10F79D7FE3FA@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Sun, 24 Aug 2025 08:40:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] irqchip/sifive-plic: Respect mask state when setting
 affinity
To: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner
 <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
 Nam Cao <namcao@linutronix.de>
References: <20250811002633.55275-1-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250811002633.55275-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <11cec161-3f79-4feb-a71f-e0eb8ea491a1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|PN3PR01MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: c01de001-6432-4d42-e48d-08dde2a6c532
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|23021999003|461199028|5072599009|6090799003|41001999006|8060799015|19110799012|1602099012|53005399003|40105399003|4302099013|440099028|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE5WMXBjOG5VZlY2empkN0U5aXNsNUsxSWgwMnUwSDdkNnUweXhyMEJaL0FT?=
 =?utf-8?B?MUNVMUpxQmgyalZ2REdvYmpSaUw5R25YaGhJU3FYUEFrQWdHUGtDMlFOcm1i?=
 =?utf-8?B?WlJsQ08wWFJxQVI0eTNjQzliR2lzeStFYlJIcitzKy95cFRTRWIrb1lDTWg3?=
 =?utf-8?B?MTlZRjlxTXVLdm9JQUQxZ2VOa2VWU2J1UmNPVExsNXZFbGxlL1JWZVM3TTRN?=
 =?utf-8?B?MjF0Y3hxTHl1V2xoUVl4VFFxUlo1NGlaSnhtMlRIVlJWbnZrR3lGYUUydHhK?=
 =?utf-8?B?QWZvNEZ3cXpBT0FDYmpxVHhhL0QyaFNoTkMvNlFsOFhwUnNxc1RZQTgydmhE?=
 =?utf-8?B?SUc1RTRmNzFLZ3dvQklFVlRTdkpKMmVwNzRkdGJ1VytwaGpiU1hJclR6aWZH?=
 =?utf-8?B?N3lETzdMeGtwMysxdzU3d2plUTYwTlhBb2orMTZMdjZXbWRMam9wRHBrNGoy?=
 =?utf-8?B?NjhMbjVISzg1dEZCcExidXhZSVo1bEJDQjJuWWdpSU42U1VOT1ptL1BZYjdR?=
 =?utf-8?B?OW10VFIwTVo0cVg1R3MyRTRaYWNNYmlkYWZERnJjSU1XYURjMDViSVdkOEtG?=
 =?utf-8?B?RjlLQU5jZnlYSk5lWTBtdk8wYWxKL0xuRlpsTjhYYkl2bFdTUDE4Q3ZrZ0NM?=
 =?utf-8?B?T2ljUWZ2d1p4a2ZIblVjSGp1dUJlVllHalN4UzdIWWRqTVZDemhMSUhXdHVN?=
 =?utf-8?B?dUNYbmR5dytSOE93dU1LQUFDZ3pXR3ZxRkNxbitmZHpuZlBpbGFSQU9rYXBI?=
 =?utf-8?B?RUpMblU1ZS9ydnd1VlVQK3FQR2xFZUdsYkJoRTk0T0RBbVN6aEhnNHQ2VWFJ?=
 =?utf-8?B?MGxMZzI0VFNDWGwwV2VNQXRGd2ZuWi9vTlU5YnhzR1lJSlFBaWFBM2ZZZ0Jz?=
 =?utf-8?B?MVoyMTBTV01ZMjZKRWdoeXRjWGNvYkJOQTdSTmNEUm5nZWlmR015TWxyd0Ew?=
 =?utf-8?B?M25uR1FSZ21POTArS1AyWHVuWG4zdG9hMm01VnN2TFV2NnAwWnlrZmFZRFZs?=
 =?utf-8?B?dHNtNHFoVUZTR09HWUJjeldBSm5PQjN1b3JLRisvdGhXeS9aeFRGT3l0R0NJ?=
 =?utf-8?B?SXh4cmdDK0x3VVJPN240eHFWTUFBTkptTXZ1UlNoejlhMkZNRzZvdTdBQ203?=
 =?utf-8?B?UDhXQWFqR1grK21LSEJhcFhNQ2RQeis4M2tBdmZTamt3WU44eE5ZMWE1M21C?=
 =?utf-8?B?a1doUkV1aVp4N0NIeElxbkcrbjZsOFc5dFJrQnNBaTRLTEoxZkhFQ05MMWwv?=
 =?utf-8?B?aTR1a1RpaGMzYTB5NHc2dllvOFd5aTlnZjB3SU9vSDFISzJZUWZ1Z1BiVHVi?=
 =?utf-8?B?U1ltVkc2MVB3SU5pcXB1eU9PK2Z3S0NmK1dhNkZKMWI3dXNvem4rN0N0UzVX?=
 =?utf-8?B?Smc5K0lrVWNEVDl0NUNSY2krYklmeVo3U3UrQVM3ODVRREpIcktFS0tyRWJn?=
 =?utf-8?B?Yi8xV2lzQS81OUp3VVViZ0R2THA3dEVjcCt4dVkzcUJXTHU0cnVlK1BMUUQr?=
 =?utf-8?B?UG16WVJycHd0eXBPeVdISlpTRXJ2ZG10R3J5RUJYdnQ0c1BkbFRhN0tDemI5?=
 =?utf-8?B?Yzl6ZHRpSDZ1RWttQ05QRXEvMTk3Q09Ha1Q3b3BsOHo5MkNpY01FdWkvZHRm?=
 =?utf-8?B?MC9WVW9ESU1JalJVMUVhUWRtUVNlbW9YeUp6b05DQ0R4NXFkWDVRVGt5ejRh?=
 =?utf-8?B?NUdDaTNmM0hYa1dGdkp0SFFPdGRNejJxNER5REJKb2VTSmM5UGVmNW9la0ZL?=
 =?utf-8?B?Y3RIeHkya2VQZEFrSXVwdUJRalcrUUVneEt3MTI2N0lCalI3WUI5M3N0dTNG?=
 =?utf-8?B?aHZnVS9GY3hFTnlHK3RoQWxscytXejZoV2p3TkI2VkNNZjRNdjVIbW5VbU1W?=
 =?utf-8?Q?Z2mawQ61D/pNG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk9uYjlQZWg4RElUZjFDV0FqaThlSUdEYTlSWk84YjZVdnZGWDFsRU85Y3Az?=
 =?utf-8?B?aFg2aTVpVEJkT0JlTzhzWlV5bk9kUEYxNUtGdTJ0ZXVnc2lpVEVPYXM3bklB?=
 =?utf-8?B?cmJJYXRnbjE5NW1FU0JUMElBbVdCSGtUQXI4Wk1zTzg3R2l1c3hNcThDZklE?=
 =?utf-8?B?U1h6Mm1kM3FmaEFzcWR0ODU4MzdxQkErV2c3VjRjV0kvYWo5ZVk2RDRTNlgv?=
 =?utf-8?B?Zmkybm5WWlY5RXBsZzExWnlYWmptVzlyREFVZSt1WTBZN3poUy9KVGNPZlh1?=
 =?utf-8?B?R2xpVEo3Z252cXFuOWpDQmJCT0l6WEF2TjFhTnZ5dDZWM2RoazNseVVnaXBZ?=
 =?utf-8?B?TEZTbkxaUTdlbEk3U2c2ajhMUi94VDhCNVRyNkJERFZKMm5KZGVscmhvQWVu?=
 =?utf-8?B?Q29sMlBDOUNIQ3BpNDRqMmkwZ2luajJMbkRQVUNoNUgxejJKSmY2QVhUNllZ?=
 =?utf-8?B?Y0NxT3o5dE1wOHBCaWNsVUttWjdZYTBXSCtPeTVBb09yV1dubkFaLzhSRGJO?=
 =?utf-8?B?NklGbldXSmR3Y0dHdXdwU3FQWDg4b1JSb0pEUGlOMm5EUXErUnVLd05kd2FJ?=
 =?utf-8?B?SWZBcm8wd1A0dno1U2FSQ0EySDNRTURMVUNGLzMyQ2tHbHc0SEl5VjRNL29w?=
 =?utf-8?B?Z2l0TUFic2RJYm9YSEN2d1R1R2hSSUJsVmZTM1NYazJkd1pseTJNRm51aDJO?=
 =?utf-8?B?ZEpYTnFTVkN4YkViZitmazVuUFUzWDVDbTM4T245c2d6ZzFFWmpFUmJtc2ow?=
 =?utf-8?B?MmtINitNL3VPZlJna0FzY2p6eVRQWE9rU0xSa0s0T1VOeDlEbjZFTjh3QVRJ?=
 =?utf-8?B?MnFONHJUdDlFelpHUHAxd01sUkt3R1JGSFg4UWJOMEdra2lRWTgrcWVLcWxH?=
 =?utf-8?B?Z2ZwemcwZXNyenBRbmJjdjAyQktvY09Xbzk4THExb0hUUzUxbnVtSlVGK1pm?=
 =?utf-8?B?YXBSdC9tUm5rVC9hU2FjUVNCNk1BRUtsdmxQdGplaWc5b1J2bGtaWTdFcDMy?=
 =?utf-8?B?RHJ1TlFpTUduMStpWDVsVkpyUzJHcFB0M1JWdGZSMGdCV1UzcE94ZWRtSitQ?=
 =?utf-8?B?K093dzNyUjhaWkw4dkJpMHNBdEtoQXJDWVcrSGRHSUxDSHBCZUJEM3FUbGgv?=
 =?utf-8?B?S3V3WTVTU0FualVtek5MS2hBQUtjRGptay9KdC9RbS81NG9mZ3dnOXFWU3c2?=
 =?utf-8?B?ajNFWEVJbVNxaUxCM1d4a0JYQm53WXMwYTI1VGd3ekJ2aXRCdXdVaXowWWs1?=
 =?utf-8?B?OUN0Szg1YjVTRGUxUDdFOXRwTGxObWFqUmMvTWZQNGVUU0JKV2xHWGVDY0Uv?=
 =?utf-8?B?ampvckRKY2syWXROcXJpeFZrUTBjNEJna3VnTTg2SzZqOGlHTU1xUDMzcjZZ?=
 =?utf-8?B?VFU0T3Z4eERPZjFYQTR6ZzFXby9qWFBvU2dQRnF2aVhrcWRBRlpDS0daVGlt?=
 =?utf-8?B?QXNtbmdTUlE2V05rNDVndURCR2lYbjdLV0g5eWM5d3FCSng2Y2VvTENwbk1Z?=
 =?utf-8?B?dUdDN3hpb3V6Z1k1N2x0UXp5UEpxcXVaN3BtS3F6SjJuYzdrd2JrakEweE1B?=
 =?utf-8?B?RmpuKy9xM0JSdTJvMm9TU1RIa0hRcXZxQ0VXL2pmRExaQW5CMXY4VVVrc2Y2?=
 =?utf-8?B?dXRsTXZzM2dEbmw2STNRSjl6MW53U2l0SktTY1BWZmc3alFWd0ErSUJHcWhw?=
 =?utf-8?B?NEFQckhuVEozSzEwNjFzR09rTFZwVWpWMWx6aHhST0VIbVg5cWZ0b01RYnh5?=
 =?utf-8?Q?lq2xPz1pIKoz3i30nTcF7i4SK0S65Kwtahg89h2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01de001-6432-4d42-e48d-08dde2a6c532
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 00:40:05.9658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7728

Hi, Thomas, will you merge this? I see you have picked another related 
patchset [1].

Link: 
https://lore.kernel.org/lkml/20250813232835.43458-1-inochiama@gmail.com/ 
[1].

Thanks,

Chen

On 8/11/2025 8:26 AM, Inochi Amaoto wrote:
> The plic_set_affinity always call plic_irq_enable(), which clears up
> the priority setting even the irq is only masked. This make the irq
> unmasked unexpectly.
>
> Replace the plic_irq_enable/disable() with plic_irq_toggle() to
> avoid changing priority setting.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Tested-by: Nam Cao <namcao@linutronix.de> # VisionFive 2
> ---
> Change from v1:
> 1. apply Nam's tag
> 2. remove unnecessary off-topic change in plic_irq_disable()
> ---
>   drivers/irqchip/irq-sifive-plic.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index bf69a4802b71..866e38612b94 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -179,12 +179,14 @@ static int plic_set_affinity(struct irq_data *d,
>   	if (cpu >= nr_cpu_ids)
>   		return -EINVAL;
>
> -	plic_irq_disable(d);
> +	/* Invalidate the original routing entry */
> +	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
>
>   	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>
> +	/* Setting the new routing entry if irq is enabled */
>   	if (!irqd_irq_disabled(d))
> -		plic_irq_enable(d);
> +		plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
>
>   	return IRQ_SET_MASK_OK_DONE;
>   }
> --
> 2.50.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

