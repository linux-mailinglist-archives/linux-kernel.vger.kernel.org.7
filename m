Return-Path: <linux-kernel+bounces-861783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C80EBF3A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E9844EA287
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1441F2EA17D;
	Mon, 20 Oct 2025 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eeECr1/y"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BDB332EBE;
	Mon, 20 Oct 2025 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994443; cv=fail; b=WEc38Ao5oqgnsLLOsNqwvkdWLAY/IBu2mW2Fyb5xP2DXYzjlVCwbZlq64KvbAveF2z49i+Itkn+5Yga7+H1t35DGilhPW/gHayAgD+xHX6GNWVVyUOW1eWRkRsdvDaqtn61QJQDUFzgyY07yqNEuAPVtRJsEc57b+L3jCn5Lq9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994443; c=relaxed/simple;
	bh=jWO/vqLtawYq/L1FaW8TtkZRr1JxKgqoiCXRzAGpMI0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pf3ZOfPAFSAYLIwRSo07N6tNsx1YUTa6QrAbMxBM0/Jb62GORPznHc3alZbnJN91CVpdT8oEyll7dNVI9IJyWe8upgOeQ5RaXaBsZ2J4AyQnxtu6c2/1Jsi3rWi1iLYzCuDbc6CKLSdpj6mg8ZqDmUmI0uHdH6l9SUldrOTKFcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eeECr1/y; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+nPKojJ2mKaIxrL9oZKzmqRpq+R1Hq3V9YSwKwCoOGsK+XLz5IMUpbMHrzv2iOxhmvQkT0gqK5qNPWVSL8xDB/ZZYeDQgKWwzu/AiUF/HWlRbLpQKlZYVRAhUCQhP4hNCIM+JM5GEEh8rMhhrBlItH/sRcPB3bAIfNBLZkIJ8BI7473rcQuwAVUEswwUt43tgidGhXscVLHEIAJDl4rwFF7t3QpXlHQeqNv8YQP6QyhKy2PE17C7tzro0/e14SQRmTXtEme02+dh6t8vU6XFHYKt11TbEojiNM5GPcTmAgAF5vpLf+KTeOpM+vYw1iVFsUAZVf5YkId46JsNSaP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn0HSJcoEI9+hngbKgLsm2cPHG+N9USn0bhMvsyGCnQ=;
 b=M9niJnW2oEYXOO2I7mPunJZbzwLbux+2onMRU+ocN0VNhfbzmuXtUg8dHXb6hfBsV9OmfJx1cOFCb+O1LkQWmeyFQBrEBpNscg24RVIYUJQtBXAR8flvq4suR8twJFEGF+xUBlz+/yNeBVXq8n27DqEtlxFbCeAnnvdwpfaezDxTMADtCdNkeerrOdvFz/RZUtyWQmZgBaq0GYqzHfnlvlROQsQ0g/u9pxA4Fky2egMwaES5k39eiWr9F7vL37BPEZjW749lzejff6uhFNvqvs/bAU0sJKc7iz91t3UWl1Vz4SK8JsYft5aVUBGI9Q6UgTr6EgQj846yzxjWiCgGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn0HSJcoEI9+hngbKgLsm2cPHG+N9USn0bhMvsyGCnQ=;
 b=eeECr1/yN/wxL/VxgfXm1UZ3bPlhHsW/VkZeUuu/buvAALZArrH94OSX6D8B3K7peulevx3mC2nTtI3sj7p6Tjn975d4SKb8Tm5iOD7bj+rRknJ/elepjcHMb2nAS/Oj/U+8+RHXEelYOzhts/s9acHyyDLu1QuTi2KdPjGPFlLW2XdwdSczAVO6DnqDDSmHUBdLXWhEXs+tMAQKsGB3Z/bmDKNvv9cqMrEf4xAS1R1Ad2Q+zpq0n7Iu12X9Ds5eKaEtH04msI9FaYb+tiM6UFwJkGdu1y/TBIZYGHJ5txRAGAPKc5Yv3ItuLmNgUgEPhZ9Rm3Yap6ybt7s39T53sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8105.eurprd04.prod.outlook.com (2603:10a6:10:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 21:07:19 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 21:07:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 Oct 2025 17:06:42 -0400
Subject: [PATCH v2 8/9] ARM: dts: remove undocumented clock-names for
 ov5642
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx6_dts_clean_2-v2-8-3c12ead5094c@nxp.com>
References: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
In-Reply-To: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760994408; l=1733;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jWO/vqLtawYq/L1FaW8TtkZRr1JxKgqoiCXRzAGpMI0=;
 b=w/ob276WDHywmlv1j6CRo13sToRZLCDId8d1NtombGKBuX06Q/yrcEhFitRgZZoMgm/Xdcfvb
 1ZBim5ZitdgAfutVqHLPMWw9rB7l9EvixHju/ix3m8QXUqDmjhmPrcZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:510:323::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c04a13-048c-4284-bf20-08de101ca7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkthYjQzMjBCSTFoVlA4cDBWV0RxMUhRTCs0K3htUUNyZFNyMWkvOFRxRmRM?=
 =?utf-8?B?S1d5NHlhbVYyY2NvdEdpR3Q2VDVyYzh0VEVHbzAxMUpGeVV0WmN0TmZ4NFEw?=
 =?utf-8?B?YkRPNWljUXEraktob0lZbE9WNUlHVHo0ZHVHREtjNnZFdU40bkJ6aE5KM3dR?=
 =?utf-8?B?cHJPUVhubUxrV2tZZHhPaW8zOVRoTU1zUEhsTk9RUWZYU2lUQ3VqUkhZUHp3?=
 =?utf-8?B?MHpFUlQ4OG04bjY0aXA5Rk1MYi9Kc3Fva04zcjI0MExvd2lwMUNCS3EwYzUw?=
 =?utf-8?B?L3RCRUlrQjM1eHBaVVFmb3dqTmxNVjRjMGpEZzlZVzhhREx4dURLY2NOM1ZK?=
 =?utf-8?B?bGNKbEZuZERKclNoZHRQOUdnS0ZoSjloOEtrUlBTZmZrcklIVmdDaWdjQ3ZV?=
 =?utf-8?B?QUsybFRkRkRRQ2RnRnE5OWw4dng5OUZrVnZjVE5JZUNzdEI2RGhHcFRjMkdO?=
 =?utf-8?B?b3FCWHRmZEo4M0pkd0ZyRTdGNk9GUzIyV1lUbndPMW81cEg0aE9JOEdJZS96?=
 =?utf-8?B?V0dtUmR0N3h4YXFWOEc3SHVyZFN3TkhPcTNIeEs3dHM5bTBPek9HMXd0WmdI?=
 =?utf-8?B?ckZYeG1UNEtmMUZiNkN1ak5CaWFmTURMZUlFeWVrQVZGQlF2bWdqYUFiYUVx?=
 =?utf-8?B?OC9qRnNuOS9Wc25FZ1RFbndrVjF3eWxlWXJRUEVzUGNpZzh2V21lTDIvcGJH?=
 =?utf-8?B?QnV5ZDVobGpIb0dwOHV1SjNzc0NlWHNTRUlXUDcwYjVMVmxmZ1UxakFTM2Np?=
 =?utf-8?B?TEhObjBTeVhKSkYrTG1FQ0YxRmhpZzFtV1FHZzBET1VTZ1g4VzQwckN0VzVz?=
 =?utf-8?B?dFZkTVpnRjZYZTRBWjFZbHBaQkw3SngwMHVWM1h1TzIzR0lzaUhnMkRPK3ph?=
 =?utf-8?B?WDcrSVg2dVBHaHRtQnBDaFU3RVNlZlhKZzJlZVZZNUhzTEJaanhZTFBwcEFT?=
 =?utf-8?B?dmhTaDhmN0ZvWG1LT0NGNEJ6Ukk0RnlvSDA1dUZYdDdJYko3UUhNZm5KUnFY?=
 =?utf-8?B?VnlCWVJ6UFBsY1pUMHRFd2hBV204ekJHcUVQZzFtbXd1UHRXN1JIOG5QM2ph?=
 =?utf-8?B?aSt5TXJ3azF6cjUyS0dCWlRVS25oZ09ERVlKNWtsbUdIRTdjbkhXdjhGTlYr?=
 =?utf-8?B?dk0yM3I5TnN6ak43b2MvSWljNlczV3RzcE1md1E5L2w3dlRmbEFIRUJXOEQw?=
 =?utf-8?B?SFlBUFRxdG1vUTdOdkpTbEpzd0M1L3cwY0pLdWNTeGNpbW1FZ0UxRHhONWp3?=
 =?utf-8?B?MmpTMEg5QjRiNkN3OXpaQW1TM0EvdHBHcDBSQ2pTNVZjeUNIOXNjbnFtenJs?=
 =?utf-8?B?ZG1nL1Jrb3RPYll1ekhsWnAyTlpsRUpkT1RlM0Zwa0JORExybGJyd3V3Zi80?=
 =?utf-8?B?a0s1YnlJZldvanpMUUM1bnQzdzBHYW1PTVJLaUZZVWdwY0MzMWR6QWZGaUVt?=
 =?utf-8?B?Yi8yeENTWWpad1ZKUUxDNERCdjQ0a3dFcnM3VjQ3WStwR2VDY21pL05RMzVm?=
 =?utf-8?B?Y1JRMVZvWHZNVkNQNWVKVWl2bW5DNHAyaW5YWmpFZ0RkTEZjcHJFY2NQci9O?=
 =?utf-8?B?Q0kwZVEzTmNvanl3cHF3MUtHeE1FMVloN1NzbHJRdDQ3eVJkTmpEY1FvUWtK?=
 =?utf-8?B?ZnkxMkZVdzBYRHQ1REFaUW90RWFvZDVLQ1ZkU1cvbWI2QzVibUNQSWx2dk5y?=
 =?utf-8?B?WUVveFVRdVAzY2I0U3p5UFoyeFNPUmJJWW1qTGNYdUU4bWlnNDF5UXVQS2U4?=
 =?utf-8?B?TS9Pd1JjU25VYy81QllZUmk5OXkrSE45QVlNa1VGeHlacWJkS3llT0g1cU1W?=
 =?utf-8?B?TnZBZjZtVDRMWWtac1FoZW9TQ0VTb0JmY0FjYzRjaGlEWGFxa0xlVzBJYUVB?=
 =?utf-8?B?dzllTDN4WE5PcFRxc254ejZMNjhwalFQdmhlZmJGN2x4WXNtZVR0cWtQbnps?=
 =?utf-8?B?cm5uR1hJeXhGdDhSdnNqOUtTa2JUcFBnZ0NlWW9IbjZ1VHAxRjY5cThOQk03?=
 =?utf-8?B?NzBleno2c093PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXpRRnJMZnVvY0RtYmxGSjZoa29qaXdGMkFrSDlrcmFhV1JzRkV0bysrNFhR?=
 =?utf-8?B?TTFHTVhEeHF1dVJmSEdtNGx2MExtUU43SThxVXpQRzAxUnJ2VUcxekVNV3Vl?=
 =?utf-8?B?U0cxbXpFR1Fyd21vYXRaQUFxRFQ2d0tEZVU1V1g2NXhGY2FiRWM2Z0pFSFIr?=
 =?utf-8?B?enR3Q05nbjJiOVJUWVY5d2locXYxS0oxQUoyaWQrdGY4b0QxYllrdmlnVEtB?=
 =?utf-8?B?M0ZsTDc1UTRKZ2VxOGZXZlNpT2hRMkVQUisvcjJ6YUZLR0ZSaDMybGhFSzIy?=
 =?utf-8?B?S2VWaW1rS3ZsdWJWU2JCTkt1STh3STE3cXlheUY3SGNZbEtWcHBDeTVrK0Z1?=
 =?utf-8?B?MmZlTnIzZ3RHMkswK3FZQ040eWl2VEJKYTZjNG9qNmIrV09aeCtGempsWmR4?=
 =?utf-8?B?eks2QmVoUTVnRElhNnpya1NURkl4dEVHbVgyRnN1OUNJWUlTb2lBR295MHh6?=
 =?utf-8?B?Q09tWFF6Q3o3ZmdLL3dWc09YdTJSb0RSSVhyUXpkd2tMVGNoelRjS25YclFu?=
 =?utf-8?B?U1dCbnVKS1NmcmVUckUvSUxhOUJtWHRpemZoNnZUZ1grWFFFcFRoNlFUV1JU?=
 =?utf-8?B?bUZiSDRJaEx1NmtiSXdkaExJNHk2RDNJOHgxUjBsSkw3eGdwUU9RRERJRDcw?=
 =?utf-8?B?Q2tRZnFWK2daamZHY0ZLMVJlRCs3dEM2NmpvbFdNVmJqdXUrNGhiYTdXNGV4?=
 =?utf-8?B?UmhOMzkvV1ArM1U5NnIybXNEZEh5YTQ3SGJONmRNZjFaTUFGcU5JWjlYYUhP?=
 =?utf-8?B?S1B6U09LQjhlVFVITUJXYUs2V3BYR3pFQktSYllTZkx0d2ltMFV2TmN3QUZK?=
 =?utf-8?B?SDhpSXV6b1V2dmpZWHh2bGJjNWIrcHJqV0Z0aTNhSkpzUGVlalFtNFVyZ3N5?=
 =?utf-8?B?QU1vb3BaNit3dkVWUTZvaUsxVXNwblJQazdwUGRoTGZoM1VuaXN6RDR5aFV0?=
 =?utf-8?B?QkVidnIvOGI0RklPOWZFa0E3Q0d6clZyMlBrV0NTbnFZNDhHMnFvL0ljcmQz?=
 =?utf-8?B?OEtvd25XdXlyenBCMTdOMWtuZnlSeVROL0lJRFhWdVpOeEhkZnZMbnM2MDNE?=
 =?utf-8?B?R1plUGhnYTJ6Yzk1SytCLzR0Rjd0cytBMUZNTzdmZTB0UG9UWk03Z0xkSFVq?=
 =?utf-8?B?UXZYT3IzM2MydUkrT2x3WDRRTnRUcXBFN043ak52Rk9Cd2l6ZzJ4b3g4N0Zs?=
 =?utf-8?B?bitlKzBOOFVCKzFacCtFejAvckxxdlNraHppNUh3emJQQVJqbDBnQnlURHZP?=
 =?utf-8?B?NmN1emxzQ3YrelhzTFBWbE9uUUhla25EOEs1MDcrb05tRW9QNWJaL3BQSlI1?=
 =?utf-8?B?eUh2VmxsS2FmekVyVlpMb2tjblpFUE05ZmU0OHJRdVV0ei91eFBVNGlscEVy?=
 =?utf-8?B?U2dQWThnTHFrbXVXeUtBYTE5S0kyZ2w1SzF5eDVvNGVZZVBoK1RpWFkzMkhR?=
 =?utf-8?B?QWpjYkdxdHhKZFNLYU1aZ1NVdU5hWEtVMitjSnNYbmRXSlIwbzdpME9UeXda?=
 =?utf-8?B?SytHcGttcmQ5L0IrZThjN3RBRmdKU0w4WG55VWJrT3JEVVl6VDAwMlF1WHBx?=
 =?utf-8?B?em14R2ZobmxvbEhBeHBPcDJNaDV0YVBjcWozdnJQMnBOUTY0NURERmdydXkz?=
 =?utf-8?B?RGlYaUxsUUg3d29QZzJkL1gzbWgxd1h4UVZjSjdJWGtzS3V0WCtHQkI0cVFF?=
 =?utf-8?B?djdRNytDL1poa2Z1b1hUdGlqSkFLdjZJNHZtY3IrZFFpaWY2RWVCOUJVYWRX?=
 =?utf-8?B?S21BWmNydnJuZVVUZHpGTkNaTFY1ME1ud3pqa3FMR0VMcVBQVEk3TEc1NXBX?=
 =?utf-8?B?cEtQZ01Sd2NuMVdwWTRnZkFNMnZDa1RmbzFXcmE2Nk9rYWg1ek1wU2ZrcFAy?=
 =?utf-8?B?WUV1Wk5OY1QxRUZMM0UveTczdy9RMnFsTGlFM3JJdmxHQWJxR1NQbWFsNFZT?=
 =?utf-8?B?Y2s1S0RCR2tOS2l3OE5XRnBhODMzR1lXcXBMdE9CWW1kYzlrcHNDWlVCa0x5?=
 =?utf-8?B?T09ZQ25CNTNoQ21LMk9sR3hxUlRDTmJiV3VBSWM1MEkwZW5vVWdvNnZnRWNp?=
 =?utf-8?B?VWc0QVQxNSs0d2NLU29IVE5qaXN2K0FxZmkwRFFYdWVKeldPbzNFY3NBOURU?=
 =?utf-8?Q?X0Eagp0Y5J6iXZcrGe+9e1XHz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c04a13-048c-4284-bf20-08de101ca7cd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 21:07:19.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ka+VgLXKsfLXMUu328L5kNUXmndwQ96Sp6Kl/Us2bi/j4tr92LfmEdmkzp0I8Yk2SV2mQido4/R8RusiUvfz2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8105

Remove undocumented clock-names for ov5642 to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6q-sabresd.dtb: camera@3c (ovti,ov5642): 'clock-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov5642.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi | 1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
index b2d9e528fcfec55d5467a11ae4308fc92c1d1d50..3b7d01065e87b2587a87f97438eea205be3222f8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
@@ -363,7 +363,6 @@ ov5642: camera@42 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ov5642>;
 		clocks = <&clks IMX6QDL_CLK_CKO2>;
-		clock-names = "xclk";
 		reg = <0x42>;
 		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		powerdown-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index d1adbb11c51ae078094dbe475b85038c89d243ac..ba29720e3f7205675b46a14ea4ce3f8957790911 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -287,7 +287,6 @@ ov5642: camera@3c {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ov5642>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
-		clock-names = "xclk";
 		reg = <0x3c>;
 		DOVDD-supply = <&vgen4_reg>; /* 1.8v */
 		AVDD-supply = <&vgen3_reg>;  /* 2.8v, rev C board is VGEN3

-- 
2.34.1


