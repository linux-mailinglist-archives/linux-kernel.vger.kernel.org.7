Return-Path: <linux-kernel+bounces-799372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582BB42AAB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250841680BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49482DECB7;
	Wed,  3 Sep 2025 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VLyWDZmB"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379DA369999;
	Wed,  3 Sep 2025 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930824; cv=fail; b=IsJ0LXHrUHJpr4U/I7HwtSQRdylMeBFEwAdT33fBGAJkQ8Jflb8hJDxmorTjYBbjX3W2Hmi4t4FImn/Rnnpd/VPV+EgBd12rV9h2uzcqs+kYlhpaizuUqKuvICl/v7rmYLh37K3ubweyrwiShUE1K/XeWiQtWavRPhoE8t4dd8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930824; c=relaxed/simple;
	bh=NJW4VKU9u/7kD1dIJVA+tuoADwHxBQjLmSGbVxODzCw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gxmD5XhdibGfff+fQADRb3h9LxbcLJtueWE0kbAymzUdDbZNZ0jI1rk53/GBJwGKDwTMyXBZ2PxvMDpOLu+RoNzd54jQsllPt+tGqXcXsA0lpcXfgqBgSSfLveLQmJxIVIjyjmoDnT/8utwjRpImzYgBexfnDRBVU/iKikMmjEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VLyWDZmB; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YixrfYzHfjqoUALraQv0oJLmST+hZNZoMToUiBLUfbjzGQTbCP3s4RiSuRlC0F4neNWM2HurrzZE9zQUIgE2dP1ZkpUWv91LZVIL68GLzZ3yYvBioMGd6QfsZS/r4YSR0flMOkBbj1An8/tQl7Xu3EsfIVF5gqWrlq3HM6p7kHNh0kR0fnp9m7LgIi5sZ3sK/h/LbXi0Ic/r8OH2st121lSPiXAJzNjWZ75l/CjUC2ICWIIk4B6+n5yyhc8d2lBtT7ri665u2+CohTZB6bAvzvxUhrqs1FQZBz/M3IGcPmQZOdV3mfujP/c9vQ2D1w0jSaxtlEOcza0phKeEKAsa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zO5cVfSNsqS22nYo2lRfQc1YcFaJGAJUKrHiwZ8bok=;
 b=RMFjy1pt/iFtziMAaGcyjTOP6ZRiMkTpu9YmctmGkRchB0OKFkrkPLe7RpVxlesvTM/MNP1sGa42/h0nov6Armp6YR5iwoXaEeXuKRWO0gO60WaqQOBlh/vXNWvuudsKyQ1AQ1b+aY+KSIDNxTPUyQlJTBFGjbVUxmJxGsCOMNoaam2V/ifd0rwajNhbSogjSHvbi9D3b05wT5F6Bo510tpqTgdixMbg5zoxwQ7k+UsyAp5b+YBLIf2fQIYBIo0Obrd6jsZx93n4wj/zMqx4nJMPs2fCFcL5u9WgVq83+vOQXdLvTrNsCV75PGwHxkH/VCJ1vJP86A+VNaP61ZpJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zO5cVfSNsqS22nYo2lRfQc1YcFaJGAJUKrHiwZ8bok=;
 b=VLyWDZmBFel1bOeAWYaec+Vk7/3yOM/2dpLyQedg8czaJksiPShtsuJlRD77Aw4H9rr392yG2mLTgt09+uwu/NiMRQHSjS/Jj/CLS1BokW8xkS5fVVk6iy0WxXnNka5t0MKl/oO90pomdQcrx8wg3LxXg3FhQo5HqxM4rk/Nc1r3hyCjoVpCkFBYzGjsXAaUnO7os8BuW96JxvCxF8bApM5pe/BZfEAmRUP2c2R6DPSotgbtJ9bSKd5xcZE89Hd/AaAyYHeoClDDENw/vv7amh66gyEoBoU7ENTElEh1y1QGtm4meXe6JK5yr13gzyNAuSQW9XCqTDkOD49J53dzhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:17 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:19:56 -0400
Subject: [PATCH 03/16] ARM: dts: imx6: align rtc chip node name to 'rtc'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-3-1e883d72e790@nxp.com>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=8448;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NJW4VKU9u/7kD1dIJVA+tuoADwHxBQjLmSGbVxODzCw=;
 b=VtfCGT7DwH3mvEdDRlmG7THkGVILrwl2X/Ykusr/bS32gt5NuWw4UvVVB2FxfQZSoxCdDlv0W
 b8u8QDx2pTIAjvvqoYIgHgLTAlflcHfW7d1WSI8NdgqDcQ5LnhXXqeF
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 331188b3-a82c-499b-3c58-08ddeb274c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1gydFpRT2hHRzRZcFFmRmErSDJVRThGMktLUGNRY200dWFJdGsrcytJRnhn?=
 =?utf-8?B?UjV0aXVOVzdDOWV0K3ZaK3oydXMyUE1Cb1VXQWZKMTl4NTdzb0NnR25ISi8x?=
 =?utf-8?B?NFJ6MHRNWU9CTzFCQm1VSWtNZFgyQ0VtUnhwTm4zTVp3V0V3dnpOTERiVFov?=
 =?utf-8?B?czFwc25nMXFSZHh5dElBQ3prVG9XSjJiSU4xbi9jdzBnOWZKTS92RUJKZkJJ?=
 =?utf-8?B?d1Jkc1FNV0tBMXk3UHU5ZjZxeXFQalhsaGRIVEh2RFhLOGV4QXZkSUlYRGdj?=
 =?utf-8?B?N3BHOE1Mc1BkWTIrN0JYai9vbFNJUTQ2Z0prVW1NZWttbENoVnpFRXRpdlNw?=
 =?utf-8?B?bXdEMmY2ZlJTUW92VStCVFhrQVNIaFNwOVBWeWxKd3psdEpiQmlyelB2SzMx?=
 =?utf-8?B?QXFWZWhrbHBrMyt3a3NGSXlBNEhUN1d3OVpwOGEzcTlMMUhVTDdMNStSWXBJ?=
 =?utf-8?B?SWcraFRTZTBPM2x6ZktZL0hlbW5ja21GZE40bGRYQk9WMzZleWRYcnZWMU4z?=
 =?utf-8?B?T2I2ZmNFcmlDQkg2UFgzYlUxUzEzOTdPMEV0Q29mYk1HeG9Hc1dYUHNjMUtM?=
 =?utf-8?B?aEs5clhZN1RCTHlFUHhmekxUWXc4NC84VS9xcnNCUjdxeU43ZjBtSnNNSjEw?=
 =?utf-8?B?cU5KK1RCUktzQTFKa2J5R0J0RnJFL3lIZ1JVZkVCWERhdjVLejRlVnEvV041?=
 =?utf-8?B?ZFQ1YlZiVnRHMmJXZ3VOd0NRcEZEZnJ5empXM2E5WFVvcDdYVzdIR01KQWhs?=
 =?utf-8?B?QlhncGkvN3dPUHdTNDlzT3A0N0JnaW9xQnN1UkxNazNsSEpQUTVUbUo2RWNn?=
 =?utf-8?B?bW5JRXBuckdFYkVRRFY2UVZYdGpJcCtUM2hhZHhramZGd1JzN2RHSzRhVHIw?=
 =?utf-8?B?QWsxVWV6UWJjUko0VFFYOGQyalljUzBBSWUrb1hNTUZML0hHSVNCTXBWNHRN?=
 =?utf-8?B?N3dFMGE2QU9FcDBHUGFDZ3NaTlgraDE5VzJuTTdIUk55S0xuUG9IUjNBQWtY?=
 =?utf-8?B?MXdycWF5MUVhalRHSmx4YkFZTFVQS1hNc0lCanB2ZWM2TllReU5GeUFLQXpF?=
 =?utf-8?B?b3NRZU9TWVJaMEU4TW5QejJBbHBwWEtVRkc5YXRQbmlVWkhFWjU2Z3kzZGha?=
 =?utf-8?B?RUxDZDVrSnNXZ2E4dGhsMC9LVnptS0xzWmx6Z2JIb3NzWTh1OTJodEFqamNh?=
 =?utf-8?B?ZkxzZHNRK1ZaejZuVnVrdEZjZ1BQa0VhNHBocXVuam1sc3kvQjQvclR2cXVY?=
 =?utf-8?B?UWNKYm9nQUlCNm1lQU9RTUVtZmpXL1N1WVdzVVdCVm1EY3hTRmxsR2t2L0dl?=
 =?utf-8?B?akZTU1BoSDE2NjU4SGVudnV3L1JtSmszdGdmc2JDQkh1T1VzSFVqM3N1MEE2?=
 =?utf-8?B?aW9xUlNQWktrR1k5em5zL2ZMQ21jc2JkdG5xeWtyQ2YzMU51aWlxV1pUVTJ6?=
 =?utf-8?B?NzBXUnBTS0RIWUovajVDUk9Rck5XQ0JtK3Z2TmFadnZCa0YwdEZCMitxVXg5?=
 =?utf-8?B?dXZyU1E0WEJNOUFFeVhOdk90bSswL1BQNDJvaFQwVkQ1TXpadW9xWjNGOE4z?=
 =?utf-8?B?MGp3Zm5aWkV2NXhBVUZWOUx4bnZrbVJEck13SStuMldaNjZ0Q1VJZlFHV2Rv?=
 =?utf-8?B?TS9nYlpxWGlacmhwWFA5S05BbjhJaENwNE9EL2JxTEZWN25mZ0VUd3lrWTJL?=
 =?utf-8?B?dTZhUGVKUE9rVlZNRjgyMjYxYmprQ1U3U0s3NzZmWm8vYXNIaTg1Wi93Q3Jo?=
 =?utf-8?B?ajkzc0FGMkhnY2drVTI2VmpqeUpnd0NPdDQrWjJhWWtRV3FEenk3WmJ1dmdr?=
 =?utf-8?B?aW9FQ3o1VDdkRVVMMzY2Z2YwdEY5ZHBZaEs0WFU2a1YxV0t0MTYvQkJnL1o4?=
 =?utf-8?B?VUhJcUY5VForM05kYUtpT2YrYVNVNzdsRGVrbXFHY0xJMzdBN0FqejNRTkJD?=
 =?utf-8?B?U05OVWxPVFdsSng0NjdQcVpkc21aZzlzUmRQeHp0OVJPZWVBM2c5SWNjL2ho?=
 =?utf-8?B?RXdtMWtGSFN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2lmcEkra0VtNU9zSzVSOGEySHZmT2tIRW5FMERobzZWb2NoMXlXcUprcUEr?=
 =?utf-8?B?NjRzV2trK3RDNlhxcXo3RUh0STFsRmhScFdkTXlNeFNqWUFQRFFuanVRbGtK?=
 =?utf-8?B?Mk5jcG0wWnlHVkVaOVY2WFAxaWJmNzBDREx4TUljWklVT2ZYOXhkbXp1T2pV?=
 =?utf-8?B?NjlrOHdFVGNjQlVrc3dNcTcxKzhYMW9KeWEvNGZ2K1Zzc0k2NlhyYkNFVmFv?=
 =?utf-8?B?dWd4VERYU3Jqa3c5NFVJL0NaTllzV0N4cDJJaXhGbDl1LzJWYXJiamFmZFZJ?=
 =?utf-8?B?R1VmUzMrbWFrVUcxNnhOcGRhUnM5NTloTmFDYTllMkpSOXJYRW9KWWRGaVlw?=
 =?utf-8?B?dktVT1daS2oyb0hLZ29UNVIvUCt5RjBicEtJUWpyK3NTS0dLU3M0YmlJb2E4?=
 =?utf-8?B?UVZHdlQyZ0VpUHZiajlqSUxCazlhTWRyM1VIUE92TVNhSFRERUlqVEhIMnUz?=
 =?utf-8?B?QVdVL0I4NmZtOXNKZytLaGdlTVNmVzBueERNREhCNklQdlZhVTNjWkRFcEFU?=
 =?utf-8?B?T2lWWjY3bHNHT0lwbFpMOVRlZTJIQzFoN1NmcE5laExsUmpQZ1ZobitnUlVy?=
 =?utf-8?B?cExCS1poMnpRNUFXNUhHa013cTk4SE9VT2JNS0VzalFOaVQ0b1dVdE1remJS?=
 =?utf-8?B?NnF2ZXZNR04yUmFPckdacXBHVmdEZTUzQnYxMFJ3WHRXa2tySWxqejl4MklX?=
 =?utf-8?B?djlkNDh1aXZMRVRpWUJhckYzNTVpNjFwV3JCc09tSXYwTi9vRWlhcE5MWXdj?=
 =?utf-8?B?S2k1RXl0UVQ0ZVlsbk5oTncwMm5aWFBySkdhdllzbXRlNVhRcVNManNwelFY?=
 =?utf-8?B?cTRDQzI4R2hwai9tU0VyOGtPV2o4UmJMQkMyT1UvNDlCWjhpMjJJenJWbU9F?=
 =?utf-8?B?T0ZvNy91TFpIOUZZdE9LMUt5MXFZWlNpZWpPYktsNXBNamlZOFFxd0dzOXZH?=
 =?utf-8?B?S2l4cDRqY1pCQ01OYk1Ja0ZwQ3dLL3pKZVBaVkhkNGNJWUIraEhoVmtZVVAr?=
 =?utf-8?B?aE5NWThrMWFnSDhPSDIvSXhYdHhhV3pRajdkeVJXWHNCaHBCSFRBenkzRjR1?=
 =?utf-8?B?Q1ZwOEJTNmJ0eWtHa0hTMVArOWQ0NERUNFhTZC9uNlVRQzk3UXBXSEh4bnV4?=
 =?utf-8?B?eWNmb1J3VjRGa2Y3Qm1FWDR6UG44bFE0VXA3M3lkRlZoU1pydElQU2FZMTFU?=
 =?utf-8?B?ZXh0cjFJWjhQaFdrOFJ1MUNnaWN4ckZtQzBnM2cyN1I1ZVUxNTNJTTZQRnF2?=
 =?utf-8?B?Rkt5WnJSUVd0dlgxZVV6MmJCcmh5cUVpVmo2bVlrU09mL2hQUkpOeHBxTXls?=
 =?utf-8?B?ZWhMSjJYUVgzRGo0V2tyOVE4bk43QTd6Y1BaNkV2VTdMQjBOK3NKWkhXamFy?=
 =?utf-8?B?dXFlb2hxczloTEJQQ2RLTTRuQldSQlkzL2lvdFB2U1BTQTRUZDBmTzdLTUFP?=
 =?utf-8?B?WVI5anBRSDlrOGUzaVZybU9yUnNHUFo1aGJwejhRMHNhS3dmK21qT0o5L0V5?=
 =?utf-8?B?ZW45cXFHT3FMVmpCZS84aTVnUk4vTThGb3Rld0oyUVY1SzhCeGZsa2NOdEpE?=
 =?utf-8?B?OXVHWFo3amxLOXN1cXZoVTJYQUFvblpkMlVBaDVPM01QZGVGTnpRT0lFSTBI?=
 =?utf-8?B?anRFMnRQRG9qc1l2UkY1UjBaMHFEWHg3L1pkSmszZENQNUNsOVZYQzFaeDZU?=
 =?utf-8?B?M2FpSTdHalFxTVQycGxRZHpOYjdjZTBKQ0M1VHBzMktXRW9PaHlrdXRaSy9V?=
 =?utf-8?B?MndDWE5kckpiNzM2bVd2ZDVmMmlVdCthckNyM0VaRkNtMk9FYU5qOG94UDBN?=
 =?utf-8?B?OHNYYXhBcVZPMG9aNEZCT1RhWmxHYlpxZkI3b2FFang0bHR2citVaDFPdEhi?=
 =?utf-8?B?WjJDVHYvSTgvTXdUdEdXNitvY3JnQzArRE50MzUzek9GUXR0TGs0Sjl5SFNH?=
 =?utf-8?B?UTR1WUxXZitpbXhTVWV2dXZ3TXVLYmJjdHN5bzY5TnhVQXVwY21IT0Nob0lY?=
 =?utf-8?B?dlRsZmtvSGxLOHJjcnlkbTNFWHFabVBSMk53dEhaM3hvNElMaUVvM3lSTVZ1?=
 =?utf-8?B?K0p1enBmNnlmcXp5Vi93MGxzMm0yYjhhZklubm9qTnl0c0xEZW85RHZhTkh1?=
 =?utf-8?Q?jY6u/+UNRUXIBDJr4XEAcZMQD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331188b3-a82c-499b-3c58-08ddeb274c16
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:17.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJySUuvbARMrXIt/rTV+ZsISdOdGY1sHkI0aXisGfbnq9iSiMhkMTiSGbMXB+SNc3RgOLmojXnht/dyvxIagNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

Rename node name ds1672 to rtc to fix below CHECK_DTB warning:
  arch/arm/boot/dts/nxp/imx/imx6dl-gw51xx.dtb: ds1672@68 (dallas,ds1672): $nodename:0: 'ds1672@68' does not match '^rtc(@.*|-([0-9]|[1-9][0-9]+))?$

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx35-eukrea-cpuimx35.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx51-eukrea-cpuimx51.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi           | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts      | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-gw5400-a.dts         | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-h100.dts             | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-novena.dts           | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi        | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi        | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi        | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi        | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi        | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi        | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi        | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi        | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot/dts/nxp/imx/imx35-eukrea-cpuimx35.dtsi
index ef546525e2ec8af8375a74d666d443df08760a45..0064b5452b549c7765e57bde9aeed650b7cae4d4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx35-eukrea-cpuimx35.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx35-eukrea-cpuimx35.dtsi
@@ -26,7 +26,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx51-eukrea-cpuimx51.dtsi b/arch/arm/boot/dts/nxp/imx/imx51-eukrea-cpuimx51.dtsi
index 0a150c91d30f7ebdb8c31c0fa46e1a241fbdbf6f..244740d65b3dd13013db47e7817ec34b952f8311 100644
--- a/arch/arm/boot/dts/nxp/imx/imx51-eukrea-cpuimx51.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx51-eukrea-cpuimx51.dtsi
@@ -26,7 +26,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
index de80ca141bcab87a9344c389b94c8a181b1b4ed3..7a3b96315eaf55328cae2329357305b70c99fe6b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
@@ -157,7 +157,7 @@ &i2c3 {
 	sda-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
-	rtc: m41t62@68 {
+	rtc: rtc@68 {
 		compatible = "st,m41t62";
 		reg = <0x68>;
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
index c5525b2c1dbd594ba79c6c95e9dfc6b64a87670d..17fabff80e903f621814492a8f8b837c5721adbe 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
@@ -266,7 +266,7 @@ temp2: ad7414@4d {
 		reg = <0x4d>;
 	};
 
-	rtc: m41t62@68 {
+	rtc: rtc@68 {
 		compatible = "st,m41t62";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-gw5400-a.dts b/arch/arm/boot/dts/nxp/imx/imx6q-gw5400-a.dts
index c5c144879fa6090deb732da1252016c9b6aaf624..bf8fde9cb38d9c8cf6bcabac2ee753e0dd4f138b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-gw5400-a.dts
@@ -184,7 +184,7 @@ gpio: pca9555@23 {
 		#gpio-cells = <2>;
 	};
 
-	rtc: ds1672@68 {
+	rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-h100.dts b/arch/arm/boot/dts/nxp/imx/imx6q-h100.dts
index 46e011a363e8827e84008dead0390a5e9548ffd0..4c8ea43815597490950581513474d3b5b1dcd581 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-h100.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-h100.dts
@@ -171,7 +171,7 @@ eeprom: eeprom@51 {
 		reg = <0x51>;
 	};
 
-	rtc: pcf8523@68 {
+	rtc: rtc@68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts b/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts
index 8c3a9ea8d5b34aa395b3e8a5f34896a91eff7749..4d25090db55f956972c7535e7309fd4ca17ddb7b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-novena.dts
@@ -265,7 +265,7 @@ accel: mma8452@1c {
 		reg = <0x1c>;
 	};
 
-	rtc: pcf8523@68 {
+	rtc: rtc@68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi
index d92d26e40a1cf1c29b6fa9a630858b87ebd15a12..beff5a0f58ab48d4d7b8f14f9e695763dc2e3bdf 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi
@@ -271,7 +271,7 @@ eeprom4: eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc: ds1672@68 {
+	rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
index c1d124ad1d66139c62c52bffd9b22f81e3e3792f..9d3ba40832169bedda3591de02e09ad469275ea2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
@@ -351,7 +351,7 @@ eeprom4: eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc: ds1672@68 {
+	rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
index 63e604537b06e6af5596298f930dd1e73afee952..7e84e0a52ef34c296406625019d45e4ae21f902e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
@@ -350,7 +350,7 @@ eeprom4: eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc: ds1672@68 {
+	rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
index 66a7b3e03fa1214f4ee56b16835b342328867b3c..81394d47dd687f052df0ea1154a45172f3f837d4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
@@ -376,7 +376,7 @@ eeprom4: eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc: ds1672@68 {
+	rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi
index 07cb36e65df7c99b7e3a2f650f354f6e31fce3aa..6136a95b9259977bd2debb05e2a480cd1e2fb765 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi
@@ -288,7 +288,7 @@ eeprom4: eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc: ds1672@68 {
+	rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi
index f152ebbd203dfa1aa3caf793c6c485026ab58bdf..9c822ca2313092e7919b8b7a4c10d59b71697dee 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi
@@ -261,7 +261,7 @@ eeprom4: eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc: ds1672@68 {
+	rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
index aef920c192b564d5ad4f7a99d128c786e2fd886e..552114a69f5b9575a3685fcbbae11a7fc2673e45 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
@@ -257,7 +257,7 @@ eeprom4: eeprom@53 {
 		pagesize = <16>;
 	};
 
-	rtc: ds1672@68 {
+	rtc: rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi
index b73a170940a0126ebef98343028994be3ba50bd7..87fdc9e2a727c2c1b300f7860de40d0e4101b7eb 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi
@@ -271,7 +271,7 @@ eeprom@53 {
 		pagesize = <16>;
 	};
 
-	ds1672@68 {
+	rtc@68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
 	};

-- 
2.34.1


