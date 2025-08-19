Return-Path: <linux-kernel+bounces-775542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD0B2C06E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0CA170B12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718132A3FB;
	Tue, 19 Aug 2025 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cwRYt4zE"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013013.outbound.protection.outlook.com [52.101.127.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA04326D7E;
	Tue, 19 Aug 2025 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602829; cv=fail; b=c42DyIW7d3r5jcac3MNvQIhk+Z/3Ad94Hwdn+GhovcFJ1Ic85ISssDWIqBU8omsci2DwMJAa9vfWHn72tSuO08kBLL9+KlIBnleg2JNKrBWXqw0V0D1qHR2y1ZFSrNBBH0na7zGBjlNuZYIBdpDWA4B5e39/cdr+88PugFiZAU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602829; c=relaxed/simple;
	bh=YxV4JM5o4VXKePuIS41tZaUZF5Q2aFkJwVyJgs0aVjI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fEHBYk51Ngkm7UqQ8yzRYhtnKI4knGBwOVz+Gs7lSzVkW0zZNJh7CYHkJ1Npaa8c/MBxvRyQT1KRJqDXu+pPjAxQQ3Axl/qm2L6UjCGMYUECgIuVkiJaBKuEjAMUbqtMLZ/HunPNv+IB8kdHR0KabRcqtx36XqW5RUoNjgqxpPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cwRYt4zE; arc=fail smtp.client-ip=52.101.127.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKg85LtSRzhRBWtyRSB/LshQy+h6tSgfinYYLVvQtwgCcY1r0SQTNJZpMrrqbOoxEtK1IakKKSOAh8j2OzH2PMzfh6+eL0tvhWpxX80AkxHLoEIW9+fVvLdzuiRCMe1R9A8d4tuJBWDFsDhKgznNAhEiF0wxGtpdZ1dQJkn4x0s0wphTdzbK657/kNbgOtb/65ILfamjuT49QSesZ72JxsUxpJl5hvr5o2Ka7PlkWm0DlDW7HEwhfRn3eb6w/kTWPbiUGU+ainz8ZTYCNNrvOulNl54eg0BL8lWi4yjAVdI9h1ZUmfpcEwodKFtLN+TjkjB+vCuj5eAYa3681j5LgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgYlDhRfqPWQZ4++zL6RPagudMZYh8RPKFZsuu8P1f8=;
 b=THVoKoCEYJT46JCrgKJ/vDuPN7HBHjf4KFdnKcvQwJc78G9p9dZT7UhIPRinKqQjr0QmKM9wthVSa5dpSKoZbyxRb9fdCHzJNdMBjqaIJ4QZxW5434ouAnwdXOmBWLOY7QSbSSF8PXk0lsg75yc5SqgueRg1VfPUbwY6GrgGAhVcP5L/eIis6MyknbLYoCk0KcpDIeLgenPA7Zie3UQhs7IJcgXZJ1WxYiRFOvBN65z2ISt4GWI22ffJV36w3JOwjAP5ob3NHEnqEje+w5ZUu93UDW3BuJfT2/PVI6xYhMErJYIBmeBzRVvbCBA60gWbvmY3IyJ5TDzNUafsV3bJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgYlDhRfqPWQZ4++zL6RPagudMZYh8RPKFZsuu8P1f8=;
 b=cwRYt4zE53RH3CeoIFnpwDd4zlZPkPD9SXU7EmGxBixOiyFRW4Joh3OPpu3ZGPFF9JwSLrFNcjXdRpIG7BLoDgMn5oJkoLcZLx+tB19TgVBmkU6sJ+HDzlfTTlWKGo8EX3L7OC33z4I65E3SFvLOOsilNXag6bCgxl8OGxxsEajBCTkcrO+zSFjweDtEP9SpHAureAmrJarGGWkCLUI+6xuAyQLOnxT/4+vop+an+e9BPpa8mmnazcK1eoDoAO7I81u8YEyhkKZwb3jmKgZZTJt47+KcGN6ZmLpNrnjMh5H/u0etFBZQJrIJpB+Esu+D+S5Im+qHqGj03nZ+ZiY61Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYQPR06MB8119.apcprd06.prod.outlook.com (2603:1096:405:2fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:27:04 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Tue, 19 Aug 2025
 11:27:04 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] ASoC: SOF: imx: Remove the use of dev_err_probe()
Date: Tue, 19 Aug 2025 19:26:54 +0800
Message-Id: <20250819112654.588527-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYQPR06MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 3464823a-33ad-4c0a-b055-08dddf1352aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?99Os02MawSPDH6zLEOhSX0h6z2O3+3apWwT37IMMLEbgYzSJglZXcu3MgGP7?=
 =?us-ascii?Q?ANpGi7E5FtS2xOKRb/TY/4xqMhieWmzVDlE62rN203tg6rJ/avyIJVqx4FmB?=
 =?us-ascii?Q?ibydFthigs1L/ymQoXhmZAGdPYr9o2ak4FtkKHQBO0yEYl49U7RXLr4sHf5r?=
 =?us-ascii?Q?hgvFAP0JsxPN3OkOGroUEkPMsfKH6u/OM9ckqRAmE1xkhTpzdxu4ThafA08O?=
 =?us-ascii?Q?5uOjiIS12oHMj6w5VgtslXClTNja5b8X/uteaCXyWBOWrMN5+adFNwuzznKV?=
 =?us-ascii?Q?a+Unv3ESOQqH1Be3WodTK8TXbYKSHhnsuq8MRiJaUHcoKs5rZCUl1oCRE7TJ?=
 =?us-ascii?Q?d9LdDRQRRwv8U3dzK/ZGkWWZJNzwEwmf6Uh7EtvaLbDRpEAXSqKCcKi+Kd8y?=
 =?us-ascii?Q?iKK8EIxh80TGI4NsBBWdvQ8DiTOtgpZhP59Mt/IjpWrcPt2BVvk0DH65Pahl?=
 =?us-ascii?Q?fMM8DhW7Polzebb5p6KKkuUKGVy2yIuFG3Qm0pvfi2/+CuNv0ZfmcA4pEP+0?=
 =?us-ascii?Q?hpkwBselXEoNf+wlURC4nWsof7xij2Qvie/8Ai4OHdjF9zw45yR3gJXfCSkg?=
 =?us-ascii?Q?JpWwtPTBf1GN23u9cDl7Ez5+sd53yq4rcluuk57qNih9jfgtNHOhvJiyKdAO?=
 =?us-ascii?Q?5XPwFM+GibFiwWEYBHkSxrWwryM82dnX4prMGq3s2zkjRpOAk+CZQ8udL7ep?=
 =?us-ascii?Q?Fz5tWsRUlsdHpP31XLLQgyHBeyjGlvZkqB/5xT+Ax0uwogSWuMvg/j45yLcB?=
 =?us-ascii?Q?s6AMp6BeDoLY9sXNEwQ/2c85W5/3EaVKV6lnWX/kbsW11D+0hkYLiwJLasJT?=
 =?us-ascii?Q?ciF75cIHbhvNX3JEwV47W0Uh5u3w6Ml8wXdt5UXYyBh6Yh3fAitCoP2/dxbG?=
 =?us-ascii?Q?EEPjqLyiY/lilQU5Nuz40XgohXcyUvRavoKBcjprH0yjuh60wvQP4zWZPTFy?=
 =?us-ascii?Q?xLW4FV4w26pauasizO5BkCwz8z4caeldaJzQ1QoBhe1Vk1Myf3PaykL89zP3?=
 =?us-ascii?Q?9sLpu99jhqcN1pVta+YmOYNZKWCbSQByFaQ/AapKgW994txjODBCBY6Eccg7?=
 =?us-ascii?Q?fWuuhNWnUYLT9uO3qQ8nlfbeuh455prSC7/JIDWUdRYvVFylR3jmGtbTb++p?=
 =?us-ascii?Q?eSEdkEFKK3fqZJ2Mol3oErqJfBLIRnffc47QoyOndfRNcqqIRBbry3voFFdZ?=
 =?us-ascii?Q?reCCMoesCtK/GYLQMMmw/eOt7R8FVjPFE9AGI81AY7qUqfXNTgkF/GWMFAKv?=
 =?us-ascii?Q?++dlpPGbHln5aOjyOqDDq5l+A3tIw3Dei2mRIp7PCD6eo7tPKlIiN4Ubn7+Z?=
 =?us-ascii?Q?h4jrVUNHhRvPx7APg2JTlkSszs37/mmeTM/WD8sh24ar8/YjOyrRHNXc9JUo?=
 =?us-ascii?Q?FtM7MSk2M+Ieq187Nf50n8nHzJlkozndxJbokORblxuZZomgFr7skUh9hy++?=
 =?us-ascii?Q?rqWrJMSYCz8wvFadoyMwusQD8sIzPFA8f5PRSHX53VbPgZMBukkuSTX8gugv?=
 =?us-ascii?Q?Rx5kQG9xfuXXNxc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bC2nE7q+byrBysA1OIBDGn1enqyUSTt/RR3udU+Ie05ShFp1t1lFbXu+XNhn?=
 =?us-ascii?Q?iq/28NVBP1jvFsqWuiaUAQIyCe4rbXj3Cb5saKtg7lrexeCb0zcbcwTUP8ME?=
 =?us-ascii?Q?R0FuByQGBsvAsWGERCRv6LTkJWUaikxA87fIVDu0zhVRUF5qwNj4m7ikvm1/?=
 =?us-ascii?Q?A4Nsk2SfEJzIzTu5WsZH0DOAqeEHjvvgHda+RiDyJX9oDh076+G/+mqGv4kk?=
 =?us-ascii?Q?CnxoMmr7nRTFLEY6XSG+kjjqLUkZ8Dnw7gPt1WBTbX54c1fHNrdnDTktKBu0?=
 =?us-ascii?Q?R/Mnd7u66UsR5Mtq7OVgx1hSUGK+zMi3uwDdXTO5G2SeaqiLmCpd4lfEMbTs?=
 =?us-ascii?Q?Ol9yP2WfjYnZgWFxlfBF6VQOvec/TctlA8dEypiaesmGKfZUv777x/yu1d/i?=
 =?us-ascii?Q?MifRk+y9ozGiwYgYFQ7MRmAsWSV+1rwVl0Eoj14nxnjbyT8BKy8qtxiNnlpU?=
 =?us-ascii?Q?rGQY/dN1oBz5UsG02r2Fd+tmwu6jLA4G9vVn5qXnLYUR8HM3apB9bE+Q96fJ?=
 =?us-ascii?Q?dkHRuPPlkT+z9tf9hrKvyC8p5PRuaGvm+shmBXTM20E1Y3JAltij0AN5g2qF?=
 =?us-ascii?Q?xZsGmrWyteGAwNJI+p6F+30hteecJKNx00vBULeN4kMadmsgu4398rmq2abc?=
 =?us-ascii?Q?G8hWZIQspn4VpFdam3YzAdd52pYyh7y+ZEPz4el05D/7QWpaUY2TdE9rFB7c?=
 =?us-ascii?Q?wsVofz9xWH6ycIaTcQMIy9h/AXY5A+f+k0rlIipqAtTKkruHeMTyuThykL78?=
 =?us-ascii?Q?k2Tn1jOnfDpPn+rJq6rm/dSdip1GnruYFX5aboV16KTyUO1BVfTjQlXeF2ys?=
 =?us-ascii?Q?Kk0E0MvEopKgO6lhdgSAh4pnS7C5TZyfzMtHwozBrnlVHlOLd1eqt7DEci7k?=
 =?us-ascii?Q?9T+tLN89cm30opGak9mIDsdwXLDmlo4ii/3AF9uh6/Ok3dzatR+SOHpELAuT?=
 =?us-ascii?Q?GdmxQCXtxANGYCq+NypLXkCtq2781BqQz5Sl50JZBhjPYEFJHFWOXHpSpCy9?=
 =?us-ascii?Q?jwuIOe8PIyafgTrHrJjjppxWUqESglIre97DxOCp0ktFa/0SYe6mhSgHwIo5?=
 =?us-ascii?Q?5gSijQ1iKL2Y8GAGyXLnupSVGXMwvAPFercGr8Vj7p3Lvg4nQB5FXkzpJ1ei?=
 =?us-ascii?Q?igy9MurDo+g4a/a2XJYl0ipHL/cwgB5eaSQBW7VLQ9hCeN+v8+9d/gXmXCuH?=
 =?us-ascii?Q?4Nse51veuKa4C8lcu3yqti9XMXen/9qcHUX2rZ6mL7KyeONruBtR2bDA7PzD?=
 =?us-ascii?Q?GNDq9kGigqTnaZx5SWSd27qhzbmJBFnXTcFdSY0KhM4t2GoXBrD4Gb7xzCVv?=
 =?us-ascii?Q?5yutjPcwRARNhEaN7BnWDdiU34q325Y0pfQE/APScbw6wI4stfcEjeQG652x?=
 =?us-ascii?Q?zfXudrMORMQWic56CmTaictf5AtLpqA019X88lRd8276zTdE1BRmHqsYf8z9?=
 =?us-ascii?Q?ieHZ9fmlZ3JsgF0vYa1HJtyKJg5qA7Dml1gvW451Ge4RW1e4RQYxefgnwSfp?=
 =?us-ascii?Q?3Ww3R4MfvsXtGFT2+BqXsqqhomaR2qNCE2VY5+RMjnCYXIKopmPkWa7D+Kh0?=
 =?us-ascii?Q?/W+aq45iN9ZrZVSNBIENJUu5H53V7CtgJvTkkwuo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3464823a-33ad-4c0a-b055-08dddf1352aa
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:27:04.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CD2OmLSccvpKKI7ASDNju4y5QrU1iUc/BkMg46oOT5CJv3HryrHvk2amLwYSGDtaYcdsmr+lIt40T17AKJLXig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8119

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 sound/soc/sof/imx/imx-common.c | 4 ++--
 sound/soc/sof/imx/imx8.c       | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index f00b381cec3b..4523621cda10 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -354,8 +354,8 @@ static int imx_probe(struct snd_sof_dev *sdev)
 
 	common = devm_kzalloc(sdev->dev, sizeof(*common), GFP_KERNEL);
 	if (!common)
-		return dev_err_probe(sdev->dev, -ENOMEM,
-				     "failed to allocate common data\n");
+		return -ENOMEM;
+
 	sdev->pdata->hw_pdata = common;
 
 	common->ipc_dev = platform_device_register_data(sdev->dev, "imx-dsp",
diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index b73dd91bd529..7e9eab2e3034 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -171,8 +171,7 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
 
 	chip = devm_kzalloc(sdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
-		return dev_err_probe(sdev->dev, -ENOMEM,
-				     "failed to allocate chip data\n");
+		return -ENOMEM;
 
 	chip->dap = devm_ioremap(sdev->dev, IMX8M_DAP_DEBUG, IMX8M_DAP_DEBUG_SIZE);
 	if (!chip->dap)
-- 
2.34.1


