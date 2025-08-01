Return-Path: <linux-kernel+bounces-753005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3576B17DAB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676F21AA5B79
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC831D95A3;
	Fri,  1 Aug 2025 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VPPB54G+"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5D78F58
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033705; cv=fail; b=QkuzMuavyhS6iWql4edVQWL0cKaXVddq5aLnm366bSkcWXEcOQwjbmW4veaCKfxDi7SuUeAgokrd3zrHxVE1sNfO7TIAVC1CC3pIhJKccEowk6qrOtDkJr5B14Dp2bElbtpUNr/KwtWIPnH9eRK4yFYbBiFsB62iFjh7V4Y9fHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033705; c=relaxed/simple;
	bh=+AVrEo9K721aY8AJja5HJKnKpiBm3gGzxzpiOcKNszo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nyb/RJRK0XhtaRO7lNFSq4BDaHcnS8YHOWqbhYC7G9ZdXWikJ1IZvS5wjXZsk1Y4POm6uLLPfU/5jMv9c3csLD6QhfUWmo2BfSoNzs00OIo2jDjwRL2q/EtZiNXoz5oMn+1AwfJx9J8LxV4VqrwQVStt8Hg1Z2CepNZSwYkFsi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VPPB54G+; arc=fail smtp.client-ip=52.101.84.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l99wLUn+Y84v8SF8Op7oDCL49ImkcmZjMNOZYBIs/aIoQ/AEQ8CkpU/23mDofv5UiB4+RrTXjlJJkYxY2LSzp8mrUlllqAA6RkBpi5ez32QmdyVXh/8B/k1FwbzeookduTTQ0yZmk5hc1GtJRC3UCdkpdm8uiGqyRQKTQ1HwO1ISTZ5Cx1p/psz8XSeU+59W2FDiSfb4bjx2Sf+Z+T8PsPMBhXZ6bj7TPRbNnK8Fr+1Jj8SjkvuRPFfGCVuCJ+Q/h18dq79fZUb9hmR2cwJ3Jqjd+CcYstWPsg470ysnzuJp+Ry8yQVHjqxiNgeEnAqXDSHN3qwOyx4MN4u2PgDsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqDHKxupTCD6RjD70xhbm4H4cZh96eBhd9faHvC5s2w=;
 b=YfKOoe7Ogy+nZSdXGP9SBkBK7aX9x8HakewFbTE+yOms4h2hrCMK+bLrnqkbscnTUuv+xsdt7/fMQ/pShEoQH5iEC7/b6GEJUFQmd3vuMp/BXtkoSO/Zoda6cQShW/gmrI8gQ0bEVz6MerdNVEK7S/ik6RlH27qufZB3CfI5KHekGVmXKYlNNAME39b2e4W8nikT+3rGgF85hizw63XG7MVkvEQrznhhSog8RLOw/VxeL8szMASsVXjgOmNVHxdkDrd15gvgpMUEDhbC4j9mi4AqXzHvssloxGcZ/IVm29vroRVdGty7OylE1aj5EI4e7RSn/Ab6ShUuBu6tcBDrXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqDHKxupTCD6RjD70xhbm4H4cZh96eBhd9faHvC5s2w=;
 b=VPPB54G+PPMXFPgEU/wkMg3A3DMwbHTyCc4fEgXpBXXDlMmpqWt2RGFaOfvAWK5T0slBVU7cQDDvCpDudDhEkv5KpkKxHa6ppNEKVMIgeLv5mZv5K9olFDb64dsVCWb1GctW77ruGYGVlVNGxdN52W6yPaaer2bGaROGzvD8SkBQeGb5Stl3iOd3kTmIazhGxRcZNjcRjTtZoKklTvsAzSyK6u6skHdPEUg9ugUV+eQTzdGp389HARjW5bgDou2Am573mD9F1vK5a+cLIcCo6dSTYs61v+gI0jw2qVYVJqNXUH9hT6QvQCKElyNHnoAvVl88bcAnP6PS0AeUoweOJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com (2603:10a6:102:219::10)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 07:34:59 +0000
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18]) by PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 07:34:59 +0000
Message-ID: <5d68bb61-1404-4d05-85ad-9895db80bc1c@oss.nxp.com>
Date: Fri, 1 Aug 2025 10:34:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/20] clocksource/drivers/vf-pit: Unify the function
 name for irq ack
Content-Language: en-GB
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
 <20250730082725.183133-18-daniel.lezcano@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20250730082725.183133-18-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0105.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::22) To PAXPR04MB8590.eurprd04.prod.outlook.com
 (2603:10a6:102:219::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8590:EE_|GV1PR04MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: d3aac323-a371-4883-d9ec-08ddd0cdeb62
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmxmV3lKa3RDUzJLb2hNeHJjWnpwQWdPZ2tCL0l6TVFTS2tueVVsS1VLR1kx?=
 =?utf-8?B?azJoS1loL3QxeW14bGFOUVdPQmp0QUJzdnFSNzh1VW5lM3g2RzBLR1Rzbks2?=
 =?utf-8?B?QXllYUtQNmtrcFNqRk4vT0QwYWI2WC90RDJrazRQRnBIZVZYS1Y0WHQvYVFk?=
 =?utf-8?B?YTJPRXE3UWNVa0t5Qlc0TGZSUVFnTkZ6eEtYbjZnWjk4TXJmM1RkNFhPclRU?=
 =?utf-8?B?Qjc5cWVZZC9ZSnVBRlRiUVBqbGErRnM3SndaQ2dsNnh4ZHA1S29FQmxlOENY?=
 =?utf-8?B?ZmR5Qml1a1ptclhJOVlad25DNjE2bDMyUjl5djk3K3Z5TXJLSVV3S1ZWTFgx?=
 =?utf-8?B?NVFleUNWYkFGREZ1eGtiMVE0UGxLNVRSYW1CRzJ1UWQ3ZzFzZWpUYTNwb21j?=
 =?utf-8?B?SSs3cGc5MzlaaHU2UkxFZU5XMlIyMWhkWWVpc2o3UmM3R2tJQldqYUxVSXQ3?=
 =?utf-8?B?c1U4OUFDMENqRU56c091QXljSUVKandaNUh3WTRSRi9hQnp0QVUxemV3V3B4?=
 =?utf-8?B?aDhqdnNiUWVPQ0RDU3FRQlJEeDVaZkZZbVdNTnB5amVqK1Zta0dWN1pDZ284?=
 =?utf-8?B?d0tVWXFZSG1DL05QbEtsZkgxVVRheGpEdjhwbHNDNTNid1J3UGM5ZHpKVUdp?=
 =?utf-8?B?dWp3alBpSjFDSXVDK3cwcmN2aE92MlBPQ2JNbFdLTi9VSEx4amRoTW1lczdB?=
 =?utf-8?B?ajR2aVBla01RNjY2OGRsVzk0VU9wWk1zbnFHbWNDV2xycVlMTTBWZ1l6QkxJ?=
 =?utf-8?B?TlNzUUQyZVhzNDNTK055d3VackxqdVYwYkdZOG0rd05YVjhkdkE0K2ZiVnZh?=
 =?utf-8?B?TVZ0OG9PMzk5d0tvWTdCclRWR1FpUXlWY0x0bjIxOTV1TEVpU1NPSjhGOXNy?=
 =?utf-8?B?V3Rzd0J5Vlp4YU96eklxYWRjRm55MEgydXB0dk5yYmtnSklUUEdrWmk0WnI3?=
 =?utf-8?B?KytWSkJ2Ukw1aEFya3ZKUFB0L0pGZEcyQ3RORnkvejVpbTYwemNTZmNzcENK?=
 =?utf-8?B?ZTdENDFDc3dwblN5RkZ2Sjh1SStiUUxRNmZMOHFxaXVnOXQrRVlGK3l3WW5H?=
 =?utf-8?B?OTNFQkI5c1dpUzdVanZqYk56WE8rTGpYZmdpN0tvME9GV0FHNlJ4Z00vNng0?=
 =?utf-8?B?QndMSjd5S3Z1S1p5MHNHUFpnWHhaNi9PMXVFUnJQTmNtZkkraFl2TEJ0ZWJa?=
 =?utf-8?B?RTNhMTRsQ0JnSURyandMWWs1c091clJpT20zWDBGQmo3d3JucTNja2FBSDRp?=
 =?utf-8?B?aWJsT0VKUk5QbUxDc1ltWWtRb01HUk95dlNlZk9IamtwLzRjTGU2TmE2T3I3?=
 =?utf-8?B?WVlnVGFIVUU4NUdiamY0clgyQ0MxNnJEU0xVQTVBK0twbndMZm5qTUlsbUpy?=
 =?utf-8?B?eHRlMjZydlRTQ1VvWDBGNjNabFAxUWlYL1ZNc3NQSGtSNW9lTUN6RmNoN0ls?=
 =?utf-8?B?WXRQWis3UFo0WkxLeVNmVTVwbTNjNGhKSnl3S1AzMTlyQWsvbE5WOTBtWjEz?=
 =?utf-8?B?cUxhWWVCMkpBUjk1U1Y2Sys5aUJ5emRDbm9tT3l5Um9GTGRvWTZhdlV1VlIr?=
 =?utf-8?B?RG8wdnd6Q2w5SXNxa29FUzZDSkVrTnJrQ0NGemtsNVhsbm01Qms1UDFkNS9J?=
 =?utf-8?B?c2RMbW5TSmp6MDFGd241SnVRTy80Z2t2Zm9OOWRvVW03U0cyR3QwTzgrb0ZM?=
 =?utf-8?B?S2RRRU95V1p2S21hODVrQUI4SEFtcTBObzF2R0JranNWOGJCTWFqYmdnejRt?=
 =?utf-8?B?b1hSODZWckxLcnVpVDI2MThGcTkremtiTlFNODdsdUV4VTlaN1QwS3ZQTzNL?=
 =?utf-8?B?UG5RZ3JVMlFRSnBRQ3g0RDhxYmJFT2hYaE0xY1ZodXN0aFk2Y2JYY1ExNk9v?=
 =?utf-8?B?U2RkVnBZNnJsZTVBR1IvRTlWSnFRM0RYN1FubHUwVFUyVWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8590.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW5qVU1RdUVEeW4rUFNFa2JObnhLNDNhNUdRWlJ0WUh4Y1BsYXdlSHdWTFRK?=
 =?utf-8?B?VHRYWGxLZXo5MUlFN0kvaUE1UUhrc2RpRDFSWmsxeFZlai9jY2NvQUlIeHlP?=
 =?utf-8?B?SFRhS1hoUWpmT0tvak1BbjFpZWdtME9WYzZQRXViVC83SnNveHpzZU5leXFU?=
 =?utf-8?B?VFQwSk42Mm1GOXJyQmlHMzM2QUtVNzZGTU84Q3lGZUZLNnFyRWEwUWZGME40?=
 =?utf-8?B?aStzaG9CSjJ3cGJwOTNYbGF3RzdFK3V2K0VGRm51SkFaZmVSa2dOVXBXWGZK?=
 =?utf-8?B?QWVkajdJUXJkalpGU21jSzNzSXE0dXVZRnZ6eUVVOG1SQSsrMmpWaVpuRzNW?=
 =?utf-8?B?bjNBN3RiWmszd1gxWENlS2VURVZvVXNHY3FFVm1tZlBYTjVIQkpqUEM2c053?=
 =?utf-8?B?NHRLQnVQQ01sbHpLVjgxMlBaSUNUZ2tuaktNaGs5Ull1amdMdEJkeFp3MDBJ?=
 =?utf-8?B?Nkl6THRaZjg3NVZ4akt3TlJ3c3NCd1NZRTlIZ0RZcDFtM24zWlAzYmtnQ3hW?=
 =?utf-8?B?OXpndlp6Y040Q1FiWVJrRjJjcjJLYjMvcUNoaWd0QUNFeDVzNzBQRGdjTnQ3?=
 =?utf-8?B?TnVXell3TTVZMEVRZzNKY3JRWDVvbWlLd2UzQ2RYRmhSemZPaW11Y1M1U2Zs?=
 =?utf-8?B?TEo0M1VNUmpwMWozNE5FWlRsaEFZYzgvN3NZM29wRlFEWk1PRUZES041d3Jq?=
 =?utf-8?B?YlhZSlYxcHQwYTFZb29CVU5uUUZGMkg2OVZXSmZxYkFTQ25QNjUxRTl4aW5j?=
 =?utf-8?B?UUZnbE92elRkcGdRMThBSEVmeDlvd1JwU1BSd2hYMjV5a3dzZWFiNUdTU0NC?=
 =?utf-8?B?NFh5RzFaVTBmVkxoNkFTZ0VIT0lKdlVzMGR4aWx5RjZGakRWVmtOWEp3VWJE?=
 =?utf-8?B?SEVhYTA1aGMwcWdrS1RFSEJiT2t3SW8rRHRZenFlb3BKeStMQ1pWTnVlL25G?=
 =?utf-8?B?cXRXSUJKOENMS1g4RlIrWEJHelE0dVR1dHlxRGw4OUM0Vmp5ek8zMlNNakJE?=
 =?utf-8?B?NHJUQlpSczJaQzR1ZjdEN1h5b0dBZk9Xb1VyU08vR29BbDhWakZUclZQVlJx?=
 =?utf-8?B?OWh0akMrSnc3cUcwQXpucDdtdHpoa0xhRVcxaTVsWnBNZldzRFNzMXN4Y3Zv?=
 =?utf-8?B?TXJYbU5IcllmSHMvU1hSVk9zelg4T0JvQVkzSlU5VFlUMWRUYkxmV0xKVXJz?=
 =?utf-8?B?dWtRanJlczBzbFQvcFRWK3dTeVVKTkozczBNWi84NGo4N3BtM0V5M2U1QnFM?=
 =?utf-8?B?YVFjNmliMFpTTkFVbVZVcGNycmtUbC9SQkdKK2tEOE9MQnZzZXkzT3FoRkVS?=
 =?utf-8?B?NTVBc2ZSeHFSRG8xVUJ3Q25qblFvcDJmVlRBYllkcjhxUUd6RnJZS251NjlB?=
 =?utf-8?B?bnZTNDNpZzhxZk1jRGZuVElqeXgySFNLRHFMSnBMcHNsMFNGQW80SGxyeUFr?=
 =?utf-8?B?TWhNdVUza3VVc2pXdjBDR1NJcyt3R3Q5Z3J5ckVnZWdKSTlZdTFuOGp4alJz?=
 =?utf-8?B?U1dKMnpTbWVBUy9tdjR2bnlsZjQwYTVETVNucUE2bUx3SEFhbjk2cEJ0a0E1?=
 =?utf-8?B?b1UzeXhxU1crYXdVK1VHMzJKK2lwb01YYS9XTEJWY1dpN2VtOHRGTGdjL0R1?=
 =?utf-8?B?Wk5hNCtvbXVNb05GR1llNVJLSXE0YVo0N1ZQTm5pSzlscVIrbXdhdkppT3dH?=
 =?utf-8?B?SXZ2ZFhHTlVNMWZ0T1YwTlBmM2xMWXdvSWpqdWtsMkxtd21uazE5WU9RWmND?=
 =?utf-8?B?MmRhWUpscWZjUk9mY2ZlTWNESy9qbkxpQWk0R2lRR2tPVWRHQUZzcVdmVzBZ?=
 =?utf-8?B?R3E4Rzc2WDc4c1BkcG5ZbUZINDQrdEhsT2p5cmhhOFdTNnFER3BhS240UGxX?=
 =?utf-8?B?Z1JETVdncVB2cXRpdiswOU9walVsUElEelNnMlBOSXgwWC96bjNHNjBYU1dQ?=
 =?utf-8?B?cUNxRU42RDZWWFk0UzlROGM2TW1velBGaDdTME5aM3ZTUUJ0KzJrVk80ejBV?=
 =?utf-8?B?S0x1VjdHUHNrTk01ZkdoVFg4NkQ0bERtUXFBMUxOb0hNcTRqZWRZQWtPYitq?=
 =?utf-8?B?K0d1b0pJbi9ld1NmU2Z2dmNKWjd6R0dCendGRm9ZVk1mN3NRK0FIbkhZRGk3?=
 =?utf-8?B?UUxkY2pGRkF3aGw5RlgxK3ppNlNDaFEyZXZuV2Z2U3RnUk9kVDJnU09TemUw?=
 =?utf-8?Q?s3THzm/GH2777rfXIPPwGqQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3aac323-a371-4883-d9ec-08ddd0cdeb62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8590.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 07:34:59.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdBUBHumUMA0rvyYtR+GQkPoJq/nJupLTZJtmrL3yNTV4J52IzTK02/tazi/zpWPgDsf+kpvhEXcf549iUMPdtJGYcT4SBXHTJqFHsragFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

On 7/30/2025 11:27 AM, Daniel Lezcano wrote:
> Most the function are under the form pit_timer_*, let's change the
> interrupt acknowledgement function name to have the same format.
> 
> No functional changes intended.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Checkpatch:
WARNING: 'acknowledgement' may be misspelled - perhaps 'acknowledgment'?
#8:
interrupt acknowledgement function name to have the same format.
          ^^^^^^^^^^^^^^^

total: 0 errors, 1 warnings, 0 checks, 24 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or
--fix-inplace.

Commit 4a2a139e0b3e ("clocksource/drivers/vf-pit: Unify the function
name for irq ack") has style problems, please review.

-- 
Regards,
Ghennadi

