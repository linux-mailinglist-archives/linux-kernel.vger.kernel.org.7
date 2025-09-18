Return-Path: <linux-kernel+bounces-822107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D3B8309D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180757ADFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197742D6E5B;
	Thu, 18 Sep 2025 05:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RVy4mqDj"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1329BDB6;
	Thu, 18 Sep 2025 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174298; cv=fail; b=cHXmONJ+yTyVV1lru82Dd8Kd8Q4twwDDe8PADCDNOU7W0YrgXG5Ng8rbCzIkuUW+vm2G+qosBI33IE82LMCxamcbMf5zI/L0VegdHchmFfK9Xu7lAhSOSCHZnxlKGXWGORZN2RP/bWC/+lod1tOpJuuSX0tPCeX8z7KK703a2PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174298; c=relaxed/simple;
	bh=+HvRtLZ7mlbSkm8tsOd+6MPehEptjiQw3jaica+cri4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=W5hCpK/ExwuKlQPozY7V7/lRmUGJSUDe50dVAlXlmRoP7hReyVq0Vlm7v4AN+5XIEfhy2uhhVuHEUE5CNrgi18dyzllKuw+BBzKepGRh7qdRLaAOoRAchtUPRMdm1sX5eDFYQsqLJr61XtaiQbTWp09cwb6i+19tLWWi8UvxhUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RVy4mqDj; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbcuyAYZ2+PY3W/QniLg0VQN9fWqS25ymebZwAVm66BAbRh77S+RlOrhuw/P4M2xxQ386ODiqi6T8bUUWibF+aYLrpW01fish+x25oy2T+PyUDo0lxbu1tdoZh/znyipc2nUPEE1fetZWumEwm+hcdk8voxk5ruZI2yODEwHAhg29NFryE+GlXlXtBkNfDnqFxuGWfbXreB9j/VwsEqnAxqASGB2Mlzk6IYgo4PBWJ07AUKgSuagI2W7jANTs9Zxr083ZCxgxlmmXbxZavcnIZ6pwjKjEXSQ4ZIf/l3eyI5LH4bwtaaQcRg5n6E9PRMuuAIOGrjkKilbOkvoWtUJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzGKWqJvBfSNQD2kQo9CS57v5S1YM1/rzGYBISlp//U=;
 b=b3XbJgmqSQcIpAQ7TPvcsFElsekCH0eEOtNzqGtYvvSdkSl3Qlc0PUZAk3UZYSnuHQER8YRp8cUANm1F2PDW/BANsfI62JAiL/hdN82DqlEKm/t2lhcXCqHQ53XyLB/ln2yyXtkpmH/NckzESsHOIMqtPA3BNskB4WTd1LTp8uHK1ndIK31Up4AS1vdT4uh7GJD4oTB71DdRXcZjmxOX+WVfTq7fOB3ATjUbWNZZgl+eQv2WAIzY8/9T3LtfKR9JumoIRqc9tINhuUky79Z/UaKKqfdTS4eR9ERe2mwdP222CjLIxKhuLfi4aLEFoHA4fdO5FehICX6sHUV2yqTbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzGKWqJvBfSNQD2kQo9CS57v5S1YM1/rzGYBISlp//U=;
 b=RVy4mqDjT6C2hXWD8OitmLMz0Ks9sfE2KtScaM8rBkf/7h9d5YFpV3cYirGxsd0+ksro8pkyjpgbh3VxDnsJtZMSZgSIN1jRXF4nrHH21nvSF+J9rvGyS125JXqjaZ2tyWd0NQSjXn5xFSukRbauHtdE4q4t2N3dxQpt+Yau90KIY4KZqbguQU1VCCNb1qK/i0pEp0yEWWJ0xooz73+n7O9XwRD8FyR+bJCs4x0GnWZu/9ci4IId9Y8qs5M0YFYoOjBogmfo69ZJUvnwdQNGaXqgegejZdDh7OjM5pUxpq9odg1khUGUAlqDfeziRbuD+O4xNIr1c8MblBcGBtnt3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7398.eurprd04.prod.outlook.com (2603:10a6:10:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Thu, 18 Sep
 2025 05:44:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 05:44:52 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] sound/arm: Remove pxa2xx-ac97.c and the defconfig
 reference
Date: Thu, 18 Sep 2025 13:44:31 +0800
Message-Id: <20250918-audio-v1-0-e9d0df5c60d2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD+cy2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0ML3cTSlMx8XQtTY6NEU2MTEzMLQyWg2oKi1LTMCrA50bG1tQCGvUM
 gVwAAAA==
X-Change-ID: 20250918-audio-8532a5344681
To: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758174285; l=945;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=+HvRtLZ7mlbSkm8tsOd+6MPehEptjiQw3jaica+cri4=;
 b=y9T28hQIGsO75SoPNaf9TARzNnEAFfSqlZSgf7Y4EgV53rMaWHUI4XAaNcT2qMxyGf01OG0MC
 C71gxUBn849Dxu5Viwg9T8Hw5O3DBMg5EIfI3lhUlOqL8zGAjpVqzM0
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: a931e1c0-6a3d-4e51-7542-08ddf6767cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2xEd3REWi8zMlhvNzZhWE5sNlhVdkpHcWNOREJhS0Jsa2FlYkdDSi9mMnBl?=
 =?utf-8?B?L0NPRXh1SXpoYUZkRFV1bHU3bEIyQ3J1R0M3SS81MUk4djIvT0VQbUlOOVFX?=
 =?utf-8?B?YWV0eTZabk5scGlKNDFMakNZNG5CV0NySXdwYnBwaWhUUnRZM0ZEY3NGL0VM?=
 =?utf-8?B?MlcyQ3YvTXpGK3l2M3A0czYxVENHdlNFYmVyclZja2xLVmtIRGY5UTBwVlVG?=
 =?utf-8?B?N2NQVU9ZcG9CZXRlQUFpMzYrMTdtc1YxcGdPdDBQc3d5Vk5NdkhjbllCbzQx?=
 =?utf-8?B?WUJjbXFEb3ZKd3dqY3YzNGRHVGg0S1RnMk1oUEkyd0xURDZSL2JFMlFqYncr?=
 =?utf-8?B?T2R0elN3WHMwU1o2Z1JseXF1OXZTazloeUlUZEZML3JNRVk4NzhOQkJLN1pz?=
 =?utf-8?B?aDJLbnBFVHVVYUF6VXVlZVFGcStadEF1TzNzMHZ1dTNpdkpKeGtySTl1QUdj?=
 =?utf-8?B?WWFIZTgrUWxHL3M5bFgwUFQ2U1FVNzE4R3hPOVNPeDhKaytWZllPcnNyQnZ5?=
 =?utf-8?B?dlRweGk4azdSVU1oQmMwVkN4TjdwNC9idGszVEJINjJDKzVEQ3FLZkNmOWVY?=
 =?utf-8?B?SW43WGxZbVRGYVowYXdBRXVEcmduTWpxS2FDQnhYdmNDaC85Uit1MnZxcS9E?=
 =?utf-8?B?Mm9BV2k4WDdiYksrUEdSdm1ZeGhuQlhPUDVLTGxEaTJlNlZEbUhvSVBubTZQ?=
 =?utf-8?B?SnliRXB6M2w1MG1PYUF4OHpUaHM5WlFPQ2cwRlFxZDd6M0M2NWtrOElLa096?=
 =?utf-8?B?NlEreTUvOHR5RnBaWmJ0cXRKMVZ4Qk84dGpwM0o2OWRTTHZ4cUhjaURVUWFP?=
 =?utf-8?B?eFZ4dTdLZDkwYUQzWG50U2ZSY2phZ2hyZ0x4V2oraGtSRHBIS0UwU2JSVzAv?=
 =?utf-8?B?TEZsTXZ4eXdmNkRXRksyeTRyTXQ1cUI0a1NEQVZVKzhOZXRLbnZ3THMxZXRt?=
 =?utf-8?B?OFRpRHhMK2c1ek9zQnh1ZEhRNUVRaFFHMnZJWjZmcWt2S3ZkYjZqMmdwb2pa?=
 =?utf-8?B?MkNDL2oxd21VWDBxeUUzR3E1Um1Gcy9rZVBRRE4rSEhiRjYwS2NSQ1B3UkJ3?=
 =?utf-8?B?WWZRSXhtOVdyVWUveWhxZ1oveWhMTTlRbE1ZQmNuWDBRa1FIY0hkbjdpOUN5?=
 =?utf-8?B?UGREYnhTeGVIUk5sajVMS0h0UXVZQzlVUDgxWG84dXZCbW1zMjFveHF1UzVq?=
 =?utf-8?B?VDhaZ3pjTEhWZUtwdXBDN2lmSXRrZEdQR0FnZ29vN2xMWmZ2eUtLMmJyUHFp?=
 =?utf-8?B?cDV0cURFc3hRbUJhcVFyZ21aNW9JQ0Eya2ZweFAySnBueTNOYjlSR25tT0cx?=
 =?utf-8?B?UGJTeDFsenBPRUd3UWd2MWJYQkpSTXh3T3FmVXRHbHpsY3o2MG54bGl2NjRv?=
 =?utf-8?B?b200b1Flc3RnQVhFNEFBNCs4cWxkaWJsL2NBMlkweis1TUdiS09oL1VmTFRa?=
 =?utf-8?B?Uk9oOG5Gblg0Z1BjM3VsZnk1bHQxSlJmT2txMGt2VU9oRk5KekVSeEJEemFI?=
 =?utf-8?B?ZDI1Vjg4RitjalQ3eTl2R0dLZHNmaXJ4cDJJbHRxYTN6QU10Ym9tWi9NRW96?=
 =?utf-8?B?djd4YW52Mm9BTnRuQXlZRm9RR2gxclg0SnlJT2lQREZOV2pyc1RBZk1tYnpH?=
 =?utf-8?B?Z1hab1FEaUZ4VDBRcnM4KzNtMWE1MUtzTGdyY05sajY5U3FKa1kzNEh3Z25P?=
 =?utf-8?B?ZzU2Y29IRXVlMzYxRS9IVXJMd0N4UkhBN2F0QS9MMC9vTzZVaThsbEFPV0Vt?=
 =?utf-8?B?eGxHL1AwU1g5eVBwZWZzbGZnc203eHRjWDVJa1Q0T1FSMTA3S3E3RGJ4VEpC?=
 =?utf-8?B?TUtveGYrUWZGSkdKa0tueEZSYXVBS3Q5WTlUYlZja0JLaUNVSFZVV1hZSGNa?=
 =?utf-8?B?eGdmeThDdlVvdURLZTMyUzRmQy9SeGg4ZkVhOXlWT3oxUWFpWTV1YmJPTDBH?=
 =?utf-8?B?S2JaNEhpZkMyckNhZVhsZEd2dHUzcGRiV2dQS08xY2kwREpKUlNNMUxzbVJk?=
 =?utf-8?B?aUhKaVJoSlVvRTNLVVNCcW1nL3puRE5ONVRFeGIzNnE5aFdOUmxJVWsxOWNW?=
 =?utf-8?Q?4Y0Dod?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0VjKzkzWm15cE5DK2FnT0xVQjBvd0RjM1I1eHhJRks1UmJlRU5kRE1lMmJG?=
 =?utf-8?B?Z3VlaHJ1S1N5R2RzU1UwemFFanlYbkQ4b1FHZUt2SlhqUnFtTXBqdFkxZnNj?=
 =?utf-8?B?NXJwVUhQQ1YzbnFqdVIxSzE3Y0dwbjlycFBoS3pwTGd1dmNSR0hCVkxPMzBW?=
 =?utf-8?B?OC9HUW9vZm1qb2JyTGtoOGVBZnI0WXYyLzhrTm1EcXZzVitHZ0ZnVkpwNXlC?=
 =?utf-8?B?ZnkxRVpoUm1Tb1YrTGxscm1UbVZ3RHlMd2lDMWpXSWN4b0s3UWxkRXk3NytO?=
 =?utf-8?B?N21sMSs0T1BMYlNuTXBsZUpPd0JseWtSb2JXZVdXS2d3ZkNZTFVOTXR3VDUx?=
 =?utf-8?B?aWNUb2tRT0I4M3ZCcFYrM3ZkN1pkRkE0MFZYbnVuUVdnK2FCOG4rZzJPNSs5?=
 =?utf-8?B?U3Fqd3AxVm1pUG44dlFtcDBEMDJFU3lkbHpjU0hESGlsNmFpcm5ESHlNdlhk?=
 =?utf-8?B?KzZPSkdVOHEvM3pJWGpPb25EOUVqSWU1ZzNzWVFCS1JJcFZreWJtZEdzVmFx?=
 =?utf-8?B?QXNFTEI2TDk5YVhLdTlxVU0wZXZTNjRWWVFuN1J0a2QzR2JFamV1dTEyZjRW?=
 =?utf-8?B?bUdQa2dhL2x1V0RNcHFDN1lNSGlodGVPUyt6RlA1TEhRWmxMMjZHU29Sd0xC?=
 =?utf-8?B?dngwK1Zrd0dRKzJYTG1VOGlDTFZjL1RpQWFxQkJxejVWcUdBTXVEQ3JXTTUr?=
 =?utf-8?B?MTRjOTZFR3lwTmJpd1UwYitmMHZBeU4xVStyN1hMMWlkUkw5OTdlRFZiZlkz?=
 =?utf-8?B?azk0OWJWYklhNGFrM2dLZDN2UWp3M1U2c3hxcWE2cXN0TTVnNmEvclEzWUYr?=
 =?utf-8?B?SExzRklEbEF1M3BwaDlkdjBKSzNKNHU2UjV6TjJnV25qNmhPTXRBRVdOUU1T?=
 =?utf-8?B?NkZlY2VoVkZ3ZUVKSllqa2lrUFA5YXJXQ3BYS2EwUlVXTnFUdGpTZTVEZDNm?=
 =?utf-8?B?Ykh4YXlyL2d6T3A4RnlHa3NhWVhBUm01TEtIbDRMYlNkMng3N1UyS3l1cWdY?=
 =?utf-8?B?SzF3b3RZM0p2MTRDbzREUjIzRFU5UGZiTFVMNEJMZzhOcm5qK0dTNDBGK0hG?=
 =?utf-8?B?Q01BNmpvNWRHaFVvV0ZsaVVFVGdabUtyQmFRelUxdkd4anE5a0JxT3VQcFNa?=
 =?utf-8?B?RVhBVk9oVUpJL0I1TU94WkhoWGRYdkVsR0pjMUxKQTdYczRoaFNHMHJzUzZL?=
 =?utf-8?B?K0NMU3ZYd2JudC9INURCSjR6NUV1MlRnbExpOUFHa3huMHlFbGxvYTcyL2dH?=
 =?utf-8?B?K2Npb0Njc0ordWg5SzMxOXpKTFFDMER4bHZNTjNnT0hGVnAwUjRiRCtSdVZE?=
 =?utf-8?B?aWsvVDlqVitOT3pQbnZ2SE1iRzhrVEpIT3JPdC90U0t2NjllZEdQU2VxVGRk?=
 =?utf-8?B?SlVyM09SU2I0SzIrOUdDQmwyVVRhM0RnSlBXY2d6aTV0N3JWUzNuaWJjb3N6?=
 =?utf-8?B?dnpVQ1hKTnE0bXM5R3JtY3EzY0ozVmNWOGVZaFpzdzBUb3FiT0xDcWtDZnVP?=
 =?utf-8?B?azk2cythbENBdWJlNThrcHRndlVGdGZrYkRTUlVDNjVqWjl0VXUzVkFsdlFT?=
 =?utf-8?B?WTc0WTlHbklrMnlyU3ZMQWdUeGllcHAzS25maVJxVjZuRytEM2Z0ejJmRytO?=
 =?utf-8?B?M2dKOXBXdFkzN09tbndtVHFDcDJWQkxvVDZ4ZThmcUFwY1lQUE9TU3dhYlBP?=
 =?utf-8?B?c3JkYVhXVTRXYVA4QUlVZ3BBdTUvYU1NOEdnZjF0eE56Mm5lY0RYTFlUemM2?=
 =?utf-8?B?OUYxNjczUVdYSjJRaWFkY2tVOFAwd0hCSU52ajVoVmloclhCd2wyeXZEVkpD?=
 =?utf-8?B?aHBhakl6MzRZZEgrUHViRnkzSHVERGVsSlBuTVVpbUhVS2JwTVQvMldYdUVs?=
 =?utf-8?B?OER2VmVJTU9pYWpxVm1uTytSeDVHblpiYmNNR05UMFZHdkFwOXl0RDJSOTFF?=
 =?utf-8?B?eGhJdlg2VzdneDBWY3hGL29ZZlJPVnp6cGRVbUZpNXZOY3hxN1QwNzFWTTd4?=
 =?utf-8?B?VHlLb1NTTEw1d0NMcXpjWWdxOVA0T29aTzZsVkNPSTZEOHh6MFc2NmIxY0l1?=
 =?utf-8?B?Um1oWHNpOTIzSzd2RVlJeWFHZmlONkJCY0N6eXRtZHZOaDVkOVdxTmEwaVNj?=
 =?utf-8?Q?lKC9r5b5AjYpFe1DMVbiydRW/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a931e1c0-6a3d-4e51-7542-08ddf6767cae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 05:44:52.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAsa6PotgK1ADS1PR0JFaOoo8QSOsWhFrRYkhaWZGfN087j2IK1hmjwkbTcDJRvhOUiYq56Z1NxDKiIU0ykenQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7398

With commit ce79f3a1ad5f ("ARM: pxa: prune unused device support") and
commit 2548e6c76ebf ("ARM: pxa: pxa2xx-ac97-lib: use IRQ resource"), there
is no 'pxa2xx-ac97' platform device created by machine level code, so this
driver could be removed. And also remove the CONFIG reference in
defconfig.

DT platforms could use sound/soc/pxa/pxa2xx-ac97.c

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      ASoC: codec: Remove pxa2xx-ac97.c
      ARM: defconfig: remove CONFIG_SND_PXA2XX_AC97 references

 arch/arm/configs/am200epdkit_defconfig |   1 -
 sound/arm/Kconfig                      |  10 --
 sound/arm/Makefile                     |   3 -
 sound/arm/pxa2xx-ac97.c                | 286 ---------------------------------
 4 files changed, 300 deletions(-)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250918-audio-8532a5344681

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


