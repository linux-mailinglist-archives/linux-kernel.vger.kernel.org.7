Return-Path: <linux-kernel+bounces-823212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC532B85CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B534F3A5385
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E56D314B60;
	Thu, 18 Sep 2025 15:50:57 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3CE312801;
	Thu, 18 Sep 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210656; cv=none; b=WL/lc9LVnRLrKsOXaaEsDjSyLQeajiiNec5bgClSoaGc30GxvqZK31si+Z7MbbYvQor45ymPLw4LyeGkXatCMd5KTUEI7WVX9MaX8lkelGXEokUC6dlgwvXF1YWG5aZEjzmwQ3RYdphbWmQrqYXE+LpNHsbCqn2u3aTLHXyUTdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210656; c=relaxed/simple;
	bh=hiFVvDsKhsZYm/v2+/bRrQVP0aSM357pzO7qX7bdClA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtAoC1ki27+HYo86wY8Z/4rIiajd1mq5RwrWKdUJA36mBMSgmlgsLQSvUyicZHxdvjPhSHbr5t8TtKFHLHOmVrOwvMs8yXyP5nh7NUdlH7oJ5L+KubJ888uNKdnynNPfiTDMBshrokZzr7Djfgm289yTwNyBgD7zndN5pBiusnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cSKST1lJVz9sg5;
	Thu, 18 Sep 2025 17:34:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oX_2heg6YaBY; Thu, 18 Sep 2025 17:34:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cSKST04Rcz9sg4;
	Thu, 18 Sep 2025 17:34:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C02FB8B767;
	Thu, 18 Sep 2025 17:34:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id XD6WzEdXVtAS; Thu, 18 Sep 2025 17:34:32 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E966A8B776;
	Thu, 18 Sep 2025 17:34:31 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Herve Codina <herve.codina@bootlin.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH RESEND v3 4/4] ASoc: fsl: fsl_qmc_audio: Drop struct qmc_dai_chan
Date: Thu, 18 Sep 2025 17:34:11 +0200
Message-ID: <9c729bbd9f1b61120a09a87fb76176ef344c5153.1758209158.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758209158.git.christophe.leroy@csgroup.eu>
References: <cover.1758209158.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758209657; l=7036; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=hiFVvDsKhsZYm/v2+/bRrQVP0aSM357pzO7qX7bdClA=; b=oA3dKiOCZ31kqBYOQcNUMFTkOTmgYgQtxij9M8WvelR5/+bYlgZQBVItZWNy4YPLRccDMKo6Q dV61RhOSRLWAzLjZP/dUyAWPZSYf0HGD7vPtuOYVP9fwia3krRLHUdr
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

prtd_tx and prtd_rx members are not used anymore and only qmc_chan
member remains so struct qmc_dai_chan has become pointless.

Use qmc_chan directly and drop struct qmc_dai_chan.

Acked-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 sound/soc/fsl/fsl_qmc_audio.c | 52 ++++++++++++++---------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index 2790953543c5..3de448ef724c 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -17,12 +17,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-struct qmc_dai_chan {
-	struct qmc_dai_prtd *prtd_tx;
-	struct qmc_dai_prtd *prtd_rx;
-	struct qmc_chan *qmc_chan;
-};
-
 struct qmc_dai {
 	char *name;
 	int id;
@@ -33,7 +27,7 @@ struct qmc_dai {
 	unsigned int nb_chans_avail;
 	unsigned int nb_chans_used_tx;
 	unsigned int nb_chans_used_rx;
-	struct qmc_dai_chan *chans;
+	struct qmc_chan **qmc_chans;
 };
 
 struct qmc_audio {
@@ -125,7 +119,7 @@ static int qmc_audio_pcm_write_submit(struct qmc_dai_prtd *prtd)
 	int ret;
 
 	for (i = 0; i < prtd->channels; i++) {
-		ret = qmc_chan_write_submit(prtd->qmc_dai->chans[i].qmc_chan,
+		ret = qmc_chan_write_submit(prtd->qmc_dai->qmc_chans[i],
 					    prtd->ch_dma_addr_current + i * prtd->ch_dma_offset,
 					    prtd->ch_dma_size,
 					    i == prtd->channels - 1 ? qmc_audio_pcm_write_complete :
@@ -165,7 +159,7 @@ static int qmc_audio_pcm_read_submit(struct qmc_dai_prtd *prtd)
 	int ret;
 
 	for (i = 0; i < prtd->channels; i++) {
-		ret = qmc_chan_read_submit(prtd->qmc_dai->chans[i].qmc_chan,
+		ret = qmc_chan_read_submit(prtd->qmc_dai->qmc_chans[i],
 					   prtd->ch_dma_addr_current + i * prtd->ch_dma_offset,
 					   prtd->ch_dma_size,
 					   i == prtd->channels - 1 ? qmc_audio_pcm_read_complete :
@@ -206,7 +200,6 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 				 struct snd_pcm_substream *substream, int cmd)
 {
 	struct qmc_dai_prtd *prtd = substream->runtime->private_data;
-	unsigned int i;
 	int ret;
 
 	if (!prtd->qmc_dai) {
@@ -220,9 +213,6 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 		prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			for (i = 0; i < prtd->channels; i++)
-				prtd->qmc_dai->chans[i].prtd_tx = prtd;
-
 			/* Submit first chunk ... */
 			ret = qmc_audio_pcm_write_submit(prtd);
 			if (ret)
@@ -238,9 +228,6 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 			if (ret)
 				return ret;
 		} else {
-			for (i = 0; i < prtd->channels; i++)
-				prtd->qmc_dai->chans[i].prtd_rx = prtd;
-
 			/* Submit first chunk ... */
 			ret = qmc_audio_pcm_read_submit(prtd);
 			if (ret)
@@ -610,9 +597,9 @@ static int qmc_dai_hw_params(struct snd_pcm_substream *substream,
 		chan_param.mode = QMC_TRANSPARENT;
 		chan_param.transp.max_rx_buf_size = params_period_bytes(params) / nb_chans_used;
 		for (i = 0; i < nb_chans_used; i++) {
-			ret = qmc_chan_set_param(qmc_dai->chans[i].qmc_chan, &chan_param);
+			ret = qmc_chan_set_param(qmc_dai->qmc_chans[i], &chan_param);
 			if (ret) {
-				dev_err(dai->dev, "chans[%u], set param failed %d\n",
+				dev_err(dai->dev, "qmc_chans[%u], set param failed %d\n",
 					i, ret);
 				return ret;
 			}
@@ -654,7 +641,7 @@ static int qmc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		for (i = 0; i < nb_chans_used; i++) {
-			ret = qmc_chan_start(qmc_dai->chans[i].qmc_chan, direction);
+			ret = qmc_chan_start(qmc_dai->qmc_chans[i], direction);
 			if (ret)
 				goto err_stop;
 		}
@@ -663,13 +650,13 @@ static int qmc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* Stop and reset all QMC channels and return the first error encountered */
 		for (i = 0; i < nb_chans_used; i++) {
-			ret_tmp = qmc_chan_stop(qmc_dai->chans[i].qmc_chan, direction);
+			ret_tmp = qmc_chan_stop(qmc_dai->qmc_chans[i], direction);
 			if (!ret)
 				ret = ret_tmp;
 			if (ret_tmp)
 				continue;
 
-			ret_tmp = qmc_chan_reset(qmc_dai->chans[i].qmc_chan, direction);
+			ret_tmp = qmc_chan_reset(qmc_dai->qmc_chans[i], direction);
 			if (!ret)
 				ret = ret_tmp;
 		}
@@ -681,7 +668,7 @@ static int qmc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		/* Stop all QMC channels and return the first error encountered */
 		for (i = 0; i < nb_chans_used; i++) {
-			ret_tmp = qmc_chan_stop(qmc_dai->chans[i].qmc_chan, direction);
+			ret_tmp = qmc_chan_stop(qmc_dai->qmc_chans[i], direction);
 			if (!ret)
 				ret = ret_tmp;
 		}
@@ -697,8 +684,8 @@ static int qmc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 err_stop:
 	while (i--) {
-		qmc_chan_stop(qmc_dai->chans[i].qmc_chan, direction);
-		qmc_chan_reset(qmc_dai->chans[i].qmc_chan, direction);
+		qmc_chan_stop(qmc_dai->qmc_chans[i], direction);
+		qmc_chan_reset(qmc_dai->qmc_chans[i], direction);
 	}
 	return ret;
 }
@@ -794,19 +781,20 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
 		return dev_err_probe(qmc_audio->dev, -EINVAL,
 				     "dai %d no QMC channel defined\n", qmc_dai->id);
 
-	qmc_dai->chans = devm_kcalloc(qmc_audio->dev, count, sizeof(*qmc_dai->chans), GFP_KERNEL);
-	if (!qmc_dai->chans)
+	qmc_dai->qmc_chans = devm_kcalloc(qmc_audio->dev, count, sizeof(*qmc_dai->qmc_chans),
+					  GFP_KERNEL);
+	if (!qmc_dai->qmc_chans)
 		return -ENOMEM;
 
 	for (i = 0; i < count; i++) {
-		qmc_dai->chans[i].qmc_chan = devm_qmc_chan_get_byphandles_index(qmc_audio->dev, np,
-										"fsl,qmc-chan", i);
-		if (IS_ERR(qmc_dai->chans[i].qmc_chan)) {
-			return dev_err_probe(qmc_audio->dev, PTR_ERR(qmc_dai->chans[i].qmc_chan),
+		qmc_dai->qmc_chans[i] = devm_qmc_chan_get_byphandles_index(qmc_audio->dev, np,
+									   "fsl,qmc-chan", i);
+		if (IS_ERR(qmc_dai->qmc_chans[i])) {
+			return dev_err_probe(qmc_audio->dev, PTR_ERR(qmc_dai->qmc_chans[i]),
 					     "dai %d get QMC channel %d failed\n", qmc_dai->id, i);
 		}
 
-		ret = qmc_chan_get_info(qmc_dai->chans[i].qmc_chan, &info);
+		ret = qmc_chan_get_info(qmc_dai->qmc_chans[i], &info);
 		if (ret) {
 			dev_err(qmc_audio->dev, "dai %d get QMC %d channel info failed %d\n",
 				qmc_dai->id, i, ret);
@@ -851,7 +839,7 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
 			}
 		}
 
-		ret = qmc_chan_get_ts_info(qmc_dai->chans[i].qmc_chan, &ts_info);
+		ret = qmc_chan_get_ts_info(qmc_dai->qmc_chans[i], &ts_info);
 		if (ret) {
 			dev_err(qmc_audio->dev, "dai %d get QMC %d channel TS info failed %d\n",
 				qmc_dai->id, i, ret);
-- 
2.49.0


