Return-Path: <linux-kernel+bounces-817631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABF7B584BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6B27B29B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFD9312804;
	Mon, 15 Sep 2025 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtEDg8Ik"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61C2C11ED
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961465; cv=none; b=cVeWAF1dpcOdrHm2MeLwu2oi+4FVUsBWIW60W6EWyuuBuxnBXCrrmF2mkjvHt8sUjX0JQEx16mdHcRe0P01JgEF7W7Tr2E71TQ7/mzArdrVtOvVXpAYFWp/UR2LAICSe7n2OIlZAe6mQjQ+e3hhw2basfZY2b+R5Gnf4+yaFgOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961465; c=relaxed/simple;
	bh=L+M1ZzECWc7o27mlJQWYs2Ncc6khfKdpycbHvgVp5i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIfL36NOk5/XZ16xpAcI39DEht9fcjdxKn3fKwydnvXAEqKaX8/H4G8Ahp7CXXohr+381LwhHAJzxMkdBSkF5pNYJSq/lmSwLVUbrtlaGR/hOMF/cpJQlcXueAGZxMa6UTkA5lLgaB9GjC5u2/38uSewWXZ8VyNxtEIVZSTnWR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtEDg8Ik; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0411b83aafso682478266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961462; x=1758566262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwqKiH/y6X4L1jh+XrSa2jKjNfRnZ7Plhu44ecA68uk=;
        b=WtEDg8IkAb2qr3DLCqHwItwBE5o60JV8FWkmdkk8iEddyQ4gKDNm39Y22J/HjWC7P6
         gD6JR3dp6LvjeRz5xyUK/JU1ofB2L3506tCERif8ILHa0uG2Bwy+iFtY40N3IxdVhlnc
         roYueLE+BS2xFRuTgV5zYrPiaQG1R6Xz5Q9lC0Z1UfMW7ZshopPXIsX4o+0Nv58r5wea
         JoY+iyg9nxiyvke0qyY9k10MbZjZej7231luRqFocz0ylIZgq9FpzKmPoxBwLocufRsz
         7NqoZ3Un5TxcMfb+8YJJyoLLvL5R7Tw5+RYzeHVQ2NY/d99pz2xFWaDJDYQiEzQRdkU+
         nWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961462; x=1758566262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwqKiH/y6X4L1jh+XrSa2jKjNfRnZ7Plhu44ecA68uk=;
        b=EG4Ke4vfTg2fz8jPX+B6Ibburko/AP0aemqfxbu3htH6XPyRFHe8rO4ecyBl8Lvoaq
         3/YNb6ez7M2wA+fvU+OJafjzPvTYtGIcUEUy6B0dp4jMAJdwbWXT+ffeiYK0I1JA/0VZ
         ycfnQ4zCpDw9r+XkhvJt5V0mEmRSM+0+dhixL2L1WePBOQD5S9Rsc421PE8erTGXYBQK
         o/CHcYajyNrwQbBGzV4/oBUI4SQ/B9Lw5erb+UlYQ0IOayzjBcXbQO3tJTsJGexGQ7my
         916qJ1C1J0YyeJCy3T4+pQqgly/t1yI3nEmNUMAEYOGrCM+SrQ1MiSuLl9WPpkoMe94e
         CTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRAZv3nPSLwYhZXYmNpvQmMNEBHxKzn9Z4Ex/xsTtSDyn0kEuFTswL3aM3ceSXAIopWuRzUpLDWsIpJxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjG3rbCU+g8z7Hs0hH2lRbsdwPXLlk3Mv/QaeWVw7VIrkkE4CE
	+b6yBQkqh5RC4nKwxzJ0zPkJil9euVODludWWbXzdeDV3QYA3vI5Bqe8moQDnQ==
X-Gm-Gg: ASbGncslxbswWlqbV57uo5JrYFLuA7hbrcsxJ7hU2144G0LAbzrY3bQ14NkgBA6R45U
	b//yORDeVSC3fnr/No3hdqym1/BjARZ69Z7p0N1HYavHdFSIAO7ZDANWtJrWocBR9Jtk+gwpD95
	CEo063Z5COOfIWGQ2Z5Qq8B48VpU+BM1G2DlFfuXKRsPhcRSHb9285Wd0BpUnJbqcfOJFZKwsgC
	6L7Rr1YVsyaE+b7lvE0wzKdebAtAmK/QeWdgPJ1JF3mPtmL7jTr3HQaKLOukuOXiqTOWD3ke+HT
	Gb6J2/O3zaYGzYL1vYkLrhg82r/wd4CPrsc8c64JznrR9V4kZ0TilZ/fCJwzFue5Ns9JVDtPZ0o
	5Py6XVS5bRB7ec8IXpGXcmfGdYU8ZYrSFHl2QS1yZo2DgABhxQXd9H2gLvbHdRR9fUuhCCQA6aK
	gjRkI=
X-Google-Smtp-Source: AGHT+IGANoiEWAPfOY4jgzmxfgKsGfrxWOlgfv/xUo3QUDJfGt0s9o1t9GE9IutJIpf4+qhMXszSwg==
X-Received: by 2002:a17:907:980a:b0:b04:5b3d:c305 with SMTP id a640c23a62f3a-b07c35722dcmr1465346366b.17.1757961461647;
        Mon, 15 Sep 2025 11:37:41 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f22ddsm1005093266b.88.2025.09.15.11.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:37:41 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 3/7] spi: move unused device CS initialization to __spi_add_device()
Date: Mon, 15 Sep 2025 20:37:21 +0200
Message-ID: <20250915183725.219473-4-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915183725.219473-1-jonas.gorski@gmail.com>
References: <20250915183725.219473-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using spi_device::num_chipselect, initialize unused device CS as invalid
at registration time in __spi_add_device(), and drop it from the
different allocation paths.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Changes v1 -> v2:
* new patch

 drivers/spi/spi.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6598fb862d80..ad965eae9c9f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -703,6 +703,10 @@ static int __spi_add_device(struct spi_device *spi)
 		}
 	}
 
+	/* Initialize unused logical CS as invalid */
+	for (idx = spi->num_chipselect; idx < SPI_CS_CNT_MAX; idx++)
+		spi_set_chipselect(spi, idx, SPI_INVALID_CS);
+
 	/* Set the bus ID string */
 	spi_dev_set_name(spi);
 
@@ -780,14 +784,6 @@ int spi_add_device(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
 
-static void spi_set_all_cs_unused(struct spi_device *spi)
-{
-	u8 idx;
-
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
-		spi_set_chipselect(spi, idx, SPI_INVALID_CS);
-}
-
 /**
  * spi_new_device - instantiate one new SPI device
  * @ctlr: Controller to which device is connected
@@ -823,7 +819,6 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 	WARN_ON(strlen(chip->modalias) >= sizeof(proxy->modalias));
 
 	/* Use provided chip-select for proxy device */
-	spi_set_all_cs_unused(proxy);
 	spi_set_chipselect(proxy, 0, chip->chip_select);
 
 	proxy->max_speed_hz = chip->max_speed_hz;
@@ -2443,8 +2438,6 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		return -EINVAL;
 	}
 
-	spi_set_all_cs_unused(spi);
-
 	/* Device address */
 	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
 						 SPI_CS_CNT_MAX);
@@ -2589,7 +2582,6 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 	strscpy(ancillary->modalias, "dummy", sizeof(ancillary->modalias));
 
 	/* Use provided chip-select for ancillary device */
-	spi_set_all_cs_unused(ancillary);
 	spi_set_chipselect(ancillary, 0, chip_select);
 
 	/* Take over SPI mode/speed from SPI main device */
@@ -2837,7 +2829,6 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	spi_set_all_cs_unused(spi);
 	spi_set_chipselect(spi, 0, lookup.chip_select);
 
 	ACPI_COMPANION_SET(&spi->dev, adev);
-- 
2.43.0


