Return-Path: <linux-kernel+bounces-889330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D01C3D4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 224454E7E33
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF372351FC7;
	Thu,  6 Nov 2025 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vq1LsTeJ"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7710355044;
	Thu,  6 Nov 2025 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459071; cv=fail; b=fb4GK4X369a4fHoCrbVim8bIwHgbmnD18yr5aAaRGHpYWAjpHTvw1YC1fXG2Bs+QYgH9VGWkUFOip7ospr4hoi7nDxK8etOin4o/7keA48/9wMoaPftStEyE1SyPv/8NQnXDP57sPpGldV30tyXA5VedOt34K5JPqme7fTM/xCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459071; c=relaxed/simple;
	bh=1RxowkE5FTVK677T24G5xi3MPYZRIDfNJ7nf1gedgjA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Sm+ZWWDltB+maJOV+8FxQAHhlLU2XLMhSYV7hR4u9grA/OPPPUsX5F5ViZ4WXOqRvoAnEkUQzuFsKDFwVpWntYEfvf6ZNAnlOA2MnozIoHBCjZpbv8Paxs7/BozOpik9LnzIdtlUftdV6PEvr/L2uJJS+i7LO6IOFLU/Gt8E34Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vq1LsTeJ; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFcodvR5LsV1ezKOBkbi1h80EXhQTZNAtkfVwpjC+v/qsJ1q30Q3KOkSYI2ixt3i/FeTvWnDYJ4NPsvfosK58vrpGlJYauKe1esG7wMqNhkRH/yLZeyQVkBNx+0LTeVfIjwLCoaXIBLRBPSCLewcoiblrQunD6Nz/IQrEcWvaxueRA+8dNd8HyxRZTn9nKFxgmicOxMShklwgPfe+Oo/cXDLkXqWC4OoogSTxT9Qq8ZFNLtlZjAH/YeKvSBj18y0tjUjULOKFVZocPkGrK8WQcAE5gAYXjh+GBMO00fmuDKZ3M+dnCDMx9Ocsh2gfvOAbAa67PAXWMyJDNdHB0qaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp2CsL1ns8pyZkSFyKHBK1MEQz8yQ0LJvn6uf4aZ9zI=;
 b=RR0QDk99mqnTLF3l3xDLWlvAe/zE4UFNySqRfafn6qqoqWoD0aXu/5K6YyNyxHuLJkgNxJlQ/NTjThtS7lquFKqOTDoqXLYMRL/ckKbtTb1t63wUGcOycpajMbtEURJHl/BNdXrLUG2CEAt3EE4GraYtuhJ/EnRF01uY42dW3Enn0ckxXV88uwzKscog59FVaq3HXXL+iRi3on0SK4++OlIfYgBntuEjDD3ru+/X2OrWx4iaqi72D4Sh4EaM98hsKLu9dgtaUU0VRbd66Ycbkn8uVAx0qSx22JIxmVvDIDNgGvF3rNxGmeyms2JXYK2HYf0YVU/MELvUk560CZsxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp2CsL1ns8pyZkSFyKHBK1MEQz8yQ0LJvn6uf4aZ9zI=;
 b=Vq1LsTeJf+GNie0nG7wz957PlC5EBp8RLRal63KTmg+BYtILrp8K5rSIMb75hS2Qy8Hz15sK20YDFmPfwIHJ0sRASllHnCZg2ij+3L06UGCnF8UaYbYrpm+pH5fF9y+lUJB3BXjhVjTtqd62FEINDD/aJgtsBeopAl8ivwPrd9fy8mFbdXTHwHSab6+5VvJ2+d8pIAbAhl2bkiiq1l8WHfCgE0KpLeKKln/U9WNg1EY6pUbXRpeZyRn/P3SdKNd3s0HC1Cml/crWF7UUjKFFsQuKRuwRMopjOnNVHkZORVE8K/SX41AD/VEfhKSMEC+jZ2HJjveUVGb1IQVINcPE9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8756.eurprd04.prod.outlook.com (2603:10a6:20b:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 19:57:48 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 19:57:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Nov 2025 14:57:22 -0500
Subject: [PATCH v2 2/3] ARM: dts: imx6qdl: add label for system clocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-ccm_dts-v2-2-12fa4c51fde7@nxp.com>
References: <20251106-ccm_dts-v2-0-12fa4c51fde7@nxp.com>
In-Reply-To: <20251106-ccm_dts-v2-0-12fa4c51fde7@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762459054; l=1281;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1RxowkE5FTVK677T24G5xi3MPYZRIDfNJ7nf1gedgjA=;
 b=aE+94r/rVL50OHxwy7Zbc6jJt1+3nCEtHzXsoRhbc3rHt+Uz08nN+jLtFrX2xcT6/NvX8oOcK
 4Re3dArU34uCqdeny96p4758TVouR9QGRd/REcyNZ6nKgnHDMZrpZFi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::8) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 7384c88c-b841-4bd7-1dae-08de1d6ec2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWF4THFVVW80Z3BZUVNZWnVncThub2RwQ1BZQjdvVk9kZUFkQWZnR003T0U0?=
 =?utf-8?B?Znd1QUZpTVZnTVJJTHhiUktQejZYV2FlMUEzVVk4b1VPYllEY2NDVXRldlNr?=
 =?utf-8?B?ZXlmUC9wQ0IzQ0I0Sll4UWhpSzBhUU1MNWN6YzhTVlBMY2ZQS2tHaW5ndkhk?=
 =?utf-8?B?NTJJS2FvdlhMendRNEgxY1ByWHJRaGVUK3JIZ2Q0UndlWnA4YTIzN2YwVVI4?=
 =?utf-8?B?T3pCSElwWS9HZHVoams5b21xRis5YUI3a2JRWDBEanFDV2hHS3dHSTAxRUpL?=
 =?utf-8?B?L090U1pIWmovZERxQ3JhSGkzdnF0MjY4b1VxQ09GeEpSOFlxeVh0blJ1eHZ6?=
 =?utf-8?B?R1JUeEtmdWJNcFo5SjJwbEJMK3ZsSUhWbGtTOFBtL0l6WklNckN2UHBPZUZW?=
 =?utf-8?B?dmpCclJ5ZFArZ2paSXkrUnBrMU9Rc09TcDdUaWY0KzJMR1lxenpEWm1BbUNl?=
 =?utf-8?B?OEZwU24xL0JRU0xQSnd1OGJEdHdCaHJ3Znh4NjhRZmFET3RvUS9RSGJ2emRG?=
 =?utf-8?B?b3doR2tLNUdsOGtML0NDNTNOa3o4RTgrMGJVcmJoREhzTnRZalBFYWFUNFFG?=
 =?utf-8?B?dGtwbGFubUxvS3FaQU92WXhYaVB5MEQ1Ull5RDlTbXhxcFhtR2orb2wrdU5E?=
 =?utf-8?B?YnpHMWhOVGw1WmhCQTJ1STEyYzFxdVFxWmwxUDNJZWNuTlZTbmNNQ3VPdTBI?=
 =?utf-8?B?WjFvVDRrcTdEQVNicWdPdmt0cjhPbUE4MGZOQSt6SHduanNhSWVUNnBrc0hW?=
 =?utf-8?B?TjhsUkhDbGxJTlB1Q0UyOEo0KzdNSCtPT0xkUWozV1hEc25weWRjaUtqU3lu?=
 =?utf-8?B?Y3JUS3ZkUlBFZnVab2VUckRHdDh1MkFPdDBKN3VzdCtuSEtIa0VGRERmU0l2?=
 =?utf-8?B?eCtVSHlraUljcXdhUlgvL0wxQ3lUZG13Z2RWbFZtQ2ZuRS9yNmRsK3BQYXlm?=
 =?utf-8?B?VzNHS1BkZWlVU0duWUZRTGNFOXBmaGFhNVZuRFA3aFpEZ0g3aldUNDEwMVh3?=
 =?utf-8?B?WFNoVEJOa1BuemQrYWZJOC9YOWMrUVQyYlFDOWdTL01NbUUvUTJuRzhLTGtN?=
 =?utf-8?B?Q2VCREZHMDhWZUg1bGhqSVl4UGZSRTBUckFBSEc4TnFTOUI5d0V2QW5HV0lE?=
 =?utf-8?B?U05RTTV6MTI1cHpMNzRtajZOYWZ6akgxcEUwRm5QeE56SnVINmJTV2FQTTY3?=
 =?utf-8?B?MGcrWGdHQmtvRlBPMWw0QWR4ai81YnJxcFZOV1B6Ujd1ZkxLMG5yaC9tMms1?=
 =?utf-8?B?Qlh6MHd4Z1hyUHNsU2dja1RvckkxakdtR3hzWHFQUDVIeWNkTk1ZbWxKNmRH?=
 =?utf-8?B?SnZITXc2N2dleXRxdXhWRVFEY0dVd2gzM1ZyZm9ubDNGNHRrZGFENEtLL2ky?=
 =?utf-8?B?MFNvbTYyZ0VDS3Y1dmlxZkI3R3p0ZmFwRE1NVXUzalJTd0JDU0RRRHFuZDV3?=
 =?utf-8?B?T1AyUzc5QjVBT0FRVVhZL0daeXlIendMdXpaeUtSOXo3QVcveXVkMmErVmxT?=
 =?utf-8?B?ak9zUzI2Q0FuTTkyK3Z1dHB2dENZZ1crUTNBOTFPQktIclJVL3BheGZrN1Yx?=
 =?utf-8?B?UklrdXI0MGFoV0RlWGZsNUVpUWNBR2hjb0w3ck9hTjJjVnZDRURKTjllMGlW?=
 =?utf-8?B?cm1jQ1kwZVRPN2RaZEloZnZtWWhjQ0ZRVHlGSHVJTmVUYkp1R2tMTUt6NnFR?=
 =?utf-8?B?RUpXakVzaVdBQldnUjF6bUVaSTk3cnMvSGVMSVZQUGlpbmNjTThoY3RYYjJG?=
 =?utf-8?B?TmZGQTJKT3p1cExXdnRpMHpDUnlCUlc3aDQyUktEcTJUeGlocjVhYUhkNjdj?=
 =?utf-8?B?NFZqdUVLRVUvdktqaXFIb0RnNDhsS1NHYkVscytxV1lxTURWSXQ5YTUvTGU4?=
 =?utf-8?B?RU1JN3VlWWtvNk84Qlk4TjBGNjIwcU9ySU1QRUk1YnpLVU54alhrcEJIT0h3?=
 =?utf-8?B?WC9URGVwbmVhNDZxdzgwM1E5NTc5V0ZwUkdnSWhGY1V6SXNsSDg4M1VDNkxV?=
 =?utf-8?B?aTcwdmx0TUsycmR1Ujdad2NieXlRQStzaVhBWHI3aHNpQ2tNZWRiVmhiQWFp?=
 =?utf-8?B?bFc3WUpaY1RDemZ3OWc2U0FaM1dvWU1FZEJuZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWdQbWJYaldyZzdTQzYvWkEva0dqMDBEaXU2VTFORG9xWVBDR01icEoyRGRr?=
 =?utf-8?B?ajRqVjhWMkJVQldZNXMrTWRMS3lTemVPK3Rza2ZKbzZwWUpPTTlnSFQ4WTBB?=
 =?utf-8?B?QmpOYXJtWm1Hci9MMFR0N1JiWjBuRDV2UTdGSzlrTyt4bVZtQ09VcS9IK2sw?=
 =?utf-8?B?UkFyVkRyeDFxMHdrVDdGb0VBR0VpeFBOeUwyenJBSzZCeGxjWUpqd09DeG9t?=
 =?utf-8?B?K2xoU2Y3MlhCTEtldVAvYnBJOG80NGVTSW5tRzlBekMwWmRObmxJMTdFR3Q2?=
 =?utf-8?B?ZUt2UmdySFhQWXc2L0NNMFZ2cTZtdWl3Vmg5Y0hHdUJkQnp1dFVmYW03U3po?=
 =?utf-8?B?aStsYmZ5NTdjNFFEeE9Fdk85WFl3Qy9WRFd3YmFMakFFNE9uRlFrazlhOXRk?=
 =?utf-8?B?aGx4UFhMQlZXTDR0aFNacXlSczBZZUF5SWxjQTdkSnVvNkRVTVY0MEd1U1Qx?=
 =?utf-8?B?N2kwMHQ1TmpBeUFYcXNHRHorOXNQSEwwQnRyWk1NOGtxbWFKUmdaNDV0RGwz?=
 =?utf-8?B?Snd2VnE1clB5Q3dGWXhJZDZFSVdJVFQzWGhTc2hkVCsxbmtsOUtBWlZuYjZk?=
 =?utf-8?B?Ri8vM3ZkcDBMaDE2YnE2czNIU3UwalRxbUNyVVF6eFhiYW5jcEZma3UzQUwz?=
 =?utf-8?B?WGwyblpMcGw0RGVTSlY3NjB0eW5ydjV2SjVEYTZkRnlyRElyUDdFUWJMUGFR?=
 =?utf-8?B?SVdEN0R0YUpUZW1BZDMrSU5HWkh1SE9udEFWaVZ4NStXNEd4Q2YrV3dpUjht?=
 =?utf-8?B?MGNJeEpLaTBqTEtaOGNNM3hkTC9VRmhFeWYvVGFKSFNmU0pXbkJoZkh2RGxz?=
 =?utf-8?B?YmkycEs4QzloS25jYlQ4UEROSmpXVE1VUEpDOXNUZ2pqeTVHQ21Uc21WZ3Rl?=
 =?utf-8?B?Q3pxQngwc2JxZHZjbE83S2Q0eHQ2WDFWUGxjQ2I5cFFFcFpJaEJEUng3N2wz?=
 =?utf-8?B?L1BIbTBISWhiN1FzVXZwTHlCdHIyaUxuekZjdHd4TTBsYisxL1NCOGFtN250?=
 =?utf-8?B?eTNaZXFXb3VwaDFPUDJVeURPSTR0eGFzQ3JpQ3FhTXlEVStiNVRtWk1vMXFO?=
 =?utf-8?B?bElnbmNZQ3VNaGtGbWdHaC8vS2p5NFZFNUVYK3NLVU1HNUxaeWxiMkpkWGNW?=
 =?utf-8?B?ZThGUnBkQWRQa1FmWFBOVmJ5MTRTWnNDMThUb0o2Q2M1anVVTVBuZ1ZnaXVU?=
 =?utf-8?B?Yk9RNmg3VGlRTFZKQWVoTnUyOVNxQnpSTGdydWJ6OFl2UE40MFBPeDZxNy9k?=
 =?utf-8?B?QWhvcVFiMEF0TkFMY1liM1kxSXM5QTJ6LzRvazZQTElob3lzZERqWVlvaGl6?=
 =?utf-8?B?QTFaTWUwcno3cFR5TWo4NGdPT2tqV013SzZ1Q2R6enJBV3JIMnphOUdhOGFJ?=
 =?utf-8?B?ZmtPb3o2QklOWWdRYmo5dXN1VGtRd3BUdUYzamM2bnZNUUpvUzdyOVFnc2NP?=
 =?utf-8?B?Q3ZJQVVEdVlzUUVhb1hnZjZxcld3dE56RjdHQmpPMVNlWlFnUnNSZHZZQVlV?=
 =?utf-8?B?RkhNVGVhWGc0ekJRV21LSEczOW11Nkd0bW9QT1RHYlpCdFR6djVQdzNHWTlN?=
 =?utf-8?B?Q2M3TFU3bmhyQml3OEo1MXIxbnVWWWJoZzZ2Q0lBUDFkL1lEWjJnNFVuWU5K?=
 =?utf-8?B?cXlrM0NUWEpNTDVWV2hXRE55Vm8wQ3UyTHdNS2ViSWs4WDV1SXU5RXA5TEJv?=
 =?utf-8?B?NDJ6bVhLUFRvcnVHNjY0MVIyc1N6dFRuZWR5Q2tQKzBqbGNhK3hwdFdoMmk1?=
 =?utf-8?B?Q2RET0s3aXYyeWdiKzc2QkdZUG95VkpBREV0UzJWZGI3M3VncGNHK2liUzN1?=
 =?utf-8?B?NDZ6M1h3cmJIbG5GL0RzWDU1eUFHdmZ0dkdKa3NhRDE3dll0RTNFdmg1YlZK?=
 =?utf-8?B?eTJ6b1NvdGQ2Y1MrQ2lDakdneE4vYTM3VTAwVmxTM1lpaVNjdkIvVWczYVJP?=
 =?utf-8?B?VzdBeWlMRU5wNGFlVjVFNWtnK0ZjWWlUTEpoNVVzREwwQndDTURkeEdMT2NI?=
 =?utf-8?B?RWU0UUg1TmRvVUZoMTMvc3pzeE4xMU9WU0s4dVR3aGVoTzE0RGl3SEhqWW5m?=
 =?utf-8?B?UEdaNDZDOFpGVDRmQkhKRkJ2R1E1ZW1YU0JXZTJHUmVRQnpHL0FFYTlSUXcv?=
 =?utf-8?Q?j2XTxQIIznU2mPvBwrNyxwjdJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7384c88c-b841-4bd7-1dae-08de1d6ec2bf
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 19:57:48.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6qtQnx9ivPyfU/zQh7sJnbDvpw/WLIFelZInbnVR3yOL79KFPX7yg6A1xVjx2QSEMfcwV8+gXOVFbTBultRRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8756

Add label for system clocks and add two missing clocks anaclk[1,2]. Prepare
for fixing ccm related CHECK_DTB warnings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index a361886144ee1de5a183f405a58d7020d75cba9b..6887e7f8d40470eb149ac1fb86876e544b8e22a7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -54,23 +54,35 @@ aliases {
 	};
 
 	clocks {
-		ckil {
+		ckil: ckil {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
 
-		ckih1 {
+		ckih1: ckih1 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
 
-		osc {
+		osc: osc {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <24000000>;
 		};
+
+		anaclk1: anaclk1 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
+		anaclk2: anaclk2 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
 	};
 
 	ldb: ldb {

-- 
2.34.1


