Return-Path: <linux-kernel+bounces-772692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73190B29634
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C400A20470B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B905E23505E;
	Mon, 18 Aug 2025 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Op5c79jU"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1894E23A9AD;
	Mon, 18 Aug 2025 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480387; cv=fail; b=qgixsYR4NgDBfc0nTMQLPjdBuYiRvK2UDCz3B/7HopAeGpfo/leVICbMqwCXHCIG0TlN0enaAy6d/tA0SIcfvHJc3WEGgATs35NbyinNO5f5LyJYGF5qEvAYp9kRyxY8F0tUBASmeu/EVYEfz5xrWhiMKJGCbBzcyKBEa9czP4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480387; c=relaxed/simple;
	bh=mpqalh8LbRfjlxazhHEvIQXrwkoj227LtQ6M7E6bZDA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gXyTBoBo7OCHOglPAILL1qmhkXMkOS+/KqcQ4223MJ4QS1kjipyRnyEX8VntzZ4hBM2o5PvAOB+278rbYvGVIx2MWTMql/0mTa00svo3a3aOMOGIlVVOapF8t3DkWgLgQxr/PdzM8QGNjoV7bKBMFq3IOaDfk7XSrAIQxWm0FUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Op5c79jU; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMKXzz5FAlZnIq4L4fsuLbr8rNuMoW2NwYxw2YHOya8kNfmybgeVoior4clIURHWh7VQyyYEcPPSuwxUWZd8F9TTZftxO1Y3ujeKrr7DwQQW+ph0RvSNHo9Ju1J5IMidc7PHqQVpalaKlTtNlJeMaRq6UpGya+uiYn4/UeZtF4jnAvoc3A1LkF4Wb57s9ir1QCh++pljp9ZZww0zAZ+RRzIRQoWUYsH+YX3qOvUwez6Ikdh8YxJcVD9vyOmtCmRoJ+S7JZ/SR2j/RC6Qv5QTC1GWa6o8iQ3PCHlbGdntMr0KSNDIh15NNc0IZTVVx/8/AvGo2NEc8HGylkTPYWafsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBKcbVa7pVq2WN4TcOoMvxxV+Kspe8fy/s4YymJdGPo=;
 b=EtIu4KvtqLky7ZjG4/oZgszfUg4mQD85IbkLxsmrIIwZb1I+eLJQTa7avnNA5IwO6R9ekABdc+q8uyWlbvFsIn+PavDZhoZImsUFHpFffdMtjbViwTKrX4dJkoGPBYqcmg72AKTawV0H9QBfQl6rexWvlyn28jGmhqFA+fnsCOHFaJPOuK4Sq4QtRKSvYc0n1lT8xxgAag6a9aL3MPGTuUcm4VTJU42yy+EzSS2UftZUitQr2/lJR55PoFv/dGq4+LRQpCuPUrQ2QJUnpMkhUduVb9/25L5XBKLAFsKRuaYsyFtyYZAM2FsGHYqMxKO4s1T1I1XGLecHHjnu++e7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBKcbVa7pVq2WN4TcOoMvxxV+Kspe8fy/s4YymJdGPo=;
 b=Op5c79jUaQE8NuNnvrwMsyecmgz2f8xby0BU2meEDy23uzyu2Arlfvok2UYKnt5zCUP3lJoCXDU45o11QLZ4hH7Fsq7tzh89va9xL+ZJnU2kMnZNkJATDwu/ELmaH9So1a8iJzvwUbZDeeJ3bw8yQao0oLp7hrZkxRC1isT9cEbbTUk6gGB1cOpNVbkNgLHyYwslKMLf49iZs6sIv7YujzjcAKG05tQnrDQXdOLv1weVdNFhRSeS+5FjAIIlunVVCQ8HPeMvOZsGkC6xqg49lL/ENDy632lLDfFrLSWKacKeN3CySsT2miyskUrUKt0Jog36BspqnZ2snmdQDfIy6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11530.eurprd04.prod.outlook.com (2603:10a6:102:4e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Mon, 18 Aug
 2025 01:26:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 01:26:22 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 18 Aug 2025 09:25:38 +0800
Subject: [PATCH v2 08/11] arm64: dts: imx95-19x19-evk: Add Tsettle delay in
 m2 regulator
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx9-dts-v2-8-8ba787fb5280@nxp.com>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
In-Reply-To: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755480344; l=1300;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=dU0p2TJ7f2Wb6ghgzYMa6igBObZC0Br2korjCseD7is=;
 b=ZSiV3smYDnXnnmtqi2auL/5CmY0qp1GqBROVLSfatCVv7XDs9ZfN68hBZCWex7PaW1lOo3cTK
 cDAz3U2MKkSBZItReEir5mrXGYTdmK4A2BhBYWPfR4KUR1tJ3jBowBd
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB11530:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0b62f6-a229-493b-aa13-08ddddf63d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enJUZERBbk9od1hzbVlheW1GSy9PYUkyZzJPbTNPdmw1QnZ5cWJaWTZWSngv?=
 =?utf-8?B?Ylk5d3BSRWtuUWR1RVJkTFE2M0t2WHFKSTA2UThHcE5pZ2R1QnlGdkM3bXBj?=
 =?utf-8?B?VHZndGhYNCtLeEk4eEdiWnZxNmRuY1QzSkQvTGNySUJXOHZQK0w0dko0bGhM?=
 =?utf-8?B?RGdud256czhKKytwSUJoQVV3K3ZlZE84ZDJxVHRPUCtKUTA1OFVaODljRWR6?=
 =?utf-8?B?ODF3eTMxTFFaUHVmcnhqUFRTWENKd2FxaFU5Mjk1cXNQdElpci9RZ1NHN2hn?=
 =?utf-8?B?R050UCtlbTFOUDlIYTRWVFlqbnZ3eGJPakVBaUVoOVlSdHNzdVpZQ1JPeURL?=
 =?utf-8?B?QVJqVk9KaWxISXRlWjFNelNoK2NSYjBqQXJNb1VSQ2FXbzZsd3ZVVmRJY3VG?=
 =?utf-8?B?c2FkOUNUWU5HVGN1dzE0Kzk0dFFlUzV2U2JxaDJKdzBXR0cwZDgzVkpNeWhF?=
 =?utf-8?B?ZUNzeUZlZnlIcjYxNWc1ZUpkOFhZZk5PUHlSaFRHY3k1TFZLY1U2ck9mTFMr?=
 =?utf-8?B?SGdyMGtUQzh5SlU0ZnNvaVZuR0NjOW1GbnhzZjFSdkN5UGRTSFRDMmEvMmF4?=
 =?utf-8?B?LzlRUE1uZXlkQTVZa2pzeG50cEFxQjQrcytYSEs0UE9YeGpFWTNnUjVONFN5?=
 =?utf-8?B?czJuUGFDR084VGE1RUJWS0Ztd3I4OEpyVTB1LzR2d3lMay8yL05mc09BTUtU?=
 =?utf-8?B?bXJaRStUemhUZnh5TEd0RVVGajRWem9QUTBUeEhxL0l3OE00U3Q5aXM2UE9E?=
 =?utf-8?B?YlA1RHFZYWYyN1l2MzcxQk5wUG9lR0pidStRdkpxZk9Qb2wvMEU2aE1MMTdB?=
 =?utf-8?B?ZWVqNmUwaEM0K3VqaDMzYUNlazcxZVYwdFVlNWV0RzZYODRscWJZRGFSQmsw?=
 =?utf-8?B?djN5ei9aZUZ0NEtQMFFKdlcwbzBtUjhDVWdua1BwakkrNC9LQU8vRkFsZUth?=
 =?utf-8?B?QmJPUHkvd250OGdoeFBKTXRSdkNUOUxBWVhzQ3g3SloxeFowRSs5elo4NElP?=
 =?utf-8?B?VmdNREJhTXRvVW9uemlJZ3VyTUtYeTVzNmV0c3lEN3RPMkFXcGZVKzh4R0F2?=
 =?utf-8?B?RDQ0cFRFdkp6MVZBNTNVQTZaM3lqTDJDUWRZZ3ZkeEtNMkkvNkNPN0l2Vmlx?=
 =?utf-8?B?M3U2ZjA5NDJWWFd3S3E0bGROaEpselplV01peXBrVU1mbWVRQ29oMlc1T09M?=
 =?utf-8?B?WDE2NytISnJObmRjYlpURVJ0eDYrd0RzT25qY1RQbzd6TWtNNGw2c0k0VjlH?=
 =?utf-8?B?RXpGZCsybm1TRmNTQWlUN2FpcUR6L0tXU2J0RnAranloWmZsUjVmR2lmTHlI?=
 =?utf-8?B?QisyUy9QL2l1K3NSZ2M3Si8xeHFtK3hoOE1VZitsWkJzSzBYczBFeWVURkhm?=
 =?utf-8?B?YTRRTWJ2Rk91aDFvenpFdi90QTl1UjJEY0VURERKYjh1SVdrS2RvRWQ5QUNY?=
 =?utf-8?B?bk5la2w5WitGdnBySFJPRENiUnlQY2haNEloZDduUzVpeWI5VGdDT1kvUDlQ?=
 =?utf-8?B?clV6RTRoMDI2ZlV3NkdKaXFROW9mTTRXMXhyRWM4dFNRanpNSVZGTFkwRTdF?=
 =?utf-8?B?UmZ4a0dNR1NPY2ppTExsVjNqN0JRUzgrWjh4K0dHMmtzZHgzN3prS0xNM1E3?=
 =?utf-8?B?c2lWR1lyQmJCTjlOWmJveGt3Qy9DU2VQMnpLS29RRHNUN1g5cHRpU3ZLSElp?=
 =?utf-8?B?UG9rZWFsZnQ1OERJQURRZkhXdThIZEs4U2o1R2FLZk0vWXUxV2dyWWJ0VDhF?=
 =?utf-8?B?VGlHUkwxbzlkV1c3ZkRTTklFMnJuNnRvTEtDTkJjM0VSK2c3QXN6OFVhQUEv?=
 =?utf-8?B?dXFwaU41V2JyRUh6eG4xc1k2VTVNTmIxSGFZUUJ0aHB4U0hIcXgrMFEzZitz?=
 =?utf-8?B?MFhXOWdqamxPbkJ1dmRlMVBMWmVRU0xuUG1RUTZHOVVQazEvV3VJcElGYTFK?=
 =?utf-8?B?a2daeStJMUdHM3V0RnM3RHcvRU05M09jTEFyd3NFZzJGNjR0MTg4K2dYam5S?=
 =?utf-8?B?U0Uxdmdwblp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmUvVXVSTGR6V2o1bXVGMjJtSGJWUUdJbjk0ODFVbDltNzNoNlNKQ1F5RnZq?=
 =?utf-8?B?b1lPaWFheDdOUWNxYmhVcXg3S25vcXpZdUt2bk0yUUpaQkxYSzJBY25qWEhR?=
 =?utf-8?B?VG5kYmQxemdHQlcrQkE4Y2Z1RnJxZUdIZk9KOC96V1dIZS92V3Fna2M4MVE2?=
 =?utf-8?B?ZXF0UHZSczJ4dVNNZDdwblpiL3BzTDd4UDRwR01FMzYrc2tRSUxXbm8zMURB?=
 =?utf-8?B?RkNBTzIwejlLeHdyVVJjWEc2ZVpDd1o3ck84cVdHbjN2cGthbXMyQTNRTDg3?=
 =?utf-8?B?YWNiNGFCaXpJbnAwc1VpWUtFaEtMVllSTzU4QUxNTS93cm5ST21FQWl0UGcx?=
 =?utf-8?B?TFJrV0xGb2pZYkEwNWx4Rkw4eCtkNjVPcnVvVmNORGdjTGxBbGpvRGx0b3Vh?=
 =?utf-8?B?L1crbGtIV01qaDlsblJld1cxV3YrUlBhUUE4ZlcwQUk3amoyU0xNMHpiRnNO?=
 =?utf-8?B?STk0V3dyRWRRRlcvWVVyQUlZUWRmeVd5b1p0blNyUFE4TkNBc0UzYUdVeWV0?=
 =?utf-8?B?QVZlUk5qQys5WlVPMXUxYWZkenRTbXpNNHVGT1B6UCtQdzB2dnVkUERNdkhL?=
 =?utf-8?B?SDNTc0l1bUN0NjA2L0s3Z3dsTnRFRGVaQWl3TE1BUy91bjZqMVJ0YjJGeDhK?=
 =?utf-8?B?SWZxSTJlaWNLU1dwY3M4K3JteFZNbnI5MDFjTUJUTzMyYTZWVG9KK25HZVJP?=
 =?utf-8?B?c2ZtM3hCWHNFRURGOW9Ib0VFS3AvWlgwbzdHU2NzTEZoMVJMNG9KTnlIYUtL?=
 =?utf-8?B?L0IyUHphcXFOaFlTV2NrRENQMCtjaVNIZ0xiaXFOTHl5WEllcVJKOTFXeTN1?=
 =?utf-8?B?QUtlWlZmdndhcksvZmZ2aFZoY2pQRDQ1YllqOE0vSURhZGk3M2d2alpGNGxE?=
 =?utf-8?B?T0VNRVVOOUd5MlE5OW5IMUZMM2gwaSt0RzZDYnNLTG5Tczl1TTZFeUVXaUlN?=
 =?utf-8?B?RFFUV3JZWlFEK3krVE4rdFRhVWpGL3Q4S04xVU9rdGlpZnBuVVMzclJoOWJo?=
 =?utf-8?B?NXdTeHlORjdOUjgwSDBpeERNZ3pGZjAwZkFGU3JSaWdMWXpGVUFBeTRnKzBD?=
 =?utf-8?B?VW14SjNSNjdUb0VqNS92ajdhbTJaUEEybjBUdTdvV3UrdGN5Q3ErTTJQMkY1?=
 =?utf-8?B?MHhOSzNsN0Fka1QvT3ZPSUcwTnJhVnZaY2hjQVlSejkzUDJ3OHRhTHU4T1ZD?=
 =?utf-8?B?NVU5Wkoxc2ttSG1PVVNZS285RmNWdStvUGE5TnhsOGtTYzNhZ1NEZHVFaTBo?=
 =?utf-8?B?azRpQzdnSXhqVWlDSEY1blZ3Q0J0Q1lTc3RqNTZmZTZuUnN6ZkNIeVp4SmVP?=
 =?utf-8?B?cHo2MG9CQjYyajdUT1UzSGFYZ09Rc0dLbzZ0MDJjTGVaR0lSMGtGd25wNGVG?=
 =?utf-8?B?WjhMMXNqV2FRaXRWTXpJSGVlWVpXVTFGdTQ0YXprdmh3M2k5NS9WK1psSG1J?=
 =?utf-8?B?U3hBZEQzU1VVU3ljV3hxR0pvZWZ3VVZrSUV0bjMrT1lIaFpqRVZVUlNkSkR3?=
 =?utf-8?B?ZlJWSEZpd2szbkk3amUzeTd4cmJmRkUyb0hMMHNkMXBZTVB3UjNrUFB1TC9X?=
 =?utf-8?B?MTZ5cnNkTEl3UEpTeE40RnRYeUwzcjBYTmRrMXNLSG0rT1N2NldhdXdKalpr?=
 =?utf-8?B?NDhZU01Ld1oySGJyV3k3QmhXdWwvYkxEWnRjRVdIVDE4SVU2THR0ejQxenlm?=
 =?utf-8?B?RSt6ekMxVjMxaGtQWGFab2lLLzgrbVV6SGRONUlUM3ZINnAyb25pay9SYWw1?=
 =?utf-8?B?cG5lekVubkYyOFNkeS9WS0JQME1jZ1AvYUhKZVhZRDg2aEN4UE11MHhXNmkz?=
 =?utf-8?B?Ri95eVdYTjN5ZHJhNy9vNjBtNGhFbU8zM2NleTVGSU5YTGNDSHcycDJkNU5y?=
 =?utf-8?B?ZHBkcmtodVNnV1MzUG9Vajh1K2xWYmRkeDRDeXVXbXVHcld3bWJrRldKK1Vn?=
 =?utf-8?B?RG5oY2x4V00wcmJMZ05ZTVBXSnFZWXJmemhWSGxtZTNCUHBuU2grbHBBMFlj?=
 =?utf-8?B?QmdoQkQ2V0NCeXdKTy9jNDhVdGNydVphdTA2REgzY0twVW90OGNISVRTM2ZR?=
 =?utf-8?B?VVBpOUgvQ295ZHJNRy9XQ0RoM09jNFBXRDlhZnlINW4yTXBpQXpiRVRBMUVv?=
 =?utf-8?Q?+CrhxMeEPYuyheLDGETk0wmwg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0b62f6-a229-493b-aa13-08ddddf63d9f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:26:22.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmt971Mj4IddGxivNukeU0g0Ngf09KY5A2tIUB21dULJX78Gjztov5IyGTMiXctQPX5OzKxRi+QMCmocuGFMWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11530

From: Richard Zhu <hongxing.zhu@nxp.com>

M.2 device only can be enabled after all Power Rails reach their minimum
operating voltage (PCI Express M.2 Specification r5.1 3.1.4 Power-up
Timing). Set a delay equal to the max value of Tsettle in m2 regulator.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 39815b21d235d2f8cfa49720d3be49d056ea039a..6d2f09404bdb8bee62532f1e02f59bd5a899833e 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -136,6 +136,13 @@ reg_m2_pwr: regulator-m2-pwr {
 		regulator-max-microvolt = <3300000>;
 		gpio = <&i2c7_pcal6524 20 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		/*
+		 * M.2 device only can be enabled(W_DISABLE1#) after all Power
+		 * Rails reach their minimum operating voltage (PCI Express M.2
+		 * Specification r5.1 3.1.4 Power-up Timing).
+		 * Set a delay equal to the max value of Tsettle here.
+		 */
+		startup-delay-us = <5000>;
 	};
 
 	reg_pcie0: regulator-pcie {

-- 
2.37.1


