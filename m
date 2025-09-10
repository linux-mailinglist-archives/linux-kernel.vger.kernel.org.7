Return-Path: <linux-kernel+bounces-810919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF12B52182
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70DED188F2B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF862EB5A2;
	Wed, 10 Sep 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6vpSGTo"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6E2DF14F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757534400; cv=none; b=AgADUM9R1pNobT7i4s3fqs3D56jFevJoK+Zybtnd0LQ78OP3Pr/obty7U0uLcyE/K3gCRx9aTvRFDTOsHOsZjGgX2jFS3WX5/UAM2agBrJBHyLsDgTSz/Z/qQ9j1ibKQ7edqFr7/GuCZ9/2eyePiF6S+qec0PdkKaA1zTUWxz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757534400; c=relaxed/simple;
	bh=uBXOGlCMnQlsjVVSJTHl0fyM5k1HHTXNsd7ZIyoRfFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WuXhYG1/HAoMW/6ruH9f/7BGjd2B6KzVTFpRjKC9TJ/LC+GNMBUkzW+voCEmjVHfLpSYiKpEFtGG9G3vtyqrcZ35hygaZKGha4hgnnfbazeUlkkQE7mjiZozY9Iru2jaB862agwq2BMGox2IyhANPgoiwjTm7rddC1+kfEvvzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6vpSGTo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so5793f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757534397; x=1758139197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ng6TDWf6XlZYiajdaz3TZ112Ah6XVvc29LELuzSu4Wo=;
        b=f6vpSGTo1ufZzZA3r7oDXpt2IsxKbBrA9FmVLAF2NX7NrRaFBE/apToMKKHuEAQa6Q
         YrsaH1wGLWdex4rZzxji0apv8Nlap3GNKXR+Ux5+QepftIMQoy2zfGVOAciXKUvjEO+x
         reNvaOy+UDiVD2pJXRsIZIMw+MAkVBnnmPeZY/ib+YmaK8Mq21jUhVFU3IXWxV7q7+pL
         O1YSBMdu35tLSRpvKARWZPn7YaPV1fftFidKlzFdzwsgrdEprHxV6Ht+KLvp+yPh5D83
         G7zIOny9V/PQ4IPeJoYZBeyUCYDmvEQIuic/UYfHJr85xmpUxEPCvAv3Sko6ElAxY1Br
         KG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757534397; x=1758139197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ng6TDWf6XlZYiajdaz3TZ112Ah6XVvc29LELuzSu4Wo=;
        b=Ritx/R89g5WynNX8ICd+HOa0PZYqMC9jRv7K9LZXp7aK2XyGziaicTFybTOtN/zZ0Z
         /K8Ui9lHbiFmaI2I5PBxsq0/eDCIkGTl4J4TRsTSd2zucHS3ZpzLQ8diQmQ8moNLFuCx
         FmnOK51TMd2M059063X4wghePQnr7kP1JUOGOf4OxjFZAx7kq9hdqFBdftrkEnoO3hPa
         kTwyX+8FNakbk5xOAIAoZYmMNIgfWcsWFsuoM1GOxWYG+qCEgim52sk1xWhuyKvzkEWI
         9txFc2lIvppGp7FJkHpZy60D99yRSZefn2Nyl+vc4148gEKx9AHLb7i05+9IM3R4Sefz
         6Xow==
X-Forwarded-Encrypted: i=1; AJvYcCVhLj8BSqYgn038NrzFh43w53SlhHJwng9MWo4CZJRinrAUdB1nhpb1as9wyF6Bf08b976D+ygAJWmNypg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPbyZXDv2qh+wjSwqqXMuYo6/C+f/FzE5eWBzKAWEggob9acoC
	8YGpYmNjadbX58O0A9k+wABUxvRg7NIf40dXcbRrwVDbUg2uzRekRiK6
X-Gm-Gg: ASbGncuK4VLmi8g31TRQc4mUEh9ku3/dwXkDnLJTZUnrMnQxQqen2SKFpABF4e+mOMu
	fbXqzLQMtOkN0QmrPadUM53shWPmr+eGNmc+C+EetNbU+6c9WOVkadK9XItaJlSovaeVqMF32y9
	SMGo74CZictkE3u6+ApsSH0zPksXWrYHbvTddAnDFiPBJaMekwjkXcFfn8oehuxym2oOrq7pJPK
	u8faE9tlNVatzaA3V4XlbcDsznEhYwlAiRkG2Iqf7d6vdX9koAP+s1JvzC0Bl0tlmTDIINAuJPi
	n3gWk7YkHNlLFHZ0mBluT1dU5XV9grsS3NhZTBsKw2e36eraRJSSTq62ZQcWPCYzdp+iZaWVH1a
	PWnRdinuQqypc/kMI1+Tuud0dTaAK
X-Google-Smtp-Source: AGHT+IEUZwFaC1J2bBuG5ahfJdmOHm77RmnVlTVKmGXWf2OqqxuOZ7IqccrUBn6fCuTpw/09PVWvQw==
X-Received: by 2002:a05:6000:2084:b0:3e6:4b2:b9bf with SMTP id ffacd0b85a97d-3e6426e265cmr13549939f8f.24.1757534396405;
        Wed, 10 Sep 2025 12:59:56 -0700 (PDT)
Received: from pc.. ([105.163.1.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75215c51csm8086771f8f.0.2025.09.10.12.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:59:55 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: broonie@kernel.org
Cc: julia.lawall@inria.fr,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] spi: Replace lock/unlock patterns to use guard
Date: Wed, 10 Sep 2025 22:59:49 +0300
Message-ID: <20250910195949.273553-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace lock/unlock patterns with scoped based cleanup
macro.This simplifies the code control flow.

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/spi/spi-fsl-espi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f2f1d3298e6c..eae0fac911de 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -379,9 +379,8 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	fsl_espi_write_reg(espi, ESPI_SPIM, mask);
 
 	/* Prevent filling the fifo from getting interrupted */
-	spin_lock_irq(&espi->lock);
-	fsl_espi_fill_tx_fifo(espi, 0);
-	spin_unlock_irq(&espi->lock);
+	scoped_guard (spinlock_irq, &espi->lock)
+		fsl_espi_fill_tx_fifo(espi, 0);
 
 	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
 	ret = wait_for_completion_timeout(&espi->done, 2 * HZ);
@@ -558,15 +557,13 @@ static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 	struct fsl_espi *espi = context_data;
 	u32 events, mask;
 
-	spin_lock(&espi->lock);
+	guard(spinlock)(&espi->lock);
 
 	/* Get interrupt events(tx/rx) */
 	events = fsl_espi_read_reg(espi, ESPI_SPIE);
 	mask = fsl_espi_read_reg(espi, ESPI_SPIM);
-	if (!(events & mask)) {
-		spin_unlock(&espi->lock);
+	if (!(events & mask))
 		return IRQ_NONE;
-	}
 
 	dev_vdbg(espi->dev, "%s: events %x\n", __func__, events);
 
@@ -575,8 +572,6 @@ static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 	/* Clear the events */
 	fsl_espi_write_reg(espi, ESPI_SPIE, events);
 
-	spin_unlock(&espi->lock);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0


