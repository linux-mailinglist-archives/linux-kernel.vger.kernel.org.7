Return-Path: <linux-kernel+bounces-829623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44785B977BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338CD19C82D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52530DECF;
	Tue, 23 Sep 2025 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aBJ8pW4t"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341E27F4D5;
	Tue, 23 Sep 2025 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658997; cv=fail; b=FiNcLKdCalOkJuAKHuuey0b+lA3uwlA5EgaQTIRZ8V01rGVfuzNw/w4fLtoO8TXgqUh6aic4QI9SDkIJy4JS1hVrDUpOwzpoFdII+L4aISfOZb7WT1BwDTbprcZLBunmdZmi2SV7aaryoGvCoFshJRaHdOPrEDQcIvrUxm0PG7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658997; c=relaxed/simple;
	bh=MfrzkHWiY3Foc5Vne3opsJSIafyoVDR8FSTrkUytx1M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Jnv3nZiTjw3XnuGQHkzPB5VimgUzhUBB9pYjCW5AuRbOJS7ZtQPaInfq7qDdCZWaKQORxwrQoaa7f3eO98uA4xou+PzfCPVRdEbmRwheU92b12Vs8mILxkR9zqWtSP5BG/JxS3zGtkLON/m/M/DVwN2AviwzsXstxqHqkRFqp4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aBJ8pW4t; arc=fail smtp.client-ip=52.101.84.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2rv0Tq/uu3ZWV1IAtsAEVDZPFg4GY8QYIQRpn3jmcSJIENq6ksyfkn8iqZLbYOGDLRBzA/nqrR8NngtOV3tmfuy9rLfcen8lIRKB75n1xOOwC6817Du2eqBhWLzF0rk8AN7R8BmHveZqUNbyChsCeqPnKPXtwP5pbuvx3kmZKtazBCTvxOvrPA/Y5akinsC+Ul6YzmbRSXLvGw6OBQA3UrNSA/gFDcxpYe4Qwa20d6xo4vCZr7SlUUJkyJa86ylkRn+HfOOvEGXdHDxPXSe5UBZ8N8pthwDlTe034TnYy2ySyVdeOpgytrvOI/Nxb+voKgoUiKRdWbZLHzBwnOGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDZ0o4H9ijr71sJrKbVbVEtmQtNm/2nqrZ66oE0U1GM=;
 b=PPYlSVwk907AkTW751IiwLB6PlKSKZVkkdCVVBhWGlE7Z4JMrIdMmfr7zD5MsZ+1iESSBJxP4m3v/ltQU8IU5hI9owrTmQgVFT7iHT1xR0OCtTVlfkFsHui57IZsJHHIGwnmko9EP6xrlcQsR/XCDpZevrxr5MoxiSqfsZ9orudzvQXMUn8K06dppWEz6TJl5muvj4YgmeEVl6htv/iHtgMtySDbzb2QxHg2/I9PlRHzHRx3ympdlq2m6prFECJ9lkqfYtB9dViqs12+AOPf/D0colaai2pHN71GdTJ+8++2cAbD4+BAk7ovWulPBoHih/V+A9hamNRp3u/UcJSBBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDZ0o4H9ijr71sJrKbVbVEtmQtNm/2nqrZ66oE0U1GM=;
 b=aBJ8pW4t300uGhFLUxMptmc1R9HLVZQ2WYj4hj9O9I/vDxc3cNFaJu5LdBu5vxcbNLv+oCddM7jTH+adJsphb0dc4HrklAxXptsYlUH3wTgrz0Afvk2Mxk/QP5Gzbg9ft/ynAJ0UJuD25HGc1pngLhdcS4gPdb+SozYvikSDj/RFG7yf2k3dLeB96qjvu60tYpPiI90QVM2HcDN1ILSbN9dd45puJGuoAE/bDKfO5auSw5ITTuv3N0XNiImuS04xjcFN+zk3+RJzerXWfF1+JSr239p5HxIwiYizl51bd/nVeH1lvjo858laC8pwmx6hLsIV8TUgCPv7k+WUeP57Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 20:23:11 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 20:23:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 23 Sep 2025 16:22:50 -0400
Subject: [PATCH v2 3/3] arm64: dts: layerscape: add dma-coherent for usb
 node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-ls_dma_coherence-v2-3-ce3176396bdb@nxp.com>
References: <20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com>
In-Reply-To: <20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, Frank Li <Frank.Li@nxp.com>, 
 Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758658981; l=8694;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MfrzkHWiY3Foc5Vne3opsJSIafyoVDR8FSTrkUytx1M=;
 b=Z6BEDJPQTJaPtSW5rkTEWHsDjm8yz/88OZ7YCNF4QS5PBRs7Zb3OVQQDwOJjQWLemuu0nsSxG
 /ha3n8BVzHuBxRBHTJ0gv+qf+rECUlxnbNIUhq+2RznlVbZbDa98heX
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM0PR01CA0170.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::39) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DB8PR04MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: bd184490-9a94-4762-be33-08ddfadf0423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTAyQ3hmVDJsaVhJaEdrWlUzeDRuVnVKVDdRWG1rMmJPcnE0Y0RCYXh5WVJ3?=
 =?utf-8?B?clJpbkIwdVNzMDA0S0dYYjZRZWNKWHp4UkJUQytFV0xPbHJ1WHo5MElrTnpv?=
 =?utf-8?B?MkRVQzcyMm5pR3lBVkYzUklsUExWOE9ZNW5OSTRWSHRXQ05YMklmSVpkSmlp?=
 =?utf-8?B?bjJvMnl3UGU1ZWRxN2ZMUzFSTy9nTkRockRSSjZndWk4eVg5R1p6bEpLcFk1?=
 =?utf-8?B?bWdTNnRpcUMxSlNidUxHUDg3eHIyYThsTGprbTRwdnBtdXgrZ0VOaUJTZ2lp?=
 =?utf-8?B?TEZIUU9SdStBVm9IM1BjK2Z2UFVyZTZzTDRSaUxMVzI3Q3BTaXpzZUpBMEc4?=
 =?utf-8?B?TDA1MHRwU3ZiQ3UzOFBHTkNsbVlRQVh6KzZCNWZYS1dlcGtucFIxaFZmcHNB?=
 =?utf-8?B?YmpXTGFzOWNlSCszS1YrYkJMaWgzRVBMRVRRd3ZRRzAwaHVYZWN3aHNDcDBs?=
 =?utf-8?B?ZXgvOVk2WTg3TExDV2hKMzZ5d3A1NE5PQXEwWUR5OEJhY1dINmxWejZmWE1E?=
 =?utf-8?B?cUJPakxFYzNQd3NWREVWdFh2QUQvRzFhR2VSdUV5U0tTdzdXMW5lcXVVTVl6?=
 =?utf-8?B?MkoxV2xNK1RnUmhXeENiZzkxL0hlZW1XUzI1RURVUjdBYTZxQ1dlMFlCdUdm?=
 =?utf-8?B?eGtKT2xualpwbndoMGNsYUFkMW9Sc0FLakNjSmcrUW5HL2pGZlFOOGhYeTI5?=
 =?utf-8?B?R29HandJeEE2TGRTcHJnQ1YzR1BncmZsM01lR3E0SUlpc3pEdC8zRVE1SnJo?=
 =?utf-8?B?dllLVTc1VlJFbU91QlhkWm1XMEZrVGZZN3FLZHVKdlorWFJDOWwwVWx3Uitx?=
 =?utf-8?B?WXRjWTVZRFljQ0x6dlZzNkJXNUJVeHFPTFQyTTR6bEx4eTV5cjVlM1RpeGRS?=
 =?utf-8?B?YVRjcTJ4QlJpMjJTNTgrUHZXTkRYQU01U3JTMDQ4YTlNVUt6SWJOS2JNTTda?=
 =?utf-8?B?TXFia2dyZkFRblhoM0UyZkt4blh1akpldjBhMHF6eERxVStPSTlaS1gxNUhX?=
 =?utf-8?B?bUdOZWszdWpZVU4wRmhRUlVqMHkxRVl6RDNiRjBQNGJMWWFabVpmUnUwR1dD?=
 =?utf-8?B?eE1WSVNWSlYxVUFwSkdLbjNLRDNwT0M4TWhDbzQvR0NNd1dlcnpLdCsyenZE?=
 =?utf-8?B?N3YxbXZZUDRQbHhsZHB4ZzZYQ0N2eFZaS2l0Zlp6WmU4bzR1bjBnM244Uito?=
 =?utf-8?B?M0dlTmRtYmkyZUEwU0VXN29UMVZJTzdKZVlyOUY2N200STRBbXR4Z1hJTnpq?=
 =?utf-8?B?NEZVVmtPU0g1dm5JMTZCU0krT055VVpHcjdpcGlvOHphTDhxQlFkcW1CMTk0?=
 =?utf-8?B?SzJOMkZKQnhUamxkUW84ZERibGFYRTIyejBIWmV0Z1ErTzdYWkJ6dUQzalpl?=
 =?utf-8?B?eGU1SjlmZ0VYRVNVc1lCMUV2TW1IWmRTYitxOGZSSFRuMU93NUV2dFE2SHpC?=
 =?utf-8?B?elJNN0VwTmptcE5jbFR3S3J6eXpXOHlKcUszREl2T1laZXFRMTVGem1odFV2?=
 =?utf-8?B?cGpPMmk5R0pvaUNtT2hWV3hUbFZxK2dFY2xOejUxWll2dXRpWmtGQWZMNm9k?=
 =?utf-8?B?a2xuSUd2Vi8yMW1BbjNOdG90WDZ6N2FySzB3STdRRG1rcVo0TGtoNStEanZo?=
 =?utf-8?B?YTlLQjdlZzVPbW4wOFc3M3c3QUVoWklNN25sa2dMT3I2NEQ0QitoOWNrcTJT?=
 =?utf-8?B?VXdyeGVBQlgvQ3ZQbUJxT1JrZHFjQnVVV3ZpaExGYmFENzk1aVlvc0VSQVNt?=
 =?utf-8?B?VldsM2J3YVFvL25PN1VKczU2dEVqUVkzR25JZ3dyaS9nUkZDaUR4ZVNDRTJK?=
 =?utf-8?B?eHNXSXdRclQyWXo1eVJBWXdKTG5wbUV3ZWxiNytIeEJZU05EUFRHTldtaW5K?=
 =?utf-8?B?Mkw1ZGtSdWNaN2IrcXNoK2R2K2VsM0Y5Si8vMHZSL1cwUTdocUpNSTN2dHBN?=
 =?utf-8?B?dkdML1poSGFrNXNVaVpraW1kRS9lZ2xDWktIbWhsMmtrTEVUVVhOUmFHdEx6?=
 =?utf-8?B?ZXBwUEthdGFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blF0MzdZMmNQWHFVdWd3VHNoYlpOalltK0FrNm12ZEYzNGtxaTBsdTJaQTRT?=
 =?utf-8?B?UTZFbWFwR25Wb3d0ZkxFMEV5Tlorb0t4cWNCNDFST3M3Nm5MdUphdlBqZEtv?=
 =?utf-8?B?dERpQjlCWU5PTThsN1A0WStzbkMvV3NUMlpVbTNBWml3em93ckwwYTlrMjM4?=
 =?utf-8?B?eTJIWWRVY2dlK3ZWNTA2M3k1YnRhOERNRHNvR2tyV2RYYnMxOFJCTGp2SXFE?=
 =?utf-8?B?cXJaMlFBVmMrVW1PazIzcHJFZmhLZmZJZ3R6VktnVElMRjI0d3VIT2ZESkl6?=
 =?utf-8?B?Z2hUZTJGTHRYZjdtQ1dMNFUrYzlxQU00ai9FOFNqWmJsd08rQWZwcFlIQzQ3?=
 =?utf-8?B?YkNQMkxXV2YrWnZXOVpSK2ZZTW8yR0VoZ3BMOWwxSE55TVNnU1VwVFpOS2tL?=
 =?utf-8?B?bFVTNjVxM0xOeXd3V2IvQXlxa2tnREdJMXlnK1hPYlJKMm9IQ1YrSHZBOGI1?=
 =?utf-8?B?SHBKazBoU0ZCUERocmlzWldWbElHek0vMlFoWWxkelR0RDNHQXlHK1VJbmlo?=
 =?utf-8?B?QTZFSUVLK2k3eU4vRWJZbUZ6UG9iRVZrRHc0ZTFXNlpTeEdUR1pzYlNYOXNw?=
 =?utf-8?B?WHJtYjE4OG0rbEUrUmliKy95dGgwdlR2UHZ2VmpaKzdZOFNlZTFCNEE1RmFw?=
 =?utf-8?B?dk0xQUhVa2k3VE5yakpYSXlmNnVldHo0WERybThxYm9kUGp4YWFhaHdUMDdp?=
 =?utf-8?B?ZjVNaVYrS1B0dHhKTXBiUFpnK1YvUGlIUmN4ck83YytRL2hZTVJSV3RxUDZR?=
 =?utf-8?B?bndTcWl5T3dFdWhRU0ZqSnZjaUdpQUU5S3AxaytKbVVDT1NuUGR1V2xyRDFU?=
 =?utf-8?B?ekJjMHM3TWxuTjNqemt3MVBhZDBQQ2VCWi9UdExWZ3VZenVvc0FXUHpPaElL?=
 =?utf-8?B?eGtZTzIvZTdVcjEyVEVFU3pPYWxlb0swNSsyZHF4RGxCZkVxSmhrc29HMFhw?=
 =?utf-8?B?MWRmVEs4MERRYnFaREhyRHloWGtkeUd6bU5GSTBjeVUzdk12WTVJbGc2U2hk?=
 =?utf-8?B?WmphTTdiUVFZSTlUZmkvbDBveERlTmd5NDVuNGEzQkNBUUppZyt4TUxXK3R6?=
 =?utf-8?B?c3Z6V1V0MWdwcWdvelpjQnpKZU1jLzhtY1ZtU294aWJDbHZvNjJCR2QzeGNV?=
 =?utf-8?B?YkFBS1BIUEZWMGJTUzdnVEM3SWd2UlA4TGd2NWNYVlo2ZCt6OUpuWFZBam1s?=
 =?utf-8?B?ZE9jcGEwaXRQTis2bUVwWXE0bWJ6NzVCM042UDBYY1VBVVI3ODYvL29CdkVC?=
 =?utf-8?B?SEFjcWxkeFM4WjduOUkranJrVmxMVmNienUzOThiVEYxcmpGTjVNMmNQMTVX?=
 =?utf-8?B?WmFBYmRKRHAvRzU4Z1BxVUsvNGVPM0w0c3Y5Qnc1RGNvenREc0tRS25URWZ5?=
 =?utf-8?B?UUJkOXQxYmtTczZqQUYwVHB4SVFqT1UvTHdOakdGY0RsWGhjd1pxMlZKVEF2?=
 =?utf-8?B?R3pSeHdpTlgrOXdBYXkyRmlRc3daQTlEUVFJVnFnTWhwOXQxQkF6T0tCTUpy?=
 =?utf-8?B?NllZNDA3Q1Facmo4cUdBOFpyN1kvNzBSVW1ENmlRNFhBZkZrOTk0djBraThH?=
 =?utf-8?B?ZXk1QW1CczhTUjBodHFZUm52S3cxRGtMaWs2Zk1MZW5DcHozaEdSeU41czVQ?=
 =?utf-8?B?RVBsKzFLMFRWZGVrUnBsYU9OR0J0OGU5ZUZhQzduOWtNVUFPL2xSTnU1U1hy?=
 =?utf-8?B?dlhBQ1U3WTdGZGlkdkU2ZHVZM28wcDQ1TDZ1U1ZLYjFtNHFDay9NS1BTU2Iw?=
 =?utf-8?B?QzhPbVJZMlFsMTBIYW82TTRUbUQ2UnlPRTE5N0VVc1dJMDl4ckRLZzVPaW5m?=
 =?utf-8?B?bkhKdnNlSkkvejA1SnVRcWhGY2lvL3lYU0kwbFVJNmhrZEtmbUNpSjQrMENk?=
 =?utf-8?B?dWFpUkEwb2ZIYkNkSzdCWXhRVzlXNktvR0tqN055dFNRZzFyNzRjR2NySkVt?=
 =?utf-8?B?Z2QyaWNRN1AyckRJaWdMaHlmKzE5L1lEWTFGV2NmNE9wVGJRQmlQZm84L0VO?=
 =?utf-8?B?WXFOZ0g2Z21Ed1JKRzZWaG1sZG1kV0FRWHhhVXU5QllUYmQ3aUFFa21mV1VP?=
 =?utf-8?B?UVBDSk54U1RPSGg3dGIrS0dkK3NCcXJLTEVGOVB4VjRxdUhBY0V1U0x2Z0Jx?=
 =?utf-8?Q?VJ6E2SRP98juHKrs/AsD0gNQy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd184490-9a94-4762-be33-08ddfadf0423
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 20:23:11.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBg7FwhO7XsEoDYq5YxBxTIAX6UMLm+9dq3c2btaFuW51wbLmJ/S5usoJp4lFf8Y8REuFefO3w1FB98MXVQW3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953

Add SOC special compatible string, remove fallback snps,dwc3 to let flatten
dwc3-layerscape driver to be probed and enable dma-coherence for usb node
since commit add layerscape dwc3 support, which set correct gsbustcfg0
value.

Add iommus property to run at old uboot, which use fixup add iommus by
check compatible string snsp,dwc3 compatible string.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 3 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 ++++++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 9 ++++++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 9 ++++++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 8 ++++++--
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++++--
 6 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index fc3e138077b86cd5e3cf95c3d336cb3c6e1c45ef..ef80bf6a604f475c670e2d626a727e94fcb2a17a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -493,10 +493,11 @@ QORIQ_CLK_PLL_DIV(4)>,
 		};
 
 		usb0: usb@2f00000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,ls1012a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x2f00000 0x0 0x10000>;
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			dma-coherent;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 7d172d7e5737c4b6e42ee88676c5763fa7415260..e7f9c9319319a69d8c70d1e26446b899c3599f95 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -613,9 +613,11 @@ gpio3: gpio@2320000 {
 		};
 
 		usb0: usb@3100000 {
-			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+			compatible = "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&smmu 1>;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
@@ -623,9 +625,11 @@ usb0: usb@3100000 {
 		};
 
 		usb1: usb@3110000 {
-			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+			compatible = "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&smmu 2>;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 73315c51703943d9ee5e1aa300c388ff6482423f..50d9b03a284a2aa4e13aa3323c25bbc5fe08f3d0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -833,10 +833,11 @@ aux_bus: bus {
 			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
 
 			usb0: usb@2f00000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1043a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x2f00000 0x0 0x10000>;
 				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				usb3-lpm-capable;
@@ -845,10 +846,11 @@ usb0: usb@2f00000 {
 			};
 
 			usb1: usb@3000000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1043a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x3000000 0x0 0x10000>;
 				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				usb3-lpm-capable;
@@ -857,10 +859,11 @@ usb1: usb@3000000 {
 			};
 
 			usb2: usb@3100000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1043a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x3100000 0x0 0x10000>;
 				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				usb3-lpm-capable;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 770d91ef0310d971d044a1f55cc5e2cb738acc47..22173d69713d1bd2abca986e76668ad437dd34e4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -749,10 +749,11 @@ aux_bus: bus {
 			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
 
 			usb0: usb@2f00000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1046a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x2f00000 0x0 0x10000>;
 				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
@@ -760,10 +761,11 @@ usb0: usb@2f00000 {
 			};
 
 			usb1: usb@3000000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1046a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x3000000 0x0 0x10000>;
 				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
@@ -771,10 +773,11 @@ usb1: usb@3000000 {
 			};
 
 			usb2: usb@3100000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1046a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x3100000 0x0 0x10000>;
 				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 9d5726378aa015eff10578bf095908a58b9d9eee..b2f6cd237be046123de9342e2167aa32248a8a16 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -489,10 +489,12 @@ esdhc: mmc@2140000 {
 		};
 
 		usb0: usb@3100000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,ls1088a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			iommus = <&smmu 1>;
+			dma-coherent;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
@@ -500,10 +502,12 @@ usb0: usb@3100000 {
 		};
 
 		usb1: usb@3110000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,ls1088a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			iommus = <&smmu 2>;
+			dma-coherent;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index c9541403bcd8239a48d4ef79c7c4f9e3b607b556..d899c0355e51dd457a4e7259709cea98a488f557 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1094,24 +1094,28 @@ ftm_alarm0: rtc@2800000 {
 		};
 
 		usb0: usb@3100000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,lx2160a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			usb3-lpm-capable;
+			iommus = <&smmu 1>;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";
 		};
 
 		usb1: usb@3110000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,lx2160a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			usb3-lpm-capable;
+			iommus = <&smmu 2>;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";

-- 
2.34.1


