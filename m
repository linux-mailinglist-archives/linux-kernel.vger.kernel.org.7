Return-Path: <linux-kernel+bounces-777089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB50DB2D512
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7B85E6DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41B2D8368;
	Wed, 20 Aug 2025 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z47eQTdm"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45956256D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675621; cv=fail; b=UWURX9A5ekwE0mSfLg/lwbZxtilYqnZxoz4enCVe/+Mkj/1rjGDXrL4Vi/mbvAYkHaos+nVdqRoiNFYdI4ItzhklcpdUFQBw0AsKZcCKTdG/9l1ZUvLWW3u79duWxAL9bCSk5qvnEPWH8zrvzvz7ID+9sEeNvV3VRD48PQvFcmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675621; c=relaxed/simple;
	bh=JfXNf+hv1AtlASHuFkfcqOt2Hzu8yQBY/3A+govCMq8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jmX2w7nU6lYp+tWY7Av/pnOHsntqKlPqvj0F+Ud33fvT8dlIgBQewSZOVYOJbWohVzE9mLipSDBXlr3qi/gmgy2LWNjng+Xr4jRvQd+VaARGYitBPkVIFcahBluqLkEkg94B84K1fw0wHkR9DPuOHLeUYAtygpgk1ATu0xctXOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z47eQTdm; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odUOU89t6Ay5iiHn3tKP5DLA3/jiiV2Uq+aazrgzKQQWQcylt2hYV32WEA2ceFNBc/hK0/ZhRYGH4Xo5Cno9Zg3Sl0AMUr49JZEBjFc+WwoyqdRy4rsPc7TrgzycRpULTUlr6r9ymQi335iXFwm/COCOxgGobCWUynjVRK5uxmahormFcAOw3UwwX1K0V/tx7sAoi+rZpUZ8FWkhLY+TzDnfLdH99vnnaYwao1mbJX1pVcGZJ6jfzTFTCvB1zWQqAGfIaesgev+xql9YssR5rp0RpoNFzW74uh8958dgTgbAMNHJmGqTJ1qzjNgRPfM0Efd/yPOZ1EbkdIEBon0/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv8g7H817Odc7kqOetZBQft60Gs962bRKA6L0NjFxHo=;
 b=TKt/g8ym6Fw2RZfW71trg2J9D6rhwVCJjoeBA8Vox5i+JylCAtXrtyw2d0GP/jJ+mpl8kWPyy2Qly68TcAgyl03ImHNPdbzeQjDLTVQqEP5ZdwLKlYC12qBMTwXTxrm497PsvH2zc46zcLWPcXJVZ8XV+ojyyjCOY9H/O9iwf643EPRIyECOOonGKxbI9B+YTGedifcKI2Jfx506oKUEr0CpEe/xF1H8Rcky1VpcekwTk6wJoVBPlBK6t0x7FgLjEFESOPBjmBrs6xiBtwv68qTxnVvTQJsdEJSPGjqcr71VofG1hdwo3xHIPObRkDmiEnZVbGFZWSq+7/QVlE2eJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kv8g7H817Odc7kqOetZBQft60Gs962bRKA6L0NjFxHo=;
 b=Z47eQTdmlmNq4Qz29geOfofo/4Mbf4TZxFO/glD9lb1pC6iU7ubVOxhqhNoyX5Fbwx8SQD6zRCUxGacaIbSGItJnRW8qpMIFwQCs+E6apEq1iG1AjuB9uXqU5b/sRRI/mE/+aEx/rPUhaylloc5eTEWK3cSV5q+Q7HsFnB0B6K9n13eJ3aoOCohvBEBgkEIzKM92jcw8ANkb8223Y6/BDVDbGRbVaTcam3UzGt4aovbNwYiWedHwhsfvEdTeZQwVxAdm73y3QmyXdn0zE7PVUs6PZ3X5F67nEh6RCCk4rEkUtcLo5r/k6k0j3JsDSNPmRxpasMorGFjj/NoEz5rm4g==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by PNYPR01MB11748.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ed::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 07:40:12 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 07:40:12 +0000
Message-ID:
 <MAUPR01MB1107281F1A920C6DBAC30CE1CFE33A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 20 Aug 2025 15:40:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Affinity setting problem for emulated MSI on PLIC
To: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>,
 Nam Cao <namcao@linutronix.de>
References: <20250722224513.22125-1-inochiama@gmail.com> <87tt32r082.ffs@tglx>
 <re3qxwkm3lu7o77kyfswwennqvtpyonlj4zajt5eu7z5zwkosr@mwacqq6bpbk4>
 <87frelrgn6.ffs@tglx>
 <qy6z6ym2rje36vgt6az6hkubsaeenicsu5ouxwbkuwml2inib6@qvz66lad64h3>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <qy6z6ym2rje36vgt6az6hkubsaeenicsu5ouxwbkuwml2inib6@qvz66lad64h3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <236be1b9-58a6-4d4d-9faf-9cbd38f63162@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|PNYPR01MB11748:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f79b86e-4765-41f3-a0e9-08dddfbccba4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799012|23021999003|19110799012|461199028|8060799015|5072599009|56899033|1602099012|440099028|40105399003|39105399003|3412199025|4302099013|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXl2QlcrQU5aOFpwdmpoRno0TExJSzlOUG1rdk41bnZoU0Jqa1JnTTljNmVl?=
 =?utf-8?B?VjAyL3pLTGlVT0tCLzFDOEJqMHExdzJDNy9qR05VSmNhQVVlZkg5SENFS1dr?=
 =?utf-8?B?WVBHb0xvUmo0QXFRRmV1aHRzZ0cvWC9vR3dqd3Vyb0pETWdLemt6RGJ4ZEV4?=
 =?utf-8?B?MnpwVTJIQjNyaXR1bzI2ejluRk9XaHZWQ2pjL0ZVeFhrbVlPQ0lqVnlyWjZD?=
 =?utf-8?B?cFhzUjBoY0pVMGhrTmFXM3ZTM28wQ1NSdjl2QkRvQUxEL3FGS3ZZakJVVnFp?=
 =?utf-8?B?MGRYODJuUjFSVExaZTFXckZnMitMSWc0OUpCRi85T1hEUVNUQ0drUkJ3cjFt?=
 =?utf-8?B?b2JCQUFEd3BvQ2x1SXZtQ2kzTGM4bElmUytDM3d6bGZiMFc2TmZMOGlpaXpP?=
 =?utf-8?B?a014WkhQS3M1azJOT0FHczhhcGVIZHVUZFh0S3FXbU5JUU1XZlhoNm9BUmQw?=
 =?utf-8?B?WkFKYURVeWw5MTNMbEs3a2NFTkcyMXl6M1NEMWNaTVJtQmU4d3RrRGplUFN5?=
 =?utf-8?B?Y012bG1OeEpGS0dIQmZoWUdwSUJuMzNybjJlalk0VkVhZ3lBU3hOeDZIRzQ4?=
 =?utf-8?B?VExWUUJGTGRtOXZ0RUI0UnZQbzd5TUdUbTlVdVlDRUw5Skdqb2pvQVdWd1pR?=
 =?utf-8?B?ZWwvYVdSc3RQZnBNaDAwOGZ6cGpocFAzakJhZFBHUDltVTNhSTJJNDV1U0wv?=
 =?utf-8?B?WW40VDNUdkdiTFBFSzRQNE9rVXowOHROMUFkWUlLaGVnWHpXUGxjR1BZc0xo?=
 =?utf-8?B?Y0lIb2JRMXVCYStUUG9nL0hyb0VBTXVsYm5VaFRzaXhQNjd5bS8wQlhBbldM?=
 =?utf-8?B?b3JiRFpnWUxYNUFYODFkK1I5cDl3U2IyTG55RjYxaFdYKzlGbDA2aHZvSUJK?=
 =?utf-8?B?MTdrWGZnQThvdG5rZFN5anRUMUczeE5udG9JQlhYSWpxSHRtWG9MeGVJMU1P?=
 =?utf-8?B?bEJ1Mjh5U05aVmZLNVlQdVl5OGVjNzBMcG9JWTdlZzN1czZRanVQT0ZJaEF2?=
 =?utf-8?B?RmZPUzRJZU1pVzl0dDF1d1ovYlVnQWlabDBwbmYvSDJtaENzTkZja0lKRjN3?=
 =?utf-8?B?emJYMDhtQWhSd0grMDRsdDd5UldoZnM3RVd1eEJDZ2RQd21KM0RwQVdnYUVB?=
 =?utf-8?B?bkN1MTBQTXpHU1RHWVJUZTBHZ3VJZnNHaE1lUWxDNVhWL2N6TWdIY0JrVmdB?=
 =?utf-8?B?OU9XVjc0YVJ5dDA4U1dSSUJYR3FOZWRIQjVlT3hVVGtjS2lCemMyVDJ6akhB?=
 =?utf-8?B?Y09vY2dYcWIxM0pVTTNwLytPY1hBekRyWFEvbDNSMmtRa3YzZHdtOG9SOWlZ?=
 =?utf-8?B?R0QrN01kK0FIZm9ZcXF1QUJXeHpJcDZra3NTcnRiRkZXV0JTdFdJbUJqcWk2?=
 =?utf-8?B?dWl5bEFkaExyOUg5SjZSWUszTVJkeEd5c0FVTlliNzFxN1FFNzNKRTV0ZDIr?=
 =?utf-8?B?eG9wdTduKzZmTXB0Tnc3WG5tWEZSWGh5ZEJkWDNNWjliMXVqZlR0SHlMQUJs?=
 =?utf-8?B?M0E4bkZyU2QrUTRLQ0NpTTcrcWk2cVJvb084VUh5TXlhS1R6aVRNU2hFSkNL?=
 =?utf-8?B?TmxxbHRDdlNGMkpuNjJxMDdDK1dzbEpsenZtdUNyNEsrQjMwT3BINHIxZGVp?=
 =?utf-8?B?bXdXdm5jeW5OY25FcUdFY1ZXek02dG95ckk1czRGMHBNQ3F5a0NmZlNyUDYx?=
 =?utf-8?B?YUFiNTA2YVFBTDhqem9ZSTd3UUw5M2hZQ0xsRi80SitsRGxhNnJCOVFGZ2t5?=
 =?utf-8?B?c0VWRTB1ZnFrTHlwR3RJTTNZaXpRT2ppWThLT3ZOT3hEcFdIZlljaUF4cWZY?=
 =?utf-8?B?bEtiUWQ2d3FHYUdFcWIrdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTZONG1TbEl3MGZuSTR3T3p5cUFiOHV6cm5pVDErVHRoTDNnMEgxSDRxQVEr?=
 =?utf-8?B?d0FpQ0ZhcTlWckhDRDUrUVAxSnpTM2o0cjI4WEx4TG5qamdpVFhyRkl6blZQ?=
 =?utf-8?B?L0I0alFKTlBka3hBNHJIckM3MGNJS25FM0dIM0VCY2dOZFF4SHViZE1Remlt?=
 =?utf-8?B?SDQvRlRlREFwak9xbHJUelVqM3Raa3IxT2xCV0x2ZDNzQXFSYjBYbDk1TUEy?=
 =?utf-8?B?Wm5BN1dud0VEUVBxYVdsZENqR3BqaHVhRVBXYnlTN0tMcG1zcEJabzRpYjRr?=
 =?utf-8?B?VjYzeVZNUWlpdUxlVVNJN3Y3M3AvTVhxdjcwS1FzbWNIOWh5a0dzWGtZRWZs?=
 =?utf-8?B?aE9IRXUwQUxUOWlXMURZYU9tK2RGbTZoYW0ybHoyUUNPN1dqemsvOENYNzdh?=
 =?utf-8?B?REpsZi82ZDl5WnVIMUFmZ3FwOENTL3RmeklWbE9NdkFiRHRnUGI2VUl1ZnZX?=
 =?utf-8?B?S0xkWkVvbk9ETmxlbW1WejhicjF3SVdkTUlMTHpiYlU3Y0pxZUlBdEZOQ0Jo?=
 =?utf-8?B?ZVBjaWFKUUhRU3hVdU13Z0hsalcwMUxUWjQwZ1lBQ3VvakNpN1JKYjU4ZEFE?=
 =?utf-8?B?MDhZeWhYalNHRjc2amxGLzV5STNrWWJxTzhSbzI3eFFhanFrVndDbGhVL1hB?=
 =?utf-8?B?NXQzaU9CQ3A0bEt0UkttTnhtc0JWSWlObml0SndRYW1xS0tiVG5OV0xMcjlq?=
 =?utf-8?B?MXNBakRQZWJwN1JrS0NrVVplWm82S29qclZldUdYakxJa2ZaNGpBUGNwN0VJ?=
 =?utf-8?B?SVJzVnJWb3ZZZzVndXNEZk5CWmQ1bEc4NWs4L2pWVm01M21WUlRuU3RqRm9v?=
 =?utf-8?B?akhOdUxFMmE4cGF0UVN2ZEdpMnA1aG1pT2J3dUl0eWlPb0YyK1VGb01jMC9n?=
 =?utf-8?B?NlhneDNacW1GM3dKN2l6V1A0ZzBVcy9iOXNpNlg2VXVjR3g4RzVTNFJRMm13?=
 =?utf-8?B?MDlIaGJpK2N4RWV3SUEwbUNSUzhiRmRyeFdNV1NUQTVZUWJKWGUvWWovN3VQ?=
 =?utf-8?B?YXJpUmxXb1NJMG1BOGt0R3NHMnZ2TXVKVXZSUGhiVUhBWEFpVTBWNGlQdkth?=
 =?utf-8?B?d0orbkpzUlFxcjBPQVUyb3p0QlZraFRRK3pBbTI0dlljTWNDbXFNV2dPU01s?=
 =?utf-8?B?NGs1Z0dqUmtYVjlIL3d1NUhBaFV5c3c2WVBnT0ozcDBSZTlnZlA1dEV4VjVk?=
 =?utf-8?B?VEdtQ0xjY0hMQXlpT1U3N2dsVkdHTitwQUpBQTByRng0eXluaDhldmtIeGRo?=
 =?utf-8?B?Y2liaW52cG9uUlNLUndkYUFiakZnTVFObFo3MzJQZThibjBIM2s1K2hYNExZ?=
 =?utf-8?B?OUo0NDV3dDNac1VucFRGL1gxbEsyRU01UGpZK0JOVEkxclcyWXpHbVB2LzE5?=
 =?utf-8?B?by80dW5ScUFCVnNWZGVIRUtUMU1hUDNLcjRKV3lITHFnVlJZMzFOWXlOVGQx?=
 =?utf-8?B?akNFK09LeHdTYlA1ZTk2SXhOTFAyZmRQTm5UR2RKQmRXS3YrWTFIM3prV1ZU?=
 =?utf-8?B?cUdJZkNkbVl1Ukp5NXdpNW9Mazd4S2VFbVNBQ1cvNWlMclFpdUV1ZGMwMjZ0?=
 =?utf-8?B?dFlweStNQXZpWnpaUWhBV0VuMjFiMTNuQ0x5MDErVE1UL0RnZlZoOFVEb2xk?=
 =?utf-8?B?MXVsRkhQRGJvM0pkNm9JUGFsOVRSMy9VZ0ZlQ0lqYUFTL1JpLzFTcDRIWm90?=
 =?utf-8?B?WWNCNVBJOU1VSlhOYzBjQ1FqUGpGc2RUMldMaUIxK05WUjdocCt6STZmeXR5?=
 =?utf-8?Q?Q9qHhbi8rAO1PxJMDjK8h6C/9U73PZVO7x7uB8s?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f79b86e-4765-41f3-a0e9-08dddfbccba4
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 07:40:12.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB11748

Sorry for the late reply, I just found the time to read this email recently.

On 7/25/2025 6:25 AM, Inochi Amaoto wrote:
> On Thu, Jul 24, 2025 at 01:07:41PM +0200, Thomas Gleixner wrote:
>> On Thu, Jul 24 2025 at 09:34, Inochi Amaoto wrote:
>>> On Thu, Jul 24, 2025 at 12:50:05AM +0200, Thomas Gleixner wrote:
>>>> May I ask the obvious question:
>>>>
>>>>      How did this obviously disfunctional driver gain Tested-by and other
>>>>      relevant tags?
>>> I think the SG2042 pci driver does not support affinity setting, so it
>>> is ignored. But the detail thing I will cc Chen Wang. I guess he can give
>>> some details.
>> It does not matter whether the PCI part supports it or not.
>>
>> PLIC definitely supports it and if the routing entry is not set up, then
>> there is no way that an interrupt is delivered. As the routing entry
>> write is delayed on startup until irq_enable() is invoked, this never
>> happens because of PCI/MSI not having a irq_enable() callback.
>>
Indeed, the SG2042 PCIe driver doesn't setup `.irq_set_affinity` 
callback. After configuring the domain inheritance in the sg204x-msi 
driver, the domain inheritance becomes as follows:


plic <- sg204x-msi <- device-msi


When the device requests an interrupt, the sg204x-msi's 
`.irq_set_affinity` callback is automatically triggered. This is because 
`.irq_set_affinity = irq_chip_set_affinity_parent,` is set in 
sg204x-msi, triggering the `plic_set_affinity()`.

Part of callstack dumping is as follows:

[    0.941653] [<ffffffff800099ee>] plic_set_affinity+0x1e/0xc0
[    0.941660] [<ffffffff8009b576>] irq_chip_set_affinity_parent+0x12/0x20
[    0.941666] [<ffffffff800a2c14>] msi_domain_set_affinity+0x2c/0x86
[    0.941674] [<ffffffff800993cc>] irq_do_set_affinity+0xce/0x1c2
[    0.941681] [<ffffffff80099992>] irq_setup_affinity+0x110/0x1d8
[    0.941687] [<ffffffff8009ca72>] irq_startup+0xd6/0x10a
[    0.941692] [<ffffffff8009a270>] __setup_irq+0x51c/0x5ec
[    0.941698] [<ffffffff8009a3f6>] request_threaded_irq+0xb6/0x160
[    0.941704] [<ffffffff8060bf22>] pci_request_irq+0x70/0xba
[    0.941710] [<ffffffff80902354>] queue_request_irq+0x64/0x6c
[    0.941718] [<ffffffff809034c4>] nvme_setup_io_queues+0x254/0x688
[    0.941724] [<ffffffff80905ccc>] nvme_probe+0x6a4/0x752

...

In `plic_set_affinity()`, it will

-> plic_irq_disable
-> plic_irq_enable
    -> plic_irq_toggle
    -> plic_irq_unmask

I think that make irq working and that's why I didn't find problem on 
SG2042.


> You are right. As I debug this problem, some interrupts are enabled when
> entering irq_set_affinity(). And it does not have IRQD_AFFINITY_MANAGED
> flag. So I think the problem is covered by this: the plic_set_affinity()
> enables the irq. As these irqs are enabled in an unexpected path, I have
> noticed the problem before.
I suspect this issue is related to the setting of 
`msi_parent_ops.supported_flags` in the sg204x-msi driver. The SG2042 
doesn't have MSI_FLAG_PCI_MSIX set, while the SG2044 does. This leads to 
different behavior when requesting interrupts for the PCI devices. For 
the same NVMe device, the SG2042 only requests a single MSI interrupt, 
while the SG2044 requests multiple. The first interrupt is 
IRQ_STARTUP_NORMAL for both, but from the second onwards it becomes 
IRQ_STARTUP_MANAGED. This results in different paths in `irq_startup()`. 
Simply put, normal interrupts go through `__irq_startup()`, then 
`irq_setup_affinity()`, while managed interrupts go through 
`irq_do_set_affinity()` first, then `__irq_startup()`. The SG2042 
doesn't have managed interrupts, so I didn't see the issue. I suspect 
the SG2044 does, which is causing the issue you're seeing.


So it might be worth investigating why the two different processing 
paths in `irq_startup()` cause this problem. I saw that Inochi submitted 
a patch titled "irqchip/sifive-plic: Respect mask state when setting 
affinity." Can we assume that simply applying this patch will resolve 
the current issues with the SG2044? Do we also need to consider 
introducing changes to the startup/shutdown functions of the plic?


Also, I agree MSI_FLAG_PCI_MSI_MASK_PARENT should be added otherwise, 
plic_irq_mask/plic_irq_unmask may be missed in other code path.


I read it hastily, just some immature ideas, welcome to discuss.


Regards,

Chen


>>> For SG2044, I have tested at old version and it worked when submitting.
>>> And I guess it is because the commit [1], which remove the irq_set_affinity.
>>>
>>> [1] https://lore.kernel.org/r/20240723132958.41320-6-marek.vasut+renesas@mailbox.org
>>>
>>> IIRC, the worked version I tested has no affinity set and all irqs
>>> are routed to 0, which is different from the behavior now. Another
>> That does not make any sense. What sets the routing entry for CPU0?
>>
>> This really needs a coherent explanation. Works by chance is not an
>> explanation at all :)
>>
> Yeah, I know. I did not dig in when it is worked. This does teach me a
> big lesson this time....
>
> As the problem is covered by the plic_set_affinity, I think it may be
> caused by the same problem. Routing to CPU0 is not the real reason,
> setting affinity after enable does this trick for the problem.
>
> Regards,
> Inochi
>

