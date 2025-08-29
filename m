Return-Path: <linux-kernel+bounces-791814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49937B3BC44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E4C167451
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948EB322764;
	Fri, 29 Aug 2025 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixg87rgR"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49D322527
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473241; cv=none; b=YHoJ3usEGExKwVyjkesaA0aSquvncRsX5xSfCdK2/lXO/64SItxHtcSoVNizysqsKJfUM31vo7L0apQeug4VSpTWek7zT0YHyHN/UzOaoz8IFqBnFp/vtb5LATPD9cT3ecUk9O2KFp9m2oBqCXFa0YYkVfDAYDXaDdc7Xo+UUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473241; c=relaxed/simple;
	bh=jEDrWRqVtKULrTucTSLr0n/DeF/H+SMQdH2t6erHpwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhRU8QsIACtFAqYcSoB967Ir+FSmhfkBgJvrozeRutU+6fLFBjKRU28LHxGvKi5CUWBgSR66y8jvuVw29K2QoQu7FdXbcNpjSkwaos2Wc9xqMyE+vbRIg1HhQOODE0uGa5LaPos3urojMAhEGs/6PUScCPyB90RwR3KFvtGF+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ixg87rgR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-333f8d25d33so1007071fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756473237; x=1757078037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FE9Jl8MLsGFXC4bdNsn+0eHbgCcJaZ4UJYq9PxJ9Nrw=;
        b=ixg87rgRVcKadRFH6hrf2zLsYXOOyQFv49peJ0OnnRCToTXNzyG47yQdTgTwY4JMlf
         l81WyqLAooYLKsj7J+KuKmklqZljZ+9yYy3LEtNHag9xkjGjpLxABiB34XquzMF6XPYA
         /PPgSNuDFDz61IZ2eWsoZWHydeKtjY6+Kzgkg4p6UK+mImuLsZJ4/Zl59wXcsG4an4ai
         275UAMoexefvpHOAQ9Psr6RWkf/s/2JBoLwJk6Sq9YN3KlW4wDVAOTs9YOk2+897md+3
         dfjjGNIObZkzxQtlvKN61AsGIx58RuC1JDZlA5Nz70o0dbyHMxhphnsebGYkecPEUccP
         EBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756473237; x=1757078037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FE9Jl8MLsGFXC4bdNsn+0eHbgCcJaZ4UJYq9PxJ9Nrw=;
        b=D2AEX7apUpcwEVo+gWgeJBO8YHM53hW3fyOd1xwQqy6GZVAScgMb/C/7QOlDRfn0nw
         z/o1znV7zoYpGEHGmY/IbUppjYQJHXk8amLC5wviEFZc0sANWP5e7rifuxKszEA2ySg5
         2OrK0HsrT32kWauxKSofplcwEauYExbvOQXYcBXBUO6YBHeOUe329qaaK/9Jf7zeUp9B
         pnbluqJJKmSQxymuMPJiQGbaYq4bQQrDMHRWyX+MZKnIocss7NSkEtVc0A/Okg/g75gP
         ZXLVxvNxHt6ckNtQePN4dW73/hz535EDmulURN72P5oJSR4I4oKN/OCUy92hQ/F46l3R
         2puw==
X-Forwarded-Encrypted: i=1; AJvYcCUEz/0l/qG5Yi92Qn8lsfAyETJH650iYRKHQqp1nxcmRwBSC/49382oyzmcFkPEMRjSBND9Mf/aaeHBXNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLLmMxcUkr0IAaz//Qwyg9Ru0s2m4GirEnx+TLkZlnK4JeRqeM
	C7nL8QxawVlld8JuDJmH9Wr1lGJ8KSLsgHLdCH39nWwyg5TQxJcdjQ2IF4yH9mF7oupAroHa8K2
	IDpm8
X-Gm-Gg: ASbGnctAlrT8wEmuLsQgnVIv0NrU+4/b0/L11z/DH3jgVC+ovhfCejSD6NBXwgBEl2V
	zILJM+lnYHv9HyNZejHYivqihoXxMBOEHA4oUb9R0fTJekjChIgx5beFrlSkZ3DwsNPaDUPsiJ3
	QDjupFq/a5flFs2ePbEVv4VzNLNsay+Kl0T4WUSQJKDEyeIuCUhrGYrUu/DXY+5mIi6qS8h7ax+
	O8mdCVK7pq8FZb9mJt2jhETU3hE9sVyOgTv3azGPaZ3lw9xFgYMl/shBK6Lfaiel+waOlvtdD/U
	U67yW5B3Gex0yXrRUxZViqrb/x7y6or3VwVIhcWA1mai9RpuOF8DlkxGVsIXDNNcl6Iny8iP37S
	doJwbbmWLYwrKxrPoMMLyXz2mGF1Lbg0MUqJaK6+0F8nJdGcqRuchGRjTFLKAPTv9Ah15
X-Google-Smtp-Source: AGHT+IG/8Xqj716iiBt/qchOr1OFGqPi5/74id2OSt/hQJFdA0DdakhT+OcqxRtL9E/IhDxB0ZX1Dg==
X-Received: by 2002:a05:651c:2121:b0:336:a73b:b605 with SMTP id 38308e7fff4ca-336b8da6293mr2896991fa.5.1756473236831;
        Fri, 29 Aug 2025 06:13:56 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-336b489c487sm4641041fa.49.2025.08.29.06.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 06:13:56 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: peter.ujfalusi@gmail.com,
	vkoul@kernel.org,
	nathan@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	benjamin.copeland@linaro.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] dmaengine: ti: edma: Fix memory allocation size for queue_priority_map
Date: Fri, 29 Aug 2025 15:13:46 +0200
Message-ID: <20250829131346.3697633-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a critical memory allocation bug in edma_setup_from_hw() where
queue_priority_map was allocated with insufficient memory. The code
declared queue_priority_map as s8 (*)[2] (pointer to array of 2 s8), but
allocated memory using sizeof(s8) instead of sizeof(s8[2]).

This caused out-of-bounds memory writes when accessing:
  queue_priority_map[i][0] = i;
  queue_priority_map[i][1] = i;

The bug manifested as kernel crashes with "Oops - undefined instruction"
on ARM platforms (BeagleBoard-X15) during EDMA driver probe, as the
memory corruption triggered kernel hardening features on Clang.

Change the allocation from:
  devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8), GFP_KERNEL)
to this:
  devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8[2]), GFP_KERNEL)

This ensures proper allocation of (ecc->num_tc + 1) * 2 bytes to match
the expected 2D array structure.

Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/dma/ti/edma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 3ed406f08c44..8f9b65e4bc87 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2064,7 +2064,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	 * priority. So Q0 is the highest priority queue and the last queue has
 	 * the lowest priority.
 	 */
-	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
+	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8[2]),
 					  GFP_KERNEL);
 	if (!queue_priority_map)
 		return -ENOMEM;
-- 
2.50.1


