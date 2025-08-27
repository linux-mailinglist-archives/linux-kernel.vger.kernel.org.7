Return-Path: <linux-kernel+bounces-787673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19121B3797C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D78366713
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47BF30E0E0;
	Wed, 27 Aug 2025 04:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FaR9Sv5J"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7604630DEBA;
	Wed, 27 Aug 2025 04:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270782; cv=fail; b=azKxe8M3O7IQMwzz6PDOmyuxR3dM7uloq5aC5sSj0BxDsXnrwZb8Svai9I7jEKFgz/bX1CRu9RY1Nie1UDrYdk2nnZu7Ll/E7QxR6iY7ahKeI7yVNcUF9mzsARptDOGMMIlyja9t5ZxZ9lL56dhpyjrJeoDn5ByV1Oi98eUshW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270782; c=relaxed/simple;
	bh=pifyHl+upSEXGrNwu9AkYdfkgfYp1MPBPDO65pNL0jE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oEmwfNH62YRWCYLO+3w4o3/Qq6hNL9Hy8RR2LUyX+7Wn+nzexk14T8eTR9a2OK0dM3wCjP/pKahCxY+LdJoRcJvBOAAQn7ISCjylFImQWDPPVwW3+U0draC6vs6cY8HlyVpM5ZKonQHQgz0UYWO2/ofLeKLHTZcXZvegzMA/XkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FaR9Sv5J; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNe9FLKW90Hyxnv1sbUFwO4eGOEKAKs8TuoKqZTq6Jv5iNFBNeOAPimNBA/jpV0JsybxeNKAlquAl02tExOiZn9Gd6ZNILN4bHtuoWU4GYwIB9vG3tmuoH1E2O8vFRKmAnHjbVAiY4MdpemZXaCv6CCoLb4nOUC+MGKSfmDeN5eZ5MPv/VREQHR/LSOlxNOYjOtg86N01Yta2s8SHYLi4qr1ns0KNXYAr91GjAxxAsmPYtSRAqn2OAJtSkFHwic5Z6B/c6cyRPwpKN8Fvps1jCE7aS1n37XoN8MaTTxODfORFsOIWDxM2Qnwcm5rgHxyi2FtqXWr7q1PcYx0vlQg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmaWIJQRVbWQYyTwQ6DOIzUSTeRMjOT2bz/abwmpcao=;
 b=hBpzQ2OZDsRvgX1O97VcsgaUGoUg4YlnhDeLiUrYNWhyktrpejoXxFQjLM43DZHtogcKUnFYMxUkikjy67qxidhrbIVBX1Y/rlvY0mamF8g2uZBsULQWpEY/uOI2D7glRIng0dymVW1khmcqEOJwKn1AXihtL8j0bxSUgyKLI5H+WGBM9ME1uHgxKlGS6O3AMzD3uy4z5JLPmpCK+1kttyJMKxF6+MFZShKOENu+64MWVMtq4lSN5JKgGesA88/HHs6Jwc0qQHNaGU+jFt8dN0rg0vIkDLHUfb96IYHvfk2aXbm79EA45CfswuzUb+UmfTRWNnrzOVvXugn561grtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmaWIJQRVbWQYyTwQ6DOIzUSTeRMjOT2bz/abwmpcao=;
 b=FaR9Sv5J0mgq0eaFGByc37nMv6YR6UMT+iqhZFGPglpQmXCoEWKBIlHfzOeBmIogYILRxUWHkke23ICcsW6HnHrJ3NCx1VM/2IFMe58J4oiXbKdaWSBQeGPKm1sRHq6rVQvpk/J5otug1oPBFJcP2FonnLffMFkOnZvwNfyDdktUv3T9FEpUtH5ZhPi6gtwzxF53nv9JJbfdhZ4HoYORM9EGb66/8Dzbjg4Y+4N+b7bQIhj3h6sDoBQPsGqlPzPQEQcwd/6PRCr3swsXsprOLLTpvDQAJioLH7dxnUxpTNGkGE36LXwkYVl0w9f8frBC7W2l8oo4ZLteIWzopmojvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6899.eurprd04.prod.outlook.com (2603:10a6:208:183::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 04:59:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 04:59:36 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 27 Aug 2025 12:59:13 +0800
Subject: [PATCH v3 1/6] firmware: arm_scmi: imx: Add documentation for
 MISC_BOARD_INFO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-sm-misc-api-v1-v3-1-82c982c1815a@nxp.com>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
In-Reply-To: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756270768; l=2251;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=pifyHl+upSEXGrNwu9AkYdfkgfYp1MPBPDO65pNL0jE=;
 b=3wtWwmnqUBLBfadExcwbo8mJL1UFNm9oCuuNTeMQ3Nfn4rnMeBJDQXvz7GDp/UiPyHa6RB/jh
 1h04FGGd+V+DYb7jH+cjpLpV9nv9JJuCBnx/AXdxNmbXffgxvqcVpK+
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9c4ffe-e9f8-44ab-4582-08dde526854c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NllZZVpOSDY1ejVIbjRlcG1yL2V2WGw4UTFtNXZrZzNqN01NemxZUytzWmw1?=
 =?utf-8?B?SGhReFBmU2hTMjJ3dTc4S0NhaGdyZUNDTlZGbUh1cms1MWVZYloycHVFSUph?=
 =?utf-8?B?eXlXMW1Bc1ExVTU2MS9oSmtONlA1c0tTVFNzL2d3N01LQWdYN0ErNW91U25U?=
 =?utf-8?B?dG5Nc2tHUDhtemM5YXNZNmdOYWdQZXBBa1M3VVVQaFAyTmRJNndqdDVIL0Vs?=
 =?utf-8?B?RVJFa0paY1JjR2NnZkxrbTVZQXVkSzUrMnFKb3Q4K1h2MzF2UTdrckFucnhU?=
 =?utf-8?B?L25nUnR3ZmJOMFhHQXdodmFMZ1JZbFluMDB4UHE2ay84ZXpYS3hGNVlhTEg4?=
 =?utf-8?B?ZUlsdzVYUXJTYlNRVWlNQWdEaVduY1NiQ0ljREtlWlNZemlFenV4Z0NxVWlw?=
 =?utf-8?B?M2xZM2R0LzJDMGZXOGw0RDBuZFIySjFEOVovenNydUlKNjZQcTYzaDB1T1My?=
 =?utf-8?B?RVMwS25Xd1pjZ2k0d0RWenl6Y2ZhQURxOU16cGxybk9lVUFOWHR5ektGMkkr?=
 =?utf-8?B?QWEyZnJneFBYeE1OVFkxaTFlQU5UMy96cGhRZUZJaC8xMkwyRnZuMmZGbE1Y?=
 =?utf-8?B?eWFpcm91aVVDbFdTa0hWeVA5S2tBa0hEM0lJMVpLd004N3ZFOTlCNDdjYVFV?=
 =?utf-8?B?YUg3U1gxZnBCdTBrWHBFeFVpc3pTeEhrYUtuVkl2UlByT29Qb1R4MXZaRDhj?=
 =?utf-8?B?QUFWUkJraVlFMXdKenJNRVpUcDJUdnZjZGdWQWVVekJjMzNadU41ZEMyRjZV?=
 =?utf-8?B?U3R2SUh3SEFCZkluelVCMzM0cktkbkxSOFpjUGRzK0k0cmZZeGZlS0tXdTB0?=
 =?utf-8?B?Z0Y2WHRKVW94ektTNUR2UDdHeWtNTzFvWnV5NlRaajVSU3lvVTlvbThkOFI0?=
 =?utf-8?B?SzIxNGNtOG1YS0hUWThwbkxYcGFIR0dnNUc5a1lqK01HQnNMd2E5SERMM05q?=
 =?utf-8?B?Nmpha29qYTNWZE90MGIzeXJ2RWxkcURVZjA4TEZyaFdJMzJ6SWJHMVJ3UzNJ?=
 =?utf-8?B?eE1yOTlXS0JUb1h5VkJaZ1VFdXUwd0xkd3NWelp5U0JhbFM3Z0FwUlEzc3ho?=
 =?utf-8?B?RDV5TUlScUNGYXdjSGhwcEFjSGlSVEtwVzNHM0xHS25SaldrL1ZiTUh4cVRD?=
 =?utf-8?B?V1JUeVhGTGFhRHQvRW13WVgzeDk2d3U4K0FMMTl2UUx2b0dJRGM0V1ozTTE1?=
 =?utf-8?B?cm9CV2cvQzhycW5ENkRpenRvNzREbUZkK3VNTEhlM1pDei9oTFZESkI5SHp6?=
 =?utf-8?B?K29raW1rUElNTWdYUjNtaGtGUitYWmhaSGdBTFhTZWkvRmhPKzNrR0g2TkhZ?=
 =?utf-8?B?MC9ERGlhMG9iSkFEU2VGWmRmNHBMbUpYMlJ3MUs3eW1MRmREbldlSU1IWXRH?=
 =?utf-8?B?ZHFoQmFaYnR0MTN4NVJFbVFsVFg5VXhMS3dIOEJXNlpqUzFZZzBweUpWVlFo?=
 =?utf-8?B?NEpUQUNsdjRxQmx6Si95UDBlSHhRc2VsdHk4a1cyb3JLb0RHaTM1MVF4VHJp?=
 =?utf-8?B?dm41YThZa0gvaENqaUNYejZOay9KWXhWSVpLMEVhUW4vTW9YT1BTaTU4N2hP?=
 =?utf-8?B?blZxS2hSRWRLVWlKdmhGZ1VVOVlCU1RpVkJITG9yczk1UXVZV0h5SGFKRFhJ?=
 =?utf-8?B?RytYSk5WYkp6UTV1NStnbXcwbHhzWkc4QVJmamdHYUtKS0xEaHlNbVl0Z2RG?=
 =?utf-8?B?cFZzNWhtWnlQYTJNOGFNQTRjM21TeDZTNlE5a3BBQXVXdlE1Y09keXZ2K2Ir?=
 =?utf-8?B?azlUSTQ0cEVvUnRyTEhjUFdpNGlhUkRDR2tkMnE2NnorUGp0ZFJhRUdGUG9m?=
 =?utf-8?B?eFN1R0hCTE1GSU9lRVh1RkM2ZXNHbVhNRXlBcUVXQ1krcTFUUWVpVU5YTkZH?=
 =?utf-8?B?Y1VVN3Q2dC9JWS91SFdoOVU1WkNaWDNHQlNyRUkrUTlDdFEwbnA4TkF3bmRj?=
 =?utf-8?B?VlNJRWgyUWNLT1FaQlB5VnkzUEdNaTdheTVLekF3azlzZjRTdW1kcWordHVY?=
 =?utf-8?B?b3NHQzZQSVd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDlBcDYxa3VwOHZlZFJ5NWJmcCtxMmdIcFMzYkRnbGVCWWhzdWFoTzdldUxN?=
 =?utf-8?B?L0pTRTdTS3dqb0ZzMVE0S0Z5dEt6RElaSzZ0OVBLRkp3ZUI4ZjRqdTh1dStO?=
 =?utf-8?B?NE5ZbkNSdWRxK0pFWDNFd2RwSmtkOFlvdjZTL2lFamxTUG9SeTd2eXc5eFQ1?=
 =?utf-8?B?UGpYc3hEU3FLejY4d2R3RHNIK0Z5YWFackI4RUxDUFliWEZGOWFuRWdHNThB?=
 =?utf-8?B?UEVkL0thMS9qVVpTZ1pvN3ZIY3hZTU9jbzdyb0NGd2ZkOWY0b08zS0ZURzdu?=
 =?utf-8?B?ak5BWVdYclBESGxFaXlUZlNRa05zRHBlSExENk1MYmRqdFVUMzVnRDVIejJs?=
 =?utf-8?B?RExHRGt1VVYzWUIyd0s0Sk5ScG1CL3NOSmhKTGEwN1VaUk15ZDZDa1B2WExt?=
 =?utf-8?B?aHo4ZkZGbnJQT1YwNm5STHJZVFlmV1FtQldDVXArV3JpK3dFcUc3bFROZ3VB?=
 =?utf-8?B?YVNMZ0Fhbm15eksvTm0xcVBXL2ZpelRXd3FFWS9acENEcVBtUXQ2cXIzSlEw?=
 =?utf-8?B?bjh4cEp0b2RjM2Vrbzl2SkxWMWVmMUlDR2hlaTBPYWVoNUhQQlhJejBNS2kr?=
 =?utf-8?B?LythQ09hS0lkcGNMTDRVc1g1ai9ydEp2cVAyamIwMFdDOFhRaHkzaFFaOVFX?=
 =?utf-8?B?Y2lpYkpKRllFbHV1ZHBYZFgzb3FtR1NqU2w2R2Ywcmh4YzJWWjZqSmtDR2JM?=
 =?utf-8?B?Q0lxSmJYOHluYkZoQ1JReUs5OU55eUtmSEpSVDF6UmNodUpaWWZ2bUNtaSti?=
 =?utf-8?B?aVpTN080aHhsSzFnV0xWak9zeCs4NVdyVHRWc0h6SnJPb01RUzltMjYxSVlP?=
 =?utf-8?B?TXpVRHVMV0d1dCtWUXlyYys5UW1KQStGOGV1SUlYWk8xa1ZqNUN1WkMwY0pK?=
 =?utf-8?B?N2ZkcU01UnRhMGpTWFNueTl1ZkVVSm9XV2Q1R1ZTNlczbDlyNDBWV2pzR3B1?=
 =?utf-8?B?WUpIbXQ1NC9vK0FUUzBLZld0N21NQ3pCRTJwbTZUbkx5K3hidktYeXNNNkY2?=
 =?utf-8?B?Rkk3bTYyN3dqZWV6MmE4Zzk3R0NzZmZkNkhCWVBncGZZclVtNlQvOVlCR0NB?=
 =?utf-8?B?c2tTc2V3TTJhN2habU81bTNSbmc3eFUvemJ4WU93YlFod3BNQzJubGtCVVRm?=
 =?utf-8?B?V3RScGk4R3pZSDV3R0JqWmQ2VG5TOTZLc3QwZUZ6VWJULzZ0djh5V2pnSVNI?=
 =?utf-8?B?MXBETEhzQzUzRGk1c2VRbUdGVVBCb3d4OWtBWXBnbUxIQ2JSVi9MRmM1Ym5F?=
 =?utf-8?B?a3FXZ3g3NlVrb24wZ2tRMllxT1pGZlBhWGIreWovL3lCd3E4bzFidUwzMDlw?=
 =?utf-8?B?c0FlSUxnWVg4Q2hpQ085Z2tnVlB4Smcwem9Qd29BWjlzQUpYbEI2Q0Q4TmRv?=
 =?utf-8?B?cDR3U2VSRVJWSnR4c0VlWEdVeFNWRVpFdTA2UDVrN2lJVXJwK0EwbFREbnd3?=
 =?utf-8?B?Sk5HaldlZTJyZHk3RlhlZDdSdWRUaUkrSE1LNHZ6TmhUaHB2eWh1YmxtMk9E?=
 =?utf-8?B?VnlaMnA2N21Ic253dTUrdzlFbDZrTjVCZjh3QlRIbDI0MTJpREVhbjE3VDQz?=
 =?utf-8?B?eERPUmM2YXdWald6aGV3MzkvUGZIb1hYc1M4bEVkM2JnQ05VUHNla24rbHBl?=
 =?utf-8?B?akhMUzdaeEE5TExCNGxDY0FRbnBDcFdhNnFzbEl3T0wwT0owRWlLd0NWTVBJ?=
 =?utf-8?B?aytXVWIrS0N4UVBSMVljY2lzT2w3c2Z4WW12bFJIYzNMRzNmeEM2eUF5TzNF?=
 =?utf-8?B?Wmgxak9aVHZyYnhZTUdmdkJuWnBOc21mcnA0cC9JcmUvcU5nUnhqc3NzVkFh?=
 =?utf-8?B?U0lCVVZpSit2WU1TY0FIN01NczkycmFFSUltOEZha0xubHZ4Q1NTOWZNa2VX?=
 =?utf-8?B?UERVTjBBTmlxdzBTMzBONkpCRUdXRGN6MGIyNm5EYW45ZTFBVkFVak1UeFBp?=
 =?utf-8?B?WVp6aGdjc1MxUTlOY0ZrYmtDTjJmUWh0eXVYVUluZ25kY3pPRjQxM1UrWWE3?=
 =?utf-8?B?Zi9CVllSREdpVGo3YkVtR3RXcDdLeEdyWUJJWnFSMGJlTlRva2ZOR1BRN0Jx?=
 =?utf-8?B?Z2p3REZRaHMvMnFXWmtmNWdCWk0vU2NhUVZwc1RDVC9ZbjlJUGRVM1RndzQr?=
 =?utf-8?Q?9FFmz8Cmm7ncPc9lsNvSuUkBW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9c4ffe-e9f8-44ab-4582-08dde526854c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:59:36.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8KihmMQS86Rf+2X+vjtKbssrT63XFrEBtJ8aYvlBaeWuKvBXEScmcmxHWrhxSa8I5H19iTG2/0f+hW+LIZyrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6899

System Manager Firmware supports getting board information, add
documentation for this API

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
index 4e246a78a042a79eb81be35632079c7626bbbe57..0a4d157b3ea12c7735aa19d8d6c64ae8504d0c71 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
@@ -1670,6 +1670,28 @@ protocol_id: 0x84
 |uint32 syslog[N]    |Log data array, N is defined in bits[11:0] of numLogflags|
 +--------------------+---------------------------------------------------------+
 
+MISC_BOARD_INFO
+~~~~~~~~~~~~~~~
+
+message_id: 0xE
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: config name return                              |
+|                    |NOT_SUPPORTED: name not available                        |
++--------------------+---------------------------------------------------------+
+|uint32 attributes   |Board specific attributes reserved for future expansion  |
+|                    |without breaking backwards compatibility                 |
++--------------------+---------------------------------------------------------+
+|uint8 boardname[16] |Board name. Null terminated ASCII string of up           |
+|                    |to 16 bytes in length.(This is SM exported boardname     |
+|                    |which may not align with the boardname in device tree)   |
++--------------------+---------------------------------------------------------+
+
 NEGOTIATE_PROTOCOL_VERSION
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 

-- 
2.37.1


