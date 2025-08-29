Return-Path: <linux-kernel+bounces-791692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF1B3BA33
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601B9566F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E68314A77;
	Fri, 29 Aug 2025 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dUGfsVar"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1884D314B88
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468055; cv=none; b=nC2JAKDWULPVKXR1QwRDHh6Ca50E8YljMExuJSHckylaDkBcFuhDuIwoV5RtltF8fqAt2oJdyF4QdKF3pZjvr38VuMqQJ9LzQyHguLQmvofBRNTnovFmKeLJNlhAFvK6xF5/oB62j8cdUe29qi4PbJyA2Yy9OSRh/lSyKrKvOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468055; c=relaxed/simple;
	bh=S7x0ebfCt523Ls93oeQmD3KMYniINwdLaICZrUxIvQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dyLlSVDHNH4/d42dtotKm0F8l+7YKIpmkfhlTO1WZeFxT5+/dvIq9n3DQmhaUBdvs95dhjcqWq/1TRkUj+b68/oQhJvOqQma1JAzOGnVRi4cwEEc8mjHd+KtVxILST7PawDGsw/DGeFrULKKAKLdA6EMDm+0BALL8RzJSBwJJUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dUGfsVar; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so12385815e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756468051; x=1757072851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8Ff52Eurd3Sg0Fy6ii66kdfUaNx9pjdVhD8AWVlFlc=;
        b=dUGfsVarh9WwpLEtCnQNp794sxlag6qgqgHqnXkHFboB/1DW6OiE4mHoz+N6Wisc8x
         vns7E0MQN+Nq4kKR7aG8v9VvW2rsLrKMT8J+td7Suvu2bTQBfKb59pm5UpeVzLkx5bzD
         Q5Y4K04/IgNQbmnJ7vyzJs390gpumoLuxVx52e5G/EoRBNYeWSS6Vbcg4eh6iV2/zPd8
         W989N1IYKb8TkOaRKzCniYLE/Q6oPHnNwXQKZxo2JSxfSUmJVg3nwsqnQOrXlDngDXmP
         TYp5o/rbXw4XGQX+hSpupmfIfi1WhZKP6y7Uvy9zQO3JT6vC3LGqKpiOiByOCQb5EmGi
         PsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468051; x=1757072851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8Ff52Eurd3Sg0Fy6ii66kdfUaNx9pjdVhD8AWVlFlc=;
        b=brQJ/4mApKxvUZsRDyXxn8amcbaAw3PexnZ+6qLHTn1Io1mBCMh1BCAfGSP2cLr1YQ
         f+468V4fVInVK+lHKWFapRpWbfT3dRhwUhIz6xzVIPcIXkvOZIHJhRu+sehAfJGDzqhL
         p4bhB/QxgeJZOkQmTeR5zlzkuPeoTXg6XdDD7M8JJQ1KMt6Txz5ooqAYJvjJwk/AFDDH
         di/VyGptioEJicKADDBjxhHuI1meQqyFuZ1jJw2+qfaC7vsXV+JcEaf4yreNqjSNg1ro
         OdNDYE05E3OBJziltjJMP/XO6A/kdsrfPBKbgRmJG6KBpeXAYCEn0gpsxWBkoiMcAjN2
         EWiA==
X-Forwarded-Encrypted: i=1; AJvYcCUNEqHqlaYiA4dhg0Sp06xFLEJpHhUlWkFFoDnhRr96Uc7fGrRYstqAxcu4DBelU28d7psnury2LEHjd3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+IMkRcPf2AR3p5DZqURR5c//oy5K9u9QpbPJGlr1U8uidof+
	vQA5DOml4fGLX0QFpN/NlqjNIsvO/bE/wLg0XOVBR0MaAjzVxhB0EZ6LB58VLp1h9m0=
X-Gm-Gg: ASbGnctVDtpH4InlY1QY5BRC4vRqChkvV+oNh4/lVehX6pyUCdCpoRKVggVF0bYf8iv
	ybyiJTf1RVZ981B1/xTM1kXdAcKfVlZdcDUf9VlwI607mM/zyhljWJtUEbrPT1rvyb0YVFhc2fH
	KwIQeZkCvydkK0AJME3IH3Uopy2R5fcHDKScWciaolh+wR9q8SX/Rvsculpq9awOvehnIoiLYkS
	DLi4cWw8Qh+oa99jSep1zvwk563cc+AvMBKAYyEHxGSijjvwZxKQo47eyDBwJQ4lcbvD11mKcTf
	WHneBDJ9CFzrLtyvyySQSHEvsEBIuLqWEk3fVpN9yQsriKfCW8NYlOtSxBEw4Vq6Y48MuF8PMSE
	hkEairWSThV8FgBVnIu6SKWX+AYrdqxiXsJ7DUDmGRtpi3c4Fm3H+
X-Google-Smtp-Source: AGHT+IFz+p3bq6EKzPmfcfC5PMXg5Zav7B1eRrwjjM0k5SgBpuL4bFJbKjkKmesw/qpW53whi0+p4w==
X-Received: by 2002:a5d:64ea:0:b0:3ce:663a:c91f with SMTP id ffacd0b85a97d-3ce663accb0mr3601184f8f.42.1756468051335;
        Fri, 29 Aug 2025 04:47:31 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7c461edasm29873255e9.9.2025.08.29.04.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:47:30 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 29 Aug 2025 12:46:49 +0100
Subject: [PATCH v5 7/7] spi: spi-fsl-dspi: Report FIFO overflows as errors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-james-nxp-spi-dma-v5-7-3246957a6ea9@linaro.org>
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
In-Reply-To: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

In target mode, the host sending more data than can be consumed would be
a common problem for any message exceeding the FIFO or DMA buffer size.
Cancel the whole message as soon as this condition is hit as the message
will be corrupted.

Only do this for target mode in a DMA transfer, it's not likely these
flags will be set in host mode so it's not worth adding extra checks. In
IRQ and polling modes we use the same transfer functions for hosts and
targets so the error flags always get checked. This is slightly
inconsistent but it's not worth doing the check conditionally because it
may catch some host programming errors in the future.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3b652d744492..8dcfd5ea4216 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -480,6 +480,17 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 	dspi->dev_to_host(dspi, rxdata);
 }
 
+static int dspi_fifo_error(struct fsl_dspi *dspi, u32 spi_sr)
+{
+	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
+		dev_err_ratelimited(&dspi->pdev->dev, "FIFO errors:%s%s\n",
+				    spi_sr & SPI_SR_TFUF ? " TX underflow," : "",
+				    spi_sr & SPI_SR_RFOF ? " RX overflow," : "");
+		return -EIO;
+	}
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_DMA_ENGINE)
 
 /* Prepare one TX FIFO entry (txdata plus cmd) */
@@ -553,6 +564,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	struct device *dev = &dspi->pdev->dev;
 	struct fsl_dspi_dma *dma = dspi->dma;
 	int time_left;
+	u32 spi_sr;
 	int i;
 
 	for (i = 0; i < dspi->words_in_flight; i++)
@@ -601,7 +613,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	if (spi_controller_is_target(dspi->ctlr)) {
 		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
-		return 0;
+		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+		return dspi_fifo_error(dspi, spi_sr);
 	}
 
 	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
@@ -1071,6 +1084,10 @@ static void dspi_poll(struct fsl_dspi *dspi)
 		for (tries = 1000; tries > 0; --tries) {
 			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 			regmap_write(dspi->regmap, SPI_SR, spi_sr);
+
+			dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
+			if (dspi->cur_msg->status)
+				return;
 			if (spi_sr & SPI_SR_CMDTCF)
 				break;
 		}
@@ -1086,6 +1103,7 @@ static void dspi_poll(struct fsl_dspi *dspi)
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 {
 	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
+	int status;
 	u32 spi_sr;
 
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
@@ -1094,6 +1112,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
+	status = dspi_fifo_error(dspi, spi_sr);
+	if (status) {
+		if (dspi->cur_msg)
+			WRITE_ONCE(dspi->cur_msg->status, status);
+		complete(&dspi->xfer_done);
+		return IRQ_HANDLED;
+	}
+
 	if (dspi_rxtx(dspi) == false) {
 		if (dspi->cur_msg)
 			WRITE_ONCE(dspi->cur_msg->status, 0);

-- 
2.34.1


