Return-Path: <linux-kernel+bounces-799371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7674B42AB2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955547B05F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D74136C06A;
	Wed,  3 Sep 2025 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AxWOJrAW"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8230ACFE;
	Wed,  3 Sep 2025 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930821; cv=fail; b=pq2A0sW49NsqXGyV2FdU6A7MvQTalhoK/bRwhWL9b8CMBn8JWxgwDZzTocwPgJ9jVC1xDZTN1btalQIhMVRn00jUc4+BjZ+3R/53gy5hGMzbeLHP7CgYagnQkLRNLzGb7W8XJOj7aDBfLr4ce+X/5eF1b/BI9TmcVbGAjBNJC80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930821; c=relaxed/simple;
	bh=QQJKb9R9Qw4NBfRO7ZX2iMWoEr5cXAQ07ID7LUttLd8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TvbJm8w2vrsHegcVN/5wvApSuA69AId6/oJlBczEDERUw8utggkTdkgLqYIGv1jZVyOB/lilFWbb49kNL1KoBxNT4AH4KVtilMLOlH6Oo5b8+VXMytu5scOH+msSBBCPrK2QuLvxyk0pY6+eXC1pq5pW6ttupCuSnlo3Slj92YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AxWOJrAW; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcSvrSP/hv4rwWnaFlXSSkd5mOtA/10y7qTzAs7E3DY4QJw//F1AmF77EW42T5wdJGEHoye6H1A7lxWkspObCpKId1kf2UdCxzD73o7WvLTrlMUQp4UpwKIJFAREe7nWxolhjGgFRcA5pTxhTwd3mIOeEavZFhzm9CZcdgsfWy2UNlWicJqpSBb3BNdPijl6czCBjA6tCTf7kkGRUq4QazpuJ6Z1CuLxHrpcbK2rWTHCBbsMlGblxIkll13NzEFqo1xqI2OXmCN6M0VzpStgGqQYNzXVURSBoB1yqxAbuynjOarRoj4c+ZdV5qLBaZSMAFisR/crb4qMMm+mWjxYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtIN3cJnO/MHuapM5wSVfRxh5/6M/qbYYuGxZdV6eiA=;
 b=rFnO+yF/ww5vPFNR/H7dOUjLGHmtIHWLyqXcky3DE5cE9QaPPcsxfJVatJlmmHTFNXv+O+FUZ4XbV0rkZ5sIDzk0Y6b9oC9yygwfdsbO9QyOFsnDIkd8CNdkTTLS9olEdMlrs7gEB1W6TfcUUKQixyEWIlsUW0TRv2ToM0AgEfGRdYhJBOxye4/aDHRWQpxoM85P6VpAaDsFyYXvs5vdWJIGlqL5ChujidzczZS+DqsUBmKL7oepWGLXyjwabNh/gt1Kq+5frm8bIWSNGitFMEc+9EyecbNCyLuIIXOGB54lBYXB1nYuP1qbmPfiwtbhW/SUaXa/nFtw3Lt8K1s7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtIN3cJnO/MHuapM5wSVfRxh5/6M/qbYYuGxZdV6eiA=;
 b=AxWOJrAWZXre87PzezvcAEbkxtN0GSDYaPthy3nHzon2MA6a3MpOgx12oghtFK7UzNoKmYjUsY5ZFtXgmRLMolH67QNbdKN9Mseyruu1q0KwjclaBZhYQ5cnoEN0n5SR/W6LqwxfcIW4IBNoD7CmujUSO86dN554VoeuvAdnsmkqlPtluT1gvjDNgMY3wLxho4JcE0eo21SeeJ+pH+q8VWiwIHLm6deWQYlrAYqGRiAoDWUkXzvXKG9J/5idUsMBxO00lsl/15QUxxXFHsbga8LjmQZgliOaToOb5j7qonP8DZeKYC4qroUxZFbmFUJ0hM55jLxGv+aaPUkCI6Z8tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:14 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:19:55 -0400
Subject: [PATCH 02/16] ARM: dts: imx6: add key- prefix for gpio-keys
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-2-1e883d72e790@nxp.com>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=32465;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=QQJKb9R9Qw4NBfRO7ZX2iMWoEr5cXAQ07ID7LUttLd8=;
 b=nheKWjQbvzNcPXedGKx9o9U3IHp7y8lbMkGXZCesT8eLk3TMJSaKF/ew8v7ES5gq+dPynVlMU
 uCdSfVysR93DEwmyezAhnTPBIqWvpD9qCy7b1Ma6xbRGPdcplV1MiOw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: b07b8020-6488-4360-1319-08ddeb274aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnhtU3hwVnEzRlhUSXZXa0R4V3JrUC9HRDhEV1RNemJQcE1wN1NRSDZBYkFw?=
 =?utf-8?B?YzdRNmVxVVBYZ05mNHBnTGx5VGUxRmIvdWM0eEpLWlhnY0FpU3VvRk5YUjZN?=
 =?utf-8?B?U0h2WWt0eENBcFJIcUNoM24yL1JlbDcyalViVjJ6Z0lrS1dTcGJ1OE00UlRi?=
 =?utf-8?B?cC9QbCtCNHNub1BGRElHeVY2ZkZ4UGVUTjd6c1o5UG4raC9aZ2drRVR0S2VK?=
 =?utf-8?B?WWpIbU4vTXcxOGlZSEdHejJpaWxhOEdsOG9lb3ZhL0JXYW1JR21TWEhtT2M1?=
 =?utf-8?B?bWM0MUc0djZ4VnZsbzR2NnJ3OEMrb1NudVE2WlBQZEVPSkwxcUg4V3dCOXB3?=
 =?utf-8?B?MEF5dmRVZHZ5REwyWEMveGxxZzlzZ0p0ZUd3NG5OQVNScE9JdFBUbjFIMGMv?=
 =?utf-8?B?azJPUWNHR2lpTjg0dktZK1JhRFEvc3dBU3ZSdmZqMVRUUDZyUGFtMjdhTUJR?=
 =?utf-8?B?UDFydElKdEdhRER1Q294dDRuSVdoT2VvaGdhaThUZkhLTHo2aEQ1VnhqRzZx?=
 =?utf-8?B?MWNDRGZiSkVESjloZllZSnI0VEJLVmFSc0RkV0VLZi9QR29jUlg3S3pvZEFa?=
 =?utf-8?B?bHllWVh5RFlwMmZRVGtmR1RqNitKeHF1REgvb0doQUJEWkpCSTNsa0tKYkJ6?=
 =?utf-8?B?YTZDQTFHMG1nUEN1Z01jcW9SSlcraHEvTDJ0ZFN5ODVRb29NQVV2c3dBaTlN?=
 =?utf-8?B?WktZTHg2RDRtUTBMSjU4SkV6SlgwZ2lQKytVenVZdWp4VzlpanNieDF2aHFL?=
 =?utf-8?B?anBpUWFSTldpWk1RaG5UK0ZUL0lzeUlLZlRISWZFMXFxYzdmOENjNENmSTRX?=
 =?utf-8?B?Q0NTbzBEay9jRVBodk1BeVBKU3dHOWFNdUErZ0crQ0xGTW5YTDIyNW5XWG4x?=
 =?utf-8?B?SStLMURhbVN0QmdnbEpRaVlOU1NIRzF5eDRsNmtkSlRONmlXajFzZ2VkOVRV?=
 =?utf-8?B?ZDZ6Si9FN3UrZS9XL21CdDN4NEgzajNuSzNkMVl5ZEVsR1hOQXRoeG5IakZD?=
 =?utf-8?B?UUZXZmhVZENUakR5RGFheEswQlpsYXQ0dG5DU1VzdHNadngxdEJuNDR5MkFU?=
 =?utf-8?B?QU1QRGowSlhJQXNTL1hCSFYzdXlmNlBKYXljQkREdlhUcHJxTFA0UzJuNDUy?=
 =?utf-8?B?bHJiS2pvcW91RitZSW5ja0RmUHZ1WWRpUHEvSnZqa1JRWWdjQ0Z0VWFNMmJV?=
 =?utf-8?B?R0NBUW1WaTNVWGpUS2NVbHd4RGdPMm9wcnlJOHBMM3BiN1g5VEJGMVRUL1pT?=
 =?utf-8?B?cERwbExBZkFwWmxkenVRWm9TNVY3SE1EVWd4RTUxTlZhcUhvd05JY0Zqb2sw?=
 =?utf-8?B?Rk0xemNDSVAraTFyZnVkTVZsMGpPcjRDQktFemNJZGtTcncyRWt3bFMzeEdz?=
 =?utf-8?B?T3B0d3ZQdEg0ekIrSlo0anhrMGtBdFpmKzc3VURLVDAyTlUvQ1daWmJvbit5?=
 =?utf-8?B?VGV3cDU5K0t1eXp4OE9IM1NzblJTdmttbGRJVFVJQTdkY05CaThiSHkxOEhx?=
 =?utf-8?B?bldPendtOFhILytYam9KQkhxU0ZEeDJrMitFV0JRU2Q5QTJtbzlDR3pLSHE0?=
 =?utf-8?B?SktwT2ZWYzdBMFhhZklKK3lITlpVc2tsR085T3AvVGRBV0dUZ09McDRBSUFi?=
 =?utf-8?B?WEIwNlIyNlhyaXRjVG5FaTd0RUZrSEJ0S2tzbU04UlAyVTlzdjJQTVo3MHc2?=
 =?utf-8?B?TFp3cG1UdDZzQXczajZicW5meFV4d1JKQlhZQjN1bXZFWW8yVmorMklNZzJn?=
 =?utf-8?B?YTJJQTlMblNJb2J1RFZKSml0Q0pDdVgrSUk3K0paR2NYNzZPRnlYT05VR2Vs?=
 =?utf-8?B?dVdGOE9iTkNEL1VzaFZ5NlYyR3E0R3ZqSlp5WDl1RE8rdEoxR2tQOXVEVHJY?=
 =?utf-8?B?NnZnUEx1Y3dkMGlKelBYdnhBMTB0dWpveXhwRkkzNi9mTlFYcUZPSVFYZWkw?=
 =?utf-8?B?ZDFaeTlnekNjMFpTelBJb0hIVzd4MGFsVlJLKzdvVVNkZ2xYRDFvWXI1M0th?=
 =?utf-8?B?cTc2QnZWZDFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWthTWl5UVNEMi9YbjUvWmZtaDRWb3l5NDliRkZwZFBvRVRYSVAxN3RrV05C?=
 =?utf-8?B?cFJSVFp1bnQ3Z0NZeDE0TkVzNUgvVnhrc2VkRnNXQ2dLYTNLZ0l0emhJK1Nk?=
 =?utf-8?B?cVVQWm5VQXpFTVk2R2FOZVJZS3l4bW15amxBN3Q2czNwZ0RJbmRTVWRWUHNa?=
 =?utf-8?B?TzNQTnBWdUdReW9oVDhyNUpTM2FYSGo1RzlxMW5yZHFWMGlnTlN6bTVHbG5v?=
 =?utf-8?B?cmZramF6c1NTdmVCRlpvRnVDMG5PdU1jUHVacjFwNmJPNDV0LzZqUGUrSFJ5?=
 =?utf-8?B?ZFBpMDFIYjFJNm02V1dNZHNGNUZPbDJUL2ZWTVR2TUFORFFuMmlaNTlIYjM1?=
 =?utf-8?B?MjUyRnVLVW5lRkE1d3VzSURzVE1YdDVESzRlNVU5eXFrWHovTDJrSU0vM2dM?=
 =?utf-8?B?dnl3M3hZZDl6SC94L3pyQlptYUEwQkQxckp0NGRIU0pVLzJSZnJ2aHZTczJM?=
 =?utf-8?B?YkFxMnV3RytkaFpRZlZWNmJNVTduYmxXYUh3VzY5ZGVIcEIxTHVQTFQ3c0pY?=
 =?utf-8?B?UWNPL3lwVGY2QUtQVmJITGlmWm1qUXEzcVdaS3RERUl3NGVsY0p2MW5KeVZv?=
 =?utf-8?B?R1M0N1Q0dFVwN2xwZDlMMUxyMTEzS0gxbkpvZnkzMHFZSTlkbWQxS1VPYTZF?=
 =?utf-8?B?SnBpcUVtQWEyN3JNQVJ5enVlN2ZlcmV3eVVMaXJ4QytsbkZ0bVdubjBxQVNM?=
 =?utf-8?B?eDN3aDJjYjBEVk42N2VQdDdNcWhrcmlmL2M3NGh6V2hBZEphMWh2cWpsSkdr?=
 =?utf-8?B?eFQwYUJWZkthcmo0V0pGKzFqNXJaZ3VxNFA3UE1oaHhQZjQyNE1SSEZDVjNa?=
 =?utf-8?B?c0ZqY3I0ZzJ6V0cxNDFzbGl1UUkweW84RDdqcE1VbW1Md2wrTkx4Qjg2VFht?=
 =?utf-8?B?MStnSVJxY3FxdTBjY3hrUEtad2lvaVhmREpjUnJjTWxmY25PMHRmMCs5SjV0?=
 =?utf-8?B?M0xMYTRvdDZTaElqc1prR0JUbHdhTGR2TWJhdHp0S0tmSHZDazJMeXg4bEps?=
 =?utf-8?B?TEZZNU5YTGtCRUhCR2FIcUhQb1JJZlNFeG1IWEpXM3lpY2Y0OXNXNCtLVUlZ?=
 =?utf-8?B?L0VvK0VzUkRsdEI2TVV5emUxaVlKNkVkU21wNHZrSTBPczZ6RkZhbnZBODdH?=
 =?utf-8?B?alRxUi9Md0VEc0NqcDlvU0hkdXk4eDBHaEpqL2NxaEpBYW51Mktpd1JUOWV6?=
 =?utf-8?B?ZUU1YmZvNGdtT3NiZTcwSjBJME02YTUxcytoUythcG4xRlFkVkFSQkFydWt1?=
 =?utf-8?B?b09OcjVFMUd0emRlWFhGZzVHL01VOGxpbDdWeDd0UVpOZVVBcWFuaE5VcUVG?=
 =?utf-8?B?UENrcGJ5K3VBZkV0Sng3K0lvNHk2bXBEM1BGYTU0WDhmRGc5V1F2NmRwYlZX?=
 =?utf-8?B?dXQ3U29palowLzhicUxxTEdzeVp3c1JvUG1lSkRoSFFhaHJvcVFObGZyVlpS?=
 =?utf-8?B?dFNUL2l6aENKYjFpVjI5U29ZQXpnb28rd2lGRkxCY2FlUE81VkNCelJJa3ZP?=
 =?utf-8?B?Q2Qvb3Z5RmxvMFBHMFpuR3hpNlF4Wnp5ZGJQNWxSOEhYd1hEUXZGR3N2cVFm?=
 =?utf-8?B?d2pzWUhFN2lRbUVsRFFEMW5OT3ZUdEJzZHdRdHVHTFFFMDBtSXZ5dVVrUjZL?=
 =?utf-8?B?dUVFVGxTbFlJeEY4WGt4RjV4MVAxRUVkQUFydC9yR0RtcVhDbkhYNXN6dWVu?=
 =?utf-8?B?MWtKUjZ5eVVWcmJFVVFFanFWQm9yTTEwYkhsM1lEQkc2MmJhMXRRVnROS21N?=
 =?utf-8?B?QXF1eUl6V1l3SWIyUHA2Y3RVQUd3WGZpYTNuRnJsazMxOWZiZ2kxT3RnSkdQ?=
 =?utf-8?B?OUlkdWVmL3BNbjVKTGw0WDZndmM4SEJoOFp6OVoramJPa0NBWnEzZWhTUFRp?=
 =?utf-8?B?eUlBZFVndWViY0wyWTc0alpucHpVNXhSM3Zrd0l4cTJlMEtGNXh5d21qQ2Rv?=
 =?utf-8?B?N09pN3BjNER1RWNxaDdIL3hpcmhLWjU4LzlTMTF2TDlIRTZURzBybDlCWGQv?=
 =?utf-8?B?M3ZOWXcrVXhzOThVSUhpNlZpenBpTVdlb1l2R3g1czg0dTZoNXQrbzZIWU00?=
 =?utf-8?B?YmVUNW45cFdUQ3dEUUN1YW1ySTQzNG9ITHY1ajJBdjJyeTZxTnZpeTBEYzIx?=
 =?utf-8?Q?vHPjQPW6OqLJw/kOaaybdZgT6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07b8020-6488-4360-1319-08ddeb274aa6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:14.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWSBPGbTuUpnzIPdrdVBkBXiWdoXuZXPxoxrKnRafKxpxJ7pFDSMhQcmM5cPwPO62iWcMOz85ySPe8Z17/OIzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

Add key- prefix for gpio-keys and rename button_0 to button-0 to fix below
CHECK_DTB warning:
  arch/arm/boot/dts/nxp/imx/imx6q-gw51xx.dtb: gpio-keys (gpio-keys): 'eeprom-wp', ...  do not match any of the regexes: '^(button|...))$', 'pinctrl-[0-9]+

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi               |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi                 |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi                | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi             |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi         | 12 ++++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi        | 12 ++++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi            | 12 ++++++------
 .../boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi    |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi             | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi             | 12 ++++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi               |  6 +++---
 arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi           |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi                   |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi                    |  4 ++--
 .../boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dtsi         |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris.dtsi          |  2 +-
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts                     |  2 +-
 31 files changed, 116 insertions(+), 116 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi
index 41d073f5bfe7a5d42ecfe34341d8dc8a39f73801..c504cf7e9492a339658e60cff18ea7d86f3fbc4d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi
@@ -118,7 +118,7 @@ gpio-keys {
 		pinctrl-0 = <&pinctrl_gpio_key>;
 		pinctrl-names = "default";
 
-		button_0 {
+		button-0 {
 			label = "Button 0";
 			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
index 97763db3959fb1d5906b564ccedc0d1c13a7e02b..6fb873c2983fc03195ffa46245ca89813ca3d999 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi
@@ -33,7 +33,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_emcon_wake>;
 
-		wake {
+		key-wake {
 			label = "Wake";
 			linux,code = <KEY_WAKEUP>;
 			gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi
index c61e70469b66003c1fe62c75dbcd9608a11661ea..d92d26e40a1cf1c29b6fa9a630858b87ebd15a12 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi
@@ -24,13 +24,13 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -44,21 +44,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
index 4f66271bf4a4624cdc6403955022f8fdb69a0c4d..c1d124ad1d66139c62c52bffd9b22f81e3e3792f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
@@ -33,13 +33,13 @@ backlight {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -53,21 +53,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
index cdb40046bd7e58319c897d45c74c9e9c0afe9867..63e604537b06e6af5596298f930dd1e73afee952 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
@@ -33,13 +33,13 @@ backlight {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -53,21 +53,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
index 94f1d1ae59aa224d14bdcdf4d06d1bd2b6f8f6fc..66a7b3e03fa1214f4ee56b16835b342328867b3c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
@@ -34,13 +34,13 @@ backlight {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -54,21 +54,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi
index 4db5ef4a3e563dc0889f9a21fffe3818c74d499b..07cb36e65df7c99b7e3a2f650f354f6e31fce3aa 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi
@@ -26,13 +26,13 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -46,21 +46,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi
index 5d5ef18a05936eda6fbd6f21911e933d3a17959e..f152ebbd203dfa1aa3caf793c6c485026ab58bdf 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi
@@ -25,13 +25,13 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -45,21 +45,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
index a9dfa7cb69ef5872ba6601286c618aef99de21c5..aef920c192b564d5ad4f7a99d128c786e2fd886e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
@@ -24,13 +24,13 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -44,21 +44,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
index 11483daa59fc2c1bead0cff5284415a158b44136..ea92b2b5c50d93b2e3a03d3a6f8d7526bb8e6785 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
@@ -50,13 +50,13 @@ backlight-keypad {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -70,21 +70,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
index c48dd7d06bce7fc86e2ad4428a178b9d572f7f86..b518bcb6b7a99673de2a7eb49e2a34b75d41fb29 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
@@ -34,13 +34,13 @@ backlight {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -54,21 +54,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
index 2d24f9bc4106ae185ec8cbccd866089278218879..3df4d345da9898762a55e31a1c2d139116321f76 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
@@ -36,13 +36,13 @@ backlight {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -56,21 +56,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi
index e214a5f2f191b68b05b5101dcc5917fe830845ef..b73a170940a0126ebef98343028994be3ba50bd7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi
@@ -24,13 +24,13 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -44,21 +44,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi
index 02bfec7af9f2cc752534a69ccd2926cd8747beb9..099ed2f94d61a0a5f594c4d85800a881c330a80d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi
@@ -27,13 +27,13 @@ memory@10000000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 2 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -47,21 +47,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi
index add700bc11cc19807afca30d057bddb1d9dda8cd..cbca5e58e81211506987f38556da024467ddf48a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi
@@ -25,13 +25,13 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 0 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -45,21 +45,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi
index 0dc239d4975c4583b22c0e38b3fde265a3198888..4e4dce5adc153e5668b2004d1edbb4b82ffb9655 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi
@@ -24,13 +24,13 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		user-pb {
+		key-user-pb {
 			label = "user_pb";
 			gpios = <&gsc_gpio 2 GPIO_ACTIVE_LOW>;
 			linux,code = <BTN_0>;
 		};
 
-		user-pb1x {
+		key-user-pb1x {
 			label = "user_pb1x";
 			linux,code = <BTN_1>;
 			interrupt-parent = <&gsc>;
@@ -44,21 +44,21 @@ key-erased {
 			interrupts = <1>;
 		};
 
-		eeprom-wp {
+		key-eeprom-wp {
 			label = "eeprom_wp";
 			linux,code = <BTN_3>;
 			interrupt-parent = <&gsc>;
 			interrupts = <2>;
 		};
 
-		tamper {
+		key-tamper {
 			label = "tamper";
 			linux,code = <BTN_4>;
 			interrupt-parent = <&gsc>;
 			interrupts = <5>;
 		};
 
-		switch-hold {
+		key-switch-hold {
 			label = "switch_hold";
 			linux,code = <BTN_5>;
 			interrupt-parent = <&gsc>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi
index 8ee65f9858c0fcfa40e69ee4c08a5baf50e1e178..8d471450d5c5c76131ab9677986228c1615f584e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi
@@ -57,13 +57,13 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&gpio7 13 IRQ_TYPE_LEVEL_LOW>;
 			linux,code = <102>;
 		};
 
-		back {
+		key-back {
 			label = "Back";
 			gpios = <&gpio4 5 IRQ_TYPE_LEVEL_LOW>;
 			linux,code = <158>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
index 43d474bbf55d1ca80e317cefa6326fcc81f83496..a096f4d985e753e280cd3f8b2f9ee26588c19e0f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
@@ -86,38 +86,38 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			wakeup-source;
 		};
 
-		menu {
+		key-menu {
 			label = "Menu";
 			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_MENU>;
 		};
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 		};
 
-		back {
+		key-back {
 			label = "Back";
 			gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio7 13 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio7 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi
index 8e64314fa8b2a6f69e10fa0577e49ef6bb931345..806af7f60419e7e81c8373cdbaca36453abbbba6 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi
@@ -47,38 +47,38 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			wakeup-source;
 		};
 
-		menu {
+		key-menu {
 			label = "Menu";
 			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_MENU>;
 		};
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 		};
 
-		back {
+		key-back {
 			label = "Back";
 			gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio7 13 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio7 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi
index 8a0bfc387a5996bcd4ff3fc7ee4dd26c04f3a947..c71aa7498acf4a0b1cc8f74c325c8944ed1a781c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi
@@ -80,38 +80,38 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			wakeup-source;
 		};
 
-		menu {
+		key-menu {
 			label = "Menu";
 			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_MENU>;
 		};
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 		};
 
-		back {
+		key-back {
 			label = "Back";
 			gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio7 13 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi
index 037b60197598bca3eaaa3e2c61d176e401e2a7ae..060d2aeb1baf750c1b134ac716d9948fb64e5f10 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi
@@ -13,14 +13,14 @@ gpio-keys {
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 		status = "disabled";
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
 			wakeup-source;
 		};
 
-		sleep {
+		key-sleep {
 			label = "Sleep Button";
 			gpios = <&gpio6 18 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_SLEEP>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
index 2587d17c5918573cb103361234194a1b585b6548..b9dde0af3b995feb49fef38fb0fda69eee3a5750 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
@@ -32,35 +32,35 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 			wakeup-source;
 		};
 
-		back {
+		key-back {
 			label = "Back";
 			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
 			wakeup-source;
 		};
 
-		program {
+		key-program {
 			label = "Program";
 			gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PROGRAM>;
 			wakeup-source;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 			wakeup-source;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio5 14 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
index bdef7e642d3cf2edd833dfa7b7aa9d9b67f61ef0..f7abc17c7c93a7016854d7beb7d041dc90301514 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
@@ -108,38 +108,38 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			wakeup-source;
 		};
 
-		menu {
+		key-menu {
 			label = "Menu";
 			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_MENU>;
 		};
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 		};
 
-		back {
+		key-back {
 			label = "Back";
 			gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio7 13 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index 960e83f5e9043babb5fb9cc979208cdd94256cc8..e8368c6b27ef3be2bae1d1dadc7c29672db0e5df 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -71,21 +71,21 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
 			wakeup-source;
 			linux,code = <KEY_POWER>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 			wakeup-source;
 			linux,code = <KEY_VOLUMEUP>;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 			wakeup-source;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi
index 6823a639ed2fc25db1e153178ae376733d7c6472..2daf2b6af884965c80e1b309c2d3b8843b618bcc 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi
@@ -58,7 +58,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		power {
+		key-power {
 			gpios = <&gpio3 7 GPIO_ACTIVE_LOW>;
 			label = "Power Button";
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi
index 2bb5b762c98400b285426341f0fb21a4e64a0258..57297d6521cf09f1fd629ae375c9994ebb683375 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi
@@ -44,7 +44,7 @@ mclk: clock {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index 67cf09e63a638f6383ccdd659b2634670cb8f601..c7aeb99d8f002011a677ee50c7c849b9aab91374 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -33,14 +33,14 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio1 18 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 			wakeup-source;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi
index 2f3fd32a116795ada43a78d967704fa988f7ba3a..d4d6ce9756390d6b7aa296eb585fc7fe61a67443 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi
@@ -13,7 +13,7 @@ gpio_keys: gpio-keys {
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 		status = "disabled";
 
-		power {
+		key-power {
 			label = "Power Button";
 			gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dtsi
index de4dc7c1a03aee71800eb509201bdd57af515205..e75dad0f0e231cc4aa1c2596287ad783518c9cbe 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dtsi
@@ -13,7 +13,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_snvs_gpiokeys>;
 
-		power {
+		key-power {
 			label = "Wake-Up";
 			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris.dtsi
index f52f8b5ad8a6ee73f2d0ce1f1d2183893e8f7179..bce6fbf230b3969b4a7ca22a794205b65bb27283 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-colibri-iris.dtsi
@@ -13,7 +13,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_snvs_gpiokeys>;
 
-		power {
+		key-power {
 			label = "Wake-Up";
 			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts b/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
index f2cd95e992e74c04737184f3a7b217b8b8b95748..56dedd4fb8f0894c48eea5e34f2b8445cd38cace 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
@@ -23,7 +23,7 @@ gpio-keys {
 		pinctrl-0 = <&pinctrl_gpio>;
 		autorepeat;
 
-		back {
+		key-back {
 			label = "Back";
 			gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_BACK>;

-- 
2.34.1


