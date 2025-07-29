Return-Path: <linux-kernel+bounces-749086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2736B149E1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E801665B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94573275B11;
	Tue, 29 Jul 2025 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cw30pzpH"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012048.outbound.protection.outlook.com [52.101.126.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F95279DD6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776934; cv=fail; b=g3u6TwxKw8lAd2cbyALEkVj9Q2XZOpix9tCyl+mAwqaZGYY1o3u3HgG9Jx/QYIWqhDrcKFPR2SltnNDlfmSytnV4fQb3frMUW6eTT5qZBbiuVZJfupGFGrksBTNpaggyyBZodzOj70wKMDJWnPl2zvC21wlKymwL7Kdu/ps10tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776934; c=relaxed/simple;
	bh=ORkT+EvmPvn0W/tRK1Wrd9OJyap5eiE7YgLpKFC/ZZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cJhOgJK2Rd/MQx4GySA6smwumLzYL1JAZ4LvoIa+2sS2Vg1OJVt0eDDZJxoXTKQ28RxW/0vcr0Ul3bp0VKw4IpNvHHX42Bo0jdZwD7XYMXRS+EJCJ0HoQ4uPjMNuOQDhUccoV1MWSVIgz08+/5lWW6fQLg7Ve3ZwSj4sn+whkQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cw30pzpH; arc=fail smtp.client-ip=52.101.126.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+9PwU14yJjpHjtDokhBsvaAa5o8nk6CcwMC9GSnu//iJ+eqAnQTP8l5XLlE+NA8EGIBR39H4f95rb+e27nOmhp8KN5AuzTe+x3pJVmzm1P7KNTmWMDl/jWEmMdR2cm7Jz2K6hJxvJE2RomSgXUFsuN93Ux5P9HHgjRPspRwQeF+RVDHBceFWc3J0YXIIhNSH4tlhUN3U5H3lBcp7goqYAe70L9q85kNFuhXewnnmHQSGRCYcq5Wg8GM2hxaphq88D8GIKipIyfFB1WOIL2bLlYqf6WYhmg8LX12SQ5R7iuBSCc1n8fqqVUdaV1yTzRuNyO/+wNAGgL1vmVR996dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE7OI0cxiN/8GMHBQAzKZdcwG7yWqLXBkK5t8tUqaX8=;
 b=LJnjRn2KaPz573dKKRe8U2R5bwR2Q24w8nrbn/aF2zWdpzNbKJxF0sQ9NVOjpgjzODxtWmql965KRSJhjVSyUBN7H6sZmW3WkZJOxqNH3w/rJkOcTFs9hobyfaIBE6r2ziLGXfUMIGuMgS30u92msnhvYkIR0IsIBUGkzjj+I/PuRbVQkO6+bQM1bG07Za0F+USLhhzdL893raZZJT1+CrKPF5CpGjkpa1r+hYX7d4A735vLLJTuOimmePvTpqye8rbimOyJKm3vT4bA+Kq0IHd8KS+IPixHCgBqBHpyWuJtLqju0v0J6i6DUiWpY+YiU3MyeTNnk6zRguny+2ndkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE7OI0cxiN/8GMHBQAzKZdcwG7yWqLXBkK5t8tUqaX8=;
 b=cw30pzpHTXoz/Hh1y1Y7OXfEPPWn0Dadlj3FT8nkvdsALJJA1L1yG52m5VQP0GZ5DYn2ju5olELYovVFac9cIKjZsVzDmcPbbOGbHlG57l5CL2+0x92LwxsfjYDSwMJHrWSo2u6Qdr0XrfBEGpdKCRKog+FsNk8cOJ6B03iwZ9lBalZrNOUlYRGDWC/pvACHOymCTbGjnl4ZpMN8RXtMLqBC+Nooyjy9V8/fUQkGKlc+152v8UAP05rq3eJrKbIW60lpS30oP76nmORixXtfK3MoHjeneKeyGu/zSqmTUd8kSDXszpgCKJ00Lvr0TmU8ZK6DPi1fPlu/n+ssYHu8oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com (2603:1096:101:2d4::11)
 by SEZPR06MB6138.apcprd06.prod.outlook.com (2603:1096:101:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 08:15:30 +0000
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b]) by SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b%6]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 08:15:29 +0000
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
Subject: [PATCH v8 1/1] genirq/devres: Add dev_err_probe() in devm_request_threaded_irq() and devm_request_any_context_irq()
Date: Tue, 29 Jul 2025 16:14:34 +0800
Message-Id: <20250729081434.497716-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250729081434.497716-1-panchuang@vivo.com>
References: <20250729081434.497716-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To SEYPR06MB8068.apcprd06.prod.outlook.com (2603:1096:101:2d4::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB8068:EE_|SEZPR06MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: abb57243-0086-4fa6-0864-08ddce7814c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?igw8IMunH24XyieWjNEzoBkhxPsKxLeUZVLEarlNEe+7OqCAhffaz1biOxN+?=
 =?us-ascii?Q?2koCdbAGx03a725YQD4MR/7wEV1jzx5lLlAz3SQkR5gtfwb6owAQ9Ja59Vzx?=
 =?us-ascii?Q?LoDrLKJZEv9woisBXxnFSLyHP/sKfAdQF+uEb9+BHmyh9CTpxEmQ34u4f9+d?=
 =?us-ascii?Q?YQKCxpd7fVgt2egxuNZVx7sLusOj5F/ACUDdsEs9utpb9P5U285ZyC8smo4l?=
 =?us-ascii?Q?XADIpVrHcORXXABhFkTm+LJagq5Ki6EXk7/jZu+6HOizVA26nQTCN1QzbDJg?=
 =?us-ascii?Q?Psj82IXib7YqY/jiFCysBGIzG0ejsOld2+SfQsvTmmHqpRkkogVihNYDcQZL?=
 =?us-ascii?Q?aiYV981HxP/NVgcnykOCM7aML/jH9POXVQntax8VK8sGfRl24ZJfMlhYeKhD?=
 =?us-ascii?Q?NnvcVGBi6rpGYbcDo/b9VWw2WIsDwSj8WiKiA2OuwrYYSDxPishza+uo8Put?=
 =?us-ascii?Q?bTP+sMPam260ppsFyQQ6CNw4BNf10YRpozwZkzhM0ThLCLX0uPFeVv3rV5l5?=
 =?us-ascii?Q?XvQQkTWzMltQFXtix1+UK7j7+0mnFcfSjDU7hG5Ub1g8CuoW7ISwg3L0Io0m?=
 =?us-ascii?Q?4ynbYKC0AcDEwTrJZNzhcjgAoYsvpc5amgu0tXuXs7NYyAWASyH5hn/F9Dzo?=
 =?us-ascii?Q?Wr+KEPS/rngLYQmu9JJ8cAaS0XWqHuAkAPmKUa1ygNMW1wEnlnkNz8DNIt0b?=
 =?us-ascii?Q?jeg6b4pKaF21cFIdQwHRVczEEDVjVUp3R20tZSqiPJbjHuSHh8MkAqmLWDsH?=
 =?us-ascii?Q?Bx2Iw/TTkI3hzNCUWB25v+CW97xGuNG5+zqbV/dlw9cxadDWdKGrCbrXHqxz?=
 =?us-ascii?Q?7J6V2bPqYa0jt0qB/K4lB5JudR+L0D660KNquDqsUYl4pLJ1NQp6bWD6dXhC?=
 =?us-ascii?Q?1W6qF+rNvQ3e89fpzhM9DDLwJaVdhPPOR6+1ATfRBKOKHxxnVSaIgxBgIT8U?=
 =?us-ascii?Q?/4ltakNStXVHB0CC/atrIkZ+mqSeJ1rsPUjXh9sqNbu5PlIR6IsLoCypIew7?=
 =?us-ascii?Q?mVhAlA0MeUmuS96UoqIAxnmgBM7DqM0O4QhtwnG2kZGF//YlswtK6uj2L5LS?=
 =?us-ascii?Q?fRo89buol194Xkp6ZJbtmboLTTiXrb+7GwKHAeCprYHnoEcWmHd6MyhRnL7L?=
 =?us-ascii?Q?N3zaUIRi4Cg44l2y+bZW/ZMtRJYEqC+TJnlZyCIuGLt+4txMl8FDFluQ5S4v?=
 =?us-ascii?Q?fQPymi+USGrynajX/55pubK7NX4aQe2yAt/ltT+7mIfMQQ5HpDcg/sRfNKL0?=
 =?us-ascii?Q?p6b+kEygutb4C6KGVsAB5qrsdr7gh9zanDXNE7BpRUIJDo4oR+dU2/a8dRGY?=
 =?us-ascii?Q?X4W60V6HIBKx2MFZTet5gXx5WhY5JaXwhznES6gVJodoBkISajzLH+Wpe7Pm?=
 =?us-ascii?Q?7v9ad76N3yTHQAcpYilpLdCM7Iq/tcDuuAt7q3h9br6wbpeyNSq+e6PE+6ZZ?=
 =?us-ascii?Q?WKD7n3Cqnfh1IxfLVqFc4HNrUG6czd5D7U4aIdlzpH+GxpqVlkLSNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB8068.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?stNt+4q5Vj6+MtSsrfM7kFjxcyb0rfafFtc3RC7v9NlUYVy0B9jcNkPHkfeL?=
 =?us-ascii?Q?oHpXkxUpsO/iM0u+ije9E+sVMV7995rrBRtkV64ueavb6Wl7yvn+NSNu2Lnb?=
 =?us-ascii?Q?VfDAxBvrsXPXuZmcnrYwxgm5cZLiuValgrHxkLC19Wj32WNPJbafkg8X8V4x?=
 =?us-ascii?Q?flMB6U+2AIy5P/iM1kQ9OvFdEUladB+NRVpBumqbz9roRlnWljc7maFyHRFv?=
 =?us-ascii?Q?Nqw0QPvkN+wuHONZmqWzZJG0Kza7QwsBttpq8LhaC4ByTdTOfallS7HAp/+8?=
 =?us-ascii?Q?YRLfFKb+mBiinnUtegiJM/pUeHPGO05QuauPgAbtnMc8MnRGRtDnhptF+azT?=
 =?us-ascii?Q?3LX7h7ywpuuGCxcKC/EYgPYw75xSB/vehmwGvDVa0f42SYbTUSFpJrZkyAGN?=
 =?us-ascii?Q?zsjqWrzhWK5yJdMwDzi37myoaNKCI/izD9sycWveMRNwPM1aYbDF9DlnM4EH?=
 =?us-ascii?Q?mtX2/xAT3Y9qGsm/ljaptYVXS6KrMOdkKGMrQHN+mtlwQCXRLDai73bx0m/o?=
 =?us-ascii?Q?DwSVOs5CVELw/QAkMd6Q9EeZcN4OW7iKTfLShIv8QZh7U2ceebxnxVdrd8bh?=
 =?us-ascii?Q?WHEWb0vu1fxQOjfw+Zf8/FZlV+NsSPRyPe1OScm8Tedt2YJJwWsx4ktil6W7?=
 =?us-ascii?Q?u4AVQBm+fz7NxOC3bauuf8Y/zCEWRceosA1N0YqK5N4M54U1EiobgjNJtC3k?=
 =?us-ascii?Q?9Q6AXzuvlN6Ep5BSzGTBr8YJtOYQAuphI50LaXN6y7bSE1omKbRdo0/0sAn/?=
 =?us-ascii?Q?IUKYNvrJ40253jaaJbNh9Ad2r1zMgsRHIHdoQtXXvwWh0JuZNK2Gd4aQpS8S?=
 =?us-ascii?Q?yXUqCHRoBJKY+LdjRLS9J4XkH2oTt3GrotXZ6T9gs40dq6i0+IybodYoYVjC?=
 =?us-ascii?Q?3t6i+W0Fr3TROYTlYr7/nUjxpcTB7AusLzWqhcw7DREgOhaoLcxUi8I4NOwn?=
 =?us-ascii?Q?lRagRuZHJLZOAT8BONVIcFSm1tYDDgnJaunM1ma62XAHejrOp4TPiW42YV2h?=
 =?us-ascii?Q?/guPieVJEgu+tP2252yGvv40JbI8nItbp3nIOvwxYP8vhxvBqYDa2jnmHpOH?=
 =?us-ascii?Q?+w7y0Y1poUBInwWNhZz/2efntjFYm8zJaGZFRUlDHwWioEvML5RVJtdW70KY?=
 =?us-ascii?Q?NU38YTjnAt7lehBukukCAU7RwcoVnDwu1A19DjF0Pm+FFKAe/EDiNfs/v/9J?=
 =?us-ascii?Q?1ZQDXPrGwXvSMoDPgxxu7C6gPPt2HYsnwNC4HBczxpe3Lu8l/f5etltQmFkj?=
 =?us-ascii?Q?lMuLePChUiK4vu7/NFNdOmiKIxhZ80CtHvUpc+/I+ptLsUZnsAnoY+l7X2ic?=
 =?us-ascii?Q?t2uqzT/oenA+ZapGMf5yIMWx9Hm4P4AZULnT6TPyXVyhbYXFUfCzhgEBncVJ?=
 =?us-ascii?Q?njd2gnknFCYQ0PTZCIe/admTTyZOPP16kGLepksMkxrDKyRdtDLkUGUrr1Zt?=
 =?us-ascii?Q?6KNPrCn6Li96Pu5K7U9jRq/ktgn4wijUrGz8Athbzw2I+cMTCkBmTIhR1s9j?=
 =?us-ascii?Q?QpANagE7WvjxDrLVAyhy9BEAZrpl2wKCy0NijDzgVQYpD+qXwIaZ3Dtn0goQ?=
 =?us-ascii?Q?+32uz/m1hj2das2nQkS5K87wGdKWlLXrg9fGJrCB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb57243-0086-4fa6-0864-08ddce7814c2
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB8068.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 08:15:29.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vfv+RF9I0TZ7pi4KYdke/aGF/NZGu0PbEDmya+K18gczzXEDhb2DBYLWv9X0zntRgSGWfmiH4cree1H3mabXzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6138

The devm_request_threaded_irq() and devm_request_any_context_irq() functions
currently don't print any error when interrupt registration fails. This forces
each driver to implement redundant error logging - over 2,000 lines of error
messages exist across drivers. Additionally, when upper-layer functions
propagate these errors without logging, critical debugging information is lost.

Add automatic error logging to these functions via dev_err_probe(), printing
device name, IRQ number, handler addresses, and error code on failure.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 kernel/irq/devres.c | 121 +++++++++++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 40 deletions(-)

diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index eb16a58e0322..4656ed12532c 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -30,29 +30,11 @@ static int devm_irq_match(struct device *dev, void *res, void *data)
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
+static int __devm_request_threaded_irq(struct device *dev, unsigned int irq,
+				       irq_handler_t handler,
+				       irq_handler_t thread_fn,
+				       unsigned long irqflags,
+				       const char *devname, void *dev_id)
 {
 	struct irq_devres *dr;
 	int rc;
@@ -78,28 +60,50 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
 
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
+ *
+ * When the request fails, an error message is printed with contextual
+ * information (device name, interrupt number, handler functions and
+ * error code). Don't add extra error messages at the call sites.
  *
- *	If an IRQ allocated with this function needs to be freed
- *	separately, devm_free_irq() must be used.
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
+	if (!rc)
+		return 0;
+
+	return dev_err_probe(dev, rc, "request_irq(%u) %pS %pS %s\n",
+			     irq, handler, thread_fn, devname ? : "");
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
@@ -124,6 +128,43 @@ int devm_request_any_context_irq(struct device *dev, unsigned int irq,
 
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
+ * On failure, it returns a negative value. On success, it returns either
+ * IRQC_IS_HARDIRQ or IRQC_IS_NESTED.
+ */
+int devm_request_any_context_irq(struct device *dev, unsigned int irq,
+				 irq_handler_t handler, unsigned long irqflags,
+				 const char *devname, void *dev_id)
+{
+	int rc = __devm_request_any_context_irq(dev, irq, handler, irqflags,
+						devname, dev_id);
+	if (rc < 0) {
+		return dev_err_probe(dev, rc, "request_irq(%u) %pS %s\n",
+				     irq, handler, devname ? : "");
+	}
+
+	return rc;
+}
 EXPORT_SYMBOL(devm_request_any_context_irq);
 
 /**
-- 
2.34.1


