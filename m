Return-Path: <linux-kernel+bounces-867516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCDCC02D25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB701A68602
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC3D34C9AE;
	Thu, 23 Oct 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="EKnnrikm"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799DF34BA41
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242373; cv=none; b=lJaowIe5EzJJ2R7r30IqH1B1otqLL8nNBEFbYtJVQaW8nEdUv6VRRg2vgw9xDBALXFgerROmDVUFT+PufQbyVw/nwGWoikk+NBGe5+eu/P0xSQ8d/I6gCA6KRyckqa3cbI8aB1dRzFO0Bby5nflZ0iJYFEpcSi2+HQn4l2iFH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242373; c=relaxed/simple;
	bh=EkU2Rug1mgYJi/cmODCWd1WGMqqUFjCxy//sYzWdjcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqA8VRx4iS61w8ybCd8CpL2rw8HnLR4dMPW5pQovXQGjx1iyOANYwCQhZ1kmfE5hXd5r/hWPen6KiPmNPitwUIhT4fYJlDkeKj18kLEZB+W6QpW9kLGxh2Fc0+IGY+52Cpz1Imh+oVFf5yret2/sFxoIqTbqCQuMUI41+jEulqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=EKnnrikm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so877923b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242371; x=1761847171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I05R5wxHah0tP+5XjRF9CvuJmtSK0+imsUvDjfvNbmE=;
        b=EKnnrikmaCfyPdqN2FPhE0tKhl+vsccU2FP79sXfUmkFjuD3zsbtrK+drwT47kaTeQ
         Gr7BAoBBnMTynM1+xqgsLFJDwt7LPKJvDSTinxBnaH9F/mRZj5jCfiUK1vZOxz/8njHW
         EdV/C8oD3bxV+DA7hWMiJmuh635Nng0fyPQcg4hpH1BmSqhC2cL/7+5dg3ngUygt+d+h
         sWAOw8NcK/LUfrrQa3n7/Tpzz6mz5W+I5qciiC3omGAszM+e6ioHG5rDVa+JvKXxaR7q
         5ptmnIiK5pPrP73hPNU7hu0yb3wkvoSP7/+G8MU1fgWykbK7bD9UzBsrn6dKmQb53NMD
         1z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242371; x=1761847171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I05R5wxHah0tP+5XjRF9CvuJmtSK0+imsUvDjfvNbmE=;
        b=j3w6GWe7/T/erA/5B4G+TTPkchliBGlDh2NCPzT8R6u4tedj4KzfE+dxIGF/S0njlo
         pk3wlJ/GwU/kscXCHs217QA6iRqc66c5qMeQidoGARSX661PpPSeWSEl/U3diMci3Frz
         8upM/Vf5CIvWyEzXt0uUEc/3XinTZqSXUSq1u+3m5uEmNm4oJooHr8I9Jc7Va8X70tFJ
         iun7JDlEdXwvXFj3UG8xHA6pedxxYqm7Jh6yY7FpUoMXzxdK403VD13VzKKvpA4EzH34
         rKcFbDZCz9kXcy+S9ImOHdbFjmSuzsXeiv24S0jHPN5Gene6zvsqT2UJndg4jqpS5Whb
         0CYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqHs8s+8ITL4mjhWcPff0kx9GEU+/XWsxHQItETvWPRdIXGvrqzIcvyjqIrZJvLLFndtrwJKK5yV/ik9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE69sg+EM+UAgjZvLf8ZoQXQOnJZPhKoJfehDr2hQC/pFQ4M3j
	2JEqt2xqL3F14d+GJlYrcR3X6aLCbtTZqL8XjUVr+Frf1pjStsXcnNmnatNVauwvCUg=
X-Gm-Gg: ASbGnct+cIYuAoQ4W1Os0On4rmEdtNUBgt/nXh7MK2geonf0vJU2ANXPS/zPQasJzCq
	nnCp7qzMpPx+LxJfk/zrhWLiY5BTLywaiCCE01zHdV/zyMnOxIPxfsKo5DyZ1s+Sc5AoulFbW0X
	d6bd9KUPKXcRlFZbCCX9c35+D7pwKr5rxq+jtpauZ/ra0eKj8calDV0lF97uVsdklhFLdDuuDQu
	ycss0hoxrvKjcct3HR0h08J9TEi6fcu6NA5A1C3zaM9uKsJiAz9FxaeHu8bOIX9GYSF8/C0skUU
	q/hbZEQOVH3JCU1IF7ZOooDGKo/RVXdr3CMeyfTXqdO/0A6yF2VNCIsMGMtE7XRaQLEyMOKUaBB
	ywkWUSLqFRV1vkcC+nUfPMY159lJzT6A2tIE9tTXKcPeeCXzssqGgGcwAovzc7DjfA9IbMYSKoG
	q8OkS+AOW6uOIUuE+o9adr8Y8=
X-Google-Smtp-Source: AGHT+IGoCA5eG9vMTRsnrdRnkF5/ZgcCIYMlzlQVHh845VGO6X+2euBU7KRA6snytjs6NQ8wnUF2RQ==
X-Received: by 2002:a05:6a21:3086:b0:334:a250:5774 with SMTP id adf61e73a8af0-334a852285emr29903456637.11.1761242370937;
        Thu, 23 Oct 2025 10:59:30 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:30 -0700 (PDT)
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
Subject: [PATCH v2 5/9] spi: fsl-qspi: add a clock disable quirk
Date: Thu, 23 Oct 2025 12:59:17 -0500
Message-ID: <20251023175922.528868-6-elder@riscstar.com>
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

The SpacemiT K1 SoC QSPI implementation needs to avoid shutting off the
clock when changing its rate.  Add a new quirk to indicate that disabling
and enabling the clock should be skipped when changing its rate for
operations.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - The quirk flag is now named QUADSPI_QUIRK_SKIP_CLK_DISABLE
    - The predicate now returns bool and is not inline

 drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 1944e63169d36..c21e3804cb032 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -197,6 +197,11 @@
  */
 #define QUADSPI_QUIRK_USE_TDH_SETTING	BIT(5)
 
+/*
+ * Do not disable the "qspi" clock when changing its rate.
+ */
+#define QUADSPI_QUIRK_SKIP_CLK_DISABLE	BIT(6)
+
 struct fsl_qspi_devtype_data {
 	unsigned int rxfifo;
 	unsigned int txfifo;
@@ -306,6 +311,11 @@ static bool needs_tdh_setting(struct fsl_qspi *q)
 	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING);
 }
 
+static inline bool needs_clk_disable(struct fsl_qspi *q)
+{
+	return !(q->devtype_data->quirks & QUADSPI_QUIRK_SKIP_CLK_DISABLE);
+}
+
 /*
  * An IC bug makes it necessary to rearrange the 32-bit data.
  * Later chips, such as IMX6SLX, have fixed this bug.
@@ -536,15 +546,18 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
 	if (needs_4x_clock(q))
 		rate *= 4;
 
-	fsl_qspi_clk_disable_unprep(q);
+	if (needs_clk_disable(q))
+		fsl_qspi_clk_disable_unprep(q);
 
 	ret = clk_set_rate(q->clk, rate);
 	if (ret)
 		return;
 
-	ret = fsl_qspi_clk_prep_enable(q);
-	if (ret)
-		return;
+	if (needs_clk_disable(q)) {
+		ret = fsl_qspi_clk_prep_enable(q);
+		if (ret)
+			return;
+	}
 
 	q->selected = spi_get_chipselect(spi, 0);
 
-- 
2.43.0


