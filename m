Return-Path: <linux-kernel+bounces-797510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B2B41160
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDBA48863B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2EC29CEB;
	Wed,  3 Sep 2025 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Sbomq4XP"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010006.outbound.protection.outlook.com [52.103.68.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99729D0E;
	Wed,  3 Sep 2025 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756859853; cv=fail; b=A3eiPHVG7ZVsdcAudsVA7oJaatGE3ED9frRqJFLSjC4aZxI0iK/AQnWyDPrO6tBVR4QqcHp5sneaCm/6wOm3i8TEwGJ8OzrBhTdmkiVxWnNeUvHvMZoMmBEnsRvPE3vL03YIIoem9FR6FGtEcnxE3r0ETeLE9q4EIvakcc7yqqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756859853; c=relaxed/simple;
	bh=bxUTB9tGy0I1ue/KCHfG5yoaHD2ytWD0wzOKXgU5/EM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GKAX7M30879UhwIBosF6xxGv/i/2yBYlyv6xkzrXknjcz4QSIEhavx2Zw/O4AEeGep098vfvy/DO1JvSxFAVhOyYIYVA5Vynroopenhg9tWiZZDNRvY3TwVr5IQ5YNq4Hv3/HFahAvNKuPxbrMBRIMHciS91TysEOBAOh/kto8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Sbomq4XP; arc=fail smtp.client-ip=52.103.68.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etOnqZWvQzgCx6KD28pBuuSnOhrq8oTx6e7wgEeQ/0lP5dCrD0inDF1882o7d0IfvonsNN3NJXp9LF9Rh8cbtLmRO4q7SXlF2DRte6Ha0qcwZblTF7KVWfwD+IqrTAR5b0hw9VuNpacALQ2jc5ydsemEuwtm8k78NzF9ET0PB5ciHXUJjULu7PIOKQGZzV090oxX6CX6V4+3xEPONKEypqIK36KsyDOyVA/oYllFKLpY/onuNh0STYhAc3/llS+c9aXRdJ/KmGnsOqzaX5npYoU/jmymTatWTPTSURWfAv7r4UcnKeDaKDW4NzQLe6iIdrrEPlTpvjAslPyFnfOnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxUTB9tGy0I1ue/KCHfG5yoaHD2ytWD0wzOKXgU5/EM=;
 b=fot5u5PUDNxomOFBJY4SaDs4tx1oeCwEshkhJKf9kMLblM92pvA+YPPQGiWHBQpUqoY1v+uWz8MEXJNYXmVAIh3fcwl0VR7kABkfga6+bcLN4impGc+pjFx8FCpprI+YVYwIVj1eNyoc+jxu7N2+8qjKxAFRoU/Ia6DV7HobtrkyxpkjgWtLJ1nBOr+ZABZaWO3mvz5OZGLjftmgScRCHrVpGZuVo8O59cXOnw2xmRHYhf9vhBzbMrJBhXoS56EuEY3/AooYGJSwHlVT61Udw/12r5KWSfHZLIc8MBmk0ZGXzPXs2KFbJLTsVK56raObtfhrslEyJjhEdfTleAvDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxUTB9tGy0I1ue/KCHfG5yoaHD2ytWD0wzOKXgU5/EM=;
 b=Sbomq4XPC48lmD/6E4bNvV5cH+ah4Xj1XxSju3aV/cNpw1J0vDrxEuAp7PoNiB+60uMgbke1eAiR414JXLoa2yyZW+hIWkEoYiyQOcgLlnYoxa9WN0M8W8rmGKyALo1jL5D4gvo6CWQY4Nuj1e0K1+6/VH+7A8RjNKQZuXUoilP5gdIaFAZYEC8T9cxmbr521hhLarTDsg9HoqVSOtre4l1HYzT1pKSPDJRKkNCNfF+w7KuhL7v5+RmDWr8QeiHsgLzjLojs98dbzYHQgUeoNeSRBmxlZoX8bis25ZamHWqdJ8w715s/ZkoxJjwcbQd4h30zOS6lTnHkAtH+mv+oxA==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by MA0PR01MB6953.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 00:37:21 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 00:37:21 +0000
Message-ID:
 <MAUPR01MB11072D36CEE005DFA112222B5FE01A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 3 Sep 2025 08:37:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] irqchip/sg2042-msi: Set irq type according to DT
 configuration
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, conor+dt@kernel.org, inochiama@gmail.com,
 krzk+dt@kernel.org, looong.bin@gmail.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, sycamoremoon376@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev
References: <cover.1756169460.git.unicorn_wang@outlook.com>
 <MAUPR01MB110729FEE220A79D00B52121CFE07A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
 <87seh50zi0.ffs@tglx>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <87seh50zi0.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0187.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::11) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <51c78c8f-b780-45a6-a0c6-c0392ba62d5e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|MA0PR01MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: e23a710e-ce4d-4c60-25c4-08ddea820b12
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|6090799003|23021999003|15080799012|461199028|19110799012|5072599009|53005399003|40105399003|440099028|41105399003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVVoWFBjT0sxNnFmbDQxTExIN1AvVGdiYjlMQmUzcWtwR0Nyb293WGF0L21G?=
 =?utf-8?B?TWtWZXdKNWNxTmQ0NDFVd0MxeTNYL2JqYlVpN2lwR0pGbWErMUpMZ09TWVhv?=
 =?utf-8?B?cjM1b2JSejhkN3FIS1YvN2h5Z0RHOU0zZ0JTS24rT3kzQVNZMWdiREovTDZY?=
 =?utf-8?B?TjU0Z2lCLzhFUlBVS2xmdUp1K25RWVZXQUVlNUh5QlYxTkh1TzgrTm4rcHZK?=
 =?utf-8?B?U2MydndYa1piaFpZcWt1TFRSOGplenRGK094V2xiRmsrVWRzcjZCMCs4S1hK?=
 =?utf-8?B?NlVpYWhLTkZxVjdpUkNrT25CYkp2STYwQzVRUWozWjcvNzd4K1N4WlM3UjNW?=
 =?utf-8?B?OXlGblpYSzR2eXZCNm0wdFlleHh4d3hKR3YzZ2NmeExGeUV1QVFUL0piNXcr?=
 =?utf-8?B?QjUrOWFLOGtLZDFWVHFLZU9CaFQ4TWNzRloraWt6eDRxY096WW9wd3ZWYjJr?=
 =?utf-8?B?QTJuNkdxd3NjalFxd3lqR2xTRXRianZSNUlJQmdRbVdWakRRd1oyZmhUYTRP?=
 =?utf-8?B?L2VOUk5CYVc0ZlBWQzVHSVU5KzMzdzJSc0hxS3JJdVBHRllRYTk4WWFsRzhX?=
 =?utf-8?B?bm16MGNjY1JQMDVNYm5tKzl5QTc4T3lOL0NCVEwvTS9hc3FaQXlMOVNlSVFj?=
 =?utf-8?B?aXNxKy9JT2VVN3lNaDViS2hBNWVRSnBmcG9xL3lEQ3dtcWc3czlCNWZ0cUJX?=
 =?utf-8?B?TWZLbnk4c3NrL212dHNhQjNFMTNlTGEvdlo0Z0pDcDhDeEFTWEZ5cFJYMi80?=
 =?utf-8?B?dzV1aUpLSXZyTWI4VWtLWjNxeGYrS011TUxlcEZ6VmdFS0VPb2JHNm5WdW9j?=
 =?utf-8?B?TWVSM1QrelRmNVZMUitUVlhOd0xGQjRNWDQ5K1VvU05WM1plTFpJSDBCOGtE?=
 =?utf-8?B?N2hPTmdqdm4wSklLM2p6VXhRckhjUzFmZjFRbHgzaHdFK3VqdVdMOFdPdlUv?=
 =?utf-8?B?TkF2WWtvRWdENWV4L0V6M0JCVzhGVGVaQ1lTK2NlcEZVcHZ5UHMxUmh2YmRy?=
 =?utf-8?B?UGcxdWc5TnRmRFRSQWk0NFVTNEJPV2VqWVhwR0piaVlmV05ZUGk1N1oxelhr?=
 =?utf-8?B?cVJ2c3JoNXdvWEVzazlDcWhlZkdzZmJmdkc2Qks5d0NoL3B0SVNxai8vVHZH?=
 =?utf-8?B?NmFEcFN1STNGUFZIL2xkMFdIUE4xd3ZqVDErazFEL0tqUUl6VXBTTWtadHgw?=
 =?utf-8?B?QVkvTzZUaXNsM0FodFgzdERBMUJUcTJZY1k1OWVhaGUwYytQT1VBZ1B5NWg2?=
 =?utf-8?B?TDlBU0FSQjl5SjFXc1dzb0dWaEtUWElDcGNDL29YRkpkTnlyV2pmNk1zV284?=
 =?utf-8?B?LzBYMzM4Q1RmejUwa3BKK0hqYWFsTTJhMDN3RmdIYnVvSEtXMEszV0JaVXZW?=
 =?utf-8?B?MTVRbjhWSEN1L25kUzVKMzNVYURaRnBuNzZiVnVBOFlQclRFcFQ1TnV5YWRo?=
 =?utf-8?B?bEY3QTNKZjJmTXNHejY0d3ZYanlmbDJFeWFiVTZCU1JHb2hVTEdZV2JucFEv?=
 =?utf-8?B?bzI4eE5Kb0VlRGt2TmsveVZBT1I5TUsyYjY2a0cvVmVpVVpnbDl3cHJOdS9L?=
 =?utf-8?B?ODVhQTlqNHA2c3hDVEs1djZjQjlKa0lNSFNUVnNtelBKdWMvNHRHcEhxVkdp?=
 =?utf-8?Q?/7xBnRlG1vZwRZ0gujC8P76oJI1LSgAyZBBRs3p5Fdqk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3RiUmNhT095Zkh5aEcxOCtDQXRaak5Qc0dSNVlvSmwrTjgvem5aUlppdEYv?=
 =?utf-8?B?VHpybER6aEFjbGdVQ2tZMHRpeUtScTVpQlJpaHdrTUVaK0l3eXVTaU5lR0ZJ?=
 =?utf-8?B?T3RyYnM3K2pPQmRMRER1VDhXRFJQcHl5c2tGNnBoYUJFV2tQbFkwckVSbmg0?=
 =?utf-8?B?ZkJEemJidE9xREg2Ym41cVU1RmN2K2NaVE1uT2JqSmlvWDQ3dWc5ZVdOUmFO?=
 =?utf-8?B?enhjajQ4MVJTVGZjWk90bUpHeWRoNmRFTmxYWmU0TjIxUFFuS3BPbWwwOUVY?=
 =?utf-8?B?Um1NRk9RczFIaGhCei9lQ1dONDBKMExrYU5DREl3a3p2ZWRUKzBZOUo1eVBR?=
 =?utf-8?B?UE9uQkRRWE92ckdjMWFKMVBETFlVZXF1Ny9uUG9GaFRFM0luZlNwQWZ3SFRs?=
 =?utf-8?B?dGdNQUZRQWd3TXlySXN5T2cwZGYwQ0Nib0hCb3dodmJHaTF6UCtHN0hWZ3E5?=
 =?utf-8?B?Wk1UblMwQWY3K1FYamQvcEJacitpQTB1YS9sZ3RiQ0R2clNaL3p1bkw3bGlj?=
 =?utf-8?B?cENpSy9oYmhvMEg1c2QzVWh3eG1IRlRtNXN2TlJ5Y2lsaUMvZnFxYTlqZTFC?=
 =?utf-8?B?OUVqSjNxQ3Zaejk3L2xaUkZPb0VTakFmUkNKS0puUFQ4c0lWdExEUmhWbm51?=
 =?utf-8?B?M1hPamVBRHkrL2hSdEhrMld5MG81NG9PbkxwVFJUb3M1S004QTFHR01yMmh6?=
 =?utf-8?B?SURwTmpadjR3WjdHbjZrMmR6ZXpLVzRUVGVtMFN4YjkvdFJzaWJ5a3Qzb2lu?=
 =?utf-8?B?VTFHQnAxb1hzMXB4TXRONmxzcDV1Sy9PSGkraEtOY0oxelFwbkloREsyM1Q4?=
 =?utf-8?B?eDNXNFRsZmtYdWZrRkJENGk0ekhBaFhUWnZoUHJ2SWNRSEZZL2lEcSs4YXRT?=
 =?utf-8?B?bWZGMWwxVFI3UlFlN3kyVmc4Vm9zYmo3d2F3clhJMnBxaFhhczdlSjN4ckZ4?=
 =?utf-8?B?ZEFra2JTOVBrSGlTVmVXZlY4OTRYejlZbkhrVHpybGk4OFFNM1k3TzFIYm1p?=
 =?utf-8?B?T0pZUk0zdXpibHJ0YVNuNHRpUFRlVU9BOG9GNTUvSWFtMW00N054UU9xdklu?=
 =?utf-8?B?aWxzL0ZxTlE1a2loN3FSVnl2RVpsek1QZ21RKzd1K1RqM25lUkkvZTgxSDFG?=
 =?utf-8?B?T3Fnb1QyNlNTR3o0cE9Xbk5vd3Z1UmxwSHVmb00wa2Rqb0ovMVR2aGdNQjVH?=
 =?utf-8?B?MXNqNFBGWWxOYzhzMjIxQnBhVHFaWkp2eEh4Nkc2NUhGOElzK1ZpalQ2enEw?=
 =?utf-8?B?K0x1TEI0dXhvdTV3Nko3YjNXY0ZyTzRNYVp6d0g3NUFtR2ZNeHljaEFCNEx2?=
 =?utf-8?B?K2ZRWlBaNk85RElmbzZCYjdERHIvNUJYcFBPWDZpbitFZ1g5enJ3b0tWbWZT?=
 =?utf-8?B?Q1lidTZSS3FxNGpaNTlFbm01WGErdmRIeG9RNTgwUS94ek5RSVgvRDI5YVhz?=
 =?utf-8?B?bTVWMi9pOFhhZzVsWW1NR2dPYk5QSG1CRmpURlpBSVhZN1N4UzZkTmg2bE9H?=
 =?utf-8?B?aXpoNGMxb3l5MUhUTmR3K0ZjaVArUmFmSDJWcXBXenc2MTJ4U3B5MW1Ma1Ew?=
 =?utf-8?B?ckppaDRmbExNUUJqRjkrdDFuTmpHbUxBSHlhVC9RaHM1TVdrVUJ0TXovVzVh?=
 =?utf-8?B?ajc2UEl1RFlqK0FueHlVWGhlaE9xSkh1amkxWUdLQ0VGeDVNbVBFbkw1Ujky?=
 =?utf-8?B?aUJSTmx5TFMyWGRUZkxnSVRTS3JwTGs0OTZnVkdrRm1XYkRUUlJqdVVGQTBh?=
 =?utf-8?Q?QdfE7NapFSgyRDy/Nzi03oWSrrXPMRsxB3lbYwH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23a710e-ce4d-4c60-25c4-08ddea820b12
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 00:37:21.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6953


On 9/2/2025 9:12 PM, Thomas Gleixner wrote:
> On Tue, Sep 02 2025 at 07:59, Chen Wang wrote:
>
> Please don't top-post and trim your replies.
>
>> P.S. Since the modification of the DTS part is closely dependent on the
>> modification of the driver part, I am not sure whether you are willing
>> to pick these three patches together, or just pick the driver part and
>> leave the DTS part to me?
> They need to go together in the right order obviously.

OK, I'll adjust the order of the patches and repost a new version.

Thanks,

Chen


