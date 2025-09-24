Return-Path: <linux-kernel+bounces-830304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7906B995C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0EA32221D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A770D2DCF7C;
	Wed, 24 Sep 2025 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="szwD3iJ9"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1DD235BE2;
	Wed, 24 Sep 2025 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708436; cv=fail; b=BMBuzekiJodLcebm8WMhtM3vxyoioNmcEs3F+4dpqFRafDjH6TZXv7+of6yZdO8eo7dslk/Z+663ys32jfsnJnTVeHw8QQ11IJM3ca19Wml3uXzo1VgNuUBrSCCPHKOm2Ux4410H4mU6AP4pn/hCSRK4DP2Mr71OThhvY5sEJRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708436; c=relaxed/simple;
	bh=jE7rjfSYnbWjNct8VCf6B9EOO66UnIo9NxsceOa5zZ8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LcaWxd5/SnxzXQiD8a95SFt0BIJhOMiBQkhWUImxoFJn7pTgcjICUoBgKQApQo+8ThgKpfcQS8jDqtkiOBJiiSbJCfUV65AC0i8zdrKUJAUIRX4+d8hYcJAOKitLsX+EtLv//JL9vvYfE5ATK7BXKqq2KfjlPvt99IQmC7j2IrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=szwD3iJ9; arc=fail smtp.client-ip=52.101.84.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZVwRsWIKyjML95j70SCdjiJ728pA9FncDdluuaD10AGdU5+Lv1aFhfzcBDhsUONIr6gP+1Zv5yysHqMfVWO4JGL83weoW2fP6VckU+i4XjIvDTmLMKn2eMJdMw/gXuFX75Wcx/+DpJTLlEHi9xc7q4wcXjynyWmRn/hF6/E79lR9Yct9RCkZAe/hpvzZvtlnXTVYnmuc6hPx8ZObrbEr+I/3Kt8e+NjebyKr7KTO5XT62cAQcvQvkn7hib/6YZ9L9X1Uryuys8w9dxHVVV4KIjXQ4IRRul9X9ZT+1wNPGIfsXVb8h7sTaQTEr3NN0HPt1tcgJbSndWfexiG8/AdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixb0C3Sp0HxtgLcFurVrGVe+hdOrrcIleoawD2oA71c=;
 b=HkjSUs/V1fN3714CHeCBv9p8dDiCF9lyCUeoEZ5vIZzPJHd8MBo9giWa7zZD3jcphT0w6Bdsn5HpT3qCkU+oCUQ3YykYSX42ALfk78xP+8KxAbNzgSx9eIUO0z8NLQG6QsK+y5q4g0shiNsdxO2KpF1wk2D8tsLuiaI6a7vnRRHYHVwuc5jkSwgpd630ryrXAbZ5t0By6TC24p4Z9DCe0Ntevy06L+eanuTvjLENDjHoBIeBK5Og0MYp3teYo865xYTpYPSFbZT+VZxU19Sv8d386Wx02TxXNP/m/FECK3ncTGzff6ALB4BuwlygC5gmH9w4L0ZTCC6ZG1zP/IvvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixb0C3Sp0HxtgLcFurVrGVe+hdOrrcIleoawD2oA71c=;
 b=szwD3iJ96IGrWeIBSY+uCn1DyMgMco4STRw8dfzfrNArp2a5FmKvr0xFRgxLL0nBeQoBZHlRwChgtNTOESY0Bd2jcZLdmg8rDcXLNAuMLh//XVnSQma83vJAb8cbVLTned/OxQakUAyjW10c9ngmdkSHjlM+p+0XmBvTJkjIrIXw0akU9Gq0LGLUKi+I9t18gh1CwV9sZ9fJzewWHVy4gmxSvA5BdGw65OgcQF5sI/H8CYkxLPhErY3yzLJOayEo8I8G90uWT+LVp0YNNzpT27xvsMj8WQkjQBfrf6ZTk8IADI4CE0+QxWJfRZvgvJwHlHbUHnwf0wRxsHNUKmLflw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DUZPR04MB9745.eurprd04.prod.outlook.com (2603:10a6:10:4e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Wed, 24 Sep
 2025 10:07:01 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 10:07:01 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 24 Sep 2025 18:06:25 +0800
Subject: [PATCH v1 3/3] arm64: dts: imx94: Add OCOTP node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-imx943-v1-3-0d32d7852ecb@oss.nxp.com>
References: <20250924-imx943-v1-0-0d32d7852ecb@oss.nxp.com>
In-Reply-To: <20250924-imx943-v1-0-0d32d7852ecb@oss.nxp.com>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DUZPR04MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a77f74-08ea-4fc9-3a7f-08ddfb521b10
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHVsZ0xTeHRhNTRuWnlyRmVoUHFHbnVnVm5sa1lkbm91RFppbTlkamhTRGp0?=
 =?utf-8?B?UTN1M2lpQ0Z2QjJsRUNCMXNMZzFlL3R2M1dYOW96TXVrNG81cXR1MDZEZnR5?=
 =?utf-8?B?NXQzM3lHN1hNTEhybWFWUlV3UzRPUTRheXVERjhSSWdlM2RtTUpuMjUwNkRN?=
 =?utf-8?B?YTJQS3h2cFErVU0wamZqL2RsS1A4dEFkelJpTmNrcjRXOUFzaEpxdGFiaVJK?=
 =?utf-8?B?QlltODVJRStlNnJ6c2RBdDRpdjJreG8zQmJpUUtwdm85S3J4UTk3TFE4VGxB?=
 =?utf-8?B?Ym5mU0VvL2xCOGpPcTlGTEE3L3E5WlpOcnVEem5ZM2MzbDQ3NGFCdkJYY0JV?=
 =?utf-8?B?SzNGRkpqZDVVQmp3WkZOUnlrbUlrRXJjL0tielUvSjk3UmwrbXRmZU04SStO?=
 =?utf-8?B?dFRTK1ZJWldHWjJEVlZhc2xzMlR3UXpscW5ZdzNVSEh0RC9JNSsrUTU0UCs2?=
 =?utf-8?B?QThWSEhRNVdQOUFjNjBnbXBHOFV5V2Jlci9jaDVPdTFEczQ5aTVhOHBwR0FJ?=
 =?utf-8?B?VHFUbXFHNHRCQWZzQXVtb2tPeVJpWjNaaFgzMGNBMGV4eXVCcldIMm9zQm1R?=
 =?utf-8?B?UFREVXFPR2hBTmh4WjNaR2lCUHNRMldTNXlQY1F2Q3J4Qks1eVN6VE1wSVhz?=
 =?utf-8?B?WDV0OGg1YmI5dWE1ZVBvaFIrVUZRUkhkbjZ6c1M4d055dkhtOUljQTBtQ1hJ?=
 =?utf-8?B?eWZCZE4wK0ZoSnp3dkUwZmZ2VkRTcmtUeXdSd0hvZkVBS3FCS2tKQWcxQk14?=
 =?utf-8?B?cUUrOTA2ZHdrQytNSEdpOW9Lc1VtdENRTUxJVmhUWE5tczhMeUVRZWU4aktV?=
 =?utf-8?B?Y0U1SUZrRFIrOUVKclRuWnYrbzdrQ3lXWnR5cXpHM05rN3VMOHVibG1IZnFT?=
 =?utf-8?B?VUkweGdtTnJ0WTMvSWdoUDl5SlkvV2VRTEMwYmxWWnZwTklIRXNyYU1KNUhz?=
 =?utf-8?B?eFp1VkRjNGcxYThIOVBTTDNwSVhpZG1lRUFNY0JrTUFZeHRZcXlmUlcrMm5D?=
 =?utf-8?B?L1p3RnhxZ3Q1RkNVemFHaytTcVBPVktjYklseWNTSU0yQ1NsclBMRGxWdHZr?=
 =?utf-8?B?NXhmY2QwdHFZZWF6SXdSemFhVTVBYVgxU0xWSWtkSS9VZHcwWmdGVytMVjF5?=
 =?utf-8?B?dlZUMXUrd3NhQU05bDB1clNJUnF3ZGRSRnNDd0NqWGVpTDVqTkxKZTdXeVND?=
 =?utf-8?B?cHlEVWJQMWR6OEgyL09MR2dIQkdVVzh5a0tkT0piSVhzMzV1cHowWFp3WHo2?=
 =?utf-8?B?MUErM3poRVB4SE9FcHRJc1hKUWMwcGwzK0tsWnRvRVEyQytMNW93MEJtdmxa?=
 =?utf-8?B?ZjhZQVZZcEIrRmh1cExQN212bm9xY29yaDNta0d1QjBQdEZkaEFUZVhuU1RD?=
 =?utf-8?B?bkw0R2d2SzZHNUg5dVFYM2hsbm5TcDd3T0tBMUhFZ0t2UWE4NUh5SVVhc004?=
 =?utf-8?B?cmQrczBNKzJzM1JjM2NSSTVhdkRLNXFqL1haRVNKVU9zNGpLcTBXaCtRQXZX?=
 =?utf-8?B?cVFCNDZFdlIyTDRlWmxBTUNvOEhoTUR4WGVrdzFCYkZFRnR4Y3V1WmhWT2N1?=
 =?utf-8?B?eTEzM2U3NDg3Z001QW9qOVJkQmtId3VEdFNKa0xNSnc1UHROK2trdTQvejIz?=
 =?utf-8?B?VGtFUHRIUUV2NlRXNmdRNnJ5M0poSzFqUVkwektLVVRFaW5mVVpxcnlzYkRJ?=
 =?utf-8?B?V3dVRVdRQlMzNVFURFRwZnN3Zit0WnBVbkQ2NUlOSXlteGxGYXFGNDMzRkIx?=
 =?utf-8?B?cnhIcFAyWWxrZ1FmZ3lHTzZYT1M3SzkyVTRXUWlHSVdyclJzeCs5WndFckc2?=
 =?utf-8?B?U1F5azRld2dWdlh6K3YxNFg5eHFHSDhyVGxSVFlRUmMvNENJYStYdDM4ckZt?=
 =?utf-8?B?S05ud0FtL1lVcXpIdW5jamQ2ZEEwN2I3b0dDSkdzWWZMUjNXUTAxa2ZmaWIy?=
 =?utf-8?B?OTJ3dkRxRXlhMElSL0ZnSEtkL0w0RnJEZ0g5R1VWOEJaeS9WcGE3SVJNMmFR?=
 =?utf-8?B?R0RzT0c4VElnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUxJeDdaeVZyMHFiSE9xR0lHZTA0MENXbmsweW1abWtRcW5qOVozYm1XbDF6?=
 =?utf-8?B?alBRZEJteWlMdkg4NWpiUm0rWDZtZDloVUlzWW1wZGxHTk9Xbk16dVhSd1hm?=
 =?utf-8?B?bnJ3RlpVVmllRWhYUVhYbUlybDdTR05mUStJa1I5aFVlWDB4V3k1Ny9KY0xF?=
 =?utf-8?B?b2t3RTREZjJLVFM3V3NPajVHTm9RYnlIMWV4TTRGWlZNTTNwdlp4dGxoMjI5?=
 =?utf-8?B?aGxhRDRFOVRibGt3TmF0eVpFZG5veHAveHQydWthazB3WVFGM0kvUExMQlBp?=
 =?utf-8?B?SGZhWEdwdEJ5bHhOdlp0cDNoUlFQWFRQNitnQWxUNXA4MFdseFBCM3pORHEy?=
 =?utf-8?B?Y0haRUI3clRYM1BBVGVYcUxoR0RNRXNISktZTS9ieEJRY05IaUdYcmdMNlpT?=
 =?utf-8?B?TnB4ajZDVEtSTDk5YU1zZy8zUUpvWDY5M1craytKbEZrY1pWRy9hUzlFa21m?=
 =?utf-8?B?T1piVXhMM2NLaGxOUFJab0JtRVBGa21kQ1FETEt3S3I2K2lGT2RoV05zOFAx?=
 =?utf-8?B?b05kU3JNTFBtRkx3dHp5ajJVTE9zY0dGUWlnREIvMUxidzA4bnBZRlZPS3FE?=
 =?utf-8?B?c0hFejNDUnM0bjMyWnVIdTUzOHJYWXVRbU91M3FsNiszaU1mc0w3VjlRSUlv?=
 =?utf-8?B?VnFSQy9zQTJVYUxnaDh2Tk1FRXlUYlJsdUFVaHdtakJGak82Q1RMak1pRzRj?=
 =?utf-8?B?bjhvSVJRaFROSzVBYUFiZzFRTHZZYXNwdm1wTTB1dEVuY3R1TVZoemNGcEcx?=
 =?utf-8?B?eTkzSVRvRHQ2bzQySWlHTlF4TExHUE03aVRFOFg1ak1oK2lOd3Q2eW5XcjVn?=
 =?utf-8?B?OEtESVRZL2xvQTRsdzVES0RtaW9OT1MvQmhJMHBPOGF1UFRzNWM4OTVEQjNo?=
 =?utf-8?B?cnE0dHVKaWhwdlFWbmw3TWhCYWFjQXB4akVHLzRzNGdmNEoydnpWSG5qTjBL?=
 =?utf-8?B?VkhPbGxjUk0zVTgxcUE2THJsdmhNVHRPTkJ2eXVPNm9WY2oyMC9DU1RqeXhn?=
 =?utf-8?B?Zzc4cHMzOHBvdFREWXVwMDFjSTQyR280bmVZbHNoTkJxRXJhYWFTb2RxckpB?=
 =?utf-8?B?QTF3dHhLeUhnT2NzS2h5MWt4RUVQbEhhZ1JWMElvN3d0bEdKempUTjZRZ3Ay?=
 =?utf-8?B?OU9vbGtiU21BdVFzOXYvTEJLa09LeHpibnM0ckF6ZW80WlRNbmd4b2FpVEtp?=
 =?utf-8?B?eWxwVERzTXg3dXJCbGw0R2RUZWU2eG93ejVkL3JBa3ZPMjY4YWJqWi9TZkd5?=
 =?utf-8?B?VEJXK0RGTkRsUXpLMFpHTDJrZDcyMk04cTkzc2F6bFpMNjNySnNaOUhsS1Nv?=
 =?utf-8?B?UWdwSThQclQ0MXJtRFRoVXY3K1R1WHVVcXR4eGc1a2VYcnd1UmlWZEVtdFVO?=
 =?utf-8?B?WW5LYkRVSlFaZ29SKzhCYXZGNm02NXNWTCsrMUltUWF3UWlibnJJb1pGNkRy?=
 =?utf-8?B?bzdBbmxNaExBcE5UYXRQd2EzUmVyQlU5OWpoVXJMNnAybjkrMXVuTERsclN6?=
 =?utf-8?B?YTlOamZ3OWN6ZXFYcW1oUVdYc3Z5MUgvZWlnSUY4MjYxdUEwZ2k0K0dDWkI0?=
 =?utf-8?B?cllObzV3dkJYNDZaR2phOURIenFOdWNCRjNNSEpOWkN0ajZZUUo0ZnNXcDlC?=
 =?utf-8?B?eUNjSDFaNlk4Y3BmM1BnVkcwRUpidUFaYUp1R1MxMXlLNlYrOXM1TEZkUWZ2?=
 =?utf-8?B?L21KZnBHd0ZEckRVaVBRSnEwTEVwZzZzWjZjbWR5Wm4yRFdwSFgxQnpwb0t3?=
 =?utf-8?B?N2djdFNYK2pvbkNhN1BxQ1poOGxDdmpWNXZBVktjNTZ5VUM5T2owWDNZR0VZ?=
 =?utf-8?B?TjlUbkZBWUhzc1FIVEE3K1hYclg5elBQTDFsM0t0ZU9pVlVmT0hyamFxdkYw?=
 =?utf-8?B?eEdBQXFhOSt2MUU5QnVzbWpYcWNvOFJDbkdvb1RHWGZZZ0piRmZTakN5R0Rq?=
 =?utf-8?B?SjRBZ0RVNDFWWlkrcHNGWDZWZko5RURrYmsvb05adVVVc0l0eHZYSGtFMTlE?=
 =?utf-8?B?ZzM5ZWhWT3pRZmpSeFlYRjg2N2w1TW81b2JObmFsNE1XaW1GR0tKdmNrKzhx?=
 =?utf-8?B?TGVrUVArVlNZeStFR2duSGI3ZkZJK25lTFJXcmJOSXE2Rm9NNEIzSWxFbDA5?=
 =?utf-8?Q?rzLhUCXYW1AVNyDOOCehuhrQ3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a77f74-08ea-4fc9-3a7f-08ddfb521b10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:07:01.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdtCtOJwbFx+SJVcij5L3QsFeO8c/5TsBLrwFlEUSXyVlu4NXrR1YI7PDeFaAwBoeC+Up3WvxUIAZFe0BQ51fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9745

From: Alice Guo <alice.guo@nxp.com>

Add the OCOTP controller node to the i.MX94 device tree. This enables
support for accessing eFuse regions on i.MX94 SoCs via the imx-ocotp
driver.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index 44dee2cbd42d..1f1148405193 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -1171,6 +1171,13 @@ a55_irqsteer: interrupt-controller@446a0000 {
 			};
 		};
 
+		ocotp: efuse@47510000 {
+			compatible = "fsl,imx94-ocotp";
+			reg = <0x0 0x47510000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		aips4: bus@49000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x0 0x49000000 0x0 0x800000>;

-- 
2.43.0


