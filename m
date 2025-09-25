Return-Path: <linux-kernel+bounces-833234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BEBBA17BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6AB189A518
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C551322771;
	Thu, 25 Sep 2025 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a8PCO/K5"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D132253A;
	Thu, 25 Sep 2025 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834864; cv=fail; b=G4Ft3dI7VPWTYAxUP8u6g/5kY+pqreVAxYXLWo3r6yAheG7s8h3mGvMNDVy3N3NNOSNb5JMiZ0JkrzRUlBkBoFK1lNlSZJXxHn7974pW1EaZt5IMC11D69vbphrVRDAh48+NZYM+3EhXm0m4nz9qW//jGIDYXJvbqAYrbaiWY18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834864; c=relaxed/simple;
	bh=oVUUTzXEys0EGLaNi6pqcX39W4KcvXr7QB6CkAdgx/k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nshZe+eoRQT9VvQqHw/hISEPRRoXkMDtRvTlzFTY5utpgbp9GOqHizKXRtcNldkMkDLf68SWHjJHi/Y5vEt6cbAOJhKkhcxk9Be+2MBoyXRlCSEg0AkyMMiVdrB35/t3A8nvWL6YeaAlyNKUBu9nmuqhiQWFpg9malov5Bgjdnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a8PCO/K5; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6BKlea2Zeeh1HHX1jcQftwHCzUz6ZAzsPBKxm2qH+5r/ga+RzT0ZOUm1R6f8eXw9SUUhm7kOgAMWwNClO4I3xWvG1ojSIcj5so51t3QgoKdtKocA7hXvBwRe3clABXGyIIPvs7eO/8a0gnNKKHIL3Obcjvik7tbvDUj8RkyUWbYAu6KXvKPHT4BM3raRUCqSIff06+fNwBzhEgh9A7zS9+sIdQfPrnuAXOP12gAb0ZXXonsbJsL+FjnYCfvsSwD+cj35owO3WixJ7PW9WqqLxNs720jrF01L8CK8Bn+9hodNL1sNcVqA2pIXkFC5tJfqOoNyOQBQWcOHTBeMW5XKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzixAsWVBHBotlHxvcqhoEdO+gcVwq8N4sYgjnTSg4Q=;
 b=AIiS+CiX6CYvxUIO3JKuwZekstSmENt2ssJqS3bQRv5vJZ3QodB7uWbzsANHzatziOiSePK1SAYkmhAuf+AQrvER4DivRV/XZd4Vh6x97uOQ0sCg4tlH/cy16neTc8pqnnDe+Ut4VgDjts+lUnQMMWTOf9h1wKmCxdZXUZiAXLOA6Y1dsFtyw/paeqQ99e3gUMXTTKp6sDHrAZBE4hDbgam9dtOcwfwbtHSttxh+4Fbbf/cp6sZf+CCDv1tvCqoO1ElBHFEFfZmWTAxnqMZAYa07zMO7NpHOKg/IkLsg4RPLrzILNEQU53wvdAiYxxV0wuQ2DM6f9XO30B8j3Wqdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzixAsWVBHBotlHxvcqhoEdO+gcVwq8N4sYgjnTSg4Q=;
 b=a8PCO/K5np6NFvfurc39m5aFtO4QG/Qo384AltJ1xQ+3OEm6dtkRr2JEEF2EeVI19l2yGBD1IS02ZMHZISI1ETB2Q9jtnyYgOet4odo6jFSsbbc9NbPDztHYf+1Q6EpYIpGJS6qING+2jViOlHr2hAbwGBEwuy9imZqmpe3oOshJt7RfhtfkWl7sSFMUY+g0XBqA54Ejde4gcOZ7Cfe/obLLJLPZjB3Rx/c9DWiNVq2/kJaYLwlnLSV5POWrFoXh8QKOt0QDl+VshmTcV3FXl/U87qzjDXO6YZzw+Nl2eTFa66iP2sdlxGbfcnJQD4+wzfPXpCXOttUIJmXq2NpaiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:14:20 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:14:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 17:13:49 -0400
Subject: [PATCH 05/11] ARM: dts: imx6: remove gpio suffix for regulator
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-imx6_dts_cleanup-v1-5-748380dd0d22@nxp.com>
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
In-Reply-To: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758834839; l=1691;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oVUUTzXEys0EGLaNi6pqcX39W4KcvXr7QB6CkAdgx/k=;
 b=YX/gkJ7wcAZz7YlRhrDleOgvMz/rt2djkwUMOS/nclkHSDUHlvGkAG8EO85VpfQmO9Zky8gLf
 Wq1y/rwcs8SAlMMIviN0yysq1MoS+7/HGUCcgKwBXpcO5H586oS8BUZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: fa432f7c-24a6-4990-1ac6-08ddfc787e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUlMbHQ4a2k3d0pFSk4rdHZSYmlBYms1dktwWTZUdFRXQ0t2N0wyMXhzZ2V2?=
 =?utf-8?B?NkQzUWdPL0tzcGdXWVlWczBpb0x5YklhL0hxSHgycXN5TzlOUjB3SklMSUhr?=
 =?utf-8?B?YmdUWTQ1ZnFSU212ZDVJaDFSVWl1WFdHblYwR2s3ZmVxZzlUSldGdTdxRHZJ?=
 =?utf-8?B?S1N2dmlmL1pSUTdBeUlVVm9NaDdaWmxDTnFHUFk0QUdqQWZZVFQvb3Fvek5V?=
 =?utf-8?B?NGY1a0RpeVdzdkZwUHNpY04yWlo2Ny9FSXVEYWp2QUdQZjJWOFVNa1l1Ynkx?=
 =?utf-8?B?cWhZdWN4azhKU2tGV05WVEl6RmJPY3VUUEtQQlJleVhTYmdFRWxGKzJwS2Qv?=
 =?utf-8?B?U1MzbmVJMkN3N2tWcXRjczFzRWZweEJBblFtS0hYL1k1UE9xQWh5c2pKUEZO?=
 =?utf-8?B?bksyWmxKQzM4UmJuUTg4N2ZiYnB1anR2cFRKMDA1SFdhamlSYjAwR2NPOW9q?=
 =?utf-8?B?ZVN2NmxnRkdOZHF1QVpJZ0VWREZjNkx2T1poRFBNRmJWcGJ5MEpWSy93b2Ir?=
 =?utf-8?B?dkZaTkVFZXdBUmQwQVJDUEpXbDkrZVdYaG4vZkFIWkVka2VvVnAxU2ptb1Q4?=
 =?utf-8?B?dWZ5L3dwUDlxMENIUVQ1eTRvSnE4SnRPU3BlakJ1UCtkblBXbGMvWkFsdmMx?=
 =?utf-8?B?TldXSlFheHVaTmVTdlVXSmc4WnNkVXM5bldYRU43Z0E4ZE5ROHBVaFJhUU1U?=
 =?utf-8?B?dkVsYklDaUkzKzZoNlhza3I3M3daTTVFcUFaazBzZ1liOUNqYVIveTJSNkg0?=
 =?utf-8?B?dUFvSXF6R0FKamdBYVNTTUpYVTBXcVY5QlJlU3VpZ1ZTVllxd3RaL2QvUVE5?=
 =?utf-8?B?SThMdjIxckZhYTh5RHd5RHA4Z1dxRWtWNmpQbHo1d0RBcStnQzZROWp4a29R?=
 =?utf-8?B?Q0RvS0VUNHNjUWVKYlJjOGs5bUIvbGZHcGlORGpTSG1yaHg0ZFNPYjBJNlNM?=
 =?utf-8?B?cHZINElNNVFpSFFSeU41cWxzczZ2bWN6bU1qK3V5RmJtQ2JDSEZQbUpEK3Ar?=
 =?utf-8?B?SEoxU296dXpERnZobnBjNzdheHF6Nmp6SzVQZlNzWFZEQThTbWhYMnV0U05y?=
 =?utf-8?B?ODROTmRpQTZPY3gxRkxUOGptL1hBTVdkRnBJblcvcHd3Y056L05MTU5rVVg1?=
 =?utf-8?B?REJpUHRCYWw2MHl0RUhlT2V6Q2M5YmR6Rng4M1krTHB3QVVyY2hkdTUvRThI?=
 =?utf-8?B?aGVqMVZlWlV0Tm55Z0J6SjhUY2Yza1FNM1JpcTJCbW9SYWVuQmkwSXlubUd3?=
 =?utf-8?B?WVRIZFJxMWwrcHBIOE5hNjllMVlvRHdVeFlJWUwzMjlHVU9WWjllRmJEYjBk?=
 =?utf-8?B?UGU2ZDBkSmZBbnk1dlIwUnE5R3RHRmZiVDFFeVFNV0NuaXBiRFNBRHNhY0dH?=
 =?utf-8?B?anRCcnQvYkpFcXBtTVhlYlIrVERFWTd1V3BhdDRONmlTcUZsT0JJMExwMjly?=
 =?utf-8?B?eHlIa3pKTGs4aVlyaFRwa3NiS1Z2U1pqSUpPaE9LN1AwYSttN1h0NlpPZGtL?=
 =?utf-8?B?VmdpQTlXWTIvTHg4M2d0MC95bHZBeGFSRnovbFgzdVZqRmVndVVFT0pEMnpm?=
 =?utf-8?B?VnRnYTUzNXUvTG5mMXZlRGdnd09aQUl0N0s2a2NxN1ZlYVF2YVVhT293eHFq?=
 =?utf-8?B?NEtJS1RBSVpTT2VQUWl0NERoMXdWemZiT1ZUcVBUUDhpQkM2TmFQQkVWQ3hy?=
 =?utf-8?B?Z3RDYkFLRHRKalB2R0gzbDRESXZCeU8rTmYxUWhiTUdVcG9pL1NPTCtUSHJ4?=
 =?utf-8?B?NEVKbEN3b2JSanMwTFpDMmQrdVh5eEtnVk1OUWtPM0I5bElKN2ZGUTlEUFJs?=
 =?utf-8?B?cjdmMURQRVJzS1dyU1BZWTI4dmNsN1lyYnkvMFpKcy9SZlFGNG1HejlSaWZo?=
 =?utf-8?B?Z3JrS0hSUHBLVmhJakk5NnpnSUt5ZVJFblJoVmdSckJjQ0wyZUlockZOU0ZL?=
 =?utf-8?Q?06uIE8U2soQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amZKMWxiQ0pnbHM4L1RrRytwV2hBeVFKNVJPNVdyUXIvd3NCT0FFMUM3UmNr?=
 =?utf-8?B?RzhiRlZGNlN0TDhEQnp0dUpNTWN3ak5wdldGWXV0YmxrY25ETk8vKzFkSnkz?=
 =?utf-8?B?ZUhrUURGUWVObXhjTDBoVkgyUHMyYWhGS3EvSVlxUzZJaVVvZDlubUk1Q3px?=
 =?utf-8?B?blhmMXI5SzZnSHNiQTBZZHRHV3JxMkhuSjVSYTVvNFZUSXlrbFRRTGxnT0Zs?=
 =?utf-8?B?bUN4SUhRT05MMHEzZkNTeFh2MGxHN3c1bWpZelc5SlpUQUpnNGhWcWluWXcz?=
 =?utf-8?B?enFGUzkxZTRaYUlZM3JHZkNXbGxqQXprMHFycU4yRXY2YkRMV1dPbmRtMmFj?=
 =?utf-8?B?UVdXVU9BK3RaMGdrYjBTOENUZ0FpYVBxQ25Vb1dLK0xRaE9PelpUaGJka1Jk?=
 =?utf-8?B?WVlYR1JlMFNud2F6U3JCMEpHaTMyT2ZqR25SWktOaWdxSHlvZG52WTk5SmNE?=
 =?utf-8?B?VGx0YTc3ZWY3bHBjNi9OcThHYUtVbjBwODVGZXpKMkVyZDE5UGhwWmFvL1Ru?=
 =?utf-8?B?VWVzNUI0MEZzTEtGcGo4cXd6UXlML3k0T3gvRFIyT3kzSmozTXlkekxCSG4y?=
 =?utf-8?B?QU5SVGJmOWk0Nm5QdjcvcEh0d2gwTmcxVzVVVXJraW9lZWJKREEvR2psYUFZ?=
 =?utf-8?B?eTYyMENuM2xSbmRqWnI4dEJtbkFsZ21mMFZmcUNsK251eGhKc3pjMHc3Uk82?=
 =?utf-8?B?UFZNWm45WEJndXVWZDRUcWczZ01NSEZGVmxBRjV5UWtyWWh5WWJLZWtVSU1k?=
 =?utf-8?B?MDR3Rkg4cWFTSDIyMGRxeHh6R0twTVE3U1RNcDdzYjdFTnZIOHRwd0pLYk9w?=
 =?utf-8?B?dk4zc1hSQkJQWnczSVcyYUFBMlJnWXhLWEJSditiQ1Fwc0NWeGhnVlRMczBz?=
 =?utf-8?B?bUs4VnFydjVEaEJWQVNIQVNDL0tGbjFuakVGaWdyMitTaFExYThUK1pTWjFV?=
 =?utf-8?B?anRsc3VGYkcwdnBSb3F0c2k0QjlBZlBoRXRjaWFCTmgyOVZjWVRkczhJalB2?=
 =?utf-8?B?TEJuWVRiTXdHVXcvUlBrM3Ftem9qbmxVN2FObklwVVNOQlJzS2FIcVUzdTBs?=
 =?utf-8?B?VWJrelZiZjVlQWJhUWg2Zi9OUkVxNHBSdmNEMzd1eFRqazVWMUZ5M0JZNGVs?=
 =?utf-8?B?aG8zR3NCazRMNktQUVZzSkZ4TDVRc0hPazBoK3hMckd3WEViTUJCeHhkb0xP?=
 =?utf-8?B?WFM2RFF5RmQrZmlDRUUrRit5Tm8veVM0Z3lubFFUS2czNjU3SDlxUkc5eER5?=
 =?utf-8?B?YWFFMkFuY1lZaVBWN0ExS2d6d2FGa3FIUGhlbDZWaDd0dFRidjZYU0NQT2M5?=
 =?utf-8?B?eFFiOTdUa2dmeXZQM1prbGNGNFBqZTFRM2F5RlFkSSt4VWJ0ODZ1SDhsbW5T?=
 =?utf-8?B?WXltUmlBVmRHNEk4a3JRZ2NZU3RIcURQcXp4YlZQYmpSQ1Z1cGhvWndpUlFt?=
 =?utf-8?B?NlpoaWJCR3l5Q0Y1b2JlektsSmM2V0g4VGFDNi9QbWtidDBEM1NHejlTejhh?=
 =?utf-8?B?SkFVUytVM1VuczROM05wSWgrbDdTcFhScElmRVBJQWxFdnc0YnpHci9zaVJQ?=
 =?utf-8?B?YWdUZTY4MDlXdFNmcS9sZWhTSTNWRXhBL0VvM3lrbG1kMjZpNlhIZDlQNWVE?=
 =?utf-8?B?N1ZyQW1xSmozeUpXTjJHT0J2M0FTTSs2dzN2TEsyb3FhMzFVd3dqWFcwM1kx?=
 =?utf-8?B?aURkSjdxOFpMeThhc2dqWEdta3RXYnZBcC9IOHZIWTdCbWw2YzhnbjBDWFFV?=
 =?utf-8?B?Q2s4S0RzTmlMRDNUVWVSQ0RSUUtCM0xiVFZsdG5IR0VjaXF2dFJKZ2VBZmd6?=
 =?utf-8?B?Tlg0TUQxSWVJdU5UdTAvbSttUHNESTNmL21oNmlhZDBBWlNsQytoM0lkc0dC?=
 =?utf-8?B?cHlrc3pra0FwczR5RjRiaW1DMXIxR3h4WXhXRFFJZWp0RVhEa1lob0lqZEdJ?=
 =?utf-8?B?RkhaK0crYU9mdGRQZjVQN0VmZTB3dUh1Z2FZMDFsVHEreFhPL3NkUlNyeDhh?=
 =?utf-8?B?TURBd2VLV1NqWVRSTHFBcTZvWHpOMVpMK3BPTmROV0pUTExjRFgxb3VBNmVU?=
 =?utf-8?B?T0hsQlA4NGNJcU81UEpDM25SZ0pJTTU4MGUxRGRsa1ZPMm9Xd2c2VFJTRmx6?=
 =?utf-8?Q?nvrL5mT9dY7bBlUKihUwga87x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa432f7c-24a6-4990-1ac6-08ddfc787e29
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:14:20.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CixaQV0QXb33FkUHLSkV9SSpTLWufILSHHUQ468vif048d4JYwbN9ctrT/fMfLtrfJl4x8wEcVNBA6iJlD94iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

Remove gpio suffix for regulator to fix below CHECK_DTBS warnings:
 (fsl,imx6sx-sdb): regulator-pcie-gpio: {'compatible': ['regulator-fixed'], 'phandle': 69} is not of type 'array'
        from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
index 299106fbe51c4ac1e9e0a70a4ec12e16b8110497..789a9aac005ebbe20e600dbe7bc7262ccbf74c64 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
@@ -73,7 +73,7 @@ awnh387_pwrseq: pwrseq {
 		reset-gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
 	};
 
-	reg_pcie_power_on_gpio: regulator-pcie-power-on-gpio {
+	reg_pcie_power_on_gpio: regulator-pcie-power-on {
 		compatible = "regulator-fixed";
 		regulator-name = "regulator-pcie-power-on-gpio";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index c7aeb99d8f002011a677ee50c7c849b9aab91374..3e238d8118faedd39a923aa90d859301516cd00f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -119,7 +119,7 @@ reg_enet_3v3: regulator-enet-3v3 {
 		regulator-always-on;
 	};
 
-	reg_pcie_gpio: regulator-pcie-gpio {
+	reg_pcie_gpio: regulator-pcie {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pcie_reg>;

-- 
2.34.1


