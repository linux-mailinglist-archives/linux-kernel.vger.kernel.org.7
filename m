Return-Path: <linux-kernel+bounces-796474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9826FB40116
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086F31B2469D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B722DAFA4;
	Tue,  2 Sep 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxnWJLCd"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B117A306
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817174; cv=none; b=IRcgPUhBGMsQxn9u3B/HGsJ7J+sTo2pf+14wuferaB29F1B4LXhybgWS6S/1CF2SmrY2zIJAfhaaAopC1UpSqyOctb/VOxohwFc+hTq7TT+q/JrxvKfMBKlYRkpyPQeZumPEkVkJKz1aCh1MGGSN81IsoUG4szgPJTKyTE8bQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817174; c=relaxed/simple;
	bh=dLXhXmGBVUdjGWO7AanK630sMzav+5Mv4ke+Z75scWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwz3epV9TUqmHInRNmHD4sqP/WQbIlfFAGTHg7CL0MjZuheGVJq5Lzqx8E2OaI2RUkODr/30ttpJoB3l4//dmuOBxvMJ/jAxJi9anA8/ucQy3atrMkisGGTVqkPK8PfhkdelMsDfUDFm0MoedSZs91OecxQ+xQs3QyuY0towhsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bxnWJLCd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3d1bf79d75aso1059598f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756817170; x=1757421970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsDT6IfRm3W35zg8rWWkO4jVs26qP9v/JAyh479nlAw=;
        b=bxnWJLCd/QOoTj6TyehjWiDDdYez1E5BGTsF5KROrpkTmqDIHSg8ELJELpDEyaxLo6
         tB//SZ241cApKp+F9glGp4MsTU94TlZTIRC/n5AV6uafo1MEera5/qP6R5QrHu//4y15
         x+MZWL6BCPifW6GiM5OpUL9xvjlnfx4lTmlO6dYTmgzlutKbKCLOV547vmiXSa3Vwjzq
         mQea/1RWZ3PGqOZscHbbyusFfBHrydGPEB+EFhld19Lq0tX+IKUwg0lKrMn0HIdOxVyz
         N+zh87ANdMR01Lai/mTxB7CcTAw1XAKNpqkKwSBA8OWP/NONR9YXbIce09wWMkhrsqpB
         zZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817170; x=1757421970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsDT6IfRm3W35zg8rWWkO4jVs26qP9v/JAyh479nlAw=;
        b=DCc+M9ffDis6w2BtU+XqI6/4b887DbTyaQBp99Gs4GW3Nw3O6Z0v97YxRX3hbjhsol
         wyxnY/3drSou/1tCDyPDtyCsHVcdFfAk5vUvJ+/C3+TRu9flQkdEIEH3A45MlsWmsk5m
         aCVC0lClZyX7H4H/k3wicGW5NS1Q5fKExYJHD/WxKbQNuDu2UCt8sw+WXk1IojMWsiJe
         l+aCT8o7xjJoPGa4SSOvlcoHZXV9xSMci6aCij3IdPKTSf7H3TFMUH5q1dUO2mCZXQ+b
         lHtckZ48C/5eF5j6aD6FgWIHmdabKTphjsXQRS5FCJahpSdcEOPn0N0Vvuy+YJPijo5H
         0vbw==
X-Forwarded-Encrypted: i=1; AJvYcCUYfzI1VMIcoP87xkb5uUKNxT230Sbo/fODLszr55quoKxn4MMYA6DTbefyuu8BXpVh3nuODYqbN2nq52U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYylqhkpat2XqThSaG6RCWK31pXmJGZI+rMcnoPOAs4WfSTi8P
	w8GXsPGBitRMRhzGSoETFos/HaXBewuo/cyv3OhPBYSlBc7JANwKWNB3l5m1ySteA24=
X-Gm-Gg: ASbGnctoiBHxnnhqD0FQlkeiD91qNHKOfA84JT96/POOTLk6lrJNWC7cKbHOHIpgDov
	f8pE8xSi/nlsTVeYDffMAbAmAa8RvKA4Kx6UEsQdEps7p0yZKRwia/oUsvluANfTxH1LRhNGv78
	YtDzovykznkgTY8YLeETYbHWWYDdC895+N8E9zcNd4iqXCmYPtcGSXTVnfV/x+qSgFWHqLaTR1G
	KnGoceLcut7KRxJS94yeKp1MqA5WOanyYe3O2pV3BOZ1hBep1zcqV8L/K38dFSXXGOz8Yhlvuxi
	xHZvyo/sgq5oFoqy6iJvvcW2Hnm7X10XttOvHMsyP35pB5wzNoXHRkl3Lfz5xXGO0pcloaT/f20
	6sF/Zgk63xsavgHBT+HrYhvzoBAqAZWvb8UuJDAlnJg==
X-Google-Smtp-Source: AGHT+IEwUKz3nl2krF2wHyMlpvQhNKTtJiOLQm9e9D7oVD/bUvk+dX6eDVCzpUFwJ4wbqE7UxEr79w==
X-Received: by 2002:a05:6000:2212:b0:3b9:14f2:7edf with SMTP id ffacd0b85a97d-3d1af84bfd1mr7494714f8f.1.1756817170353;
        Tue, 02 Sep 2025 05:46:10 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm19589896f8f.15.2025.09.02.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:46:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Sep 2025 13:44:56 +0100
Subject: [PATCH v6 4/7] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-james-nxp-spi-dma-v6-4-f7aa2c5e56e2@linaro.org>
References: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
In-Reply-To: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.0

Using coherent memory here isn't functionally necessary, we're only
either sending data to the device or reading from it. This means
explicit synchronizations are only required around those points and the
change is fairly trivial.

This gives us around a 10% increase in throughput for large DMA
transfers and no loss for small transfers.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 65 +++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0baf7e0608f2..81d1e4470f94 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -493,11 +493,19 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 	return cmd << 16 | data;
 }
 
+static size_t dspi_dma_transfer_size(struct fsl_dspi *dspi)
+{
+	return dspi->words_in_flight * DMA_SLAVE_BUSWIDTH_4_BYTES;
+}
+
 static void dspi_tx_dma_callback(void *arg)
 {
 	struct fsl_dspi *dspi = arg;
 	struct fsl_dspi_dma *dma = dspi->dma;
+	struct device *dev = &dspi->pdev->dev;
 
+	dma_sync_single_for_cpu(dev, dma->tx_dma_phys,
+				dspi_dma_transfer_size(dspi), DMA_TO_DEVICE);
 	complete(&dma->cmd_tx_complete);
 }
 
@@ -505,9 +513,13 @@ static void dspi_rx_dma_callback(void *arg)
 {
 	struct fsl_dspi *dspi = arg;
 	struct fsl_dspi_dma *dma = dspi->dma;
+	struct device *dev = &dspi->pdev->dev;
 	int i;
 
 	if (dspi->rx) {
+		dma_sync_single_for_cpu(dev, dma->rx_dma_phys,
+					dspi_dma_transfer_size(dspi),
+					DMA_FROM_DEVICE);
 		for (i = 0; i < dspi->words_in_flight; i++)
 			dspi_push_rx(dspi, dspi->dma->rx_dma_buf[i]);
 	}
@@ -517,6 +529,7 @@ static void dspi_rx_dma_callback(void *arg)
 
 static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 {
+	size_t size = dspi_dma_transfer_size(dspi);
 	struct device *dev = &dspi->pdev->dev;
 	struct fsl_dspi_dma *dma = dspi->dma;
 	int time_left;
@@ -525,12 +538,12 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	for (i = 0; i < dspi->words_in_flight; i++)
 		dspi->dma->tx_dma_buf[i] = dspi_pop_tx_pushr(dspi);
 
+	dma_sync_single_for_device(dev, dma->tx_dma_phys, size, DMA_TO_DEVICE);
 	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
-					dma->tx_dma_phys,
-					dspi->words_in_flight *
-					DMA_SLAVE_BUSWIDTH_4_BYTES,
-					DMA_MEM_TO_DEV,
-					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+						   dma->tx_dma_phys, size,
+						   DMA_MEM_TO_DEV,
+						   DMA_PREP_INTERRUPT |
+						   DMA_CTRL_ACK);
 	if (!dma->tx_desc) {
 		dev_err(dev, "Not able to get desc for DMA xfer\n");
 		return -EIO;
@@ -543,12 +556,13 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 		return -EINVAL;
 	}
 
+	dma_sync_single_for_device(dev, dma->rx_dma_phys, size,
+				   DMA_FROM_DEVICE);
 	dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
-					dma->rx_dma_phys,
-					dspi->words_in_flight *
-					DMA_SLAVE_BUSWIDTH_4_BYTES,
-					DMA_DEV_TO_MEM,
-					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+						   dma->rx_dma_phys, size,
+						   DMA_DEV_TO_MEM,
+						   DMA_PREP_INTERRUPT |
+						   DMA_CTRL_ACK);
 	if (!dma->rx_desc) {
 		dev_err(dev, "Not able to get desc for DMA xfer\n");
 		return -EIO;
@@ -643,17 +657,17 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
-	dma->tx_dma_buf = dma_alloc_coherent(dma->chan_tx->device->dev,
-					     dma_bufsize, &dma->tx_dma_phys,
-					     GFP_KERNEL);
+	dma->tx_dma_buf = dma_alloc_noncoherent(dma->chan_tx->device->dev,
+						dma_bufsize, &dma->tx_dma_phys,
+						DMA_TO_DEVICE, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_tx_dma_buf;
 	}
 
-	dma->rx_dma_buf = dma_alloc_coherent(dma->chan_rx->device->dev,
-					     dma_bufsize, &dma->rx_dma_phys,
-					     GFP_KERNEL);
+	dma->rx_dma_buf = dma_alloc_noncoherent(dma->chan_rx->device->dev,
+						dma_bufsize, &dma->rx_dma_phys,
+						DMA_FROM_DEVICE, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_rx_dma_buf;
@@ -688,11 +702,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	dma_free_coherent(dma->chan_rx->device->dev,
-			  dma_bufsize, dma->rx_dma_buf, dma->rx_dma_phys);
+	dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
+			     dma->rx_dma_buf, dma->rx_dma_phys,
+			     DMA_FROM_DEVICE);
 err_rx_dma_buf:
-	dma_free_coherent(dma->chan_tx->device->dev,
-			  dma_bufsize, dma->tx_dma_buf, dma->tx_dma_phys);
+	dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
+			     dma->tx_dma_buf, dma->tx_dma_phys, DMA_TO_DEVICE);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
 err_tx_channel:
@@ -713,14 +728,16 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 		return;
 
 	if (dma->chan_tx) {
-		dma_free_coherent(dma->chan_tx->device->dev, dma_bufsize,
-				  dma->tx_dma_buf, dma->tx_dma_phys);
+		dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
+				     dma->tx_dma_buf, dma->tx_dma_phys,
+				     DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
-		dma_free_coherent(dma->chan_rx->device->dev, dma_bufsize,
-				  dma->rx_dma_buf, dma->rx_dma_phys);
+		dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
+				     dma->rx_dma_buf, dma->rx_dma_phys,
+				     DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);
 	}
 }

-- 
2.34.1


