Return-Path: <linux-kernel+bounces-844518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F1FBC21E9
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF719A487B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6992B21638D;
	Tue,  7 Oct 2025 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="POqvVnku"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B220330;
	Tue,  7 Oct 2025 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854747; cv=fail; b=VdDdBjTNglSpYCbfDYjg8ujTSWblYePg9jixE4pBok8e3cmyHs/+vTWS6fcFUt87xlwAfhYlpXoROcuOa0AjbU0LmOstV9OZ2Qrfb4RAE/lAiWqnRy455yd2b2zELhkp2T+HJSCf/a5tBoVrjBV62YEg/isaNKeyky8Sev+JBj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854747; c=relaxed/simple;
	bh=0ZyoYR3CVF4T4w6yG/noioLW4tSSx+KHr/Gge6Owauw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FkSevBB08K8Y6f4YCmYMV5E1aPVNcTcuwVWl2sX6yfuhdJI7sZgmPNZ+DoXKHsFSy64HFVeOWDua+ao9CNXo2z796iRhHgZpVTiPci7nA011eWtxpT5dmY6bnJAEtRQyOlgInp8iy01nAm4L3asJAvLBOJwZZokPB+8xWn0BaGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=POqvVnku; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mvz9JB2JL+yPegPrnzVG9iNTFFnICpM3hP+PFf7+wgZNt+7ErBXgBAVhMqyCTG3iKyOfUWL+YWTXKM53vW/OPOy85HVyFFSXZ58HptZ+bC078guP5ytRN+T/yLoZU9d33kDBAf7UcnWNWfWUKARODct/gHcdyx9G6eitvndu3vMUKgJLbXJkmgzI4bAihBhQBl13vYEPcmZpzg6eaM5NSm0Q5rp3WkqC8T4aAjuIRfJ9AKjMfv2yyUtF2SLJlStKRNQl+gkaENZuU61fwnqbReVtEurdLiZl3IY3yz69DZTh0dyxT4zzKmgjfpleNZ9z0CdhHTl0eIzWUv5+elw5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoMycbd1GHC9ZF3SPhH94/NJvBoKw7yzV4t8HZNYkM8=;
 b=ajCQKV2Nklv9KQfkP9JYaVigqtem5r70zV1Qw//HsujvvtnWt3SlN5XyVOXK2w6mAtOelOMu7X9ib86zRWJA+FqmPy59TLXLAdIEu0UtJElHPigLihFsbJxP/DLhEroMtg4y2AOnaok7btv0q1C4raUliItGmD5s3hRAI7BYaW2qD38JIBL8KxCTWtCPoswvBEvlJ6YORs65S9eJniEnjKpwjHbQhnt712Y3x+Y9wPJJVkCL8pBYbzF3/unj5q4Zqmjt/SqLD8QUuZqxUVSPZUvKiJwFy5GKoihieOHKUgmw2EkP6rdVx8lfJ5n12tYtHmqi6LIakdmnqM7UqXHElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoMycbd1GHC9ZF3SPhH94/NJvBoKw7yzV4t8HZNYkM8=;
 b=POqvVnkuH4N2kjcN25UMJpXopomofq5J9fHN7r3W4s8mkBF9tUgf3K3Vn+KhjzbsF+g/laPHCHu9erefI8h9bCWWBhIYwU/mZt3ydlzVYYMrhp5G+NyOPd1IbmMpyeel12h2Sdd80mIQsYaTpWknnabauK/W67qUyMQJ6kK4XlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:32:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:32:16 +0000
Message-ID: <88c6c40e-8c19-429d-a7d8-c8f2755f515c@cherry.de>
Date: Tue, 7 Oct 2025 18:32:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: jjm2473 <jjm2473@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, kever.yang@rock-chips.com,
 naoki@radxa.com, honyuenkwun@gmail.com, inindev@gmail.com,
 ivan8215145640@gmail.com, neil.armstrong@linaro.org, mani@kernel.org,
 dsimic@manjaro.org, pbrobinson@gmail.com, alchark@gmail.com,
 didi.debian@cknow.org, jbx6244@gmail.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250929065714.27741-1-jjm2473@gmail.com>
 <20250929065714.27741-4-jjm2473@gmail.com>
 <d8ad476c-d0c7-4e97-9e76-540a539ffb52@lunn.ch>
 <CAP_9mL4ofig-X-w9wx1A5D_eVXROo6AVFBSwp4mh=kj7webpPA@mail.gmail.com>
 <7e219aef-88a0-4184-9553-30dcbc8dbd79@lunn.ch>
 <aOU-_tPOmkyuw_kx@shell.armlinux.org.uk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aOU-_tPOmkyuw_kx@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: be8f1ebc-eb53-4835-196a-08de05bf13e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDVZY2NBVE5vNFoyQktoTU9MSFU0UVNMa09CckFhci9LR3l0N1hNWUZNdDNp?=
 =?utf-8?B?b1A4bWJUaFZpaHdHVFdLSml4Nk85a3Q0ZmpJWEw3WHdvYzgvWDlmQkRFeGNB?=
 =?utf-8?B?dHhidy9TZi8ybWRYNmZTQUFyZmVpaysydlNXdlNSM2F4SlUwN2hpakdyVzJV?=
 =?utf-8?B?bjczYjNIeEVTVFR5Kzd3Vk5VSytkU3BPUEl5REc0WTdDaWVrSGhIblNOSWVP?=
 =?utf-8?B?L0ZIbjF3SnBkanFhdStUNFF5YlllRW1xaW5QUnRQRmNHSW1xcEZXdHhubmhP?=
 =?utf-8?B?Sis0WnFEWE0xSHdua2Zja1ZwQy9acHJ4MVVyMnZFUFJIeDJDelhvdzBwYWpT?=
 =?utf-8?B?Y3pUbzN3M2RsZmg4KzVmRTNDQ3BaWjN0SDRZdWgvSVl4K0xNZzgwa24rN0Rj?=
 =?utf-8?B?KzVNWmpvQVZmbnE4QzNhcXc4TjBKdisveklQcXA3S2tLbkQ2V3BQQWdiRlFo?=
 =?utf-8?B?b1ZkcitzTTFCWXFhcEZhN2tqMm5SN2RiT1lBaDh1enJZbkRwZkFtQ1M1YzhG?=
 =?utf-8?B?NWpRWnQ0TExmdFZaUlR6RVhtZVVTT2JXUVlVOWtwdW42S25sUjkwdURMS25N?=
 =?utf-8?B?ejg5NTZsSGhlbitnejhRbnJKWnlQQTFpMkRkNDBJbDJHKzdIU3dmbFZzcVMx?=
 =?utf-8?B?VlZ2djZhaDhDRDNSVEdEQ3ErWmN6MloyVzhrOWQ0T1QwTDE4aG5zaG9qUjVk?=
 =?utf-8?B?TmxxVit0VTBncG1mUnJWZjNSQklXa1JEZlZpR2hOWEQ3Q0Y1aWhzcHNkemxX?=
 =?utf-8?B?U2VGZmJUYlNCQmxYSjhnMFlCOUJoRjJzbkhYdHZUYmhIR3FqNE9lVnZPWkxK?=
 =?utf-8?B?M0dQUDRVQjZJV2NkRG9aTHZ5YzhzUEJrWmhrVWQ0cE4xMUg4cXRDNkMwYVNZ?=
 =?utf-8?B?NTVlaXJkWWZ0L0pxRlBaM0hNTlcvYnVsOC9nWGZhM1B1ZDdTNWhZVThsZnFt?=
 =?utf-8?B?ZzB2d0xTYTZJcTZ0ejN5RTlPWDFEdU9JRzVJeEt0QmJFUEhna09LalNta0Z5?=
 =?utf-8?B?VlRoWGswZHJhTE1qcjVnbXdJNXlacWRLbnJRaFJxeVBKcStvV1N2TnFVRzZH?=
 =?utf-8?B?Vk9FVnk0ZStUcGR5VFhTSkFEM2JPN2kySEVsc0krZysySVdrSnE0SWJHYzNI?=
 =?utf-8?B?dWxNSGw2L2ZGMWV3SHpnMEVyQkdxMGxSd2hqNG54VE1MZCtCb2lkZFFTL21E?=
 =?utf-8?B?ODh2aUhmTWRJTE9scGZpSXFTY2h2SFJZN2xVVld3c2dveURzY2JRZ29QV00y?=
 =?utf-8?B?cWdCNHJvd1dwZC9MbEhkdXJXVHA5YXlCVlpvNm12UlExWExUQ2pyVEpZditr?=
 =?utf-8?B?R01WaGsyTVZoT0MrMkEwUVorUStvb2JvZG9wQmMwOTk2NzlER1MwNkNqSzEv?=
 =?utf-8?B?MzF3TUVxSS9rSXkxTGlaQ0FITGNtRTA4WHJ4SEpMYjVxMi9PcldCSmF3TXlI?=
 =?utf-8?B?N2xtVXluLzJRY1czZytySFBCdGlTNC90YW4zZFVVeDdaNnU0bldqd0g4QnF3?=
 =?utf-8?B?K3RaOFVGenV5a3RySkdqZU84K0RqQTl3UzQyZGJHM0hwb2dVRTJNRERFaEk2?=
 =?utf-8?B?dzNKVW8xUExkUjlpV3RiNkExdkdQaENuRWNEdkxSeWhGZ2ZleXFhdUcvK1lR?=
 =?utf-8?B?K24yK0F0VHlocTJ4TEsrd2pKKzE4NHdUZndvbHl1c3BjVEM0VXR5dUd3TXdJ?=
 =?utf-8?B?NG1XaWhrdkg2dUlXSVgwdFMxNGxoaUg2US94YXRWWkZZV0k4N1VqNHh5Rnc1?=
 =?utf-8?B?NzB1TXR4bFNveFhscllkeDh6YkllZW1DOC9uS1JZZ040bDdkcjd3RlgyRWdD?=
 =?utf-8?B?NW9GdFRZZHpJNjBoRGJWRUZ4SmhoM3VwZllyd3V5UnU3QWRYdXE0eHFLanRT?=
 =?utf-8?B?OFNLc0F4VDFsU0l2OVZ1aERSb2laTncxWUdsdVlYNDNUMHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWFocU94V3RyeU9EdStFRWtvL1VjTHFwcHNIeXVnaGp1NVNsWFpWcUxrTXRx?=
 =?utf-8?B?NWtodjdVV04yK1Y1VDlwQUlZckZZZFVtVGNPQXVpWm1tNjlkYWRLWEZKc0RD?=
 =?utf-8?B?WVNDK2NkNmlhV3pOSFEycC9SRGVNVlFXMmQ3N1gyWE5kVDIyaU5MdU5UZm8r?=
 =?utf-8?B?NXZvQkRkc2JTeXJKOTgwU0JxdEFxYTJWaG5GTEhrSU1SZ1EvSEVaNmlpQWhM?=
 =?utf-8?B?YTI4aDFQWnNsN2ZBTGg0b0xmaWhTT2ZFY2I4ZHkyZHZraE94MHVmaW5ZQVg4?=
 =?utf-8?B?WXJpZWtQOGlxdngwTGEzK1JKcUk1ZzVjc3RUREp4N25ZV0tERVBMbEU2b2Nr?=
 =?utf-8?B?NHBqK3E5UVZRRkxhN3hvaVBPNW5abGt6KzlISzFNWUdoNG1YcFNSUjhOeTR6?=
 =?utf-8?B?UlNiVU5QQU1xS2djaVNNMnoyckcxNjlBYTE2SGNiWXJmM28yL3FodCtMVk1R?=
 =?utf-8?B?YzNuWk0ySmVMM3FDMXQwQk9jL2thcjVyNi9CaFc2Zkt5UytsWmpZM3FVbVFI?=
 =?utf-8?B?WWgveXUyTTBQYkdnZGtXRjVlanBEOFI4ZElKcWYrU3BaSlFLUnUxNVNhcVpZ?=
 =?utf-8?B?OVhQZE5KbXpsd0YwVU94WXhuWlZJS00xL0lLUkJodU5WMTN3QnhjSTNuY1VR?=
 =?utf-8?B?RXpvYjFYU0N6bHhSRVRFNU9ERk5nOFpvbzA3YjZRdStxTHd4QmUrcjRNZGV4?=
 =?utf-8?B?dFFJWWp4U1FManJDU2hPQWxha1Mva2pDMC9vNmFoNnlVYlFJcWF6alNKbjVY?=
 =?utf-8?B?QVBGOGMxcnM4N3ZZQzFmbWxCOURyRTlQdUlpVFhUTzErUHpRVDhFTDlPcjQ0?=
 =?utf-8?B?K1NDcEtCVnEvRCtTNm90T2h5Z2JQaFFPYm5JS0NUR1daWW9VMDYwaEhBQkxa?=
 =?utf-8?B?OUorV2xFd09rdmxMVVdWM1FESmRxZGpLclp3em9OSndWdnFJOWhmaytGQnV3?=
 =?utf-8?B?em5pV2RSdVZDcFF0VEgzdnB3akwwLzYveUtNanQ3UDM5VDl6R1hvbERrQTJ5?=
 =?utf-8?B?RWVvMkYxcW1LS2c3UDF5cjdSVDRqT3I4QjJWREFneE1IS2xvVFJxU3JjeW9P?=
 =?utf-8?B?b05PMmdaSElodnFRMXlpMWpMK2t0d1VkaHc2TkcxTW9wYlpoY0NkRjJ5VVdK?=
 =?utf-8?B?d2dlM1JGSXdvSjRnRmhhZXMzMkxyTDhKQmpkeS95R0tENWpTRmo4TDVIZmdS?=
 =?utf-8?B?WDJCc0E5R1V2d2tyeUc0K1V3QlpYVVg5a2d6blhLcXJ6WnRSS2ZlRVJkaXJQ?=
 =?utf-8?B?cEtTS3JuWE1QOUlQOGdzdmExMk83cFpwSUppczZwb1NUUXQxKzNGbDhrTXEx?=
 =?utf-8?B?Vkt1UmFsSTRoYkRXb2JPU0RCQ0doZTkwUFdYVEpjQWxKaGExSEYrWEZTeVNR?=
 =?utf-8?B?T2VobHB0NVhsRy9CcHNFaG1GU3R3eDJjZVNMSThkcVcrNjAxRXZ4S3NlL0ph?=
 =?utf-8?B?cFJPNmw0OWlteW9qMXIrZ3BITHMzaHBQRjhoRytUak03OEFkbWJlcW9pNkN2?=
 =?utf-8?B?NGQxKzhuTlJ0d0JEUTh3REY1a2ZzU0Vpb2ZlZGtoanlYUVFRK2tlNzBNZWRk?=
 =?utf-8?B?eEpkOGZPWlpXaHY2K2ZaTHRBSEZxSnJLREYvbXJyV1drQkVsR3ZqTUZnZ3JI?=
 =?utf-8?B?VDVWQTlTbWVDaENEOU9TUzBiT1czOCtIQzN2OVo4SXVQbHhOeEQ2d0Y2bXNQ?=
 =?utf-8?B?MjhxKzJ6ODhaeVRpTVk3R0hOZzdNTlNzRW1EOS9DR0lvTVFnYVFWMmN3YWpq?=
 =?utf-8?B?Z3p1NmFzNlNZWDFpNEg0VFZ6MXVIdEpGcnhsT1hxZC9kQ0RYU1E0eTlJbTcw?=
 =?utf-8?B?Qklia1UzMHRveEowQUtaYmhxQWJ2U3UrbDVnTzNqVGJzNVB4SWVULy9tdFNU?=
 =?utf-8?B?ZTM1SUdoQjdJT1ZDMUZSZnlBMWZBRFlra2NwTEtGajAreXh4UTdXNmJuTVds?=
 =?utf-8?B?dGFHOXVCRWhGUGlSaysyZTFtU1hrMG1XRmNsNWhQOWhSZEZ2RmRYdUJBMm1h?=
 =?utf-8?B?SDc0OStEanFJN0lhMis5eWVWeUtsMGowaDJ1MFRhRjR2bGlTZjNQcG1JWE5F?=
 =?utf-8?B?RFhBcGZuNHhXTzFkeWNJTjU1ZGl3NXVNN3BIQ05uUEZaZDRDREdsQVJZdlNR?=
 =?utf-8?B?cWREVGJ4N0dtVnNmNVpFVEtYTWVNOWtGdUtSSFlJTWJ5K0swaU1nd25oTVVo?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: be8f1ebc-eb53-4835-196a-08de05bf13e4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:32:16.5549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMsQOGqRXgIU4zvd8VEsJjfgSSAVEb7n0FNk79bwwmVKOl3tsyxKNm85djsUbP84LZQWCsiNokPhrsy+3Xbn6lpa1pv9nQUUe4a6LUCAGe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075

Hi Russel,

On 10/7/25 6:25 PM, Russell King (Oracle) wrote:
> On Tue, Oct 07, 2025 at 04:57:32PM +0200, Andrew Lunn wrote:
>> On Tue, Oct 07, 2025 at 10:32:26PM +0800, jjm2473 wrote:
>>> Andrew Lunn <andrew@lunn.ch> 于2025年10月6日周一 23:51写道：
>>>> Please change it to rgmii-id, and smaller tx/rx_delay values. Or show
>>>> us the schematics which clearly show extra long clock lines.
>>>
>>> In fact, the RTL8211F's RXDLY and TXDLY signals are both pulled low,
>>> just like the Banana Pi BPI-R2 Pro, so the configuration is also referenced:
>>> https://elixir.bootlin.com/linux/v6.15/source/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts#L237
>>
>> Pull low makes no difference to the 2ns RGMII delays.
> 
> To be clear, while the RXDLY and TXDLY are hardware strapping controls
> the hardware configuration of the 2ns RGMII clock delays, the realtek
> driver can (and does) override this according to the phy-mode property.
> Thus hardware strapping makes no difference to Linux.
> 
> So, what we get at the RTL8211F PHY is:
> 
> 	phy-mode	receive clock delay	transmit clock delay
> 	"rgmii"		0ns			0ns
> 	"rgmii-rxid"	2ns			0ns
> 	"rgmii-txid"	0ns			2ns
> 	"rgmii-id"	2ns			2ns
> 
> irrespective of RXDLY / TXDLY hardware strapping.
> 
>>> The tx_delay and rx_delay values were obtained using Rockchip's
>>> automatic scanning tool:
>>> https://github.com/istoreos/istoreos/blob/54746dfdb5bd34d1f281cf41d1d1620d0c3ee686/target/linux/rockchip/files/drivers/net/ethernet/stmicro/stmmac/dwmac-rk-tool.c
>>> https://gitlab.com/firefly-linux/docs/-/blob/rk356x/firefly/Common/GMAC/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf
>>> https://github.com/axlrose/rkdocs/blob/main/Common/GMAC/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf
>>
>> Vendors get things wrong, including this. 'rgmii' means the PCB adds
>> the 2ns delay. Nearly every Rockchip board follows Rockchip broken
>> vendor recommendations, and then i come along, point out how it is
>> wrong, and ask for it to be fixed, before being merged to Mainline.
> 
> Can we at least get the "tx_delay" and "rx_delay" DT properties (which
> are register values) properly documented in the DT binding document?
> I know from the driver code that a value of 0 means "no delay". Other
> values add an unspecified delay - it is not obvious what any non-zero
> value means, or what the default means.
> 
> This would help us understand what values such as:
> 
> 	tx_delay = 0x3c or 0x4f
> 
> and
> 
> 	rx_delay = 0x2f or 0x26
> 
> actually mean in terms of the resulting delay at the MAC.
> 

I couldn't figure out what they actually mean empirically, see 
https://lore.kernel.org/linux-rockchip/96d32ce8-394b-4454-8910-a66be2813588@cherry.de/

Without Rockchip's explanation on what this actually does, I'm not sure 
there's something we can do on this side.

Cheers,
Quentin

