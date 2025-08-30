Return-Path: <linux-kernel+bounces-792946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E097B3CAC5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8F77AC522
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84E279DA9;
	Sat, 30 Aug 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MYRhqbpD"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013053.outbound.protection.outlook.com [40.107.44.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAE42065;
	Sat, 30 Aug 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756556889; cv=fail; b=QjbV9ExJElPJr69KworJJeL5llFuLNQZwAOjiuZZFDTVdXWYBxjHIhIA00OUDj8Fu2VdEk9pDtPeiaq8YN5VJGujToMfjQMJ9BJ+LOYtsRC2clruVPhnhZu6PD3lTddElksl4U7sIbBXLc22NISRUQJPxSbVI8ORF2er3Vuszq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756556889; c=relaxed/simple;
	bh=vc0J2YNjjqPfbZp9dsdEwnYu1tv/BG/wxV7guJZXMzY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ax7z91tQj2mACaeXNr1Vb1Bv9bJVtgLWQASJ7UX/k9vGOMW4i2QitzV7gEnbQWr3h46tZY4Lz4bnbmOmqHrXd8MNfF40IknmjInxSXNm5z+xLU1y410Zy6KQHxf7k8/FdF0uw3RRanU/nTc+bio0/aEIktxdZE8g3rTjlN5OWYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MYRhqbpD; arc=fail smtp.client-ip=40.107.44.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/PbQFQoAWiSG+XVq2jW6X4A+nvqem8d2drY011rJ6XO+oXtKMWpDuN5CBhCBFRhucOnhpi4Gw7evhwos6t/3R1sU4NVfVXr+ZVnCeTBaPvPPMII/s0BSLXmnM1xT09ZvAr9pKxvacocRpkUZK7W0yjr7ZgszukgQffRWYDrr8JPuGdI6OS4JGgdnPnw81PRdPsrlauB2IHdl4ySKTH5ZcmcCY7U0/7H3qN7bpHbrrUBmRdgjkuhe9+XtAODyjI+zkx8n58k4ZZ3ps+/EE4PED/XWFBX3WK17b+6S9D8QFTudfp6LknwOorPgMn8ONRncIXhyPbMUsqEEuUH+d8kmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TosY3hWH0l4bZV2hwWWSb+s3mVwxVMXMIseICWsZqPw=;
 b=Psi2ag+xXJQJpjTnEz3LZnNBimugrmyO2XxI6vMnKJje1p2LP7jwWddXodbnPf3BCPGxSfH7fgvFhzm7sZ2JGzrmwjZZDcJohVqmyoZCKYSzhyyKaxtM4NgDQ2JYpdVK/ok9w4A9/GNBPhcwVamLbyDP6Hh2kjZKq1+zEMlnRrzVcf9K+4xZ4R8nA54LvTURIO2+pwoF1hc42uS7n+meGwynw+TeUXnv4S9B+aon8AYGIuoAu1WyWghoXh4bP6LcL6hIJg0IqVoGSCAN665DiYFYSYQKxlnVPIcs5u0bucpbkSWupRWNWwilsGVd7055OEq4EYfwr8xf2iyAmOFpww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TosY3hWH0l4bZV2hwWWSb+s3mVwxVMXMIseICWsZqPw=;
 b=MYRhqbpDvmxpp7ZQC1eB8MD7Acrh68COBbK0prjP5+9kknF3hu8avKwQONhEQKyBCVbltS7hPsATRu2jw2WAlDdYq9BFl0QCFtaBN2mFbL0JMcNFSrczLzJFtnRZhXwgg2fK/r5PCXNErPsmvT2GGQ3ysxDWLINYwW5mtR20biBZEMLaWRscPcny4jWmYftvC74iLFPWYOM2ycm3eEJq1ex96dElXqNXZMKkkp0wkz51boRXKgiX9u/9cA2Ddtrzr7ETpHtcVVCBybM6GU3OuD+0XU6RBbz6IVkMKmtTdLa+++3EJt+iWN2cCs3aU7JN0u5qZASz1gzODOYGUVKlIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB5895.apcprd06.prod.outlook.com (2603:1096:820:c9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.25; Sat, 30 Aug 2025 12:28:03 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.021; Sat, 30 Aug 2025
 12:28:03 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] clk: ep93xx: Use int type to store negative error codes
Date: Sat, 30 Aug 2025 20:27:52 +0800
Message-Id: <20250830122752.57670-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ab46c6-fc9b-4d2b-8db5-08dde7c0aa12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DP/Qs0wT0EZb8yUUOM1AJo90jOt28AdraZ4QLdkiWkSq/efAjpAg3dBjD6C5?=
 =?us-ascii?Q?SAsOLDOoTlw7JpWv3VJCQvTR8P7tSxWO1+AFwP23BXcc4xGEN/GPEFjLTSIk?=
 =?us-ascii?Q?80EZk0lMEFzN3HRJBe9ZHJd9UkpIJpfZEI9jJU4ovrEvBlohEizvY+lWPLDH?=
 =?us-ascii?Q?EnQ5ruwffRssiF91BtKmJVL2VqVf+UgCboEXVuXPrseeDuvi76GEaheimGAi?=
 =?us-ascii?Q?hmhp1e0phZCC6jfFIkE32TtU6sFh95qud9YXwbfYjmn6g08M9AJ6bNW/81ri?=
 =?us-ascii?Q?6/XZnA58rUQrah10UpwrZqIpiCXPmT66eTcOlGXiktW6CI8rZh4xCn64agO5?=
 =?us-ascii?Q?sUmCWNpjkeDC7gBvWNAK3QKnShfP+nTMrAXT2U2h7V/PXvOpeC1M0h0fuP68?=
 =?us-ascii?Q?q+h3xRL//4nIf8xSXv+WGXpqrfb9j1ukWniUfBFN7CBGubkvZ8r+A8BrkAJU?=
 =?us-ascii?Q?y8nZ4AW3+QNV0JnhAQW2CSdcMpLlN1Zh9qgTjxdgMvcdd1OFjCJ0Vy7q/b5+?=
 =?us-ascii?Q?qryq5hbBm+9zUM8/6MdQfTX7AmRCOfwK854nF8/mmGwURY4ZM1GMdQzvtr9k?=
 =?us-ascii?Q?WgebCGW0ZvCjbUZ3fnuiERlr9I3h3bYOEIDIHInQdrSjCMSB3ml8w/v1YYmC?=
 =?us-ascii?Q?ViolxDT23NqLXhNjvx6WM9NiKTmSVSKfnf7nHe+LBQGP3kwFY1Johu3ZePhX?=
 =?us-ascii?Q?pHGHcpxlJ63KMZK+Ohe71zHBbQ0doa5sLAYnV9k3eidqNeAR8Z2AmYQYjwA5?=
 =?us-ascii?Q?jJ8e+5MKQYfxnTNB0pQEY8rCVPE6bAo+CRJznWYVPZjPTXaf+T3XCY3+FG9H?=
 =?us-ascii?Q?P+378rn0iqNooQ41Z0DjjBLHoZi4OV+AFt8wiPddaVFDZwoclA0J4nHyfpk9?=
 =?us-ascii?Q?AJcTYc9PYBPK15H2Ivk95iDJfcKqjnVPG58pA29X/2s/kC6HzjNvyM2zSiyT?=
 =?us-ascii?Q?4Da60DznblHlyj18H72e55i82oa5YVnVVEDdYrzbm6pawL3AWJ3NN+peJ54b?=
 =?us-ascii?Q?JUei/EytEt+dFPgf4iGuoZtdXGAAYhuhHhJ+rMfePsbePzWqCQiH9JbzRxq6?=
 =?us-ascii?Q?rmIO+e7qZ+XzuuXbrkZOU6s37nuOQzRTRguFkqy6QAYNTUr4XxPeM7VBX/Kv?=
 =?us-ascii?Q?RUrHbCEjO3ZPWEOcaWUrmm+lUNpxqK3S4ai5Mpqik/7PEew1oX4hHFlVWxUY?=
 =?us-ascii?Q?lJ4msbHDapj5b9p45gqyWN0H+uBx/0g6fya8902JNf1P25zGmoHvLQFTD5oI?=
 =?us-ascii?Q?DDVOD9Nf/A52eJ+KkhOXzaOeQWgw+iiRUWG+GhpkSClVIqwAU+XBE/OGB5ve?=
 =?us-ascii?Q?d8OTI4YtY3S9rbiD9Divh0B9uxJ7q64E2y9arLLIEE6TNF8X47wX7NzUk245?=
 =?us-ascii?Q?Nuam22klj90sCAZfPVeV646/hx487OZAfUA9YCRyHofBMawTJT3Zl8/7Q2Pt?=
 =?us-ascii?Q?me3EdCoTtO4q7CuqHICa8xeRNjpzNnYJ2D1U58m5l5m1owNDByD1rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZyP+LgVQu6npemR4Z5aFLIueTqTYg9Ey3KIjijjKjVlmygkmpbY24QdfcpuW?=
 =?us-ascii?Q?QWNcvZ6YXc2ueuMAyXj9lF4x/4A0O2KDy1vzSGlt7hxt2wG7sMH5g/ap/KI+?=
 =?us-ascii?Q?C9Z8Oq/mn0KSGhX5dNdon5Q13ufxjNXz7t/xDFL70eQqNlnjCjsVLcs3nowe?=
 =?us-ascii?Q?hSWBaQ7SdytqBSzeulz5bjpWM5908+VhFR5+FCozXbHjSB0VgASyjT5EoYR7?=
 =?us-ascii?Q?2FTNbsz9svdSjHzlZD8sU86avzAmZ6YvW/dxpA07D5GZiwNxeLHhJFmAnK7q?=
 =?us-ascii?Q?rDRSAgVibYX5Mynvfun8Mt0y0fWX492EbaMIESf3qbTzqc1YdLjpNfbNPQTG?=
 =?us-ascii?Q?qWGl/nREp2i4w0cd/9fF8WXgqUZrN+FX1Tcgik2n9gRFBmaHWiXZ/bO8FeUu?=
 =?us-ascii?Q?1ij+Ci+GE/iuDsSUb8nbqjcE/342vysBED68EtMnuntBP/JjvV8fI0sDzm7L?=
 =?us-ascii?Q?4Kfzz8VPWGd4BDFRgL2HodgzBUQ1QOF8sllWLTs8E2oxiSQIk5j5ZBhqUMy4?=
 =?us-ascii?Q?IVsu/JEaTKa9IvqdJgvVa7yFo2ASUGY8/SYk8YJWZyC6nfdBu8icWi9r2nm/?=
 =?us-ascii?Q?xlTLmG6tadJK4s/+i1EY9tMB5cHOXS6v/sXPQBUb9OnTIJTHwRiH8x1tGd36?=
 =?us-ascii?Q?r6GffbzwTaXsJLFv4F6h+3UkLqRPCvyp7aHMaUng7SyIfHLVqADhjgB/EvgB?=
 =?us-ascii?Q?O90461KVhZKYjV1ihOdK58aTww46C9gJzOFZvHcPuEbADVvdyetDuIweajZl?=
 =?us-ascii?Q?E7d4y2cOShqhkVpUSUGM6VgtJTaVEgq1CueJiYfq/EpcphccxrRHkirxpb2t?=
 =?us-ascii?Q?V6XRGby3mdtDLO+nEr7DITykovZBZhrMUbeTWXcWwVNVhNC4aUpWX0DTw4Gd?=
 =?us-ascii?Q?3kaDZ9ACNbDZWYTrLR7CIn693zltHsLaCFEJkmP4CxZuiDd9NuK4BqCrpRJv?=
 =?us-ascii?Q?avDpZ/n4cCWmLSRmbYCUyA57Xgdl+WlWEINhgrj3ls1BKR9vqhtroOTILSKh?=
 =?us-ascii?Q?OlNE36Qidzj4YJwW+AbOFx9nPK/Xx3w9kS5tYr9dlKZYAQV+Y4ALFtc+rWVH?=
 =?us-ascii?Q?HV98VPJSMbxc1G05p4bBqum6sYdGu88ig9UXW78FBYFCRyXwJK2prna4Y/hq?=
 =?us-ascii?Q?pPDpCQCMn84qOq+C9uRSfy5zUb+NeuW27/T0w3vcl1K9+ZJ1/cHqY3maYhyi?=
 =?us-ascii?Q?JDHCe4na0khYoHbXcQA1sGpSTd9fPzghYyJC7k6CvXAa5G/aoypWGDps8bf0?=
 =?us-ascii?Q?bjgMpvon+VlfPdwZNJf89Rjh1XcbfGJvGL3Fwan47ZY3sWb1uA+spfMt9mUk?=
 =?us-ascii?Q?0RLRNgwaIZOVUK3y4sO39EYXD01N5NT6Fv3Wq2XxjvPVAVpGHL38o5h/q2jl?=
 =?us-ascii?Q?/xRqaxylkqLmvwROVMsLy8xJoOvJzWDBlEiZvKFMaffHRvwQcZCU65jTVknl?=
 =?us-ascii?Q?LTWF9vH/UlZnkA7fSLQZ9VtVjTDm52tE/CWC7YvFyPVYI79r4Jze7NvAS488?=
 =?us-ascii?Q?DrI/3Vh06yTlxAH9POobk2hhWGyM58ERk9iltHCwz/Hs3muf80zHct8efaLB?=
 =?us-ascii?Q?Oy4C8Yo8chIjWEspknJ5h7fINU6VFXt38rteUGNl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ab46c6-fc9b-4d2b-8db5-08dde7c0aa12
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 12:28:03.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6AhVc+On7xOCUZmpdHhKWYaIEfNCVHpWQ+3ReMgycDdaEB4UHVYxrdq2otdax1xccz+0YLyKiwiIILJNmd6Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5895

Change the 'ret' variable in ep93xx_uart_clock_init() from unsigned int to
int, as it needs to store either negative error codes or zero.

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but can be confusing. Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/clk/clk-ep93xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-ep93xx.c b/drivers/clk/clk-ep93xx.c
index 4bd8d6ecf6a2..a7dca023e00b 100644
--- a/drivers/clk/clk-ep93xx.c
+++ b/drivers/clk/clk-ep93xx.c
@@ -486,9 +486,10 @@ static const struct ep93xx_gate ep93xx_uarts[] = {
 static int ep93xx_uart_clock_init(struct ep93xx_clk_priv *priv)
 {
 	struct clk_parent_data parent_data = { };
-	unsigned int i, idx, ret, clk_uart_div;
+	unsigned int i, idx, clk_uart_div;
 	struct ep93xx_clk *clk;
 	u32 val;
+	int ret;
 
 	regmap_read(priv->map, EP93XX_SYSCON_PWRCNT, &val);
 	if (val & EP93XX_SYSCON_PWRCNT_UARTBAUD)
-- 
2.34.1


