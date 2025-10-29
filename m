Return-Path: <linux-kernel+bounces-877103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F293CC1D334
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B7E3BB9BF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B33836335C;
	Wed, 29 Oct 2025 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bo/XF8CO"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260A35BDDA;
	Wed, 29 Oct 2025 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769706; cv=fail; b=i2PFG47+waDm01Wvpa7PjBzns9Xw8lz85FvnpaIlGDsHQXmWoAXTu5adGeSdqeps0B2oJE/T4KJ0bnwBW07mNL/CrRBwDakmGSlnIXOjOlpXuKMluSFivZeKDSgtYrmPsmcWaiq9Q9HIglzarBICrmW0CnFKOq3H4/z2kENCEBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769706; c=relaxed/simple;
	bh=ueN9vgJ7p11KcAlbebayhbRxCU//p48iuu8WqN1BMAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UuovZQ6jKHjv9ijdN1EaI06QgwnpYsSdt16MnJaVptqZU6YzoNDvW5+NfhGmlH0GWq34ttB+ORQWM/B65j3Jr8XqfGXKQKsitsdcXaeFtntF+kSPgx5SrTNTsoXdY53qxveXE7OmwDTvPvUbXPOcKikiewUGKVh7p2V4JaCLwR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bo/XF8CO; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvkgmsi/ITgs/L5Wtu5AdIW1Lm+atU3qZkWlyozWJdaQUp+S+mrePzjO1PjHG9SPptN1aS2Svu3VwfViW21LX1Y+Wwp3hxWVyugSVXohEvl0iqD/ZVzE743uvKJBSTUlkTrdcNgpmnVGEwYEfneYNjptMf89CahJwQyfchPKYSvCOGOGOqgDGkZZecamMHJelePeV54fVJF524MQEUV1L12Wa2nJbwjYr6HzVhJWsYEsi8AWQQMPkDfDjM1ZC7xyAhCbFGCMH2919bIL5WpVqxPFKABasRc+36QBhcAibDOSI0RV8QCp9WOeNjf7uKH4pW4h82aW9Tsop/x3wh09wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhUgJY0UzEoSTw0gklOZXaw5bPH0dRtItZFM/WbN9vk=;
 b=rGQU3aGreKTZfHQZ5n558OA2dgy/bu4miA4H1pnQRtYOFZu50fFC5AfqaKUgcoY2urflzNQLX/NcGG02ap8DU3l1+THTgh+/Sf4s5FXxukVMSg+37Kcq0uGRdJX5uL7nq4BDGTMNliTNF9OOJX14F8Ihe0+y4C1IIrBRgjI1RgUJvIBOlJl29+JR5/l80j7JGmEZ5xzt2TBiuQYoTYSHl+OXVBN21DYZWUYoPpH/9oCCazJGFsoyME7SRWZE+rp2pQgheU+Edh+Bt2WTf4LPVnmS1cewJIsnBCfYKi9EdONrKryksX6jrAvjo82fNIx6nzsoHNciAK7kWOek/0wSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhUgJY0UzEoSTw0gklOZXaw5bPH0dRtItZFM/WbN9vk=;
 b=Bo/XF8COjrTnWdoWV417LOpAEs9GFcJRPtvAV8exNYQXyNmKU8AtDth+5fBy9lO3LHSdyn7eYgrdnJk77gy6FSNMQglzBiDZ+bSoUkvYPiEk5iAey6X6/F6Z9QTb1gFsm6NjHQE33WTE2veYAC/sJp3Dy5rWCVdxrphBaH8nqkcKk1Ph1ykch0Zse+MMUrgAXf2KbUeH0hMS5eRjg4X28zps5+00cktRlQ4l2MrIzA5N/dzvIKXwbnSAQIMv7esq+as+dGPonbbawywuwKAVuzupVowLEHS1bF55/yTkNQKirxHywFw7gzlNvElVzUNJ8gKpDFCRU+M5+JaNT2ypsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB7870.eurprd04.prod.outlook.com (2603:10a6:102:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 29 Oct
 2025 20:28:22 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 20:28:22 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC32XX SOC SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 2/5] ARM: dts: lpc32xx: add sspclk clock for SPI[0,1]
Date: Wed, 29 Oct 2025 16:27:58 -0400
Message-Id: <20251029202801.3963952-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029202801.3963952-1-Frank.Li@nxp.com>
References: <20251029202801.3963952-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d79e6d-e19e-4e50-39a3-08de1729b450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yYqqItjaGsJIUriTHzkMPB2yfH4nbzM7473wStpp8AFKFfFioDLcCdm4TX9w?=
 =?us-ascii?Q?ok9CbAJ7enz5xSm3567YR/i3PsGYa872wRAp7WnVIDUBrPVenFBQVFf0+xb7?=
 =?us-ascii?Q?JPoPkQrOtkNF3mw2pxjmYAwMz0PFgJPFNmTFQ3z4YqVJM42hF6xGed5mZlLS?=
 =?us-ascii?Q?PVAP5xvOoUQpAgEd4I7BEFf7gi9HK3jFYtdMkGjk/Nwq0XpbvqOgjRILB9j4?=
 =?us-ascii?Q?DTvUQcWaIl0X7ufB6FwtepJb08YPzyux4MiFJiqIPU+jb9CioPk6uzBLYspX?=
 =?us-ascii?Q?r4stykoKuLAgtClji24mIt/zCKPXFPrJ1NBr6uuhmJxHYk/Fe2nyNf/bNE7p?=
 =?us-ascii?Q?74+KfDH7fHA7w2xTa4jfhcBsuwviY6tC+3jR4DfoAwaTwdMiX8cjusP4uKsN?=
 =?us-ascii?Q?7iTvrmBHGf6fsPHdDYc5RxzNNh2i2jlpciYq6yqGQVw1ZhGkYmu3tZYsn8Qm?=
 =?us-ascii?Q?HcFucTivjnug6SPpHE8GjmncAfzGsqo7M3LpzF++V3b2bSpxWC6NwxvS+faj?=
 =?us-ascii?Q?pdD89j9C5fKX4uR/+qRioKuiUUdscsjvNMIV8txY0bZ8DpHhLTCw8OTEDHPR?=
 =?us-ascii?Q?f9gAwNLLDuvHQ2T2QjfEXBLW4seUVnz+SSaQCvoMokpzDu7gNUMvJ1v4qJvF?=
 =?us-ascii?Q?E9jYvbXeYiVFwEKLQL1GsnPdoLXA+lT3tvUYqKvk9mBIeF3JxvMCe7Tef6Ln?=
 =?us-ascii?Q?mDmw8AS+ukLwd3WurNKJ0nFqBSLQNQcXuc9R8b1x3b/A41/TDP3MylGw4IGN?=
 =?us-ascii?Q?dSY7E3AcnyNhxJ8h1bNFayhL+JnNO1y4K2yix1Hnat9O4v3ysemnZnsGX8MO?=
 =?us-ascii?Q?CyNOlznlPES7ElXD49cARMeJ8t5BzQayn2gwsY4OLnRfXD6Lb6dPCoZc1SmL?=
 =?us-ascii?Q?tXYi5FP88pAEgzoKAIzJEwuPa4gNpETxfUTCAh8ftYdEQ0A7/tFQEkhvzK4Z?=
 =?us-ascii?Q?IfOsLaFqPHMYU9R3Nd4AwPTwh6ZPyyhJH5iHO24GcDC2GV5mF7d+URASBpw8?=
 =?us-ascii?Q?vusqV5p/0UHznOn8WJOE1I+JPDeZ8Cc1bY2JYNmOogOfuwEQyfIXw7rLhyHB?=
 =?us-ascii?Q?eMYFv1ON7LjKvR8IgEaC7W0cOqqcqIIey9m6IvRmyOzqv2rwwMnTLtGCUPzF?=
 =?us-ascii?Q?96VibSjqa2qIufmPziEJD+nj0CPkqb+t4An63fx3Klg2+wd4ZRrPHHwE/khC?=
 =?us-ascii?Q?VqfL17pkXSBkJVxnzbIvwE1hfGaL9xX61oUy7Ut6ayu9iSxHUvL5DK1gU0w1?=
 =?us-ascii?Q?CNOvYHq/HQXJKMxRkElv0//y/hvZA70HBk4xb49yrfeeYpeNK8qiTrzw6HTD?=
 =?us-ascii?Q?rif8XaqDQJtez4QqbX1HYKQmt7LQ595cJJL7lYs6IvkLtMJdxVS+7TPhk9zn?=
 =?us-ascii?Q?VtG5aCBD0h/CvM+HzqT5i57iuze5/bihqeiGACgHmJ7LMHSNrWXJk/48EndM?=
 =?us-ascii?Q?MQVABNoLJfxwlpTqN+TrCJmuHaoZuk4KZ+ISvN91iVhUowB46jio3NEiG7eN?=
 =?us-ascii?Q?QlHd3Em2+FabvyGQeNIfIhg8BQOESzSdhrOI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dsJO49jj2tCtmKNRa3xsrXGDS5pzYf7n0rwM0/sR/fcmyz5e/1Y+l1Ztj6yM?=
 =?us-ascii?Q?NgqfFdvauJtA279+jb1Zbf76s0xfcg01bDmLrYyPkn5s4oI2e1fp7amFn6ky?=
 =?us-ascii?Q?ZhDhVNskChihG889Rt2416iPwcwssglboDUXTId4ev13eCvWEJ2jPdU7T/YM?=
 =?us-ascii?Q?MpuDPEh98Wzizt7Xh1a5dXAcKjJLzw8EijB6hRJwqx79IGE7OcBcI6nzyw26?=
 =?us-ascii?Q?NfNSjG2ikq+QBzFz3f/jbVq5+Q4av5zWhvLZjJmQ0OzepeiweNvu63aMq1Rn?=
 =?us-ascii?Q?GaFuOuFQvIPtOYKjWwV7PHScUJOwS//08rj6AuUg0xA2sBKknCOJ/N/AF8L1?=
 =?us-ascii?Q?eKUctTVM+mXoAbChZlX1lRIkfQRJaxWx7EwSk0ERTfT726uBioSvWIourHfX?=
 =?us-ascii?Q?tPCliQZ5uZS6r7cQg+kb9prT20wSalq4wcqDpCumDDCBaTvnQiopdsaPq5z1?=
 =?us-ascii?Q?bw91aCPruIfNb6PBJ4eERz9hS77jNX6leIvx2+J6tq3mPUwW6MaTWiV0u4W2?=
 =?us-ascii?Q?wbDb4Der/fr2RfePWtuUpIkGrdhussDW6tRqoF0gFMpSoCmiraXagNVdby3h?=
 =?us-ascii?Q?+1kvX7ALwpvA/opNn7TGPS9QjafJ9vIWCtlbbIZJyneG2mTKTxo73DAf0zkp?=
 =?us-ascii?Q?7D/ys5IIyMMJ5sfXBX4Vx23l+ocJAnv3y9qxkCem5/8OrvPSni2T2hHvDKpx?=
 =?us-ascii?Q?GDZkdSYgZ8liEDJPwWA7oVXJTQAaInUvWFwv+4gNxZ77Hy/Wi/bk8DgDBFfL?=
 =?us-ascii?Q?mkNGCx3tbil7+Ftz+kVrUOidlwI8ordbNzn86sQD216Ul9kJsOvVo7qY/Wvq?=
 =?us-ascii?Q?XEKT8UwELYp76OuFZX/57Z7umYQ5eqlaicJr/ehh3uCtvtUZGGDMmaM5teRW?=
 =?us-ascii?Q?ZHCFYASuDz4VUcYf6JaHo4RqjDn+i51TA66WHuB8Pl4FNOGSVL8HqdnIynPc?=
 =?us-ascii?Q?Xn8x8CEFyUfzTVM/4FNb40MzDjvYparn72+abT66/inBTW8YTS0TonMmVFlZ?=
 =?us-ascii?Q?zqTJoHRKDdNrwsE1eeYH5tJXlCrLSZBnbAah8MOTl5vtj1CNL/irISsmINcG?=
 =?us-ascii?Q?QRea5F/MrtGqA7RU6Fg38wep+UQq+OqaIk81xmviCa98YX8rcPK97uwai4II?=
 =?us-ascii?Q?PvlGjtzAEcHtEzBNbleNEp6qN/dJyBJq40RH/gkR9PNSXit7/6qPKm/P06Em?=
 =?us-ascii?Q?23Osh8AnQFEolmBSj8ZilDJF/mXd7t/sGM9/EtAtUPxscrq02PLWGZ80QQJE?=
 =?us-ascii?Q?TZe0xnk+9FcjCMIIJ7w3n+VQpx3qLvuEawq0oDxORDNecJuxBanLB71tpj1x?=
 =?us-ascii?Q?naxx6r/w01hpAA/t5+tZkjIwkCW6+pqtc9YOvYaptQFwkPAZk9+QXpBxVdqh?=
 =?us-ascii?Q?pqXwgB2/nSNHPqsYVJTxrtVX6JZjL1DjJ9WKhi4ONLkufudYDVcdpmzfbW5B?=
 =?us-ascii?Q?Rz5UWqxcJ6ye0S5TQbkvMbrGYh7h2duIhYN5ILeB7kav9C6fCzHTBpsuVpgf?=
 =?us-ascii?Q?WLMycZkFjcq9rmUCZ7CaCsnFaNImIyWDjpP6OaECwGRGZyu97bdIvLODDHws?=
 =?us-ascii?Q?8nGmlb+yLXpmlEhji+c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d79e6d-e19e-4e50-39a3-08de1729b450
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 20:28:22.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nkjSEYmTEngvx54Kniw1Y2koc3E5Z3LC1ZEUcSC4vslJL4oatRQFYcU9NuwSbRNcAtyLVvrjFjqEbpa+QL6tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7870

add sspclk clock for SPI[0,1] to fix below CHECK_DTB warning:
  arch/arm/boot/dts/nxp/lpc/lpc3250-phy3250.dtb: spi@2008c000 (arm,pl022): clock-names:0: 'sspclk' was expected

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
index 9790b0a1d6537..77f210a2152dc 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
@@ -179,8 +179,8 @@ ssp0: spi@20084000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x20084000 0x1000>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk LPC32XX_CLK_SSP0>;
-				clock-names = "apb_pclk";
+				clocks =<&clk LPC32XX_CLK_SSP0>, <&clk LPC32XX_CLK_SSP0>;
+				clock-names = "sspclk", "apb_pclk";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -203,8 +203,8 @@ ssp1: spi@2008c000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x2008c000 0x1000>;
 				interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk LPC32XX_CLK_SSP1>;
-				clock-names = "apb_pclk";
+				clocks = <&clk LPC32XX_CLK_SSP1>, <&clk LPC32XX_CLK_SSP1>;
+				clock-names = "sspclk", "apb_pclk";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
2.34.1


