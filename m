Return-Path: <linux-kernel+bounces-819862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC7BB7E018
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AAD11B26EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014F421FF35;
	Wed, 17 Sep 2025 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Lkduitqy"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023133.outbound.protection.outlook.com [52.101.127.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1731BC82;
	Wed, 17 Sep 2025 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758074576; cv=fail; b=FUovQaaBuVpda4RROiNoBSrrbuAQRFkiRMTrndqozO9gg0T0p9TzjcHZOffpB/vg281ycQeXg1x37GjmOy4V24bDhptODTRvy+ZyIlnNKy2UwLID3cr93ZmheJORDh+6hfACUc0gLLgU6Cz6aoXu9h88BpLvovCXXgOPUSnCRL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758074576; c=relaxed/simple;
	bh=0i52DW+j2ICqQQWRsSBEloPGSv0lUm5roi5Sv4xhGc0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OUCvXt0of54us91NfS+rgwBs76GNxauQqbR/TgrUUU6IidQFfgwEDw2NF41lptw6Rind2PT8Y1sxTyXJqxKz8bsOd8H2AQPhExlNNuwpWXwYsSOrNddlMlQ2GWXjzLDHMldVEsonhwY6ZvBbXGFJNL2UTTPrw7bw7JI6mBBSLzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Lkduitqy; arc=fail smtp.client-ip=52.101.127.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHY5/aIoJVEHZr+xQ8uRKjVibIOakLn0J6Jq3F/kEC0lZF2AQKbTgKeqC3HT7iJrVBc9u0De17Ft+cJaDnZBS2X2B5o/Qe7oeh4qM/63QWsLT0atMIiC3TSYpEQK4WecYMj1xKrED5Ra3tIQ9BoTIkGBcdSqWHDDk/x2LfffGwYotlHTTGMcZvLAvk0KujqZ4v0VJY/R2Se1L8IEU1kNemzNn+7XPpFLoMwrdCo4IrGnjy6W7FdLUU8OEPu05Panw3S3nwQi9nafJzFvFr6Aq6DZZzxNPYIP17HzfJlhR592sFIwvmFXCDTPHMkDasRxbGB7dtbotjQMrjYQjs5WjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssOrGfrfjmrOlpNz0v7bYfmnvV8vssGuBmnIiqk/Q/g=;
 b=Wizt/vdshdEk47fSGTg6egU0xY7JesG5D6lzd9ZKv+O4Pwfm7qRQPT9MTbhLwxnmwyBXHXRL5ukdIEXVetwlY1nVVSO1MqFIFWI/UTRpibDrImX8xsaV1oMJg/2xcbdpxGi2m7Q45T5oJX74SCgXSs7VuSRUeAjS/BwMHsCqi/eXt0rBnvRfVyHC7JgkFa3I7fWoUUMiTF8NXW+gz5/4PS28R+Ye5OQKGHkV/rJDajncRfFsEGh7UGAeHxYLOHz9NxrMr4QbZKE8ZvrfCoZ+izB1zDGdjps9BNZDHVn8MorwZchWVxrwTcFd80VOWevOM9n4/3ZkKb5zTDuCoIOE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssOrGfrfjmrOlpNz0v7bYfmnvV8vssGuBmnIiqk/Q/g=;
 b=LkduitqyRsuMwZkkIZjmGCDEmrVh6PNJWyMh2Tnqv2PxalJR3ewZ0quial12AQWXxWzljSdZgDS1yBW21vbit+ElApP1zLrepLEmL+hOBYa7Py5fojSuYuy7b/FrbWI1vjpCTkkjmyJSWRqfLwHeENRguYgylGu1nK20bHoCUwCpHBSD5cMytmKZ217MexSOz/rbd+QGcxAcLnB4vxPza0obMlfkrVAPXfxagBJhw0Vyx8TuEoBlTSSfnM5Gssn9/v3wYbbFkktcLDW+CrFWf1ft7QX0n7YvSuJkvGsXdirRgEx1TtnDdRwy2P/CQwoAdAWWLEiD89cY7XQH/F4yfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYZPR03MB7639.apcprd03.prod.outlook.com (2603:1096:400:426::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 02:02:51 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9115.018; Wed, 17 Sep 2025
 02:02:51 +0000
Message-ID: <91935087-0f0c-42ed-8ad6-f6312240413c@amlogic.com>
Date: Wed, 17 Sep 2025 10:02:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] clk: amlogic: add video-related clocks for S4 SoC
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20250916-add_video_clk-v5-0-e25293589601@amlogic.com>
 <1j348mj0sw.fsf@starbuckisacylon.baylibre.com>
 <66f130b4-88d7-46d2-9f66-9055896d445a@amlogic.com>
 <1jwm5yhgqz.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jwm5yhgqz.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYZPR03MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: c44efd94-0056-4e3f-f21e-08ddf58e4e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3lZNGVCUGdCaTFFMDl3N1ZHV3VocHVJeWlkSVdtR003UXJUbWs2ZWdOUVhO?=
 =?utf-8?B?RjdSS1VIUTVFcUpHc1l2MjByNkc4alhxekdnblY3NUg2RVl0eDF2My8zMjc5?=
 =?utf-8?B?Y2JVNGQxTGVhdmxwSU83TTdRVyt4ajFYbFA0cGE0WXFwRjlQTWVSZTBJK0c3?=
 =?utf-8?B?N2xpTXZ2cXJvRnRmZHA1YjZlRTdGbkFTM0twU3k2OFFYWlJSOXlEcEE1M2NQ?=
 =?utf-8?B?L0JoVDJvT0lTdkFSbWY2UUl3UE5HazZMNkh6cmRDZERYK1JKbmVGS3lpUWdG?=
 =?utf-8?B?ZnN2T3ZxdEF5RjNyV1pHY0pNNXpCbDdqK2k0MldkcllGWjQzNXVoQ2tSNVpl?=
 =?utf-8?B?eGRFeDdoOTJVK2pKSnY2ZlQwWk9rdG4xdFBOOU1pdTZCZU9LTExZUzBwYy9n?=
 =?utf-8?B?bVdockkyWXhTUlZrK281NXFhOHc2OXNpdEc2aUpTMkZZcFg2cjMxYm5Ea2x6?=
 =?utf-8?B?dXFGK09IMnoxNzF0dHM5WE9YalpsS3JCTkVtVVlPRndlcy9lbnM4UTRDZnJa?=
 =?utf-8?B?UFU5c0VqaUV0RTZtSnlUWW90a29rVUlGTCs0MG11Z2RvYWJxVHlrZXdQaEM1?=
 =?utf-8?B?c2pHZ2VydUJqT05ydnZyVDdlN1RDQzJFVlJZWGZBTHdnYUtGYmpKcXpaeFEz?=
 =?utf-8?B?Z0dxTTdMSXBxV01oTi93bXE1eCtJZ1NENHh1TVJMNy9pVitDbXFYaklQeU9T?=
 =?utf-8?B?eFRLMEU0Mlg0ZFl2cDhSTTdrRE5zWkl1YmZZMEVPNjdWYTN2RGhmKzFBVnBr?=
 =?utf-8?B?akt3YUVDdlVFN2I3Rk96bHVYZnAyNmdQRVlMeWFpSlRpR0VqcVRRS3JPakVL?=
 =?utf-8?B?UDkvS1UvUlNCNmFkNm8vRS9oQnBoeGVaMlRxYks5SW1ZeEhES1VCOUtvNzd1?=
 =?utf-8?B?NUJlUU52aUJBTE5QVEFiT1ZRTlJPalRpZERJZ211aUk2dWd5ckNDUTFMTXdq?=
 =?utf-8?B?TFZBcHdlb21qbUpUZHVjZFlJLytTSHFXSTBuY0tla0FFRGZPN08xOHByUmJ6?=
 =?utf-8?B?SEJ2LzdJODR0b05iRlVNcHN1dEI3ZlRSOVRDQ0NPUXFxMXdaZEZmU3hjSGVR?=
 =?utf-8?B?QXk2MUVHNkxMTFFJQ2JIaHdvb3llZE4wQ3h4RXdYTmhDUDg5OXJROGlSelM1?=
 =?utf-8?B?RG8zUVRhc2ZjdStJUnZHUFZSNzRJQ1c4djV6d1N5SEh4SGFCU0ZtaUJMVXRn?=
 =?utf-8?B?TTFBTHp0VEpSZkt3UTltRE5EME42cFBnZnV4NW5VM3hQS1JUV3hha2xmRDZZ?=
 =?utf-8?B?Y1VPZG9tOXJMa0VhTDZac1RvVytialBERGxZallZMm50MGIxT1hGWU16VlR2?=
 =?utf-8?B?SGpSaGlZRXRvY2I2VTJJMlA2MTFycXplMEQxQ25HSEpRSkpYV2czaHFpZ0lh?=
 =?utf-8?B?TUVJTUdhcjBvMUUvR2JhZ1ZxQi9XVmVQaVRtUUpjMENJdG1zTTZ5ZE0xYmtL?=
 =?utf-8?B?VVkrT09pRGd0SGtxVU1Ka2RzK1F2WmlrYnRCUkUvQXB0YTlRczRLZ3dtNmVM?=
 =?utf-8?B?eWZrMlc3Z3hRNy9kVVBSSXFnd0MrT29FQWhNNU1Vdk01TFNVYkVzV0YvY0xw?=
 =?utf-8?B?TjRlZWdlOEF5UDc3YzRPUlc3bFBISjhuMnFPVWhGZXhtdjBPQkdoOVhJYlls?=
 =?utf-8?B?UXlmeEN3SHZlNTJsNzdJMGUvWjBBYWIydTR4bWtPWGhMbWRnbTN1MGluU25h?=
 =?utf-8?B?MnVyTkRlR0dGTnNLNmt3QytjQjNVNHEyaER3L2ZrZDcrdEluSEt1YUJJQ0xI?=
 =?utf-8?B?ZUpKRkR3cm1xYkFoaENReVJ0VGd4enYxelc2ZXBEVWxxV2hxYUhTRExXWFU4?=
 =?utf-8?B?QldXQkZEak95Y2hLOUJaa0pEajRjbGdQWE9leWxBbTBXWUpMZERPQnl3Tk5C?=
 =?utf-8?B?Z1NJclc0M21qSHdtbmpFajFyQ2ExUytYc1NUUnNWdHBqTys2ZHhlcFpMTW9T?=
 =?utf-8?Q?/tA/tn6ibIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUFqU1N1L0NnVnRrWDBRb1E2WmhMM1gzTUxPOEdnMlpFUzRjSDRTSktYMmFm?=
 =?utf-8?B?Znd2c0pVbjNGOUcrMFcvKzdoc2dUY0NNckRxVEJoR0hiVHcvZzVxWnBtN0JI?=
 =?utf-8?B?Y3FoN1pBNHZvS3AxclNkSHV0RnBxZlhibm1Od29CSHVWMGRXY1d4RFJ0ZUhq?=
 =?utf-8?B?dEpHV3VKNDdUTS9jaU1adnBlUkZleEY0dXB6VEpRU0hPeEVFNnVqSXFMeWlF?=
 =?utf-8?B?bDRvOVBvZTV1cmNhb0V3ekN4RzRVNjNlMm1HL1Vab0lvckdCU25wV2Q2dGlT?=
 =?utf-8?B?M3ZwbmZISktoeWIxV2FCYUkySmhOMFNqUnFuaEM4ZlpIVDRnUWkzSDRCM1Zo?=
 =?utf-8?B?M0RuZXNCSEFPeGJhdm1lOGdmSHNBaTBkMVlnbzVvWlhmSUhMS2toWFJwa0Zq?=
 =?utf-8?B?WDBQajRLVkhpR0dlSDk3ejNNbDA5U0t5OE56UG5WYndLMHI2OEpMeEVuN05Z?=
 =?utf-8?B?UnZ4VHdTZmxhYVpIUXY3VEMyTUdGZHNnWEFsN1lSRm9Fb3ZVSHZOTnpWa2VN?=
 =?utf-8?B?QWZZSDJrcC9laUlOemhPaFB3dnNtY3JFSi94dDl5RFM1R2FveFBKUTU5Mmdz?=
 =?utf-8?B?SmZIYlhhOWhaQzVXMjZCWDRCRWhmeXNzYU8rdDRzc1NsaEFEK2hOUmE4RzBP?=
 =?utf-8?B?ZW1EeWplZk9ZNXVaNFpYaEJOcCtsZ3VvM2hBRGVXV3RmeFB4aDdmMFhEVzBM?=
 =?utf-8?B?dmlHV1FseUk5a3ZaeTNaSTVjMG9mQ0ZHQ1ZoaE9UaS8ydkZFRzBZRDE0MmZV?=
 =?utf-8?B?cWhMWmZHbU51bHRxbDFmN09kZGYrNFJ5Snp0UUNUZ0ZibjRiSjJrMFdNMER0?=
 =?utf-8?B?bmVMeWk3U0dPRG5uM0lwWUplcnZUNldOb1RqRFA3Q0JsZy90c2xpS1A2dlEx?=
 =?utf-8?B?TnMwcVBsbmVBTzdKMHZ0cGZDOS9TR1RTbTQveWdvZlR5WVppWXZqcHhUN1J1?=
 =?utf-8?B?Wlp4a1o2VmgvUnNKaUVob0dvclZ2V1V3OFVKeHh5REJJV3g2bFZEVjhQVTVH?=
 =?utf-8?B?QkhWWlUrdXcyNWU5UktVd0VYRmNuSXBKSlJETE8vOGZCUXhxdGk3Ri8wam1J?=
 =?utf-8?B?UXhSZVovN3ZUWDkva3krZVpaeTAyOGt5YUp6cWdaN2NDNzBpdjI4L2ptd0h3?=
 =?utf-8?B?RFlMbndmMjAyMVk1Y2Qzd0JmZy9oS3o0Q2J1TE82QWY0Z3pHd0Zrb1kxL3ht?=
 =?utf-8?B?d0dmb0tLUitFL2RpUEdEK21XdTVrQllkQkZ2UkxFczN1NnlraDlyNGpJRFlX?=
 =?utf-8?B?VXoyMWpSMGVpNkYrTlpzdnhIY2JrYU40U25rRi9BOHJiS2NPdytyK24wNFBy?=
 =?utf-8?B?MTEvMC9XVllCSDlaZ1B3QjY0bGkxK1lvNzFpdjVybGl4SEhYNnppc2NxUFN3?=
 =?utf-8?B?YTd6YVhNM2tMcUVTbHZRa0JuVWNnK1ZZZXVITEtHaXZNU0JPRVQyaWI5eUV4?=
 =?utf-8?B?SnpBdWJtNC9ZaWNiR3hxRS9wL1ZsZmJTZVVjZFg1aFMrVm8vTXZSb09OODhm?=
 =?utf-8?B?STZSRkQwWVIwZ3dZbzA0UGVIbnFnNFk4NHdOaURkWUozL3ZoSXpXNDJkMWF6?=
 =?utf-8?B?Y3drS21IeCswdEZ3QTQyRHlXN2FWSURzSjFwYUo2NWFOS2kwbE9UMlM4b0ZX?=
 =?utf-8?B?QkdENDNxVXY5VGU3UXBJVGtsSUJ2emZDUnR6RTJwb3JmbHFjVUJZNVlpbXB1?=
 =?utf-8?B?cW9FNmdBZUhhME5VckYvWmxVTHVRSXJaUmt5aDlwblN4aTY0SnAwQkMzZStN?=
 =?utf-8?B?ZTRxQ1lVZGZGd0pwYjZmcTFCS3Y3WDVyMzc4NWQ2N0xhSHJWc0FPaVQ3RUt4?=
 =?utf-8?B?WTR2ODc3WW1ITGJjeGZWNGZ4KzZzVkhIVExMYk9qSG10cFl2Ylg3YllDWVBo?=
 =?utf-8?B?eE1PVDdqK05xVUNoczlIeEZUTzlVS0FKaUY0TlRaZnhMSlNhR05LMjBwcG01?=
 =?utf-8?B?RHluRmZFeG14Z2VTc1JjdmhuOU9Ramp2Ny9oTWQ5ak1LVFBIZGkwdktyOEJw?=
 =?utf-8?B?amp1RllmT0dpdXBFYisva0lrcjl5NW02WHgzVURzTW9VMGJ4MWlPM21Pajc5?=
 =?utf-8?B?NTZrWFkvVHlObzhrRXExdmFKd2FXSmZVM0c4T2NoalU2SkpjZVhBMTM2MStL?=
 =?utf-8?Q?vxT8b5HxlwL39v8retRD/NJlY?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44efd94-0056-4e3f-f21e-08ddf58e4e89
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 02:02:51.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9SWtIrjTCosnwNwMmAw3sT3K/8pVH0VvuMmWCTEU2vqQdL1QZZi/dt4bXaZGUZoqM4oA+pHeQm8qHiK/5H+eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7639


On 9/16/2025 5:46 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Tue 16 Sep 2025 at 17:30, Chuan Liu <chuan.liu@amlogic.com> wrote:
>
>> Hi Jerome:
>>
>>
>> On 9/16/2025 3:47 PM, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Tue 16 Sep 2025 at 10:06, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>>
>>>> This patch introduces new clock support for video processing components
>>>> including the encoder, demodulator and CVBS interface modules.
>>>>
>>>> The related clocks have passed clk-measure verification.
>>>>
>>>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>>>> ---
>>>> Changes in v5:
>>>> - Add Acked-by tags from Conor.
>>>> - Remove unnecessary flags as suggested by Jerome.
>>> The request was "in an another change" ? Why was this ignored ?
>>
>> Sorry to bother you. I'll drop the flags for 's4_cts_encl_sel' in this
>> series and submit a separate patch later to remove CLK_SET_RATE_PARENT
>> from enci/encp/cdac/hdmitx clk_muxes. Is that ok?
> Why can't make it part of this series, as requested ?
> It does not seems that hard to do.


The topic of this patch series is "add video-related clocks," so I'm
concerned that patches adding or removing flags for other clocks might
be considered off-topic.

In the next revision of this series, I will include a separate patch
to remove these flags and provide the appropriate commit message.


>
> This is another unnecessary revision and the community will have to
> review, because you ignored some feedback.
>
> As noted by Krzysztof, you really need to pay more attention to the time
> and effort other are spending reviewing your work.


I'm still a newcomer when it comes to upstreaming, and I'm not yet very
familiar with the rules and processes. I apologize for any inconvenience
this may have caused during this period, and I sincerely appreciate your
pointing out any issues with my patches.


>
>>
>>>> - Link to v4: https://lore.kernel.org/r/20250909-add_video_clk-v4-0-5e0c01d47aa8@amlogic.com
>>>>
>>>> Changes in v4:
>>>> - Add Acked-by tags from Rob and Krzysztof.
>>>> - Fix compilation errors.
>>>> - Link to v3: https://lore.kernel.org/r/20250905-add_video_clk-v3-0-8304c91b8b94@amlogic.com
>>>>
>>>> Changes in v3:
>>>> - Rebase with Jerome's latest code base.
>>>> - Link to v2: https://lore.kernel.org/r/20250814-add_video_clk-v2-0-bb2b5a5f2904@amlogic.com
>>>>
>>>> Changes in v2:
>>>> - Removed lcd_an clock tree (previously used in meson series but obsolete in
>>>> newer chips).
>>>> - Removed Rob's 'Acked-by' tag due to dt-binding changes (Is it necessary?).
>>>> - Link to v1: https://lore.kernel.org/r/20250715-add_video_clk-v1-0-40e7f633f361@amlogic.com
>>>>
>>>> ---
>>>> Chuan Liu (2):
>>>>         dt-bindings: clock: add video clock indices for Amlogic S4 SoC
>>>>         clk: amlogic: add video-related clocks for S4 SoC
>>>>
>>>>    drivers/clk/meson/s4-peripherals.c                 | 206 ++++++++++++++++++++-
>>>>    .../clock/amlogic,s4-peripherals-clkc.h            |  11 ++
>>>>    2 files changed, 213 insertions(+), 4 deletions(-)
>>>> ---
>>>> base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
>>>> change-id: 20250715-add_video_clk-dc38b5459018
>>>>
>>>> Best regards,
>>> --
>>> Jerome
> --
> Jerome

