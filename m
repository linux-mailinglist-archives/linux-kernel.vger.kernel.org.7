Return-Path: <linux-kernel+bounces-846233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A88BC7549
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 119364F2358
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D2E23D7C6;
	Thu,  9 Oct 2025 03:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SHidlbKN"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E41245022;
	Thu,  9 Oct 2025 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759981749; cv=fail; b=YmKhSv/PIUbLjuQ+DGaiqjL52n25aa+vt+0pSD/IG0OMUefAvtjr1Ryh3Mdrarp136r3hYPSt7l9+f0LzM4o2uzrAKl6j/02fVgiV1PhUzWh256Sd6E4+9eLM4nviCBIfRsoVnql80hTOQWeksulShp9+79OGjrcCpsbGBXjPtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759981749; c=relaxed/simple;
	bh=75cZrqNLayxLEh6MIXBbMp56UatCqr2hni9P6KOJ/Vo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rUzQOQ7EfrN1H1jLTMaS/s3xC7bSBIotzDRLbGuZvXcSFik1Hf41RAdh19ItJBiaO9PFdknVzqocImkUXhaPhmKbl7zlwTyBF78lmDitb3NK2D+WOeSwdEN/hna/g7elcXn4q0wWWa8vqCZ/vEufb1q7YFo1V939ZURPp2s9/hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SHidlbKN; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cm79nb4mzpmLp3pvgkaupNzj8ISwiEELzx6xgasgMdhenwqD0G/ema4kv3+ASVwqk5DW9rx9ocdeMvh+PWNmbSYwaLMeSv/G/gRCbuAiMnwSl9Z7ZclE5UDQTlrDzbI1iWiFdaiXVaMyzQg4MrVsAlCgJXYSG4lVRGt0qLNVoMSUojqW2NrF0QMyfStLTKB+WYC5Q4X0RXwUQ3bc8Cz+C/UCQrmUTjHKBwvSw855aquT7rS2jzaVIdhaESs2146RNaprXQRqJeiK/bfHySEaj+rur5e0B17lrJ0yj/ylk3563xR6J5PARaRqW3m7uo5XGvG+PuC4MneMCD4DvO0gfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UKNO31PnXDDu24iKJgXJbyrbta8LohUN0X/i1jK9TE=;
 b=R4jIQDEK2hp7dDcbd7a4RzqgHUGbWUSjhDFti/Aan4YyVaG5TexFERnCEYeq1StBZDuSf0v2uriD/zuxH1tZhyennVGmVRfekABxSc8n6F3IKmY1w4x5irzGrvWb9DDv5oeAWFLZl9hlxqbYmg5OtfSWwvl09PsKak9wFUi+dnvwtwcSs444eY36skP4ySf0qiUHGgLjNR7QtDqraEtMi5aABTQn6KSdA+Zcytl7SUimR2A9F3Qz42C5JkziHguDJdvz5X3+02F12TqM+xsNva50hBpg1KLIqj+8XQzd9L8ZYWC+ahq20yGVMVVtGS1qR3T3H5Z6KOM0K0vDuF66GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UKNO31PnXDDu24iKJgXJbyrbta8LohUN0X/i1jK9TE=;
 b=SHidlbKNqMtUMZHreI4yQnQL9dNF3gNz3GvrskXNAqpPsSZafRcvCbsp+C+o/mDilgmKWlFg3lMTtsQoi6oTfiKalI05NxlMC/va/qnot4P/Ga7U18Q7gnu4d1ThdXgWdC3glZlaocroytbMH1+tM6+r6ieExlMSf3S3DO0uQWrGtArfgYZxgrwhtcawsPo40XViPfFGoUvthysesOAuK9oxSVj4SOQyvU2aZgCTWYQ/OjiW8DWPmS3fAtPp2xzV7H/AE9flgBc/PWLx/BVmSL8DzCGtmNBqF/Zk/lY4twHJjds1L+Jp/+WTEiZ1+jQqYqTUZxrk9RxswLjuyeTjpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10217.eurprd04.prod.outlook.com (2603:10a6:800:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:49:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 03:49:00 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 09 Oct 2025 11:48:19 +0800
Subject: [PATCH v5 6/6] clk: scmi: Add i.MX95 OEM extension support for
 SCMI clock driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-clk-ssc-v5-1-v5-6-d6447d76171e@nxp.com>
References: <20251009-clk-ssc-v5-1-v5-0-d6447d76171e@nxp.com>
In-Reply-To: <20251009-clk-ssc-v5-1-v5-0-d6447d76171e@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Sebin Francis <sebin.francis@ti.com>, Brian Masney <bmasney@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759981703; l=8820;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=75cZrqNLayxLEh6MIXBbMp56UatCqr2hni9P6KOJ/Vo=;
 b=2SqhEvNyzuK7N/5cZlCA2r9FufkYfbHj2sC24OHKGvcvfrufuh0rrOhuq0xXc5Sgve4+4a4HX
 CWOaDCLZM4LDeiHgiuhJ3D7ocZplGV6DCrPcA7osESmf/I7CySPsG05
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10217:EE_
X-MS-Office365-Filtering-Correlation-Id: 144a174d-7135-4a9c-cf34-08de06e6c7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emlEdXUwRGhiaG5vN2Q5MG1WamhIRCtHVnJ4NFdaTnhkRTBOOVAzZnd1TVEz?=
 =?utf-8?B?dEcvU2cyQ0tiKzUxTEU2ckdmQS91ZjRZMzZtdUtxWkpEcXhOSVFQaGI2REJ4?=
 =?utf-8?B?WTN2YitKVmpNV0MvN0hHMjlKTGpEcnFNZFVNUDJ6ZDB5WGR3aHl0Z2RrU1A5?=
 =?utf-8?B?OE5CRGNyZUpnbi9sQmpQc3crUC93Wi9TcWYxSDNFSUpKTklFVllLeDZiYWlN?=
 =?utf-8?B?QzlST0pDWjhJa1AranFwaFNyRnA3a0QrRGFsdVZ4UjRwZkZSeDBqOVVSdXRO?=
 =?utf-8?B?bC9JM2ZQZjFOZHowUzdBQVB2c1JsR01oMFg2Ukhsd0lBb2JrdUZMOW10MlpF?=
 =?utf-8?B?VHMxT1lTa2RKZXpCakI3UnlKTFNNUHdXcklmY0hva2ViQ2owVy8ycGEvZ1lR?=
 =?utf-8?B?V3phNm9WdkozcmRsZmlZRGZTQ2JJdU9NNW1NY0xKWjNneC9lMkxidFNEOCtS?=
 =?utf-8?B?USt0TzRtQk1qY3lXbWRrcUxZejZCZEdkTmQxTzN5MmZJdVJQS2tFcXJYczVI?=
 =?utf-8?B?RGRCQnNYWE1SalBLY1JNNkpIK0Z0VHVrTjZOOWt1bmJWVGhmLzJPMTNpOXl1?=
 =?utf-8?B?d3N5Y2UxS2dTVVhFWUdHVHhrVFNCelcwZEtVSFdvOWxJaXlRWDR2cjliaW9y?=
 =?utf-8?B?TTFTT0QvczdTRGJJTUFmYk5CODVMU1JKVUFrWERtdWlOQU9tN1U5MnNWT0RW?=
 =?utf-8?B?UWJTTkNKTFdhRnIrd0VVMDl5MHBOczUxQ05PU2FFOXdVUnRhODBkbXF0Q1Rr?=
 =?utf-8?B?QUpoRVR3T0ZFbXJ0NFlYazlBNVRobzBSeUlvc2cxN1I4SDEvZEdYWFBHOFl2?=
 =?utf-8?B?Y3BlSURHcUJEQkhySUJYSXZra2dSRlZ4Nk9ldERnY0RuenRFU2UvQlJHTHJP?=
 =?utf-8?B?QTFwdE9oWkRJbGd4ZUxuMkxCcmgyL0VJc0FCTnFUdWt2TkZyRk13ZU1nbmFl?=
 =?utf-8?B?Qk91eGJRakJBSjRFWHFjSHJMallzR25BRW5UQ0xWejlZL2FaNEJrMmthVTZT?=
 =?utf-8?B?NUc3VGR2N3pOWFA0N09hY1M2VDhUZXFoQlh5bS9jK3A0V3dSVXdhZTE5dkE2?=
 =?utf-8?B?VmRaQVR6UEdsbEp3cnY4dTFKbnJldkcwWW16Y3pTdzlhR28vc0Y5Qno1QWtP?=
 =?utf-8?B?NmExWVJ5YmxEbEJwV1JqcC92dzI2TTZOcVhzcWM5V1dXRmhiUkpGNXFWQk1Z?=
 =?utf-8?B?MzN1eVp5ZkMrTFZ5RGVyVWRZdnFyK2tUSm1MaXdXNmU5aVBNOW92dnFnOExM?=
 =?utf-8?B?UnMxOWJuS0ZyVVVkcDcwalBtYjlnQmw2TUJxcUQrNFFrdWlhZERRT1hvejAv?=
 =?utf-8?B?ZmZYRDRUaFFxR2NneVNCVXhTQTRKajFER3ozTFZKMUh5M0E4MjE1L3B0aWtj?=
 =?utf-8?B?c2wxSEJsblZqSFdnbEM1YWo3MTdaMTlpMDdid3RDcjE4Z1ovdXVjWHAyNXFv?=
 =?utf-8?B?ZXJHbmtDemU2Q3MzOWRaTGxqOHpydVJiUTVvMnZwYlVud25pSHRkeFVtbnBW?=
 =?utf-8?B?dnhOTG9ZV3k3UC9aUjNRYmdZVGhHaDhseXNBSEJsNTBuQ2tJSHVUTnFSY0FV?=
 =?utf-8?B?eVBocUFhZXZXVjhrc1NXZHZrVXdPbk9wSjdacVNNaHNPZXBoL1pQclkxV0Ev?=
 =?utf-8?B?dExKeDM5ckFQWmFsUkQ3bHZ3NnQ4WGdHOFNxVTU2QlUrUm1VOUc5K1ZWZ3dC?=
 =?utf-8?B?SFRLOFNvRWdJRGcwT1FndEYwVExoTnpOZ0dpdy85Y2l1bUt3UWZxMFdLbHp3?=
 =?utf-8?B?NG52YS96RjliUTVPcmc0YzI0eXFPWFhKdGJmeUxCb09iek9MMlVaMVk4SHNr?=
 =?utf-8?B?ZFZrUy9ySVZHbjNHSGFNTHFQRDNqTjhoaE1mUng0ZDBiNnI0dE1mdzM4UHhN?=
 =?utf-8?B?RnAxRUpQTGNrak50UVJycElackI1NnBJMUJDbklGd3drNFVhWVhmVk5sRmJM?=
 =?utf-8?B?Ynh0cXYrME9nZmQ2eXNHbjVzMXdzYk1PYURSeEFiamVxVDIybk13dlRwSSta?=
 =?utf-8?B?dkRjMVF2U3VISUNJSEN0bFU3TWVKUXVDeDlxd3lja1owdVBybE9WSEVlaEYv?=
 =?utf-8?Q?hkn5jW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzhSS1VhY0lMcjFoY3NhbzU4QzFJcTluRUVmU3dPOWw2RXBJZ0pqeVdPSnIv?=
 =?utf-8?B?bEE3SW94MEVELzAwNXFGMjFkWDVERFAvOEtCaTdEU1FITEVLbkMxNHZ4QjZK?=
 =?utf-8?B?ZGNkSVpZeDlOVVJ4YkIzbmVPcGNUclkwa2FjR1NobGlCS2JYQUNadmpaL2tY?=
 =?utf-8?B?bHhXb3p3MVc1K2VVR0ZpVVJLLy9MLzF6MEluM2duQ0dwM3hkaWdibU1iRW9j?=
 =?utf-8?B?M3NCV0ZrbjZLMHd4OTkzcTQ3bzdxZC9QU3RXMVM5RUR6cGxKT1pEajZLTFlr?=
 =?utf-8?B?bG9OWjBYOU93U3l2OEZLamF5SFd5b3MySHVZaHh5QnZaQmkvL3hSWDZ2VW5E?=
 =?utf-8?B?RE9XcEdGTVBrYXpkcXlRL1ROaGFFbXVvZCtwakhHU05CcXIwdS9Ha1dJWnJv?=
 =?utf-8?B?UHVrYjJQak1OQnRobU5Hd0paQ3lTL1ZkK3lqZzBUV3JaUTlWMS9ZMjlqWjhv?=
 =?utf-8?B?RkZNaFJzR1VWVGQxRytkT1BSd1hVTmFlNnJacTAvSTA5emtvQXU3Qm5EQTI0?=
 =?utf-8?B?djhzZFJHUVNnZjdOMDQwdFprT2NER1RZOVJOb1hmbFRQdWNiOWQ4cmxCMnNB?=
 =?utf-8?B?OUdZZzJOQnoyWDVlS1RpNGx1c2RXY3c1bHVScHU5eE5Sbm55N055cFJzaDJ6?=
 =?utf-8?B?TUlYY0JQN3hKWC9tckorOGwxeXRzamxnbEtzcUJwck1EaTM2M0RkWUtxSDBW?=
 =?utf-8?B?LytnaStnWjZaN2VQY2JXMnlEc2xSc2xSRlQyMHpUNnB3R0N6UC9hejg0NVdS?=
 =?utf-8?B?WUVxajhyYzVwem52N2JmaFdkZ01pMWtNOTdZRHhSU2ZUbk9VUGN2eEx5b2NF?=
 =?utf-8?B?UFJwZzlNUjhXS0NYTWsvdXhPSUlnSEJjU3hPMkE3K0Z0cUlKS255Rm95MmV1?=
 =?utf-8?B?NkpWWk10UkkzK2N0UGhxQlErUFJZU1lyRHJPRWFoQklxT2ZQTk5sQzJycHVG?=
 =?utf-8?B?MWZ0VHZIQnFubVBpdFZxeGRUdll1TmY5U01oSTVONU1SZGFhcVhqZDdnRTE0?=
 =?utf-8?B?c3lIMWc0Q3NtZ2FjSHoyZXgvNklBekpjL2FnL3UzL2o3Rkd1dGxxeWpyMmVG?=
 =?utf-8?B?TjBYK0NCNDk1VjR1VktJdU01ZjZaalR1TnhZUkpVN0diSzBPZmVCdkhnZUdF?=
 =?utf-8?B?VHRyS09kVThSRW5EY3QxbEFXYTBMV21IT1lMZmxjZnNDejRkTjRRdVd0WitG?=
 =?utf-8?B?dFhHdDErajNSbm9NYWhRekhpTEJlai9jY0R0cXJKZUJWUFVmR3ZEcGNMdGp5?=
 =?utf-8?B?REl6elFXYkJIVGR2Nmczako0VmNheVROUzJKdmxNdHppaC9VOEZMR1h5a1NM?=
 =?utf-8?B?dVRSYUJxOXdFM3pFY3VTVktxMCtwUWRBOUYxamM2QjlLSC9zVTh6cCs5WTAv?=
 =?utf-8?B?dDlXaDFkb2RJOEt1Nm0xQjBwZ3M2OXArSy9CRjlvMjlJMTlGbG5TT09aS3Bz?=
 =?utf-8?B?Z2xJZ2E3M3BZVitFTHJuUExtVEJvWm9aMzk2VnV2TTFiMG14SFhBSnpjWm1G?=
 =?utf-8?B?ZkdwMVMyajV4dzE4aTdqU0hFUVY4M0llVmwzRVNFYUVNSFdCbHpNY044a0x4?=
 =?utf-8?B?QjhQSS9seTltZW9UUCtzV00zVWJ3dlFUNTN0QXo0VEp6NzdQaExTSVpGOGhj?=
 =?utf-8?B?SkNpMEFIbDg4OEZmTmFLTFRscEJVZWFJTnp6bTN2SlMra2JrRDNOcTFaNVdQ?=
 =?utf-8?B?WmM0c3Y4QWVuZld6NW03dlo5OHdyTjFReVc3YStCUGk3OGloeC9rZEJMY0Ju?=
 =?utf-8?B?djVOYTlJZkt3YTBNV3NYV3FsRzNZWXkvWFREeTdMejRoemV5ZzVyTWkzZjk5?=
 =?utf-8?B?dVRnNlFCeXZobmI5cEs1dHZ6U281YmZpdlhmTzdzc1ZqUzd1cmxjNjdGbmMr?=
 =?utf-8?B?UkxUWjlsWHBlNmNWRGdCYWJmRjhmUXlJSHVIcklKWEcvQnJETEd5YzhFRldV?=
 =?utf-8?B?T3ErbnB4dzd1eTUyQzhhU2J6RzBvVlFmVTFaTlJROG9ucTZmdzNIN0FLNHpk?=
 =?utf-8?B?WTJWanM5VUJZNXVaWWQxQlNzMTgrS1V3UHFZSGVtWG5lc2RoUHRyNTRxQVR1?=
 =?utf-8?B?QVd3cUtpbmdvWURCNkJoOWZQMVNKekN1Mm5NUEVIbHB3ZzErbWtRK0p3dDBa?=
 =?utf-8?Q?ZRjUVdG2nZ21f4TRPT1YsVDBp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144a174d-7135-4a9c-cf34-08de06e6c7f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:49:00.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrfH/8okQA+Zs07JUaKZgzuHUZnF5KXLx2N2tYe6+h0aUTPy7d7kcTP+kJ4DCsJB5I8MQuZG4AHcwQGLyo3ujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10217

 - Introduce 'clk-scmi-oem.c' to support vendor-specific OEM extensions
   for the SCMI clock driver, allows clean integration of vendor-specific
   features without impacting the core SCMI clock driver logic.
 - Extend 'clk-scmi.h' with 'scmi_clk_oem' structure and related declarations.
 - Initialize OEM extensions via 'scmi_clk_oem_init()'.
 - Support querying OEM-specific features and setting spread spectrum.
 - Pass 'scmi_device' to 'scmi_clk_ops_select()' for OEM data access.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/Makefile       |   2 +-
 drivers/clk/clk-scmi-oem.c | 103 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-scmi.c     |  19 +++++++--
 drivers/clk/clk-scmi.h     |  11 +++++
 4 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 9e8c989b24be0f7cfdf2325c9b19d05e9d2a8eb9..fd54e2fe3c429362b93457d0e349e1deab2320f3 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -95,7 +95,7 @@ obj-$(CONFIG_COMMON_CLK_RP1)            += clk-rp1.o
 obj-$(CONFIG_COMMON_CLK_RPMI)		+= clk-rpmi.o
 obj-$(CONFIG_COMMON_CLK_HI655X)		+= clk-hi655x.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
-obj-$(CONFIG_COMMON_CLK_SCMI)           += clk-scmi.o
+obj-$(CONFIG_COMMON_CLK_SCMI)           += clk-scmi.o clk-scmi-oem.o
 obj-$(CONFIG_COMMON_CLK_SCPI)           += clk-scpi.o
 obj-$(CONFIG_COMMON_CLK_SI5341)		+= clk-si5341.o
 obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
diff --git a/drivers/clk/clk-scmi-oem.c b/drivers/clk/clk-scmi-oem.c
new file mode 100644
index 0000000000000000000000000000000000000000..0d7f4e423168f759ecf4fcc9e51324420e19f97c
--- /dev/null
+++ b/drivers/clk/clk-scmi-oem.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The Vendor OEM extension for System Control and Power Interface (SCMI)
+ * Protocol based clock driver
+ *
+ * Copyright 2025 NXP
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/scmi_imx_protocol.h>
+#include <linux/scmi_protocol.h>
+
+#include "clk-scmi.h"
+
+#define SCMI_CLOCK_CFG_IMX_SSC			0x80
+#define SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK	GENMASK(7, 0)
+#define SCMI_CLOCK_IMX_SS_MOD_FREQ_MASK		GENMASK(23, 8)
+#define SCMI_CLOCK_IMX_SS_ENABLE_MASK		BIT(24)
+
+struct scmi_clk_oem_info {
+	char *vendor_id;
+	char *sub_vendor_id;
+	char *compatible;
+	const void *data;
+};
+
+static int
+scmi_clk_imx_set_spread_spectrum(struct clk_hw *hw,
+				 const struct clk_spread_spectrum *ss_conf)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+	int ret;
+	u32 val;
+
+	/*
+	 * extConfigValue[7:0]   - spread percentage (%)
+	 * extConfigValue[23:8]  - Modulation Frequency
+	 * extConfigValue[24]    - Enable/Disable
+	 * extConfigValue[31:25] - Reserved
+	 */
+	val = FIELD_PREP(SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK, ss_conf->spread_bp / 10000);
+	val |= FIELD_PREP(SCMI_CLOCK_IMX_SS_MOD_FREQ_MASK, ss_conf->modfreq_hz);
+	if (ss_conf->method != CLK_SPREAD_NO)
+		val |= SCMI_CLOCK_IMX_SS_ENABLE_MASK;
+	ret = scmi_proto_clk_ops->config_oem_set(clk->ph, clk->id,
+						 SCMI_CLOCK_CFG_IMX_SSC,
+						 val, false);
+	if (ret)
+		dev_warn(clk->dev,
+			 "Failed to set spread spectrum(%u,%u,%u) for clock ID %d\n",
+			 ss_conf->modfreq_hz, ss_conf->spread_bp, ss_conf->method,
+			 clk->id);
+
+	return ret;
+}
+
+static int
+scmi_clk_imx_query_oem_feats(const struct scmi_protocol_handle *ph, u32 id,
+			     unsigned int *feats_key)
+{
+	int ret;
+	u32 val;
+
+	ret = scmi_proto_clk_ops->config_oem_get(ph, id,
+						 SCMI_CLOCK_CFG_IMX_SSC,
+						 &val, NULL, false);
+	if (!ret)
+		*feats_key |= BIT(SCMI_CLK_EXT_OEM_SSC_SUPPORTED);
+
+	return 0;
+}
+
+static const struct scmi_clk_oem scmi_clk_oem_imx = {
+	.query_ext_oem_feats = scmi_clk_imx_query_oem_feats,
+	.set_spread_spectrum = scmi_clk_imx_set_spread_spectrum,
+};
+
+const struct scmi_clk_oem_info info[] = {
+	{ SCMI_IMX_VENDOR, SCMI_IMX_SUBVENDOR, NULL, &scmi_clk_oem_imx },
+};
+
+int scmi_clk_oem_init(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	int i, size = ARRAY_SIZE(info);
+
+	for (i = 0; i < size; i++) {
+		if (strcmp(handle->version->vendor_id, SCMI_IMX_VENDOR) ||
+		    strcmp(handle->version->sub_vendor_id, SCMI_IMX_SUBVENDOR))
+			continue;
+		if (info[i].compatible &&
+		    !of_machine_is_compatible(info[i].compatible))
+			continue;
+
+		break;
+	}
+
+	if (i < size)
+		dev_set_drvdata(&sdev->dev, (void *)info[i].data);
+
+	return 0;
+}
diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index bf85924d61985eb9e596419349eb883e3817de73..1ed2091e3d4a951c8662db4c94dee4b9c98b8326 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -14,6 +14,8 @@
 #include <linux/scmi_protocol.h>
 #include <asm/div64.h>
 
+#include "clk-scmi.h"
+
 const struct scmi_clk_proto_ops *scmi_proto_clk_ops;
 
 static unsigned long scmi_clk_recalc_rate(struct clk_hw *hw,
@@ -242,6 +244,7 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 static const struct clk_ops *
 scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 {
+	struct scmi_clk_oem *oem_data = dev_get_drvdata(dev);
 	struct clk_ops *ops;
 
 	ops = devm_kzalloc(dev, sizeof(*ops), GFP_KERNEL);
@@ -288,11 +291,15 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 		ops->set_duty_cycle = scmi_clk_set_duty_cycle;
 	}
 
+	if (oem_data && (feats_key & BIT(SCMI_CLK_EXT_OEM_SSC_SUPPORTED)))
+		ops->set_spread_spectrum = oem_data->set_spread_spectrum;
+
 	return ops;
 }
 
 /**
  * scmi_clk_ops_select() - Select a proper set of clock operations
+ * @sdev: pointer to the SCMI device
  * @sclk: A reference to an SCMI clock descriptor
  * @atomic_capable: A flag to indicate if atomic mode is supported by the
  *		    transport
@@ -317,8 +324,8 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
  *	   NULL otherwise.
  */
 static const struct clk_ops *
-scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
-		    unsigned int atomic_threshold_us,
+scmi_clk_ops_select(struct scmi_device *sdev, struct scmi_clk *sclk,
+		    bool atomic_capable, unsigned int atomic_threshold_us,
 		    const struct clk_ops **clk_ops_db, size_t db_size)
 {
 	int ret;
@@ -326,6 +333,7 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
 	const struct scmi_clock_info *ci = sclk->info;
 	unsigned int feats_key = 0;
 	const struct clk_ops *ops;
+	struct scmi_clk_oem *oem_data = dev_get_drvdata(&sdev->dev);
 
 	/*
 	 * Note that when transport is atomic but SCMI protocol did not
@@ -350,6 +358,9 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
 						 &val, NULL, false);
 		if (!ret)
 			feats_key |= BIT(SCMI_CLK_DUTY_CYCLE_SUPPORTED);
+
+		if (oem_data && oem_data->query_ext_oem_feats)
+			oem_data->query_ext_oem_feats(sclk->ph, sclk->id, &feats_key);
 	}
 
 	if (WARN_ON(feats_key >= db_size))
@@ -407,6 +418,8 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 	clk_data->num = count;
 	hws = clk_data->hws;
 
+	scmi_clk_oem_init(sdev);
+
 	transport_is_atomic = handle->is_transport_atomic(handle,
 							  &atomic_threshold_us);
 
@@ -438,7 +451,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		 * to avoid sharing the devm_ allocated clk_ops between multiple
 		 * SCMI clk driver instances.
 		 */
-		scmi_ops = scmi_clk_ops_select(sclk, transport_is_atomic,
+		scmi_ops = scmi_clk_ops_select(sdev, sclk, transport_is_atomic,
 					       atomic_threshold_us,
 					       scmi_clk_ops_db,
 					       ARRAY_SIZE(scmi_clk_ops_db));
diff --git a/drivers/clk/clk-scmi.h b/drivers/clk/clk-scmi.h
index 6ef6adc77c836dc2d599ff852cdc941f217ee388..d7f63f36c56d155f728325efd6bcf7fe2585b170 100644
--- a/drivers/clk/clk-scmi.h
+++ b/drivers/clk/clk-scmi.h
@@ -7,6 +7,7 @@
 #define __SCMI_CLK_H
 
 #include <linux/bits.h>
+#include <linux/clk-provider.h>
 #include <linux/scmi_protocol.h>
 #include <linux/types.h>
 
@@ -19,6 +20,7 @@ enum scmi_clk_feats {
 	SCMI_CLK_RATE_CTRL_SUPPORTED,
 	SCMI_CLK_PARENT_CTRL_SUPPORTED,
 	SCMI_CLK_DUTY_CYCLE_SUPPORTED,
+	SCMI_CLK_EXT_OEM_SSC_SUPPORTED,
 	SCMI_CLK_FEATS_COUNT
 };
 
@@ -37,4 +39,13 @@ struct scmi_clk {
 
 extern const struct scmi_clk_proto_ops *scmi_proto_clk_ops;
 
+struct scmi_clk_oem {
+	int (*query_ext_oem_feats)(const struct scmi_protocol_handle *ph,
+				   u32 id, unsigned int *feats_key);
+	int (*set_spread_spectrum)(struct clk_hw *hw,
+				   const struct clk_spread_spectrum *ss_conf);
+};
+
+int scmi_clk_oem_init(struct scmi_device *dev);
+
 #endif

-- 
2.37.1


