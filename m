Return-Path: <linux-kernel+bounces-782281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678A2B31E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4C0B25FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECCD21CA14;
	Fri, 22 Aug 2025 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="GKya4y1V"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C5210F59
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875805; cv=fail; b=Ir/XCxgksKETgQg6Mf1BYGFtmIH2ES7LWJWqyTIeuZOJ0S7CNMm1AgnIXnL3tTRBiP16IB3NSyl5QPLD1N2dBLiCcwUliPIRp/TnnHZ9mAdj23AMJnwi0+O5yPUDoXpXCikSM26sSbno86Pkog/uOYuxnAupF80wisjknIHpTQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875805; c=relaxed/simple;
	bh=xJQ+sRFCuHDU7pZ8/WvoPEHgptmeBFRWwS7DQyjpBBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cphgjzHr6sk7apXf7YMNqRibKCARA/nsKBAWWy3zyJ/oWRBYkc3pHWykRqhMegqEn7hnatk17Yn1ykbvi5ZHLwh8Ldru1OQjBGaCldWCkMJKWfG/WKcGM7LbWAHHSgY9kgdYb5KSPEfqoYnZIS9X5zZlzckf6wj3cEQ1zqyrfDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=GKya4y1V; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQP5Qyxz3Ly0DVkkCKA6vTn/ygnoxbSTLCd59EFXYBRUOpZgVODgiTzVIHrTfyAdWe3wM1sXvlt3vUZ2w3qKPTyg/lQSEXPNImuNxU20YZ/Gni5loFbY0Y/MNwKdyN3BjpCJmkS9e1b6gnqXiwGPsd8gAVFoSDyaffOdxL+lThVKngVB+rKYHA31xFIPhSERQ9b1fkDs+ZGRQrLcY1DLuU0UJCTv4Evf/UOmZKzNWqLxub5W/t9ZpcpBf9dGmuwR+YTJMxD4eqjDzcpsiLUr0D1EmGhCNqUCiyTpCddnHLtrvMrb5DYVlwZP5i2aTG3TRShXVH8imbN+F8xUqeKlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIHVDF8QQlCks9V6F+liau1sTtCG+DcsAV1IQLLMJbw=;
 b=lJiEnG2XL+MbHdV1whpjq/Nqcx/y5jQOv9Yk2cjJVNV4gU4GjZZ431bJrXcLgxaRfG5r0kIO4EIXoiZQy8VZ3x6V4HFXeg5FTFBh4MlRNm0jgPjAQLsiBJFdFGuEYuUH/3D1sBm+Al6MLOwFHrqXMbnE6OyNEACsc5SELsj3tq4oiAKAE2f8K3snmBDFbdT71y8up51SSIcPx6/mSP7Kyl2LiPzFO85hI0NiHdl6SwZoAsqgjwvjQ/2+7+MgYO4mgf+KRqJQs3oE/AYNH05oo87SAd+PO2sr/DsDHghCvVvy17AmjlL5Q7IoHl3IOt6T754NNSaqkDrzMXYc7isUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIHVDF8QQlCks9V6F+liau1sTtCG+DcsAV1IQLLMJbw=;
 b=GKya4y1VLh/cCNr3t6J6eAwR2EV3fPdSSqrEZq/EJb3UqUb+htGq1ggtrWZY7kJiXruRZyAMBxg5CClj7P72L/Mh9fZrg9PjhHJUwmybWN+WJM9AdC57u1TFarmv2QvoVaSK2DrCT4Do3kTHguHZi1+QireiPvucbxhYQ4LCpdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10374.eurprd04.prod.outlook.com (2603:10a6:102:41e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:16:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 15:16:38 +0000
Message-ID: <d784230e-49f4-49e9-be4a-bc7c00020cfb@cherry.de>
Date: Fri, 22 Aug 2025 17:16:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: enable NPU on rk3588-tiger
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250812085213.1071106-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250812085213.1071106-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10374:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d5f50c-77aa-42b9-96f1-08dde18ee3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEtJMDNtaTMzOWhZcllRMFE5ay9acXM4ZFBLZTczWWtkNm1aZzIyZm42ZTh0?=
 =?utf-8?B?MTFsSmtyVU5wZDZDL0JOZ3UxUVdYSkFFdUw1Nzg4RE94ZHY5VHgrMVZMbW04?=
 =?utf-8?B?NUR2TVhlMS8xREJnRmdjYTc3K0hZQXQ2bysvc2RwODBxQWZFVGlYSUZ4eHNv?=
 =?utf-8?B?UkhwMlNKVjYrQ1dITWU4ZlVBaVVBTTlHM2JaM2NlRVZ3WE1HQTVyTjlVME5n?=
 =?utf-8?B?UHE5UW1VbXVKY21nQlpLbjBVYlRxMFNyOUtQMXk5MmZZVFBHdWd5SG1zT0t3?=
 =?utf-8?B?ZnRGNFY5Wi9TeDRyeWFFZXpvY0c3OUJSOFdLb3RaSlJBamRYK1Z2SGtjMTZU?=
 =?utf-8?B?TWpKTzVSU3hYZjdCS0N1ci9wN05pcXVBNllicnBobVB3N2hBVEViamdIb0hj?=
 =?utf-8?B?M1hFdnNIcGY1RS8vWi9FVHNMaXVKK0Jva2sxTGZBU1dTdVExb2VXblVMVG84?=
 =?utf-8?B?dXZ3cngxQlBER1NGTEMwaWxDNDVWeHJxSFJxNUVJWXA3T25ZSmJBS0M0TUh5?=
 =?utf-8?B?NVpRTnhnNmszL3hIZ0J3UUVUM1JveGE3clNTcDdzbWRDNEtQdHZKcHhsR1R4?=
 =?utf-8?B?bGlHb3d1aE9Ea3pYZ0s4bjl6U28vWUNERlVrS1J0VUg0WXlDZGZRMzhocHNC?=
 =?utf-8?B?c2YyRjJvV3VDcktjZk1aYVE1a0Z6Y3BIZmNySUNscnlpUUpsN0x3bURkYjhV?=
 =?utf-8?B?MEJGZzVtdU96VHdjbnlycmdQQUxVd2RWTEVKZ3VvVVUvM3BHVDhWT01YN3J1?=
 =?utf-8?B?ZEQzdy9kYVliVi9qNm1tS2VJM1h5RlVSUDhKOWs2REg0TkFIcTZWcXFVdDFE?=
 =?utf-8?B?Um1obE84Tko1L2VhVWhCZkdBOVJ3ajRYd0crYUd1MnIrZHZydkpmTGNsWkha?=
 =?utf-8?B?d0tVZkZVUzRwVGYrU1FXaFB3N3F3QXBuWFdjbzFCMk4rZU9PUUl5SStaT1ZF?=
 =?utf-8?B?a2s3ak52QXRjeW5wem40RTZkczZBVngzTVpFZmxmb2FnVHhWMFU4dDNiM0xh?=
 =?utf-8?B?QWJLSU5FQmFlR3BXMWRqTng2MFJNQjVETEVSWWlIZjJ2akRxcWlyN0pCN3FM?=
 =?utf-8?B?SzlybDdWSW11dHZTMGdVVkxDekU4SjFUT3JvN0NBMWczVll2V0JiRHJQcUc4?=
 =?utf-8?B?TVM2LytBcTJvN0dmRzUvc093OU1PMEpzYndNdFFnTGxRTlRnOC9vN0F1NXRR?=
 =?utf-8?B?MTVQWHlBQkVzQzVSSTk5cXFxQzRPL21CYS9raG12QzN3THZlZFgrTW9NbThl?=
 =?utf-8?B?TVZLZ3ViSVEzak5kc1FJSHRJTDQ0c01XMnlZaUoraDZkUWpBTk9JN21qTGtR?=
 =?utf-8?B?SUJUdEY5V2pGcVg4V3p6c0xQWnVJeUJ6WktVQU55aitjNmRvcmM1RXZsU21C?=
 =?utf-8?B?Zkp5bXJWZ1ZaNGxFT0U2N1NsaldKdThsRHZFK2hNcWtKT0Z1QjR0ajJ4SmJa?=
 =?utf-8?B?V2ZLcEZmUlZJR0xxWFMxVitoM0F3Nzhzb0ROb2duMUl5L2VKV3lmNmpnSU1M?=
 =?utf-8?B?L1FPa2pLMEt2Uk9LYXpOYW5zRWg0alF6TFBuYXRNSEpOb00xQUhHbk11T0Z0?=
 =?utf-8?B?cWVBZmMwQ2ZDdm80M2pNbTQ1eGJZdk43TmNpV3V2WWhuajVPeklrRUlYMnNl?=
 =?utf-8?B?QThLMFlaMUo3VzNWbmZnVGVuMXIrcFRrbkI4Vk82L1AwUFNNL3lZNDdpUUZV?=
 =?utf-8?B?UFA2Q041ZFMzZHVid1Z4bHBNeXJET1ptcndmbExtbU94TW4wc1JzdThIK1l1?=
 =?utf-8?B?R3N2cHF5SExBYy9MZW4rTzZwY0tHZXFuVjRDbUtWcUEwWFFDYkEyZWVLaWp6?=
 =?utf-8?B?RGQraEl3ZmFvNE1xa1dRcFlVc2d1elpkdndNQURUdTZuNVRFL0JJb09za2E5?=
 =?utf-8?B?TEwydXZsZTREbDJkbjVSbDVQWlNlRm9PWjFSWkR6UTR3UlJTRzV0U1ZvSmZq?=
 =?utf-8?Q?CEFU+yhJwwk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzVRUndXcDl3NkhRd09ieXZrOGY1UFdwaml5T0UxQU5mcVJwS3Vtd09QclRy?=
 =?utf-8?B?QjcxOG9odFRPS1lUSVhzTmZ3YitXcU8wR0pWS1AvNWV2akx5NE1zeisyUkNy?=
 =?utf-8?B?MFZzRWllSFZFK2J4b2dYWjNyOHpiT3JoVUpOcVd6YlhjcGJTVjJGQXNaUkdi?=
 =?utf-8?B?T29kblREUzFHckMwK3M5YmJlTGU3K0NDRmx6Snk4UG1OUTBRcE05VUFpYUJr?=
 =?utf-8?B?anJpNGhGYzFVQkp4OGFCVlJHeGoxT01oajNEeDg5cHVaU1NWSFA1SzZvMUEw?=
 =?utf-8?B?b3JyQUpaaWJ2emJXTDc5Wm80V0Qzczk1STV2dFRDVUVhQW9LNFdDbWpXcEhV?=
 =?utf-8?B?blh2Qm5QVFdqTS9WMU1veDZET1Q0c2ltVTIzNTQ4TUM5WU05WWgzNDhnZTFk?=
 =?utf-8?B?VW5jSnE2V0tuYjdlUjBqSjhzOTg3NjZuY1lUZWlnNlIvYjdrSlp1NkFnRUN4?=
 =?utf-8?B?ZkUyTHdhTEc2T1E3ZDJXdGgwNm5IbWZyZWJka2t3Z3B3YlJ2dUpxeDdERFlk?=
 =?utf-8?B?M0MrSHk5TWgwbVZBL1ZYVUZ3aFgySWVtdDNtQWRZZGdPSlhHMzlUcjFHS2xT?=
 =?utf-8?B?MVVWdER3T3FXTUpybFU2UGwzdDFpVmtpeitQNWlJZC9nQVhUSTkxc3Nta2pV?=
 =?utf-8?B?cjc2QnBZYWJqdDZVN3VFc2x6dHhIdFNGVlRtN21OY1JDWHBqYlNScnpndEdh?=
 =?utf-8?B?WWplOXdFWllIemNWMWFpY2N3dWRZaGRCK2dFTkJMQjFQSnNobS8ya3dCUXBh?=
 =?utf-8?B?MFRoQmpQU2phSzVrakRuN2phQkY5VnN5WUZaUnFacHdmcjU0b0g5TkFpVlh0?=
 =?utf-8?B?TlRLMlR3a0srMzBDaGlIRzRRSlZITkh1S2FreFA3TC9wWXFSNk5HWkhzUzBm?=
 =?utf-8?B?bHpjemRaNGJoUkpWd0ZSRm52bVlsUjM0b21mNFdOSjNQN2xlNk1QZUhkWVhq?=
 =?utf-8?B?a2RYRm45Z2pmdkNMYUJzeEg0Q3E4RGptdGwvQlBVN29NOHRYRlZCeU1SeHRn?=
 =?utf-8?B?MzNRdEVvWDRhS25JZHJGeDFOWHlhQ0U1TUxxZEdYem9YRXBNYkl0L29QQU1k?=
 =?utf-8?B?aUtOU0NRcDl3RzhjM0Y1WkRxaTE2czB0aHhuaXljQVVMVVcyNUE0Um05cVZI?=
 =?utf-8?B?VjVGd3VEUnljR3JLQzB2WE9YcVcxT3k3QktnOCtrd1RKaG54dHpidU83cVFC?=
 =?utf-8?B?UlNSNXE4bTAvNDdpZ0Zsc3QzOUJJZ3czQjM5ZzFvSGJpbzBZRkNxaWJiZzVl?=
 =?utf-8?B?cjNMUlhJQWwzaWNYTGVaZEVvRXVCZ2VHcWJhbzNrZ3pNNnYrRlYvNzd0R0tK?=
 =?utf-8?B?WGh3Qk1sMktXejdLeFkxbGNjd3pqWkw2WUU2ODkzaE5SZ1N5bzF5RXQzenhL?=
 =?utf-8?B?cVljWkRBMldNMUFtWk8zdFZkV1hsQit6c0VBdjlQWmFHZXJYNVdwaEswRVJj?=
 =?utf-8?B?dVlKV2FsTEVXb3ovK1VBMGFBVDFRV0RlRUJpM0lXeEg0c3JBTGJxRTl1N1Vo?=
 =?utf-8?B?NXpUUFJ2NUc5ZW1ReW1JaVdIT2V1RGhMMFBMWlhZWFJnQnlFWnJnNEpWcHlK?=
 =?utf-8?B?QUx5ZTZpcUJiejRIYlptcGwvM2NrTzFIYmVkVmZWLzZuTzRKTnU0c05kb1Nl?=
 =?utf-8?B?ZCtlWFRxS2FRSURrT01pYm5HMEpnUHB3SW9LTkZiY3V5T2tiQUg1d3ZJcmZ0?=
 =?utf-8?B?MjF3WWdrSDhoQzAxSDAzdThJM3hoUjhLZlpzUUh0bFN1YWRJZnVnTEtwSmlE?=
 =?utf-8?B?cCtmOGxwN0wxWEpINWJadG02YUhaSVhuRGFPTDZranVEaGo4Rk1MVjFYR0Za?=
 =?utf-8?B?ckRUSXdSeklKZUZiZ3o5TE9TRDhzalRuQlZpU3p5aUtpZUN1dUdJYmgrV05Q?=
 =?utf-8?B?dnB3L0lwaGF5MlI1U1VHYUtEcUJ2RXFwUWIyOGsrNGhhNHk4SzdEeFBsQTNo?=
 =?utf-8?B?Y242ZWhIajh3OW84aFl5QnVrNWJGV3g2MTlFdXI3TWhvVGk2aldxd2FUTmJY?=
 =?utf-8?B?VmwxTm5qajZWLzhBUStIVWNNV1UwbURxZHduUWlPMG56L3plVXp3M3ladDNx?=
 =?utf-8?B?UWlCMnJybnFkazVWMzhUR0k3TUFITHN5cExlL1B4Yk5RaVcrUlBjdXp5WUR5?=
 =?utf-8?B?WXRSaTd0eW4ybndLeVpQNVFNaEV1WEVMRk9jRU1lR2JkcFRmVS9kaVY0eDhK?=
 =?utf-8?B?aHh0eWRONVVuNHk5YU96aWdLRklFTm1IVFkxTTFzQkYyS3JHUWgyL3JNRk5r?=
 =?utf-8?B?MGJlaGhsV09QSHpuVkJ6ZnNrcnFBPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d5f50c-77aa-42b9-96f1-08dde18ee3e8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:38.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POOaBjILUOydC8TpubSg3FvHtUhJBpw9sLPi2akv9MqnyKDnjOnrgfI01UYN4T4SPZlVvd5vxVKwU3XUBfNNMvTYDMgOHY3X/712aWpMfQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10374

Hi Heiko,

On 8/12/25 10:52 AM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Enable the NPU cores and their mmus and wire up the supply-regulator.
> The regulator itself was already defined, but it does not need to be
> always on - the npu can control it.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 35 ++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
> index f4bebd25e938..9859f31d2894 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
> @@ -194,7 +194,6 @@ vdd_npu_s0: regulator@42 {
>   		reg = <0x42>;
>   		fcs,suspend-voltage-selector = <1>;
>   		regulator-name = "vdd_npu_s0";
> -		regulator-always-on;
>   		regulator-boot-on;

I'm not sure we need this property?

The binding states:

"""
       This property is intended to only be used for regulators where
       software cannot read the state of the regulator.
"""

but the rk860 we use here can report its state if I read the driver 
properly.

If that is correct the same "mistake" was done for other RK3588 boards 
which enabled the NPU recently.

The diff makes sense compared to other RK3588 boards' recent NPU support 
addition so I guess this is fine :)

I am currently unable to test this though but considering that this is 
an IP within the SoC which only differs between different boards by its 
regulator feeding the controller(s) and that this change looks in sync 
with our hardware design, I guess we don't need to wait for me to be 
able to test this :)

Same remarks for the next patch in the series.

Cheers,
Quentin

