Return-Path: <linux-kernel+bounces-897842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0928C53B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACB77344370
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96477346FB9;
	Wed, 12 Nov 2025 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DGyccirs"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A205199939;
	Wed, 12 Nov 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969074; cv=fail; b=JgBCD3ZhFJK9QU0omGsCq2fssYqtetxLkwLYy19z0tCjWgbfWTOjkZUdzSYWL3c/cVP6fqCvL1GIGOsISagNbPerKILVnp0owL0/RE978ndzVE6nr2sfWutwuaY2yv7WEpEtVJilDQsdgDZx1yCo82qt1fPqWkXTXhQ4afuLlKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969074; c=relaxed/simple;
	bh=VGPxdZqs8b7uxugmGWRc8MCwqj8xXHVlon0i4tg7pQQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SQwtdLakRXVZXpkmgTwexVUG8nWKWG+2Qg7YTlc4BaAt2CZICDmT3HP+cSLVs2QXHRkuPLrq1lhmoihuvwlisfniv9jILW4t7lhdWxxiwnzBl9o7UZ91LFPF3g2WWhgaxRXpvvMag3VIcOF+7IE11KR2EagluDtuklggcpzg/cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DGyccirs; arc=fail smtp.client-ip=52.101.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbr03HZTF2bvfeapPqAre86k0X41WeE5q/wyzNc7ATbRQhE2mQrVThmpg5ZT7CqgpAwHkJUL1cNZ/x4hJEIkQKT/jrDOW5MKm5As4UFHuHsFVmFg1DFp8Jyh38bKMQr0ADBauQIxzAr/PD7E6jeWocTXEPAoAiOrtSRfXix+OzmiGbV+xyLZDfDuvQ6ndEd31KNmLa/UAeUE/2I/uUm3Xwi25xrXvMr8BhbxBQc9kx8iT9B2aFPoUAOHMXR55v6q1zlEM1uRfClKEJfavT+MT93H3XCFODiX153ZtpZNHrL4zKN5+Q6ukxc4ZoW8KzZkGrv9gaY7PR2WmuHnezCZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7JrrJxTt3cltbRKHP8+6M8dRMReQWwP1zlGPJ86Wc4=;
 b=TE3CbHwHZ3aZYW9aJIv0ic85boMzbpS+5MY+u4bS+PAlOrg2leFnlWqBWoPOCYj32MeIO+xfolbQ02gvAWk9bkZ5OZlIQa+NwLIbH8LQbwHlDzfpxPAeLpVRAegz+5t5CnsP8bhFl5Mvd/JioFxhmmtIbclrgDUs/Fu5zjdjpUz4HRdvXA4FtNeeRzRoMOC/BN0fx+201cW0b/0WQqceIP4dmRvZZ0EzW1tw36ZCC+Nz2oOY5Pkvw07C+KNrLpmKSCtAhZ81UNYYuLwG6uEED/axDMKPH6VqFPZIpuAtMpYAiXVuv7bEh22bm6PaQfx34dLVfogWUXsTGp3rYQX8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7JrrJxTt3cltbRKHP8+6M8dRMReQWwP1zlGPJ86Wc4=;
 b=DGyccirsq+Z0Jv6k292hztRCPWpYJu6sQj/d/P0RXr/o9j87HYrO9rOSCSokC3E2LPRL0fyri3JglkKR5JfL+FTTeyycbIJC1GMlRvBmqYW9eu4DU5cwQKNG4k9otee1e5BCwP4K06mexlJF/Zt8kh2xIK17ytGBdqbUlrBr+TyT+QsLN+sOxwtEX+kv9y0aqkWWG5r7jj666Azye/M6799ZXF0u/5sIQCl8ZyYKo3TqIs85BQnEggnRFouF/ka471WD0Ctz0/3sil0lPdnipr0XYuPDoJKvefMicZa6jYWuzatXxVqVoehau+jnzMGrTBYk5NPCXhz4ynbYRPsE0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22)
 by AM9PR04MB8339.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 17:37:49 +0000
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::a361:2618:7785:3bc9]) by AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::a361:2618:7785:3bc9%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 17:37:49 +0000
Message-ID: <6484e7a7-6094-49a3-8b86-ede29c630596@nxp.com>
Date: Wed, 12 Nov 2025 19:37:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: imx9: use SCMI API for LM management
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251112144124.680-1-laurentiumihalcea111@gmail.com>
Content-Language: en-US
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20251112144124.680-1-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0049.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::8) To AM9PR04MB8907.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8907:EE_|AM9PR04MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: a100383d-5f3c-4122-7be3-08de22123318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkRuYXltQmNJeHZSdmhldWx2MnBQc3MzM3l0c2c2OVV0VngycWU5dmExSHc2?=
 =?utf-8?B?eDlmSHJwWk5FMWQyN1BGU20rWGYxUzlDYm1IWU9TdWQ5d0FmbjdQQXBBUmdE?=
 =?utf-8?B?RlBPdHVaclRJK1FIcCtLaXpwQXorSkNrcWM2eFI1LzlpM21PUVRyTnhhdkp4?=
 =?utf-8?B?bG5vSkxjY3Nlb2VvRStvUzd1cEsweG51SjZBTnN3R0Rvc1hCQ3ZtaW82Y3Y1?=
 =?utf-8?B?V01EMktGR0M1T0VReis4WU16TUhtV0dWbC9uTkdGQjk0Rkg5ak1UdWNTM2JK?=
 =?utf-8?B?cVBNeXJiQVc3M0RkSEZXR3pYQ0hZSlIvaktRRGQwZFdETDlzZFF0S2M5akF4?=
 =?utf-8?B?QXNnOG9tT1dEcDlSMEF4Znc4bWQ3bXB6cmdvTUxDOTVLUmdha295NnBHSi85?=
 =?utf-8?B?c0I2clhnNlVuQ2dpWWVEWnlVQVAvUytGQldYcENjeVRGYmZ4QnlnSnI5VFVL?=
 =?utf-8?B?cGZoQ2VUYlY1QmV5bWpyRXppUzNvM2ZjM3V5dHh5TG5DdmlOQWZUU1Q5ck5V?=
 =?utf-8?B?dkdCVzlkUTJKeC9TTWkxRnAvNjZydDJrZ0VRaytQakc3UHAvZ3c2UFFhVmth?=
 =?utf-8?B?aGpRY2hFNUh3V1dlMEVZc3ZkRmpETHVEQmRJTG5FVlVFc0hJay9iRUs5Snc1?=
 =?utf-8?B?VWQxVTNVUXFBblhKaUo4WGJoNUVvV2pvWXg5T1FLVHlrdlNadHlZYlYvcEVz?=
 =?utf-8?B?NFpkMU1ZbmgzNkI5TllRSkFTMEVrZzJpbzA2QWZDWERacS83a2NXc0E2RlVN?=
 =?utf-8?B?MXhPV2liQzJacHk5R3c3emRjSFpQRmFnZG15RXZmclRjR2pWYWI4VnBGSjlq?=
 =?utf-8?B?QStiQUkxQVowVUo1MjEzM2tpTldkZ0Zaa3RCbE5iSjdMUDkrekMvK1RMckdB?=
 =?utf-8?B?K0k4RHgydTZGRFgzQk4xenNFOWFCOTJ4RXkwcG1XV21CUWYwZnNuOFhzSFpR?=
 =?utf-8?B?T3VKekZnZ1pYTTUvYmtYdHhHNEx1SlF5N211dXJPVGdHTEF2UzkvNGl3eGNL?=
 =?utf-8?B?dkQ3WW14TUZKb292czh6YllTNjlhVG11ZEF5NERCOEVJaDVaM1lteEQ1YlZ1?=
 =?utf-8?B?MENLcUJXTkxUMkxsTUQ0c3hxeDZtWGdDcG1ES3I3YUpBRiswWDYzTXhxcFVE?=
 =?utf-8?B?SktkNzVmek56SzVKTFR4aTJGbkRHT3FBUlczM2kzMjE1WERNUTBVMTFZOW5I?=
 =?utf-8?B?MktteVdoZThKaW9qVTEvQmtlVUR2cjFUdGU2NFVGL2R6OGMxUy91WDN1RGhx?=
 =?utf-8?B?WlkrNkI5SEdEUENtNlE3M3hORzNzY0kzV3RJaWZoTFNaUlFuaEZsT3pGZ29S?=
 =?utf-8?B?OHlQd295aGc1aVdtSHhtQllJMXIwNXBZN1UrY3UvbHFlMnlHRlVYdGJYZjVu?=
 =?utf-8?B?Q1Z1S3B0anJSRmt6RXYzbFFkTm1jcWVVSG83RzFCYXRnTTd4TzZjWmpBUE05?=
 =?utf-8?B?bU1Uc09FdExUTG9MbUdnMlFXUE4wQXNhVW1ZTnhRUXA0aThZTE9jNXBXVmVM?=
 =?utf-8?B?YWpEdEx0bWlrMndCUno4dHBFUC9SeWFvajVrbXJuV2JqRnZlZHU0clZIZ3Nz?=
 =?utf-8?B?SXFRcFkwU2lvT2FjVE9ROUFsZ3dUQU11RUY5UjRIczdFUFAxTlBkWFVlaUxk?=
 =?utf-8?B?OGZ3em5NYUF3M1h3SG5DN1gvV2xhd09OaTFTNVJLR2JqYzBDTEUrZitEaU9v?=
 =?utf-8?B?cUY4UGlLVEtlYUtQemJIZFNESTlOZmw2dnpVbVZiWm54WHEzMTN6ZVlzbUZ3?=
 =?utf-8?B?NUdkQW9iOWQ2c0RSUVg1Q1I2RThIbzNrZkFIVHRuVUFPZXVyWktSS24yd0lN?=
 =?utf-8?B?cHliMHM3VGlOSVUweEZiNmNjOFRBc2JTeEJMRDRmWUtJQ2puallIME5rT0Y5?=
 =?utf-8?B?YW43QVI2N2dQS3Rmd2JjS3AzalZ6NUIwWmwxb2ZCczdsZm9pMC9hbzc5WFEz?=
 =?utf-8?Q?3cw3tkz2HgjOoDxIO6R70fB7KZFfdxok?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8907.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnoxdnZjTnZJZGhlZ3dhdVdtalFLaGFCK0VISzJNR1F4a2h0ZWdTTURWMVk5?=
 =?utf-8?B?eTdaUzlXK3JFREFMcnJ1dkhQNXRVYXJLV0g4amVDMG5CdGtRRHNNdjZwQUw1?=
 =?utf-8?B?Uk12MDRFa3hKNnA3dy9OWUZlS2lWYk1nM2I3Nk1mN1dJZWdHd3NPSis5NzRw?=
 =?utf-8?B?N1poeklHS1VxQ0d1TUdrSncyZjk5ZHBzcHVjd25RVHkwdVJqNDFJcS9ERldw?=
 =?utf-8?B?dXlQeFRQeGxoSkplWjdKVVR1YS9wekY4SkhMNEVqVXpGVHRiMnVyc2hqVk83?=
 =?utf-8?B?NENQYmt4SWhod2J1amNpTmdBckNxNEw1Z2s4emJ4NHk3Wkc4UXFneUl1bGI4?=
 =?utf-8?B?VVYrYmJVRVBWc1Bkc3FvNzVuWEJINWsvaHRrOHJYbTdnNE5QSmdYeDBPQlg0?=
 =?utf-8?B?M1NEaUFMSXZ4R1huYW5ZVDdNNXZlRC9KZGUwQU9ES2lSTlBuN0ovempwL1Zu?=
 =?utf-8?B?b3BvbXBqK2YwcGl0TFhHb2t6OElBUDZDbG90cmw4dzlVNjBTaEpBM2VBUU9P?=
 =?utf-8?B?TGRleEhyTFQ2TFlFeFo1bGh5NTdqYTduV3VlSXExSDJDOXFpMWpmNUE0enQ2?=
 =?utf-8?B?VG9pOEMvTUdSV2ZyWWtSQm1jMzdraVA3QjZudU80ZkI3TWNvaVd3VExQU0NO?=
 =?utf-8?B?a0xwTkxyRjY3T01vOGtaMFE1QktaUHdrNUdtVnlhR1FpdWxrWU1GaVBsaWZk?=
 =?utf-8?B?UmYwWkhhYXE2WC8xaURMR1NyOVUra2lkUG9KbHdZd1BlanFCSndKOEhlVy81?=
 =?utf-8?B?bFpUR2x4aHAwdURZdGowYWhFMHVxa0ZKVCtPWEZYbk9Eb0V0TkdUcTVrKzI4?=
 =?utf-8?B?K1BxQi9aeFJKai94a0RNSGJtMEMzSEtNR1VVZElwcGZING5oZTZPeDFWZm9B?=
 =?utf-8?B?QlpqcUV0WlFVTjl0RnRvSUY1VXFDblNTOWViRkwxZTh0MDdmS0g2aFo2RFBJ?=
 =?utf-8?B?VStCQ3h3VUNyc3E5TVJ2WnpQQmowaitiK0llWmNlMHh4Z3VPeUhVS2ZrYk1K?=
 =?utf-8?B?cDRuYjQydGhla2JYWVFQbSt3Y0ZaWG4yNFpUQks2UHVPYnF4dW15V0dOWDBU?=
 =?utf-8?B?K2pIUmRoSG92Nk1KSXRYYzdlZkpZMWJoazByUkd2My9NdTVpSmJhOW8rTDQ3?=
 =?utf-8?B?Z2VUNXNQYi9PMkp5cjd2MjlMaDNIZjZFQjdobjFTU2RycHliRFRKZ3BUdzFJ?=
 =?utf-8?B?S3dHWDZCb1RaUm5QdzltMGhDc2JWeDNBRlVlSjJONkJHL09mRHBEUGMyZEJP?=
 =?utf-8?B?d0N6WEFBbWN3aWFIK3RuenJwV25JTEhwdXlYK1BiZEpMcmFTN2xKaGEwM3M2?=
 =?utf-8?B?N1NZN3FjSlh1SnhJczExYTlzTUprTHN3ZzA3emVmaHhSK1g5ZGZ1bzlFS1BD?=
 =?utf-8?B?a05uU1BQWnBQcnlibzBmK2NKa0dmczNVUWZqdGJRU3JleFJCWklxR1lIbGMw?=
 =?utf-8?B?aDVIQ3FSK2F3RkZZcmtFMXFzVTM0K29MaE1QTm55M1dpRGVyM2Z0WXZVM3Zs?=
 =?utf-8?B?eFVKODdDMEpWZnkwWU5KcWlUV0lEZEQvY0orbWpJWlFYaFZNWnRyMjVyeVFB?=
 =?utf-8?B?dGlKK1NnN1djRmNHcUM3SnMzcEVvMUV6WkllNm9Xb3FNc0VxRFNFNVpLU3Vh?=
 =?utf-8?B?eUZqWHZNckdRZExuc0FtV1llU1NuYjNSM1BJOXYyMXVqbjBUeFg1L29XZ2lC?=
 =?utf-8?B?NWtKd2VBdHdQdDR4RCtPL0hkaUxSZUg2TnhXcHVUWHIzZUJrMWtkMzJBMXpx?=
 =?utf-8?B?SGZMT1BtMFV2Q1dxMFRIRFdham1XcXExcWNEQW1lRTl2SW9WSVRFYnV4T0gx?=
 =?utf-8?B?akRrcHJYTi9XZ1hlNmNkcG0rcEk0dHNOTG91a1ppenNhSEJjOXJlUUtuV2RY?=
 =?utf-8?B?YzR1U2ZQLzltTllIQ2l2TFBvOThqckc3VCsxemdTeVIwTC8wdlZSbEphd0NW?=
 =?utf-8?B?ZE1xd21uck9FWmhKajBYSWFqMWs2QmlSUDNEQ1NhcEpVS3JCc3pzRldPaDZh?=
 =?utf-8?B?TVFMY1kyaU5Id1RUb2FyaExDRXpuRzNFVVdhQ1NFalNmNXNFRXRnZnZ6SzNq?=
 =?utf-8?B?WGs2SmV2d1pkWDZibmxBTmJ3MjVOeWdtSjVTcXhmZU9VWnlVV3E2SXQzblRa?=
 =?utf-8?B?akZqQVlRS2ZpaXozdllKY0t2aE1aL2VOTEFEbGJqRVdTQ2pDRDlrQk1pODNo?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a100383d-5f3c-4122-7be3-08de22123318
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8907.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 17:37:49.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33+olVFggzO5Wgp0OrrTNXtsnG60u3YPRsf3yfsbojPpYXrT9lbnM95Csrx5os8jn4p9BP/OqYmzGF3hcX9Uiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8339

On 11/12/2025 4:41 PM, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Linux supports NXP's LMM SCMI protocol so switch to using the appropriate
> API. The SIPs were intended to act as placeholders until the support for
> said protocol was upstreamed.
> 
> The underlying CPU protocol command from IMX_SIP_SRC_M_RESET_ADDR_SET is
> replaced by a LMM protocol command with the same effect (i.e. setting the
> boot address) since using the CPU protocol would require additional
> permissions (which TF-A already had). Apart from this, the SIPs are
> replaced by their equivalent Linux LMM commands.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>   sound/soc/sof/imx/imx9.c | 36 ++++++++----------------------------
>   1 file changed, 8 insertions(+), 28 deletions(-)
> 
> diff --git a/sound/soc/sof/imx/imx9.c b/sound/soc/sof/imx/imx9.c
> index 853155d5990a..e56e8a1c8022 100644
> --- a/sound/soc/sof/imx/imx9.c
> +++ b/sound/soc/sof/imx/imx9.c
> @@ -3,19 +3,11 @@
>    * Copyright 2025 NXP
>    */
>   
> -#include <linux/arm-smccc.h>
> +#include <linux/firmware/imx/sm.h>
>   
>   #include "imx-common.h"
>   
> -#define IMX_SIP_SRC 0xC2000005
> -#define IMX_SIP_SRC_M_RESET_ADDR_SET 0x03
> -
> -#define IMX95_CPU_VEC_FLAGS_BOOT BIT(29)
> -
> -#define IMX_SIP_LMM 0xC200000F
> -#define IMX_SIP_LMM_BOOT 0x0
> -#define IMX_SIP_LMM_SHUTDOWN 0x1
> -
> +#define IMX95_M7_CPU_ID 0x1
>   #define IMX95_M7_LM_ID 0x1
>   
>   static struct snd_soc_dai_driver imx95_dai[] = {
> @@ -38,7 +30,6 @@ static int imx95_ops_init(struct snd_sof_dev *sdev)
>   
>   static int imx95_chip_probe(struct snd_sof_dev *sdev)
>   {
> -	struct arm_smccc_res smc_res;
>   	struct platform_device *pdev;
>   	struct resource *res;
>   
> @@ -49,31 +40,20 @@ static int imx95_chip_probe(struct snd_sof_dev *sdev)
>   		return dev_err_probe(sdev->dev, -ENODEV,
>   				     "failed to fetch SRAM region\n");
>   
> -	/* set core boot reset address */
> -	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_M_RESET_ADDR_SET, res->start,
> -		      IMX95_CPU_VEC_FLAGS_BOOT, 0, 0, 0, 0, &smc_res);
> -
> -	return smc_res.a0;
> +	return scmi_imx_lmm_reset_vector_set(IMX95_M7_LM_ID, IMX95_M7_CPU_ID,
> +					     0, res->start);

Please add a dependency for SND_SOC_SOF_IMX9 on CONFIG_IMX_SCMI_LMM_DRV. 
Without this, the functions scmi_imx_lmm_reset_vector_set and 
scmi_imx_lmm_operation will return -EOPNOTSUPP.

Iulia

>   }
>   
>   static int imx95_core_kick(struct snd_sof_dev *sdev)
>   {
> -	struct arm_smccc_res smc_res;
> -
> -	arm_smccc_smc(IMX_SIP_LMM, IMX_SIP_LMM_BOOT,
> -		      IMX95_M7_LM_ID, 0, 0, 0, 0, 0, &smc_res);
> -
> -	return smc_res.a0;
> +	return scmi_imx_lmm_operation(IMX95_M7_LM_ID, SCMI_IMX_LMM_BOOT, 0);
>   }
>   
>   static int imx95_core_shutdown(struct snd_sof_dev *sdev)
>   {
> -	struct arm_smccc_res smc_res;
> -
> -	arm_smccc_smc(IMX_SIP_LMM, IMX_SIP_LMM_SHUTDOWN,
> -		      IMX95_M7_LM_ID, 0, 0, 0, 0, 0, &smc_res);
> -
> -	return smc_res.a0;
> +	return scmi_imx_lmm_operation(IMX95_M7_LM_ID,
> +				      SCMI_IMX_LMM_SHUTDOWN,
> +				      SCMI_IMX_LMM_OP_FORCEFUL);
>   }
>   
>   static const struct imx_chip_ops imx95_chip_ops = {


