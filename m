Return-Path: <linux-kernel+bounces-858694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB3ABEB74B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 672214EA95C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE833291F;
	Fri, 17 Oct 2025 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="fdc5DWLW"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021085.outbound.protection.outlook.com [52.101.70.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F43064B7;
	Fri, 17 Oct 2025 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731909; cv=fail; b=nnnK3gUGEiT+fA6VkcQqs8PuP8Nbapq9lkNTnnrMsfsrGSwR1G/2rWW2fKoGsvf1tjKP4CaK+kyHA/03o7LEsOXKC60SYefxDzVMTRm9dmuOJWJT79fVr0lidHOObCkbMzM8HWmP8rWuxthGSQt1BLOO335Xs/3VRDYuy+882Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731909; c=relaxed/simple;
	bh=ypuAOkYyP3ZueLw+4pfb5ZQZI2EIZDdhkXjABjjGhXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UyXqkBELyAq7yVFKVZodo1KMDl2rttAiR7nEo+dUZpXdL0Ef6L44EWh4PWRxhIReTBQDnjSHEJfEJaV9ilUjD8uReHkrhQ2qyR89R7KPMHJ22iQaRmOaY31uK7SabSx/FFVhMydoBKTjVKnxGodJXrWwUSy1eG8TjSHLtbOzTVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=fdc5DWLW; arc=fail smtp.client-ip=52.101.70.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIt4JfA6OlWx/CHcC2FKsbjsmHyoXNrqeoR6tqsdmiqPmIWhhsf3BQEi9XPFYtAw5ImIiNvwIvUamk8euZ//4illE0zIvlRDcxINlEq5zrOl2DvA/R2rxuDLXl6B9aT66RKukSxBmNeA6itA9A31NGGvbkrfaby4o2h+ZfUY/4ECVeEsqjxmhL1xNezNLMO64R4vwF8J+EYYla6i/Lp70MqIeoDQpuVsAsBAhvqYFfjjgEUZfEx3hIMQlQCe3+LJbup9cX1vrZTXsaH9mqX0tmTx/mQpOsRa3V+dfK4+zN/2sOc3SjAciQNF5lZIlE2YncXzDHLMd2MF3wnXuSaEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEe/rFsc/ulwiEf9Z7qBqvcRJdBZ6R2LCWV8pLNzBmg=;
 b=nS0oQnYPyquwbPRbCHmMFwbqvOXjO1x/m4P+JSCgrbOvTiOAkluO338ifm/BMfeoG7krv5wtvGWIF3wvg30jpn35YvvVB0IrK5B8NuTdk6lts5ymxO2MLKBEk5OhA6ym4J0cr6/zj4BpeTxXCFuah0sfuDNSysmT1w6QsuIhOI9xSB20dwyhnVx4ElDPFy2trG3+JaufHu96YKKTUiiFUuUkWIKIsNjPyqflzM1jc+l04A5OsNtQKK9cDFsP2qsGjqUP38yZOqzn37oGHailqFg9qnUbfBs/bVeK+nck3UtvK8jUztebOBdVdIlsqaXF3T/rw1w24zbHojvHb/aRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEe/rFsc/ulwiEf9Z7qBqvcRJdBZ6R2LCWV8pLNzBmg=;
 b=fdc5DWLW7tcOwhIdHyLJoczgg3LB4NZskakgi7bYdtkhzrwcFsqDAei9wD2o7YsTrI1Vu4o+vok+VSKc5YPjpTEmzffKFdlhNtbHaIyQiwdDhdHZzpEnV9fbZ1MT9OoqFNsuKkYSeKxQ0fupwduJu6iJENYMaYk62m5VpdNORCCYEH+8bPJZDwQytKm5ZQBzJtMxDSP7XQuqdY8x2l9RmXROfX8Cml5QDR5/iXzmdsNFF+KvAjcs3rYLHnVdENdwcXZwjWXrkKBO1byAfMCjL/NfEs6CZ1yOpvX3eqKm/2ehza+zqbkOb8g8T3p8IpdcW1KgGoNLdDtaUV6+LavRZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB11247.eurprd08.prod.outlook.com (2603:10a6:150:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Fri, 17 Oct
 2025 20:11:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 20:11:39 +0000
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
Date: Fri, 17 Oct 2025 23:11:25 +0300
Message-ID: <20251017201126.493496-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017201126.493496-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251017201126.493496-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB11247:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec381bd-08d7-49d7-5226-08de0db961d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Ma/ylUaPxEHMW4L3W0CeqzxTTASzigoWFYC+uQoGEBwuNF9t+sFrT239ERt?=
 =?us-ascii?Q?iLm84LMDOmaF3qne4AQebyptbyyWUdE48gCOhz9DpIFvhUqVHXZeDHNe8g6W?=
 =?us-ascii?Q?V5R1a7U4zDJWS/tAQl781PROytSbKEjW/CtA4CR5j3FqtzZ3TqAe1I/zFK5K?=
 =?us-ascii?Q?Ns+Z7ybT0OLmgXFebOENSx43WITV+sglCaRjfrHqWFiBVoqsAp8SZ88j0s18?=
 =?us-ascii?Q?IJkwW6cN0m0ulNYqyh7aPYyPOadssuC0YEBROD6fY0dEHJss9jVW3aRz+/Pg?=
 =?us-ascii?Q?HPEVf7REK9oK1tcGpN22pha2uAPlc3XbATWirgiSBFqGc9lZ8rV0BLLw+Mxn?=
 =?us-ascii?Q?X/CNVwQsAZhv4cHUXS4kn7KX0S6d1XKx/M3BvsOtacHyd1ZEiqFPggstcHDu?=
 =?us-ascii?Q?WagcNzHz4K6JZD9ANHdChA4S8WKKnUmOpZmjBdEYVQaBy3ZUcYqegfPz5GhE?=
 =?us-ascii?Q?Z/PZ63GFIbzxw5G3nWxVsLpc1u5CFLpUta32PTCM8xKS1ek55k17X7FJExo0?=
 =?us-ascii?Q?JE+yTqtrJ6+Hb02HrGvy7Sa1O5M0Oum8RM3fU41smztC8SgTglYxhrTFqv7l?=
 =?us-ascii?Q?eRVxqZhUtL10nE+b77t2a72h4vbcFsqVG+mPIuexDhNrQIwEiETErzYm2uyv?=
 =?us-ascii?Q?j5EKrEZgJDRf1PSHoEs+jOZHd48npPXi+1+zQO9v1l1gKqer/6G9job+HtOc?=
 =?us-ascii?Q?GNUjhxN3qZU7UBiDCS3a0oBCdyLya/DCcp/qD4lbsG0U2hXzsmYmRix8h/5+?=
 =?us-ascii?Q?xp/XCI0GH/hwSazQzMr7up2YRlV68X1v1pEBtaHpU9AbcoC3V/URaJut9lVj?=
 =?us-ascii?Q?59Exm0eMPnzyhNLUEiAwKIQvbzq6L4HzEytqhQrnO9a+ncvoHRG5BaK9g0Kc?=
 =?us-ascii?Q?qxemQYiq0pV4PCzqsTHxaLXZOppIiDhW+oaJ8SRuJA+eDvt3XCqhW11rnz2w?=
 =?us-ascii?Q?fW7uCRUEtV0vikMPhdn1sY3H5tx1kB8im/GqNjfYXuEd8+CguyWxyMoAQUFy?=
 =?us-ascii?Q?APchtNLAEpHmgKEgk4SbbqHAkhmUQCb7A/NC3yCWE9IJagcD0p61moCwP6Xc?=
 =?us-ascii?Q?FhqqzSmSHVn+3IqRDtIeS7BOBLUfqgEpgBclMvr5CCNWV3vWgwgg1ekxrLh+?=
 =?us-ascii?Q?X6RqYWNj3X+ENeBF/bVE8mABhthnDxLObpzQCo+DfdmylUJ6zYqZS0n1tQAQ?=
 =?us-ascii?Q?gclQoeH26nZYJFJebYE0+sQ+IM+SO7GKhrA4JtWYO50Od3yrvzBvK+YSNssr?=
 =?us-ascii?Q?nSOppTeSZAaCf+BRmC5X9xceRCjhU09nKSOPPCnkjCOgUXzY24ESnELHuKTi?=
 =?us-ascii?Q?r4FtzJnF7OP36vSt6SkgXk8qyAMC0iFtI9Mt2zVEYi4Szg/iKOM9/HMLBokC?=
 =?us-ascii?Q?km826P7peZ0A1j8OU2LLl4CwlwToSOp+QVc8phI6jH4v33YG/8QKdD13sak/?=
 =?us-ascii?Q?z1HBGU+PuJPxNMh8xAwB6WcVGqaMbM7vT7ZBMyFs3fRbWVpBuAe8Uf7bFLXo?=
 =?us-ascii?Q?XMIhaNO06SwNXZt8vNj88B7CUnWCBzeS6VbASuaRA6YUxXDx2Ul4No4CzQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r/pF5vtVWLekFykruAk3cls747TooLNeSgT181vVRrPh7FHNUKRCgysvhER8?=
 =?us-ascii?Q?wsIyQtYp8KWfKpICcedhquh14OsppBk4SU8l87bfLCIW6R+JlYczMHkOMkqV?=
 =?us-ascii?Q?UqswnCA1ZQXIcBGY1sFrQFbk+MKh1QXjTdnkU6M7JCC1n/wU6uqXikAlOW+f?=
 =?us-ascii?Q?KQE0K77vrHhKHt0iXL1oLloUw+GzvkUCn3MeqlFWmbr08XEClmAn/Ib15uez?=
 =?us-ascii?Q?KNfalISIm/rn1SEsOxANTWIfG4Ygig/m6dTEvieH+EzeP/Lu3j2dk0VbBl5y?=
 =?us-ascii?Q?GCQj0gTACStzAPchWVqCwGIqtW1GUgqTxOitNkllh9sm8n1eK9dmKmBxX7d6?=
 =?us-ascii?Q?JkroC6bJx3wGALY5cfr1pg2Um35UecnvLrGB60LntLxQHTEIExZFKlIrZvcn?=
 =?us-ascii?Q?HnBrpXeCElD4ToO0GYZ6SjvVWjEcjhedII9x2FiQ4TdSVEZqglRvC8g+n7OR?=
 =?us-ascii?Q?c9BYckjyJ0TEfLczawPln9eieI2C3BOPBBPiLdnJ64zaoBr+MopHwy3zhX0Q?=
 =?us-ascii?Q?fLlVwkow16FdYZJASSHLWqMGWSl9xy8KRUOee/frRtE+xQl0NCJBPKsRCgCp?=
 =?us-ascii?Q?7rFG38BbIR4zT075zlYieULtBIPwjhcnLg9A6dFEt8foR7ZLmNJekv5XbwYv?=
 =?us-ascii?Q?vSvJb+q93M4NGzjBLNQzwGWol9B+9N+LfAGjREu447t8aCg0NeFSzoZHSoSi?=
 =?us-ascii?Q?hfp11UIWTzQraKVJAKgUEWfnBbcyoYU+ri/NNj2IWo9EXwYqHetwZwlCPN7T?=
 =?us-ascii?Q?sgzMGN3nJtUMrqy+wXPoe/vdsBKc9zs50Wf2PKuQ0QzdBo9NCsJt9dJO3MEl?=
 =?us-ascii?Q?C/I//yCiI7nWP1mzbVRjkzT873lKCXpumCRb5pHk7B0N6gzJ2iFL0/36Jzl7?=
 =?us-ascii?Q?NZ0IkR411PG5eMIGoe3je6zMfotdPi1ttakr0n6idffp17c9AMDuregHtRIh?=
 =?us-ascii?Q?SjOhnag+InCHCkbSs7Sh6Zj7EsF+WzMP547dmSVNlBhaU8ZhRFV7B8SG/YjC?=
 =?us-ascii?Q?ixqkRj1Dz6+pk6RjbEk3VSWN+aZvo4lsJ5tXqNkL15oQm7XsyBN0FPTaiUlp?=
 =?us-ascii?Q?lceG7dVw8pyFIf5chTBPDltcs1KuY4Z+b235G6FP6Nx9Q4dwvUrRmI+wA35b?=
 =?us-ascii?Q?GyAvkWUhmUmX5iSDi761aEf/RSObJVmPMNJe2rrqtpexw9OChazl1uuN3OEe?=
 =?us-ascii?Q?UYm6AJanmJOHiVbErVeOIa07YSaWihb3Pct/DzP9Ks0q4H0F8BtSKH+9eG2/?=
 =?us-ascii?Q?Zt1XtET18Jwl/QKEqpbhtyRm20vi1yoZHu2anpKQChb/KjG5RhxE/oI28pvE?=
 =?us-ascii?Q?w/xBBNB6s3pLkUzfbO9Ke++gNoQRRD9HQvRLinb+QhtlAvWfGh2fy3DzifOH?=
 =?us-ascii?Q?d5VksnzL0UvvOPOhgbKd3+C2a5+qLOEQrBEERdaAbnxWFrUq4HcnyKzm6HAI?=
 =?us-ascii?Q?SxnncW/+Z1rqVSUQyi5zrImf2+LB3ugmANV0zg4pFL3lJeJ4M5NUm4FoGZBL?=
 =?us-ascii?Q?PiaMv0lLNcJqBMfc+sXeb670xCPmG/z4ryyTdnnCL3X1PnVUHsAkrHC83mrx?=
 =?us-ascii?Q?XpabevYhKgdfwecpXLAEGxhP0K4GlZZZoFXgEjJPwZfTOpSHgLFo7bmEVW8a?=
 =?us-ascii?Q?oW3Wl/3XedOKz3jQvhtfIzo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec381bd-08d7-49d7-5226-08de0db961d3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 20:11:39.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chbnPRukYGqsMD49upbFjl2sam2Wubf2d42mutq2YMpuYZtv+L4Ur3CnRoVP3L51DZIxj7i3IYSuG7701YRpBL3bhQDqhkjGjsmgsdpufM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11247

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


