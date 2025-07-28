Return-Path: <linux-kernel+bounces-747950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BE0B13A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00353B509E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA38E218858;
	Mon, 28 Jul 2025 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QGlgfvI+"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012069.outbound.protection.outlook.com [40.107.75.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA08BEC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706003; cv=fail; b=AwXzwX1jWauW/CryNgIxsZGYsWQCCgXk9AUkJPSKSPYqotSn48/KY0N3J/jMENFc+T6tnf05MLLS/x+vcXGISdNyKgi4PVbEQPvdui5gNpM+QQpDQAJb4abEJjAQHEXhm5Qp82c4KulDfMd6j1CMrrQrka54+miHu/QllyZC+1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706003; c=relaxed/simple;
	bh=S1lrEPAHM7rYf9jC4ro5kWiuSABymRb92RC+BpV7FOY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SfRMx4nPXvEK3Hq8gjNkf1YOPoVO26485+KRGTiG6GISsR/dRyMDvUWCKXfv3yIQsXMSKkO1PoxK8PjU+eO/e1s8reB8rjcF8kKfthUzH6q8FgdT4CNmTuJEMAv+IoSV4V0DnPLhd573Cds5oz/QSpdTsuMnMN8uxUnKhwWKzMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QGlgfvI+; arc=fail smtp.client-ip=40.107.75.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWpNR+Z0dxYf6UHk0fCOagq1f94XmAxoh/RG9UUTwFrLpmVZalTF81DVucesQDFRUmgqC/ps/l0MPxcXUv/URj+C1h6G7RY07VZpnwpiSuL7kqll2gg7N/vCt+W7TVmYGkBd+FoKPCzWvjTRkNucsW9tntzyEHyz86C40/p7iyO6Zxaa1qF86amoFa3Ov75KDmzzzeNtfvlHl1g7e9vF8c2+HKWwaXx7JPWNat+I18XfbNla9AADXC77DHRseCVU4STmXMM1u+K/D/cgA/DHYeEWC9p6WOiCRtAyOEgyKqUVQHHBY0WYfO1z+h/DgunOWrL0d97AVx5O49qKWI29FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZ5Xl0t1IL4tPBNQK5DOZNwtZ9yZTohqH++WnJQK/g=;
 b=NGzh/JYIDZ8WF5Fp8lwtYboskK5KximTUBK62kRWbTrEnrU2ECrHdhEjQypTNT7k55Rj+tgAE9JmYQt7V1MSxsHLMiYOHcSFa2SjnSwCyKWp0s2nvBBOIu3Nj3sTJ76wi9NfUzOPi0QF45aLxlzacxy3y+cZukDsW+diDvfBv14Av9FWnY3eo1EngApmvjPb6DcBtSbP5ysGyLjIJJJbIhCwirbSESc/OxvwGfdemZj6eyy4+ZVsPmNGGEle1GH247/ajR++dIkcN58AVniS4x2E5HrQ5cR7L67XjPpcazKHYOdqFel+pwvWT/PbNAfQq1aLcZL3F51pAz1xoFy9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZ5Xl0t1IL4tPBNQK5DOZNwtZ9yZTohqH++WnJQK/g=;
 b=QGlgfvI+g8wZhQQQUPARq55ysMajVOk1wlG3j/3nWBUWZshuApEzu9TEOJqQ4ajcjnc3UKDsZHSg+9TPWUoEc68wRD1XqTqxThIzMPUGDt0pEpA1a3Om97AqETZPKt7ucdkrEoFDwqbRBNldvL0vACh2vElmUX05DU/aK+8YPJxvrwgKQS9tCFi/wmHOqHCAbgrzMWg7cZRTZdK3I5M247jmyf/0Wuz0a1g1FMrbE/HCRRLq2gzPw9KQWwwMXZplnqixu19Jt2anCMfKByxBTu4Id1K5MTr6kaD6uu5u108ZYZ9W4D9q9lFb+QshOFT1Sca2sAOTvB6JOldztdU0wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com (2603:1096:101:2d4::11)
 by KU2PPF81451D190.apcprd06.prod.outlook.com (2603:1096:d18::4a0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 12:33:16 +0000
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b]) by SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 12:33:15 +0000
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
Subject: [PATCH v7 0/1] genirq/devres: Add dev_err_probe() in devm_request_threaded_irq() and devm_request_any_context_irq()
Date: Mon, 28 Jul 2025 20:32:50 +0800
Message-Id: <20250728123251.384375-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: d05306d3-9cc1-4324-1b62-08ddcdd2ec44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZYgSbeMEE8L5bGUhiI5YxHCoqJuZcRLOWvrRC7gsDpQRqVBeks612wlz8kLm?=
 =?us-ascii?Q?LME2Q83O0M8yJF23gr/J0ika/fcRHcjms0vkTglMcpkHK5eHFDwY/u+Dk+zo?=
 =?us-ascii?Q?3gMQXhBa39VAnNn8lFtjebm3oS7A4fWS3y4EbIWLftl/DlG3aMvHkAYoycgS?=
 =?us-ascii?Q?CO9nLONejcnAd/7Q3DANaLtomqi+rcShDPfYsnKmUfZsQErBVXaPMjifBSQd?=
 =?us-ascii?Q?9Rtez+2ONlQztHvjnj7hF14mtbQyZW8PZq+It33gMb/VnCQ8Hiam94smh4ka?=
 =?us-ascii?Q?osON1WLMtfsSYnLghm1uFN817pXuAc/YZhjt8mHvwE6gdUqwGQucBa7soUTV?=
 =?us-ascii?Q?IbKb+yo/7sUZuBdyhn73LLwvGaBfE46ENqo1zdbTtUJyxrupHiwoPXlKAY/r?=
 =?us-ascii?Q?EV99S2d5OgTBlfuqZZh4569GpgEXn77GVgAHzLLqV3286U5yVoILKGZamhaf?=
 =?us-ascii?Q?4BuJo2xsDJ5okFVqjulWK4aFYffruMxuV1Us0BhK/X3Xxrs908JLCW7uRTmZ?=
 =?us-ascii?Q?TQEVm1qNATKVfW8/DGaYArwbCP7emGm4xPQRl5wc89svoBSsIbxtXt/VI7Wj?=
 =?us-ascii?Q?0eaDeKJiX5Lbzl5nAIPCjMXQwza2kEERe0ZMybTdIgW8x8Gb52XoQrvkl7u0?=
 =?us-ascii?Q?DZtCypmi4aOHzKvyxbbgXiGvZhoTIbKbmt61frqM9lBZY1opBg0htmQ3en32?=
 =?us-ascii?Q?RGtBGGkLffuVZgOG31FL6EYdZwmDZiCJLxzJja5YTowXCptQvUZCo3+O0+fE?=
 =?us-ascii?Q?NpCAPLdF9EMBSXuR6jL5jpXFJJnIZnOw3Ty49GBJ1+fz4CMe/263Fe4c4P5p?=
 =?us-ascii?Q?r4zNAFWu09Jqz4p0JbMirAoO4C/5gdgI8ge6osXU+slGTzaYOHpDUMnrUsm6?=
 =?us-ascii?Q?vbaG8swev2Yo+gxptLEVyL1Zcg2N8YRjjqtgoyNrtSiOTUV0pgLB2WT3NpMQ?=
 =?us-ascii?Q?DN0WSLONBXyB8wOC1rOo+IktILYtLpmOP1INnWH6XAtvDUPSm41G3NMA9g8x?=
 =?us-ascii?Q?neNIUUbxkDtVAYaQJEsFmd9Ly5TRB17zAZkRbudBAulBUF6b8LCh1EYfzdkj?=
 =?us-ascii?Q?/C7zrT4Pcg7vTEXhieuEmdfz34aFkRTOFBofuQqWIyC2xH37DP1IwNMq2WOv?=
 =?us-ascii?Q?p1Np+J3hai4hKZy1ikbnyy/zQBxXCup+s30EJBW88AFdppZ2NUh1HirGqLxH?=
 =?us-ascii?Q?H6KkaOVM7XSFf0U8FmVk2B4bf7+80h89Hp8ufdWs/WXy92g6yHXNcK3520ng?=
 =?us-ascii?Q?GoNa1i1rmrfeerVyA/N33znrO58lYLiPthd9sBe83ac5Q0SG4ZEr7m7xMu2Q?=
 =?us-ascii?Q?EEkXV9FXAemHGDGpNY3wLdoXnpZFntJmGs6YTz6xAAi1S3J5VLlgTRIQ/qqw?=
 =?us-ascii?Q?ftNIMGg0NHRNjMFtTOf3yAhlF/dPnyMkxpBsW3YIKNlJOZdcOvlhmvxZUjOm?=
 =?us-ascii?Q?PBkN7UVsEl96dapz1UotMZkMTEXoYP6KdAzwim4jwf31YDKTen6FrO1GSHTI?=
 =?us-ascii?Q?OnkIC1WF6OqXpXE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB8068.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aeFDUG4N5DhxOgCWcxBkjjvdq6d/eV22PCVQhUeEu9KhKCkHWLMlG/ufmern?=
 =?us-ascii?Q?JpaVwb7p6ci3nyQyyg0QB1kGLh2X5Bkbcq9zxhcJVXagvmWnu3Yv+5quKaJ8?=
 =?us-ascii?Q?XKHgQiLAnopCoi3vo94POpAyKGvUSMP2Bu6O8R5E+IHyaBe2VuvTVMzC3iI2?=
 =?us-ascii?Q?TNckS8iBTSqBaueTooYPfB58fj55KAV4vEzZmhTUwGmTaT5Zv1dpESujQs1S?=
 =?us-ascii?Q?kZOv3Fmx+P/qAcnsv6r0+CSem4QDkcHi7VExU4a8jtyoRu6ys9eScr8gJQsg?=
 =?us-ascii?Q?JkIirnaCWUTxz3Ddtjs7JJfo8rGoXqyVTdgReVAAonRH9IZVAxME/1MToUiJ?=
 =?us-ascii?Q?N+f6dbeuGW57EhAtSl/BHa++FjzEma/9gEArXPtZIXexN5+LPqk3Twv6p0vw?=
 =?us-ascii?Q?8Zc6y3jGREQMlHevaNH+qQh6jISprj4CFOWei6qN02QFQl2h2/wqcjQ5ZQNU?=
 =?us-ascii?Q?CUlbl8yok53jJmyR710igpRObvObh/LC0sJhQNZrRF+OOvDOMfaVuL0f5QxM?=
 =?us-ascii?Q?ZvC6QKhxotbGua+vWShm6iLjs2GoXwaEm0Zga+XgTqmn2Q2MD59eFh6jk4/K?=
 =?us-ascii?Q?/Xd0ExGYqgzoZ0XNySbobNjtSMlqoKgxUfJkBni1B22szVr67Vvcl4WMxLe7?=
 =?us-ascii?Q?aaEwonRn1ggGJuLAW0vXzLvSPNsjYMtmKXrX0ivZs+sYs+leF2Wez+fSi0Wr?=
 =?us-ascii?Q?vlzxdmUfu38lMcGlFrowJi1t8f/8xC8cS05LEWfGxYmMcqiQjpoYnZgFvWPP?=
 =?us-ascii?Q?W7ULpddBPl/SG3SrDSl+IhCQQB6qyPELCa0277tAuf4G6kt66Ah+tcxrc0jU?=
 =?us-ascii?Q?dZUZrpYxBHIVUbvJf+PHp1XwNqTutnIP56AGcsusWpXwm6WGv/IZfZECDF7b?=
 =?us-ascii?Q?072dot9oqxkEN67sekxv8LahOBCMYNYC0e6sQEpBZty7orVoZXNrP8iIruai?=
 =?us-ascii?Q?HnPjwPLOkcD8oLi5S6heMkd39B0bcYr5B5c42Wea340adHCzcI9W1z4Ykx2E?=
 =?us-ascii?Q?dn3tGXRbO2B5zP4X4GGAFlEUHRcH8AFkFFjxzEuZFCorQ7KLOG8o5LORBHFv?=
 =?us-ascii?Q?bxdiGQx1KoiOs6jPU3N6vnyaiz5l8V1uh5yJmlTB2NRi/4QnDeTeRjyiUphA?=
 =?us-ascii?Q?8soluQVnDlMTdBfeytOm0f4cub7wrQDhnNGD+0mkOcSIclY2lfjvOy0milHZ?=
 =?us-ascii?Q?/Yw5AI4Yn4C3NhGkWTITMeQGF/S72H35/MCbMei+xSDmNuNlIyXiQM1oZq2b?=
 =?us-ascii?Q?A+z/Hn4+/2NdzxTT/fAqV7h1wbj/3yrT6Z2ch0SxGKdfu/66gsGz9O1wjSoq?=
 =?us-ascii?Q?vBoQbhF2QQlzAuOjQ9nTvHt3kwo6q6+AH06pJVgb2LG79fyUjyG7LPvzXUVK?=
 =?us-ascii?Q?BpRM1MpXcryL/ldoHW3Ya11WfEl11ZOq9lFat7rCEeXrJnZRRKEnSAvPkOpI?=
 =?us-ascii?Q?61icOprged0D1+KOkAsIPQM7h94pINyJPlP0d3rdPOY0ViSiu6BykV8kmeE0?=
 =?us-ascii?Q?4JI66/b6s+/t0VLVLQ01Di4CxSZoalLwlfT8qRHsr6B8Jo6nuqKNP3d0voD/?=
 =?us-ascii?Q?siIAygzr7M072DdvOvFw7uAxctjsOZiTKuRMZBcJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05306d3-9cc1-4324-1b62-08ddcdd2ec44
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB8068.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 12:33:14.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGbah5UlU6HD9aefOwnF7MFhxPhSKTimEErx43KyUFf4OVwXguknsYHBvFnHq/2AjIYiuuPcG8XMNwX1RNMTGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF81451D190

There are over 700 calls to devm_request_threaded_irq() and more than 1000
calls to devm_request_irq() in the kernel. Currently, most drivers implement
repetitive and inconsistent error handling for these functions:

1. Over 2000 lines of code are dedicated to error messages
2. Analysis shows 519 unique error messages with 323 variants after normalization
3. 186 messages provide no useful debugging information
4. Only a small fraction deliver meaningful error context

As tglx pointed out:
  "It's not a general allocator like kmalloc(). It's specialized and in the
   vast majority of cases failing to request the interrupt causes the device
   probe to fail. So having proper and consistent information why the device
   cannot be used is useful."

This patch implements a standardized error reporting approach[1]:

1. Renames existing functions to __devm_request_threaded_irq() and
   __devm_request_any_context_irq()
2. Creates new devm_request_threaded_irq() and devm_request_any_context_irq()
   functions that:
   a) Invoke the underscore-prefixed variants
   b) On error, call dev_err_probe() to provide consistent diagnostics

The new error format provides complete debugging context:
  "<device>: error -<errcode>: request_irq(<irq>) <handler> <thread_fn> <devname>"

Example from our QEMU testing:
  test_irq_device: error -EINVAL: request_irq(1001) test_handler+0x0/0x10 [test_irq] test_thread_fn+0x0/0x10 [test_irq] irq-1001-failure

Patch Link (v6):
https://lore.kernel.org/all/20250623123054.472216-2-panchuang@vivo.com/

[1]https://lore.kernel.org/all/87qzy9tvso.ffs@tglx/

Pan Chuang (1):
  genirq/devres: Add dev_err_probe() in devm_request_threaded_irq() and
    devm_request_any_context_irq()

 kernel/irq/devres.c | 78 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 4 deletions(-)

-- 
2.34.1


