Return-Path: <linux-kernel+bounces-892328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7446CC44DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 266EF4E76A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABC3299950;
	Mon, 10 Nov 2025 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Ily92FE0"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021137.outbound.protection.outlook.com [52.101.70.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E3F293B75;
	Mon, 10 Nov 2025 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747025; cv=fail; b=Aj5DH/oG9V+fcYhlS8Fp4jXBRylnhkaj0hUyYum4v0GEGJ6KCKso7yxXtYe04oUoGeheRRaOsi+/fVXDm33a3rgFg96maFgJ67QBKYe9PU5594m7OlAgMnaSsMgRSA2dRNuclCFWVP03oOeb2iKI10Wn0XS2NDP8xzVvB6ABGRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747025; c=relaxed/simple;
	bh=ypuAOkYyP3ZueLw+4pfb5ZQZI2EIZDdhkXjABjjGhXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4AznF8qnkG7nKd79csOMgT8n8cpo+vxDEAHi/j5HD9dbU6d+om0p2EmkbNe9zaHfGmCWwR03fbLcv3Z4ZnpGxRl1vEC9oWsQA5vl1h7O/fKDKP5n2JgS3qIvNCPEKipxafyfRlwMlk3Cm5ggFIYHeuFvvmmjnsj+dvavxbNyyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Ily92FE0; arc=fail smtp.client-ip=52.101.70.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT3wMSzEyEkiVHP8OhS1xyaZLHwzYvMlj+mtVkPeW7asL26rF4vWsMgyi+lccD/7P6NdaQ/LEOFb35486YHH1O5qycPALE2dPHpB24AQIvc8rQrQxxCdcRtn5jb+OzgRzyDRKBdUx+7Oipj7Vcgnj+VXsOZp3JxOTciDeq397XTbJdzyFqQDjCLS6t8JW+Z/FCXZkv4Gteqx0MBJ2t080T08H+jSp8Q9gQdZ/qxxbd3vYUbxmFeD9LTNdvPG4G44NWEfygeBv1oMkCzxACBbRZL+fNlKokDN4PO6jTNP/74GZPl4At9G82VoN/p3nvmDnxw9grqbnKs3sTE57Nm7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEe/rFsc/ulwiEf9Z7qBqvcRJdBZ6R2LCWV8pLNzBmg=;
 b=WFfXFwaszC5LNkJP2bF8eqdBM2jz4YKKkLUGwtsA1oFLoC25sBKeckyWu7Mey1s9tWgGSFBYWFy0YXTq2WzuwRJnnuQNVkHZVXPR69hO9fMTCfsDGOZrijNFzCWhPjk+D7EnnUokgHWNPKb5wfqBcHmcZF9Do9qxMpUZ0PmISdokOuCXTdLA3DP4ZEb4Zw7td2ACFug7i9yCnoIIQWdDNuu+nyShVNhqDRZad7N/4zz9fxkjfpKNbh9nMOwNveEpxJ6u/z8ITQ0W/9hV9ypMYBAk8jOaMZ2cUTToEw52AURr/lAt80BGdZ9cojkT5H93X1vaiuzrI3dqRLiCim13jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEe/rFsc/ulwiEf9Z7qBqvcRJdBZ6R2LCWV8pLNzBmg=;
 b=Ily92FE0mQvlqiQE1xg6RZsoiRNuzTvZCSrsKCjJKqb1VTgU6ocLXJJkkQRnwaRPaVfh7INxU77jGWPnqolyxAF1JT0j5Qy1QAV7QR7UMyt2BPb8CYIx6XfKkGZPQOrKWV0d+VmoenBAWyL8J83d1V7spf226ctG1OjsrBsS+/n9+tZtFQr1ysp80qwkVXtUogwN0KFg1gw1fECZMbWgvATYYww7ntfMKhNGhJhnyaxLzV4RbDgWuIPiwTw7KYoGeCAIFWqnQpTL2BRUnKPAwu5MPwpJrlGiW519R+8T0DkM6FEmQuow3ku6MYFQKEXt+FeYziw4mQ3uSpj6T7aopQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB10946.eurprd08.prod.outlook.com (2603:10a6:102:46d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 03:56:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 03:56:59 +0000
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
Subject: [PATCH RESEND v3 2/3] clk: en7523: Add reset-controller support for EN7523 SoC
Date: Mon, 10 Nov 2025 06:56:44 +0300
Message-ID: <20251110035645.892431-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110035645.892431-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251110035645.892431-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0483.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB10946:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce80284-aa53-4617-ab8a-08de200d32dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6VvR3hn8MlbwdBKaYFJtHTx6NsKXBF73dp6g4tZGwORY/KQs1QxpalBaUPof?=
 =?us-ascii?Q?n/tf92Rxg1fN4KThKN4REjQ+oCq40FgTpLZZAYU4wP8RLcg+uaa0UGxQqArG?=
 =?us-ascii?Q?6LrVjfH+fLi7JCJmg5SzAi8jsMqIeJKMmuVhTMinA+KLNb4U7bbiFWQgulJy?=
 =?us-ascii?Q?Gte0hGJlX6CNhFDAEP290dsZlnE8RIJsB9ZmRKZtgFrtdb+aFTt/g3c5xr0+?=
 =?us-ascii?Q?qC52ln1R5hPAOT6nZwLYWQpcY9N5YrHBBJZyOre69Yd/Fg2Cv3YWR7sDaxfH?=
 =?us-ascii?Q?WA1Xo+ekJn1GB1Oy5BPT43So4o/s3JQymayoPXSRK2AaI1dLB84TPN7R9KTP?=
 =?us-ascii?Q?YQQuCFXIbSp/w9/yEVHrbwtLedEhOPxoMMDScoUQ4UPFIJ8S7kOSg668XMMO?=
 =?us-ascii?Q?RdDBK9S37GW3fj4yQoUI66j5+la6SFp59tcWMMeubmf99FhpkkLEhYRicilm?=
 =?us-ascii?Q?nBOFI8ar8Ybk0ZfpkaqCaFpBW811+xoG3cyWpbp02Zhv7ZN99D9VAi4iBTZV?=
 =?us-ascii?Q?CvA1Abgw9EM9GWaHTkPyUqXlKiCy2wbwdfr2hZHpwCKuiZhO7XVIlBM0fnmf?=
 =?us-ascii?Q?RO7n5AydB4RYJwRvrMA2a1NodRhbNnqezXusn0ZkqF6cYUUDv5hhcdSCBzSR?=
 =?us-ascii?Q?5fHgT7CKKMdwz/iMseavVnP8HAhg9jhiCYINwZuUafP+kxFThC+dEBLYJQ1A?=
 =?us-ascii?Q?bkyBDVWQLhlPxlu1z85DZJSNufYr/jdUNO2t+PmqUUuPB9zKw2INIh5PUySd?=
 =?us-ascii?Q?FtJUJIeZONjGa7aPkUrez/gNrZZ8Wks//BZOML+7aZBsV4O8gaF3IEfQl5ku?=
 =?us-ascii?Q?byfPJsylyVKAg+rR56C6BHHPG6mhWOXVi0tVohAb5eNoyzOVusn42fXNxf6v?=
 =?us-ascii?Q?KGAt6O0xJ9skTHbxYonPcW8HL0cnJ4XUZOAnwayA9C7kfAHz6L8yx4hBsf2i?=
 =?us-ascii?Q?uu9tGFAoRQpuRlh+r4I1YUu+9WIS7/6iFUym3k0B0jVvkguDtNGApfgi1d7S?=
 =?us-ascii?Q?mcQSb89K7dL7eq5pINB9DpZ536bA2wsxtva4U0OSTtDXvMfMrlg5SVju5r/N?=
 =?us-ascii?Q?fkJ4GYf5n1jYCSAztU795AJLywCJncHtGAkqQaj+JfLsO8D8rCaeyZdrCcDA?=
 =?us-ascii?Q?zUNqedGeDfdrUAkpo0Sgcxk9E8eFXZPiqOoHTJbJugr7PUAwAnTeDkXhwU+q?=
 =?us-ascii?Q?hN97sgvwkmFQAvRYaqFxKvVpRcczxXdNvlUSAyDbYgO7RPUH2VW4OejXBQw+?=
 =?us-ascii?Q?TY1Qkkm5WfLiM7Xei8vWEpOGFaypIiqAYNpbLJFlrtx21MJv/G5s0LpSqzr2?=
 =?us-ascii?Q?4QhaJtuLfCv2S4FE97d0j+Wp0qzErUJZOnnkyjfTuLh/qd4pGhPMRrReuhQ5?=
 =?us-ascii?Q?OT9Qfc8pNWskO0DuDNvQtlGq4mPPo8bV9d3cGS0cQYF4MgOVXzlj9csSynuY?=
 =?us-ascii?Q?oe9YWLHoyQ8QWuitbtmrb9gv8XuurevU3hgeTc0t53zdRQ9qv/LtaMb4nYLi?=
 =?us-ascii?Q?yBMXDh9QYa3a0eMn2nG99bZQDTEDIBslDhbQCc12um4ewES9GX/+FjWnNw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yTZkjybULZ9IHiLv0z01WIEMBao+X8HCXBmxkQ2FBLHCilkIY11MYL/qYNtb?=
 =?us-ascii?Q?ck2Kw/Y05tUYd5ZaLPYY1v4OI6DQ7fzrLoxYLXpkibSVq7OXbXdySFwjt/uU?=
 =?us-ascii?Q?4V5tU248cJ+hS7W4jlG5LuazZZACdWqd4uk2ZNZr6nILDD/pi1trb6LN2p+W?=
 =?us-ascii?Q?s5uGApXdyFe1PgmvFBq7gRStk3OmW2M3G50kAixdcZm3OypWvkherCkCss0t?=
 =?us-ascii?Q?ihDVf+wZ65FOCj4aR3oIc7o+ZQH6j9VdweOtAmmOz124DpfMA27npmP8aE4X?=
 =?us-ascii?Q?PLzvqB5rg/cbealIFw8Rb0/utGembcra5Tf70Wp2m1/3oczNWE9BPsLlb94+?=
 =?us-ascii?Q?NjmqamfcBV7MgTbGVEFZh7mn2PclrQSeyTQzEIS/+qU6NBGS10EmAmFfxGVa?=
 =?us-ascii?Q?kEaZWCJ6FKAHYBFcFvTh5rd8q5gXYlwxmD9XZSkVjqO9AEKrZ3fA8fqZVBtN?=
 =?us-ascii?Q?eKo+3oMinHjgXqLgY6sTXd7ggBg5iaAO1rooVau+2A6a4mQlDWkGGiQip4/J?=
 =?us-ascii?Q?F3HntxQ1Vqurr1zKtCbo745VwKJ5R9BUXEp56eOSNFR5UHsrxJEnDDIuwmHq?=
 =?us-ascii?Q?dNru6KpSmMeQxwfTXTW/zfRS1rqSX5hmBLb28lD2kRbIBzIZZ5Kze9ujWvzY?=
 =?us-ascii?Q?a7EDj4yMJDIDFvDnWGTH+BPNG3b89S8DNyQlvyilASm/ZUR0BFvnANjKdEOZ?=
 =?us-ascii?Q?Ug2onGCE2DQJ1l6aT9anEub5xqaOifFQ7caMljfjUUTB1t26gsjP/+2zRMkn?=
 =?us-ascii?Q?DSek8DLkbOjJkkq11e+DhsgRtYsSkOCg+ydc4td25L5fJGGgA6UcDt0dxBbN?=
 =?us-ascii?Q?jWrTTjlyZ+/imoxsv6ILNrRgk9V5IqvO1sajDfK7Sy8eQLxXstIbdf1cfsZ9?=
 =?us-ascii?Q?Rj8IIHV9hTxztd5gwYZtf3K87p2THLGcAbaWBnuOnislkKB+wTS7X1lj2rdW?=
 =?us-ascii?Q?svw8bMoObSypVWXBvQEYiLvX6zLZPu9vhhTs4caFrJp7N9eGgk9WhSUWsQSY?=
 =?us-ascii?Q?DqMHpsjEZqS46qPRBFwtK3cLyJh0+moEXyXmgK5bm1k+4rgMw4EMDlkXht5N?=
 =?us-ascii?Q?59svnfmyb0aS3KiniesipJrpEfzM4vEZrpk+rh9nIA0zIcRNFpIbSrlP6008?=
 =?us-ascii?Q?5Ba1+Vd6Rz8Gn0EHkpOj4lReRikiegI56qZ9q4YILP8OjfGRxVlF8CJUBYmY?=
 =?us-ascii?Q?BENgY1VQVViqom9gPmyk67TUWRItnlIuA56ZTDcm+SpuGeMlAtOLqAox1w/R?=
 =?us-ascii?Q?tFrSvudNj+nJlZGNsjLfRgRA62c6aT/l7/OCNetdZyMDpWgAu9GgIX+rDqvH?=
 =?us-ascii?Q?wKLCrghYU6uQWJjaaYGeqLV8/lrNRWb5otEfia+1eCp/RdTL33MPSdJ6tjAw?=
 =?us-ascii?Q?ziLQmojRKbANNfXga5FD/+nKwl12CGg0MVX2fuXHLSyxkeY9N3QOXAWpYmBG?=
 =?us-ascii?Q?TvtHl/js9HlV8PcQ9AIBqxhQ7w7PtNdl82T/9bIAsHRrwX98uZ4aBI9/L92a?=
 =?us-ascii?Q?3mliTltdiFrEWJMgluFEH+1Fx+0EF0jfW19vyAoGkSFtcfGflQqSE4IbdPV/?=
 =?us-ascii?Q?HFFaireiro8fA6jdcfdivjo+dMMOWWIJxPLy2J5YduFOtVZg8foFoHhzXmXB?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce80284-aa53-4617-ab8a-08de200d32dc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 03:56:59.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9vjoVvcpqRmfOAPN99NtaQRUqk9QMF5O0fgRZuVTwmn0kLE9IURIK4dXU5///mIHzRZ0oVIcsoV50GdNBh+DEiYkPOzLVVCgN0V3AdnvCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10946

Introduce reset API support to EN7523 clock driver. EN7523 uses the
same reset logic as EN7581, so just reuse existing code.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


