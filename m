Return-Path: <linux-kernel+bounces-874648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9DAC16CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 833BB4ECB56
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB562C11CB;
	Tue, 28 Oct 2025 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hl5wd+V1"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701D20B212;
	Tue, 28 Oct 2025 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683461; cv=fail; b=Lr9Jc1Z0/c+gPKUOGHmf1GKy+E2+qYUkAGn22F5Mc5PWn2HNBARoBIfIBoU0VazXjVFBnhLo3JfvgB2FMQ5AKpq9LQM2+f5ZFQMSrrzo6LHghS8ZnJ7JlCep9lHnp4vOxzxsFxzSu83cOGWwvsjfoe6KD3OVWpQT1+LzGAAbOsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683461; c=relaxed/simple;
	bh=te2FAhD8hj9/0KOw2EpnPvBQBt/S6g8Q4Qx24TIj6NY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PqsnnefOXBaV2r96eXVIxpl26vRMR5tT+7uT8n8YV2ZeurDAL0PSR9eHhqykee/rzYDpEH1Fk78VQ8smBf5OLjbtMJiGYvOFtCT5s8/E5XSRfgqRt16cVxRGBch1uUGnW5pLG6zoYuUt+1MLmUsKzgTRyx+hQ0YzitcqiT8RgQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hl5wd+V1; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEnYiiCSEfCWpNXuvH1yQLmi1nIveOWnY/6dkru/LveJOf15Ilro+qCZQIbz05X0IEzhoRomq68g7h/YwofjbtCHmwmXCCSvFbgpjQv4ip2tI7jrZ/oS1AlxzHgtNEAubr+c0A/5Cp+Be2KWh8zehu+rgXFEESirmelD+I4oZLIUZZ82sgcUu0dqidaqrUvgsrRWhyv0ACB/iqg/nPTTF11RzCbkGqobvpln5fDgHm0GCqCjlolJ8mJuvLEPLmVXO5/luPgh4Hb2QfKIiOau1XIJLHVQ9lSNgTU27kZdTtlHN3YKMtgQOLHacngrpOcyYxq3cg7uiNKU52N3bBDwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1B1cnvlZXW3Tgd/UIh9myE75gxJ6m1zIGbYQ8ra6/U=;
 b=SaDrT3AN25zv4d76K9IR8sx5DDQh0PsMYz21pFc45onC6Q6/J66EDn2J9WbODk2hNTboCKrWba8Y4WUDyUhYQRmrPHCKT5fzhEbV5y41AHpBiya6McZVDOOmiRdaN6MxmpiIZT/6AmX4Yvtebtu3u6B9bqZ7gm8/kqtTx91DucydY3snDrtfW61HSeau7whKsVcYM8il4WaCcCJFFqUvKD2Hm/j/1/qtdO+mF8mcn2XVLzIdchLM1XiyHHIGxD4Z3KEkJOCwqMfhl1QEUANNwjyLodk/EZFiT7k71EJLf3ZaPZncfVwM87CpQrrfB9ko/kPlgRdgDdSDXR1S2nZz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1B1cnvlZXW3Tgd/UIh9myE75gxJ6m1zIGbYQ8ra6/U=;
 b=hl5wd+V1iKhkGTNJqCezmWCw4zJhHM2TICeX/cUD1hoMqWKDNzrzH/VQgUbBtSNjaAX+pnOGQZBQ9XPJuSABJ2nDJLoZiMDLEr6B5X0cUg932gj/2Ls+5l5Onwlh9BMxfTq2M2EISCVKmCuHj65hoZelhAbkkxCgTnSCEp8uzWlUMN+FaN474A51e97qD/LDHWre2E0FlKnTCrkbtp0dtFt40yKkKUo8tzPEDEMix1u8atCGO2BZs+NQavyZBKUg+lyUe48YN0wHewMgu39YhMCLfty3UOhA0jRWvonfyGhFOorQDBw2KUKuIcfafWY+TkmiWaQx8jeaiB8iKO/EMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 20:30:56 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 20:30:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/8] arm64: dts: imx8qm: collect some missed qm patches
Date: Tue, 28 Oct 2025 16:30:41 -0400
Message-Id: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPEnAWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyML3SST+MLc+JSSYl0TU7NEA0tzQ+NEs2QloPqCotS0zAqwWdGxtbU
 AyXBWZlsAAAA=
X-Change-ID: 20251028-b4_qm_dts-456a09713a6c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761683454; l=973;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=te2FAhD8hj9/0KOw2EpnPvBQBt/S6g8Q4Qx24TIj6NY=;
 b=lREzr7WYu+1yFUiw/Y87Yt3rfsGMtcZVRb991+/EfhCUwzVI0rcgRe3xZk+4j+YLQWQQufNzf
 VvHClzCGtuYChAqVYmaHlst81eqfGUQb2pNqagMY4cTSnXLNJVivdSS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:e::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f52b4dc-bbc6-406a-f164-08de1660e62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU1YK1lQNmkyUDJtbFNselcwYnExbjl1N0FvaTE0Q211Nms5VjNNTXZDajF0?=
 =?utf-8?B?UUpDclF5VTNzendGY240c3k3VVUyK0JXM1BkcjIrbEZKRFNSYjhyN2NwYU1r?=
 =?utf-8?B?VTliYlhEQ1pmNkFpRnl6UzBKN0hXSTRtdlowVzFvT3VXbjFYMDF2TmVvbzJh?=
 =?utf-8?B?ZGpkd1kyWDMyOWU5SWlkV1d4bXdEb2NBQ3dyUWtndzFTcEZwam8rbjg1MXJS?=
 =?utf-8?B?dWRNN0lhbXE3VThJdlFpSEZnWXAvcXdodmZsWmdFS09NdzJYeXVrbW1PWith?=
 =?utf-8?B?Q1ZXbWdBSk5pT0gyam1mWktPVFFJTHRaeFJ3RzFPRVVFaDJDaXlvZjZrZkhC?=
 =?utf-8?B?cnJyUkZqcFNSRnUzUG0waER4OUczWVU2OUYwaEZOVHZsQTVVY0lvOCtSZkJ1?=
 =?utf-8?B?RUd4aXlzRmlyTWZKWlVVNDdaWEdEcHBxUmJlM0xnZ2tEQnhQamRTYmV6U3V6?=
 =?utf-8?B?bXk4OTFuS3pJMW5mZTZRNkNrcTY5OFhSOElBQm5MZW4rbkNaNExzOURERTRY?=
 =?utf-8?B?WU1VZTVoemMwRCthZDM2UEFENUVTYytKMmErRklVZUpuLzh3WW5hbzh5eGJs?=
 =?utf-8?B?Vk45MzhrMzRETzlXRzc5MjdWUVpidUNWK1pndWFybU1EdDNuRVUwZjdjT0hI?=
 =?utf-8?B?THppVGhpZlVHZVhUeG1NZlE4eWphOXRTbmxCSlJCWDJmZndwNGxXTFZXTW5X?=
 =?utf-8?B?WjVsQXR5VkVtUHhuTmJBdmljVVBxbjlHaW1WMDZoTW1rWmx0YXQyLzhWWDV4?=
 =?utf-8?B?VHRBZWs2aW0vSWprUDRldnVYaGF4cUd0VnhnVmw4NklNbllIUjhHUkNiZk1o?=
 =?utf-8?B?Rmd5T0hna04xVW5ENC9peE5xNEFCbkF2d3hYOWdRMU5UaFpRRElaMmNoMFNV?=
 =?utf-8?B?cExZUFRhMDZEZ1FJdWthVGIzS3VuRFZPUzJ6aHdVSVBxOTVrNXUybzluM2t2?=
 =?utf-8?B?WGx0MGVLaHM2YURLRW03bWNuNHFDcFEyM043OVJUOUhWblNmTkIvM3NlbmZQ?=
 =?utf-8?B?UDlscDFOUGpCT0owNWZGd1RNaVhCZ0FmdDBFMjNYRzVldDJqU2p2Y1JxelpK?=
 =?utf-8?B?RFhWaG1Na1B4QVdtdHhDTURUZ2ZVLzZrUmVQNFZTcHpXZk9LWlJOZVRZdFg0?=
 =?utf-8?B?RkZtWmt3VS8zNWJTc1NIOStuTmdSekFJaXRtOGtCVGRxV2FqT0x1T1Z4ejR2?=
 =?utf-8?B?YkI5VTJNVU1EeHgzRkM5dWN6anQwdUFOQ0RzUzdoS3lndndIUkp1dzhKYzJF?=
 =?utf-8?B?Zmt6YmVpcGFXR2ZTeUlDMnp6VDNUTjQwaEtmdXlMelRLN29zdXRkOXZlOXE0?=
 =?utf-8?B?eFR5UENDVFJ2U1EydHV5aVMrY3l6LzdSS3RsK3hkZE1ubGl1b1J6YU9YbE5D?=
 =?utf-8?B?MDZrQkF2MDcxS0RWakh5a1draGNvVGpOMjNSeUJYbzNIL2dkSlFsMUFXalV4?=
 =?utf-8?B?VkJGeWdhVWtxa2hEZ3Q5aDFyeEUrY3N4aDlHQ08xQSt1dldtekhGckpNMWlK?=
 =?utf-8?B?QkNmRE93SThXQkJ3ajhyNkQ5YjE0NU04Tk4wYUliNml6RDBUK2U1QXE5d3Zh?=
 =?utf-8?B?d1hRajZLTWNZRkx6c3pWdG1GY2RnQkliRkt6b0VYcCtOZkhBN0ZHNHcyMDJt?=
 =?utf-8?B?ZVEzZk5Oc0xlRWVtVldQT3JySnlBVzQ2TXBJUHlLRk1aWWpuZkVQTDgwOGlJ?=
 =?utf-8?B?ZEpVTkV6bjRPellvYXpoTzlPME94MGlQWktnTjdqVmFIQ3lZTm4xQkJsbUtW?=
 =?utf-8?B?eFl3YUkrcVF2dXdFcWVHTHUwbm5uOFhEMFkxWGNxNkNuMEYxclB1eU1yUzRR?=
 =?utf-8?B?bDh0Ny80YS9YcEhuQWRHbzNnUjhDMjNWR1BYdW53NWU0MEVVc1V5NUR0alNx?=
 =?utf-8?B?eU1hNC8zZFkvLzlYTGZmUG1ETktVNkk0TzRZWStUOEJIN1FEUGhPYytFSTZh?=
 =?utf-8?B?dnBLb1lTOURNQWpvL2xHREh0M2JOUzQvbjEwbG41cWNJNW1yZGt6dWUrS3lz?=
 =?utf-8?B?ZVdOSHA5UFQ3R3gwMnNJQllRREM4cU9MZERaZ2FaZlc3QTcrM2tjS2JvSDQ4?=
 =?utf-8?Q?DNy5B6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUVHN3lZN1Roc3JBRW1Nelpwcithb083aHJ6LzBxYlJEbUNxZWJWNitTbVZV?=
 =?utf-8?B?MHpiWnkyN1dyMHF1QXFhdWhkS2pFNitTWGMxNWRPd2ErVkhpVmliSlB2aGZT?=
 =?utf-8?B?VE9FTE1kOWszTlh6UFk4WG43SDdGa2xIc0R2ZmN6YkJpSFMyLzk0ZU1PMTRU?=
 =?utf-8?B?MVIzUmowOWpyckc0NnNiNkVGTksrYWx6cit3RWZXclhYT1RUS0tSc2tXYUov?=
 =?utf-8?B?S0M2Mlk2dXBXWi8ra1RKaldObnJYQXFFTFA3a1VFRHFLSGJpcStwYmFNY2pp?=
 =?utf-8?B?aGdhNTUrSmkxZVdDNmJJTmhJL3dXQWVENFVoN2JQbnZzWFNocVFOZEhDTUdL?=
 =?utf-8?B?bld3WW9RT3FqOEQrOGNmNFUzQTJyQ0U4Q1dBRi96c0hPMURuTlpVaDg5bFpz?=
 =?utf-8?B?bEdWS1IyZ3paL21rVXBvMUJUTWtuTU1qc2Z2cVdGWU5idys1NHVtOVhabkNL?=
 =?utf-8?B?WDdxdWphd3JYeTJRcGdjVHBDYld5NzdRQ01sVnkvTnRNSGc0aWI1TnVBYmxj?=
 =?utf-8?B?aVN4OXIzQlY4a29FNGxlNlZkZ0lIVzRZWFRZRVRDamFLWGt0UUhGT0dzQWlO?=
 =?utf-8?B?dElGV0N3ejRCV2loSHJ3eGZaKzg4QmM3ZExXK1FwS0N0ZmZTSFZ0SHk0RU1s?=
 =?utf-8?B?SktQSVRHNVRXbzhFZ1BIMWgvWG9yeVlSVnJhNkxjaGpDeVVIR1phN0pjU2wr?=
 =?utf-8?B?bGd5cVVnSVd6MEQzbThuK3RsT3dSdFB1Qk4zT2Y1WnBvS3lmOTJLUmtvVmZa?=
 =?utf-8?B?R3pXRjFTcHZqR01xZDRFWVdub0NueHBxNGhkV3ozb2p2cFg3NnFGTW9wempp?=
 =?utf-8?B?bWpodFYxUjI3S0M3dEx5ZVF0eWg1TWc5VFRhM3BOZW1wSnpMcnhwaG5ESmpC?=
 =?utf-8?B?L1dBTjdISXJKUUpKWTV3TVl0VXVRODNYZzFvWWFISzZETVZJMm9ybXNLWTJF?=
 =?utf-8?B?Mkx3NmthbFZGVnZCZXVabXZ2Rks3b0RIUFVFNG9oUTBRUGRMem9FenNEMWFI?=
 =?utf-8?B?Yk1QZ0xzT3ZVZ3ZlalAxWVFPU2Jja1BDN1FYKzQyQ0tJRk9MODFOamNVaXhz?=
 =?utf-8?B?TTNOZ1RsR05EdGFpMjJYVHhEL0dxR2ppVEZvTDhNOFdaaHc1Y1A5ZVE5TWZW?=
 =?utf-8?B?S0JwejV4L2xQMHVBL0hMenR5cStIZ2phblVYc1A4dTdwSHhrTy8rbFp1VHY4?=
 =?utf-8?B?Q0JXZ1dNdDlQZExQTnZVR2RQV2wzeU9EVm15Z09obFlkVERUVExQa3VtZUd3?=
 =?utf-8?B?WW1BNGZWVUgrTzRPM204cmloWURLSEEySnN1blg1ZmdmcGluUzJCVmpmbVpI?=
 =?utf-8?B?OWNIYTZJUHJiSnljWXBjSHdVNG5neWRkMmF1SnBEOFM5dWV0UGhCaUJRN3hP?=
 =?utf-8?B?K1JJWDluSkk1VjNycGNBcWpoWUZpbW4vVHVVQmo5dFhUNWtYT0U2dHFicTZH?=
 =?utf-8?B?czJ6Y2hJOUhyd2JOc2FMZjJ3clh2alVuZk82b3prRk01Z010enZuK0F3SjNj?=
 =?utf-8?B?ZzB1OTV5TTNjVWZrZ0c5YzlSZ1FsZHkwdVhYWklycjF1ZWtqYmxyR01VTXV6?=
 =?utf-8?B?U1pDSDVvM3poZS9QdkFmeTB5Tm15Vm5EaXE4U0ovcnZoazlDTjBxSjk1RXll?=
 =?utf-8?B?NTk4ZFBFaXhHWFVOMWRYdzVtcGREeU1zZlJ0RC83cDU2UUdkNDBwQUdORGRC?=
 =?utf-8?B?VzBBRW9TN3BBQ3RkaUZscDZPckxVeHptaUVZWkJCcmxUTDkrZ2dZNzgyUnRX?=
 =?utf-8?B?Vkl1UFl1L01oemRCUVFVTUFWdXdXMVdGMWpjQ0RBbFZxalpqK0RpWjNhSUgr?=
 =?utf-8?B?Z09lZ2R2UnR3TEtYekNmM0lSSkh6SWV3SSt0Y0UwUGtKRTVJWERuOUEwNDdi?=
 =?utf-8?B?WTZsKzBraUpRRDVMMk5YTWpIRmUwUkR1L1RacTg5WXNuU0g4bzZPaFdSOFhx?=
 =?utf-8?B?WnBPM2diUWtGalNRSkl6ZFhrS04wU1RxNE1RU1ZsbEk4Yks2RkkxdFd4YTVM?=
 =?utf-8?B?dUl4eDVoR0xRQlc3dVdDVG9XVW9CS1QwV0xDeUdMdTJKaDZoWWdOYUY5WjRQ?=
 =?utf-8?B?REswR2FOMHU1WWdzQ0VYMnkzREdwWXduQUcxRXoyd1lvdUF1Q2x6TkM0bStr?=
 =?utf-8?Q?yVgo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f52b4dc-bbc6-406a-f164-08de1660e62a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:30:56.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BGTVlhed4Vy3cS5dxZQwob9jBR/BQ+SmWRwcVPE7M99IaJ/c+YEFuap23c7d+EnZW9skujoD1nygA2MrTrleA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

collect some missed qm patches.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (7):
      arm64: dts: imx8qm-mek: add state_100mhz and state_200mhz for usdhc
      arm64: dts: imx8qm-mek: assign double SD bus frequency for usdhc1
      arm64: dts: imx8qm-mek: add lpuart1 and bluetooth node
      arm64: dts: imx8qm: add label thermal_zones
      arm64: dts: imx8qm-mek: add pmic thermal-zones
      arm64: dts: imx8qm-mek: add usbotg1 and related nodes
      arm64: dts: imx8qm-mek: replace space with tab

Richard Zhu (1):
      arm64: dts: imx8qm-mek: add supports-clkreq property to PCIe M.2 port

 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 146 ++++++++++++++++++++++-----
 arch/arm64/boot/dts/freescale/imx8qm.dtsi    |   2 +-
 2 files changed, 122 insertions(+), 26 deletions(-)
---
base-commit: 15a86388f95bd819e102fcec2712d314e77ae4ac
change-id: 20251028-b4_qm_dts-456a09713a6c

Best regards,
--
Frank Li <Frank.Li@nxp.com>


