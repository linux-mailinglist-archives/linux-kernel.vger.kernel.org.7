Return-Path: <linux-kernel+bounces-791686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091DDB3BA26
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE7C1669C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF22311C06;
	Fri, 29 Aug 2025 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5UjA0/3"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A472D0C8D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468047; cv=none; b=VQuv/gUG7sG8CrjM9TSWrv7qgqHrWIjNuuv8cwEqr9gS3jT7PeKfhgeDoRuzx0Wb85kCkKCkbTaIykvDAxiGIZCyi9Xdgr3JlYeBKnh40NticF9T56Tby9ct5OAIGH22wUI5S6+w8KcZWDd0yD0MmcK+2dekL6wAajThnhCNpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468047; c=relaxed/simple;
	bh=SJcfNlBFzk+a4oHyKnj5riOiYRcAEXt/WpJ/ZMOki4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dT27PWcMfG0Se0p89xB10NYt7NnmCQ7AV0kd8QfOgF8XxKvtz73eHmCpeo2are1GBl0PV/vjlCWl14woTTKa1JlcoaQTmo63vf4izbr5v1yl7SAoIvb6WveHn27TYi0UBHosKSZmWXZRVWqosjNe03HUTlCJkcbHp3vwL3c7iJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E5UjA0/3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso11615865e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756468044; x=1757072844; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xW+Oe2QcsURx3U6b3nBFCY8yPP0337LLQjhu7L4oQOg=;
        b=E5UjA0/3HEpstfv1SC8oTKbjm7Tz6e2LZJpTPhNXWg//fLYURXwoY1hOekAM+GNvSV
         zd6m5QaACkndDwoLg9CLPm+2TrR1ClACMhtK7t+YQESUHiV2AzJAcB4ClO6hPtj2TvpP
         n0ZkquyWEG5qNVPCZHg8Gy2RJ6Rb9Y+iLg/ciSjzQtGtTC0KqzCb7DtJfRgnxgU4RNaa
         KkQfLOr9flx+c9zU4rDYjt+aGdAQyIimJj0BUS5PTdHedYXYEkfeOfg8vYkcs5NQQjNT
         3BY2BJaRpUiub0qmQmpb0HYz9cNMAk1DX8ReWN2guBCkXV/HvXnFrjdZ58JAFmA+kZWw
         /zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468044; x=1757072844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xW+Oe2QcsURx3U6b3nBFCY8yPP0337LLQjhu7L4oQOg=;
        b=HejA4pXaSdYhkyn5poKCSzL5dbllneOgmtV6i3nYWY4/jb0n8gcyM5atGtO3bpX7Ks
         za7eMvUSCg32VUlZacKJiGa28yHmafAXzo8JApsFAu/nN9lKpNT1m45AJeKdyc1TTP/I
         x4V8QJ1j2YssFdem8aAV5KqCSdX4o0AIsj4DYKd1FE/BAG2neQ1D20f/X14gp0Xd4moF
         rjn8xbvzRP9OM4eQ6QrBLL8Q5YzHaXbfdInym6etMvxR9tfTa+byu3dGiHKBPQgx7cUy
         4JEadTB/EftcVWA5ONrV1xfxiPTw7VVwDN5tapgvE+S2F5hRuDkPIJF0OemGg6Nh6j17
         EXHA==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ymbo02JuKZTOymbVDxamw6SJRJ/QaexH5wVfgI3S4Fhnp/ALFkluPWIFWEC192nJuneOXfmZhai7Y8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIID/Twxfcegx2DiLtOvGb5doCJiDdR2WS8zNACyxtOqay7VB6
	G9YvvxB2co2swpUBnwMrUdJR/HGXLXqXqGYb9CW/z7JOvvQ7V/KgqR2kvBJR9qqJefw=
X-Gm-Gg: ASbGnct2U7cbLXBEf2xOL4feL23wQnfymfLTOVHJwBXJvSr8GZdkP4h6cg30b2sCY2U
	wNNu7/fdjJv/6MbXdGMt0fjng9ExFbbTqLbg/cFxXsazLy3FSCcMa8uFv9A/niLe5bdv1Dm+90q
	oUxbCPluHcyFa6rnR9J6j8J1VvdShNaVlZXlelzMwKKAK1oje9fO2A2zan7T/fIvWhUeRihlIGx
	jE3b03c97/7+Rgzoxibjyqv0N8Y+belWeNFHjfKMocNeE+JeznxOdF06UyoLOPuJirMfVhN9qcR
	m08GrZgO+5Lu9UcDoHdc93bBBySXPevi9rterWGl6Qhctm2peeWLbhzqzHZBXAADeHRWowQDV3X
	Bw9PW4BBRLObrvRzlQy4kOyYInV6rzA8=
X-Google-Smtp-Source: AGHT+IE9+qIKv+jkEpFOA36WurHcVsP6/n5G6O6yYPB6+PEgSMTfb3Bx/lwORRZac4tVlbkSsE5ilw==
X-Received: by 2002:a05:600c:4692:b0:456:1514:5b04 with SMTP id 5b1f17b1804b1-45b517b9636mr214898345e9.21.1756468044084;
        Fri, 29 Aug 2025 04:47:24 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7c461edasm29873255e9.9.2025.08.29.04.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:47:23 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 29 Aug 2025 12:46:43 +0100
Subject: [PATCH v5 1/7] spi: fsl-dspi: Avoid using -EINPROGRESS error code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-james-nxp-spi-dma-v5-1-3246957a6ea9@linaro.org>
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
In-Reply-To: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
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

Signed-off-by: James Clark <james.clark@linaro.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
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


