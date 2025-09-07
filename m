Return-Path: <linux-kernel+bounces-804659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A69B47B31
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 14:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2609201F6D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E8D2690C0;
	Sun,  7 Sep 2025 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QeZjtrYh"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913781E1C02;
	Sun,  7 Sep 2025 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757246904; cv=fail; b=iPTPybBqCvxaPgeHJ37iw+yskaxm1TyuKqxQTTYs6uNiYx1p5Q8UEuDzNOXzDkLNh0Qm4Ic6SG7yq6hNKo5/KVj+i9yJ4YwmbLQkeKjVJ0k7vla6Q/2Bie6CVqtFfOiZ0obl5PegsWvXrGkwfNBOxEVCcdgPk003txzH7I1KpHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757246904; c=relaxed/simple;
	bh=zuK1bnyBywTCsQnEMPCUZSFJUEqxAl5UYK14bjpRXYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oXCoFV93yjhZ46OJPVzPuIOj/uciX1Y6Ue8FTLG0obRpx6DMuxMHnOsYepuLKOFDHXuYmBCK5IdvFCjxQ0KchyZlYaAngR4w1hldkyZvjrqiEeAbk6atNdfQlctXNpqMqirpFCY2nHK3CNI44UsCOK/rW2kihlAttoqD3XeUqgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QeZjtrYh; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2vU/Uh2cf2wti5frlMqgJMd7zwOwN6CGFh80iBZpUXKXelVUSFn1+et9xGTiN63PGMvjPN+f7NQR8+kL6MeQaHk54a2NnWH4ClOJ43WWnoVrBefU2bo5lmnvm1qyvYnnlSvtuXN9UP+01iNO/VIz3lYoYHeq7axisoQx29Vd/oB5M7hIl8jQljbzDWelsQ4lvaRYFD0go3CJf8yh+hPTgogxFG56P3PYrDZ3wjzDnLqKoJraMWjNV5pb2n5yyFBOUZuBww5IGTU/z/vrrHub3CweRd68E+bklbEw1l2z+PnTm4K+KU6gE3m6hkkK3OXikbtFIqZL+Hc8Lcx244rfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuK1bnyBywTCsQnEMPCUZSFJUEqxAl5UYK14bjpRXYo=;
 b=yTsF6AEVseXbGOsVS5k0BSkErmWmfRpRcVs0maywpn6Frnm91JK26Sq7qw1El7V7pixNHXPEvT6DrAyLVGwLFDn5ePNMwwOl9lkMH20gnJteOLv80p1Qh392iid2/08p2lBJatbRD2TP/819vZ19VDeulf4F/2ngPjcPR7ZWLyh69dBmG7P4jwQjIMKUAJJmPgYKWKs+05soATZl94OEAYK1DpTE/3ztgCS0NnnlPDz5cZAkMMCyFHDQgZi0oGHSg8jYF8xaFIiu23j60C4k8rMt3HqCKrV3viQtOG/Nj+cCv1b/+gwGAg9emTiopyWzd5yFlODRAYTauh33LHa7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuK1bnyBywTCsQnEMPCUZSFJUEqxAl5UYK14bjpRXYo=;
 b=QeZjtrYhugoAOt1Gcod9WgTByh/kwl5Kh6ZwrK60aogM7qucZ6PaQFL35YkQn+nP2bI260mlRIJszkgNAceKxlVWQH63KQTYX808Fyul2h8pW1eOzXuTzTA+JyAX/Xh1CVNq2Ybi0y77g2NEWhdxE5Z2KnG0R+TL8Uzpewj1oGAylI+E3npqgoulnE7XDxOh1FZjDkrAUtUpm2Vwg4/b4P9O/WhXWnmGiXvfRm6IamanE1YAEFaqHF2sABOQ17GAE3NiMfoY2Rl8bWOHbDY+nXUow8qTQ+rUFh2P/z7KJEPx72hGEBBCXlRkDtsqNvesYhc8v8aJql2CvbHfm0/zIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB10019.eurprd04.prod.outlook.com (2603:10a6:20b:67f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Sun, 7 Sep
 2025 12:08:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 12:08:17 +0000
Date: Sun, 7 Sep 2025 21:19:44 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Brian Masney <bmasney@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] clk: scmi: Support Spread Spectrum for NXP i.MX95
Message-ID: <20250907131944.GC26925@nxa18884-linux.ap.freescale.net>
References: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
 <20250901-clk-ssc-version1-v2-3-1d0a486dffe6@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901-clk-ssc-version1-v2-3-1d0a486dffe6@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB10019:EE_
X-MS-Office365-Filtering-Correlation-Id: 30454d60-34c1-49f1-b920-08ddee073ac5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cIrQlCCu6Zo7rgR3U3fRmoMb529ekuJ6nHZkEDQaxy28H9QrjcAtTh5P5vrE?=
 =?us-ascii?Q?Ii4qk3DFEvq4I3cHYORkldZJWh2b6z5FbfPTpnouGBKm2QQRB0m8H72XY1sM?=
 =?us-ascii?Q?W9IglcplbiWrXQY5nq7ZJn3vpI9TUf14u8lCWW2Vgr6H98xD9bg1j43EB/P7?=
 =?us-ascii?Q?Oc7+5jH8JgGV7mBJ6cku1CLrCCepIvtsh9VkpzTSZiFSYC2l2f7LeiVz34TE?=
 =?us-ascii?Q?OS/VA5HmTSGPl51di2sLiPUWyd2Xgk2rlSvr8+F9TL4oe4F/oOmqzzxACPlV?=
 =?us-ascii?Q?p+C7KGiesvQqKN+HuX/La7tF7AaCs0sBIb5cFTuZNhJRxpGIltryecDmzMpV?=
 =?us-ascii?Q?2N18cFUuj9yhvnZ/GUYrWnrCOBL7SPuxUbonw7fG6tEz0UVa5SX051FaEQDt?=
 =?us-ascii?Q?VWWZDcbURw2XNjqQCIUDtsMUhPySCr3ZNXL5K1AwaVOR62F/3JrWn5GpgTvc?=
 =?us-ascii?Q?fpaAf0NY1E2WNDpAvsG15qxNQt9IhdCjZpIISG0QyU18Be+1gvcm2YpMa8n7?=
 =?us-ascii?Q?hoJpgdfj4T12uoLP4GPvRFywwu54PETrBPMkIU9OiO5dYBf5l+OK8yweyc60?=
 =?us-ascii?Q?Q2+wnT5fppeQiLR5ZlaePncGsMq1IKCaFBukF3Ua3tN5TN9Zk5v/PJ2bTuhR?=
 =?us-ascii?Q?Tv/IDGqu8deA3zDFX9vAFjY+qxq6XXlpFmi5OYkv3/GJhyVEP0EqD6No1KQz?=
 =?us-ascii?Q?DrR9+7JL66AKP1E/FR73GxZWu9FVvLgnsAFLm/lhrQF4ueS7U7XD7JZntJI0?=
 =?us-ascii?Q?mfQH5jMGVgOyY3NUW6TCjv3DQXjJik6IC10EoaBLyvrMR8QqSiIQnpt1tTWk?=
 =?us-ascii?Q?QVZEtCg1RANRTwvBe0vTD+/NBFix78bZFfb70IrMmuhBYnL1I/kiB2VG3gh3?=
 =?us-ascii?Q?v1K1eMXfzNV1IURs/CDn7Zs5vSPL4f03rgodk3CL6Y5AR+QcLpG4RW/+SmpO?=
 =?us-ascii?Q?x5PP7fji1my6cHTZBFVNLMS/STtYQLT8NnsxruA2WQwNWMRUlttRYfRG8pAI?=
 =?us-ascii?Q?jCvtLgC8FopnWgrdvV/I8xaAmGNrwCbap2XCCKgV4uECe9VfwXa/uQpviGG8?=
 =?us-ascii?Q?B//LJmpgxaY86BEUxdudI7C8WqlEugom+fKp7wPpJ2D0Apx7S1LJGEu1YyO1?=
 =?us-ascii?Q?B4KeqEHP1U89tc76+0Dr7YYs++qeY/xfNCy2yGY+sBvwMF5zqdf06cIGjEEP?=
 =?us-ascii?Q?yoGEsTCJMKzPq7LDhFvP2w+VEnnyEh+ZAukTCg8R38RaNQwdzKiSMK2Inf2K?=
 =?us-ascii?Q?ZIhNEHQHTT7CSa+wM+xBNEkc/PEkVbsBfYnUS04hqBKw8TGEPuWrsxjBqdXg?=
 =?us-ascii?Q?Hdvkxd/CUZ0m5bQeFuQdYQlBQiJnX5MRagoTpOR+UvYKbQSv9M4vDUAFTCK1?=
 =?us-ascii?Q?2draBpphBDBx0/ONRt3XR702AM3fHoz04sBTWTBx3EQgkhjj01ozesKUrscT?=
 =?us-ascii?Q?A+CHw76tSPEEwmMP8UtuWvo7RTAvoVfPIGeY9L7++HOIA2pVp9ffCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GpWF1Is1LukJc+qDRvxyyOqTixFHB2+Qz89aQIo80i+LN/RNO+TNphgY1P/Q?=
 =?us-ascii?Q?i9ff+v+2xbIppH4qxndXbjzOdOdFsf9fot9Sg67Q5lUY2CUVAOfMX25EBPi7?=
 =?us-ascii?Q?W7TTuHipAZGx1HJQXzmEZxXH+mRqhfn+PttgZZZeG+Jq84uLQV117uw69pJq?=
 =?us-ascii?Q?05LoK7bpqq3Z+IRVu1DDNXOtGLpk71A5CirfQJGNXwhPhxLVtDGZDTqRtPEn?=
 =?us-ascii?Q?H7reWv2idOPjzWdox2RbyeXbaBvtPzHcBKkR3esgWmtWJUWJEC2Lyp5uX9Na?=
 =?us-ascii?Q?7x+1Rg1u7EAjZ5wVHWKXRiCnCpsvFAfb1MtnUR7xU03l8ZfSWjUedughZPwr?=
 =?us-ascii?Q?59WwPB8X/6VuWUii1JGsyfk5yiXUHpHnBEWuNFq3zPOiC55XcBuRP7JkWaSX?=
 =?us-ascii?Q?IUI8aSX2GGfISsA6IEvjOFBIKatQAESfup12Ge0vRqhNnFqFZZh+G9HJQxfz?=
 =?us-ascii?Q?2hGmOQSljLzPUXY8AXySACDhw6k825AKxRiw+Kjqba78rXy19aWNHjY//tZt?=
 =?us-ascii?Q?oHUPQrPw3KOJQ4i9mPdVPYhFlASZtLEDaRq2L9dHYYckQdGn98c5BW1GChYS?=
 =?us-ascii?Q?mOoY947f1o0w//V7zGmZ8X4VFdeleken+1ky3XB6m57N/3Qaq/6FLCS5HzRo?=
 =?us-ascii?Q?e/+WHfAI4miHBrW0lO2t8agVQBacdEi0MoLZGmct+TMyrKuqBh4ZGl12hnhq?=
 =?us-ascii?Q?F07vOe75UVOhvBa2pYmH1t9cxYovooojAGXqvsCsXDCjBMpd8HprsoTFUNvk?=
 =?us-ascii?Q?v0fNK2ZLXH2pQZRLjgcoXohQwOBRC7BMv9b6uj/EpeTonP9iUA+jjTRNjsxW?=
 =?us-ascii?Q?g7dAg4wlpYrUwiViiKVDQQ1pRbLS43JGkeubGUxqJp/NwAZzUdaGzCeQmCx1?=
 =?us-ascii?Q?FKeL5/i9QzStU7B5fUsErNlbmqa74fT6Wf5xUuDX9p+3HWkm7kGkRpVjkcRT?=
 =?us-ascii?Q?zqL4+CVHqHe3sfNb4sb6+On7wq2HKQIT8x3ATEtHw6IPtQYmfwtBTwqxQWSS?=
 =?us-ascii?Q?D2E5xAzKJ2vzBaZX/pmu6pMxgaeaoGjdexmp9VYuWUW1QMTDsUB4OK7KMEkL?=
 =?us-ascii?Q?TTv7r34MQ1a9cww524B9OFuxPlyl3H+Z0xV2vGeKPJScJAaUY5wHk7NM9uby?=
 =?us-ascii?Q?Psk/4lB+54BiLGU/qyRyeXQ5hNVBPUjQ+swa2WFpRIl8py/5400kHXbixu6t?=
 =?us-ascii?Q?71Hm3hAA88edoi0SjAyXccXXx+99ewF5TxK1XDrZATnlGmeICgxirYIGy7+E?=
 =?us-ascii?Q?eDeAtmNCPA4sLKON24dQ35OMErjQ4JDtrK48n3YRtkN65QNmv9+S4jJ7pMJ0?=
 =?us-ascii?Q?ij9SKdtWhNAGm11AjgWSBRNOG5fH8M5EpLNmbn+AvyoUjhirOKXMeZRTDNkm?=
 =?us-ascii?Q?coCM9xLCKmxFtu4J4/xn8N7IJt7R/RDOqCKLSiwfTft5IcocYtejxvtzRdGz?=
 =?us-ascii?Q?b0fHPjBJDO9t0WmGJ46ne6q3bNmSWerfSGRLQb28pwkIYIaYYJK0NU4eDx8G?=
 =?us-ascii?Q?Z6eQM2TYTlb2fXGyq+s0KatqxiO2Ap8R/6Sow28Jgb9EyQuclfpQPg2pRZzW?=
 =?us-ascii?Q?UQliF/ei2AsRihFCTcWK3psmDCAUEwHxHb8uimQP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30454d60-34c1-49f1-b920-08ddee073ac5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 12:08:17.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXyy7UlNJfmcTcQKgGy65ZFnKfdqVaSr1rT1McKlwemPgolX1dPjwdmn4ACbLxFF9GX8bFIysT0tXH3icxGKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10019

Hi Sudeep, Cristian

Hope you're both doing well.

I'm currently addressing Brian's comments on the other patch and preparing
for the v3 submission.

However, I haven't received any feedback on this patch since v1. I'd really
appreciate it if you could spare a bit of time to take a look when convenient.

Thanks in advance,
Peng

On Mon, Sep 01, 2025 at 11:51:47AM +0800, Peng Fan wrote:
>The PLL clocks on NXP i.MX95 SoCs support Spread Spectrum (SS).
>This patch introduces scmi_clk_imx_set_spread_spectrum to pass SS
>configuration to the SCMI firmware, which handles the actual
>implementation.
>

