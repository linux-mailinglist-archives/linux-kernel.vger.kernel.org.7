Return-Path: <linux-kernel+bounces-777691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B5DB2DCC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EE3177AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CEF31813A;
	Wed, 20 Aug 2025 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KhCv90vE"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013063.outbound.protection.outlook.com [52.101.127.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9842431DDBC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693369; cv=fail; b=EVNx7FJ7eRxYFuo2udhs1Yug6cKnZ5dqOcAL9zVpKsApBsp/o4Otvoc4wdvjmJ6yZxzKtxXZ9TDkn9lawt04hZDq9mibtV8f6Azc6DoZq1TiYaSXxZudcA6d1lH/qH3KBogb+4/YClMDqcfQ1QYcej2u4E5nOytpLKYb3QIf16Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693369; c=relaxed/simple;
	bh=QF/CpYFvdB0ZgIpAzjGTsU8nkp82Bmu4inEzB2Vx52Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jnkcIPwxJU1NcXnfrobhXUHgm+aSAwzwc17KynJn6Qeph0LMtxJF0bCTufUdZgl9RzUe+2OH2UijFQr6n38w5LAb+wzv4LMrE3AT0UMW/MkoryxpT7l8GOg50MzVY341/DLpJAQS5xWSW1xkHce+fKVpl5jiue41r6dcKM8EoXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KhCv90vE; arc=fail smtp.client-ip=52.101.127.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAl8L8ucxKDHhnIPjkpmoQgl2idMxW0UoJmLWSpdYcKahyZG7w9mUyoT6KtozwQynFuhLrf7bNR51mT4RFYvg8MM99PAbqzFVG3CMGT/9DnllvTh9jV5PG04YgODtEgyeAP0OTwA6dsbdaFxain52k3N+wqQvvMqq3Upe+Vu3jAn3OaCpYHi36HJakq8/9uS0TFN6EXb1hTF9yFcpJ1pjV01CgMEpBeIyZUNDa0rw9LqPUi/2aMDqGVH26FV+TopFvUeF4wsZYX7nZ9xEZiBj2StLCY7ICbaly7TdmWLhpRgeeSVZ7Avf3VI5YZ9uVL1dgRqrcdlxqe+bfWL03OgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9oy0jtRg1HRSHUl7Qr2MAfjTpadlWYKecIl/dl5Xyk=;
 b=JiSMp9fv2q5s/23JeLs4DEP8Lf5MELOB7id6lpW2LhZCcnjUfCZXu08SJwipH8hR+pAamM4TT8MhmjpvXVHsCxRIKFv2D1SXVJJAYPmoIdFsrcRIszXvFK69SUeuiA23MnqkUt2FV1FMbeZ66pRSUrHQT6AsRG10AeAk8EGGEfhiNPLgnDWHbCLG9ulP93zAR6aX6Kzx4zCNTCkRMaADYisQS3SUtq0ZWXm9ig4Z4YlHhguX2ibykCn3oQxcYW+FJuLCOn1o++iOD3a9k+gYkC2zRx9mmuGCLqiXoSf9B+Ja8kyMBbzOUGTLJl0alQkLtbrdEMcFsToH1Div88NGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9oy0jtRg1HRSHUl7Qr2MAfjTpadlWYKecIl/dl5Xyk=;
 b=KhCv90vEA5muLfLk6Y5eI4nDjvaiAfWX8SciZFSie4KcNPDqMaO+51K37EfJpsvd6E5dreRd3QvxG1KDSn5zMxrWM3XPRdm2hYmdjkTf+XRrlA0NCE0KPqW7HYthqfDOZDG9tB9qApTJ2Tgk2TArRmi7SftKY94CkqYMXxyierWlNCMYTHcwc8d4eJNLI2xGGkTQnDmmwOPze077QtD88X+0d5qFWgx+0OM8jzI1za2sZeZlT6E8enMWwZx4zzERe2Z9642zFaCuqQ3tuG60bq6MHLa+X9Vf2SlTEcMX4HVganutK7V6olw8Nty7kyt9zNXmeHjUJ3ovRBdztk8znw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SE3PR06MB7957.apcprd06.prod.outlook.com (2603:1096:101:2e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:36:03 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 12:36:03 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] bus: imx-aipstz: Remove the use of dev_err_probe()
Date: Wed, 20 Aug 2025 20:35:42 +0800
Message-Id: <20250820123547.471113-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0331.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::10) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SE3PR06MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 946b0ca0-a683-46fb-24b0-08dddfe6200d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WlVn+VvczWsFdiOKubJMG53H9havdA0g8Pp28DmaMCbTEQjYQ1iHKuPCNYHi?=
 =?us-ascii?Q?Ml6eyZCqim2TCLnixtza+6re03UvKXdUTXqXjNUiGYZMIc6lom42fRrESiJ3?=
 =?us-ascii?Q?OthvgrrZRnoh+JowO3iGawFtsuONS6QyVhJw9txmZRpBZxBJQOE483W29DKz?=
 =?us-ascii?Q?0bDA5YMq3WBT9ylwfE6VDs08/An2lVOWtTgjwLFMrCrnXGZjdIHlu7Dtao3w?=
 =?us-ascii?Q?mpxMAWblwa+4gYx6R/h7QaygFp6ZhdsYCQIafm0CD1I6LRZJfJRUYXCF/WSH?=
 =?us-ascii?Q?5koy3HYJTR4+aw1PGEPfNfuQOl7+y18O6BGJbVKpaV7rqgaqAXjABoPRxMlh?=
 =?us-ascii?Q?XTmm9YYwH8ShODaAdDjdPd6FRhx4LKiO2NTHbHBzkY/n5FkNlkg9r7IJO9dy?=
 =?us-ascii?Q?lnidHegKFnU5l8rvJjB7hWdeoMYb71UWte4UUc45VO8Rju9m3gxbRbpgAiPm?=
 =?us-ascii?Q?r52Mtt/H9+0JIFlnFr0RVaU6WK1lQMBg0Px+ZD7A4sOckgus2BhVJGMh5teu?=
 =?us-ascii?Q?55YcApms5royHZcuGLySs5eYBHFKk3ulqWwB2mWht/n3GTJk1y/sFRaHSpxI?=
 =?us-ascii?Q?QTmcCehNA0gVpq3qzGp397bJ5naes8vXRC/MK9IGGfNEsTS1kxYnQo5vwviB?=
 =?us-ascii?Q?l0XfClCTEfpgmm2VT0VC2MIle5X6wKLPalgG3DtIbvHeymDGDRYZmoT+HfRA?=
 =?us-ascii?Q?x0q1edi9fQD9Q2sdUXtOXmrZpAdIm1pJ/R+MqthM+GSrh7iPZqqKocoREmSM?=
 =?us-ascii?Q?34wOFqluD9uRmKAyYdG4eXPCIPldkEZso4N4bqF7XLnv8z5DIYLGZKsfSQIJ?=
 =?us-ascii?Q?EGudWgTzlCI0HsiZswfjBCdbDhfJF09LR+w0mO4cb7gx+w4vaIn4UHR6aSBG?=
 =?us-ascii?Q?ZznpgQtWhWb9FFplaATuV4n0bs7kzN8yGD1bTXl/sbH/scNrFUenKaPtdg/n?=
 =?us-ascii?Q?2w9RGoWiS9wN8fIBDePabzzZBbhJfL5pVhPdMGTnTATy+fwCysJN9uzBnRyo?=
 =?us-ascii?Q?FzGB/RbJ88Ge0pKryBvurMK3ZWzozGApaIBjEghXEiajOXTqOStZZfY7Nnt9?=
 =?us-ascii?Q?vLhtocL3/HdYY2IeCn6LFgvl/c4ufm4pIFO+abrb2OrpQbeoyX/pOrbYCJkW?=
 =?us-ascii?Q?0iLgwZhJje1MzTaZ97F9UDsmJJbrSGl1fFMNj9ZlYKpQgmEvxiA6HJoI9eOe?=
 =?us-ascii?Q?mnlL73l0kMjAGCY7NrDwNOW+vqIQnq/i20HYyKG18mgG/gZzIn1TGMcTVeMi?=
 =?us-ascii?Q?7RjPZ8UhhZKJDaYbobcQ/kpsBNQPtus/M9ga2ba2xP4IrXLFdxCsxfFdHjDG?=
 =?us-ascii?Q?jzZkYgdnPP+sSOHtcxZtOQktqP1Wk+L4SMB1+jfYJBoqTcCp+10RopsXkj2R?=
 =?us-ascii?Q?8uHVlF5SKBNdjdj73YN9yc0BH4zRjs3XrU2nlWaGlFWZIi1+WIVMlnJ4nTwX?=
 =?us-ascii?Q?Mktfbj9onab30PS3JNlPmSG3TzvQUwWTAYhUqShXmEbZYlefD11cESOl6Z9S?=
 =?us-ascii?Q?fp64gZlx1KGKHzA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfzCPWV6X2n2I/z2ECpSBGPSKiOKKFMoCumIFigMGqcM0lleU82UFaSde3Tb?=
 =?us-ascii?Q?pmjrNI0zJugVjzNUQVQUCiBI2ZVlZhXpr75onOTE7N5IHvEwkyHA+3S5FoId?=
 =?us-ascii?Q?6ZC64AfW5HyM9pAe+/Duzc03ysztC2XijfzRAk2PZjHzSwaLXpFH7eV5fKWm?=
 =?us-ascii?Q?K9UP5s6MO9Ae9Tsx8UmuvyxWqr2Ae2pyr9dNYIdTgt7PaSme8jhicCGF1Ldk?=
 =?us-ascii?Q?DDuja9YByvwGcZklbeNtL/RdOYpAdOABTtbYR5wFtRgRmxYnurJehfYjLDbv?=
 =?us-ascii?Q?b2sNEe1dSaZ0zyMnCMveJdZOBnuruBdjffPlYSqhCr/zmxr1/8t4cSCdsIZO?=
 =?us-ascii?Q?+r7wweFKM9/saN24JkWxMLqwXkExDdJz3G3OHOisI3YoJ0uAZsfrYvzFRYM1?=
 =?us-ascii?Q?tX7tbX68Bdfhno172mKPsvJ1I0dUvHjROpUQvE3EUPpjWnUZnw2G8y++xjsE?=
 =?us-ascii?Q?hhYrrOHbRSS785Fu7ULCeYJk6IGIv8RpiwS/UIHBW/fFd7UjQ3TYhu4y8TYP?=
 =?us-ascii?Q?MmmSA5h1gDcAh2f7JO3HAoOXCcdabUsZjNYl+6WAecO42WDPV1QrW8A1qxht?=
 =?us-ascii?Q?qHLS+glpkO7w9rw0joyAR3c8IAqTPY5IvKB0y9y0hfq6REXYQQVJ+S1KhQxV?=
 =?us-ascii?Q?B2ivcJdwRbJhJXmtBqoNzdeKYno9OoPr+SJz9eQlTYv3Lfm+ipq0W4GFlkop?=
 =?us-ascii?Q?zWAUmg1dNCGT5inBxpT0dbgPyNvdkDAsnH70F8lAEE//iFGCsIbgQ7ikGyOm?=
 =?us-ascii?Q?kwcI99Wk7bloo4r1adxHOfgWxUn7yyT16fZjI5E/tE6rBDCVcYZbBvzIM5mB?=
 =?us-ascii?Q?nx0FpxVxKUG3EEaPjPGXii3OfiCFWRCRe5rUi9GhveGmg3FPxJJ+yhZETgLE?=
 =?us-ascii?Q?2QVFb30d+ZGIJrniRUSfWUKreIejW/mcOfXRLY27YQMQnD6t1GzPJ50Zr6M3?=
 =?us-ascii?Q?qSu8rdHB4uHqDdIkTrPQ/8V1+rafCvg4TJU21uvqrmZI8PutDrswBiFSH+Ap?=
 =?us-ascii?Q?loj8jnwm8t+h8W9oyIRfWfgTDLqJm8yWYTbm8cqSt9mSTed6dloG8o+rDjd9?=
 =?us-ascii?Q?H/rmTE0FcHbqFPLn6otOvPKqBSCWxmwGgQdQu+WoacbFtQrRFRMz3fddClcx?=
 =?us-ascii?Q?GAACTjeoxtt2MuzPfFn87Goo9Xl+NVjejYHHVwjtdRAVdHVLuWod95Rfmlcd?=
 =?us-ascii?Q?U/mZneJi8kKIDVxZh2E2SfLheoWMCGuZQtwwXbJYMkrqXV451WXX7Q+LUWCP?=
 =?us-ascii?Q?Qb8PDOEPeJ7KRrmrqEk52dDaRewjp0Arszs+O6yAtfgaiizHDwzzH6o4OtmM?=
 =?us-ascii?Q?2MQvuZoODD+ttA7nzkz6pXsXp5dhNuj4tiCu30hMs7LJoZAmnN4A8gdxnUQg?=
 =?us-ascii?Q?rt5FcDFNRaKsGUs0bf4gKP2UQFjGFVXBiykdKlk7jkTSKGW6Au0c9hoPHIKK?=
 =?us-ascii?Q?IBlw5p+HSJJiG+m/pMCeD/0+fVeDbJg8HtZA9y3mYyV+bpfal9M5zZ7UEDVt?=
 =?us-ascii?Q?537j5g6ciJSpRHaNdXAtL43WwpP2yAR9WI6J245KJjpqgYnnrE8ZyBeViJrn?=
 =?us-ascii?Q?eeg4HcpG8Sc0Npx7zZ5BHGHmQoK9H3i4Jl0GT9ll?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946b0ca0-a683-46fb-24b0-08dddfe6200d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:36:03.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwcSdrhywnYSQsF41ZroVLseYxKKu7PEEW1Fl2htnFAp/P3MCrcikIkj+3l53NiVDn+L8lXq0cjPqWUscONfMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB7957

Logging messages that show some type of "out of memory" error are generally
unnecessary as there is a generic message and a stack dump done by the
memory subsystem. These messages generally increase kernel size without
much added value[1].

The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
remove the useless call to dev_err_probe(), and just return the value
instead.

[1]: https://lore.kernel.org/lkml/1402419340.30479.18.camel@joe-AO725/

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/bus/imx-aipstz.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/imx-aipstz.c b/drivers/bus/imx-aipstz.c
index 5fdf377f5d06..b0f1445c4110 100644
--- a/drivers/bus/imx-aipstz.c
+++ b/drivers/bus/imx-aipstz.c
@@ -37,13 +37,11 @@ static int imx_aipstz_probe(struct platform_device *pdev)
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "failed to allocate data memory\n");
+		return -ENOMEM;
 
 	data->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(data->base))
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "failed to get/ioremap AC memory\n");
+		return -ENOMEM;
 
 	data->default_cfg = of_device_get_match_data(&pdev->dev);
 
-- 
2.34.1


