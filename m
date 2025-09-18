Return-Path: <linux-kernel+bounces-823208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C99B85CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B8C162618
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA631065D;
	Thu, 18 Sep 2025 15:50:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BBA3F9FB;
	Thu, 18 Sep 2025 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210636; cv=none; b=OJkECFflX6x9g9tsmoNIUqIIa8DeWLE4L2ZPkXMgdHcQpjw1hQm3nc8j+OP0K+OsWeSrk0tQnmV+fUL6SA7BZU5S/YULW5L3UMQe8129Io3qz1+hvAgJQZCMzg0I1FCAPnA/+9RPEHVvAKWn1SdA+w4Pli8iJvO4tJ4Ah+E4DQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210636; c=relaxed/simple;
	bh=3ueV0+TWEXT+lbHC1mnyBhAYLOCSJuYccHwKxxNUhFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7frbzkxylmwkxcUlsgd5HWA8teOd1r6NyPdQOFRAJ1Z1Cs9/rqs6G1SUiJ010Le6oVRaexYKaKUy40nhLIZjK7QiCq1FpAtSHFsj1cuCcqCGFjPolOWsi2q1HY0SHdPEkaAh0C60GMPi9KuazjhGK/lAQxEhOWNrKImqQHjD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cSKSQ3kppz9sg0;
	Thu, 18 Sep 2025 17:34:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HDEkcH1IVVyx; Thu, 18 Sep 2025 17:34:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cSKSQ2bD1z9sfv;
	Thu, 18 Sep 2025 17:34:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 439198B776;
	Thu, 18 Sep 2025 17:34:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LGlByoGo7Cr9; Thu, 18 Sep 2025 17:34:30 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 76C7A8B767;
	Thu, 18 Sep 2025 17:34:29 +0200 (CEST)
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
Subject: [PATCH RESEND v3 1/4] soc: fsl: qmc: Only set completion interrupt when needed
Date: Thu, 18 Sep 2025 17:34:08 +0200
Message-ID: <40b41b53a26e77a50b3a5f68fcecc6f9a40a84b4.1758209158.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758209158.git.christophe.leroy@csgroup.eu>
References: <cover.1758209158.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758209657; l=3349; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=3ueV0+TWEXT+lbHC1mnyBhAYLOCSJuYccHwKxxNUhFc=; b=7YoDVmchoSPIi4mkTR5smUVwENM9xsvOMPjROEZI9uTWYid5RyMwIeB5cXfTLUQ7gKIPzZfPK woyB7SkM8ZiCdywhXXs3gY5r5gykus9J3L5aR213Bh6Wb4klHtJd3sV
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

When no post-completion processing is expected, don't waste time
handling useless interrupts.

Only set QMC_BD_[R/T]X_I when a completion function is passed in,
and perform seamless completion on submit for interruptless buffers.

Acked-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/soc/fsl/qe/qmc.c | 44 ++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 36c0ccc06151..da5ea6d35618 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -461,9 +461,16 @@ int qmc_chan_write_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
 
 	ctrl = qmc_read16(&bd->cbd_sc);
 	if (ctrl & (QMC_BD_TX_R | QMC_BD_TX_UB)) {
-		/* We are full ... */
-		ret = -EBUSY;
-		goto end;
+		if (!(ctrl & (QMC_BD_TX_R | QMC_BD_TX_I)) && bd == chan->txbd_done) {
+			if (ctrl & QMC_BD_TX_W)
+				chan->txbd_done = chan->txbds;
+			else
+				chan->txbd_done++;
+		} else {
+			/* We are full ... */
+			ret = -EBUSY;
+			goto end;
+		}
 	}
 
 	qmc_write16(&bd->cbd_datlen, length);
@@ -475,6 +482,10 @@ int qmc_chan_write_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
 
 	/* Activate the descriptor */
 	ctrl |= (QMC_BD_TX_R | QMC_BD_TX_UB);
+	if (complete)
+		ctrl |= QMC_BD_TX_I;
+	else
+		ctrl &= ~QMC_BD_TX_I;
 	wmb(); /* Be sure to flush the descriptor before control update */
 	qmc_write16(&bd->cbd_sc, ctrl);
 
@@ -569,9 +580,16 @@ int qmc_chan_read_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
 
 	ctrl = qmc_read16(&bd->cbd_sc);
 	if (ctrl & (QMC_BD_RX_E | QMC_BD_RX_UB)) {
-		/* We are full ... */
-		ret = -EBUSY;
-		goto end;
+		if (!(ctrl & (QMC_BD_RX_E | QMC_BD_RX_I)) && bd == chan->rxbd_done) {
+			if (ctrl & QMC_BD_RX_W)
+				chan->rxbd_done = chan->rxbds;
+			else
+				chan->rxbd_done++;
+		} else {
+			/* We are full ... */
+			ret = -EBUSY;
+			goto end;
+		}
 	}
 
 	qmc_write16(&bd->cbd_datlen, 0); /* data length is updated by the QMC */
@@ -587,6 +605,10 @@ int qmc_chan_read_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
 
 	/* Activate the descriptor */
 	ctrl |= (QMC_BD_RX_E | QMC_BD_RX_UB);
+	if (complete)
+		ctrl |= QMC_BD_RX_I;
+	else
+		ctrl &= ~QMC_BD_RX_I;
 	wmb(); /* Be sure to flush data before descriptor activation */
 	qmc_write16(&bd->cbd_sc, ctrl);
 
@@ -1482,19 +1504,19 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
 
 	/* Init Rx BDs and set Wrap bit on last descriptor */
 	BUILD_BUG_ON(QMC_NB_RXBDS == 0);
-	val = QMC_BD_RX_I;
 	for (i = 0; i < QMC_NB_RXBDS; i++) {
 		bd = chan->rxbds + i;
-		qmc_write16(&bd->cbd_sc, val);
+		qmc_write16(&bd->cbd_sc, 0);
 	}
 	bd = chan->rxbds + QMC_NB_RXBDS - 1;
-	qmc_write16(&bd->cbd_sc, val | QMC_BD_RX_W);
+	qmc_write16(&bd->cbd_sc, QMC_BD_RX_W);
 
 	/* Init Tx BDs and set Wrap bit on last descriptor */
 	BUILD_BUG_ON(QMC_NB_TXBDS == 0);
-	val = QMC_BD_TX_I;
 	if (chan->mode == QMC_HDLC)
-		val |= QMC_BD_TX_L | QMC_BD_TX_TC;
+		val = QMC_BD_TX_L | QMC_BD_TX_TC;
+	else
+		val = 0;
 	for (i = 0; i < QMC_NB_TXBDS; i++) {
 		bd = chan->txbds + i;
 		qmc_write16(&bd->cbd_sc, val);
-- 
2.49.0


