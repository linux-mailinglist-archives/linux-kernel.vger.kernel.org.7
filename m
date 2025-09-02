Return-Path: <linux-kernel+bounces-796111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D8AB3FC0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12C74E19C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F97D280A58;
	Tue,  2 Sep 2025 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SWniDY2i"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8E27F75C;
	Tue,  2 Sep 2025 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808339; cv=fail; b=lv2wDPBIoLmVcnaWGblQvrM/gHdb60wcK4vLgFYYebLh49N0DD82ItBjC5/eThQN9Ep4oIymUGe8MHGwZF9+IWWvt6aowwLwhL2Sn5YQVpHG/0YLMMg2v9h17Br8b/SJ41uItgZKe3E40yKBOP5mu4YZf9bqYvkDiOvtRoekRUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808339; c=relaxed/simple;
	bh=RVw/KVycRYAPpaMtZs7lXPcAOIXqKGw+NsSXpqrfwSY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RKngjr2ckz19F5qql3KZaibTgnMVDzfKEZT2OsvJnorKXQz2ju1+raps9TH4LRbyycZnKMaYJk2+UF/OndvclTR1VSgRFgBq8Un0LTWOR0KCY7MOJgbwGQRo2qilPTg2skAqKyvGGqGEBKlIZHWEoZ+W5oUAw7FbWOfhFNd82eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SWniDY2i; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nI1j4c1Xo3/6c6WeuhJNOY+dSBk6EfNGUli+VeJ5bu0uB62gWxPQQ0xqBjjvBV8IOUJBDgmF5nNNxyl7AUTAEN+sRa5viY/mveuWxp+PMb/T9xYpVo3B5A17ace/5tDOJj1leg/Qj9l7oTYu9NcDiawDcgdrR9Gt+F5xRcT1dwt/IK78jXtiImpBS12DUP9VFDHTulZRsufr0+KqlC6T38tmkiVRF9omFm8no7yS44mc5NyeN8fWx3EMa+EzknbmnxETILxSOTL3qiym3q+LdwMKs5Ifxnbuwn9H8Od3Wi1RAhgEhhH0BzpF0pq2ZKEGXXmsPCtXsJSoDO0MFBmoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcuDxnwvTKf0WltgyDHn+eJVGTEFzMg7bS2+PJ8UZrw=;
 b=LJCbhE52VhjwVdU1R3fN7vUp9+E6Hcx89NVCqHYWhkN8DXAzu0zqIWFFrO91fQB0h0itQi8ZIxA+YPT7abyCH27IY2LSDrB6Cgu1BTdDFaYrMY2R/bVOQyfyY2rR44FDaY/qNU27JXN07soTc+ws+L8a1fd1HK1RSOAuUPbPeFbIyWGAcmQfrD1f5L4DRqNbuwEE8h3rwO7bazP9vKVStBimCUvEgQdqpPDGojh1KzP6PckhskZitArRiDBj5lJ0AbI9m4JFXFJfCR70JoFkTzWlngmFSI1/YG2B2ZJNCR7V+AdVX0dkyFTpREmtVExObWTasuUHEPRO6bDrDfy9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcuDxnwvTKf0WltgyDHn+eJVGTEFzMg7bS2+PJ8UZrw=;
 b=SWniDY2i9pLLpKnUPe6mFCTM7dQseDCDFfoAzqXijRYzqTgppoTOcz/8avk3PjLQlfcScgz9f4etIqqfe/zW+F0V8jaMelYF5HAnbaqs5FUPM9sj/IS5jcl6mrarzhw+1Udu4rHshimkzysQmstIM50FS7NPqPObcFwKqZFHfqHdfREtAfULFDJ9Ma3NH4NHZDuTNjDUGoXt9/8pbgKzp1A2UkjPKklIyTCAGtMBOg7U2SDG35awbrEDRkGEfIqIlyIo2vUJq7DFfFVApGO5m4r6Am6ttA1cxycIsmOS6HsPRC4RSbfpE9BWOIxqKjTDVsYEhw1hZRzb3i70UPUu0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DU2PR04MB8520.eurprd04.prod.outlook.com (2603:10a6:10:2d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 10:18:53 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%6]) with mapi id 15.20.9052.014; Tue, 2 Sep 2025
 10:18:53 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com,
	robh@kernel.org,
	laurentiu.mihalcea@nxp.com,
	dan.carpenter@linaro.org,
	waqar.hameed@axis.com,
	festevam@gmail.com,
	kernel@pengutronix.de,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2] ASoC: SOF: imx: Fix devm_ioremap_resource check
Date: Tue,  2 Sep 2025 13:21:00 +0300
Message-ID: <20250902102101.378809-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0028.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::16) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DU2PR04MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 652ae76f-d066-4f70-d3e1-08ddea0a1e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VEuduJaLFVHn7R5tIing8WUNVArIOTnWl52DwXAlr0GR54jYHNsn7ISNya5m?=
 =?us-ascii?Q?+gPk2I2fCnz872VvUEdslVM5qsj/WmoxDT42zI8RoifWTW1Vq8iPKkj5h9Sa?=
 =?us-ascii?Q?yOiiBufkMpmzoCFa/g8KD8T5fxhEIRdco54ijHeyEAT49I0uJaSbq5oCjlCV?=
 =?us-ascii?Q?94tP/EXarLGcZUc86+T09aySTQ7ySeX+opCmchDc5qiFvUrNQ0NT7CS+yoSo?=
 =?us-ascii?Q?acw2iVxRr8FUyuEZRE4SE1YZmLInUuyX0PkgqguEeg20XuhpQy4IRvnR98bc?=
 =?us-ascii?Q?C9xQv84YShc3G4PQy4zxoXQszNQ5U483MhDKNpIfoQHv3LneJxv9YMu/0mgP?=
 =?us-ascii?Q?isUqtcD0y//Jh9L1ZFHLf3POqIEeD1PBJJ3ajSO+UmVFEt8xHaQGt/Tgs4+V?=
 =?us-ascii?Q?fSG62JxqSCFs6lRuJ2g/BYIjf/Z8kJgyYVeUa1IB/2rJzTnvcWiB8RInC/zx?=
 =?us-ascii?Q?qIIlfeZk0cL2gvGpK4JsHwg0q07Etb2oiaIeqyCq4nbb/GB0XcQJu2CwwuQL?=
 =?us-ascii?Q?OauDKKcMDY/Gy68bym/dKrzWs7gOr04atAXt7BUF8cBFGaBosxEn8DgR3wTi?=
 =?us-ascii?Q?S43Mn8F7kCqCNaWZKLp7cI/LXGO4/lEkuHjPr8ddW1qPnaaQAmHpQV+aKtXg?=
 =?us-ascii?Q?ecsGmUJM1MmB1O9Ts1wYDgf8I80RvPCDPX0NpKAmszukhqbAGiWP/yRl1tmM?=
 =?us-ascii?Q?Khc7I7IRVLnvT6N5rXZrlWHBSuOBILi+6x3lrMle/t2emi2kI0BscvSSvtSo?=
 =?us-ascii?Q?i57M8YkUS91lB4Y7GJxVDtW/vBc+dirle6MdvsxT5qwXmKGs3lfAbo7vgjN+?=
 =?us-ascii?Q?WCNirZL1cwmdT8QpwOKpmrVZv4y+gk3cUuNudaH6Njqi8E52iWR1Y4mSokqD?=
 =?us-ascii?Q?E2leA3ahVwR+AuhMoQ1b2ma9qMnVwhr7eRhNqpyEQgaHqArhgRChmFjzqRaA?=
 =?us-ascii?Q?01wdfEbF5UJ/U+sVysZ2MsTvesF2C1ewJl2zkN4KYKkFOc6f/PgomF+ZQisI?=
 =?us-ascii?Q?5DE3gFhmjn52+UWrXziyRRPZK3QDCTT42QHQfyt8BAIQZkYXzAWSjmjpTtAV?=
 =?us-ascii?Q?d02EvSkOde55Y8KdBypU5WqgGIgWKyrLkjIfCvXkwatSjHvBTeIUKd3w5E1e?=
 =?us-ascii?Q?bU3nomQLzvfQ5ZcOQrJA8Mt0uKhVXEhJ/lX9VavoxEQg3Z/ZL5AqFEkSDqr8?=
 =?us-ascii?Q?6cvVVz3zbGmEHcLAq2SGepBS8t/4o1oc5i0Qe5CG1IsQDAxdaMnvXLIRe7Uk?=
 =?us-ascii?Q?QZ7x2AKUbUXO/AZrBLeEiF2gPwcMNKtDLyj/wafO22YONW73l4DHVTguIno8?=
 =?us-ascii?Q?Qv+hBAkWxgKuF3alscJGDl8nKzAkJdiin2qLwBG6Pp/156UXENWsnHjDr3Hs?=
 =?us-ascii?Q?Ym2+YR+Cbt33AiAsFqmWAzBIXmxvL3jQSh3CbsuqylNwpwJaLy+ZDLWlBviO?=
 =?us-ascii?Q?XF2s/E2bOWj+WtnSZZBewDwj6PJ3llWwfygq83E2EYT/98Q88OAAgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/hmflIRcnND7mAMApYQckrAmA+5MmLPH9u2J1tFgvVgIp0eJGgxTroXFG6c7?=
 =?us-ascii?Q?eMlPhYKcGlXvN9R0NPmV51jF/WIPEimIqN7/JtDcVWx2/VksdmT2CTLn6B8B?=
 =?us-ascii?Q?Zm+P0boItBGEIbHakU+wJ6A7r6HRPlR+QxLhLX+mADvdHnAIcEZ0Sfe382FQ?=
 =?us-ascii?Q?e2BiDPi33GbXw+i5wOy5ySAkTmZSSxL4MfuTqYX6XjRHclb4PHn+chte6NUb?=
 =?us-ascii?Q?t48XUyd6F723ZBzNtXetu+DVy1XtlHXwoV+I4ve42X5lPlFrBiRBYdCjQqqq?=
 =?us-ascii?Q?JN4J51WEyUYeYWVP2GDuYXcj5qSb0EWa6X4TCz5c8cKBc9YbRKKhZcbTjyBW?=
 =?us-ascii?Q?UAlfPoPV6SkA/ASgJHpbRmHY+EJYTH8K52iZXQu9+5vMzBvT8B9MNDvjkb/e?=
 =?us-ascii?Q?7xuTUESgMZHdQb2/wvCnrY1J9OsT8Rv72FH1fw9ySrmS+54s3KCiDLzc33zb?=
 =?us-ascii?Q?v7yePq7bk2235v9vtRv3NVIRcJhM98MG5K3tDtWeqZBejowNh182Nw4aa9/e?=
 =?us-ascii?Q?5ElL5apfwTv1zWorGhTSSXtWcsycaNYzkQDzRKAfrebqwMPHaWzsUrC4PwJ1?=
 =?us-ascii?Q?DTWzGkc5igQSvif7dRWNDVQrLqtJaTu8PHmV+QpDYsRi7/uP3GK6JyvRULLx?=
 =?us-ascii?Q?7HQAo2KGSb12VOmL64mm4kn3cw2P6kWAUsOLvwB4dqY6mxjSuspcU5Su9eO3?=
 =?us-ascii?Q?VpA/q3le15dhmvJcjcbY5sPXkMZsoJfu17bHLlYS+k4+E7Iz4pmnSM/XoeO6?=
 =?us-ascii?Q?eVgv/DY4aZn9EYYbnYAzjbqBj7E50lcPNunx01yTyVaeVB3AEhs40rExRs1/?=
 =?us-ascii?Q?v9qYOgd49TavyLSUlhYSZJoZzwOhQL6XsEJyqAeoG4vErs+xbKJ4iipgFTFv?=
 =?us-ascii?Q?qwgWaAmXYL6S6ZzTxBvmmBLY2kPpZ5IrdamfJHoBoP+YcKl7sS+Jgg8thCRC?=
 =?us-ascii?Q?b8r4YHKiCGu3xaA+5dGO6Vkv6qlAK4yVvDyztsWj81makgGxVpL9d4y8zGY9?=
 =?us-ascii?Q?GI3x+YYCoi2+slMr9M5O81mPg6vbspnBz2ZhLaAtyk5nDvXvroDAv0w4hOec?=
 =?us-ascii?Q?XKWwyl+C38IGme7qYZAmmiyKVlKGnww8M2UTFTPlx5Y5rIIjjVM1lr1yJ5yX?=
 =?us-ascii?Q?1a4v1qooV1WxYE+3afQZlFc2w0BjCgpjo0kmk6OjZDqD+GBo/gFzfxtF8plk?=
 =?us-ascii?Q?L9LuVe36srOZFU/Asr4KgjcrGWMJTWUdQyFe5DZ/wKWOExO1MK1k+/Ig3Y2c?=
 =?us-ascii?Q?OVN40YgK9uMN1JHEh9cxP56WGvk/XZXbryrqpOThlWHLqujb6dzV/X5JAxgx?=
 =?us-ascii?Q?VBgtNPpE3dBfwUWCo0FOTC0GdHpwqs2/0eQTeqTBEFaC2hd+wl5irmROCOGg?=
 =?us-ascii?Q?t9jZ2HWf6orym0y1E2IweResBYXQ2ArIa+1XjU3z/HfpkgF1e5bmnUzOOVit?=
 =?us-ascii?Q?X7Qk5SKh7GO8hNgRTVy3eSvfDoArNDbiXGdCVOeS/yGxN84sWB6inPq6Gg2R?=
 =?us-ascii?Q?mLuOGsE5xA/HnoiYRZ2KZruM7B1MNCFvwcqDQGw5CcCeu1l0Xvjtz+I+dIox?=
 =?us-ascii?Q?j+rujXJZBDmCXw81AHsUjU0D6SrM6v/Jm99v7wbw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652ae76f-d066-4f70-d3e1-08ddea0a1e1c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 10:18:53.4396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lvn4etBUZ3weahiK4A/+3/H6FzyBokgWjyKu0JeB0NsQXgUDC6egnZC/Hfc9X5+Z8fYpPYPxpVtCIVjqkBhqtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8520

devm_ioremap_resource does not return NULL on error
but an error pointer so we need to use IS_ERR to check
the return code.

While at it also pass the error code to dev_err_probe
to improve logging.

Fixes: bc163baef570 ("ASoC: Use of_reserved_mem_region_to_resource() for "memory-region"")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1:
 - pass the error code to dev_err_probe

 sound/soc/sof/imx/imx-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index 40debc541bf9..e787d3932fbb 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -316,9 +316,9 @@ static int imx_parse_ioremap_memory(struct snd_sof_dev *sdev)
 		}
 
 		sdev->bar[blk_type] = devm_ioremap_resource(sdev->dev, res);
-		if (!sdev->bar[blk_type])
+		if (IS_ERR(sdev->bar[blk_type]))
 			return dev_err_probe(sdev->dev,
-					     -ENOMEM,
+					     PTR_ERR(sdev->bar[blk_type]),
 					     "failed to ioremap %s region\n",
 					     chip_info->memory[i].name);
 	}
-- 
2.45.2


