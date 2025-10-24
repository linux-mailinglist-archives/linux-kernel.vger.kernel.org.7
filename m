Return-Path: <linux-kernel+bounces-869434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D53C07E02
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B771C43354
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23912571B9;
	Fri, 24 Oct 2025 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="gDx6Ch5V"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649236C23D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333365; cv=none; b=gRTik+Yv6Wykc3jlm+J/ZBZO7l/XGo8Xc8offtCehIxotTt24E6+f2xMjUejxygGoWqPd5c6N2im/dlyiKE+63fjEoz9JfZgHKVTyL+ihzxy34aHgaC6oj2xfguvUKq5DEC3PDMJL2TUtzl2GBMTr0OI97c0wCgSTmyxK9oL6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333365; c=relaxed/simple;
	bh=fJYpRFRILxdNLkxi4Dero+aiC/WPnQUq9uXWEscfpMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHX3PueEwq++/R8YTuyWITB92a0UCKln3PrGGAATynwz8ctnPSA3PAmSl7r5nG1hmSBBBJu9NR70XvWwrFkDakxbeR6nQXvJ45zAtIDRiSZb6TFsL7tAX3OKSNpuxxNdyouEKx6g9Ql8FwoTgywHPUZwyhj5Hx8Xb2MRpkseoNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=gDx6Ch5V; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88703c873d5so91246939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333363; x=1761938163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPf7dJcoXU9s785ZftOfTSEvtOpAo2Z85GYUpq2DxVw=;
        b=gDx6Ch5Vlq4W6EDixMZzR1n/emhpfUIJe/2o1Bnepgx2nIDGGaCfDHdWW2W2Qq5gGY
         nsFGf2jQPOLnCIWAwGqJSHkyuav0vzdXhpjNDFTjkIZvqC/U2Lf/fJfyjHxGnUw5CARA
         /8bWsHjDO2FwdgpNUrTXViTeoNOaAvE72Xx+G3eXC58GBXh0oa9JUrY8Ylw+TFQaZOSb
         N71daahTkkpK1+fnF4zZshICDrfo11Q12YQJ96A3J1G0C93N9/z2eFReks9lu2PHZYgD
         ZEENz/jnAIwKgnCxWAypi/3KglqJKwQhS/hh/vb52OqHscPBMQSz7D3pdB+QrnXJAkQu
         7bGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333363; x=1761938163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPf7dJcoXU9s785ZftOfTSEvtOpAo2Z85GYUpq2DxVw=;
        b=ssyT6aWmArspaf0tqsOlUe66GvvV80WA2zDwXuE58fvS7Ep/0asZhkxce9PVDdDhgl
         eGrgq/FyLf2qWfRSO2Z+aPZYs9hinjvyFmDqFScMOa5/h60sYXYIWz8I5/EaNsAEWPC3
         ry9opNDiVo/hR1gaz+FmD+NsLFTD9a0aa0atZbbesQ/WZhTjhvyShyTtXhLESV8BctUI
         r/af4e/k53eXGTo6Cn3JIz0p2vZmdczucML8hFqEisLYCoYEOnm/dERQ+0J54d89DhGY
         tUPcw4jF9N7zaVJIzyub7pMB1EKdaxlYoT9DOSi7FJT3/aVXPakkenk5qQb/Ha9bGFJf
         Z6sw==
X-Forwarded-Encrypted: i=1; AJvYcCV+srZIZDkfUEiAWu+cfDpXgj7j8wG6HlN5ym0xJleyXjipEb2+gfkTXpS+/aXSM04cRJwveTi0KYETTKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXEOf6f+4w2y8StCrgTd3ccJii2hWC74PJg1BT/vRtPzRyPGAJ
	tpTYj5loJS54VjK7Odx0FFXksDNqnK4D1Aoj5X8Y661HhkjFHnRcMBJOtu42rvGu9tU=
X-Gm-Gg: ASbGnctV9jwghjCEYPQe8cLDUWuPtwOX8scSWvLydWm+LhwmTQ2+Cjdrk4rdMsaySVw
	+fUU0amGKmfJ0ByPBsDXZziPKbXDWCA9kafx4ft+SAgoQ17fx7oIt9LYiNBO7dHP4FKfM/kceIY
	L9yTxuW8DBpOhzqIXmV+eIivsXEd2FusfI1yc652Zxq7Ukyb1H0BPKRvft60hJcgAxMeHfQVxxq
	+MnR/kkFG1W+92Y/tnrKru6yNGjq2C9sG7WWyR08KhJtyuGcqGgxqBBKrMqNRr9UvT+rxecDIkp
	WgxdA4GJR5YecmY0FBebTUTlj4jvvnyneuBuH04u38Wss2xavxbLfO4fvCsi/zBqbz3XXUDUhcj
	38NdHa2kjIk6bE6oxVHAjDk+JcfdRzlcFO8GoDWJf4FToSdZi5ycofCXyl1VPcyFsm7AtOe6r10
	0LsyV+PvrgtkUuGMPvZqlaZdSMwDH5dFq9PtnLYeR0OaMdXqNdpUtaRg==
X-Google-Smtp-Source: AGHT+IE7iOHD5RLmA2kk1MvUlsZ0DBgSjQiI4X5X30Jlm6cwRYZovCXte2pXzgLa3TLg4hmhyFE+dg==
X-Received: by 2002:a92:cda3:0:b0:430:b4ca:2696 with SMTP id e9e14a558f8ab-430c514e290mr430965745ab.0.1761333362623;
        Fri, 24 Oct 2025 12:16:02 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:16:02 -0700 (PDT)
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
Subject: [PATCH v3 7/9] spi: fsl-qspi: support the SpacemiT K1 SoC
Date: Fri, 24 Oct 2025 14:15:47 -0500
Message-ID: <20251024191550.194946-8-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251024191550.194946-1-elder@riscstar.com>
References: <20251024191550.194946-1-elder@riscstar.com>
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
v3: The sfa_size field in spacemit_k1_data is now assigned to be SZ_1K

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


