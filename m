Return-Path: <linux-kernel+bounces-799374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45ADB42AB3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A23567D07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA37E36CC87;
	Wed,  3 Sep 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T/DQIQPN"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39AC36C08C;
	Wed,  3 Sep 2025 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930828; cv=fail; b=cdmoVsTCs0NFHwNWtrx/NlMrjdhxbM8LK2YXsT7BCtWqGR/wKXCw6mafUcfLyqZlHG6MkfxX/XRtI+W9GdMvlEXMrtoOyHxxcV/y7Cf9tmpmu39wRFdYvG79TWm43a62OqxVs2iTSy4My3rMu1vpo3uuPdkCREL+FUMhVcRiWKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930828; c=relaxed/simple;
	bh=y594j1MCZZgMCCuf5KmFAyvaE8O8lC1PanXspdHE3uY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JfnYVrF/WkdVymDe5jcutfeXgCnBfmwfd/VMpF3JzQ6naoya4d7mhpbvtLQ87JxsUhihvZVyo+/o79WZgRKULt1bHgskvumZ+ucuPif8dHEPtzCrcbry+QWPJyOV2Joy+QrfD+kqyFdRTjCcWwyaDFviI2ZbsN43mtl0+y1iUyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T/DQIQPN; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuumLCfP+D4gHvIp6YSfrG9EiglnTbuNPopVw1VextOApr5FkoNZ/lh26IVgrWSGSTeq2F1fCwqBUcWaG5OGsqXoEboBcHnKnO5iUHuqKD7dWUpm1R7JmWlZTM69a88BoTv4G5Y5VZebiNpT0MVfRU+Z2pz2AY+30Xqft0LI3YVDjmioW9o0j36VVzTGJFenbMJ4VWUQs00phQzybWjvHluNh5KfZ6SvbEHvG4AQgJiNZtusy/9juOM8OdarjQfk5PMUAxHYDCI4UJYowtOj1o7tJ5WRwc46Yb+RN5cXqtovoL5Ge3nkMpUT07q6WaM5g45x3vPCo6xo4+iSepTlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fKqGm8zs9ilLpkdKKoZJu35fBrGHxwz/Ta5epjI//s=;
 b=it1arXE0icEydnYff28xe74uP8ewg1OvE1JMlZ1HMUnHj9tx4w7Xciq9Jn/iQQwkgCMU1WWwRXizfnIunbKEU8u0EbVLBD+pFHhnAJqTcPwrx2D3wiA3P1MsK4iS9MW/6o2V1xwXIGNIm/fbQL6AZBONYK2GkvijvtP9bRU/omSgwE1KzEGZX35lkNSGjZXP7CZikapBF4zEN9N8WzcEEVXwA5dKhchMhhBPZVY4QGz5+71+6THY09yPNP2My88b78GS0XG1TTYg/rmnG2gFGOD+5V/r88R3B5YaMl/O0RVQrbd/Wk3piI1dF6BIQWvzlfVBn6fVkKCoH9nm4HEkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fKqGm8zs9ilLpkdKKoZJu35fBrGHxwz/Ta5epjI//s=;
 b=T/DQIQPNmMvPmwSO+whHoTWMZAaLBbaH9UkRuXti2zW6OCIK3LWpLO46Ob+RbKHFopNWlW8T3WTh8ce7dT7OhKd4r7fJz+auczeNOD+C3PxC6wDhHAH2Ml7vXkpyAIz1VWvNYpVA7ZGtQNJAW3kpaSmhYiCu2VmavyYFSRc9Pmo3595l61z5h+Ch5gkJBWIA4gIankEDCFANuJwVaRTZ1MgXZH8K41rGLZpG0WnpTo77eVdnzps7m64HQSwPYEHdnmBYSTdUE5GAv/Cf4G7H/ILxPxSHmpogvAlk+J0tIxhlXV6YdO9a4+GddW6y7kfQmwvcLm3w5Xu0VuKIvI3crA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:22 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:19:58 -0400
Subject: [PATCH 05/16] ARM: dts: imx6qdl-aristainetos2: rename ethernet-phy
 to ethernet-phy@0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-5-1e883d72e790@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=1034;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=y594j1MCZZgMCCuf5KmFAyvaE8O8lC1PanXspdHE3uY=;
 b=huu5uwu6humgfuYMbY+puv0/r9Ht1RLZNPC/EOLGfyjJNAT0uXxqHapo5cAsd4PWWZr24SGkN
 OyA6XBuKmKlDIIZlxshA5RwowBQTnv6gd3LBbsM9PPFujz9ViAD5fWs
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
X-MS-Office365-Filtering-Correlation-Id: 4dcd58de-3c04-409f-956f-08ddeb274f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eml6Q0w0eERiTDcvOVlrcW9TbGF0dGgzUm9zZHhuRFVFUGZJcllMekJZbU1H?=
 =?utf-8?B?ZW84TnpkbzZOS1VjRElSdUxrZ3Y0SmZVWG1EdHY0cEJZeDhmMTJ5TlRVeEFK?=
 =?utf-8?B?MnlSS044ckF1OThTU2N3RkNzYjVVeHMzb01YQkpEa1hQS3UzU2o5cWd3RmdB?=
 =?utf-8?B?bXJjejF2QkREZU0vNjFxZXF2S2h6Ny9ZUC9BTThpOE0wc05FcnFrR3JYUkNL?=
 =?utf-8?B?MkQ3RnF2bS9zUUpkNktJQWo0bE5RT1ZHYWF6dXNVcFpLY1VKM2pua2luQ09H?=
 =?utf-8?B?bmdwN04xOWhMNUVMUlZRcW43cXF6Y2pUay83UlpjQmhZcSs1d2dYdWorR0Zr?=
 =?utf-8?B?aUFrK0hDck84aUhqY3BkWVllTmtMTkthNXN0RkZNRGQ2RDhldmpqaFI5UGFy?=
 =?utf-8?B?akdEaTkramlNTXlTSGFxdFRvMUVJbFFWd2VhZHhKWVZJR2FwRDNlY0ZEU2FB?=
 =?utf-8?B?VjRRMzZOSHA0c0dJQ0VqbWZhWHlZM2J2RW9zanluSjVZSEtQbWJrV3VTQUZk?=
 =?utf-8?B?YVU1Y3E0Znc0aE1OaHJ1TGREZWF2TU8ra1RsdUJlVUtaMWJDdzhwY3g1cHp4?=
 =?utf-8?B?UWRHZ0NtOFlRbDZxVnZNeHRLMHRaUVF5dzFrSHhJNjJSZ2RtUklVSmc1NmdN?=
 =?utf-8?B?ZVNEVkladXZrU3BzU0ZycFNSK0dEK1ZEblhwL1ZRQmJ2TDREYlZGVTZmRUQ0?=
 =?utf-8?B?MHZMSmJ3Y2dzR2pTQUo3WkRCRkF4MDhFV0dVbTlqamFrWHIzZ1prUjNVVFN4?=
 =?utf-8?B?UnVhMThJWDd4TTVDMWtrd09pQ0RaQWVhVWhmK2NkVFdldmdVdXR4UzhCRXc2?=
 =?utf-8?B?SE81SW9FQkZXSVNpaCtXVHBUSWpxNDd1UXAzd2FKanV0RytFc01lWVI0YTla?=
 =?utf-8?B?aGdncjlhQnhEYzBDbUp1ZVU2L1ljWXFSQm5tTnh3U0g5dXBMNndyeGMzSWJ4?=
 =?utf-8?B?b2FlbGtiUGFieFpKM3p5b2VDNDJNWklYR2orWGc4Wk53OTUwZWFoYWdsMVpB?=
 =?utf-8?B?bEplMndhSGxQMzg1U1lsSSt2N2dtQys4S05VL1F5Zmtzck1OM0I5aW9xU1Ir?=
 =?utf-8?B?Q2dLbGJLVVhOZG5QaCswR3dOZ0V2VjBqanIvN2hxRkk4Vkk1c09pRC9tajdR?=
 =?utf-8?B?emZpTmRPMmRiT2hraDY2UHI4QmZwSURJWHpzL0NkNWVVd3ZNcE54eGFGbnFP?=
 =?utf-8?B?TG9mNHJ0YS9Za2d2SkpKY20zZnFNaktWdmh1L2xGN1ZPYmUzTEljM1I4ZlVV?=
 =?utf-8?B?V0hjU2dYRGNhT3d4a2tsVzZ2VlZwUTdGaVV6cGp3NVJtdkhjdnZNRXdNMWlL?=
 =?utf-8?B?ZUNVeTJGTzNDclBMbTgrZVo0UENlc0xtMnV4di9IdFFTWFdraE9JelpZcFJ3?=
 =?utf-8?B?K21ETHYrZXNUQ1Yxd1Z3bFl1K0lydEw3RjNWY0xFZW9La2g1ZXgwWWpXUi81?=
 =?utf-8?B?dlhtc2x1V1B2VDRNTnI4OEhQcmxPczZpeWdudWl2ZCtEYlZJZVM1S1R3dEJZ?=
 =?utf-8?B?bDVXSnBLTEx3WDRGbWQyYXhBaVQrZ05zcnI3cWYyQm14TzM4TXhRN09TSFM5?=
 =?utf-8?B?LzdPenVic1RWc215N2JiVTVSMzNHdldlSkhLbzVyNG1KelNRbDZGTkZhUmxt?=
 =?utf-8?B?bTBTOXhVa3RSTTg5NjYzTEVLYS9sTk50NmlEMzluRCtacEF0RCtIbUk2cnRR?=
 =?utf-8?B?eElIQ3A4ZTB0UGxTV3BleU92YW5ZWmdzK3RaZlR4cVl1a1krN2xjbDNaZUZE?=
 =?utf-8?B?OTk4R1ozeDJ2S0drcGM3anloOFhzTi8rYkNFZWI4ZFIzNmtrMVF3TVkyS3JU?=
 =?utf-8?B?SEJyaEtEYjY4Z1ZKTU12TjVVbStNdmdmK0dkNFlTQkZTWGNuY1pESnhML3Rq?=
 =?utf-8?B?Z1d6M2dJWEJobjBzUlVobHNkLzUvRThISkxPWXZlc0FzVjgrbTZJeWdQM0dO?=
 =?utf-8?B?Rm9OSFVIWnQvVjZKNkRzU2tlOENabUlMK0phMjVBWlU0Rmkzd21xSGhIM1Ja?=
 =?utf-8?B?REdhRkFwM2lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU41SG5HN3U1RjdTWVpvR0pka2RQWjdoSWw0ZHZSMll4SFZ6YjY3RHF1UjFZ?=
 =?utf-8?B?cTIrUlduaXdBVUpvUThtUFdraTYxVDVIbCtNN0g3VVBQOVVPS1JKLys1bG11?=
 =?utf-8?B?TUpucGJoa1ppeDc2a0tkS3BiZDFmUkd2bWZPdkNzdGdHaXErVEZ4TkFDZmQz?=
 =?utf-8?B?LysyUkl2amp5VEM1dHdDb1JBRjNsNUN1SUJFeEt3QVV2YlNiWURlY041YVF5?=
 =?utf-8?B?MjkxSEpDZ1FaemFsTUdFVXlFc1ZWVW9aRGRsYWcwV2NqeWxuYUZ3by9iTGdD?=
 =?utf-8?B?WlZhbHB2TWh4VDVacFRwTjFxY1E5RmRRSDV0d3FBeTN4TTU4VDZWSmtYczBW?=
 =?utf-8?B?cDZUbjhqdTh0eFluN204b0N1SlRTZU5iY0tjMXE3cG5tc0Y0Rk5BajJ6dWdl?=
 =?utf-8?B?ZlRsUDRXSWxKNEU3QWhSTXNaZ25aRkNHUk1IMU9HZzd6QlpSanhiQkMwYlhI?=
 =?utf-8?B?dURRR1FYSDFtYTQxaGtxRnVObHdtQUxZUEpDMUNyQlB4V1g1cDlJdmhIa0dF?=
 =?utf-8?B?cjEyQTg5OGQvdWk0UzJ2MDJMN3hSU0M3MVIrd3BjMWZ4S2t1WjdpZWN4OE8v?=
 =?utf-8?B?VHYwVFMyazI4Z1RMTDZTL0o4K3JtcGRiY0VZRDZGUzVSSjNjZkFGdzN1aDUy?=
 =?utf-8?B?ZjM3ZlorMUdzaEJiUm11SDZvTzU5NXM3MmYrcTdMRXQ0VkR1M3o5bk1ZdHJR?=
 =?utf-8?B?eHhqdVc2R3BqZVlaK0M0ZW8zb2Yzdytmd2czaUpEYklQMXdvR1I2OXoxcjJm?=
 =?utf-8?B?N1hqSEFROWpkNGRnaXBuZzBDV0V2L2kxRE1zUTRSZnZ0VkhKNDBDOGpGUkoy?=
 =?utf-8?B?VUhVeDUrNk1XYS9NSzBQTTNLaGFTcFMyNW40VVdGTTZIVzBLTlFFNVpuNGsv?=
 =?utf-8?B?VWJuYmNuSHVBbW9hT25uWUtDSHRLZHlBTnhld2RYU2haT0RmWnBFa09kYmRP?=
 =?utf-8?B?OE1RVUdLNGMzQy9CdDV2L1NIT3JBQ3NPM2cyNFpOaXBEK2RDUzdLZ0NMQzNI?=
 =?utf-8?B?b0ZPOE9ZZ2lBQWdPNHQvOUlJMTlWeWtCdWhCaWZqNTVzdjc5QXlQWC82UndU?=
 =?utf-8?B?VVA5WEMxN2czTkorY25veW1IYWs0TnlKQ0xFNjFLZnkrZ2diKzMwczFuVEZk?=
 =?utf-8?B?a3F6Mm5MbldWVENZd2hBak5ZQkRVekNNY1BJQUcrNHJqTmQrd2pXSGNUMDQ4?=
 =?utf-8?B?RS9FRUxOZElCODNkY3R4OWZ0R0IwdXRLWEoxcDZ2NTBsVG85MVQ5QjJZUFFB?=
 =?utf-8?B?UnZScWpFS2xubDRRUTNTK0ZkYVhxbzNnekpNYi8vQk56TGRQelVjTUpyTjJz?=
 =?utf-8?B?OXhPNTZrYm91dGVvWVltTWsrREdYcnZJMDNWRXNIOFFtY3ViU09nZlFhclM2?=
 =?utf-8?B?bXAxYjNxOVNtc3MraHhMMGQxMFBZTDM0dG1qRS9XUlQ5NmtkWXZhMUYvWkVp?=
 =?utf-8?B?NGdYYjAxanpJb0h1clk5dFB4V1dxUHBVOTRobFVVcThpcHZJdHVwMHpFMGM1?=
 =?utf-8?B?cEJpS1YyQ29YOGdHeHd5akg4Rzh1ZG9OMzNuR0wxT2dmdkZsL0dSTzZycjRQ?=
 =?utf-8?B?SmovZ0x4VEMyTm9ta0NLV3VwVTVOVEZGUHQ0OWw2aHNXKy9WUXVpbkx1N1FR?=
 =?utf-8?B?emRONGk1dXdKTS9sUnpyVnF6b1pCZTBKcFFEaENzcUFabVlPT3JQUDJxZjhN?=
 =?utf-8?B?OTZCZWZYZkxTVzdFM2kzTng0c2Y0WGdxOVZBS0U5eXR0MVd4eG5valR6eVJk?=
 =?utf-8?B?VXZSODRVRDcvK0RxRGZvaXlRRW1hTzJGcEx3Sk05Tmh3RFp4V3VmZEg2aFBV?=
 =?utf-8?B?djA3aGNaYU1ZMEpKY0JpK0xIUy92aUlVRmVTNmR6WDZaMkt4aVJrakh0VHR1?=
 =?utf-8?B?emUySjlCVEtYTVRCREVTS2NPNEJ4TWlJdzRvNjIwcnpEQ3MycVRhUVRrQUJH?=
 =?utf-8?B?TVFnSXExMWIvc1RDVGdEWlNSTGtnMUh0UWF6dUV2UE5QMDE0UXh2LzFGMVZE?=
 =?utf-8?B?YksxM3haNHNra3FERUtrZHRJWnNOS0ZkbitVaTUxYzZuWE1QV1A5NUxLM0Vo?=
 =?utf-8?B?QUtScFN2TXY2d1RPN2srNEJQa25uYzdwM2FjbzlLN2w2am03NERFejhETmVV?=
 =?utf-8?Q?RFVx2oChnD7sXqsLObCbzCwEI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcd58de-3c04-409f-956f-08ddeb274f00
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:21.9558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQiJugev3lF86e8QCJXoP7eoBbjhqlSSrYMPmZD0wsZ1ALymIcOynn1KaAcY4yxU7tVMkgzYnkwinvirExJUqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

Rename ethernet-phy to ethernet-phy@0 to fix below CHECK_DTB warnings:
  arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dtb: ethernet@2188000 (fsl,imx6q-fec): mdio: Unevaluated properties are not allowed ('ethernet-phy' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
index 5a04909ff9ee13db0726d2bd6710cdcfbaf83faa..d23342ae22d07301813586521d54d6df96c608c9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
@@ -326,8 +326,9 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		ethphy: ethernet-phy {
+		ethphy: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
 			txd0-skew-ps = <0>;
 			txd1-skew-ps = <0>;
 			txd2-skew-ps = <0>;

-- 
2.34.1


