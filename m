Return-Path: <linux-kernel+bounces-796472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 331FCB40135
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0BA97B7F90
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03AA2D97BB;
	Tue,  2 Sep 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmZRKMed"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034962D47FD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817172; cv=none; b=nLzKy7lQ9qp35MQfWs/gs+iZ76+84wPfD8Xc6yPo59klUrpAznHqgvDZqOwg2/uMSjiBL466sGuOzR4OqpETpFELR3lbcvsh0YcuzL98qLNhtCoZNrmJPjfEJfFmQfag+aJPbDZNPYiUG3z1G4+qqzZiW9fw9+10FFtawd8Cu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817172; c=relaxed/simple;
	bh=C9oJkV3mHs12c4uHbbNxH2PTvvxlVuP9ivdk16TivuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UIBGx6g48wznRE8LtpcUHY2umluPCQi8STTrccrm3ZfEOd8ggcDfmy0RdiOyraUQONG1fZYoXPacubh8So+TTaPOrWqIevXdIwnbgwjzhbBKY6P/NO0UlnvMhCRXyC8hV8qL0QiXj7zCU4/se5WvSNAlKLuHKLPKk64SjVwf0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hmZRKMed; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3d19699240dso2185964f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756817168; x=1757421968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kn8pqlkvI8BkvlrFlfSozqitc0dmKXQH5rpgTQNMM/U=;
        b=hmZRKMeddOeB2iSqdWCOzXZDSPwYEy2kc9Ne9sr4fQXBRk1ApyuWlQpBuwiaENjVC8
         3d89NrluwMA9xLxnpCH07qGaG/w1um7GCC8MnfNnt9qKW+BctvqCiENxkTSPt7KMnsmG
         CW+vwHKs1IRA1B2Ju1u5Lj1lBnNWIhBrsJmvvXPoTzkCGanCb1C/o9645OT6nAA+6GMG
         igYm/5XmVcQg5wyqWE5qv56JhBWz6wMsKJzD0edG+2pWrbHkx5NE2wC5pJJHZHyhJqlQ
         x+RjiMtsAW8GTKfBlCz6gSbZnHPPtIa0SSUEIvBYyBKjAFWEODW3eDGA/CgONT8Hmn1g
         ZEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817168; x=1757421968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kn8pqlkvI8BkvlrFlfSozqitc0dmKXQH5rpgTQNMM/U=;
        b=H3ir07hLjPl7WtXTS1FZeFPcBFDGP+OUzqLq07ZM04vE7jWjB+DsfU/tv+tdBY4YUh
         t4EJ7L9e9/Lgl160vbtvR/TbgewXmLMv2PjWqn7ryxed0OqctjiC1vHnCBeE7OYgSSfm
         YKi2nw/hms2v+m7yoMhQcf8t2wukXnFnw9Kv0u8hcSTpbV+sL7sCV+uFW9YKNEUCXY4C
         N2ll4Q+xycCZislPC7EWh1O1eU2PDQo3KLvOdX1PTpDbskjD6Nxwrp5/37kZbTrNePh/
         5cP1a3j1R9ceXQZj13rMPVKpFufxR9MBoTI6bix8EDhD9Vnj9fGEUY+toHJvbzF2Fb4W
         q4xg==
X-Forwarded-Encrypted: i=1; AJvYcCXzuqwp4OvPLuimSxwkHUpoORClSjbn/B2JeG0hYM1Dqm5queFDMdVePGUM5k5fWl9YhnVWWMe/nnXVnsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfPVdDawlXpYbLYKotrrXEuLXeTaO5I5g9dv97iFLJa+han7n6
	vDVqXR3GA2f0VoARSQrroPG0hv0xWbK8wD9h37BjLFJ5msT0FlisyquQCapv280SkB7g4Be0zgW
	nRyDmpBo=
X-Gm-Gg: ASbGnct0FGM2uQu1eB592Vaz4m8E+V/oBYKp+VhG9RJ67A2Fd786cYwu7Q115vxwETF
	tao6if4cP1N7aE4Fb1P+wLDjo3bf55IiOm7prdjsT6HE1/VS21+rFRQbmIp1YfzXE4rbnQFd2Pd
	/QI0Ye4Qq60pn2FXqaCRp7bRwTpN9oue2oleyFXeel1PmS2GwSS785yy/VGujWmO8f8aHZa0a3U
	vyb+JSjerigaodc3AROZ/DhMCYdMMLexqBXzv6Jei4P457B7juVXT0Bn4tJ17OikYRJgOMGJ9vH
	mdVnpt276w+2DN9B5npXdZq3KsFVPtqFI8JkN2jQHyiLXIOlMAd63GPDjqMFcgf1cWzlhAS2ekP
	e2L+ZUg/be8ac3IzA/FN6MaogOFhcyiQ=
X-Google-Smtp-Source: AGHT+IFdtM4/TLGwP6fe/R2gAZvK0+s/idu1aQn5sBDOWhmpmHH0V56Svb4t3Yx0WsS/OmGQzPbJ4w==
X-Received: by 2002:a05:6000:1786:b0:3d0:e221:892e with SMTP id ffacd0b85a97d-3d1df633bedmr8952104f8f.27.1756817168257;
        Tue, 02 Sep 2025 05:46:08 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm19589896f8f.15.2025.09.02.05.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:46:07 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Sep 2025 13:44:54 +0100
Subject: [PATCH v6 2/7] spi: fsl-dspi: Store status directly in
 cur_msg->status
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-james-nxp-spi-dma-v6-2-f7aa2c5e56e2@linaro.org>
References: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
In-Reply-To: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

This will allow us to return a status from the interrupt handler in a
later commit and avoids copying it at the end of
dspi_transfer_one_message(). For consistency make polling and DMA modes
use the same mechanism.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 654905a358e8..48054932d517 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -591,11 +591,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 static void dspi_setup_accel(struct fsl_dspi *dspi);
 
-static int dspi_dma_xfer(struct fsl_dspi *dspi)
+static void dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
 	struct device *dev = &dspi->pdev->dev;
-	int ret = 0;
 
 	/*
 	 * dspi->len gets decremented by dspi_pop_tx_pushr in
@@ -612,14 +611,12 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 		message->actual_length += dspi->words_in_flight *
 					  dspi->oper_word_size;
 
-		ret = dspi_next_xfer_dma_submit(dspi);
-		if (ret) {
+		message->status = dspi_next_xfer_dma_submit(dspi);
+		if (message->status) {
 			dev_err(dev, "DMA transfer failed\n");
 			break;
 		}
 	}
-
-	return ret;
 }
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
@@ -1005,7 +1002,7 @@ static bool dspi_rxtx(struct fsl_dspi *dspi)
 	return true;
 }
 
-static int dspi_poll(struct fsl_dspi *dspi)
+static void dspi_poll(struct fsl_dspi *dspi)
 {
 	int tries;
 	int err = 0;
@@ -1024,7 +1021,7 @@ static int dspi_poll(struct fsl_dspi *dspi)
 		}
 	} while (dspi_rxtx(dspi));
 
-	return err;
+	dspi->cur_msg->status = err;
 }
 
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
@@ -1038,8 +1035,11 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
-	if (dspi_rxtx(dspi) == false)
+	if (dspi_rxtx(dspi) == false) {
+		if (dspi->cur_msg)
+			WRITE_ONCE(dspi->cur_msg->status, 0);
 		complete(&dspi->xfer_done);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1069,7 +1069,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_device *spi = message->spi;
 	struct spi_transfer *transfer;
 	bool cs = false;
-	int status = 0;
 	u32 val = 0;
 	bool cs_change = false;
 
@@ -1129,7 +1128,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				       dspi->progress, !dspi->irq);
 
 		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
-			status = dspi_dma_xfer(dspi);
+			dspi_dma_xfer(dspi);
 		} else {
 			/*
 			 * Reinitialize the completion before transferring data
@@ -1143,13 +1142,12 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 
 			dspi_fifo_write(dspi);
 
-			if (dspi->irq) {
+			if (dspi->irq)
 				wait_for_completion(&dspi->xfer_done);
-			} else {
-				status = dspi_poll(dspi);
-			}
+			else
+				dspi_poll(dspi);
 		}
-		if (status)
+		if (READ_ONCE(message->status))
 			break;
 
 		spi_transfer_delay_exec(transfer);
@@ -1158,7 +1156,8 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			dspi_deassert_cs(spi, &cs);
 	}
 
-	if (status || !cs_change) {
+	dspi->cur_msg = NULL;
+	if (message->status || !cs_change) {
 		/* Put DSPI in stop mode */
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				   SPI_MCR_HALT, SPI_MCR_HALT);
@@ -1167,10 +1166,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			;
 	}
 
-	message->status = status;
 	spi_finalize_current_message(ctlr);
 
-	return status;
+	return message->status;
 }
 
 static int dspi_set_mtf(struct fsl_dspi *dspi)

-- 
2.34.1


