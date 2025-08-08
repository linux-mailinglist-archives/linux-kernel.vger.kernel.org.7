Return-Path: <linux-kernel+bounces-759759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77060B1E213
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A83218C375D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D11F4CB5;
	Fri,  8 Aug 2025 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C/NhZQyu"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C68B43146;
	Fri,  8 Aug 2025 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633895; cv=fail; b=A4RRQwzq8n+a/yalMSI0CXala5z77e1tL/pvoTIB4mSYJp71RpdNJ6sabO2vDKCwvSvn9i+r9OYrfMLH/TVbx4M0ylr2o0sdIWokjDYt2VZweIgJqwVQ4DVWXnZbihfcCRCA2Ic05dJsiSowdGEd2788IuvC6xWvFZ5onzhqf2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633895; c=relaxed/simple;
	bh=3BS3Ufgi/jKX+Vp+lOal5SBfmsLp1ZUgbipMFTwc7ro=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S3cPOzE/kBiEhPRgXOQ3v4VOj2bsaWrao1WD1G2m3YjMVmBB+0H0iuuxJFCk/tYeYfgJ40bcClPZtSh1Rw+Od4PUbdqtekUShyu/t9OfsgD7p/uDMwOh6uS1F0BcXAUVChEOnhFZfH2dxeiGuGL52Jrxa2G6ygu2oVrWVuZe6rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C/NhZQyu; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdNsKaIAIHzORHgXq8+aTYx66xkNkjWz6eQsRJ38tlQ9l8Ofdz9XUmazRWAaiFCWZH3b4+g/ETOw0u+X1eX3PELexFwvIp6nfuOMd4F6sD10qkaUh83+JphJB7IvuO/FQAzv+5C10273AbosWSv5yNu3IqEvRoJVUtimCabbRDqk6ssznLFVJOzlWqNEDN6va11jM6pn7U6gLEpM6l8xQWCVnaNincdWJKWQRrEkAGApJ1VvdJmkEtAEMclLwvfbAicg6zdrA1T8jyJa39PInECITsZk2MQIdg3xhyBuOLTvujsxTwJQQFNR1pwAtprD2VmyiaRb6Vwgz79i6dkULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/wNvY6WMUno3vwuuFRiw8s2tgzjYWsAYnXDtDI+9pk=;
 b=ACsl9SYHX/LGf004bL7rk1NHixKvBihzuoLurMrC1wyZhVacP+Jw8sOoSjjW4GOLhT31m9KC2gvAbN8ii+vi3C4jqeQggctX9VO2qhubO4ahZlZU6bs5YQtiRtjH8im1aA0QyWftnV4KNBjmOjJgGcXgeAZGobl2Qms7hAop6SDtqk9ntQA69yK5THdjO6GCbLpyjSVxZWY8hRzCGiHqydSAjWxjn81+iIKOjQZCpqvP2Le6FuhCPtS2d0+5fUIDBxo+UEyooVNmOKT77X+fHxnbR0+SE89me4aPx1my+3ZIHCwDNBNXe1crozfoA7azACEEqtxNB4LVoU7Is5f0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/wNvY6WMUno3vwuuFRiw8s2tgzjYWsAYnXDtDI+9pk=;
 b=C/NhZQyuyKxTCEbj3yqxNWWQv71p+YRUlVrcAVaHL8zoIXIcoUjDi660z7qysVJYuG6WwGEWm/onC9V7wKog/k8onG0PzVdxq+iqFPDML1g07u1qsi6lp6qbno1SLdabJUvyMeSn+hYlurrLtPaiNCnHtrXjPv2VA4ZThMkVzVTSlrVozknn2TU44V8f9tvWRAnFWgT15GQIRIyvbrCTN/Oz9tayuwvfxOeF9hE06RoxmBf55MxkpX36rPD5jOwCgNUmICaISSoIjB7RLzq3BEOWOJQ+t4OGu3PbO8QSH8974kfOvQislf3SYKvE5eg7eMEKO/yvhSWNx7mV1kxHLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by PA4PR04MB9437.eurprd04.prod.outlook.com (2603:10a6:102:2a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Fri, 8 Aug
 2025 06:18:09 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%4]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 06:18:09 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: lars@metafoo.de,
	perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dmaengine_pcm: Add port_window_size to DAI dma data struct
Date: Fri,  8 Aug 2025 15:17:41 +0900
Message-ID: <20250808061741.187414-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To AM9PR04MB8353.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ef::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8353:EE_|PA4PR04MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: 61febc00-221a-4ed6-df89-08ddd64358bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D6LrnCZEMZF1T6RjlRo4wpmUXICK1tgRNnLftKPZUb6JpvKBYTZ/yiybqXBw?=
 =?us-ascii?Q?sqiXU+lnx3LvQALOJLrdCi2RgLrGAvCraliG/nYiJ3tasGTuH+M21FRnZjmR?=
 =?us-ascii?Q?gTAMbPxEzqOLzU7eLH9+1B/27fQ3cu9qbhHVwT0cgify6V2cWVKlTExqH+n2?=
 =?us-ascii?Q?9e474rPM0dTVv9XmOyB9oYmXwZ0nIB23ATCZZXK6bPSF25XmkS5mivCY5d/u?=
 =?us-ascii?Q?4iHBeyAZ0+yqHkd+Ic5c9CTZmRu87kXgDF9UWoIuVsYGZVNnbapvsBVEuwa5?=
 =?us-ascii?Q?kQYQhTjBRKphrLOB3misX1iPr0wt8dQkDsYp6RNT9PSdOJvPMvkZlxyMYMbF?=
 =?us-ascii?Q?uE8hUcTz28aY8M9oAUXB6lVpFtsIO2VLl7+nO/aOUhGNThCvI8GMVieiSugC?=
 =?us-ascii?Q?PbyIFMjnocNQfzjmBw+TGh8aDCCZhya2z8PMZGYY6Le1jLznJM7PeyykB4yu?=
 =?us-ascii?Q?Q8n2Z22jaGJ0HvBhGpsRlbdxwxk5DROlcUiu4xwDZLfUS2RWN986sqBic/1/?=
 =?us-ascii?Q?KMbJblt9LpzJgDXY6xS+w5IKtDh2RRo3Udw8KtBmh/zYphB0/ZQ2QyhUyw2P?=
 =?us-ascii?Q?sfXJ9W4ijNoh8oAHLGfNgSukHFtqXH3LdqAgsdQpBX97JW4c36ZKn8uZ5uDU?=
 =?us-ascii?Q?UBL7SDOpgc0fWZxkD/IaeFgJQL1V8c+BOpyS+U1PD63nsWdIOiw7XRLAhjbS?=
 =?us-ascii?Q?rlck+vBhupCn2ZvzR1/nuSLmjyadQnNRgX3Y/fkqqj714RDstVyKHsTyPI/x?=
 =?us-ascii?Q?xU+B8hDv8wasgXrp1UxZIvHFzBzLtxQdWItIjDk0TCBBpjNKKmZ5Cs/vfyDS?=
 =?us-ascii?Q?PkX6f1a5TBzBOtj+sQcTfSbghVKUNzn/X+wF81L8MfrKIlBpZ09PZ9R9eVbZ?=
 =?us-ascii?Q?OMv125h2/aoHznL0iBNCGyRap5z3Dq+DuEPQnJhr/j0p39mndABMhEnDp4fv?=
 =?us-ascii?Q?Yhmd5kVD5f3p3JrAGZM4kUQCEu6k5y7jTJ8JupB/2oEI8C9UgLTZsGlsVHEK?=
 =?us-ascii?Q?cC980VZNB3DDLa+viJfvP1ma1xb1XNp0rcu5Y0iIjFMbFiikspCdD4/1sawG?=
 =?us-ascii?Q?XHvOQnPGWRNFf5i5aNId+bMrqjTXcbvL6fgXawWLNPmAmtxdtjcMkedahNPJ?=
 =?us-ascii?Q?ut5tYPqITk4VJapBeujXX923Ab64Y8mezzNV1TvLZB2BRD0qv3TrB0w/CCvQ?=
 =?us-ascii?Q?32Qa8LjYCHOr3pM2ZjWD0bzjFoPm6vKN3pUD3/lyAhsvadE4yn40Wdl0cxqb?=
 =?us-ascii?Q?yAV1gYqjVeeHEpMNSaPYlyMID3m6u36jIiDiZ307+1y+dyZSWTY7FOc+SxRA?=
 =?us-ascii?Q?M9PVpfcjIxLNXKTfSJbdAYMmfHtulTG/DOm36gaTxYejHibLpgdLKgAqGrYo?=
 =?us-ascii?Q?k6f7AsenxanbmqjGbcC3h57uQWbAEah23lPf8Dk1mZvAegWxBXa2STKn9au6?=
 =?us-ascii?Q?mZZPkJ4HWQGbu8z8HA5o+2TAPtQPVzeMxlWQYrv+dE7Nlz+ZN0tThQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ddnwsl/ARsG3r0/4xvOV6N/ojvb57D67wXZnGZ/34OiMBrVpH+MI7uDMtVwB?=
 =?us-ascii?Q?rwGs11kn10BrF7mac3OjEbKLUvtFIaf2xXnwbhu0iPC0oV4IL+polSe5xfAT?=
 =?us-ascii?Q?j+GyFjRHZHXGkiD5J9UWGbJy7CBGNTgiD9U9UOj/YvbMrAB57yX28Jq8SzV+?=
 =?us-ascii?Q?jq+Qkx5HLb1u8LJcLDrRl7SdKFpxDkH/4d/dVATedusfqwVBBd/h7n18Mh/z?=
 =?us-ascii?Q?pEUhI+5Y/j2xgeBd6u6BxoBbG937PeOHHiKV1dvVNhwlzWWn7obbrF5ix0hu?=
 =?us-ascii?Q?C5ujiNjZfMCSykbkLnz/Mj4KA5mzLAsSd6itmniGWylHeqfaJIicZACq8l6J?=
 =?us-ascii?Q?qxtjj9OmynShsm/8oInz0Pv166803Kl11Fnp5hNcv5+ybhTFAspZSZCm0bAI?=
 =?us-ascii?Q?j0249y2vz6AL4DHCItMZHnXvaynuf3L0aInPUl4P3Z8txT0R00ik/aB9mBWX?=
 =?us-ascii?Q?yk4aCjzDoPeMeDd15lWnayLCbSvHwnoQ0QvSb6y8FUnDdSlzQixmDEYsHy9f?=
 =?us-ascii?Q?XP/XQaPPTk4+8B5+NKifwbRDN81SulL9xcJ5qeIv4NMpzljSq7YGV3haXPz0?=
 =?us-ascii?Q?ki3QkQzHIeE1q2dMSNHyNL1Tsdh2MbG9BikjUx/51hzpUVeM8mVSd4+e6vgb?=
 =?us-ascii?Q?z8quqR7jWYvJ2hGjysMvfPz6jKvt/Sr/bMLMCI44GX/AGkgiuHm7JsI1XPab?=
 =?us-ascii?Q?BXhI5eV2tO1Rvf+4bCP20+8XsGC3yeSwzERy5x7wRQU/h0h1niMSjUlheRlk?=
 =?us-ascii?Q?GYMQ1OaHDE56xskhVSOtmD+kF/BtwIeg4ldmysGQ+2NHhrJIh699zT+c/7t9?=
 =?us-ascii?Q?M8RmgDHUEuqwYhf5mfajZKoCd+Knw/gfiApQ9drYWVfbBM/H7ryZ61Gr0dmS?=
 =?us-ascii?Q?cMEZmNALUvgvLQkVs+askIv88yaJ8wSy6o5n1B3lkn2LZpsiJ2vL5DSlBZG+?=
 =?us-ascii?Q?aba5+1YI5Iy/ubJsypl1SfTJQxQ+zf8ZGhacbNTliP7LiGVHCr7vN6GxfDHa?=
 =?us-ascii?Q?NCWOtLe4yE+tpveoRzbFItrLm0dvCpd0YNfpfuhQM5W/zx0zWHp24XljGjnD?=
 =?us-ascii?Q?uLHd3tJPhe2oGAjrx2XQORALD+KxpmqWnQmw6bT8WWyDENaAp2I17GmJyPMM?=
 =?us-ascii?Q?1mMWxr3PRId+fVDC/NoOqrgPd7fnd4NngRLYqs8jfX/cgnko0jZpg90aNhUi?=
 =?us-ascii?Q?M5jt0ZYMQKH/hGyevKmFqjrlFhltENlpGhTo5aOiIg/HdQ08xUKysy0XMdsS?=
 =?us-ascii?Q?bgGxFyCh/Uht/MG+2F2LQQ53KX/y/HmOJQcksMdhkuFVW8AuMwtq/4fr6423?=
 =?us-ascii?Q?QDr6meHHHnxoIbUzQ3cBYla8Iik6FoBlo46YRYNFNHPc61qdVcppMcDYhG+g?=
 =?us-ascii?Q?/3FzvfSHiMFA+oQpdtU1UzNBKmbPdcI8GP/7cdboO4Duck8s4wA28DQ0uZA8?=
 =?us-ascii?Q?NuHZ4LChkeJ1Mm2BUAOAaFmEOANi7akM1vlAuRWhMqHb9/XXD9WMtf1bfj63?=
 =?us-ascii?Q?0BagVHd+nV+qKA+NIefTc2Lshp6klW7Jzh70tvzkidQTddvnelXBf1kQeKoi?=
 =?us-ascii?Q?DfWSjAdEfi9MOQCUSnSDjT4UITT6dT4jmUiGnXlw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61febc00-221a-4ed6-df89-08ddd64358bd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:18:09.8465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9EMSUbXBBUCnnVgiq/Y2oD/CKWI831sVz0eVkL407jzsVRWqpVCtkxPWoE6+tU24qr2vc/YrMTKRjvrumUQVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9437

The port_window_size is a struct member of dma slave channel runtime
config. It's the length of the register area in words the data need to
be accessed on the device side. It is only used for devices which is
using an area instead of a single register to send or receive the data.
Typically the DMA loops in this area in order to transfer the data.

It's useful for cases that reading/writing multiple registers in DMA
transactions.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 include/sound/dmaengine_pcm.h | 5 +++++
 sound/core/pcm_dmaengine.c    | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 1ef13bcdc43f9..9472f0a966a27 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -69,6 +69,10 @@ struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream)
  * @peripheral_config: peripheral configuration for programming peripheral
  * for dmaengine transfer
  * @peripheral_size: peripheral configuration buffer size
+ * @port_window_size: The length of the register area in words the data need
+ * to be accessed on the device side. It is only used for devices which is using
+ * an area instead of a single register to send/receive the data. Typically the
+ * DMA loops in this area in order to transfer the data.
  */
 struct snd_dmaengine_dai_dma_data {
 	dma_addr_t addr;
@@ -80,6 +84,7 @@ struct snd_dmaengine_dai_dma_data {
 	unsigned int flags;
 	void *peripheral_config;
 	size_t peripheral_size;
+	u32 port_window_size;
 };
 
 void snd_dmaengine_pcm_set_config_from_dai_data(
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 72040964b6fd6..f0c17503df425 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -111,6 +111,7 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		slave_config->dst_addr = dma_data->addr;
 		slave_config->dst_maxburst = dma_data->maxburst;
+		slave_config->dst_port_window_size = dma_data->port_window_size;
 		if (dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK)
 			slave_config->dst_addr_width =
 				DMA_SLAVE_BUSWIDTH_UNDEFINED;
@@ -119,6 +120,7 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
 	} else {
 		slave_config->src_addr = dma_data->addr;
 		slave_config->src_maxburst = dma_data->maxburst;
+		slave_config->src_port_window_size = dma_data->port_window_size;
 		if (dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK)
 			slave_config->src_addr_width =
 				DMA_SLAVE_BUSWIDTH_UNDEFINED;
-- 
2.50.1


