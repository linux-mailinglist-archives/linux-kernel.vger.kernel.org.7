Return-Path: <linux-kernel+bounces-770560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0AB27C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F882B0072E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1899A2D8DA1;
	Fri, 15 Aug 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RAMq9/P/"
Received: from outbound.mail.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AA82D7392;
	Fri, 15 Aug 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248708; cv=fail; b=RORIGgTbtDqRqCZtv2/NowX1DMDWwSymAIVUK/I5kpNwwVKtlLyn8+uJFnoYodio3Fo+uEuQZ/K3DxaQC4i4ExUW/t+1DRlMUffEyDtMqW0MMtNYyE+jHbc72aFXw9L7CPpGKjg5nq5gFis1b3i4wSc+UY0afkj0qc2P9I3bLnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248708; c=relaxed/simple;
	bh=aI3SKZu8KGHMJkE+6wQsCnBavlp74rp9LYlQ/eebbtU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g4clE9HNqdUib1lrktJpV64Lij40EPI50cPQjpasuxtZi4ZgyEJ/iWDUiGJ6vEGjd+d74vj4N/+YAy7M96aOYCmclHR/oXxiBIOfaR2gGEWDl4xWxXEbeYdgDq44+9yUsO+wsABa+KHZMynQun0QgJG5XtZtdoorm51625c4qOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RAMq9/P/; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7yqlUTZUIMvmy/dQWOrgZ9kaKFVlcDifG6vFPqdrwSHz0v1llXSg4+FksxrozhSA5bME75IvfjZNddnO2Bx3DWxGatFy7pyJ5FCRjm1ioZKRRus5gCJcI8krPk192b1gxrbHmWnIpchckW5+vrZrC4k9PP/DVnMqLBCoO9xB1suB3usE3TrWIZVQ0NqHhGBdGlRYWCLBwCVC0TPO30cDTw9QYKQnllYA+4miVjWDaDtmZZtww+mNA3phLDYb7FTxDyY0RXUvYNfMTXqyV3qfskO9nvu3N/p33UdCOyev+HmtzxTJDmbRF3osb7eCaXXfbkSsioHpkho4Y7HTjvb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksXcUyqxmcT2l/7DBjLjqvkTnTBILWQCm4dRYY652Z4=;
 b=R9dih0iatOwOxucWmLo06Hi+C4IqgtC0jBzclK1kBbzWj1uzSUEfLNxKiiiKynHqdxe1ekLWH8BtsgfxirPMC3T+YKP1SIcLJITSRmZT0akqsc/ODWeRo1uR4xOqqmL/puD3FhwkWAGGXHnxMvZggr8r+rXwb0PLQJ7GSEoHElGKSywMIA6udH3s5Tn7DRKsCn8NfFLN7B9vTd+mjE0lKue9aDrj3Qv8bo5jWKgu25+T0AT5nVYMD//GMJs5EgM7/J8iy4FiGaQvVzKGN2BCjZp1htGedDts5O+gQms8QKhweRROsRLjdMU9wv6BPcVF1QSi6QzHdtto3c3ccHLd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksXcUyqxmcT2l/7DBjLjqvkTnTBILWQCm4dRYY652Z4=;
 b=RAMq9/P/07vpekTvyE9Nbo0/3jGxCr1i8SMBBTEQw1ZE6pMrwPPADqhmaX6+W+OamfuIPuZREJYzqGPlMoULws1yKcaLz4YPL6ugW9FsXXYk+WqaPUYA6RxfNAyKzvtPj68g+wJEsIvVco1ZTtj0bwybRQ2CyxyKI5TbsTILpy1L+g58XaPy1iS20vy9R62+n3AFTqZNM5M9OYxU+ot8EcDNMefID4ZkWQc9X56VMCjULzMd+tYThH1jpNCYDtIqOHG22iM0CKyRYQtfkRSRMe2sa3fadgK5mhGRjaWkLNKFMysXhKHvch5k9hcOxPrIbSe+Rm7CRBNsvaiQg7IU9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8014.eurprd04.prod.outlook.com (2603:10a6:102:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 09:05:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:05:03 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 15 Aug 2025 17:03:56 +0800
Subject: [PATCH 10/13] arm64: dts: imx95-19x19-evk: Add pca9632 node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250815-imx9-dts-v1-10-e609eb4e3105@nxp.com>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
In-Reply-To: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248657; l=947;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=aI3SKZu8KGHMJkE+6wQsCnBavlp74rp9LYlQ/eebbtU=;
 b=C8/BPWCoa79uFjMLaOenOH8COZI7niKNOBm4820OaaHV2xwuLyUbYp242e0NTkkEpmuFcsb3s
 vsnWM3D32aYAWiJyHG56U2igyNoj6T4KwMdcVOsBY389fd6V8xHI0zZ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 881124f4-4844-4bc3-270e-08dddbdad288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWt5L2VjVEFSMGdoN3ZxVkNVVFBSUmRIaHd2bDhKaGFIMEFjUjJqY3VkeHJr?=
 =?utf-8?B?SDdrOUdpQTRpemRncWg0Z2tlN3NCQStCTmg4bU9MNVB2c0ExeG5MaWVia2Q1?=
 =?utf-8?B?NFhPSkppN2tXTnZISUs0alh1QlFqb3MwMEkyQnQxYzF5aVZFNXhXZGJqeExO?=
 =?utf-8?B?RUNKeDdKWHNJdHliT0EwclBrTDBNSjRDZkxDbFFCOStiYzB3Vi8xTyszQVFP?=
 =?utf-8?B?SGZ6U2dqUFFvVlhLd05XbUZrY1lKLzNxVllRK0dIUjNzaUVQQmVCeEkybGhn?=
 =?utf-8?B?ZkpKRjh4YWdISXdxRGxxOHFvSW9laW0xUUlwMDZVVHkyOGZlM1NXVUYwL3I3?=
 =?utf-8?B?L2V3RitqQ205ZENSakt4eFZ3N00xdmh1dFlROGlpSjIvN2FtN1lnVE5iTGlN?=
 =?utf-8?B?KzNmNWR1UVZaT25JY2M3WGdDbVZ6bUNUNHZmMEkxMGVHNml6YVNBQVdMbmFZ?=
 =?utf-8?B?ZlJFaXhiSHU4dFA2Z2ZXRkdFR0VpM0Vja3dBejMwZFZpN25XblIzcnZBT2ZX?=
 =?utf-8?B?OTlGMnhQb1JGeUtHMU1lL2tRQTlaL2x0MlFMWHNvcyt2Sk1yOVJUV1pQWWN2?=
 =?utf-8?B?OHBJTG9ta0dWQnhKU0grQS96Q0JUYXpyOVlIdHBBYXY5MldoT3VTakJZUTR3?=
 =?utf-8?B?eGFmZlVmUlVycEEralIyYUxQWjZrWVFLMWFFVE90blNmbFJ5dVVDT1lHTW9I?=
 =?utf-8?B?OUg5T2NYRmsrM0xha0FoUXFSYi91RkQ1WFkyMkpjVE5maU02bGl2YnU3OU9s?=
 =?utf-8?B?SUs0QXhZYU56a1ZZNDdTLzJGeW5kUXBOV21IdUtIL0QwcnFBSTQxa1FTUlhm?=
 =?utf-8?B?ZFBRMjhidHJ4Mi9UWUdjLy9PVW0wNGpOY0xIUWdpZHg2S0VQNWhwNWUvemhn?=
 =?utf-8?B?L2gzV3hVbmdYWjlnZnVmT2FpbllJUS84S0Irdm56N0lNRWdIOFE4am1ScEw2?=
 =?utf-8?B?UVdoNEpSZklCOU1hODBKUlo1L3oyWURnc0JYYUVUU2ErWmJtNnUwMGk1ZFdv?=
 =?utf-8?B?RkthcFd4OWxqQVFsdXkyK0NUY3pUUG1sTWR1T2VGY2lQbGZOaFgxNW1tQk1F?=
 =?utf-8?B?QnZrWlBLSm1OS0Q5eWkrencyN0VsMDdYTWNVRTE0UFIyMU5WT3kxd1FuTHpn?=
 =?utf-8?B?bXdHMzdrR21oVUR6RWVEc3A4Y05jWUh5eTR5T2IySk5DNVd3VzZoUzYrRWsr?=
 =?utf-8?B?QXNTWWdtMkVpY0Y2SmpxNkVSZmEyYXlFeks3ZG51NTBITTEyVm9lQlBlUFl6?=
 =?utf-8?B?TFB0cmppclNnWmpNTnJGK3JVWkIvSTBlczQ5dmtkbWIybkVkZGJTOWd0SWh5?=
 =?utf-8?B?KzFlMWE4TWUxMVAyb0JyQzBKaFVrYkFicjkyb2NMdjJOa3lHOHJMVmxURm9s?=
 =?utf-8?B?bG4rYlFYa2FlNXFrYUpGLzJ2WjZ4L216Vy83OGVoVWxyLzVUZ2gyV1JlUXF2?=
 =?utf-8?B?WDdaSTVBUGpQNi9oRkk1WEl0dDBoMHg2aEtPUkZuS2VMVjA4TGRJdE5UYkFY?=
 =?utf-8?B?azNoSzZNT2lxZGo5M0lHQWw5YWVzOEk2UFlqYjBRVEV2QjE1T0JTMnBLWkh1?=
 =?utf-8?B?QkFiS0xkT1FhdmVncEk0NEFVZXRqbndYQ2d5clFyMjJZVThSaXFPQVkxMXdw?=
 =?utf-8?B?SVdYSjBsd1ZHeCtTRUd4VW1WRW9jKzA2RGx6c0VWTDFscEVWQWhIRWFqNVFw?=
 =?utf-8?B?aWowbnlCdTUzeTdwSU13VjV2T1R1Sm8wKy8ySGtxay9jNkttbnllTkhUbHlj?=
 =?utf-8?B?U25WRDB6NytKbFVEd2hJVDJDeWdNMjRoTTJ0L2JRTDRZTWRBeTRjeGhYNHlw?=
 =?utf-8?B?S0hVOUtHN29hM3BCK2JJZFJkVGlEakUrbUpZRmFUYTNMTnAxYWlFOWU5TkFo?=
 =?utf-8?B?bnFqbUNNUk9PMlNHbWlwTmZKR3BsZFdEY1FGNm9VVW1nOFZBcWJIdUZKYllQ?=
 =?utf-8?B?QkpEdGJRMUFsZFphM2FPWkNQMWYza1kvVUR0M1J6ZlJaQnJoTXhkQ2ZJSTdZ?=
 =?utf-8?B?SEtwLzJlSzZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alZEQUwyVXFlN3BrTlRwSHlUdjVUbGRwTW55OFlQYk9udTZEVmxnRTFRZG1k?=
 =?utf-8?B?RFZjTzQzVlZ5Vy9IRU80bzBuN1liWXNXNzBRVXRQdnE2QVRheWN2L24rSFR2?=
 =?utf-8?B?bXNYaVVZWWthcWpnUFVzSTFsZ2t5RnN5K20vMnpCQVdhN2UrQWpQQmJiWUZm?=
 =?utf-8?B?Y1psSEdRaDNCMGdTZ3BjZHVSam5rMGl5djBSNWQvRHc0bWk2akxlVFZzclAx?=
 =?utf-8?B?UEtKeW1FZWNvOUY2aGU5UjJtS0JqYU04U2kxaUpmR3dMYndVa292UE1Zd08z?=
 =?utf-8?B?SURZbDZMMElQV0wxMVF6V2owaGgxTTB1Z3hyby8rK1plRThIUWRpbW9GU0p2?=
 =?utf-8?B?RmJtZVJzWkJ3YnA1bVlUZzAvZW40L2ErK2E5bjFLQTk0ZjNHVWRXTlhic2xO?=
 =?utf-8?B?eE5JWnhVd0xnNHNTYmtGREZ4SmxVbWtjbDBwdzFPb3lzWWNHSStoYkpHeWFC?=
 =?utf-8?B?b1dQU3VDZFhGVCtJRCt3eXYwT2srTTFFWEROVXBwY0FTWmhIUjFud3Q0SW43?=
 =?utf-8?B?aUpqM2d5UXQ0dWVEMktuT0ZGaGkrQ0pGZ0dRWk5ZSnBxWU1td3gxUEVMZDZF?=
 =?utf-8?B?bTBrVDZRbnRyN3BIQ0o1K3M1THB0alhxbEozSkFZdmZjakk2WEdQaUptQ2pt?=
 =?utf-8?B?ZFNqUS9QUGhjdXA0ZkZ6UzVLUGFzMndadE9MVngvRmFRZkZudUxlOXNRZ1I4?=
 =?utf-8?B?czJCQXIwbjZMRUh4YTZTdUpGcjNnTnJkTFRuR2w0azlkOEJTdnpRZWlDaTRE?=
 =?utf-8?B?NXJ3NExEdXpZQ3V2RnVUQzhjL0xEZ2ZSbEpsOCsvRXFGRVhXV1BOdU5qNmpo?=
 =?utf-8?B?cEJ3QXFET1dxZFlDOFZxQXE4ZDNhaTlHNmhJa3ZCOHd2MjZucXlsajBwWWwr?=
 =?utf-8?B?OFFmQnQxSFgxdnFUTnZSZCtBck53YnJqVHIvWFREUmlZR1NrdDZ0UlgwdFRB?=
 =?utf-8?B?SkFySjhoeHVMZkI4czR0bU5ZY3J3Y0h4aWtuN0YzWXNBS0ZuemhkUkx2a3oz?=
 =?utf-8?B?dXVzeUFEVHhuYk1JNlJ3OEdjMmVVOStHUUNEV3RBN0lDeDBlOGVMVDN2enl6?=
 =?utf-8?B?Qk1NUzZSZ2RUK3JscTMxNVFTMHl6elRMQVBhVWx3QU5mWGZCc2JySENCUndu?=
 =?utf-8?B?SDZwUUJpcGNQTmoybkRZMk0xckE0ZzU3cE9tZWxkellkQkJFSHcyZGFXdzJQ?=
 =?utf-8?B?THRtV3oxRmxKQWJZZmlVNkxlUUR3bDArQkVsWnQxakptbVd2b1RrOWsydEtI?=
 =?utf-8?B?MFMyeHh2S0VzNDk1SXFNUlU0bTZpbkZ0RjhIeFlEbU4zbldNWldub25GQzFJ?=
 =?utf-8?B?cnFGZXRweTFGNWZrdjVKUWUzYW9uTXduZUt1eCt1d2w0SzhNc1Y5UDFDNExI?=
 =?utf-8?B?ZS9RNTVWZUsxVDV2ekxFMWwwR3dqWmZXVk82dnJ0MmNQZzFCbWNkVnZFaStl?=
 =?utf-8?B?cVRCZmVCOFAzVU1xUW91elRCVVdTejh4NDRYSzM3Sm9UNEsxRmt4R3NaazFY?=
 =?utf-8?B?OXF3SmZBRWZoZS91cW1xYlZTaFBzWHJ6Wm1ITnA0QS9NcXFnMFJxdGF0SzU0?=
 =?utf-8?B?aFZqRml2L1BSMUNxcEZlVHZNQUpML3dJZ2tkdmROa1YxN2g0c1dSU3JVYnR0?=
 =?utf-8?B?d0RCVEIrb1ZRYkNHa0lnam5GVUtSaUpvb2wzVDk3OFQ0NDNvZ09JTnNFdmhF?=
 =?utf-8?B?MFgzK2RreU1peVJsZkhreXFDTTg3c25uNXVjTFd5Mnh2enpTZXZNR3ZKQ2o5?=
 =?utf-8?B?TEJuTmdrbms1WE5BTnlsdUNiWVJvRTNaT256VkVvakxTRmQ0MENTcXR5Uk90?=
 =?utf-8?B?YVFiQ1czei96QXJod2ZVblJaRjQvdHRTUUJmQmRPbWttbW1IRkxQUndpUTlG?=
 =?utf-8?B?aVp4ZHJnL0dtYmtNT3pMVzNrT3VuZldpUXp5dWx5NVZ2eGl4VnVPeWRteEVu?=
 =?utf-8?B?aTdKT1lITnpSVGNnNkZ6NGpjSHUvZHVwV3U0MWhNVi8wT0Fhb3k4RVkyTERr?=
 =?utf-8?B?eGpmaUkzWDJxaFNMb1R2RHJuczFIa3hJZTlOdzhNSkxYOTNqL2lVanNjOXRQ?=
 =?utf-8?B?RCtRZEd1Q3k4bjRBdGFmaVNxUVplc25VY2V1bHpHRm1iNHBWUU1JbEoxWVRR?=
 =?utf-8?Q?7ZY7I8zyC19Mt0zjzrp8pTsfo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881124f4-4844-4bc3-270e-08dddbdad288
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:05:03.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gRsxN/EWm2uXDkwGzb0ZSFKJV9KP9/WWv7GRB6qZGzLYyVcQP9mseVmkwsZN+c1agl/pB6OjQ2Rvbm1WNVavA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014

Add an I²C-bus controlled 4-bit LED driver PCA9632 under lpi2c3.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 82e183dc581012a7c5be3d2bf749463d0a8a360d..c35a5083c837379804e07f98163c0a5d4301abd7 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -329,6 +329,19 @@ i2c3_gpio_expander_20: gpio@20 {
 		reg = <0x20>;
 		vcc-supply = <&reg_3p3v>;
 	};
+
+	pca9632: pca9632@62 {
+		compatible = "nxp,pca9632";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x62>;
+
+		led_baclklight: led@0 {
+			label = "backlight";
+			reg = <0>;
+			linux,default-trigger = "none";
+		};
+	};
 };
 
 &lpi2c4 {

-- 
2.37.1


