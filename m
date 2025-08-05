Return-Path: <linux-kernel+bounces-756190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C00B1B10E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D99188CFEA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51262641EE;
	Tue,  5 Aug 2025 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mNm5K03P"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013026.outbound.protection.outlook.com [52.101.127.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689525A2DA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386212; cv=fail; b=gc21TJxmTdrRSUYrHe2ihPBxlh79Yixb0THm/rK9gZ0BO9nXMUUFQOr04b4VogmYqYFCD+Wu0XHArxkNaDI2enmiQSIeSs1x/6hsq4ng7vm6LJOBvo64t/BEzRHJlDr8A8SzisKBBsFP96f86Br8wCDKCH9SnYajs7ODyO5gWjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386212; c=relaxed/simple;
	bh=rtCrdCo9hkr51NCYZk0CA4Q7rDWV5snaWuQuPiAKAhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IB8IhBKr9ReNxyMeRubj3c+/M0mSC/rICSNg6Twr/msXHVWTwRq1fP9KrdWm7rFHbzgTf0M64zWfncnkj04yGrGnl+vpo0Ai2OM61SyJPCgwMumErfVb31dF/75GmbDbf/qtye+RJRE089dg6f/R/DqDoUheqzvgWh1ht14J4YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mNm5K03P; arc=fail smtp.client-ip=52.101.127.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuUzkNiFh7gB1mKAFkJQ1FPkOOqLJF+yCk/NUIf4bzzrDnBDLJXP2M4IfXrjGyykjHsDMBtMEYj/IFnnZKJGxMcxpIxq0KFqM3toAFxZVrw0gXavRccXZxUPohkLuwMF8PfRGDMaOImQSkSBJLAWYF79ocCZI07IpcP48eblKlkpAKtPmSjkQFgUYLFrZHHYkeu3+t4hQsf5wrbKC4v5VjdUQYQjzJkvXnQP/vQoAeegd/V254sowOx+JFhK/XeZJFhSbqlQlVr6gygqbkwiWNa9yOq5w2uMF3EEpo1jaQ6RpqYoM8cOxUB2AgeR3swdDxV4lKKADiuIDfDyWRFM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGhqwtNeSJGv2G1a7aX8CvoNolFBbJZEyBMj2qZXkYM=;
 b=d+ZNUstgwidRK83lCmafPlM1HbBB5M3uk4FIHyWTy8n7iYX1e8XmhITr1XkOQu92KP9c9S7HeC96d1TBB+Kla/X9kKdUaz09AZ6ScVNe4MWH6Jd3SLh94l9kAI80iUXYMao+gpLimJwct4vnu0jMQ1LYCGwrh6KYt15mH8sI0YuimNy1BCmRimg6J7UQL263EDoGOYvx2sQE1p1ZvaHWWTdOFiPyxTuMRrzaSG039lkZLvrnPW1BzyL/2QXWo0uog11Yhwie3XzecneKubXL3khcbah72nHgkSwieLA2tRWAisJyr7sR6tWcP1sHz91a/i24RuCdqJW2AawHRiLFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGhqwtNeSJGv2G1a7aX8CvoNolFBbJZEyBMj2qZXkYM=;
 b=mNm5K03PY5o1qtnoKxrI5nqmicP92o7r9Lnp4vT0+EVe5zzuduRQgkGpi2e4kXHHFKfAi5/1iz0v6IC2ru1UCHlVRmn1lczcKBNGKkMsGFKc580zo4ZY6OHhNefSPZ2LicZZbxzfb0bmUwyiABQ1mLMyV3ghCuYfhVR7izrTqIMsFIx6YG8Xic0r8gDfs35mNwf96RkCRXfZbSvzKEPKpZBCHaejrtW/P5fNm1mYGX/6qH2KHYb3m+951p4fGnCeR7YWCFDlVgq8+vU+22EsV0wg3euFVqrOThNqpudoT3TuIH5uk14/UOSUQ2VTX9YAfsoR3C+cZImGGZ6Q9rpiig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com (2603:1096:101:2d4::11)
 by SEZPR06MB5643.apcprd06.prod.outlook.com (2603:1096:101:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 09:30:06 +0000
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b]) by SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 09:30:06 +0000
From: Pan Chuang <panchuang@vivo.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	Jonathan.Cameron@Huawei.com,
	u.kleine-koenig@pengutronix.de,
	angeg.delregno@collabora.com,
	krzk@kernel.org,
	a.fatoum@pengutronix.de,
	frank.li@vivo.com,
	christophe.jaillet@wanadoo.fr,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v10 1/1] genirq/devres: Add err handling in devm_request_threaded_irq() and devm_request_any_context_irq()
Date: Tue,  5 Aug 2025 17:29:22 +0800
Message-Id: <20250805092922.135500-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805092922.135500-1-panchuang@vivo.com>
References: <20250805092922.135500-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0325.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::8) To SEYPR06MB8068.apcprd06.prod.outlook.com
 (2603:1096:101:2d4::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB8068:EE_|SEZPR06MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 728f6e54-d0d4-46f1-98db-08ddd402aa15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m1p+o7IlOogRVTkkhTXL8fwPPyi3WmvVjUxLb/GL8+5cApUx74EL4DmgZDrR?=
 =?us-ascii?Q?Q2gce57OVHxb/DrCK41VDEE4hflWeW0ke2WzjesndWXqUMNHFgpZIB2fH0mA?=
 =?us-ascii?Q?G9Q3CYBGxt/IUgPKN+UZOZoLo6l9jCQ65uigYq2N2RL+fwPvTWqPO49WdDmN?=
 =?us-ascii?Q?McabdF8E8t1hRR1NiOd1HWPzM1PNFqMN9gUyM+pQ0NvZvqZtN7zRo481XnYU?=
 =?us-ascii?Q?E68Mx9nzUZYR221Eo81mFa59I9aBIkwUnnRML8PbZen5Y64HBwXEKD672xN2?=
 =?us-ascii?Q?YCtAcxArYRub1zahcj35DTMIP4TvqsPJJwxl+XfTEdeg6VuvUIHCzKRtUolw?=
 =?us-ascii?Q?OisJiG5lTRvvN4u1cg6dcHywcRhQFpx90gqWu0iOxrrJ8VaGzrkh76sHW/M4?=
 =?us-ascii?Q?OiAqJaeT375vHvEL5u0ErKJlbYcxEnc2cMBXJUX35JZLoIL6B1kPSHEo0cb4?=
 =?us-ascii?Q?s+Medut5O6Eb3BuWSVaMfFSGKYp95++3wfqDUyN/lGUO6e9kcNQ7MBOLA5ZM?=
 =?us-ascii?Q?qbCTEsTkJwKg+pRAbUnvw5M17sWuexcTizEdIwvqPQELCneQNMMV9iXvSODU?=
 =?us-ascii?Q?gf4cRUN0x5JMyWYlEVsPwPHgLJcMSI0reGlyLaWz61gdFmoefr7nZbWoaGQB?=
 =?us-ascii?Q?KShdhQbpmGR+a11kjgrzxsFT95pgLNV+K5cSaQSEw5YG9rEl5CA65geSQgjQ?=
 =?us-ascii?Q?2qCr+Cax4bnp2hb83s2dQwx/nSFtMQzyaG3E15cfCV4jGdJ0nQRlFS/UYkqd?=
 =?us-ascii?Q?ClGdd/2LguVzmBLSvLhlEMVUPklAkxlebqPoLJNvDrOZGQLIP7hf6MjT7ibQ?=
 =?us-ascii?Q?vxWmgvsnyIk4CV4I7yxHCY9P5O8Y+/2ywzDaoTKsf5BK7FSuq9BNVe3M67A8?=
 =?us-ascii?Q?Ll5Fndv76P/7dAgXtzFzllYweHWm5gHQRjT7t/0pTYnbKXuZrcNeuAX+zQhJ?=
 =?us-ascii?Q?FlEc0wkY/dNv/+vAIYBaBGZIrMVUu6eCgq21KEzj8p2KK8uVJMHgId1Tpcoa?=
 =?us-ascii?Q?AhrwUfaRw+sQAIIcfN2tb+rr+NZxdyTr6XNk9w5Tl/NaccOiy4rzZ4Rtp5Nf?=
 =?us-ascii?Q?m+6k4Ju8EmcfmH3JnLRY4swFU/zXkuhJbSgVQHElRo5eSstT/SXpT+9Mo7/2?=
 =?us-ascii?Q?6CIYmYJdqgjChpQ7cwGt+PmvuGDs8KYQl70tT2ZZ4JWP+QzDTi3IiDt2l9AO?=
 =?us-ascii?Q?1MC9PERCWE7YDOQFghwT0wNmU4EbCx6P9+qdWAvyYto4XEQ+TfBpAHrG9h/P?=
 =?us-ascii?Q?fyOkISncFz9UYYEnXcxrGJYTjIiLnmQiNs7/1GXJ80jQ6B/yWaq2PBfJSmAC?=
 =?us-ascii?Q?2DjTIryv3Bt6cYEnnjIc49IjUzIezn4ZpMcoyyaDvvqHJpolsvC2uyQV1ZeV?=
 =?us-ascii?Q?r86FQCEl0pM5CBFsUO1zcpi51NVSQ5VBmMxw6TAM5pxRUE5FrHq5559hg4Uh?=
 =?us-ascii?Q?ebxfQ73hwWe2CKGsAWNyAPKruE4q0YEgrNCQ+EEZikIDYz8VnYs4qA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB8068.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G5HRoRNn8wiicgHs8Ej78+6FGY1GBZajtGlcl30ExlLPKOa3qoO7oJCi76yT?=
 =?us-ascii?Q?72f2LLnlsAyssXcLSolXJb8AsvEXGl/fpqqRY84/KYrFwSubp/OGHQvW8I6D?=
 =?us-ascii?Q?UMhwycJQrkQoK3g7uvRVg5yZjdrNBb8l4a4aCzoT/cnYq7pa4I9kcX7fV22J?=
 =?us-ascii?Q?ZYVcPohW0ecHCyvhv7e3nyyb2wFweBlzrOoZNST/qOldqApTr3GZVuWI6t7X?=
 =?us-ascii?Q?Wz0zuVqqZyFklONikX3TLRQlNYdrx42cuP316B6LVW1iz/dXbqFcJOLfN1ND?=
 =?us-ascii?Q?tYpt90qsuO91VN13ZF5gSwdfms4Mw8Ns8E0Sukt6l8U528gqZPJ2akn0mB8f?=
 =?us-ascii?Q?UpX5tilmDuQ34yLOl7fyBBGxT4WTdPCGbtZDvDvEF83VFke/34uEw4v75K5u?=
 =?us-ascii?Q?/0x7ehp1akVjGl1QJtKhbAD6Q+SPWWk4gXrWFzIm2N+rz/0cE+AP/hgs5pJm?=
 =?us-ascii?Q?wts4fCyYDNSeZ/lB5XvmyzVYca4+PHiFgueeOcVPE0/6JuMtt9sQKvz1IXDC?=
 =?us-ascii?Q?1ckRl8PUBWSzojEnRyUdKXaBWEkMnVAg/7H2cmhenK2+CYllzEv4poIxAMPX?=
 =?us-ascii?Q?rIGs7FO+tq4Itm66dxyqmTCFT8jngiXLKqTrxM9fES/niA0Kd+FQRVsE4pLX?=
 =?us-ascii?Q?GBuowHUnjkhRHhy9xR7mivsJTkDGFlgyG0cOCKY9I1a4OtdFMK9AR9HQPlwZ?=
 =?us-ascii?Q?kM8fWJ7pO8w1QvYfdXrH+jlv6hyo+/S5m5D8M8ioMaPG+qYf8Nb2lztZmQ9j?=
 =?us-ascii?Q?96DW0li1kPxGfUxuhgksv3UYcvT36bUVmsixW9pkhhr0G6ed5Wg0DSY9o2dw?=
 =?us-ascii?Q?zXVIlRjed6JuFOxNsjbpfqv55mV2NV1lnR+X5bvS+zhYVO/aahohvuVGB82O?=
 =?us-ascii?Q?WSuFUHVS8Mem6kksdL6Cs177IctgrrJ3oLSfeQfqjsD1+MkyV6GDKx4mde3g?=
 =?us-ascii?Q?dBYAs6LGZbK5wvOo55fNxiK68KnGRoMIfPUr7kEaaLqh0mW9A8TO97aiiGY5?=
 =?us-ascii?Q?FhhDuCNAinaqheekC55eRg0QMzZhwOx65I/i7kk/au5ZVbRSCPek3eWC/bdt?=
 =?us-ascii?Q?WKdFav0PnMmadcKgafDMxIAQdiwc/rc8m3qWRzixIyQkR3+AAHhd0vBenXGM?=
 =?us-ascii?Q?6Nk2Ftn5i5+83zYdoyXvY994RWCCyh4q+kCiRG0ZsQjWrPE8EUO/87AV6t95?=
 =?us-ascii?Q?uu92jm7Z/MScg66c6gEji6Dzeefud01ePlH3lkxUA/XJMYyHkcYTxh4ZGuq2?=
 =?us-ascii?Q?jB//LU9nqr18xK/YN91HV/tIaICuVwlfWGvnv+ttG8wdK89HiMGcV4TSo/hW?=
 =?us-ascii?Q?/B2XEI8X+NXZ620z6dXomu0hR+ed3iCyIL+yHuG1F42AAbr2JpbkYa7lmntE?=
 =?us-ascii?Q?p2kNtqef9e3RvuTYUALWSi7BsMe1UIj8INyN4d3GeLGCS5x6NVVJpm4li77A?=
 =?us-ascii?Q?iMEPctvdyTvX0YMOZGPbcw8vbARUnF7YEj0/v/2LQQA1vZMC1U51kRaHXPPp?=
 =?us-ascii?Q?XkpDnjErS6m2Dc4KDM4RRtuSbE1SEfQ+n3fSrB2hxHDnoA36gpb9FOWMvMgi?=
 =?us-ascii?Q?EJbuSnl1vbT3ZXKMTBxwKE/20Ibmwg46W2PRMlR3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728f6e54-d0d4-46f1-98db-08ddd402aa15
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB8068.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:30:06.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtLGoaqNOtUeSPoiokyahV2+vP1+hTR96afPzzzyCFchBu0SyyWWABi3pJr71CUREzgMp9+vQPIwjUfE2BeYnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5643

The devm_request_threaded_irq() and devm_request_any_context_irq() currently
don't print any error when interrupt registration fails. This forces each
driver to implement redundant error logging - over 2,000 lines of error
messages exist across drivers. Additionally, when upper-layer functions
propagate these errors without logging, critical debugging information is lost.

Add devm_request_result() helper to unify error reporting via dev_err_probe(),
Use it in devm_request_threaded_irq() and devm_request_any_context_irq()
printing device name, IRQ number, handler functions, and error code on failure
automatically.

Co-developed-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 kernel/irq/devres.c | 123 ++++++++++++++++++++++++++++++--------------
 1 file changed, 83 insertions(+), 40 deletions(-)

diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index eb16a58e0322..90290e3b9699 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -30,29 +30,22 @@ static int devm_irq_match(struct device *dev, void *res, void *data)
 	return this->irq == match->irq && this->dev_id == match->dev_id;
 }
 
-/**
- *	devm_request_threaded_irq - allocate an interrupt line for a managed device
- *	@dev: device to request interrupt for
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs
- *	@thread_fn: function to be called in a threaded interrupt context. NULL
- *		    for devices which handle everything in @handler
- *	@irqflags: Interrupt type flags
- *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
- *	@dev_id: A cookie passed back to the handler function
- *
- *	Except for the extra @dev argument, this function takes the
- *	same arguments and performs the same function as
- *	request_threaded_irq().  IRQs requested with this function will be
- *	automatically freed on driver detach.
- *
- *	If an IRQ allocated with this function needs to be freed
- *	separately, devm_free_irq() must be used.
- */
-int devm_request_threaded_irq(struct device *dev, unsigned int irq,
-			      irq_handler_t handler, irq_handler_t thread_fn,
-			      unsigned long irqflags, const char *devname,
-			      void *dev_id)
+static int devm_request_result(struct device *dev, int rc, unsigned int irq,
+			       irq_handler_t handler, irq_handler_t thread_fn,
+			       const char *devname)
+{
+	if (rc >= 0)
+		return rc;
+
+	return dev_err_probe(dev, rc, "request_irq(%u) %ps %ps %s\n",
+			     irq, handler, thread_fn, devname ? : "");
+}
+
+static int __devm_request_threaded_irq(struct device *dev, unsigned int irq,
+				       irq_handler_t handler,
+				       irq_handler_t thread_fn,
+				       unsigned long irqflags,
+				       const char *devname, void *dev_id)
 {
 	struct irq_devres *dr;
 	int rc;
@@ -78,28 +71,46 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
 
 	return 0;
 }
-EXPORT_SYMBOL(devm_request_threaded_irq);
 
 /**
- *	devm_request_any_context_irq - allocate an interrupt line for a managed device
- *	@dev: device to request interrupt for
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs
- *	@irqflags: Interrupt type flags
- *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
- *	@dev_id: A cookie passed back to the handler function
+ * devm_request_threaded_irq - allocate an interrupt line for a managed device with error logging
+ * @dev:	Device to request interrupt for
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the IRQ occurs
+ * @thread_fn:	Function to be called in a threaded interrupt context. NULL
+ *		for devices which handle everything in @handler
+ * @irqflags:	Interrupt type flags
+ * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
+ * @dev_id:	A cookie passed back to the handler function
  *
- *	Except for the extra @dev argument, this function takes the
- *	same arguments and performs the same function as
- *	request_any_context_irq().  IRQs requested with this function will be
- *	automatically freed on driver detach.
+ * Except for the extra @dev argument, this function takes the same arguments
+ * and performs the same function as request_threaded_irq().  IRQs requested
+ * with this function will be automatically freed on driver detach.
+ *
+ * If an IRQ allocated with this function needs to be freed separately,
+ * devm_free_irq() must be used.
  *
- *	If an IRQ allocated with this function needs to be freed
- *	separately, devm_free_irq() must be used.
+ * When the request fails, an error message is printed with contextual
+ * information (device name, interrupt number, handler functions and
+ * error code). Don't add extra error messages at the call sites.
+ *
+ * Return: 0 on success or a negative error number.
  */
-int devm_request_any_context_irq(struct device *dev, unsigned int irq,
-			      irq_handler_t handler, unsigned long irqflags,
-			      const char *devname, void *dev_id)
+int devm_request_threaded_irq(struct device *dev, unsigned int irq,
+			      irq_handler_t handler, irq_handler_t thread_fn,
+			      unsigned long irqflags, const char *devname,
+			      void *dev_id)
+{
+	int rc = __devm_request_threaded_irq(dev, irq, handler, thread_fn,
+					     irqflags, devname, dev_id);
+	return devm_request_result(dev, rc, irq, handler, thread_fn, devname);
+}
+EXPORT_SYMBOL(devm_request_threaded_irq);
+
+static int __devm_request_any_context_irq(struct device *dev, unsigned int irq,
+					  irq_handler_t handler,
+					  unsigned long irqflags,
+					  const char *devname, void *dev_id)
 {
 	struct irq_devres *dr;
 	int rc;
@@ -124,6 +135,38 @@ int devm_request_any_context_irq(struct device *dev, unsigned int irq,
 
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
+ * Except for the extra @dev argument, this function takes the same arguments
+ * and performs the same function as request_any_context_irq().  IRQs requested
+ * with this function will be automatically freed on driver detach.
+ *
+ * If an IRQ allocated with this function needs to be freed separately,
+ * devm_free_irq() must be used.
+ *
+ * When the request fails, an error message is printed with contextual
+ * information (device name, interrupt number, handler functions and
+ * error code). Don't add extra error messages at the call sites.
+ *
+ * Return: IRQC_IS_HARDIRQ or IRQC_IS_NESTED on success, or a negative error
+ * number.
+ */
+int devm_request_any_context_irq(struct device *dev, unsigned int irq,
+				 irq_handler_t handler, unsigned long irqflags,
+				 const char *devname, void *dev_id)
+{
+	int rc = __devm_request_any_context_irq(dev, irq, handler, irqflags,
+						devname, dev_id);
+	return devm_request_result(dev, rc, irq, handler, NULL, devname);
+}
 EXPORT_SYMBOL(devm_request_any_context_irq);
 
 /**
-- 
2.34.1


