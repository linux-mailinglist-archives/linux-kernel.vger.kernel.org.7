Return-Path: <linux-kernel+bounces-772688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A692EB2962A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B9E1688F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3118F2264B6;
	Mon, 18 Aug 2025 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F0nzvkZL"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1D223DD1;
	Mon, 18 Aug 2025 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480370; cv=fail; b=Dxjvu+Lda2BmMaBNRM08zVV7L5P11UAO8Y5amWYWZcJirQ295X6K2rMvjwMg6rsHQF8ELqrLqXEKXip9ID/zUh/N9eB6TcHy3yP37SIqnIAajZyBHKf7t1AFM/fAdtBbqsOz5q7bUoW4zK7tV/MJyLUE/+iDV59UPvioml1X2Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480370; c=relaxed/simple;
	bh=dDzTc403AapxL3ZZMuYpNvgS9saSJTK4lO6F87vsZDI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l3DOSC4gTM7maMOabn7ID1+r3GTpvhVauYB1hhi3T8fC9XPpgAU31ds5mbNoBRWgtVEN20tszPy9O0kJfiMRsbgBDWAgZiwI5XEMq4oe4eOflxQVZDmf6F4bz542KyoOmba0dLERrvAUjwPJbLX5bF2UMAnf/3XOcswph9qExdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F0nzvkZL; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2zVdvmRjX1WYzHLvrNHV7pSyxa4U5N67gpMn9Ru7sSSMyMAQnFrWWqVb8NuySMvEmD5It3htYKQQoim4kv8xeU4mkKPH7tw10E9qOK4oYQ2kuPwcGWpVJVQIpPHgqx1usJnV5A3OlaoGGIAuE2HkWEGQRFp7ZP3J6fcJ/5UPMOIo5nMY0Tyc1cvBMUDw696LOH55yUG+m0lDfGes1/DxwHaASIBR36h21h2Xr7G6PlUvvYg83NQkvsHTODCrk1d75jnYDDPI/S4J6sQlS1dwQ15akzDIAANaFE5HYKeSe/cguVPehivmX+7ls+EGfkzFZACnH/CXcVwtoJfngTUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lBRygBm+rVPz2fFiJ0k4hsaiyByjPucA7fslwHbeaQ=;
 b=hVMjxnkAN2eNanF4k9dMInQHWK7z5yVrfxPSyRA7TPHe+jwpCXM1CxdUk5MLcowcGUoR2r9jVACLSMWFuzFJLpQe7z7lN6+4wtjEXiMpZkvJMFcGqMEB+du5L1OHgNx3E3MYW2ghcZJoJFB9t/jVe0+/wqTGcXph1MYaS2pCpcOpt+0ntwEbW0Nj1tKCrvvpL+kKqm+ZqbavuIWXiK4Pokel19nLrs90giW6OnWESE13TbT8a2RU8z44By56jIERfSmo0RgF4Ey1IzIneE9a2LNy0Yetv3rp50e3Htpo0353o6oIUVUuiwtwyoAYU4ZaoQx30r1dflm3wdb4zODL7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lBRygBm+rVPz2fFiJ0k4hsaiyByjPucA7fslwHbeaQ=;
 b=F0nzvkZL0UDnakPOCgP3NwN1QXxcku/9JzmlRjfFWL12Ts+cdrDSAkKYewuLnKlGBqawndPnuJ4tx8il4vyyI9Bv/M/rFKP1Q95mXXDQAW/qcSeBneYxykIy4EpnI4NzqUz35kvuSxCaKqvvwAz98PWgboNjoYcd4VOEVxMQ8e0fg94MLAaV6A8304XL9ktF7q1CuUfeVTqMjjNv49m9TgAQL3N0m97tBEwx6WRoluRHvaVYqiXgNOjVI0iSoNcXJXyDasVXPKg1YAefnKSpToPx8E0y0s884OSfwTL2N9ZyMXdrsEth5sLgwkF+SIRMTcrIte24g7dCGnK5jBbeTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 01:26:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 01:26:05 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 18 Aug 2025 09:25:34 +0800
Subject: [PATCH v2 04/11] arm64: dts: imx95: Add more V2X MUs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx9-dts-v2-4-8ba787fb5280@nxp.com>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
In-Reply-To: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755480343; l=1454;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=dDzTc403AapxL3ZZMuYpNvgS9saSJTK4lO6F87vsZDI=;
 b=EI3ek/8h1M8kR/S/Rz91zklo70qV0+YNybD1t6K7ojMnEja5UtpUeTcFQyyS2d85s9vdZUKDn
 s0saqUWtvjiBNm3ABhbr8RKYRwGii1Ef+saY2YJ5kXGP5ohjvcTjP//
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MAXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd650bf-2d84-482b-209d-08ddddf633b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHk4c1NJY3ZNeTRaeWMyaWdZTjlWQ0NiTi80c0dzdllhT0FSTSt6MkdSS1NZ?=
 =?utf-8?B?NFlHWkRFTHNsMk9LdFY5YXlTTVhHdUQ2Z1k0UnQvVTNDTlFEcXg4aHVtdnBw?=
 =?utf-8?B?TGFUZndUbmFZeVNjNUN5TDFqb1ludXJVaFlWNkpHUkRzQXhuTnhrcUIzZlhz?=
 =?utf-8?B?eUs2ZUpXNHArTmpqKytMS1c4WWtEWGVhb3JHWlBLUkd1Y29EbVdTeW5sK2xE?=
 =?utf-8?B?d0E0RmRVMGdsa1hsWDFqd0VsQitQbHZZN3NOWUFHUjRoSzc2ODNmWFRtTkMz?=
 =?utf-8?B?d3UyYXZQbElhTU9EUURSU2lTdlJxWWZiNjlwd1d2Y3dDY2dQeTdjMDhlc0hT?=
 =?utf-8?B?VEhpZjNzQ2RXWlRsU2YvV0xoc0hSMjAwWFF3NW5KSEgzeXBuTmh1cC84Q3BI?=
 =?utf-8?B?dHhxeDliWGtrcHZyc0FhcmZzRXR0M0dlRG1JdjVIOGhMeDdGZXlFdUhMZzdr?=
 =?utf-8?B?dk1jaGM0N1FBOXQ4RHR5RVpWbEM2cFVvRmZycUQ3b3M2ZURpZkdOL0dBOEx4?=
 =?utf-8?B?T3RLZ3ozSzJiaFNvVXI0NGF4bERtVDZmM0ozeExCSFdMTzJYRjNBc3U5TjAv?=
 =?utf-8?B?U3NiWmwvNDhhc0lFZDlvOXRhMmZETE5HQVVqNnhQcUNUNEpLK21nZzBEd3p0?=
 =?utf-8?B?ZmJUOGpubUNXdXdPekRqRlFHZXI4aUlOMTNnN0FPWGRaOU8vNnlnTXFGYkR6?=
 =?utf-8?B?OEowNjZ5UHhCSzgvTkhNMVFiaDVsdy9zQ0J3VldzZ0o0YWpYWjd2bzBJVlFK?=
 =?utf-8?B?SzZROWMxTm45RHBUTkROcGdYWDZFT2YrcUo1NzJZTTQ5eWI4QUlYcWUwRG55?=
 =?utf-8?B?aU9kSTB0Wkowd09RRUF1Y0VjZE9NcmorUmJtMWFOdENlWVoxM3dlazJWTUhH?=
 =?utf-8?B?Mmh2dEwzY3BORkxwc1BVOEF4K0owQklNak1yaGtsSlo1Rmg3aTMvcXE5TlBy?=
 =?utf-8?B?RGJwVkdhV1pqRDREdmZPdGwyMXI1U3oyZklVRW9Sc1dmQzJ6Z2twU0lZQnh5?=
 =?utf-8?B?WTErcURxOHZiS1VjOVFBTno5ZW1YcHFVOEhTbnBFblYyd1JVY1d0Sk0vVktt?=
 =?utf-8?B?V29oNG12MUdaa1BZM0JadlppM3ZhUk11VFlPZmZjS1MrbHhVQzUzK3hsVGZS?=
 =?utf-8?B?REkxUTlaVk83SEFWaldNWC8yVnRPak9rUk5HYzROVGVYRFRVZ3hrNGJOV2R6?=
 =?utf-8?B?T1NXWFU5UlhNRFYyWHRja1RJbno0N29lNGk0RDlJd0QrL2ZQNXM3MnI3b3da?=
 =?utf-8?B?amY0RytzV0EwT0tITlk1aDcrMWlZak1tWW9tVEJLZk0yblM2YW9FT2RHNEJv?=
 =?utf-8?B?WVdFVzkyYzhpZEtJR1gvaUFNK1kzaktCbXdBeWZBbE5IVU9XdGJFNmx4dkVs?=
 =?utf-8?B?cUEvYUxvSHNrSkhYSFlqcFRlUm5YSnRHMUhPdUNGUTZZaXQvUERveXcrUGFk?=
 =?utf-8?B?NmxtZUJwR0dUcUdEUFA0TVBEQXAxMnVLK1dlVGs4dXNmYkVhRjM1ekUxQWxl?=
 =?utf-8?B?QXpWMDVUS01hblJjM29xZkNmVDl6SXpURWVBczcxa0Ixc0VqelRlR3hyUU5y?=
 =?utf-8?B?YngyOFluKzBkZzY3MFA0eUs4Y2JtdjkxTDhtQlppdGtPZnRvMk5IVGo3MkR3?=
 =?utf-8?B?L2FTdGovblBzdVNYbEx4NlRCZTVSMjRraWFSdE82T3Z0UGpOM0l1b3JyQWpz?=
 =?utf-8?B?TlJwM2FRRDc5UE52ajVPSkJSaXFMbHBWenJ3dkdCRGYrZGEzei85ajlMTTdT?=
 =?utf-8?B?Tk9QUitHbkZBclU1eWJZM3JGSEl1eFZqVFlGOUNEOEZybTE3UGJQejNWZzJu?=
 =?utf-8?B?bDZmS3JCL3pkaDhUcTZ5U1FNKzExcW5xSVhxOVFMcTcrcU0rQ0JLeWRoMzdC?=
 =?utf-8?B?Rkx1VlV2aEl6NVlUdC8xME1VTjVpRG5sdW1vTmtMeUh0TFRYTnBETzhDdU4y?=
 =?utf-8?B?K2IwWm56QmszZ283cDgrWWhXZkRiTXFPbXRheC84Z0oveG9wcDliS2Q4TVZD?=
 =?utf-8?B?UnNRWFZYSXpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWczSTlvb0FNcm13bjFUUXppQy9USndZLzFyMnRIblY4WW01NTYxV0ZsRE5X?=
 =?utf-8?B?d0NSRmJuR1B4enpJYjJPdjlZTFMyazl2cEJZZHpVckR2L21HUlV4L3BaSTVE?=
 =?utf-8?B?LzkzeDRKSStrb0c3aW1LMzZKK1RBSzdwMW90QWttZW9DTy9RSXZBbStvSjY5?=
 =?utf-8?B?L2J6eU40Y093V2hCNGNWb2RvQ0grK2pyTHZGaTk4ZS9VeVFIajg4TjJTY1Vk?=
 =?utf-8?B?ZkY4T0pRN29OVzI4N1JxNGljYWxWeFdyWTNLd0RyemNwaVB0QmxlVlp2M25s?=
 =?utf-8?B?QWlwMllycG5WNnNuSHBjM24ybXQwWUJLRVduSGJIRDhrcjZwL3NPUTg3NEI4?=
 =?utf-8?B?NGdvMHAybXVGOWpJa0JsRml1SkF1dGRrYjQwa0wxSU9qYkdLSnUzNUZPVW9v?=
 =?utf-8?B?REhiVmp6U0l0MDdrbGdialNYMnJCV2ZPOTdncjRGbkJsSEErVVpDVjR6QkFs?=
 =?utf-8?B?enlHTy95WEo3Sm01MGx5b0ZtcTdNZk5ZZTltMTNqUVBmZGhMYnFtYnJzU1Zv?=
 =?utf-8?B?NzZsQjRDME5Bb1YxQ0xDZXU3OEdhbFB4OXRZcjJ4WkNvM085ZkJ2SEdLUW5X?=
 =?utf-8?B?OTBUWDIvWFV3SVo2MVMxb2JFcFZ4SW5FQWtjQ3V4ajl1dnl2b1VPRGVoQ0Zh?=
 =?utf-8?B?UVBHekZtcDFrS3FrRmxGeDVlTGk4RGdxMGRuMERwOTllSXdRWG9STFhTa2py?=
 =?utf-8?B?S1d3M2NaOHA0UW5pNnVtZms3eFJLYVd2Q2JTdHdMRzNTZXlyT0FuWm56bysx?=
 =?utf-8?B?VEdSSEtKUG1EaCs3MmZ5UDdKaktUVldIZTdxM3A3RjRWcFplNWRXTTc1Zmd1?=
 =?utf-8?B?Z2s0VE9hS0dJbmZramUzN2hTL3pyeHcxOWU1VzRsbnpXNHJoMEs0N1Q3NTlm?=
 =?utf-8?B?aDZyU01OOWJFMFlGUmR4TkJqdWpyT2xtS1M0NVlrck1Fc2JLSFVKQVFMZlFH?=
 =?utf-8?B?a1p3NnBMTHpXYTdGMDlwV0lJaFpFYlhTbG1vcXRic2Q3dW8wcFNPMXphSnMv?=
 =?utf-8?B?R000RUJNYVp0RHgweC81UEFzU2NCZ1AzcWk1OFZLUjFKYjQ4S0R6ZzBSRk1C?=
 =?utf-8?B?eEN1ZWdRQWRoOFA0Q3FhaFhFQVdSdnpnZGRISlU2b3pTdWx4QitsL3I5VmVw?=
 =?utf-8?B?ejJBdWZpWDNNVktWSi8ycktzazgrUzdTSGVxeTdGa1ZxaGtxWGRyekhubW95?=
 =?utf-8?B?MlNoajRFdDdMRjVSQ2swOE9OWHFPSnBacnl0bWNGWmg1YUhiRGUwNE9VQWxt?=
 =?utf-8?B?b3QrVWwrWFRWQlpuMEE3aVVyV2ljYk5iR0lzM0tSbTd2U1dTaXBIQ04zWW5t?=
 =?utf-8?B?SWdDZExwY1U4d2QxV0I4RVFxblRTd0t1SjluMTFDVVlNZWQwQ2JoVFpVYWJE?=
 =?utf-8?B?b0RiWVhWQnpmRTJKVGV0ZW1Zb050NnRESGh6UEp6TVp6dmJFZ09LaTRBc1pP?=
 =?utf-8?B?MlhpSzU3REJSZlRKblU2MkJ4a00yeTdHaytnd2FrY1BVVkNUb1FhZWZNSmlR?=
 =?utf-8?B?Z3VYd05valJheUtZTDY4WDRScmlYaHhKODh2NlpqYmxHbkJ3MTRoTndaU2dU?=
 =?utf-8?B?K0t2dC9vbEhCTHdDN3ZoZnp2ZVFqd2hjR2tBTzJpaUY1aE1XTitNeUovQTlP?=
 =?utf-8?B?eE9ld1U0bm1KTUlsK0VhNDlyRCs1TmI0UWJ3R2hteFRuSktRMzRubjVRT0R3?=
 =?utf-8?B?U0JSWEQ0TG5jaW5xOVRJNEhSZldNQ0VZbk41K1dpWDhhQzRZRjRtTGpaeDJS?=
 =?utf-8?B?eXBnajhRYnNseURqV0M0WmpDcjhpVUFQemEzc3ZncXpnZVJjSWs5MWxiL3lw?=
 =?utf-8?B?MzJpQUYyaTZ3NU9KTElDbEtCRk9JdThGTWs2L0hkSWZEWElIV2NwaWNXV01m?=
 =?utf-8?B?S1Q2bG5Tc3luT3NMNmNsMGFrbkFFUXhYMHJhNFQ1ZHlNMGxnZGtYa0RKQnE0?=
 =?utf-8?B?NUlMejlPY1N3N2d6T1NPenRyakJaMnFjTHd4YmVadENWZjc4a2tWYThpVk14?=
 =?utf-8?B?NUs1MkRxdjJpWU1qOHdmeHBPWFJaZmEwTGExU0dPUFRXL2h1b1FrUDFjajQ3?=
 =?utf-8?B?dnBsZHRxdzZ4NkI2aEx1czhQMkorcVVncndJOEo0RDltMlo4elloUk1zL0kx?=
 =?utf-8?Q?hsvHJVu3uJG8ihcZTR1U7Sfa3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd650bf-2d84-482b-209d-08ddddf633b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:26:05.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ksp7Ra8KMZRrZv8nYpWiu0rKMrzOdpJZaiV9+qLIpzSiOPXla3OuzG2nsMctrV5YfTWJ15ucOUHYHo3ha4ECg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388

Add more MUs for V2X communication

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index e20feb1bcec6088949e7dd1ab2fc1c108393fb81..02c0422a7aa3877c8431c9b050d85f43f5ed7bde 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1500,6 +1500,13 @@ mu6: mailbox@44630000 {
 			};
 		};
 
+		mailbox@47300000 {
+			compatible = "fsl,imx95-mu-v2x";
+			reg = <0x0 0x47300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
 		mailbox@47320000 {
 			compatible = "fsl,imx95-mu-v2x";
 			reg = <0x0 0x47320000 0x0 0x10000>;
@@ -1507,6 +1514,20 @@ mailbox@47320000 {
 			#mbox-cells = <2>;
 		};
 
+		mailbox@47330000 {
+			compatible = "fsl,imx95-mu-v2x";
+			reg = <0x0 0x47330000 0x0 0x10000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
+		mailbox@47340000 {
+			compatible = "fsl,imx95-mu-v2x";
+			reg = <0x0 0x47340000 0x0 0x10000>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
 		mailbox@47350000 {
 			compatible = "fsl,imx95-mu-v2x";
 			reg = <0x0 0x47350000 0x0 0x10000>;

-- 
2.37.1


