Return-Path: <linux-kernel+bounces-784253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AFAB338A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39F67AD4DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260C629B793;
	Mon, 25 Aug 2025 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rq74RoeB"
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8E2628C;
	Mon, 25 Aug 2025 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110156; cv=fail; b=cAbz5WXL+s3C2t7mQ/yflc37HhoyIgi6e46lL4Wsj2mA+5F1ojuwU2WM6AvlTxFFom443422PyKzAhL9WJasNnCOMgoB++vrV6a48PbT5dPya7+t8jfeHCvd3bpoKstN+JFOy0n3oFvxBY77B9FNaxj7eBiZi08jBQeyhKwZaUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110156; c=relaxed/simple;
	bh=i31L/Op1s2ICN0wggEGPTrqpG7TWnXse7EieZ+x9UMo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V2vGf19k0bUcrmf7urHv/WWiayTSnc9fpB8/JAl2ZZW8VOiUDd/V/ag7VfKEzOmPQgqcr8GOmxv18ayrDZ/Z/VAg80pqWCDHrF+KIoqorKe3pJMBLg4Ju9ocS21/Xy2ErzcxB7FylYkAHBdFpJjerxHJt2oAYred7e9tgLaytng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rq74RoeB; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGbgx4i2hpdo4HdMi3NiXHOD3kHx4G8ZtZn68dHAHQE6D2wTzQRrLhbFJKpNR/TjAkzgM8dm7vmaqG/eTZ3BGovKAc2Dl/weCEA3mu+nyQjK4DofXVqtWb21huFKuXzSp3P/2HQJVn9ZK3MRoiv/1hAEiekJc48Mp0XW/CMT/UfMLCWOLHEL5swJtzwuvG5F1RgzcxmnsQb5oFjXW1CG7V1AC0q4g0k+f6eGtFtAf+CqKBVzZeaYYZqYnwdyjj3/A4XZe5wNBtiiWO1jZEuRToXohE67b3jWYtmNd6WITfpYWvcxEGaTkJb1k9r7lHxwNYkLY7z4rp65zLML9nwk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBy4kYOIZnnmRmNPNILI+ToPKjA1maYubOftD4y54X0=;
 b=REM0B7bGb5yYpFJd3idTQPhIxyliPXCDNaySFw19NPjYrVmpOgVeKWBvRAnEJIEANDYM2wN05NU6PrUTVSCY9C93piAeIgPwXxTPWKy+74k+PSBODfQ8M2htNUlMP9GyTxidKXnqKq0MIoAjpgRDlQbTpb2XVfTbEkXci/NaJY1QycK1mZ1CdW3rI1emBsFMDRBZOGRNbUfLww6IL3LT3YnoQZ/oJJLknAlPFyIeIHf3gAcEfvb4gWTpiBaFvoG2Y+2NF94lfhFed8rViX7BQIVZZchUIpFkqNmAJqTezLlUXzV8+7XPxmKfdZPT15BKz84zHGyownz6g8iZoJqqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBy4kYOIZnnmRmNPNILI+ToPKjA1maYubOftD4y54X0=;
 b=rq74RoeBiR6BtKRHQpv0FEsd2G11XjsRsGvIFFMiLdJRW98byesb67msyhjkHky78JVP0yugOvHKrwj5Hbxq/MZ+amfGIrhJr7NKFjIAUMEs1IOgn5GCxJc8PqphW5pMqCt8Sx0bMJ7d+CzhuMnK5K8Ea2U8jaPZUehR9ne4aaKNSK1+LierEvxSdqoOHlp1MYaUYmNmnv/Vg9ubZcxTPMyenUuG5M74jrI6w0r/h5uxbWcN3ivF+AZNGAZT/i1vlg/exxE0nNF8HVeibau7Y/IXTP22aU69pkPqggARGnZh/ItPY9uvoEtyPcmJRXY1RCeq6cpZKIiJSXM27TzueA==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by MAZPR01MB7214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:52::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 08:22:27 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 08:22:27 +0000
Message-ID:
 <MAUPR01MB110725A1D283DE4D69AEC137DFE3EA@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 25 Aug 2025 16:22:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] irqchip/sg2042-msi: Improve the logic of obtaining
 msi-ranges parameters
To: Inochi Amaoto <inochiama@gmail.com>, Chen Wang <unicornxw@gmail.com>,
 u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
 krzk+dt@kernel.org, looong.bin@gmail.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, tglx@linutronix.de,
 sycamoremoon376@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev
References: <cover.1756103516.git.unicorn_wang@outlook.com>
 <adb383f0f4a3cb588448a5a708fb7a907d5e9403.1756103516.git.unicorn_wang@outlook.com>
 <n7na4pl6xfhwdk3xq3ulwrxm5d32kdub44otuk7avwjgb32sjz@erqbkyzhohqv>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <n7na4pl6xfhwdk3xq3ulwrxm5d32kdub44otuk7avwjgb32sjz@erqbkyzhohqv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <154d0cfe-20ef-4f14-9ce8-d51d8de79dcb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|MAZPR01MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f464cd-544a-407c-4529-08dde3b08687
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799012|461199028|23021999003|5072599009|8060799015|41001999006|19110799012|440099028|41105399003|40105399003|39105399003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXF0ZGkrQlE5OWNoeXl6dkUvQkFEYktDSWp2d2hnc0JxbXhaMW0ra29jQUJS?=
 =?utf-8?B?Q2FDb01ROVp3TldKeEF0TVg5VE94NE1nTnBKeGRUcFhvcWhmMGZvVWFMSlpr?=
 =?utf-8?B?cG9oRDJNQTJhdHdsS3lvQTVMVGdtRVRETXhoUk8zb2c0S2pLaUpYYjJreEJV?=
 =?utf-8?B?dVduL0xYakkrR0hidy9mM25rbFZLclpZcC8vOFBwL1VMK0JuTnB1RGQvVVV3?=
 =?utf-8?B?b3dhRkRIZHVlYUo5QWtTL1AyQ1ZVeGRlaDlEVUtZTW5YT0dJaS9FMm9rMVlG?=
 =?utf-8?B?WmlZWXN0UVhCRWRGWmhES21TVGU2TWF2RkVnVmlnTFVRZCtncmRNQXNZaUtR?=
 =?utf-8?B?Y0QxNDRZYU1kREpTbHMzK3BJWE81c3QzT0xRSU92aXN3ZkNFaXZORlFFQk5M?=
 =?utf-8?B?MWhHQXgrZVVvczhNeXRUSExwMC9iOTZGQVVJTHJqUlRqbGpuOFU5ZFJqV3Qy?=
 =?utf-8?B?dTF5VFUrRUs3NVpIUWtKcHd2REk2Um8zSllCR1NISFZyN1JGaU1oSjUxK0RJ?=
 =?utf-8?B?cjh4bnZZdEd0QVlBdDlXRWJ2d0s3aU1GQk9tMEdiRjVlOTl2OWNEK3VoQ3pV?=
 =?utf-8?B?LzJ3VWgweDVTcUttVXM2cGRYRlBsSVE4Y28yc2s0S0o0MXZLS0c3WlhtUVNw?=
 =?utf-8?B?c3d0dG5HRCtFODhNRkpZSlUrQnRLblJnRGpsVVdLUHNLMlBIMWY0aUsxUlMx?=
 =?utf-8?B?Wm9Dc21sMTM3cGc1bXFkb0htam9NYnR1OS9qRlpRcytDRU5vbzN0Vk1lVi8y?=
 =?utf-8?B?OFFtVUFuNjRuekN6YWNuaVFtK0lKMlRqdWVEN0drUzAyTUIxRWkxOUxQZG9s?=
 =?utf-8?B?Vk0zNEZTNjB5OVVSZVl1MUpDTUpjanpFVkc5azRWTy9jSkVNdk1GRFBvejht?=
 =?utf-8?B?aG5FTWdQbXI5WXg0NTIrNStLYVl4QWF1MTFnVElhakZoWVFzaWdtMlhZRTRl?=
 =?utf-8?B?K0J1RFdOR0YwK1JVV3FnOUc1Y1E4cktQc0ZwMVpiRmEyanRFOFRhZSswcnp3?=
 =?utf-8?B?dlZGaUE5Y1JhWGwyVFJGK2REcTA3RjZzSzFyVzE2TERWUHRXR2hXR1lpY0dD?=
 =?utf-8?B?cUpUM0ZnVEhOOW9IeHhHclNKSFdPdXl1UGlkNE5yN0VOOEVCa0ZKckFjcTIv?=
 =?utf-8?B?MEVSeDdFMHJPY3VKdWkvZTljSlJRYllmZjZDK2psem5GQ2tQdjZQbU9ZdnB5?=
 =?utf-8?B?UnNPcnVZZ1NlcVlZK2lsMkUvUWdCQ1lKdUgwSzlta3RhRWlEQjdyWUhNQ0hJ?=
 =?utf-8?B?ZEpiRThaKzBwYlNtSzJPSDRVTE5Db1NBd05vRzV3aW5hU05Cb3NhaVVaZCs3?=
 =?utf-8?B?M1QydXM0OG9hWmJ2dG81dUNtZk96QThobElBZ3VnQ2FMV3J0dk53Mzg1djZz?=
 =?utf-8?B?U2IrQWhvUE1tWHlGeTBzZTRLdWRreGRoZ0IrcDRLSW8zRVZCaExRSHVOd2t5?=
 =?utf-8?B?K2FaUGNuVzlhcFlwRjROaGZKSm9hNmh1RFROWHNUU3FRRjI1UXdZN1VqQlU5?=
 =?utf-8?B?Qm4vd1FuSlRqRUZvQXpWcHp0M0tvcWZUWElJY0hTSjZKR1VSVVhXMDkrb29q?=
 =?utf-8?B?T2VmaHpvdmRGU0pyS1ZOZHZaZE1yRWttdURNRHJyL2dUZ0pPVy8yWGk1L3pk?=
 =?utf-8?B?WFl3SDFKVFBzdFcyQzlJQ2VRU056NE5Hai9kMm96QnhTUmpUTkNER0c5Ykg3?=
 =?utf-8?B?aXFTUWlhYjE5Z1lXMy9pZVpmZk9mVUY1TW8wVE9OdXlPVHp4OGZjOXRRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWxjMVFzV0pTbWpJZWxEekhuT3kzTFZ0NkJHb2VXc0oreGh1S3BSZzc5MEgx?=
 =?utf-8?B?RXg2WTZUdkNCYXZPZ3dKaThTRUpnYWNUK0FLMU40V1JCS0hES29xZnp5SG5u?=
 =?utf-8?B?SXZRYjhIaWpyK09IMndCUGVDVlNEMFZWTHVXUTk2alRiU3JuMDU2STBzZkM2?=
 =?utf-8?B?NUZVZzYrQjdoeU91NlRibmJlL0NjM29DbVF6Z1U4ZFBuTkxaL1MxaE5PeDZ3?=
 =?utf-8?B?ZWtqa3paaTlCQlFlelcrR1BzZ2Z5d2lEWlh3Wk1aTzJiTzNzL0FBN1NnOUpv?=
 =?utf-8?B?b0xmSVp3QUo5NUZKUDVsUDJ5aGprcnJOd0grK0oxNDljd29vSlhENm9xck1l?=
 =?utf-8?B?d0Q3b1VZT2RuNFpSWkU0M0FmaUpRczBpdU1rZTJ6WWFSakM5VWxkck1acGNF?=
 =?utf-8?B?dS9BRkw1aVo3ejNjTkJXTGxlOFUxQlFRZldCTGYyd3FaQ1AzbGhraU1aZ3A2?=
 =?utf-8?B?KytpRnJrZnNjM2wySVNTS0RBK0VHOS92ZUtEWVAycFNWeEhhZXRwZFFzNFlG?=
 =?utf-8?B?R3pjNk9HcWV0OE9RS0ZEdkE0OVRXMnBwY0lsYk9aL3FXcU5yQjFoN3d4OTVG?=
 =?utf-8?B?MkNwb3dGRW15VmE1cmJaWjdIZENzYXQ0SXFXTDRybGlvUjd3Wnp0bzMxNDFm?=
 =?utf-8?B?MmlvbGIyeEZVM1piandGMitmTG54dFEvclBKajJpNEIrVDJsRE1KNVRvN2kw?=
 =?utf-8?B?VnpHSm9CUGtpTFhxQjFEU3pRRlIySDdJOWlNM0xEcjhlTTBIbzh1THN1eW1s?=
 =?utf-8?B?dC9JZWdxMEF5ZEUzNTVUQzRzc2N0RXVHL2NCVytwUnFFSXNMQnBxZ0tjeWoz?=
 =?utf-8?B?RDNyQ2FSVWJXOUFuNmZrYjVEYjllRlRaanp5eUxoa3hpTzkza25GL2t6NGxj?=
 =?utf-8?B?OXVCNDBjN1d6VENRc1cyY0lKbHRpMFg2b000VkVweVVTUlIzNXVPdFdieTBY?=
 =?utf-8?B?VVF5UlE4QnV0b3U4VjhrR1luUjFSZ3BMQWd6ZjdJaEN5WUduUjViZFlra3lG?=
 =?utf-8?B?U0E5ZjFxTld1eDJzQzBVQXNLVjdCZ0MxVVJDSmM4bjV0T1UxNWpSNHB5cms1?=
 =?utf-8?B?RUVuSXNieTgzTzl2NzB3aStPOVErWS9nY2F1SjdENjlVMHNtMTF2MVRoTzdS?=
 =?utf-8?B?alB5ZzBFZXBDRFNwRExZdTdCMWxaa25mVHNuU3BnZm1BZDZzUG5peStRRW1z?=
 =?utf-8?B?SmJPOFFRWEdDdjdzOUEySmZOTFpKVkV6b1IrNjBhb3E2QUxrTnJEcElMZU1W?=
 =?utf-8?B?cFRUS0RZWUZ5R0dKM2lLTXpNY0gva3VucHBBMi94SkZGMC9abk9zekloQlFK?=
 =?utf-8?B?dmhFTE1TOGdTTU56N3Eyd0dXRzJObC9uL3F2QWU0c0tQRUlVNllGTnhMSmpX?=
 =?utf-8?B?bmszaE1ScXhuR3RDR2VoTjFaQUxnR0N3STR3NVVlY29OZTZ2TWF1ZSt4N0JY?=
 =?utf-8?B?dloxczZpTm0vaEh2YmRKV1RwMjY5M3V3RG5QQVBIYWxzcm9Ma0xUcjBsbEJ1?=
 =?utf-8?B?V0tnMERMRFFLZzFnc21FSEVJZjlweDVvdUh4d2ZNa1d0VWUzRy9SVVordUh4?=
 =?utf-8?B?djVPdW9zcitqd2tGS0F6SVFLdUQxb241bEtvZWJzQmFIRGJ3RXF5QjB1TGtL?=
 =?utf-8?B?Y1F1V1FGQml0RUh0Z0w4MVdVVTBYSVJpTCtma0VFalBxTnlxdWpZZitUZU80?=
 =?utf-8?B?YkpqcXpBRU01aHJmWTNLcmYwNjdwTVg4VE9Fc24zd1AvSmRwYkVPNWd1b1Fv?=
 =?utf-8?Q?4eWPaxhshky5Ue43EPOa3R8mgQEong38Xnlxxjk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f464cd-544a-407c-4529-08dde3b08687
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 08:22:27.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7214


On 8/25/2025 3:33 PM, Inochi Amaoto wrote:
> On Mon, Aug 25, 2025 at 02:55:03PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Get the arguments of msi-ranges by specifying nargs directly instead of
>> using nargs_prop. This only takes one step, unlike the previous two
>> steps to get the values of all the arguments.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   drivers/irqchip/irq-sg2042-msi.c | 14 +++-----------
>>   1 file changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
>> index 3b13dbbfdb51..5249afd93b4a 100644
>> --- a/drivers/irqchip/irq-sg2042-msi.c
>> +++ b/drivers/irqchip/irq-sg2042-msi.c
>> @@ -276,17 +276,9 @@ static int sg2042_msi_probe(struct platform_device *pdev)
>>   	data->doorbell_addr = res->start;
>>   
>>   	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges",
>> -						 "#interrupt-cells", 0, 0, &args);
>> +						 NULL, 3, 0, &args);
> Why using a fixed range here? I see no improvement. I think using #interrupt-cells
> is just OK.
Ok, I will revert this change.
> Regards,
> Inochi
>
>>   	if (ret) {
>> -		dev_err(dev, "Unable to parse MSI vec base\n");
>> -		return ret;
>> -	}
>> -	fwnode_handle_put(args.fwnode);
>> -
>> -	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges", NULL,
>> -						 args.nargs + 1, 0, &args);
>> -	if (ret) {
>> -		dev_err(dev, "Unable to parse MSI vec number\n");
>> +		dev_err(dev, "Unable to parse MSI Ranges\n");
>>   		return ret;
>>   	}
>>   
>> @@ -298,7 +290,7 @@ static int sg2042_msi_probe(struct platform_device *pdev)
>>   	}
>>   
>>   	data->irq_first = (u32)args.args[0];
>> -	data->num_irqs = (u32)args.args[args.nargs - 1];
>> +	data->num_irqs = (u32)args.args[2];
>>   
>>   	mutex_init(&data->msi_map_lock);
>>   
>> -- 
>> 2.34.1
>>

