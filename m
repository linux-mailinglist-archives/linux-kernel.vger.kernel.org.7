Return-Path: <linux-kernel+bounces-773218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2EB29CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C69B7B424B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD3C3019B5;
	Mon, 18 Aug 2025 08:51:18 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A09323A562;
	Mon, 18 Aug 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507078; cv=none; b=KFxJFbGDlOZu+x7xXGOvJaOOuXOctxwoW3CZD8vjgyCGpZvPpaAsjYGLGIJLZlTzPegNhZ4JAn+JFSAOp5ezGMGJspCtHOBL/GNiz0B507dCmZVLKTWF9gupuYTuXrucXJLBzxRQwHiqylgjdSKEMckHxdm3qjX328wLIKfUiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507078; c=relaxed/simple;
	bh=kTwze63IXhfJKmOMOziMBpN3ze0bvx7Dv9G4bd5j9oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDlKAtAKkTNuD3mzpjd7+yhsIvknGoyRKLOnxh3P8rYXuK/y0SHDHGVO6vQdZOez/lK6da3JxLpWvvNA0SXbYzo/cEwyW2VMrLHkIH/4jPofP4KAsM37RLuFRipwq/vV4omEbj4pi20mwYeKDYVIIxQFaskjAGZmex61ICkVoSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c55HX0qZFz9sWF;
	Mon, 18 Aug 2025 10:20:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9syMfqubNB4p; Mon, 18 Aug 2025 10:20:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c55HS62zqz9sW7;
	Mon, 18 Aug 2025 10:20:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B866F8B764;
	Mon, 18 Aug 2025 10:20:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id u3ByOgEZDKj3; Mon, 18 Aug 2025 10:20:04 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B40F8B763;
	Mon, 18 Aug 2025 10:20:04 +0200 (CEST)
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
Subject: [PATCH v3 4/4] ASoc: fsl: fsl_qmc_audio: Drop struct qmc_dai_chan
Date: Mon, 18 Aug 2025 10:20:03 +0200
Message-ID: <ab9550c28280834152c6a0f51d58a68556abd1a1.1755504428.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755504428.git.christophe.leroy@csgroup.eu>
References: <cover.1755504428.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755505200; l=7036; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=kTwze63IXhfJKmOMOziMBpN3ze0bvx7Dv9G4bd5j9oQ=; b=QhTyCGzMVd3HyrWxivP5SIyCJ3I9n7Zr9fLTH9jDUm9mguYkYHOz9yd/6ke7TQRUZGKs40xhm 34BRdv5LrO5BoLyge7Qs/ePpGM3uzM7E+ohnmIcWgnim6inJ7+Ag2Na
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

prtd_tx and prtd_rx members are not used anymore and only qmc_chan
member remains so struct qmc_dai_chan has become pointless.

Use qmc_chan directly and drop struct qmc_dai_chan.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Herve Codina <herve.codina@bootlin.com>
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


