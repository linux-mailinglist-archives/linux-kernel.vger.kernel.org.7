Return-Path: <linux-kernel+bounces-822108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E333B830A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAD34A3852
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B12D6E7A;
	Thu, 18 Sep 2025 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e9le4255"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B772D6407;
	Thu, 18 Sep 2025 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174300; cv=fail; b=HrLM9EV2qA3oQ3HOwcucNYbNOK4Al+QwfaVcaM7VyGBxoAA3ysidQ1XT0Ql0y+IId0XTaSrbp413rFfr/7M7vecj4fU/y9duKLuRSQjDuKYbLHPYLmsrWosoZCZ3oU9ZhtK0h54fH66kQS+dQ+6iMATYtv8UcQqTxyLujdo+uHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174300; c=relaxed/simple;
	bh=HbxiISTQ3eg1CuILWGIza5WVAELx162zndqEMuzMpcQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Bpq1Oi1X6jqmNCNHUceIe3GfzkknsVqLqIUiUjBRYOlWxAvL+Qk173Sn1YQqw1e69t4GPX5ChR6q5Jc+5IKF3UXgT5kp5jFp4ZTyQdeLPhm7CfoUxSnczv30eDkPkif5Fpg7h/KmdWKhlS3X+M3IH0oFlNmHYJKF098/4Q7wEAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e9le4255; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpskM3IkBZHztWvo6UpyVCOUz7zw2iWp/eNhOGKt6kHacdlwhjZS/XS+jITNpyTeKLSIgRUTf1LHwYWq9DSppLWym0fZ1jEYCeIhegLkErM4VdUrlR7yFmTZ408ul632Uvnn8RbaVAMJYEedv7hSo4cMsga49gsV8eeQyo4+bliY5v6P76qWzHL+5SONElkW9IkWaGpen30FCygDvCdpPdTKblp0b8Ss9a2kVSUupAizBzLnaz+uLLIzX3arXnwZJ7qVI4rQbkKFQH2rO4EbDeSNnwar9xzARtRfbV/Zl9/G/oN3MzdbGTkAeTx0W52Rbjpt3BHhodvBj+LAQcTAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IYncX3GlcUhVvM3FOiEZ32Pl7Dvri6sPw/gE05NHaw=;
 b=XEh1QAlcMnfvw8jh8ADWNbe5D604Cxv807u1s4HZ6Yy/+A3bDOAazT//0HGNuv1h6azS1jo/9HELrTyqsy85k7gbHfIbal03MzswQndhKz2TQNC9Dx+l/pCJFdJc8uXCqqqpKWKA1mvbJ3zhPcAu02xSstmwHBg/WkGNA/U3mDd5jamLhLlvAERg0XeqkuwD6RwrZi2mVStYIlkfbLw7JjBW0P4SnZhvljex73Zjfa+euLvRy2km+bIxn1OtJGI3FlpvP50JbQOu+oDoJa3SH1NEINMOg2ZtBytIZ9Nme7WkRIMM0x69A18WCAKZdFXKEB7l0w8BWHoIHUVR8tSKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IYncX3GlcUhVvM3FOiEZ32Pl7Dvri6sPw/gE05NHaw=;
 b=e9le4255DMw7E5KuOiKSk9DUMZ5jT+vXBCmeq2hPn6z1SzJ40XHlSnQANx3xxp7XlHYQC8diVMkJP6CPY1l69oUTxY+xq5YhlhP7QaXS/dcRsw7aUnWCB7w3eysbzOGI6y37+8dOrX7CLAog4Uzi4O9c6YtkZ6EFjbH+eMpcHtpVRHRQQ+svGdijN1nYYazZSM8k47krziiVM1a10exvqWJELSAYjNlItQtME1peXga1wHYW+J7mHq7p7QfuKRrXnQ9TXVKpQz5169bgGCRGll/imTQcV9i9gtJjDpp++dx/QNh95Ka/rlIHXRayNDu+n3XEatFMJgiogKgDwNeaxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7398.eurprd04.prod.outlook.com (2603:10a6:10:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Thu, 18 Sep
 2025 05:44:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 05:44:56 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 18 Sep 2025 13:44:32 +0800
Subject: [PATCH 1/2] ASoC: codec: Remove pxa2xx-ac97.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-audio-v1-1-e9d0df5c60d2@nxp.com>
References: <20250918-audio-v1-0-e9d0df5c60d2@nxp.com>
In-Reply-To: <20250918-audio-v1-0-e9d0df5c60d2@nxp.com>
To: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758174285; l=9158;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=HbxiISTQ3eg1CuILWGIza5WVAELx162zndqEMuzMpcQ=;
 b=ZSEXs0mYQGDPK9dGRpzb168HJSlJdg1e8eAoreM1MKt9GcDY7kSfwN4p5RTqpsC0mWu1wxhx2
 us3n7TahaExCw9OS26ZiLkD0lRD8zByN1Melh+BQNJaG327Hd8v26L6
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
X-MS-Office365-Filtering-Correlation-Id: d116d41b-84d3-453d-a71a-08ddf6767f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3ZWMTJpM2ExTDNkd1FhZFVMMFQ5azdtUzU2b1AxMCtVOFVMb2gvbFFhcGtK?=
 =?utf-8?B?THRndmczSnRPTkw0dURJOUxqMTNEaFZ6M1ZwVk16ai9kVmR4bWVVTTR2ZWV5?=
 =?utf-8?B?aHJFQldqNjBoVHlDb2hYQnRVNGxFTkdVTTVsSTJJTUlucHdJYUJ5V0krcGk0?=
 =?utf-8?B?WkJNWXVQZlFlQW9iNHNBSG9TZU05NExBdWQ1ZFhmRG1ZNXpFSWRRNkFrZ2JS?=
 =?utf-8?B?NEFzRmd6YXhkVDF3WE1RRmt4UmZ3WkVwYUpZcG1RQmQ5VUpQTkNHWjdLQ3hB?=
 =?utf-8?B?SWJtb1Q4V0dIUjltblhCTVhXNjQ1SG1qWmZGMWpuZW9GbXJHczhuT1cxVUdu?=
 =?utf-8?B?MmtwWVVTdEVweUR2d0NTT1UwbEpwblprOU9aWFJ1a2Z3SVBMeVBLTmNQTGxB?=
 =?utf-8?B?Y2VXMUhkWG93NTlPSlV3VXVvS2RNRVlLdWMwSmZBUHFPWmM0dGEwb3M5ZFdB?=
 =?utf-8?B?QUx0dWpSOXo2VjRXQ2lseWU3NE4zVEZNbWVIeUIzVUREcXFzM2lMVWNXaFcz?=
 =?utf-8?B?MlBzdE4xeFMyaEFTalZNU00rL29KRHRwSDdtRnVKVkpwSzNhMlBzb3VnQ0s1?=
 =?utf-8?B?S3R1b3pNQ0t2VUd3TERJZHRTQzErSGY3VDNFKzB0YXUxb3JWRm5Td1g4c2NG?=
 =?utf-8?B?OE92WHp3ZjNVN2M2N0V1bDNEdzlMSlpXZWg2Q0piajRHNEZlaldobThuZXMv?=
 =?utf-8?B?alp6ZnBTV0pya3dEdEwvU3RkWm0zMG1KOHgrZURVQ0hkTnRBR3kvWjhhNHJs?=
 =?utf-8?B?QWx6QTlFWVVnc2hvSTNNVHU2cG9iT3I4RlBQbit6RmRxTG5sbXM1M2VSVE5S?=
 =?utf-8?B?b1J2ckp0eVYvS3B5Q2E5RDFXbVZ5ZEdFTGN6eG9tS2pYYVFEMHNFcEpOU293?=
 =?utf-8?B?K1psQU5mMEU1QmE5enNmcGZ0TTROK3RocVRuOGVIMUNMTHBJcVJTTDlZYUk1?=
 =?utf-8?B?ckxUMTVVOTNpbWxjY3lNWk1LKzZRTFJCSlRXMG9Kby9sVmtOVE1BeFVqVzNs?=
 =?utf-8?B?TUlaZ1MvYXR6OEY3VnRKWlUwK0tlanBDWHZ3OUF2NWxNNnM3TXhoeXBnZWJU?=
 =?utf-8?B?TFYwcVpSWjFDbm1hR1RZSGdCaDBvR0c5NUsva29jcXBGR3IrVTZQVjdwdkY5?=
 =?utf-8?B?OGtFUEg4Y2I0elFxbWJaY0FlbnF0dDMvR0FiU1E5U3pHekRwZVJGT1lpNjUy?=
 =?utf-8?B?cExzVXo3b1EranNrbGFLdyt3akJydVoyZzZleDJldm43OS9uWEd2OWRpZHRq?=
 =?utf-8?B?bGp2NW5OUVhJbFJoR2VCVW15TVh5NlFXMmc0MDFwT2xVdEhFNEd5ZXV0LzVS?=
 =?utf-8?B?OGhxaWc2YTRYYXhNYWNFR0NGbmJOWHhUZ2lpN3d1UTlkbGdneFk1TmxrNnpC?=
 =?utf-8?B?WFI3OVZXWjcwdE4vemJlU2NVZkw2Q2JMWHU0R0l1ZjFsN3gwTHZ4MGQ2dHJx?=
 =?utf-8?B?aEFiUzE4Nkwra0hjaUJyK2FFZVNralJLcVJJMGE2d1ExREw5UGRXVFIxWjRU?=
 =?utf-8?B?ZWhORHFCV1d1REllSGpoRkltVlpLdGFXeWZCNkI2bnpROHZ1OFl4QXRUcmlN?=
 =?utf-8?B?N1doUm95eGE0UFYrejJkZy9TVU43RjEveEtwajIxajRpUW8yQkVSdjJPZm02?=
 =?utf-8?B?YWRHMDBiZ2hRcU5UdXBqTllIRlpnOVVqYVg3anpla3ZONUVwS09DRGY3bWZ3?=
 =?utf-8?B?bEo2cEU2d2dhU0hCN3l3QkxzUHJ3WThpSUprTEZWZHgxZzZsTmxxS3RHWmIx?=
 =?utf-8?B?dXA1TlhaTHVzc2FmRy9sUGdSUHZmdXZDMFlkNGVNMFE0OXVhSkZTa0RDOXFJ?=
 =?utf-8?B?ZzNDSWRYYnZ1WVVTWGZkelh4cXArTEVRdzJpK2E4Vnk0bFRDcjhZZ2oxU3VZ?=
 =?utf-8?B?L3cybDlzYjFjMkZpZkE2YmdKS05RcDFhdXl2Y3hEczN3bzFuaEpmdlFzWUla?=
 =?utf-8?B?UHZtckluaERhU0Q0V3R3N2FNVmYvLzRmNkNPY2xXbDhZbkplaHFsRmE0RDQ3?=
 =?utf-8?B?VHlxa1BXNHBHK2tscnp5ZjVtOSs2Y0pPMkIwY1FyMXB1a3c3UFFmK2Ryb28r?=
 =?utf-8?Q?/DRyhs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmFVbFhVN3pUL3pQbk5vc2c0WW9keWpZLzY1ZnVBYW9iRlhWODBsRWloQ0Jh?=
 =?utf-8?B?b291K1pLUWgyYnNNUDZxRXBmcktOOUx3blppN1N5OTNpUHMyMVZnSXZjdUNt?=
 =?utf-8?B?YldFdG9zSHo4dG9SbCtJY0h0YUlVYVg1WVhNbGhnVjNiZ2RSUDRabGxEcU92?=
 =?utf-8?B?Vk5rZjlMbXd1VXFOWm5TV2pzR0Uxb21GaW1VQjJRbERqUVZVbURSekdIV01n?=
 =?utf-8?B?dWJGdTJ4UDJ0bkEyM2w5bjRFZXhRaDRxbGY5c2VtekJZL2VyNnM1VHhnYmR1?=
 =?utf-8?B?TnN0Wmh0YXRDVXFpQklyV0ZqWXFoSHhKVlZIZ3lXOTBWWWRqUHB4eEUrNEl3?=
 =?utf-8?B?T1hYeWFhMDJMOEFwMkpGdTNBWmNHU1ZWT0t2bnN6emhyY3hlYzZlRGRNa3cy?=
 =?utf-8?B?d1pHK2cycUZkazZaclNUb2JDeWtLbmhjcGlsbkM1eEpHYnFxdk9VK3JVMmRu?=
 =?utf-8?B?eDZnRVRjRk5jQS9yMnBVMXZFdWJQMERlbFNtdDZwRGtMR1V3ZWFlRk9WVm81?=
 =?utf-8?B?aGgvSkRiQ2Fzc1JLa0FYZE9ueEs1cHVqbTA1L0x1TnBLQmtTSkdrdU0rSnRj?=
 =?utf-8?B?b2h1aGNycmRZMHBrUEpJZ0hVQndWNGlCVStoODNCMXR2RGVBN2dsYzNPMmZP?=
 =?utf-8?B?UkNuRkl3SFVoZ2xuTGpLNUIyNkZDa2dWQ0NFZTFZS3RQQWJvSHZkUWg3N2Z2?=
 =?utf-8?B?cTZtVmpTQys4QVkwK3dMdnppZUZ4VVo4UnBzZ0xNVUFNbjlvalJDVnBQbnJs?=
 =?utf-8?B?MU9WeGFyQXJYMGVEUjlNVDU3OFZhd1crOXZQU3V3dzlHdEdkZjhsT1NOT1B5?=
 =?utf-8?B?SkhFbXBHZGNzcnFlVlRubEt2YjEvL0VIb0E3TFdTMEdoSkM5S1VKTFYySjQ0?=
 =?utf-8?B?Nmp0aktNOWR4WXhXeHlwQUpZOURuZW5UUzliZFJ1a1pONlZLdng1WXZRYkhk?=
 =?utf-8?B?M1AzakNOanZtWEY5d3lqTjRhZE0rQVJLZGU5YjBXUitTYUxVTFd5VTBSQzlS?=
 =?utf-8?B?QXpadGlEajdKL2g4a1ZDS3l4M3Y1L3lyNzVDbTZqTkc4UDAzaXlXNGJzSVRP?=
 =?utf-8?B?OFFsanZjWWtIN1lmVjFmelkwbXRNTHlTa3hzaDVlVmZzMlZaMTFUMzZ4RFlv?=
 =?utf-8?B?L25SOU1RZVZtSUcxbVhLb0k4bGx6dTg4Ymt6WjlVcDFTbjRiSndUYXpQRUpO?=
 =?utf-8?B?QlpzRExuYzg2QktZVFdnR2p1SE0rRVdGQ2hzM2RCTlVBS1JJU0d6L0dUL2Q4?=
 =?utf-8?B?OTFsTncyV0MwMVFON3lkdEpvK2RUZDZ4OERmWDI5L0pabXkzblVoSXRFNlNv?=
 =?utf-8?B?NWFxdmNzWFlnRzRiNEd4MmUyS3pFRFpQbEUza1ZMRXRQR2c1eGlGMlp5QmNu?=
 =?utf-8?B?bGIrMnY1a3AxRXhXbnE3UDNBcjNVTnNBU1NQbXp6WjF1UjlOZmFKUWIwZDFu?=
 =?utf-8?B?dXVBOEdscHZGSDdmUVZqMVNvT2J1cDlsTVh3WlExazV1OXhIZHQyV3ZJWFVa?=
 =?utf-8?B?VE9lTkVBcS85V2RlM1NKVDdERk5tNlFOaWxscUp6ekFnK0lqSVhHNDRzTjY4?=
 =?utf-8?B?d0x3ZmNheCtLOEMxMm9DVE9OdGVwYmhBci96VVBxMmU3YVQwNm9UVDhrVkVK?=
 =?utf-8?B?ZUNXdjJtWDUxQzliVGpTZXFFNUZQOGp0SG5rVUoxMWxhaXkyTEo5Rk1XT3VI?=
 =?utf-8?B?ODVJSnhGWGNUSnpJVnk0SHRaMVdjeGs2UEZJWWpQcDVwUU9GVkZBTlJ5aEcv?=
 =?utf-8?B?M0gwVDVLUFZpRHdRTkNra2JvQmtiYWJtOHB5RTdZN3c0Rk5RUW01MDFjRDhB?=
 =?utf-8?B?MElFSmIrak91UFZ5TVg5SkpBK0xLWFBYMkJXYWhtNUE3V1J2VE0rQ3FSakIy?=
 =?utf-8?B?dWtUbXphMzRHSkVzVnhibDZlc01ZbUFJOUY5bjAxeXRITCtoUWE5VFZxbXBj?=
 =?utf-8?B?SHZXSVNQbFI2ZHdiNEVUYjdqUXdVaVhWOGVoZDFkZEVTai9WMUE1c09aUTI4?=
 =?utf-8?B?eTZyRDZmYkJNYTh4S1Y0S1NDS2pwbnpROExqNnlrR3lnOTNpMkpHK2FiNGNv?=
 =?utf-8?B?VS9iMEIraWtHMUtvWHgwRDE2ZUNCTkg1SDdxWXE5M251YzQwczFmWTRYYTBi?=
 =?utf-8?Q?Wzw3ruPtEkVU5hxOr3GcvhnIS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d116d41b-84d3-453d-a71a-08ddf6767f17
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 05:44:55.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I54FLiQxzxnNXkgCAXc8n4y4APUG57KUcFc7pH3rMKubF3QOyhN4Gu9qYp2sIXGLBTFgX0QEFemFECml17Ow0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7398

With commit ce79f3a1ad5f ("ARM: pxa: prune unused device support") and
commit 2548e6c76ebf ("ARM: pxa: pxa2xx-ac97-lib: use IRQ resource"), there
is no 'pxa2xx-ac97' platform device created by machine level code, so this
driver could be removed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 sound/arm/Kconfig       |  10 --
 sound/arm/Makefile      |   3 -
 sound/arm/pxa2xx-ac97.c | 286 ------------------------------------------------
 3 files changed, 299 deletions(-)

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index dea2c661b3537309d8ba0ab044640f15205bf29c..e4d7288d1e1e3e7c5d081a7bf474319693d5bff6 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -18,16 +18,6 @@ config SND_ARMAACI
 	select SND_PCM
 	select SND_AC97_CODEC
 
-config SND_PXA2XX_AC97
-	tristate "AC97 driver for the Intel PXA2xx chip"
-	depends on ARCH_PXA
-	select SND_AC97_CODEC
-	select SND_PXA2XX_LIB
-	select SND_PXA2XX_LIB_AC97
-	help
-	  Say Y or M if you want to support any AC97 codec attached to
-	  the PXA2xx AC97 interface.
-
 endif	# SND_ARM
 
 config SND_PXA2XX_LIB
diff --git a/sound/arm/Makefile b/sound/arm/Makefile
index 899edb4bb278dad0e7dd90fd11703f4dca6c3cb1..99325a66cf771ad7a22df18b340221fa13e69a2d 100644
--- a/sound/arm/Makefile
+++ b/sound/arm/Makefile
@@ -9,6 +9,3 @@ snd-aaci-y			:= aaci.o
 obj-$(CONFIG_SND_PXA2XX_LIB)	+= snd-pxa2xx-lib.o
 snd-pxa2xx-lib-y		:= pxa2xx-pcm-lib.o
 snd-pxa2xx-lib-$(CONFIG_SND_PXA2XX_LIB_AC97)	+= pxa2xx-ac97-lib.o
-
-obj-$(CONFIG_SND_PXA2XX_AC97)	+= snd-pxa2xx-ac97.o
-snd-pxa2xx-ac97-y		:= pxa2xx-ac97.o
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
deleted file mode 100644
index 77b11616a7ee05a45573d1b643f3192f35c0c38a..0000000000000000000000000000000000000000
--- a/sound/arm/pxa2xx-ac97.c
+++ /dev/null
@@ -1,286 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/sound/pxa2xx-ac97.c -- AC97 support for the Intel PXA2xx chip.
- *
- * Author:	Nicolas Pitre
- * Created:	Dec 02, 2004
- * Copyright:	MontaVista Software Inc.
- */
-
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/dmaengine.h>
-#include <linux/dma-mapping.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/ac97_codec.h>
-#include <sound/initval.h>
-#include <sound/pxa2xx-lib.h>
-#include <sound/dmaengine_pcm.h>
-
-#include <linux/platform_data/asoc-pxa.h>
-
-static void pxa2xx_ac97_legacy_reset(struct snd_ac97 *ac97)
-{
-	if (!pxa2xx_ac97_try_cold_reset())
-		pxa2xx_ac97_try_warm_reset();
-
-	pxa2xx_ac97_finish_reset();
-}
-
-static unsigned short pxa2xx_ac97_legacy_read(struct snd_ac97 *ac97,
-					      unsigned short reg)
-{
-	int ret;
-
-	ret = pxa2xx_ac97_read(ac97->num, reg);
-	if (ret < 0)
-		return 0;
-	else
-		return (unsigned short)(ret & 0xffff);
-}
-
-static void pxa2xx_ac97_legacy_write(struct snd_ac97 *ac97,
-				     unsigned short reg, unsigned short val)
-{
-	pxa2xx_ac97_write(ac97->num, reg, val);
-}
-
-static const struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
-	.read	= pxa2xx_ac97_legacy_read,
-	.write	= pxa2xx_ac97_legacy_write,
-	.reset	= pxa2xx_ac97_legacy_reset,
-};
-
-static struct snd_pcm *pxa2xx_ac97_pcm;
-static struct snd_ac97 *pxa2xx_ac97_ac97;
-
-static int pxa2xx_ac97_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	pxa2xx_audio_ops_t *platform_ops;
-	int ret, i;
-
-	ret = pxa2xx_pcm_open(substream);
-	if (ret)
-		return ret;
-
-	runtime->hw.channels_min = 2;
-	runtime->hw.channels_max = 2;
-
-	i = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-		AC97_RATES_FRONT_DAC : AC97_RATES_ADC;
-	runtime->hw.rates = pxa2xx_ac97_ac97->rates[i];
-	snd_pcm_limit_hw_rates(runtime);
-
-	platform_ops = substream->pcm->card->dev->platform_data;
-	if (platform_ops && platform_ops->startup) {
-		ret = platform_ops->startup(substream, platform_ops->priv);
-		if (ret < 0)
-			pxa2xx_pcm_close(substream);
-	}
-
-	return ret;
-}
-
-static int pxa2xx_ac97_pcm_close(struct snd_pcm_substream *substream)
-{
-	pxa2xx_audio_ops_t *platform_ops;
-
-	platform_ops = substream->pcm->card->dev->platform_data;
-	if (platform_ops && platform_ops->shutdown)
-		platform_ops->shutdown(substream, platform_ops->priv);
-
-	return 0;
-}
-
-static int pxa2xx_ac97_pcm_prepare(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int reg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-		  AC97_PCM_FRONT_DAC_RATE : AC97_PCM_LR_ADC_RATE;
-	int ret;
-
-	ret = pxa2xx_pcm_prepare(substream);
-	if (ret < 0)
-		return ret;
-
-	return snd_ac97_set_rate(pxa2xx_ac97_ac97, reg, runtime->rate);
-}
-
-static int pxa2xx_ac97_do_suspend(struct snd_card *card)
-{
-	pxa2xx_audio_ops_t *platform_ops = card->dev->platform_data;
-
-	snd_power_change_state(card, SNDRV_CTL_POWER_D3cold);
-	snd_ac97_suspend(pxa2xx_ac97_ac97);
-	if (platform_ops && platform_ops->suspend)
-		platform_ops->suspend(platform_ops->priv);
-
-	return pxa2xx_ac97_hw_suspend();
-}
-
-static int pxa2xx_ac97_do_resume(struct snd_card *card)
-{
-	pxa2xx_audio_ops_t *platform_ops = card->dev->platform_data;
-	int rc;
-
-	rc = pxa2xx_ac97_hw_resume();
-	if (rc)
-		return rc;
-
-	if (platform_ops && platform_ops->resume)
-		platform_ops->resume(platform_ops->priv);
-	snd_ac97_resume(pxa2xx_ac97_ac97);
-	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
-
-	return 0;
-}
-
-static int pxa2xx_ac97_suspend(struct device *dev)
-{
-	struct snd_card *card = dev_get_drvdata(dev);
-	int ret = 0;
-
-	if (card)
-		ret = pxa2xx_ac97_do_suspend(card);
-
-	return ret;
-}
-
-static int pxa2xx_ac97_resume(struct device *dev)
-{
-	struct snd_card *card = dev_get_drvdata(dev);
-	int ret = 0;
-
-	if (card)
-		ret = pxa2xx_ac97_do_resume(card);
-
-	return ret;
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(pxa2xx_ac97_pm_ops, pxa2xx_ac97_suspend, pxa2xx_ac97_resume);
-
-static const struct snd_pcm_ops pxa2xx_ac97_pcm_ops = {
-	.open		= pxa2xx_ac97_pcm_open,
-	.close		= pxa2xx_ac97_pcm_close,
-	.hw_params	= pxa2xx_pcm_hw_params,
-	.prepare	= pxa2xx_ac97_pcm_prepare,
-	.trigger	= pxa2xx_pcm_trigger,
-	.pointer	= pxa2xx_pcm_pointer,
-};
-
-
-static int pxa2xx_ac97_pcm_new(struct snd_card *card)
-{
-	struct snd_pcm *pcm;
-	int ret;
-
-	ret = snd_pcm_new(card, "PXA2xx-PCM", 0, 1, 1, &pcm);
-	if (ret)
-		goto out;
-
-	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
-	if (ret)
-		goto out;
-
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &pxa2xx_ac97_pcm_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &pxa2xx_ac97_pcm_ops);
-	ret = pxa2xx_pcm_preallocate_dma_buffer(pcm);
-	if (ret)
-		goto out;
-
-	pxa2xx_ac97_pcm = pcm;
-	ret = 0;
-
- out:
-	return ret;
-}
-
-static int pxa2xx_ac97_probe(struct platform_device *dev)
-{
-	struct snd_card *card;
-	struct snd_ac97_bus *ac97_bus;
-	struct snd_ac97_template ac97_template;
-	int ret;
-	pxa2xx_audio_ops_t *pdata = dev->dev.platform_data;
-
-	if (dev->id >= 0) {
-		dev_err(&dev->dev, "PXA2xx has only one AC97 port.\n");
-		ret = -ENXIO;
-		goto err_dev;
-	}
-
-	ret = snd_card_new(&dev->dev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
-			   THIS_MODULE, 0, &card);
-	if (ret < 0)
-		goto err;
-
-	strscpy(card->driver, dev->dev.driver->name, sizeof(card->driver));
-
-	ret = pxa2xx_ac97_pcm_new(card);
-	if (ret)
-		goto err;
-
-	ret = pxa2xx_ac97_hw_probe(dev);
-	if (ret)
-		goto err;
-
-	ret = snd_ac97_bus(card, 0, &pxa2xx_ac97_ops, NULL, &ac97_bus);
-	if (ret)
-		goto err_remove;
-	memset(&ac97_template, 0, sizeof(ac97_template));
-	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &pxa2xx_ac97_ac97);
-	if (ret)
-		goto err_remove;
-
-	snprintf(card->shortname, sizeof(card->shortname),
-		 "%s", snd_ac97_get_short_name(pxa2xx_ac97_ac97));
-	snprintf(card->longname, sizeof(card->longname),
-		 "%s (%s)", dev->dev.driver->name, card->mixername);
-
-	if (pdata && pdata->codec_pdata[0])
-		snd_ac97_dev_add_pdata(ac97_bus->codec[0], pdata->codec_pdata[0]);
-	ret = snd_card_register(card);
-	if (ret == 0) {
-		platform_set_drvdata(dev, card);
-		return 0;
-	}
-
-err_remove:
-	pxa2xx_ac97_hw_remove(dev);
-err:
-	if (card)
-		snd_card_free(card);
-err_dev:
-	return ret;
-}
-
-static void pxa2xx_ac97_remove(struct platform_device *dev)
-{
-	struct snd_card *card = platform_get_drvdata(dev);
-
-	if (card) {
-		snd_card_free(card);
-		pxa2xx_ac97_hw_remove(dev);
-	}
-}
-
-static struct platform_driver pxa2xx_ac97_driver = {
-	.probe		= pxa2xx_ac97_probe,
-	.remove		= pxa2xx_ac97_remove,
-	.driver		= {
-		.name	= "pxa2xx-ac97",
-		.pm	= &pxa2xx_ac97_pm_ops,
-	},
-};
-
-module_platform_driver(pxa2xx_ac97_driver);
-
-MODULE_AUTHOR("Nicolas Pitre");
-MODULE_DESCRIPTION("AC97 driver for the Intel PXA2xx chip");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:pxa2xx-ac97");

-- 
2.37.1


