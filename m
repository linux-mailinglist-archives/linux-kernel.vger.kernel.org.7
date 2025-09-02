Return-Path: <linux-kernel+bounces-796473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C416B40125
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319F87BBAE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2722D9EF5;
	Tue,  2 Sep 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyQfY+5P"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C12D3236
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817172; cv=none; b=LmhWBE16ukJasRcLEdgtD5dzUUoByR4oB4XEPH7P6LPwlEwX4yF9nS9WNklaoknIdq1MwGeAY8SZvulQlI1gnqUvmx7j2tOtDWMHxjWwv0RDqUO6rz8+fwrty7asmTfEqpRYtp5ZgFeOA4rxr3FcJ7w6o3oExirgQZx7ee/lJVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817172; c=relaxed/simple;
	bh=HlSzFDl3cBqzMzO8EjTfysWzT0vHCTcl2hNct32AEQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KI2Q3TXuA1kVzESqctMN+Qlw9TeymTSFCFadmNWcbAhrcPupug7Y5Mox4PXH87uiiCYgjgO+a8MmFHiW9uXe99x63tYykB79bg7nFusZDM2bCCPR/Vup25iUMTj3irB8uqyHUJOT1ZJ/1WLp5ZWZL2w5iEtTYtpKmndbTM8ava4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dyQfY+5P; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3cf991e8c82so2825612f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756817169; x=1757421969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MLNcN+jIwemVKrw3ojUSNaEqKQ1kS6kcZrlQ+5OTVU=;
        b=dyQfY+5Pf80RXVRk/GSd7DF5u2jROkYXpgyJmwHGsdEBwqXjHmOKWFpzVSFeyhj8vA
         Q9mjFoTj5vSzqhvuf3javnZ2YTwV/hDMSslfonRzc0LbDv49dRbQp8KrPLIp/GC6Rgsm
         BwDbj60q6nUaKnvX8Tt1rXWnGuzaEjy2hP4tRuaXnhoR6+Cu0Kz3kEFe4jQ+QkEDCYLc
         mEBSj6N8n4UeM55AsEXKKdefjmfuYYgwPep5wiT0iEULKM7maOt5Nn6b6PReOwsrMLM9
         eaHUzra+mYMGLlfiNqTUIuULIKSgIGjgm6d9ljPcqtwSqfL17pFqLqK1893ZFdtbDxDX
         /c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817169; x=1757421969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MLNcN+jIwemVKrw3ojUSNaEqKQ1kS6kcZrlQ+5OTVU=;
        b=LuRUNbgstj+5paRLHuhCvfXgyAF4d9sQzyOT0hsOb6S59Bzz5Bm6NsX+BhkmVyh90/
         lW8QNoD4NwcyBU/Tj6WDNWdVozf1dW0Z6ZYv4NU58LjSrAjsr3A/Lpv43Ve7CdncuuTf
         ZqYSH9pMP8p7D3RUEB2M8zhB8z/a4R6LjO/Kwt6uugpU8Sc8bqMoqouoDj490vRZ0zRr
         vK5QtPwGDwgYqyGfcf0v0zUliB1nha/kzSW7Ue6laCt3Y6s6UXasXtfs0cMcWiSGhtG4
         X1EP2Ln1ncCJKid1C2DOT3pofpZ8QGeI9wKE4OiHsRgU2WsoiaUSq1DaCtwSCSiN6OYB
         szcg==
X-Forwarded-Encrypted: i=1; AJvYcCXcgmjYbw3SHCLaJ/er/wt89GM2eXkgvdrFL+nZquN/9afCjAIEaRf4xWUOWGRImLRs2HKb5VCaQxGLHzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3uiLK0NdXdQh09ClT0joXbrJW87xvOSJB2SSOoh09X9U+uVp
	wvrLB3r8e5dbhcn8hyGqp1NCrYCLUONZsLXuIYpwwPsUdRH+rT/XJkGuxyqxlLTqs7k=
X-Gm-Gg: ASbGncsJbLf+9dp60lLMRAnm7ctJ87WEXyBAUD07W2KLAztbnc0S1kHU7YitBI8W9YV
	jjoonICYOXXQ9RbQ9nbjwXPw74yT9LU62WPN+zrN0cSiSBztJjyE0u7FHLpYjThbCErX0TF6jqL
	sZJ2ormx0PBfJcfhSk6RTs1K2k1VW4+PMc70pmo1ZQ3xtaUli7MBtaU1VF1jvPFNRCuQh8cVmTv
	BboLaTDsw/nxLY8q7AOAMEub/XNZFK9GZlDTAiwujwsLD/aL+Tiy2T+EddKeOL6S7A1C1kWYT00
	IKDBih7GNdpMGuOHbxyznvK1ZUuYkP7G5oJMVOY/yMFbRCPWMMkwsfHXKj04P1qzlUat9fzE/5m
	18h4xn2Kc46f/uI25B3JHvuU4Of+IlSk=
X-Google-Smtp-Source: AGHT+IHRohpxYfReD2iQh67pxQ7xf/UxQzUzPqez9/ZzutPlA0iGuE6EAUDKZAfe7C8t7lupU0kMpw==
X-Received: by 2002:a05:6000:268a:b0:3d4:2f8c:1d37 with SMTP id ffacd0b85a97d-3d42f8c2014mr8211307f8f.26.1756817169281;
        Tue, 02 Sep 2025 05:46:09 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm19589896f8f.15.2025.09.02.05.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:46:08 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Sep 2025 13:44:55 +0100
Subject: [PATCH v6 3/7] spi: spi-fsl-dspi: Stub out DMA functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-james-nxp-spi-dma-v6-3-f7aa2c5e56e2@linaro.org>
References: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
In-Reply-To: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

In a later commit we'll use dma_alloc_noncoherent() which isn't
stubbed out for builds without CONFIG_DMA_ENGINE and results in the
following build error:

  spi-fsl-dspi.c:(.text+0x644): undefined reference to `dma_free_pages'
  m68k-linux-ld: spi-fsl-dspi.c:(.text+0x67a): undefined reference to `dma_free_pages'

To continue to support devices that only need XSPI mode and so that
randconfig builds work, stub out DMA functionality in the DSPI driver.

Although older parts of the DMA API have their own stubs, it's
intentional that newer parts don't follow the same pattern. Therefore
individual drivers should not compile in calls unless CONFIG_DMA_ENGINE
is set.

Link: https://lore.kernel.org/oe-kbuild-all/202506160036.t9VDxF6p-lkp@intel.com/
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 48054932d517..0baf7e0608f2 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -373,6 +373,8 @@ struct fsl_dspi {
 	void (*dev_to_host)(struct fsl_dspi *dspi, u32 rxdata);
 };
 
+static void dspi_setup_accel(struct fsl_dspi *dspi);
+
 static bool is_s32g_dspi(struct fsl_dspi *data)
 {
 	return data->devtype_data == &devtype_data[S32G] ||
@@ -468,6 +470,16 @@ static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 	return txdata;
 }
 
+/* Push one word to the RX buffer from the POPR register (RX FIFO) */
+static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
+{
+	if (!dspi->rx)
+		return;
+	dspi->dev_to_host(dspi, rxdata);
+}
+
+#if IS_ENABLED(CONFIG_DMA_ENGINE)
+
 /* Prepare one TX FIFO entry (txdata plus cmd) */
 static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
@@ -481,14 +493,6 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 	return cmd << 16 | data;
 }
 
-/* Push one word to the RX buffer from the POPR register (RX FIFO) */
-static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
-{
-	if (!dspi->rx)
-		return;
-	dspi->dev_to_host(dspi, rxdata);
-}
-
 static void dspi_tx_dma_callback(void *arg)
 {
 	struct fsl_dspi *dspi = arg;
@@ -589,8 +593,6 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	return 0;
 }
 
-static void dspi_setup_accel(struct fsl_dspi *dspi);
-
 static void dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
@@ -722,6 +724,18 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 		dma_release_channel(dma->chan_rx);
 	}
 }
+#else
+static void dspi_dma_xfer(struct fsl_dspi *dspi)
+{
+	dspi->cur_msg->status = -EINVAL;
+}
+static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
+{
+	dev_err(&dspi->pdev->dev, "DMA support not enabled in kernel\n");
+	return -EINVAL;
+}
+static void dspi_release_dma(struct fsl_dspi *dspi) {}
+#endif
 
 static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 			   unsigned long clkrate, bool mtf_enabled)

-- 
2.34.1


