Return-Path: <linux-kernel+bounces-796475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416CAB4011D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC9F4E52AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0982DAFD8;
	Tue,  2 Sep 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="li2BReH+"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104922D541E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817175; cv=none; b=HIxWw8/dOA55JeDAvocpbgw4Z/eE+vNTAamtHOzfIAaumwctxNcrCz3MkccVCrw56auRuKldkBbP0GkUKzrAXloVuLutn1VDecUh+sXX3QYGdfww5hIlO+tKQNI1vgDtaYDbI+yMqdHUtgi8Sqbq1gOXZu9RRdfhb517mEClqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817175; c=relaxed/simple;
	bh=v/uxCKJdP+2z/SZsRX7qf7nC3a/OLUNE6hFHvBrITqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eCDXfYZtiQkCrf0S3r5gNHkKmctoGpekHwugkIFnSpjwbXATGbu/DJyDgRaJ9yvxg2+7douhrtoM4IKWrOFeGw+05Y8w8zEhCo7ZbHjaILDGh6UtlnlIA2DWv6xmHafWOqPk3ZlK4FwDUZYgW2zy9SLcfPuOMrG+yJX+g582iMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=li2BReH+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3d1bf79d7acso1840386f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756817171; x=1757421971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zO3e10lREs9p/eEtCUsOWQlh8TKJIiFbHYmIoKfi80M=;
        b=li2BReH+E1pcIs3feeQPnCAZZPf7oheRfl3dk3mu+TVex/N1F2jKk6rShlJORpCE9B
         SqNHigthQZQUik0egBjm6dvW7PxsqFC3bE7UI/xbZaztr8O5W46ZQ4bFCtmHSKiWZwgY
         aJvZduD9DOwU648ai3mPFbv6u3Dn9/18REZC8WUSwMFYKGHTHdxGp1c8Q8pC6B0KwV4Y
         NfPK4BCjqIcB0e9qJur1fUXkco0r6ODNxYjJU1KXPX6wn3XAOK9V4iMneXcP54cdpV99
         HKTyEpUJoOpWxzJEUIjSYEqmPA3DGIooY2DELf6gQdrJujTAqZ9nbQyzaqCdbnWSUjmC
         jMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817171; x=1757421971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zO3e10lREs9p/eEtCUsOWQlh8TKJIiFbHYmIoKfi80M=;
        b=Oi2cLuVQOtKUXmU3Xbn/jrinYmJf8KFeiOayXmxJtel1zi8pwo5immvC9V6d+Xce/A
         ElxDhjPLCd05mu/1twpOVJPXFbxMVF28VacFyQgbEJF5SJYHsqCu/92e3T+Kbx4OxSMk
         wZzKIFmPjv35Udax18mFTNMxQHvOXa46I46ujbZxfxQrHFnFDyR840j/n0po1/Sy2ODg
         cf0Ksz6s3FTCGS2pFHxkZmRKXTHPr9CPgYM7MjIF/xqV7MAmqF2bXuckLaOj3iWDiiAe
         LTs2/HxlJvJH8JalSurhY9XxF4eem/IBSDItarIpfsgSUfG2Bt8BE2NQ8B3WeQgn+mn6
         rBWA==
X-Forwarded-Encrypted: i=1; AJvYcCVoxLwUaDnn7fQoXQV/RbSVOKRuAL6SCP/b7zave+aiUKv8aL8XDsQcNNGOQIAfWgbxqAknt8etVSoyOXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJdM63dL1WGjoMekM5x867B7cj9ptWNtW1MO3fNwc4myZnDvU
	FaHSTHz8PfdRXK3DWBK/pkjjFsRVzA+0Hd1YYZSfNpRD+McqztWeKe2JLAWKIunkJfcHBnCalBN
	AyF1tZKM=
X-Gm-Gg: ASbGncu+TCWB0I+0uLt89ylvv+wjLsoZP2KVOmYliOKb9nX+GHvOS0dU8N2xYw31LtW
	onztcrFQZaUJmYbZlrVAijlG3YiHaH6fwMq1akTVZMwM0noi9EU1qWtWpf/nB4+HfecntDs9Fqk
	sncnmQ4ugn4W0rGmhvhV4EDPyIQCO2Ay+wIz7Tyxn35hRxdD/oJGcypHjUEj2TE0teuNe3eJv/2
	9HrkjVB6wuR7CBDKNhd67RFdTIavMWrdd0zxvYjf0l7poYfgxqmVstId70fAZWme1w/M7Qobp0l
	X2D+yOjftisqFh4qLm+hlTnmIxJKGxhiEtlED4gsXj9T0piUUTsGcw4NO+4Uh4a/dvzhwIYfggG
	K5MmRVi/xvAm+53Zm3z9E3epdQRaVHNc8912gj/y9kw==
X-Google-Smtp-Source: AGHT+IFBOztEmu3TQb+b78WlUZhWND4Jix1WfelrhLf0L9O3+fhi7YgD88/+Eg01QZasQk34F4HsBA==
X-Received: by 2002:a05:6000:2112:b0:3d2:6129:5505 with SMTP id ffacd0b85a97d-3d261295a85mr7852150f8f.36.1756817171365;
        Tue, 02 Sep 2025 05:46:11 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm19589896f8f.15.2025.09.02.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:46:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Sep 2025 13:44:57 +0100
Subject: [PATCH v6 5/7] spi: spi-fsl-dspi: Use whole page for DMA buffers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-james-nxp-spi-dma-v6-5-f7aa2c5e56e2@linaro.org>
References: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
In-Reply-To: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

dma_alloc_noncoherent() allocations are backed by a full page anyway, so
use it all.

VF610 devices used to use the full page before commit a957499bd437
("spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode"), but
others still used the FIFO size. After that commit, all devices used the
FIFO size. Now all devices use the full page.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 81d1e4470f94..6bf87ef01c13 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -331,6 +331,8 @@ struct fsl_dspi_dma {
 	dma_addr_t				rx_dma_phys;
 	struct completion			cmd_rx_complete;
 	struct dma_async_tx_descriptor		*rx_desc;
+
+	size_t					bufsize;
 };
 
 struct fsl_dspi {
@@ -493,6 +495,24 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 	return cmd << 16 | data;
 }
 
+static size_t dspi_dma_max_datawords(struct fsl_dspi *dspi)
+{
+	/*
+	 * Transfers look like one of these, so we always use a full DMA word
+	 * regardless of SPI word size:
+	 *
+	 * 31              16 15                   0
+	 * -----------------------------------------
+	 * |   CONTROL WORD  |     16-bit DATA     |
+	 * -----------------------------------------
+	 * or
+	 * -----------------------------------------
+	 * |   CONTROL WORD  | UNUSED | 8-bit DATA |
+	 * -----------------------------------------
+	 */
+	return dspi->dma->bufsize / DMA_SLAVE_BUSWIDTH_4_BYTES;
+}
+
 static size_t dspi_dma_transfer_size(struct fsl_dspi *dspi)
 {
 	return dspi->words_in_flight * DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -620,9 +640,8 @@ static void dspi_dma_xfer(struct fsl_dspi *dspi)
 		/* Figure out operational bits-per-word for this chunk */
 		dspi_setup_accel(dspi);
 
-		dspi->words_in_flight = dspi->len / dspi->oper_word_size;
-		if (dspi->words_in_flight > dspi->devtype_data->fifo_size)
-			dspi->words_in_flight = dspi->devtype_data->fifo_size;
+		dspi->words_in_flight = min(dspi->len / dspi->oper_word_size,
+					    dspi_dma_max_datawords(dspi));
 
 		message->actual_length += dspi->words_in_flight *
 					  dspi->oper_word_size;
@@ -637,7 +656,6 @@ static void dspi_dma_xfer(struct fsl_dspi *dspi)
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 {
-	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
 	struct device *dev = &dspi->pdev->dev;
 	struct dma_slave_config cfg;
 	struct fsl_dspi_dma *dma;
@@ -657,8 +675,10 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
+	dma->bufsize = PAGE_SIZE;
+
 	dma->tx_dma_buf = dma_alloc_noncoherent(dma->chan_tx->device->dev,
-						dma_bufsize, &dma->tx_dma_phys,
+						dma->bufsize, &dma->tx_dma_phys,
 						DMA_TO_DEVICE, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
@@ -666,7 +686,7 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	}
 
 	dma->rx_dma_buf = dma_alloc_noncoherent(dma->chan_rx->device->dev,
-						dma_bufsize, &dma->rx_dma_phys,
+						dma->bufsize, &dma->rx_dma_phys,
 						DMA_FROM_DEVICE, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
@@ -702,11 +722,11 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
+	dma_free_noncoherent(dma->chan_rx->device->dev, dma->bufsize,
 			     dma->rx_dma_buf, dma->rx_dma_phys,
 			     DMA_FROM_DEVICE);
 err_rx_dma_buf:
-	dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
+	dma_free_noncoherent(dma->chan_tx->device->dev, dma->bufsize,
 			     dma->tx_dma_buf, dma->tx_dma_phys, DMA_TO_DEVICE);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
@@ -721,21 +741,20 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 
 static void dspi_release_dma(struct fsl_dspi *dspi)
 {
-	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
 	struct fsl_dspi_dma *dma = dspi->dma;
 
 	if (!dma)
 		return;
 
 	if (dma->chan_tx) {
-		dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
+		dma_free_noncoherent(dma->chan_tx->device->dev, dma->bufsize,
 				     dma->tx_dma_buf, dma->tx_dma_phys,
 				     DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
-		dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
+		dma_free_noncoherent(dma->chan_rx->device->dev, dma->bufsize,
 				     dma->rx_dma_buf, dma->rx_dma_phys,
 				     DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);

-- 
2.34.1


