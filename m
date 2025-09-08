Return-Path: <linux-kernel+bounces-805064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5201EB4839F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0BB189AECA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1DA235345;
	Mon,  8 Sep 2025 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YaBslR+b"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA241BC41;
	Mon,  8 Sep 2025 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309638; cv=fail; b=GZa/O7SU0jJ6s5JP86Q2TGHd6pCYuqd+fhOJueFidJ8qo9HpCodrwr9G0FTtHx2ylwxm8lVm8DHApvlR8HnBz9pX5YCzq3akQW199G6f7UufABDOs462mJB7b1ukrJ1BCoz6RTu+aNhTelO+nfyo4daFp14vc4QZWbc3Lv2WCS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309638; c=relaxed/simple;
	bh=rjSf3ZdWVz8hYEegkQ650TuMGI47g7pph17R6yZyoyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xe0tpaMW+oF7RbV1xmy7vNkFnMv/p+79Fohfxsyuu7GbazPrXGIjMt8bqupv9t6LRtfuCJhdYmAkDM2faXwco2WOeE2/cAMXfzqD9E3J3bUtqL3UvOVg9q0aFGeMGPeRzPwbFhYg1wXOvDI+oAV7+xcHg+53Zl/7aKNH44nnpEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YaBslR+b; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWBke3ZatPS5Yxjg3KJHZSlgPvS96mTAmmEPpvmqa/KovE1iG5vqnVo0dvCswZ701bgu42uFM9ke/rY1ZLXxf8ShbzCoGD9mR0v96maVxM0+epCmlW7kClF2RVfs3fkoEwDpPbmI3hoom8Ewa3vvrMPvwt54xpKqKL8NtwgIRVx9ra3rXUTPLI0kiFCyqRRppZuuVpSlUTwJyiYVPoPY1Wq0nXZg8enln2Wf7afHZL4rHygEuVWrTI/2Gp9C0Nj5/LRzViP9ZIDuCrfPk/I+iqSBH6NYGjvNMQdTImQF8w/0PVPnjHLHBUsEPL4/LKV7fa3DkFcARyRvYln2nMzvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09bHrGXgM1TBoMD0bKBorFn5qTwKDAH4w72acWRRyag=;
 b=Z1vAAy7X+3t9EoGl/FttieFPa1KFKMjizpfqAgu+ONsyFdh3HSORuDrCBgUlooYGeMJYNY2d4b6nFKID9k8rdW14aZ6MPuHO2uzzr+rV4CawGq3wOjlzFrWxz0E6KcGRicaJ8hbi7YDZsrwC4hLiyOIQYR8THpXWM55L9qkW1NfF3MD1w5MQdQA7IVAMN1PqVd4dzxhFEdVib2kEVCbsaQrkp15UKUbyk88GAl4haWmra7nGGS4NCDnNyy3g1pIw6XVEVWhSdFep4/F6NrdYdH3I7hty+GwijVSMznoU46f7B7kdYTrOmI2GRdeXvaItRHCSKkxx9+TqafH0SneBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09bHrGXgM1TBoMD0bKBorFn5qTwKDAH4w72acWRRyag=;
 b=YaBslR+bInEyo9iCcrIE4vlyx9k/a65LxsgwBEplaAA/BsXCJx7VyyhlSzuAK3qc43HOacsXFq0beTktiCzc4qSRUD0T1HQj+ICHtkRQ4e9M6MKfHiyB31fiw1AtL2d54pnFDP+3r1quS63rxeXFWRAPTPcgCPjjPgp2xv9dgj1JcyTt+BUL36xacBOU8cJPCFU5yh7Z+7DiU0WqdFG2UEa86yBooSmsNkkzX07G2kGfamV/f1EDMYe1+ZMCOWyC2i6MTmmeOVZNdqfKsE4AAY38xcX1FrgB/LtAQrR0MpnQ77kmjiLe4KstDY63b5B8q/3tSRnHh4Ff/jXEm/fDxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB10727.eurprd04.prod.outlook.com (2603:10a6:150:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Mon, 8 Sep
 2025 05:33:53 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 05:33:52 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: krzk@kernel.org,
	myungjoo.ham@samsung.com,
	cw00.choi@samsung.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org
Cc: swboyd@chromium.org,
	heikki.krogerus@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	jun.li@nxp.com
Subject: [RESEND v4 3/4] extcon: ptn5150: Add Type-C orientation switch support
Date: Mon,  8 Sep 2025 13:33:34 +0800
Message-Id: <20250908053335.36685-3-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908053335.36685-1-xu.yang_2@nxp.com>
References: <20250908053335.36685-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB10727:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d5bcba-b078-4824-76d7-08ddee994bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jjWh7Pw6+dVMXPEwMFqS7EV+IqjPchtONOVUf4t68pDDSMC8VayDn3VNhy23?=
 =?us-ascii?Q?ZReIMLjHjr2WcHw5L5eiP/7/6AM7gH3P1ow/qX0lENaKSrL9cNsxJoNlecLP?=
 =?us-ascii?Q?WRslAMD6Wne1oQNSsupo9gygIb7tZvlOCcTSxAmD5nllf8tnUDzRHqEWR6BG?=
 =?us-ascii?Q?uhwne2A3BvrXsEByg7urCoDjsOq7WFxHnHXFirmQn/ZhRdbvDuF4YuCYZYmH?=
 =?us-ascii?Q?HbYJGOXq6fmFobp62gwY6mELDCOvolj3cemoyQMKP/kPtoE5z1aMLZOzDhVv?=
 =?us-ascii?Q?IpKgOax/so6bTtzvGUPFW65+cQ13FHzT651agUuanafyNOEX05PI4EGFLzj4?=
 =?us-ascii?Q?1AxqpqrUNmZhvAw/T5Z5hBeOS/iw6UOvwJXW8664RdmkTWT/0VWAm/2/X/ax?=
 =?us-ascii?Q?16Tidipvx6JFKcWChLf84uFTgtQt1tgmL+M/8bPCR0+xYaCjEk5Bj9oryO+a?=
 =?us-ascii?Q?pX4fJcJsGaUDs3nYI01WjcT345ka0Amin1bmFFYqqnBt50zmczFKV+M68wL7?=
 =?us-ascii?Q?LjUochFmHCgxwxqepLKLPuAnJPDWWYmtyNF/isE+M/h5U/a1wyG6yfsybWCc?=
 =?us-ascii?Q?d0TTW4q/R8ijO5qxForwbACnlgDEFKSeGJuWpd3sCgaTHDWLjYjGK7t8LJjM?=
 =?us-ascii?Q?mShtefc8pALm1knbu7KRSzwahsw6mUtbIjdZiK3nau9iBCnHVqya04/RL88M?=
 =?us-ascii?Q?qgs3F8tUi53m0Yf1p7BQJnOTqipIj3WeszDkkKUtvtFUzHCl15Sp+b8HVTLG?=
 =?us-ascii?Q?xfN6CF8ke0iT1G2fZifBvVcTkKlgEGfH+Byf80IdgXZmp9k4WgH1dRhTDxa1?=
 =?us-ascii?Q?1aC5o8gjjLvbGDkSDP0Wq4kt++RILGiACjx36H2B/zluQN+kP9iYYM4MpcZW?=
 =?us-ascii?Q?pjKC6VCukg39NvfVpDrM2aJIZDoYYoaIT00JJWrWTWk0oFckaJJA7Lm9V/gk?=
 =?us-ascii?Q?gbdz874vNUUNF9FhoBA2OaX+3ZIfqDwH19hSIAJxbvza0pMjDAYCcDuGWRHr?=
 =?us-ascii?Q?AJNs34GFYGQQ5us+xtcnwMmPit+aGeB69oml7LUoGobuU4iXHymKUb+j0i31?=
 =?us-ascii?Q?R9itGap5M5sHNJiG9irkt12sA6A3P9aAwZpa4p7VEab3iv1br2lZQQCOq8D/?=
 =?us-ascii?Q?nazDTok/kOmWYLJzMvxqTL9M08OS4wt2ucKPFl1tuevX8sUlKohOvcN1Gmez?=
 =?us-ascii?Q?6ismismi1O/r+M/0bnpYmTWgEd5q7Wr8DtqbplvHtfn4NVQxOuXDB5baHNeX?=
 =?us-ascii?Q?BCoJUkpNSkdlt/iUE/boJl67g+kbzKvtbSMlYqcLez476hnMNiPKxII6YkBE?=
 =?us-ascii?Q?i+KCjVvKnWSt5fZUY3l6pKX7T0nqQHo9q3pcBVfZAa1Qut5XBhtMeDsWhEAX?=
 =?us-ascii?Q?m0TbNMVjmpgZ62KpTMCd1AQ8MvMU/CRT28GDwRccWstohc4LNGatg9mfq1aY?=
 =?us-ascii?Q?Jh7K3h0UG47QxwuPGa9bL+UAg7gBcux5B6MmNZ0S02YW7L8HP8iqCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?njyK2tpIpNftHmJC4uYEyelkpxXAG6ij4s9iRjWPHLF/hXx9jCEY1nf07NYr?=
 =?us-ascii?Q?vK+O/mgA62mtmA0uyrHEKCyncBnVxYjsGBy8Mim9Sd+p4dZFVKGYqOErTzoH?=
 =?us-ascii?Q?DSQ/k1eKuy9aJlrvV5wpQQTsq62JbiZyqYVC4ZMJa4tFA7kaVNNO56o+VK4Z?=
 =?us-ascii?Q?Livrf7tjHuObu0rIjt6ujtavSnPhK1yhfZvQsf4QHDc5CP6bIfF4k1CCwkjE?=
 =?us-ascii?Q?S64KEw4yvaE6+u011d5TQiG4gz33+uAOLeCt29M4zDeWt9JXJgNz6i2H/GOX?=
 =?us-ascii?Q?Rkv6Ls35k+CmH6o9cA7MG7x+AgAGclihwqoKKhKdOzzA7NDwlqsSMPMH6RXg?=
 =?us-ascii?Q?fHohycchPVpQpHGBLH/7TMCb/vQRe/7eV2Or0BHT6QFvVQLXaH4hpMcvTD4o?=
 =?us-ascii?Q?keBxhE17zK6Ikx9Eg9BznJbz5eAQKkc0rNvCWkgg6B1tL4PYGhgS/zwUHa3i?=
 =?us-ascii?Q?1U5frABM2jjLTxXF/2u2DirChYCZGLpngJf59LPnYu42HBK7n1Wfflc0d0AI?=
 =?us-ascii?Q?RaG09taZNugszarOKqu9LWxlmzOlG3MR9OEgU7awVYyDXm1j9n+1Yjc9yS0e?=
 =?us-ascii?Q?BcW1pris+hM8uG0YHoWjqaXSGeP/3MxM/390QWSJuH1s8mhPx86nW9b1mon7?=
 =?us-ascii?Q?vErts3GIu7qFP4HAuW5XMoGUsa6ZcG7mjQO8O9OzRuiCDZphwgEK1AGwL3rG?=
 =?us-ascii?Q?lJ2T7URe1pnCNUshGd6FEq0wzdYiFbH8bcwbVBclbxt44fQkKtgftXCGSx75?=
 =?us-ascii?Q?O/1yw+uXpKZwAcDFFyF3Dd03e7RVHaqUq12y+oecpyYjQMt/e5w4jiY/s6+Z?=
 =?us-ascii?Q?jjJcl0NudU040rsBpcJOIWPnLgOrF5dwmFlQsuaHfOOuv9d2KURkJ3MlMeqQ?=
 =?us-ascii?Q?NCGPQ9kWHsZYoW7CojcYESecyayHOyRbUT8c7a2TBrDrMGlw1FeBxYbLxeRc?=
 =?us-ascii?Q?yLB89HWZkaUQ923vxf2YEyZ6bLUjLaayC7ZI1R2/HLLBosfARDTbtAJRV76b?=
 =?us-ascii?Q?ouF151BDFrI3X+gor9UbpuWgj4RLVMPg6c9fsAiwsQmQYvfDIcSJW/XDXDqW?=
 =?us-ascii?Q?tBZB+7XQ1g9/xre2YHRE+ydgcw1dr69d4+JFLOnAUk5WtJ6pCLqXYJhdPy+w?=
 =?us-ascii?Q?SXHPt0omkNCKjOe+SIkTfSYf2SjBIPC3eR0jDyGOIzHW2h5cyitqZY2dIBlH?=
 =?us-ascii?Q?IVP+ob4RWnr28ynvQGsGXF7B6Ws6OiKS+UDdfI4qbIWEKPGkmQA+PlA9ql5J?=
 =?us-ascii?Q?vDO8hSMxjZgWS1Fec+WtzfJ7yBdz3WbFnYHehTwLrQEUmk9tinyXjvacICz2?=
 =?us-ascii?Q?ydBjALR6vjGGvCAJnBykeR1LC5jOYaTGQV1isKnFOmJ4ux6IIA2sGFXexAO6?=
 =?us-ascii?Q?B1RgkymoqiXzakjvInZJIbvX5OZtZH7Me1IpIrtkMhdyqvNZOW21awjKZRT1?=
 =?us-ascii?Q?e+MUGjhQdrY/9T2GNjgIzxuWPrwHTu+Fa89fUz4Dfiz4CkpV4u3Zu+UUe2Xg?=
 =?us-ascii?Q?Ni802+Acu7v2qz5QlPsI0xdqAIf5hfXn09XOhclc1ZrvEV6vNFKdEXNCubhy?=
 =?us-ascii?Q?0XtoekxLoyzehfWpPGcGMuAcF2Iuu63z8HqyLibJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d5bcba-b078-4824-76d7-08ddee994bed
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 05:33:52.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSunC7b3phXGcYx3gia3LLJIxdEw3Yw/IVWUAUdaXoa+YmkbxDHqphRBeU5GdDJMUvVyP/s5/FE68l1UruHWDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10727

PTN5150 is able to detect CC polarity. The field[1:0] of CC status
register (04H) will keep the result.

  00: Cable Not Attached
  01: CC1 is connected (normal orientation)
  10: CC2 is connected (reversed orientation)
  11: Reserved

Add orientation switch support to correctly set orientation of
multiplexer according to CC status.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - add Rb tag
Changes in v3:
 - no changes
Changes in v2:
 - move "enum typec_orientation orient" ahead
 - improve commit message
---
 drivers/extcon/Kconfig          |  1 +
 drivers/extcon/extcon-ptn5150.c | 40 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index a6f6d467aacf..fd4ec5dda0b7 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -145,6 +145,7 @@ config EXTCON_PTN5150
 	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
 	depends on I2C && (GPIOLIB || COMPILE_TEST)
 	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
+	depends on TYPEC || !TYPEC
 	select REGMAP_I2C
 	help
 	  Say Y here to enable support for USB peripheral and USB host
diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 78ad86c4a3be..768428d306ce 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -18,6 +18,7 @@
 #include <linux/extcon-provider.h>
 #include <linux/gpio/consumer.h>
 #include <linux/usb/role.h>
+#include <linux/usb/typec_mux.h>
 
 /* PTN5150 registers */
 #define PTN5150_REG_DEVICE_ID			0x01
@@ -38,7 +39,11 @@
 #define PTN5150_REG_DEVICE_ID_VERSION		GENMASK(7, 3)
 #define PTN5150_REG_DEVICE_ID_VENDOR		GENMASK(2, 0)
 
+#define PTN5150_POLARITY_CC1			0x1
+#define PTN5150_POLARITY_CC2			0x2
+
 #define PTN5150_REG_CC_PORT_ATTACHMENT		GENMASK(4, 2)
+#define PTN5150_REG_CC_POLARITY			GENMASK(1, 0)
 #define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
 #define PTN5150_REG_INT_CABLE_ATTACH_MASK	BIT(0)
 #define PTN5150_REG_INT_CABLE_DETACH_MASK	BIT(1)
@@ -53,6 +58,7 @@ struct ptn5150_info {
 	int irq;
 	struct work_struct irq_work;
 	struct mutex mutex;
+	struct typec_switch *orient_sw;
 	struct usb_role_switch *role_sw;
 };
 
@@ -71,6 +77,7 @@ static const struct regmap_config ptn5150_regmap_config = {
 
 static void ptn5150_check_state(struct ptn5150_info *info)
 {
+	enum typec_orientation orient = TYPEC_ORIENTATION_NONE;
 	unsigned int port_status, reg_data, vbus;
 	enum usb_role usb_role = USB_ROLE_NONE;
 	int ret;
@@ -81,6 +88,23 @@ static void ptn5150_check_state(struct ptn5150_info *info)
 		return;
 	}
 
+	orient = FIELD_GET(PTN5150_REG_CC_POLARITY, reg_data);
+	switch (orient) {
+	case PTN5150_POLARITY_CC1:
+		orient = TYPEC_ORIENTATION_NORMAL;
+		break;
+	case PTN5150_POLARITY_CC2:
+		orient = TYPEC_ORIENTATION_REVERSE;
+		break;
+	default:
+		orient = TYPEC_ORIENTATION_NONE;
+		break;
+	}
+
+	ret = typec_switch_set(info->orient_sw, orient);
+	if (ret)
+		dev_err(info->dev, "failed to set orientation: %d\n", ret);
+
 	port_status = FIELD_GET(PTN5150_REG_CC_PORT_ATTACHMENT, reg_data);
 
 	switch (port_status) {
@@ -152,6 +176,12 @@ static void ptn5150_irq_work(struct work_struct *work)
 				dev_err(info->dev,
 					"failed to set none role: %d\n",
 					ret);
+
+			ret = typec_switch_set(info->orient_sw,
+					       TYPEC_ORIENTATION_NONE);
+			if (ret)
+				dev_err(info->dev,
+					"failed to set orientation: %d\n", ret);
 		}
 	}
 
@@ -219,12 +249,14 @@ static void ptn5150_work_sync_and_put(void *data)
 
 	cancel_work_sync(&info->irq_work);
 	usb_role_switch_put(info->role_sw);
+	typec_switch_put(info->orient_sw);
 }
 
 static int ptn5150_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct device_node *np = i2c->dev.of_node;
+	struct fwnode_handle *connector;
 	struct ptn5150_info *info;
 	int ret;
 
@@ -311,6 +343,14 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return -EINVAL;
 
+	connector = device_get_named_child_node(dev, "connector");
+	if (connector) {
+		info->orient_sw = fwnode_typec_switch_get(connector);
+		if (IS_ERR(info->orient_sw))
+			return dev_err_probe(info->dev, PTR_ERR(info->orient_sw),
+					"failed to get orientation switch\n");
+	}
+
 	info->role_sw = usb_role_switch_get(info->dev);
 	if (IS_ERR(info->role_sw))
 		return dev_err_probe(info->dev, PTR_ERR(info->role_sw),
-- 
2.34.1


