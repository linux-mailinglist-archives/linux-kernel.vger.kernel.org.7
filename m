Return-Path: <linux-kernel+bounces-791687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4752B3BA28
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224B3169049
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F975314A8B;
	Fri, 29 Aug 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H7k8Nqn7"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527422D97BF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468049; cv=none; b=onpf1Av6zdY2LT+nYnyilEZnULe7WBYGK1NsU6pwXsCcSzK5jjHrVUT1bVD7EcU4yIsUWRBDx9liLnUPhqAn5s1oCg/A4Kx8vAjPIiYxy82S6z35/9wIwlg45GhskjNb0lPt3MOc7sgslKckHrMsvEJx08v+fsWe5BD0c4vFpfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468049; c=relaxed/simple;
	bh=C9oJkV3mHs12c4uHbbNxH2PTvvxlVuP9ivdk16TivuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cb/4IjE1JSw5qrOzhyXSUtphdkC8SycyzFHsLA7G59DPbbgCF+cL2eZSJE3nAVXbtTkinFitcFR31W4MxzR8U5ngz2CHUjaWa1SD8EXW2dnFKpz1Bqh2ioSQLN5IpNJNYrUZO76DoXX30v9LGAy34F39zjzqkptO/55r7YlwVak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H7k8Nqn7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d0dd9c9229so375464f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756468045; x=1757072845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kn8pqlkvI8BkvlrFlfSozqitc0dmKXQH5rpgTQNMM/U=;
        b=H7k8Nqn7oSWOjFdXemMUDl+9DJVoeA+oy/zhCjpX5K3/VnBDEERdOYygZdQgvtrWyi
         g3SLZ+JlQrg9JnbkRVfl4NIUPX+vIEH3FdFAb8Z0ZNxOnZedEB6iqYYIC3sj1gls8p+8
         dvFi9mlVZyh4IcJ0DYGXS/bdvayUiTXdw2QPueqWXuBbB2ZtGSnmKowumF2RNgY9NeH4
         cOODr1wPto/H1CGGPaUAJ0jy6jShlC2BmsmNNVgTqvWvL6yYGvMqWBReJq7NjVaI6n0I
         hsoeDjii/4aYDffeDMQULS3xDbi3cj0xpprauFErUhP6i2+o2FF979tyg7Wiqg0vcuqb
         VZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468045; x=1757072845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kn8pqlkvI8BkvlrFlfSozqitc0dmKXQH5rpgTQNMM/U=;
        b=HAQyWjcL9bi+++WpuFc6VNLWl4YmiqFdBNZ/JxPeJL5UeoUUHcNeSjEBOfTBQvRtIh
         qxxQhfluCYJwZM7LuoM/jrp1+UtwUqpcn1v6JVtNYe7CKgheYYnIetj7cqJkG8DO8qtG
         ArtSgjxbG4LEC8V8N9iJjgZxBxhW5sZZnLxhMu+ui0rt51T3C+9NnOtsKypennr+bIPt
         E+w19QSQZDP6SpkoLwlWP8lxphj14n5QuEKg7jOKDsc2jg/IEXkeqDsZu4Kncgg0OWKu
         PvbXbi/gSIKY5zWNnnyk3kjdnxDxS/N9Uw6ECpLYj0QYlLtRaQfIQY+fH5USRhV/NsLz
         iSxA==
X-Forwarded-Encrypted: i=1; AJvYcCWCbLc9hOd4WVDCjT/idsapixCCAJ4byEUHULN+TOts2tQlOMYQFIcH8DbjM9nkjTTaaO4ZOQEczvoG3Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41s48qme44Jy68u9NEVOx6rn6hVKrZGk2lvtoCTuteWWm3bcN
	b39X3illXZTdfgbj29JcfG2RwE1yx6UGLDjdHE72HmWa7d2P8PQY0e1A8Q5laM6oT1Q=
X-Gm-Gg: ASbGncvAPgcyH2t6AwxmavocdXJjhzPrLUNalcK3Svbqq/c2HpU3D+IlFfL5+rNDxDr
	klX8ysWBvISQPTyZyezvVwCvuXfhC5bP7BUNzxm0fJn+gtChDqiE4t3udAwpJizCD7AX+EJmp8c
	9b+syTvNZlwqMc5epnQ0d9o2KDp2bDDIql4gmi+nlG5ifYw0jKYt37XPiqIyYtRUMIklMbXWnZU
	jFxBFz0IjOQKMIYOxtUEp2/KwhIiJHnbuh/H7v7uXuDD/UnsMPFCzO3hpCGhUTPUMYwBwBExdp2
	SFxReGNrRFd0YJECeTnuiDcBZwF14GJFPH8yO1RvM0PIRovdnfMlYcbndeORQMc6VgxjvnfY8zo
	pqy7UPYbDX2WvsHWp6FsDpQAbCL2bsobs5c6xV1BXQQ==
X-Google-Smtp-Source: AGHT+IGL0ASm2uIQQ/Qffa54YZ9HYmMBFCSp1SC5y1m58lh0NhcYdhBoEVrKo1g6jmgY6sni2jL9PQ==
X-Received: by 2002:a05:6000:2289:b0:3c9:58b0:dad4 with SMTP id ffacd0b85a97d-3c958b0db85mr14887558f8f.35.1756468045401;
        Fri, 29 Aug 2025 04:47:25 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7c461edasm29873255e9.9.2025.08.29.04.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:47:25 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 29 Aug 2025 12:46:44 +0100
Subject: [PATCH v5 2/7] spi: fsl-dspi: Store status directly in
 cur_msg->status
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-james-nxp-spi-dma-v5-2-3246957a6ea9@linaro.org>
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
In-Reply-To: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
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


