Return-Path: <linux-kernel+bounces-830366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006E8B997C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1AE1B238BA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE082E174C;
	Wed, 24 Sep 2025 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="vaYN3pit"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021085.outbound.protection.outlook.com [52.101.65.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC72D97AC;
	Wed, 24 Sep 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710942; cv=fail; b=adpFEaFuDnRibccPPiNux7epOBM+8hGLMvfWGQmbpDBYjJQ6x5H4dCBRaY9+XauAZODF9UebnmLdKJ8Fb7u/cqY3L0UiHfTMrF0dI3wTeQ69Hi54LkTkTd8GICsGo0zZezd6fzS4/CAErpqr+vjee/tATMc0Tp85dq72HZ3MFHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710942; c=relaxed/simple;
	bh=fjSig4TH2vvRNPb7+5AHXTypGglsGDui/wAXJdaUNPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sLLySOE8ZzFHBVLNm1HpbulDbPYsWP7k5HrircendsTJAC4n2v3GjAQ1N84+1aTMxMt2qBOMMDBzjTzDrgB0YlBI/R4oChRn/StzFgNprssWduTuM0N3V3FPpBufTv6pchU7SPrVg1KjaMyCE41rOYaUdTHnMdnvTKyvLsro4oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=vaYN3pit; arc=fail smtp.client-ip=52.101.65.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPUcDb5Z0dVSArRV9vVhSPb5DzfK0mngtEOcDFPP5VdkANWQlqYBbpK2e7HsyQ2penm2udzjtzjGGHYJ7C6GlJ22rqsmpSZNVJXVVwKic64Elsu8JHE/BVep3uu+zakgDsRUFYSCPdoxeD2pTF8tXD8KqwS/VnhW++KGg2K5Mxpfabatby4Ih1gdqHVcAEV6jPxF5hZ+l2vYRxSQp8fePRneee9wUCSqCOBOPd3yxA757qiS9aR1eVeG55O7tc/pttscT6Xcgqi/PsLiybp9MKIx49bPglvonHWEHFCwP59a3ePSh44kM1O5bjZBj4mWSnllVotQtN63Z9MJAhQ/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cBBfDcCKDwtfZcpdIVajvLJFDilx5RQ2s24RddtlVQ=;
 b=evfLI3jXX/JvvipQ8bI5UqEeCTjnGlDhMA7e1Ri1WT64SKidaxCb79lCSZ+vvjkWGJIXtHUw64AySmaduHBrSdIInbQ7XaEGCw2V/8SVmMz6Zo3PeXDkiMFtAk92sBxC5s61Cc5DyU9zW6KFR+z3LIeeRZApaqehDFOQtBubaj+HV15ETSGLMibcwyfwM0Mccka2++PG6P0pYUbzfF/Ns+aZuFXnf2F5TKgYHWAuPs1aul6nv9QmV1vgVpB2rinrPJCjqWYHXruHNW49kknbjYgSeO2/W67prmhTmgEYvFIf3gFI3Qcr1/OZjugrahBJYwsooKON06w09Au4NBZ9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cBBfDcCKDwtfZcpdIVajvLJFDilx5RQ2s24RddtlVQ=;
 b=vaYN3pitUex3iiqvZYwyRJr06VR5J6WjeiINxUjooNlnkqpqbEj9u7agx7o+PXV72CJvo73xnFBtAPPu+H4UXS3OGunepx3OeMlY/LTXmRdVZ/84/ecuKgoH8NHYnPdltF3BDtOi1uLOBykKNig6KKYBRG176+BbXAOTI2Az74xU4lBNcZZFZwAGoS2ADJYPbEVEbjGpl3zugf0Kh/D2CHN4FKPTYem0Z5cCWs5rIe48+IZh0ql6DNvqWWlSDPOnoT1h1+zmrvUfZwgyNavrIa6HqFrRFmqVp3NJ0zbSZbzKjyKz8fQ0Adiv+LMLQf0C/prbnizrPmbgCMZh/E8k0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10010.eurprd08.prod.outlook.com (2603:10a6:20b:64a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 10:48:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 10:48:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 0/3]  clk: en7523: reset-controller support for EN7523 SoC
Date: Wed, 24 Sep 2025 13:48:47 +0300
Message-ID: <20250924104850.1930254-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10010:EE_
X-MS-Office365-Filtering-Correlation-Id: 790029b5-266c-4644-647f-08ddfb57f69a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gqR9Q/KNP1E97oSF8ibPHMYSbuy5/CB9MmV+3euwMWMC9hiQMeOP8ZKG6BQe?=
 =?us-ascii?Q?aqOrrJXLhqM/hjSsyD8oLDu90ZV+VP6/x0NCXdl1j5l1RsQaCnVN6UnTIlSe?=
 =?us-ascii?Q?l3cbpkUcCVVXLwJppjiK8c6y1g23/jANWAdycrzw2cGR+UM0PGXvLIA9JnPW?=
 =?us-ascii?Q?mp4Ws2YKPPyzt4FaPi+gMgNRr/sjq/kuvGkRaMzQHyR4DkUSQzOuhDV2DyMg?=
 =?us-ascii?Q?34CIcncU8eXIt9Mn3nbULe2IxUxZiyTmM9/K36EtUQ8pURPtSQU18yCbQida?=
 =?us-ascii?Q?0nTbEFrjwYueQ+bgOfBrvpBGcBW+2id/wepcfu80TBCfdj1fmsrOldATarqQ?=
 =?us-ascii?Q?zaC82uMCGQpDucKb0srhNeHMc/fpHtQzSd4Q6sULySken177xfqaZaBSIDh2?=
 =?us-ascii?Q?9HUBK1g9WFCy+FNDzpQ6Pbr1AWxMtfnVzLKCFqbVRcqOm5dtBYJyWI2JY2NR?=
 =?us-ascii?Q?1RB7AabL0YCR9kXg4rSEpP7kRlHDx7eNFF8i4af7I39B9wgHCWh1iDalfa8A?=
 =?us-ascii?Q?CjA30xYvy7uCsgoHcYofq7rLb3F+wnY+wW63R9RElDyjkkfTEok22wqXi2pZ?=
 =?us-ascii?Q?5gM01r3pkUoU6sVHeuFsV5HcdusUR0iTmISkke+cUgN9q6LvvA+8GJZmEDIn?=
 =?us-ascii?Q?y8Dn+JHsyQL7+B1b5w+ULUvGAidGDm3OQCKEScj01AC8o5JxyWqth0qoOyJ4?=
 =?us-ascii?Q?5nPn9OQv9jcpPCSXQy81AglwtIfYeX13M805QS9J80J9QIrKwoLPB7oDs7Gh?=
 =?us-ascii?Q?rgxFp5OF6SVs9WmSP3bCkybtne47rCfjczg4MYlsUFcYpyGM36bSXFhKtTfc?=
 =?us-ascii?Q?ND8+mG9/OIMdoBYpzo0WeoHMm/qCLmTcAGNG4arHSgKOiLwvEkP2+DUF47YA?=
 =?us-ascii?Q?Z/3eOxVSWktHOoOgHA14tqcVxqmZaMKbf3NwM43CY37jn9LM+j72oIwSa4ix?=
 =?us-ascii?Q?15gyLIUVTt2N6ah6AcAnKX2RuxQzgfVsNzJxskqP5QJ2SpQbf97hX9A+qCqa?=
 =?us-ascii?Q?HNAeHMu5c82POVim5aWBBHdu0N5sI1S8f4+cZZH0djfvgwsLGhrWwWltLndY?=
 =?us-ascii?Q?efLSEwvYEU+MFKU9XiZWyQvqAf4a9fXlEEtSjchth73cbYxNBz6TYdyDtElW?=
 =?us-ascii?Q?RJWrlWOyJgVhMgpT1ldOw2r+JwC1h+wEtGtfTMqRpGh2eOMTqZgPSkLqTDO1?=
 =?us-ascii?Q?KtENmY2i8wvtyyRE+EP58Ds3akrbl8Rd0rEbFb9DvLdPwS8daDfhKTZOLtjQ?=
 =?us-ascii?Q?uehP9f+fEIRZh13SCze/85w16voNOBrtnXyuybvdLndf5BQOQLUV3S3TEQU9?=
 =?us-ascii?Q?jjGfoOFVJWahBwMyJ79wTZEg5Zs0GErQvclOrutuWAaTy9QLG7v5b30U6y79?=
 =?us-ascii?Q?QG56WX8+ldv9mCJEHtnR/ApTQOGmHJ3xcxEy8GIQg5WiJKWJSzVJfDcLGqY6?=
 =?us-ascii?Q?ei6+yb6YRWsRp3rua5ZRsgISzKIexfs7I5GJfFxmDPh6T+ekZYN+sM198Har?=
 =?us-ascii?Q?3T1yrAmatP9ykXk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dLLT+2EsJYMpNDAivWKNDE7y1BYbjypV01/YAs+8zYpYSq2ua6Eh7Cewjxjc?=
 =?us-ascii?Q?zdrTe4LGfD0wDlAFi3O7SRTbtPoW12JSPxPgEhcZrshZW6joYoFWrtmXW4c7?=
 =?us-ascii?Q?DTmp+iXoPhaFdzTbP47bK7XOeX5IWVTZJ/9AIgfSGEkiL1r2qkQROXrYWGhW?=
 =?us-ascii?Q?zCq/kFiC+Xe2V3f6CLijCybSZ+7aZ2gbPoR/x7h3DjVTi4ufWRQwJYspXpCC?=
 =?us-ascii?Q?2WxkEMnekddmW8wh5xT7b6nRDiptLZWmKLxh3NL7XE3qJyG6Sesh0MUJMG1F?=
 =?us-ascii?Q?nfTUlC4kFoQckFybLHJ4S2yyoC55tx3xIigL8ms13MRjDNnyhAR89a7pQK3J?=
 =?us-ascii?Q?8iLm2o/GMv8o0ioIX5QaaALoONwPrf7Knhqrnui8cfyn6vyorKI0ZJFX+Xh9?=
 =?us-ascii?Q?0al+369H5szfM1YT/kai/N0MyNa/TrtGbHp+sDDOl0ZCrwtK0/xwW0dEjikW?=
 =?us-ascii?Q?KahxIEiQl+OjQmfBRc0/mozBPap1Q78X6FCll4fIOqV2ApU/fXj9BrUaaGzL?=
 =?us-ascii?Q?ncDagk7ydOhxNQZwUkwWScpwJe75PXKFC0OT0dE35Ehlj7Df29nfD7mt3EMX?=
 =?us-ascii?Q?fZWRY0MFp6ShB0acI0xRGGQUDn7Cf2cT/8l29nWhPdhqJ3DtWF9+M0mqCExr?=
 =?us-ascii?Q?SZ3KCUsV/m5Iaf1SdBwfLaLtBXCYqiDzTbBAQuLq+6Y8h12LA2FNzsmUdpN1?=
 =?us-ascii?Q?P+q+cNEF+JKY18kXmFTBpKN+eRXf4y+1URWSIr0UmeRAMQLPOvWEob/kztiW?=
 =?us-ascii?Q?f+K2IVmhEhA0b1br7ALvwcD+1dqHtwblXQwSc51Mp17wE3FluFVive72Ko8E?=
 =?us-ascii?Q?iWU+j68+wSR4zJwj+g+LDT9bEHgskjZS9yzNOPwn4jC2IAgcKPT9Djyzrypc?=
 =?us-ascii?Q?AVwPOV48muF3QeEmB8q/vgJnx45S1Kd/Du4X+ngUp8ZTdoycGkKwB4Ik3dDr?=
 =?us-ascii?Q?MQb27V7PkaqWyQ06P2zwmzPL8kwqzMcBPl7xiTToiqdgJlGI6a08HPDoUaTj?=
 =?us-ascii?Q?Q+e4PP4S7o4R19cRbuOLTiuik0MB1kKZ3L7AA30Vs3plATwU47E1J9VyEQyF?=
 =?us-ascii?Q?8CCTnFFXWQm0wAAkrj+4Cfopa8kWi7WJ4rVnMlE587e5IntEN9+MuqHB9c+W?=
 =?us-ascii?Q?mW0Zoq0wYUGPiwp2DBYLp934wb4v7f81EkDHJHT25kGwmixb6ye8Ck8VGyyp?=
 =?us-ascii?Q?cNokq912QGxGOhv3aJg/cIZJ4N0rTpzC1Z6D0JfhVl/QCdc/DP5qjbL9CGKN?=
 =?us-ascii?Q?Q9Vk47zgUGPmQYFXJGcEsU6tmOnQdFwJ71hn1t0jSFCroy6EusBQz/sGyqlk?=
 =?us-ascii?Q?Ou+6sYqU22kBlPr/Cx7IMFYu4DaBmHOQtlKZ1vR9WLTYTFO5daak8IbjyA7o?=
 =?us-ascii?Q?m35im0iq1m6JZasRg/FT/6BtCAbl7ngwBSJ15mCFNtH3E9CgKOAaiaDqtuVt?=
 =?us-ascii?Q?xtlJ0bSWgcNPhZrttZ0tLKyAo4dCfA7KDzk8haqZTSyzXEssTXTkIVt1zIzy?=
 =?us-ascii?Q?W75Ecfcl2+GDOLgtV41bckfU0f0Cvq8LOG78MlcliwHD+r7PtmejowtFrEGL?=
 =?us-ascii?Q?CSTJmvKXLFtFK9DtJNG4kNJrgPLveWeE7XQ3pNI2XIcRK8iGe+l9fSx/TE1D?=
 =?us-ascii?Q?EwGh578egYm69T8tGJyfrgk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 790029b5-266c-4644-647f-08ddfb57f69a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:48:57.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cy+Z0vdWfrKqS0KsXZPi6/Yie2Xu7WTN/y1xHY850v9nuLrOzYyofWm5685a5F5WWypyDl0rrZOkQ9pAEGgxCHOUPmw/cGTi5FWVElNou+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10010

These patches:
 * adds reset-controller support for EN7523 SoC
 * updates dt-bindings
 * updates en7523 dtsi

Reset-controller support will allow us more easily reusing of en7581 drivers
for en7523.

Changes v2:
 * keep '#reset-cells' property optional
 * put dtsi changes to a separate commit
 * add missed dtsi include

Changes v3:
 * keep en7581 prefix for common en7523/en7581 variables and functions

Mikhail Kshevetskiy (3):
  dt-bindings: clock: airoha: Add reset support to EN7523 clock binding
  clk: en7523: Add reset-controller support for EN7523 SoC
  ARM: dts: airoha: update EN7523 dtsi to support resets

 .../bindings/clock/airoha,en7523-scu.yaml     |  3 +-
 arch/arm/boot/dts/airoha/en7523.dtsi          |  2 +
 drivers/clk/clk-en7523.c                      | 64 +++++++++++++++++--
 .../dt-bindings/reset/airoha,en7523-reset.h   | 61 ++++++++++++++++++
 4 files changed, 123 insertions(+), 7 deletions(-)
 create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h

-- 
2.51.0


