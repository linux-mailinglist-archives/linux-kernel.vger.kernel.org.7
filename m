Return-Path: <linux-kernel+bounces-896602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1A7C50C12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1B4334B5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D02DCC03;
	Wed, 12 Nov 2025 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LUoIRyhr"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011063.outbound.protection.outlook.com [40.107.130.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F22257824
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930075; cv=fail; b=J+4ea4UssCfU681hv5FFM+KeCBcAAJS11DI1ny1qsZtPYJhmMAPB+TTL3b5qXuaOkYRcga/3L9TqulmFEjrGIPeOwSXPYyEj2mceA0yI5L8JA6niWoQFsEC6Ur9JvDFBx9CEBvmrliunkj8Hfdr8jFhIzTw5kyEe3BtJROamXs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930075; c=relaxed/simple;
	bh=SM+ARwu3tWLUueEvcjbe4AknlOqtRSUPy4ZdW/TaTcg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T6oVULKhOP4y6yo4kL95Y59uyZ4YFJS6PGJXhfnjjp/kqNlPkzvTXtXYpnXcPNT8xVvhIgblG61w2/JG9tbFrtzMZHb+6TU0niIAGmsZJI7r/nxnHsmccmDy1bJj0xocUggyIa+SK6ixHltN+58/XBIhEdTe23l+DYiVwBLllGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LUoIRyhr; arc=fail smtp.client-ip=40.107.130.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/D6Io4V5RULfpSuX8FozaELsMfCzTh1M+hoyFf64ObBAhgAUnJ+QydMnd68dPQ8fpjenuFBdo0VAXbldVvH3VsNTe8Ir2R/dwjvHFw0s0lWxM7K3cpKAffkmLJd8Fqtrio8qNH545fuo7cjTicn7xMMZ1+sX+18D6P5K0cfgSknQifMy+fck1lK7sgbO/rU5a/vRUVv5odi+MYKyT5YfWmyFf1ff+UwI4QBvJVr2mdoFpgvruGmH0Q+CpSrLXavHNr6Cj4pu9wKsl0TmzTCLRlrPn47ypoLOfedDSwRllIS8boK6YcGMhzHdjdp5BDS8fUXDTxgNousvqDD3i3FsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/UaVx79feLzt/kwGhD1/HTo9b4GEKUxtKNcavU67kw=;
 b=wdsIfGrbpo6eThaeOpRDty4V3uI1xXwxCCbYwmV9DQIId4yvZfb5sYuuq17Z0Vu3+ypPWbasrwtFWJfu5iDM2bDHnShsJiMTl8HVbJvkEj43JQOZxQlA1IEsrRmnGvsXK0jBVEbYRUf9BdjqRgox1Zw0P2WMOrkmQWQxXLjL5dU3iRQsLmr9zN51zjln0wCjUgzKbw5F9tbVQPvnN3E26Z6v1zvWz1VeVh26y2V6zZpVnHBloeejiUqDm7EBYftP+ve5YQKHGGDleu3mS59rXGON5iC5TNRAaJ9HPmD7EbpYsVJECdToEBqoYMhGtavmG1KPOAOtNC3Z1ACJUjuDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/UaVx79feLzt/kwGhD1/HTo9b4GEKUxtKNcavU67kw=;
 b=LUoIRyhrOCEbLZ1VDohKlgwMNABr72axj43smi4Bi58Rv4yNoXMRAoIPjRC4dxjqRYHXTXv4iytGmn8/kw3NPB1SwyVLnZ5jCruyxjQoCP5QXEay7QrcEKZKt3tj18cgYyl4x/5De7eJRgo+nydBuMtHLV3/PZUQxJTOaMh9FgXCQOTMNp9Ey5fRBGxRjzmjPqfztKss3rmBzAoTHTx40Pqx8OtbZslNZUvztVtYLC1LYx1lOp3pcdXBLSGiSIeKxJmEcM4z7ImTUeXAKWksEYy5JLRUu2t+b8FMuInZMAFx4DeuMoEM9O7ruCT+X2X+7mJsEBg2U4+qbYItCHJnpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI0PR04MB11939.eurprd04.prod.outlook.com (2603:10a6:800:307::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 06:47:50 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:47:50 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 12 Nov 2025 14:48:04 +0800
Subject: [PATCH v3 1/5] mtd: spi-nor: micron-st: rename the die_late_init
 functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-nor-v3-1-20aaff727c7d@nxp.com>
References: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
In-Reply-To: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762930121; l=3812;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=SM+ARwu3tWLUueEvcjbe4AknlOqtRSUPy4ZdW/TaTcg=;
 b=0oSIA18b2GD0MlpQ2b1YHPA0TT9duNL2MVtdJbBd3JHRm/TUQGgoOQnjv0wf3Wat3TIlP8wRR
 FS+Op0M+bcsDW8rbdRX0tTr9WLlAImKrkx0pHhxI3J2iHKSBUkZ2X+b
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI0PR04MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: 3074cd22-9926-4909-45cb-08de21b765d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWtiS3ZHd1RoQUZrY2ZBRGFFL3htWDlWbGNoeUZMRll6TE05MStZZWRPcTU1?=
 =?utf-8?B?eWQrbzFxNDhVTm9rQjdEc2FHVnRxSmVRdjZRM1VYKzYvUWl3c0lHcytqMlBN?=
 =?utf-8?B?QXNFL25uRFh4RnlnRVR2NDdQbjV4WWUwdXJwTFp6bXZLTzZGeWozbFE1T1Bm?=
 =?utf-8?B?NjZ5Rmd2TUtPTHNyWmFYb0RiMkx5MXVGcVJJVVBudUtGSlRXcFBxcm5jR0x1?=
 =?utf-8?B?Z2tYTEhKUlZ1M1U0WXAxWlE4VUdheDE4TWlHRlQydGdHb3hxbitRNXBEQ3dP?=
 =?utf-8?B?MjFTZitoK3h6ZFlzM1BxNmVhNC9EN3RtRHVROFZOQit4bEtpUmVRZ01rNnFT?=
 =?utf-8?B?WWRsSVV0eUFHQm4vSVlhUmlpYW05TXNKS2krZUFaRjFXQmVGWWtQbFkrR2NB?=
 =?utf-8?B?REVSKzNXVDNncXNLdWs5VGpTaExlT3F1Mk1ZTE81SXRsMERDRm1vbVFkNGht?=
 =?utf-8?B?N2NUSzJoWVlnS01kMGFlK3VWQ3JJZHdXYjBWNVpGVjFBYWJFd0RLekNYVzBh?=
 =?utf-8?B?S3FVSWQ3VDVUWWhvTzVkU2VQWUhRUGVmRGVVdk5FRTNoTE0zUUorZEJIUHA3?=
 =?utf-8?B?dzVWQXk5Y3RhWEhIQzVZSzNTZFYrRE92K0lwcmx5TUtmRHl5RFZrS2M4OVI4?=
 =?utf-8?B?YmhKZmtoZ3BjbStoZGVaTDFQVTlLT2FXWGhVSDA1RlpPaE5YUTF3dXZOQnpi?=
 =?utf-8?B?NGQ4a2NaUXNJSGgyMnhLV00zbDJMQm5NVEVJNnlhTWp5eUxaVS9kVERKbHVa?=
 =?utf-8?B?eDlSYm83TTJkV1FXWVh6TkgrRVcwbGp0R2JOdEtEN1B5ekRNOGNDR1Y4TzIz?=
 =?utf-8?B?enkzV1ZaQ2RVb1dTUVFqem96cVNNSWliYldFZW1kaUN4NHoyMzFpd0tObTdY?=
 =?utf-8?B?MEpHMzBSNVJmZ2ZFQldBeEdSZ0dWTm10QlNrYUwvN0VwWlh2dVVNRHI0VEdw?=
 =?utf-8?B?TWFSaGY3WlZaNXZaMWRGdzU0SkNvakJGNXJ3cGFlekFmMlFEd0VKL3hRQkdY?=
 =?utf-8?B?QU5CRjF2WXVUbDhiczdqY1FObjVSUGNSK1prbEZ0N3l2NS9Iamcvbm43UXZT?=
 =?utf-8?B?aEpkZVB4UVN1NlBaZjcwRHRqUTdCUkpDZGZIVUEwdkRLNGlQaGtNM0tSMDEv?=
 =?utf-8?B?QU9GdmthM1VkNERPZEpLRHlhRVphNkxvMEJZMTFIL2JKZ1Q1MWJvQnhNV2hT?=
 =?utf-8?B?NXdJbXpiQkhIMEczUzNlL1NLV2dwSlpVMmFCRFNBdkVESWs4MkxWRDZyQ1RP?=
 =?utf-8?B?Ynh1WXpLVVVOSWN5MjBqSWFUKzFReVFmTDk2SmlONDU3WnRXQTc2QzNTZTF0?=
 =?utf-8?B?djQyY2g1a0JoQlN1TkRYVklZbzFRVmVWWnE5a3prN1ROZWNuU25VK25rZmdP?=
 =?utf-8?B?Q0xkSXh1Q1ZHOXpGRE1UVzkyNTNQSGI5ZXZXbDlNUWhmb2RPc09iQkJndHZR?=
 =?utf-8?B?WVdNN0hZaloyTi84RE1MWHJqVGtvNnI5T2k2VUNxeDlLUExhb2lWM3NwT2tx?=
 =?utf-8?B?WDEzMGlhL0x1anNsMU9zL0dHTW9iTlM4OTlyamFOeW5ibGJyd2o5NUZDZWFr?=
 =?utf-8?B?YXAyZTRBVldHbzdYQVVBcFROTmtlLy9tZFd1aFRpcnlRSDB5VTUzOERDNU5o?=
 =?utf-8?B?NjlpRnA3YjlQOUJOdjRsZWxwNTA0dDBtRU8wTDVTRGg0RjRtK0VJMFBHY3pw?=
 =?utf-8?B?M1FNT1Q2S0RUbUN6bGhMMWxIa1hTeU1KaG5YZVZtL0NwaE9NWFFEVXQyUnY2?=
 =?utf-8?B?b1hyajhjL3NEWDdiYUtGbHl4R3dKd1o4Znd1MjNWWXFQRG9PNFd6Nkp4Zkox?=
 =?utf-8?B?V3p0NkdWcEhHUjdCYW9hUDA2RWVBTVh4WUlQc3FySDZvY3FzZXROcFFiYTZI?=
 =?utf-8?B?NzNRQlhWa1hpQUlobmMyaWFmSC9Qclh3NkhIWUJMaU9VcW92ZENvZCtUNXB1?=
 =?utf-8?B?UjRnWTdId1M5N0htRHVySmxoZHcrQTBPT1hyQkZIb2JiMEZ6eHJ1Qkp3UzhR?=
 =?utf-8?B?Y0lrbmxGN29Sa2JEbGVIN3pIeldvOG9KYzZmSllYOVl3L0Y1bGl5ZVYrKytu?=
 =?utf-8?Q?MxGD0C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHU5REsxN2VxQUVvWHdzVVNCZmNtRVVVYzBEZW10RmRDRTFvM0IwaXlVS1Va?=
 =?utf-8?B?UERhMDE0VWdxSVR5dU9FRTgzdmRFcS8xcUovSUtWT2x6RjhVMEJLNWlyY1dX?=
 =?utf-8?B?SEJtVktKQkx4Y1JYc0h6SDVQTDd6dGdzMHRxbXN1MGxlTzlEY1FPSE5JMnJZ?=
 =?utf-8?B?bDRLQnVIL242ZHZoYThlMnJGKzJQc2ljSTlkRWt6R3FjeWJEU3VJS0pDWXhn?=
 =?utf-8?B?aDBKYmg2b0J0TFo3UmJuT2VtYnduMnZuMDZ2d041NGVFcm9zWjcxNFNwdkVD?=
 =?utf-8?B?Q1pwa0xueW91YUFDVGlkY3ljbGxLeHJXWkRtL1IwamVSMDRkbGtjWlhPQ2xO?=
 =?utf-8?B?VlZaeWNyR042ZDd6Ri90Lzlid29ibitBL2hsNjVSVUJUVjAvWG9mQ2t0dDIy?=
 =?utf-8?B?MFJiU243M08rcllXeFVKNHdUeHcxNHE5Q2NLa2lVN01tUkhSM3NJanZibExT?=
 =?utf-8?B?WDZuWDFBS0VzRjNmck84YmdLU2pMMUJsWXA5UkdLY25yYkwyR1dpY1VBRm15?=
 =?utf-8?B?clA4cU9PekVTbThBcDFCM1cyS1FYakEySG5iaEd6aWhiZnFVZDBnM3dlbStE?=
 =?utf-8?B?WHdxYlBGVzZqS1lsQWFNZHhGSTBXQnhZakpzNDc0S244KzdoNm5JRmpQTlBj?=
 =?utf-8?B?dFh6OUlFSHVZODZCbUJRUm5YdVlYRGUyYnA0VGxTVW94Qm5CM29qYWMwblR6?=
 =?utf-8?B?cWxrd1pzYUxSSFFYdWsyeksrS0ZranE3MVR4K1lpdHpJd3UrYXJIaFBQTTVZ?=
 =?utf-8?B?cHdqcTBjZTlCckR1SFd0bmQxM2N3YjFiVjVqTzJ6QVhzQllFTGVtZmFVbVZQ?=
 =?utf-8?B?Z2xQWTNCMjVkWFkxL2wvTWJMZmJhVmdCc2QxYUFzc0I0bFg2SXJjbmFDV3JD?=
 =?utf-8?B?b3N6TzFUM0h2OHZhc1VrbGVxb083M2lTTlZSNkRZeVFTQ1hJWXVSSVo1UXRL?=
 =?utf-8?B?VlMwdWF4SWhYSVZoZEhnQThiU0tjakg0anVDQk11cEZvTVpPbnV6NGlRYmgv?=
 =?utf-8?B?eDBGVThNTFQzeFk2cEZHeVd1bHdxZ3dzclpzMm9jUjQrUGtINE13cXdFdjR5?=
 =?utf-8?B?cTgzQ0dQQW1iRiswa0huU2Y0d0N6YzFGNC9uSURlVHBEUTRVUnNqSHRmSkgw?=
 =?utf-8?B?M2hmVUFHZ29zOGpJYlY2MTQvbG5USWNiOTRzQThWMHZjZm5vL1BaMTEzTUhP?=
 =?utf-8?B?UVFjSVJweFVCUEswYmZzMkRBS3dIMFJCR1ljbndsVzNRNjBoczFsaEdBYXRG?=
 =?utf-8?B?K2gwa3NSZ3Q5RzFuSE9kVWlNbE9STFVkZXdXZC9pQm95QXB1YkxQSWpzSTNw?=
 =?utf-8?B?V2lIVS9mNkhoSkZqK0xRR05WME1QeDV3ZU9FanlNY0ZGRmxoY1FBNW1CUE9V?=
 =?utf-8?B?ODRkbkpYOUYramNSZHJXaEJGRyt6dFlaREoraFlJbDRrNEpLVlY2VEFqQ2hw?=
 =?utf-8?B?M0pqSVc2UHNoUERhRXdaWENVcUZ4dHV2cjN2QUdpVzRxTFdRci9HVUYzVDk5?=
 =?utf-8?B?Q21LdDFDWktId3g2M0hBdWtvNmpVL21VNDlYY2hzS2VxbE5pVUlCQmhaUVps?=
 =?utf-8?B?WGhZbzExM1kzdERmRXdRRzhmOEZ0bFRTNnZteEJ4ZkJoSXNZaGdsZ1JwVTJJ?=
 =?utf-8?B?Vy9VOUIxYisyK29HeEVKeUtPaDlzeDNjU0ViaVVEZExkVkNLeXVaclhwaDIz?=
 =?utf-8?B?WUJ5SGRFN2Rucyt4SUgrbTZ0bXZmOVFCS3doRi81bkxKcm5yYVE3cFJ1NVBN?=
 =?utf-8?B?TC9Wc3J3cjdqempoM1pqcVpJd1FQVXZmL2Q2VlZPQkZwTFZSTkFEK1E5RE84?=
 =?utf-8?B?dm9xTUZrU1VxbVpDV2RRSFdvaDlIaGxHczdKM0VaZWlYcVMrY01BOUhTNG1U?=
 =?utf-8?B?TnU0RytqLzN2YU1BaURMWnUzSU45NEtPTkhFRUZkK29hRGttUWFqRnRMWDg5?=
 =?utf-8?B?ODh3VlBzSmZ6UXJ0YTVUdEdGaE5kZjlrMzVtZnlLK1RaMTVkR25mMlkyalU3?=
 =?utf-8?B?R096VE5UclFYL0xSZ0RGMHJmVERobzV6eHUxZm5jVTZJd1N0WTlXaHNnQTRq?=
 =?utf-8?B?ZWErZGppM29GRVpiUUM3NDZCemJsTFZTRS9EcDMxMDRTNkN0d0VVYUcwQVZQ?=
 =?utf-8?Q?UVvRzuu4QqdxeFxPEvLl63/wF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3074cd22-9926-4909-45cb-08de21b765d8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:47:50.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5U3bdYvrcAo+9lNrPq4DcyI31r16bAsIDZ+3eTsOW4953VNthV2N6Xp92tfn0bkfuT9rdrbW910DULlDcr1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11939

st_nor_two/four_die_late_init() also suit for micron chips,
so rename to micron_st_nor_two/four_die_late_init(), and move
these functions up, then micron can use these function without
declaration.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mtd/spi-nor/micron-st.c | 70 ++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 187239ccd549510c6e9a6eacf4ae41158287e077..92eb14ca76c57f29ece1edb3fe652c56d1c2888f 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -127,6 +127,38 @@ static int micron_st_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
 			micron_st_nor_octal_dtr_dis(nor);
 }
 
+static int micron_st_nor_four_die_late_init(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
+	params->n_dice = 4;
+
+	/*
+	 * Unfortunately the die erase opcode does not have a 4-byte opcode
+	 * correspondent for these flashes. The SFDP 4BAIT table fails to
+	 * consider the die erase too. We're forced to enter in the 4 byte
+	 * address mode in order to benefit of the die erase.
+	 */
+	return spi_nor_set_4byte_addr_mode(nor, true);
+}
+
+static int micron_st_nor_two_die_late_init(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
+	params->n_dice = 2;
+
+	/*
+	 * Unfortunately the die erase opcode does not have a 4-byte opcode
+	 * correspondent for these flashes. The SFDP 4BAIT table fails to
+	 * consider the die erase too. We're forced to enter in the 4 byte
+	 * address mode in order to benefit of the die erase.
+	 */
+	return spi_nor_set_4byte_addr_mode(nor, true);
+}
+
 static void mt35xu512aba_default_init(struct spi_nor *nor)
 {
 	nor->params->set_octal_dtr = micron_st_nor_set_octal_dtr;
@@ -193,48 +225,16 @@ static const struct spi_nor_fixups mt25qu512a_fixups = {
 	.post_bfpt = mt25qu512a_post_bfpt_fixup,
 };
 
-static int st_nor_four_die_late_init(struct spi_nor *nor)
-{
-	struct spi_nor_flash_parameter *params = nor->params;
-
-	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
-	params->n_dice = 4;
-
-	/*
-	 * Unfortunately the die erase opcode does not have a 4-byte opcode
-	 * correspondent for these flashes. The SFDP 4BAIT table fails to
-	 * consider the die erase too. We're forced to enter in the 4 byte
-	 * address mode in order to benefit of the die erase.
-	 */
-	return spi_nor_set_4byte_addr_mode(nor, true);
-}
-
-static int st_nor_two_die_late_init(struct spi_nor *nor)
-{
-	struct spi_nor_flash_parameter *params = nor->params;
-
-	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
-	params->n_dice = 2;
-
-	/*
-	 * Unfortunately the die erase opcode does not have a 4-byte opcode
-	 * correspondent for these flashes. The SFDP 4BAIT table fails to
-	 * consider the die erase too. We're forced to enter in the 4 byte
-	 * address mode in order to benefit of the die erase.
-	 */
-	return spi_nor_set_4byte_addr_mode(nor, true);
-}
-
 static const struct spi_nor_fixups n25q00_fixups = {
-	.late_init = st_nor_four_die_late_init,
+	.late_init = micron_st_nor_four_die_late_init,
 };
 
 static const struct spi_nor_fixups mt25q01_fixups = {
-	.late_init = st_nor_two_die_late_init,
+	.late_init = micron_st_nor_two_die_late_init,
 };
 
 static const struct spi_nor_fixups mt25q02_fixups = {
-	.late_init = st_nor_four_die_late_init,
+	.late_init = micron_st_nor_four_die_late_init,
 };
 
 static const struct flash_info st_nor_parts[] = {

-- 
2.34.1


