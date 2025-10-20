Return-Path: <linux-kernel+bounces-860680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB2DBF0ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 220BB4E59CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74CD2512E6;
	Mon, 20 Oct 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Xb28qlRK"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E202F7AD7;
	Mon, 20 Oct 2025 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957519; cv=fail; b=XYoPptOP94NwQOFVGpL/vb+uxwg025z+n7/kJHaQem37AwLPjFjoOacAL5y+mhHexJotiLC530sySWMABygS0LkepCEeAo2Ex0EZeBmVymRN6bKSkedc6m7EJe6GHQJq4bGZawKTNTr+xEsoPZeLJpKIVbspY/vOj3pQLzkaAFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957519; c=relaxed/simple;
	bh=ptWZj8MKlAAK2UkX3Rph78Yx+UhknfIWphnct+6Qlv8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nOHjB2b3UwenikoWZDYQMZ8BHLD7MMSrr9VvdTQK+d4mT9SJxpnU5NkkeM3skOK2tHEelp+E46Mv40Dw1HeYnPlyJ+C/QQdH2ST3Oxu6I40E3zDokJGQSbQqrrQnCtuZQeWKvcug0eWH0U5A9oXUSJDcxObcxw2UzHQ20gL/aQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Xb28qlRK; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbURkhSOKOhXtTICEHsdtYF4J9NC+yrFgahHTJTKimWts3wCuf6grS7jUvC6garHWxZRDxgUs2ej7vgS+alkZ43eINU0Ta22MnPI3o4FtZUuJDTwyDPBrJIKnSu7yYF88UdbGYs0uPXfiOoQUZt2luMbvmdV8j+Ga3mJXYB96RhSer6csqhHoAP2qkN2ZbqcKVA4ZisDyNcP9jpOiJkW0cA2zvUlO7nnYNUzX8bK4wANNbqPmvuVyaLCaPVkeGI1S9F6FK6yY0eEpUDGHfaSShDFx3noIGwSUcT+LLfP01uslvhtzgPB3MhcMst4/KLD0DmrOIe9hwnlz87vXeSXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWknxS/LTXG5mgkdsKRT8ZkAr5/ukzo5B4QY2rslwj4=;
 b=F/NiE4UgG4YvjE46TmI1PpQfyj2VgCGBWVAc6twnZNemJesREnnntOYT676qinfKMW6mexswSHLKv3i5vpBMc/AftVA8eN/FatqiCJmoOyGLPRRFyj8D0R7Jan18+SOEDIl4saej+EcII8y7Y61y3NGFRWCGBE1WKW9OTavtO3xKTggq2TCEHT2rJ1jwqNzxWKzaONiDlCQy+rhOxUTFBlz9madkQ91VaXp+sM9/4SR2yRIiwuovC+qKYVloBT1fisRYTWu0rnR/Y7l1Z0DQuX5VubfpxS1g4jX2XqaLqBrgmXe772ADgFkptYxqbWyle6AYsfz827QrH99tcUXKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWknxS/LTXG5mgkdsKRT8ZkAr5/ukzo5B4QY2rslwj4=;
 b=Xb28qlRKt8zuiJ6NxiJQbu642CUcKbXAudX1aNtHN3Slk2R8tn7iaiyNnipInjF8seKGQzW+v85Gau/cokK02O2Hh4L+7lHkUb/aCBEkRSCW3782agrO3i4bX/Ipnv+u2TlZM0LCrs3m3Jo+3kVU1oPdfhqIWy+YTcFYziVefjhUFSe/IUePcg+jxmczsh+vPuHHAA3zJem99FM0shUI/MPquxu3mcKzw10oeF4a1NNY7Jjdbn37x+sf1uXlu0q3NPQHiwE/uvQXGuS2n2Md342obpGkJnvBvVL/hL3zciJBJBeXvEurobNFfHgVwr0+MWKEg6KrQZrFstOPQ5BCJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11683.eurprd04.prod.outlook.com (2603:10a6:150:2b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Mon, 20 Oct
 2025 10:51:53 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 10:51:53 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 20 Oct 2025 18:50:44 +0800
Subject: [PATCH v2 3/3] arm64: dts: imx94: Add OCOTP node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx94-v1-3-0b4b58a57bf9@nxp.com>
References: <20251020-imx94-v1-0-0b4b58a57bf9@nxp.com>
In-Reply-To: <20251020-imx94-v1-0-0b4b58a57bf9@nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11683:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce6b473-0fbb-4306-0ee3-08de0fc6add8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THdBa0lpWTNETjRTdXJQbnpLYWFZcFNNQ2g5QjhJcXErL1p4b2RhVHFXZlY2?=
 =?utf-8?B?NmMwMUNoMGorZE5iTUV0M3hqeWZHcjRMWWFMSzYwN3F0U0FRUmYxcWFzSDdl?=
 =?utf-8?B?cjdKZzNWV2w2aGp1RjcraDY0VEwxMEdOQ1V3Um0rMjJWMU4ySXFaZ04zRmRC?=
 =?utf-8?B?TW1lZ2w5ZExxcW5Pc2pRRjBLWExWS3NBNDVlWWFxUS8wK1I2cit2WVV3TGUv?=
 =?utf-8?B?TUhabmpvOEU4Njc4MlZLSjVUTUNtRUQvRVJvNWtFTGlmRUg0cGRGdnZDNWph?=
 =?utf-8?B?WWREbW5BWUtGb29LaVM3a3FNMjVyVDgzdTVwNmVhR0R4NkNuRDRTMkgva3B2?=
 =?utf-8?B?VGFEdnAxb1FOdzB1Tkc5OEM0WHB1dUpKejZid041dzJKQ0svNU5CTjYzZDhT?=
 =?utf-8?B?ZUYwR1lCNUxoSy91Z3VnQXdkTnRzM1U5MW9ubjdFZHo4UDRhb1JvRVN6MlNF?=
 =?utf-8?B?ZmtXeHltUU5Fekh3clJPUDhUUmxEdHNiL2VhQitmTmMwZS91b0Q1aU5aTXdD?=
 =?utf-8?B?TE5pNkNZQXEzYmYrWGE3emc0TWJPMnRzQWRGQ1NLWE9YbDIwQlNjeUFBZ2ZB?=
 =?utf-8?B?ZDk0aFozcXdSNE5uU0hpOTN6MDhEaUkxMEcvUENrN2dHSll2bUswR2VaSHNV?=
 =?utf-8?B?eENWc21Ma2VnTWxOcEFZUkU5VHpHNy96b1VzZXNyb0NTNndpcGU4RGpKdHg1?=
 =?utf-8?B?UTdDMjhOUFF2TWtDTmdqY3dScWFpVHJWUVVNMDl1cGwwMlhPa25OMC9pTitM?=
 =?utf-8?B?cnJGN3ZHWktVcTBZRHdna1JXa0luTmFmV1NvOTVsZllDeG14bS9JUHBKR0JP?=
 =?utf-8?B?ZkRXYzAvUHJjdU9kWUhIcmpPS0VXcW41bExuWjJFVUFMeERFSVl2cHd4WnBJ?=
 =?utf-8?B?czh6Sk1zOGw4Y1l5T0syLzl5Sy9pMDlLZWtFK3FtLzF4cVJZTUp3ZDVyY3Jw?=
 =?utf-8?B?ZGhRT0s5Y1FvdHRZdmtnK1ZLUUhBdHRJZFFUV29Jei9RdFNCbUN6MmIyZ2tU?=
 =?utf-8?B?ZlVyZ1lNYXFHZVlEaXVoZENaVzdkTnRVbi81cUp2ekVCOEJCRDdMVlFmdFdF?=
 =?utf-8?B?TEpFN0JuSmdoU0lXUm55eVRnaWJ5WVJUZWRUT1A1d2FDL002aHZxZ0lidUxD?=
 =?utf-8?B?ODZGZHJBSkJSWmEyZkJFVk5NZWVpbVVDa2RRWUNNUFAvaEFNY2FjbGpoa0sz?=
 =?utf-8?B?SCtnbHZyQTVxRlRsaEpZM1F5ZDdEYTdSL1NBVTFUbE9XeWFaK2pZUHAvUzNB?=
 =?utf-8?B?ME82d3piTGFnQ2c3YzZiRkw0RWt5QjRNM21kNmVhaW9xYm1keW9sTVh3UG9J?=
 =?utf-8?B?eVRRWG5mNThkYWVXWmM4dENRYmJYSENXZ3l3VVV3aTBITnJPS3VXZTVRTlJ3?=
 =?utf-8?B?QWdSTGFPdEZHN3dsaWZQeG9wbjQ0MGFlcENkOGNDWVg1Y2t4cGxXbk9Dd1E4?=
 =?utf-8?B?RE0vSHNDYlUvRnVsZExGT1Y5cjdTZG1DQk9xelluOTJORFVveWc3REh6YXpt?=
 =?utf-8?B?R2lUSkphTmQzMFF2dmdDS2tIK1piMjhlZlZrQU95MlNMNE1SRCtSRklKdnor?=
 =?utf-8?B?anViSE5oY1BQSklDeWdvcTN6U3VpSzZIUndoZnhwdWJzUFcwWlNxNFhWWXJ6?=
 =?utf-8?B?dGFXQ1g3L095NUZ6UEhVdDMzUFBzb3hXbHl1NnA2c1JSQ3E5alZXMG03NGxR?=
 =?utf-8?B?NUNSVXhsbVhzZE51MVR5N0Q5N3Q5SUs1Y2V1R1V6cW03Zi96YlJBbDNpcjlh?=
 =?utf-8?B?aVBDcEVIRVVZR0xyaVB1eUdTbHlwUERtSjV2L1dNbnM3cW41UjJ3UHhRczVq?=
 =?utf-8?B?RmN1SS8zY1dkY2hMSG1NSjU2dzI0dEZ0b05wbUk2YUdpc0RjZlY0d3g5b2xV?=
 =?utf-8?B?WWt4SGMrM1IwUEJ4RGhGSjI5UjhCM0dMVXlXWHByYlcxeXovaGcwOUo5YTQ5?=
 =?utf-8?B?UEFkTWNWVG53cUV0azdrNFMxWkNPZnlPZHR5WGtBMWFROHZPczdncUVzcURK?=
 =?utf-8?B?a1V4dWFsZFhUdThVT0FWRU91VmtrZ2E2VUliK05oT0JrYTJmbjFIc2IzMW43?=
 =?utf-8?Q?g7KnzY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW5qZG1nSm1HQlBVSFIzN3pqUHF2VkhCZDdtRS9RZm9ab2xxRysxdDdwRmhS?=
 =?utf-8?B?MnNRMENlR01uZ0NHQnAyUVBya0o2bjZwcC9YbVFNczBJM0E4aUJEN0dockF2?=
 =?utf-8?B?T09VakVxRWttbWlRbUo2NFFocy9nNVBlVEZJS2ljdU9xeUtUWXVybnE3UGwv?=
 =?utf-8?B?bzFTdjhaTFR2U0M2YkU1Z2gxNFFYRTZhMEJqR294aWUyeU1GNXEvSW1sRG9j?=
 =?utf-8?B?b0JwaXhzb242NnBobW94NnlWQk9vVVlTSUg0WkpPYTdlRjlUd1RGY1pUWDFQ?=
 =?utf-8?B?Rlh4YW1Dc2JSaVFFcS95bCtmTzBkTkRqYVNLTjlJYUg1VGNDQ3lPakRMdCtv?=
 =?utf-8?B?SFd5OUlsaTRIZnBrTmRReXNrWi92S0Z0SEdKRjg5TnRobUt6R0FFRnBQb09P?=
 =?utf-8?B?R1YxSENWSmxyZStJM1Joek9TT1J3K1p2NEhTYlZmM3hBRkk0OXFBa2N1c1k1?=
 =?utf-8?B?R1UzVXFlRmNCeUJkcHJqZkxpdHFLZENMUFlrdjlUS0tha3hlcTgzemRWNGxq?=
 =?utf-8?B?QzVsSkwrbnlnZW8zWjVIYVQvMmk3U3VrV3ZGTUlQaWhwQndYN3c4Q0tPcXZn?=
 =?utf-8?B?NjFUZlRRUmxSNGpOT3E3aDNnVFFPNTV0VDNoZGNLazErckNKQWN0ajI3eHdv?=
 =?utf-8?B?WlFtaExON1kwOWcvYmFXNDNPR3YrR1pWVzBqNDRvVUx0R28xckYvOWNaWUhU?=
 =?utf-8?B?VTV3L2grcE9UUjdMT2ZJaE52clZ5WjE2a1VRUjVFWGtocUpDTllBdTl1YWJn?=
 =?utf-8?B?UmJLTjhjamJKdFJuVERFTTd1RGZVb2JtRGIwcXVEN042dk5obkJnQm41YWRW?=
 =?utf-8?B?L05RU3FjWC9EM21UMTMvYXRaWHJwbWFlbHBPN1M2YW0zb2VERTBLSkNhclhG?=
 =?utf-8?B?WGFMNzJIbmQyY1FFdC8xU0laUWJ4cjdxTXViemorelp2c3YrajJqSGxySVNM?=
 =?utf-8?B?SUdWME8vRWN2eFQvVDVod3crcWYyMDR3NjMxcytBaytYdmtSWlBPTmN6eEow?=
 =?utf-8?B?VDdEUWpaNHVXRXhyVEZiRWxqVEVBU1hNZS9jcStsTnBEclNMTU1uOUJDL1VO?=
 =?utf-8?B?eVNvOHRFSGd0OU9GdStLNHdPdm5lZnFKbkh4blhEMHZwcm9rUUthL296MWh4?=
 =?utf-8?B?TDJBNjBEcnpKRGJhYVA0YnVpMFlMOUxrR3JxUXl5TXpMUGhoNm5CU1ExY0Zj?=
 =?utf-8?B?UytreTl3bXV4Zm1GNXNRZU1rNC9CQ0pDRHJ3YkU1UFM1Ly8vaUc4dEd6all1?=
 =?utf-8?B?Q1oyNHVXbVh6NHFSMm54c3RMZWs3ZVZWeVpvSjlGamQ4MnlBakVyamtFbm55?=
 =?utf-8?B?a2V2Y0h6YU5WWFRtbXZJclBSM2hmcXR3MkZDZmIzeFlMYU0vWlEwVDlFSkdp?=
 =?utf-8?B?R0xyL3p2OGZHa2ZzVGtRdHNZOGRxTGdaUUJxWGg2SURibDg4WFdSQlJka2ZX?=
 =?utf-8?B?bVVLeVpUZUJsVytTRm5zVXhzVnV0S2E4dXhPZ1Foai9JZ0Z2Ly90Nm9aV2Y1?=
 =?utf-8?B?UHJJdkNnd1hHd1N4T2dOTVgxUU1EeXlPQzRFb01qQ0pDOWdyYVQwUEw4WE4y?=
 =?utf-8?B?U3lwTVhJRnFMRWRtY0hUMlRMTm1lVjlRWkNNNEdRdno1eU0yeEwzM1U1ZDRV?=
 =?utf-8?B?Mm1wSHRyRFV5Nk1Cd0ptYWZPVGh1M2pJaGFjcFp1WWRrYTlHU2NrTGZpV0xX?=
 =?utf-8?B?b3NuY2ZWclpYSHhkcU9OTDRtb3pRZnlKb0pKOWVYTjhPdENPaHhMR0F5bHQ5?=
 =?utf-8?B?bUVuWkRqNS94UVYrbWNCV3hLYTZlSkpOUnY0d05PNjhFdU5VZXlLYTh4V1c2?=
 =?utf-8?B?eGVYUm9HNGtRNTZ0b0xScUJGOVlOWllSSHZHSWxTblFvYWNuVFFMUjkwN0Nl?=
 =?utf-8?B?b2w4azdWUVNhMExnTVNUcGF2YXNuVHBCN0FFU2Rtc3Nqb09JQzM5ZzlxcG1M?=
 =?utf-8?B?OW1kL3VrVW1DSHI1ckIzL1hVMTB6cHlSQXBhV2tKSWYrNzhSUG1NTHQ5blFt?=
 =?utf-8?B?QXRKc2owelQxdy9weENNVm5wSVpXQmUvRGIrZXFIZkdZZkdNSWNGdXBTV3g4?=
 =?utf-8?B?Z0pkRzlYaTFKYUg2OWNsdlgvNXNZT3B0T1puemttcGJaSUQ5MUNZdTFub0o2?=
 =?utf-8?Q?/e/xNzjsTWdnm6cmdeuNHd2Bf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce6b473-0fbb-4306-0ee3-08de0fc6add8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 10:51:53.0261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/fRRymWQ2ex8UxftU7C9nWdbY7stMN3bpti7XfOc26nmDloao1/hh9R5UckY4ZhEoKBQeJk8G24UPi9BkvE1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11683

From: Alice Guo <alice.guo@nxp.com>

Add OCOTP node to the i.MX94 device tree. This enables support for
accessing eFuse on i.MX94 SoCs via the NVMEM subsystem.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index d4a880496b0e..8728b3aa15a7 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -1173,6 +1173,13 @@ a55_irqsteer: interrupt-controller@446a0000 {
 			};
 		};
 
+		ocotp: efuse@47510000 {
+			compatible = "fsl,imx94-ocotp", "syscon";
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


