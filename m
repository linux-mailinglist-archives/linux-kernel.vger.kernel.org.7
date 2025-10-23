Return-Path: <linux-kernel+bounces-867515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC61FC02D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 691013532B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D491F34C80E;
	Thu, 23 Oct 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Yy3zyUXT"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D54A34B404
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242372; cv=none; b=a7QZUcgjcMGTWFqfa5ypr67K24OGYBrtIfJT6EKiRXWO+qVKjHLdW09WcfZVuGL/McsfXfZ/P6C22Yi5RN+Gxc9FTyHZ/AyBke80GNNEg62JZEXIbMikXjX+/cfi8lPN2jFckzfK0DMrYmYQ0Pd+i/K5HH2+omUd46RmaoOuimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242372; c=relaxed/simple;
	bh=7ez/6EjkIlh33htYKjsePGy3T2mVBjoqatOtR9I8D94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGj/gZ1CqbfNJ+E3/aIkrIgcJpI7yhFdaPIVw+3Q3U/aV4GALOn+RrmvWNG+kvh3sPXk/H/s3q+blYJbyiN8YHTBlkdM6DVUH1VORUKSdX6jknG0P1dO9PQPye/EAJclDkaOP56aYt7NC8eNPRewqQnOkNq+eKie8Fk1HrJwkLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Yy3zyUXT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so1169838a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242370; x=1761847170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpdAYbWvJ67Pq6SWW8TZBr3xHWfsprNvetly1iKihCo=;
        b=Yy3zyUXTi+0e3vmKG2Ui+yTxn2tmKz7PF/q/x5L6n2piFr8kq4CpV9Gp4W9036zQav
         y5NxRSP7pO54xha9gPSM8/nTGJT4uAOSQYyPYnj2p8mhs8X3yHFQOB8F2mb+/SBJJ7G8
         bypFwXrYvpFuYQl0xuxyinQDP95UavbkoFvpQmnZV48nIgKOvGGMxICJRl6UD2yPaKM3
         uLGnsoG9zfPsat25xZO35LufyRdzNq/JnozHuhcGar/fBHUSVjPponG7k6FMRQLlSKqU
         LY1FWKfr/D0FBFdDgfOhEdvAg7QjvD28lKVs3gJApPjxAEmUi7HsUaGRjZLvE+u/OwPL
         c+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242370; x=1761847170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpdAYbWvJ67Pq6SWW8TZBr3xHWfsprNvetly1iKihCo=;
        b=p7Oqm42zWvfaSc++uU1HGEvLnwbSXFkGYvkIftbHC+FM3WtcSCbAKzPHBMiMVyHkbr
         4RugU3QyoGeD4E0m9oTjE4DLeIbyIEZW5BNUrZWUxVt83un0VnqfOiqEvD7368eLWwe3
         6gFuEmYEMOjadfUXvX7NAvsRoA/XK3G1yjdrYubqPG1jd+lVyXuDRT/Gb+Q7X9hsGt6A
         SVUU1CUE4BfdKS+5ZDUEEPX+bsm/O2mkaDa1qfmmWs0m6TkCn+Qty09LjWVEk0sgns6y
         IgvR5sAkLQDjRUgzM6SBxOnkZiGBRyFUBwA1y7IXxaTu56OkOWSp3bi38NiITtt9KLYe
         1h0g==
X-Forwarded-Encrypted: i=1; AJvYcCXL3cUq37Aa2iX0n1SUJzKnc9X+mIZh2jf7hPQI76+KYdzEf6zS1xamuknu0yieAl7oKpvicB24tuOr6TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLw2x2SRTRnGjqM6rYujZ8dge3xxQxFbo3o48oXSJKqhgxzUR1
	PGB++4/I9+EKiTi6w2efJY3wNB/JqF67dZRu2bwZ/roPxAtb3dUdgFwh2hME459L1s4=
X-Gm-Gg: ASbGncsZVzvn4t1aOIGf8XF530oErmNC+u52rR3s4NLyuROJ9OfsDvGtgz+HrMBe/lF
	FdJxAdSDeVVOS92srgaIm0cWnAHbYhou2euBXOXUBoPpq0KvuCSUbzlt9i7Z2t/DptGz/wQRRmS
	SE09BfdNvynm0ZdM/hFWgh0CEiOjt63VFBQU96AqjqE79VzjGmNa5j/1vuuWhnr61dBYwjZur2G
	C5KKPuMgaWp17MAZfbRHqICkvChecZSoHVTBZHmU8NhLPsIiVnJDepW8LMYVMazkViwOz7vycS4
	jjJ8yprMW6GudOCdxoLJU7wzjDWJzhrfiTm3MOOqMtEWnSdPdK1lEignBePYHuKbT08cX0uHaPz
	kC/ytXviN0ieU3TB/bM3VheRnF4fPpV1GQKqueoxw9oifRHrqIOvZ2Mv98M5R9xMDLnvx/cnXYt
	FccZn7e0GlileSzP9BaDeNAJc=
X-Google-Smtp-Source: AGHT+IEsHCRIEchVGl1aiqwGIr3m1P1UsY5mh0aI0l1e28xrZb5I36C7fTVFMh7HosCXyjh0AUoMEw==
X-Received: by 2002:a17:90b:1c0e:b0:32b:6ac0:8633 with SMTP id 98e67ed59e1d1-33bcf8743c0mr34004618a91.16.1761242369714;
        Thu, 23 Oct 2025 10:59:29 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:29 -0700 (PDT)
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
Subject: [PATCH v2 4/9] spi: fsl-qspi: switch predicates to bool
Date: Thu, 23 Oct 2025 12:59:16 -0500
Message-ID: <20251023175922.528868-5-elder@riscstar.com>
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

Change all the needs_*() functions so they are no longer inline, and return
bool rather than int.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - New patch: predicates now return bool type and drop inline

  patch (patch 4).
 drivers/spi/spi-fsl-qspi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 1e27647dd2a09..1944e63169d36 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -276,34 +276,34 @@ struct fsl_qspi {
 	u32 memmap_phy;
 };
 
-static inline int needs_swap_endian(struct fsl_qspi *q)
+static bool needs_swap_endian(struct fsl_qspi *q)
 {
-	return q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN;
+	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN);
 }
 
-static inline int needs_4x_clock(struct fsl_qspi *q)
+static bool needs_4x_clock(struct fsl_qspi *q)
 {
-	return q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK;
+	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK);
 }
 
-static inline int needs_fill_txfifo(struct fsl_qspi *q)
+static bool needs_fill_txfifo(struct fsl_qspi *q)
 {
-	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890;
+	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890);
 }
 
-static inline int needs_wakeup_wait_mode(struct fsl_qspi *q)
+static bool needs_wakeup_wait_mode(struct fsl_qspi *q)
 {
-	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618;
+	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618);
 }
 
-static inline int needs_amba_base_offset(struct fsl_qspi *q)
+static bool needs_amba_base_offset(struct fsl_qspi *q)
 {
 	return !(q->devtype_data->quirks & QUADSPI_QUIRK_BASE_INTERNAL);
 }
 
-static inline int needs_tdh_setting(struct fsl_qspi *q)
+static bool needs_tdh_setting(struct fsl_qspi *q)
 {
-	return q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING;
+	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING);
 }
 
 /*
-- 
2.43.0


