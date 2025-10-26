Return-Path: <linux-kernel+bounces-870164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD6DC0A14C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 02:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2E8C34BE55
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 00:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5E23BD13;
	Sun, 26 Oct 2025 00:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TmuypHo3"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798A1A23B1;
	Sun, 26 Oct 2025 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761438726; cv=fail; b=KOTergyBJ/72mLM8C3tvfpF7o8p+XEx0BzF0T1x/xnkaT5lrOJrVXstZo3mxEw3a8GCFcb9s0gLmv/EzjBQZtn5bBCldgsbD04LH8l1v2dhU3a14dxDHuNmzkJzjrUEk4YOtqDzE4+nbUUuOHtd77sZBWoHF8VWzXb2aOKLE2QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761438726; c=relaxed/simple;
	bh=mgtYPc5CzF6u9hGWeRyNDMzKZczzF/bDhYvAHhxTEkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CZiW0AaFqN6OTv9INDdeKiowpuZkQsf6PGJSWRkbQUZDNeKMI/AscckKhKDNbezWoenDhH5ffuKDGtU1kMXlq5Wy2aTttgPlcjb+NC9JNuzY55UC5uzJKLh9na3YKRK9l3Wv2lZgumwCuvk368sywPw0E/0A4TQ2sDoKxd+GYug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TmuypHo3; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCAvJKuaevzIvaK47u7kZ6nYqxzvA65cYJk/+3zRrKqi6V0oB8Ptr4Iq3Z8yghFiJfm9xj9LI3Ld7wicNDyN+TEUliGirV+qBdPJX1VzrWqOLd5CBFKPNCQDZQpFfUynKwqLSIDl+KNBRhQafNvljJY78Um3MFVdhhhUOAALwNCA0uYV/aUB1pBz5ydPC8EieBrFsBBxLk0qVJCe1uaL9WCRMZh4zKROU8brvICNMwJIWkP1XHGtVYGIr5D1dU6pGagUhwdb8ptbyVM+5tsR/0S7egFCbVZSzi5I8cGMX8udFliUmZKFHvh+DHX1S2xRjwSiYW9dGIYKu/Epzp33DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPVIv2sJHt9D9xFei0UQWhAB8AVftGHc3OcRi6tXNO8=;
 b=fjbbgHhE4jm9JWwnEjb9dAYUEodd6ev+wOJssMtlptUUp5TfwwHCM/Z1xfrpv7hrWvWLQ9JCGlE5oHhT2Tn3TG6G1nrOKs2ZsaEpx/sbvrE3PtDt0Wl5DGKfemdaYWbzhIPWhf8tbsTSYEdfccMvebrGf9gmi1uBUo+iW5MefbPil6Alt6P5DXHBTRLmmJa8sxmL6dFpjeX8Q6XKVQZLJ2maFUhh23Zp1LhDCh8v9KT+oGogoDObe5xflwuzs9V3dLl9oq34OIJYCiVxDAUFfM13AZAA3GgXog5EhTLX8LUiLRbRXoLGKSNFEDZ3aafy/+bZcgMMNSu07aFU42tcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPVIv2sJHt9D9xFei0UQWhAB8AVftGHc3OcRi6tXNO8=;
 b=TmuypHo3qrKp9/7yzAMtyURfpEk3wiQhPkxpBTWbsziSmnBI6ZqG8rGFePaTmqMAjc/mNe2NY9LdazgZRMiCAzR/C/R/gXqzAkn7TF4EQ7rISsnEootv2yFTN5zqBb1vXHUL7kxnIun/g17XHKRmrh7eluPR40ULDFODUxMxRCCm+NytK8MCL6CbWOubvD1FJTBVrVNrVuBq8cSOZT0yJOmke3YFWM4gz2fQ97zI8y2P3XSlAlr06LVRKzYPZ50SF2UK/BKPkUWDv0BG/HnGg7xoJ9qf1aFwFWwDzllojKRgOMrWlV+BQWOF265GIYzzlVYy7asA+bhsnENEwaBcCg==
Received: from PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2f1::8)
 by PN0PR01MB9120.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:160::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Sun, 26 Oct
 2025 00:31:55 +0000
Received: from PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2e35:fc95:ee3:bf0f]) by PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2e35:fc95:ee3:bf0f%6]) with mapi id 15.20.9253.013; Sun, 26 Oct 2025
 00:31:54 +0000
Message-ID:
 <PN6PR01MB1171739409EDE88BC4453D09AFEFFA@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>
Date: Sun, 26 Oct 2025 08:31:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add PCIe support in DTS for Sophgo SG2042 SoC
To: Han Gao <rabenda.cn@gmail.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, conor+dt@kernel.org,
 inochiama@gmail.com, krzk+dt@kernel.org, mani@kernel.org,
 liujingqi@lanxincomputing.com, palmer@dabbelt.com, pjw@kernel.org,
 robh@kernel.org, tglx@linutronix.de, sycamoremoon376@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1760929111.git.unicorn_wang@outlook.com>
 <PN6PR01MB1171791524E2BC1C227E342F6FEF5A@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>
 <CAAT7Ki_4nkKM1-D_8ybwusxTTsR=Lf09v8Cx6QDWfuy8KLtbBg@mail.gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <CAAT7Ki_4nkKM1-D_8ybwusxTTsR=Lf09v8Cx6QDWfuy8KLtbBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2f1::8)
X-Microsoft-Original-Message-ID:
 <f5257198-2f89-4987-82f7-7173b4a9ce71@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN6PR01MB11717:EE_|PN0PR01MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 82953710-e301-45c9-710d-08de14271034
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|461199028|6090799003|5072599009|23021999003|15080799012|8060799015|3412199025|440099028|41105399003|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1k3VGQvbzNzeVVVbGxsdjd5T3A5UmNtSlJaQ1JhYU5GSVZUM1o1QzhoRDFC?=
 =?utf-8?B?bzhzWUNOcUFVZWJCYTIzMS9EYTZLSStkZ0dOS3F4N3labS9kOVVleHRYaFk4?=
 =?utf-8?B?WlZIbC9KWHgyWllxRnI1b0UzY1BuS3pzVlhVeXFaay9SUTlzMmdNVWYyNnF5?=
 =?utf-8?B?K1ZWOVJ6VHo1U0kvZXk5Q0hyTXF1Y2x3LytraDRjQjV3aDZ4YzZsK2psaG9L?=
 =?utf-8?B?NHU4c01EN25meklpM3poZDMzTGgzY1VyZWhONzhzOFl1TW9XVlMydDRtV1FV?=
 =?utf-8?B?RGVZSlV3QkZYTFJ0MThaRk53cDdURVVKNUUzcHpzdm9JUUdMcGIzd2txWU5L?=
 =?utf-8?B?RTd6OTZJUGMxUTJ1VlZmSml6cGk5NUZYek5BQXBGRFhxNXpGZm5ycEdMOFpY?=
 =?utf-8?B?anR4QlZadGNmemJEVzR5bUJxZ2lkbXJhM29sa21YSk84MmQ2K3VoVGZqT042?=
 =?utf-8?B?dVVhRis2Tk82OFh6VWRRV1BhcDhuMEYzanEycm14UDZ0Um5KalV1ZktuYi9y?=
 =?utf-8?B?S3NUWjdheDZMSmttR290c3RsSVd3SHVXQ1FjWnRKaVlZVENCK3NDSXMyVis3?=
 =?utf-8?B?dHlKSU9BMGlyc3NVYThvMFUxTnBvbVlRdS9CZU5EanlRVnpieXFraE9pbG9Z?=
 =?utf-8?B?K0xlZkNnbWxpM2duNEsrMnUyL2QwbTNZNER3dEZ3ZGtNSE5SalJtRUhtc3Nx?=
 =?utf-8?B?dGt4ajAzdHpFSHppWHBQRFRRb29TMG5VOW96MHlPeUFRQVlWNnJjKyt3UE5U?=
 =?utf-8?B?SzNQbFNUZlBlQWZreThVWEZRaVIwVjQ5Uks3ZFFUS0ZlVVJBL3VVVE0vSW1x?=
 =?utf-8?B?dkZ3ZzNFRExkbmNNNFRzczB4WThsN3pDbG9STHlJUjFMU0dhNVBGbmt0Zi9w?=
 =?utf-8?B?MVR5OVFVd0ZiNnNJQk1uZGJLM1lqeGFEV2I5T09kSGs2SUNWam9TVk5yNGtr?=
 =?utf-8?B?QWdQbGdBaVlYZWZyaFpoeURZS040ODdQanBsV1FLR25lQktQZVhUTUJtMXNh?=
 =?utf-8?B?bS9oZExkSzZZU3VKV0lnV3E0WmNja3dBekFLcm1aTHF6ODc3N0xUbEFvQlBM?=
 =?utf-8?B?bUp0cFhwTHYxbGpyU3JzMjJlZVdrTkVGaEJCWDI5Y0hGeEFleHdHYUM4K0FS?=
 =?utf-8?B?WjYvbFJHd2k5RXZCMXdPTG1HSkpiV3VrL2VVRExSWXo5ajZkcURlc0srN1hL?=
 =?utf-8?B?aE8yNzd5YkVzd1IxWEtWeUpaVnFtMWhNaGlKd2dqd2VlckZuTFR2dUk2ZzRn?=
 =?utf-8?B?S3lOZjhFMjByQUp2a2NnaXE1cExKR2hNVWJmNjVXYURVUHRrRHJMQVcrb01p?=
 =?utf-8?B?STRYa09zZm1tM0pYWHV1T2lvK1psbFVLbnpCY004OVVOTkJvYjZ2Zm5Pa01m?=
 =?utf-8?B?cHpmMWFaaWRpTmIybnhiSEdXMmJ2VE4vbUNNQ2V1LzgxK2FJaHZhTkpsUnBW?=
 =?utf-8?B?Y1lNL1FwaTd6czBJK2kzUks1YzM3d3k5WXVjc0JCRWZJQVlFbkpGcFFYMUdL?=
 =?utf-8?B?TW5ZVUNsTktlR3lXUTk1VVZ1U1BRbW5IMzFzQTJjTHlGenIwTmxBY3JWV3d5?=
 =?utf-8?B?aE55aDFPVWQ5MUVhV1RxTXF2MGZHemtZdnJmbzZqbkkyblkzNEV5bXpwOGpa?=
 =?utf-8?Q?wCylneLYx3G/rB5iZ1Ld6urz8VL+eabLKmt2MMlwngys=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dy82eFNZR3IvNVF4aGJmVTZxZmp5cmdJV1hIQWQ4c2ZpMVFzeFdlbTVsR1Vm?=
 =?utf-8?B?YTR5YXBtWVNsdEswckFpMzhZUHNTZlpBY0lVbzgva2xwZVBIMVdNTkM5MUdo?=
 =?utf-8?B?VlZFSXVlSWdFZWY2VXM5WXVIekZiU2FkWmdkZUFsRmppcjUzN2FRVXJBNUJp?=
 =?utf-8?B?aXBxWTY3aWttWG5OMUpDQ2MySlFvbFc4U29mQ2hmTnFWSDNSam5VMHU1ZkYv?=
 =?utf-8?B?L3hIZXZtcmpNZzBabjNvK2p0Mk5TOXMwcnAzN1pReWNSYThOdnFWWEpYelBk?=
 =?utf-8?B?TTlHVUw3ckpxOXV6b21aTkJHeEVlanJzUFVqbXV2ZzdqZGZIN3FkSXM2eW4r?=
 =?utf-8?B?K0Izc0piNGFkVzBnSmozUnNQZlY0bjBHTzM3d0RMa1lLMFpBemFKeHg2alhy?=
 =?utf-8?B?U3pheERJeENzQ2VicTlXcGhKejZ4TkhrdjhtK3dVeklHeDY0SWUwdlNXQnpX?=
 =?utf-8?B?dkQvQTYybGRnMnZtOTRpQ0czTThMYjhDVTlGRkw5cmR4alFzT0hTRUI4UzlN?=
 =?utf-8?B?TjByclpkdHFCZU91aXpRTFRuTGs0K3phMDh0Z1I0dk5nUzlsR1FVby9KS0hm?=
 =?utf-8?B?eDV2UDMyaHdUa1lWdTRQMTFVd005R01CVTNnWGFxOHdoQ01LR1liMlpNL3dD?=
 =?utf-8?B?aGFOd3NSbWlXQUpTQkxyT29aK2NXN21Mb0s0ZjBFaVpEeHBuOGYvY08xNy90?=
 =?utf-8?B?SHlWbnlYTEpNRVk3VTAyT2JNRytQWGFZY1JSU3dneFY3R0M2THpLZDZ5bjVX?=
 =?utf-8?B?dUFYL1BmQ0FHeFlGRnVuTEZQMFhIeTgxdUwzYy9RWEhoaUpPQSsxMnMyajg2?=
 =?utf-8?B?VnJPQUJvVkIrYlZTQXpScVlaclpBRDlRQVE3akFrQ0drRFRSRlBVb1FFOEZS?=
 =?utf-8?B?Y3dCdFpOMDFJbERMYWFJa295Z2k1Sjloc2NDL2doYVRVSjgrUnByV2xRK21F?=
 =?utf-8?B?TFRhMDQ0a0pvWkVDY3VVRmhwQ1RCNExpVUxtc2V0SkZQVndpZW51ODZIWHpn?=
 =?utf-8?B?eEt2bEpZRUorYXZUNXp4M0pPZE5UcWgvcVhVTXkvR1NzT3lyQ2xtb3UySlQv?=
 =?utf-8?B?aTRpOC9RR1FOd2RaTmRwdUlJMFBzZlJZbUI0MEFxUnZJeUFxMXVzVlRHQ0Vt?=
 =?utf-8?B?eU9TeW9FeDdKa2FDa2FhY1dEM3BpTkdsMjZQaGQxVEJTUkNQeHJ1ZHVkZXRr?=
 =?utf-8?B?UXRjUkx5TDE5TnRkRmVJNmZSeHZJVk5rN2hFMXZMQ3VTR0FoSU0velgwQ0tK?=
 =?utf-8?B?b3YxSSs5Q2ordXZsU0VQZjlPbkVlUC9KbVBiV1I4RDEyei9NTVZlVWZCd0xO?=
 =?utf-8?B?ZS9lVkhsWG1Wajl0Uy9iR1QxRUNqRjFySWdsRnd0TVlEbmVER3lmakNIOHF6?=
 =?utf-8?B?M1g2UWJ3aWdWSWowSXRLcWNzdUNFU1RyenVXeHRUQUs0MCszZTZ1T285OGFS?=
 =?utf-8?B?clFZdFE4bXlhN0htMGV4N01DNFF1OWZVZnFGS1IzRjNZMlZEaVBTa2xtb01U?=
 =?utf-8?B?d3A1R1FYM0JPWHdPSFRhQWUvTm9WMEZsY2Z2WXovc09GOVVDOHp2N3ZpTFdi?=
 =?utf-8?B?RmZYRlY2eTRPNDZESGhPQklWSFhDVGZGQjF1NVJJNUN4S1dVVzFiRHdlYU1E?=
 =?utf-8?B?QTJ3ZlpGeHRJeHZnWkhHTmp2SUJvYXBjejVaeGN4WVdBNW1iS1d3MnUxeHF3?=
 =?utf-8?B?N2RhY21aeEl6allrQjZOd2dOTUp6cXVPSmFSTFFic29tdEEwUjNZT2c1QU1B?=
 =?utf-8?Q?j2JWWkRaophmV4xdxP6cuLlfRAyYI9RIKt+j3dP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82953710-e301-45c9-710d-08de14271034
X-MS-Exchange-CrossTenant-AuthSource: PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 00:31:54.4872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9120


On 10/25/2025 7:58 PM, Han Gao wrote:
[......]
>>> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> EVB1.X/2.0 can be started normally.

Thank you, Han.

Inochi, please add "Tested-by: Han Gao <rabenda.cn@gmail.com>" when you 
pick this patchset for next.

Regards,

Chen


