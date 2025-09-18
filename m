Return-Path: <linux-kernel+bounces-822565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D641DB84253
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2FB1727D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C214929E116;
	Thu, 18 Sep 2025 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="aRRwrRKX"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237A72836AF;
	Thu, 18 Sep 2025 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191977; cv=fail; b=Lg0UNSxCe/4dEb1cqKLPrakoFEL+dAJV+4Ii/osA6TH5x3Ul7FiqNcOWC3pfVWs+dHAejNDMZS4Hn4iXvWk9Fbv1vvszSVmS5c8mxXbYVVin3nTRRgwQWm6Suy9VOx0pZ20d7XNI5y5uN6xjkt4fNV9ydJOJyV0mMIJqtj4b0IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191977; c=relaxed/simple;
	bh=mQbDusO+aLF9SbBjxhNW24pr8/qK/6QMwDjy7sV6aqI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dv+Y4Jcu42Sb5ZMmX3yJQz0H61/+8lfvuXTxmf4+rtIEJFvhxzY9LrFtTBzbEu2wwA2LgxuI90eYmX9RoYbd54nwX6QfmoNXY36SnIqPvgOkvzz1j+S2Lb4UuadUesBpvrvTuNypgUNtBHpay3dybl0L5lhFsX2Qa8nsuUgAMxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=aRRwrRKX; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmOs8iMfuKSfF7KdYz3dh5aMyesiqda+30l0H/B1xHgJ/711NjZ78SUGSk1q3NMvsNSZkYq2TcYhvWrItBhhTK/GFs9Fyq/7+x82hv87WY9wrVs7XzD1i5vYk5/6iElKLKrZPDQuo1YpLtmisifH7y9as/+hRa25Z+c6OO6uXFwRnfEzuLVeb4/xfkl5Bsjk2h+qHYcQFk5GQalu7lx4CKLiqed+zuO6BphF0121UjjlwgVBhED3m53cLxf5EmRX5TEBUHmdfzW+eB7Vot3nuvGilLxI/kxulqSYsv73bHYCBBBPYF4wECSMfFYot5rjjAcjvwWukqA1thWs2j49bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/kWrTEqFouScmg6vgwoOb9Ks5Xq4kOZous6Hir5SQo=;
 b=rTZrx+0aUzPw293ztk86qJ48rEJyDqe619bAqtYoI+cX9wNtX1qb21g2b8hJBporqIWhkd3nUUUXpSQuAJBoxDQDHnCYMoVDpQq06Yngml5iJ2NqeXoLtv7exkCiZZrzVWDjPABXF+0OU+dr0S0ktK/b3goELO8plO+rYcxIrtDfDiEjDBLywdbp/bUw4gEArDWbM4v8TOyQu1MfxrBHRO5eSEce1MFb7annUT6cn8fCI4fR6aEoHJ3CPpOGPzR5+tXUHB9KPx3ybK4N8oqLbIqAOENncIVmdTa4gKdaqh+4bYMRPRWgNPv6WdSaaBYdM/xjIBfrxsc9bgN1laOf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/kWrTEqFouScmg6vgwoOb9Ks5Xq4kOZous6Hir5SQo=;
 b=aRRwrRKXxddFCFSgK5rOUrvzx4GyehntzvhgrdmOYntAH88fWE8nIMi8V/qnrh0aZB/fGckzICxRfG5x22a5ZeU6AN0D3E/6WSmxEfAYXx8gk28w5NqO4nEm3DYDOMAg5yL63+u4LGYqvy18wMyas/bF5gfoJENBX9iLn6J30Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB11011.eurprd04.prod.outlook.com (2603:10a6:102:480::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Thu, 18 Sep
 2025 10:39:31 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 10:39:30 +0000
Message-ID: <ecc96b5a-2062-43f4-9959-b4e2b126d9f3@cherry.de>
Date: Thu, 18 Sep 2025 12:39:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enable DisplayPort for
 rk3588-evb2
To: Chaoyi Chen <kernel@airkyi.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Robinson <pbrobinson@gmail.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250918062825.194-1-kernel@airkyi.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250918062825.194-1-kernel@airkyi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB11011:EE_
X-MS-Office365-Filtering-Correlation-Id: a928f3c3-ee43-4095-3756-08ddf69fa613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3NXZEJXQVlZVjY1MVhNY1FiMnRvSDQrWkVWNkVTamVaTnpWY0EveHRNUVQ4?=
 =?utf-8?B?Q1VCZVNtc2dXLzJDU29ZeWMwZW9QR1ZSSkRtcTVucWNvQWZOWkw4b0FFamNL?=
 =?utf-8?B?Mk01emFGYVdqdGZvNmRlQUtiam1IU0VqdXpNUWhhOFhod1pjYUlDWVdOQ0F5?=
 =?utf-8?B?YTNwNHNmeHBIaTJqenl6YkJDTXp0UjYvbXNGcTZ6QUljdERqMzBaQTlzOEtV?=
 =?utf-8?B?MUl2TEUvOGtpQlByTVM0aCs1TUNJVXV0QzhnUHEyMlBlUjdPVWtWeU9PNlRJ?=
 =?utf-8?B?THdCYXFzaklkRFpYK1FHWU02STQvZXFTTStMVFNOK0IzMjN6cmsxVmtVdnBT?=
 =?utf-8?B?a0ZRencvWUR4eDZIamc0ZysxajFic1ZqdjIzeW5vSnE0MTJjUG5EZkRUZlJO?=
 =?utf-8?B?MjhVbUdVbkFrMUJuVTQvQkdPL2cwSy9WSXJjY0g2WGtvYzFJck0zbWpKcElh?=
 =?utf-8?B?VFhvb0JSLzNLakdYUVZnT1FjVzJ6aUwvV0tWaHpPSjh2YTcxeHVzWUVia2Vh?=
 =?utf-8?B?cHBCUHByNVdXTUdKUzRKTFAzYm8wYjdCTmlDUlVHSXdhb0NzaHdDZ2R2WXBY?=
 =?utf-8?B?a3BTNlJaYkdVUGIxWlRmMGQ4cm9EVWE3ckt5b1NXUFpGZUdJbm5pbmg0L2RP?=
 =?utf-8?B?T1N2R0I1UWg2RkNXZklqRjI0SHp6R1BrTVpZMmxBcStSc1VGd1QyOFp5Y0hx?=
 =?utf-8?B?eE14dHRuc3U0UjlVWCtuN2k4cVc4dXp0OTIvb3FuczJTaFpqcnlWN09IZUpO?=
 =?utf-8?B?Vytmd2llZEhBUG5USmVtaGtGd0RkMHI3NjAvTDhoVXFXbHozNUd1ZlI1bzZ5?=
 =?utf-8?B?Q1JLblgwUXM4eU5ldndkRHoxbDhzMzVuWENiMThYMUMwT2pKSE9IbHRCNzRl?=
 =?utf-8?B?a1pmSXo5eEQrRUJLbVRKQ0oyQytwelFZMGN6MzhGeC9rbm9la29ESHFUb3BM?=
 =?utf-8?B?L0VFeGZGZlNYeDBldGJ4dFQyWjN4aDE4Q2hDN2Ewc1c4aGZPWW1QalBYdXU1?=
 =?utf-8?B?bHZLOHR0QlRLalNJTmxmbzVqTzdNTzFBZFlyK2hvZWpLWkF1TzFCUjIrZG9V?=
 =?utf-8?B?cHZhZ1JFaVVDcUVtajF4UGY1K3p4MVVTU042MzViWVhzVWJXSGZYUzNJR1BK?=
 =?utf-8?B?VkQ2ZHJRUndXWk4xSXpXemxaKzAvVXRYdGtkN2R2MGJ4WEtvSXY2RDZ5dnRO?=
 =?utf-8?B?dGl3NHVjdVVvcUt1ajBrR1pTTXhGT3ovcWx0eDhuY3RJenVLSTNmQUkvQlBm?=
 =?utf-8?B?b25jSUY5cGRiRnJWam0rV2dKaHA2UllITHV4aUFuVEpsalM4M3ZXbGRPb2ln?=
 =?utf-8?B?WWZlSEpmcjdsN2w4OU1tL0xpNG5OT0dERk5rY0V6NzRHdEFYcWVXNWhpRXk4?=
 =?utf-8?B?Qk1INlIrZm9pQXlWdUJnUEpHeFFMb2NoQ3I0dUtRdHEzVVVMVnpuZktUS0JK?=
 =?utf-8?B?U3N1Z2oybS9ORDhXRVlBTXZOTWJVclNTTFZ0U1hEd21scVRtVWNSVFB2UWhx?=
 =?utf-8?B?cTV6Nm91VVZ5UHBtWitvZk5rUEVNYVQvSjhQczQ1NHA2TkdFajZqWTYrS3Y5?=
 =?utf-8?B?WjhqaTN1dnZaWGljKzRoU1duWVVMeTFwMHFmNW14dVo4WTFGS1hrc3h3b2Zw?=
 =?utf-8?B?THM2c2VxdVBGNm5PbS9zaGlQNFh6QWpXTHppN1c3Z1FHblpmVE4vVFhyeFR6?=
 =?utf-8?B?WWdTZDRhc0tOSmlQRVpEMXh0TkN5MGRBcUgwZDJNQVNxSzhzcGNrOHZZSVBM?=
 =?utf-8?B?elNHTnpTK1N5TU9BWWVaU0VBUlN6dTlKLzU4Rm9sQ3A0K0Q3NTNqcGhYZ1JV?=
 =?utf-8?Q?2CHDpj6SkHqJTOMWweAMLUcg9ONWJeqEA9nM4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFJkVnFDWHVVN2dpdzBpLzFOTkNzM0dua0M3ZjlQbWhHeW5jZDlaQjgzUFRy?=
 =?utf-8?B?UW5OUVpFcGhpUW1vNGtxODVaWEx3ZWJlVnJzOWF2OVBsNFpLV3JuRDJFZlEr?=
 =?utf-8?B?U3BycGVha0ZEc2lKTklsb0xLek9oZ0J2R08rQVRzQWdkbXVYM1FrZjJBQWpw?=
 =?utf-8?B?T29yaGlsRXc2cDk5Ky9qc2xGSGdFdVhveWFLek1wTGpiVjk1c2lSa0VRRnNB?=
 =?utf-8?B?TGZkWnpjSFk5M29mTzlmUytteEswcnRFNlRHNVBYKzQrUU9keEhkL21oRDRs?=
 =?utf-8?B?eE1CK1hHbXZSZmo2RFZOenJaYm9PTVRZbHRoT0poMXBKTFhiOWpGbHoyWS9v?=
 =?utf-8?B?ODNxMVVqenp6cGxxRk01ZVg2YVdkMlIxZ2pzeHdyaEU0ZExRZGx3dFh6aTd1?=
 =?utf-8?B?Y1JtcFpzQ1RRL3NuQjc0c0RYeVN3dFRFeHBsWGo1UnU4ektWeXJNeEFWOUFO?=
 =?utf-8?B?ZHI3MnB6K0Z1NllraXRwQ2c2YzkxK3E1L0RTRDVKTHBISlBGK2xsamtHWG04?=
 =?utf-8?B?d0hNSmR6dVQ3SEkxNVdsMXFjekFPRElrNkgwa20xRXpJRVJEVmROdkxxQkV1?=
 =?utf-8?B?bWNQMjZrUDdTajNTd01XSnpueElLZEx2N1REYWpkZ0pTRWNQZkRpMWhlR2dj?=
 =?utf-8?B?bG1BWmhORnJRSmJ4MjRPYytPR1ppMUtqM3pXQ1hFbm53R21wU3VNajNPelE2?=
 =?utf-8?B?SVBZRXErMk5YaFVJcUlaZDRNQnd2dGlNdWFQRldocGF3TGM2SE5qb0JxQ2Uv?=
 =?utf-8?B?a3VXQlJ0SGFPRDAyM1J6ejF1cGtqQ2dmazNWQW5Jc3pkNnJUcDl1dWRrTXM0?=
 =?utf-8?B?SWl5aVNwVDdnd0NPTjQwQzQxdEliUUczOGhsa1hDZGdXMUkrTXBCYnBOalY3?=
 =?utf-8?B?czBpQlFaVStuQkdiNm9vcUdEWFcxZ09md3d5N25JRHNjT3RQbVErd2FoRW9Q?=
 =?utf-8?B?T0hnRFo5S09neGtid2dLdS9HR21iV09aWjExYnBsOXdjSG9uMWwvMmpPM0xm?=
 =?utf-8?B?NUMwK1RYbjVEamhnMDRqQWZ4MkxoR3QvQ3ZQTXBkaUYzQXUvUllPZUJINzBD?=
 =?utf-8?B?cVYxUXB2b0ljSjRWeGNSZEJLTjZhdGpvdytWZnVnVk5saXR6MGZBNFpuRmov?=
 =?utf-8?B?SkNjOVQ4UzRlaDA3a0tKS1pIejMrRVZZUGtQb0lzYitYTWptcW91TTlFbWw3?=
 =?utf-8?B?RXZwK0NUdGtRTG1EMWVyUWRPMVUwNEpiWWlobTJpdFBvWCs5dG1KZ3FnQjdW?=
 =?utf-8?B?ZUZhQzhCU3RNL3pWQU1oN1Z3VTJrTGVSclRaZEJNNGVpZXM4OEhrb3ZKcVJl?=
 =?utf-8?B?b2JYM2l2cXJNU3c4T2tXOCt5UW1yTDczcHc2R3A5aTdpa21RQkJHMWdablI4?=
 =?utf-8?B?NW9HSjNwRCt0TGszdGdIWnhUbzBhRnRjRnpFM0s0VHJhaEZyYSsvNndzT0R6?=
 =?utf-8?B?Z1V4TUR5S3F6WDF0d3hIeHQxSThPTmhUUThOcys5NnZjKzJ4WHNQeUQ4QkNE?=
 =?utf-8?B?VW8xQThYMjNHM01uOXlOMUpyQVRna0FISVZFYUx4TUhlbTZkZ3BKdW9vZG8v?=
 =?utf-8?B?NFByQ2NjdVJDeTN4bHRvYzVTaXdub2pYbmwwVWdyOTdJcnRGcE95bTY5MFAy?=
 =?utf-8?B?S1Y5N3Urak5ZQmd3blJaSWtNWC8zVEl0R0UrYWI5azEzbERjU1M4ZzNnUnJn?=
 =?utf-8?B?QjRJTDlaQWtyTnpmcFZrdkxDT0RPcW54SU1Ed05kRE5WUmlOUjF2UGdsUVJk?=
 =?utf-8?B?amQ0RjJkcnVWVS9Rd1VIQnh2SUo5SmFhOUF0UHVkcmhPZysxajRTU0JRbWho?=
 =?utf-8?B?eVcxRXFTR1FGTTdycW5LM3ZEaysyQ3BJcmEzZWE0RURUK1BZaEFtcW1FT0Jj?=
 =?utf-8?B?YU1iOGFBMCtOaUx6Q01CaEVYK3VmaU5pcXk1bXZwVFAvWVdKMkF4NjRGUDM5?=
 =?utf-8?B?eCtSeHVVK2NKSld6N29TdFdhSlZFQWM2QzZhaTlzbGpMTGNReTZYdDRuK0dp?=
 =?utf-8?B?eEdQM2o4VCsvL1YycTNPSUsrK0ZlNkl6eHBzalgyVktsOXgzOVpzNGNwa0Q1?=
 =?utf-8?B?ejZmTlJOdXJGRERIMDA1UncxTU51UzFacjJTQXh0aHFjNW1GQ2xaeFFWTWs4?=
 =?utf-8?B?NlJyWjJjNTFvckNIUjJHc0s0SXRRckVNM00ra2pSUXgzdW5mR2R4YVcxWUZs?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a928f3c3-ee43-4095-3756-08ddf69fa613
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:39:30.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +N04Kvd+dTN6+9+3v0fj67A0qV677glI48//YRrBNcixR8LouvqOwvIapqo1Y5+e972Dz5WRnUcggdr9N7Ch6nXoW/UiJ1vZxihOenX7onQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11011

Hi Chaoyi Chen,

On 9/18/25 8:28 AM, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The rk3588 evb2 board has a full size DisplayPort connector, enable
> for it.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
> 
> Changes in v2:
> 
> - Link to V1: https://lore.kernel.org/all/20250916080802.125-1-kernel@airkyi.com/
> - Fix invalid DP connector type
> - Add more comment about dclk_vp2 parent clock
> 
>   .../boot/dts/rockchip/rk3588-evb2-v10.dts     | 48 +++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
> index 91fe810d38d8..60ba6ac55b23 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
> @@ -25,6 +25,18 @@ chosen {
>   		stdout-path = "serial2:1500000n8";
>   	};
>   
> +	dp-con {
> +		compatible = "dp-connector";
> +		label = "DP OUT";
> +		type = "full-size";
> +
> +		port {
> +			dp_con_in: endpoint {
> +				remote-endpoint = <&dp0_out_con>;
> +			};
> +		};
> +	};
> +
>   	hdmi-con {
>   		compatible = "hdmi-connector";
>   		type = "a";
> @@ -106,6 +118,24 @@ vcc5v0_usbdcin: regulator-vcc5v0-usbdcin {
>   	};
>   };
>   
> +&dp0 {
> +	pinctrl-0 = <&dp0m0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&dp0_in {
> +	dp0_in_vp2: endpoint {
> +		remote-endpoint = <&vp2_out_dp0>;
> +	};
> +};
> +
> +&dp0_out {
> +	dp0_out_con: endpoint {
> +		remote-endpoint = <&dp_con_in>;
> +	};
> +};
> +
>   &gpu {
>   	mali-supply = <&vdd_gpu_s0>;
>   	sram-supply = <&vdd_gpu_mem_s0>;
> @@ -916,6 +946,17 @@ &usb_host1_xhci {
>   };
>   
>   &vop {
> +	/*
> +	 * If no dedicated PLL was specified, the GPLL would be automatically
> +	 * assigned as the PLL source for dclk_vop2. As the frequency of GPLL
> +	 * is 1188 MHz, we can only get typical clock frequencies such as
> +	 * 74.25MHz, 148.5MHz, 297MHz, 594MHz.
> +	 *
> +	 * So here we set the parent clock of VP2 to V0PLL so that we can get
> +	 * any frequency.
> +	 */
> +	assigned-clocks = <&cru DCLK_VOP2_SRC>;
> +	assigned-clock-parents = <&cru PLL_V0PLL>;

Are those board-specific? Considering the VOP and DP/HDMI/... 
controllers/PHYs are all internal to the SoC, would it make sense to 
have those specified in the SoC DTSI? I'm not familiar with the video 
output stack so maybe it doesn't apply here or is a bad idea, so I'm not 
actually asking for a change here, just asking a question :)

Cheers,
Quentin

