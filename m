Return-Path: <linux-kernel+bounces-764661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D785B225BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E233BE6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D53E2EA462;
	Tue, 12 Aug 2025 11:20:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927881A9F8C;
	Tue, 12 Aug 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997637; cv=none; b=AsgOpJWzEjf7VHFURsROBO+CbwrJa6+/GsbMMzTQ+sb/aOIQyq4qVJPnpDvEA2OCkrb8sr+fOd9MEt6qNyZwQCK7+GBWnnnU75+jmi1q+ytoku8MTe8QtzK9EfGoRMHb1h2U4rwWXGxcbmn5lBHOw6Bt+vhKAXof+R+N3JYc/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997637; c=relaxed/simple;
	bh=XfURbicrtINn/6zsJVAuuKOWunGZaLPhKuyOsIyIZX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uN1WcoNB0YIJxIJLeQqJlWEQoSzIsvraZ+nLJb37Gb/ENg2VeyGXTOz3g4u9W7wg8H0GD3HWLclB2n2J09fe/TD1e+SDX8M6xoDIvIfsw7B01s7wLGBRb1Q9XvkxyJ66CBMRPCv+dpknZ10cUySeRVZpitwS0xAb0UIji6nRfBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c1Swb2MHyz9sSN;
	Tue, 12 Aug 2025 12:51:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kerTTt7NRZVH; Tue, 12 Aug 2025 12:51:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c1SwZ5d91z9sSK;
	Tue, 12 Aug 2025 12:51:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AA7BA8B764;
	Tue, 12 Aug 2025 12:51:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ClAnCfTxCmbT; Tue, 12 Aug 2025 12:51:10 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 03CA08B763;
	Tue, 12 Aug 2025 12:51:09 +0200 (CEST)
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
Subject: [PATCH v2 2/4] ASoc: fsl: fsl_qmc_audio: Ensure audio channels are ordered in TDM bus
Date: Tue, 12 Aug 2025 12:50:56 +0200
Message-ID: <8d01cf4599664188c92a515922d68c9834263384.1754993232.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754993232.git.christophe.leroy@csgroup.eu>
References: <cover.1754993232.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754995860; l=2232; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=XfURbicrtINn/6zsJVAuuKOWunGZaLPhKuyOsIyIZX0=; b=YBxguf9SJ+Iqmj02qL4fBifNH7KDTCcS7hy6Imu81/zBTIa3kKCjuwcO9Knmd63YnJxJKvq/X Q/IvZFe9FcrCZqrymZp7kNatPLd0/qa1D0OzNY8vUMKpguQFswGlVuH
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

To reduce complexity of interrupt handling in following patch, ensure
audio channels are configured in the same order as timeslots on the
TDM bus. If we need a given ordering of audio sources in the audio
frame, it is possible to re-order codecs on the TDM bus, no need to
mix up timeslots in channels.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: New
---
 sound/soc/fsl/fsl_qmc_audio.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index 5614a8b909edf..0be29ccc1ff7b 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -791,12 +791,17 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
 			       struct qmc_dai *qmc_dai,
 			       struct snd_soc_dai_driver *qmc_soc_dai_driver)
 {
+	struct qmc_chan_ts_info ts_info;
 	struct qmc_chan_info info;
 	unsigned long rx_fs_rate;
 	unsigned long tx_fs_rate;
+	int prev_last_rx_ts = 0;
+	int prev_last_tx_ts = 0;
 	unsigned int nb_tx_ts;
 	unsigned int nb_rx_ts;
 	unsigned int i;
+	int last_rx_ts;
+	int last_tx_ts;
 	int count;
 	u32 val;
 	int ret;
@@ -879,6 +884,30 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
 				return -EINVAL;
 			}
 		}
+
+		ret = qmc_chan_get_ts_info(qmc_dai->qmc_chans[i], &ts_info);
+		if (ret) {
+			dev_err(qmc_audio->dev, "dai %d get QMC %d channel TS info failed %d\n",
+				qmc_dai->id, i, ret);
+			return ret;
+		}
+
+		last_rx_ts = fls64(ts_info.rx_ts_mask);
+		last_tx_ts = fls64(ts_info.rx_ts_mask);
+
+		if (prev_last_rx_ts > last_rx_ts) {
+			dev_err(qmc_audio->dev, "dai %d QMC chan %d unordered channels (RX timeslot %lu before %lu)\n",
+				qmc_dai->id, i, prev_last_rx_ts, last_rx_ts);
+			return -EINVAL;
+		}
+		if (prev_last_tx_ts > last_tx_ts) {
+			dev_err(qmc_audio->dev, "dai %d QMC chan %d unordered channels (TX timeslot %lu before %lu)\n",
+				qmc_dai->id, i, prev_last_tx_ts, last_tx_ts);
+			return -EINVAL;
+		}
+
+		prev_last_rx_ts = last_rx_ts;
+		prev_last_tx_ts = last_tx_ts;
 	}
 
 	qmc_dai->nb_chans_avail = count;
-- 
2.49.0


