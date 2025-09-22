Return-Path: <linux-kernel+bounces-826909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B0B8F9D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859F63BFA85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAA0275860;
	Mon, 22 Sep 2025 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="f92QqQZ+"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022122.outbound.protection.outlook.com [40.107.75.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463525B687;
	Mon, 22 Sep 2025 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530644; cv=fail; b=gmM68hOY2ZJNSTagpWoeDvubCHHMTT2azY3zkR6orpdFrUsbzYbjm6p52POhtbNLshsAW6vgsixXqXz09qmyAwcE0w+rFoyu21yJQIY1F93We9RWVa3hxUzNUCYhaTLfg9lr6UNAPwfd614rJe8zqrbTYJ/HbYrWqp+AuSjxe1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530644; c=relaxed/simple;
	bh=+qU8rLHBnAP+Tm1KIxRjVwA5iYmpMKVuz0dggMqHxpI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t5ssGETg3MmLGF+m3oUl7xUNhgA9uZckR8Lw7M7hgoRfoLSRU3jiQ+6dMg0AyaaBGJyL0RmFGJdbslz+b9qw5+yy/m3KfLv/AuQfhDOub7g3f3r+nHRaAAGjlDrSZSPaVKtIefvisvmPGMgMrrJL+aLaL6JGmwrP4gvad3SdjDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=f92QqQZ+; arc=fail smtp.client-ip=40.107.75.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0ylmyQtSkib38EXaJi7PPcQNIh57QTQfZ+muP6cYoz6Md4nf+6dERDKtRyteV31qArs8+GFCLVHX22whS5G4oCM2Jzsn4nANVKka85nxwPOtZIR9p3tTPwUihjuLDK1OyvwLMKhAiBwsDMokTm75rT6f4bRF/JXtIX6iQvrR1EOpzNqvIoC3L2hpp0mCobYj1DodzfwYmQAYMU2ccrlliC4HgsAI5x+3GFKhDsUrUlH4eliO1Q19OM8mx63VLzcBd1NIwwPIeWKStIugL6uHlUppxl2awpyKbjyLObS7FyVKgmj8cbBPUv5/xCRX/waZTNzS85ZtpOU+Ez34p5ytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/3Ej/gGpDrwbXh0IG3zItWOIyastlpX8dabf8nZXdE=;
 b=k7xYupYznaI1cXmcPWMvtIe8Cm9tGGuP96OO6DHrmKhw1ly1lmAk4cC1qquJKw8RvUkDWni6/nRvTaaJBloPv9U3G7nONWnFwq0847GXveX/Hoh3qpgsQEHv21HoWF4bsUndJD3qvwF8uYYQRgcHexwGBDaIZrvNLRh6hq+ao3tZiWQmDX0F//GbgvsJF+V2xVTs+QedOCZ9wGZvnIuX5HlMqpulg+ahos3l9YY5En0JFpC2qu61KR0aWkyzYVpQRySZVkEPXqx1Gz6Eq2cl+D8pGgP0moP03fu6v9VV+1avmWAhiSVOaa7LvxzWyL4MC3cH3vfG3uCziJqfxAifNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/3Ej/gGpDrwbXh0IG3zItWOIyastlpX8dabf8nZXdE=;
 b=f92QqQZ+Km0J1JlcLMrGiTJAdf5H13dITACDXsGpj5Me3g+bAjAJ67Z03OvIzzGEUcd6DalfUZzmaYBT5TNvQQiZKGPZrU/0eMU6K5cAeD4Rrizwp/EMVhOMPV/ZQSkGT86kN7U6fLb3nmHCCYEHQhlAnAS5cHQjBfLWES7dDpZb1+6j4n3esC5rtB/uitBclRzWrKrR1URlMhuWln1UKsZ7KbYLB7DZBVnYx1QfJQVouauvnhXrHcUgSETz6aE3KiCA9QRreyp141md+OQEeoguc4ACrgbWqnFnoKlr7w3KequSiSkkL1f9ez3hF+Uqzfg4grH/Flzfp1gCNL4XVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYSPR03MB8627.apcprd03.prod.outlook.com (2603:1096:405:8a::9)
 by KUZPR03MB9360.apcprd03.prod.outlook.com (2603:1096:d10:21::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 08:43:59 +0000
Received: from TYSPR03MB8627.apcprd03.prod.outlook.com
 ([fe80::cf16:aa54:9bd5:26f]) by TYSPR03MB8627.apcprd03.prod.outlook.com
 ([fe80::cf16:aa54:9bd5:26f%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 08:43:58 +0000
Message-ID: <b16a6936-b6b8-44cc-9c9f-3415cef54b29@amlogic.com>
Date: Mon, 22 Sep 2025 16:43:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] dts: arm64: amlogic: Add ISP related nodes for C3
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250918-b4-c3isp-v1-1-5f48db6516c9@amlogic.com>
 <36345378-6fd5-4a48-b5ea-0fcb6abda7ba@linaro.org>
Content-Language: en-US
From: Keke Li <keke.li@amlogic.com>
In-Reply-To: <36345378-6fd5-4a48-b5ea-0fcb6abda7ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:d10:33::8) To TYSPR03MB8627.apcprd03.prod.outlook.com
 (2603:1096:405:8a::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR03MB8627:EE_|KUZPR03MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 89921cc2-64b8-4b9d-a7ce-08ddf9b42c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDdnVkZJNjBMSFBGRGpoMFlCM1J3ODdtTjIzOVZTbHE4NDljUGtmdG5OYVJp?=
 =?utf-8?B?VHFkMmlScHBPVXBMaXl4Z3ZWWHVodmdEQy9ldS91Qjlkd3NINlFQTTZaeFBS?=
 =?utf-8?B?aHdBdThtOU1scng2Qm5qT1BWTnZyenR6QVJRWGUyUW1LZVo3KzZJTzd2c3Ju?=
 =?utf-8?B?YlQvRXNQdnZ0cFdDanliWHVtUzRFd2tvU1BFa2tTZUpsMlJTZjVrRFFpb0RN?=
 =?utf-8?B?M3UyR3d3Qm1iU3Z6cjdGTUFVS00wdmNjRE9LM0F2SUFCcVRndEk4NW44L1hi?=
 =?utf-8?B?R0ZRYVZEUlRvV0Yyd2hFSjFRR2kyRm5xRFZsS2wzYkU0T0ZPMEczRGZaSVM4?=
 =?utf-8?B?d24rcFRjTVFrQ05YL3F2TmxkMFkrWFR3VHFoN0hwSGdGanYrUnQ4Tm5PdDRN?=
 =?utf-8?B?WUFSVFNNRHlEdE5WVG8xeUp2U2NodUJuam5ib0VqaGR0a0xDQ2hGKzFRdXpF?=
 =?utf-8?B?cDgzOGNuWEU0ZGxXSkVVYU9GWXRnam5iaEY2SkwxWk5xVklBMFNMdTF6N1la?=
 =?utf-8?B?NWh1d3I4RVZBc2JkV3dYc0dUTmh3Z1dINmoyeUVlZjRHSG9Bc21qUU5Edmdx?=
 =?utf-8?B?TXFKRGVpTFpqYllydnptM1RjZHg1SEVXY2pXRU9RUkVYWjVQdGE5aTNMZFdp?=
 =?utf-8?B?NGFCNzFxdndUR2hzanNhMWRMTEJBbXlpOWhndHBMK1BEYlFUMW1yeEhwNEM2?=
 =?utf-8?B?TnZzUHdrTHJPUkVFODZWRnJGZ1c1UXZiaUFqVWlEb1M1QVZVRXNkTmVjWmg1?=
 =?utf-8?B?U1IyTFREVkhZekM4UFZudXpsc0p1N1REK2NCRk1ZdzlnY2xJWDBmL0hucm14?=
 =?utf-8?B?dmQ5THorUkl5THc2VXBvN3I5MytPNzFVYkhZRGVTQS9Ub055ZnNxY2MyOEFl?=
 =?utf-8?B?aGZ1WEYzTE9zanBTUFFIUmdoSlZHYURwdUhMUFBRbmprcVJvMXpXdFpMVCs2?=
 =?utf-8?B?Z0REUHliK09neDVBQnN0ZjhDdmtNV29PYTJaQytxOWFiNmQvb21uUTFPaW9Q?=
 =?utf-8?B?bUY4c1N1WjBrWkV3ekRqZzI3VXhNMDNmeVhtMTJITGJJazhUMHNORmN4ZUZX?=
 =?utf-8?B?d3NuOHFCamtGa09kSEs5MGkwdEpOZ3hhQTdoVmFsRVBTbHV4OVJ6UGhvRU9E?=
 =?utf-8?B?V3d2Nm1QTHlyMU9UdVhTaVVFbTVPeXBiMUNIQlhXNVYrSnJaYWNQdXZDZWN3?=
 =?utf-8?B?SVVrdUlndzVNUW5jeEVBeVNPVkJWdFIrVUs0K3lqT1VVbE0zenI2ZDlwQVVI?=
 =?utf-8?B?UlNYTGUzSkhLandDdUpML2VoaEEzWHpvU2djaGNLbFlncGI5dWNSc0FRSTJj?=
 =?utf-8?B?bWN2ek5zazVOVVNzMVdyL3NVNk1LZ0NTdUNOOXdXRVNoVnVWZW5RaWhMM3dR?=
 =?utf-8?B?R0d3djVGMWZSY0psb2I0U2hKT2ZVblo2TTkyNW0yUWR3NElGdG9wNHFENnp3?=
 =?utf-8?B?OHpody9pSnhmTVp1Nno0UW1ERG1NMENFeDhEa2laNU44MmQ2NWNhUm0zTUFn?=
 =?utf-8?B?aW5wb1BUUHROSVhmdVdDbkFwRHRRaExiQU5VUCtmb2RXd1Jibk00N01uMk8z?=
 =?utf-8?B?UWgwZnFWV2x5a2NDbWRsL3Exd3pqQy8xU1BDSm1pTCtXMDlsU0ErcDFqNjBo?=
 =?utf-8?B?RHBsZ0pyWHRWelVRLy9DWDVMRFVjZVF5V1pCaTRldmFkRDQ0emVrLzBMNGdZ?=
 =?utf-8?B?aDBvbUcxaEhSOTdtcE10Ukg1ZWZScTFpZzdDTE8xZy9QR1AvbENOckUvcjlQ?=
 =?utf-8?B?Z3oxOVE0TFFhOWpDL0YvUzlMR3VNOURCVC80cHdzK3V4TVlvRHMwbDZDY3I3?=
 =?utf-8?B?eVlCNjErWXZSMDBib2dOS3FlbGplQjg4d1d2Slp0bnJYQlcrcVRiR1c4cGhz?=
 =?utf-8?B?Rk9lR1l5cnRXRmJhTUViOGNDV21ud0UwQjBlcEdVbEhWWE9SZEtZTDNGZFVD?=
 =?utf-8?Q?QULXieK3xPI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB8627.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmF1NmVKZmxpajI1Wm1qSk9KYWw2bGh0NDA2a0xENE1pTlgwcGhQU1hydGEv?=
 =?utf-8?B?blNPYWlweXIySzFMZjljRTJpRGU4Q1UrSjFGYW9rZ3BjUWdwdjdmRkZiS1R3?=
 =?utf-8?B?Y1UyVHdRK0VDNUVZd0VYRk1yYTI0bm5UN0RDbW9RNXlBb3F2NFRXcnYvOHBS?=
 =?utf-8?B?QlJMTVNtK2h1YVd0M0lVRzBETVY2QTZFa2REUVY0SnFuV0lRZzZWdEw3cFBT?=
 =?utf-8?B?cTNFVmZwN1FRSm1iUERqVFh3ZlplR0FUK0haSlhId2wvNXpjZ3oxOGNjOEhy?=
 =?utf-8?B?ZE5EWlkveUNRT1lNRk56ajJyN3ZhTEUwY2FwVjZZVXJ1UDdqY0VBM3phTUpE?=
 =?utf-8?B?QTVIbkk1TWNDS1Njd3dPTjBjQks2S2RnQmNCVm5vQnRuWkRCZ2UvSGdYaWhX?=
 =?utf-8?B?K1k1d2V1dzR2REdjbmgzSS94YytUUVEvOG5rWld2VlJ0OWNqWVFTNVZhYm0y?=
 =?utf-8?B?VHdNU2ZlVGJTV1dRRkxzSEt3Rm9meVZmbXA4QmJXbXprUWtvZm15Lys3RDBU?=
 =?utf-8?B?T0JYTi9ad2lINyt0SFFpcWRCWkllbGRBRENGMiswVGpqaTgrWHM0Mjh0K0dq?=
 =?utf-8?B?SDVaQnNoeGg4bnlLdDg2eEdjakkvK3NxeGpwdk5wRCtLZFFFMlYyWnBFUlQr?=
 =?utf-8?B?M3hoL1BqVFJHQWc5cklVMkE0bHUrZnVuK3NDZUt6UUlQYmZkTWhqeDlzOUpR?=
 =?utf-8?B?RE9qU1dRblJHSTlqTk85RHZoT0pZcDl5MHJPdmZpc2QwVWJDc1AwOW0zMDFR?=
 =?utf-8?B?Rk9tYkN6R2xYdUU1c1lZZE9vOXhFTk9UZUd3eENsNE15dCtDTjdFcVhkeWQ4?=
 =?utf-8?B?RXVkcTVrRVVtcnpsdXIxU2VGamYxc1RzWEVFanZ0S0hiRStrVHdjeFhlYnJ0?=
 =?utf-8?B?ZzFmZHlmcWUxZkU3WkZzSHpHWldqQjl4M2lxcG9ydFBaOURuZDhDVU9qemlr?=
 =?utf-8?B?L0tlRHNYMWJ3KzBwRkkwQ1c1SW4zYzZwZmpBdTVYb0EwRmx1Yzk5K3p3SVZX?=
 =?utf-8?B?Vk5xTDFwYWk3M0pHVklxN2dFek1OUFVucGNkN25YYTdLb2VUTXh5RitxMmVC?=
 =?utf-8?B?ckNKeCtUaU91dkR2aGR2QVVDWmpiUnQvWWtNS0YxbFRhSjlTTm82UFpIblhJ?=
 =?utf-8?B?aEhzOWJQcmxxVWQ0VkRzTW5BSHRkVEZ3Z0FtSEN4U2wxQ3J0SEthZjlidCty?=
 =?utf-8?B?eWllV2JpcU5pYnBsbTdYd2p3bXZFT3ZEVStqRTBhR2dlME5nbFA1MUJYSVJz?=
 =?utf-8?B?YnZQdGdtVWVpQy90OW9jTGNjWk9JSG4xc2xlakVGd3U0dUM1eU9yQklnWk5j?=
 =?utf-8?B?SFViejZpN3FDUXA2WjVsSDlhQlZmRmV6b0dUVkRRelRPV3U5ZWQrRkdVcEcy?=
 =?utf-8?B?SWdrTGdMUlpXVzl5VmtGRmFQYnh5UXhnVmxsMm1Qc1pUSG9uZTBPNWhOekFq?=
 =?utf-8?B?UXhObVRKRzhTaXByNTZ2dSs0STkzaDZFVFRzS2dlV0JZZWs0YXA1OWpkbEJr?=
 =?utf-8?B?MkN0TndFTE90OThjcW5OT25EOHZTdEp1QlhzYTZ0RmgrUkR1cVJYSUo2T2hr?=
 =?utf-8?B?ektraTlvQXh3dnBXYWhvaVNBVFNjSS9qUmdpTzRpRHFqOGQrZUNXQXd4bjhi?=
 =?utf-8?B?VDg1Mm5pZk9WY2MxK0RaUFRycElVeHl5bTZGNC9WUjlvSmo0NG9hUnZkay9Y?=
 =?utf-8?B?TmZKcTBlbFEzN2VtZCs4U0djM0VvUjhYUjNNN3BadzRhVEJ1TnpLTWpmWEF2?=
 =?utf-8?B?RzZRRk5JM1pPK0FnMFA2cFdPa3p0SHNiRFJnZ2NPZ2tUT0N6a3pDVVhPTjdo?=
 =?utf-8?B?NFljK0pDaGcySWtLcDFOMVFEbFE0K0lEblArTlR1TGh6eSswU2tKM2NJMVlD?=
 =?utf-8?B?c0l4a1YxS2s4S2ExbHhqNlQzckxaYTcwc0gvWUoveXRXMERORjFYV3Z3V0w3?=
 =?utf-8?B?cGJTemtEdENHMFRyMUN2NHl2RWNsZEpVWWpHZWNieHdNZ05ZRUtuR3VrbDRh?=
 =?utf-8?B?VWhxMGRRaFJMcXVVQUVERnFZTUZjVllOakNwKzhPU2t3US9GOU5FSkF0NnpD?=
 =?utf-8?B?M1A0WnZDczlSTGx1QnIwemV1QUd3ZW5lK3RTV25vRUZzOG1kYkJOL1Nrakxu?=
 =?utf-8?Q?4KO/r4WisckUd6C2yEvQQ+9E4?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89921cc2-64b8-4b9d-a7ce-08ddf9b42c2d
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB8627.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:43:58.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ri31ljwFlzF2mVOLL9iLpwQdG9dS9Ao6R10M38Sofrtvvyz9kTzjGGSvbrlceZXmEQsMIVPdmXY+/9MidDmVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9360

Hi Neil

Thanks for your reply.

On 2025/9/19 22:43, Neil Armstrong wrote:
> [You don't often get email from neil.armstrong@linaro.org. Learn why 
> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> [ EXTERNAL EMAIL ]
>
> On 18/09/2025 10:35, Keke Li via B4 Relay wrote:
>> From: Keke Li <keke.li@amlogic.com>
>>
>> Add the IMX290 sensor node description to the device tree file,
>> which will be controlled via I2C bus with image data transmission
>> through MIPI CSI-2 interface.
>>
>> Add CSI-2, adapter and ISP nodes for C3 family.
>>
>> Signed-off-by: Keke Li <keke.li@amlogic.com>
>> ---
>> The C3 ISP driver and device-tree bindings have been
>> submitted. To facilitate using the C3 ISP driver, the
>> related device nodes need to be added.
>
> No need to resend until the bindings are merged.
>
> Neil
>
https://lore.kernel.org/all/20250427-c3isp-v9-1-e0fe09433d94@amlogic.com/

https://lore.kernel.org/all/20250427-c3isp-v9-3-e0fe09433d94@amlogic.com/

https://lore.kernel.org/all/20250427-c3isp-v9-5-e0fe09433d94@amlogic.com/

The device-tree bindings for C3 ISP have been merged into the Linux 
kernel v6.16.

Thanks.

>> ---
>>   .../boot/dts/amlogic/amlogic-c3-c308l-aw419.dts    | 84 
>> +++++++++++++++++++++
>>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 88 
>> ++++++++++++++++++++++
>>   2 files changed, 172 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts 
>> b/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
>> index 45f8631f9feb..e026604c55e6 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c308l-aw419.dts
>> @@ -17,6 +17,7 @@ / {
>>       aliases {
>>               serial0 = &uart_b;
>>               spi0 = &spifc;
>> +             i2c2 = &i2c2;
>>       };
>>
>>       memory@0 {
>> @@ -146,6 +147,36 @@ sdcard: regulator-sdcard {
>>               regulator-boot-on;
>>               regulator-always-on;
>>       };
>> +
>> +     camera_vdddo_1v8: regulator-camera-1v8 {
>> +             compatible = "regulator-fixed";
>> +             regulator-name = "CAMERA_VDDDO";
>> +             regulator-min-microvolt = <1800000>;
>> +             regulator-max-microvolt = <1800000>;
>> +             vin-supply = <&vcc_3v3>;
>> +             regulator-boot-on;
>> +             regulator-always-on;
>> +     };
>> +
>> +     camera_vdda_2v9: regulator-camera-2v9 {
>> +             compatible = "regulator-fixed";
>> +             regulator-name = "CAMERA_VDDA";
>> +             regulator-min-microvolt = <2900000>;
>> +             regulator-max-microvolt = <2900000>;
>> +             vin-supply = <&vcc_5v>;
>> +             regulator-boot-on;
>> +             regulator-always-on;
>> +     };
>> +
>> +     camera_vddd_1v2: regulator-camera-1v2 {
>> +             compatible = "regulator-fixed";
>> +             regulator-name = "CAMERA_VDDD";
>> +             regulator-min-microvolt = <1200000>;
>> +             regulator-max-microvolt = <1200000>;
>> +             vin-supply = <&vcc_3v3>;
>> +             regulator-boot-on;
>> +             regulator-always-on;
>> +     };
>>   };
>>
>>   &uart_b {
>> @@ -258,3 +289,56 @@ &sd {
>>       vmmc-supply = <&sdcard>;
>>       vqmmc-supply = <&sdcard>;
>>   };
>> +
>> +&i2c2 {
>> +     status = "okay";
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&i2c2_pins1>;
>> +     clock-frequency = <100000>; /* default 100k */
>> +
>> +     imx290: sensor0@1a {
>> +             compatible = "sony,imx290";
>> +             reg = <0x1a>;
>> +             clocks = <&clkc_pll CLKID_MCLK0>;
>> +             clock-names = "xclk";
>> +             clock-frequency = <37125000>;
>> +             assigned-clocks = <&clkc_pll CLKID_MCLK_PLL>,
>> +                               <&clkc_pll CLKID_MCLK0>;
>> +             assigned-clock-rates = <74250000>, <37125000>;
>> +
>> +             vdddo-supply = <&camera_vdddo_1v8>;
>> +             vdda-supply = <&camera_vdda_2v9>;
>> +             vddd-supply = <&camera_vddd_1v2>;
>> +
>> +             reset-gpios = <&gpio GPIOE_4 GPIO_ACTIVE_LOW>;
>> +
>> +             port {
>> +                     imx290_out: endpoint {
>> +                             data-lanes = <1 2 3 4>;
>> +                             link-frequencies = /bits/ 64 <222750000 
>> 148500000>;
>> +                             remote-endpoint = <&c3_mipi_csi_in>;
>> +                     };
>> +             };
>> +     };
>> +};
>> +
>> +&csi2 {
>> +     status = "okay";
>> +
>> +     ports {
>> +             port@0 {
>> +                     c3_mipi_csi_in: endpoint {
>> +                             remote-endpoint = <&imx290_out>;
>> +                             data-lanes = <1 2 3 4>;
>> +                     };
>> +             };
>> +     };
>> +};
>> +
>> +&adap {
>> +     status = "okay";
>> +};
>> +
>> +&isp {
>> +     status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi 
>> b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>> index cb9ea3ca6ee0..a62fd8534209 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>> @@ -992,5 +992,93 @@ mdio0: mdio {
>>                               #size-cells = <0>;
>>                       };
>>               };
>> +
>> +             csi2: csi2@ff018000 {
>> +                     compatible = "amlogic,c3-mipi-csi2";
>> +                     reg = <0x0 0xff018000 0x0 0x100>,
>> +                           <0x0 0xff019000 0x0 0x300>,
>> +                           <0x0 0xff01a000 0x0 0x100>;
>> +                     reg-names = "aphy", "dphy", "host";
>> +                     power-domains = <&pwrc PWRC_C3_MIPI_ISP_WRAP_ID>;
>> +                     clocks = <&clkc_periphs CLKID_VAPB>,
>> +                              <&clkc_periphs CLKID_CSI_PHY0>;
>> +                     clock-names = "vapb", "phy0";
>> +                     assigned-clocks = <&clkc_periphs CLKID_VAPB>,
>> +                                       <&clkc_periphs CLKID_CSI_PHY0>;
>> +                     assigned-clock-rates = <0>, <200000000>;
>> +                     status = "disabled";
>> +
>> +                     ports {
>> +                             #address-cells = <1>;
>> +                             #size-cells = <0>;
>> +
>> +                             port@0 {
>> +                                     reg = <0>;
>> +                             };
>> +
>> +                             port@1 {
>> +                                     reg = <1>;
>> +                                     c3_mipi_csi_out: endpoint {
>> +                                             remote-endpoint = 
>> <&c3_adap_in>;
>> +                                     };
>> +                             };
>> +                     };
>> +             };
>> +
>> +             adap: adap@ff010000 {
>> +                     compatible = "amlogic,c3-mipi-adapter";
>> +                     reg = <0x0 0xff010000 0x0 0x100>,
>> +                           <0x0 0xff01b000 0x0 0x100>,
>> +                           <0x0 0xff01d000 0x0 0x200>;
>> +                     reg-names = "top", "fd", "rd";
>> +                     power-domains = <&pwrc PWRC_C3_ISP_TOP_ID>;
>> +                     clocks = <&clkc_periphs CLKID_VAPB>,
>> +                              <&clkc_periphs CLKID_ISP0>;
>> +                     clock-names = "vapb", "isp0";
>> +                     assigned-clocks = <&clkc_periphs CLKID_VAPB>,
>> +                                       <&clkc_periphs CLKID_ISP0>;
>> +                     assigned-clock-rates = <0>, <400000000>;
>> +                     status = "disabled";
>> +
>> +                     ports {
>> +                             #address-cells = <1>;
>> +                             #size-cells = <0>;
>> +
>> +                             port@0 {
>> +                                     reg = <0>;
>> +                                     c3_adap_in: endpoint {
>> +                                             remote-endpoint = 
>> <&c3_mipi_csi_out>;
>> +                                     };
>> +                             };
>> +
>> +                             port@1 {
>> +                                     reg = <1>;
>> +                                     c3_adap_out: endpoint {
>> +                                             remote-endpoint = 
>> <&c3_isp_in>;
>> +                                     };
>> +                             };
>> +                     };
>> +             };
>> +
>> +             isp: isp@ff000000 {
>> +                     compatible = "amlogic,c3-isp";
>> +                     reg = <0x0 0xff000000 0x0 0xf000>;
>> +                     reg-names = "isp";
>> +                     power-domains = <&pwrc PWRC_C3_ISP_TOP_ID>;
>> +                     clocks = <&clkc_periphs CLKID_VAPB>,
>> +                              <&clkc_periphs CLKID_ISP0>;
>> +                     clock-names = "vapb", "isp0";
>> +                     assigned-clocks = <&clkc_periphs CLKID_VAPB>,
>> +                                       <&clkc_periphs CLKID_ISP0>;
>> +                     assigned-clock-rates = <0>, <400000000>;
>> +                     interrupts = <GIC_SPI 145 IRQ_TYPE_EDGE_RISING>;
>> +                     status = "disabled";
>> +
>> +                     port {
>> +                             c3_isp_in: endpoint {
>> +                                     remote-endpoint = <&c3_adap_out>;
>> +                             };
>> +                     };
>> +             };
>>       };
>>   };
>>
>> ---
>> base-commit: 84b92a499e7eca54ba1df6f6c6e01766025943f1
>> change-id: 20250731-b4-c3isp-16531391a1cb
>>
>> Best regards,
>

