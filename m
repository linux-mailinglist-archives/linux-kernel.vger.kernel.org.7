Return-Path: <linux-kernel+bounces-796471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D701B40139
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C887BB7B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF6B2D9784;
	Tue,  2 Sep 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUb5ZQkM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F942D3EC7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817170; cv=none; b=cg4zLeKTDIICqYB3FAtj99NkWra/r1LAULYfqfskKYkAlOAWp81a76r7JtI0lM+oita+IDMXOkrvsF21c05mm5Sllr0EihSQJxA7mQcXilDcII8gRPkPu1Oqy94LKxHmo+vEAEdTHRm4FDWqjQyJevQTbcRk13QgGBBL5464hck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817170; c=relaxed/simple;
	bh=8/fgw25QdB1ZgzdAKtXHCLtofKXduBfFQhmuMPgookE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBVG812EhkazQ7SmH1PYbQ6MPMG4TxylYb+/Dmqjt0BaYoaupR2zE7Hh8FRE943Zku3zGyK76bd4kyJflLTyYz7qGqMFZx5QGt5l/jjpkc6gcG1OaDIj0ifhHFT+G3lrdiVEaxT2wvtKoQST6mzjJXkUvdarNHF/tO5b9PB4/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WUb5ZQkM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b7c56a987so16861925e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756817167; x=1757421967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5r9IPHLuMKz/CQAQPk4+OYtt68jBsvmpWFMRP88G9KI=;
        b=WUb5ZQkMRb/nX8f2m5X0PRpMMRJu8VSdeLcLLMx/sAKY6k1ta06F2t0JD/BF5X5zZ2
         G0E5SbmWYRUmCbccvh1ySU5zjVNWguy/FLBXXG+zF30OYYH+Ntcu7JlVUtBBcvzMiPje
         Hr5Rn9FIp+fvYb56Mh3kBYYCb5WYRSlc9dT3/vXv9cEDHCzbVckzygWGUPDDTzNtI8cW
         kBJ9xiIa7JBgTThsPu8R9V2zDHOkVY81xu3Kouvpy0OauU24eDPSmNQdvhUCOjcICzCJ
         WkGcM7fXtlpwJW1x/TKmFG1OUwV//a+zSXPXYb7ydsa7g1o0guSTYm+E0zvFs49Z3bXi
         5ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817167; x=1757421967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5r9IPHLuMKz/CQAQPk4+OYtt68jBsvmpWFMRP88G9KI=;
        b=GixgfU+ByE6fdI4grQEpFCsybTmFnNz5n6arf09vLZ4/N2Qv15gTw/cbIOaONPG5T0
         NBXAD9+2QD1R2U17XPE15HCqViJqirpVx25DHwVkZUMHw4BHKQZTD8tYxrlATBkrHD4T
         xlLKtzVz56FjBRA9fzN80CPP5BZHViaA2CyAQy4EGBYVZO60AatvpMwlwKTCYZncLhPX
         NuIrZeshrMbBYrzw3db2ZzR0xAwS9agwk7mpr0qnVZiMSpKW87vHYzVKHj0yEAKSTrdd
         NY+yH8tRs9HQUBzex0EHdYo7H/6ms4bHCP+OBqo0MhNuJByYQjMyU/Sqd4kPNRQq+Ya0
         sIyg==
X-Forwarded-Encrypted: i=1; AJvYcCUD6nFqJIyoeODtRAFWECQt7XIRD0xkRSpW4vLkgSiR8pFBegJgEKS4QJSPrcutx9k6qLTG54KI+qA+OvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIcvyjR20qkkOO3h7BmCNi4FjGCN0vXYULMWN7A1+CodWaXiA
	26zC/IzQ/1XPYdpOjFi6IgnrjOd8cSPg/DGlyERX2i9LpuEB7nN58fxIPCGDMIKxu+8=
X-Gm-Gg: ASbGncsR42EqThu5Fd1tvptXnYtzlV33ZvrjFB+fAV9srpgqd+ma6PM7o69J2JbHd9L
	4B9t75DavM7IZ5j2/1YKg4N1FuS0mAugOpPjqknhem46EVjg5MQKERWxCKxDg/+Fq1dQDY7Zh4D
	uWiUVw3SzZHKO1BshO21Uz9cFf5YLuv+qYR/GZDNjGLDp9A+BawUL4vl6fXIXNkIiVDyuAecjF6
	bBpNYeZ+N8ClSZcCfEjAk8iCjFnJYFQsB8JMpLqdTSC62WcyIQyfvtZ6fjKaVxvwJw07AuSPzdG
	QfDl3eZAtMGs3p3uypU4tIJ6Im0H+4xfWhow51u6sD3sXZ31fWMW0809cjR0cJxHdSG9/6n48d6
	iD0qn9WkWzJqrI+nMLi0W3KGcOmBBE3k=
X-Google-Smtp-Source: AGHT+IFiBte5oIm9wgYp4QL6sXIclbo20jvsZNvWU5oy5exkamtVaSde2J41wTdC4z94mkJWGbNsYw==
X-Received: by 2002:a05:6000:3112:b0:3d1:42dc:c710 with SMTP id ffacd0b85a97d-3d1dcb76607mr9142347f8f.16.1756817167187;
        Tue, 02 Sep 2025 05:46:07 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm19589896f8f.15.2025.09.02.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:46:06 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Sep 2025 13:44:53 +0100
Subject: [PATCH v6 1/7] spi: fsl-dspi: Avoid using -EINPROGRESS error code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-james-nxp-spi-dma-v6-1-f7aa2c5e56e2@linaro.org>
References: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
In-Reply-To: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Refactor dspi_rxtx() and dspi_poll() to not return -EINPROGRESS because
this isn't actually a status that is ever returned to the core layer but
some internal state. Use true/false return value on dspi_rxtx() for this
instead.

This will help separate internal vs external status for the later change
to store the external status directly in cur_msg->status.

No functional changes intended.

Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 4bd4377551b5..654905a358e8 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -986,36 +986,45 @@ static void dspi_fifo_write(struct fsl_dspi *dspi)
 				dspi->progress, !dspi->irq);
 }
 
-static int dspi_rxtx(struct fsl_dspi *dspi)
+/*
+ * Read the previous transfer from the FIFO and transmit the next one.
+ *
+ * Returns false if the buffer to be transmitted is empty, and true if there is
+ * still data to transmit.
+ */
+static bool dspi_rxtx(struct fsl_dspi *dspi)
 {
 	dspi_fifo_read(dspi);
 
 	if (!dspi->len)
 		/* Success! */
-		return 0;
+		return false;
 
 	dspi_fifo_write(dspi);
 
-	return -EINPROGRESS;
+	return true;
 }
 
 static int dspi_poll(struct fsl_dspi *dspi)
 {
-	int tries = 1000;
+	int tries;
+	int err = 0;
 	u32 spi_sr;
 
 	do {
-		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
-		regmap_write(dspi->regmap, SPI_SR, spi_sr);
-
-		if (spi_sr & SPI_SR_CMDTCF)
+		for (tries = 1000; tries > 0; --tries) {
+			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+			regmap_write(dspi->regmap, SPI_SR, spi_sr);
+			if (spi_sr & SPI_SR_CMDTCF)
+				break;
+		}
+		if (!tries) {
+			err = -ETIMEDOUT;
 			break;
-	} while (--tries);
-
-	if (!tries)
-		return -ETIMEDOUT;
+		}
+	} while (dspi_rxtx(dspi));
 
-	return dspi_rxtx(dspi);
+	return err;
 }
 
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
@@ -1029,7 +1038,7 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
-	if (dspi_rxtx(dspi) == 0)
+	if (dspi_rxtx(dspi) == false)
 		complete(&dspi->xfer_done);
 
 	return IRQ_HANDLED;
@@ -1137,9 +1146,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			if (dspi->irq) {
 				wait_for_completion(&dspi->xfer_done);
 			} else {
-				do {
-					status = dspi_poll(dspi);
-				} while (status == -EINPROGRESS);
+				status = dspi_poll(dspi);
 			}
 		}
 		if (status)

-- 
2.34.1


