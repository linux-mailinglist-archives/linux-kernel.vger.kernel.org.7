Return-Path: <linux-kernel+bounces-799377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43799B42AB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD7F3BE41C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0502836CE1F;
	Wed,  3 Sep 2025 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wr7AJ2Tn"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C05A36CE04;
	Wed,  3 Sep 2025 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930835; cv=fail; b=g1BSJRKlWJFtNmVSEWW4G6LbiakL7DSkjGS8Gc/uWo6AexupYN5IAQjGwKqr7T4Nb1VdoInoMyohgk8m6OIt8GL/1gOArY3H3dL24B76uqJJBx4R5EAiVUjGgqFi2Et/h66CTvkjAKQzPNg4qbvUagKV+YccyB6WUqBnN3y/EKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930835; c=relaxed/simple;
	bh=AfNhWz/z7TJJht3CTuPywuWnPQfFYx7xhPW/dvXu8fA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qSDSYAD/Qn8BzjgzXB7uYygMZuLb9eczySdaPkU9KOd7c9CumppQGicV4jcyLn2x9syebTbFz0EXE2QYaT/6XjONlQSljzhGMmt2cqe2TJ48cKpdgk4/XXGqe0z5RnorCbCV5JqaXdJHstGwKfQWwgrHZUeWw6C///UfqLEjuoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wr7AJ2Tn; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIZsIl80Q4BulBH3MP02npYpRLI13vG4tvlRjG9ecwp7r+A6OCqQFA1KmDTUY3mLclFC1LwJx+frUNM5JKvUvOe6mti92lJ7uVAF02Qt7/9sCZxMgtcReJOVWBycWV8GtwiEoGM4Gm2bEwOmEnGEo2DYES3HNXOlaSJPzk59xoLn+E2FzRQzsyeURiAiGRZmORAQdOuXxiInLi4aorf9gqF2JpPgi1qatgtXXkTHcC33gCq1Q0eH5wGRhwfwsc4ooCLiqvvbPM4X2IIozfqa5cGdVvxe8B1w9c3AIY6YMw27F98Fav9YgmvS2vb8jdrguxAdNWtHskD+leNnMVcS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWwRN4JQc8SZcwkieEVHq6uwZdGC1uKH+tLc89GV0CA=;
 b=rlQi7qqli/D1RLQcbRAyxOxq1NSiJ8oppBXa5V7FMFOFFx6tu7iwIhavMoxdqG9ZFVUlRAmgmpw5/l9hp5cPILwcltE2nRtP8/gVFzSaeSMJv/i1ugAUroB1b7t+PvAwZczEA2AYpY2FwJgGDG73JSMxGwW4dtW2NlfGRYPQ3Uen4zIRpBNZ0zEsukBDscBxBiiXZuyPx7Wem9SeUuSe3Lkc/mEZ5aEmyc27ONW7DwE3C3QHZjtycio/C6b/zQmbqASvO3MMnxJWlz9/vT+/shtYrt7DRfWt00vwHeXl84XKmIzO+O7N/w7ssQl6DFk3FDaFcUWo8jxI+Bzm/j7pLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWwRN4JQc8SZcwkieEVHq6uwZdGC1uKH+tLc89GV0CA=;
 b=Wr7AJ2TnKAvXEYYl3eSt3VSNl5Rx45Ii982FOE8x/aldLr8K3c4+s0tfAwSxC0gc6u7JXAYGePHkNyRug1yGBandWWn3GpdvWorm09G9DF26ZjzMytX8y+qxU0d7Eh2+9OEhFYzu82jN66pSQBGukbtLAaAjGENd+G5pQmabcrqwirPPcDkB/AJz/6X9gyjMzLhgbTzf+YbXZHYqgrcEbwBYicRex7+4vlID2RXBX4Nua7SuAFoxrQa82P6rVmV4gs2q+QQB3ykAowe4IdO1+DmBDaoIg1hA31Iynv2p32gU/5Mt+IZMnXv/uF+POhIuGl76utlwA8rTFt5xemE8SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:29 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:20:01 -0400
Subject: [PATCH 08/16] ARM: dts: imx6: rename node i2c-gpio to i2c.
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-8-1e883d72e790@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=1241;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AfNhWz/z7TJJht3CTuPywuWnPQfFYx7xhPW/dvXu8fA=;
 b=JquC39SRMu/75dj7subR0y3bnMsPwwPcELa+yS5Wv5lekXEdu356JjhxWnKuu63bu2uWhHnaJ
 GBc0hByZ/lvBsP5fLWJECCXAtrlkWpaADXGXO5O6zh1GEeNv10oPisU
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
X-MS-Office365-Filtering-Correlation-Id: 17b6d9e5-a254-470a-e36f-08ddeb275348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUVOTDkyN09MS2hYYW9HQW9BRTZJTHdWU1RUS1hkUVNLRnNXQlFlWlJsdUNY?=
 =?utf-8?B?Y01wdm96MThHN3o2QzJYb1plaTZkaHl1ZElES3B6cVNFb2pEQXUwbHRodWM1?=
 =?utf-8?B?NVM3Z1JvOEUwRUU5YlZBWHpTSTcrTE9LeVk4bWFCNkxRNVV4ajJ5YzZjL2Vx?=
 =?utf-8?B?V0J0Z0NiK2c1d2VpYURTYmF2V0ZnS1NnNE9JVGJ1ZkNBb01FRS9IM1RlVy9S?=
 =?utf-8?B?REw2MUZzRHhJZ2llM2tiVnBjNkJyMmIyWnBHbU1zRGtXMlo4elcweFNmL3RF?=
 =?utf-8?B?MjdFK0lNZXBRTDlSekovYTFVRlNUZjdHNFFrNUp0ZXhHbjNWYlZhRXNKek1F?=
 =?utf-8?B?OGZGTUgzcHhCa05qREhNT25YdUZSSUFEWTcwWXNkcVpLL2hMWVRqaThXZk9G?=
 =?utf-8?B?SGNVSWhPVHhJcDFDWVVVYnRnVFlSN3kyRWFybHpGZWJweGRXY1QxSlRBWTdP?=
 =?utf-8?B?TTRlS3JaVVVObWwxSyt5VFRGaVJEVmM2dkRYQVJQN2l1TXJtSjQ1RVZ3Z1pH?=
 =?utf-8?B?dTV3V3pTNHg4cUNnc0dxdVZNdWxQZXZ0M1NxblVsQjVzOHV5aXFyQXdaVVg4?=
 =?utf-8?B?UU1zWERCL2RLRmNkNEY3SWh4MVNMblBHa0RYWmtQYTdzeEpqMXJxUFBQQzlK?=
 =?utf-8?B?L29OWGkrdWROTGN2Zy9tQzhJdURFM0hEVVZEaFVCRXZIMW5LamZQeHdjQ1pN?=
 =?utf-8?B?WlA5Z2FkMG4wSk03bm1DaHpTVVFJWmxkRWMzcjdHbm5JeVc0ZEc3RURKOVZs?=
 =?utf-8?B?MUF3L2o0YkNEdGpsYUUzR1RRT0NVUEtra0toTlJLR3hVdVhjNXBJSzBsdVUz?=
 =?utf-8?B?UFM5SXJBRXZSK1NXWFA4QUd4dGoyWFdaSGkvdFJsY2ZWQS93ZjNkNm9NT1J6?=
 =?utf-8?B?OXJ1dzV2SXRlb0pJeWtYOVN5UmNybS9wbjRLWFNRUWFZajVhaEF6Y0VQTjVJ?=
 =?utf-8?B?bnRCOVM0QjBSaEo3UmkxWm5tYlYzWkZncCt3R1ZRZGJ3OXA2OUtFa0xjblJ0?=
 =?utf-8?B?SWVvTzduRTZCc0g4cFMwVVBoZkFrMVZmN3YwS0VGaGlWQmZrbDJOOXFNZ2Nn?=
 =?utf-8?B?MmVCWDdIYWc2SXdBUnd4cDFJVHNlOXFrSjJlNEx3a0cxN3RlelZCaFFzQndG?=
 =?utf-8?B?SWZFaEFLZWFRMnZoT0NqNndDSEpPWFM0M1BHZXIvcGhPMnU0NlZ6TE1jU251?=
 =?utf-8?B?UUdBNTFwcUlJcFNhdG5YQytoelZYdlJWUXNNOE1EVzJaSVBiclllN1JSNTVL?=
 =?utf-8?B?ZjhpUVVKTXdwWEs0Y2YzTEx2a1dzQitKSTZWQmlTcndGWkJqVFJ4b2krYkth?=
 =?utf-8?B?T3M4eEttbDlzM0tVR3IvaFM5OHcxSGpzMDBMTFZ6ZE85TGNuVG94cllyOTky?=
 =?utf-8?B?RUdoc2RTcGFkRW52SDJUWjhwNXVQQUlLWFRZK2JadXBjeEMxK0NmWjZkVHNi?=
 =?utf-8?B?bGV6Y3d3N1NsZ2R5Z2E2SlI1S3FSV1JWaUFFVXE3d2dVU2pkOXlLR3RYa2FS?=
 =?utf-8?B?cDE4eVNJSFJiUnNwL0hZWjhQTEhybjEzdmc0disrZGUxSVkwQnFQUFgvSk84?=
 =?utf-8?B?UU1LSUZZbWxjWnpHVmg0ZWY1OHVWdG10dG81cmpXRXRtd1JKVzhLR3BqK0ND?=
 =?utf-8?B?eWlZWisyMzZjMklYMXBSMWJnbm5kQ2lBSjFVL3ZmUnFoUVJIek9QcGI2SVZq?=
 =?utf-8?B?Sm5EczgybXdjdmpkdGdrMUpVZTJVdnNGMU5jTW9rREdUaWlzaEoxb1NvK2ZD?=
 =?utf-8?B?OHBLSzVnbEpYb0NndnozQ3NTOFNzZXJPVDZKV1RJaWZ6QlhvSG1xUEo0cVN0?=
 =?utf-8?B?QWJTRGp5R3RUMUJhNUUzcFRlSTMrOXdma1RUUnVha2lXM0FSNUhyR2pkcExN?=
 =?utf-8?B?K25GWUJaY0JOMHI3VjErTVFvYVowV2RTaUJGMVRPYnMzNHVua3NCcy90NUlZ?=
 =?utf-8?Q?h/zCD2MqEsw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlBrU29STFJhTVBCek5sUnZaU1RPdFk5aHlINThFNk5NOVQwVkZlU2RqcjhF?=
 =?utf-8?B?dk00OFdkeHVnT1RNNXRGOTFqOXVGblBTWm9vbHZSeFRvMVNRQWtySGc2ODhR?=
 =?utf-8?B?cXptalpxM2Nma2NVcDZpaklPRjhpZ01FUG9RamdEcGNKZFh1VVA0YU9sZFB6?=
 =?utf-8?B?L2RQdXgrdkMybDBQZlhNSVlOaVE0dmpCUnQ0aUtvTTEzeW5vbERHa2hWeVlz?=
 =?utf-8?B?eUZ3YytLa3YrdzB5Qno0VHR6ZjVtM3BaSnpWNXBobWxJbTc5dVg0WW9ua0V4?=
 =?utf-8?B?Zy9sT3NQV244Y0JwZEh5aXI0ZzlqRm9nQmhkU1VXbGluMHlyWXhLcXZ2MTdR?=
 =?utf-8?B?dVlUaFB1MitWUW5WekxaSnd3clFHVDhEem54eDU5d25vN091SU1BaTV4TW5r?=
 =?utf-8?B?eVBlcmZhN24yMEpIQXdwVTNkNE42TCsyalpjUFFnZEFic290aXBaUG9yU1o3?=
 =?utf-8?B?cTQzM1VjUHZjaDQ0UTdNODhHS0JCV1NnM2FoL0dwRHlIa2VuWVZsWTVneUUr?=
 =?utf-8?B?eUFLeFJyeTRFRGNlRHVDQzJrYnNzeFd3WkwvOXBZeWpBWk42eE4xMHMrd1Bo?=
 =?utf-8?B?Z2JJa3g5U2twQ01mV2plejFLZE0xcWlUbDFtKytrdGF1cTR2U3dCR0t3eGtN?=
 =?utf-8?B?L1BtZm81UHpJVzBsNjlBb2VrZzNRM0pDVjV3MHhiSDZBZG9hbnU1MXcwM2Vj?=
 =?utf-8?B?Zjc0U1FpcTV5RGR2T2RFeHc1NVBleFBqOGdNQXZYS3JreTBMTG9uWTRuNnd4?=
 =?utf-8?B?eTc1c1UvRWJvZWdvOUVQTzljanlVNVkxR2tjQXMwMkNrUllkY0tlbW5aNFNW?=
 =?utf-8?B?RE0wWWRZTVk1eUZMWDRiUUhIZ000WStwMUljSTlEY0xwaDJvNHUxOVErNzYr?=
 =?utf-8?B?UnJvRVRBRVhKL0dtMnp6L3VBUFVrSytmQzhYR1RDVENpYUxhUkdMcTJvUS9P?=
 =?utf-8?B?dE1uSXdWWVY5T3NSZFlqM0RVc0pKMlgxQ29NbTRNenp2eERnMnVENnpzSDd0?=
 =?utf-8?B?d1FKMTVqVUhkc0VZT3R4UTFPbGZXazR6bUJhSHVlWWNJclRhNDUxaFZrS2p2?=
 =?utf-8?B?VFZmcEdCb2J0QWl3T29YdUlaV0t6c3Q0QmhQRGl2VGZwVXJjYUdqQUsrQmhu?=
 =?utf-8?B?MWQ2K0kwdWxTcnIxREtkNEVTWFY4LzA5L1RNeWZ2aWtVc1dVOXZjOFozT0U5?=
 =?utf-8?B?V093YitaKy9seWxFZUN4L0pvSTFYa2NpdzlneGZyZjROa1p3SnNDc1NrV1V1?=
 =?utf-8?B?U2VJR043ZXZIdDZRUnpIakNZZGdId2hmV2V0cG9Zb09MOHVtcWhWZGY3RS85?=
 =?utf-8?B?Q0hGZkRaNXI0SndmNThmS2toOXpkeTRHZDNPdEtmT1BwY3hRM2xISU1yR1lr?=
 =?utf-8?B?NTFKUHkxNUl4WjhSZUcxK2RXZXduNjc1NjlrNlB3TlhYeHpYdGhWYS81Yndj?=
 =?utf-8?B?QktBSVEyL3VzNFRDNDNCSEpSbjFRTDVzd0xxVk9PRGdNVVBXYk56cHBKMWo5?=
 =?utf-8?B?THZVWUlXTklmdFplVm9PazMrMjkyYjNNWUNWeTA4TDBYUk9QTjdTVCtIV3gv?=
 =?utf-8?B?MG96UnZBbnR3MXNNVHhCV3ZjUk9sc3U0d0xoRHBMVWF4SG50ZU8yRjlOVjh0?=
 =?utf-8?B?K3lVNms3VVd1WDBadVpsQTQ0b0JWdGtLODI0MlZ3d1llRmIwSzk5QUlISnhK?=
 =?utf-8?B?K21NTGRLZWkvdmdVejk1dFkzVDNNdVY0bkFqZFZkaXdDZDQ4MDRySXc5d2xz?=
 =?utf-8?B?bjlHaXM3RWF2WEErM2RkS1FZV0hEdHRYcWRXVWY3VnI5RGdId1AzNzVDejZq?=
 =?utf-8?B?dzU1RmdMeWJxMEFGRkZtUW1OV3ZuMUJ4MHk1eStYMmNYcHcxSHA3cjhoenpn?=
 =?utf-8?B?TlRScC8rcmJkS2NxbmZHRzdMd3BGLzBqdkJSRDV2ZUlsU3FyaHF1L3JZWmhv?=
 =?utf-8?B?aG5uUjN3NjBEbldyRURJY3ZqUnVibk1uR3RmT0xENG4xQWFiL1hSWXRGcXZF?=
 =?utf-8?B?bzd3YmY2TkljUklKQ3FyL2owUnF0TVJOL0lyNXYrN1lOdWRmNkFtcnpSd1dO?=
 =?utf-8?B?L2hMN2xpL3hlNGh2azNiN3AvUGlud1ZxVWcwOVAzN01iYUtQNm1Db29NUGNv?=
 =?utf-8?Q?fMB25Piqb3bc8/ckHA55hjHRf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b6d9e5-a254-470a-e36f-08ddeb275348
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:29.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSmLRnMLlFDYMy9y/PbAnxpIq742iULNcM7YpFaXdfD5aL2XbBTmQT8bmO4n3dXGSx9NWCUh9Krn6SJDcycM/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

Rename node name i2c-gpio to i2c to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul-0010.dtb: / (karo,imx6ul-tx6ul): i2c-gpio: {'compatible': ['i2c-gpio'], '#address-cells': 1, '#size-cells': 0, 'pinctrl-names': ['default'], 'pinctrl-0': [[68]], 'sda-gpios': [[46, 1, 0]], 'scl-gpios': [[46, 0, 0]], 'clock-frequency': 400000, 'status': ['okay'], 'rtc@68': {'compatible': ['dallas,ds1339'], 'reg': [[104]], 'status': ['disabled']}} is not of type 'array'
        from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
index f053358bc9317f8447d65013a18670cb470106b2..d5ef613e8c9af684eba37ad578a86b6541096c4a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
@@ -72,7 +72,7 @@ backlight: backlight {
 		default-brightness-level = <50>;
 	};
 
-	i2c_gpio: i2c-gpio {
+	i2c_gpio: i2c {
 		compatible = "i2c-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;

-- 
2.34.1


