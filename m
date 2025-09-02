Return-Path: <linux-kernel+bounces-796476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F28B40126
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33537203E61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2462DC32B;
	Tue,  2 Sep 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJc6m8TQ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C42DA755
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817176; cv=none; b=Nt6/OYAD1LM5ZCnTTB7zkoWONSYwBSnWYo1ZVVLiESqQin9VN77l7C9dtFVqaelt5pzlOiVVcO+UtNpFjDsV2F8MiQNUFAZiiDFu8Q8jwCmiMwQJmZ5H4KKVtZA6CLr1k4s58L+zxjsHcDcfrR+IlPbb6n+VGbkVBmTRyBa8ajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817176; c=relaxed/simple;
	bh=xSF+c1quUfEBbfl25vLH7FmwBetOvWPbpnPjJk15kZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjNeOF6AxEG6TlnsS1Cx4x1tk8Ro2PrIjPfR+almAAJa29QSiQDOA6U5oWNCg8e7EV3IFGrBjMmNzDPBO6jCNfvedDdN9nh6NZHoANFus2Z9G3NnisWYeQxEM909KTZnPuEGlZBsaNu7iuQpeht3al9KIm38cUrjJWX9Gppu4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zJc6m8TQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso1799418f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756817172; x=1757421972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMvtg5Mq6C/ZSIJ0uJaRfjqxGAaFFsi0SLuwvNPDC3w=;
        b=zJc6m8TQ05bQPU2RlNZ8v+6oQyr3Fbe+cf4F4//H1hlMJ35KyqYVR+cXj5HkTq2fHN
         aFogATpc33m0oVEc2lOC7rvHx/2GBwP2QURgMGIDnwd0iU7h4HuuTU6BORPpKLa1VG6z
         LL0g90qAoGibeENia0UQQXVGyxaCTtjBOpzkk273srnbIq1nVCnuTl/Fbe9FCQ5tsVkf
         sNHq/NfuWbb3sv5TzUPOy6VfzkjDbWqNcHpmN1Z5mm9WD1PYM5kDOsPVOeDpAMtpVEQS
         kJ0Ucp074yAi6FgjxNH+1EZEKxMRnzlE5rrDXsYH/h0Cn9GJoPDNYCEpHsDeZuF2FmAv
         d5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817172; x=1757421972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMvtg5Mq6C/ZSIJ0uJaRfjqxGAaFFsi0SLuwvNPDC3w=;
        b=pDu9NTtBS/lMPCuehzh/TxRPrf/RqEXasYq9xhvXRzbJkM1qsFXyL3eOGJB7wkknjo
         8Kq0POYUH+6uxNXFwzjkusTKKbm5P0ZNaeDombH5rayH0baUJm3audD49799XRSkk8vZ
         9Wqy1n5P4QJG2kBMPUzifcPAlvDSL9hegUlhLxBDnxKRljMMRkK+Zrs4GA9PprEQV1RT
         WAQfrGwX1dCpnBoW1rywDX7rhJDNPSR8g50hWHofv75/ysalzP1XVSMqqsAf33NOjQF+
         G9e06Leu4kTCFlz1v5b6MLiTh+tnyEJinRMIncEre00dWVEsro5oK1pDIrtkM1nJtm9B
         ssIg==
X-Forwarded-Encrypted: i=1; AJvYcCUGmR+iz/EKjmqvEju/+MIjGt2V+J3VfbEfMr7/VGGH15YVPPhcAmwZVDHumkRm+epmTHRTsXuKzZ+takQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXi+OLIyprafJ8n9bjTwWMc3GROjBmawNOOG9Nq7nzqkvexXwV
	33yFP0uAxpKLgnfmFy9+C0zqw/E6/LCuVnzNJj45IxP+Bs9YR7nY96joIUsxmzCARDU=
X-Gm-Gg: ASbGncsquArT/uRU8HQldQz1JXtRc5UUxMaSjmrtQOkU/7L9kqScBlqu/wYKZi3Q9vn
	j6vrOD/xrrwv8HycEH5IniAKTLeL/kUhPtxUay/XZDt9e8qsl+Z22FnBk0Hj6wnbuSgvfKtByW2
	gaLL3DgAJVAoQ0/nubi0QQ8vQTDjc7r+9C2uDk/BJgP5ZO3dtckyYDGOv8VtKYtiXraYvC0mGnl
	WLn5X1KKPYAWt/krr60hFTM7rZQmmlqYnJOgfGBAg2l9DWR8gPJR8Gp7irR1kgu+dUmd3NvXBD9
	iYwZYMC1eEcwpvZxBZuRREj9VR3sDpWDlhYeew7EH1XzvSrKFOPFRRZw1Noh4wEW6HguF7tLNjH
	FUUJttuSSc+y6eFKQbQMxdIqF/y6pLrE=
X-Google-Smtp-Source: AGHT+IHHnLIfKXefUkGxa5EfKnESKjlVPeyNiNsifBpBQEufQVD811lASeZ0fiPvah3xuHy5ugya8g==
X-Received: by 2002:a05:6000:3110:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-3d1de4bc2e1mr9092247f8f.39.1756817172368;
        Tue, 02 Sep 2025 05:46:12 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm19589896f8f.15.2025.09.02.05.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:46:11 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Sep 2025 13:44:58 +0100
Subject: [PATCH v6 6/7] spi: spi-fsl-dspi: Increase target mode DMA buffer
 size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-james-nxp-spi-dma-v6-6-f7aa2c5e56e2@linaro.org>
References: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
In-Reply-To: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

When the device is configured as a target, the host won't stop sending
data while we're draining the buffer which leads to FIFO underflows
and corruption.

Increase the DMA buffer size to the maximum words that edma can
transfer once to reduce the chance of this happening.

In host mode, the driver is able to split up a transfer into smaller
chunks so we don't need to increase the size. While in target mode, the
length of the transfer is determined by the remote host and can be
larger than whatever default buffer size we pick. Keeping the buffer
small in host mode avoids wasting memory, but allocating the largest
possible in target mode gives the lowest possible chance of dropping any
data from the host.

While we could allocate per-transfer using the exact size of the
transfer, 128K is quite a large allocation and there is a chance it
could fail due to memory fragmentation unless it's allocated once at
init time.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 6bf87ef01c13..3d29285c772c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -675,7 +675,18 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
-	dma->bufsize = PAGE_SIZE;
+	if (spi_controller_is_target(dspi->ctlr)) {
+		/*
+		 * In target mode we have to be ready to receive the maximum
+		 * that can possibly be transferred at once by EDMA without any
+		 * FIFO underflows.
+		 */
+		dma->bufsize = min(dma_get_max_seg_size(dma->chan_rx->device->dev),
+				   dma_get_max_seg_size(dma->chan_tx->device->dev)) *
+			       DMA_SLAVE_BUSWIDTH_4_BYTES;
+	} else {
+		dma->bufsize = PAGE_SIZE;
+	}
 
 	dma->tx_dma_buf = dma_alloc_noncoherent(dma->chan_tx->device->dev,
 						dma->bufsize, &dma->tx_dma_phys,

-- 
2.34.1


