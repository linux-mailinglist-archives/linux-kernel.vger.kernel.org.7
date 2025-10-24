Return-Path: <linux-kernel+bounces-869431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659F2C07DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17394400BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF2B26ED3C;
	Fri, 24 Oct 2025 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="e4uPgXcK"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533D36B975
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333362; cv=none; b=AHGm064orMRhs8y/JHEs/8T9RqMQB/L2Rx6tFkJ/ETedOlaHlkt9zgUpVQIMkD3j6j16RE87tp48K72rjcdtVxSMmCyn9KBXIgvoBtyu+OrsEYv7QvNIg2a2oKhYbpV4cikFxwdGDqOwkm0EwxjZADXNxPiYKgK3q0Th1J1liAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333362; c=relaxed/simple;
	bh=ywZfSSvOtu1gmb3PxLYzxkGY1zcq4rrHofGqdsSxizM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jp/oxz0C1i/5exReuGADZ9xCZLT4mx2B+Mk2zpImV2PfNXH+GQI3xNXyelifUxN8r1x2X0GGw65wv/EcpausRqajaQgIaJx2elGtM2o/QJKavoetBgNT4qOPf8n1h9W7HqRPmd32rNBdpwX5YVoCXkAQ+vC8Ll6Mg4GoSVuhPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=e4uPgXcK; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-430bf3b7608so23666445ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333359; x=1761938159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whAVJxDDZqUJMj7E4dlz8n3sScKT3peLB8arm+VC5HI=;
        b=e4uPgXcKg3/ncsRYDV/QaU6uM7WfWvx1Q1Qda/tensyL2+Q0+7WVnh7XvBQWVwOrAd
         xkRAD4Gbud6+8S9qWCsP3u3Ek7yR+O5sso3hFTe18zO60jcVS/DGkpa9gRxjsO3q4wuk
         0CVWAhQAp+CaUoUJGu11eazuYF+BpNr3GEm+8PT8rvLIf6KycsFw/cZcPLgVTqgdUvln
         rLcMbLkT9LbG1Lj94Rv35fDTmTcW1xoWnxYxm0MJWe0xdRDVHQEgPta9gUpqCZZIuE6T
         TMnEapCvX+WKdU1qHvAVkRzecjeuHzvHkitzNPMPdVqioDkfpCp3nPucl9xviQ430aC2
         5vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333359; x=1761938159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whAVJxDDZqUJMj7E4dlz8n3sScKT3peLB8arm+VC5HI=;
        b=phkQd5wuoJT9nuaQkoW2nAIkISeUZDKsWrf6J5zH4imdjKKG78ybdebObz8nqrhvY4
         /KakCe8hotd8ExeVMzO3NlhdDNh2nwrykEcHscDSNG5Nmu+SPy3pwey/WT07Ud+FPqGw
         ZtI8OpKDNRucJRG6ZeYDIhJ6duK8LCkH8zui8G26BccH3S2Y2LyHIHKVIoai5OVoR7pG
         oS1fah0/s4FauXJNYH8jZtDcubhEyn+Y+svCTOLrG/AYUMbbwsEGDZASPcjLppn93tpY
         1zuOnvdD/eZ+6nIcAGQOVM4yh8QxcNwJrGJybZCeXHps3oaLgiI0IGO2SS6pHBlTQAuX
         L1ew==
X-Forwarded-Encrypted: i=1; AJvYcCU/3gus3vbfl84nRvcoS1SJTWQumlZ6nuUHK+4CfeXVQofUQpyyfDL7SljJcUIYc+te6d02Oyg2ZluEQFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCS97zWk3BpW/O7GzN8NXD4TwutQfdC6BCcPKV5qOM318zUXN
	o9X8tLWXA70hTAFSFUaFbAja3bbafvIJL6bzWLtYRbQmgxD/iVrY+hVVYmK+nxlMQOE=
X-Gm-Gg: ASbGnctsiqPL9nNCwOEy/Q2VkrtJ7WJlMj75qqo6YrhJjyC2Ea0/nugG5QYoLyQMYFa
	GCr8vnYtK31rnsgf7qLzxq5Jyh9GtkNZHLl/bFuDOylDFU9fwZfpHk4tRZ/ckaxNSr3JVDW3aWI
	FKQMg28KtE5Mrykpc6+wenbuqXRSIsaQvZtI/xMkORx1akzmsSH8WfD8wodrwtwkmJMZk36yunB
	ouQf/+EJ1ZXkPY1wlKnj9uvAEaZ6+AZqhVZXxL8DotNP9uc/clWg14wDKnhsV2FWYQi8eXzBI6o
	CV0FUcd8VrYu0rJXxNfaGO5LiICvlWzWQr9PoEhpgZ7UBc63+irfO0LfFCn7gyYLVYMxVww+ErH
	mhMY4OCAwKQnVtZSljbFoPajQxiBbs4dIbc4wXWOpNHylEAO0gD4PjiE525bCG03p3UjEIjiNKX
	YJipdmw1sM5pKOYXz/p8tvImwrrvahB2uhz3uEr6wdqoPUc86ePRRjRw==
X-Google-Smtp-Source: AGHT+IHX2zRIoMsUD/QzZWZVb8zmLNqKBEZdZKIdnvVZGFa0ldz9lbQJW3juwmiEnXtXUSBt9XGehw==
X-Received: by 2002:a05:6e02:b2b:b0:430:bcef:e0a8 with SMTP id e9e14a558f8ab-430c529fb9amr413408425ab.28.1761333359510;
        Fri, 24 Oct 2025 12:15:59 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:15:59 -0700 (PDT)
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
Subject: [PATCH v3 4/9] spi: fsl-qspi: switch predicates to bool
Date: Fri, 24 Oct 2025 14:15:44 -0500
Message-ID: <20251024191550.194946-5-elder@riscstar.com>
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

Change all the needs_*() functions so they are no longer inline, and return
bool rather than int.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
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
2.48.1


