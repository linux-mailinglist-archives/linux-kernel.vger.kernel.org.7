Return-Path: <linux-kernel+bounces-782989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1A1B3280D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1937E566F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22772441A0;
	Sat, 23 Aug 2025 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="QxazX3GV"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011030.outbound.protection.outlook.com [52.103.33.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB825C96;
	Sat, 23 Aug 2025 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755943230; cv=fail; b=ptm92UHY9Tc97d0JFYPhsV5hkWXJXvBJQ2cjuC9EloLrsY8scFpDge5CTEaQwZUK36jcWjHcndmSFS5htdoqDPUStvXy6Eix+jSuFOxwAxQ6i5zBoA30LBEQJTn012Kd6OkQB/Lqk/xMNto3lZtOx9auH+LdZtmf4mpEFA0OdMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755943230; c=relaxed/simple;
	bh=S7tNLqNocVGF0U2zQtY/S6y27OMgekEP5NseV3pUfvI=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QnRgStpBbD8x8sx7031/q7wFHiYjclG9CatzzRUvHQl88p7h8OSqwpSqKMeYURh6oiemiukdFyphGxi8Elz1Z8PVMfLLwyvVUwT8w6D0K5MLBCbu1Wihe5gr/qWiF2VOzIjIAJD2MueNlt1atoQki4NCC259XLhyp8jK58bskbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=QxazX3GV; arc=fail smtp.client-ip=52.103.33.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DR4ftLPCeOY08GNptZxNrWt9gAyrgktAUMsnwzwycIuzc4fqsrTYkdvFgGaJ8vvC0Oqf1kC26tyuM7hZi86qZk6ikoabU71HqREVGqbIY20o2AifgFIev9R/h8oYMUmnDWvCGU6qcCe/t6wkngu+nGMYMtW6qO7gT1mMXZuXrGx+OGAj21IDaDl0oRe6Hdx2XaxK3sRGqMwcPF7otHCqBeTSft9MvTv8RTJ/gKhgIb9KIJHyat6D8p7szLshzgiFSFvEEdfjgJtQuX/0SKSR6XNFinCyZ0rU3HIjg3kpOozDExAbuuwkopZQiCwpFaXYhdubsJZ9hIKMjYhGZGjE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHXh54qUZ6bGyP/9bwmBCNiDT3N1FlVFtBupBvKz2J8=;
 b=V0NnahtejLPG4BF2Bfg6lK93RIoeP+1vS7k/SPUL8ar2PJ4B6J2/4f2ZjHf55oET/iIhUBvPwN9Chbm1WsYKfAsOM6Nmz8Iw0GQ40NXPqIS94hPHhWqe50aPLUkbOTILxRKUWsBQPwHwfCSh5IK19ONI8QjHQ71a5BfRCMnpcdzN2g6IJEFdSMOViAjbfLInf+53DA/biL1lvyduQNK2sVxNpLPmiYSRuD+b8k5vH9DW4Skshu/GgGOA0Yr9hJe665Nj81i74Pr9FecRB2cKnKIuAEJDtY5xrDLGhFnve0Jk4GAkMsC9c0jaQBdz2jD6ie5VUyTMM3ckHQnXnr5TCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHXh54qUZ6bGyP/9bwmBCNiDT3N1FlVFtBupBvKz2J8=;
 b=QxazX3GVvVAiJd++z1Q4zeJ+foA/nXSXj1rfiaCimHdvar2lNmzxEsg6IX+PaMoekm8NlyaiKcmav9k1zKRnOMa/BZthaWH4bV+lE37eNqbHk/USzB5BGKsHknrfjeX0POUprFYZBE0FTMtKR3WMADQWewf/Oq0UDQTFWdY3+r8xR8ihnSLJYfS9y+yWRwLlp/m5SQHAQXDKaSxbTFfkDdMQCbKOAL19jjS4r0Q91xt1jUCFCpGgj4wLJ4fcrHYw1/HcTUTKEi97yurMC7NYiRp2zzwx/e8ujJbar6y6YjuUVoVrqmqT3Frkwu9BMrd3+azkx67BqY74etAIt5EMdQ==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by GV2P189MB2959.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Sat, 23 Aug
 2025 10:00:26 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13%4]) with mapi id 15.20.9052.014; Sat, 23 Aug 2025
 10:00:26 +0000
Message-ID:
 <AM7P189MB1009A6BCD143F9BE5C3341FAE33CA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Sat, 23 Aug 2025 12:00:24 +0200
User-Agent: Mozilla Thunderbird
To: opi5plus@bcc.bai.ne.jp
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sound@vger.kernel.org, robh@kernel.org
References: <20250821041555.4781-2-opi5plus@bcc.bai.ne.jp>
Subject: Re: [PATCH] rm64: dts: rockchip: Enables sound output from the audio
 jack on OrangePI5 Plus
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20250821041555.4781-2-opi5plus@bcc.bai.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::9) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <4f77f183-6487-4797-8f65-d6406cb1f8db@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|GV2P189MB2959:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1dabce-3b74-4de2-1699-08dde22be1ab
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|8060799015|19110799012|23021999003|461199028|6090799003|5072599009|1602099012|3412199025|51005399003|4302099013|40105399003|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkFYVUZIOUd4cGZxUG01YjdVOThGd3crNnU3THQ4WXNXdlVPTXcvYTdaSW1J?=
 =?utf-8?B?WkFOeE9BSkdPQ3ZKSnFuMTNuRDJLbnZSVWx4dkhjQTRjY0UzU1BkWlpaTEQ2?=
 =?utf-8?B?dCtwN00wc2xzdjhsSW1LZFJRbDJ4MzJTT3JBWUxPbVJpM3g5NWRTOE5Xb1JN?=
 =?utf-8?B?V0lPbGRYTUVRamN3ekZxM1RVNkdVNG9aUFJsR1hQMlhMMXM2S3dteG1UN0ti?=
 =?utf-8?B?akQ5dUNjT3BBMGZWQ2hCdEozY0RLdFRGdnRxb2lBUThueHBjeFdDTFN4Mksx?=
 =?utf-8?B?UHY3ZzgveGNYbElZQnNJSFcvK1d4SjJReERMZjVhd25ORVExbmNxY01uSVJ6?=
 =?utf-8?B?eUdDN05CZjFrZDRXWHNjcUhvcUxSZTBzOE80WGFFLzExSkFENXdibzhOWGw1?=
 =?utf-8?B?VDlzMU5ic3c3SEhKblFWYW9ObElwRGJZNVc1TG90M2VRa2VYKzEzQ25LUVcz?=
 =?utf-8?B?Y0d0dUhxVkhqTXhUWFZ2MHduUGJmRUQ5TDJlWlYvMzZsVkRSbDJYWnpVQ2xL?=
 =?utf-8?B?Qnk2VExvd2JSaU45N3ZwR0YxWEJEN25CWk56ZW5pZWhNbnFDMlNpWTlrQm1N?=
 =?utf-8?B?ejB2MDZBaXVCWEY0UVdzY2JYbFlUOUlVL0dDQTAyLzUyemRHMlAwMUxpWEMx?=
 =?utf-8?B?MTluM0ozZDZ0ZTRialJUQk1xeFI1ejZTdXYzeTV5NEtGVzBBOWQyMFVJa3dh?=
 =?utf-8?B?MURIb0xGWWp6NlJzY3JuOFc4djdQb3pjUTluNmVQbTM0MkM4R3lxNWhPb3ph?=
 =?utf-8?B?Q2Q4ZFQvSE10VHUxOW1lN1NSTmVrT0l3ZHk0alFlSEtNV2xGL3lyeVI3R0k5?=
 =?utf-8?B?dis2bFRrNTlNZFVmbENYYTNmeFEyMmE4T1QxQXZxUHU4Y09tWHBNTGVDdFRI?=
 =?utf-8?B?ZCttdGpzV2ZQMmM5K1JyazliRVRWSU9tY1UvazVEVTlTekFRNnNiZ2hid2VT?=
 =?utf-8?B?UTFmNXNxZ3B5d2hyaFZSSHNQdXpCR1F4RzlPQU52TjlQMW5XZFZSeHRoOVFV?=
 =?utf-8?B?TENnaFJSdEd0RG1xTjU1TUFjWkUvTW9acFJGUHBkUmovRXh4bmI4TTVtdGFt?=
 =?utf-8?B?cEgxaDRpa1kyMlB0TVRWNTVTMWZ2cTJlN3ptS3NVamo5aCs1UklJMTJZSkJh?=
 =?utf-8?B?NDl2ZmJxVkp6OTBtVGNGNk05UTY3OVhEYkllU2hqQVFyUFA5cGNJWVlSR2VS?=
 =?utf-8?B?bHBMMTc1YVViK3ZZQnpOaFhMdk42TFRZaHpnOW8wK2hhcm8yNmNBTmdRU0VL?=
 =?utf-8?B?YnA0dGNuYzFSODJEalNwUGRGRVFiMGVubVRxTDEwQXl6dFlWSVZlaG9GakxI?=
 =?utf-8?B?OW8vbnhjYkRtZFJ5UzlRMTNyMjRyNG5kbm1JQUplc2N1MDRrRE5mZ0wyWVpD?=
 =?utf-8?B?bGt5REJLSjRZZmNzbUV6Q2NiQW9Fc21lNmw1Z0lwK1JIZmhaSXNzR1NDRk9T?=
 =?utf-8?B?TUp6TCtkcFZ1TVZ3Q0NkK2NhdFVocXYrU0FoUWpHelkyY1EzaUw3dE1pa21O?=
 =?utf-8?B?dURQT1dWcEJCREowak9CNEpYUjc2bjZGVitaVHRaZkdKZERpWFJQLzBIUTZv?=
 =?utf-8?B?NXdHUjFJWXNKZTJHL01VazdQTkR6WHVGUlFBaTNEc1pXS1A3RS9DcXdPNjg0?=
 =?utf-8?B?MGtSQm9jVkwxV2lOYW1OSHZmU2JvbHA0TU1KRW4wSjc0Q1owakpZdjlGLzRs?=
 =?utf-8?B?Q2UrOW50ang5aDQzaW0zblZzcW43VGxMTkUwcWpndnFjUVB4dGQ0amxtUzJ0?=
 =?utf-8?B?Z0R6dEhBcS9RWkNKRGJaY2UzKzJFYmdjRncxaFM2QmRRVVNpUDJQcjV6NEVX?=
 =?utf-8?B?UnZGV29CUzR1WXJFL1VEZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTcrZlgxN1hwelZZZ1ZKQ2dUVHNjemZ4b3JmV2I1VEp1ZFl1Vk9WbldmSjJZ?=
 =?utf-8?B?eFI1c3VlUDVFUlVpdXpCQ05GZlBUS28rWnUydVh3Q0xYRGo3N0RaTjgrUEgv?=
 =?utf-8?B?WGQyZml0Q3N5MHRjeEpqV1M3ZDdURURwMEM1dU0wWm1PQW1WZ2Z1N0NUZ2Y5?=
 =?utf-8?B?VXZTRlpGSDhsRTZIWUJTV1BNNXloOGdJM0ZzRVRESEU3b0hLZEhsNUJvNDl0?=
 =?utf-8?B?WU8yQmJjUVNjL0tEVi81c3RucGN6aWh6Y2QrOUxDbm43eC9xYTdWcGZ0OU9I?=
 =?utf-8?B?T2FzaHRQTktYdGwrSElucytRaXEvaS8zenI1ZDMvWitTdFNIMUhhV1ZMNHdm?=
 =?utf-8?B?UTltNHZORlZYdVV4eEJxbzJhOS95UXpOT3l4d2lRRm9zZ3ZWT05JVEJZVHB5?=
 =?utf-8?B?RDkyRmM1RTMzWEhkajNsSVI4SklUc3c1YmdjcXRieWMzR2tLZVNOcTZOMjRq?=
 =?utf-8?B?bjYybDREaE5IbGJsTHo3RXlaQjFKaVNBeXNWV3ZBOGRCOGYzcTFlaDNkNFk3?=
 =?utf-8?B?NnlLR3ZpWHM2OUVjNG5CSStrUnI0VVl1V1poc0Q1K2VUR2plTVdyQTZiR3ox?=
 =?utf-8?B?cjQ3SjBhN1paK01uLzllMStjQmxWM0JNbkdPQTZYWkpwQ1RlQUU4S2NPNkJF?=
 =?utf-8?B?TDdCcURWZ3hOWU8rSGo3cU9VWTBnaFh1WmE4VTlwdVZJYW41SFd6Z1FvQlpZ?=
 =?utf-8?B?WTNuZ2U1bWxRYk9MY1FUVDBiZlpSck5tQW41OTMzajdtQk5GNjZIUWI5dzJt?=
 =?utf-8?B?ZHpyOVgvMEVUblVicGNNTDU3bGFuNDlnMXlGdThVNmlub1hrelVBanlrNCs4?=
 =?utf-8?B?QUIzQ2J1T0tZWGZicXNsTzNyMngwcmVkS3Fsb2JUV1FjbCsxempDZzZIK0hK?=
 =?utf-8?B?SzN3aU9tUWpSTGFucTRyemoweTlmd1BTV3hmT0FpNEh0QktCa25neFRPb3lW?=
 =?utf-8?B?QkdlNjFhdGFwRDdjLzBOSFB4dzhlOE5PSEkwSkNGYXYwV2tybEc2eVRHc3hF?=
 =?utf-8?B?OWQySXQrTEVPVEpMYXhvZW9CNmtEakkxS3hVMDdzNHlGeW1NUHZ4TnJCaU8v?=
 =?utf-8?B?U0krdkQ0N2dyWU5nL0p0ZXhwOG01dXpWQUU4TDRXZ1c5ekNzWkh5RHhybTZp?=
 =?utf-8?B?ZEFXcHpxVHdxVFdnUHA0UnFWNm9DUTdXQ3gxYWVUVzQ5RVBRMXFtSlE2WGF2?=
 =?utf-8?B?NVVkejc0LzhJalVKOGFudlMzL1d3aUcza2tSNHVjc3JOeXYyZThORjFaRjdr?=
 =?utf-8?B?emYvclhOZzRFRHdmc3pla1RMbzVHS1llMlgycFdMZXcrekpNVzFvWUtCWm52?=
 =?utf-8?B?amI4R3Q3aUV0Q0FBcUpaSW40V0lpTGlXU2E4V3F6SzJFNU9EV2FYTHJYTG5z?=
 =?utf-8?B?bWFraVFRUjU3NmxDUlJmYXUyZXlDZEF5MDdraWI5N1ZvUWhsbkNseVMrNytW?=
 =?utf-8?B?ZGp2V24yclpqYkx2SGt2Sk5FVUlPTjNudmo3VXkzdmZRblZMZnBZRUJ6Ni8r?=
 =?utf-8?B?Um5ScFhHbWVHbnFFVkNMYnVRMmhzZXAwSmIzSDNCS0M0SlhvRm4xSEhLV0Vv?=
 =?utf-8?B?aDRDSS80TTk4OGlCM2lBMERtSFgrZnVzc3J1SnZjQjMybFJ2S2xwQmVhc2ly?=
 =?utf-8?B?cUhwQ29MQWRrNEJjYjVYRWFLakM3aFNrSk5GTGlCSFRzZTAyeTB0NzVyaDBo?=
 =?utf-8?Q?nuXlHhQFbzvyw2lvueAB?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1dabce-3b74-4de2-1699-08dde22be1ab
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 10:00:26.2230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P189MB2959

Hello Hide,

> Currently, analog sound is not output from the audio jack.
> This patch allows you to select analog headphones in alsamixer.
> Works with kernel 6.16.1, but not 6.17.
>
> Signed-off-by: Hide Hako <opi5plus@bcc.bai.ne.jp>
> ---
>   arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi <https://lore.kernel.org/all/20250821041555.4781-2-opi5plus@bcc.bai.ne.jp/#Z2e.:20250821041555.4781-2-opi5plus::40bcc.bai.ne.jp:1arch:arm64:boot:dts:rockchip:rk3588-orangepi-5.dtsi> | 1 +
>   1 filechanged <https://lore.kernel.org/all/20250821041555.4781-2-opi5plus@bcc.bai.ne.jp/#related>, 1 insertion(+)
>
> diff 
> <https://lore.kernel.org/all/20250821041555.4781-2-opi5plus@bcc.bai.ne.jp/#iZ2e.:20250821041555.4781-2-opi5plus::40bcc.bai.ne.jp:1arch:arm64:boot:dts:rockchip:rk3588-orangepi-5.dtsi> 
> --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi 
> b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi index 
> 91d56c34a..656aac2df 100644 --- 
> a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi +++ 
> b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi @@ -113,6 +113,7 
> @@ analog_sound: sound {  		simple-audio-card,mclk-fs = <256>;
>   		simple-audio-card,bitclock-master = <&daicpu>;
>   		simple-audio-card,frame-master = <&daicpu>;
> + simple-audio-card,pin-switches = "Headphones";  		/*TODO: SARADC_IN3 is used as MIC detection / key input */
>   
>   		daicpu: simple-audio-card,cpu {
> -- 
> 2.48.1
I tried this patch, but I am not able to get any audio out on my 
headphones. using kernel 6.16.1

I did see headphones in alsamixer, but cannot get it to actually output 
any audio. Any hints?

Kind regards,
Maud


