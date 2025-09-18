Return-Path: <linux-kernel+bounces-823211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8319DB85CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E08B16D7AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765652BEC52;
	Thu, 18 Sep 2025 15:50:52 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5AE3148C9;
	Thu, 18 Sep 2025 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210652; cv=none; b=dV+Su4n6r3UhMt9LEWkqfYIm58IFtE+NxecvX/jX1rkPQpt+suLNEDyp21u/LhvLL1E3a4x0vGmdcFZ2iKaXXN3wlruwCh2RuaY0CNjAMGJYuR3uX9qFM4R7wnRLokpA3S3rb4VPyof15pTvUbSX9L95FOJa/lSqtT39R/+HyeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210652; c=relaxed/simple;
	bh=X4wuqoJpWXmIdrxYayEnw6eOSBXb//enGdJw05ySXnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgDQqwyX/5h68zrujTQNHRbpiAbqifO91X0v3mAN1OpogGWEIZ9MIMRTf/elbRbkFNuJAb0mVbzXYd/JZSQ0PkzbKAKx2A6q8BqJPHmI6TAfRveGVdJiyee5oyDZoSMwyTuoURJ0bilD5eKeXwEaOKQEcYZx2hxoA0nreP6nizI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cSKSS1qhmz9sg3;
	Thu, 18 Sep 2025 17:34:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hva2kIU2-6vX; Thu, 18 Sep 2025 17:34:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cSKSS0Z9jz9sg2;
	Thu, 18 Sep 2025 17:34:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E8B178B767;
	Thu, 18 Sep 2025 17:34:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id QD_i62Bf5ayM; Thu, 18 Sep 2025 17:34:31 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 212A18B775;
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
Subject: [PATCH RESEND v3 3/4] ASoC: fsl: fsl_qmc_audio: Only request completion on last channel
Date: Thu, 18 Sep 2025 17:34:10 +0200
Message-ID: <bbd5167d190bbb45c3a4cd6ef2dece8817e0cc1e.1758209158.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758209158.git.christophe.leroy@csgroup.eu>
References: <cover.1758209158.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758209657; l=4994; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=X4wuqoJpWXmIdrxYayEnw6eOSBXb//enGdJw05ySXnk=; b=5i6LXaaOIEGn520Ma2k6jL70nix73aVbzgnhaVpZ96giQjjDNoTQigsFLYRNulLzciRKhomQw T17+p9Jsyw+CV8tEilZBBmbOg7wVXk8HGtmOEUvRzIvM8IgLSuRMana
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

In non-interleaved mode, several QMC channels are used in sync.
More details can be found in commit 188d9cae5438 ("ASoC: fsl:
fsl_qmc_audio: Add support for non-interleaved mode.")
At the time being, an interrupt is requested on each channel to
perform capture/playback completion, allthough the completion is
really performed only once all channels have completed their work.

This leads to a lot more interrupts than really needed. Looking at
/proc/interrupts shows ~3800 interrupts per second when using
4 capture and 4 playback devices with 5ms periods while
only 1600 (200 x 4 + 200 x 4) periods are processed during one second.

The QMC channels work in sync, the one started first is the one
finishing first and the one started last is the one finishing last,
so when the last one finishes it is guaranteed that the other ones are
finished as well. Therefore only request completion processing on the
last QMC channel.

On my board with the above exemple, on a kernel started with
'threadirqs' option, the QMC irq thread uses 16% CPU time with this
patch while it uses 26% CPU time without this patch.

Acked-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 sound/soc/fsl/fsl_qmc_audio.c | 46 +++++------------------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index c0c7ef0a1511..2790953543c5 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -57,7 +57,6 @@ struct qmc_dai_prtd {
 	size_t ch_dma_offset;
 
 	unsigned int channels;
-	DECLARE_BITMAP(chans_pending, 64);
 	struct snd_pcm_substream *substream;
 };
 
@@ -126,17 +125,14 @@ static int qmc_audio_pcm_write_submit(struct qmc_dai_prtd *prtd)
 	int ret;
 
 	for (i = 0; i < prtd->channels; i++) {
-		bitmap_set(prtd->chans_pending, i, 1);
-
 		ret = qmc_chan_write_submit(prtd->qmc_dai->chans[i].qmc_chan,
 					    prtd->ch_dma_addr_current + i * prtd->ch_dma_offset,
 					    prtd->ch_dma_size,
-					    qmc_audio_pcm_write_complete,
-					    &prtd->qmc_dai->chans[i]);
+					    i == prtd->channels - 1 ? qmc_audio_pcm_write_complete :
+								      NULL, prtd);
 		if (ret) {
 			dev_err(prtd->qmc_dai->dev, "write_submit %u failed %d\n",
 				i, ret);
-			bitmap_clear(prtd->chans_pending, i, 1);
 			return ret;
 		}
 	}
@@ -146,20 +142,7 @@ static int qmc_audio_pcm_write_submit(struct qmc_dai_prtd *prtd)
 
 static void qmc_audio_pcm_write_complete(void *context)
 {
-	struct qmc_dai_chan *chan = context;
-	struct qmc_dai_prtd *prtd;
-
-	prtd = chan->prtd_tx;
-
-	/* Mark the current channel as completed */
-	bitmap_clear(prtd->chans_pending, chan - prtd->qmc_dai->chans, 1);
-
-	/*
-	 * All QMC channels involved must have completed their transfer before
-	 * submitting a new one.
-	 */
-	if (!bitmap_empty(prtd->chans_pending, 64))
-		return;
+	struct qmc_dai_prtd *prtd = context;
 
 	prtd->buffer_ended += prtd->period_size;
 	if (prtd->buffer_ended >= prtd->buffer_size)
@@ -182,17 +165,14 @@ static int qmc_audio_pcm_read_submit(struct qmc_dai_prtd *prtd)
 	int ret;
 
 	for (i = 0; i < prtd->channels; i++) {
-		bitmap_set(prtd->chans_pending, i, 1);
-
 		ret = qmc_chan_read_submit(prtd->qmc_dai->chans[i].qmc_chan,
 					   prtd->ch_dma_addr_current + i * prtd->ch_dma_offset,
 					   prtd->ch_dma_size,
-					   qmc_audio_pcm_read_complete,
-					   &prtd->qmc_dai->chans[i]);
+					   i == prtd->channels - 1 ? qmc_audio_pcm_read_complete :
+								     NULL, prtd);
 		if (ret) {
 			dev_err(prtd->qmc_dai->dev, "read_submit %u failed %d\n",
 				i, ret);
-			bitmap_clear(prtd->chans_pending, i, 1);
 			return ret;
 		}
 	}
@@ -202,26 +182,13 @@ static int qmc_audio_pcm_read_submit(struct qmc_dai_prtd *prtd)
 
 static void qmc_audio_pcm_read_complete(void *context, size_t length, unsigned int flags)
 {
-	struct qmc_dai_chan *chan = context;
-	struct qmc_dai_prtd *prtd;
-
-	prtd = chan->prtd_rx;
-
-	/* Mark the current channel as completed */
-	bitmap_clear(prtd->chans_pending, chan - prtd->qmc_dai->chans, 1);
+	struct qmc_dai_prtd *prtd = context;
 
 	if (length != prtd->ch_dma_size) {
 		dev_err(prtd->qmc_dai->dev, "read complete length = %zu, exp %zu\n",
 			length, prtd->ch_dma_size);
 	}
 
-	/*
-	 * All QMC channels involved must have completed their transfer before
-	 * submitting a new one.
-	 */
-	if (!bitmap_empty(prtd->chans_pending, 64))
-		return;
-
 	prtd->buffer_ended += prtd->period_size;
 	if (prtd->buffer_ended >= prtd->buffer_size)
 		prtd->buffer_ended = 0;
@@ -249,7 +216,6 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		bitmap_zero(prtd->chans_pending, 64);
 		prtd->buffer_ended = 0;
 		prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
-- 
2.49.0


