Return-Path: <linux-kernel+bounces-830368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87373B997D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3211B23864
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E562E1730;
	Wed, 24 Sep 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="InyzsaN4"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021085.outbound.protection.outlook.com [52.101.65.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900662E1C4E;
	Wed, 24 Sep 2025 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710955; cv=fail; b=efLq9QP3yzq72dM8CeNKaOqUpulGN/yurmyQ0GGDE1/w7kcoDJNW3/vmSWHuY1Vgoa9FRe2PHajOGqsOVuTcZ7SMj1oE7YasZjPU7uCI7FNg0v4GTFa0S/kj2g1EFSWQZDy/LR2pY3tm9TY5NN6w/jYeIg5eYTfCzXp9+6LKLAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710955; c=relaxed/simple;
	bh=jxdX1ziwxMQJHVMmUioywnmfRAPlkMNAtZ84VNgoHvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFEP5ThXPuSjsRDyX7waK1zRp0Ni8MkfGZT2Ns7+LpuxxYxfWmaSyfm236PNJmdi+rBQOIbJ/RjzjXkzB4zBqhIa4JYcGqznU4KL6IVVmO7i2evRG9KgSmxIegqJaP2NENuLVCPWFZrI9SYp02kICC/Bq25dHzGrYgDlbUfywvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=InyzsaN4; arc=fail smtp.client-ip=52.101.65.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSEiT3KlfJWSJymCTskeo0BCQs0mCzQTsRacjw12dPKwcR4CJyufY7XuFkyRg8CHjui+3sPrnZu03TKfyat4n+heYtWpkfhNkTFjr+mxnxYryVCEGYZgtmJMUBS1VM2nlUz++cNJbF39RXXcpCHqjFYYBvw6UoiLDfn5mcgwAzJCJ54jv2IqMFLOQS2TogBEflsEz2POqdflXzQ20tCbV46MP9LHRvx6psZm6PuppSPDcEaGERonmQa7AksgirAqqzNzKHiEcZv+fxrPZIW5VQnIh7jgJtKtldKpDgCdgIBPsIKXQu7VlBdArjbqmXPTw6EJGUQ0BmfDkMaPpwk0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Lveme4e61Bjqu5xk0P6DIkL07ltTP8wxtCrNN/EYsc=;
 b=rzPsukBSPT1gGihVOTooJEjbUxSb7MoSNeLkXiHdCneb/rwsUEJpCPvyr7cQavtLWsRjCZ4RIwuBInwsKJnFAh3LNaJPM8uZynitNjWA/eiZ1jm4cXw7UVGqD8Pukk7lql8kCh3s/2hqo2DbBbZJ37V7H3fVew1b+HcIdlJk7j6jS8O16eC60XK1sGI/nzUrys3F8A+BHLR2yGAq9AvL40XufVDVhqLcmUT2Ys6sSIg0HhWcyWNLaI3zNB1VfQjT+fgGlhR0rCIZp+dznjGGWU673qMBtVJfdzzkSqwL3bYyyfULGHxnAcKghAy5P73SpLTW9ggVB3ZX4eW4QJ+iYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Lveme4e61Bjqu5xk0P6DIkL07ltTP8wxtCrNN/EYsc=;
 b=InyzsaN43//jAR7cI5WMNti+JrlR+Fh1UsVDhHtEKuucD1rMTfajnXdc3yS0YKIJ5lLxhNd54QnOwU+DrSUHNETqwYp1B2dQVGbZNhOPIqrQcOleUT9s4Rh22aw06Dh6Z9wrfsi58hD43AP7QkJ3j1NhHEIQR/MsXWZaw3ugNhTOoG8kK0+0GuwL452oOaiZq5kRl/vcCDFxDxDmdvNY5zI4JPyCjElQMgdyTxx7pxtxPNWijC0F2c/b50MwZJ1QOzfmWAsSu2p0BNN4CpJUF9kEQx/QFy3X/mb5ovZWeU823UzRI07o2onBN4s/IUKVnEd0UmaL/1olw82SUChnQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10010.eurprd08.prod.outlook.com (2603:10a6:20b:64a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 10:49:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 10:49:01 +0000
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
Subject: [PATCH v3 2/3] clk: en7523: Add reset-controller support for EN7523 SoC
Date: Wed, 24 Sep 2025 13:48:49 +0300
Message-ID: <20250924104850.1930254-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924104850.1930254-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924104850.1930254-1-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: b37535fa-e9d2-43e4-5375-08ddfb57f897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wpb6jWk7OjsT8uCuQ2gx8LdmF4Kv7ojW7EiX6JUKpWatLYyig7nWY/s3RJne?=
 =?us-ascii?Q?74sW5PuxWWgHY9GOXI4Ea/d8gUmWSALFhtC/cwaS37Zb8VPoL1E/SFsiJ1vK?=
 =?us-ascii?Q?8WdY08RIzCovd2y4l1TmPh0ueDC2/I50hFO2EERXd4+BAXGDq+rNel3ex7WI?=
 =?us-ascii?Q?9UyTf1jOvaKEiA+5gWwK0SuKdHcIBm5EVDC5kz3i4c4EvCVZYmg/yvsseAlm?=
 =?us-ascii?Q?vpjoe/8waeMAh9Myd9u534rMJxEUILLHSsNq9F/LN31Efg0WOhuknUYFO0Fs?=
 =?us-ascii?Q?U13d3pPMac57RElReQxjqvcdCW0efmXYL8aSU/i/UDnGlZQTrZrLJ7hLb68r?=
 =?us-ascii?Q?U9dkToV2t9BPjtClcWFT5Har3xzERCAYmuZeBeO+Fm3jKOur+LKtPMTf6rBD?=
 =?us-ascii?Q?hfxPEKScWcCYlv+jymXbFApqfRQBwA16bxWtIrMzgJMWh8fbg7N72IRWCxqo?=
 =?us-ascii?Q?wkZLz1kOZPab8XVOU9ZkjKQYAzAzD+Qzf7LoxgEX5rEz+j6UW7MyUTanVFYc?=
 =?us-ascii?Q?coPYuoSr/kPfSgBM5cbV74pS8HwLVeDW9mgl2YdcUgg+8eiBR7ZHSdKGfKjX?=
 =?us-ascii?Q?SgF8IBmbLMGVVA23eTTZVRSTj/V+y7c0DHCFwqjdaXGipGY23HudOWLe7AQN?=
 =?us-ascii?Q?lDU2M8ilqSNZpuSksLbrs5jR7qLT0CrpGY5LOFQhAw1/9zVzIajk0eHO/Idh?=
 =?us-ascii?Q?AyhvnO7AyFPapbd7xfbW9PGupNKAmWK0CqvA5ftMhlV44Seys4BdupR7zPQk?=
 =?us-ascii?Q?WnUrnezKMahMCcdtgevDU9AZCYZ81fH5hpWJr7++9RCE4Dj4DsxHQUC9z14W?=
 =?us-ascii?Q?YOcDSsqMBh6kkiLyJQi48qkC3PiawJO3XWx10AzUE4AcTUUqkYue/hO0xMTB?=
 =?us-ascii?Q?19moPc1ugavufjJjnrwWdqEsWpZfIvcMOLWtYkP6mZQvcUDsYdg4W4wvmnsb?=
 =?us-ascii?Q?ZuJL7zVJlowyt0bv6KrAfDaeIwz3Xbmtv0vP4NpSS52Ji2nxtD2B/DibLPx0?=
 =?us-ascii?Q?o+xrD6Lip9ImrlnnsJlQYtte0WpoHPXBbHL+4Siee5XzPLOL4QnnvV2Hyn8/?=
 =?us-ascii?Q?xdvwyWQpiFHXuBdfKl2bs4FiBaYcuXTmj1usIBavcpOFNj/kBFmxkZJnExMS?=
 =?us-ascii?Q?rfkUMAgSZa6BfH+WSFA51KkYQqsMNlO1oyOebIXX060969zTK80Tv/ymvSkc?=
 =?us-ascii?Q?xJpUr+SkwkCSry8tbpc+/hBcH/HtZvXEEQXn+XUmUhrdKQuogYMWKcOHZUMn?=
 =?us-ascii?Q?lSZuLQ4KbzJ1/aBOD0l9AGlXlqdTZ/rvleCtvr4kecryGkld+skL3/Exb5Q+?=
 =?us-ascii?Q?qbo0DKP6TSmtPtzGtqabp4HrJUgqjxzs5KpOBYNU7XfG/gudivZFzSNkfVvu?=
 =?us-ascii?Q?Zf610k7tNo4k8CAGMTT8P43MqL0EkzMzz2F15nG/vun7OEFGSLTLbQgs2xiq?=
 =?us-ascii?Q?FHLAK/3QI2szZhTbc3ovJ+VLVR7xrBxfb1ZqgIOyOmDl/1+lEvdi5hSLf+7n?=
 =?us-ascii?Q?OyYqqdYXlQFqYpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WbNMIWLAbkAIjl3E0yNiazitkNpxzCJNQsSgUcMlEftAzUqwsmhxNCUp9acD?=
 =?us-ascii?Q?ogX6lCybY9fHJwJGFfYiEGLD6dtdKlJAEDS/RMXadRVEGzHVV6OugM7h35GY?=
 =?us-ascii?Q?D53IuBPic46JQu2DQ+eAKt304/sGqnc5yWVCsG1DPan+9JpkUb4w/+jWaYXm?=
 =?us-ascii?Q?yrXWkLH+jacyALRyVjgqqza2ArXequv5tFpgCITsr4rPepNqK7tWot+6nAHb?=
 =?us-ascii?Q?y4mC4fUBNDxoZLGhfnLLomFwdgcd1h3UDL/LiLriH7RH5GHJ6YHUUN/DDM1f?=
 =?us-ascii?Q?kwgxJhlMMux0Uw77EO5YgS5cKWeZUIyikhFoQVSvDVRr1cfuCWDOPBzAeFEa?=
 =?us-ascii?Q?zDunZ7t6cQkGoaqrgjag1+VOnydoIqFenDYTCar0OTQJrz6Jq95N7a49+941?=
 =?us-ascii?Q?pjytCs7Tcs4D75z7UA+fHMdqHj6+A1Yw3xN/lOEZnxOF8r6W6hLPUi3u0Ik8?=
 =?us-ascii?Q?Jm0pDS9265A/ZFISZVAjH/Aq6lmls1nh1cwLsDHxuOA3GoFuCNjtvSV9c6qh?=
 =?us-ascii?Q?QrZjtaHjjkH4Q4mBu08eVdWariN/x9IUjk+ag0t8XwIwfMl8bhGgZsy+19Rk?=
 =?us-ascii?Q?CaiP9mjJ3S6WrtfT7p0I5xLlTRz4bSwgO91cn117riOWGYjQxxE0K27gqkrv?=
 =?us-ascii?Q?qv+NNBe+aQY7atU6KVJkbYub3qJ06qN/1wF56I9w0bWI3tHy9umT8dlsrb6l?=
 =?us-ascii?Q?t2cuOSoy+8r0ZhgC94FaHKbwdevvWoaS86MkgZxHjKlzlWWDT6/Du/LUO+Fw?=
 =?us-ascii?Q?UuOCnv3Ng7tGdueJSMkoOz3JKOngNOZGBQr3pCqJA8HykShxmNBKWf1U8lSc?=
 =?us-ascii?Q?m4BBuCSa0GXmOybhM7fYSzDkfp8K0Kj7s5739S4FerqltNBB4Z2mcE4/VHvS?=
 =?us-ascii?Q?Qd7JqTcz/w0lXWeE6JAvKbEZAhsLlRqJ/9igz6TAZl4sF4nr4h9w+HDCoPgS?=
 =?us-ascii?Q?kPfO1WHztJOMntBFBSUYA0jdjFId34+naQKyqOPA0AH+a/QqkMuH4PD+/c6r?=
 =?us-ascii?Q?1uBVO/rMF/u7FwfgV7OMHrpT4uiLwSPUNFw1CDURBGwarWUqGTjKzOkI+7J/?=
 =?us-ascii?Q?5K0Ev3AITjIR/f6AI5MCm+iYq1cZZpyc7cxApFUmQe4gcJxY1WaHiEaMMOJY?=
 =?us-ascii?Q?7+57ZXw4a5GjDyXdLE6UNm0kFONTfKSxtC+Bm/t1b+VjPeBH9OP6QwJyaiwB?=
 =?us-ascii?Q?KXMWbIy+BUZp4+VDMpr954AkLXy63DcvvDE32xl8TRXNDYxqHpoWf99BOUXo?=
 =?us-ascii?Q?yYDUc9f39gFbOVhVv8Tsm83MMtSlj3hmuSws0oGA+UnmKSFRfL1cdNjWz6a/?=
 =?us-ascii?Q?OpvGr52Fp7m6TF52Ow604bJXZzS0wivuEFMDEOOKv/O4x9il9hrj7+hRKPne?=
 =?us-ascii?Q?uraf/lUDuM7BaRclQW1ARBejLDHnboxl4lbg8Fy0N7ci0COr3h1viicDCw85?=
 =?us-ascii?Q?zGcR0JuK1QwVOpTgWI1DHv8Y+6fFYx6FRWm/McVPJ0spMx29R8ejGi36/H1v?=
 =?us-ascii?Q?ntlGSphNxpSHM1mmB8Po8T7rc7hoPQdwbwBvJpH6HqviBd98f+R7xEbJFebG?=
 =?us-ascii?Q?w5MAJHu04yHF4nMIGvVR4+8R/by5MsULmxZD5jN1bGQcWeesIqv7bjwL8W5B?=
 =?us-ascii?Q?vchpzFmJ2A3M1fPb1JMuv/A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b37535fa-e9d2-43e4-5375-08ddfb57f897
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:49:01.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8dGHe5+i6gLWbHMWHadYIWkmbNuZK8vAdYyy9JtIw1olTwgUDFlrZst87ZYTV/j8GE5z0uCiUoCGRcNDPf9RipNUHZmkmT3u/9LEpC++jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10010

Introduce reset API support to EN7523 clock driver. EN7523 uses the
same reset logic as EN7581, so just reuse existing code.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/clk/clk-en7523.c | 64 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 15bbdeb60b8e..08cc8e5acf43 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -9,6 +9,7 @@
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 #include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/reset/airoha,en7523-reset.h>
 #include <dt-bindings/reset/airoha,en7581-reset.h>
 
 #define RST_NR_PER_BANK			32
@@ -299,6 +300,53 @@ static const u16 en7581_rst_ofs[] = {
 	REG_RST_CTRL1,
 };
 
+static const u16 en7523_rst_map[] = {
+	/* RST_CTRL2 */
+	[EN7523_XPON_PHY_RST]		= 0,
+	[EN7523_XSI_MAC_RST]		= 7,
+	[EN7523_XSI_PHY_RST]		= 8,
+	[EN7523_NPU_RST]		= 9,
+	[EN7523_I2S_RST]		= 10,
+	[EN7523_TRNG_RST]		= 11,
+	[EN7523_TRNG_MSTART_RST]	= 12,
+	[EN7523_DUAL_HSI0_RST]		= 13,
+	[EN7523_DUAL_HSI1_RST]		= 14,
+	[EN7523_HSI_RST]		= 15,
+	[EN7523_DUAL_HSI0_MAC_RST]	= 16,
+	[EN7523_DUAL_HSI1_MAC_RST]	= 17,
+	[EN7523_HSI_MAC_RST]		= 18,
+	[EN7523_WDMA_RST]		= 19,
+	[EN7523_WOE0_RST]		= 20,
+	[EN7523_WOE1_RST]		= 21,
+	[EN7523_HSDMA_RST]		= 22,
+	[EN7523_I2C2RBUS_RST]		= 23,
+	[EN7523_TDMA_RST]		= 24,
+	/* RST_CTRL1 */
+	[EN7523_PCM1_ZSI_ISI_RST]	= RST_NR_PER_BANK + 0,
+	[EN7523_FE_PDMA_RST]		= RST_NR_PER_BANK + 1,
+	[EN7523_FE_QDMA_RST]		= RST_NR_PER_BANK + 2,
+	[EN7523_PCM_SPIWP_RST]		= RST_NR_PER_BANK + 4,
+	[EN7523_CRYPTO_RST]		= RST_NR_PER_BANK + 6,
+	[EN7523_TIMER_RST]		= RST_NR_PER_BANK + 8,
+	[EN7523_PCM1_RST]		= RST_NR_PER_BANK + 11,
+	[EN7523_UART_RST]		= RST_NR_PER_BANK + 12,
+	[EN7523_GPIO_RST]		= RST_NR_PER_BANK + 13,
+	[EN7523_GDMA_RST]		= RST_NR_PER_BANK + 14,
+	[EN7523_I2C_MASTER_RST]		= RST_NR_PER_BANK + 16,
+	[EN7523_PCM2_ZSI_ISI_RST]	= RST_NR_PER_BANK + 17,
+	[EN7523_SFC_RST]		= RST_NR_PER_BANK + 18,
+	[EN7523_UART2_RST]		= RST_NR_PER_BANK + 19,
+	[EN7523_GDMP_RST]		= RST_NR_PER_BANK + 20,
+	[EN7523_FE_RST]			= RST_NR_PER_BANK + 21,
+	[EN7523_USB_HOST_P0_RST]	= RST_NR_PER_BANK + 22,
+	[EN7523_GSW_RST]		= RST_NR_PER_BANK + 23,
+	[EN7523_SFC2_PCM_RST]		= RST_NR_PER_BANK + 25,
+	[EN7523_PCIE0_RST]		= RST_NR_PER_BANK + 26,
+	[EN7523_PCIE1_RST]		= RST_NR_PER_BANK + 27,
+	[EN7523_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
+	[EN7523_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
+};
+
 static const u16 en7581_rst_map[] = {
 	/* RST_CTRL2 */
 	[EN7581_XPON_PHY_RST]		= 0,
@@ -357,6 +405,9 @@ static const u16 en7581_rst_map[] = {
 	[EN7581_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
 };
 
+static int en7581_reset_register(struct device *dev, void __iomem *base,
+				 const u16 *rst_map, int nr_resets);
+
 static u32 en7523_get_base_rate(const struct en_clk_desc *desc, u32 val)
 {
 	if (!desc->base_bits)
@@ -552,7 +603,8 @@ static int en7523_clk_hw_init(struct platform_device *pdev,
 
 	en7523_register_clocks(&pdev->dev, clk_data, base, np_base);
 
-	return 0;
+	return en7581_reset_register(&pdev->dev, np_base, en7523_rst_map,
+				     ARRAY_SIZE(en7523_rst_map));
 }
 
 static void en7581_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
@@ -652,7 +704,8 @@ static const struct reset_control_ops en7581_reset_ops = {
 	.status = en7523_reset_status,
 };
 
-static int en7581_reset_register(struct device *dev, void __iomem *base)
+static int en7581_reset_register(struct device *dev, void __iomem *base,
+				 const u16 *rst_map, int nr_resets)
 {
 	struct en_rst_data *rst_data;
 
@@ -661,10 +714,10 @@ static int en7581_reset_register(struct device *dev, void __iomem *base)
 		return -ENOMEM;
 
 	rst_data->bank_ofs = en7581_rst_ofs;
-	rst_data->idx_map = en7581_rst_map;
+	rst_data->idx_map = rst_map;
 	rst_data->base = base;
 
-	rst_data->rcdev.nr_resets = ARRAY_SIZE(en7581_rst_map);
+	rst_data->rcdev.nr_resets = nr_resets;
 	rst_data->rcdev.of_xlate = en7523_reset_xlate;
 	rst_data->rcdev.ops = &en7581_reset_ops;
 	rst_data->rcdev.of_node = dev->of_node;
@@ -698,7 +751,8 @@ static int en7581_clk_hw_init(struct platform_device *pdev,
 	val = readl(base + REG_NP_SCU_PCIC);
 	writel(val | 3, base + REG_NP_SCU_PCIC);
 
-	return en7581_reset_register(&pdev->dev, base);
+	return en7581_reset_register(&pdev->dev, base, en7581_rst_map,
+				     ARRAY_SIZE(en7581_rst_map));
 }
 
 static int en7523_clk_probe(struct platform_device *pdev)
-- 
2.51.0


