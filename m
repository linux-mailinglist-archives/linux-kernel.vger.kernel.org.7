Return-Path: <linux-kernel+bounces-599643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D016A85671
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 10:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD308A608E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 08:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B402929346B;
	Fri, 11 Apr 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="CkHWfevF"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021095.outbound.protection.outlook.com [52.101.129.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D112128F939;
	Fri, 11 Apr 2025 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744359830; cv=fail; b=eZQMvTIqM2FbMUzWmem0Jts14Mn6M3DzVyfDGo/axGbYC+t+K87KWfM9glAREmNSiORggG9NHikhm1yvrepzABLL+9l2PKaMIciqtZ5i1tJePyGN7AYKWYP4VeGkVIxYJ2rUinQimancq6L/K09AObhA5o9t4IRTrMaruLfxGlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744359830; c=relaxed/simple;
	bh=qboQr3r/nQtvVSm79VX5bAgKc7Ak0gm9BFcmTAIN2cs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DOk0OqgQMk/HeJGKHE9RxYKTBE+Fid0Fp4cz8Y0/QKw2brDGqJU9G9wmGmcTwZIgcIE8rf66kIc0k3EkjozW8Xd3K1Zz1gFh00c+mHUViidScAwuV07mzRf5H4HNPIV/v9Sdr6twBpBRRfmudmrQsHBCbJw54wB6VeTMsFxJIiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=CkHWfevF; arc=fail smtp.client-ip=52.101.129.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWcOmWs7Xc6RpaM6UFZMbWUzApxOq8zakb7LORvLZ33/KltLlIyJhRen55vxnc1jluFe6evKr+Y/R4Pua88l1s1NW0P1zs6fTnaNNERLraQlU5g5vECK1hgzwKJaMIDa3Chpdx5jemZ1xDfA/OrR3zWPIVpMU+jkUqP9W8rVQGyeqhQ5TaM+MpCyWpefUM7PZUtFi2Xlq/b5qDiqlNMpw39VwrLWi7zvKZOvXJSxv0gvMKZD5u6/AZ1BCSZ8JH07xZ9nK/+krtOZ7jWwJ3o1fxJsfVZXglVSkdXDTOTGzgjakwuazxZ0On8ARg+RzlH+VdIPKBSaObQ+nDbv1KNruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qboQr3r/nQtvVSm79VX5bAgKc7Ak0gm9BFcmTAIN2cs=;
 b=Sa0zUw+GVrLNevt7BC2kIi0LBiQl63C/SNbpDbphXKKuWqU/Zz8K0ISx0niSl2RWmrHP5wPSqljANtMkq8JJURc4ee5xjFtgpvp56s+nnGz7L+IPHTzEeYUhV2TwQmapsD2TT6SzaWe43thhgGZxOW0GSuai09NbSXLNQrJXq4LlqJcefSMf+VKG9kM2NLR/8flNVYPa3rKiurTcQMDmeCj+BJbrbkt2ASwTNMIX9sogNsQH52MDayF0RPIa8d6zgeWJoVB1LUTJ05AOVegjC3cUR+QGUAgpWs++uWRHcHxVeGYLSLMfPXFGns0MUI+Tw6evdzlWrW/HHRGDInkC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qboQr3r/nQtvVSm79VX5bAgKc7Ak0gm9BFcmTAIN2cs=;
 b=CkHWfevFrEa0Im9Xr4iSKZlTdiOHAg08cVDCUQUyLosNjDgLlCCdol03dhjgIXNffJAd2hbh1fyKsmS1hjCQdy2EhjA7YSw8h+zJr7oz5Oi+bpwmcTlvpIfhG80t9Al/MbS+m7cf3CdafpLorvfLASyduOeKSq2T0yAqKAx2fOrYDD7qCdsWI1BEiLh8DCwvDmxZgO4blSeWv1WFth4vluLnQra5WngzDFj2ItdWWXoM3GaMhdg0SGT9tnL8Ge6JlhDYSqvRCOlmGodKYfRW76V+cOQQHGRFpb4Ke0qSnBDdtHW7jADl5EM/3iRasmiOrXaIuhIlm5Mg/EW1Bbe6wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYSPR03MB7387.apcprd03.prod.outlook.com (2603:1096:400:414::10)
 by JH0PR03MB7655.apcprd03.prod.outlook.com (2603:1096:990:d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:23:42 +0000
Received: from TYSPR03MB7387.apcprd03.prod.outlook.com
 ([fe80::74f0:55c7:2ffa:a57f]) by TYSPR03MB7387.apcprd03.prod.outlook.com
 ([fe80::74f0:55c7:2ffa:a57f%4]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 08:23:42 +0000
Message-ID: <8a0f383f-e100-4928-a040-91ec0aa9aa6f@amlogic.com>
Date: Fri, 11 Apr 2025 16:23:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: amlogic: Add A4 Reset Controller
To: <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, "Jerome
 Brunet" <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Zelong
 Dong" <zelong.dong@amlogic.com>
References: <20250320-a4-a5-reset-v5-0-296f83bf733d@amlogic.com>
 <20250320-a4-a5-reset-v5-2-296f83bf733d@amlogic.com>
 <e01d48c6-287b-476a-b5ca-de670375561d@linaro.org>
From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Content-Language: en-US
In-Reply-To: <e01d48c6-287b-476a-b5ca-de670375561d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To TYSPR03MB7387.apcprd03.prod.outlook.com
 (2603:1096:400:414::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR03MB7387:EE_|JH0PR03MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c4206b-862d-4063-236f-08dd78d22b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z05id2RCTUFsZjBRMGxXc3F6bWxsb1JmYVFPWFp6RmJvc0NQd3o5QlhkTXkw?=
 =?utf-8?B?RkpoSzIwbFhmN0xMTXNBR3IvNkxBWThzNUVuc2VQbnZQek9VM3VJbUZYMHZ6?=
 =?utf-8?B?SVRhQWkvODFiaWlFak5NVzQ0Q2czN3lKdis0dVBQaVhHTXIwQXdoL2JYdXdD?=
 =?utf-8?B?dGV4SEFIY3NmenZBbmdwOFFNRllUekJXZ2dVZEZCVXB0cWtuK2c4cjhrUXBH?=
 =?utf-8?B?eHNRbjNOb1VPRTB2ZmdxOHVrTXFYMHNxamJLdkp1MkxiWnhCYncvTGUzVXQx?=
 =?utf-8?B?N2VHY3ZPTHZoY2Z3a20zZGxkUm9TeENUQlk2K1ZRZGIwTkgwbURQNFErSnpp?=
 =?utf-8?B?dVhEYk9TRWt2RitxTnNicVJIVEVKTnB6TnlnLzF5M0hrOE9hMjVLMjJ6OFdM?=
 =?utf-8?B?bGZvTHBYYXlSdjNHK0sraDhYMWkvQXJKVG93RWlvNDVFSTdFekxZUDJwNkRK?=
 =?utf-8?B?T0tGYTU0N2hoVFdGdGVuK1l4Y2wzanJnNkZWRUxBWkZaOC9YTEM5bWxWbEEv?=
 =?utf-8?B?eG1McGdPQlYwblhQM2F5UEVoMXdjTnE2YTUwaExzb2FLM2hKUi9FSXRtVUlk?=
 =?utf-8?B?SVBOay8zVktQYlZJV2hxbzhTUzZvNEVWTFhIdHlISHR4Zms3SG9ZVktNdENM?=
 =?utf-8?B?eDMrSU1KaStWT1AxZEVYOThaeUNyRUx6dzVqQlYzSUUzbXRYdzg1djNKMUJ3?=
 =?utf-8?B?SmFRUWJVSXNFREpiL3FMWDR4N2I3SFZnMkZRTks5UGRnMElvSGNTVW8rR1lo?=
 =?utf-8?B?cTVWVWdHWXI1bVFPRVlpRGUxcldTYXJrU3kraHc2ZkluRXNaajdPUVZHSERy?=
 =?utf-8?B?akk4Tko0YVlDYThXbDNzNXE1SWNkYzQyODZnZ2k5cWVkMXpNRFBwbTVCVy95?=
 =?utf-8?B?c2hEeUJYT2dXd0V5SHBMNWo1Nnlkd1oxcEpzQlFLL3hrN1JQNkFEcjNVbFJn?=
 =?utf-8?B?clhoUUlHK3EyWlBoc0tVY2tmeEFqQ3hKRUxOTFI2Qk5OQXhXODQ5WHdFN3ZQ?=
 =?utf-8?B?K0d0RURIb2ZkWGdZYjg2STRvMW1odGZhT01pdVdYb1U1TCtWSTNWbERGK2oy?=
 =?utf-8?B?ZThwci9CaHJvT1llckptcjRaSzNUZUFkV2gxV2o4K05RTHJYbEVmUlYxZ3Ju?=
 =?utf-8?B?L042K1NBdllRR2VHcnNPaWhnRUdSMVZPbDAvS1Z0SkFxdll3N0JlbGxxOXVB?=
 =?utf-8?B?SElsMWNCRjF3b2IzRDByYWdlS1duck1PWXJoTGdpaG9yUTZiV05ZTzM4U1NT?=
 =?utf-8?B?QlpBZkt5bDNPcW0rYVJmeXNjWHlZbzAwU2syQUkrcGJOTE9PQUhaeUdrSmxx?=
 =?utf-8?B?cnRNa2JXOHhwSHRINTk4VFliS05hUFJ1OE1EWXZTdXFXUjJSSm5PQmI1Kzd0?=
 =?utf-8?B?V1liTFBlaEgzOWdDUnJtQVdpR3JXc3kvd3oyVlR4SllqeS9iWXRzSm1CYUlo?=
 =?utf-8?B?TXRwT094U0l4SGpUV0xEUU5KU244dTg0WDNIYmt1c0FWUlJtMlFtcUlLRnIr?=
 =?utf-8?B?cVpGb0FlQmttY2doM2grZ21mZkMxblpDa1VNekF5UFhOV0VrM1BXVTk4T2NR?=
 =?utf-8?B?M2RYalBSWjhuZ1RTQkxpd2NValJwNmZnMlFydE4wWm9GdEd0NWlPTW9GVnlx?=
 =?utf-8?B?T24xVmpyU3lGY3FweTQ0WE1Qc3hsaVo1YVFldFZMMTlCWjdramlONE9oUlIw?=
 =?utf-8?B?UFJ2NmJrTmVad3UzMUV5NWZCZUwrM0w1eGpvUjIzMm00ejJCMEJGV3BOYW50?=
 =?utf-8?B?RGNFYUEvcmJQWi9CQmJPVkFwb1YzNCtkSVdnWXRqVmtPb0xNOXhrMkhtcUhn?=
 =?utf-8?B?WHVEYW9wbXU2TFZ4WHNUU2M5Y1hjYXVDRjhFMG5HaGQ0OFgvQlgvdWZuUUht?=
 =?utf-8?B?VksrNnRoWnhKdlRlUVlXMnEyVGNaOXkrU08zWEVnYS9lakowZXQxRE5uSFdw?=
 =?utf-8?Q?6nN0STv/Gco=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB7387.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW1OZElabkQ0MFBpb2lMb1QwSHdmOTdSRGxLQUhsbXdBQ0llVThmSEF4T1Rr?=
 =?utf-8?B?N3kzVDRUOFpabGlMVGlQakl4dkZSVmRCelBJWElqMS9PY3dmS3J0ZkNvSFJU?=
 =?utf-8?B?NXAvS0x4RnhQUWNyUmwvZmU0V2RCeEtVVlpnUWJUYnpxZndzakhBelp3M0Zw?=
 =?utf-8?B?VjNYTDVjbFpQUW1oUExBalI4d00rdnZCeVA4akZNci9ORVJrV2FQSXRwKzYz?=
 =?utf-8?B?MkxuTlBvODhEMURTMXdkK2pkcllDTmp5QnFqK2psUCs0MUNUYnAwZG5tY0tk?=
 =?utf-8?B?anZxdWxlQ3RaK2NIZlg4VURwMW05UXgzWGNXZVpmWWhaaTJraW9xYUMybmhq?=
 =?utf-8?B?OTVrVmVBSEdmcXgyV3FUUkFzTE96Rm5ySjNoMXU1N3phd2s1WDdPazV3RWx5?=
 =?utf-8?B?SnJtcmRycTBwVXlkUkRSUmVoMm1OQ2xPeG80Q2ZFWG9MeTRHbXd2Mld3OU5X?=
 =?utf-8?B?blQ5dDRFbGlaUkFxR2Vrdzh5MS9XTmFLWUJZc2hRQnc1azQzSFJoYzM1VEll?=
 =?utf-8?B?aW1tNWNFNk5DbzFGUy9wZ0dGc0U0QTYzNjYzakdkNEFKTStFck1hN1B0S2NZ?=
 =?utf-8?B?aDNFN3B2NFJCWVUrOVUxS0trdjljN2NOOHZuSGE5RVVycEM3YWhJOG5SM1J2?=
 =?utf-8?B?MGlWUE9jK3M2YUhVZmpuYVMrdFpHTUMyWUNuNkY0Z1plQVpKY2YzeURwdGcw?=
 =?utf-8?B?N2M1bEttd2wzZ3c3SVd1bjVwUFNHK0x2cW5rc3VQeXprbkJsL0FJRzcycDgv?=
 =?utf-8?B?Qi9QRmdWbVo3WkNwd1N2VEk3ejZIR0lWenF2THJmL1ZyRnBCVHM0OE9MSkUy?=
 =?utf-8?B?MlJaNDQwVkpQeXE5WENYT1F5aWxzcUZVR0d3VW1Pc05jT1FhV3lzSVdBVGdq?=
 =?utf-8?B?QjRhaVlpcFlsM1VicTJ0RVpXdzg3TWN1UXN2ZXJFeVFEK0dBUXhOVWN2TTZk?=
 =?utf-8?B?Zm1uNUJvcUEzK2dOdiszTUlLcCtyTkcyempJeVpQZEdRRUpHSmVoRzRkdnRK?=
 =?utf-8?B?Z0kzYmdnV0JHeWRLM2R1YXJGZnpjaEoxMVNQSDVVa3dBcHdDQjJQOE1BNjVV?=
 =?utf-8?B?dUJQYlBTcExyck5aczQ3bnE3TndCNnczRDM5UzZGTmxXNWw5T2phZmlnQmtT?=
 =?utf-8?B?U3BraS9mNzRsbkJaNnlyNkJ6cHRiYWlkdkdaYUtEQWVZTXJvY0EvU1g0djVk?=
 =?utf-8?B?Zk13L0RsS1AvQ1ArUXc2VEY4Tk9zMTVySUpZWktrc2tldFhKYTByZ3l6SlFX?=
 =?utf-8?B?RWUwUS9VeTlHeVRFcnEybDVYMURaYW9mZkVMMi9UZy9QS2RDSkkwb0N5My9s?=
 =?utf-8?B?blZiMUdVcktpR0FNNWtuY3RtWlBpWThTRG1SazZUbUp0UmJyVmNDbmZ1TVJL?=
 =?utf-8?B?OXZBdnZ3RVRnWFJQemhqYld4V05MYWxhYjVJdzNHamxuY0F1SmZUVW5tUzFF?=
 =?utf-8?B?YUJDTHp4dUtNdDE5NU5JTjk0cUJsYkJYc1h1SnVZYzlnbWNFNnpscFJmVlFX?=
 =?utf-8?B?VWNvMXhIWUIxNCt1MWZ1emVVLzdnQUozU3V2TmsxMUtqM203MWdSNktreU5r?=
 =?utf-8?B?eWJvVjZ5L0pYUy9iSks1SWN3eGR6c2hmODFZcTMwcWxOTjZXMzdhak4vUE1V?=
 =?utf-8?B?NllLREVyY2UxZmxKRXcwNjVwcnlRTWErcWZIakgzRTIyWTNRYUtKVFg4N3Q0?=
 =?utf-8?B?YXN3RlhCZW9iR3VOT1preE9saUUrSGNSdnBTdm00dWtrOXNUSWN1aXAxVFo3?=
 =?utf-8?B?VHJYNC9VSitDVERXWTBJZGpYVjU0MTFIL1VNQ3h5QjFrWEFIOWVJbElQYXhD?=
 =?utf-8?B?NHRzaVErdThmRHpJaGtOdEpyUlNaR0JUbFp4RWd4WmhSQldYYkNsZ2ExSldP?=
 =?utf-8?B?MTVkSExWNllPckdHV3B3ejZBZjhZQUdqeDB3VzIwckZZNXVXRDVCWnZTaEJl?=
 =?utf-8?B?YmcwOWxLQ1VPZXJkUWZzajdTOTRwWVZYUUdGbkFsWUpjejRtaGx6azRlWm5i?=
 =?utf-8?B?eWdablpad05HWHRCZXRIV21TemJJYzVJdlYvOEQrdkk5bmVDTmVBbUZtZXN2?=
 =?utf-8?B?dHE4Ymg5YlloQ25TTmZqV3BvUnpMOVBXVXJvd0EwZTJSU2RMckdlZmx6TmdX?=
 =?utf-8?B?amduQjlTM0x1Mytzb3dDamVVNkFJTjdrN0RxcVB6TVdnY1lsK1lheG9sTUdj?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c4206b-862d-4063-236f-08dd78d22b69
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB7387.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:23:42.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HU1OU++OqTb/h+O1eb21DQ8jo85WCGMvvJDIORIEdKYHxOoGRytFAdgHL+T9SXdJZNx8kVXpia2TEd3ZKWS9Tku8jKxrm8kpghh+LrwzvJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7655

Hi Neil,

There=E2=80=99s a conflict in amlogic-a4-common.dtsi due to recent merges.
Should I rebase onto the latest code and send a v6?

On 2025/3/24 15:06, Neil Armstrong wrote:
>=20
> On 20/03/2025 10:42, Kelvin Zhang via B4 Relay wrote:
>> From: Zelong Dong <zelong.dong@amlogic.com>
>>
>> Add the device node and related header file for Amlogic
>> A4 reset controller.
>>
>> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
>> Link: https://lore.kernel.org/r/20240918074211.8067-3-=20
>> zelong.dong@amlogic.com
>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>> ---
>> =C2=A0 arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h | 93 +++++++++++++=
+++=20
>> ++++++++++
>> =C2=A0 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi=C2=A0=C2=A0=C2=A0 |=
=C2=A0 8 +++
>> =C2=A0 2 files changed, 101 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h b/arch/=20
>> arm64/boot/dts/amlogic/amlogic-a4-reset.h
>> new file mode 100644
>> index=20
>> 0000000000000000000000000000000000000000..f6a4c90bab3cf7cfaa3c98c522bed5=
e455b73bd3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-reset.h
>> @@ -0,0 +1,93 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>> +/*
>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __DTS_AMLOGIC_A4_RESET_H
>> +#define __DTS_AMLOGIC_A4_RESET_H
>> +
>> +/* RESET0 */
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0-3 */
>> +#define RESET_USB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5-6*/
>> +#define RESET_U2PHY22=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7
>> +#define RESET_USBPHY20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8
>> +#define RESET_U2PHY21=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9
>> +#define RESET_USB2DRD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10
>> +#define RESET_U2H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11
>> +#define RESET_LED_CTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13-31 */
>> +
>> +/* RESET1 */
>> +#define RESET_AUDIO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 32
>> +#define RESET_AUDIO_VAD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 33
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 34*/
>> +#define RESET_DDR_APB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 35
>> +#define RESET_DDR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 36
>> +#define RESET_VOUT_VENC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 37
>> +#define RESET_VOUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 38
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 39-47 */
>> +#define RESET_ETHERNET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 48
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 49-63 */
>> +
>> +/* RESET2 */
>> +#define RESET_DEVICE_MMC_ARB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 64
>> +#define RESET_IRCTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 65
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 66*/
>> +#define RESET_TS_PLL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 67
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 68-72*/
>> +#define RESET_SPICC_0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 73
>> +#define RESET_SPICC_1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 74
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 75-79*/
>> +#define RESET_MSR_CLK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 81*/
>> +#define RESET_SAR_ADC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 82
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 83-87*/
>> +#define RESET_ACODEC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 88
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 89-90*/
>> +#define RESET_WATCHDOG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 91
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 92-95*/
>> +
>> +/* RESET3 */
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 96-127 */
>> +
>> +/* RESET4 */
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 128-131 */
>> +#define RESET_PWM_AB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 132
>> +#define RESET_PWM_CD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 133
>> +#define RESET_PWM_EF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 134
>> +#define RESET_PWM_GH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 135
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 136-137*/
>> +#define RESET_UART_A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 138
>> +#define RESET_UART_B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 139
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 140*/
>> +#define RESET_UART_D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 141
>> +#define RESET_UART_E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 142
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 143-144*/
>> +#define RESET_I2C_M_A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 145
>> +#define RESET_I2C_M_B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 146
>> +#define RESET_I2C_M_C=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 147
>> +#define RESET_I2C_M_D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 148
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 149-151*/
>> +#define RESET_SDEMMC_A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 152
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 153*/
>> +#define RESET_SDEMMC_C=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 154
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 155-159*/
>> +
>> +/* RESET5 */
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 160-175*/
>> +#define RESET_BRG_AO_NIC_SYS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 176
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 177*/
>> +#define RESET_BRG_AO_NIC_MAIN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 178
>> +#define RESET_BRG_AO_NIC_AUDIO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 179
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 180-183*/
>> +#define RESET_BRG_AO_NIC_ALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 184
>> +/*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 185*/
>> +#define RESET_BRG_NIC_SDIO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 186
>> +#define RESET_BRG_NIC_EMMC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 187
>> +#define RESET_BRG_NIC_DSU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 188
>> +#define RESET_BRG_NIC_CLK81=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 189
>> +#define RESET_BRG_NIC_MAIN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 190
>> +#define RESET_BRG_NIC_ALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 191
>> +
>> +#endif
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/=20
>> boot/dts/amlogic/amlogic-a4.dtsi
>> index=20
>> fa80fa365f13c4a93f5577f78bf2b3369cb91cb8..6537153b3026af1bf9d1df0a196619=
b716553cde 100644
>> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>> @@ -4,6 +4,7 @@
>> =C2=A0=C2=A0 */
>>
>> =C2=A0 #include "amlogic-a4-common.dtsi"
>> +#include "amlogic-a4-reset.h"
>> =C2=A0 #include <dt-bindings/power/amlogic,a4-pwrc.h>
>> =C2=A0 #include <dt-bindings/pinctrl/amlogic,pinctrl.h>
>> =C2=A0 / {
>> @@ -51,6 +52,13 @@ pwrc: power-controller {
>> =C2=A0 };
>>
>> =C2=A0 &apb {
>> +=C2=A0=C2=A0=C2=A0=C2=A0 reset: reset-controller@2000 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 compatible =3D "amlogic,a4-reset",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "amlogic,meson-s4-reset";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D <0x0 0x2000 0x0 0x98>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 #reset-cells =3D <1>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio_intc: interrupt-controller@4080 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 compatible =3D "amlogic,a4-gpio-intc",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "amlogic,meson-gpio-intc";
>>
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

--=20
Best regards,

Kelvin Zhang


