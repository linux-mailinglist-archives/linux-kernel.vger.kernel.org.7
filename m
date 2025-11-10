Return-Path: <linux-kernel+bounces-892685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC9EC459D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0E924EB87C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667E4301474;
	Mon, 10 Nov 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="acKu0qcS"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6B30101B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766592; cv=fail; b=nlcCRnm6SXQZV9Mm8b0ac8IFlXoq35fea38qEtfXsQ9vN/F+PhGn6vWq3LYl7FjD1tVXuXDDRR0E953NqqmzPoljL3gcGiozjUygXuNbafoafI4nJdIOAnCX+8lcgc7xgc78hbIdrGm02C7U9PrV75ltIYFprvPnk6P6fkCkvOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766592; c=relaxed/simple;
	bh=AUHDWC3vD2lMMY/qBAujQKv3mX12AYUqiNkQiqpz+Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LDlRTHUjtvDewglmEK7Gu5tMWuJXUiYSaa2d4FIbTfaHld5C1lNNSOQTwWrSgeYSq8jYGj1vICRynZ/h9NrHkIenf16+NzvnexcUbv1U8tiMwQ9PUUBSrd2bWvxbZbapEgg5zv1a0YoFs8cLNMq9Rn1H9v4gUM12b2Kstv84smI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=acKu0qcS; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbKaLzvBsNGHvTjOWhpMg3n3ZY/HLkmswzj7OUrAoaxMka41D8t0HKXDjaPtpOKy2iZFFmyGkDpU+lbdKguj/yWGKJraVOOUo5LiEJaDDp5wo4cQYwXhIr6MHSj9gYu8mvBHZfxnPSTFMUjY+aSDy4OyY+n6fcL8vBA+FCTQXK+yoj9J7Z8XupQCM584QFxK3bAzoRNUvcvz/xzIG0sKKipV0mPxKg4jwKVEfWnNRM54I5t3Fs+En6CvscdBJpXwh+EriATXLyNqRZS/reNvb1WnVs3rE5qmu3KhPi3NBN1cL+qYcs7q9G8RMKJjXc2lQqeVRucGPxUSc6gCvwn2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbDlC8xSn6c5iXr5wx1lcDPdXPfAGkLLeeLhcV9fr/g=;
 b=bnIWeVMedwlfwVUXHmcoKtwn8il4wDSfSzTxoKyU71gKDt5l4fJbj5KYxckjx1+BcB70PhjkmFDYK/TBTTRGhkZuXXicQUzENRHz7c1qOOzb3Nsv70E4gPm5NNPkE5Jo1CdVYkLkNzpv5v3+TavFkrKleuU/gxFbboKhXclsmq0LMoZhxJlv76TsphnGzulNgAG+HzvEmS0TA1Ov4eXEBgGxuqBbrO1KQQaqE4q3f2IOYkxBwVd31iUJypgnZUq1GDmAPcLwh9T/bSsOlvS5hFv0UAQ+FqpJyX+ptXASiCZPkovpoR23SEkOqcuSqJGqvyyII5lbMVZz1n65dupKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbDlC8xSn6c5iXr5wx1lcDPdXPfAGkLLeeLhcV9fr/g=;
 b=acKu0qcScFeJUy1mcBzXBvNGPi5K8P0OujZYrI190pXnVDiZOOczHrNDbo10bCnQwV4oRMp8eiQcrIsAsgLUwVOeRpPh2ia/7HHb2ViC1B/zPk5H3+4ZRou80/FX1gDPS/U9n/lcZ0c94MP/xRTto97Bm5fzhPc2bTGLmnPcPNniQ3nK5XOHB4sG8FNX/vyE+cIGqHKFJ2iWe20j54Tfnx2gtvYxB+Vfc0SwhjFpamBJPCBUBgzU1kfg8aLyonRcNn5MZ2kPjjs8Amm0+tbb2sCHTeWhukSzqyYx4bpmUTHrgVXsgBU1/SkvKAURNIIIzef5O9dxHTEcVYG032IGFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10574.eurprd04.prod.outlook.com (2603:10a6:10:581::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:23:07 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:23:06 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy 11/16] phy: lynx-28g: distinguish between 10GBASE-R and USXGMII
Date: Mon, 10 Nov 2025 11:22:36 +0200
Message-Id: <20251110092241.1306838-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10574:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e4dce0-ee65-4e48-1c35-08de203ac189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tw1PNZFAAZpZdUM0tr+3bSBs65uIU31/Jm2ggjEVuKGFyagq9biiq18n9geT?=
 =?us-ascii?Q?Bi1ok+SLLOVosolGzJjswilcakL/HFwUa40r/irtu+2nS0qU8SLvW7ekqRh8?=
 =?us-ascii?Q?g0SAAXfrFu2aTRwTDchCT1kClGqdoR9leGVyGsjRFjwW0jlTGehFqLUyuJPI?=
 =?us-ascii?Q?4tKUzsgfBvHtAgIyyNEguuqqhcF9KvjLTcZVBrbba1RY+8t4YTdkBkK/aBPC?=
 =?us-ascii?Q?WfhG1CnzeKHaXRG6yY1kpZzUtwB8FbzvR9v2ZpOfFuJa6c88FXnrWquvvrIL?=
 =?us-ascii?Q?DjmcsuBeVBprLVOFuBLR05IcdB1Dl8nUZL0dr+EvxND18cuUXMc4coOGQioN?=
 =?us-ascii?Q?JYSfRTgBV/OiE1LcfCL4ooCg/aKDbgUsw/+puSTv3VB963FEyqUB+MiFdqIm?=
 =?us-ascii?Q?Bx6N1PaYSbYKT8BHH8tY9KLERyUfE/gCtmhtLV3dDtyrlHIBctTM0s6wAh6R?=
 =?us-ascii?Q?7ICvdVweBDieTAzK1an+G4tW1KKJtqY/YGhZ2h5pWtGA2QewZ95JlIs0niiZ?=
 =?us-ascii?Q?UyaxSf6b8+d9hmC0QVpoM7lb5dBzOGx0Wl1z4LfffmreruJSpakBf1r+z4bK?=
 =?us-ascii?Q?gq4Urdd3F3WsQL7mQVQlnBDb5a3Ltcsgk8nYG3XzkVgxygfLQatj/zoYkekh?=
 =?us-ascii?Q?ytY/yTadq/D2tNJkIPsIkzIpsUpdduTV26sWQEBksByACJJX5o8ovxq8jt3V?=
 =?us-ascii?Q?slGoCE9b9K8Zdo8+LyEzguxYBhnAD9Rj3Sv0oMIeH9Jsf9+zywcso86IYonG?=
 =?us-ascii?Q?hdz2WYFwIWhM6kg2cHb9Ti43c7/4PSQC5hnrL4APU3ibq4Sw27VR7YeIxTsl?=
 =?us-ascii?Q?dXgn7ZRfaCQaMFNVg5ujCU2KlOwlFaDjcKS1JqueMICPXUp7MUyY7NTPN6ii?=
 =?us-ascii?Q?c8KIGkKN8Y/7UoBf1vEpIyTIglDntXpm7oEd5i8lFjLdbJbn5d6vusbJNkyf?=
 =?us-ascii?Q?dsuzVZWzJ3AEt57o9HlxLKxWR5mC8zho302yAsXU+Mnuo2r8x98Dr90IzOJ5?=
 =?us-ascii?Q?YiPzWDYXU8+nh3/ZSs9WzTHSexZccBrOHtEcxJPcPC5bBJu4naFO4oZv4Xzq?=
 =?us-ascii?Q?pUAjzlHItSALNqE0L2YjPCPERTUnpF6C8s0+IJgMjqApG1ThAe6+Y+QRzPfG?=
 =?us-ascii?Q?hFpQmIww4SSSQ6gJrOgHe6uX/zf3FoNavKBnSPgCIxpC2TSriOWYdWck1u8g?=
 =?us-ascii?Q?WX1HhfTphs3St48Lw1nxW77vCJIhwGlUbva396k6U1va7QvcxLY0D01Z6xKr?=
 =?us-ascii?Q?+oRiHyDO/RvjcQxeXE+/BNKaJ171EXjZku9qxJxEkk2R3dOOEJSVTFxNq6hU?=
 =?us-ascii?Q?YHoTjUYT0tm7uObRmc0xrcvIZuI1CQcPSoGU2APTQ2QEarUBGVdlfOBbG4MM?=
 =?us-ascii?Q?vhBF0yJ6lJiQQ80F+7QGfimPJgVJY15RLTs/XXHfKh9DWsxzd2S6qFEf13w0?=
 =?us-ascii?Q?9M6UuDLEC485rWcOATtCWuqbFB5Thpj156BN21142OGO/Vfnau1bWPeuzvhs?=
 =?us-ascii?Q?wUZbSl1x5EoCqkIqekAz6cXj6KH73LwuXoUX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gknYN6JUax5Apym5PG439A9RMlco4TKMaNYZItNr1zw6czHwqQaTTaCEkV5o?=
 =?us-ascii?Q?QxmIf98glXNYuLlR/mmC17al+5g3NfYXWHvuqWDyfQk1t2m9K/stgRHrA1BY?=
 =?us-ascii?Q?f0dfjHDkKDphl7aTzrCr5NyOrEbC1+3RkJHt0AcKKkzK6DvyyzE3KksqYWIg?=
 =?us-ascii?Q?tZXZgtB4V8H7oL3piP0LYBOERaH765m203xQdLPW9ZIknCPJQJEBly569bY5?=
 =?us-ascii?Q?kz0FiTEmva3MYmEA3KAruNEeBWC8WgWq8OrXdHmCRgMxCRGHk7NGyuSR8JeI?=
 =?us-ascii?Q?sOfz0vpMgglNphpd8562dR+mpSjoMWhDFq+KuzSxdzVUtcKVw+4o5Uzcxb4u?=
 =?us-ascii?Q?QsqWf870bDls8W33u94b21bx6oHECgdI9dQVFS7ro8JfM3LiLGv0Pq4m1561?=
 =?us-ascii?Q?ZmwermlLwd4q11j4ErstEXx4jvZGfsXI7C1f1PyqhAXB9H+LnXZ9mcryAM+k?=
 =?us-ascii?Q?4fmHSRnLHfX7NQEgNsmfsC15CVKG61wTA2CLvRJT5D+UENGt8/94xAqWKxcK?=
 =?us-ascii?Q?tLCtAmlhb4lKXu/+k8cJXtLnIxS+PlwN1OG6rpIowNF5scdcZiKXKAUJqSTX?=
 =?us-ascii?Q?eeHc6JKaV1gpRM4VRPQZspuCvXZ+JSQ0GkExKUJyvYa0dzw633H41+jXlgLO?=
 =?us-ascii?Q?igCNO22TRlG+/uOv0MPLIUpV+DhCZcrE4vOeZGuWgetZnMIuRN3e1JngsFH5?=
 =?us-ascii?Q?/FxtHbDNoSN3Z67aPUCtX383ItwEbYW3Y1qy6Bnj561XVvWYgEsAdAq6N7M0?=
 =?us-ascii?Q?3pgHMjcgD6RdOk4i7Zn+Jm6wNTDxSAjTn8SBOMwfHyWWTfQmk8j535ur/cmN?=
 =?us-ascii?Q?XyhHL0wyLS5PZ4EXNBliLTqSJ0zfHtSD+D1kNvlm+Op30u70G6o0IjgJ2nHB?=
 =?us-ascii?Q?ZWaAWliwHeHNLfgSRqfRuQIVe05tnx/fJl2fvcWJKP0xcNffRYM2IBh3XV/d?=
 =?us-ascii?Q?i3XpCatRUXRksat/my5RLc5j7ge1cqbA/xUP3GR3oK2TBb0t+JkOOFXkNPpL?=
 =?us-ascii?Q?jzLMfhxwOsD13PlnBSIDtXchO4q4PwmT2TLgBS7v+wU3x+GTzlhA2tziFyr4?=
 =?us-ascii?Q?2pSVmvAKeXMlQKj50Nleh57hy91LhCxbWtk4Z2JEN3nhWX6KsNfIxCgtDBTC?=
 =?us-ascii?Q?tnZwi7AZFx7LMSMRj1PhN3LHTfNZH/bnZopdIsm8ntRwomYc6oDXJUdwp0yL?=
 =?us-ascii?Q?RqRx1h1ja78YYkgrfVHWP+Gbz5VjIRCSW76FOkIo7mLWvKO2HoPA8EIZ5oAZ?=
 =?us-ascii?Q?OfHeaV2V+bCz2w5HIH5ctEszCgGH646n3lEjf3Yj1cwWFljMwdPZunZdkrYd?=
 =?us-ascii?Q?bVeeRYgGA7kN0BTpuL6CBlQk0DQOWEsd8VXUaaYjVAjMCsucAkNEb+XANUqS?=
 =?us-ascii?Q?fnDlO4CrpnM5XVFNaVwAq841CsgtSmgxdl82+n+WUdHbq1rwbfPItYqg8xmU?=
 =?us-ascii?Q?U1tJ5ZwOYac3atRF2XL1lnaLCifwre9Lv06DR6cE01RjtP2SMiXtSMOwvb03?=
 =?us-ascii?Q?C9onRB4qjFKQovzMPYnF0nu7S3bjQOagAYdHpLY1LjgWuYmAaDkWwfZL4Enb?=
 =?us-ascii?Q?hGKOtPl1VZUmYwRUyVYUFUwSsxVg4tdnJOiRKUedq5aVzm9gYFMjs3g+haNT?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e4dce0-ee65-4e48-1c35-08de203ac189
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:23:06.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ot1n9403CLf9Rejouacro/twtVbqPikaSyC2mjkq8dX+s2m/h9NA3mQg0vFYlZ92o3FAHXc54phNGIBiYHq8Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10574

The driver does not handle well protocol switching to or from USXGMII,
because it conflates it with 10GBase-R.

In the expected USXGMII use case, that isn't a problem, because SerDes
protocol switching performed by the lynx-28g driver is not necessary,
because USXGMII natively supports multiple speeds, as opposed to SFP
modules using 1000Base-X or 10GBase-R which require switching between
the 2.

That being said, let's be explicit, and in case someone requests a
protocol change which involves USXGMII, let's do the right thing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v4: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 87 ++++++++++++++++++++----
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 2b5dbc0361a1..9c78f2db631b 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -246,7 +246,8 @@ enum lynx_28g_proto_sel {
 enum lynx_lane_mode {
 	LANE_MODE_UNKNOWN,
 	LANE_MODE_1000BASEX_SGMII,
-	LANE_MODE_10GBASER_USXGMII,
+	LANE_MODE_10GBASER,
+	LANE_MODE_USXGMII,
 	LANE_MODE_MAX,
 };
 
@@ -316,7 +317,35 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.smp_autoz_d1r = 0,
 		.smp_autoz_eg1r = 0,
 	},
-	[LANE_MODE_10GBASER_USXGMII] = {
+	[LANE_MODE_USXGMII] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
+		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
+		.teq_type = EQ_TYPE_2TAP,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 3,
+		.amp_red = 7,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 0,
+		.exit_idle_flt_sel = 0,
+		.data_lost_th_sel = 0,
+		.gk2ovd = 0,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 0,
+		.gk3ovd_en = 0,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 1,
+		.eq_blw_sel = 1,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 2,
+		.smp_autoz_eg1r = 0,
+	},
+	[LANE_MODE_10GBASER] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
 		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
 		.teq_type = EQ_TYPE_2TAP,
@@ -413,8 +442,10 @@ static const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
 	switch (lane_mode) {
 	case LANE_MODE_1000BASEX_SGMII:
 		return "1000Base-X/SGMII";
-	case LANE_MODE_10GBASER_USXGMII:
-		return "10GBase-R/USXGMII";
+	case LANE_MODE_10GBASER:
+		return "10GBase-R";
+	case LANE_MODE_USXGMII:
+		return "USXGMII";
 	default:
 		return "unknown";
 	}
@@ -427,8 +458,9 @@ static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
 	case PHY_INTERFACE_MODE_1000BASEX:
 		return LANE_MODE_1000BASEX_SGMII;
 	case PHY_INTERFACE_MODE_10GBASER:
+		return LANE_MODE_10GBASER;
 	case PHY_INTERFACE_MODE_USXGMII:
-		return LANE_MODE_10GBASER_USXGMII;
+		return LANE_MODE_USXGMII;
 	default:
 		return LANE_MODE_UNKNOWN;
 	}
@@ -496,7 +528,8 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 		break;
 	case PLLnCR1_FRATE_10G_20GVCO:
 		switch (lane_mode) {
-		case LANE_MODE_10GBASER_USXGMII:
+		case LANE_MODE_10GBASER:
+		case LANE_MODE_USXGMII:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
 					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_FULL),
 					  LNaTGCR0_N_RATE);
@@ -594,7 +627,8 @@ static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 		pccr->width = 4;
 		pccr->shift = SGMII_CFG(lane);
 		break;
-	case LANE_MODE_10GBASER_USXGMII:
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
 		pccr->offset = PCCC;
 		pccr->width = 4;
 		pccr->shift = SXGMII_CFG(lane);
@@ -611,13 +645,32 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 	switch (lane_mode) {
 	case LANE_MODE_1000BASEX_SGMII:
 		return SGMIIaCR0(lane);
-	case LANE_MODE_10GBASER_USXGMII:
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
 		return SXGMIIaCR0(lane);
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
+static int lynx_pccr_read(struct lynx_28g_lane *lane, enum lynx_lane_mode mode,
+			  u32 *val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	struct lynx_pccr pccr;
+	u32 tmp;
+	int err;
+
+	err = lynx_28g_get_pccr(mode, lane->id, &pccr);
+	if (err)
+		return err;
+
+	tmp = lynx_28g_read(priv, pccr.offset);
+	*val = (tmp >> pccr.shift) & GENMASK(pccr.width - 1, 0);
+
+	return 0;
+}
+
 static int lynx_pccr_write(struct lynx_28g_lane *lane,
 			   enum lynx_lane_mode lane_mode, u32 val)
 {
@@ -829,8 +882,11 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 	case LANE_MODE_1000BASEX_SGMII:
 		val |= PCC8_SGMIIa_CFG;
 		break;
-	case LANE_MODE_10GBASER_USXGMII:
-		val |= PCCC_SXGMIIn_CFG | PCCC_SXGMIIn_XFI;
+	case LANE_MODE_10GBASER:
+		val |= PCCC_SXGMIIn_XFI;
+		fallthrough;
+	case LANE_MODE_USXGMII:
+		val |= PCCC_SXGMIIn_CFG;
 		break;
 	default:
 		break;
@@ -955,7 +1011,8 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 			break;
 		case PLLnCR1_FRATE_10G_20GVCO:
 			/* 10.3125GHz clock net */
-			__set_bit(LANE_MODE_10GBASER_USXGMII, pll->supported);
+			__set_bit(LANE_MODE_10GBASER, pll->supported);
+			__set_bit(LANE_MODE_USXGMII, pll->supported);
 			break;
 		default:
 			/* 6GHz, 12.890625GHz, 8GHz */
@@ -1000,7 +1057,7 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 
 static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 {
-	u32 pss, protocol;
+	u32 pccr, pss, protocol;
 
 	pss = lynx_28g_lane_read(lane, LNaPSS);
 	protocol = FIELD_GET(LNaPSS_TYPE, pss);
@@ -1009,7 +1066,11 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 		lane->mode = LANE_MODE_1000BASEX_SGMII;
 		break;
 	case LNaPSS_TYPE_XFI:
-		lane->mode = LANE_MODE_10GBASER_USXGMII;
+		lynx_pccr_read(lane, LANE_MODE_10GBASER, &pccr);
+		if (pccr & PCCC_SXGMIIn_XFI)
+			lane->mode = LANE_MODE_10GBASER;
+		else
+			lane->mode = LANE_MODE_USXGMII;
 		break;
 	default:
 		lane->mode = LANE_MODE_UNKNOWN;
-- 
2.34.1


