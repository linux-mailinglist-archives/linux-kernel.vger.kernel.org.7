Return-Path: <linux-kernel+bounces-772685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389CCB29615
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726753B36FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B5E22B8AB;
	Mon, 18 Aug 2025 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cife/z9v"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4B1F866A;
	Mon, 18 Aug 2025 01:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480359; cv=fail; b=EuRPI4lEoktfpVTDsDqGuDa44Nz0645z0AgBBp4UW50Me0IJWzwxsGlliwZ56u39qOrDHUIPjxanBTrv4ngPtPr3bx+o6oXIF4jvHqqdLHmOXbK/YFDa+XSlBoMk8leIGd0zcg/aT/BWuYYxASBhL3FC2WQjKzK0Cl2u8AszP0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480359; c=relaxed/simple;
	bh=JyGv+2W7Dj+X+LW4GAAxtefRSrBLDTqADN1/g25cH6A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BLJ92NcKgK8REW1NSfsM+2MeCVfBAvta1ElXx6OUSH+h5mYyEH5iGv6ZXy8Ek8+Vwwkmx4121cKwl5v+YhjOCKjtCbKthi7ec51VIKtcZcEbRfSxo3LFcDqt5tHBO400x8duj8BciQNooehC//InbAs5ZAPWHEiX2Wv3iM7jTDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cife/z9v; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ia1/GVcjRA6icShsekIovUwAPVsZbaZGj8Jna1zhI8CaifWFZfBjLIHHbYEJWl3UzvTOrmbISVFqsceG43Tle5oro7TUPTdYJuGBaJsSTtApcKkFQaN4zXeCUYR8bsc70EMbcQCdq9HSiOlesT02PrcvL7FvdCmVGRknXSgDgx6ipaDumRgPltiBV40+HRp4mt/dVZGEvCbMHlE3ddQJWATWKDX0cb8Q+FM9TMYJ1QfGf1QhCZ+QuUZUZhyNTD+0zRigaKjOX6+G8ec5G9JX69Hoc59K70PO+rY5r9EN+eSqTxhNClaotqmAZg9mEdaf9V/rPKrK744ZrqC+2VayrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4yRgnEbzU0WHFtc9AzCP+5iDeBNdClI3mt0JlZYvx0=;
 b=LQoUynrbOOu9QkYjE6u87lshFVHJ1Nc7TxoXJiyevbEQ8YngjGqVMNGZe1IM7YTWQxOo2DS8QyWwv422wpYsBAU+vqY7JRCQ6spqYXbx3p58bnOKQ2zv3EQIRpjXGKhyiJf9C00YrnrQ8WJPS0tX9+0o2DzCRVNNOyaYiPHAZJ0UtU/Q/+3KxOlhfEgkwTwIRxszXJLu1k+rV9Y5M703rF7CGaJ2MXfcyir5+QUaQ+e4Cr3nNIXEKOaFUKpwdIInV15TD4lIDoC4ZSOcbWO+YQgeuma1/6OK4DNjg0tBGLGmplCCyIWFCCalGTZRKRO9BeMpmHquWTRkXH9lq4XiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4yRgnEbzU0WHFtc9AzCP+5iDeBNdClI3mt0JlZYvx0=;
 b=cife/z9v1YwvNLGMQVGaJ6Wcj0JEeIkiy3wwOUi7dWOpcHylepdaZ1v8c/XxnnvhUYyhXfF1ZnG8kvVC353v3N6/7xFugOrcXzSyWw7WKODTVRKj5Cqnkl6/aRD8JaUGFE5O3dNFLT8P39uWY1HSPOqXb3pYys0IsnI2WLww3Jb5vCp4PFWwSci3T323qGwdMuq+QkoK3dG9woHH6tDH785m3DmKHDkxZF2IvbKLiQpNh/R8wxhon3YXpGu/b66MrKQMDe2BSHup158wBsziUQ2GWhdT/hqfFqjrej/eY63xWpvqixrrV0DFT9fp/NL6/LUM3qMDwr8G5tLNMNgPQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 01:25:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 01:25:53 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 18 Aug 2025 09:25:31 +0800
Subject: [PATCH v2 01/11] arm64: dts: imx95: Correct the lpuart7 and
 lpuart8 srcid
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx9-dts-v2-1-8ba787fb5280@nxp.com>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
In-Reply-To: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755480343; l=1422;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=sruah7xOxKOpi6PFHCpXj9nks7EgszT3vSdYic3NrUc=;
 b=DBv19UqHxnueLadWT8zAmw2c1JkvXgW/ygrZV2scWjQAqVqVPDgQCQqo41wdgHytpL7Fb4iyK
 59lgLbMBHO8D8efX+EDVfcuHiRgUrTU7CzyCMXyn1mvhadK3i2PQCw4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MAXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: c58c6870-b5d9-4399-802e-08ddddf62c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0hNb01KY3ZhVXhUSDV4d3lDN283Q2hzbk1nNFVPYklFWjduWnVnWVQ5Rm5j?=
 =?utf-8?B?TU9EdEFndkZ6L3hSeXBJZXAyMWZFd1ZtYUw5NWJpbnpjMXJ1S29RMHZQcFNz?=
 =?utf-8?B?WHYwSmhVbTg0b2hCeGRYLzVhL3dDR0VGY0c2cXJJUU9Kc2pHd3l6UTZ4dC8y?=
 =?utf-8?B?MjhPV0RybkYvZlZXWXd3d250eHpDTXBTSXRqbDNJVjBYTE9YaUFEdE1HTUJk?=
 =?utf-8?B?SlZNZEs3bVQwSEJYNEpWaVJhcFgzdHMraThncS9LQVVlOE1hbTNyQ253TjBS?=
 =?utf-8?B?dWFNcVUrM2V2K0FrWHJFb2VlaXgxQUxzd3lYYkd0OHpJU2pOdnZYNU1Ta3Bo?=
 =?utf-8?B?TlpXakJmZ1J3c0I5WFU1N0xsbitFaGFEKzBpdUNoMndnb3dyK1dKSmJXM3du?=
 =?utf-8?B?MUlEbmhNTGltQ0Mxc3gwN2VCc3ZNZlE1eDQyWU9CZ1k2RVE2cFVoaU1PY1Bq?=
 =?utf-8?B?MFgxelJQOE9HbjVsOHNGbzNybXJMcGc4TThjUUxXRzFoeGR1MXVwNFI1aWxT?=
 =?utf-8?B?RkJSRXE2dzhxamJ1N01qVHpmQ1JiVmp2UitHaEt3NXVISndkZEM4d2dxenZM?=
 =?utf-8?B?ZmRKSkVlOXczYWEzaW1iNXRWU0JFK1g1WWpuOXM0d29RMkhhL2xmSUxqWGZE?=
 =?utf-8?B?bG02QzBSVmdyWkliSVBlRjJrVXlzMnZhT2srVUtlYlZpd3dmcU9CVXRiT3pE?=
 =?utf-8?B?eWJ4bXZkODRLQWZVclBIYkR0MG03VHVSbnFvS3pRT055U1ZCbmF1aU1icWhK?=
 =?utf-8?B?OFdJSmFhalc2S3ZUK3d3MVp5aGtuWG9YeU41UnFiZFowczRRcThMdEg2Vy9w?=
 =?utf-8?B?ODJpeHYzQ2ZJVC92UmpCek80LzllRnpGbURURkVZYTVhWUtqQTNCcEFoL2ln?=
 =?utf-8?B?OEdwczl0U085OWRISjE0Z29INzFvUDNUN1RHZ2daUnk4ekxZZGE3aWVFcFc4?=
 =?utf-8?B?enJFTEVGemtCcUhTc0lQMTlMWlpnYUVWb1JLQjVhRDkwWXIvZkpnQWFjbmgy?=
 =?utf-8?B?U0s2aTFaazRUY2ZNU1gxOCtsbnY5S3Q1Z1Y2NUxqVzE4bGhBaFluNlBIMmZJ?=
 =?utf-8?B?SFhFQ1NZYTNGbTdFd3czem1CMGFDNzRZKzFOLzRUR0xkMWRPYmdLTXNHRlZI?=
 =?utf-8?B?RWR2TjRvQWpvTVA3SkliSlRia1ZyMGh5UEkxbHNURWU0VE8zWVJyQzRaeTJ5?=
 =?utf-8?B?SUIyeVFFbUF6dWlUVU9wcDN6R0xibklWSXVzSGg5TklIT0NmSy9OS1pMUURK?=
 =?utf-8?B?cUFVSFNweWxGc1NnREduay9mOFdTMXduYjBTOXcyZ0huaU5La244eWc4elF3?=
 =?utf-8?B?UGxZdzhhUDE4NlBBNVhSNmhmTTh6UldVOGdmekVoenIvdFliYk9IRmlwc1g0?=
 =?utf-8?B?K1k4Sk5LenkwaDRzTEoxUGl3M0xZelBRcXA4UWVTWllub1pLMm91UHo2dWxX?=
 =?utf-8?B?RmxjNmNVa2FBa2hkNGZDZSs5WEgvM0wrTTVzNmpEQUY2WVJ2VVliZWtWcXc0?=
 =?utf-8?B?V1hSYnNkb0NiU250Q1VTRVNGTkZwcWFxVkNaMzIrUy9Dc1haRk5yTEo4Q3Rz?=
 =?utf-8?B?bWJqckdzb053M2FiQUpaSkRuRk1Kdlh4RzhRVkhBT0d2MmlLeXFhUWdRdi9Q?=
 =?utf-8?B?bk1DS25TR09YVUg1N0JoOTJNNFRUUm5Dc1lVU2d4b2E4UDJCYVhsblB6RGlm?=
 =?utf-8?B?YWJrYytiTDlkMHpLRVF6RktGWS90djNDYkRvU1J2ZmpKcDNOMGs3LzRwMlBp?=
 =?utf-8?B?bTNIb2U5Yll0a2VRcFF3TWZvVXIrWVh0RVZNbmg1M0pkL3RmR05QaXZ2QkVa?=
 =?utf-8?B?SVZMNWdDcE1sRGhtMWFkZG5RK0FUcVJxSDRGdXFodThwaXlvczNVa1IzaG1k?=
 =?utf-8?B?dDEvbHlGbjJpanlxWFdIQTBRcDF2ek9LeXdkcnJvSi9Ca2ZDSUxaSGhXTFpN?=
 =?utf-8?B?bDFvdnYyUXNwUVlaSWFqU2FJWTVQTitWci8rY3hBcm1PTG55VExqekNuRTBn?=
 =?utf-8?B?Zmc1SURWY3pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1pUYUlFaGNtSDBkMCtsKzZPd0ZzTEVIRlJuSFV2czN0NlNBV1JyaWk4R2Rz?=
 =?utf-8?B?bEZGazN6OVh3bWxjTGU4MW53VmFtUFdKSXhNRVZGMUlUYXNpSmtFVGNkMUsz?=
 =?utf-8?B?U2xqNUZVS2xaQWh2RzVnQXdvTnFTVHZCMDlpY0pCd2pDTjFFU1JESTEvS2h5?=
 =?utf-8?B?djY4eWdBS2dHbjdLL0haTlllQy9iMVJYM2tYZkg2eUdkcDRMWXZnaW1HSmcw?=
 =?utf-8?B?ODBPNWw2WlNEa0VQUkxOczhyVDI2RVJCakh4eEhKQzlOQ3I2enlMaWhubGg4?=
 =?utf-8?B?eDdlRUdkTTkrM3JqUElKV256ejFjRFBZNWRWQmtTZW5ObVBFM1lwNXFUWDRy?=
 =?utf-8?B?dDc1SjMyVjE5OXkrUXlLUU9BN2ZENzVCMU9pb0xwUVhUKzhEZEIzeHZXTGxy?=
 =?utf-8?B?QlB4WW8vY2lGYzRtNjI3Qnl3dnQ1THVVd1h1dWpucTZpeHdoRkluVkgrdVNV?=
 =?utf-8?B?a2dGcHRPOFZWVkhEVnZBRFI0WWlwZzloSE9wMDMzaGpKK0RTekVGS2JOeHdL?=
 =?utf-8?B?OFhIa0ZBcmNyYWFaVUVaWkNSSTlWWDF5aDVwLys3T1BtZUpsdWJmY3BsNkVL?=
 =?utf-8?B?empoVmJ4ZGYxdGF0UXBSaWRCb1ZncmdGMFFobDQ3WHBNUnlYOTBpZnVhczJQ?=
 =?utf-8?B?bUc4YkJsem9Ya24rQUZGZDBxRWRxNjQ5SldMdjdiU0U0TldDa21VTlB2VVpt?=
 =?utf-8?B?L0hHZDNDRUJNK3llRUI0b3dCWXpyclpjYm9LeCtUUWwwcFl4MVRkTUw0VEFF?=
 =?utf-8?B?d00yN2U1RFl4bUo0U3ZwY2pxZWg5a1hMYmN5T2VWeE5BVDREK3I4VGk4Kzlt?=
 =?utf-8?B?ZjlFVWtLR1ZYRExIRFNYblpxdFduZnk4aXZDalo1ZnpOTks1djFISGpYOHlF?=
 =?utf-8?B?R0NKUkZ2d2Q4YXZiSW1JNXA4L0Zjd0wrS2NrWS93R2xCYjl6ZXhJdkdLMHhQ?=
 =?utf-8?B?RFhQSGlUdGYzOFAvZ204NnZ0bDI2bzVvcDVWTUJOakpUaVFGL0VxUmJ3Q2hT?=
 =?utf-8?B?Y3hjNjcxaWtVSzZZdVJYakxCMWFmeTNMd25UeU1sSDJ5dWtFZktHV05jL3RC?=
 =?utf-8?B?T0plTDhxQk5PdHE1Sks3LzIyVnNtbnhkR1N4NCtOcFBFZTl0WmpucWpQYjBr?=
 =?utf-8?B?Wkk2M3A0OWVza0t2d0lKOHdVOG02RmhGNkpEMWtpN1NKL1ZxQ1lyVlArTzhk?=
 =?utf-8?B?UWJNOGxveUF5bXFJeGJ3UFcwY09FMk40Q2twZXkxL2tqS1lYbHd0ZWlrSS85?=
 =?utf-8?B?NkJrdTJXTU0rS2swS25VSUVYUXA4V3dKbDdTeUJtd29wUm9WdmVDVnhhS0px?=
 =?utf-8?B?dkZxYkZkSTF3NURuQlQ4WGJBeGV5RmlqOGp0ank5aUtWR3ZROW4yaFZIVVNM?=
 =?utf-8?B?NWVZc1Fob0RxdVN1a05HTlpMMThGVzRINjJYUDVha3hHVVBkM1ZiRUo5Rm9q?=
 =?utf-8?B?cjF1UUtqd0cyaVFlTXl0Y05Za1ZiM0FYYzJHeVRRRE5FNDlDWnNDbGtYWEVn?=
 =?utf-8?B?Y09HTlBiVHNFb21zWng0Tlp4VWJzcnMzeUdpQ1l2UUc0dWsvNFkwWkdqMjBy?=
 =?utf-8?B?TjJIYnhrNTczaXBaTUpjbzNjS2luSnQ0NzMrbFVnTTRBMjBGanhJNytHeDAy?=
 =?utf-8?B?ajM3N2gvY2VRdWJ4dzdXK0czMUVXVHdja1E2Wjh0RDd1bVVxcHQvM1JXbnBV?=
 =?utf-8?B?UWNsMzFlVVN5MXl2V2Vtd2FmMzR5eEJlck45aFB4czFneUZCYWsrcVVMdlBh?=
 =?utf-8?B?TUFBVzhJZmRsc2JGSU54cERjSC9BZXdoYlAwb2RLTi82ZFZEdWFQeGVIc2NY?=
 =?utf-8?B?U0llQStxaSs2YmcreDc4dnNDOTVieDVnRHpmWUhielBlOHdjbWdMaC9pUjc1?=
 =?utf-8?B?N093dXZLSnE2WXNWVGNUcmtCbjJwS2Z2MGlxK21YV2U1N2pKSjhEYVd3NHFw?=
 =?utf-8?B?V1RGUFM1dXBZUWdQaThib2QrS3hlMGxRTDlvZWVkQWlSRk00ZFRCeG5TL2Z2?=
 =?utf-8?B?ZFcyUEdxWGxOaEFSWTdVLzRDUXJsSUx5Q2E2N1dqbVF5QVpBQXNtdGE2aUd0?=
 =?utf-8?B?TVhTUGFER3hNTGpqK2F2OVhsV3EvNkJRUUpaK3Zkd1hqcHNiUlBjMnZUdjc1?=
 =?utf-8?Q?h3pfZW8oyWLXo9yN1wc/TpG+V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58c6870-b5d9-4399-802e-08ddddf62c52
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:25:53.3001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlzdPgBA00sMCnry+Be5rzlFH8Bd2T2yLb1Wg9kq7q4hk2eNd7SCRY+JqG1skMv2lJleGilL9oZE2pHcBd4xVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388

From: Joy Zou <joy.zou@nxp.com>

According to the imx95 RM, the lpuart7 rx and tx DMA's srcid are 88 and 87,
and the lpuart8 rx and tx DMA's srcid are 90 and 89. So correct them.

Fixes: 915fd2e127e8 ("arm64: dts: imx95: add edma[1..3] nodes")
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 4ca6a7ea586eaa5fbbaa56be8b821f7c929b7dc4..dbcc557d07f5b8a0ef27d68b7211b07d26fdb9bc 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -913,7 +913,7 @@ lpuart7: serial@42690000 {
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART7>;
 				clock-names = "ipg";
-				dmas = <&edma2 26 0 FSL_EDMA_RX>, <&edma2 25 0 0>;
+				dmas = <&edma2 88 0 FSL_EDMA_RX>, <&edma2 87 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -925,7 +925,7 @@ lpuart8: serial@426a0000 {
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART8>;
 				clock-names = "ipg";
-				dmas = <&edma2 28 0 FSL_EDMA_RX>, <&edma2 27 0 0>;
+				dmas = <&edma2 90 0 FSL_EDMA_RX>, <&edma2 89 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};

-- 
2.37.1


