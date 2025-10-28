Return-Path: <linux-kernel+bounces-873810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42244C14C94
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E1F18891B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E4A3314AC;
	Tue, 28 Oct 2025 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="8Udb5EXX"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023120.outbound.protection.outlook.com [52.101.72.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CC432F768;
	Tue, 28 Oct 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657098; cv=fail; b=e1jCnA7YzHkRSZGWxkwA5SWyYmH2UOtzEJ4Y60UZWrCylP82TlqCtFJ1IhoXboCgE6PzyTYDtggtPZAiKGo24j8lhYsII80LZYqT25vn6t2+XihfWAao1oA4LHFWatyaspzFq6v+nr+kcntAUZphlHMP6EyVkf+pPAMQFq5G4Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657098; c=relaxed/simple;
	bh=frPMziPl+S34vuk1f3KcCe1EIbDAxNli0YDAbWa3zP0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SnVpRiCKLaBJmjcuU1HV16dL4llXomMLVkkSWPU+vJbRzsUBy2x1NTyF6XWtfH6rCITvzuJMxyNFltg4Ld5r5Pnpi5GNi3XAnSGOrle1YMUHVOZgMVvSVEU/fwR5z7kD9S3qXzsq4aFUZvEtC2DLxXo0/jXRIHUoJuBvR0qdfV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=8Udb5EXX; arc=fail smtp.client-ip=52.101.72.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPy6zLphcHu5+BL7XfoPXIN+KYlOMO5i8EC8pIlPmyix9mv8PD01+RNZx408xTNIhahKMP2TTIA4jrRNJwYTFdMKq40EJBD1rulI7tL/0kbvzBD9vss0K29N4mkDSaFzfh3vAtCjlmSGtzekSRW751rGRDiWq0saNERR89Mv+PltbUjVRvVhBVhz4irU9li91HkW3St+M25ieCYvFcKMoG2xqzAbXlYQgg5Ma72iFnBQK6lrGcGPS5vhkX7UTKihvvZ8G3M7sgpJASpWlukCsmrAGFl9iBtC64ETk94zkIiN+qklIFnAkcmbTMtZEZRveemhA3GzTmcerdld1/8K/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lBFadlSkvZnEEehHr2LBcA47Jw0MHCMBx7fxzT8BbI=;
 b=OZTZeGMb/s2mEcmSrc6hMTyW5ss4NGSTWL+ur+Y8QLJ2bmHwN1vNFaofPIyFvfA/4feuy5Ov3eoky+3tPpYrciBFg6Pkzm6ygS2aQ46hP96yE78MYhR76NpjF0FVAusRwSmIjISHaw1nfyK05+/qHdBwykY8AdsjZ/dKBV2LJ8sNnwNotZmHfIeqr6XDySexFmX8NbWlys0flx6YB0UgHLoHiqY3+wmeaZPSEJEWP9OWBmWJAJbWQIdNfLJRaCXShEeStJ2JxEHngdAQSznBm3RTEgGELArpmE8UWm7qmdFGEnpWLUJKbPHXO1AazxDgl12U5OqcdpnsEd9Oh/fm5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lBFadlSkvZnEEehHr2LBcA47Jw0MHCMBx7fxzT8BbI=;
 b=8Udb5EXXetHfp5Lo+7nIM7OA3Q/0FyWal0vEEuaJ84OPmeyN6YTTCr3zEmXFdE0BAmu4+TngCKDafoJ3pja+0vZTOPsqUy+BBrBsph4VRgTZ3p2o9m1AtZcW/uw73UxQ52ZqOcsZSI55DNnqI451JiqAE8GoyMR9HF8d8jXOOFo9S/r5gH4Y/u5YYUCTwzV5uLQXHcQ4o4CmT5MUozjVfBj9ZXOdifPqNmgBHxCU8t/EBIw61jIdZ4YRSZQQAKR+Ip99C2UWN1T1+/9ZUG4inVDRNKB2bn7UF3V0HTJWA5qWSvWP3rU9O7GIpQkEOnSp259S9dYT1ORsKoWQNrXCgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by DU0PR04MB11259.eurprd04.prod.outlook.com (2603:10a6:10:5dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Tue, 28 Oct
 2025 13:11:30 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%6]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 13:11:28 +0000
Message-ID: <938f85b0-4c9b-463a-960a-f5f4e4092480@gocontroll.com>
Date: Tue, 28 Oct 2025 14:10:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
From: Maud Spierings <maudspierings@gocontroll.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 LW@KARO-electronics.de
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
 <a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
 <65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
Content-Language: en-US
In-Reply-To: <65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::32) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|DU0PR04MB11259:EE_
X-MS-Office365-Filtering-Correlation-Id: b60b657b-508e-4c12-ec0f-08de16238135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1BINlF4T3FHaFFzRjJvWmoxZ3AyZ3laVEQ4MndrdXV5RFU4Z1dObVJSaWZU?=
 =?utf-8?B?aVJRVTE0RXYzTzVSeUZBdFF1R0lYMVpLVnBkNGhiYSt4YUNzcUtNc2ljZmVH?=
 =?utf-8?B?R01VYVlkbno1elgzdUc1emd2ZnN4U3k3WWxUY2NXb1NjSFVZbTZEMHhiTjl4?=
 =?utf-8?B?TGkvNXpTSTdGaUMxTWdKd0FpMHdLbFJFS1NQeWIrb1FCOFNnME9HZTQzZGRH?=
 =?utf-8?B?Uy9NQkZKWVA2SGp5eGZBa0txeFMvbC9Oc1hhbXlHT3prSmxhMVVtOGFydkIr?=
 =?utf-8?B?blFJWHBybGRWTnIyYzNoUWh1V0lKbVpBcmZNMFU0UktsTG93RzV0VGFhaGdB?=
 =?utf-8?B?Tzd3SkVVZkhJaW53Zm00dkhYNEtiQUFMdlpBaGhIZk5QbFhseTAxVTVxUU1j?=
 =?utf-8?B?NzRCTld5V1BSUFFQT0dMQzBhNm1oY1dKclBscFVGa215M0hzM2EyaWN4TlRO?=
 =?utf-8?B?QkJwMWdKdDdZY1F1Z3pkR1ZBVWFyb3ZKeXJNZ3l2VGNkcUpKTCtCZ1VLenpj?=
 =?utf-8?B?ZlVDek1KemVUUlNJeGhSTnpSL25HNUZvTHlwUGR2NjRPSkdqMm04VXVoNDhq?=
 =?utf-8?B?cmNyZ1d3dGU4VVM1VUNHR0x5TDBacmdyYlBFSTNwSmY4bFFlMURYYlgvcnlr?=
 =?utf-8?B?U2R5ajRXWEJ0eVUyRmtBaUdCQUhXdDRMQUpFRTVsbWpBVXZObVhkVGpYWGgv?=
 =?utf-8?B?U3E0bmkzS0hxNmZLc3pzWlQ3ZGZwRWNUQXJabjNHenp3THRNUVhTSTN6cUMy?=
 =?utf-8?B?cGdPdEdDaDB5ZkxIRHU4d05xcEVYM0Y0K0R2ZmZJTEF3SmV2K3BKem1GTytw?=
 =?utf-8?B?WWFtV2NLbnZMci9oTnhHOEZ5azlZcThRVUVnYmpHRm1PZ25wUnBFVEJsUGJH?=
 =?utf-8?B?M2tNYktWcWhFbFBiREtZV0FrSnFaZVFxdzJmUkk4UUlkd2RwTVJxcEF4T0hL?=
 =?utf-8?B?bWFBdzltenhoNVNNZ1dCUGxtdzhJTnNZL1VRbGU4dnAyVGVmWTZpbUlsay9B?=
 =?utf-8?B?TWNHR2Y2MlFwZUZFeWxhYzExU3dmRzdPRGE3RlpwdzZGWnFwSGFvZEYzbzdS?=
 =?utf-8?B?MUdrL09oZCttUDgyOWxIRzAwVm1IUm5VVkhUN0JxU3ZKODVYT3NWeGhMNjZ2?=
 =?utf-8?B?Rm53M054STREK0VCYnI4QmV6b0pMQjA1YzlBTWJrcnlvTDZVdjVkWUNnODdF?=
 =?utf-8?B?MFlvRnVWNTJiSjNpTGhNdnBnTGZsN2Zma0dnQWlieVAvdlNXbzdVZGJUNzF6?=
 =?utf-8?B?WEJhbU1ORkxMc1ozS3ZRSXJUS0t2NjBuYlV3cEJXM1YrTlhHNXkvcERDTGNy?=
 =?utf-8?B?NGx2K21ub3NPWHNRcENNWU15OWo4TDRoSzhURUUvanFDZ28xYnZ4a1BpTk9Q?=
 =?utf-8?B?dnNtQTlSTk1MKzArSHBMSFhJdDBLMGFJU0xaWktadWRyL2xXS3FOQkFFbWNJ?=
 =?utf-8?B?K01LTExXbEluOG44M3VoNTB3Z0sxeHdkb1BsZVdIMFBlWEYrRVpGcWFwS09q?=
 =?utf-8?B?dFpXWnIvdFMreFI2VVgrS2NuczVHaXlpTFc5YStNbTFxbTlhajF1d0JqMVpJ?=
 =?utf-8?B?NWUyOWxLYk5vYzAyTjcwWmdELzRQbCtneWNjR2pJd3licmpaTDl5a1hMZDgz?=
 =?utf-8?B?d2lza1dXNEZFa0c0K2o4ei9FRFVQZThpL2VuL2JhdmRneXVSanRsZlc4SDhF?=
 =?utf-8?B?Z3dLTXRsblJOTTNtV0xJSUVZZFZ4TGh0TUtyWi85ZzBGV0JFbHBmMWdzS2t6?=
 =?utf-8?B?QlFCV1Z5bnRoNjFZajBoczU4YjZ3M1gzSFpVNGZFSGIzRTJ3eU85WVoydGts?=
 =?utf-8?B?TUZDb29PRHl2SEFPcnMxOFZWcEdheFdGSHhOUzVsdDdlL1RjUERFRW5EZGly?=
 =?utf-8?B?QTJ4Y3lYejZTVzUzWHc0NzFCbzFJL2dJcUR2NjhqSkZuNkgwWDRHUHBkaHZa?=
 =?utf-8?Q?xK1w/uwM+O9mR9pVjAjX5oylTpDhbx0n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUpURWM4Tm5HNkV6b2pPQWxXY3pKb2hGSHlIRTIwNVFzSTRCRmpqSHZQdjF0?=
 =?utf-8?B?RmUxQjdtcWE0UUs5RmQ5bE1ENTVJY1k5Nkd4a1oxN3pzWkR5SXU1YVFySEli?=
 =?utf-8?B?U0gwUXdPbG1QTGorY0V3d2hSdUQ0eDVJTlpnQlpqWU02b2U1Zyt3ZVJhdFlC?=
 =?utf-8?B?WUFSbS9BckloUXFwMER2bEdmN0NTZU9wOElLZVh2ajllUFFhOWNaZUpibTNu?=
 =?utf-8?B?RzlRTmw0ZzlOK3hpVDhCWjdQdGVHWTVqc3o2dEV6bFlBYm5RTWNNTkg0Nmdv?=
 =?utf-8?B?NDR1ckc2dUxRVFFkRCtSelNTMTl0U1dUeG8yNzdrKy9zWFFZa0dtQ1N2eWE0?=
 =?utf-8?B?eFVMdlZUTXIxb2hBK1BLcDBsMjF3MC8wV29PTHQya1VwWFVuRlkxZllQTk1N?=
 =?utf-8?B?L0dNd3JQV1RiZVc4VXBCY0k0SGFkRjBhY3BmaWJUR3FFTGtJWjFUdWZpTUd3?=
 =?utf-8?B?ZW5qb2liYVc1ODhqd0dHNWVQajAwU1hsOXA0TU5vazZITDY2clZEOGdvb3Yz?=
 =?utf-8?B?Q0wxVkc2clFkcDAxOHBhSGZScjZQZzFpTFkwUWdzR3BIa2UzdGFWY2lLeTdN?=
 =?utf-8?B?QlR1cmkvdzRYVDdadWQ2VUkvVkRTcjBRKzQvVjVIZGt5ZlE1K2hGSEFkK1JZ?=
 =?utf-8?B?OWJSb3huMGFHajVtUk5vSDhNUG5ncnM5QVhqNDJiZDZmRDBPVldFODFCcTRR?=
 =?utf-8?B?TXFsSWpXWFhYQmp5S09nSUdtWjh0ZE1oS1pheDhPL1BDdmwyakNWU21oMDhv?=
 =?utf-8?B?cFFWL3F4Vk9EMndybFR5MEh6S1JFNHVET0E1MFdTTDU2WFZscUMrWmxTdHR2?=
 =?utf-8?B?bTJ3WTFqaDlKZmoydVM3b0hOOU1vTjhOVCtiOXd6Y1U3a1NzUTU3ZDZOK0xz?=
 =?utf-8?B?cEtaMkx3bXEyMzF4Y0NRNUZCNkVIOER1NVBrczI5dXVCYWJDSjNJbnNxR0k4?=
 =?utf-8?B?a1crTnhDMzExdk5UTzE4azVPT2NkQnZQYTduS080YzBBQ2JQWkorc1BqS3Y5?=
 =?utf-8?B?Q1NGbWlJTGlOV3lkcXd1K0s0VzhxdlNRS2loVGF5U2t5bXQrcmE2c1V2NU84?=
 =?utf-8?B?dmFaK1VmS3laWm5uRzVhNW0wZWFYdUhIYzBhTWw1T29PNjNlOUM2V2R0MExW?=
 =?utf-8?B?Q1pWaGYvQmhiN3NZT0c1RG5jcHE5aURnamgzM0hLMWRIMU5vUFVpVzFwMVpn?=
 =?utf-8?B?M1UrbTEyTWlQKzlyWitoM2VDSkMxWDBKYnBWWklkbXdEcVFFOE9MdUxKakxz?=
 =?utf-8?B?NUtrdDhXekVtSUlyZHR0elB1UllGMlJ1TDdqMnJ0dDZsL2hsM2dYYlNkRUdk?=
 =?utf-8?B?WXM0RFgxNlk0a1FWbWxhOTlnckRXeHBNcjZ3UjdYc3R2bHgyWFRSZW5rSkJ0?=
 =?utf-8?B?VzRXRXZreGNEWmdqdEEwVDVlNngzaW1YT0ovdk1tOVF1blRTdlQ1YXE5elZZ?=
 =?utf-8?B?cFROaVNVa01lVmI4d2dycjNJbmg2VG4yZElsZHFQSmVXb3hndXI4TCsyQTda?=
 =?utf-8?B?ck1yZm9vUDB1bkFCTEJIb1lWZTQxSkxUU3kvTlJaL0YrVTNXYkN4YXk2MXJX?=
 =?utf-8?B?TVlhaWI0UnpZYTkyVURQNDRKaklNK1lBdzZqaFA0akp6UVB0cWMwZ282Snlj?=
 =?utf-8?B?Zk5EKzk4aWtQd0F4YlBVVU9xbllZYTM1N3IwaU0vV003NnE5SkFmdUlHYUxs?=
 =?utf-8?B?V21xUzZPdXZOY0tZbWEzeEwvZ3lnb1VpWVpqaDNGcUNicXJKNm51ZXU1SFM2?=
 =?utf-8?B?RWtJSndOa0JtNXozdWF1bGVRWDhPMWs4RldrNi9WSUdWTFlHQlEweklmSFRS?=
 =?utf-8?B?NHU4RUJuUnpjOWJGeVFKTUhjR0dKdVFaUW4vSGtuM1ltb3hQY3pQcVYxb25S?=
 =?utf-8?B?Vk5hdFI5aFdNWDZHMFBEY3AwU3FnaklxclJiQTJOaEdjYkRTSTJpY3VLK2dX?=
 =?utf-8?B?R3JIYzF4czZ2bGRKc1ZhZm1NelpwbXIvM3pUQ0JLaVVJSFBaK254bWhQak1j?=
 =?utf-8?B?cVFSRWRkOXhWMGo2WWhEdjlXTEZPQjIvRWtjR0JQa1ZqR1BsaGFDcEFBMi9k?=
 =?utf-8?B?UWlvZ09iNWc4N29Uc3RjUHZkUG0zWGdjL1JlU0NQcHhLTmZycGVsZ1NUaHBy?=
 =?utf-8?B?N3NxL1hoM1pEc0lhTUNXSGozcVUzdTFqS2cvVXY5MVo2MHJUcmd3REpBRTA1?=
 =?utf-8?B?NjZrV1FFLzNFanFlOEFiOFNpd21zenBlWGFYSzhyWmppdVVrVExqd2lCVTFt?=
 =?utf-8?B?cjY2VnM0elREdi9wYjJhOHZYUWhRPT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60b657b-508e-4c12-ec0f-08de16238135
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:11:28.2063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efvovRpLxm4yn1B5q7Q83lB+0NS30ZMnL5kU3lEMDTC+2vIgx/KyRWXZv+22Vf4jEbjvSDh1VF25XkyzIPSjDslH1FdM2q4qXcF6sViyhoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB11259

On 10/28/25 13:42, Maud Spierings wrote:
> On 10/28/25 13:15, Matti Vaittinen wrote:
>> Hi Maud,
>>
>> Thanks for the upstreaming work! :)
>>
>> On 22/10/2025 10:22, Maud Spierings via B4 Relay wrote:
>>> From: Maud Spierings <maudspierings@gocontroll.com>
>>>
>>> The Ka-Ro Electronics tx8m-1610 is a COM based on the imx8mm SOC. It has
>>> 1 GB of ram and 4 GB of eMMC storage on board.
>>>
>>> Add it to enable boards based on this module
>>>
>>> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
>>> ---
>>>   .../arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi | 439 ++++++++++ 
>>> + ++++++++++
>>>   1 file changed, 439 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi b/ 
>>> arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
>>> new file mode 100644
>>> index 0000000000000..46d3ad80942cc
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
>>> @@ -0,0 +1,439 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (C) 2021 Lothar Waßmann <LW@KARO-electronics.de>
>>> + * 2025 Maud Spierings <maudspierings@gocontroll.com>
>>> + */
>>> +
>>> +#include "imx8mm.dtsi"
>>> +
>>
>> // snip
>>
>>> +    pmic: pmic@4b {
>>> +        compatible = "rohm,bd71847";
>>> +        reg = <0x4b>;
>>> +        interrupt-parent = <&gpio1>;
>>> +        interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>>> +        pinctrl-0 = <&pinctrl_pmic>;
>>> +        pinctrl-names = "default";
>>> +        rohm,reset-snvs-powered;
>>> +
>>> +        regulators {
>>> +            reg_vdd_soc: BUCK1 {
>>> +                regulator-always-on;
>>> +                regulator-boot-on;
>>> +                regulator-max-microvolt = <900000>;
>>> +                regulator-min-microvolt = <780000>;
>>> +                regulator-name = "buck1";
>>> +                regulator-ramp-delay = <1250>;
>>> +            };
>>> +
>>> +            reg_vdd_arm: BUCK2 {
>>> +                regulator-always-on;
>>> +                regulator-boot-on;
>>> +                regulator-max-microvolt = <950000>;
>>> +                regulator-min-microvolt = <805000>;
>>> +                regulator-name = "buck2";
>>> +                regulator-ramp-delay = <1250>;
>>> +                rohm,dvs-run-voltage = <950000>;
>>> +                rohm,dvs-idle-voltage = <810000>;
>>> +            };
>>> +
>>> +            reg_vdd_dram: BUCK3 {
>>> +                regulator-always-on;
>>> +                regulator-boot-on;
>>> +                regulator-max-microvolt = <900000>;
>>> +                regulator-min-microvolt = <805000>;
>>> +                regulator-name = "buck3";
>>> +            };
>>> +
>>> +            reg_vdd_3v3: BUCK4 {
>>> +                regulator-always-on;
>>> +                regulator-boot-on;
>>> +                regulator-max-microvolt = <3300000>;
>>> +                regulator-min-microvolt = <3300000>;
>>> +                regulator-name = "buck4";
>>> +            };
>>> +
>>> +            reg_vdd_1v8: BUCK5 {
>>> +                regulator-always-on;
>>> +                regulator-boot-on;
>>> +                regulator-max-microvolt = <1950000>;
>>> +                regulator-min-microvolt = <1700000>;
>>> +                regulator-name = "buck5";
>>> +            };
>>> +
>>> +            BUCK6 {
>>> +                regulator-always-on;
>>> +                regulator-boot-on;
>>> +                /*
>>> +                 * The default output voltage is 1.1V, bumped
>>> +                 * to 1.35V in HW by a 499R/2.2K voltage divider in the
>>> +                 * feedback path.
>>> +                 */
>>
>> Could/Should this be described using the:
>> 'rohm,feedback-pull-up-r1-ohms' and
>> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment 
>> correctly, that might allow the driver to be able to use correctly 
>> scaled voltages.
>>
>> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/ 
>> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
>>
> 
> Ah I didn't know those existed, should've checked the bindings in more 
> detail, thanks for the hint!
> 
> I will have to investigate this carefully, since I don't have access to 
> the actual design of the COM, so I don't know exactly what is there.
> 

So I am not yet entirely sure if this works out, I used the calculation 
in the driver:

/*
  * Setups where regulator (especially the buck8) output voltage is scaled
  * by adding external connection where some other regulator output is 
connected
  * to feedback-pin (over suitable resistors) is getting popular amongst 
users
  * of BD71837. (This allows for example scaling down the buck8 voltages 
to suit
  * lover GPU voltages for projects where buck8 is (ab)used to supply power
  * for GPU. Additionally some setups do allow DVS for buck8 but as this do
  * produce voltage spikes the HW must be evaluated to be able to 
survive this
  * - hence I keep the DVS disabled for non DVS bucks by default. I 
don't want
  * to help you burn your proto board)
  *
  * So we allow describing this external connection from DT and scale the
  * voltages accordingly. This is what the connection should look like:
  *
  * |------------|
  * |	buck 8  |-------+----->Vout
  * |		|	|
  * |------------|	|
  *	| FB pin	|
  *	|		|
  *	+-------+--R2---+
  *		|
  *		R1
  *		|
  *	V FB-pull-up
  *
  *	Here the buck output is sifted according to formula:
  *
  * Vout_o = Vo - (Vpu - Vo)*R2/R1
  * Linear_step = step_orig*(R1+R2)/R1
  *
  * where:
  * Vout_o is adjusted voltage output at vsel reg value 0
  * Vo is original voltage output at vsel reg value 0
  * Vpu is the pull-up voltage V FB-pull-up in the picture
  * R1 and R2 are resistor values.
  *
  * As a real world example for buck8 and a specific GPU:
  * VLDO = 1.6V (used as FB-pull-up)
  * R1 = 1000ohms
  * R2 = 150ohms
  * VSEL 0x0 => 0.8V – (VLDO – 0.8) * R2 / R1 = 0.68V
  * Linear Step = 10mV * (R1 + R2) / R1 = 11.5mV
  */

Because I do not know the pull up voltage, and I am not sure if it is a 
pull up.

So:
Vout_o = 1.35V
Vo = 1.1V
Vpu = unknown
R2 = 499 Ohm
R1 = 2200 Ohm
Gives:
Vpu = ~0V

And:
Vout_o = 1.35V
Vo = 1.1V
Vpu = unknown
R2 = 2200 Ohm
R1 = 499 Ohm
Gives:
Vpu = ~1.04V

I am not quite sure which resistor is R1 and which is R2 but having 
there be a pull down to 0V seems the most logical answer?

I am adding Lothar from Ka-Ro to the CC maybe he can shed some light on 
this setup.

Kind regards,
Maud

