Return-Path: <linux-kernel+bounces-579611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD3A745E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 10:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D223BF101
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBE82147E0;
	Fri, 28 Mar 2025 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CZu2oL9K"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0AC214229;
	Fri, 28 Mar 2025 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743152378; cv=fail; b=EHJHNGWUqFR/lPlxgdMLmpq/+FUGRWgwHw8pDREVBmB10o9pqtEkwd6fbfkFpgllPiq2w+Hg05BKTRvDUZJoBjbw5tpgaqNWf0STbeK50AgAAnx9Xtwe8wtrdNlyupvTZv7PkesqowGL0GiZlZM1pBjmfoXZWQDKkYv+5YyND4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743152378; c=relaxed/simple;
	bh=4epSgtMbT7lo6XNhxJNMHungnVAYI7hFOVchqOIb7cg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CpJ2zbeEfcA6j0QleKC3loZvV74VlNl7Q5xu7NsF2DDlEtH3gQryaHDfNN1MtPfo0BmmUpPmZ0g/xvCXXZHp2a714UswNU9hbuosaqEOr3YVlDo1riBUO74DqYdz297viUeF3mH1bt1RW36x76xU40Ig/1D8SFSXhL3POGrEk0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CZu2oL9K; arc=fail smtp.client-ip=40.107.241.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDLkEjDgKWS99aaQaDJj9C25SmZGmV0+5jhNcawqkTSikEih2fCflb/69utrCDAXNyUis/v0qo6SJWj5/ooE447R1gpGAdUOLLd7mDUw0cHw89r+YgefAPGr0GUna67IwLye+Z9CMlpw3NOD+dRHs74OOUbt5E7Gu2ES5LxmEoGJpktKH7J9xyZA1sTQW/A/ClEg6WRDLCgB5e/ue3egIoNXndIzh1YErgLB8WihSWH7iwVlS8dKVm/4OzVVsp4FcbT1OdmAicAnEBehZtZfD7N1HMNd7hW0650uMOPmGNKhIzF8RTotHQrvbeNa6+Td0lyleW3f3vUvPB6dLeKXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jr0oOJfRa5+H0ur5dTlXG11g3LYRx5l2Ha42RM8bO7U=;
 b=m/bHUErbupyesX5nqEw26vvBDrEn/WtqQx5nybHuaeMKYZekGsv6rnslE3fOj1FdqMnsCOIgXR3xRAZc4nPP+YFwJrGQUjvp52Mu4zHmd4UlAK/QoGo+xWzI5ChzG52rUz7K34/MTWvXrV0LS5g1QelhC1LVMStSec4RwGGcLFSZmfFspTMhh2GmH9Q3VfbrDsf7jhKI5dtIznu8ZkZ8+fvccVSk5wtTG73dpN5tvZHL7NMkL3Gr3//AzOMLnUsZT9LzhZKqodn2i4Kh9UGB6AHCYL3m2DkDrjcf1Lcmks5eygtYZs6jukIB2a8sxaTUaPUSBe9GmQ2PGRSLTGPLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr0oOJfRa5+H0ur5dTlXG11g3LYRx5l2Ha42RM8bO7U=;
 b=CZu2oL9KC7R38yv0BhHN8yMXUmNxulyzYpERcqeIpm86wbBfLUtVI75HNJ1nHsMVglXOx5II8GADloPVbdm75w/KuTO9LIbAEWRQYrmY8GlsTMj7WqyHoP62SXuABlciV/6IpSQ0eEB26Oj9leOAojEWT5uIQT64uGWHg48tPEwR2jtQrxFgl8aCrO++DO0UVyzxOrwtZpcrkPyksSxS2M8iLKuKmo5C7ChuQlXLToY229n5hb00sMMZS+v0uaTWyJ7Qq+fHSA99JWKyqMcyx7Xj+oCvVurbdOhqBNLK/qWaY/x3IAgaUKM5yW+vjMdKQXdpfij63CRiwhvMOhdMcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI0PR04MB11046.eurprd04.prod.outlook.com (2603:10a6:800:269::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 08:59:34 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%3]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 08:59:34 +0000
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
Subject: [PATCH 4/4] ASoC: fsl_sai: separate set_tdm_slot() for tx and rx
Date: Fri, 28 Mar 2025 16:57:44 +0800
Message-Id: <20250328085744.1893434-5-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250328085744.1893434-1-shengjiu.wang@nxp.com>
References: <20250328085744.1893434-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|VI0PR04MB11046:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a499a9-3020-48ac-efd1-08dd6dd6dc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TNCQY8rO6fJw3A9jZcuedmR51hET4bQ36WJOvJ1ikegJCqgx9pEhrC+k//EN?=
 =?us-ascii?Q?WEvEJcFn91dlKpCgICFCVWwQ9bZNWsfboatifiyNGvovY6fbeieFE/CkJSbE?=
 =?us-ascii?Q?n5aziTT7vSF8ssNDteuThLLDET603CrNVrOwdB++EOv/f6Y3H+JyoP4Ywvz6?=
 =?us-ascii?Q?lngg9GEnFs1z2lk/KyIgzH97ixC7W75CVL7aKtwVxmYVDnJE+djmTLkhmaj9?=
 =?us-ascii?Q?3Kd5w/Vvk4efvQGDQqx/Xj5L6fjxzmHCRefdrBjDzs+uFCShqkeMjwyI8IWS?=
 =?us-ascii?Q?8dkGghb6ZE1YYe2AnCx0+ZfcF3XC6mzdnmm69uZRUayzASYAApJdHMwHqTum?=
 =?us-ascii?Q?jsm0IzApSkYSyHq1pMr3j7vx5C2iNKxl7c//8V7JeyV70IawByEXtAl+JPcN?=
 =?us-ascii?Q?8g9S7ATWbYWrPMGEp7ExUmahXe6VuCYAJvK0KeVJQPcTedwgyycQPUW+Y03U?=
 =?us-ascii?Q?41kezuGmeIAEVj2Jqznyt4WNChA/HvabdXHsyukyUQDZKf3iTibO+3PFNUv+?=
 =?us-ascii?Q?+JWW2BXPrYQUbjrS81GiOkO25gETuA3LUGaMJtrTzGr7RkZIKS/XOGui5hT/?=
 =?us-ascii?Q?8abBHFH1d++U9T9H8kR06ZWejQYLVuIYXUWo9Wh0xH2qZsvscsa/xmtIC8Gx?=
 =?us-ascii?Q?P7vzPmup9w9MaH/qM/PF8cFl43qYV7hqKucyjVmg/XvPrZkQ1rG54CPKhevc?=
 =?us-ascii?Q?Zw2Jsb8KD7LMkPv2dgo1wEq5wXB8ePWFTNQ8Ktk6wgLI00E3ALbVtsrBiWX1?=
 =?us-ascii?Q?Je8rvz+ClBkvymHLZjwOwlvoUxGDSNKQuKlVfiBSTAg9rXoijN7ard3fFrhv?=
 =?us-ascii?Q?8i1rWxWzFp1EYvB+lKHEgGNs4ju/Ejlgow0hcBHRB353tetlfvI0GfzEXfY+?=
 =?us-ascii?Q?FEeqTXQOPkSpEGlw40kaiBZr040DhPyq4gDkPJZw2I9fzbCsA6GyoaH7y8w0?=
 =?us-ascii?Q?9ZCLIIBIa2QxE6+t5vIa/dzqNfM0P/NmihQ1g5c9Gx3uFdaRPtqoWgSHgpql?=
 =?us-ascii?Q?27b+eBPBT+vmzcuuYfPoZxpYgfn5GpS/ysHqBoMgychCaeUp0RWiCdHcxtY+?=
 =?us-ascii?Q?pd1clOAd9+/pDWW5FlX9kI5OXefGyW13nU1ZC6tJ4e59IeqWo3OSNUEDZIWE?=
 =?us-ascii?Q?qKezEs8TMAJ0uq2BOTagnJbwZkQxYJd3yBrsPshC1T5yqtTpCSE7Gx268ZE0?=
 =?us-ascii?Q?+ZU/a/Zq86UXpclA8oFFZQVR2Lg4TFYagBcTkhHqZq5w4+SQB3AJ+ugGhK22?=
 =?us-ascii?Q?yI/eHxv+KSHqt/yGfOst0bl+OZhbBQAVUxQXOSGKB3BbkWkyTTKrUa+ZmfLP?=
 =?us-ascii?Q?BB4v58g6qgDqUvanE7gW65pH31onTBUQXkhY2fSYk6tasqe9ZsM/7ZpZAzZp?=
 =?us-ascii?Q?/K+QmNxTYtNuiWJezfEgUGO+j0ZD8Ud83VwNuiYbyBAGWIifgVNVlm+WJ7Aj?=
 =?us-ascii?Q?qc0I7gUJHFXjC0WUVY44PRW3VGCwQzHZ8lXF3aWbs4XhdEOIyn79rA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HlWfb2A/16QX9TRi7twUwKArM0HCbQu++7ZPiEaFUc4vAwQQm17pIN/jhUAN?=
 =?us-ascii?Q?7D5VPGXUI5SjUUwHHxrg/2DoZB+lByXqDqevL3H94Aq57F+WfMlpPbS9I2WB?=
 =?us-ascii?Q?SIuvsiFGOpxsQDX30sDmicC+g2znElo6hYZ/ubS3U2jw7ILxSJAeUoMYkWep?=
 =?us-ascii?Q?Kr3DT46u38vRlzdzae1s5SXq8u9bFKtI6koDIQz+IF0hzXlOMQbYF8JTjYTm?=
 =?us-ascii?Q?5MnZHWOVP7oBkL3J/UFuHGx6YaHHAmAtMMu9RPn32CnZpkWnwrNPNmhVZVlg?=
 =?us-ascii?Q?yhx3P4UD4UVBs7JNJyGcLnpJJRDg4V5PLcSkM/EpkOsW1UxDGnNRzsytDuyr?=
 =?us-ascii?Q?nJjHz1XDTTYg+1ZNL+F/4p8ztPfSuwgdrzYn3u0UXKX4OlVMQnjEzilL2XQF?=
 =?us-ascii?Q?vEjYdimyUxjtd8WK1M/QmdzySIjKtbVY1HMU0f2XORPfuTJDMp+Couxzveaz?=
 =?us-ascii?Q?7IIn3HvqVIgIBIPYZ27G6pzgwZA3krpi1W4F+NIS10PIXPDe7piQQ/okUz2K?=
 =?us-ascii?Q?BoM/QMRve7kakpGo+ZUcFOOC4I9KuDYjvWl3J43SAMzteUUmO8LHetxTNvxZ?=
 =?us-ascii?Q?a0WLVEbPJQzBwHfRa3vC4oOyYgw9SVgddGmZ2Zi/CHPtpmpWvJ95vNw9e6Mw?=
 =?us-ascii?Q?Ae1jkScp9n8Es4BYqQc1K/rQuQJke4aHalcCMmYcWl32Kge2Dnf969Ru6F/5?=
 =?us-ascii?Q?9U0C77BLWgB9sLE3UXlEGOwNs2X4YB+QQOpBU1MRZgErAp9g9JD7qAHvCKTM?=
 =?us-ascii?Q?TvWzEOHc2l/obpdQGe0gq9M2gZ+0blUS/U23Gcuxlj7AoiIpBnzbKbq1da5T?=
 =?us-ascii?Q?Rh07ZUv/M7b0pYySV7X3EjhT84UAIoYijxZ8ApKEj59Wn5MOqoW0racVn68E?=
 =?us-ascii?Q?1ESnLrJEnFgN5LFNv13FQ+AfU0iE+qNByFnURmCqyhCFdP7zgjvP04lSF+Ux?=
 =?us-ascii?Q?zZpbHxTWN5W0XXbFo0drHj2EfS5fd5MLx4NspXq7MFwljoMq/3VyEzhXUVbJ?=
 =?us-ascii?Q?8SX2rnlc2Ka2WfaypQpsPp69sPHXlESu6sHPzvW6vb2yxD2ntFkyyClFMJTl?=
 =?us-ascii?Q?Ngqn/X2r0PebhJjMOw+YRGT8RtbBvzvNTBcgq/hIn1s4C5DePcyrJO4HqbGC?=
 =?us-ascii?Q?PNA7o66YpF8k7sb78jgIP93O2SpG10941Lxohles3pu8NbXj9UJrDFqAKgHg?=
 =?us-ascii?Q?3hs+gPi68LU8+h++d1BchAzwrXG01D8bLGgb2tdExCTYM81tgsSd1Qc/7M+g?=
 =?us-ascii?Q?DtbOvR0bMGwdPSrrBPHzlonk9ZgVUa6mEVKt9nqKXSy7cjtqfa5ui/JKp7lf?=
 =?us-ascii?Q?9WULwzK/vNwhVw92z6kmT0f+1VwQoH6nsxx0itWkLgF8wX2iF9UkkY6nLFu9?=
 =?us-ascii?Q?wsmlu00gkzuCaTgJgswdI8c/1hSMUpPAGq+OnhmndjrHNtLb3j9Bc5YdJyt4?=
 =?us-ascii?Q?ER+/yRr05TgmCBgMYN92tWXNc9binNOz7S20A03oVS5occjNt5qHmOjWlR4H?=
 =?us-ascii?Q?hOfKWQIeBitJBAPqcJVT84alyzUG8qqRihxcaRD/VPTLpftrRwQ+9haSKTPt?=
 =?us-ascii?Q?HlUjl0lcRDXtzarwAi9r+BtNarHl+GAEn1w8v23a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a499a9-3020-48ac-efd1-08dd6dd6dc38
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 08:59:34.4458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFeyS6L9zbqjEXqyFU/XFjWwyKAq9lmVyu3C9oKs24ZQpE7S0xjo5M+SHcc6mOa8bCjCvhK7e59RoC3KFbHAfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11046

The transmitter and receiver of SAI can be used for different slot number
and slot width configuration, so refine fsl_sai_set_dai_tdm_slot(), add
fsl_sai_set_dai_tdm_slot_tx() for tx and fsl_sai_set_dai_tdm_slot_rx()
for rx.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 45 ++++++++++++++++++++++++++++++++---------
 sound/soc/fsl/fsl_sai.h |  4 ++--
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 09054e339b31..af1a168d35e3 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -163,17 +163,42 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 	return iret;
 }
 
-static int fsl_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
-				u32 rx_mask, int slots, int slot_width)
+static int fsl_sai_set_dai_tdm_slot_tx(struct snd_soc_dai *cpu_dai, u32 tx_mask,
+				       u32 rx_mask, int slots, int slot_width)
+{
+	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	bool tx = true;
+
+	sai->slots[tx] = slots;
+	sai->slot_width[tx] = slot_width;
+
+	return 0;
+}
+
+static int fsl_sai_set_dai_tdm_slot_rx(struct snd_soc_dai *cpu_dai, u32 tx_mask,
+				       u32 rx_mask, int slots, int slot_width)
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	bool tx = false;
 
-	sai->slots = slots;
-	sai->slot_width = slot_width;
+	sai->slots[tx] = slots;
+	sai->slot_width[tx] = slot_width;
 
 	return 0;
 }
 
+static int fsl_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
+				    u32 rx_mask, int slots, int slot_width)
+{
+	int ret;
+
+	ret = fsl_sai_set_dai_tdm_slot_tx(cpu_dai, tx_mask, rx_mask, slots, slot_width);
+	if (ret)
+		return ret;
+
+	return fsl_sai_set_dai_tdm_slot_rx(cpu_dai, tx_mask, rx_mask, slots, slot_width);
+}
+
 static int fsl_sai_xlate_tdm_slot_mask(unsigned int slots,
 				       unsigned int *tx_mask, unsigned int *rx_mask)
 {
@@ -548,11 +573,11 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	u32 watermark;
 	int ret, i;
 
-	if (sai->slot_width)
-		slot_width = sai->slot_width;
+	if (sai->slot_width[tx])
+		slot_width = sai->slot_width[tx];
 
-	if (sai->slots)
-		slots = sai->slots;
+	if (sai->slots[tx])
+		slots = sai->slots[tx];
 	else if (sai->bclk_ratio)
 		slots = sai->bclk_ratio / slot_width;
 
@@ -939,7 +964,7 @@ static const struct snd_soc_dai_ops fsl_sai_pcm_dai_tx_ops = {
 	.set_bclk_ratio	= fsl_sai_set_dai_bclk_ratio,
 	.set_sysclk	= fsl_sai_set_dai_sysclk,
 	.set_fmt	= fsl_sai_set_dai_fmt_tx,
-	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
+	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot_tx,
 	.xlate_tdm_slot_mask = fsl_sai_xlate_tdm_slot_mask,
 	.hw_params	= fsl_sai_hw_params,
 	.hw_free	= fsl_sai_hw_free,
@@ -952,7 +977,7 @@ static const struct snd_soc_dai_ops fsl_sai_pcm_dai_rx_ops = {
 	.set_bclk_ratio	= fsl_sai_set_dai_bclk_ratio,
 	.set_sysclk	= fsl_sai_set_dai_sysclk,
 	.set_fmt	= fsl_sai_set_dai_fmt_rx,
-	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
+	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot_rx,
 	.xlate_tdm_slot_mask = fsl_sai_xlate_tdm_slot_mask,
 	.hw_params	= fsl_sai_hw_params,
 	.hw_free	= fsl_sai_hw_free,
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 3f9357da0d8f..6c917f79c6b0 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -296,8 +296,8 @@ struct fsl_sai {
 
 	unsigned int mclk_id[2];
 	unsigned int mclk_streams;
-	unsigned int slots;
-	unsigned int slot_width;
+	unsigned int slots[2];
+	unsigned int slot_width[2];
 	unsigned int bclk_ratio;
 
 	const struct fsl_sai_soc_data *soc_data;
-- 
2.34.1


