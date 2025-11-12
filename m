Return-Path: <linux-kernel+bounces-896589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EF4C50BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FB524E64D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F92E1C63;
	Wed, 12 Nov 2025 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VZzlxJ3r"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82E2E0914
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929377; cv=fail; b=r/9CJpb4IOCvAPLYS6oWRA3pMhh6UxR+4yH50NybMfnnahqXDU29FQ2gG2Tiwbun/bcRp+05qNN2Pe978Iy6/sx9/sPIQVzRllFonbH1itffz25UlthRHj8Hco/uavVBiRe3uVY54oyyI7bJpW7vGqdnGXS1sJJKpAa7ruQOLyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929377; c=relaxed/simple;
	bh=2EB7Ai4+LOqBTDtJ7dyGev0P9V3FvwX1/NfQjgUawFQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=I0+c4WlNzjrdjGDM1F6H11Rd716ZMTYeQ9NXC30vathUPhRL/DfrNv+J0pmwUiMa22yOzBChmUcXSjl34XWn+ZKfTafL1Ul8mveaLULSpUwknl+kerLl/ZgKLTUTUsf8h/zBn3AH4xWWRz4XrabmQMgjwzBiKVvNAtbwCT9eJJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VZzlxJ3r; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGXnLvLu6yY73eZbonanKcYCJAtc+FC8AgnRY2oEJtx/HWiEd452wNapnDyMIvX11FN3P8A7PLWsKuh0+FFljZgqjFNWnqYI042Fhg/B7f1kEe9fbydpGkecGOIwPZv1m+6hdBQ3WIlKUNIhzd3EfsaIL8nfajUPo/+CLE5n/yIbzzusJiCb04WrOgOmnmMLQkUDEWL8iQNyHcMYmB3Zz2XmyN+d9aga56QwjczuJLXs7LMl2pnY2no9Wy1VrlOwFsIi/+AEaFBNmqeqMWuOCUKzkdL54X596SeZjWyPuQZJwyz777IBsHTE9xrGKZqJfT09WJWxOfdq0x6dK80NLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eX4kqjDY0jruqmVRdcCosn1GDDY+gOWBSEX2M7rpJQ=;
 b=n6AWPdmfanKBK3PVqIJ/OZiLeMzmoVg8dbK8xDI+cVxN1qrDzc+xra4lOeKtW4E8n+XIGt+t/B7N7f3kRAQAWEd/nGfMI0VMeGeZ1SUX3mHSERc0UF57RCJLP11fMLuNy06nmybZl5OrKtoyeS40RViVBfd63/LbXJrb9EQnwLIZroIm5ytAvJc/4yhCnBnaSl/Fn3MwX0k+choIQAUvsLX5v0DBcynPI+c13hefA/DZtTW2/MiDrptKIoImXwJlSS5ZDvrfafz4zXc7wHSjNJqgBZYCOUl6zS/Iew0atG2x4mRnmfVpLyT9TG3ersJqoh5fcPbjLg/QRK578BpICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eX4kqjDY0jruqmVRdcCosn1GDDY+gOWBSEX2M7rpJQ=;
 b=VZzlxJ3rhanU9PYAK+gU/qQQ5eUREgQDZ2samynxnNQce1ARfUiVOxq/K4oy8//lKOs6LZctVaTQFp4GIYw/LblAUati7/Mp4pLpCVfaM1SSAv/ADU9V3BD352SNtBLYeaFRCMDS6Z9N9Ceqzi/0VEVSb884uBNg31VVqhp+gbgNpsGu0cDymoRns6/4LqeBxG1OK1VNX/TZTcfPL9YOr8hJtI2r4PyYuZq0Y8awnrQy5MPuzQpkrnBhxYFZb6UVhIzdYrt/0aQuSDp2RrADWkjNbhpBjNWs7bcxRjUowd/x36DnwFmleTq1iyrd6jJ6r6RHdOc+GyTYORnL0FGdsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DB9PR04MB8187.eurprd04.prod.outlook.com (2603:10a6:10:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 06:36:11 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:36:11 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 12 Nov 2025 14:36:20 +0800
Subject: [PATCH v2 2/5] mtd: spi-nor: micron-st: move set_octal_dtr to
 late_init()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-nor-v2-2-8699383714b9@nxp.com>
References: <20251112-nor-v2-0-8699383714b9@nxp.com>
In-Reply-To: <20251112-nor-v2-0-8699383714b9@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762929419; l=1595;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=2EB7Ai4+LOqBTDtJ7dyGev0P9V3FvwX1/NfQjgUawFQ=;
 b=2XNR5BB+cgZLMLZPPa3wtktBtVRpgaj5ldIfqE47tg5nLVouEKO/dK1iIYiHWNKEPr8knOlFA
 f0/V1k/x34KBUSNVyeI8nSLGeareQBTfR+wtr2GdWhopsFU8yRd2UFv
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DB9PR04MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cdc0ed-09a3-455e-5e29-08de21b5c551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODMrMURBTzYvQ0s1cXBRV1BiaTBJN3ZoUlZYc1dlWldoMmRneEJobmRCZVMy?=
 =?utf-8?B?YlE2elZwQ3A3VG4zSnpuYm9NREp6MjZyYlVRbzFEUlhia0xBbHlzaXcyWHlL?=
 =?utf-8?B?eWRHd0tIZCtIUXJ3akFpczZCbWxlN0d3am94ZG90WVFVbEtGVUI3eUJ0TW9E?=
 =?utf-8?B?RnBrS1FKRExPQlp5WmhrWGJYTTBpZjRObUc4djE5UkwrTXRqL0pYcnF5NFh4?=
 =?utf-8?B?QmJVWkNCZjFlb2xIVTF2eEFqdXlvMWF5SjBpdktGOFBQbFNhU0Zra016WGF3?=
 =?utf-8?B?YmsvMVEzUEp0UktSdklEWi9uWWNTTmRNYkpyVGhnVGNVUGUvVTRSa0dyTU9w?=
 =?utf-8?B?VFFRRUF5bGxGY20rRzlKemZKaHorWmJyOEFUcHZOWDlEZzl6Z3J0SXFLRkQy?=
 =?utf-8?B?ZDNaOTFkcjAyMm5DaS9aZ3ZFUmlobmVERWJKMUJlS0o5ZXhpcmlXRHpVN3BW?=
 =?utf-8?B?d1U5MUNKeEJlNER2WmtSK1RaS284QUxSdG9UQTNWL0NrSVhlbVRta2NPamVr?=
 =?utf-8?B?WCs0eEVUYnFZcHUvT3MxOGZsUnhrUFR2Vy9MTEUzdHREdGNYU3BESVV2cktj?=
 =?utf-8?B?cVBNTjNvMkhKNEd1WWliQ0JSVHRTRFJkVEZ0YkM0MmFVWStpZ04xazJ3bzc0?=
 =?utf-8?B?UHB2bHoyVDU1V2NFNlBnZU14QlEyb0g1YmZ3YngweDVHclZJYXEwWDJJKzRl?=
 =?utf-8?B?Z2JGMDc2eWR4V1ZIT293bWYyQnNrcnZkRml1Y3I4aGZPeDd2cG1xNEVJdWg5?=
 =?utf-8?B?UWpyMVNZSGxEeUhEY3RiR2h6ZC81cDg5OC94SVBab24zU21rOHUyamk4YlhC?=
 =?utf-8?B?eDlFeE1DUklLS3FRWjl1Tkx4SlM5TnBCSDUxOHFTNTd6bnM4aVY0KzhyUC9J?=
 =?utf-8?B?MWExdWlzRnNXcnk0MzJidk9HQTNBQzJHYVdsd0ZrOEp1SzI2dkNYVlB3MzZC?=
 =?utf-8?B?UjhSQmFTeWIzcmwrMHpsK3ZXcVZqOEJERGNnOWNIdzhkemRQUkI1VGtiU3ho?=
 =?utf-8?B?NEcydTFibE9sNGtWMnBuTWtWLytRR2x4MHh4Q1kyK0FuTnQyTnBLekV5ZFZh?=
 =?utf-8?B?clBPZk5oZzU5VjF4SWJ1MVB4b21JS2NyaVZDM2RITkdIc1hyOExjOWhUQ1p0?=
 =?utf-8?B?MEpGOEtaSGNBZkpPd0t0d0tpbVNCNEVmTU9Gd0lkSVNmc04va1I2TFF4WjNC?=
 =?utf-8?B?bk9UQzIrQVFNcUkzTi9yaWtWc3R3T2tjUW1wNHZqUmtsK3VPcWlFK0xFU3dZ?=
 =?utf-8?B?QXZtOTIxNU15TkFHT0VzNWIzdGtDRGx2VUltQ3llaDIzOS9BaVBvQ0pPcURl?=
 =?utf-8?B?cGNTMHVlYnRxdDNmS0s4Sk9NODhuRHFOMFVqRjRRZkFuZnRxd3VpbSsrcjUw?=
 =?utf-8?B?eGtXb1FwRzg3NmwzRVdWNGRicm9NekNsUXN0WTYwVDdaNFc1T3V3a3RKdG9h?=
 =?utf-8?B?ZkZCcEVpUFpHQTdQeGJ1NWZBNkVjSEVEb2x1YU9jZnpzY2VhL1NvUUhvcWx3?=
 =?utf-8?B?Vy9mVm1uY2prZDhSdG5NMnVjMWdONGFma1gyWS8vNU5na1A5dVo2VjNmSnc1?=
 =?utf-8?B?TlBudTUyREJDeWJ3ZGFWR3F0Z2VYUnFaS0NWa1haMGVJYytFdkZiVXFLNDVE?=
 =?utf-8?B?N1F3eTd1M0JnUnYyWGZrblFXcWJUSUpKOVFWZmVPa3EreEZ2THY1VVcyMi9L?=
 =?utf-8?B?UmRpb3Y0dElNL28zMFBUaWo0TjlyZFNUeEU5TStwSjA1blZ0STZhZU9IbTdQ?=
 =?utf-8?B?M1FONmFoajZOYUxZbXplTG1aV0RpYU5FV1ZWMlZKZ2RyS1dDQndQajdMdFMy?=
 =?utf-8?B?WUh0TjVRRFFjM1pYTnQyQnBaNGR2KzRlOUNhejA5eTBrZVJ1V2lsaUpNZmp1?=
 =?utf-8?B?eEpnRndCTFY0dVF5d2V3YkR6SHhMK0RjMHZhYUFUNGRTankvOGp1OHI5RDNv?=
 =?utf-8?B?aTM3MStrZUpuRXE1V0VxWlI5aUVDTVU4clprSEdsL0pzVUJGL3BERml1RldI?=
 =?utf-8?B?YkZ6UDdrYlJZajZDNnEvNkNCNHQxaEd4ajJqNytYNzc3VzYycmpUNnJtaHN6?=
 =?utf-8?Q?OlQQFF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm9LdklldnpGYys4Z2ViWUJzVnhRbHNmbWhnOURBWkhrOS9iNVBMaGcxVlNZ?=
 =?utf-8?B?aEN5Y3llQnVrSmR4emV3Ky9uMDc1Z0FZTi83dGpTeVpKRzVLY1NlNEJ1OXVN?=
 =?utf-8?B?TVV4ejBMcGM4Rmo1M3h2bDF1dktvd0lreURLUEUyTUlsNFE1cGhaUmwzbmw3?=
 =?utf-8?B?Um1SeUY0TldzNHBRWEsybnZ4TDkrTEtuazFXTFBXUUJPUG5MeU4zang3alJ4?=
 =?utf-8?B?d3JkTnJ4MGFPQWxFRlhUUUNCY0VLZXl6NFVGK1B6L0VRT0tkMnJxWnFydWxt?=
 =?utf-8?B?bDRKZWhKaVB1WlVvUnpQU0E3bHVyRDcrQllOWGlMVjg3Um4zRTFsbkZMTGw0?=
 =?utf-8?B?dWxjU3UwNTZYOEFkRHljR3VzWko5dFpGZGpnOVhHcDVtR1hqY3RHT1NKalZE?=
 =?utf-8?B?aDArSDliOTRtQ2I5Y2FqM1lrZ2ZIME1qS0hvb29TUFdaTGtJVllWWkRHRWZw?=
 =?utf-8?B?cC9wREZkK2JqWCtsdnVVNTJFRUhBZTNKZ3cvRk41VWpiT0RhT0ppZTVsVk9w?=
 =?utf-8?B?Uk5HNmd1QlhqV1hnSnFCVWZPbk9rYnd6MFNWdzVkbjYxWGhFaFBkMXRaVG1w?=
 =?utf-8?B?NTY4emp2amxsa3lBVjlMOFhGWm0yYXJ4M2lJVFJFd2xSWWZuRHhXV3NWaUMy?=
 =?utf-8?B?TERmbEcvOVZqeHkxNGJWNkVWT2N3OHE4YzNqQkJHeFpjamhIUWdsdDdTSkRG?=
 =?utf-8?B?bzJ1bzYzYkl2K3RvbnFteUV6MGhSWjIyT0dWcnlFbFRSYlNGTERwM0FjNjJF?=
 =?utf-8?B?dkx4QmRuTlBKOWxLd3dCV1N5YWlIRmtORlpZc1Zmam1RSFEreGhhSUxDT0hE?=
 =?utf-8?B?YVpMSnlERFo0V2JWOHVWNXJBNEJqWlhvMUxiYkFiNGtpczlsZ29oeVY4aXRX?=
 =?utf-8?B?ZEE1ejNwNWFzZW9aUlNQemxncmlhM211RFNiVS9qTVIvc2ljdHhIQm56c21G?=
 =?utf-8?B?b1hWaFBSdVJWRnR5cXB4bkFGSUdmSVUwM2toTFNxRXZEaDRCekVycHdZeENo?=
 =?utf-8?B?L2V1ZjJoZ3JQM2J2SFF0WFFZYWVmMWNOT3pGNVgzMkxTeFVMQlNveGU3eGFZ?=
 =?utf-8?B?UFR6akljQVVWNG5kTWxWemVKcWFZSlZnN2NnTjZ5dVMxMi8wdWlzZ0tZdy8y?=
 =?utf-8?B?NWVpTHNhV1ZHYXNTSUpRZ0tPNVRYbkk1QVFxTERrSnZaRVY1YTBNb2lpbWh0?=
 =?utf-8?B?emxNc1ZENUJoWThIaXlqVXRhOVdscWRmZDh5WUpBbGw2Y3JiWmtxeU9mdzJY?=
 =?utf-8?B?K0ZFMkJSNHliZkE2WkUwbzVscElocFBlWEhibU1GbFgwdHJINi9kSlE0b2VU?=
 =?utf-8?B?dUk4RnliMnliZGVlK2l1ckRpQURSbmJOZEFJY0lIL1VsVkZ2aVF3Y3NKc0l2?=
 =?utf-8?B?azZzYStaWEUzWFFFYTYxaXl4RmFLNktUL0FSWDJJUHZCOHJiOERTaHNxSFVz?=
 =?utf-8?B?ZnNHWE1xUHFCM0d1TmQ0TmhyaldVczV6eE1UL3lTdzVBaktFQWR4eWlJR1Mz?=
 =?utf-8?B?RGRtOGJQRXJGYVozaHdlRDdpM2YwVVZiZVVoV1NBU0M3aGg4QjFpbTRkNklO?=
 =?utf-8?B?ZkFEbG9KMkZhMVJMUUc1Qmw0VUJRSUhVQjV5S01iWGdkTTZmQk4zQ0RWdm04?=
 =?utf-8?B?VW9KU0U4blZ2M21iRUh4d2tsUVVqVUNnb1hGejhVU0NLMlVKallwTGthR0F5?=
 =?utf-8?B?M05DZHlSNXZhYlNvQ0NZOC85ZFhSQ2ZxWlFYVHZndW9OYmR2c3Y1ck50Yzcr?=
 =?utf-8?B?MmRKVTdJRnM1eUw2MnNTZmlWS0dIcUNVcWJKNG5xWjVsUDl6OW5JUHo1M05x?=
 =?utf-8?B?L0xIYW1JNWt5WHFHZ052djZ1a1Z4Z1BoSnZSUFR0YVhqYjhENWRDQTZUOE1K?=
 =?utf-8?B?bC9mZXNvSVdsUlNiOTVuM0VFdk9IbTl5ZzFrTlBhYjlKRzdySFBZRDJ5VzN6?=
 =?utf-8?B?eE8wY0hpMWRURmh4MWFGeHllT0JlR21ZVUNsTGFSWDBPcHFLR00zbDhGTmYz?=
 =?utf-8?B?S1JHOVV5cm1ZL1FsSk9OZzRGdDRzekVKcU91Uk9LbkIwSG5kV3ZlSDRsZCtl?=
 =?utf-8?B?d0NUcU04RXhzcnlQcG10UmpxakljY3k2ZGp3dGxmQ0xkVi9VRlZIM0pndkNv?=
 =?utf-8?Q?/q4Io+5CtQ9WcwKd6adtxS9tn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cdc0ed-09a3-455e-5e29-08de21b5c551
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:36:11.8709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3lZIUpHcqNBo61I49YvmWwqUTvjzi6w17wzwZs9OJ0MV+EyuCgc6JEJanRfLbgurxPa1AUCcsq9BDiZPgrUEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8187

Move params->set_octal_dtr from flash_info->fixups->default_init()
to spi_nor_manufacturer-> fixups-> late_init(), this can cover
all Micorn and ST chips without repeat in each chip's flash_info.

With this, we can also remove flash_info->size if chip has SFDP.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mtd/spi-nor/micron-st.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 92eb14ca76c57f29ece1edb3fe652c56d1c2888f..81a9bead1434056cce0893c97bd35ea248c15894 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -159,11 +159,6 @@ static int micron_st_nor_two_die_late_init(struct spi_nor *nor)
 	return spi_nor_set_4byte_addr_mode(nor, true);
 }
 
-static void mt35xu512aba_default_init(struct spi_nor *nor)
-{
-	nor->params->set_octal_dtr = micron_st_nor_set_octal_dtr;
-}
-
 static int mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
 {
 	/* Set the Fast Read settings. */
@@ -187,7 +182,6 @@ static int mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
 }
 
 static const struct spi_nor_fixups mt35xu512aba_fixups = {
-	.default_init = mt35xu512aba_default_init,
 	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
 };
 
@@ -635,6 +629,8 @@ static int micron_st_nor_late_init(struct spi_nor *nor)
 	if (!params->set_4byte_addr_mode)
 		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
 
+	params->set_octal_dtr = micron_st_nor_set_octal_dtr;
+
 	return 0;
 }
 

-- 
2.34.1


