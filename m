Return-Path: <linux-kernel+bounces-749084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7D4B149DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A2C162D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A64275B09;
	Tue, 29 Jul 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="T8Tl6Y4q"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012000.outbound.protection.outlook.com [52.101.126.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE5D26D4F9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776925; cv=fail; b=E+k+c4ViHVxhnZDPmRrHIkCev6zKQr2Zbes11fK+0qnrLEgZmDXNRziDOkiyWusYv8DzxmMM61iSvbRmkqJq0Dr3tLw4CaDHXIE2zCPfC4jwRq+NuOpoVSr8eqHEwtI72p93WudUIgITnDvh4wTcwY+s/NLqC85JWEYz1H8bWBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776925; c=relaxed/simple;
	bh=vqOMB/ucSEzCaHsTJCW84zNLxGBgYSG4NyJOio7RbHg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bUYQzgju8FpQhZ7uLitJuqiHPXe9RUmi4esNQafGEwvzUekAFjl9NvDaVg3MH9jeh0UU6YkLizvYBAuWcTIMSQTCpn8CdZfkCc7mSL+W0zWFin8MZ7ys1x21W5JcUZ2NWycbgQGa/cbCxuUXZBtEll3/f+2RKBHR+d4Ayl7322E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=T8Tl6Y4q; arc=fail smtp.client-ip=52.101.126.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrZgz4ZxP27rEjbYnDCCqW379TNz15w2y8aBPlUajrRjtp8w4DZ9zL3NAc3QnkPegvR3+xPxLKvCbGN541o/FvwX7GZ07zlkdtuxi0KwFs+N2l6wxNjAcbCVkzwSCPt7qf78b21IUBrvJuSIuhUmKnKZ0acsn0ApIb/2rngMaiAjErt6kGg66QrbwlKj56NJ3bREV8yqI/E/sRQKg6y52wxfIjLTz5es3Up33GSG/Fm55H+dgUchGQ9PCRippCGA/ha+C2qXwX7WFRQ9o6pLQqSzbNyMw5ceKAEh++LLr5UbVvQdVxib3O8glds3yt5lvaKIhbcSF5UfrZoStmy9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzVOmQRGPDUO8Lv6chW99GvfRP2ATSPtpu6qCU8RciM=;
 b=JooUBqCrBIVOciwLdtfMehGd/k18cmHwRujlprPQ0zey27icULILr5kYV6xW5N9TXmtEJfjfinoa6CU88E4WBBOW5djdeHACnbvlEJjjG7AZg/cm+dBFYWfaxDIRRUKAoFj4ndxErzM5SfHUtPC6L3cT+qalSh6loppLcazEvqtNDh/q8s7JtFlPOsvYMv7fLxPSAOrvrwXLw0z0rKREYfDmYlB3ImAmhqMtic5jpaGG/9CiO+1z4cWxhemLiqvc3WIvjcd9mUoQAKaJl0uy1lyMV0RUZzY42dvfJVerulDtAf426CybgYfS2stEE1kZAWfJCJlETCx5Xk47hZkDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzVOmQRGPDUO8Lv6chW99GvfRP2ATSPtpu6qCU8RciM=;
 b=T8Tl6Y4qdZz6yRIcqOM6eEBL1avL9s4c2H2HZAfNtv8frhr2h0qZFZ+8KnYBJfb2u0RJlVKiGT9nf3IGdNvA6orv02rmiYjkq6ZaZ55Y0gzBOcsiNMvDaCHMCFI4809XOvFV8DfjpQELhFVdFOJYrBZFZ2d8WjrmkBDVUYzqGgWZyvrgR9CXd+mK5JFw2IAmZ9dxXa93FNwcMeYA0wItfjwFcEzIQGP1WEHN5oydU3z6IWWzGx1f+LW4EbFc1eg8N/5wr12VeO1Yi/mI6l5Ovw4n7EjUd/T4PyD08S+fFE7WHTwwe2bCQe7ohExeSxNh1VSelKbY8dGDvV//Uc0WNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com (2603:1096:101:2d4::11)
 by SEZPR06MB6138.apcprd06.prod.outlook.com (2603:1096:101:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 08:15:17 +0000
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b]) by SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b%6]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 08:15:17 +0000
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
Subject: [PATCH v8 0/1] genirq/devres: Add dev_err_probe() in devm_request_threaded_irq() and devm_request_any_context_irq()
Date: Tue, 29 Jul 2025 16:14:33 +0800
Message-Id: <20250729081434.497716-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: cdae262d-dbac-4712-60a8-08ddce780d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c+hhIeGq6aYUvB/p0qyHY/ydOMvBW5cwdLGKJ++8MHOXmP2j2AD0OuHZA2vF?=
 =?us-ascii?Q?+LLxGhLdIQNEVH078JFfE6W1pMjQ6/dMfEbuHSVaPoXMHJrcwPMHVAF2CFlg?=
 =?us-ascii?Q?K8SYh1Tgn/686stanvZUI33eyE1MYTiv3t64IaEMSyitPX281AQwX4j2MDeD?=
 =?us-ascii?Q?MFhVxkhDzSf9zG/z2sVf3LKuF9/z+KKynDldXc6NUMQH6W6EhCPWx+mHuIhA?=
 =?us-ascii?Q?CKWSaG3Vvz0M7sVu17EXDXR6082Q11GvBl7k6J3ObmOU1CpMkSjVS3cEfw/i?=
 =?us-ascii?Q?qf5oOcMfMv+E3AvDkFAN1TM901Tk+dmReQ2Rm8lk6+OtRrypPbXeD28zbtUj?=
 =?us-ascii?Q?AymWF5KH5Su/rVwOz3TN5H80xun6BnGfC1adfwt3c9/DZM9t2V4gSiOizAqu?=
 =?us-ascii?Q?xQhq+N4OLhO16SmaIAhaUHFyUapdsBl6E5ikCwrrLec7EwA5NsZb7qtXJE7Z?=
 =?us-ascii?Q?dorrt3yjyClvVA98dsqQF5yTcZ40Jf6VDTn7Ww7ja1MvRxdzhXnNq+tZLDxW?=
 =?us-ascii?Q?9OEiatno7/mkK2p5Q/8/XIGfgYLJNRLFoDaUM+zBWTwlJTvrG9lmNmoZPhWu?=
 =?us-ascii?Q?pQL3AtkZ9k3DsiywXKU//M6UtfJ88a4bdd2ao/I69t9pffc1v8lh/Lcua2Sg?=
 =?us-ascii?Q?prpgzhSahcG1oHqONpIg87w+V9/9j03aT8JNp32pU0Bvu5mUWe045dXn5h1o?=
 =?us-ascii?Q?fHPJurgZpWz/l7CjS8gcEQ//NTOQRnjmor9Uo23pfpBFRurUinnsf9kEewVP?=
 =?us-ascii?Q?ZUcbijGxwY4dxQAIUew8ssQY7g+wV3g6epth3ZOZtuszZ/+wCgmFacu4EBxv?=
 =?us-ascii?Q?LAI8oWvp57yRmP8U+wJDr/ZiJzg/5jsbYIbuhVhZxRkBnWK1nOLBPWT1PbZH?=
 =?us-ascii?Q?ryyGfDuZX+lD+7FgD98EbuGV5ONL+nKk6troy96xQWOkAcA2jlulYkuCvPPl?=
 =?us-ascii?Q?u0okj1lHmWo1i2tFbdssOgzzN/J+7Y2HPg8SjP0JQrCXEu/2Htq0XTBroenr?=
 =?us-ascii?Q?FmuZXo4TLS/vF65HTjL2fFeCEcTGmu419bu3yjEdTLBXcfEGwBNBfafUyQOX?=
 =?us-ascii?Q?NYncPP2zTLrUQW7PF0AV25xqsRRGBdCpkfAlG5l0MZJvfCvbOLZgmRINiKHJ?=
 =?us-ascii?Q?3q+vWlJFs+BK9/UJvWZzhpPQOy19G/yGU/9G2QmA1sw9AMsBsW/wQZyq8fzM?=
 =?us-ascii?Q?O2LhW2XgxJmIODqLRXF277DclUFFTB1sFCwppCKFHLSoHmQIJmhBH18ZV2OH?=
 =?us-ascii?Q?Q0De7fxmEy3X6CzWLFOlNHLuMFHVC+2UFt7SlUKGslC+BvHb6GZKMqAFFcQA?=
 =?us-ascii?Q?o4L0tsbb4mKGlzYs4gmfI1C2YcGuxQyWELBjk0U8QwsOd7LQyE42vnNTWvWS?=
 =?us-ascii?Q?LRdqFh+MJECClVQdoE3yyEiTMcKLaKe43WtiZvWZlbiEw+a4M0GfkIAMEIdY?=
 =?us-ascii?Q?QTKDFBhFQboTGBtUUx3dWSpAY8Fyi9O4sVlgZ2sGuX03RcKd8In6HroInYUk?=
 =?us-ascii?Q?ffvPcHn4UeK9qlY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB8068.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pEPwcavu3G5ehi4ZiRfK2IPoemTgOG8QwuD5xISq8fTmegl3JTpdPSK5W2Mz?=
 =?us-ascii?Q?0DMLWAyJr49g3u/gU0CHsHFp88IPDSUsvc69MALNcqhVrpVS0II4D817nwaW?=
 =?us-ascii?Q?SKMaBaHVqGcEquP20BY3X5oA8u5nTfDWj2ENmajk59FPajimluA5biU5aOXl?=
 =?us-ascii?Q?+usqCZeRZ9nHyy1yl0R0ew34HN+LSbXZuhJakZ/3Dx+wW1dklCkMrRrehMzz?=
 =?us-ascii?Q?cNRbYcgFpbAeS1pgdWZRGGVX1gXKIv14wXu56XO0mtbwllk6MNHy/fO6/leF?=
 =?us-ascii?Q?zmvu2wEoTgb/h779bR2bZu3zBBV8/WR/gSQnocR5bPj9sJy8aBOFbU1BlRN9?=
 =?us-ascii?Q?lXdq4hH9ubN/SjnciGTFFlZAPWGd356CqRiQiViyUOM4wy+jPvFT2JC46C2T?=
 =?us-ascii?Q?tNuHuTeN7CHq/Crc2At6vc4QRW/DKe4FWpIAgDzm4JU2ur9PwRYVQLWjfHRM?=
 =?us-ascii?Q?bULLu+IfU4OaRHtbLA2ukqrMUt3CMtjWQYWK0A7FcdriC7gv2ZuFRtkN4UKw?=
 =?us-ascii?Q?nmnyIn5cq92P6Nrsvi/TErpwOd8XW2IQaHxTRpXiWjx7oAoQ4lwqHci3Ve4g?=
 =?us-ascii?Q?kRtJvCDyYsZTnmMFE/+1ZXzwdZUkZNyy+1cLn+oTBhCExwOowO6H9IsM1kSJ?=
 =?us-ascii?Q?t6JXwO209Ek05Le8AI0icGFp/BswOpvNKc9dsXs8MrCCpgsLkqeG+KqG2vyN?=
 =?us-ascii?Q?R+sDCueh0acDYNG7x8dHGp4VUF0OOXQ4XQvTaiYpyMhE/i5jQcBC4gJIi7rz?=
 =?us-ascii?Q?XlLw9y64l20R7IXh3kr4iQBMZA07VH2xAlssKfNw23rDcLUXxhZ4udlL1ABg?=
 =?us-ascii?Q?2jxF6E4LvRAFzbWi1R8hhdzITeufHx4gQhUaxdeE4iy6YjMiybEElyUSzFkI?=
 =?us-ascii?Q?qRFD8wI7AaT0t4r2mNmmboQI0On0AitFdLXTiDehco4zGv/G/8xljiE4hhpz?=
 =?us-ascii?Q?cLLP/fbWvyIIaTz7ej5lnzJImpCCq7cz81bLqwVBo+yNXkNDRXD+hVQ1XhRU?=
 =?us-ascii?Q?TPv7A9kTl9pu9VRbUNy0O7Xi7D7P0b2aLqRotGWFZj3GKovwItdE3diT079/?=
 =?us-ascii?Q?YqJPh3kpk20vScJPzsTbkmjNoo2fdSlibc9HLMsPzeHAo/8bkZrmMiYUHh7W?=
 =?us-ascii?Q?XaT5egeQ0lI1Sv2DT2BSX2mO06/bo5E7T4v2zE41MX7gyX3X12KSfn3qiCvK?=
 =?us-ascii?Q?k28GzFISn5ccPWzpRnQ3GBgZGwN/3P0VThISTCKNUF8Zh1I4COg4IlJXYjhc?=
 =?us-ascii?Q?0Mz4bO56Jtc40J92uEYwV/2GkuctL/HTzte2mhyIqQqjkKu5xJnVEfJEqNcs?=
 =?us-ascii?Q?vvOYOOtdAWaL/5WqLFr5JcJ/kCdxV5BeCRKE+2G4a1RsCrD2YL0gmTmkDioL?=
 =?us-ascii?Q?z0P4/rvfC+18GPhOlnQjnqgEvxleZJ5O4blKcDyvLePUhaSESrp4LAsvn4gM?=
 =?us-ascii?Q?M9I604BMwh5pPFPj0S0wNXVcRSd0IB8SqFKl3S0V1Ws/5t8267/Rv8OxYZ3Q?=
 =?us-ascii?Q?vuZEy4cMPoZ737q7eorQENPdfx5oj1BsNo/aCH741YgfYsHfwmiovKVVUPR7?=
 =?us-ascii?Q?159+EJ+ogmG2GRAjW92tGkg8y9fOVC8WbpvmXJIj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdae262d-dbac-4712-60a8-08ddce780d21
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB8068.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 08:15:17.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0Mx/Ze5trw27mQ/8EDW5r2VWByUwY1j720NLVUw5hEBObLYPnAlzPDRL9TEjBZBe+jTuV9Z+NcCN874H3j4Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6138

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

Based on the v6, standardize coding style without logical change.
https://lore.kernel.org/all/20250728123251.384375-2-panchuang@vivo.com/

[1]https://lore.kernel.org/all/87qzy9tvso.ffs@tglx/

Pan Chuang (1):
  genirq/devres: Add dev_err_probe() in devm_request_threaded_irq() and
    devm_request_any_context_irq()

 kernel/irq/devres.c | 121 +++++++++++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 40 deletions(-)

-- 
2.34.1


