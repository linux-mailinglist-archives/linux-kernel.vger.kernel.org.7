Return-Path: <linux-kernel+bounces-820267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C87B7D42A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36594170926
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C35630E0C2;
	Wed, 17 Sep 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P1v1s5f+"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5930C34E;
	Wed, 17 Sep 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098573; cv=fail; b=gbPU3Wkh40aGg2/YmN8ZYVZlcK8YxitJtCkk54nyTk3mqqKqdzMcb3AR7LG7y/kuCcF7sBwWmd+xLAk3KXn5vNBvFvVjbWiK+K6pCt5TRXa/3eoPDlB7D++mXP2DNM0cTpbPEqcVEmB3k35FE+1+a9bpEG1/JMMvmSMT4piC02Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098573; c=relaxed/simple;
	bh=AunRVSW5+ZYxqJD8K20yHWUfsZu246J0f4T7seDVsIk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rH+qKCUANr3Zf4S8iaHQ26ZLUyx9MR1VbAyDlxGqEMAtj6Jnsuu+AidSbKbU9lFrz6nts0TMHUDkCa7BRauBUJWRKPpS0VufIYLRj7hkAcaVDaWOca+mnYOBABD3mey9QbbWj1JncfyO16gnjDXvUWE6dX4B+JZBT6Ajckvx3wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P1v1s5f+; arc=fail smtp.client-ip=52.101.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBuNcx9XzzLRxK4JTWFvVJeJGQUJTGpL0+dL9YtOIoN4BHhgElZoIE0uc0PILKZV+2ON9FxyVfTi9fKk9lAgBHwn0SlsRGEUO27gxpGortgnVL331ImmQRsS1QdDTu2TXFXsddC5/ZzcMmWbarblOMUKRgOcaj+tnKa089Nqz4sTbXSjDnOas1YwbuprlR4hFlqah05mv6A+29IZ6XNcCOV8LO+tiKWFK1oT9/+q+Gs0utYOzRL9PiUL4zdlpha/w7wGJ6gamrtKT5fAYxz1x8PaE9wArvJOcWlVnblsPrko+xQ+I7/EE0vgy0KiHyHAj22tkKANhCTtcTTA/tki7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GjOo+TxTvi4lpaGbM/Hb/NzmRzZqIjE9wsvXvcCwtE=;
 b=yPEvV55esblvr4aAsulKe473uzvxkMdoDMiU+Gducin05MOihByqq3AXDiZHhCzNYQs6f0Fi0ReeM1F5RgIjRy1dysIg+nI7MLg/zkH//Apr37+K8cYo9VCc2ZtFEyuzjSb4gS8Y4U0q9+GnQIwvYItXp/raPhb6wwocz6g6Z6r9w5BuMjY7Y+4WNOpYmtBFCgfA6tTpu2J8fMe1267izcejRVXni1BaxYMmnN8rCpbZsHOrRKgtaZWB07MCncFN8ck4guFy47mM7qfZ/eJGxtvxX+i2zWUiN12IQDCHSIAIH+aY2qVrGOOCMHb2ProBDhkF3rIAPqwdvb74DhJMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GjOo+TxTvi4lpaGbM/Hb/NzmRzZqIjE9wsvXvcCwtE=;
 b=P1v1s5f+0woDD8JoWwff22r5BnKk/xyeMpMnVn1mIeQs6Fe3+tyUTMLQLXNcSLjqKnM6MlOezTbjljNV9Ko3VQiGGaouzXborygs8HYFvVDGK3+bc79DZ4mAU77N7v3wcjDsS47K2ggPy7Xp/JdyH+3FIoffuh0xoWn4rTbxFRWGh0w/QuBp2aRKkCEf9rEo8ZkJRS+da0q0eBoEAA4KtzAofbTWmG+3UY1eaPIkzQGcF3A1aWhprqB5NYGL/z/sI8033zBe66nsVdKqI76AuAqtu/AMDfYQHv42Bu47PJO1r+ydVvvoRW7X7IOUt35Y4kHWLKmpeltebZytl8CcjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10818.eurprd04.prod.outlook.com (2603:10a6:102:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Wed, 17 Sep
 2025 08:42:49 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 08:42:49 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 17 Sep 2025 16:42:30 +0800
Subject: [PATCH v2 4/4] arm64: dts: imx8mp-evk: limit the max frequency of
 spi nor chip
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-flexspi-dts-v2-4-7e2a95e3cf4d@nxp.com>
References: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
In-Reply-To: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758098561; l=1190;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=AunRVSW5+ZYxqJD8K20yHWUfsZu246J0f4T7seDVsIk=;
 b=avffLXSo6Xl5V27hllnu9VjDe17r9mljC80UEDS18u0FzFUlLqhiH8Wb3GXfRGe21JXfXEdA4
 rlSEuDdBopNAbDUmn2Bm/q2xJgau4i9g/ZsOpb20IPPneCVLSoUDSr1
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
X-MS-Office365-Filtering-Correlation-Id: 2373a56c-26b9-4107-f550-08ddf5c62e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkc2cTVpclBxRk1STGx0MUtSQW1MeWZ6cERJczFLeDIrTHhpWXZOMkJrS1JR?=
 =?utf-8?B?NnRuZFhMdjNxdExMSjJPQzhqanlPb2xTZmVFK1BZSW43NkkzZ21Od0hJZDJw?=
 =?utf-8?B?RXhBRjY4VUNUSkRuNUJsYmhRTDZ1RWFFeGQvendZTFRGV00vcEZlanZGdGY4?=
 =?utf-8?B?UTd5M1FNdCtvUlJCSnFEU2wxUzVYSk81OENVMTZDRmthMzBBbjNGREZBVjV6?=
 =?utf-8?B?cHhvZ1hpS2l0T2JvWWtiNVZ1NXY2c3ZwS1pvOVBDTUgvN0syU2lvR0VYdURj?=
 =?utf-8?B?M3pTVmxTMFQrMzg0VXRPTExKc3lyMGptUGFvRm9DT080WVE0WnBIOHFLWXFt?=
 =?utf-8?B?YTNWYStSWW5ndWJYQmRVZm42dnkvak1YQUNUVGcyN0E5T2RQd2ROSDRHVzhs?=
 =?utf-8?B?TjFSZVMrWmU5dXFPejIvbC9xK0ZMLzcxQjk5TC9EZGxocm9XTHZpZ0F4ejU5?=
 =?utf-8?B?VlR6WFVQUWI3bXdDdXZibjBQT2dwZHFmSm93S3d1ZGNaMDRPNXVld3pYWU90?=
 =?utf-8?B?cVdQQnp6N1liNnh3Q1N6ejVEc1J3L1ZsOXNIQVRaMUlMV0k1djVsbXFZY3Jv?=
 =?utf-8?B?L3FiV0x4c0JiQXhVM1praWZJeVorS2xQRnowMlZWUnZHVkRqZ0dpUnRFV3ZF?=
 =?utf-8?B?UE9YZU1jeXF6bDNhQXlSQ2hVV3dldXFGN3FraGpPeGhiNVVTWDNtRUY4eXUw?=
 =?utf-8?B?YXRRbFRaazBGVHNXV2ZTSjAyWm85bUxqUmE3YXRjeUVkWTR6WFM4N3NwYU96?=
 =?utf-8?B?OXYra0NncmdSb0I4RlhJZzU1NlQ4SUlLRkRZd2h1WmczdzdRM0xIWkgyQXp4?=
 =?utf-8?B?ZFRoSXVleXYvUDkyTUozSk5qWTZPU0E4bUkrRnlldWpodXkwL0R6cmltTHMy?=
 =?utf-8?B?WXdlRk1jYnhNcXNxM21LQnZhQ1Bhc2UxZnU2dmdYWU5pUU1YMVNVdFhMSnh4?=
 =?utf-8?B?Nmd3dEhuNjJGcW9HT1ZsWXFVNEJoa2NFc1pCTkg4Z0VxNVZlR3JlYkovRDVT?=
 =?utf-8?B?WW4yd21tTzRCNWZrM1BaenBpaW84dnBteEZ2R1VBRWw2QTBrYXJKL3c2aGZq?=
 =?utf-8?B?d2VKUHNFRnpLY1VWWXJDUDF6ZUdGOUVIK0Y0YWdCTnlhTi9XNjJaUVZpYThX?=
 =?utf-8?B?Wk1jc2pScEQxdHRQOGNqVEtQZWxMZnR5NU9Idzc0dnVVMlRNSFEwQ2p1c0Fv?=
 =?utf-8?B?RVBQUWdBUlNQOWsxYkZjWitPQm9SbUhCUFZFNGxzNEVMdkFXbjdJYmxGaVEr?=
 =?utf-8?B?Mm12SW9XNnFiSzNpME5SeFBhajBlclF6UmpLYlZQeDBUd1pNR3dJelBScjVu?=
 =?utf-8?B?VmpKczdUdU84eGw4SjhZZlhpT1BBaG9yNFUwelZ2eGlwQnpzVHNkRS8yZXB4?=
 =?utf-8?B?a3pQUGFCK282R2RDZjlrWndyS3N0QnZ2aEs5ZWt2dm1oK1ByVzE0NDdLNUZy?=
 =?utf-8?B?NXdHRm8ybmFnVnMvcE11S0JoM1JIdTI0eHFsK05NVzkrNlpOZTdUL3ZKM09P?=
 =?utf-8?B?MjJjU0JVcjg0eUVvSkZoQ3ZhNFdzVzg0ajF5YzFzamovdnNOK2lYeGk1a0Zi?=
 =?utf-8?B?cTV2OFcrc0xGeU51aW9UL2Z5VE1LREh0SSt4Y3RUTnJEa04zUm9ET09ER2FO?=
 =?utf-8?B?T2Nxei82RTMzajBBeW9wWEhocUE3UmE4Q2FlVGo3cnF0U0tLNWNBU0tKZmhl?=
 =?utf-8?B?SFZsbnRydmxScnk4UHpZRUpKZCs0dWJXSlRrZ2NlSE50NEpabzBndzJuZk4v?=
 =?utf-8?B?V0hNb1dHWGF5WWZCYlQyZFZiaXoxMVc3dDc1dEdCTW4zNjI0Y0FiZkY5a3RS?=
 =?utf-8?B?N2VIcXdvekdHVjgvY3FEMGVEb056U1czNjJlZHhtNVkrdTZtNDJFeGYvQ1Nn?=
 =?utf-8?B?RzM0dzNZMFp3MHljZXNleGt6ZnFVWENUZEh2QlBnWHFGb0pCaWVJMmErSHBM?=
 =?utf-8?B?SW8vZDY1T0FFRndQbDh5QVk0dFhuKzV5ZUhIVGZRbDVWeEd2VmpPWHNRNEVx?=
 =?utf-8?B?MkNNTVdZWmxJSmZVQnJESWhGMFFGTVZ6NVZEbWVxZmNoUGV5Tko2OTZHRGQz?=
 =?utf-8?Q?dA9C88?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWVnZEFVZGlJRlNtcEZUbVJmc0dUcVB5WmVqY1RPMTBOeTNhRHN1aUEwdHA5?=
 =?utf-8?B?MkJINWFMWFhkeEpLejdnRzBackFNTkNxMFNqRGRvUjRmVjQzaStBMEgzTVUw?=
 =?utf-8?B?T1R6OEdTZmFCeG5VcERQekNPbkt3aWR3KzcyVjljVUFsVzhaQ2Q0NTZIUm9B?=
 =?utf-8?B?Q1VqdGNobDRqS1hLRXhRQlltY1FJalhQNVl6WnBYOTRYK08zTVZUUEE5Z1pB?=
 =?utf-8?B?MUg5bHp4VkdKb1pKL0JMc2M5NTdJbktrdFRlOHM1UVR5S01EaUtrWEg4STQr?=
 =?utf-8?B?YUNzZXptUjkwZHVaWVIvNkVDU1RsZFhWN3lZeFczdFExblRYeHVXWFZWRm9C?=
 =?utf-8?B?c2tqaXdlTXd2bjZ2TGJJWjZ2VTc1ZkhKVUU3a3Z5OStZWjQxV2poRjV6Y25u?=
 =?utf-8?B?eXpRcmhmanlQcHZEQUFHRldwMytGbjR0ak4zWlhuRWFKVXNqTXZnQ2NmRUhs?=
 =?utf-8?B?L0RCcURWc2g2OXgrM252dXhaV2cxVDlrM2lEcVJCcFFpN2hNZGc2V0VIR1lI?=
 =?utf-8?B?NHY3U05mQm9QTDZ2cUsxUTk3REFhbTRoMTFUT3dDZDdpdGJtQXF2RnJOUEgy?=
 =?utf-8?B?V2J1K0RQdzQ0cDhtdmpSbjhBWnZ3WUMyWm9meVVHb2gwc2hsc1gzZG5KT1Uz?=
 =?utf-8?B?UEFMYzhBZTIvRGZSNkVkWlpNWXJKaXhsbmpjSC9IYUd1YTBKRFJQRU1nY1g2?=
 =?utf-8?B?eVkxWEV2WHJRVWVPblprNEU4dURMYSs4ZXdzZGZVd1Vrci9zcURhMTQ2MnpG?=
 =?utf-8?B?ZjFjVFdNMXdNQXNBcGdpUlNXbkFCWm5nZ3J3aFg5RlVjbTE0M2g5bEdPek5G?=
 =?utf-8?B?dGxNbWVNdlM3aXEzb245VkxJbVhKSEN3ZEpzMG9NYW1qNFdKMjRERHdLbTR4?=
 =?utf-8?B?amRHMnBLZjJTWHZRZHRJY1pWQnlYUm5peXVIVUtLVmpvV0VZTFdLc1VoTWpL?=
 =?utf-8?B?M05Xa1RWMHpuUFY5NjdpR0I3azZLWkJvcC9WSjR2T2VjYVJGbThOWDhPTGRF?=
 =?utf-8?B?Q0FUUDdpNTlDM3E5elhXRVZ5S3RWb0ZsZDM1S0p6TnRJZ3JwSGF4M1RrRy9o?=
 =?utf-8?B?Nllsc3VsVWRFUG9wRmpsMDIxUklRcU9TaDRuMjF3WVFoMDlFR0VXNHk5Zkhp?=
 =?utf-8?B?NHhEY2pUakhFRkhFNFJoTVhTek9rd3ZGVVZPRmR0TVhzRHJvUlpqZ0xwbnBp?=
 =?utf-8?B?aEx2Wi9yL1J0R0Z3eUYzVnBUZnEyNHRSZExzc01GYVYwbDNXU2xhUXgzcnNt?=
 =?utf-8?B?aytMUkhSemRrSi9KRC9TVGl4di94TXV2VjVYdzdEY3dLbUNmN1MzN1BvQVdQ?=
 =?utf-8?B?WkdkTDB6YnN3V1lPZC8rL0M2YnF0SVhiSm11ZGJCOGFkZnFNMG9ORGt6eXU5?=
 =?utf-8?B?QjNTR2FqVDNJemJlOEFWbGZrdEhwQUxlRkh3czNOdXlqZ1ZXdElKQVk1VUlD?=
 =?utf-8?B?NzJlUHI0bTcrNlFPV3ZCTXhTcjVDbEVvUXFPbyt5YllNdWVJVFB5czFJYkRD?=
 =?utf-8?B?NkpPcWRjSmw1WTFuaW5CeHgzc2NlK3BjRWc0NUhPM1M4aFg0MGRxdE9FTGZx?=
 =?utf-8?B?NWNnZExtWFZ4U3BiVGc3b20yNkhwZm0vZnh0N2drUHQ3Z1p1VzcxK2YrUzhr?=
 =?utf-8?B?U1k5blFoOFkxMG1ITGxwdzdCR0V3alpPUko3UmpxRGl0cVVDcjhQZWs0TWtV?=
 =?utf-8?B?YWpZN05Nc2lHbFdLS0hpYjl1ZWYwTXl5ODcwemxuVEo5WWJ0QlJaN2V6R0Nk?=
 =?utf-8?B?bi9nRHFMNXlWZHYyWmJTeFlvQm5JTWNNeXVxeFh6UTJpMzJ1VTIxeU44MzF0?=
 =?utf-8?B?Z1NuamwvTGQvVHdkZk1HRVZLOFZIMFFBa05oUjhqQlg5U0xJbDFhNHB6Ry9T?=
 =?utf-8?B?bys4QkI3bWxUYktSOTRMRWkvbis5dDNiMkJockltcnRrcWJpWWVWS0t4L3dU?=
 =?utf-8?B?ajhYdXJaRk5yY01YbFhQUE1pRjJuOGI1UHVnUDVLcnk3THFKRG52cmNSTjYy?=
 =?utf-8?B?bEJoaHgvSldKQ0xBYkdCK2s2NFhQUmNRUlp4RUVMVENHL3phZ3FFcUI1WEo1?=
 =?utf-8?B?c0ZmS0NaT2REamVYaThKZEd3TmJmWkVYcWJXbURKMzRJUzBTendDYytwY2ZY?=
 =?utf-8?Q?cDrZxigBS6GXDoCcYuIkWNenL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2373a56c-26b9-4107-f550-08ddf5c62e62
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 08:42:48.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITq/nEtkt8ho7bSBfXXoQuWhMSIw2KPXnLG0QZ3BLmPjBwxsBuJKSKZlkOWFop4k2jRjG0WUY2ZsrBbUbo/ruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10818

The spi nor on imx8mp evk board works under SDR mode, and
driver use FlexSPIn_MCR0[RXCLKSRC] = 0x0 for SDR mode.
According to the datasheet, there is IO limitation on this chip,
the max frequency of such case is 66MHz, so add the limitation here
to align with datasheet.

Refer to 3.8.12 FlexSPI timing parameters on page 72.
https://www.nxp.com/webapp/sps/download/preDownload.jsp?render=true

Fixes: 7a2f7d763d94 ("arm64: dts: imx8mp-evk: enable fspi nor on imx8mp evk")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 3730792daf5010213cbb9f6869a8110ea28eb48a..0b47d72cae9900ad53eed04c810a9ea8af795446 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -272,7 +272,7 @@ &flexspi {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <80000000>;
+		spi-max-frequency = <66000000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
 	};

-- 
2.34.1


