Return-Path: <linux-kernel+bounces-877105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF364C1D33A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71C8A4E12F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC281363B9A;
	Wed, 29 Oct 2025 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OmcdCyHF"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A4363B89;
	Wed, 29 Oct 2025 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769712; cv=fail; b=V0O8COZKB5bX1CjdEVa554lZ1T6RfIHJNdRzPjP9FeQRCm/KZyCpWh7L1c2A553Y4+aiLu0+qIqBBu7Gs90nHffuOG3YcJ0MiccHAaFR1gP607BWEoQSr3G4nEznfUqcCiavV81jEBQFEAsObZm0usYurzPfOaY6SOWZ4J6LFkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769712; c=relaxed/simple;
	bh=YnXyvoGfGEKl+F37VX0Ty0/kyCs5pSfMImJy3mg9hyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/VXXIurzfaGjeoeDNoaZVCsUDm3ZWce6GlucDPby4ECLsJDf1ID986oKWdj1BDRXzE+ydv7q/s1nZV19MmjLSpsM8pCCnKkUW+/g0LFrLeqMGeeR6vACi7wlEQZFMFqbkZshsikwUzoNxXEz0gHq3SKOkOxKPtAH3UO++Aqz0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OmcdCyHF; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHoJu3hLvFBwjq6JpL91ihBKK+r6uH1Gbe8zU4ORdAJ4p0y7sCb56nymENxkyYNwr+/yfquY7AHHTlnNKmJu3Km+FcoYuznQWbi1iAOeB9V03+P75A/cTMDseULFuwiX/oibLqkWnUlH/PIxD0KPyn8edniPyjhV3LiggexuMb62L6MCheQAdv9hvhE0wUGpDBrhWR+1+u18OXJnNMFgUWCUYPZQfatFWP4QYzTDgY86vb20XFwuSHudlIZrZGLbh04RqUHSZ4fiZ6+6vgJUD9eGS44OPtllVwYx/sRDk1RMXRmmcKgEPuWvQSKspwAR8Hb/R8UaZWmxQ43WsRqvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EudCcYlVtXyw+twKLIqai8SjlIks+PwawpG/nzBeELo=;
 b=jDYKoAQOY8g3IYJI2h/P0BZS9bEgUAuEnvSskKmCaBtvUWyvegBZ5T9XbOX+1SVizPWsFYcVRYKxkPFdw5wq5Ccx3ts7ohZxukCSTVdzP0th3nWoa8LtZLUJMIDbrTQd2jvjgT+dWpqcCkm2CYRgtUKowq8TDAr1RJczOpFTjd4mdw/JlRNBErPA4t+jZtoqQQgtY4GKGp644ue8eSqnsG04fqL29y7syCHtm4ic/+PHKNQCe2oQ287+ek/0CFosMPF6871DvWB/QCivve4WN/vr0B/b2Z/skXr2UAlBsaNMhmLYEJUKHX2V+qZ12YfKztYYKJkVdkAcV08uhgEsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EudCcYlVtXyw+twKLIqai8SjlIks+PwawpG/nzBeELo=;
 b=OmcdCyHFe2tC6MwhiwSHSturBS2rbLXH4f0J17uDEAQqJZbKJ9Xx1fwCsrstXqKd5bTmfSERT8dzot9WdD/TRi5K+ukI6wOZO5oc3bj2AFdiE2PTyVOSY++uarpj5ps6SvzqzVhcS4fMr2ES0YPrkRi+PfkPGNNpEX529J4COEON2UBjdpJxqBIx1Qinr3uQ0LG4lXexIK2JJGh1vGFbK/PIxnSU4b64YgfF9T2fbU71ivwzQNTPZBYREIY4Od9etQyzm54Bt+XD7qyw7YXIDXBnQsLWTrDPeKGdoEm8VX+ygIku0apDdBKwEVrbo/ZFqTUu/CIcs3tJsDadpIn/nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB7870.eurprd04.prod.outlook.com (2603:10a6:102:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 29 Oct
 2025 20:28:28 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 20:28:28 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC32XX SOC SUPPORT),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 4/5] ARM: dts: lpc3250-phy3250: add at25 required properties
Date: Wed, 29 Oct 2025 16:28:00 -0400
Message-Id: <20251029202801.3963952-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d4390d7-cdc8-4f36-987d-08de1729b80c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/fzFV+MMBJwVBUCqijE5nnTgJNpwA03TlfQf4VAeAhCtRgx4DE473uz5314?=
 =?us-ascii?Q?VWaUjQmLb/NXRXdEXWSKGwkI84F7j780fUo4rVTCo29dYCS+TGmRLMXtPVAD?=
 =?us-ascii?Q?Kr0gV1T8bV3rPM14pl+dbrBLtkxy/sZ3RtCHxWHNKiF8pLCgnUIoohJhsRQW?=
 =?us-ascii?Q?UgWsmZ0bWCAMg1B3rHi2oBO0CSOZkLXBaJzV+nfNSoYgqPKoYIsKnqLfdtmb?=
 =?us-ascii?Q?i7Ei+/0JFw2+Ut5lEV9aBAkPyVXLx5CB1iZpPw+w2RMlp1Mp9TWlaL8qZztg?=
 =?us-ascii?Q?Y/v/Koe6G6HexvW3yZhFydgEFzJkLFmLNmyVrNP9pfdLhHCuhFsbVGt2EzhO?=
 =?us-ascii?Q?WYRH3td3MGzHX8zqCFPN+au4HM5XsaJ1Vt9WKNB58l2G3CL48RkxPkPinVsw?=
 =?us-ascii?Q?OHu3SqvhnrtMPGQm+IuG9mUAvsZiLPm6x6xZCDwvib1+1yF+sjOU13VhNpg7?=
 =?us-ascii?Q?w50TM7HcCeW7H0iqR6I8h2yRRYGm3vTWkl3u8wG9ENUr9w6/Cilsj5ghWBr6?=
 =?us-ascii?Q?oYiBOAmYwnLRiC5TGrPBYJ+GJHshPnt6nCzBYpB+f1U3NM54w9b6VhVYoQEJ?=
 =?us-ascii?Q?sh8w1//18grz0MnOaKRhimCt9ljmcqHpfSqFFuE2qJMS3XzLa6AMGHdIkUrC?=
 =?us-ascii?Q?Pni9FPUmS7bxBTDpF3nzOnCFZbEiX1jVQmyPHNXmtKMDBFfD2xMMJNE3O/TP?=
 =?us-ascii?Q?au9lBlShWwaKHEUz6xqq82JPqZXZl/0P34xjOtkVRiv/nTWuNI0hh0QkZ3pU?=
 =?us-ascii?Q?EUeJj49RAD6+trUEIdv8EnUlofVc2j22eSNjpsdh6Dr++QYT1xymIfTd7zk9?=
 =?us-ascii?Q?u8Ccplj/LrjkF+efMQKGPL5zEVpuf3RBvttcC9eJXxzFrzIqrUNSeW+JlABi?=
 =?us-ascii?Q?qCU0ySdLvTSTusAoT+MVRRDCTpAZ/scHERH7khtYzBpvg5TrsRpfgKqoHNhe?=
 =?us-ascii?Q?jD+D95Q3Fni0NfvW+6RFfDow5O0W3aWkA5OYMYoO3WJcEoi8XbQlhGESAPg3?=
 =?us-ascii?Q?4oHPUoMJwDSlGOyMkaIYj+4Kpr1st+RaJtFPK+tkMB9S1IrUnNrO/fGkdRJg?=
 =?us-ascii?Q?9ji9lpQZkN9vdWHLgFGtDm+nCyVxJR1b1+S5l94NwD/OfxecZo0AGX7SxM24?=
 =?us-ascii?Q?F/h4f+YR+xEcSkD5DubICiLpqZ9VS3lNE4ikDkfkh/U9LEqh4fCTpYNAX3fN?=
 =?us-ascii?Q?ZTRvVm2p/aKG4WGrmehSofXX4CWxzNcJqmMaUlWDmXIC+N1UCzN1PTy3LnZs?=
 =?us-ascii?Q?X354ztp8k61tx2Mk2KujjuOGQ2syNzESmCZsiiGl2EYuU+p+nHtFWA2oPMl6?=
 =?us-ascii?Q?9lejVJQbYfE1i07EobWj5tMrwpVGrhJb7Tih4Au+XRsda8GSRaccBmrmwk6T?=
 =?us-ascii?Q?oOVPcrxfW+xb1X2KAmk10tjPzNWfqDv+1AuR9U5Fyd5wtlDZ/JvRcI8SsOpO?=
 =?us-ascii?Q?/Qa+9uBO/ijokcjxLsIxDla9noVtP1IB86YSvx9WCRdCpQ8lUMjXvY5KR86K?=
 =?us-ascii?Q?tj+o12Q8TTMd0CTBwZT9JJUscz55AAaPOo1M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?suPTwpfIKBGgOVGZ9KiNiwsblebWEalrUoAeS8HNP2dgmDGQQerOWNMPwzrM?=
 =?us-ascii?Q?gmf2UA31Kn4XTCEOJs7bmSfAXR6//Rj0ntAP0n1WlM19XynZ2hAJ2GR12kjS?=
 =?us-ascii?Q?4Bh3xicJBpD5nO4g4tFPmOwtfpf9WmLr4uvHdmAZ4JK+hoceq7fOyxYaqfmq?=
 =?us-ascii?Q?CiQG643arLij0ONcH5xEtUNZ6bRqCCNvwCczVq90SryK2a+LeqRGH30SDkIC?=
 =?us-ascii?Q?ZfYDD0y7O6OEQkmYZbc2jvF/GFCxqOczSGRGTOgnLmIOXpIrNCYEwFJWGH0a?=
 =?us-ascii?Q?Q2dvmT1wmlDgCQXA1O9j7weXeY28pQO2lYVqngF3pn2BONMEcebromwaPRvX?=
 =?us-ascii?Q?YA6NFcG2CaigI8whUMNQCib2eTOz6xa2inUopL48v+jz8nFfV7yLjlmQUsHH?=
 =?us-ascii?Q?GBjXbrQ1aZtiD4MhjHHjxIkCTNSRoOYCwnkXCiPslvJ1KJaqQXaMDIquxDHw?=
 =?us-ascii?Q?QWHTiGcw7mjZIJW0TOWejoAHlVgF2DPy2M1mAd8HbZ+eKawHTufxO4A5OCPi?=
 =?us-ascii?Q?1zGYcf+jFmGOghzT4LAurkhglXB134yHQp42XSI45HNhWz5HS3lTNTE92fxf?=
 =?us-ascii?Q?Q5LBOmq64NizBedmuFGDre6CVUsPQL6Q7XRQiCXaDpdKEKog6S0tfapj0sbj?=
 =?us-ascii?Q?M37VSVy7BDZ5sjVgI6rdJNUsD2gnu2jPqghSV1gJfVKFloqbn2InS1FFo5wR?=
 =?us-ascii?Q?52LJObX9D4STEoXLe5GwxH0n/pPTjykbW/AiitXiKBBHB9cK4awVB1H3F7Uu?=
 =?us-ascii?Q?YiIpWOVxHg9c0/5IuY5MKLk2kc9c4bMi7ndtu2CDPCyGZxVuOTHqQKuQPx0o?=
 =?us-ascii?Q?V2g3OMvz71+qD+yfpBm6NyitzKEAGv8jPvnQCFFW6TaIAo3zXHlc1meFjNXK?=
 =?us-ascii?Q?3Wj6Os/rPG0EfE+65L2SujhxGgrGgafMhRFig8hFEEn0v/vXYzYlNr3ZC0Sm?=
 =?us-ascii?Q?hWvymuklRbGDzNdo+NjGPCNiC/ip5acuZcId5jDWaa2x0lmKKeVvzEdpbciD?=
 =?us-ascii?Q?uuEpXjoL7DiwmxiPrfQ0D/D2cKsoJqF1W/PMk7fTD7WH1tnLetjQMnGOX4FQ?=
 =?us-ascii?Q?ri6JVRxdi1rlMLlA4O+52fmlrq+eBknYE3Ho+5coh7t+3IqZ0a65I8StOC0j?=
 =?us-ascii?Q?sJwegcni8CCufBwCVnagBXesQoi2Nl4TRVHlVQ9gf8KZYu3pslyLEUWcyOe3?=
 =?us-ascii?Q?pw38oAq9pR8WUL/Gy7KTtOWB6eeQKAAsBHGHBVIGdzyJRhYEvTfMkDHMDmle?=
 =?us-ascii?Q?KmkjCerCWcxgqb2rT5HOEZCUBq+YAmRWdYyN3wamBgnadzXSSphNRaVFXt+/?=
 =?us-ascii?Q?DyC/xGNhoqLgOIQFVExV/u1+TkvNo5JOUFO+MK4p14Zpm76Ah9vOTJW73c2q?=
 =?us-ascii?Q?VrtZiVCdO/W7jsGKY/Gzly3712824jLWLGHrng37ybP7gOzw24DLgEouQmR8?=
 =?us-ascii?Q?qis9aH7egkAbOYUepFI9JJ08/DR8rtePI7SkFLw8JfN9PgCipW/ooOGRvMkF?=
 =?us-ascii?Q?awDVcygryXJAeyoArUDC71RzVcqr2WT48dTqrvpzs2Q9lrR8yLW5ilpM1OcW?=
 =?us-ascii?Q?9CxsUAartB24QZSM9E0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4390d7-cdc8-4f36-987d-08de1729b80c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 20:28:28.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GriG0Lsb42QEGhfdg/IkW+v+qvJeaKMjHJuO3oOZqQHr+ECI46L/q+iv6nd4S2tCCO4CO5+2mJCtk9fsMZRWmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7870

Add at25 required properties (size, address-width and pagesize), which
duplicate deprecated properties.

Change nodename 'at25' to 'eeprom'.

Fix below CHECK_DTB warning:
  arch/arm/boot/dts/nxp/lpc/lpc3250-phy3250.dtb: at25@0 (atmel,at25): 'pagesize' is a required property
  arch/arm/boot/dts/nxp/lpc/lpc3250-phy3250.dtb: at25@0 (atmel,at25): $nodename: 'anyOf' conditional failed, one must be fixed:

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/lpc/lpc3250-phy3250.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc3250-phy3250.dts b/arch/arm/boot/dts/nxp/lpc/lpc3250-phy3250.dts
index 21a6d0bca1e8a..15463a96938cc 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc3250-phy3250.dts
+++ b/arch/arm/boot/dts/nxp/lpc/lpc3250-phy3250.dts
@@ -200,7 +200,7 @@ &ssp0 {
 	cs-gpios = <&gpio 3 5 0>;
 	status = "okay";
 
-	eeprom: at25@0 {
+	eeprom: eeprom@0 {
 		compatible = "atmel,at25";
 		reg = <0>;
 		spi-max-frequency = <5000000>;
@@ -216,6 +216,10 @@ eeprom: at25@0 {
 		at25,byte-len = <0x8000>;
 		at25,addr-mode = <2>;
 		at25,page-size = <64>;
+
+		size = <0x8000>;
+		address-width = <16>;
+		pagesize = <64>;
 	};
 };
 
-- 
2.34.1


