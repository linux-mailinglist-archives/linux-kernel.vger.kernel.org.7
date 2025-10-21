Return-Path: <linux-kernel+bounces-862465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909C4BF55ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0AC3A5BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAB1328B7C;
	Tue, 21 Oct 2025 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NxWU6mbc"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79FFC1D;
	Tue, 21 Oct 2025 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036906; cv=fail; b=e6uB9hPfUFRMSyFhsa9RRbxZFrVvY5lyfMOrso5GC+wgOIWUGKuT42uOfORMK8YfP7FfwPeyt1uKhJfOTpGewh/UULZIBdf5f+XVARVs6b4OCqAg11J6yIQlb1SknmHW00lb87rYnWg0QPpDzR66r2fxAiNkRk3tKm1w2n5icKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036906; c=relaxed/simple;
	bh=4l8uDjsjX/6QMdKZEr/KgqElvhu39liFJ69g2Ak5wbQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D0lYEczD3QpL1wUUj84lJXmFokS0RuwpTNWbzGnvExOXd507H4Wqke+CfABlRnyRIchNbAFThQh6hHUpe5dkCVoAEXTjMR9VL4U8tNt9bd+le+SjuAQcuzp6hqsUQncltozuxrnPX/D3J91v0ZY3pWKa1eCNpdFBVtjvze2FS0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NxWU6mbc; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTmzZ8bsVqLMcSMZOkGFKHDG+C7t6G+a5Tlhv4HR1ulNK4NDX1JWOFWQsc7/IYqhXbqwVdfeDBsUkvc6zlU76zylqh0VOsmNTJzO7/40umtYuIciu6zciGox6VJYual+BWo7RH86VgRPmBe9quyGG8IrW4FYbvmm2l22v0WcFEXNQswQc7FDe5JWmqamlp0taWP+MHIdMmQqUPo+is2G28xkeoT5aW58cxPnl9QLybakB4pxOLBQHyXkLCX3g2dCpj8x4N3jOCx2W2FiDE6CE/mkfN5szxmJIjKWprv868TjezIxvRoSaC4y4q1YZxb0Nu6M+ZSmngurWwwW6dQg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnddnIgJS1wjXiS3Hbn23j3halwdtLkLaxLIAKe8HUM=;
 b=OQulogk5ubWmluiD4HOLqDCNUkzf51N1SpwGrIsaFWxb1LlBHsMk2YL9mlryChbnZV/T59VMrJSqKxUVCNxHn+CujBNBTmSzrfhIWAKlP2qARgwV4fFY/xtr8+U/Fp6XZ+8oGOwIWQX5SgMZ0tb45Glmi2VQxKFrqcu3E067nzBp+o8L75UNAO/dcRg1PzGTEyyrl60KmVmbDdg8agqAHfCzdKaAIBfkcpeaXG+A1pIRxl8YJzek6/q8ic35IJX89cXfTL3gtBl3hcBmRVK+rKgB7V/14GNgRUhQ9Ab6YQ2UEtO2nF3U+A+0mGQ2v4ZJSIDr5rV+2qLLEdgW3+Rm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnddnIgJS1wjXiS3Hbn23j3halwdtLkLaxLIAKe8HUM=;
 b=NxWU6mbcZWAZPKJyg2n1pzE901XOhyazHh8K1MJ9vb1FX7BNqK+rcYOFPetmOWffpgU/OLw9722FRQARNGH3UTzkQtwido6QTSRSDk5RL5d3lUUiiW/6h9TbXg6frp+ltw4UfrXBqwDlL/JttuXG9rMuVZMFbUSgQ+vkGcajdmB1OaaiU8CeamUOK1nlRrc6YQwA/Som2/9bLeG6hBaAM2A2wVF+kXpWn557RXqJHDC/u1uCUGWeXtsKDPBCE22U2aSosXsfujY7nJmBvgNAubsJOrdSA5wA4ldiQ+wLYcUIA+RPSPXJOMaUmrKw6qt9schn2vWMCggKd9O7QgtXjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA1PR04MB10627.eurprd04.prod.outlook.com (2603:10a6:102:48b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 08:54:58 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%6]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 08:54:58 +0000
Message-ID: <47c802d1-bf26-4d02-b86d-1ca9ddda0fa5@nxp.com>
Date: Tue, 21 Oct 2025 16:55:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] ALSA: Add definitions for the bits in IEC958
 subframe
To: Shengjiu Wang <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 lumag@kernel.org, dianders@chromium.org, cristian.ciocaltea@collabora.com,
 luca.ceresoli@bootlin.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org,
 l.stach@pengutronix.de, shengjiu.wang@gmail.com, perex@perex.cz,
 tiwai@suse.com, linux-sound@vger.kernel.org
References: <20250923053001.2678596-1-shengjiu.wang@nxp.com>
 <20250923053001.2678596-3-shengjiu.wang@nxp.com>
 <aPc-Wad85lQWbqfa@phenom.ffwll.local>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <aPc-Wad85lQWbqfa@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA1PR04MB10627:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e756faf-35d8-447d-966d-08de107f8329
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MHA4VldSRnRUNUFGYlcvUTBUdHkzMG13UFZvSGNtWXlMSFg5ekI5TW4xRGZi?=
 =?utf-8?B?RW5PMEIvWXFZNlIzcFBDaGNqWkFZOTFzSDYxY0E3aVlZcDQvV3JOUThYYndo?=
 =?utf-8?B?QWJscEtDcW9vd0VFREl2VkZta25JbFNoOUNia3EzdGxXOUtFN3lCWUNJOHVw?=
 =?utf-8?B?SUU1UitxeTNSWnFMMGZwc2F0dWExZHl5MWtvVEVYeWdmVDJCcnNjYkxLVEND?=
 =?utf-8?B?bWE4VzFYNmpteVdFOWM0TWlTZmhGOXJJOWZudExzdmZDcWpybzQ4VDJVdSs5?=
 =?utf-8?B?Y2pRWElBSTVwdmp0MXZKcVZES2ljeXZ4THVrSk5VbG90VmJKVHFLVmVESTdN?=
 =?utf-8?B?SFdwMHlOMy9aS2RydDBxa0Vtam9QZ0M5WTZ1VDBOVUFsK2tGMWlQd0dPbVFX?=
 =?utf-8?B?cmxCdldiclV6VkxObVFheWtOUXNGamhyVkxtdFdDenJxKzMzdFhKRlRHUGQr?=
 =?utf-8?B?OTdMcm5Rdk5Qdm5SR0FPNFI0c3FTWkFSZDRPMzNWZHU5aXRyVTJKU3ZDMG9z?=
 =?utf-8?B?MVRKcUxIc3hydGtLR0hVMFUyYlQ5SzdxbzJBMWRReEVFZVA2NTVaTTlqSGpw?=
 =?utf-8?B?dFkzdzVuK2hMeFpSdzEvZVc1MjlUU0c5cmVBNTM4UHVkbk0yWkI0OXZiY1ow?=
 =?utf-8?B?Y1NaeUdlU0dhZE5JN1VDRFZwUFduODkxbUxhSWZkT0dUY0hDQU5oWmZINGE3?=
 =?utf-8?B?YXJ4MG1rbUZBRzJqanNFVXQvMExoZ3pVNnUrSXhxMHU2MFU2V1FLUzNKUkF5?=
 =?utf-8?B?VjJSRkZQZTEwd1FMcVhJVzRpMURKMVByZGFzODFwU1VDMkViKzM3NXlEVjlN?=
 =?utf-8?B?NzBwNE1iV2RLRkRBWlh2eUtFbTdYR2toRitXQldGSUZFcmtmTkdmU2c0QnhZ?=
 =?utf-8?B?NEoxcTNhdDFieFBSam9laFAyZXlxd1NiSS84VER0eVg0djRlbDJkaTlSZld5?=
 =?utf-8?B?THE1cnZ2SFhXVHNHQzB2NnFzZVFsVDBBSWxJdlJRSGdidm40ZHZmSWh3di9a?=
 =?utf-8?B?TUdwTG9RR3lZOTBma2ZwUnpNWEYxOXE5UjZkVitxL1UyeTBlUG5aZE0yNVZZ?=
 =?utf-8?B?eFlwbzZCbG03Z2tpbk9BaERodThWOWtPK2hqYzFqR1RuTnZhQU9Tdk9hN3ZV?=
 =?utf-8?B?OExtbXJBSFF1RkR4RzRJcHBFNG9RMVRDRkdzdlVhSVZpbnNYQ2lyZlVaaitK?=
 =?utf-8?B?VFcvK3NDK0JIK3F6OEdGb3NyUklKcXVIOElWUkU4MGNUMnlWd3p5TGpiZ1RP?=
 =?utf-8?B?V1FHZm03KzBadXY5K0pKUUtrMW1SRnZHUU1xamtESjBXQkpGMTcxNXQvYTVY?=
 =?utf-8?B?aWhVdDhqS0g2cW5PZENGUVltMzdMZHpualg0N1RwYVd1YkhKWnUwTWpJd1Vq?=
 =?utf-8?B?SDhqN2RsRTFUajRzNC9YYTRZaVRlMlRYOVVXT0FHMDlwWkd1VENYYlYxUzRa?=
 =?utf-8?B?c1UzTU1iN0NEN1R1K3M4U3N1cDM1TXoyYVlUVmVXUDgyWm5VL3k5d3VEVUxU?=
 =?utf-8?B?Q1BYejVxdEFqMHltTmR3UnY4NXdOSDE5RFJpVGFqREdTRE5nZ1FLZnlGYmpJ?=
 =?utf-8?B?cjk4dzNHUjdPWlZMQ1BrVkI4TTRkWVZhUkloY3RFU21lTW1VbjZKcVQvVm15?=
 =?utf-8?B?YWZpSU5VWVZnOEpzRExSUDM2bEtZOTI3TElsb0FWVVFzTjdQd2R1U3F1NTZm?=
 =?utf-8?B?NDJOZ0ZtMTRnSUxsZDM5eStySVZDVkNXM0NwNXhRRUVqOGQxbVBncFIzRitN?=
 =?utf-8?B?R0JFZHBIeW1zZStrMTRSN3kwQ3R6Q2tKZlFPY2xFQ3orT2V4aXhlVS9hQUR1?=
 =?utf-8?B?QytIRzAzTGxLNXhiazV1bjJHUndVcnEzZE00dUlsaFpscnZhWlRoMGhYOVkz?=
 =?utf-8?B?N2pYQ2RQWUFweDhWcXJ3QlVIZ2FuRmxqSFdjenpSb1VvQ2pPcHU3YXM2bEFn?=
 =?utf-8?B?MFhVckJMaVZYck9NTjJsTGVoSERNWTlOc3BKM1pEUFFqZlRDRE9nOG5aajhO?=
 =?utf-8?Q?9cynOOPF3ahBGGSG3C4q6BLCt8Mo3s=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Uzk4SjZMMm1sYWZIWkFLODhPT20zbHZaOCtDYjc2aVJodmhyZzdHeVcxemR0?=
 =?utf-8?B?aUxWZXVGWjNnT1pPR3R0aEs4L1BwblQ3VXBwdVNxTUpWRmtxUERITnVxanJX?=
 =?utf-8?B?RlNPL3ppSlBLTFJ3NjRPeFlsQjlYR1lORU8wdkxsb1Q5MVZUUFhUUlFtMmtX?=
 =?utf-8?B?WHFRdGNxcE1GcXIvdFZXSzBpajF4NTRlWUd3Z0dyajJaeERVTzFva0NoKzFF?=
 =?utf-8?B?cXVvT0tTZHlvZjZTS0V1VjdDZjQzUmtHWHFxQjNhbWorQUg1aWhMMk41WE9z?=
 =?utf-8?B?eXZPV1B0NFFiRGFuWE9NZHcxVmVHa010VWNKa0lXTHV2M1dXelh1eVVRRmhX?=
 =?utf-8?B?bG1PT1BGZUhjaUJHQVk5ZEhGWVlubVp1Y2dtY1dXdmEzVGJtZFdnRnNIWTVG?=
 =?utf-8?B?QjNEMzk4M3BLNU9xQUNmVXE2ZkkxRmRmM0hEYzA0bG5FTG5TMlU4ZnlJSnpN?=
 =?utf-8?B?M09XRWJqbTcveWw5SjBuQkRFd2ZITWVKdXc1UEJZSGJBVUFuRnFPK2dFL2FC?=
 =?utf-8?B?YXVZaWNIN05zNHZCeFBLNElQWFRKMzlaem1Pb2JTSEtUZVBSZzRJUEpRWGNW?=
 =?utf-8?B?cXdRb1ViZTFvbDJVRmRjemlwTGJCVUE2Q0RUQVZaNC95bXFZaW1KUFZXYll2?=
 =?utf-8?B?aDI2TXhOQ0FaN1RnT2pZQzFDWWRmekZESS9GNllkVlRNQVlLLzcxYnhSNTJF?=
 =?utf-8?B?VGVZNzhQY0d5bkY1KzZHZ1NkbmQvRGJVYnhxMjJzMTJ2Sm0wZzJ1UXlwejNo?=
 =?utf-8?B?Tk02d2wzci9JaGhUN1U0K0RXMmVtZTFVaXdrR3NvQmNHR3hXZnV3ZnZ4UGtY?=
 =?utf-8?B?ODJ2cDNuRllnWFJCMlZHK1JXaDUyc3ovckZIbzUvbUowS0tXN2FWeE9GbFNz?=
 =?utf-8?B?WkFDVERnYVYxR2lZUHJxcURuSFV5VW9oSkQvTHhIbzRPbS9hWGhMdkczeUoz?=
 =?utf-8?B?S2M4cEozdkw1VUtxeHIyZnBKZnh2Zm5HTXk5VUZMS3ExczFYcjl2djh6OC9w?=
 =?utf-8?B?L0JsWkNwU2VhRjZsWmY2MVpZUnZoZ2ExNFV3N0l2UjdUMTdQZmZRd3p1bFd2?=
 =?utf-8?B?RHV4N0ZHbVgvSk13dnRCV1NKK0dxV214alVQMFVoU1FjbHNXdVRuUUp0MURk?=
 =?utf-8?B?a3pwSzFJaE1zOTFuK0h0SUZWaG5hd3RJSnhKYlFoOUdIdXZPcmtNcVdjV0NY?=
 =?utf-8?B?YnFINVBUM09pTUZUNGdxb2Y5VGhIWGxjS2xQejluN0pkQU9obnpwdWxSaVcw?=
 =?utf-8?B?TVpvbGk4SFdkc0paNTZUL1gxUEZJVGpLUlpBN3grK2IxN3FVUjhsbUErRTVu?=
 =?utf-8?B?blZsMjVza2JhV1JkUngwL0hWQWZoUURyZnZ3OFh2M0tXclJQeXZQbmVCNGQ3?=
 =?utf-8?B?TXA3NFduaE5iLzlJSmdsMlBMbEplenFwbXR0ZGlzWnc0YUlFUHE0OXM4NDhx?=
 =?utf-8?B?ejNJenU0RWNGa0xKUUtKT20wT2hhRGs1RXp1UXlpamVXYmFXbWRiTlNUYkVq?=
 =?utf-8?B?UlRnTWxDS2lLQUY4dE51aldGZHZoNkRyYkthRnowaVdXdkVkN0RxZytzMkxY?=
 =?utf-8?B?TUlzeHFQcXJ5dVIxM1ZIWGE0N1p3cGdJS1BoSnhWWTU3K3RVZ0RieWxZTmc3?=
 =?utf-8?B?RmowbS9rWWZZNTYraGloZHMwSXlCS2hFK29veXVqVFhnY3ZIUmdGNktBRHY3?=
 =?utf-8?B?ZGZaR3VtZkVQSXBwNCszVUl3U0g5MzZXemNHUnlCb0xKaWVKQTA5TGRud2hJ?=
 =?utf-8?B?OS96UjAzeTdLSXZlZWdTNEVWTXF2YUcrQ3JERGlvSklYdzBHOFZFUlg5Vmpz?=
 =?utf-8?B?c0xZMENNLzVLd3ZEclh6eU8zTWU1VmY4aDBsdkhaTHpsL1liTUljSVhPR1Ri?=
 =?utf-8?B?aWd5WEQ1Tkg5TS94akpmRDRuQy8rSjliRG10ZmVmNWpQZVdwSnFLbENhdG82?=
 =?utf-8?B?Q2tXQWVCQmJvblN4ZkY0TVFDdEJ0Yjh1K1A2YUxlMk9tTzBZckxuYXZrdk9k?=
 =?utf-8?B?MnJtdG5Mb0c1cWd5bnEzc3NwcDB1MTRSRWhOc0FyL0Qxb3NrRjJJMjQ3aTdG?=
 =?utf-8?B?aStLeW9sSHpOdlo1VlhMTTVXWTZUaVFJaGhrbExrUjRVYnQxMWRSYkZtSzZ3?=
 =?utf-8?Q?H6OeKEnOyoAapWEPP+Gu+2YkR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e756faf-35d8-447d-966d-08de107f8329
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 08:54:58.4727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Zi16hPRUnWrg+yZ5pOFwoqAUdF4VydvGWKIZhKJV6S7GhTapyYX63vvPh3B6I8DX3ueKJB4nRYSENGKpBU9kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10627

Hi Sima,

On 10/21/2025, Simona Vetter wrote:
> On Tue, Sep 23, 2025 at 01:29:56PM +0800, Shengjiu Wang wrote:
>> The IEC958 subframe format SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE are used
>> in HDMI and DisplayPort to describe the audio stream, but hardware device
>> may need to reorder the IEC958 bits for internal transmission, so need
>> these standard bits definitions for IEC958 subframe format.
>>
>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>> Reviewed-by: Takashi Iwai <tiwai@suse.de>
>> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> Would be good to get a formal ack from alsa maintainers before merging
> through drm, just to be sure.

Yes, we've got an ack from Takashi for that in the cover letter.  I should
have recorded that in commit.  Sorry for missing that.

> 
> Thanks, Sima
> 
>> ---
>>  include/sound/asoundef.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/include/sound/asoundef.h b/include/sound/asoundef.h
>> index 09b2c3dffb30..c4a929d4fd51 100644
>> --- a/include/sound/asoundef.h
>> +++ b/include/sound/asoundef.h
>> @@ -12,6 +12,15 @@
>>   *        Digital audio interface					    *
>>   *                                                                          *
>>   ****************************************************************************/
>> +/* IEC958 subframe format */
>> +#define IEC958_SUBFRAME_PREAMBLE_MASK	(0xfU)
>> +#define IEC958_SUBFRAME_AUXILIARY_MASK	(0xfU << 4)
>> +#define IEC958_SUBFRAME_SAMPLE_24_MASK	(0xffffffU << 4)
>> +#define IEC958_SUBFRAME_SAMPLE_20_MASK	(0xfffffU << 8)
>> +#define IEC958_SUBFRAME_VALIDITY	(0x1U << 28)
>> +#define IEC958_SUBFRAME_USER_DATA	(0x1U << 29)
>> +#define IEC958_SUBFRAME_CHANNEL_STATUS	(0x1U << 30)
>> +#define IEC958_SUBFRAME_PARITY		(0x1U << 31)
>>  
>>  /* AES/IEC958 channel status bits */
>>  #define IEC958_AES0_PROFESSIONAL	(1<<0)	/* 0 = consumer, 1 = professional */
>> -- 
>> 2.34.1
>>
> 


-- 
Regards,
Liu Ying

