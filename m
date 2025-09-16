Return-Path: <linux-kernel+bounces-818463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A403EB5920E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDC61897A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E92298CC7;
	Tue, 16 Sep 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="Ee2AC1y8"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C069321FF26;
	Tue, 16 Sep 2025 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014659; cv=fail; b=boFirW5PC19ZFMmrKGLaKyrnp9OVngQr9fKuD3q+IHe+jYLEz7yo+Zc38zi0whcKpYqXdQ932ygcDi/3fXzuf6gs+Hh4VLsbIXpghFNBaiIXx1TWI8Y8w9QxXfAT+KnDI2yBJ4i+ogqeV39whO0B1CneaXO1kf3X0CisSN17bE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014659; c=relaxed/simple;
	bh=JeNu8vCeqJRdi1tB+12drodTCn1/j+IQ3QqEv48p5EU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d3rTg6C/jFIrs7Wlg9Ro4aU2puIDUrk4iTW9CPFXNMqt+yQw+4XpoO4CzLggzuywblRAGfp95mWdPFfpG5lrRAwcTNZM+rAQocLmUV/OTerLZ9N3WqEDN9c3S6G/L1i7LOI8c7VusBxiTkbxJJsYc3MgRvGVj8CAeOWS+othysU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=Ee2AC1y8; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ir7hyMK3GuqQJsWIFGnAQBv1p+mhT+OpT8rK7QdopgdBLqx/7bl3vtCwCNgB2ZbiNLrT8JctMsI/cm3xhVTbBcsPxpAA6KIx6O4hZafzgBqXPhSw4MyweAUOhDveH7jwgajB8bWZccQxkNih4bSsQk2KZye2FYMJK1zrLgmNch70kghxLAWfOFNMIzfZ6Tr0t+fxa0qOQzYr01GyPXdGFy4t5DkKZoxInU7cAuSqN/t26gcN68stVcf4bQoac2IFw2Rsx1pZtrT1cyz+uVBZXNomqjZpQZBmkeNZ4NJHXQEI+F5fuKVJKpYzIGcYUrHcSAGd2vE980mVUpO//laIXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLw2AwiM6e+G+HwMh9i9Up/raXmW2lXNLD8SxNow/fk=;
 b=x17fOElB7Cj4CleqnChGKRnz3MF3G7Lj1HsVd61hvPLxNQQCdPM9KBFajrwPmnpK3HdeFgu0urqGKCKEFhX5eI/dYrLbpFFkmDIRg3HG1Rjpo3hDPJ+o/scmL5PP4OejB8ngzT2u9Lf+xkUOPKDpw37vDHkxYJNcIk9qYdaUUsam9wTPBwgKt3Lmn5zgOWpXG81KnRPmFTWWG6BVSirAaY3KKPyv78SbLVsFH90fbVP2a1gvDVBGY5XnCRcWM3ZWciYejbz0njjS7MtKRMOlKRB9smnGVZrqUnS8Cy+rBrJjgHOtmQFA48We7wWsVKC9iPoQPOEsr+gSMm1PzmFjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLw2AwiM6e+G+HwMh9i9Up/raXmW2lXNLD8SxNow/fk=;
 b=Ee2AC1y8mypVPXVhtwxXYfSHTXKfnXtBadknxEofqZ9YTFYN7LD2PEJjkbLcfa5jmanp07HmD5t5CEu7cYTK/66JFi1Gl9CeYZWDi8GNWe14D1rEA8bb0dfN2GZoFgCPFd+nB9y73QgZdRfriZK8QxXnhclzXNM3SQwNw6nm8os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10749.eurprd04.prod.outlook.com (2603:10a6:150:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:24:11 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:24:11 +0000
Message-ID: <72ddffd6-bd8f-418e-996d-70267d3ca7e4@cherry.de>
Date: Tue, 16 Sep 2025 11:24:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Enable DisplayPort for rk3588-evb2
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>, Chaoyi Chen
 <kernel@airkyi.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Robinson <pbrobinson@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250916080802.125-1-kernel@airkyi.com>
 <50379c05-c8b7-4858-98ff-da7ebdc06863@cherry.de>
 <352856bb-76b6-4861-8a3f-80f94f7c7375@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <352856bb-76b6-4861-8a3f-80f94f7c7375@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10749:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fde7808-ace4-43c2-0bad-08ddf502cbc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEFFYzBpbGJFcjN6aEpuVWhsQmhLMERKOXdMelkvQlJodW5RdkxMakN1VmNx?=
 =?utf-8?B?ZytDNWEvNnlMWjRrMDFtMVJBdTVJZnF2bXNENXVvamU0TDBHMkdhS3NvRzQ3?=
 =?utf-8?B?K2JTUzJsTUpPRnp5VDl0cnBvV000SFlJUC8rNHZZY3NUcy9ZazI1OVhRWHdq?=
 =?utf-8?B?SkJ0OVJTZWlIL3dWeVN4SXpZVEhLbE11dlRUQUhpa0NsVHpCMk1VWExwbVZ2?=
 =?utf-8?B?NGdwL2lDcHVLelc1bmdiZFI0aGNIVTBWSFl2aElQQ1Q1L3BGQW5VQlAxTmUr?=
 =?utf-8?B?aWc5WFZ6S0hjZlNCNFVRQjJaQnpYMzE4UXY0cWFtdzMyeVptaW1yYnNNc0Iy?=
 =?utf-8?B?WU1UVlFGMnZ2YVpQTkFZNmhhR1JmT2w2eU96WEg3cWxlTHo1Q1REMEhFZy9o?=
 =?utf-8?B?cUFaV3NiekljdEVJNEZvNWhOWlIxSktKcGI0OGVxWno1dm9hMmR0Sk1DY3Nj?=
 =?utf-8?B?UFpwNElEQVlHUlhNTGlnRGN2UmgrVEdkMmZLenhhQXVXYzNDc0tZMHFaNkRu?=
 =?utf-8?B?SjROTEdTZXNyanhna1IrazFhNTlDS1V4Y2JpVGlnaVJEODZGaW10SlVJOWp0?=
 =?utf-8?B?bmtURjIrWjZnamJKakdEMGdEKzkxRG5yUmJYZzdrMkROeC9jU21BMXVTYVlp?=
 =?utf-8?B?VjlpZlZxQnBBQzdIR3hMd0swUm1tcVJWTVVIY2JKZXNPUW14bk95c2Q1L1FC?=
 =?utf-8?B?aGU2R3pTanpNQXBITVhJRnlnK2hSTm4xWmZXY1ErTm0zTVlxMWRHV1lXNlJ5?=
 =?utf-8?B?blVObkJWRFR3WE1xbVB1YjhGTHdJbEJ3N2sxWDcxVFJtSGdMeEg5RWxHVHBI?=
 =?utf-8?B?TEttaUNBYWpvMHRZS1dnSlozYzVGU3NSWFQwQ2h5ZU1mbzlucytNcW5aWWlS?=
 =?utf-8?B?MmU5UCswZjErMTlmcDQ4RzNidEJkZVVSYXRDQm1MRm51R3EwUEJlRm4yVmNJ?=
 =?utf-8?B?NnZwcjFUVDhZcDZxazZsNCtJMkF4bU1HUk5tSFdhV3VyUnV1VlpJREZVMito?=
 =?utf-8?B?YlpWS0t0NWRseENIMjFka1h2YkhkMlAvemhYWXFtOEVXWGRpZ25YVU1vN3Jp?=
 =?utf-8?B?NlBvWnhiUkRGZDIwZlNuL01aRkdTUnVBb0JtNnpLU0ZQRHNFWG1JazhuVzRi?=
 =?utf-8?B?SG5OUDhMTDNnNjVIdUZieGNOc3Z3RGgzbEdJcmJGT2xBTlkrd0ErOElrMk9Y?=
 =?utf-8?B?MThMWVU2cHN5WUJYS2lqMUdGTFA3WDFFK25oeXFCUzFGQXg2Wml3N1dMcXdy?=
 =?utf-8?B?REF2dXNIYnJudnJPWXF5ZHFKMzg5YVZuNEp3bEl2S3JTNmhIakw0eWJrSTQ5?=
 =?utf-8?B?Y3FuVmZUbHBVT0tYck5OZWNQUjhNUHJ5M3hFalgwbW5rOHhHY2taM1lnZFJ6?=
 =?utf-8?B?MWJkclNFSW1kbGhJVjFPTlNvb1JOVGhoc3V6SFhBREsybzRhN3FFZG1NWkFL?=
 =?utf-8?B?aEsvZ01IYnJTMFNLOGZyakNDSExGY3d5dzhqbUFHV1lsYnJTMklseWNaMHZ2?=
 =?utf-8?B?UnpXR2N3bVhhcktHOXhJQXdjaVR5YkgvVlBrWjB4UzVzWEJWd1dhdVAwbWxM?=
 =?utf-8?B?QnQwdytSTzRMVXRvQmhoSjhyNjNRRElxU29YU21kNnJTeHpSTlVrSVFPWVNO?=
 =?utf-8?B?WWZNU1NVci9OWS94TktLMU1tYlY1a1VjUkFhcVlwQ1N3SEtJWmwwMi8zRk50?=
 =?utf-8?B?UVZqZEZ2eDNyUm9pVjQyVWRiS1plV0NrN2NiVEFtODRvSUdtazBtaVFIc2Ju?=
 =?utf-8?B?Mm05MEFJa1hXLytySkxEb0NOUlF3NTU3OXRBSGtCM25CdGFidWZNTUZESE9v?=
 =?utf-8?B?bU5VWVVFSW5Hd2dJK1RaRmc5R010Y2pEa3kwbkZmNWZIN0R0U3JickgvdGxn?=
 =?utf-8?B?RUR2U0txRFcrNkwrRWtWNTJpaDZzOVFQSGlvSFF0eS94ZXhKWWpkMXU0TjMr?=
 =?utf-8?Q?8V7BPdmpgX0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFZieW12NVNZK0FEYzBhamV0VmRrdXUrcDlOUmVpK2dCb0R3NWNvWmlrc2RJ?=
 =?utf-8?B?aC9SbzluMkRVWnJiVEpYYzlibUI3Y3UxRDE2b2hKOUl5SE9XaWNaK0VNOGdu?=
 =?utf-8?B?TWxXNmJ0Y2ZiNlhpamV3c1Mya0NzSFczbk1lNWlzVTFnVUh6L0wwTm5MSUw5?=
 =?utf-8?B?ejhici9HNzZaVVg5Rkk3WFVualNxSlI2U3VVcS9EbXJiVnlFeUFnV2xRd0o1?=
 =?utf-8?B?ZkdSbzJsaXZqendqQkNvbUY2Ym5JeHlOd1J5aTNpWHJvcnNjY0cxSFg4aGRs?=
 =?utf-8?B?QjkxbkVJOHAxUHdCVDNiNWNFMFBuTGtaU2QvRVppRHBncWQzOEdmQk94OXlK?=
 =?utf-8?B?WTNORjJEUER5enJTd1R5VzI1YTJRY3F2b0tuNXdpSlp6SGFoWVBRTDl5bzN6?=
 =?utf-8?B?bFczR0U4TnJCd3pBMlZ6S0pIc1hwa2txQSsyUTBtSVdoSWlYTkl5Rm5LRzRD?=
 =?utf-8?B?M0xncy9ZY1J3bHAvSjIxNE1oaHRlQjQzRmY4S204eVh1N2trOU90dkNVZDJl?=
 =?utf-8?B?MEREYXlMSllyM3Y3eHNyK2x1MmpKMnhOeGJKZnJXUTBIVXdpV3M5NHBaM2wz?=
 =?utf-8?B?SENJTnRlSGliUjYzbW0yS0pNV2crNndJSVhpV3IxOEFEZXRuVDdYaEswbDQ4?=
 =?utf-8?B?UjVIdWM3d3dndmxDWks0U2hjNFZBdnNURk11YTFJQlAxRFYycmVDR0s4VC9X?=
 =?utf-8?B?MmRmYjcrcVFYR0lLV1dVVHVPYTIvTnB5T0dBVzR3UTN0UW1MMkhTWFRVKzRZ?=
 =?utf-8?B?NWVkeHpJdFFVclNDbDVUa2NjLy9tS3hZUURnek44TUJua2gxN3d3L2tGS09X?=
 =?utf-8?B?bjNlSE1uRFdzSFBZZnFXblpXNHpkRzVPUkx6QngwTkpHMUtmZyszbDVpT2Qw?=
 =?utf-8?B?anRjelpiTTBWMmdHbFo0TjJJZExyNUVWbHptWHVaR2pFZ0FkYzY1cmdtcE1o?=
 =?utf-8?B?MTdsd1lMWGgzeUtOVVhIQ3VaOEZCZDMwb3ZuWGdlaGtwdG53OVJUS08za2NG?=
 =?utf-8?B?UVhxQ0VOZVYxSEliSG11MU40VGVaT1JNcktlK1A2amExeldGaWFwRWVxUDRl?=
 =?utf-8?B?ckoyOGtFMHhESGNNYk9WNHFRNmxSY21sbFJzRVB2KzVFdk1Yd3c4anBkM3VK?=
 =?utf-8?B?ZlFsSjlCcjdzWlQ5Mi9WWG1TZmJscElUTGQzYzlsVmhGNlc4VEFhVUNPOFYr?=
 =?utf-8?B?aTVpNEQ3Z0xIZjJUQkw4M0tQVmowMzQwaldUOFN3WFFUYjB4ZzYvcXRtd3BN?=
 =?utf-8?B?TWFBZTJ2YVlCaFRCTFpGQytNZjhDVEFhdGY1aUFFeWs2U3d0WHZtTVRTT2VU?=
 =?utf-8?B?OC8rYUVSY1NiVUQwd2VkTGtpakJyNmZzMnYyYWlDemsvY2hSNG5oRWhLbmVm?=
 =?utf-8?B?am1GaWpzaG8rUDJRcUM1ZVdpMWJCYWJDK2VGR3ZSU1E3UTNGcFRlNjBPcFJk?=
 =?utf-8?B?cTRUNGgzOHZOQzdHZi92bWY3N1kwbDlTQ2lVYnJTWmdEbWdOVGFmT0k1MGs5?=
 =?utf-8?B?UlVqby9XU1ZvcXhJVUZrT1JGRiszUjZucTFHd0gzMm5MbkhEcVQyQW8vdm93?=
 =?utf-8?B?Q2dtWXdqOUVtMXM5MGJOckR6blUySFJERGs4MWNac1gwWExYdCtqMFMvZWhl?=
 =?utf-8?B?TFZBTEFzV3JVUUtjbEs3WkZmTjBLdHpQQzlrYTdxdGVBZ085eXlUdlNxZkpM?=
 =?utf-8?B?c3dTU3dTaU5haEVkM1pHSm9tOVZPeG15NUZEZU5EbklvRjkxU0RIMTBTSEpU?=
 =?utf-8?B?d2tCcHErV0kvUjNFYVR5NWZ4Y1R5Mmh3a3JVWGhDWiswK2J4V0djYzFJMXVI?=
 =?utf-8?B?d3ZMK0Q5QXQ2RnlCL2ZQTUZyNGcyaDhaMy9QcUpRemJBSjh6aUxDeGFqU3Vh?=
 =?utf-8?B?NFNwZG0wRHl4bkVidHRxdkJsMEhHalpnd2h6VVhKNXN0TEFRWHpIdGZpMWtt?=
 =?utf-8?B?TFFwT3RzblNWTmE1cmVVejV4ZjZIUHAveVVLeE5zcGJ6Y3FIK0JCMlR6SXdD?=
 =?utf-8?B?dTJrUWF5REMrMGkxNjlCOHExZjZWbkZSRExwcFFveGJwUFBsUHhpR3N0bzFC?=
 =?utf-8?B?dlkzT1NMOHcxR2UrbGUwNW5YT0JyYnNkeCtDbW91SEQ0c0tSTW10dDNYWXhj?=
 =?utf-8?B?U1hPYXMxN3NCbEFqY3R5NkdudnBYU0RBMnp6SFFNTnArMzNhTzQ5eXFVTzh1?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fde7808-ace4-43c2-0bad-08ddf502cbc9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:24:11.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eu7HwJdHZRicH/mx6Pse8kK4NV2505mjaWcz/vovSyOmiIsjVc1fnC0ZzhXya7p9V5JuMIuYy9xUlC6QoK/1+JZNdTN8u7PcsgiX0XJAzss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10749

On 9/16/25 11:18 AM, Chaoyi Chen wrote:
> Hi Quentin,
> 
> On 9/16/2025 4:41 PM, Quentin Schulz wrote:
>> Hi Chaoyi Chen,
>>
>> On 9/16/25 10:08 AM, Chaoyi Chen wrote:
>>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>
>>> The rk3588 evb2 board has a full size DisplayPort connector, enable
>>> for it.
>>>
>>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>> ---
>>>   .../boot/dts/rockchip/rk3588-evb2-v10.dts     | 39 +++++++++++++++++++
>>>   1 file changed, 39 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts b/arch/ 
>>> arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
>>> index 91fe810d38d8..0e5af61f66fe 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
>>> @@ -25,6 +25,18 @@ chosen {
>>>           stdout-path = "serial2:1500000n8";
>>>       };
>>>   +    dp-con {
>>> +        compatible = "dp-connector";
>>> +        label = "DP OUT";
>>> +        type = "full size";
>>
>> This isn't valid according to the dt binding. It should be "full-size" 
>> instead.
> 
> Will fix in v2.
> 
> 
>>
>>> +
>>> +        port {
>>> +            dp_con_in: endpoint {
>>> +                remote-endpoint = <&dp0_out_con>;
>>> +            };
>>> +        };
>>> +    };
>>> +
>>>       hdmi-con {
>>>           compatible = "hdmi-connector";
>>>           type = "a";
>>> @@ -106,6 +118,24 @@ vcc5v0_usbdcin: regulator-vcc5v0-usbdcin {
>>>       };
>>>   };
>>>   +&dp0 {
>>> +    pinctrl-0 = <&dp0m0_pins>;
>>> +    pinctrl-names = "default";
>>> +    status = "okay";
>>> +};
>>> +
>>> +&dp0_in {
>>> +    dp0_in_vp2: endpoint {
>>> +        remote-endpoint = <&vp2_out_dp0>;
>>> +    };
>>> +};
>>> +
>>> +&dp0_out {
>>> +    dp0_out_con: endpoint {
>>> +        remote-endpoint = <&dp_con_in>;
>>> +    };
>>> +};
>>> +
>>>   &gpu {
>>>       mali-supply = <&vdd_gpu_s0>;
>>>       sram-supply = <&vdd_gpu_mem_s0>;
>>> @@ -916,6 +946,8 @@ &usb_host1_xhci {
>>>   };
>>>     &vop {
>>> +    assigned-clocks = <&cru DCLK_VOP2_SRC>;
>>> +    assigned-clock-parents = <&cru PLL_V0PLL>;
>>
>> This is surprising, the only other board which has the DP0 enabled 
>> (the CoolPi 4B) doesn't set these two.
>>
>> Does HDMI still work as well as it used to with these new properties? 
>> Why are those needed? Some context in the commit log or as a comment 
>> in the DT would be most welcome!
> 
> Yes, HDMI and DP can work normally whether these new properties removed 
> or not.
> 
> The key point is that when using V0PLL, we can get more usable 
> resolution because DP requires a precise clock. If V0PLL is not 
> explicitly specified here, then dclk_vop2 (VP2) may be divided down on 
> GPLL, CPLL, etc. In this case, only a few frequency points are 
> available. In my case, when V0PLL is not used, only resolutions such as 
> 1024x768 and 640x480 are available.
> 
> For HDMI, I think it will use clk_hdmiphy_pixel0/1 as clock parent which 
> is provided by the HDMI PHY when it work on TMDS mode so that we don't 
> need to set it .
> 

Considering the clocks are all internal to the SoC, shouldn't all you 
have explained be applicable to the CoolPi 4B too (and other boards with 
DP)? I'm trying to understand if we should add something similar to 
CoolPi 4B DTS as well?

@Andy, you're the one who added support for DP to CoolPi 4B, without 
these properties, is there something we need to do there as well?

Thanks!
Quentin

