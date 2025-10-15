Return-Path: <linux-kernel+bounces-854374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE550BDE37A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B11B19A6014
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812D31D362;
	Wed, 15 Oct 2025 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="TlUuN0FS"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB62E2DCB;
	Wed, 15 Oct 2025 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526662; cv=fail; b=TMNxBYJRia/kGBqWz5UyCuRtUbDOP0WkeKaRq98O04hmxnisV7HvCqw0fneWm/oWDVVJxUsG75kFXkccSpip/8rgNeBbZMFOQ/JkSuh7rBBjaYd1dbH2LTX/Rigw5pgHy/xnHi0dMsSQLDXSdc2MKxkhMxHKUiQE0fUQvq0geaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526662; c=relaxed/simple;
	bh=PWMi3D5u4k16kGVIlEZ0qEg28A97fSDCNz/cnY69isQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VM+B8fkgl/RxY///R/ys4qC/uQIM/PfBGtzF3tsHIgylxTW2x06umntMU56rg6b4PSPRwWj/OfhflfCvDSEARC+slRcW3oiD1JdHi3Ohz4GbE/jzxC9N6cv4Roav9VVhzsioNn7BC9nCB5jGhDzSbOhY+Pbdef95weXUP1dBGP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=TlUuN0FS; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmUwWRrdbMzePOZ6y8Qr9DpYi5YW/YhB6dPKByGvKK/cJ1r81pvdHy52eM0ppzSgiH9DVBnjJkRAnH+Q0cA6Rz9u1if8UzBsTGHFEL2mwO+m5dGC3QdJhUrrMZboGQfISwidKgH3jh2Z7Ttk3Rzd+y5GgqHwyAa4L+bRwzkPmxZDQarZ7sdT5SZBQyVeUsNx11X0+6qbVucNUjrn3tspnvdOkxXOz0AyOlocE6YEhrlZ1s02ZTCafXBRR2MyN0WRG4n3cOZCDA3BlxMperlNs8JPMviEnC0z4GhlJkVuIdJjlcPBweMBIIKsXIRqBjgdoQnG5cljZSWtukeW4ZLdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7F3fAkXvEBouXRVat6h/CvK0HsArZUr4OFoF4xdSpoA=;
 b=A+5cNmAuRI37R5pML8BrSZgIgy9+aa0GoLBmj6d9STZy5YKyS89WoorYw+W3nAJ4NNQfEIJKincYSFgbmsmS0xjbtVdrHBotIlbRUxNa+vOyrVGxMRNZi1LnK80k9eCGPvmOzknSYYibf6LLx2+exL2XTy8lg4mtHei6qIk4dAK//mDu0PvrFi3Pt7AVlrQQO4y8qsKjrmcEnOd+t/419UbTza5vGHf1gQtsPrE8k6R0y5og5eTRudY6sGtt4f5GjutPu4m+IlvM7zy5eu9PS1iLgRuPCMA5uLbGJyXT6hZbQ/V5ZQXXWDyVqWhbrXjGcC7C1FjyD7f3wEkWtqa2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F3fAkXvEBouXRVat6h/CvK0HsArZUr4OFoF4xdSpoA=;
 b=TlUuN0FSC7c6X1yzYZqxjoUE7eN650RIH6BNSWo8eRyks2d3dgkFaIw1YutvAMH3KRqLDD0y3pS76L9mSczJawscR2t7TmvaoD7Ix1sGaTTqaXD32f98GbRpooLF2QRQstvEDS5snG+v8VonLVeTg5viPLKFzgq+C/rx7pN10Og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB11601.eurprd04.prod.outlook.com (2603:10a6:800:302::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 11:10:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:10:53 +0000
Message-ID: <136e566c-de4c-4028-a358-87afdaca1083@cherry.de>
Date: Wed, 15 Oct 2025 13:10:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: add RK3588 DP carrier from
 Theobroma Systems
To: Damon Ding <damon.ding@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250723190904.37792-1-heiko@sntech.de>
 <20250723190904.37792-3-heiko@sntech.de>
 <0582b7bc-e5b2-4b5e-821e-8d2c4301579f@cherry.de>
 <7a0e519b-40ac-4b43-8b9d-f553f12149ab@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <7a0e519b-40ac-4b43-8b9d-f553f12149ab@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB11601:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a5a39a-4a1d-4c60-729a-08de0bdb8115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUdObkJUNFpPR2pzS2dVcGdOVjhZZEpENTRBOWZXcmNFQ1hvVTBGclpjd3po?=
 =?utf-8?B?RVZ5QzhZS3JjUlNmbTRDK3NVdkF3SEUyRndWTkthSDZZZ3FzSFAzNjRENng0?=
 =?utf-8?B?eUZ4dWNaQVJsTE13OEpodzVZSDVSZEVrcTg0STJCZ0ZGang0Mms1RFhjcGZK?=
 =?utf-8?B?VDJUWkVvU2ljSzJKYnJ0RC9vbkxFV0NTaVNRc0lDUW5LNHBUZEF0K0pGQUdo?=
 =?utf-8?B?TEQ3NXhkdkhMZTNSZE8wS3l2Sk5EQmhqNnRxb09wNHE0NFF6NU85cVZkT3VT?=
 =?utf-8?B?MUs3R3czY3FPT1JwUlhOV3hYZXFsVVF4NDk4aGhJcG5IMk00SHladHR4QlFD?=
 =?utf-8?B?d2pvUjVKcDM5cjNpeWhYM013VnBrK1BHcC91NWlRS3JPaVBqNU1vVHMram1M?=
 =?utf-8?B?Z212dld5emRTbW5pZk84dmZYM0tqSWlRWHNNRnFMNVdPcnhDblBRYlZLSkJE?=
 =?utf-8?B?QllDUGp6dGVoQUo1ZlFtemRaYUExSE9oS2grQ3c3eFBKVGwzR0kwTjVrQm9j?=
 =?utf-8?B?Rnc1L01FaUs1VjdoRk5KTFpYMWw1UWpRSFN1NHRwRzNCemp3dmRzUE5lb1pI?=
 =?utf-8?B?L2hYTEsvNEtTMHNvY1pVVEpud0NxL2I2clBSY001YndQd0NZVnBiTnkrOVdy?=
 =?utf-8?B?VjJFZFBhYThHTzdBbkN6bm5Na0sraVo4amRMK2dtaHNtR3hWejlHNUI0MGd0?=
 =?utf-8?B?NjdmNjNkL2xXaHZaQmhiVndsa3psY0FTS1R5NlpiNjF6Z3VEQ2hqZEdCT1lK?=
 =?utf-8?B?NHFMNXNJZG94N1Bqbm1YVHRHbVlOdjQyeXJsZVlxUGZhT2dZVVNiMjdDOHli?=
 =?utf-8?B?K0RDTzgzdGw2RzVxd28rVkpPcm43N1o3RjhRcDRhTDNONlVmMk9TK2F2M3lQ?=
 =?utf-8?B?Y0RkSG5QTU55STlTVXpjNzdmSTcyRjBYOVl6eTNWRUovb0Fwck5uaWdVWk9M?=
 =?utf-8?B?RjJ4d1grclpwNDNuUUVoWEwrOTlRd0RPQ0NlYmtNd1JyOVFxZ3F1Wmd5UGhB?=
 =?utf-8?B?NWwrcWUycjRvaW5EdlovTUZwbGZaVkprdEdjRVNGTmVXQ25JekFCMUJJZE9F?=
 =?utf-8?B?NjFuWHlmQk11eHl4dDRodGlvNE9hMWl0K2kwcnhwUUtZdjdSWHdSUkkwanFC?=
 =?utf-8?B?Q0h4S2VDMzN3YkczTVB4ZHdtc0U2NHBDRm1nR3VvVzdNZmprMC9IclJyRi9H?=
 =?utf-8?B?K0k3OHpBbThtM2VoZkhuY3NSdkNPV3BTZHBiNTBnVDNEcU55S3VHY1N0RjFn?=
 =?utf-8?B?Vm1iUGcwVFp2SFlGVFlrMmMrYkh4Z0xGMnJ5MlVCTlJLSnVpL01CbHgyaURF?=
 =?utf-8?B?TmxRRnZ3ZDdnc3BLZFdNWjMzeGpNLzB6alUyR0NVWENmbmFZbjBJaVFSK0h2?=
 =?utf-8?B?SmhCMG4ybUgvaFZTanVEZVBjNG5oTWRXNTdkdDkzYk1lR0o2QmJUNnFyYlo0?=
 =?utf-8?B?NC9QdUpjNmU5U1A1RnFGSENLdldYUTUzTjZXbEg3S0kxRmpkYXV6N29pRHdR?=
 =?utf-8?B?Rkg4NEk5dFk0UC9hbFV3U1IyZ2VIOUNQa0wyWXBLS3pmVFkvbEVZK0ZQY2J3?=
 =?utf-8?B?YVBSUnE5R1BTQStWNmZtYnlCN0xrbGxhanJXSUdaRDRKeVg0bDFFL2xIZHpn?=
 =?utf-8?B?b1RPNSt5RDJ1c2JiM0VlSkdpSGRHWEhMUUpXb0V4a3lhYld5Z2lncnNqeENq?=
 =?utf-8?B?ckR3TzVRWkZtNVpWUUl1V1RVQjA4R20rbmcyQzhvMGFzcWliWFNzbzE3c1pp?=
 =?utf-8?B?U1N6K3ZEOW4vVWR0aTRlN3lZaFg5bUdubExtVmJvTGlvRUJSWWpBZU5VdmZN?=
 =?utf-8?B?Z1A3cnhsd3NzbVA2dFBhUkphdHFXZ3dLV1ozNHRvVWw1N0t4SDl3QUg4SXgr?=
 =?utf-8?B?MitiRHBSZWpuYys0clBXdFdZbGMyRlNqVTA2d3BqZlc3R1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L204U2NjRlVPZVNBRjZmUFN3UXdDbHkrMzJ6VGdObXd2ZkJVSzhUazlINTRQ?=
 =?utf-8?B?RytZOXB0QVMvbTBTSVVuNzZkbklWcndZcENrUlVPM2ErYnRpYy9abWVaUnl0?=
 =?utf-8?B?NkQzWWdQRjN5cmpqUHhyRmtXM3RIN3dHYWJveWRtbXN4TDc4MUkvTDgzTmhh?=
 =?utf-8?B?S2hINTdJZ2kwZFhyYjVtWUpDa0JRLzMzNE55S3FVamx6Y2lVcUlHRXE5VzZL?=
 =?utf-8?B?VkNoaHlnZngzV1FhSHN3SjNjS3R0ZkRUMHA0RXJ6Rm5MQ3pLdzd3bU5LVkhB?=
 =?utf-8?B?cWJSZjZsNVFkQzlIZjdIU0hZSDRHZmVNWWFGRXFadW5HV0Y0K1EwTGZwMStq?=
 =?utf-8?B?Y3EzeXdOREJXbGlqbTRTOGszR2ZxT1RiZ2RJU3NyQWw1SmVFaVh1MG9DQkpF?=
 =?utf-8?B?Uy84aEZETUNWOEhzZkhGTzhEdDBsRkg3V2YraExpbHJZelFHeWJLaDRLTjJU?=
 =?utf-8?B?ZGhySVliOTdocDNDNktXa3pLMjdEWUVUSzVqTnpzVFFYdDN3UTRBOXcvVlla?=
 =?utf-8?B?bjdEcHhyVDZ1c1pNSkMwSTJVTTl2aGtsaWs4c0w3YXV2S2lGeTlXVXpxMU5E?=
 =?utf-8?B?WW02cVFOQnV5S3loMlNZc2tKRFpnc0xhbURid0ZLMlNBbTd4LzRqTG9hd2Fu?=
 =?utf-8?B?Uk9rS2ZlMVh0WnYzUVZYRkozZmFrYXAwaFVHcnBGWmRZNzZXdGg4aHQzVzRC?=
 =?utf-8?B?Z0tGeDlJaWd5VkJXemljR2JFa3pwRnVQT3UrU2duRDlLOEQyMTlDekdudm53?=
 =?utf-8?B?Y0lsSWM5UThPb0FLYTVXZ0NJdU5NdzJDa1NZSjFUMWRQVmdRcllVTk9IcGR0?=
 =?utf-8?B?L2Q4YkFaMHRtaCtVTmUwUzhYa2RndDJmTk1DSytIaUtXY0pzbWx1dWduaDVL?=
 =?utf-8?B?UjhZUmNvVGhHMVN2djk3U0pJNXNNdlkvK1BMZHE0dTl5OHpOMFlGa1ZSbVZP?=
 =?utf-8?B?U0F5aUF6ZGsxWVpjalVnbUwwMk5tRmZTWGhtN1FUK0cycW12dDB3OURJQ3p0?=
 =?utf-8?B?RTFvdlBuQ3p3RTlWRURKWE0vUVFhbzA5N2pJdTU2VHQxbXBXbWFGcHY1UHI5?=
 =?utf-8?B?a3hzZFc1cmIxZXNvTGlrd011NTZzUkFpZFlEN2IwRnByR1NtZ1Vkdmg1dVIz?=
 =?utf-8?B?NHlFSis5S3MrdVhzNHQ0WXlnRjVxVHUyMVA2bVJram9kbWh0VVA2L2plUVl6?=
 =?utf-8?B?ZXkxMG1PcnpaSlExM1pFODY2RnB6OHJWT0FDOEgvSzJ2eGFBdVVaM00yK1Ey?=
 =?utf-8?B?VDYvUVY1NjJidnAxdjE4MXdVbFYxVHg2dFpJY2cxQUFWTGFUN1NUeEpLcklZ?=
 =?utf-8?B?NHZVeXNuYVZWOVhtWGY3WnF4Z2NaSVFUSlNGVWFOVUtlNWpTdnBEZEJYMHky?=
 =?utf-8?B?R3lRUERFSVhlN0JaUG1ub0w2RWJMY1NBUkNxemV5SEZhWFBPWjZxY3ZOb0xW?=
 =?utf-8?B?QUY1R21GNmRjT2VKNWExSzJ4K05TUmwyM1lHNzhUdzlnN2hYOVpzU1ZxZDN6?=
 =?utf-8?B?RS9TODFyK05nQTBWM2dZbGJTN3VqeWtzQUwwT2R6QnM2NXRwUHRVeXVRSVJ0?=
 =?utf-8?B?bFo4dHo4NEVSRzBIeGF6VWxPc0lzMTlMMGlvSEVSenlXNHFzNGFaWEZHV2Vo?=
 =?utf-8?B?RDY5R0Mrb1lab20rZDZrdGFaTmx5WE5vRVV4dXZFcDhWUW1iQVdvMFJGQm1z?=
 =?utf-8?B?VFR3UHdlcVFRNlhGR0Y2VkJkNzkrUnhUbXJMMVUxMVJMVm5wanF5VnkvTjRT?=
 =?utf-8?B?YzNTbGcrU2tMZ3lrMUpCMGwrR0oxdGdFN0pxQW45M09WaEpsTTgvUXlqVWho?=
 =?utf-8?B?RXRqbmJUY2dhaEZnZVg5RktKUXR5WldDMWpZRUFQRDBLWXhmWUJpM2FiUmxa?=
 =?utf-8?B?ejUzekMwWFBFU21Cdk1Dd25Ka2MvSDVpdW40djhRcFhMYU1QM3pJejd3eVZh?=
 =?utf-8?B?b0w5R1VtKzIxdm56ak1BT0E0MGdxYlk5NE1JMU8zbHAzeWxSZkZkNllYYnQv?=
 =?utf-8?B?ZUZBSTFKVjgvSjUwcGI4cVhsOTR6K0Qzb3o3RWpkOVJFT3dkWmRJbWNjS1Bt?=
 =?utf-8?B?R2NyeUlSUk5zRys3MXQ4Vmt3eWVXNkdwYkRtVFZiV0x2aW9DT0w3S0N5N21v?=
 =?utf-8?Q?zduG6b24HYe5d+zL1glSKLVGm?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a5a39a-4a1d-4c60-729a-08de0bdb8115
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 11:10:53.3655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VHRE9wRwQHIXqCA/0TrHOAQNyJeHn5z+9Vk3qX9FfcCnT5gacxvHsxsKWGu67hr8+hzHA5LQCfgHYutjqQbQajDLdiSv3OPSc7SSM8xUSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11601

Hi Damon,

On 10/11/25 5:05 AM, Damon Ding wrote:
> Hi Quentin,
> 
> On 7/25/2025 8:29 PM, Quentin Schulz wrote:
>> Hi Heiko,
>>
>> On 7/23/25 9:09 PM, Heiko Stuebner wrote:
>>> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>>>
>>> The DisplayPort carrier is a very simple baseboard only providing 
>>> serial,
>>> ethernet and a displayport output.
>>>
>>> But its main functionality is that it routes the Analogix eDP controller
>>> to this DisplayPort output, which allows to test that controller simply
>>> by hooking it up to a suitable monitor.
>>>
>>> The Analogix-DP controller supports eDP 1.3 and DP 1.2, so can drive
>>> both eDP displays as well as full DP monitors. It does not support DP+
>>> so passive DP-to-HDMI adapters won't work.
>>>
>>
>> I tested this on master (2942242dde896) + v2 of the eDP driver as 
>> listed in the cover letter, or with v3 of the eDP driver + 
>> 48f05c3b4b701ae7687fd44d462c88b7ac67e952 and in both cases I have 
>> weird behaviors.
>>
>> First, `reboot` is stuck for a very long time before actually 
>> rebooting. I think you have a stacktrace when you tried yourself, I 
>> don't so cannot send one.
>>
>> Also, I tested on two different DP displays, one has a green tint, the 
>> other one purple. When trying out other resolutions with modetest, the 
>> kernel would often crash (no trace, just nothing on console, SSH 
>> dead). Note that the same HW setup with downstream kernel from 
>> https:// git.theobroma-systems.com/tiger-linux.git/log/?h=linux-6.1- 
>> stan-rkr3.2- tiger works just fine. I would assume this has nothing to 
>> do with this Device Tree patch here but rather the eDP patches missing 
>> some bits maybe?
>>
>> @Damon do you have some idea?
>>
> 
> Apologies for the delayed reply. :-)
> 
> Since the patch series has been updated to v6, could you please rebase 
> these patches? I will then conduct further investigation into this issue.
> 

OK so I checked with:
https://lore.kernel.org/all/20250930090920.131094-1-damon.ding@rock-chips.com/
https://lore.kernel.org/all/20250930094251.131314-1-damon.ding@rock-chips.com/ 
(patches 14-18 of the previous thread)
https://lore.kernel.org/linux-rockchip/20251009225050.88192-1-heiko@sntech.de/ 
(v4 of this series)
https://lore.kernel.org/all/20251009193028.4952-1-heiko@sntech.de/
https://lore.kernel.org/linux-rockchip/20251008133135.3745785-1-heiko@sntech.de/

and I'm happy to report that it looks good now (small issues to follow) 
on both my displays.

I can boot with or without the display attached and it'll show the 
serial on my display, so that's good.

1. When I boot without the display connected and then attach the DP 
cable I get the following kernel messages (but the console is shown on 
the display, without artifacts):

[  105.469838] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[  105.476889] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[  105.481646] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[  105.485714] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[  105.490294] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[  105.587544] Console: switching to colour frame buffer device 240x67
[  105.663754] rockchip-drm display-subsystem: [drm] fb0: rockchipdrmfb 
frame buffer device

2. All modes reported by my displays work (except one for the Iiyama 
display, 720x576@50.00 reports "Out of range" on my display). Though 
some have some "glitch" before showing the modetest pattern. On the 
Iiyama display, all modes except 1920x1080@60.00 start by a 
near-pitch-dark pattern except for the location of the bottom left white 
rectangle (see [1] for expected pattern) where it's now very dark green 
(almost indistinguishable from pitch dark), this lasts for a fraction of 
a second and then the modetest pattern shows as expected. On the Dell 
monitor, it shows something different but it goes too fast for me to be 
able to describe it, but only for mode 1024x768@75.03.

3. For both displays, all modes except #0 make the kernel print the 
following:
[ 1059.315123] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[ 1059.329418] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[ 1059.343840] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[ 1059.355668] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[ 1059.366802] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[ 1059.378528] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)

on setting the pattern and

[ 1064.602029] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[ 1064.616136] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[ 1064.627958] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[ 1064.639091] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)
[ 1064.650835] rockchip-dp fdec0000.edp: AUX CH error happened: 0x0 (1)

when going back to the console (note that the hex error code is not 
always the same, but most often is 0x0).

Misc:

- "Script" for testing all modes:

CONNECTOR=$(modetest -M rockchip | grep DP-1 | cut -f 1)
NMODES=$(modetest -M rockchip -c | grep -E -o "^\s*#[0-9]+" | tail -1 | 
grep -E -o "[0-9]+")
for i in $(seq 0 $NMODES); do
   modetest -M rockchip -s $CONNECTOR:#$i
done

(modetest is part of libdrm-tests package on Debian)

- Modes for my Iiyama display:

83      82      connected       DP-1            480x270         28      82
   modes:
         index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
   #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 
flags: phsync, pvsync; type: preferred, driver
   #1 1920x1080 74.97 1920 1968 2000 2080 1080 1083 1088 1119 174500 
flags: phsync, nvsync; type: driver
   #2 1920x1080 59.94 1920 2008 2052 2200 1080 1084 1089 1125 148352 
flags: phsync, pvsync; type: driver
   #3 1920x1080 50.00 1920 2448 2492 2640 1080 1084 1089 1125 148500 
flags: phsync, pvsync; type: driver
   #4 1600x1200 60.00 1600 1664 1856 2160 1200 1201 1204 1250 162000 
flags: phsync, pvsync; type: driver
   #5 1680x1050 59.95 1680 1784 1960 2240 1050 1053 1059 1089 146250 
flags: nhsync, pvsync; type: driver
   #6 1280x1024 75.02 1280 1296 1440 1688 1024 1025 1028 1066 135000 
flags: phsync, pvsync; type: driver
   #7 1280x1024 60.02 1280 1328 1440 1688 1024 1025 1028 1066 108000 
flags: phsync, pvsync; type: driver
   #8 1440x900 74.98 1440 1536 1688 1936 900 903 909 942 136750 flags: 
nhsync, pvsync; type: driver
   #9 1440x900 59.89 1440 1520 1672 1904 900 903 909 934 106500 flags: 
nhsync, pvsync; type: driver
   #10 1280x960 60.00 1280 1376 1488 1800 960 961 964 1000 108000 flags: 
phsync, pvsync; type: driver
   #11 1152x864 75.00 1152 1216 1344 1600 864 865 868 900 108000 flags: 
phsync, pvsync; type: driver
   #12 1280x720 60.00 1280 1390 1430 1650 720 725 730 750 74250 flags: 
phsync, pvsync; type: driver
   #13 1280x720 59.94 1280 1390 1430 1650 720 725 730 750 74176 flags: 
phsync, pvsync; type: driver
   #14 1280x720 50.00 1280 1720 1760 1980 720 725 730 750 74250 flags: 
phsync, pvsync; type: driver
   #15 1152x720 59.97 1152 1208 1328 1504 720 721 724 746 67282 flags: 
nhsync, pvsync; type:
   #16 1024x768 75.03 1024 1040 1136 1312 768 769 772 800 78750 flags: 
phsync, pvsync; type: driver
   #17 1024x768 60.00 1024 1048 1184 1344 768 771 777 806 65000 flags: 
nhsync, nvsync; type: driver
   #18 832x624 74.55 832 864 928 1152 624 625 628 667 57284 flags: 
nhsync, nvsync; type: driver
   #19 800x600 75.00 800 816 896 1056 600 601 604 625 49500 flags: 
phsync, pvsync; type: driver
   #20 800x600 60.32 800 840 968 1056 600 601 605 628 40000 flags: 
phsync, pvsync; type: driver
   #21 720x576 50.00 720 732 796 864 576 581 586 625 27000 flags: 
nhsync, nvsync; type: driver
   #22 720x480 60.00 720 736 798 858 480 489 495 525 27027 flags: 
nhsync, nvsync; type: driver
   #23 720x480 59.94 720 736 798 858 480 489 495 525 27000 flags: 
nhsync, nvsync; type: driver
   #24 640x480 75.00 640 656 720 840 480 481 484 500 31500 flags: 
nhsync, nvsync; type: driver
   #25 640x480 60.00 640 656 752 800 480 490 492 525 25200 flags: 
nhsync, nvsync; type: driver
   #26 640x480 59.94 640 656 752 800 480 490 492 525 25175 flags: 
nhsync, nvsync; type: driver
   #27 720x400 70.08 720 738 846 900 400 412 414 449 28320 flags: 
nhsync, pvsync; type: driver

- Modes for my Dell display:
83      82      connected       DP-1            510x290         12      82
   modes:
         index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
   #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 
flags: phsync, pvsync; type: preferred, driver
   #1 1600x900 60.00 1600 1624 1704 1800 900 901 904 1000 108000 flags: 
phsync, pvsync; type: driver
   #2 1280x1024 75.02 1280 1296 1440 1688 1024 1025 1028 1066 135000 
flags: phsync, pvsync; type: driver
   #3 1280x1024 60.02 1280 1328 1440 1688 1024 1025 1028 1066 108000 
flags: phsync, pvsync; type: driver
   #4 1152x864 75.00 1152 1216 1344 1600 864 865 868 900 108000 flags: 
phsync, pvsync; type: driver
   #5 1024x768 75.03 1024 1040 1136 1312 768 769 772 800 78750 flags: 
phsync, pvsync; type: driver
   #6 1024x768 60.00 1024 1048 1184 1344 768 771 777 806 65000 flags: 
nhsync, nvsync; type: driver
   #7 800x600 75.00 800 816 896 1056 600 601 604 625 49500 flags: 
phsync, pvsync; type: driver
   #8 800x600 60.32 800 840 968 1056 600 601 605 628 40000 flags: 
phsync, pvsync; type: driver
   #9 640x480 75.00 640 656 720 840 480 481 484 500 31500 flags: nhsync, 
nvsync; type: driver
   #10 640x480 59.94 640 656 752 800 480 490 492 525 25175 flags: 
nhsync, nvsync; type: driver
   #11 720x400 70.08 720 738 846 900 400 412 414 449 28320 flags: 
nhsync, pvsync; type: driver

Do we want to continue this discussion on the DP controller patch series 
instead of here?

[1] 
https://wiki.luckfox.com/zh/assets/images/modetest-RGB-88cf751fc5f0f148115cf67a7370998a.png

Cheers,
Quentin

