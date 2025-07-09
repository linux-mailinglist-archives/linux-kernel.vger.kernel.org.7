Return-Path: <linux-kernel+bounces-723260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013FBAFE519
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861194E6579
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B741728C007;
	Wed,  9 Jul 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="coH81nEv"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDA28BA96;
	Wed,  9 Jul 2025 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055455; cv=fail; b=UJr7WhdwS02AeIi7Ddd5XUtFw20A/HQ8jjwvK90jd2CQPXGRqFhhwXI0pLOuvSTBnCZzUUJws+k0qTJ5sS5xh4SXl2AJIABszb6oDcBlx+qDUAzSebDLczT85W7UZ9nkvNdcAASQ6i2+rZgBcPLc2G8qdykBPPk0Z1EB/2VLtg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055455; c=relaxed/simple;
	bh=QoeVuH/wTCeVMrjCkA59GoSTXyhJl0PPBBRtZtxrvWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzJ9rI6EaIc7g57rPq/BIZePf/9BhfwUiMlDwYd1gMt7hVYAzzutO/u33WowwsLjybZjp41bYgP2I8yVJiumVeKovuP8Wf+uTk2l7qM8R2QdtrEm+VzBSqd9KlN4BSPbq/OYKr+0Kn8xFnFPLS+AyddMm9TEK3o8wQ/9tN0l7BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=coH81nEv; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSmPQK/9fszsc4NgkYfFI+sj8FGKXxtIxoFFzZgmQtRaJniUZT0d8zOJPzC3vHbv9GY0s5TNqoQt1RtpKDrQ9mgV2+tfk5YTWYU34RkMBmYVdl7ZXFlplR8WSnZoVGojvZnMgUSKK3VWlQ+Q5iGUHotsBW4nZ48eDx98ChpeZLYTX+WXVX+smhfJarV23Hn7Lr0BNve10FzLcpHjur+onqr1u5LmQUjtSUY7PFH/b/aOPeOL0YC/zMPp8DinfQ9I7oM08SZQcSpVTvu+11x2fwz/KK5Bh189KpnxHXoTS0ryzDRnQLfUfh7mkhIm1pqSdR8TnDvzuBTk1+mVqLBl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz37444ALJ+0RXHBPGWw19EyxPbmY+y2OlOE1A6Leu8=;
 b=NY1zgULwsOCZqBRn2famfYz97u+iZOJ0jP45tXcQ/yZXPKIm4SIOG+aLWDuPwTHb293f0cfcgExX7FeTB4PCAN3jU8N3llRTK4JGf4dQmYttyswzgTIAAvYmsSQpeC1zfd8KJ7CmLqLWLoFd6asR89bK7eyShw2yNaev/YfpnxA/fbO33doI8DfPSUDsrJLW3a7DqNE4Dpm5CP5IRzUgX0T/lIgIrORprAD0TxU8Knr1vyTCj/KLgoQkqcxZN6U2hg9zg0bEc31xE/zwC4EfCWZ7cduPWsMmrVrQVWdqOj5ZyhkeCD94f7JY50zsz8d715EFY8tDqeo+TuFswq9GFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz37444ALJ+0RXHBPGWw19EyxPbmY+y2OlOE1A6Leu8=;
 b=coH81nEv7arF5ZMC4EcK2XnbkJ+SoLMY4CkgaFpldjITGsdfBR3inDjRp0F/+8gFmRETlDXrcWwd8z7PXTqTbAKKAEJbISKz8FtIGpMma4JnYUcOfpqYzRqI1rLIgxivvQMuWhLjrMSFLdeD7VZWawJh2ZzsF/Pc8/PNI/9tHNFSXX2uKDy4yToP9yEX+hOhRPMcjJsaJOFUu815iKNbOYnpcG4JBc7qB2zl5rDWz9WhFZd1FmYIdoz7Tu4Z5sNmnAq0ZZINwd/+SMGHdiHfCqlPjRDWOCrpV9XSnOCjrUtFy/Qf3BVk2+sy7oijRNvId9lztZnUf9tRfQM5qvJc4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DU2PR03MB8123.eurprd03.prod.outlook.com (2603:10a6:10:2f2::12)
 by GV1PR03MB10584.eurprd03.prod.outlook.com (2603:10a6:150:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 10:04:03 +0000
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/4] dt-bindings: arm: fsl: Add Mettler-Toledo Snowflake V2 board
Date: Wed,  9 Jul 2025 12:03:25 +0200
Message-ID: <20250709100341.1492456-3-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709100341.1492456-1-Wojciech.Dubowik@mt.com>
References: <20250709100341.1492456-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0032.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::8) To DU2PR03MB8123.eurprd03.prod.outlook.com
 (2603:10a6:10:2f2::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR03MB8123:EE_|GV1PR03MB10584:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d13e1fa-e370-4a92-e28e-08ddbecfee9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AfrWDP6VQQYb90vzFb1JSLViAY9Yi24Is5ofyaioATKynLzP3v3vp1WbEuMr?=
 =?us-ascii?Q?9pG5u5rPrA5RQb0nIM81p56gVW8if0V5yB3cWIeruRtlDIHPF4UlKcw+eS2B?=
 =?us-ascii?Q?CKbhwvvnpOlyrch99KH0kMlBgAGlvDBZtTLixWcSqhcok62eCXkwunp9OovT?=
 =?us-ascii?Q?xwnYKcSfBXo/3Ah8DNVNzXjMf73TwsGbYrEJaYJPid/j42o/tyvvzzxj8+K/?=
 =?us-ascii?Q?Tklr4AIh/nFkn08eVDp0pjaOrfuMqYAvMDmRmOcsNOOV5BQgtz5BPI3R6mJI?=
 =?us-ascii?Q?TUyw/kR1XXtYPLH7+wd0eeU7sVddvalRzHx0ftkTXbrFJ98E3yMHOFp9Mh1F?=
 =?us-ascii?Q?9yVHLO+yqR48HaKFC5wmglgumKMocA86jUsntvgjzhuGdOyAPu7XCLQbwPzc?=
 =?us-ascii?Q?K0ikq/6388aqpibbD/5JAR002facz71u42a5T2r80WOdrA9Sw3insyf7a7SZ?=
 =?us-ascii?Q?sOYG70rHv+AuuSIVfZfWzXEBw/Ebn6JEfJ7bkwo7lNf5m84bqsEJ95BUGlbv?=
 =?us-ascii?Q?+af/XDRQj1iXMXDtFm8ErJ2J0yZYSA8dJ9GruZzOxR8OzGpQjwBYJzsSN06j?=
 =?us-ascii?Q?RMFgQNP3fJrMYsQfvfjLq235ydMU762LYVA2lt9OY9u+Bm27xui07g9+QD0w?=
 =?us-ascii?Q?wnrSn3tClcRKqyL4fxvMkcF+ysLA5py+vPf5/J28Xj5B/9WYfjJLySYS6uR/?=
 =?us-ascii?Q?sK10Crt4I0kkflRamL+BZNIqZrJWpDr4sQjhwQy7AKHZG2i3JdVzeGSepbqq?=
 =?us-ascii?Q?ZGpYwose1FrpEc+i59salD5/Qb0FTz9tP/T2vfLxquVJysBudwiXdJRqcPFP?=
 =?us-ascii?Q?zGmVPKGo2aLZxdFZlcJ/Pxo/aw59xiqOwcBwYTElJ2a1hn5lDkeRk2B8aaMN?=
 =?us-ascii?Q?MVM/zsHF31ZgQAUp0rXMUCTWKvng8bMilEBgV9+tazoFGoHSmsHq6yexRxcf?=
 =?us-ascii?Q?3DzsxjsbZaKBam3c6AExV5nWbdqdAEHPOIT8lJNX4ehHCatENNRMsRiSiv3e?=
 =?us-ascii?Q?+Jq9YvFqLW+kakKCObxkx/dZjLzmGJCiXV6evJaBugRoLUHt/tScPoU3ooRX?=
 =?us-ascii?Q?w6ZGuGgCSXpLnXaLmUxbjM97dCIc2Td8i5tKdmbDp5Hocx+THkIrveMfu1RT?=
 =?us-ascii?Q?DF954SwHrgMaCZweDSLO6E54X9GkQ/Eu+89QFDcbqsm6Ppk+n1BDGVp1h5UA?=
 =?us-ascii?Q?ww45EJz9GFdyMT8OCRnbo2GnE4no54G7seGZK8gNqPq+V31o9yItdLb4KqHL?=
 =?us-ascii?Q?3zVc36yG6n5E1yOG5UAOiQwV6IIzaToDmZIWkq5t/MLIpbnhXgGJMQyKD/8W?=
 =?us-ascii?Q?1y3t7uSPJn3lbQheipQy3OoHrBHzaMfgm1IDj3jbUhpITfKMj4HFRlRS1GvX?=
 =?us-ascii?Q?7NyM/bKJlTJcdHMwtkgODNSKjHTmaE06InZwwBPU+sqQf89YtPIBqiiR6pfD?=
 =?us-ascii?Q?tNXvRXFhuXUpG97EwUnr9/erDoDT4PGa/yR80yLEpHxhhHI9wsKbuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR03MB8123.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6LoBzyoMNS6crDfMmEOxGClfe03ACKJ0JcjmYBkopgSGye3nuTrnbrGDXROy?=
 =?us-ascii?Q?zK94wjrU9xwD22jgbZWlcMT9SumQrvP5uRNXyfB4irASAZmJNHbFL/uPV5OV?=
 =?us-ascii?Q?mUk8gFYSPhFOuHk+ejtqVuDgiEMwlbxQxSGUNnrxixCWrQufFZeb8hQHe+rK?=
 =?us-ascii?Q?HS+Uujndwtq0m6OaKhOaMiCvLMI9B3lztxHOP/ov2Ysvx3QhDpJw6H9u8M8m?=
 =?us-ascii?Q?bIDo/uDF1MzzNW44+RxUTvBX7I48AuSQ35PtptQaYbdnY6BmtFmtcF0tWEl+?=
 =?us-ascii?Q?j9IK6gMJKcT4jAx54Bmpi81FMaGdSwXBY22gOFulKXrUYXU8pk2fyNOZJpWq?=
 =?us-ascii?Q?eYRPdnet4Std3ETIrkcSbFxrMW9f4WPGh5tl8N1S/BwoCSB4OAkDOATTb8Zl?=
 =?us-ascii?Q?kyEIQ82rWtzjOS8gqGtpwH/t4WhbpA2w3CmsJR+xszyWnGQb1UcDohY0QHUm?=
 =?us-ascii?Q?tcnFnr/uftzqwatiMC5qUI0m9kiOJALshhBRt0r3qY/QtsUjwqZgDbt1VOG6?=
 =?us-ascii?Q?Ch6wegzPzl5e4Gb8bEFWeG69GgUJJ7eud3dyTWnOp0xtM37IJhd0x5/hZMzO?=
 =?us-ascii?Q?nlD3+42xCzLJ/BXcuCr3VR8LhlMoQxdtt2oZapRmpsjpxYZ8QY05kz2IOAM4?=
 =?us-ascii?Q?AXIEbbGvA3981pH21iBjuxvWlzn+y9QNz5UMuR6BjDxMdp9qrv3xKjnDMnrt?=
 =?us-ascii?Q?uYcHe3G+PLpfUNk7tR3DQ4jESxS+xU1TWqcftf1KFw2ED1HJzMRe+1TxY6lW?=
 =?us-ascii?Q?QaMQUlE+gLdMsZaaooriML0mQx0OQ7iJaxSkFRfO317qWAtTDivzVf/Po+2M?=
 =?us-ascii?Q?sSltWO9+3DAGdQIkwd9P8FhMmfGNkvAcnKvrrVIyziET3mVWt0E5ejzPj28p?=
 =?us-ascii?Q?YZtcxSEBTbRXeLvHKYLpnMFGtHKGrjfUShuIGYgKAiWDh4Qwrg5bY7QSXcDy?=
 =?us-ascii?Q?zE80AgvxIGYFgAr3m9Vs1KYxlCSbb0kktaF0qn5Uin8P2ngvBJyIyF5quahE?=
 =?us-ascii?Q?X6G8/dm04Kib6Uemzxaa/1OByJHGySmyrgMBQOlhoQZTpO1IWNRGBXaH/C1M?=
 =?us-ascii?Q?8vsFCIlRFqWxa1y/L3xEOxV1a/YdQe4Gqy4lDD+UDQbF4lLERdJbu0IOb2HP?=
 =?us-ascii?Q?T7s9EJ1xC+jc9GR88XJoioui5Pm2wKb9QROqdMsxRaE8zoiCYU+CQOZ6TQrl?=
 =?us-ascii?Q?uHs8eTUYrQKOMWy4mAdCAqgKfBmMosEj4EdB40Ynkpu4jX7nrYHPu+YpvkfU?=
 =?us-ascii?Q?sui9VRC5DgThE037BALeyp7A0D97y982STDsUmlerg6DJb3dQ0DiKPGWMdBq?=
 =?us-ascii?Q?ZY+uhbs35A6H6nKzKvqEkRf4tLFQHntQwtd2cHUJpPEfX1qQhW4Zr9m9veQL?=
 =?us-ascii?Q?ERcGBaW+ekeRwfYMSm3tx36hAcDDk0rBS6iBpcS4oNzAVrgBX5j+N0chsGQ+?=
 =?us-ascii?Q?a2TichbydbIR53ChoOUixFMMEQkb9jen5MvP6OQyMXTnYa/BFXhbCLy68z8K?=
 =?us-ascii?Q?2Dp2o9ixlit3KntUanIg9hNY3aR1lCPbeTQZRbltkmDOF3iLlL1j0kZYtPl0?=
 =?us-ascii?Q?KySdqr3NC5lMK9dFnLpZA95PiRryBgd0T+rRo1dt?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d13e1fa-e370-4a92-e28e-08ddbecfee9f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR03MB8123.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 10:04:02.8685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCRwKQOrxfb1hl/jHtzcFrCutzee3/r4evFlSLHMupeVnGRXAXbwzmYFVpB4qNWpkKYzY3qEsODmvAQLHlVucA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10584

Add bindings for Mettler-Toledo Snowflake V2 terminal. The board
is using Kontron SL i.MX 8M Mini SoM.
Split the existing Kontron BL i.MX8MM as it uses the same module.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d3b5e6923e41..fe5eeb4355e8 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -986,9 +986,11 @@ properties:
           - const: engicam,icore-mx8mm             # i.MX8MM Engicam i.Core MX8M Mini SoM
           - const: fsl,imx8mm
 
-      - description: Kontron BL i.MX8MM (N801X S) Board
+      - description: Kontron i.MX8MM N801X SOM based boards
         items:
-          - const: kontron,imx8mm-bl
+          - enum:
+              - kontron,imx8mm-bl                  # i.MX8MM Kontron BL i.MX8MM (N801X S) Board
+              - mt,imx8mm-snowflake-v2             # i.MX8MM Mettler-Toledo Snowflake V2 Board
           - const: kontron,imx8mm-sl
           - const: fsl,imx8mm
 
-- 
2.47.2


