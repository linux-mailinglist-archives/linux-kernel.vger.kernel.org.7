Return-Path: <linux-kernel+bounces-856545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6632BE4730
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149FB3A2E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E79393DD8;
	Thu, 16 Oct 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QL/o+Ub6"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E81393DD0;
	Thu, 16 Oct 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630449; cv=fail; b=qJ/KfeZRUDkPWImZLWdDrV6ZEeshSLkctB8AHMoNsrUGnpeb2Zn1eNFynB4ITDuuEfXvlH7eyjNThJEg2J/+FVzVz9s0qA3AP/kubozEPGj9JV0newQ6/qIY7L4q/3EyytDLSaMnpac7T9gKMMvswzE2mbgcc8meJdqRfVFG/ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630449; c=relaxed/simple;
	bh=ZI5N2gtHlj4iGB7i24YmmkrzQSzg5zyBSQWLZ+uuJ8Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FC1rnvQeyNxd0a1GAbSTl8xAXThYp24pa5zxcMbO7Y4uQpudEvI0z6gAqmJD+W/eAW2w9PNyOSotwc5CZWqJ7OCbfUwpbbscsAWKKi7qi6CibuHu13EikdBy1ccOXXf3VVIkX66ttouH6GEqIUgTdNjQeYvYwLKK/WpRTgQriz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QL/o+Ub6; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zErZm7QWu57wNUNlVIsZSC8F3aq5EyeJdBnXJu7/DBefRtrY1P8s9uuWDJ9hs1SqFiIDouZigZqUKrWdIF8va8+HTQRl65FdTvn6lEbJ6qtQrqA725uClZCwvH5XQZmZJFtZyxfe+6RY0m34u3LvzP11Jd7ibVBIKt6OgcLNQwVnpewVEYrCSldCvQHricqT6yn3IAfo5w8+yWnLEwv7Uil70jV202Fk61DrnmJ8q8CkJYWi7AfuwJJx+AUMnav8CEKPJTTkw46vPXOZohbRekzcDwmeflqVN/Tgtsrs7dO8FiipLbmJ+mWiBqAqdP1OcPBZf6qYP1omi6Zyzm1hLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVjZKXtYEMXPpwKMkHyPAc97VaahRk7nq2h6Rro7gH8=;
 b=wFhsngMaIe6mcvsGdaIxaoMaTkC64BaisgWJLZH4UzkWHhX6V7ZK9jXFZB75MDP3h9gDRtQcBd7iI56covZ1eRA6lg+l6Ln+/WBVCTYxFo4Jp2+ijdOt9mtozuX3jr/oYhuXSN0FMNSJlocvWL+0fk2BVJCNfUAKdeivf40I5mQqgT+yI80UWwsDqAbt0LMwKL1EC+zZ1MEl8VdtjMwZnExToL0O4x3qJHJrZtbww6NSgru/uDbiicTuGD0INDoYPpPS4FFX7jzM/gtj1Kzmm/bec9WSpBNsIvkxAsJd7aSv1n/s3qwFTBsmb8EZZzQELEZPP7JfzzyPpRANYavo0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVjZKXtYEMXPpwKMkHyPAc97VaahRk7nq2h6Rro7gH8=;
 b=QL/o+Ub6y2ee6kEzQ33SMLpYhRd9cTd83/6yBHJwzySRV7oRP+UqnFKuCkmKOWnfZbvpPyCA90fbvqdMTtdD12Kf/QT4JxUR1QjasS1F741giqUo1L68F/39zYuLUCptU1tUoBZx0l/31VFL99DkMheA2H6cm1v0SgCXAP1O6fhqcDmepkDREKA9UkeCss/BmLqYrUGAKvpKKaUlrfut9N2IKUZI9uXe/qCv6o/Tz4B/IPgJNnf5TLTVVAwMM5WmhH8FYUU7y45Ri6YcfyOB4dKs8Ox3N9BJlipIdLZ+lqb2N0x3UzPDGLMk471TaOxXSUZa5pO8RSgt9FlOqyPRow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10069.eurprd04.prod.outlook.com (2603:10a6:150:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:00:45 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 16:00:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 16 Oct 2025 12:00:12 -0400
Subject: [PATCH v3 08/11] ARM: dts: imx6-tbs2910: rename ir_recv to
 ir-receiver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-imx6_dts_cleanup-v3-8-baf2814f8a15@nxp.com>
References: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
In-Reply-To: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760630414; l=954;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZI5N2gtHlj4iGB7i24YmmkrzQSzg5zyBSQWLZ+uuJ8Y=;
 b=YsosBiZevizKIDtd/0CnIFmdkm/6HdJEVKR5Qkykayo2N0uLlzUFRhLVXyVaYDasjFVQF8UT+
 ZjZvyaHWyv7A94xOhCpFPlnlvt1s/vN1SNC3hHGAJOTbYEl0XCqYye3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10069:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d14f81-b53f-4ee2-19d8-08de0ccd2a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVUveFZtb1BjK0FvSWh2dms4ZU5uazZOYnUrTk9aVVZTM3h3aDJzUjZUc290?=
 =?utf-8?B?cUsxZWllK1RmYyt0dzJvYnFSc3NKdWtIeW9OUFE1di9lUUtGaUhsT1hwMnRN?=
 =?utf-8?B?OFFGN3dHZnVBMDVHWE01ZTloTDVKM09FbFRWcENZVW9KZkU5YlIvTmhOVFA5?=
 =?utf-8?B?RnpKaDM4YVZYK25vblM0ZzlJMXNHdlA0cHBCcldOR1JLWFRLaDdXZGEvM0gw?=
 =?utf-8?B?cWpicldEa09td0NCZUZsM2kwOFRxaTNDdXlSc0ErOUpGVVBscy84MDZtTkd0?=
 =?utf-8?B?ekxGUFRHOTQwMjZJOXZIZldnSlFOVHpBV1dKamo0L2N0elRTaGM0alhPZldM?=
 =?utf-8?B?d1gybThqVDdwN1VNOHJFVnZsTjI2L3BRY0g3TGpWdmVpZnVuNzBtY3pmT08v?=
 =?utf-8?B?RFlqUzBqeVZyeFMrR1Z0MVI1a0RuZmdXRjc1c0pCSmNhQVNuTTFQajdkSUFH?=
 =?utf-8?B?Q25RdFArU2hVaDMvWmtsTUt0cklPOGI2UVVMRzJpMUhWaWFJWDR6bk84OUJG?=
 =?utf-8?B?Qy9LSnR4TlUwbHB3bWNFWmc3TzY4dVlmWDg2dXA2NHg5L3VJYmJSaE9UMjB3?=
 =?utf-8?B?SUUrU1ZKeWRyOWszb2J4RG9CUHBFb0ZvbUtlY2FiSnNUaFdOV0ZQUkhUck1V?=
 =?utf-8?B?YXFaQ0U3SkxrNVA5dlVxSGNpdS8wcUZGMjVvQkVrYXRkY2p2ZnRYdDRpTWFw?=
 =?utf-8?B?ay9zTlBqUWVodmRkMlRKM0JPbTMrcERPZHdIWThSN0IzK2hmR2k5WSs5VjJJ?=
 =?utf-8?B?dWlKWklqY0FoUWpmVXBqakViWWFTUzdjTHRWZThHenVhckNMYm84QVM0aHdD?=
 =?utf-8?B?ZW82TG5ydnhDNklDZDl3c3RTMi9oSm96NjJvVXBMcEswNTFzVWpEOUJqV1ZR?=
 =?utf-8?B?MFBVcEswZVRlRjRUZzZsbFZkV3k2NDErdk43Z2d6NHpnNUY5dmFUVmlPSFUz?=
 =?utf-8?B?QXQ1dXhVWTNhbUliRDY5RUNRODdHblgwZys3OXd6T3NMaDZRSS9HcjI0dzBq?=
 =?utf-8?B?K0R4ckZXc2trRURobnhhNVcrL25ueCtxc1hVOGcvUTBaRjc3YlFRL2x1WEkv?=
 =?utf-8?B?RDBHNzI5bGNncHhSMmFlVjVCWFY4NUhZcDNkSTY5RFdsZHU1WkI0Z1FYMkdu?=
 =?utf-8?B?L1ZVSVJyU2ZUVkpJOHlzc0VxM2dnTjYwamgyR3l4QndKRTlDQm5saWJ3cGNu?=
 =?utf-8?B?Y0h6NUFJM3N1QmJUdG5HVjBBWDBaakpVZTlPQ0xQaXdnMlEwV0xCRHptY29n?=
 =?utf-8?B?OXBiWHJsN2g4bW1tblE2QURnMW1CVUhRcnQ2Q3FRbmFVa0tTZWdBZUdBVXBr?=
 =?utf-8?B?eHVjNmVqbEd3WTE2d3kxVHo0dmppRi9iTW4xTlpkTWhXa3JORXQ2OVFUYTdq?=
 =?utf-8?B?UHBwbDEwdFB2OGZ5RlU3UGNVaTFGSFVxSWgrZkpFZmZSMUFnWTUyYW1neHBC?=
 =?utf-8?B?NU1tTmdHemk5RzNkdEdQMCtzWVdNS3Uyc09hN20rVXgvUEl0eUM3bmpJR0dt?=
 =?utf-8?B?V1RCSzRJODJNS05YR2FEMkVGb2JOcFVnTFE5THQ0K0hNWjVWRmtSOVdnN21j?=
 =?utf-8?B?L25yTDBWOTU4c2NtZm1CeE04VEZFcm5XVml6QkhRdVhvZ2ZOaloxLzFoRE5J?=
 =?utf-8?B?LzJ0T05XamxyRjYwY01tQjAxYWVNbVBXK1F1eENoL0ZPQWs0WU0vYnN0clRv?=
 =?utf-8?B?OFRWQld0QVlJMUNzUjZaN0NXVEg0Zi9BRWxmSEwrZnBJbnNnZFd0d2xoaEFY?=
 =?utf-8?B?enB6YjRvQ0lUaFpvYjJBRDNTMFhhZDZWeDZwZEs4WFBFRGlnKzJsdkhuMnNJ?=
 =?utf-8?B?WHFLaHBtUHBPR0cwS25iZmp2VkhCcWl6WEpQRFV4UXdTM0JOanRTaWVKUU43?=
 =?utf-8?B?NFNxeEZYazZza1BrQlJyeGtneWR4OEx2NlJrekdBNFIvd3YxQlFkOEVDaElY?=
 =?utf-8?B?OXdzVGF6bWEyWlM4SDhtTzI3dGUvNVoxSzJBNjJma2RMNDRTMVRUUHFaSW1r?=
 =?utf-8?B?S0E3Y1NZMldRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djBYc2FGNW9HaGtoZ0owR0pyai93bHhvc213ZkxhR1g5OVJDVjd1Qm5jWEpI?=
 =?utf-8?B?YzkvY1AzWExGSW05RjY5UVdoT2IrY29kcEFseW1LSXRrenZRbjM1c0J5VXlW?=
 =?utf-8?B?M2dtcy95ZnkyN2lLNFhySmxMbmozYk1OMFdEN2hNR1l6eERlTzdpTU1rWkV4?=
 =?utf-8?B?NlVrcVlZaGExUTlHMHBOMXZDdHMxRWd1VUp0RkgyUlRaRE55YUlxUUtHbTVW?=
 =?utf-8?B?V0NGakVxSUMrb3UwUkJ1MUlhcEZ6TE50QTEvZjAxeWd5QnA3UmZCOG9KVVFl?=
 =?utf-8?B?alVpeUFlU0ZVT3NEaWpqN2t2cG82cCtRSHdtUVE4YnVkUVN3SXZmWkdkblE4?=
 =?utf-8?B?NGpaQ2ppT1lPWEpjVHJSQktSM3FwSzBjbFk0OE1HZXhoUWJhaE84Uk9YbGVx?=
 =?utf-8?B?ZUZpblN6WVVBVW5qMUc2SlpqSkExR3ZVSjF1c3poNkJiRFd3RXFCV2daMlN0?=
 =?utf-8?B?c2RkdWs2T0MvWk5zaW9wNXN4dGNrb0ZrNlNWTDhXbW5EK1BWQkJQWEVYbVE3?=
 =?utf-8?B?QVhtQkVhbnpib0pCbkRaUFZGWDk2SjF4dFlqVUlUaGovOGN6bmZpMW9ZeTFH?=
 =?utf-8?B?YTBBWXFlK0RKK1k5TlFyU05raTVkNWZhRkppb2hPcnJnUi8wdUxrcjN6a0Ex?=
 =?utf-8?B?WGRJNGhGbjVrUC90WXB5UnpIY1RuVDdMcjlCNkwyelVTSStobHE3WWZXdkJw?=
 =?utf-8?B?YVM4ZzYwcmxPQ0M0K0c2bDRBbWF3UjViTUkzLzlTN082YmJWNVN0WmpSR3NK?=
 =?utf-8?B?UTQ2eFBFWHY5MDJOcStSNHZYMmFzbW1OR1F2WFBHYXU4Z0hRN2pOb3p4R1M1?=
 =?utf-8?B?dE5JM1AvRkwrMlh3d1A4RGhDRWFhRXZDTlRIcXdmalRWQVBGN0xwZmxucE5t?=
 =?utf-8?B?SWV2dlNVd3BEQWxKM25WVUNXOGdUMUhjVGtYanhLczUzbTIyRjM0VnJBeGE3?=
 =?utf-8?B?Zzh6RHVJNm5IT0NrdUdnNDZvMml0U2p0aU95MTUvZW5aU0JMQjg2bWwwcW9v?=
 =?utf-8?B?MTZ2TjJDNTNVb0c2SFFPNDhxdzBwRGlES3VYS05zck0wcWx4ZlN1cGMwN3ZF?=
 =?utf-8?B?TSs1SHpBc3JaaVpraEt5ZWFXc04yK2lpUWJTVnZMWk0vc1dlU2s4MjJhdS9q?=
 =?utf-8?B?NnNTc21EcVFya3FBR2pYdTV3OFVjTWJFVVlsb1JrYTJlS3piakxkTGVIb0pT?=
 =?utf-8?B?d0VNcERHS0x5dzhPcTNRTTNxOW95Ymw4UnhINSt6TEVBYWo4QXVKUkgydEtX?=
 =?utf-8?B?YzJCK2RveXpnRjdncFdzKytEU3pzNVhhdnRiYWo0cXhqdVdGb3hwdjloRXRp?=
 =?utf-8?B?cWVaTVJFanVZN2FxSlpNUjFXMzJGYm5tWXJway9RMzA2bkozL1l2OHVZZ1dD?=
 =?utf-8?B?ZW1pTUIzSEFJY2Z4Vm4vWERHZDYvSkVOa1E5cW0ycklXZGFUaFI4LzkrQXVx?=
 =?utf-8?B?SXl1ME9wVlF4Z0FGdUdTNWN6Uk1aRnBZeXFrRWM4NSs1K1dSdEJ2SGdOWnN3?=
 =?utf-8?B?WEpwK0Rhc3lLTG9MKzkrdnVFV1UrV3dpZ3FPS1J0Q3U4YjFhaUJ0czVWQ2t3?=
 =?utf-8?B?MnplcjFBd3Rxb0ZJVHp0Zit6Y2NRTzdnM1RWbVFrcHg1aHo0RGJEclpEakp5?=
 =?utf-8?B?MkFNWWFMV3d2bmE2ZGkybWp2a0E0N0FBSWVmNFVaY2RJckw1VnUza1RLYjBq?=
 =?utf-8?B?Z3NGdFVIZTVSZWdiNHp3ZGN0U3duR1VnaDZDTm9kQm5pYmVnZ05lcml4TXgy?=
 =?utf-8?B?RHNFZXVRWUJ5Q2ova1N3Uk5ORFk4Q2lvYktjeDZTTHRsUXJKRnBWWHpPQ0VV?=
 =?utf-8?B?L09IMCtTN2QzQlg1bUJNcU56OFVlS2lkU0NIS0phQW92cHF4N1dvQUVEeWdl?=
 =?utf-8?B?dXJVQjg3OWdmNUYwbGdscVVudmlpalRnTDRvcWNzczhkSXpxekJhNldvc05Z?=
 =?utf-8?B?eDllaWZpaXJVczJEM3pMUEhMTmZtc0xpUUQwZHkyb3ZDcFlrTm9uK2d6V3ZK?=
 =?utf-8?B?WHlHVDB4UWw3djFlN3Rib1hQQ0RZdE16b00rb1BWTnBSbncrVjA5bU5xUFlP?=
 =?utf-8?B?bDRiSkY2SHFMc3RzVndlZmlqYW43NDRYOURFYUpraGErWU9OTFlCUWQ3ZmRm?=
 =?utf-8?Q?pbVFT2eAE4ncPWSbxqKeN6Ajh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d14f81-b53f-4ee2-19d8-08de0ccd2a93
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:00:45.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eD1vVcymE//xF0yee34aui3mJ2GLpcTVN7mVV3op1CxZBM9FMlBuhmGSM9hbGXscupuqOFuPa3llQBW4IzP/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10069

Rename ir_recv to ir-receiver to fix below CHECK_DTBS warnings:
arm/boot/dts/nxp/imx/imx6q-tbs2910.dtb: ir_recv (gpio-ir-receiver): $nodename:0: 'ir_recv' does not match '^ir(-receiver)?(@[a-f0-9]+)?$'
        from schema $id: http://devicetree.org/schemas/media/gpio-ir-receiver.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts b/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
index 5353a0c24420504470b8b095eb7506e7713319c2..3bd0e2c9e57acaa8e491d01ba029c60531181aff 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
@@ -37,7 +37,7 @@ fan {
 				      3000 1>;
 	};
 
-	ir_recv {
+	ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio3 18 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";

-- 
2.34.1


