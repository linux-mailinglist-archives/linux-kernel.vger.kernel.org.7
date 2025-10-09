Return-Path: <linux-kernel+bounces-846230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F286ABC7525
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F8619E1F6B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF00E2459DC;
	Thu,  9 Oct 2025 03:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IVuqQ92S"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7F241679;
	Thu,  9 Oct 2025 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759981730; cv=fail; b=WU+mK4NuWDeMPhb9Yd/MqpG/YcPsp2Qq6BT5HGowlr61NEDLWBYowHrZzyptI1AqD/y9yH1qDvusm6xbkOmSVF9Cfuwa5bh4JliAK+mhw8Ouic1WjS2ZiIk9uyz8hrON8snI7XGFMdrTnqkB2ezmWbYQ9ZpSbqpNjNQ4FZpvz7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759981730; c=relaxed/simple;
	bh=PeRl5P3IHKJMf909jjQ/u7GR9jCDfliupm8kEswxFCg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HnKfNK5uClv/+E5evAY4Rq7+FJJ4kKKCVDWLCUdPgfeSUQgcUTBQdyjaRNVURwDUfYhV4NSGiIaTusUCicAG5DB2Z+L31BDyQN0bVwFIHe3uU8kJ+W6SlImTGvk64KFdCOPtcamsKcm8FiIJwEGwXB2Mt0Q+XDe55E3aeweF/NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IVuqQ92S; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkZcx2MqQH312ug7pUTUj5vzY7DNuVo1AlSH5SBmIm75lIbVtRG4rgkS7hDEPI5/HV2d7uToP7MvjIZMtmsoqgzx4usm1fiBZhZteLByh55uzwKYD9QFPf0sofOjLHTfSR8gJFx+rskeA+kL/F3j7TWIEWArCTm1sZEulXf9PkYlFELBjezdeNd3K2E+yfv5Fw+zcMGKQQuTN5IT7plOhAINKPrZrwiXMPEJsohriC1gYxCZbpq0IB2v58skbH86NjUHIzwd8gn/xj0FIW0KPOL4QEs9TBbTUD0OBgvXZcSx/ECt5VGBNaD+IV+G2HuQ70j9orCYkoH59uSAvagMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RxnQJJTFP/qar4FBocvrDx36TKm9SbCky48kLKdZUQ=;
 b=J5Z2ogIP2GVzoYy/AnS/jjDk4lURAbdnjSk0AHLpWz3OMiYCWu1pOr2mQXngBbQclQCYbzfomW6k6ZUa0YEOrhgXkMnt0KkWvkP6TlT8KZsKXh3iwy9t3gnBJW5t2+yvkq4F8Pwd/aDxOkQ5hdKyaW9+JkgEskWQDY+ZHBC8wj1E6p6X6roLQSOntqZRcg42I3nEjGOeIhLvlpMCXMYxiwUx/SEE6ZlE9eLmYWuXuhXUwwHK0hvSQYA7X5efbpentiDlFWHlT7RfWfnL/G8AdrhsRVb6C5bIPfMvH5fpHBDcB51vXRXmZvru8x8e62G6blqX1+9HNa9p6tyO5wE61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RxnQJJTFP/qar4FBocvrDx36TKm9SbCky48kLKdZUQ=;
 b=IVuqQ92SSjKnjkj1VjPA62lvh7MCwmCeSHcEmyLJNlAtqxeMrcLF1OkTKfLr5G9RhYLPMAwz5k5VPVFsRAlcbwN4mnJUoUydlW+6xiuy5ASRlXNUpc3viynVaQ9QDfrEF96Xcaj2oy9KwIV5dtn1YvD94NddE9ZWqzINcD0oXK+8Ad/7MpQb1G9F6GIMx9VQUcHyqVQe2fM3jFXlWqPSEu4D+Y6gZWGFDb3Z/Xm5odNQsLzfnt6RuIifqmCnw7JCz/RTW4PlVu+7nfyzNIhKsOvoNMAH1v1g7HCgHU4B4zDuCqNa/K5c5F/mBmxI10H7QUiTQ5B//W4YCTVc0yonHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10217.eurprd04.prod.outlook.com (2603:10a6:800:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:48:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 03:48:45 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 09 Oct 2025 11:48:16 +0800
Subject: [PATCH v5 3/6] clk: conf: Support assigned-clock-sscs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-clk-ssc-v5-1-v5-3-d6447d76171e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759981702; l=2996;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=PeRl5P3IHKJMf909jjQ/u7GR9jCDfliupm8kEswxFCg=;
 b=hFQkr7l/i5hkgATvycq868+z8YTvw4HH0Pkbqp71Q/a4m50V+MAfImxG9H0vcpPINaMb+8J5z
 83WNxiGkgoiAJDrAFJcmGVw6+dx6PpBNC5pCtHPkO2q8//P6zuYSz73
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
X-MS-Office365-Filtering-Correlation-Id: e98757b4-1f3a-4a4f-b8a1-08de06e6bf60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzJEcStqTlBrVTlVRU42eFg2dzVObENXcDArL2J6QzlsaHpONE5DSm0xZ1Uv?=
 =?utf-8?B?WitXNGRQeURHZ2VHV0d4eENzKzY3T0dIVzYvc3krNnFEdHBjUXZCQ2hpckRV?=
 =?utf-8?B?dEFjcmFkRUo4MHI1dFJ1YlFkRW45UnYzNWtlZGZhZ2JaaWpJVndWVHlVSjVX?=
 =?utf-8?B?VFlLUWNUWWFiYy9QaFFWay80NTJsMEgwYnlpT0pqN21qTHA5cWdZbWpOd2tz?=
 =?utf-8?B?NDRMOFMwbDhmRHUvbDZadEhmSjgvZm11alY2QmlHYXljMHpIdEN3U1dRQzdJ?=
 =?utf-8?B?ekhaL0M0cHhhazN3WUZjL3A1ZW1Dd0VIZlpRTHFBT0hUekhBTFZYNEpXTjRh?=
 =?utf-8?B?dkpUeklmbHBCUU9rVkFSSUlXZUh1czNwY0QzVnp4MW5PV3cwYU5vYVdSeHBr?=
 =?utf-8?B?dHh0NjRTN3VoSklQUHRQUTRUV1NGQTdmTnFGODZiaFk3cUExRUY4OFFtSldU?=
 =?utf-8?B?ZHpuajBHK2M4eHRuWlR0cVRoenNxelNqQTdLYXo1MlFIcjZsZE84aDNKS2Uw?=
 =?utf-8?B?N0FsOEZaVTlidy82WlEyRDFDb1dpcXE2L0lvM1lqSWk3ZVQ1cFBHQXFxZ0Qv?=
 =?utf-8?B?UUtuTGNYL0ViTGFkajgrRFZ0N0ZsOHl1aFhjZkptbXRxUXJSbEJrNzZqRjFS?=
 =?utf-8?B?V1N0cDdaeHpuQjNOYkNabjN5NUpQMkw0dTdRTXp3anZVZVh4a01DQjlpY2to?=
 =?utf-8?B?K0xVSnVNUDBKcUJBbGh5bGFSUUxpRVZRcTBQTU9IRlZCY0N1SU0xTEtIKzNw?=
 =?utf-8?B?eVU1NkMyeVp1SnB5YmU4RzlmRmg4N0dBcDMrQ0daTDBzcTVWRW1sdnJrbXQz?=
 =?utf-8?B?RWpwbU5nblFDL2NwdUJMY296clhPSThHVVkzVERmSkdzck9SSGtwNjI0MGtl?=
 =?utf-8?B?QWFyQWU4Q0RDeDZwcjViK3prcDdlR0JZcDZwdTBzc0FFVnB1QzNKMWxEa3Q0?=
 =?utf-8?B?RDg0S1l2K1VYR01lZnZlOGo5NWUrZ1pEWDQ2TVBFa3h6YUdRT3JaWmUzQWR2?=
 =?utf-8?B?eVVUUXZENzh6d0J3emhPRHhTMjgxRzRrZGNxcE1OQ2xKcHBKWWpkOCt3N0Mw?=
 =?utf-8?B?VXpJRGhNWHBQemI5ZEErZFpDWFV6enpTVmR6d29sZGkvVjNGSzlxZ29CQkVz?=
 =?utf-8?B?RS82YkR1ZmVrcmQrZnA0VXIrdjQxL3gwYjBrdHhRTGg4RURmN0orcUlpbGZP?=
 =?utf-8?B?WTdKcWNtL2JzU29QZmxUYitMUEo4ZTdaMlZLS3BPbm1qTGRqTGpBNTJtR2t4?=
 =?utf-8?B?MXlsaUswbTFvRlBPMWNmSkdZcmc0RVE1Rnlld2lMZXY0djEyc1lRbUwyRzdS?=
 =?utf-8?B?aWtuQ2ppbzVGTW9EbFFoempFdkRiVFRySDYzM2NheXk2NE9PZWtwRDM1cEFS?=
 =?utf-8?B?dmR6M0t3cXgwRFRUL0tBcEdhMlFxM3ljUXZGdThnNDFLVmNYUWdtcUxiM0dp?=
 =?utf-8?B?OHhjQkdYTEVXVFc4WHRETk1qQ2VuNU1xN0ZjT3duakNnSVhBK2tncHdGUGJw?=
 =?utf-8?B?MTNuSWpCTjc4blhrV0pzaTF4dTJudWViN2p0aXVsenF0d0JBRm1YNGt4WTc2?=
 =?utf-8?B?dUNtU05CUWxYV3hYNUd5Y01GRXNmRTB0cUtHZDQrV3hxSEpjemgrcnJ2QTF0?=
 =?utf-8?B?YU5qdHFSbEQvcEZVOVRCd3huS0ltTVRaVjE0NTkvZXVCUFFKYUJFN2lFNVNG?=
 =?utf-8?B?cDllaHBrTUZVUW8xWUNta2xrcUJEemJRWlc2aUZxeDNaWVMyYjdzSVNBTkNB?=
 =?utf-8?B?R0x0bHlDRlJrVUF2Rm91WHVUc2lLRzQ5ZXY3OE45ZDdTbXJrUmlYbzJGbDdF?=
 =?utf-8?B?WlF1UFM4ZTVXRzF0U2taSkJlRmQrYWpEME5kdmJhYWduL2pHZmtNdFNLaG9Y?=
 =?utf-8?B?YllWR0dLMnJlNUEzY0UrL2pPTW43bHEvcWlUVXc5SjI5RENGTFFjc3VUZlZP?=
 =?utf-8?B?ZFRrUzlWSGcyZFQvcHVCb2FlTUJuSHN0dXpZZ3VNak5Pb3VxVVVoVmNLcDN6?=
 =?utf-8?B?cTBlTzkwN0VoUEU5SmdqenR0cVBxbTZUSkdSOTJUU1JKa0k2VW1ZQ3ZqOU1i?=
 =?utf-8?Q?6ynGUS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnFYREhUTTJiY2F4b25ZaGswM1JTTGtBWU9CV050Ry9sQnJYN0YyK2NlNWJp?=
 =?utf-8?B?MDEyMFc0YXpnaHdZM3dZdlBTRlZjZ2J3ZThRRmpCd0doQmt5TC8ySVM4cVUr?=
 =?utf-8?B?YytpNklCTWtqNnczR2tqRkRqNnRWZHF6Q3JnRmVrZmZGVzcxaERmcEN4aXVG?=
 =?utf-8?B?OTJMZis3V3J0dVdPYWVNTjBxNVIvb1hMc2JrempNOVExWVJISysySk1taFAw?=
 =?utf-8?B?azhSRkx2TmFXOVZBQWQ1WlFCVHd1WkwrL2dPNWlMSTN2dlJPTUpaQmF0VU9i?=
 =?utf-8?B?dXZ2a1l4Yi9FWEFXZ0pWY0NUYktXUkdjQ3dUMFFDb05KMnBQMkVUME05cTVR?=
 =?utf-8?B?V09PRkNlaGprU29LdGtkNTM3QmVZTDJiUkNFL3hFYUdSWG1oMExKMVpyY1ZO?=
 =?utf-8?B?d1VMR0VITk05NDcrd3VYd2Q2RU5ybVhMY1VRZXdQNDc2ODN1RHhBQnBkOHVS?=
 =?utf-8?B?SVRDbHZpL24yakpvcUIxeDZRN2lSenk1UWxwaTd1S2tkYlI5bWxlZGEvOVFU?=
 =?utf-8?B?QTRmbVpPUUxwQkhIQlVKNSt4cUNWUTgwSHZmSUpWSGR1WTV5VFE5MDRLRDZP?=
 =?utf-8?B?NU9LelZaWWRLdjZxZG5SYTRoL1FEWWdUbUNFZ0RoZDl1Q0R6ZjdtNC9SS0Va?=
 =?utf-8?B?eFZQQWdZV1A2RWVtQ0dCaWpMRnZWVFIrV2NqaG9LSVc2M1Y5NHdBWmRiY2xo?=
 =?utf-8?B?V2lKRFJsL1RuOSsxY3BsTnFGTVJLOW9BSlpmUGVBWXJZenVaRW9NRFRFT1Z0?=
 =?utf-8?B?UGdhZER1R3pwTTd6WnZzbFdsZmlndFlPTXgxQVFzeXNnZ2I2ZHU4S2JaQjhE?=
 =?utf-8?B?SGFVN1BwVG8raHl5SFkyVE9ZRndWUlB2RTBNZHVSbEppY05RbzJsVEVsZUlY?=
 =?utf-8?B?WjV5TUJ0UUdTYzdkRkVUVDhRREVxbXFrY2lVMmkva1d2bjRLNmNWTjZkMTBC?=
 =?utf-8?B?UjJSZjBkOG1seEtYbFRWQ3lSWnVpUXR6czRBZVhDRVIrTkdSZUJ4Z2lQZDBN?=
 =?utf-8?B?OUU0clBHN05uT1NMWUJBSFJ6dzdMTHBmREpUOWxQTE5GRE5mMHphek1SdEV6?=
 =?utf-8?B?Smg3ZGFPZ045RER3Um1UNGU4NzRUU2VRTTdzRVRDVHQydWNkTmZpTUwrbC9R?=
 =?utf-8?B?SUovMlM1NVNHN1lRdG4wa1lLTytPQTNKUDkwQ29qam1RMWJROGR4blZzU3Zk?=
 =?utf-8?B?UGFkNzZjZVQ5UHdrVUVybTI0RUZGaWN1Z1Vrb0pxdG1HbzZvS20yWE1OdXlU?=
 =?utf-8?B?bVZrK1pYNFh5MmZKSFVnZlVKRUNXb05XSXF6V3MyMUxESkN1NXZueFU5UG5m?=
 =?utf-8?B?dGc2UXBlU0VQZnZRTlQ3blFERXU3ZXJiTUQrL3Q5Z1AyWXd5Q0o5eTdoS3Rk?=
 =?utf-8?B?eDJab0VtRzV5L3NaMnB5Vk9wcVVPdUxUSUJXY2ZKVkxGMmxUMlAybHExeXp5?=
 =?utf-8?B?UWVMNUNqbVEyTndvVlFoWUxLd3UxcWhlYXg0ZHdRdmdkaFRsL3RIM3ZqRVls?=
 =?utf-8?B?RmkrdjMyVmlmNWlnVWtQbXFKU1VJZ1BoWjlIemt1UkI5c1lVcG5GSVdMWUZ3?=
 =?utf-8?B?VXJUQStFM21VemtOT3pZTnJURXZxLysvM3R2ZHczLzFsR05mMmtXemlwcmtq?=
 =?utf-8?B?WlFycmU4ck1jcXpqdUVLM2w4R0EyRlRSZ3BOOXlxN2ZmOUlEQVJ6d2s0VkJj?=
 =?utf-8?B?cXRORWVUeGVrN2ZuTnFQZnR1R2xTSm5Gd3g3SWlQWHZVbG9oMVdudEY3V2F2?=
 =?utf-8?B?WEtrUGFaQXk5S1dQZmZCbk1tZTVobVR0UWJGeDk0WU5xSFBSSTBTWklhL3U0?=
 =?utf-8?B?T3ZGQTIyb2dJTGtMU3FMbFhmU1hLWGFuek54RHFZdnkyNjJJaFNkMks3ZlFv?=
 =?utf-8?B?L0VvdkFWMXpmaS9leUZIRmh2WTBTaTNlNGhLSkNhSGlLTllJRTVBL3M0WnR2?=
 =?utf-8?B?bG5xMWNHUWhQaVlPOUlEdGpNN3NmaVFqRmladlhBQ3d6dVAwUm9xSldwVU8v?=
 =?utf-8?B?VDFRSjdBcCt6eDhCRTJoamRrcURJZzNkaE5PWnlIOG5KYUErVzgyTUs5R0tG?=
 =?utf-8?B?Ym9wVWhKa3pWQXM2b1VLK3oxdEh4ZXNHdEx4YnN6dVlSeTFRZkdpK3N6L001?=
 =?utf-8?Q?JX6qBxj00gt2rlp5+XqMs8chR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98757b4-1f3a-4a4f-b8a1-08de06e6bf60
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:48:45.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUCp8I4n4MSdNBhRL6POkxCZySdBHSAUtMC8i3l5S2M6b7OCIEiTkafyNc4tazfR9efeAVQwe+OBYYK0sp7E1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10217

Parse the Spread Spectrum Configuration(SSC) from device tree and configure
them before using the clock.

Each SSC is three u32 elements which means '<modfreq spreaddepth
modmethod>', so assigned-clock-sscs is an array of multiple three u32
elements.

Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-conf.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 303a0bb26e54a95655ce094a35b989c97ebc6fd8..dd6083597db3f8f27d86abf5640dfc3fb39a9b88 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -155,6 +155,71 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 	return 0;
 }
 
+static int __set_clk_spread_spectrum(struct device_node *node, bool clk_supplier)
+{
+	struct clk_spread_spectrum *sscs __free(kfree) = NULL;
+	u32 elem_size = sizeof(struct clk_spread_spectrum);
+	struct of_phandle_args clkspec;
+	int rc, count, index;
+	struct clk *clk;
+
+	/* modfreq, spreadPercent, modmethod */
+	count = of_property_count_elems_of_size(node, "assigned-clock-sscs", elem_size);
+	if (count <= 0)
+		return 0;
+
+	sscs = kcalloc(count, elem_size, GFP_KERNEL);
+	if (!sscs)
+		return -ENOMEM;
+
+	rc = of_property_read_u32_array(node, "assigned-clock-sscs", (u32 *)sscs,
+					count * 3);
+	if (rc)
+		return rc;
+
+	for (index = 0; index < count; index++) {
+		struct clk_spread_spectrum *conf = &sscs[index];
+		struct clk_hw *hw;
+
+		if (!conf->modfreq_hz && !conf->spread_bp && !conf->method)
+			continue;
+
+		rc = of_parse_phandle_with_args(node, "assigned-clocks", "#clock-cells",
+						index, &clkspec);
+		if (rc < 0) {
+			/* skip empty (null) phandles */
+			if (rc == -ENOENT)
+				continue;
+			else
+				return rc;
+		}
+
+		if (clkspec.np == node && !clk_supplier) {
+			of_node_put(clkspec.np);
+			return 0;
+		}
+
+		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
+		if (IS_ERR(clk)) {
+			if (PTR_ERR(clk) != -EPROBE_DEFER)
+				pr_warn("clk: couldn't get clock %d for %pOF\n",
+					index, node);
+			return PTR_ERR(clk);
+		}
+
+		hw = __clk_get_hw(clk);
+		rc = clk_hw_set_spread_spectrum(hw, conf);
+		if (rc < 0)
+			pr_err("clk: couldn't set %s clk spread spectrum %u %u %u: %d\n",
+			       __clk_get_name(clk), conf->modfreq_hz, conf->spread_bp,
+			       conf->method, rc);
+		clk_put(clk);
+	}
+
+	return 0;
+}
+
 /**
  * of_clk_set_defaults() - parse and set assigned clocks configuration
  * @node: device node to apply clock settings for
@@ -174,6 +239,10 @@ int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
 	if (!node)
 		return 0;
 
+	rc = __set_clk_spread_spectrum(node, clk_supplier);
+	if (rc < 0)
+		return rc;
+
 	rc = __set_clk_parents(node, clk_supplier);
 	if (rc < 0)
 		return rc;

-- 
2.37.1


