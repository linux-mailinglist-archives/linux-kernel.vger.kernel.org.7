Return-Path: <linux-kernel+bounces-781468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E57B312E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9735C0977
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA692E284B;
	Fri, 22 Aug 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Y3E/HKH4"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013059.outbound.protection.outlook.com [52.101.127.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663929ACF0;
	Fri, 22 Aug 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854560; cv=fail; b=QpBDTDjAlYtKp0pZX1VtNXB/xhg7bPl5iRdyj4yUx5jtwKAhzaMif+J/kXEyi0DmpZdDiWfIcZW5HDVl/CyM12iThkVk7kRQq/ENccgMqnZCp9olTp+HXn8hk0QvJeOF0/ksqG4UsDNzLvDde8NIFm1wsN4vHwGjBL2hGqDFybY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854560; c=relaxed/simple;
	bh=61ZvuVNSilKFwLBOwmLw0xLPChR4hm8YlafVEmP7tKU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iO6Th+9Cl3+DGiYgpzt6Z0BQyygm3Fux6ek3eTg/7lrxIMxVIiTR1yNRkIGxUhLIcvpHzqNZF34O/Y2N9jzVITtHUd7eZZeLJVu8pCStvKQMMqYOXWBZakZss2Noivot2V078aPP+cuJa5jdx88czgq+Efq/fh9lXBKhyH6oHi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Y3E/HKH4; arc=fail smtp.client-ip=52.101.127.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFLL+hO9405fXRrOeBplTsoPynEBUhEfqlHw0kEQh9sGgY1e6fV2WfXtX8IGVdQ7mw0DabGa5UudhKU+KJ7mk7P7TjueLmxh+hHbYRLxP6M/jDOA9KPhZvazFNND3H+F9I//+BERO9ymKtji22OuFK5P73fqngdIknrvAgceKk3QizVYmQjvxqEdHEN4GNVlsHiS0MqREvKCL6UfdbOCSCgmj2D+z21fylZAl48cq75saPI48WgCTF9CiPbJIlBe8Nm9XGxJIDpM+QJbHdSTmfV7C6XWUiLiOzEVeEoV9mBueUOYX0CIFNcOz/cXAfkmfCv7WxUdfgm3KTwmyu/OpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRAD93/tm3sAPWlVWwxuPOQlKiBkSrXNcy/szhwh0js=;
 b=wjkavCQCIeofvHVe9I/xeP3UhJN7xCl/uOSk2u5KPjAnvmx9Z7RRgbIkrX7uWJ31kbQX+eoPmrI8j53F0DCAntx56CKQr1q+YR+IjSl8p2FfrqFZgBj0wmYnclq3EIRHJc/dGZIOvRz4ax1TtJxB8y1u5SIBe9mbfDUp21SZjXEODYr4/QXmdHGkfq845vLUTnNAe85D/E3xrcmaCq1uY0f1RcNdjURaGtnyWnQoqa/+1UL9S4cQYTyQbN5iPtAW160eJ8K6Jp9HcHVVbQcF61L0nEMVZ1ugo+G+Kjq2zikM6vNSE6W3RMp0ARWnZPjTNuYbG+E0yOml7EN3zeMwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRAD93/tm3sAPWlVWwxuPOQlKiBkSrXNcy/szhwh0js=;
 b=Y3E/HKH4kO+CS5BY03HaMHZ8YgBsIFkKq5zgImuvcsYdjqTTqlCqcUTdZzw2jyjJwyAdn6vR5ZK9En/7hXfV/bvZgyV04OjITdDDFdte1+XuPfk+R74kjkHifS09rqfEja5weolQAoSPjZGeWm5AxKliU/rCpgEhOkxHtAbKY31sNYCl6BKbtqZRIDPi0M16EHvFXNy97gLaDwQoFZc4nEUxLmv1/i9dxtrHIJ7pNRbvqXkpEPIgJxArnmRUzB2/ksOKetb5vG8WQnZ14LPww7kS07fxXceHVGw1h9Kx7ieFLxrXrwfVX01r/vPa6O5fvmJjXKuIcWBsI8jOMTYTPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYQPR06MB8041.apcprd06.prod.outlook.com (2603:1096:405:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 09:22:34 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 09:22:34 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v2] usb: phy: twl6030: Fix incorrect type for ret
Date: Fri, 22 Aug 2025 17:22:24 +0800
Message-Id: <20250822092224.30645-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYQPR06MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 264d58c8-2cda-4185-d4f3-08dde15d6d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eIWDzm1Stgu05quLaeaw/Ls1BZ7+7ksxYBgcPMA2Obbg0DHdrfNqyYSIXddM?=
 =?us-ascii?Q?5BdhvfVF4/xyeYcXNJUNBASDcR+TI6vgz0OhVOVpxKxq5VsCbHiaWPhCqJgA?=
 =?us-ascii?Q?ZT9Wuyeoo3PkgHHParB7ts1SNM4PJP7O3v44x3g/VonM29IqM+sOF+9rusAT?=
 =?us-ascii?Q?cKB3eStyUe12xm7anlbsT7nqM0NMLaWCdIupHFosWmcfeeQKsEl4y5ZfDBEn?=
 =?us-ascii?Q?WQQ5oLI33IeDJ4eFLQ53Dz9UDnoU/rugUs7RKjwASlWfXmBzfmG+W9VHJ3TN?=
 =?us-ascii?Q?Apc3P7nrwJuvFGSXKJ54JCv2IAlJQ2IFGxJ+znUhePjxFB0Frzd8BFoFzatB?=
 =?us-ascii?Q?7VEMMj3di/cEg5aloi/6Nqs3eKmUYnwglAsrLZaugXLott+d+HxQrP/OP5/z?=
 =?us-ascii?Q?QC0Frfod3xCB+KvjtgMGeY3UEKQBtEQNfcl2Cmw3X1r0LrgwPan1G5dMKvRa?=
 =?us-ascii?Q?3FhadTiV8EzkmgAN9TFUZO+G2vBVzolH/HQ9S5fmadaVAt6sPbf/jCE1JeBq?=
 =?us-ascii?Q?MgCwtmYKLM96eJvQY9uJyybxz6Q33zwYXXpUcRCUnaaW7EMKXGXGhWKd6FSK?=
 =?us-ascii?Q?lRSTjLlhoZ/bPTmcr9rPEqQDEvgRSA4XC6lthZIikqx6uhI2ffpZSADlpZE0?=
 =?us-ascii?Q?eDKljMm/ilPftk6fRVgHH+2IfMQtGleRMqRASPxSnnoasccVE59/XtW1HsI+?=
 =?us-ascii?Q?OFwbDfy4QKxLhqbVdLWmKqI3t3X+iipeguGRFilsd8PB63/Vbx8X9YfW62Zf?=
 =?us-ascii?Q?j7gmdkAhCbCY8jT2XVXu9SlNi45v04AUKRFxIEnOcZ4qYzF37eJ2UvMB/FyR?=
 =?us-ascii?Q?lm+L9VWbmsgM4uDSz58AiT/0vnGE/E77KeFnwPzraQAz+TsoHBiotsCft0eO?=
 =?us-ascii?Q?1IOT0F023RQR81MQNfeH8ixK/XSrWQUjkztY5YzFVyPdd6BGffe1EBpzebBt?=
 =?us-ascii?Q?dofQUM+bgq8vPj0L+nGHYL3r5Ybh8YOYP4K5TGURffEVC020Ih0uVp90vn+v?=
 =?us-ascii?Q?23ZTfYJdrcBaP7OQOpmY9kSupxZAQC3bHadL8f1DbzTfgT5j+xTimd53Okk+?=
 =?us-ascii?Q?G17V+G2opMJfM5/HuVe5OVEG+8A8rGj/6o7nibj5iBKy5RqclofgJPvrWUwh?=
 =?us-ascii?Q?0Bt0esvSwbmEWCaXm8EKvjTju5dsfFegnMLjkvulh0+9pg8KH2Tmlzvm+fE5?=
 =?us-ascii?Q?1Wsax23lE2Cw8JYuytEP/WQTUE4Od0XGoI7yr+jEXEeu02R1hllmrPTJxjsx?=
 =?us-ascii?Q?Cp1lhJHvhmVu+FedLNMfK3bbfXcOrHItEAGWvjo2URgehnwbseEcqYo3waOM?=
 =?us-ascii?Q?5cHJiCpfmuCC8WpiqLFvzden/YPLSRUx2BERcCBH10o28syceqR5OjVJNCnT?=
 =?us-ascii?Q?SNFZZ40K9YS7Pwg5QpT03vEfx2cEe6HONlTSBcixnar92LkD/i3eBnheRcuA?=
 =?us-ascii?Q?tVAsE2uzFMvr4M+uOjKFVsXaX7GBreMImGkF64aTsj1dcDuzVDcPdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oZXelU5yPoUNV4NYUpCEAO0lbXv/egMxpB8vEf0busThMSaT2QygEq8/vyPS?=
 =?us-ascii?Q?esCC701/UCJFStQeuZv46cBlJlBmqSV6+L+jpO49c0q2MTbUJesf0KJKB5uW?=
 =?us-ascii?Q?vKKoFttOml8C8txCNaSjuoo/pe6byRAxWAh1v2IXS3ru+nYbIuGfyNwLClxs?=
 =?us-ascii?Q?CsQzKb6O11EDVaL/zXw1wXr4mgfUyZ7szh4oY5l6T2YvnnZ5E9EuSQ6D2/LI?=
 =?us-ascii?Q?5Em1b0dMLdK1yXKfelCnwYGqJSzQCNEaOxj0wiXk5ZxJDE2ce/ldBhH4Bd57?=
 =?us-ascii?Q?X9W/UkPIHetBHdviUubYWAdnRD33uFUFurQTt+WEAz/aVQJhbIx15iD2LRjr?=
 =?us-ascii?Q?Ri5ijQ3AJi4O+zi4gONvGLQxKGdliOLPuuARPWAzUQzRWqjkNiXMVxKhyNap?=
 =?us-ascii?Q?mbB2U55z16iRyYMh6S8Dvvt2EMENoIrHPlKgITVQR9quAoqbM0p7HKYIEcb4?=
 =?us-ascii?Q?oLhSiRyiSCUfxBx8LhcgdBJRP8u+T1DfQOR0hGx6nTSXy6H1SC9P+eFJ83VW?=
 =?us-ascii?Q?uB3dkv1Qda/joqG5inY7MItnLNW5eM0vBs9YkxiGKwUVlM44huHYpoqoERCx?=
 =?us-ascii?Q?s9jsnOC2aF0pFPOBtZ6XsISSnr36nPMh4sbsKoHqKvAQbx71HVUsRIu/khkj?=
 =?us-ascii?Q?a9CJUWCDQVrS8evRo/zIUu0ISB2JMFWDrlC6UTRLpcvhn/48IXqaiyJIwj3p?=
 =?us-ascii?Q?x14Uz5TkqIsuI8FYnvC4un5WsO0T5nxYTuyR926PK1y1PXIcPXXQS5J6C4mm?=
 =?us-ascii?Q?vu05KQ/zdw1gI2n7O2VZAgWVJ4WPwAiD7aHD4Q7uEIANXfyG63P3ooGD6lbA?=
 =?us-ascii?Q?bdzU+/D6bk8NExs5xpUn42RtZSO1a+5KbUBz4jGjyeHfIOYSpEnxpmHDshkz?=
 =?us-ascii?Q?ukdlZ9NNjJ9dUGZHnKTNQ97ecNrirrJELE743p85pGXO1gCHuPGuMH5nGT31?=
 =?us-ascii?Q?IEsg+gi9AFktFEoC8ajAQo2GO6jlUpysxrVm8NWL3BfKcWZi/e4b/kJnhEep?=
 =?us-ascii?Q?votXUScLJW0399K78tH2sLQOWrQggp7/ssSeElb7MiH3/pgDzOgmaoypsP8v?=
 =?us-ascii?Q?7OtnWTUaoswX1GCiOzlPejYOPRNlVz/KX2RNoIqgYKSU+sihMD4fLGuXq1uO?=
 =?us-ascii?Q?9QcXddh//yGXFZitziB6Mb0/G/FCofbBvoe+qYA61dRyZhWn40I83zh2cbcv?=
 =?us-ascii?Q?me/qq9m8hT3oG1boQSOu4c87qekO1fLRytIBY+eK9/UqYsVYYuuMU2HBwUs/?=
 =?us-ascii?Q?MRXpEzgJohLqy48tpp8+3g4F2vx4PJ3bsHQfBXJ2WfXdpAYLGvN8gLLMkUEg?=
 =?us-ascii?Q?TLqGb8ZBwcIyF0axdJEbDLZ2ogyWe1/JiNPFn01gkAzcysVohaaK0OD1QOUN?=
 =?us-ascii?Q?9YQnmoF7YiA2BxnM3c68eRTEH9C4qzRPjYNVGQnplxj3iI8JAa/Lq6id4SjG?=
 =?us-ascii?Q?j8KxU95Vh7Lyz5jvE01CB4xgQU51uZuDcEPu7wbBQBUxnk0PHI6+qekn2IV5?=
 =?us-ascii?Q?qXJMM2DA3miqY8N88Z09XC+pDIZ00A+RzB98SvP5rH6YlkJmzyt8NX2/SC8q?=
 =?us-ascii?Q?OnmY36ltkhmcO9UWN1d0BzfHu2eEsopuI3VjuVLj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264d58c8-2cda-4185-d4f3-08dde15d6d4e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 09:22:34.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ApsFYBF+me2wgJwJ/5yTGLhsHErzXbrCs4uBnwE40CPN8exaK9PrmGxz5AsI0lhBSl6dbJMO5mekDffzBuJ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8041

In the twl6030_usb_probe(), the variable ret is declared as
a u32 type. However, since ret may receive -ENODEV when accepting
the return value of omap_usb2_set_comparator().Therefore, its type
should be changed to int.

Fixes: 0e98de67bacba ("usb: otg: make twl6030_usb as a comparator driver to omap_usb2")
Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
v2: Add Fixes.
---
 drivers/usb/phy/phy-twl6030-usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index 49d79c1257f3..8c09db750bfd 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -328,9 +328,8 @@ static int twl6030_set_vbus(struct phy_companion *comparator, bool enabled)
 
 static int twl6030_usb_probe(struct platform_device *pdev)
 {
-	u32 ret;
 	struct twl6030_usb	*twl;
-	int			status, err;
+	int			status, err, ret;
 	struct device_node	*np = pdev->dev.of_node;
 	struct device		*dev = &pdev->dev;
 
-- 
2.34.1


