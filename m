Return-Path: <linux-kernel+bounces-788996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF903B38F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 01:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1127C8115
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691C630F932;
	Wed, 27 Aug 2025 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PLVD1WZA"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECDA23D7EC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339156; cv=fail; b=YSEGnfZS333RtzlU3si6oNgH2ckfFG1GvvphuglXJA8tgi7ZTw2elyOLOU1+ZZLep1pVFVcoCLbdim9VEPomrrJovorZMux9rpZ6CqwWsCLRdfNm17Z2rhZ+/D/aSwmJpVRXM2IMMgKqWeO27r/cC7sdlETM/TXQdLh//lhy+P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339156; c=relaxed/simple;
	bh=3oCM3ddIUadDtyve+9ZHYPGFqwrqS0rmCmmL6NEyiA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZWePtHtuMYWw3ljza6c7Vtr3k7sDwDkRYvawDUUZpzpqudsjMDrlUPtkC+EGMelfk027ZszlIoOPAIUQ3G5cRkhJlz6PkIadubEMMWp9uYwEm96ZU6BtI8BuxPwMEEiqYmmzweu80jd1cMaytS+wDtnQpnJwRG9cx5+qyX22oTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PLVD1WZA; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMexVBFhwkGlIiW63VOCVdT1R9rIWev8DVeOZ9M35VZd5ojFFL3DxqLf6b8uoik0emSeZANrFQyFg97KGPMIxaGthzz667T5rWnv2WUyMxSssJc8Bmq+bDRjROZq8a2Smm2JYXddzMWxZpHrk3R2CqqVykCdkbNLJtxn6juwSG8ctwjw9eJqnyr9CGVFRYfT2K7V8OKyU9+03iJ3olBfLmQNs6HhCUJ3UdMDVw8O0fpLZbFFv8AZvvXxQ928td1evAC89jZAxuZBHkK3qAdmlVo5wlw5ko0yGmS8TFpaUDXl/lVG+urWpC+wPPAzijfHvZDQsk2FCaZTtGshyr9qaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtENAGBQ709z3JSAVUvTbKOByleUxKaEobXurWDL3kM=;
 b=D3gF9V0DLHmC+I4+1jsGn9zw6r9IfQTurGfJN889mhSQCG67NMSZEOZIYxFrIntwpK4o+ce9YkFmdddPJhianCEE3tXxg/X/R2H5NjpaWwKrB0NqyG0RcKmDQ2SKLPJy+BS//YkRsc2rXWH8muTLpuD04EoO+pDV2iwL+UoKcWp0hpwCr5xLaBfLltFDfA48hMZbCVsANbwVi5Ygi4LOk6dXRVrULkx88JFzPrTtZJ16+etDHBB1yGdt2+v0n+6QhxxtpnTuT/YgGb/nXyxeVFlliDa8waabw4ixjsBmz7SnDYQ+Q4Bzv/Pg0WAL8pOR5D1Lyr5/uUj0NMtgNKdOpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtENAGBQ709z3JSAVUvTbKOByleUxKaEobXurWDL3kM=;
 b=PLVD1WZAKCgXoms0m5ZsPmWbmsU0jYJJ7ei5keJlLtuW0qY43zT3Mgd834CRGOUd2g572ubuFFc9ho6oW20QgwnrpxxvTdJkxSMR6OVsbvX4OyI2iSMjlmJryHIlPOijuoHiQl7yS6NbE62d1tcYdXTEzDIQQEGamLr0d6bsu6HE2IO4FZbrNcGPlyHLzB8ZtA47DyFn4vw1fjFEJIvkLqFERszR/eESm80X4xL0MQegnmsihgCEKm4iCgf9H7NNf7uDIqLUXWuW5/XtuQj7NCxXnBJUG0Es7862MgaytlefbbSDc429ao18K7QQaFldHTuRgt/NrDI2HQh8AudXOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 23:59:10 +0000
Received: from IA1PR12MB7709.namprd12.prod.outlook.com
 ([fe80::5312:ce8b:bdf5:aa31]) by IA1PR12MB7709.namprd12.prod.outlook.com
 ([fe80::5312:ce8b:bdf5:aa31%5]) with mapi id 15.20.8989.018; Wed, 27 Aug 2025
 23:59:10 +0000
Date: Thu, 28 Aug 2025 09:59:06 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: jgg@ziepe.ca, leon@kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/test_hmm: drop redundant conversion to bool
Message-ID: <l3qkai3xh5hwvt2f627i4jhf3upyvzvvftikgbahauutyhyagr@7tsq4upe6hl4>
References: <20250819070457.486348-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819070457.486348-1-zhao.xichao@vivo.com>
X-ClientProxiedBy: SY5PR01CA0122.ausprd01.prod.outlook.com
 (2603:10c6:10:246::19) To IA1PR12MB7709.namprd12.prod.outlook.com
 (2603:10b6:208:423::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7709:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e7233b-35cb-4d6c-72d3-08dde5c5b773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p1Cq1nR04H8IUJ2FqUY2SAlB2mKYWM2mHotjzv5Ix4n8eWALDk1lc9OKpmBx?=
 =?us-ascii?Q?fgANlvsoKDQ1bA6tomVaQTEFZ6YcDwf+wZk24lJ0e/SX5Gv8DlFiE/ZjwevF?=
 =?us-ascii?Q?b4mh/c+NdPo/cRQgBUoaJhRVhG+YH7d6stKnjTQ/A5L0e5xaSAtDGg64/Ffs?=
 =?us-ascii?Q?JcOlzVzC8VZ0DH8QIQszY2TmCSKvHJarlVI+yCurDzc2ugyDjgEGW2XuQO0Q?=
 =?us-ascii?Q?h9Tt90iy4joUoLQVvfsNJH0lqteAiahE1q0WdXVuJ6mRq914estC9aikZC6h?=
 =?us-ascii?Q?4oYYcQnUolFkVWBzyk+bJed3DbpkwrqzzTrFWqOcg8CQjtcVTRo0NMmWdxLe?=
 =?us-ascii?Q?QhvXC/BV09w6S7eiBk7QFY/csYbOKE2hlXNm3h0EFWAFTy0TnT4f6XvO3zbu?=
 =?us-ascii?Q?nuhxozGBtabWX8mbpspBbJiRTwb+XY3EmodhXOWA6eoxObM5cySrDVcqyJE6?=
 =?us-ascii?Q?67AAbTAw47sTKHkWgtlJ7dWOxkl9HUp0vwJ0uX3iXeef79b2FdfvwNt5EufR?=
 =?us-ascii?Q?7lNA4EObhXF0gkoZMnDyOetpD48bJGooivjBrF1qx6nEhd3zN3H65aaLj4TC?=
 =?us-ascii?Q?d1R9np5bFxMucbJrQ4EFltyWtwxn4wDV8/9eioSr+7MakbJSbHDzhcu6nsD2?=
 =?us-ascii?Q?MzfF8yoeZ0tvkykPqtC7YU/I2kKCGZJ7TnxdwLR4T6um/O8MFKp8FJijLo76?=
 =?us-ascii?Q?qpeZnidOV+7YPNBmSkJEQRLl569uwLb5bpBgoa5fWFFQNxAyQTlifTxrJBt1?=
 =?us-ascii?Q?tCYjTXy8i/tfYtvhKfgbX39cu7DuMTjLjLUqpWwokDKv9QsmHUQkvJUVZlSo?=
 =?us-ascii?Q?sU9QawJN64l5kfOJPkMHW3xTDsQpi/iko03ODGEKltRkEWJ++O13p/dEj1iy?=
 =?us-ascii?Q?MDxWubrGvpVBMzWzguG3tl9Jg8cf/XeIFz3B7l4Nj0Nzy7bYy7VJtPVa4aMw?=
 =?us-ascii?Q?lYcG9uZw96Ax4Asp6YIl+eYI++5iLr+AEh2ybHDHuXCfyVuo1afDZNQZs0iF?=
 =?us-ascii?Q?qEaMr13utLKVxYPU34N7poCzYeqjmE7/X8DLNYs2lo+hMKk2HAWJaG+oCs98?=
 =?us-ascii?Q?e15bJ3e9q//ebOnBv2qiVacVsEskXbbABJf+tO+qCuaTroBDbfyKOvPdhG3G?=
 =?us-ascii?Q?5ibDSNjQf1fB/RVNAyMMShzN2+KtCP0+1wsgA1s+811H5YmCdfXaVdMiTfpp?=
 =?us-ascii?Q?x0jcD9kcgRTwNB7h1yBG41YWuTQ4QceWwyqpIZjnNkERfqEmoj9MzFzqQRfp?=
 =?us-ascii?Q?e+R2NgYjgjIUqwy8H8P2y2lieupHJ5YSJQFY2yHThphgU/bcpi52gKIRxKHS?=
 =?us-ascii?Q?MUtE7kUELHwt6G+GNea5L9NZn3KpBlevL4ExEjq4rc8bxO4VV/V582UK7wLv?=
 =?us-ascii?Q?wFVzl0uvu+PpXsUThGtSlWKSM2FTU4KvwVgHwFkAEG0qxBw6UCOIQc0hzmJH?=
 =?us-ascii?Q?wlhP8TIig1k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7709.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HZTbyvad/i+aCO0ibgHLZxtI3Sy4vtsmx94YV1U7wvIJKysb7mToium2bUEo?=
 =?us-ascii?Q?uCrydV3aNdfGY7rqtTlgn+aDIUnAe0KkAm8I6OocSUb8tnbLAYHsazb9WxXY?=
 =?us-ascii?Q?o3wwGIlLJpU94QjGTTF/vJ2Zc3k3+6St1cJviu0uJLR1/RLyfzGNrzgOZMlu?=
 =?us-ascii?Q?HCIh/Zcrah/WvWUI2hprbhRavFTZGlp9DgKjdd57cOsKWDKeysNPWSRjIFeX?=
 =?us-ascii?Q?2Kmp5FLyR3gg/M9cuC0u2rVIxp3lQVkclMyvUtlLPLEd3jBHO8fCvOp5iWOm?=
 =?us-ascii?Q?VfbkS+S3bAPY5geKZ9jOJ7u4gIp9O6oY2zXHGGeWsLMqwtrKcFu80BaevrPU?=
 =?us-ascii?Q?B+MbuWj5RzAsJ1jAHmlAZI+Ekh76xhiigENpvNjZehRoDI0uPYiEXxO7QVfr?=
 =?us-ascii?Q?0guaa092gmjEdfFC+nvC+0v7HGLkAdWGsPoO4+BN41hdLpiMPxRMJQDrx07S?=
 =?us-ascii?Q?vI/sgJ+Pv8VJxFT0Nis4WydnapCctU7ShwozYl4J0ex7Qc5Jpmxj8vVjaM05?=
 =?us-ascii?Q?o58jMHEMzhTWUV6m94mRaNYylz+tf7UYGFq8y6rdemk7/qmsno8RZAofiB2b?=
 =?us-ascii?Q?XQIvcBdliGxueRNq6MBe/mfQ7bcYjC7ttlOQY/mI9s7LNECN7Z/6HsLQiIf1?=
 =?us-ascii?Q?9LdvdcCkfyIULv3U8yPvtMBky0uKqctLt3PJ1tglYwQxtStZJmq5gC1i6eKa?=
 =?us-ascii?Q?MKi2mTKI0VOhDpVt+6xO5Gd/MhE3VuTo17FUXH88F2yDGvoO++i6hmAc4K98?=
 =?us-ascii?Q?Puds+JavThX2bIUsQClFnVMfwlrob21d74xmaW0ymdoXO6x+t6MjAp2IQvb7?=
 =?us-ascii?Q?BQtiafzsL5pTU6+9Ii3u2oaJrUQqtCU5yermVJFKXSJNLs9AUgm6hxnt9qY6?=
 =?us-ascii?Q?5EVBeZ9EPCVk62oXcTMRmuDA3eI0fvdP4Cl73svljvq+Dvd3v++7/l5xNJs8?=
 =?us-ascii?Q?DwR0jfJOkaeJ9qj+ER+ho8vwuiu7Wnbx7zwS6GXj9PqePt356USu61Lmojx1?=
 =?us-ascii?Q?6e0U3/EAL6lOxh/YX2X0bxLL9Ap3TIk8k3VtWImTYIuqQLgHfgWteQaOk1mn?=
 =?us-ascii?Q?0Seu7Y5QKKdgFwj8WZwPQYanIi31e42pF5IvSfkRVX+9iAbN74UQGDGYlIVC?=
 =?us-ascii?Q?x6ENMdUhA81XQDejXK8c3v93BQUrN174r/u9dpLh4EKphP0d15T/We9iizoz?=
 =?us-ascii?Q?bARzCzeeqr4FVKu+fUTkC+GaYgl5ZE2alCa93yCR0NMTO7SVo8yZ+xwOEifb?=
 =?us-ascii?Q?6vJ7crRL+gbeOVkXLPQNia9nJEGQ7mk8dOYISSr7wQZg0zHuqumtRH0jMAlt?=
 =?us-ascii?Q?3NLpanr9UwJ8oIep+rXvfvstHv9GG2vZtEqA86wl/QeV7/x4zz266lp8InAS?=
 =?us-ascii?Q?MAPu8TaYUaRhcr7xkU4UZcFVyLIhT6it5gcTnOagMD0FqStKn1255Q0zxmF+?=
 =?us-ascii?Q?3WhY+CPaAC5RWoNvmO7+rzKVO5TzLf7CRFvm+0U7f6Z12tW0ZsUmfpXrHVzD?=
 =?us-ascii?Q?J4BPxjmzSE8JNmo6WPuS3SjjWgABRl6/FUHNWsWj3YtxS3JM2+ssqBwhUgJD?=
 =?us-ascii?Q?aMkB8J4LUFWiBeBR/Kl197SNtMttxg7Evq62hsq+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e7233b-35cb-4d6c-72d3-08dde5c5b773
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7709.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 23:59:10.7910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ipaUMxmXrwjWCxyrb8ZeUJLRmfiW9GFnpOpsMuK3Zu5nDN5KbQ0L3dtqtw7WKYvcmXZoEBwR2CmAiR1B5XxlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566

On 2025-08-19 at 17:04 +1000, Xichao Zhao <zhao.xichao@vivo.com> wrote...
> The result of integer comparison already evaluates to bool. No need for
> explicit conversion.

Seems reasonable.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> No functional impact.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  lib/test_hmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 761725bc713c..83e3d8208a54 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -140,7 +140,7 @@ static int dmirror_bounce_init(struct dmirror_bounce *bounce,
>  static bool dmirror_is_private_zone(struct dmirror_device *mdevice)
>  {
>  	return (mdevice->zone_device_type ==
> -		HMM_DMIRROR_MEMORY_DEVICE_PRIVATE) ? true : false;
> +		HMM_DMIRROR_MEMORY_DEVICE_PRIVATE);
>  }
>  
>  static enum migrate_vma_direction
> -- 
> 2.34.1
> 
> 

