Return-Path: <linux-kernel+bounces-747951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3C5B13A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F14D16FC76
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8309A22ACEF;
	Mon, 28 Jul 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jQQpW66+"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013044.outbound.protection.outlook.com [40.107.44.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A48BEC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706012; cv=fail; b=mZtIy94rJ83RoCeeI/cPwxSFeOHNuxoLE8CF27yf1zyXuFUIRd8v//4Uu2Rz2JxsOPKZuZFzR79jHRtbEAUOaVeqPRAG3pEliHDgOxtM2eBOIFna8TpdkOOouS2FX73cAn9PrJ43eBoa439shE6ff0Itw/01IzK8NLHQ5qVAESY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706012; c=relaxed/simple;
	bh=6xHo2JGv04qKQxxHvSX4cgXGnpGZEoihl8ia1cQx+8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nzElqtZYi4jWu9bzRB1k7a3LDF8ghXzRCQrWbro87YfP5xe97tY4PsdwwLXxSuBu1ncrP2OuwDdazA3Ey6CpWUsFMNlxjw9x+a7HaJ0skSLIjjTAjpKO04BMfQGrK4IDvUgEi+nmzZS6TNVAJCB4t37QMJxliG0fdpgXSpaJPWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jQQpW66+; arc=fail smtp.client-ip=40.107.44.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNOSMRTV3AasvZPxaXcF7fyKJfNnq2BW3VfCsm7+lLT8n1LfIND8EnPsqRMdnQkBdSqr41dp5nnGp5ybU/Sf56JIqtSE42s1wjxfntIwkXQusRUiSpimAKGPwlIAOCXnahSeFM/3rEeojLmX2kJBsXKEEGafC3q9JSSauTqhzRl622KH8R84jBzzAz9XvBxEpvjWLePWkedfmZJzxoLkkBsu0zt0nrShCqKRdlJSWsjWned0aTrLY9K61B1LQCspAGBJdb4vZGOW6iVRAs46fE3I8KpMU0l09mytuqLo0OLMG8Rd+oU37GSCyxj1zp6Aq/h3aH8V9cajZdkg4HvADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esfXU0urNUJHeGhBk2UkdldF35y0mDz33IUxubA9tmY=;
 b=nCZdaTt6bzxHdod+GXQsOsiyob3w0x8rVVLxjSAEkPODN3KsK70PkFi0szKUoSbBj1bYfhKTKp0IDHzhGMgqK31vN6wvbx57vMIUFu+ahqFVM6mg/SWSunb7k+u06XG6nM7S7EsuyKX600LirleYC/Ka0RaBWb9ZgFa7GijNTdJA1rlf7TOZKoyHMUvNt83l5FRPY04uDzq8rv5MLnOlXkPLHyenYguv/XXtHtWtMtQclWRhDSHqFGU42n2U7z6Q7cjO1Z9EjAK2yxVC2Dyy0zDEA9rlcaYnuc06Dba+F/3Q7WBCSg4ZAbjEL4Wxqg2Le0Mmnoy+75G/NP2T4ofGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esfXU0urNUJHeGhBk2UkdldF35y0mDz33IUxubA9tmY=;
 b=jQQpW66+bAcq6Bgb+xbIcesVSbOm75Lk+cN++AnOO335JCp/XkxPiqpIJ6uohAJEB6KrSgo2/3ScjWDDiMvl1GIc6DZUlmajYvR/Qae9XUDiwpvPxlIt/3gN47SyUtLW3lzBjuH3x4YL8fTyjpPyJVsJEbCn1bGyDOHaveGwyyqxFX6r1/d/rhC9wX2I+sagATzUUkU64aTNn0Jd666Ia2TiOxDs59urLdWouh4VOSMqVKg9wLpDCTVa0WK5qAajKFOgjFs5qHMjgRPL0vPY9LOJbkdd9ATvet3/jXV/rbBy1+S6i4EAAq6yxdaKbmWMcIq8X9AsekqKJ5mPofLHVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com (2603:1096:101:2d4::11)
 by KU2PPF81451D190.apcprd06.prod.outlook.com (2603:1096:d18::4a0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 12:33:27 +0000
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b]) by SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 12:33:25 +0000
From: Pan Chuang <panchuang@vivo.com>
To: tglx@linutronix.de,
	linux-kernel@vger.kernel.org
Cc: miquel.raynal@bootlin.com,
	Jonathan.Cameron@Huawei.com,
	u.kleine-koenig@pengutronix.de,
	angeg.delregno@collabora.com,
	krzk@kernel.org,
	a.fatoum@pengutronix.de,
	frank.li@vivo.com,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v7 1/1] genirq/devres: Add dev_err_probe() in devm_request_threaded_irq() and devm_request_any_context_irq()
Date: Mon, 28 Jul 2025 20:32:51 +0800
Message-Id: <20250728123251.384375-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728123251.384375-1-panchuang@vivo.com>
References: <20250728123251.384375-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0203.jpnprd01.prod.outlook.com (2603:1096:403::33)
 To SEYPR06MB8068.apcprd06.prod.outlook.com (2603:1096:101:2d4::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB8068:EE_|KU2PPF81451D190:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d3c9e1-7a34-48d6-de88-08ddcdd2f2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/jEmUeAHlUWHM2j/yr5Dx/8526tbUYUhRNKOEbd90s6w1ZLUGIZAQwUQlipK?=
 =?us-ascii?Q?3JmtvVSZZy1ACRQJHV65mL4pWItVsu2bCi1/bMtLR8EVCLU7icZK+X4dD82m?=
 =?us-ascii?Q?zbsbwqQ08nAwpDDwB9q3eykC8VhrXETBtQs2uxbk7Vn60G6DBryUtmU8NqjJ?=
 =?us-ascii?Q?SYIW9nHL83wmCotffIlYR/PL4l9KQST5uBPBdXucMI1jgr+hZZip0ykQEVYJ?=
 =?us-ascii?Q?Sbw8/n0ggjd90VqwahNtBXZeYUzduCOsTZUTF795omoADCJbqoyw59M+qlgS?=
 =?us-ascii?Q?umTfBwKr3a9YAJ0DXH7LckegCMWOvcEHdyQGt+zFwjgqmdZ6z4olGJ/DjoPN?=
 =?us-ascii?Q?OeJBRwdJPgr1J/cqVsPI/78kBQUWkI2T+FWiKQARSz6zMUzL3loxI7yU29hC?=
 =?us-ascii?Q?weruY24FM2TSofewbK+LQ4siYKPRuwUgWF+H8Vm5dYacvxiJ4XsQCFYz38dC?=
 =?us-ascii?Q?jiRKyTrwP0i+E1NDTczv5YXsmMHJ21yLWzIhb6G6UUBvzFIfGAekF7yys8C2?=
 =?us-ascii?Q?C4UQau/AoG0Lh4WxQBtfgCXeNqJ2oW7FxQskbM9GUi8kF0kFjK+I+tN1ebnX?=
 =?us-ascii?Q?QtrxGN5Iw39DDKM7Q1l3PYXVxNvhDhwxXeFYEVfB6/0jKZpn9vZFmSZ8EdQg?=
 =?us-ascii?Q?oVyzMTAgFqaDWpzX9VhxJI3Ph69nEe00pnhbTgMKB+Bmc7vYfKhxaGbwvbnz?=
 =?us-ascii?Q?LYfIjVrdKM4A1wm8nkiuxS9eo4s0kQGxmQ6OXAAiu8IJ9dXjezR3OZYW0oqu?=
 =?us-ascii?Q?br21BRHuVrjg/4yYZPK7++AVjI3twmGmBWGw8vtvFszOwfIPH/I8aqRGC3YE?=
 =?us-ascii?Q?EXR5iizOM0ZRas8V8dcNcyhyodwdzvvFYnaJZ5k3GNZoj0gITOD2qP3gTBc5?=
 =?us-ascii?Q?smNtpyHXo4rz0tyrjyz1EXperJbmyIVf4XmDQ3L57TBqaKH4dTOHYr+SZewj?=
 =?us-ascii?Q?SpSPDZFcemxs5AEMQKS3WEUm3hukWnc5ApMl03jjG6HiyAyviJ2ai2+6UK3Y?=
 =?us-ascii?Q?UbFyZRcxjmdJv4v6es4IW8VIKuYzzmMAWxPghs/tED0UVnlUMgsNIYxLPE/r?=
 =?us-ascii?Q?MZJ7VeFDedMR320Ym2SXNSvUNVVHZm6jBmNtPzIQhtgjseR0KCLgqEcwr9cR?=
 =?us-ascii?Q?00LHBqe4kGJG44EQB31WsaFXGZpgNNgKYANqxsG6DbJyOTH0XXaSlLiAed2g?=
 =?us-ascii?Q?utkWZbbNaQ4pXvqrdi10syZ+MnXHJV1KaHLPW1qJtKOoSyJaz+O1Z7WAgAC7?=
 =?us-ascii?Q?zdrkqRIH1ihbBMeqRJcSAkc57BpeK04AJkmMI5kDT4GmbkzbooIhHswk1hw1?=
 =?us-ascii?Q?G4pTIAq28z9Nc8vOL29wh+kRx8o4/J45QaRo/gpm820OFx/qVwQgBVGjL6Zg?=
 =?us-ascii?Q?NXl848qDc0Gm8I5rZrmHLgxP12MDKPgOkKLW2OHM/C20wm/DG1/ohCO4o1lY?=
 =?us-ascii?Q?ICkrK3CCs4xIUBxeHa4W/5lnB4nP8u9HuPf/f7NYFMnhxIPFC3VGFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB8068.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kO+dftB+qAZWzoORminsI5h6S/B4Ri+CqfyOdDpUf/oTmXmuGY5iP4cy6omV?=
 =?us-ascii?Q?4WRhbCsUqZQBzUv9JP5Wy2PIR9tVyAe5uhmqOoPbQ3pnGv98gPtgoOOJVrBS?=
 =?us-ascii?Q?Zxej1ebb6P/A+kHfb6DKWGEQSAO4T9DIM6IW9bDTM1mneijTqURNIMIRpLK8?=
 =?us-ascii?Q?kWHX30sr9nkDnYt6ugFIIi9FK9wGA3g4fZ/UHboSt4aBW46mUqMt4ywYb8Wt?=
 =?us-ascii?Q?iyN7i6pqaPYOuOHmHZJzCuS9/rP0ao3/X9wu3Rs9PHUFrbA+x+tG4+f8Lj1f?=
 =?us-ascii?Q?eWvcxQB0eFDeMXCl4Au1gaAUrckoZGun6eBHEnPybf9puY1PJH+MtfUbehjn?=
 =?us-ascii?Q?gR4BGPiXx7Ddi/T7AdKMRo14/U/BA2eKHn7KznFDvwUfrB0J8CTSRkrXAByt?=
 =?us-ascii?Q?pGDBNEbrRfxaWVtdectJ2Tq4aolutjjOfJzeWcI8uIeWumj+10YT+eWlPnAs?=
 =?us-ascii?Q?8k+luzn1i263VK7/11ixbx3xQHERQv7r++fZQL2UaqSTZ/LahZRGoxF5Y6ao?=
 =?us-ascii?Q?aOQCBiB+1Uz6rq/Ud/GaYfndOtiKya3s7X0rgtknNBntPIXV+WMSoSufwvVq?=
 =?us-ascii?Q?5cYiCxUUuMMbQo12qiEduKLS6petsHhgQYqgpdnW16CMW4Uek2TREkhc+At3?=
 =?us-ascii?Q?oHlQf44n2UQbuQ6GoC0jI0KMHiRvMGbnhEE4HFlzeKp1o+Kp6t3Dow1MddIM?=
 =?us-ascii?Q?woIAerJT0uW23EthTBVn4osTozLCZkmUtAn4ut7Ij5/RaIWrWvPmHwkiJiuu?=
 =?us-ascii?Q?8vd66ERyEHSObDaCMr5YDKU0eWv/YNZ+T/lG8oCmeKa52ZtfmNUzl3ZEpQwA?=
 =?us-ascii?Q?lo8Mc0DzaWNmkUt054QUjh+36d0q1uW1MYsOkIFXoaHquo9FFTawDQ5wjcLe?=
 =?us-ascii?Q?GmZZ4wbb47ebTyhPyE3vA3pltBWOglY+Ujs8Nh2dUMAvBiqmu4zHPiR+rtdj?=
 =?us-ascii?Q?D0dD2vZIvygqGmLD6sA0SQ4/wBT7hH3xkRQHG1xQvrC/S1a6yXWrY8nWLIQB?=
 =?us-ascii?Q?ZH6IC07kIv3agVmtkXJ0FVLL34vneGoUDthhb8ZEdGiuaQL5CAExO9wItTvi?=
 =?us-ascii?Q?wu0ucdfaouhD2rzT0HsG0wZYKWRGCufW1Yg7ZHyYK0lr09/5vRUTctfnKCAp?=
 =?us-ascii?Q?C2yEnVe8CkinZ5JGo+m5P6dGb52OuiRdLb/WFsg7u/tYuanReSweh9A8ZvQW?=
 =?us-ascii?Q?MuUj+90ioJqvAmQd7++rabvqNBnkorTszyKFJTpM7euOv339fe6CCjtcmo3I?=
 =?us-ascii?Q?wO5IwZ/ofm5sdCYXJepMq296kAvBerpFhZWipjASyMYNS2ZA8WZPR6qeDEmC?=
 =?us-ascii?Q?H2l5vxhFFpntMROgXP5r59ki/P2Kl7sEEu2WTuI/LM+sMK9qvly0Wmk1bjx1?=
 =?us-ascii?Q?zKNpaeyGpuLQR+SVi/kzO7LlqBHbQwuc61iKew13vW0dFrac2n+pCAd2/PBr?=
 =?us-ascii?Q?9ZmMAdfMCPA9qL6/nAq0DRxcnt+SidVdIwv5PsZepzGYQdgiQz/M959hlbJm?=
 =?us-ascii?Q?2j6gaHoYdVKfhwq1u+wrTfMOtpy8KyuLohFyKUXBaehESZCLQUz/nxhztmmf?=
 =?us-ascii?Q?HAN/oCxiMogFlW86IzAYMXU7UJ5/BfDoAGxCR5Yf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d3c9e1-7a34-48d6-de88-08ddcdd2f2ab
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB8068.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 12:33:25.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VYgRDGh8Oxhs1ojhPbnq1SkHBwwgOf6xzLLyKzW62OEU1wX+Uz6VX8+HhDUwmT5w3vNJv9XvJiP0RvVcdpQOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF81451D190

Modify devm_request_thread_irq() and devm_request_any_context_irq(), in
order to print an error message by default when the request fails.

Converting drivers to use this API has the following benefits:

  1.More than 2,000 lines of code can be saved by removing redundant error
  messages in drivers.

  2.Upper-layer functions can directly return error codes without missing
  debugging information.

  3.Having proper and consistent information about why the device cannot
  be used is useful.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 kernel/irq/devres.c | 78 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index eb16a58e0322..a1b934c1ecc8 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -31,7 +31,7 @@ static int devm_irq_match(struct device *dev, void *res, void *data)
 }
 
 /**
- *	devm_request_threaded_irq - allocate an interrupt line for a managed device
+ *	__devm_request_threaded_irq - allocate an interrupt line for a managed device
  *	@dev: device to request interrupt for
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs
@@ -49,7 +49,7 @@ static int devm_irq_match(struct device *dev, void *res, void *data)
  *	If an IRQ allocated with this function needs to be freed
  *	separately, devm_free_irq() must be used.
  */
-int devm_request_threaded_irq(struct device *dev, unsigned int irq,
+static int __devm_request_threaded_irq(struct device *dev, unsigned int irq,
 			      irq_handler_t handler, irq_handler_t thread_fn,
 			      unsigned long irqflags, const char *devname,
 			      void *dev_id)
@@ -78,10 +78,46 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
 
 	return 0;
 }
+
+/**
+ * devm_request_threaded_irq - allocate an interrupt line for a managed device with error logging
+ * @dev:	Device to request interrupt for
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the IRQ occurs
+ * @thread_fn:	Function to be called in a threaded interrupt context. NULL
+ *		for devices which handle everything in @handler
+ * @irqflags:	Interrupt type flags
+ * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
+ * @dev_id:	A cookie passed back to the handler function
+ *
+ * This function extends __devm_request_threaded_irq by adding detailed error
+ * logging via dev_err_probe() when the underlying request fails. It ensures the
+ * interrupt is automatically freed on driver detach and provides contextual
+ * information (e.g., IRQ number, handler address, device name) in error messages.
+ *
+ * Return: 0 on success or a negative error number.
+ */
+int devm_request_threaded_irq(struct device *dev, unsigned int irq,
+			      irq_handler_t handler, irq_handler_t thread_fn,
+			      unsigned long irqflags, const char *devname,
+			      void *dev_id)
+{
+	int rc;
+
+	rc = __devm_request_threaded_irq(dev, irq, handler, thread_fn, irqflags,
+					 devname, dev_id);
+	if (rc < 0) {
+		return dev_err_probe(dev, rc, "request_irq(%u) %pS %pS %s\n",
+				     irq, handler, thread_fn,
+				     devname ? : dev_name(dev));
+	}
+
+	return 0;
+}
 EXPORT_SYMBOL(devm_request_threaded_irq);
 
 /**
- *	devm_request_any_context_irq - allocate an interrupt line for a managed device
+ *	__devm_request_any_context_irq - allocate an interrupt line for a managed device
  *	@dev: device to request interrupt for
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs
@@ -97,7 +133,7 @@ EXPORT_SYMBOL(devm_request_threaded_irq);
  *	If an IRQ allocated with this function needs to be freed
  *	separately, devm_free_irq() must be used.
  */
-int devm_request_any_context_irq(struct device *dev, unsigned int irq,
+static int __devm_request_any_context_irq(struct device *dev, unsigned int irq,
 			      irq_handler_t handler, unsigned long irqflags,
 			      const char *devname, void *dev_id)
 {
@@ -124,6 +160,40 @@ int devm_request_any_context_irq(struct device *dev, unsigned int irq,
 
 	return rc;
 }
+
+/**
+ * devm_request_any_context_irq - allocate an interrupt line for a managed device with error logging
+ * @dev:	Device to request interrupt for
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the IRQ occurs
+ * @irqflags:	Interrupt type flags
+ * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
+ * @dev_id:	A cookie passed back to the handler function
+ *
+ * This function extends __devm_request_any_context_irq by adding detailed error
+ * logging via dev_err_probe() when the underlying request fails. It ensures the
+ * interrupt is automatically freed on driver detach and provides contextual
+ * information (e.g., IRQ number, handler address, device name) in error messages.
+ *
+ * On failure, it returns a negative value. On success, it returns either
+ * IRQC_IS_HARDIRQ or IRQC_IS_NESTED.
+ */
+int devm_request_any_context_irq(struct device *dev, unsigned int irq,
+			      irq_handler_t handler, unsigned long irqflags,
+			      const char *devname, void *dev_id)
+{
+	int rc;
+
+	rc = __devm_request_any_context_irq(dev, irq, handler, irqflags,
+					    devname, dev_id);
+	if (rc < 0) {
+		return dev_err_probe(dev, rc, "request_irq(%u) %pS %s\n",
+				     irq, handler, devname ? : dev_name(dev));
+	}
+
+	return rc;
+
+}
 EXPORT_SYMBOL(devm_request_any_context_irq);
 
 /**
-- 
2.34.1


