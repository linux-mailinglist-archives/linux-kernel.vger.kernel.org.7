Return-Path: <linux-kernel+bounces-751948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD5B16FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7424418C4D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790C329CB58;
	Thu, 31 Jul 2025 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZcuuVPsA"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2260C1FC7CB;
	Thu, 31 Jul 2025 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958819; cv=fail; b=ROqPMeHTNQ709UGzJEpiNcgUo7KfsGLjCcACD1vspmrbOejMLajJVhx+zcYXEyYIFP+hD/GK9GYN4SnzLloe3TMICKr/7baTvLpGujkmlJXoRfrO0ZBPYROq0KGKHC9OMYanuizQUvvO6lJYE7EdMf+gHms2kdOgux+/WuSKjLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958819; c=relaxed/simple;
	bh=MrBcYxwpjVwjVkFui/AwsXM8IhOwACd4lCb0170Nw9g=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=OcQfpy9pShQes1w3pbawV64QeouOyJ7pyFWwMbPH9EVtETHp+bjkiittBrCLA1LgtadgYucADPx3aEJSGHnYWSJuQNqdfAHc3BcvBrw1O6ro+sUPp+sQODOdQmjvMYWvKv+W0nBgtKhakKZMIifov+9991KLVmMYQ/NWSqUzW/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZcuuVPsA; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aX84I3oo/Ok2z+hcLRak5QTtULsSczPJiFqD107vJUvMVJKmekx7igJe7DVxaleOALlM88FT35PFLVrIoZcP/PCJs1x2pDDUEHtuOj3VYvjfYfTNvPeAalQOkMp4/QDZb6Yh0k0lquZ+HNnbQuVRr7/I5QeUbCSywwOSFKW8PBWGBCyDv4t44JlfjqTWlbPXxIUUEbixLWxxovHYm3gqShSBJjc3Tibxjyx47Yxwzd3x0cglkfUgH4LH7Gld7VFVfi3N9K1zFVfWByBwwspQQg8X7qDmNkCIaAokYNRbHewjH3RmseRQQCbqz7brsJRVCXTguOa+EXoNMLnxEejNKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E375+U65oxzzZ/qiL96Lp0kP4ozDVwV+DrfNyuo+eBg=;
 b=OXUYciMrvmhib4KEMxGepT+bLxY2SSHgDR95VCG9wYqeEBThz7hZgvC+8zcT/Lnp4V8Lxkz0RrLBcHBjlDDTG4eYMGkn9CMBEZhDs/ZTjTAes1exTX0LEKuX1E3sjmQEc+iGbViw4dUyPr8j4P7gjlZ8+LYJD1EH4m9Z5SWNjzvW+Y/NslzWHSemceXFWb07aOFg5oll+WGMYCpK241K5jZg38/kwhQgUqI4OWjM0eBXgw7aJerfKcMwrUrhXD+z0Hg3lBW8nPHpngBkiOAiLcmdQMXkLK6oc/ubDvcIeaNExVAgooqiPpLcBY7fPkJthWOFp0558W7eeH4WsdXvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E375+U65oxzzZ/qiL96Lp0kP4ozDVwV+DrfNyuo+eBg=;
 b=ZcuuVPsAbZedICtMVd5Fs/vNvfmLMA9XCPEo9bcFO1/m9VOyI8bVRfq08bJgXXQ2NU7FxqrKxIxXHMSAhIXWzn5tQyiUDwXkXLtGEqzfPwmBa0M2iFKUFttYvAwXCu+J+eZzp8y25I4aQ7sn7cOr4rla7V+Xt5Ei/YuWUGGJZpjI5/+PLcHbrfYH+RIXQuw7rIvoiTfU06s5GK2lN3Lj4192k2JAu5jzRx+ue8ellbyOSNvSh5Ml4de7MNKLTuNzmYafkE/lNwZ0LtCY3AucJZMGMR2Vwm4/hiGAjCCL8lt8+h2xUmpYQ4V9rreeq0rw+7pkpTtl+2dkye25Z4Z0Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 10:46:53 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 10:46:53 +0000
From: Joy Zou <joy.zou@nxp.com>
Subject: [PATCH v3 0/2] regulator: add new PMIC PF0900 support
Date: Thu, 31 Jul 2025 18:44:40 +0800
Message-Id: <20250731-b4-pf09-v2-v3-0-4c2659516582@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABhJi2gC/43PwW7DIAwG4FepOJcJ2+CQnvYe0w4EzJrD0iiZo
 k5V3n200rpWdFKPBn2//Z/ULFMvs9ptTmqSpZ/7w1AG2m5U3IfhQ3SfyqzQoDMNWN1ZPWbT6gV
 1CzGJcAJsUBUwTpL74yXs7b3M+37+Okzfl+wFzq+/Me42ZgFtNAo7yc5xm9PrcBxf4uFTnUMW/
 B9igZQzs2UGQrzC7fVgX4EmBWMRUvlNT4HWEhiApvPO1wChAoLRsXfWG8L7LnTb5X4TFdghxRY
 Di8v5wSasgLMuBM7YotADQBWwAXxnLQOG/BToGuGYgqNIXQ3IVIAyW/EeUjnsr/y6rj+JyISNa
 wIAAA==
X-Change-ID: 20250714-b4-pf09-v2-91cdee6d1272
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGBP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::29)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ff157a-9b5d-43bf-12eb-08ddd01f8fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2o2TWhwc0dPZnc3SUpvQzNtMTZSTVJtempiRjE3Nnd4S3duTGxDZ01ndzhI?=
 =?utf-8?B?cGtuK3JwZmd2Nnk1TGlYVTd0azhScGxIaVVucE5OQy8zaGRJNEJ1UlFmc3Zy?=
 =?utf-8?B?ZExieHhlOVdXbWN3MzduRWJHb01mWi9RclhycmlLdFY4ZWgvVlAvaXg3bXRw?=
 =?utf-8?B?cEt3UUVhNVhaN1ljaCtoV0pyWjlITHdjWlRSVHEzN3BLVDk2MzB6eXh2aGhK?=
 =?utf-8?B?VWxVaVl0cjJ6aVFCeWsydnhZNEVHZjMyVS9iYnUyTGgrYjZFcFR6M21rL1Va?=
 =?utf-8?B?TStoZFB4blZjUWMxQzJQOTRsNjY5MjBYdFB2Uk9RSm9DSXlHZHMwbDVnb0RK?=
 =?utf-8?B?Mi9jSXNJVzNNRVZqbTFiZXJhb2JPUVM1M2pMY040YUtvd3hNZDRmRVYzbjIy?=
 =?utf-8?B?NVp5ZVFFc1pvNXZQV3pnbDRSTjFaL1R6U3VPSTZOSTF4c2ZCK3c5aEZlR1Jj?=
 =?utf-8?B?dU1PN2NEQktPdU5KNzVSdkU1MUVkVTlGeHY0T3d0bUx2UXRpQzZnTEtramww?=
 =?utf-8?B?eWE4anNmVDVtbStuR2ZNbHJTM0x2enAyTk5ydWxWNyt3bnN4ZGpMaHRWR2VK?=
 =?utf-8?B?SFZqaFpaOGFzc244cmJCb3JhQTQ0Mm43d1YvbVRIbURuUjVsWlBCMEhtaEQ3?=
 =?utf-8?B?L0x0c2U5SlZNRVQzbG53OC9BRGRiSW1VL2ZLVjl5NjBNL1VZeWtXaTVnMXZi?=
 =?utf-8?B?NU5qN2cvWU9Pc2NiU3VaMUY4cXUrUHJlUXEzRm53S0pxK1VyN2toSlB5UGtq?=
 =?utf-8?B?cVJWMzdyTEFxR2pnSlVuSG1lQm95WVcwdGJOSENEMVpqRjlnYS85YVE1R1R2?=
 =?utf-8?B?YVFJZjllVFp5dHRvZEE1TXlxSUYrVUdTeGZIU3lyNmltZDhHRWM2M0gvRHZ1?=
 =?utf-8?B?cFRtNzFPSi9pRWprMFRHYzZ4N2QzbE1mK2NiaWpwR2s0TjVoRHg4VHZOTk4x?=
 =?utf-8?B?ZmJmMFBkS05ENEk0N0JGelJEOGcrK1hhVnFzRkMvMmhsU2E3MVJQNnpOV0Fy?=
 =?utf-8?B?ZzlzWmY3aHlMTnA2Q3NjZ3lFSkRIRzdZNUFGY0Q1M015TytEUHhxdWN3VjVp?=
 =?utf-8?B?YU9sVXlmUTRuc3QxV09oZUNkMFVLTXd2d3UweElwRWk3Z04vQTRVcGcyeXFN?=
 =?utf-8?B?VVNDTFh1MmhsaFRtR0NZK2Q5M2UycndHbGsyN0VEUm84aCtIcUFWa1pDdlBD?=
 =?utf-8?B?eWNabkNlQXJ3a3drd1lVeHpiTXNxVG02alRzQkI2OEszWThNYlgyT0VVaVIw?=
 =?utf-8?B?NnZCUGRueEZ3YU1zRGhsbmdlK1Y3RWFQYXprVEVQZUVqV09zOXlKc2FjSEVF?=
 =?utf-8?B?ZnhKNW5zZUFzSnJTSjhXbm1KblpZdUZHUDRncDA4UlJyaVBIRk00SktpSnk2?=
 =?utf-8?B?anBkQ29aYWNYT1NBbDJXWDBGRTZBbVFvREVOT21jUkZ1eEJPbkdULzNPRStW?=
 =?utf-8?B?YldSMGUxSDBQOVNyUUxka3JrR3IvdUFZOVpEaVNkMWx4L1ZXWXFzZU9DaEEz?=
 =?utf-8?B?QVhQM2MzVUtDSnN4ZFgxb3lIVlM1M2RpNnYzN29YSDlIUHQ5eVhiOXA1amhG?=
 =?utf-8?B?ejlQRmlvVGU4WW4rWVRxcm1ZYUdWaTE5NXhCTnpKeEdSdWJzRTVHeXR0Mnox?=
 =?utf-8?B?eFZ3enp2SGNXT1FuVmpEUExJRW4rYzl6bHQ5OWV3SzVKZ1luYklFZU5qR0pY?=
 =?utf-8?B?ZTZYaDQ0cWtyV3RzMGcwd0dna0wrdmtqTEh3YmhBVDA0NGY4cFVEdG05SEdI?=
 =?utf-8?B?V2UvckppUWtsV2xKbEZRb3JoRmNWSkFiYzVWTjNvN2VlZmc2MEJpak9kK1VX?=
 =?utf-8?B?bmp2ekYwMUQ3T2tScFR4RUZDc0V1NE1QL0F3Zk9PaGNCbU5VU0JKWm9kbTVq?=
 =?utf-8?B?Wi83TTRBLzc0Zm9aUDhiaGpMUm9MOXphK3krcGhBOW54RlVHU3NOVSt4aVkz?=
 =?utf-8?B?bk9vSWdYUnBVbGMwTHU4elJkVTg3OWtGUnY1c3E5alpDMFl2Mmt6cHFoeGxU?=
 =?utf-8?Q?qqWLl6+KKa0yzl4qEGPse5IqZmrvm8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3F5SGRKU2Z1M1g0VExLWStmek4veUh6YTUzdWtPMVlzelpyR01mYXF1L0lI?=
 =?utf-8?B?R3JISzFIUGtpM0pGTy96R3I3RGhmcnV6VVJSTHBjVklWcGtGb1ZncDdzaWVK?=
 =?utf-8?B?VWxHS1pGL2ZmNFFZWlljeUhkazdoRFlrM3pINDZKckZCczdMa084cEQ2bHFO?=
 =?utf-8?B?eGxvcDhVYUVSOExjbTBxaVgwdlQ1SmgxRGtyRHlzS3FERmxlM01tSE9RVC9X?=
 =?utf-8?B?R0srNzF1cTE0bHQrS1ZYeXA5OU8rdGpqNVZ6OUllVUhRZUk2STc0OEdzYXE5?=
 =?utf-8?B?RHM3UVU0WTJMZ3lUWEM2R2JGM1FIZU5PekVUR1k3UFp6WTBCdnVvanpVZmRk?=
 =?utf-8?B?Vll3YmVZSWpYbVp4MkJuUG51N3l5UGp5Y0ZwQ0RwdFpwQnFwWlNxQU9zUTNh?=
 =?utf-8?B?ZTdmR01idDdWSHc2R1RCN0R2NkdDUHo3N1hXdWFISkpLSUFkQVJnNHA1dVBP?=
 =?utf-8?B?SjZLdkMybnVwMWYrbmlkMHdLZmVXbkxTNXg4MkFpbkpqU0ZLMmNaQlpvYmR1?=
 =?utf-8?B?VnZWeVR4ajV2WHRyK1RCWDZ4VjBEOVpXY3Y2VGI2dnlqSE9jRU0zbmpEOVN1?=
 =?utf-8?B?TVdhM1RXRk4rd09VZDh5ejNZUjdFUlBDOGttcmVwOW8vWmw1V0NHcHVNNGRN?=
 =?utf-8?B?Y1c4Q0JBT1F5TUVEVG4vMVZJWU9XdCtPTzNoVmtBRXlaekN5V1dIZVFwVkc1?=
 =?utf-8?B?Und5bUdLQVJseWEvOEMyaDlQTnB4WU13RGxSNjRxTmhhN2tGK25vdTErZW5H?=
 =?utf-8?B?YXNpdHRFTm9pUWR4SVJLT2h4a2xiNVRRWVZnMjJneEhzejAyVzdvUTcrWkR2?=
 =?utf-8?B?TzJFOWd2NG5obno0ckRYWElBNnpLQ0tkdEZkc0tmWFQ3bnJqTUtsYTVQeXUv?=
 =?utf-8?B?ZnlnMis5NHV1ZVhKMmQ4VVBWdTdobEVOak1qWVRYQnprbFV0WU5JemNiSjVB?=
 =?utf-8?B?UE9nVitEck5OZHJ2Y2JkbUlEcW9oS1Y3cDJseUQvR1dLRXpvWXpJSUlidk92?=
 =?utf-8?B?NStDSElyVmNkeU1GQi9pOEdsTklxeFJwOUNnVGFqTU8xcHlnSXFsVVFFYVRm?=
 =?utf-8?B?MjRLbGtSS2hlYkxVSVpzbTFwVUE3ODRLR0tJRkYvL3NtNm03RzRLazNyWFRV?=
 =?utf-8?B?SDJsM3FDNEJZVllLTWlnemRCdTFnaUtWditRZ0xZMi9OR01nY0pIckU1eVRu?=
 =?utf-8?B?OURUcDhHZEZEY3gxa1loR3JsLzA2anNLS3JHa0FlbFQ3TXhlWmRFY0ExeG05?=
 =?utf-8?B?RURIazdTeFZKVEQ5b0FtQ1VvQzBwYUU2KzdGT1ZJTC9jUVFsek1aMzVFbDlF?=
 =?utf-8?B?UnRPN2NYS1VoNm0vb3EwZG16QUxNcFJBdWpKbVI4SDVwNzdXTi92RUhVRjBT?=
 =?utf-8?B?NzJhWjJKOWJUdEpuZ2lhNkcrcjZncTJSQm1ZaEdiclpuVTNIS3IxdStPY01L?=
 =?utf-8?B?MnNWcms3Tmcwa1lFQ2lKT0FNdTZxOWNWRGhTZllZY2FrNVgwNmRvcFhvUHIx?=
 =?utf-8?B?cy9vNFd0SXgyeVFTMWo0UCtWVndGLytYMnpQbVdjakc2Wk9LZTBEcVhrNkJN?=
 =?utf-8?B?NlkvQ2Z3cnM1V1RGUnhMMGsxUVEzUVNCeGgyeTRmQ08rSHptRURrdUZuZnRw?=
 =?utf-8?B?U0ZhQUMweXNzUEZqemxpSFNUMll2K2NDL1FadktQNExIZThrczJoY1ZZK29R?=
 =?utf-8?B?VFVoZ0RnTG56YnFoTHJYazFhdkRzYkllZXVoOVd5SDd3OWNMUzlHaXdJdFVm?=
 =?utf-8?B?RVA3SFBjVkREQUxxYVhaUFZUU2V6OFo2UUJBWUgxUUxwRzRDd2hOTTRXaTl0?=
 =?utf-8?B?aUlRd1lxWHJ0T2dCVUVCUEVKVEl6Q01qd2J2Vy9EWFNHSzdrclhuK2pMbk84?=
 =?utf-8?B?Um1ZS1pNUDFvRmR4YVdNYWcrZlZSTytiNTNqb3c4WWxXL3RuaWZMeWNBQ1Jm?=
 =?utf-8?B?VkJ5ZXpCOWZNYVNFNXUvTW1JdWtndDFFMkFlT2tWbXExUVE0dHRBdkN1cUYx?=
 =?utf-8?B?ekdrQWNjRTRkTDU5MnBrb3V5N09ZVU9NVnpBd3RydWpOTlVCaHJpK2pxdFpz?=
 =?utf-8?B?ZDJhZ2tXRlFiMGdaSDJtMFZBaFBvc3JVT0tFcjJWRTZXV2l1a0xrWjlST0NR?=
 =?utf-8?Q?GGgqh/Li2Ixm5XSaCLcReU5E9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ff157a-9b5d-43bf-12eb-08ddd01f8fbf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 10:46:53.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLeDDOsrbNj1qyo8QswvxFV3PziHNykS1gIPcIU1kaB3ONymZtIkhWvlJJflHns6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238

Add binding document and driver.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v3:

binding part
- change regulator node names into lowercase.
- add more description for nxp,i2c-crc-enable.
- remove the unnecessary nxp,dvs-run/standby-voltage property.
  These changes come from review comments:
  https://lore.kernel.org/imx/e9f38e38-7df7-4d19-b5c0-2f18aeebcc78@kernel.org/
- add regulator-state-mem property for example.

driver part
- convert to use maple tree register cache.
- change of_match_ptr() name to lowercase since dt-binding changed.
- add more nxp,i2c-crc-enable description for commit message.
- remove the of_parse_cb and dvs from pf0900_regulators since the
  unnecessary property nxp,dvs-run/standby-voltage removed.
- add set_suspend_enable/disable/voltage for the SW regulator_ops.
  the run/standby voltage can be adjusted via the API which regulator
  driver provides is recommended.
  These changes come from binding review comments:
  https://lore.kernel.org/imx/e9f38e38-7df7-4d19-b5c0-2f18aeebcc78@kernel.org/
- add bitfield.h header due to build issue.
- correct the sw4 id.
- add PF0900 prefix for short macro define in order to avoid duplication.
- merge the same mask define in order to simplify code.
- Link to v2: https://lore.kernel.org/r/20250721-b4-pf09-v2-v2-0-e2c568548032@nxp.com

Changes in v2:

binding part
- modify the binding file name to match compatible string.
- add one space for dt_binding_check warning.
- remove unnecessary quotes from "VAON".
- remove the unnecessary empty line.
- move unevaluatedProperties after the $ref.
- move additionalProperties after regulator type.
- remove unnecessary regulator description

driver part
- modify the copyright comment block to C++ style.
- add reg_read/write for regmap_bus.
- remove original pf0900_pmic_read/write.
- remove many regulator operations.
- use regmap_read replace pf0900_pmic_read.
- use regmap_update_bits and regmap_write_bits replace pf0900_pmic_write.
- move the code from pf0900.h to pf0900-regulator.c and delete the header file.
- remove unmask status interrupts and add unmask regulator interrupts.
- remove many interrupts check warning print from irq_handler.
- add notifier for regulator event.
- remove unused macro define.
- add PF0900 prefix for IRQ macro define in order to avoid duplication.
- use GENMASK() and BIT() to replace mask marco define
- remove redundant enum pf0900_chip_type.
- remove redundant print info and comments.
- add dvs property present check because this property is optional.
- remove ret == -EINVAL check from sw_set_dvs() function.
- Link to v1: https://lore.kernel.org/imx/20250617102025.3455544-1-joy.zou@nxp.com/

---
Joy Zou (2):
      dt-bindings: regulator: add PF0900 regulator yaml
      regulator: pf0900: Add PMIC PF0900 support

 .../devicetree/bindings/regulator/nxp,pf0900.yaml  | 163 ++++
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf0900-regulator.c               | 975 +++++++++++++++++++++
 4 files changed, 1147 insertions(+)
---
base-commit: 84b92a499e7eca54ba1df6f6c6e01766025943f1
change-id: 20250714-b4-pf09-v2-91cdee6d1272

Best regards,
-- 
Joy Zou <joy.zou@nxp.com>


