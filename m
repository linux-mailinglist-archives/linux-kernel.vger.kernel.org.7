Return-Path: <linux-kernel+bounces-830303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A300FB995A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263CF1B23ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CAB2DCF57;
	Wed, 24 Sep 2025 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="No7rWahY"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60B2DC357;
	Wed, 24 Sep 2025 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708430; cv=fail; b=F5eMAlZ2XkFYD3mnXdbLMAr01XO+eHdyaNqo5pblWO5PWDZ6pGERqDFeTwDNRtw93M6M0G6H1XQkK4M/BKdqsoFd7kQ3GzFHgplA/FBhi5XsDTzOR4qHHFkRMZ9oXxzW7ZyZ24Tec8oN3UFPtUQfWd1vZFXEwwKQMzd1ViHJAVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708430; c=relaxed/simple;
	bh=2SrrOV7dvTg6LwTM0hoLUO6FDxwzkeRTm1Y1g5o3R9A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=F3/hlUvxU2t3sklzUtKxp54II7yrfnkuGfKEZYNklk6EvDPqdmDoqO3hcoAFtbkSFMnD/+MaShLplkZq2rGgHq5SNwO1rudyHzclzw5zfxvK8D1CoeFah4CfYvTjU0EjTSwDJQzly9OBByppUSk6TJHIaZcUL76RuUEVSGcY41g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=No7rWahY; arc=fail smtp.client-ip=52.101.84.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7n/B3NPW58nS9yPrqmjTL9eqErJq+75lfumjo0RxVJi1rfYgtbIanV1XagZnVKvwsQXwJ3xPMEi1GpdE1mkikDEuS2EzPg42YFKK7TITRy5pbGKQCCEzEnfbZwUlQCKb9IxEtLQbIulNz/IoVfdjxiDJNUKANiJxkwoGWxYQwgrOGNvWhKI2IHU1WdeFlNw3fRLSJt3jphwLDkyvtHfheA1Lxp6bvv3REnXnSdKZk3ihYpgLJ3qTYE1k5lyg3cXl7OsEulrci0vHYizPyCm08BoHtVq5So/jK0sTVNk4lGQo3Z0rHbiwuS2/X7L3SZThgXW756tAlTi0Rpn0fwvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MhLg9X5GtaUN5cl7ksnlan/rXvfLtjSQHS2BsI2F+g=;
 b=LYSxh4lkzMcLqQQojK+Do59HKCFXJPWRK5cXxEG6O7d71DoE6pDOL0P5gbaxQo4XFt80pG84eN/9jDnW1yHOhsvtZFb4SEk/31EnriKzE0US1I17PLEX7ADnt4yWRQT1ahVCr9C89PyUrY1aw1aIUHvKjLTTQVRvcMpUAwz2iaXUKaCy3UdVfcxatbvdnqBzAkSU1QYY16waqqmh/5RyR8Pu4weB40zjhU0LvihtonYEONCiXbhlgzZIHiDEwnnwv4NWmiUc5vxkiIAL0JhPJvGpUozAsvUhwKl6rm4MuQbeEoBcjiE4/QcVsLu3OMzOWHcbMSEbPQEKR/dJp1JX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MhLg9X5GtaUN5cl7ksnlan/rXvfLtjSQHS2BsI2F+g=;
 b=No7rWahYxf+Hq2SesbD4wq8adQGw0KEgiUn9EcN5yAVUlcKJGn3B432uvFLYGItefs+jSN9qTGzUXYwdAp+PXMeVwoiZfs7l7F4XMjTy89z/JiX+Y9tCiwHgktGnFdSraOoSVWfsApLkWQi1Kf4IIMDP9GpzDVu1ndQvK3aFGxWMWn3eWbkmvc777455kmNmT/9YfUZeOUmW0pS1Pf9uYCoGo5u4zBWWfpkWtn6/03Emoe3PSQSklDPgvQ91ldwevVTQXyLFmchIizZst4Mhja119YRHFJMY4bWO7F5sT/s8rCIt3ZOFjQ7n7BmkRarRHYjrWR+kwh0J5Etf6xO33w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DUZPR04MB9745.eurprd04.prod.outlook.com (2603:10a6:10:4e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Wed, 24 Sep
 2025 10:06:58 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 10:06:58 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 24 Sep 2025 18:06:24 +0800
Subject: [PATCH v1 2/3] nvmem: imx-ocotp-ele: Add support for i.MX94 OCOTP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-imx943-v1-2-0d32d7852ecb@oss.nxp.com>
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
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1fcc5706-4e6f-4ef1-fb2b-08ddfb5218b6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTh2V3dHM2hPTmtsQTdSeURzWElxU1ZTMDVaRlRCVmdsWDJrK1lSVFoyVWlB?=
 =?utf-8?B?TjZTemErVzdPTUJPQWpUVFNnTlA3SHNyR1UzWk8vS3BWZUtrV20yZGV5ZHhl?=
 =?utf-8?B?YkRkWlpUZ1lhanhBME9vaUpHdGduZUJrQVRlcUVxeDQ5azdiMWlsOWJWRFFY?=
 =?utf-8?B?TnR1bVRqTDY4N0N0cXpjU1FYVHFqbWM4RzgzK1pkQWhwSDdzRVJ6dHZRTWtU?=
 =?utf-8?B?c0VkVjFpeEx1MmsxR3lMT282RUdCR0FnQXRLY3QxVzhlaWpkUEJGZ1BmMGpH?=
 =?utf-8?B?Z24welhzUzhrVEFwQmJhWmVTNE5RNEpCdk11ZXNJSEozK1E1a1ZIUzYxdU9Y?=
 =?utf-8?B?dmo0ZGRremx5T2RsanE5M1FVMkZPVXRkTnJMeWNVRnhOMmpuQkJqSXJPMlEw?=
 =?utf-8?B?aXE3aklmOHdZTHBrdDhERktZVkE5a2haT2ZUQUMwNUFwZVlZelRZcU01MjMx?=
 =?utf-8?B?cjYvNGoxS2p5NkdJbGhmblorckFUYmhPNUNFT3RRRlNoSGd6aE9mTy9lWVVP?=
 =?utf-8?B?ZnNxOGtHa2tMLzR3cjZaV1B6T3UyMHJhN0hyaGFQMjRDMG1JVEhSdXM2NVd4?=
 =?utf-8?B?djNNQXpIaVpHOXlNK1V0eElkeUpMTVZCTzFrZTBNcUdDWFF5RjJyRHhuY1pB?=
 =?utf-8?B?VDZjT0xjV3I5ODlwQi9BTnRMSU93TGpBdGtiOUhIcHJnV01BYXkzUzNOZnMx?=
 =?utf-8?B?QmZ0T1ZXVlNTVVRZcy8rL2R3RzZOOHlnZUNxRFB2dWduaDgza2xSTWdyQUFT?=
 =?utf-8?B?WmJNQWRjSnpKSWpTME9saWRSMCtISHpLb2lmQm0wczJXYjVPVndJMTl6bzdF?=
 =?utf-8?B?ZERZUlB5L1Q5ekloRjdvajg4QzMycVdrL0tWZFAxNXdONlB3eFhrS0s2YWxh?=
 =?utf-8?B?a2xEOVJLMjZqZFYzVElWUU5ramhRKzVtRndKQzlsV1BMSmFJcHg4TG9ob3kx?=
 =?utf-8?B?NVJLc1N6b2F6by9XLzB3eTkrVjQ1aGoyRzU3NTNjdDQvdzhzZG9OcmJ4aE5w?=
 =?utf-8?B?cUFiOU84dzdQaE9KRDZPMXY3dXRtTVA0QTNBUXBvaHBEeHFIOU02aU9aNndi?=
 =?utf-8?B?Qy9EM1FLSHlJeUpDVWtZS1dDZkpEZVV2UDY1dWhlOXpxSlhVSHB5TFNNV2dL?=
 =?utf-8?B?RUpkUitMTlN1KzI3cTRINUJ4Q0lnVTA4aFRmeXlHVHljNUpLOFdHeHg3cERH?=
 =?utf-8?B?aWdiUDdQd0lIeDc0WkNnK25xQVM3cEdEMzBRbm9tZVE1RUhtWjNWTXd3SmE5?=
 =?utf-8?B?NDZpekJQNHlsaXFpZUgrS3pEQkE2NllRQlc1WDk0UktWMHloNkRDZGxTVWQ0?=
 =?utf-8?B?QjVDZElCMnhEZjZMcVZJOFFNSWVzU01lVzBJN3F3NXJ0em5VVjY4QytUYUpn?=
 =?utf-8?B?T2dYRmw0WUFqUTM2NkRNL2g3MVhrSzFURitvMnd2N05HaldGYTdaYllDVXpW?=
 =?utf-8?B?bmlUelp2K3hpUW4rT1Rnc3ZHR3FDVzBsMmVxU0RybWFMYjQzb2paTytGVlBP?=
 =?utf-8?B?N2dKSk50V2dXSTBsdG52cHF6YkFvYTIrdnMxVDFuTmYvWEE4MUxLZ0ZYWDJO?=
 =?utf-8?B?UHFoOEdWbzFCclptb29BRFhOeUZFbHEvMDR6Vk9ucytKVzZVcVJmUUI4VkI0?=
 =?utf-8?B?TU5yQzcveGluN3lxTHJJbmJ1bE4veFBFWHJnc3dQenYxT0xBYUkzcHJPWGhw?=
 =?utf-8?B?U2lBWUV1ZXVUcFFBQ0ZEZ09GeWdPdldJeDFJUW5QbEtWcVZkQ0FncjhtWmFv?=
 =?utf-8?B?VEtTYWpDUnRvcjJYYk16Z213QWR0eXNLVkYvYW5CS1V6MmJWaUFYMU8vdDh0?=
 =?utf-8?B?ZDRGRkFqK05uSDZiWElwT2F6NVBvbHFjZ0lsdXJNT1VOelY2M2YvMDNlQWlQ?=
 =?utf-8?B?MjBGczN3VC9LMDBKTjhCR210aDdEU1pMVnpuWnROeTBCQ2RxTWw1VXY0ZDBQ?=
 =?utf-8?B?ZWFZdXB5b1l6d0RPS3BWb3p4WWVweHA1THhBZnFncGoyeHJJMlNSLzEzREZI?=
 =?utf-8?B?YmJDMzZNZzZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1BpajhkdlIxOHppSGFycGZJZlhITVJRSUdndTMrV1VVQjIvay9uTnM3MnBF?=
 =?utf-8?B?bkc1d0Q2N2dURnlZUkp2OUFPUVhUTnFqalpZT0QwYzhmV2N4ZTJ5dUdiamtx?=
 =?utf-8?B?T3U3M2ptaHNNYU92Z2tDNTBTcDdWMVpyc1J6cFA5M0pLYmhKMFFaUGhUb3hC?=
 =?utf-8?B?TmlKWVdBaERROE1DM1J6MlZlNHN3U2RpR3BLcWJ3RndZUDJnZmtueVhKVFlz?=
 =?utf-8?B?UHM0c1FLUnZNcUl4bExpbTVRWkhMYmYzY0wyU3ZpZ3VOVWVxSzhqejl2a3NC?=
 =?utf-8?B?d2VnKzYrSHM4VndwWElHUDhoNC9Ram8yUnhQaDVjMURmSW9ySE9pU0RLNEhK?=
 =?utf-8?B?ZXNsVElteFVzNHBUZDdmMUIyTXZ3eVUwdUE0Tm55ckczcTJWdDYyL3BFSFJz?=
 =?utf-8?B?VGRmVTYrZml1TE5acDJ1OUhaNmkyRmRwK0dlU2pNL1AzQjhFSzRjMW9rRHhD?=
 =?utf-8?B?ZVlGbXdvY1NyUmwrMW9keFdWUHM2dGpGWGZEL2RCbzRad1FZeDRQaWZNZnBZ?=
 =?utf-8?B?dEJOcXh6TmpNQzdKWXZRUERIV29kVlZ4dHVJWlcvUE4yNmNKaGpUM0g4eVdL?=
 =?utf-8?B?MDB5OVdCR2w0N2lhNGdkTElsZVRhRUQwSmQ4aTRoeHQzOHlwMWpZRmJOMGI2?=
 =?utf-8?B?b1lvWjBFVUhLNERZcU9uUGNRS2xIRkcyeDUzTlNiK2oxc3dCQTYzUjhYWEZs?=
 =?utf-8?B?VkZISWZuT1pNSHM3eTUrVVEyREYzY1FSZmk0dVI4TFJtLzNiRTFyQ24yZGlY?=
 =?utf-8?B?eVJ3TDVIdWRhcVM0LzBMSy9CRmdzR0Y5YStlaW1TbDRCMEJxMmVTWkF2Z3Jp?=
 =?utf-8?B?d3VYZ3FvUkxJQTQ5VFlkNEpSbCtFYlNiRndTNVI5bktjRW13d052Zzd3dVc3?=
 =?utf-8?B?T2JudFBweDRrWnNOSUZxaHFpdDRGQldpZENOYVpvV2JFNUNJMXRwZkh5MTBT?=
 =?utf-8?B?V2t3QXIwcmQrcTluNGVKOTNuNjg2azVnTCtFQ2lSQWx5UnB2SmNIREI3SVJT?=
 =?utf-8?B?cm1EWjVMaUpUbUFmMjFBN0pKVEk3Q21wN1RTVUh6UnJyMWJNTDZsazc5aGNq?=
 =?utf-8?B?SmNoWFpnVHp1M1ExRFpBNjJyVXpnM2dEV3drTGJ4TktpSHd4LzYydE95UytU?=
 =?utf-8?B?UzN6aDhwTGtFdmlwZituSlh6dzlndUxpV2lHc1hRWlBCMnlYbHUzVmJNZ0FS?=
 =?utf-8?B?Ym4wUFhBR0ovRTkzK0R4ZnkrTm9naVdXRVBDQWFLZ1BDYUF2dG4vUXVXMUFz?=
 =?utf-8?B?TjMzVmlyQWlZOWZvKy9ZczNIeVU4czA5aXYyTjFEQWt1QzM0azVWbjd5TCsw?=
 =?utf-8?B?aDIycE5uaE1xc3RTa3lFSUJ1WCt4OUpwR25YWFpBdC9oMmRwcHc5c3VUSFhU?=
 =?utf-8?B?MDR6ZVZlVGlkQUdkaWFpSnI5K3ladnFOQlJaS2ZQNVdVTDdSMWR3bkVkKzN5?=
 =?utf-8?B?eEVPQ3lHQ2U4dE1QVEtNak1obitwMVRUemNld2gyVnljSHZlbmhLckQ5M2NX?=
 =?utf-8?B?d1FPVm9ZTjJRUHM1SmhQMWpRbHhIaHFuZE1sdnVGN1hRckZIZGVDUXBhQWtV?=
 =?utf-8?B?bTUveHBWdjRPQkNMSnYyb2toZ2ttNWIzL3V4a0JSdWpwZDZ3d2g3VXBQeFVD?=
 =?utf-8?B?S0pBcEUvYlZmMGRQdWZZSDB2c2NoUURaSG95OERKbVNDaHRneGsrcytNZCtC?=
 =?utf-8?B?YjRnZVBLT0NvTWhKZG9JN3pZREFVV0k5WmpIdk1oQXZQMzY1UmloZVBpQTRk?=
 =?utf-8?B?U3pBUldWZEtDUG1WN2tlb2t5U0tXeG8yUHF0QXArNkpxWHNvRUwxYUZTaFlD?=
 =?utf-8?B?b1hRWk9MS0o3SlNuTG1CaTgzZ2JqMnR4ZzhlMkV0bGNYWEZIUkZnZGR2dnB0?=
 =?utf-8?B?cXprelc1bDdiNEliU3g4OUk5VmVxT3JMSEpVTDludTJwK05UNVlUU04rb0p5?=
 =?utf-8?B?VDd2MVpwaWJCMU0zdURNQkRVMk92Wm5WY3ZTUlc1T3pOR0E3TE5HV1pQOHB0?=
 =?utf-8?B?TzVGQWlPN0wySUpwemZJQUhjTlRFRnJFWGZNSmZXQjZ4WE53ZzBOR0oxNS82?=
 =?utf-8?B?YTlkUDZOaDQ5SDhiQ2FZcktjNkw3TUhkV0pHTURpcFp0VG13ekFRZ1RZS1l0?=
 =?utf-8?Q?j3PnuUxUf/73Tbs/o5xNsYYX/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcc5706-4e6f-4ef1-fb2b-08ddfb5218b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:06:57.8729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNMHzlP9irSV1v+rHMvA3nX5xxzvy4Js6VOw47LL9qehf8HY1BhFgr3wGfxq+jW7ENjKyWZwXU4nq0p6fLrypg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9745

From: Alice Guo <alice.guo@nxp.com>

Add OCOTP device type data for i.MX94 SoC, including register offset,
total size, and fuse bank layout. This enables NVMEM access to the
i.MX94's eFuse regions.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp-ele.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index 7807ec0e2d18..7cf7e809a8f5 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -186,6 +186,25 @@ static const struct ocotp_devtype_data imx93_ocotp_data = {
 	},
 };
 
+static const struct ocotp_devtype_data imx94_ocotp_data = {
+	.reg_off = 0x8000,
+	.reg_read = imx_ocotp_reg_read,
+	.size = 3296, /* 103 Banks */
+	.num_entry = 10,
+	.entry = {
+		{ 0, 1, FUSE_FSB | FUSE_ECC },
+		{ 7, 1, FUSE_FSB | FUSE_ECC },
+		{ 9, 3, FUSE_FSB | FUSE_ECC },
+		{ 12, 24, FUSE_FSB },
+		{ 36, 2, FUSE_FSB  | FUSE_ECC },
+		{ 38, 14, FUSE_FSB },
+		{ 59, 1, FUSE_ELE },
+		{ 525, 2, FUSE_FSB | FUSE_ECC },
+		{ 528, 7, FUSE_FSB },
+		{ 536, 280, FUSE_FSB },
+	},
+};
+
 static const struct ocotp_devtype_data imx95_ocotp_data = {
 	.reg_off = 0x8000,
 	.reg_read = imx_ocotp_reg_read,
@@ -209,6 +228,7 @@ static const struct ocotp_devtype_data imx95_ocotp_data = {
 
 static const struct of_device_id imx_ele_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx93-ocotp", .data = &imx93_ocotp_data, },
+	{ .compatible = "fsl,imx94-ocotp", .data = &imx94_ocotp_data, },
 	{ .compatible = "fsl,imx95-ocotp", .data = &imx95_ocotp_data, },
 	{},
 };

-- 
2.43.0


