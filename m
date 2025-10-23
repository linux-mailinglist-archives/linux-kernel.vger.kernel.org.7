Return-Path: <linux-kernel+bounces-866293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23865BFF667
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748471A01624
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541A52D94A8;
	Thu, 23 Oct 2025 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XmVB0YE+"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CCE2C11FC;
	Thu, 23 Oct 2025 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201979; cv=fail; b=DGJL5ib7M1q5GWes5/6gcG13FXN8EwPqkyANaqb0URX5PyW99ONhCWjy55/rDahQM1Z7YjxENxk5VZZpwbXxKtmDFtmSZ4z7YJEH1HSWMQac0QrtwtyIU1pQWbhqS3GMqrk9zZAT7FP/2rlctn654x2QDjzuptM1dsuLMj55Fyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201979; c=relaxed/simple;
	bh=6SqGFeXN/VjCwJx0C0rqvsRTukC7J0ITA52iFn+REQI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ADdCdiBz8QRK/Lxwb7wIZMVQCXnwQXhKC1nUcB55JpCb8308/uaQqgyktbJ6WJq0RBgZF+7U8bxml7SfNPSLgjXQScYzD1Z69IHGza3ekA2gVOdrHq3B/vgbD3H5IoKcHrm4CGpDZep6KI4csIlYQllQpguo4y8jKzNerqsfEDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XmVB0YE+; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/mxhl+5KKRF7WBDqETdnI6WazRJfuaYPyzQ00LQ49zXtlZT5LIHCRq8VBlx1kFXfBsVQ6J/kuv6u8t4/634XgSjWvaEoqVOf3Sh/ETYB0kzTKCtiEjh5BT173xDNhQGQLvZtiJfRJsvhjz0W0V6BnH/v956I9EnS7lt5De1TTBxGfGLwqiNe7kwmoCNwhYFHfSRHTIsXepXOmJcVlQYDASSK2ilIiTMViDhBdlx/cWV2kQf88WBsq56yB2bQWARZHdjMXL8wiPZnQcYLeOuFwpOAwZILBesXp8N09rZHK/Lx8tAWvJzEBj+M7ANdCKpKJLMYXMt96TOZUmpZhVmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVYkp/krf126GZHeo/TwZb83spHp2lPxqCVM09fKbA4=;
 b=gtE9WtORdM9aVHVbr899OixCQbU7aZkw8NnJP15iUandQiQP9qCKLU+yavmsELL40EXsWICwFcq07i0qY6EuG11ReohuttuD/GZd62JM7unb39sVatXDUScOI2XDC3JELzRIZuDcELkyo05/i8//UwdHKa6cELztBfRv23iiwwX7EgZl8JyuVwi0GKlL8iIY4gvWi6tX1pUYOM5P0prvgVUmx31C/WzZmuVbid7SGohUNTuMLN8VvXS7FWB+WQ3yPy8F/enrEZxxCVxmB/9HN2xvQ2SULWakCAqgq7mAJtp8WRAlst6VkqpoEtfw9R0A5EB859jedcMOt7gnqEjAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVYkp/krf126GZHeo/TwZb83spHp2lPxqCVM09fKbA4=;
 b=XmVB0YE+6Hl9QhkCBA97vw0DfZ3lzdmcy5lR1zeoNkBBKkxPLwnNsFPa8p/tco3P5b8G1nWLmVkTCYKHVHaeugTj781kiK5zq04qEnUFCxnIJe5LtpRidJ7LU55bofutHnzzJslK3Es/5ONksbMbSB2gGJaZgwVENpapZvKP1MFFkHXUBJ2P/WrLAOqjw9UrMR6vOACUtwacrNkosJChvOlF22rTvU6U4M2D38dgUzTu+UQF7LxBC8APMJL33ddZ7aW5Gs4VBlDGGi7+UoHy2fE7EZKmVS+Q/rBjmprFq0Zgp5rGc5O4xIdbaimpPeJMBzgULxbOG/LZRcnNPmPCyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AS8PR04MB8006.eurprd04.prod.outlook.com (2603:10a6:20b:288::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 06:46:13 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 06:46:13 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: fsl_micfil: correct the endian format for DSD
Date: Thu, 23 Oct 2025 14:45:38 +0800
Message-Id: <20251023064538.368850-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251023064538.368850-1-shengjiu.wang@nxp.com>
References: <20251023064538.368850-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AS8PR04MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: b2dc7f96-c41e-4278-65ac-08de11ffdb3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AEehMo643wEMxlzBb189SRyKify1dQ6farVJKHz0uf6EiFh5nFlFQfQ8dAh7?=
 =?us-ascii?Q?g0gm+Ui7zeOcmTBL9LxexuSekWojP+4XcGS3RFrpfsguWnby/M5bX2HnK6Nb?=
 =?us-ascii?Q?kowePEL5Q+ZxdBf6N4sjTnXqmqTZkhTepTDHmWeek4l+ndmCwWePVoZSGwAR?=
 =?us-ascii?Q?W/6ZjoDiv3C+/ZRBrvrPPekdyUrqd6Z7yZKEp4m7GmVOoHWzyZFKiVLu5r73?=
 =?us-ascii?Q?eMcRW6BNEN2jBzqJZP3WtEf6k0SgPJNRVBnwvjC+TyH7h3zGR1mQC42pBpGb?=
 =?us-ascii?Q?zbu3d5HaIL7evvi3OCo9ciKNNK/UV22xRncXULNd0Oh7UK6dmehP8emeNDyK?=
 =?us-ascii?Q?8h1AuBdtQ6/BE3y/JDrLrcsYkgwNkEgjhiDnGn5yDlflpsEmszbf4j7teSuV?=
 =?us-ascii?Q?g8Ph5yPfTtfTe5lw6xAMWRso28L4M880s4+DRP8atqK+gyxsoZ2zF0QgSgYX?=
 =?us-ascii?Q?qANiKgtZ4nCXH3qLU5lhATZBUaZzhL/7j6ktsKtaNAtBCKnMUirYn/SzFPu3?=
 =?us-ascii?Q?2zWf+gNrSkXn2XO1FGglhVFubU2vNMOv6IZdYdhDgZ0HEW0JSL9HpAwIlnKl?=
 =?us-ascii?Q?4zmgMp2O6juCugBOsPXrCq1QiiBf6VV33YX/i9ayywpDBbL8L3jNoOlTsthi?=
 =?us-ascii?Q?IY7PinVkYW0Wv932kKXtEANHaoR5TZbXcN8EqFjzx0v+6oQz8qu5qcYl5xbU?=
 =?us-ascii?Q?tzkEkQ4GYjsrUilXO3gPOup0dOswzcRNM0Ekxzhr4TubZmMX+zPISa/HWamO?=
 =?us-ascii?Q?4WSgPFSiEbg9srZ8sh3U6zKRoDxgOAnGOziHrbvbReeQr+5qWrspQgmXDUHV?=
 =?us-ascii?Q?Oopw6+MXPmeT7h6hEmnatoCwt3KlJEoD8ctL2TGA1aAd7AGuraN++K2Gh4wh?=
 =?us-ascii?Q?bR5J8ZBkXv3fQqqxraC4WwXyXs0Mdd4hA5g15B4MAtDoKwRjhOGBXy1hw3lZ?=
 =?us-ascii?Q?QU0bellGjHzkag3lykYxajjZjmk1qGc8PskTIe8L0Aj+f30b/2w5j4+Cj+cc?=
 =?us-ascii?Q?6chJA/Hmzwzzu2PPjKJMnpouBA8xR8IfO+fxLDxtIogVkoQBvJodN5EfrrgA?=
 =?us-ascii?Q?af6ufpZKCM7R8v8HCuxYDWz+ENOfTiFtOKpk0bjuHsxozJZyTfgxXRH2Y9ki?=
 =?us-ascii?Q?slDivAV3VXRpkOKXrJEI4f92OMswpV29aPJM9XlpalYug0j7lVkfTWmeu6h8?=
 =?us-ascii?Q?NWn9t4pKt75wY9vUtAzX7HIeBmBCViTGEWmXnCTK9mTznjStvS97yglCwa28?=
 =?us-ascii?Q?VBT1vC9iRzFtnuzDyTwgMQuvmYUWvWY5lpX6C7KOHJOhTlK6g016XdWk9L8E?=
 =?us-ascii?Q?76GTTjuE67W2ouZLPTINyt0L/tnPYXe0NgtZ+QUHaBdooWkTKkjRcnfKim5W?=
 =?us-ascii?Q?uV+Ii4Ty1HMtLwv+LapuYd91h/s1RvTr6xAjXHXBJYH02D2IXgBcuVimE9Bn?=
 =?us-ascii?Q?PgABJ1ow0EIhmrvgrKKm0rYpusA6s4MFGzF41s1Dkz3bj5BuLldUcbAR6gTy?=
 =?us-ascii?Q?a5YGEGQSRX1u6IlfSE+vLU3vj2g2Bk4VlmjC4MfumEhlim+nK9X66jOj5w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KzgHXGIWbr7oZsKVVzAkst6WkOPAO4hj4hBqOmptzcMwhbBK4e9dmapxyFbF?=
 =?us-ascii?Q?vDEOAV7ILXNxcpq45dIdegHB7xhQKkf/BHkipfB1Z0bOiWGKkgMyRLghekTE?=
 =?us-ascii?Q?KOvYUtdK55Y/I8Rty2y9FPIPpNAaCyjcqw8igor/JT2WxKMhN+dSgP5qVJ8G?=
 =?us-ascii?Q?7yU25tHPZghzhDMRBQZlgO4xGlkuXaSWGNXDBBIcM8F6VAGTcMe750t+kaJS?=
 =?us-ascii?Q?4Zx+bcLn+7iNDcwg5pzZjFj2xCnE+hYpikULj9HkmXA2kKNLA5evV9PsxVmw?=
 =?us-ascii?Q?Xbr33f7iyG/j9lzAwXjbbqeiB5m5RjJLXFC/hBwEJy5UntQ76uYOzf/bm6vO?=
 =?us-ascii?Q?jI5Q9RAzOVNjgpRGPIFJfhLG2gINNDi+VyzmQKzzfcJqe1GTuZURLmcM+vvG?=
 =?us-ascii?Q?UABJIPCU+nZVYKWYboYsG9OmkQsprHgemwlwE0c86+oGuvgvnRHmnWYukhTz?=
 =?us-ascii?Q?86F/rGcksSf4+l1Y61flpF60U5/5c3zJ4xoaA/FqKrAd2yCfwURfetag27iK?=
 =?us-ascii?Q?LVWmaiWbNkYIjKPQtsHqLQbDvq97eI6U/mSySRVUFLr2BfLCzN4sa5gpVYtg?=
 =?us-ascii?Q?dGBlJx+YoOgNUYCrlOcB0yv6fiXpIWqVsnmlaNUxsFf0ZxEHuOmx6LP6TAh0?=
 =?us-ascii?Q?Jpx1WkS+LkGZmPm3vI8KoCrKE55sSXY4splhyrJWIIlHO+GfUllIlBDNlwS3?=
 =?us-ascii?Q?DmweGLPqLFH2blNOdVoB645pA1GmkDp4Xompn8RbWcSAs4SrHaiNa/jurdZb?=
 =?us-ascii?Q?T5+WVPSvR/3qbwuthzC7jEoyBCdqsa1jCbozHhAQ+jNLRH8GxaA0zs+aB3Xw?=
 =?us-ascii?Q?YHVhZqolri5xMS/hpPYfJIM4MbgAdwzikzUZFqL9M0iDz1Jy9tJq8IKW84Td?=
 =?us-ascii?Q?FQ6d4lKuVxuxpuvEAsa6+6JxfUmqsdDVM5RdSnFk8ZfEff9Qh661cHCljttf?=
 =?us-ascii?Q?HfqqscHVzayr8DjwmIQ75bNunhZL74uYkiMiAIOV5HthsGgokqwZI+PUPnd2?=
 =?us-ascii?Q?GkUjqfWjtDCPZ6Pi/8xVqR7VzPGKwwYhlh6gC/Y6cukm/hfcX4yK/bSUiPOJ?=
 =?us-ascii?Q?7Rmxz75/g6tsH/NFciYuH2te1avo8ohAWvCqnD+X2bhKJ9R8Sp7GfdZEdlQi?=
 =?us-ascii?Q?AbptBuI3Lu6hxazo4pXLS1Yt5dAtzqW3Ttq+HP7epL8Q9g6f1l4GI7fNLqeg?=
 =?us-ascii?Q?G14SPq7MqjpoonxykH8sGnCP+D3CLzQoPkGfi8l41YT+hcX8Q7pQeA7x8ITG?=
 =?us-ascii?Q?f9CWKAneokQUwQgEmEXg8ecw3k8H9CFYVpEMt2r/WVUyoRdpJdZ/FC8pdAxw?=
 =?us-ascii?Q?JIYjbjE+tnEmnz7+gpB7sFwGYopniA4+0VrBgol0iPqUInQTbWremV/er+jh?=
 =?us-ascii?Q?a58BRsXZLI9DBG+IVndrlW0l8Z89G5lRbzAZcY/rDS50fqet+Pj4IcZnj4UZ?=
 =?us-ascii?Q?Fax3pdPW3er0z7ytn4BdA4cXIWYSgav9bJPfNtuRpdjmq+oOYEXEooRnogfo?=
 =?us-ascii?Q?dXzWA0BLGxQPITm7Cqz3rC1Skr9et5L77l5mBkjH+lzvqUUyW4R6JSa9wGEL?=
 =?us-ascii?Q?36EASy/Z5s+a5s+5MvXge0dsL8ZdXS1qhoOmq3AN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dc7f96-c41e-4278-65ac-08de11ffdb3f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:46:12.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VcxW6c20hSAj3ipK4cbTZsD67qZlRzVGvOmoEt77MOOxz5Grtg7FNvUgVx4GTrf40cYU8tysqc19LqZ6FfLuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8006

The DSD format supported by micfil is that oldest bit is in bit 31, so
the format should be DSD little endian format.

Fixes: 21aa330fec31 ("ASoC: fsl_micfil: Add decimation filter bypass mode support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index aabd90a8b3ec..cac26ba0aa4b 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -131,7 +131,7 @@ static struct fsl_micfil_soc_data fsl_micfil_imx943 = {
 	.fifos = 8,
 	.fifo_depth = 32,
 	.dataline =  0xf,
-	.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_DSD_U32_BE,
+	.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_DSD_U32_LE,
 	.use_edma = true,
 	.use_verid = true,
 	.volume_sx = false,
@@ -823,7 +823,7 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	if (format == SNDRV_PCM_FORMAT_DSD_U32_BE) {
+	if (format == SNDRV_PCM_FORMAT_DSD_U32_LE) {
 		micfil->dec_bypass = true;
 		/*
 		 * According to equation 29 in RM:
-- 
2.34.1


