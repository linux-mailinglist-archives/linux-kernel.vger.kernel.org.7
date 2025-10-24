Return-Path: <linux-kernel+bounces-869131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 672CFC070CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27B9A4FC051
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E283C32E72D;
	Fri, 24 Oct 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AXzvheZr"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3632D0FC;
	Fri, 24 Oct 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320727; cv=fail; b=mcQDuYPdQYFpRT/N6Yk/yGATTYJCtoMcyaMri+NQ7/uh1Ftgc3SpPLPgkMpzkI+bONuQqMeBZlCiKukfVVYf8D88IigOfJMSAsjftgAY5FprfIfYOXrcM0cfu1e/YlbFz42Zau37SGUpqN8rhjy2/MmUjojWA9M8FwGAnXCEXvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320727; c=relaxed/simple;
	bh=1rWUT0KjYCh2yxpveH3JPLdD5XuEdFlQc13iR5vzQtg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kx3hZXye21fC8cdIXDWxW/jZJsz1GT1o5Dot7JzRMaYLRBiq7k3Ua9Ku9CKh1OAInzdrWA5FyekhghOWUzw2sTPla3HR9QTs8BA0BuQoz9s/ZJGK6mHXiPmvkGtA1FSRftQ5mByr57rPrJDC75wZ7O08oQhgKRWvF61eogrW+P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AXzvheZr; arc=fail smtp.client-ip=40.107.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cU6Thu6fSp1dihEmpH7a7mxRgtIUbJZJ2MmfLzuz+miMhoPzzUcppv8KkEutBlwoNwLF3gnSRLbu5+KkilXV0wkPd4mT2MFfKdlPeqqbGO10eM+IbM2YfeG+6BfB/tZyL4QjpZiwDJylTuhISs1M2AN3B/lxzLDdoso7VqXV4KBwqc8mUMN5pqTf7SQxtUgVB5VZelZbgBc9da3zdaxfmQs/fzpeMGau0jUtvdvuieVaE0Hdyz8EnUJc/xnT+YW0SC3ntbowHK/k816P2d35BMZpegbjr5exQyT6X37TERyDYnE0yNVDJFRE21GmXhNlIcxias88uOHC+jHnTB4CTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGmOIB1EWhKaXNmYjoVhdQ73AmRvee6FzEaMJBLum6E=;
 b=mfoa6ShBHsVSNBfEpr7Jg5ASp6cOHI91RQO/4Zs08riFr+qZ+et37HyFd4A35ZzhJCNn3yk6RKYtfZEbLv6+FleXvpM2oIUB6BQ+Ub+NzuHbgmkgFbHqr259DZD++mmIn1T6DyiuJDdvVpwCfwVgq3zpvNfoJP2ZBzCmKNVZU6KpUSSZnxGgXnLzA+91hPZ68ANWFSaqKks8thWocIAC3bPIp9FcjiSs6nirdPdAWCGlHbwWeVYjsxqDEhpxPNst5KCAD/X/89OODxrY78Xq5hjaU5SjudlBmQpitUjpUnuFCaS1Tht84MXqkup1rgvEkI++ydrybpHkZR8t7l0WGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGmOIB1EWhKaXNmYjoVhdQ73AmRvee6FzEaMJBLum6E=;
 b=AXzvheZryhE391IdNHkZPx+BY/pzSlBpFzkZ3g9Ch3FsoWsZvviKxQxT+Mhag5a/hat5wXh/lWMHxEhoA7KndLSkbFHvl4qs2D3rkYOAuoCzPmL/zxNQfoNQl51n+hkOHlDDFAwTwsh8xzJP6OXohmd3qvWjhNAcvcgZYFDO89U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 15:45:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 15:45:20 +0000
Message-ID: <9f41c7ca-a841-4b7e-a545-d1b289d9c68a@amd.com>
Date: Fri, 24 Oct 2025 10:45:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] platform/x86/amd: Add S0ix support to the Xbox
 Ally
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Perry Yuan
 <perry.yuan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20251024152152.3981721-1-lkml@antheas.dev>
 <c71c3ee5-e101-440f-9533-508d37d05d04@amd.com>
 <CAGwozwG_uU_sA0npzj6u3Aet2exxMOWdJEi5GX72CSFZJWvyeQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGwozwG_uU_sA0npzj6u3Aet2exxMOWdJEi5GX72CSFZJWvyeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:806:27::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ac180e-b466-4af0-0e1e-08de13145688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHJndnUwY3Z1YUhKT0JSOFJYVlJyTktjUDNpaGxqN0dscFN4TFV5MmQvUHlV?=
 =?utf-8?B?ZEgzZ3YxUE5wRDlTUm5CVmJDZ2ZJUW43L1UvTitWMWZ2UVJYRDVLdyt6RWZ4?=
 =?utf-8?B?c3Q2dlBncUMwdlAweHBydmw2S3JpYVZxNlREOFdnKzBWN1ZxN3F1a2Qxb0hm?=
 =?utf-8?B?SitvVXpSdmdGUnlEQ0RJUzUrN2pTUXRvUFovVUhUbm5sZ29sTUlpcTgvajBS?=
 =?utf-8?B?eEk5VHdRV3hQcXlzY3RtSTdweTFCdmhERXh0WXh3UDdoeURBZ21GWmtmaVlw?=
 =?utf-8?B?emt4ZHZWU3dYbWJHMDIvM2k2K0JyM0lVME9wdWdxMUJhTmo1bmpxYlIrSjc5?=
 =?utf-8?B?c2YyYWI0cExBUmwzUnp1di9RZFVFL3hJZ0tSZlpQSC9pai9WOUM5Q1NLbTlV?=
 =?utf-8?B?OWM5VnRQdldJei9ESXZYWTZMVVJoTFJXc3ZWd2lwNkVYMkxaMG1CdVVJU2xl?=
 =?utf-8?B?ZUJuQ25Qdzg1S2cwSUo2aW5aUzJ4SEJ6OFVhaFgrTWF2L05scjdYdWNvdllJ?=
 =?utf-8?B?cVJpTUg4Q2x4cXVxb1hJcHcwTjZGWmdXWGhIWWc3eEFnaDhCaU9vYnI0V0M4?=
 =?utf-8?B?SU5tdnh2V3grT2xuV1JKRUI2Z0V4SlY2b3ZTWldmeVJ3aFZ6c1p1b0RMTUlD?=
 =?utf-8?B?V1A1VWQ3dklEVVJuZGZaYlNSRG1HRkNydVIrSDc1RkwwNURGLzFXYnBJU2ZD?=
 =?utf-8?B?blJ1ZHBwUURJbDhnNmhQMmRtNitkSEN1UkErRkpiMkN4Mm1TNFIxOFptSXFX?=
 =?utf-8?B?aWZLY2pvdHlvQmNSV01PNnFVY0xSYTg4SmhPTmtLb2taT21MSllReE9PQ0pW?=
 =?utf-8?B?WkpUc1F6aW5XK0pJU2FDbmgrcURHdFRUbXREWkZBdDZKdmJzK3c0bjRKZDd6?=
 =?utf-8?B?Z0ZFQThXMjRjQllZZzE2YTVPai9QcWV3algxRU1ZUFA4R1NzT1h1d3Y4bjBx?=
 =?utf-8?B?WVNoajU2UnpSazhBQXNTbEhHWEhSM2loK1NZVEdnVFA1WHJySTJ2dFBSZXUx?=
 =?utf-8?B?SWdOZXY1Tm8wVEx3K1pjWnZNTlVsMmxsdGZIRWNvWnJ2YndIWGdZUS9RS0I3?=
 =?utf-8?B?KzBWZlBXbXZLeE13NUZoMng2eVNyT1h1bStuUGMydk1KRVZsdkE4allrSGhp?=
 =?utf-8?B?S3A3U3JIUFJPaGNDL2RKUzYwem5Ja1BMQ2JOT1pYV2hBQ0wxQkN5RnkyV0I4?=
 =?utf-8?B?SmszWXErUHZDYmhJVmIyM3BER3NVK2RHY2lqYkJaMGY2RnRPWW1Bdk9icm14?=
 =?utf-8?B?VkRIaWxyMTdhWlpsL25aOFU5VjJZTklvTkhUTFBiSHJ1WXJUVjNoNzVKQ0Vw?=
 =?utf-8?B?M0wxcVRTbkxtT2NuMzlobzRiOW44Rkx6c01KZHFVb2EwV0oweGhtRGlFT1hn?=
 =?utf-8?B?Qmx3dzg0ZWsybFgwZUUyakVGQnZsUWRhWmFFN09yZldrUjd0NEVZekZMbEtD?=
 =?utf-8?B?TGJ6M1FZMFFJZG5YcTVCVVZua0xDSTJobU1ZUDFwS0hIaUNnNWFsYVZ5dzRp?=
 =?utf-8?B?YWJSUHZlUzlIQWpoUWxEMlVxNGxjQVhwOFZXVHk1V0ZLR2xpa2lrNEVHamcw?=
 =?utf-8?B?WXNJVEwxaEZET3dpbCtSV2J1VVpWTXlvOXl0VGRVL0VDM1NpRGp0R0lFazZY?=
 =?utf-8?B?N3ZsUzc3NmxDMzJFaGFLOUZnNE51dGM5NkxCQzMvWlBqeW45UElzcENwWG5H?=
 =?utf-8?B?K0svYitYYW1NdDU5dWVkbkxPY2NsTG43YXJpZm5sYXF2NlNlR25kZnRWU3do?=
 =?utf-8?B?MzYza0JoMENhQ21qVlNXZ0dGVXlmUlZrenBpbkw1TkdtenNydm51MUVaMG9p?=
 =?utf-8?B?N1p3dGppMmVtTlJoZlBWaVJzQUtqMEtQeUJFNktRM3VpbDVmK2R1UDl3aUMy?=
 =?utf-8?B?VjUrQWFoNHA1eWtseVFkZllGZi9tTVBkWkhFL0tyZWV1bVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1U0Q2ZDbGw1UVVBKzR1dW5oY08rN1BwOXZya0ZyVThKY1FpOTFOMFRTZmY4?=
 =?utf-8?B?cW1jZndrbTQrUjhQdFNpbHVJc2ZMRFFoZExhUzFnY0FaZGFrLy9lVDJKMk5P?=
 =?utf-8?B?SjdoZGtmeSswY0pFRTlWbytZVy9aQjBRNjNKUG1WZW1FeTB0UGlQNlVEd2lU?=
 =?utf-8?B?MVgzYkFHZTRIeEY5UDd5eWswZG1TVHZkTFRsekloa2RTQ01kU3g5Q1FsVkZZ?=
 =?utf-8?B?dVdNQ2dNV3RTMlRjdjgveTN4NWRLazAwNWdlL2o1N1dQczdIQTJqSWM0REky?=
 =?utf-8?B?NDRnSUpRekUvdHdCdk9rV1daWG8xU05uOVpxY2ZRNWZKMHlNcjI5aUVmZVZa?=
 =?utf-8?B?OUVEYThjYmdObERPWWt0K2ZNZWFSZG1veWhtSEM3OEx1d3pZSWVXd2xsaUFh?=
 =?utf-8?B?S2h6QlVCaWZBdU5TWGpMWUY2UUxqZWtqRFVlSVd2T3drUVhBN0N4cXRoQjFx?=
 =?utf-8?B?OWZLNGo0ODVwQ0haM2FYU2h6dnIzZDFQRURPU1YvSURIV1NiYXVTTFJ5amtj?=
 =?utf-8?B?Zm9DS1BDR0Jad3dVQXRxdy9EbVJwVW1BN3ZyQXNPSWczSjZNTmxNajJEcE10?=
 =?utf-8?B?dHJRbkVlRFdzZjd4cnhmNGRYVkhHSVJIaXNOQm5Pdkt4RkVaZU1NN3ZEd1Vu?=
 =?utf-8?B?TUNwVnd3Ty9jTUxNakJjclRrZ21FdWRJRWNOYWw1dDliS1N3TE5pcHdLWmJJ?=
 =?utf-8?B?TnRMTFcyTk5EUUJ0TmlMbFVXbVRxcVV2WEFIVmFkZDBJTytwVjRkNlF4Q1hZ?=
 =?utf-8?B?NnZoZUFpL2ZTQ0MrWldMNkxxNSs1SVJUVXBNMC9QdUo2REY2UnBXZzAwUDB0?=
 =?utf-8?B?SlhNQ0dsT3FmM2lEcWtRVnNoMmE0czd3V25sRWNsQ2ZOQjc5UWNyWURtSUNn?=
 =?utf-8?B?NE1EK0tmOFY2VGg2NEVFeXhTbXdYWXIwRU1JRDNOMUNPOCtJWDhXU2J1TGI1?=
 =?utf-8?B?djZkZ1loaUNLalphWmpNVEh1aVI2WkpBTTRtRng4aGduNk5DMzV1c09LNVRH?=
 =?utf-8?B?c1RST0R6bVZwT1VQQkJOTjJpeEd4Mk50YnA0bG0zbm9RZ0dMYUluaUE0S3pB?=
 =?utf-8?B?TXBsejZGK1JNVTBLblAvQkRPcUtlNG9Tb3FHTXZZbC8yZGZmZ1FGcHYycFdn?=
 =?utf-8?B?Z05ZRE5DU29MQWovUVhhQUpoeHdrWFByV2pwZmMvQWg1azNJR0N0S1VhUkdz?=
 =?utf-8?B?T2hvMmQyTmxFRFVyVjlHQ0dSak5jU0NuNGVuUk8yWitmeUQxWFJhZmVGQ1hR?=
 =?utf-8?B?SGRqU21mdVNnZURIUW84eHZrTnZGeW9YZzJERlp4WDZESzJJakNuQVVtYWhn?=
 =?utf-8?B?cEpPRHA0UjNKQmZmZmxGN0Y5ZFhxWnI5bzFmZW0rcnVYR2lrdjFSRGZFdlB2?=
 =?utf-8?B?QlExd3drb1dCK2J5enppZStmalZSeFNMelNEa3JkaDhtVm91MHJYYW5rSll3?=
 =?utf-8?B?ZmFmb25wSVdLZENST2FVeVErZ3FGVXRLcU81VUMyTWd0WTR6blJqUUdxUnBO?=
 =?utf-8?B?bEhhNWliR0tpL3ZaVnZzVU5hZUJiYjJ1dzBCcGxXVmZCU3N5RlVVakgrNmNI?=
 =?utf-8?B?WjMvUG91cDlVZ0Z2TWQ2bFZCM0t4aEpOVWxKUW5MUDVrczV5MThjczVjdWFk?=
 =?utf-8?B?ZU9aeVVCR0o5ZE9tREtBZWNXNk5rMUhVWTBLd0xsc1VwWUw1YjFuUzJqQ041?=
 =?utf-8?B?ZlNHZTF5dXZFdU03YVcxUDAyemR2QXFJMkxjYUxaSnA0K3R3cHlScXhlaHN4?=
 =?utf-8?B?dTZnN1FlcnFlVHFFdTAvN1NGeWFhTzRKZWFBd0pZaDQ1MkpyS0VJNHBqRk9n?=
 =?utf-8?B?WW4xT0plenVUdlR4OUkvaC9kNGF1MXdqQTFyTFpDakNtWDB1OEthY0pTeGZY?=
 =?utf-8?B?NUJOV0JHdThQdEIzRVhkb2ZmYVlYWUIxS2dBbkRIM05hRkZ3M3VMM3JTTi9s?=
 =?utf-8?B?UDVHcGZBd2J0UGxsejRsci9HSGVLWm1SUEdKYVdNcC9kRCtONy9SU21hVGEz?=
 =?utf-8?B?azdoYUlqT3MxZGdUSnFwTkI3TkxmVFVrNFc3UE00b2VQWmRERFY2QUdDUUpF?=
 =?utf-8?B?TTJQV05CVStuUVlhSDBFK0hDUkd2ZUhhK3NGUzVlL0pBNGZ5b09LTEw5aFdX?=
 =?utf-8?Q?yzBt4JWBYx5abqo/6Z8X/ler8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ac180e-b466-4af0-0e1e-08de13145688
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 15:45:20.6845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zn6R3ePSly28WkhMBPTjfnBK/J7KkLO3E5wNFQrNYQL8rlLK3wIOT4x1vo2BCa7zXR438g4SgnFFRuS0cwfD4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727



On 10/24/2025 10:38 AM, Antheas Kapenekakis wrote:
> On Fri, 24 Oct 2025 at 17:32, Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 10/24/2025 10:21 AM, Antheas Kapenekakis wrote:
>>> The Xbox Ally features a Van Gogh SoC that on the Steam Deck uses S3.
>>> Therefore, kernel support for S0ix was previously absent. Introduce
>>> this support in three patches:
>>>
>>> 1) Add Van Gogh to AMD PMC driver
>>> 2) Enable spurious_8042 quirk, as it is common in those generations
>>> 3) Adjust the Van Gogh init logic to avoid powering down the rlc
>>>      and tweak post init
>>>
>>
>> Just to be clear - there is no need for all 3 patches to go to one tree
>> or another.  The PMC patches should go platform-x86 and the DRM patch
>> should go through drm.
> 
> Perhaps someone wants to test out all three. I will resend only the
> first two next time.

It's fine to send them all together.  To your point it does make it a 
easier to `b4 shazam` the whole series and test it.

If the series needs to spin again and you want to keep them together 
just mention it in the cover letter that they don't need to be merged 
through the same tree.

> 
>>> This allows the Xbox Ally to properly enter and exit S0ix suspend.
>>> Perhaps it also allows the Steam Deck to use s2idle without crashing,
>>> note it is not currently possible [1].
>>
>> FWIW I don't anticipate this series actually gets Steam deck into a
>> hardware sleep state because you need firmware support as well.
>> But the drm patch will probably will help the hang that was observed
>> which lead to the patch you've linked below.
> 
> That's what I think too
> 
> Antheas
> 
>>>
>>> Currently, around 1/10 times the SoC misses the PMC hint and does not
>>> enter S0ix, so perhaps 1 or 3 need tweaking further. It wakes up always,
>>> however.
>>>
>>> @Alex: I tweaked the text on patch 3 a bit. You can resend it separately
>>> after the issue with 1/10 failures is fixed.
>>>
>>> [1]: https://github.com/evlaV/linux-integration/commit/5ab73e9069017aa1b5351f91513ba540ce5905fb
>>>
>>> Alex Deucher (1):
>>>     drm/amdgpu: only send the SMU RLC notification on S3
>>>
>>> Antheas Kapenekakis (2):
>>>     platform/x86/amd/pmc: Add support for Van Gogh SoC
>>>     platform/x86/amd/pmc: Add spurious_8042 to Xbox Ally
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 8 +++++---
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
>>>    drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
>>>    drivers/platform/x86/amd/pmc/pmc-quirks.c        | 8 ++++++++
>>>    drivers/platform/x86/amd/pmc/pmc.c               | 3 +++
>>>    drivers/platform/x86/amd/pmc/pmc.h               | 1 +
>>>    6 files changed, 26 insertions(+), 3 deletions(-)
>>>
>>>
>>> base-commit: 6fab32bb6508abbb8b7b1c5498e44f0c32320ed5
>>
>>
> 


