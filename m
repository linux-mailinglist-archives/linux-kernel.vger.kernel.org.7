Return-Path: <linux-kernel+bounces-866292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E773BFF682
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F22154F6F75
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1952C159F;
	Thu, 23 Oct 2025 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ny5hokpK"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77B22C11ED;
	Thu, 23 Oct 2025 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201977; cv=fail; b=C53/1RExPbdFq9Re6frcTQ4ao1xfvdLdRVtjOE0ZTlyZnDAkGmqhr7HbGcSfnRboauZb4AXzzWT9PxqxWsZH+/xGApEQWNZ+4O0esjXfcBsQ7DYjmV5jLHLVmkv0YgGSw0Ekw7XxQU5D9g+YHDwIznQcfJGTNl4o6Hp4zZr7wwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201977; c=relaxed/simple;
	bh=0Ti38zfgzDMERkSqdyoU9+pv40NGYk4kQaV1DMXeK1o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fU+MQqay2aisSsW6y9jwmvk0tEY50dlqzuMoIpnJIePVdUF5zh5jedj5wHcK3x5rzoMR+obKU9AkrSKxUqfRLrfy7eVEOEy5CmiQ9wGi130WGHkcqmn52aNYryWqhGU6k5eH5YzzphjMUjgHtIJeKGpm5RlEzHolWA0Nv7v5XD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ny5hokpK; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+zO08OZo28ll4VccKRHdaMAWCO24zH2qa2bWFd5VnSBn9avM+BL8GDpDPGnB8VcZsg4qthtGv+UaqCuej1g6CXuMeiFlLnJTr5FZOKSFKAd1y/Lwh0+8d0+Yx9W1OrND++eQgr32jvWF1B/wYmb+knK6nD11yvd3Ktnb1Un/8acVWfoAIZaCzqi5K1fSZE71NmjDwUdYLf/zVamuPe9RWndmQ7jaRyrJiFt/UEEa75TAMK724j+RcSlJAEM0BfSgTKY0fFaC1Far31cngaYkphATbn6CuBKmgG3s+B2Ods4WKy9M7cFUjK8CrXPmJwndx+JR8uFQDnYA+kaDV+lKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loZoko0cpw69gNm8mT4GRW3E8EPcTh79dP0mkp8p1kc=;
 b=vBCIX84mUPmfnQQ+lc+1ChBRj3xZmOffriTrgYHV5pUrUnZLQaK0JoInhuJeBKciOcjzLIbhY/QOxrtJWGX0iJYZHpHcEuauoQmb3Of0Ai/N86aIy7F1AGjaSBROgugffuDwosK67yrAFNkS3hGuc537+SiW3c1qMdwvdwW34XONBWUYTWOa96JXoKfOTdYmJ6SMEO+97Qg3vdGR1xoulqxRufUpInERaV8esS+TjQHEi5ni0SJWYs7iux7iBY8fIIIZl1jOFfasjlZEVFVY6sJVmJJYt1osjRnkOSuXRxfuP4sFZCwJ7yJPuVWps0bdBbwJA6wJLOy46/IImRzHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loZoko0cpw69gNm8mT4GRW3E8EPcTh79dP0mkp8p1kc=;
 b=ny5hokpKAJh9afFaVg8g5M869XVvWKLHI3Pb+hRh16r8lA+u1DMHkpY1irt5GcABh8GVLoE3lIJ/1GdxqpUUB4QQhnaMAxUiq2sjZhVA286bUtcMD2DWfTMi2Slr63quILmHEdbuqONCgdhm+z+amH5RBZ86uVqFXEcaiRtSy7FneBhY2kUyeymlgpCdVP79KeT+oYpK8Vmc6To1JspIUVF4yhLGKfw3ElqD7zEsKcNugUu/1Ti+ug6/adBB1Okmh12OlNsGPg+y88sjWugrgTQ/fDdP6YdTKG19wQesyUaGv9vc8mU3LFpp978ieDATTaOcPo4ew1jLUH0pZi8WEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AS8PR04MB8006.eurprd04.prod.outlook.com (2603:10a6:20b:288::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 06:46:09 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 06:46:09 +0000
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
Subject: [PATCH 1/2] ASoC: fsl_sai: fix bit order for DSD format
Date: Thu, 23 Oct 2025 14:45:37 +0800
Message-Id: <20251023064538.368850-2-shengjiu.wang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea83f810-5878-497c-fcc8-08de11ffd8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?05k4d8vrr9ck/AafdsoXlc8g2BhU8zIxwlDdNeX/QyDGu1NsVV97TAYFdio3?=
 =?us-ascii?Q?vDkV1w/+cgSc6FLpCAtKROgKOoNPhvmamw9FTYMyNIk1e26P3JHTvTMlK0T4?=
 =?us-ascii?Q?lkwxMkYtn+DdtkvApJ9vC5TeBBCcA2hPAOTqzAlMO/wfaVUzpHUJrcKHtfVM?=
 =?us-ascii?Q?8rHt15Uy2oZV0tWIsNgMKuzY7tcEJxUaruhKEzqrIroSC5DwAGdOJ1WoB4vf?=
 =?us-ascii?Q?nyr09lrhgxC4OS7NKe4LaIBXk8RfvJ3GdA4U3LBQqS7BotfFw9/IfZACwfVw?=
 =?us-ascii?Q?ycxXbLg06O8G0otYz6/AEblA01GJpPnkPDfeYxVHSVXq/V99d9A3dGrsHPn1?=
 =?us-ascii?Q?S/gy+JEdWvUTKouk3f4khCgD2Cfk5q6L4Y910HpFY3odVUvqBZ6zvHsRGwAI?=
 =?us-ascii?Q?w9vPVzoT8zCVkXe/1C73QT910ej6NKOORqJfopP5g70sH/vi3vpNjHZ5V5vr?=
 =?us-ascii?Q?HxUHaFfyvVjKNgrBtjGeVnoAt9wwqQh1PXHNHqCmSCpe0ay6iHUzKlLaDI+Y?=
 =?us-ascii?Q?NSeWROfz8pQz4iIP8k/ijXqSvLVpvbq/SJMoNJSlJF66rfcNBOapL+q3aMYp?=
 =?us-ascii?Q?Quq8bazoEGsQIKizNdzWgyELAnqcaPiYvffNGgzqmqR3MezYHPkbM3vdaLR7?=
 =?us-ascii?Q?IU1c3JPTJAlqGBsWO79v72cCzENcu7nK/SRol6BvTcErMQiFYLSwvKI3xCCy?=
 =?us-ascii?Q?SwTugq4cyCuX0a2QWeNm0jbBl7NSiG+nYTkbHVzR8Qc1p8ONaxt5ek7k9Xhf?=
 =?us-ascii?Q?a/XaZnngf1YcD3KfaTEeh+mot0w6xfNdbsbd5J0tuhx54oaZEqhoFRmDOQEr?=
 =?us-ascii?Q?BsQCBvx8EQ17aw/ndIt122FkmCB7vhFiFdiiJLv9Vqx76TWM2uTUkQv/SlPC?=
 =?us-ascii?Q?V3CLEPm5tHxj7ciy0zJVfHuEAQnVzHYN2BZ2ui6NzhPDQAS1b44EWiTyRCPd?=
 =?us-ascii?Q?PitnRPys+3AS6nxOuRtsiucEougxP1/C0sGAATRQga/j2WbY9XnnwCk47xNp?=
 =?us-ascii?Q?HQrF9f4pekcZbt348hrxzM9v/Zz55Zb3XA7AfXR5TzE6oQH44CIJTCmaoi4w?=
 =?us-ascii?Q?mBlQQZwa8PS5+5mLh1TFTi4CrEbsyDOSI+3YSWCytC2lPw/EZbL75XVWQ+wX?=
 =?us-ascii?Q?G2Z2hE5OqdaUqHue4K39Zfr9nXrDbsVQ7hOAdE6nuqXcynD9vx8nN64RFHjP?=
 =?us-ascii?Q?AxtcruOIF8wwTCAgBbbPnkd8r06MXpJoAU26PqTbPadEr6X1+gweFXHr4M69?=
 =?us-ascii?Q?5pttC0NjtNyC0ni2mp+P+Uru8AvKMgqSoKU7FiOeAI0y1MLok4gE+mcrg4Ix?=
 =?us-ascii?Q?UovP7LaD5okNWvL7I4ZvUBbrGrlm6n04P58oAS1Q0XLV80DJCgWoVJRySTbq?=
 =?us-ascii?Q?Vl6yedZmH6HZs04r1YHarG4BR4lq0hw9ScAVfMqMXRDCTzRuf8d1hoyLGJBO?=
 =?us-ascii?Q?kM3H6ehk27jL7gfSl6nePdj0ptvrjtCqnBNWQeRUWbjgDxlb7ioINM3AjkHf?=
 =?us-ascii?Q?sPK7uwvDEjZrbe+eL2rURILRtgi3laXneFOOwksENqdObdCKAbrzt6fsCA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GkCLIwdReGkA5KLbDipXMwMGQ31sWGPmJT/w2RtRhX37My1mZXZKZhaLipYy?=
 =?us-ascii?Q?u+BpyCBs7/NeGt038D7oPdy2eJiYLoUQgG5z6BSbH/NLWKrtZvHGErhKU7N5?=
 =?us-ascii?Q?baXH7BwIi5LuESjY+3cjxeJ9SeYi0bgoRYYUeTQVaMivXI+QLpYHzHtv2otw?=
 =?us-ascii?Q?7lsZ6Hu7pJFHZMOrN42+f5bQp20Vd4j6ezpmYfoJCoXV0cgOM/JBjWCI4HH1?=
 =?us-ascii?Q?eQA3CZxL/dq4WuOX61h10wb401CBsAHY6d5/cDw0ZDmq+nioC4RHvWM5nz0h?=
 =?us-ascii?Q?gYECagyHzHN9xEUcx3/FctKjaQ7Px5umLIlMfpzF7nxdZYfDXN/UrXvpUQKD?=
 =?us-ascii?Q?YNv7O8ZrABhilmG59Ps+aFvIPL6fQFnvsMKBxufYk+u5Npu3qKdrXywE/BcU?=
 =?us-ascii?Q?AME9hd+lrvciwkuQrbh4M9YwG8px+V9D+ZqVhASKtB/iGbjviJpdod0LmN8Y?=
 =?us-ascii?Q?Cpy1d3QNUO0ejzON91mkBaFKJhzL9MnmHpzRAhVD4T4LZttDGGp1f9uK6h0j?=
 =?us-ascii?Q?i4I+UOmziphXkGUPEZlG3g/mgZuviHarlfg42zL9FKOHn1DDRJ5IPZOrpr0e?=
 =?us-ascii?Q?lrOySL6Bd+Kz57kcZXmrwXvAwzgPKkJc2YtcEPCRLxZCk+V3kKtABYDNEFjl?=
 =?us-ascii?Q?fhYzFse/RJzN9L2AtBvZMv1ewYx1ufkMSHvgZOAbQXRX9n7yXW17v1uyCUYQ?=
 =?us-ascii?Q?imdJJGfmy/SbGF0Yd7ByfQ1Ab9vIuk+jthuPjIVXVMzaX7oJk5K3paQxpZ14?=
 =?us-ascii?Q?RiVti8alY6tn0hlRLy+rXtPuRFjH7T4kOTyB+V8zr4whdPCWamFXmA3DFDq2?=
 =?us-ascii?Q?hX9h4plP7tAEkKPje35SUxsgLdiNd/fBOrAK+Mt8Ai/D8qvrDhuTie7ljm3T?=
 =?us-ascii?Q?hf7nEbA0aML/nhHJaHybyJTTwtg42KJ3vnwN8JzZdE/c5f54TpO6k69b9KRz?=
 =?us-ascii?Q?I91vPb7casK44J8mRfayNMtTXrKAR7gJ3/RXFBlGuMLQytB/Ujqm8xFcWa7g?=
 =?us-ascii?Q?vigE820iFDHWVS42JMydUI76hDtbqlAMPKTDLqjP2iC8Z9J0yVJO4LYijGu8?=
 =?us-ascii?Q?6iHKuavcV36BesF8Ge/1ZeE08ciHWKSrxCdATqrjDBRWoetAaCLvQ597Dezc?=
 =?us-ascii?Q?l91PwmIKN59VwXIe45QDfmBWpc3WuwvqbaCb2UX8T4bcujL9WZfZ/IJhyF8n?=
 =?us-ascii?Q?anmUSWnqBac5U4TW0qioaQEpi20O1LJf98Pf0PxidDonRV7Mvw3TZbVrBG4p?=
 =?us-ascii?Q?wjKnJmeQSi3qZ4PnBoue+iXRCNkc2HROyPws7cDr6CkuXXpjEeCSkUKqZOHq?=
 =?us-ascii?Q?xIvTkeTxdh89V3XhS+RE+0TceVGZrboB0AdAFWId8yX+0Dc54oFd2WxMEE6N?=
 =?us-ascii?Q?XoHHdT+70E143fj/X/rDAWZlZr4i36R5aSiK+WhBWLkAJywUw4lTTgAAd34E?=
 =?us-ascii?Q?y9P1+d2+FYwu2GsoaGg0t9mZFrlU58oyI6BG8bUFFJICdZi7le5MsGY68TAH?=
 =?us-ascii?Q?d7AwE/PkCKw9hOxJOuQWFxxYTA6+MWTlgZKZbHl1c3/Cwvpu4LxQITal3NGI?=
 =?us-ascii?Q?qz+2e1wHMUHZIo6zZLqrP20Zy5F04caQ7ATL9iJN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea83f810-5878-497c-fcc8-08de11ffd8fc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:46:09.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgKkA2EywGL6g4kVlzkNOuI9ujdrCRZETQlqM3RFmvTQ0trPDM22cMLULb1HBH9DN7aDMyCsISpLF/a8sUaj3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8006

The DSD little endian format requires the msb first, because oldest bit
is in msb.
found this issue by testing with pipewire.

Fixes: c111c2ddb3fd ("ASoC: fsl_sai: Add PDM daifmt support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 757e7868e322..65093325a6b6 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -353,7 +353,6 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 		break;
 	case SND_SOC_DAIFMT_PDM:
 		val_cr2 |= FSL_SAI_CR2_BCP;
-		val_cr4 &= ~FSL_SAI_CR4_MF;
 		sai->is_pdm_mode = true;
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
@@ -638,7 +637,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	val_cr5 |= FSL_SAI_CR5_WNW(slot_width);
 	val_cr5 |= FSL_SAI_CR5_W0W(slot_width);
 
-	if (sai->is_lsb_first || sai->is_pdm_mode)
+	if (sai->is_lsb_first)
 		val_cr5 |= FSL_SAI_CR5_FBT(0);
 	else
 		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
-- 
2.34.1


