Return-Path: <linux-kernel+bounces-777687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D50EB2DCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89BD16CC52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72CF31A053;
	Wed, 20 Aug 2025 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="T0idAHdm"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013060.outbound.protection.outlook.com [40.107.44.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35056311C16;
	Wed, 20 Aug 2025 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693286; cv=fail; b=ZXAELwa2+yfw74vwiwcrqozNAf3MdYger38tq2nt2YTswV96hoPYXOi5pyojhT/ya3vmwvPtjvg52QDPkoWIq0wCU2PnJ6Z68Dgl9AWDWIM1LTWrK+9do4/lql7Qa5ZdoRcjrzw8NBaXDTGtbFyXnlnPIctqW8kM2s1H+kOFCQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693286; c=relaxed/simple;
	bh=hsNP8LwxVWCWv5zCJz+39pr4H8GAMtxKeJYUuCwbgn0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eWrXUwFMFERITz6z1ydLTYfe54lKK6GWKDGNAcIKgkgZ56mxgOe8nl2OTPuW2ccNL/eib0jjDlxcG1cHOVHjTio7tnOBh55yF3JOqbMQvNH4c3RWyEMXAk5sartipr0hLprZ8Bh6rzpyIFSXXdeSAWxGbHlGqXK5g06cH5HvlXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=T0idAHdm; arc=fail smtp.client-ip=40.107.44.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwRlbBqP53f8R9tFE9eCvQ0CaF7JbiQgB9laq2srffs3FNixdnHQcLaSi7UD9qXmh0vT16SOKUkUK2tqMwWLEPE9BNw/RpsNcDp7OmThk2BCuDm1SiUM3dB2xVCB6Tf2q4GQWP6H+6OPHPKYGlLfTzICzVEiLM2LgMnxyi28zhiUy7w1QMjA6t7zXoaSLLREq5AfiWApgvo4yWW60qWto6gG1l+GZ7Vx5Jbzx7AELvbF/qTZz6ljG+gVlIpw8Gde5tNn7qpOjnqdaR6C/gUOSRjASHU0vidO1re+MxQeLNd+4ncxFnqmmgqS318HOF5x8+AFxCsvafhWWS23W+Y59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbHcUvo2TN5Kjl2ZaVqIAWmfsaEVDUSjDoXhBGiZ3FU=;
 b=xdX8q4QEGb7Y8KQATc8K8e1/a+EF3YluHHQfjcRhennT6MrffYdvHhMSBWFgB+2RgBTs6NL0l2pcjcw0dHz4yUjLjCDZnAYhhkN4IjfBGKZtW55bkseSbzR8Q2ocXE20PtgSee2R3Or3mTwW0NKQcwRuV4N9dJWh53QZU7oWcACFRqUo2/qVbC3pIn+uSpMQqzxnI6QAYXG0Xfq9JxWJ0Hwj9GOKNJksLjSgaU+v9Dj0qcDyJUExAaxl1Yjc1/vq36VH4ob82XofdLpI0HGH3d4KGRq4UhXHlzBGQAtpJj9r5hJMkNzV8UKaXFr2TpuS1DfOIrjoWZPYMDCM4prnOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbHcUvo2TN5Kjl2ZaVqIAWmfsaEVDUSjDoXhBGiZ3FU=;
 b=T0idAHdm+7/WxHe4TWjBMZ/NVaPKDq8t9SqddfPtzTwH45YoV72avSdJIVKdrQy3QCv1yUCwtNwGziao3aJ/HV8utEdD9uIGnGwzLfko9sXCBHxeI7e4leKBMJ5WgRJvmPXwrxIWnEQo+4uvQkZyXzwcloFmX3hJ7+Z4EA84XxAlqp8++EELP0ztNTvRp1vDnb9mf9tvw8MMfQbOSsig6ALg1zBnQNupLiNElIwoGVzAKz5sLHG5gZO1CgRfE88Mhd7j+6FUx7YDpw7xwM/8tTE5lSWYRi13pMVDsgXRhYWtjqxNubjJ0j1bMyG1uMY+l0phKwQoS5uuNhhVfV7w3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 JH0PR06MB7177.apcprd06.prod.outlook.com (2603:1096:990:9b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.13; Wed, 20 Aug 2025 12:34:43 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 12:34:43 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Nick Li <nick.li@foursemi.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andrew Davis <afd@ti.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Linus Walleij <linus.walleij@linaro.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-sound@vger.kernel.org (open list:FOURSEMI AUDIO AMPLIFIER DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] ASoC: codecs: Use kcalloc() instead of kzalloc()
Date: Wed, 20 Aug 2025 20:34:18 +0800
Message-Id: <20250820123423.470486-2-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820123423.470486-1-rongqianfeng@vivo.com>
References: <20250820123423.470486-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|JH0PR06MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 97351ea0-d9a9-4d47-4e8e-08dddfe5f0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FO0e6s+CibrFCquS/KqOE9PRcZt7TPivVdxQQjfIZiWqPbGGfLV74kpd0iim?=
 =?us-ascii?Q?Uc517z4Z1pgxGmxYgbQTQ4tB3pJz63YFb3jrNBI/YRCaMxzOpjFxvsc9Gfue?=
 =?us-ascii?Q?frOPJgLv9kld0dBE6VhNUUJ5yiY28RRrFmmCDMP0ycGSqcOBbRpabnwvjiCM?=
 =?us-ascii?Q?BpQ86rtGTWUEjVUVVs0WoMweM9b7cbV9RKhudPe6lMwFi4TRRhbQRO9rOnhk?=
 =?us-ascii?Q?2Go8lcyeB1BHyiYiqeT0JZYJdMIdyGyXyu0CzHTAvMGtpPVvPMol2wuZL6NS?=
 =?us-ascii?Q?ExlGQWOc1PSmXpV+9TLtT7wi7rPAvfYa31E5qCImGezJQKOfmofBQszPu29v?=
 =?us-ascii?Q?P6Sd3zsR/pBpZ8ywdlZ6P/AIghSbVgZi6V3aqKzxKrJKFkdFwA+NHwtKwlC8?=
 =?us-ascii?Q?N/kgrMZZliydfCW3q0nzi+Edoukzl1eu4WHJhJImf7T9qgODmihahlDJsrOk?=
 =?us-ascii?Q?0ABEKP3KiW6ARV9hE9gDSU63KeNgSQ1aJToKCxwhvc0uk16/oK/rimkMkYhb?=
 =?us-ascii?Q?uxjSLTu1l6mtQf3TLHarWrCDEHe5tjl2AbiNV918Bip/zlwpPA3ENNyHo4DQ?=
 =?us-ascii?Q?5zWm7bexcTpPPTPTq29vHc3U4dqjXoD17+Ajut7+kBe7GI3a2EqGcuHzrUvW?=
 =?us-ascii?Q?ufNDpXSJ9ovoq0oX+nIjzwGMsGcjv9vWtWLozpyrTzDjGS+1BP7UBB4D8tJE?=
 =?us-ascii?Q?WnYn7Gue9a/4st9fRADN5TUpXYIcHZtNwbKGaFWaJ3Kv/JEfn44zn6DYDfTe?=
 =?us-ascii?Q?O0Vo9TmWosmc+qrM+iobBMD2tB68hFO8n4HEfGvtknMSZTn5rL+cBURjszMh?=
 =?us-ascii?Q?OzL350QaNUWP/Qtl/WwN/YsdeZePmwomBWEIN7CtoFLHo+v79pBPfPFWUIGN?=
 =?us-ascii?Q?ibYChqQk7GxA0qKOOa0XcaPoFRjRgydLuCqlhfnJS5l5cknrqABjkzGpAoK+?=
 =?us-ascii?Q?zSMhaPEqKkbJ/1GZjFaogSOvzl1tJW6+3EoAb8MBRpocmcolRwRDIc+DeP9b?=
 =?us-ascii?Q?TMe8uplLKgk540ZBk7vUmfFAx8IVGgT7Jo+ow8CL7roob+WggDyr35kxLJtn?=
 =?us-ascii?Q?+Sgs6rCKV0cI/fii5MQNXFMsjrNlZ21KM8cajq66le8koeoyzERyu6jSdHWQ?=
 =?us-ascii?Q?wrcIHQ1qF+Lba7hF3XkcM7lPOJWlCn3Z3FoeX2QE9O4yBsWsb10ongCbRx/K?=
 =?us-ascii?Q?OFO+WMQpqKgzUjRLyBme7rJ81iLHBQ7dsh+OAbblLRTJXOpywEN761ca+0a6?=
 =?us-ascii?Q?CB250BAtxMoEaSR+mWeB+p0XuvTb6n4tt38Wib5MJofHYW3Iekh82kQ24slX?=
 =?us-ascii?Q?f7JDNDxrw4CBq+d96e+nWjXJOY8ts+6gM2BlYrFduhFjcfPK7w5uCGUgXzIq?=
 =?us-ascii?Q?WKOs5kC+5iM9Eh8QRIPXN8LsKuzIzoArn/Yn6JK2zf4eNitnNOY49NOnU8iL?=
 =?us-ascii?Q?Uj63Rwzj/N15iHB4i7ZOISEaqOplUqr7Jd0sT5TamDzlgSM3pveE+K9kQAi3?=
 =?us-ascii?Q?oORATgrPUwbzLVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eldrouXsUot4dkVJafqBrpkRaeatOf3jXOc8UZbMpE4I7LOmNd+Ox1cf7LkO?=
 =?us-ascii?Q?8Lo/ZeBrK3imKCvrsM7zIP4Nl+8igl9AiRb4lkgoKmn7+2uYZAFjosmgTi5S?=
 =?us-ascii?Q?FvFBn/nSnPIrnzhtzK3UMbrU53AgNKvob6akIDtZ9Eob5cNQiEqSODc8X9qd?=
 =?us-ascii?Q?xsBoNHO9sh2FkV/zSaeXiC8+sAhLE8CAck6rzmXCEhFPS1ySq28DVt3xUqoV?=
 =?us-ascii?Q?22ihMgXwjoQxbqMfX9zZe/bDh9TUmE7fOGcQtsN7ZZl0evsZ/b6JO52QB27E?=
 =?us-ascii?Q?RPU9gzEdwxFeawDSKc1/DwaUrPHvD1i2PRX6zA6QRzLD8jqc3L5dYxBznF8g?=
 =?us-ascii?Q?Yqv9aOGlaCkjVm5gAin59gdgLBUWsWvPKCEdhPDtUTlJm/nOYA2PNUkIaBI8?=
 =?us-ascii?Q?rt15tWe/naSKBmj9Y/+Rb8Ho03N1GniGZ1U0P+dVsluAZn8j9sFHisznkjRS?=
 =?us-ascii?Q?sFKm0sIisB4Hb5kCE4tU57uTbcAhTbiNoVUCZKvIri4cQO4pbeBpv8nOFR7L?=
 =?us-ascii?Q?mLfM/g9Is7BdH+oL1OhXSfGycsTpzmsXdAGF7eAjO/rZuGmafL+ciVZKFsPq?=
 =?us-ascii?Q?fPqYUAgBnN5SRvA7drFQ9gbPnClP8oP3zFb6k5DVD4bNVbKLPsDfoIoqWTGy?=
 =?us-ascii?Q?kcVR93YFjo1s3kiSjTwT6xlnJbirmdyfgJh68F0mR1WByxb0IhLqFP8y65V3?=
 =?us-ascii?Q?usGlW5XCXzEfH3k/cT/rU655ZSjqG00AVZhwHShsp6TMRzROHsZI0IP4j74f?=
 =?us-ascii?Q?ZBb/Lsh8u5U/M7fAVCX99m6Id3tDW8kI3k/8q2HciEW0g84y4r35H1M+SSuv?=
 =?us-ascii?Q?C7Y3oC295TMlCNHImKxyoWYMcmpNjrkYOFCHh+Sff44G504/Xx4SiP1VK/Xd?=
 =?us-ascii?Q?EVSGklWxD1HVGdHLd8VnJYi57+ZcBLQtUUOnt0cTGMYEDMb0jpIcH3e9gBvm?=
 =?us-ascii?Q?paI/MhahJbZaNlyJuUvmZE0oHYnfkR72w4JjNrmHysoJAQuLperznGCfWp3h?=
 =?us-ascii?Q?ncxbrKZmWWjP5WRVsIfeeMyNnj6sH5CU5qvNDwD/3WneU8LsYA4IiAw48+KD?=
 =?us-ascii?Q?0FFiTxO5434v/MSN47yuiYZz6V+XFSUXFtbPgWd8CZMMRzrZV69Da/J5axfI?=
 =?us-ascii?Q?oudAi0cOl8Z45NxJkeXflyjzu9DlZF48oMFaevKf+pvK8FuPV86XZMVeDlg6?=
 =?us-ascii?Q?8UFwNSdGYJaToMxPV8D0eNsc5mzwpA+RhHj/MoyCU5y1RPye2ODKej1d7caB?=
 =?us-ascii?Q?bmJyZjzGzUelXM8v/rmOWv3vnDK1UGteGIWsilCVI9v1oA8itwdgOaq03Zqm?=
 =?us-ascii?Q?a2JhZDICcYR4BeLQR1twXOfrLQ7dgW4Pbq9EWiU1ITQA6zrTpcYD4cQPb4N7?=
 =?us-ascii?Q?HlWvybsUiif8m2sm9flip7JncFJx/++h7aSXQo9E1VNgU4StqMQRyEv3pO6g?=
 =?us-ascii?Q?20nBsURGb82CNoFRxPPEnPy1PFWtrE9KH+ppkSKg8Oc0k65l8ZJ+FUolDQzm?=
 =?us-ascii?Q?nQ6BTBqV4WMA1PzPBEYBcf9/wvbt/zxsXiBUFEhtuRm/Xu9or0AP5ab0/sk/?=
 =?us-ascii?Q?xOA9AhHoLslPWliAe8c7HsAJdVxtc/sfZ6vChjv1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97351ea0-d9a9-4d47-4e8e-08dddfe5f0c4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:34:43.8240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xKUCmfA0q14vj1Lot3aRzT1Bn1c+lV/uYdxTmxbUNHFtniSbMUL/G4AprLgWK8wHWsc2qhSDKkZAUCkeElIoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7177

Use devm_kcalloc() in fs_parse_scene_tables() and pcmdev_gain_ctrl_add()
to gain built-in overflow protection, making memory allocation safer when
calculating allocation size compared to explicit multiplication.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 sound/soc/codecs/fs-amp-lib.c | 2 +-
 sound/soc/codecs/pcm6240.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/fs-amp-lib.c b/sound/soc/codecs/fs-amp-lib.c
index 75d8d5082e30..c8f56617e370 100644
--- a/sound/soc/codecs/fs-amp-lib.c
+++ b/sound/soc/codecs/fs-amp-lib.c
@@ -111,7 +111,7 @@ static int fs_parse_scene_tables(struct fs_amp_lib *amp_lib)
 	if (count <= 0)
 		return -EFAULT;
 
-	scene = devm_kzalloc(amp_lib->dev, count * sizeof(*scene), GFP_KERNEL);
+	scene = devm_kcalloc(amp_lib->dev, count, sizeof(*scene), GFP_KERNEL);
 	if (!scene)
 		return -ENOMEM;
 
diff --git a/sound/soc/codecs/pcm6240.c b/sound/soc/codecs/pcm6240.c
index 75af12231d1d..08cc52b374a9 100644
--- a/sound/soc/codecs/pcm6240.c
+++ b/sound/soc/codecs/pcm6240.c
@@ -1353,8 +1353,8 @@ static int pcmdev_gain_ctrl_add(struct pcmdevice_priv *pcm_dev,
 		return 0;
 	}
 
-	pcmdev_controls = devm_kzalloc(pcm_dev->dev,
-		nr_chn * sizeof(struct snd_kcontrol_new), GFP_KERNEL);
+	pcmdev_controls = devm_kcalloc(pcm_dev->dev, nr_chn,
+				       sizeof(struct snd_kcontrol_new), GFP_KERNEL);
 	if (!pcmdev_controls)
 		return -ENOMEM;
 
-- 
2.34.1


