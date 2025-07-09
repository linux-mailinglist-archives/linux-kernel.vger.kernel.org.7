Return-Path: <linux-kernel+bounces-723258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E87AFE511
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A295A1D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EEA1F1302;
	Wed,  9 Jul 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="muLAQf/m"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7528A1D4;
	Wed,  9 Jul 2025 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055451; cv=fail; b=WtIHxdBX7wK4h4tKipidZLdzkves5PHxPHJj0MlYw4/BcJHnH7M1CO1ceaoNPB/55Lfta8NS9+B+EQJ1zgv7y8Ue+cyAmphVenlH0tkUCpbqGPb/JHxgAwI4EM3MR2+vKinv5kbI7gAgp3DUE39RbDK1H54S3ghUoUlS5/tusNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055451; c=relaxed/simple;
	bh=hSVzkrzPfbsCDfjr1ChTuV0cANRvd9Sur99PLJe6u3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DarzR1SPKITrxu4ZA/tfYWmCmQ1uKh7PhtQyMqqXbp6R1qtx3wMu5BRwUr7txaCmGUWknqGQnoWEDV1QusNKNm1YBc9DVDv/3Meaj1BFJf86SDLtcji7xR5Pzm2C73+2uODBV4l1QLIlVjh6dSE3UnsYRfSIFc6wpaJ+9pSqZqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=muLAQf/m; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vM4Q0RFHN1JQ7deQmjF7KIOcLulOqWTUcubggF12/dMaSKDoEdYj2PGIMivYKx/L0QgUoo5EvF3VpJjZ34dgWCi1GOXD/lo+Td5COz1hvylo0/vNuCPNMqYOk0lwMP0HlbIeV6Ju+jjFYC+/BeBvbv8PwUIcddD5eWSyGau5SL0l+MdC0Upe7PIyaqRrSqGVhGO0+yBwFFyEaMLpkGhEJeYYR5WHxxtqlyYI3UgMKP8kXa8r/WGG4eFn2entRhIw116HfZ8Vm7qYvoFaSbC3Hgz9qBB0niQKzkIvRFnw+EDbge/ZK7PQfR3a1kTolmXSH2o3m4pe/u8DUFurZhRrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmslTuu0elrXWxC3BBCPNEjXZWYsx96xoKlz+qSLaAE=;
 b=CUFNKWT6w2nBWoxo4MYKkWGz/hq629PP6CIgiAC4DSJAxDGLsCBFSKZfphB2++QKUmKAlWYySrwU/6cfvWb5u0vPO1kZslE/1OQPVBhTnQoqOCTYlzMV28Un/waWK9mKzKtag3LnXZTh1TVV/HCFxgWxlgbkYpMWT/JklKnkYSV/27ndw7JVs1STrkK27CI8G6KOY1GOgqcnCKOfSni2rIP9kjHMttEvRb3r72vphNPfwc8vpgZU+5+L/0Whf4HgEuePjX2T7NvuCePmB+vLNj372YazqBl+Pu+d9/7vmcez3Tr4v+ENZigfot52rtZBRmQPnJ/N3hm0wTntnXWdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmslTuu0elrXWxC3BBCPNEjXZWYsx96xoKlz+qSLaAE=;
 b=muLAQf/mH1lhBbujP6Lnrx5tYcol3vAHsN9eMPyzaUoBFzVPn4A38PXY4mZwdSuONgz9hv2pTFuyMrhVT3w8fKNDEl0lbpJdvTo5YbXDyJA0lgw1elCe/ThSnMGUTqlCfeWs9vESfzlS6zJ2SX8VjROJ0Kfj80wRLQ0ZHeBJmEBonAGnA6a+X62moV5WmNosVi4sSR6ECK6e8IHqRRZjO6q+1JzZQ577TvdFqJSaE/oJDcvUPfrzy29aApZuMbQoqUvOBBsTJe/NNFo9VINHf/P2W/m3wgA4m2kjUqHN7gGe2F1ROF/xJbZXlSCuI5P9HlldKWnzuI3gWed5CjHTMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DU2PR03MB8123.eurprd03.prod.outlook.com (2603:10a6:10:2f2::12)
 by GV1PR03MB10584.eurprd03.prod.outlook.com (2603:10a6:150:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 10:04:04 +0000
Received: from DU2PR03MB8123.eurprd03.prod.outlook.com
 ([fe80::a4:d971:86e0:ff72]) by DU2PR03MB8123.eurprd03.prod.outlook.com
 ([fe80::a4:d971:86e0:ff72%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 10:04:03 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wojciech Dubowik <wojciech.dubowik@mt.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Tim Harvey <tharvey@gateworks.com>,
	Markus Niebel <Markus.Niebel@tq-group.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Heiko Schocher <hs@denx.de>,
	Andreas Kemnade <andreas@kemnade.info>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andre Przywara <andre.przywara@arm.com>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Junhao Xie <bigfoot@classfun.cn>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Tobias Graemer <Tobias.Graemer@mt.com>
Subject: [PATCH v4 3/4] arm64: dts: freescale: Add Mettler-Toledo Snowflake V2 support
Date: Wed,  9 Jul 2025 12:03:26 +0200
Message-ID: <20250709100341.1492456-4-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709100341.1492456-1-Wojciech.Dubowik@mt.com>
References: <20250709100341.1492456-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0175.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::17) To DU2PR03MB8123.eurprd03.prod.outlook.com
 (2603:10a6:10:2f2::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR03MB8123:EE_|GV1PR03MB10584:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f72b7b-666a-468a-8e26-08ddbecfef3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qA9A2quNaG3G3TOtqAVU6DrlKADD8uQgRhXk98GAVosApAaOypi2KnuaZf4Q?=
 =?us-ascii?Q?J7NKt9KCuFw0f5qCN9a/FdK+MD6zcgOLdmHUFNgJ8XgreMsmg2KV/dxL/NmX?=
 =?us-ascii?Q?7FGvSgC8SC/1cDMb1wWLOvwwD2W3LmgGYjSXrBOUlA5znUigfwT5b8i8+5AK?=
 =?us-ascii?Q?nmhPQF5gfv/uprhg/XOl3N9q8OhKjgWmPZEzeVtatFFaQvIPBeg2jcTeQZCI?=
 =?us-ascii?Q?tFPV5iC/SoEdJrfEqZ8uxdFW/s5lmI2sCUlrmjGDdYSJ8NqaCE9IhV70qlmg?=
 =?us-ascii?Q?Llkzn8HhCyrrcrvnQpmfDB3aHneNX41A2inCRE++hklBqqECFQmc8LvDB/cr?=
 =?us-ascii?Q?BEZhnlvBs5jI0fKp284nXeUBjOrEJGRkuZSzzBbyM4CKMzqPCR09szciTojp?=
 =?us-ascii?Q?2+Gq/y8ndjuA6l4hGRs+kIWtgI8DXgtoondyIBLkGoz7XwpFWUA6ZZViaHfN?=
 =?us-ascii?Q?3nCNTQcuD77O5Y3Z4nOJ3NEuC9glF6CQldv/YVmQbL2KMj6lHqowoXaCRiCh?=
 =?us-ascii?Q?NXBOcEEl5giDteKKUWymflNTW+K4fPFoINt1FBb4W0zfsgEyOjy1uv5IqpqT?=
 =?us-ascii?Q?jhzrtAjtHI97lrvKWAnEi75i+JclWy2+u8dnL8wYoqWvPdP9dQLUMDi3a3Hm?=
 =?us-ascii?Q?ZFENaJRtIn7y13YKev9ozRZIIQbvNR0PN7fcjD2DmniEzDwrQjmRbdyrMfRz?=
 =?us-ascii?Q?xSOPaHqyBUQ27gWlni2tSnILw3Bi/CLGmSBAIIg1X6KEXLXCasPdFlMdYwmn?=
 =?us-ascii?Q?eKUONtZMunoy7IwZTbWKiqtTdsXnOA4M3pOP+smahxfxk1YgNNoptqIfnFWC?=
 =?us-ascii?Q?29v5jhgCkNo6xtVtiRh+HZu1UJkrPFhsOCAFaulMO//9eiIGG0aIsna0JZKf?=
 =?us-ascii?Q?TzDgrdJpzOtzVapwGNgA4KyBtcL9aTLRwMwDFG61uMTZOg/2PnfPyZPQ3+bw?=
 =?us-ascii?Q?THvxLpYBCpUVmW3xN2ikYt8lrE67P9sqWM44qCDm5pYiyGKHg/LJO5nmZGBI?=
 =?us-ascii?Q?bF2WMM3LHT6pdCj3IEuK0hnLOhljgECWDr3KLDQbUJUXuFhzstNHf11QuPdp?=
 =?us-ascii?Q?dud3WFYRjRvi0TYIlHDjILHuXSZO3nted7svoGCCazj2ILkwLWzvdMpWdZ2y?=
 =?us-ascii?Q?M/B2G6Xud8hCkb+kcUwqzLW2AKzn4FQ1J+IBq2p4AXaxzytLooauLstOn2VZ?=
 =?us-ascii?Q?UrFWHrT7Jo2qIr/YO6BvDJ5wNTjqoSq4uW6cyay8V1S64ytZV95UI+5PAFxS?=
 =?us-ascii?Q?7hXqmzouHVxW4GVO176gMB7LYt7SABd0hrE5c3pmJVMXtN5DwUw1nrRhvnLH?=
 =?us-ascii?Q?YLJv7+TvFS68E4Zqg/Z3MwyR5UhqcwSdjPdHdLMSan0exPRo7G2YkEdhKG/q?=
 =?us-ascii?Q?HkFjHCm+l5gxShl5CfeBxpSS4S6CjMiD+q42x/DsdNN55SefVpJgonmHtqpd?=
 =?us-ascii?Q?/oRe8omYgM2qn/NsVD0LCUVfIsI0KEpoFp8AZs6xqEQM5igmPVfKjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR03MB8123.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?248z2x2YDvvNWg6TQOqF3ZScQcW8WWzmwm1ns99LZh8P6j3yPmjYU/6ziVg1?=
 =?us-ascii?Q?iS1P1SURAJ/0aVwzWU0MO7siIeaNkIiNIUAhaZJnWZey2WKY+IUL9WyVrlYr?=
 =?us-ascii?Q?JaA27btK0vj+hadbmVA08bfDlN+eJROqhBtPTuGw09AUI1TQuHVbMKhV+LbE?=
 =?us-ascii?Q?tTVxPQ1NPJ9Tv3kGvjsc5Nu6IaQvttzJZHaEOQV5MxjyIONwg+CkuO6hCK/P?=
 =?us-ascii?Q?N1xcAzCM39jVnTkQaoFwS39M+2nbv9Gi2RiqKL39vGlVhmZC9TLXbCuXua4o?=
 =?us-ascii?Q?LucrXZfxM2eaimA2ebVWMeVgj/OejU0j5suT+E89sOTd0Uvf0TT7JZ6F9X7H?=
 =?us-ascii?Q?Krn7tLqorSW8Gt/KMAyKgUS8qZ3LvlpFpRzisbTjMMKyMAUh3k/civLou4F+?=
 =?us-ascii?Q?UxYqY4iDkT+A3KQRWr0oJHsD8ZbU8I0ec6CJxKFeMHFK6jFu2BitL1edm45l?=
 =?us-ascii?Q?cekCKmOeyGz+fVk8jehRqw4hdrTt2KE4Zic79zwt1Gt84zbSz3pL2Ym1T4IA?=
 =?us-ascii?Q?eK08FW5ZFwuDwXX0WAVqZAcfhBl7NKgtOg+7iKv12DlJ/JnwjqfMXP7RaDUp?=
 =?us-ascii?Q?XbcfO3/jj5eBhJMsr4NcCBHkj1epf36r2GroFnrIiWDBKe1hiceTdgl5SbZE?=
 =?us-ascii?Q?li7YyYT1gkzALH4eCFCpC3Tm2m1VZ+948nYxsmpnsyptGko3V/cBJnZkHa4B?=
 =?us-ascii?Q?y0cGyGchrnotm56+snFdwMvJDxmNMD6mZPjjcsrgproLpUvsl+Qm6quWTDCk?=
 =?us-ascii?Q?jrjNVaANm4DBj1cEWBEPGJ5yqOnOjtGrwAfFv52O+g2KHiER2i2v621jyjRs?=
 =?us-ascii?Q?9drZBZvGJ6CKEEQrCLGJFSE5eg+Y5WOIoDUiWAXYjww1MQqma5J1QcwGHZnb?=
 =?us-ascii?Q?9MwsNEhnbO4HKF5PjM0nzZcx/8SoSQ+RMXkldhyEynljSLn4Bb6LczNiW6/G?=
 =?us-ascii?Q?qZQTwu8gvUpW/kdhGDmnE2comPrgc5P9jj8GafaHYWBQMIYLkUSEsMPX1gwM?=
 =?us-ascii?Q?nK3bSWdicU8J9xyR/lyrHdtK2lLheMMAQd0afOoTCvBtxEWLh2AlLnybsiF+?=
 =?us-ascii?Q?m5aMSp7DlHgNGPeJZxfeZpbBGbZHnFqvsPfdPXOSBsOZ6CdL5ElV8NH51R14?=
 =?us-ascii?Q?5YawF0Tstlq+RhOMcSgH1oJknFLZn4y3HbJM9p05XaxAs9Of0LfymW6RVb/P?=
 =?us-ascii?Q?p6W2Whosm6N6Hh9mqhObtDf74jI9e857uplUXr+DLRfLMBv9BuoSdwQYKbfR?=
 =?us-ascii?Q?kFfbqi0w+OTNpPSu9sWKgNX6LNuyl5gpfVQNebDZHiEAPZ/j4mRFuv+mOpc+?=
 =?us-ascii?Q?c5n+HuTfJAEqB4ewEhpBgRt2/5+II7V0VpMO8aB3cpSjB5sYdJWykbtzkfvI?=
 =?us-ascii?Q?BLRuaUCzM0HLVYrrreWMjXIO4BuIoP4yPTROSbIlj9vr/YzZ+bBPVS7N5Ydt?=
 =?us-ascii?Q?ZVrKFqYZ+Hz+1arh9GX4YXNghKQZR+WcYZP6rjYbZyHV07Lj2i1bPA6lXL0I?=
 =?us-ascii?Q?58iERIbKaZkFcJzgwfo9KKa08ZVnA3Y6YTSTY1rRgqbtyvGAeybv3lHsaFOv?=
 =?us-ascii?Q?aJ6pMwrfoyZ5ohe5h9hfytihShy5W/TC+AjL/so0?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f72b7b-666a-468a-8e26-08ddbecfef3b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR03MB8123.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 10:04:03.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2SrQ3u0Np3nhKn6FlZ0qUNURDmTXHz9EqaYuEdLlNUgVvWkiAsjvGQc7bMxdOl9C0xhzh5tOXATs8zTMg6LjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10584

Add initial support for Mettler-Toledo Snowflake V2 terminal.
The board is using Kontron SL i.MX 8M Mini SoM with 1GB RAM.

Supported board features:
* 7" Display with touchscreen
* RS-232
* I2S Audio
* SD-card/eMMC
* USB

Signed-off-by: Tobias Graemer <Tobias.Graemer@mt.com>
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-mt-snowflake-v2.dts  | 479 ++++++++++++++++++
 2 files changed, 480 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0b473a23d120..86f2f1580696 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -128,6 +128,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-iot-gateway.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-innocomm-wb15-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-bl.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-bl-osm-s.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-mt-snowflake-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-mx8menlo.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen-r2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phg.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts b/arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts
new file mode 100644
index 000000000000..5fdf2c6adf38
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-mt-snowflake-v2.dts
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Mettler-Toledo GmbH
+ */
+
+/dts-v1/;
+
+#include "imx8mm-kontron-sl.dtsi"
+
+/ {
+	model = "Mettler Toledo i.MX8MM Snowflake V2";
+	compatible = "mt,imx8mm-snowflake-v2", "kontron,imx8mm-sl",
+		     "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart3;
+	};
+
+	aliases {
+		ethernet1 = &usbnet;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 500000 0>;
+		power-supply = <&reg_5v>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <100>;
+	};
+
+	panel {
+		compatible = "edt,etml0700y5dha";
+		backlight = <&backlight>;
+		power-supply = <&reg_vdd_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&bridge_out>;
+			};
+		};
+	};
+
+	max98357a: audio-codec {
+		compatible = "maxim,max98357a";
+		sdmode-gpios = <&gpio4 19 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_sn65dsi83_1v8: regulator-sn65dsi83-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "SN65DSI83_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	sound-max98357a {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "max98357a-audio";
+
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&cpudai>;
+		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,widgets =
+			"Speaker", "Speakers";
+		simple-audio-card,routing =
+			"Speakers", "Speaker";
+
+		cpudai: simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <32>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&max98357a>;
+			clocks = <&clk IMX8MM_CLK_SAI1_ROOT>;
+		};
+	};
+};
+
+&sai1 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&clk IMX8MM_CLK_SAI1>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&i2c1 {
+	bootph-all;
+	status = "okay";
+};
+
+&i2c2 {
+	bootph-all;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	eeprom: eeprom@54 {
+		compatible = "atmel,24c08";
+		reg = <0x54>;
+		pagesize = <16>;
+	};
+
+	touchscreen: touchscreen@41 {
+		compatible = "ilitek,ili251x";
+		reg = <0x41>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio3 16 GPIO_ACTIVE_LOW>;
+	};
+
+	lvds: lvds@2c {
+		compatible = "ti,sn65dsi83";
+		reg = <0x2c>;
+		vcc-supply = <&reg_sn65dsi83_1v8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sn65dsi83>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				bridge_in: endpoint {
+					remote-endpoint = <&mipi_dsi_out>;
+					data-lanes = <1 2>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				bridge_out: endpoint {
+					remote-endpoint = <&panel_in>;
+					data-lanes = <4 3 2 1>;
+				};
+			};
+		};
+	};
+
+	usbc-cc-controller@61 {
+		compatible = "ti,tusb320";
+		reg = <0x61>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbc_controller>;
+		interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&mipi_dsi {
+	status = "okay";
+	vddio-supply = <&reg_sn65dsi83_1v8>;
+	assigned-clocks = <&clk IMX8MM_CLK_DSI_CORE>,
+			  <&clk IMX8MM_VIDEO_PLL1_OUT>,
+			  <&clk IMX8MM_CLK_DSI_PHY_REF>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>,
+			  <&clk IMX8MM_VIDEO_PLL1_BYPASS>,
+			  <&clk IMX8MM_CLK_24M>;
+	assigned-clock-rates = <266000000>, <594000000>, <12000000>;
+	samsung,pll-clock-frequency = <12000000>;
+	samsung,burst-clock-frequency = <891000000>;
+	samsung,esc-clock-frequency = <54000000>;
+};
+
+&mipi_dsi_out {
+	remote-endpoint = <&bridge_in>;
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&gpu_2d {
+	status = "okay";
+};
+
+&gpu_3d {
+	status = "okay";
+};
+
+&ecspi1 {
+	status = "disabled";
+};
+
+&gpio1 {
+	bootph-pre-ram;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	bootph-pre-ram;
+	status_led_controller_oe: status-led-controller-hog {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_HIGH>;
+		output-low;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hog_status_led_controller>;
+	};
+};
+
+&pca9450 {
+	bootph-pre-ram;
+	regulators {
+		bootph-pre-ram;
+	};
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_hog>;
+	pinctrl-names = "default";
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19 /* \SOM_RTC_INT */
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x184 /* SOM_DIS_ID0 */
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x184 /* SOM_DIS_ID1 */
+			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x184 /* SOM_DIS_ID2 */
+			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25		0x19 /* SOM_PCB_ID0 */
+			MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26		0x19 /* SOM_PCB_ID1 */
+			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19 /* SOM_PCBA_ID0 */
+			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19 /* SOM_PCBA_ID1 */
+			MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x19 /* \SOM_STATLED_RES */
+			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x19 /* \SOM_HUB_RES */
+			MX8MM_IOMUXC_SAI5_RXD0_GPIO3_IO21		0x19 /* \SOM_SUPPLY_EN */
+			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22		0x1c4 /* \SOM_COM_RES */
+			MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x184 /* SOM_DBG_GPIO0 */
+			MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x184 /* SOM_DBG_GPIO1 */
+			MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x184 /* SOM_DBG_GPIO2 */
+			MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1			0x184 /* SOM_DBG_GPIO3 */
+			MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x184 /* SOM_AUDIO_SD */
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT		0x6
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x6
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_PWM3_OUT			0x6
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXFS_SAI1_TX_SYNC		0xd6
+			MX8MM_IOMUXC_SAI1_TXC_SAI1_TX_BCLK		0xd6
+			MX8MM_IOMUXC_SAI1_TXD0_SAI1_TX_DATA0		0xd6
+		>;
+	};
+
+	pinctrl_sn65dsi83: sn65dsi83grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x19 /* \SOM_DSI_INT */
+		>;
+	};
+
+	pinctrl_hog_status_led_controller: statusledcontrollergrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4			0x19
+		>;
+	};
+
+	pinctrl_touch: touchgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x19 /* \SOM_TOUCH_RES */
+			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x19 /* \SOM_TOUCH_INT */
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		bootph-pre-ram;
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
+			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x140
+			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B		0x140
+			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B		0x140
+		>;
+	};
+
+	pinctrl_usbc_controller: usbccontrollergrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19 /* \SOM_USBC_INT */
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		bootph-pre-ram;
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x190
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d0
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		bootph-pre-ram;
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		bootph-pre-ram;
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41
+		>;
+	};
+};
+
+&pinctrl_ecspi1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_i2c1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_pmic {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart3 {
+	bootph-all;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_wdog {
+	bootph-pre-ram;
+};
+
+&pwm1 {
+	pinctrl-0 = <&pinctrl_pwm1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-0 = <&pinctrl_pwm2>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&reg_nvcc_sd {
+	regulator-always-on;
+	regulator-boot-on;
+	regulator-min-microvolt = <3300000>;
+};
+
+&uart1 {
+	bootph-all;
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart3 {
+	bootph-all;
+};
+
+&usbotg1 {
+	bootph-pre-ram;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbotg2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+
+	usb@1 {
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbnet: ethernet@1 {
+			compatible = "usb424,9500";
+			reg = <1>;
+			mac-address = [ 00 00 00 00 00 00 ];
+		};
+	};
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+	bus-width = <4>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	vmmc-supply = <&reg_vdd_3v3>;
+	status = "okay";
+};
+
+&wdog1 {
+	bootph-pre-ram;
+};
-- 
2.47.2


