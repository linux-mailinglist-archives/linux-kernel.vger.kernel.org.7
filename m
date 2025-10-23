Return-Path: <linux-kernel+bounces-867518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B78C02D34
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58290359614
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BCB34D4F0;
	Thu, 23 Oct 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="i9E0UEkx"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D534C992
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242375; cv=none; b=KLtyGxjh9aOr/3U1k4/g9+/Qj0tdX1fBmemuOjFB9GuWnG7zfPme65tq/zHaYyHgRNCYnR+f62qeFDIgCaArRVTYnzRy3zsayuqnI55163r4+Hp8sFrjNzrp6v4Z7e1LepVSN+wBdABAPZLYEgo1VI2TbxVYpxPIcz+hXDZv+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242375; c=relaxed/simple;
	bh=Rrh/pWH2FUlHdUUjlORE05zGutMOLV+OfzEJrgFk/ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+9GIhiNlxkUb9wOEizahGUUWe1Izz0LOREPESvplRFTBLgqn4NGsGWbPfTilpqxKALNYGz8ZeB47Q1uTEsoyn1/IXb01WCeWGAhi5T7ODIvX7X9WPeDpfGPLw+Cbmsv18cjgCoazPyQEiiTllYaSP7vb1xWSCLYBNyzDtucq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=i9E0UEkx; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33bcf228ee4so1152031a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242373; x=1761847173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAhNnAyRlJ+k8SadU3zB3G7wfuMMC4IwP0K85LfBSkY=;
        b=i9E0UEkxya+XaVPsGrP0JtNptrPsrSDAZ53q7/9bO6rxdgJLkU+9VlE1NUduwhK+qv
         8P6Zl8ccT/nnn30a7d17E6XX4rjjQJheaHxnX37Vjx74S2iPxvc4EHe3vu7VOI9Spn2B
         NxGtxbUfFq3xeAvvlaoxDsyaa34Tn5e58dMTnP27tJl6qW+6gPGDF46sdvKuRiu6i9bo
         l3kPvvnNWvCNZBp34jtpqLLN2q1UEBBzl7xyf0BhaDBZNy2nutH5DPg+PwgMBt+PtgBS
         a7wa/xbt8Te1ebhBJp6Ms0qTavu03ruUMa6AL6ANV8EcJO5HZ8ZmQq6XgUAWBT9FIwfs
         n/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242373; x=1761847173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAhNnAyRlJ+k8SadU3zB3G7wfuMMC4IwP0K85LfBSkY=;
        b=dtvJyeLugFKXzMJL/3V1xiZ9sdl4tx4JUPRYs7LSHfgyg+KA71QsuxiUopz4eGbkLL
         5tXd3nPsa8Txfm47xMHECmRvXAzk9GrDACOFK2nHirBCpRtHKByutEzq2w7bccfuBXNZ
         HED/Yhq8dVG3Bdzr44FAR5YaQUGYHfRlkYIvBxgoMMaLz2Mstd2DIxUQL14EUeEh2gCH
         epUy7cgBJkAoF320jWao7s131Q2eLW+jH0NwWkGZ1HMgOIWOzc/RctR0o6EShbA/tP1e
         LH7wGb8Ig3HqMgDZalfuyzMd/S8gihLfPkauVTrs/SLD7kbwO4UpULrTDEyhEPDt9Rmj
         umuA==
X-Forwarded-Encrypted: i=1; AJvYcCWJz/e3palVGZQ4O1PurDD4CkDneuoFGX3nUwTxGw5oU+544SEQQVZMfHNXL5gt5XDIWs25JjZacV0Z3pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6RUKbSl90SjIBBcCsGjnIKMYE4rXzXHyB80pRgeFFhsSNfrPI
	nihEqsZrCqGQocQWdMI2dQmUYDsNSP/NLm2cNmk8ChfjMecQKkyHkd/SCxkpV6smNls=
X-Gm-Gg: ASbGnctUaaQ2wCFbB5YwyAbDNvZLj3j5mqoT25Y0Uf7Y9VEBJlQl/C489qxn43bq1XI
	TY2y2ll5LyqSa3XHl+FBfXctccPRnLUGpaOZeuQSOPLCGjoTkZAnf865z8MiMCj50SDcG3LNS+F
	2o6M1YTfX8nZzg5Z+EVAEsCyjn347yr6/f2D6SZ/zk6BLtlflVZSd9m76WKlS1Cf2gefebioH3K
	F5twDHBPkZqKeIp3w4VWpLSsyNXqEawtdVfrBWdsq5faiQXk7cl5ZEeU2ue3GXdbjGYxI6Ji3Si
	Al/8q6VSa/w/OchiPMDRyJ77dSr2P+j/9YSFvX02rPqpV7nvcZW39Q82vHDqRHZZCp3pkQGCN9z
	ReyWXh5YqUQYLuJ12utxeAGd/Zzygd90puBR59KLDycGd7eMZSOj5p0/2ng/6o2ZDYalrkU3e2g
	UQAFNGIqjcWI4jI4MamrYatNY=
X-Google-Smtp-Source: AGHT+IFxReVTv/oRMBHe2/GGbvb5RBCKr3lQm/bLqjIeSeFbGb+ib3c+ylwSGN6jx8ccpilEbhjGQw==
X-Received: by 2002:a17:90b:4cce:b0:335:2b15:7f46 with SMTP id 98e67ed59e1d1-33bcf8f75b2mr32365987a91.21.1761242373019;
        Thu, 23 Oct 2025 10:59:33 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:32 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	han.xu@nxp.com
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] spi: fsl-qspi: support the SpacemiT K1 SoC
Date: Thu, 23 Oct 2025 12:59:19 -0500
Message-ID: <20251023175922.528868-8-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023175922.528868-1-elder@riscstar.com>
References: <20251023175922.528868-1-elder@riscstar.com>
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
v2: - A continued line the Kconfig file is now aligned

 drivers/spi/Kconfig        |  3 ++-
 drivers/spi/spi-fsl-qspi.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

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
index a474d1b341b6a..d4b007e8172b2 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -268,6 +268,15 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
 	.little_endian = true,
 };
 
+static const struct fsl_qspi_devtype_data spacemit_k1_data = {
+	.rxfifo = SZ_128,
+	.txfifo = SZ_256,
+	.ahb_buf_size = SZ_512,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
+	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_SKIP_CLK_DISABLE,
+	.little_endian = true,
+};
+
 struct fsl_qspi {
 	void __iomem *iobase;
 	void __iomem *ahb_addr;
@@ -1003,6 +1012,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
 	{ .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
 	{ .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
 	{ .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
+	{ .compatible = "spacemit,k1-qspi", .data = &spacemit_k1_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
-- 
2.43.0


