Return-Path: <linux-kernel+bounces-811182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24777B5258D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2031A7B13B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E80200BA1;
	Thu, 11 Sep 2025 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H3lbqGX0"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E071DD9AD;
	Thu, 11 Sep 2025 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757553048; cv=fail; b=TTFKxW0N9Nkn8Mi/7jzTndAy4y6kFqUd2RyHxMDZEw/M7jDtBB1RD6ZtPped8GYHdPTO0y+85GpCIvM1onYOvee1WMrj3J/OInf8ciV6uw+PXzeShrP2lHO96Q8/3ne3HnvvOsb681bpwsYj0dK3T6KTRUbhdSkTQeC9WT//V1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757553048; c=relaxed/simple;
	bh=jJkzJ83fTwUBS5Nd18aGC2eazpWulxeNoqXIwg5PYe4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iBi7zHBfZNjbW01xCFMYFuX3ejqo7MxzRmRmhx+rpB+SA0ZJOHQDE4L0dAsTVOIJaRZeEpAtAI69BPnbhRJ6+sAPS65eGdYPsygNmpbX9xriO9OKYkQhUUVoST619qBFCp7vX3J4/F0gKz/n/Wx5+fuSMgjC+GAv/bwzJPwePdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H3lbqGX0; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVQAPSh5TZz4907lrChMDTwWwiSCA9yHzcvS3CpspanS5dWBHnJ8DWiN/NSaiaQbkvqk2WBIjSzdHDXpbnpOqaNamq7sZnarEa81PLbXXAFDQlEwx/bB9+coeD/0W8VL0U/HLHQFZImLxeZA2InvwJfFEAvNHLP7iMCq0xOg0jy7U9uRwnHXW8eKrEutOsc30SOQiuimHRVPJtCHS5mUML3rufhAgJPJrQxKTxcMQcsNyZeKc7kMRqXuEPhJ3PVROxvFUH0+fTMwgogil9/ifjLGTjVK3BrpC16BJuZk0tM0ovF0ScCx+baxwTtclNzwD0UuSd0UfJnCKqJjm7WS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRuMD3y9z1rOHmbuAVbtIZpm2V3wxG07x7SqQ2tJnYU=;
 b=X3Pf9EDmo3olp8ys+au0yoJWctRPAJNBHUnN1mXocigAn2EHaOJWnFd1R9TNHiFtYx4/AOmStUWHZrBwt08+75d2XL1cRJsKJ8lkko+mETv+EDhNLEiJ2i0ItyhsV7+GFlyaZ7EewdwoPHlk8iwzhrnC8RYxYYGut8SCmP9C54KuQulc8v9lIxUjudcfEp4E9LgYcJ3Z8RvWxxjS4GECsmD2/7rz7FgEfFCUMEP7yvvg9sNwN1nL2DcoFzljRf4yZ0bCDjU6BEGqgB+ADa31wvg72yqWsIJXehGmlPF28EotVESuaVuJMB2PZJ+41SP8HcZSD5/zIl7zNcA74q5REQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRuMD3y9z1rOHmbuAVbtIZpm2V3wxG07x7SqQ2tJnYU=;
 b=H3lbqGX0irNhW5bUnIWccAu++vWp/TGbKtTBEqjUnD42/fnggkHbGDEOFx0B9yF0/mRGzILwJLCQ96abPnunU0xxyhFhpgORWoccp32JbRLgdDEbzclB30rPaou9dGeXl7qZaKhpSB23Eun3riU23A+rDOpYVLBxlLckuIS+MmY9N85d/7YptBjozCR2ffm9fHDFkA0aBR/Aude4OXuHowKYhV3NndsKQY3ELUM2sNdhBtwcBxR+e6F/vgUFcaXUrltrmClTIsURLyrn1NcGfTxCzuGEaYI+luqz4kXLkhIMhCGI/ur3t9KZHybgKqeNtXxH9UOlzA9INwbtR8qOuA==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by MAXPR01MB4135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 01:10:38 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 01:10:38 +0000
Message-ID:
 <MAUPR01MB110721A2F925ED68E40695C8DFE09A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 11 Sep 2025 09:10:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: sophgo: sg2042: added numa id description
To: Han Gao <rabenda.cn@gmail.com>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Inochi Amaoto <inochiama@gmail.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>, Zixian Zeng <sycamoremoon376@gmail.com>
Cc: linux-riscv@lists.infradead.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250910105531.519897-1-rabenda.cn@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250910105531.519897-1-rabenda.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <e1ccd383-87c5-4a82-966c-51d02c4ab56e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|MAXPR01MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: cff1c4fd-da44-42a8-2a21-08ddf0d004f5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|8060799015|461199028|5072599009|6090799003|15080799012|19110799012|10035399007|53005399003|40105399003|3412199025|440099028|41105399003|12091999003|56899033;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0tEeElDbGNBcE41ZjN5WGNNdHlGdXFZdDUzZlkyTXYzSVpUdGNoQmdHR2l4?=
 =?utf-8?B?S3RvTVdDaXZVdEFzdnlvcnlWRlpGck9yVzk2UWF2SWtwc3ZsY2puNjQzQVJM?=
 =?utf-8?B?Mk03bnJHajlWYVhoNnUvRXA3UDhSYXl0ZDZaQldoWkEzelNLRUM3UWZHbm5H?=
 =?utf-8?B?cjBIVjM5NzNjdCtQOG1oa3BnTUVmL3JiTjNzckQyQjJNZm4zNjU3N2trVHJ3?=
 =?utf-8?B?OWZwVE1OQ2tDZEN6dzhMNkxMdUhDRzBPMmtQWGJSRkhya0hUbXZzVmRWWjVW?=
 =?utf-8?B?Z0QyY1BwRDhoQ0h4dFJmWnAwMWtjYThicDFZcXFUMG5OTGttL3BkdDVSZEsx?=
 =?utf-8?B?S3FhdUtJYk41QTRFME5ZQXczbHBJSXg3UFpjRWluSHg0MXE0ZnpJTDlQa2ll?=
 =?utf-8?B?U3dzUXdja1hsdE5JNThSL3I4NlFWMXVvd3NCWXg5NnNSZ3NEcmQvY2xGNU5S?=
 =?utf-8?B?amZMbXhFK0NkV0kxQjFSWGUwdi9tR0JJR2xmVTl6dHFKMU04d0Z5T3FpYkZN?=
 =?utf-8?B?QUd2SklQNEkxa0crNUpRSzZYeVduOXk4RjNXVHoxMzZ6WExxdjR0SVYxRHNG?=
 =?utf-8?B?a1RkbHQza05acDhXTDg3RDNCOWYzSDYxZEhuaG5jUERMODdVSU5sZWY4UTNx?=
 =?utf-8?B?LytiaUEzYXdoRkxVVFVOVm84QWI1OXg4aW9UV3hVYkgvT2FCdDdIWUtkYUc5?=
 =?utf-8?B?ck1aTVF3a0xGQW43WkFoV0ZGTDFZOXpNZTQxdWpFV1B6TXpSRE0zKzcyOHBY?=
 =?utf-8?B?cXg4VjZyTjQ1V09zOUdPeWw5SmZyS1RSK3hsQVRnOTdyM3V3WnY4cmpHZ2l0?=
 =?utf-8?B?dnBmUzg3ZGVPd1ZGdmJDWW1oL2s0dXA2V2lYOXlwS0Z3L3hqRnpKdWRQaU5U?=
 =?utf-8?B?Q1hvUkN6TXhCa2tIdStJM04yN01LVVNZSVVxVllkeUZVaU50UXdEUEJuWlRG?=
 =?utf-8?B?eWQyNnJUQ24xKzd3S1kwNVYxTVQzRUV3YTU4dWw5eTNzQUFoQ1g5dGxaRWZC?=
 =?utf-8?B?N0R6QiswckhaNUxtVExLWC9jUHE1MkEydTBGUUJvdnFSaUt1K3dMckNkU3li?=
 =?utf-8?B?NGtyYVpuOFE3M1pHY3J2NHhUbHY3VU5kYTN5Q04wbUVoVE92amxibU9mTmFa?=
 =?utf-8?B?b0lwMUpYQnI1Y1ZaVWgzT2xVZ25VNE5RVW9YZnRHM0cxQmVpRlVzaDc4blNn?=
 =?utf-8?B?d2tvN1Iyemh2K1Nycmg2QnR0KzkzMGdXS014ZjhLR1RyZjBRRWhUd0JjMzdh?=
 =?utf-8?B?K3A1dnlNbzU5SUJBc0tTQXd1WUQ5WG5hL2h5dW5HNXV4MEd1ejU4OTVoZFdi?=
 =?utf-8?B?WjRjNEhoTjNsOUluSTc1czFZU2tpMVJlNnlnaFNxcEk5cjdmYm5sOHlXdkVo?=
 =?utf-8?B?L1EvZ3BTd29NNTk4ZVliZEhYWEtacUFZS2hzYWxLREY4aXZWd1RxNzBlTU1D?=
 =?utf-8?B?Y0NjTGQyWGZXbmQ4cG8yeSs2N0dQTEZhV29OSGI5RlRTa1pGekxqZ2NzeGtD?=
 =?utf-8?B?ckdqclIwanVvSWF2YWFveHVFYWJYSnNGd2VNR096cmhmRkZ5ZTEzR1VCZjlB?=
 =?utf-8?B?eDVObGxyUEhtTUxrenJYTW9Uc2I3bm9xNVNUZ1lGdVd5ZVp3RFBDdUpTbXUy?=
 =?utf-8?B?SnBKRWZvbm8zOGpzaTIrQTJhSkNnREVHRjFVTk9rZEVmREVyUFU4c2FaMmhn?=
 =?utf-8?B?aks0eVJOWkRObjFZQzN2S0RBQkp1Y2x4eUt0UTdENlBaMnBRMHp2TXZyYVdh?=
 =?utf-8?Q?l9mI4Kml9sen5z3ikc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cksrb2lQNkg4czhsV1RyQ2t0ZHdOVzBkTGxIYU5ibmZxQUlyRjI4SzVUQ3VE?=
 =?utf-8?B?M0d4Q25YdHpORjJPKzdFbm9XazRic3pBU2diQmcrQXFuR1BldmdEM1pRRXZ2?=
 =?utf-8?B?VFBoa1h3WFdrSVh5ZGNIdnlWb1oyeUlQYklNWEltUEJ2MVVZcDdLa1FJc3NM?=
 =?utf-8?B?bjREbWIwM0wycWxNUWNhT2h0ZHJaM0JGQjBNNFFXd240ZXBkL28za0lYdkxa?=
 =?utf-8?B?WCtMa2N0TVpxK21vdHJzNkNIcUE1SHVKdmNpTzBOSW5vM3U3S1ZobmowWnVF?=
 =?utf-8?B?elcwSWdXOVVjTGl3dVBQKzdFblI5SGxrdnhFSEhOQngxc251d2c2Uzc5bVVV?=
 =?utf-8?B?SzBxUHpTNzRHSld6Zm1Rb1RoL2hEUkE0OVhBajlCQTNtWVNOUWU0TWhKQmVG?=
 =?utf-8?B?anAwaktBV0ZyK21zLytUU0hSVlJ3cWJYTEpQNHB1YVhHSVBJQ2w2ZlZmWk9Y?=
 =?utf-8?B?enVaY2dZdXN5QXJSdUoxYmF5TXcyRGxLenlPeURZNmV0TUxLcXBxWDhMV2dH?=
 =?utf-8?B?Znk3UlB4dWVFWkRXY0l1NFN4SGxhUnVMc2hoV0oxeVRnNkoyNm9jQUM5Rkda?=
 =?utf-8?B?T09QU20xamxWWnQwL04zdWFtOUJXL05GNXFqMlYySHlvblg0VmJSYW16NTI5?=
 =?utf-8?B?eHc3aW9oZmNSWmEyQmo3djI4Ymgra0tYYWp0c0RFcm9RS0FWNGE1SHJ5bTM1?=
 =?utf-8?B?N0phcFNCeDVacksrOFRHUmZzdEdMYTdFcG1QNDNOdGdRYW9HMUhhcFJRUy95?=
 =?utf-8?B?dVlpemV5UzBicXBvZUt2OWVWMUx1ZTBvcnlRTFEzbUpqTGdaNzB6VlQzMnh5?=
 =?utf-8?B?RXFwSkR5TjVtb2ltU1h4ZG14QTNSbmdoeWJrNmRVdnQvMkcvOGNWSVQzVmV1?=
 =?utf-8?B?WWZVVytRajZibEN4NmxmdnpWUEQwUCs4c1NsTkVjL24zdHhNRFFIdG9hSENp?=
 =?utf-8?B?ZG5xTmloYkxHWDREZmJkd090T1g4ZnhFMEJ1NUJheFFGU2dISEh2Nld4U2gy?=
 =?utf-8?B?dlNJMS9ud3YxaVlpbmZ3aW01TTcvamVQZWlUQnFDNFZ3Vmo4dVFSRmNVRWpY?=
 =?utf-8?B?ejl0RkhFSHd5NkF6MW5paEsxdWdiQnFyTDNpTENLOWFGZ1BOZE1lYitidWgy?=
 =?utf-8?B?UitRSVRCcWRUTHJKZ01LWitKNm9kNXZ2WDJnUnhzUFhNclBTVVBiRGNFQXNO?=
 =?utf-8?B?Y0xmemRuK1R1TnFRM3RlNTNQKzlzYUx0eDZCT08rMHcvMDdydWt1VnhLN3k2?=
 =?utf-8?B?NE0vS21mQU9ucmcrT3M2ZlZ5N3BYY3dVa2J0SnF3T2I0b0xiNG5ZRmNlZGlz?=
 =?utf-8?B?dFFRSkxsclJIYXdkZUM3T2Y2TzQzZmRaMm1weGVGMlZSaytTTEZ5Z1hWR1RJ?=
 =?utf-8?B?Z1J1L09jaEZ6YysydUU2MzZEcEpkZkl4dGJ6b2lqck5QQmJ2QnN5dE1HenZL?=
 =?utf-8?B?S3ZLd2FDSUZ6aFl3V0MvbUZuc2ZXV3ZCdXl4dDlseUZNR2pJZm85ai82Ukh4?=
 =?utf-8?B?NkhOUnJXZjN5ZzgwTmNROUJ6V1hyTTF0VUt2UlRlbjRxSmt1SDJOZkw4TERa?=
 =?utf-8?B?WkxTcm90MkJWSWdpQjkvT0g4MXFqcTluajBrQ0N4c1NQUWc0Rlg2djJBZERU?=
 =?utf-8?B?d3Vpd0lMZkNYVGtsbEdiRVgzMzhmSWZnMW93Yjh6R1poWGV0UklMbk5hMnlm?=
 =?utf-8?B?SXVzREI3TzhybUJObXI4QTNZa0g4RXZWVlFQRHBVRHJMYlBkQldEb0ZubUxj?=
 =?utf-8?Q?BHiNHjtDWppMHJtyl63q1KpuRpbPJIBaYTVp3EO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff1c4fd-da44-42a8-2a21-08ddf0d004f5
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 01:10:38.6974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4135


On 9/10/2025 6:55 PM, Han Gao wrote:
> According to the description of [1], sg2042 is divided into 4 numa.
> STREAM test performance will improve.
>
> Before:
> Function    Best Rate MB/s  Avg time     Min time     Max time
> Copy:           10739.7     0.015687     0.014898     0.016385
> Scale:          10865.9     0.015628     0.014725     0.016757
> Add:            10622.3     0.023276     0.022594     0.023899
> Triad:          10583.4     0.023653     0.022677     0.024761
>
> After:
> Function    Best Rate MB/s  Avg time     Min time     Max time
> Copy:           34254.9     0.005142     0.004671     0.005995
> Scale:          37735.5     0.004752     0.004240     0.005407
> Add:            44206.8     0.005983     0.005429     0.006461
> Triad:          43040.6     0.006320     0.005576     0.006996
>
> [1] https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/pic/mesh.png
>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>

The subject of patches that modify the device tree are usually prefixed 
with "riscv: sophgo: dts: xxx". This isn't a big deal, so keep it in 
mind next time. If you don't mind, we can modify it when merging.

Others LGTM.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thanks,

Chen

[......]



