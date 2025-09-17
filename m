Return-Path: <linux-kernel+bounces-820262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A0DB7D47E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71A616C682
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A5030C372;
	Wed, 17 Sep 2025 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PVj92cXg"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4F302770;
	Wed, 17 Sep 2025 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098554; cv=fail; b=PCnIeQNuMVQ3ID6M3tD6IF8fz8+0rzLIjNrtzeylyb0WLShkpbfUVb+iRd8/TzBTHtcgFyuxR899989Zmw8WAhG1Z4oy3NRnfd1Kz6JENXo4ItsfQGZsA/pBFepKK233cdyhZHGnc9oA2Gf5DUkxAri7QaOPQBRvVOTa07OS6a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098554; c=relaxed/simple;
	bh=2JfKTHYKNdBLxyzyO88b5TwgO1+7n3SV/6ra+d3eXpY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=j5eSTqJf07igPR68v5WpInfONMfuFsxCfykSiIlUERMMKRbY9IS5Aq3UMz/6AjhjFJvMujddI7ZQUDE01KmcUCY5dhUlLVXC6LJs6Yq7jGlbfRmAC6wWDU9ae0lwb9l4RiimfZhmFa67Pk0irzDLmTPRwVDXb/Fzk3BgSvCFeJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PVj92cXg; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSWa/8TTIDIIrFFXe4V1vcwdZrVqDZa9YEJbaI8OCwyPs4tlWJiuKmfUq6ogMI7yKyM20Nvy6DqfG8/ujtfa8qXr7WPiTgTB8zKZy5Vl5EC6Gnh8Wf8PuHdcgUCj5jCdzdaR77tQigjDLoP3dCsz6++v43E+QNUjQUtMXECNRIyKiBH0BJkwBVR8mKDKWGGS167PUPu3t8QPM/SQc7v0j/QvGaQuIOLlVkFEgO/tZxNYiOqqXOLXaYLpmLD9PA8eISJGd6BZxXpAPgNFTkyUxA5+I1cdKZauVoZUmLsaGF7x7WJR8UML423fi7ASESQ7NWkWhqZvH9hf2xvZrx3tFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6ay7DQkRGrBz14V1gcLFnEQCx0dw10gz2AGrITdTRk=;
 b=wGSCunkUZKlHzDGC3v5CW9HAs7IfKHE7/+hazJv46/MgMLEjUrDwXsyidopsSQtiCvkQT5nNJVar42gINcqNDCzCS5epNlBfFAnHM3ORa9FKO+yYd494a82V7h/3FfcprQYSnX1sXB5vWWYHDQclRBDnb5zEO2Xun1ncJqdQ5neC1pPl1jUx2swLlPaJJwgut0yNqo1UBkbiwCzWlwo19KqGSTrRZRzAJh/A+B9xqKYOaWd88F5O/x3J/ABuGRipEn+gsB5lXcy4YKrb+5PkKn1FFBmERQNig3XJ+1EvWVPXmZWoBml4c3y0gPmGem+h53QCWEB1+LSjSCoCCHXmJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6ay7DQkRGrBz14V1gcLFnEQCx0dw10gz2AGrITdTRk=;
 b=PVj92cXgTUdSe85ipGKJ1GttWj7ILZP5rsydh7aXm1SHyy8jh+5kA1Sg4vLuVfuBYzHDQq9zeGQLBCvqucQVxjIa5TRQoZuCsqabtcuwGzNZGaOue8OHxACEZwljBWyLUkOdpnPvG03CfzIAJpq89QhryQ8bLbjvyzK/OSCiqQL5f6KbUARX1GxmKDDUHm4wILCBI8oVPSScLD42aQ3rhHo8fR6nLAa0vglxzrQqna3ClQfCg2I9yNecmLbOIqVIeA/HtbMaM0+J0JFb5nvAsOAMASl6Ydh5bf73yy1tQSay5E4PjDdoeWJq/y15QdAiCkVdPUDH+BGqyCAO/YTgug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10818.eurprd04.prod.outlook.com (2603:10a6:102:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Wed, 17 Sep
 2025 08:42:28 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 08:42:28 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v2 0/4] few small change for flexspi setting in dts file
Date: Wed, 17 Sep 2025 16:42:26 +0800
Message-Id: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJ0ymgC/22Myw7CIBBFf6WZtRggBVtX/Q/TRR9gJ1EgTEMwD
 f8udu3y3JtzDiAT0RDcmwOiSUjoXQV5aWDZJvc0DNfKILlUvBea2ZfJFJCtOzHZTrab9Wxb3UE
 1QjQW81l7jJU3pN3HzxlP4rf+7yTBONNC6ZvtdT3V4HK4Lv4NYynlC3miPcukAAAA
X-Change-ID: 20250916-flexspi-dts-24af8b6bf468
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Michael Walle <michael@walle.cc>, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <frank.li@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Han Xu <han.xu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758098561; l=1253;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=2JfKTHYKNdBLxyzyO88b5TwgO1+7n3SV/6ra+d3eXpY=;
 b=qlnlxnL98HDTrHRoJwIXhI+QIK6UKg3Sm4jhqIPbP1LzSF/MZ3NqHNUAVXyA3UZBn/zYZDt8p
 XPPNz0U8+tGBJZRMUmiU5X4eDixxGSzDGlU/1/cxNabTJDo1638H+8k
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA1PR04MB10818:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e5cb0b-463e-4069-d4cd-08ddf5c621f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDc3am1YTnBDejRGeWtOakUwN1lGZUpUTkV3ME5ScTJ3b1JBaXh2NzdzbVEz?=
 =?utf-8?B?WjBDSGJnNlhsN0ZyOWlERDBQMGkrSVYwTzk1N0FZa25RdkFWL2dhbHhtUlJE?=
 =?utf-8?B?eDk5RjloUHRsUHZvb0M3QUNBOHlkN2tOUjFqbFZEbW8xZEdZbGw3VTdRN2l6?=
 =?utf-8?B?c3pLWWZsbzNWSlNwRGFxSDA1Y0J0OUNYL2FmdnNLSjJNaU01NU1Kc0pSa1U1?=
 =?utf-8?B?SWt3Uk9qZWl3ZGpDS0RlUDEvUk53S2RoRE1yMXNoUk5mSnZPY3lOaktoTUpx?=
 =?utf-8?B?RkdqS1FSVlpZOUdMR09MUzRTc0ZSQUZRay9taDBobTJ3K2dHZmI5QkhjSFNx?=
 =?utf-8?B?QUh0c0hLOWVlb294T2dZc2Y0Nkg3QTdmR3NhUC9RaTNLY2Joanh6MHlNU05j?=
 =?utf-8?B?UmlsT1BkKzBDdTJtak1aeUt2MFVsMkZjSkQ0SnlWbVlrbUwzMmIxSGFIM2E1?=
 =?utf-8?B?aXhqQ2xJYm9VRnNqVjcxSlNYRSsvV3N6MkNEMWhYdnVvRFJSL05TMEZQUWlF?=
 =?utf-8?B?Nyt3MzBnNHBrd3lSVmRxV2hXelJESDVkZHRXdk5YNXZ3SGloUHk5UTNkN253?=
 =?utf-8?B?Y3NpTzBtaG0yU3MxcVY3Vmh1TzFiU2tLWm9VeWZDSGlwNUNQSkUrUHJpeTBL?=
 =?utf-8?B?cDdtbWtGNk8wRWluVWxmdE5TV3AzY3M0ME5Ed1hWZzI2VGZaUzVWR3huWFQ0?=
 =?utf-8?B?djViUndzT0NwWFM1dVhoWlBqZkxWVytBQjVJSWZyQkhCUW9WNFViUXlDdks0?=
 =?utf-8?B?eCtqQncrUGVOYkNIT25SQ0M3TE5QTEVpVy9MOHFYSVE4eGJBdlFQZVVydkpm?=
 =?utf-8?B?RmpqTklkRUlaeXk5OUZzaXFyV25nZ1gwd1BkYW5Lc0pYM1pJWGE5eTZvVy83?=
 =?utf-8?B?TS9UMFBKbmo0c2lHWGUzL1JWTmgyaGgwQVJZK213TW9ZZ3VLQ2YyQmJpUE56?=
 =?utf-8?B?Y0Q0RHRHZHFkbzJYaFl3YTUrNUxvTTI2WHlqMmVIbDNNejhWOFhWRWp6MHlx?=
 =?utf-8?B?Q1BUYWhiVUlzdXVRR25tdFFyc1ZlcSt2V2NScjRYWnVhTFZpQTh3OGNETWs2?=
 =?utf-8?B?TnhENDN2bXpuN0cvd2xYT2FBTUcrSDIrWEI1Zk1USGJPUUw0ZFV0blVaK3Yv?=
 =?utf-8?B?VFBvT0t2d0duMVBDV3pYL3BmTktqSFBEdXc4RDhWYVNqbjJjMzlUYkF0c2g0?=
 =?utf-8?B?Sm9ZOEhOdVBjZjUrWEhlYkFjUGxKb1RTVm1XYUZsb05QQVR2clc0QWlmU2oy?=
 =?utf-8?B?dk9QbE03dUdEQjk2Y2lheENMN1l3TUVyRXZ0NmhUSnI5RTBSNTQyZG5yMC9v?=
 =?utf-8?B?ZXVBSWFOeEV5WEc2b285RVgwQ2o2V1VIRHRwMkxaYlJ2MkcvcFhPM1duRGNs?=
 =?utf-8?B?MkU2U1JJVlBKNUJDdmVHY252d28vSEVZenlTaHFza0xKQ09nRW1PZ1ZYblNo?=
 =?utf-8?B?TCthT3pwMUFMS3I0WmJjSTVKNXFacGRsU0hhR3JVN3piUWZ5dFNqNWpSUEJi?=
 =?utf-8?B?MGVPTVRHYkhRdTV4ajdvVE54MGg0N0k2ZlVhSVVXM2NhL2puSStPeTNwOUJL?=
 =?utf-8?B?YVpFNklWdWJTMngzbkt3WTc5TXcyS0NldzhoREM3d01nSVAybmFRSGI1emFa?=
 =?utf-8?B?M1NoajNwZURqZ21UemE1cjlwSzFSMkRnQWNNMFgva2VYTE8zZmhzVjNLODdX?=
 =?utf-8?B?ajNGY2lXMFphK0oybXZKSkptVldkNTFyRC9TQ25qSGhTcDRxa0tNbkNHUmFF?=
 =?utf-8?B?MlRrUktuTlhJd3NISGQyYklNd0h0dlFRN1pyWFV0cGltSVhTdjJHTjlwSGph?=
 =?utf-8?B?dUpEdkNabCtWM2dNYlJpYTJFdWZpZlU5SjNFMTI3UE54bnNmcnRINmYvWHJS?=
 =?utf-8?B?c2dGZnZnYW5nQTc5K1ZOa3NXTWRJdFQwVVR2UHdRRmRXOEJRNE1PQUh0cm5J?=
 =?utf-8?B?VGlqY0lYSVhlb3JzQmZ5aktOcXdDcUVnaGUxYU5GbXNDcEg1NTRRSGxGTkw3?=
 =?utf-8?B?Tkovd1I5NVNYRnYxZTRxYThET3hua3dUdVlzbUU4RXFWaTU2MjJiWGlZZHgz?=
 =?utf-8?Q?3yiGYX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnNFTlhzdVBNaTFUY1k2eWYzcjl3eDFIY2IvdEg4aFBXZVlaUGljSzVveUo0?=
 =?utf-8?B?Q3pWbS90MG92M09uc09pKzhQeXVndVRzQjRCWFRFVU5sSUtsOWdZcjIyTG4v?=
 =?utf-8?B?cmhTWlZ2N21TOG5ZSFpHTnllMFU4Z3hERzIvdi9XOVBTakU2SHRUT25QcmRY?=
 =?utf-8?B?b0M5dkVYUmh0c3VHTm9ydWV0T1VHdmNYSUJ3VjRndUlCSGhJRDJuUW9IUWtW?=
 =?utf-8?B?OGIzRGd5WlZObUZadjloYWpqbHNtU1NORGpZbWZ4VjArY1MvOGtpalJScUY4?=
 =?utf-8?B?Sm9Yc3lpa0wvcWVvWDdxdlFHOURGa0ttWUY5L2VEb0hpbUFQRUk2S1dHRmJm?=
 =?utf-8?B?WnJ5eHpjSllMd1BRZEh2Uk5uaTljamsyakI5blZodUwyc2lEa0xtVDNlVkVs?=
 =?utf-8?B?Vm5DK0FIY1FyMjNDeS9WRXlPeUZPQzNpUlBwMXZMWHBZc0FSWS96UFZmZW93?=
 =?utf-8?B?NVNLV3I3ZmthTm9mMG5zck9YV2hzamo4ek96RElmSTJ6Snl2MVVJWEVXRWsw?=
 =?utf-8?B?Y2I3L1hDcFFLZTNSRlMyNlZXdERXUm0zeE9LaUhLSlZXZUZ4YTlHZGx1RXFV?=
 =?utf-8?B?YnpQUHRvN2x1UjhEbHJqMnozNElXRldCMVoyZ3FYcFcyMVRNNlArQjdYUHB6?=
 =?utf-8?B?S28vNWlOZTYrU202SnZTK0t1M2txeG8raWs5VEN4bHFLajZhRi96WGd3VG9t?=
 =?utf-8?B?Ymt4Q2F1cW9taHZvTDV1eUlKNUtsb0Q1YStudUQzRmx1dnVtNjl0MnUzOCt1?=
 =?utf-8?B?ai9EdUl6a1lUejQveG5BVFV4R1NIRktFcGtuMENnUkNLNXgzNEZlUk9lZUZ4?=
 =?utf-8?B?YkErSUJpUWJEaVVLK1lUU3FncjR6V1YyNE02Uld3eC9uQ1dzWW5rRGkrUlh0?=
 =?utf-8?B?WjcxMVRrQkh6c3hndmY1c2hZU0RSbzFOMFRoeldRQ2JVYUNndWFESml5dGZw?=
 =?utf-8?B?VHFueVlCZldZdTNWTVh1NVpyUk5YRlFFQU1KdmZ5QkRHVmVUeTZFOXB6MXY3?=
 =?utf-8?B?bk8vamNxa2dIMmlrRGI3LytTanlGYWczV0NjeFllVmZYamJoUGp1RFMxNkxS?=
 =?utf-8?B?R2xEUkQ4UEhlVnVUcHM4R0ZXVjNyUWE0VkNRQ25rQ012ZzdNOU1FbVhkT0tu?=
 =?utf-8?B?QXQ5R3gzcllDUmhCR2EzTmREdlBpUDdmNUlUYmN1WSt5Nlo3cGhVUERzOXI4?=
 =?utf-8?B?ZzJ1SFJTN09qVkV3ZllaVCtqNXUyVSs4NmZFOE9BVkZZSXhualcvT2YyNVBS?=
 =?utf-8?B?UldIeUNZSFZxOTFxRU5aelFxUmpmanZUTERrUU5NWWxrTkJtZjdwWnpXQ1gr?=
 =?utf-8?B?NGc3dTBPZTVVWmdIb3BBMUJiaFZuN3NsdEU1VUl0d25aMmpPZ2NYdXhlZmE1?=
 =?utf-8?B?em0xcDhlMzVuejhzSzJ4OTkrS256MGhPMmZOcUdGU1NBM2lCK1RITDg4YSt0?=
 =?utf-8?B?dHRScTBYTjN4dEZXYmNBdXdoZFBhN1NBNWZxbmJ1K2hFVmlnSlF2UDRxekcw?=
 =?utf-8?B?c0UrRlhVZnRvYXZmM244V2Y5c25yaVJoM1UyeVlkbWxFVEJIS2tiRzRjK3Yz?=
 =?utf-8?B?NlpNbytBWnV6MWs1YnhibUNBaGFZaGJrMmZ5djhneU5vQmdia0FvYm9vZkUv?=
 =?utf-8?B?endWVGo5T3dTR3BWSU1idnp3SFBaS0F4UTlwRFdORUkrUDEvclJCYityQWtY?=
 =?utf-8?B?UU9Cc2tXVjRTdFRtTy8wOGtqRUc3WDR2RTZ3WnR1MlAxcktGV2cyY3BHQWo1?=
 =?utf-8?B?YmFpQnBxWEU0Y0JvZ1d2bGp3NFZrSmxQU1BwQ3Rwdm5pSDNnWFpzRSt2N0tN?=
 =?utf-8?B?d2RhTStNamNIYnJSMTc0THp6Mm5mMEV4Zk1Xamk1ZDkweUFzMTBLQkRzRHIw?=
 =?utf-8?B?eXgvK3NaTndoaXU0V3l0S0V3cmUrRlJZQmNYZkRKd0p3NkhwRmVuamdOVXVE?=
 =?utf-8?B?OVpYYWY1UWp0b0dacTZhVTJHRU04TGFsbFBRdE5LQmg1eHJEZ1lNYSs4Y0do?=
 =?utf-8?B?U24xMDB5WEtvWmRDcGpUNm1xeDhRMzVhcy9CZXFQQmplaGlDQjRkcmp5MUxs?=
 =?utf-8?B?VDUxNHBIamdqTTBwNW9JN1hNQytRUG1XakFXNlQxRDJoZU5pSm1KWDBMSmk5?=
 =?utf-8?Q?QOo8sfAEux8rE129HhbZcUdaL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e5cb0b-463e-4069-d4cd-08ddf5c621f4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 08:42:28.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPPxEnFfMKMAGLVGz4UcW4yvBrWK+IH8+rQmpxxr2/G0dHbEcucn/z5stvlR9iUNSvmV1H2mAKrjdOmwOCnVkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10818

PATCH1 adjust the compatible string to align with yaml
PATCH2/3/4 limit the nor max frequency accroding to data sheet

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Changes in v2:
- PATCH1: small change of the commit log according to Fabio's comment
- PATCH2~4: fix type and split into 3 patches and add fix tag accordingly.
- Link to v1: https://lore.kernel.org/r/20250916-flexspi-dts-v1-0-61567f969165@nxp.com

---
Haibo Chen (4):
      arm64: dts: correct the flexspi compatible string to match with yaml
      arm64: dts: imx8mn-evk: limit the max frequency of spi nor chip
      arm64: dts: imx8mm-evk: limit the max frequency of spi nor chip
      arm64: dts: imx8mp-evk: limit the max frequency of spi nor chip

 arch/arm64/boot/dts/freescale/imx8mm-evk.dts       | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi      | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       | 2 +-
 arch/arm64/boot/dts/freescale/imx91_93_common.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx95.dtsi           | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
change-id: 20250916-flexspi-dts-24af8b6bf468

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


