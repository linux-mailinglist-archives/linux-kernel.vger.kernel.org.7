Return-Path: <linux-kernel+bounces-830248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38148B99320
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281FE19C6BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06762D949E;
	Wed, 24 Sep 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="GI8JHFtj"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020110.outbound.protection.outlook.com [52.101.69.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2C27E05F;
	Wed, 24 Sep 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706890; cv=fail; b=c0+x4JtwiQWcnTur69bXF6uKcMpa2KGl54fDsB4t4wubzvccnSCmb7gcumgI98dzfH4AgZCjsHpMofyaS+/ey3bPlFPkpy4VzfalrjefxPiU66Tt9jvM2st9sYji3HGLum3oLIiMRX/LqE2ZJ+2Q0i4X6S4qCt+aAyrhs+2fymY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706890; c=relaxed/simple;
	bh=LIccncw0lb8UpP3MHbIurna80RyE/EG6WCtl2TkjPfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KuZTcXVKlOoiteXZquMrNval1VVIyEZ4PIIk+d4X+PoakjbeqaZF6JYn7HrX56/hFxNqNVDP+AYnWU8kzvCq5v7USTBEGso6zKgY63uE0Ul3lxGvTLOninopsIomvhin0kCM21YieBEAFcW+3VakSAvpTixhWLZvdqLq9jqEifU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=GI8JHFtj; arc=fail smtp.client-ip=52.101.69.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y97OriNT8ofeGymkVgliKKvfGUmrJxDgBVc6hRrnqtqkM5DxIQFYh+eD9IBlL8zzK7XK/qtCdIRpE/t0tlB0IxB8XvaErM4RHwIzOzYhm5I0mZwjeA8CusEyfesFIqY/b4vIsFiZ82nAzVFhQTBWvktFL52oFxhMC+ylVFMO1qTdp9qBzH7zcstaAhahVY2Qn5xsvUCJxnhulCz6ZadeRjKWIzcovslo75NpQ3wq31RGL2SOC90a2DlGu3dDXFZkeAkaJxdJ0hX1Ew762Vxf51HwL4cLFJWsWOkNdRkfLd8rSGH94VgCWS/qH61LScIbbJ67lr7rbI3hykulrOwNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16pnkGFVbO1vjzK4Fqh9nQhcK7NoT6dcZwayS88HTh0=;
 b=R3uduCmqerQggax7XZ0G/AI0N1ztkBt/ls56iqtlBBS16DkNWLC8en3QZkKkaOw5qG8HTMK5I/GOc/KhhYyxuaYw5ElqUk1JwHukkq2e6Ey5FHbjss0GlHUGYyTP7RcLgi70kao3p6TdmxX2mcwhv4SkdSt9vAqCNjC08SVC69OwwsfAjNRRMMcYhbBHJCKtP8cl7Q8T0u/Ev24A+JkDZbZ7XWo8rVeVl0Z8nmLmoJpIE309BaOybVZTH3E1QcZW4gv277eLQQ3PgVcdDIA3E1Dcbto01tgPWWjFPUemaAPqVXI56f5C1A7YEaWvARmxwYbUV0TtRHYcfCaK6eL8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16pnkGFVbO1vjzK4Fqh9nQhcK7NoT6dcZwayS88HTh0=;
 b=GI8JHFtjqZi3RYuvoDw4a/fcnLpZiB5Kx3jPbJ/NMtj89CIVXH+FKLKoX7e9JOfdhQFFuFaqTaL5j2TYFrmbcGPb0DVwGHqfo60eW3lm2lrkIWKyne7OGN0sMzO+SfYZCOSkVEkGVdbz5bMdMjoKSKHJWT/sseE1MDSOCrh0g3M7z+zKsWtQ4ayPPA1tTeQPFYgkTnvW68KC9zKnbReO2P0HCzSQbyA0d5Y82W933wCp6K6VmP95OS7d6JAdXkxANaOfaEinHOOY/E3Z1upM6ZZSlxRE3ylhscD/Sx/InDjJb8YOnWVXir/p7zyUzutkDWucZDC9oRz6zqPMMrG9/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6098.eurprd08.prod.outlook.com (2603:10a6:20b:2d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 09:41:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 09:41:20 +0000
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
Subject: [PATCH v2 0/3] clk: en7523: reset-controller support for EN7523 SoC
Date: Wed, 24 Sep 2025 12:41:09 +0300
Message-ID: <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::25) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: dd88d894-fc0e-40ef-83c6-08ddfb4e83ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?utcLrT+8bG7GJ2Fs7wve0mIYmiEBtwLcLjJtTA/8EeDMzL915Os8fL7rt649?=
 =?us-ascii?Q?CPe52bcMOctpGE40oB4x4Nujp2z60b47yx+0JyckFHOwtZdd3FYosNFxwlxJ?=
 =?us-ascii?Q?HfqydyR61HW+riNfspN3ASRsFj+zYypJdsLIDiXGh9qiIt9s9NV55o5oNF7b?=
 =?us-ascii?Q?SeJ7WgQX6PtJG8BcKsef0Fhkby6stMe1QUum+y7Nvj1Bp+BE7BOkB8olcCcW?=
 =?us-ascii?Q?8p/1GQzK5pTqGHldIEYeGSSVGHAIrfCk4n0d5Ej0QVNybrwrKI9Hun7TQ9dg?=
 =?us-ascii?Q?UpT0Joy9Gqy6VMu3ZKofN/NbM2qKb+ZQ4hArqWnHPge6y8NWuEjftO4bTkvg?=
 =?us-ascii?Q?5USoTipV9bRticv2/jdCmyPoTDfBaUaPhIM9HcOpA97JC0GmLS0Xg8tzVTlf?=
 =?us-ascii?Q?ZAq+ZfVeHrlivUs/Z1iDCZPy3qXc9j7shB6lJxcMAw4YtxKhYBQF+59Jf3/p?=
 =?us-ascii?Q?WVY8nBkKlvxg5tuZx3tTwmEUO/vCK5je9uvpwd2u3z0At9q2pjTip9dLT5hI?=
 =?us-ascii?Q?8JzOcutSyTWmEqk1mD5OaU0c5KjQgCgm3MHA4ueeYGp3oMLuBNDCOkGbEKuN?=
 =?us-ascii?Q?AZe3/3FniyNJ8WCvlqwdBsdLmLEMDEdjZEOjr6WM0KPSm57qALJ0jWAPcGfi?=
 =?us-ascii?Q?Kzu82q/5L6rpBOkrrEaVkIDd3/wc2Ny3WNbaY/wrjA+yqVgttu+vdB7VLfoB?=
 =?us-ascii?Q?v9Q4/OgqJqQUk6wZxY6I/4qLvJNE3A5B1CuEC9duCXORBYgdzPf2g2QhOgHq?=
 =?us-ascii?Q?b5GdhYZzKPWZdrVbWAx3zv5IjJqPAUjv159upmToNPN40ueeorxqoHZlAj/B?=
 =?us-ascii?Q?BAmrTLOv3zkH7Q6fOz7+1wedbHQSb+YQfIIAZH/xARj7GkbiqUmiMgN472Uy?=
 =?us-ascii?Q?Ej5K6FL6uje6BE800q8A+rRCOWHYIR5wTkEzDtu4cPx59wzkaig8U3YPwFwT?=
 =?us-ascii?Q?bNDYIzUHCcZDVoNZk/0+yyvM8ti5bRG2FUVa7OthLK8xNPfV40PoUYdQvwkB?=
 =?us-ascii?Q?LPFZKvMqbCarCiw+MHjqgE/q0gQIAdB9SL0yExUSeLPcUiJobi1q+CiZha+O?=
 =?us-ascii?Q?Nb5lTXxSc95HIsCKnKjHkD7qbq7V/Cl/i4RBmP3asDgYyhmdQR947cq2SCUw?=
 =?us-ascii?Q?6WcUn3XiF1Y9DRKrDor9SkOxzpRbRNmAmR9v2MEck8JaB50J/0yfLaLZSIRG?=
 =?us-ascii?Q?DW95AQ466yIExtbvlepM8+ksTupMu92enQ/zcGK+3qsM6DTZ2v7SNRS1l5wd?=
 =?us-ascii?Q?KNKyqHWd5SNGV6Q09Nt2ATdRZ/hiOIFjsKe9JjHFWgWOC5kkKSDzg7VgnEJg?=
 =?us-ascii?Q?qenIn2kR8brEKfqsQaLNdZhI2lOAq400QQccBNrUNXnJv16xWgYBbnWecqcR?=
 =?us-ascii?Q?kTHdTjp3VVxAP4vTgeBLlV4h3sEz/r2hY1uagnFGjxHkFqD889YNJibtBt9J?=
 =?us-ascii?Q?SZ2EmIIbTs7+GsJ0xHvhnJtAYnc9m0debDOACjPntBKt7Lmv9bAVuQkJEx7i?=
 =?us-ascii?Q?ygAeGsWRkHqL32o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KbzO56FP0cG/nkS+lh3yBMPaUhSnzjbvqJwbbF75+4IU6OupFvxecHW+2UNV?=
 =?us-ascii?Q?jVTzzw+r27HlA4SPl5jWclfqBFgiMd87fWOddI6jqaSGTQIxCAu2sPnEqeIy?=
 =?us-ascii?Q?TbR/wNHVFzhsD4t7o56M5kpFDOUWLgAz97hiKG2+9enk7dQXhF0GZ/gxyVBs?=
 =?us-ascii?Q?RdscWTUBNyPYOdE5cps+hP4lfa7BnX5nZAI9zoF7cyfV3V1Z0FwhfGAywH1+?=
 =?us-ascii?Q?mvqm2ogF/UJ1vkMD5fnaNSwS8Qtlt5PkyiznaI4Q/lnZEvPPSx71KRGQmOw6?=
 =?us-ascii?Q?b5YNJYIz/bohsjC8sbE0UDfuw7pZkbdkU1Gnp7HO7NLZL3Y/CKthbgY9VErE?=
 =?us-ascii?Q?CiB+TALK5cL7kZwnfiYnhdXu12quMjvzr2gn2ce0D/adPRamlwulopYW0Fsy?=
 =?us-ascii?Q?iHVIsqQWBgkPdvuTKFJvy9uLdrUiLGlRZ1kC1Xir3/e0y7Uox1l7l3Lpzvw3?=
 =?us-ascii?Q?HT4vYDlQmTGzPsfbXTXDwlBb4e4Bi1c+e5FmU9YzvhrF0tMzgTHXk4IKnDQd?=
 =?us-ascii?Q?jQtasvgiudn1ixMBvU5VvwFBioZrS+EdLnZ2NSPTz0r0jIU1QVg9jyam3ZHr?=
 =?us-ascii?Q?MAKtu4iqV+0LdHXZWQy9LMlPe/G2xAmTvxjolq67WqPs1r5FRLb9mI3yCy0b?=
 =?us-ascii?Q?Fli8mQEC2E+B7+dKGevjgqFMbd/xIMO398FT+/8YfIJhZSccCb7MShdIcUaw?=
 =?us-ascii?Q?05Jsuiq5Ll7oHxMGXkjSp0X0laRUMlw/yUrBLKECH/yjCvU9ZpLovRndor9B?=
 =?us-ascii?Q?bHm8H6d825QF59rymkpb56EZ9NX2WQyG25MPoc7JyWIJXYFq9CtyK3kdtTwk?=
 =?us-ascii?Q?LQUyYbgcyqYueCMiwXe1J3k5aGBPML+sE3Y4tUAn7QDBnh7JyOHlhhLc1Ult?=
 =?us-ascii?Q?PgzlKzB52zxF/6FNR1pmtY5bRR9rth+3J3cUcOcxMlQFWuMa3m5tj1GbOE6i?=
 =?us-ascii?Q?4SpAxz+gWeZzPhSmuMFHDpk4+K2LlsBm+ifySV9H9QIeMvsIHZxquY0w9sFX?=
 =?us-ascii?Q?sxqKBLLVn1MfDOhgFZhZn0aTi+F86cZw/eaR6DqT69F/jh3qPPsCwTg9EIp+?=
 =?us-ascii?Q?0oKqc+wQ+r5E0py3HWI/i/OTmX2M04gE+GWN7hZSpSGtwUOqYl0Ddun6RLAZ?=
 =?us-ascii?Q?D7yBH3DqkwSQky+7rhWOPT32mZD24rS0AFIh+SY/KmGKXXd3JWjzXntGzXHF?=
 =?us-ascii?Q?edsMzglLdha6mFVcGPwHY+1RlubfwpLbp0bu8p3wxOipkgmPM26boEAOy7eW?=
 =?us-ascii?Q?4CZhSgXiqXnrIp9lM6D5a1z4osEpdkSZN2NqHaW3XMOKrCx+Xu3pZ1TVsBf2?=
 =?us-ascii?Q?iiIGDN/PjNMHjC5K0CV32IyWWjGk3kPAnPAklIa7kd6oBbBNKKRJ12GIaVib?=
 =?us-ascii?Q?kTqxFmNIgatQ0sebwT44+9VJJ+9tM0KANBksViXKkwvAdPo8TP04T3qV/oYM?=
 =?us-ascii?Q?Q3yeeX5mE2WDRJaL6BBE+dj5IEYfD9VosgSFnU2Gukq7mzmVCWgItpDv/ZBM?=
 =?us-ascii?Q?g632JNck1lfKuSmOhCetW8o7dMLnwm1DuzBvPpSmimbB16jed8Ym+Wr2AqTd?=
 =?us-ascii?Q?nixNJx+cdpRUDUBf+TLNTsOUqoguQWOrXejBQcpcj0ej5RmhyACPFltSxo8W?=
 =?us-ascii?Q?v1UdvpjqE0VN3x1IsS9NpTc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dd88d894-fc0e-40ef-83c6-08ddfb4e83ff
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 09:41:20.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sasz9xPUAajLHkasZcNSB7V5xpEUbnzbR5Jh7zZH4j5TVrg1zck/MFtoMVvuhffU7LNAlMgFCweL6VhKo7jwvFKKNvSa5dz6un/jC2RZYUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6098

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

Mikhail Kshevetskiy (3):
  dt-bindings: clock: airoha: Add reset support to EN7523 clock binding
  clk: en7523: Add reset-controller support for EN7523 SoC
  ARM: dts: airoha: update EN7523 dtsi to support resets

 .../bindings/clock/airoha,en7523-scu.yaml     |  3 +-
 arch/arm/boot/dts/airoha/en7523.dtsi          |  2 +
 drivers/clk/clk-en7523.c                      | 72 ++++++++++++++++---
 .../dt-bindings/reset/airoha,en7523-reset.h   | 61 ++++++++++++++++
 4 files changed, 127 insertions(+), 11 deletions(-)
 create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h

-- 
2.51.0


