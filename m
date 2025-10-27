Return-Path: <linux-kernel+bounces-871684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A21A8C0E116
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D2FB4F5AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DCA303A37;
	Mon, 27 Oct 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="C+PTq+us"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389A2777FC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571829; cv=none; b=LdCxSqukX3B+eAH+96/xXr+SLaK5RDustbdgLA2kPtmNVRRi9El4krw5cq7w4J+vZssLFZPa51PCWOsjLChogMqCOwRWpj9trhBbVzjpSkCYBltF7mc7xFHV7ZrOzFUuAl/PcpiOOn69iT7odshSqrd4JXqqma6vcSoxIpshXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571829; c=relaxed/simple;
	bh=1A6G+O+DOvefLV+rD2dNTlkz0auSGEUbdA/tj/OiN/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhYrObYaQC6xgl9aRGrN6sD2E8+k7rur2tIWWmcnlxVZWFlrZ3D511Ge/xJEWMiAlpIbt4ilhgn1jwibPjXzeuEH4H0CCXdd8ZnUQfNT8Xl8dOduquPBK3+DoqJvRxUY3ncbjj2rDGADqZDzNRXq2erNsjS7plOzQP7/OMFY8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=C+PTq+us; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-430e182727dso20236265ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571827; x=1762176627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Sro30bK07ZDN2ex4WerPYEtaKK8tB8dVPj/Yht/kY4=;
        b=C+PTq+us33ocZqLc7AiwpYUZwFNkrYzgvW2OZuJijFxG1D+CLgu2CY1awGLSr9z/fH
         tFi+ClITaH9Jhf7TmLio2mqcA0muFh7PH2L4psiZ51Pw3VVwK6c3p//SGoVxBP04ZYyf
         9pxULWt8kWNM/nS2/IkPGJMSz7H4JaZmlTbaaEVJmFqw0XImqb4HyoIzrcjvCx2eCEV6
         0d+P2b/DYHmE77LeBTcbYGzDqDUT5mKjH9LkX0+8OvAoh4lsH4cKItMgCcKXOex+9b23
         NdFUJqMiXD+tEklj5PFuSEgGbcy9O8mQldN8243A8ufv97A11hYmUIwX82nLoGZwUzg+
         EaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571827; x=1762176627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Sro30bK07ZDN2ex4WerPYEtaKK8tB8dVPj/Yht/kY4=;
        b=r+Z1Ivr3JpImEXoHc7cldl2SIMhh+nL0y9Hq042E41VQNBypd7nwVOI6iFt94b+eTT
         7rGavea/j40lEPncWPRhnGZtG7tJDOybentKfsQkN3ztMuczkGDyw0LZRjLawMV3QZe1
         TwDo9fl3fxBHNMa2EJknQn1Vtm2gteN18r28mBwe/NTmZt3JVOJvGCMnXhVoNeCPpmtD
         LTB2TzcELpkiXkm44PzU+6cDObTm6rhVgtGsiKbbYtKQ4fQwo9iafJ1g6ktACcFxnbib
         REDWzlsesYRXL/ezBSbMiD5SGw+KDWtAui7niGUVSKx6dBlgLk2ceiT3YEunqAY+eLnt
         Vn/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXb9L0RtFQCAW9DBRLCgNLEYbBATJ7O0bSeAMljsKKAtbYwNoEDd1vxI64t5DllGu+CsOEx+NXT/Q49ac8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EvPPyJrvnVB37h22dpe5q4APrVX2QfM6M8SD5bjWR+3IVp38
	/tlzAUOzMmPy/wTdNZlbT9Wveswm26ShtVmyDZKKyPRytUhlp0dTegYV1ioF92KXxSY=
X-Gm-Gg: ASbGncuupnhAVWIQIyz+rjQC1EAapwEpyjJbYXQqDCtT/ivo2u1Te9vvYUrM8Slbr/b
	zrIB4Vqvz0OgenDrxWIMisLYFvT3S1EUq+BAtctKjQpm0FoMdze80knC5IPU1uJpbTQ6s3LZyJ8
	LljjyKNGYgIPV9qeA4fQKsNbe2OoDkCWLpNuAXyACmYM+U10Zg2Cd/WBKEoD31NUtsXAxcaWkPd
	HLVvKl+4PfpbEeLY0DD8c+6R7gCUJ5OMShSGzIACFD1feqtEqynfWzjeB03v8AdgtKWxj2UYD03
	Z8ByfV//sDHYdkIVmo9fPrXoUx5oHLp53mC79gOygmi1LJGqMrVvpPcHdg9WrZhtNkToqJYOBww
	u3R7UW7oVZNIlcJNYyqzRy87cScBarTT7xG2ALGzGI0DyGzeGRCItVweDtznFYSe4Z6R/okoe6v
	dTQY2+TPdoaVIRt+XAcDsxn2fHLWQJaGsJB3Wf+WzgLwIS1MOjhnjB9A==
X-Google-Smtp-Source: AGHT+IE/dyb28DRdvs9oMw6bZQwYlyqE3BQFW88FuQ4+GtxGKYPnc6qBw31lrQ++KNgKjicl1u85uw==
X-Received: by 2002:a05:6e02:1c2e:b0:42f:a60a:8538 with SMTP id e9e14a558f8ab-4320f778af8mr1256935ab.16.1761571826897;
        Mon, 27 Oct 2025 06:30:26 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:26 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] spi: fsl-qspi: support the SpacemiT K1 SoC
Date: Mon, 27 Oct 2025 08:30:05 -0500
Message-ID: <20251027133008.360237-8-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the SPI_FSL_QUADSPI Kconfig option to be selected if ARCH_SPACEMIT
enabled.

Add support for the SpacemiT K1 SoC in the Freescale QSPI driver by
defining the device type data for its QSPI implementation.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/spi/Kconfig        |  3 ++-
 drivers/spi/spi-fsl-qspi.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4d8f00c850c14..592d46c9998bb 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -435,7 +435,8 @@ config SPI_FSL_LPSPI
 
 config SPI_FSL_QUADSPI
 	tristate "Freescale QSPI controller"
-	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || \
+		   ARCH_SPACEMIT || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This enables support for the Quad SPI controller in master mode.
diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 46a3187b33548..a223b4bc6e637 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -268,6 +268,16 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
 	.little_endian = true,
 };
 
+static const struct fsl_qspi_devtype_data spacemit_k1_data = {
+	.rxfifo = SZ_128,
+	.txfifo = SZ_256,
+	.ahb_buf_size = SZ_512,
+	.sfa_size = SZ_1K,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
+	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_SKIP_CLK_DISABLE,
+	.little_endian = true,
+};
+
 struct fsl_qspi {
 	void __iomem *iobase;
 	void __iomem *ahb_addr;
@@ -1003,6 +1013,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
 	{ .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
 	{ .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
 	{ .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
+	{ .compatible = "spacemit,k1-qspi", .data = &spacemit_k1_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
-- 
2.48.1


