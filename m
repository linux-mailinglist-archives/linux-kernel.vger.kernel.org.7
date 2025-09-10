Return-Path: <linux-kernel+bounces-809743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F247B5117B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B8A1C8166C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ED53112DA;
	Wed, 10 Sep 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzTNt0/v"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8A30F7F2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493297; cv=none; b=PiSjyy0ggQ3RQLXpX1OqmxzdXj4fzkPzqC05VrGUx5FXs0hHu20huAkBIphn6LopmuqNZDwGyZljnbKlIpmRA2f2Dsf2D1q52yfvm8bxJ/DGZFgS1kffGXUQ6oIJZx1Psm/AHkV4jT77qn2v+RsUM+gBlbVa7vSepQF8T/qAOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493297; c=relaxed/simple;
	bh=SpvRzD0bOjvGf2Nx8OuBFCP4M+Ir0Zip7/CfVuzu4QI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJco/PVuQcrGb7LUDjX5NF7KklwEXewdixA+boY5Xi6Vlv/TSgNjP9QZA7SQVFKifsmKUqsmN4pzbr6nb+kx3ar/UXzQD6faibmub83iOHLaRf3E9n+VJWOoYAFLP1N4HTuf/Nx7l+L1E0W3wdBwkWSlq0AbpO+wIFY+9/xlaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzTNt0/v; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ce208c7505so304444f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757493294; x=1758098094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5bYSYMP2Z0IUIJfdQoYkXYkAGdrYTGhMeil+naL+UQc=;
        b=AzTNt0/v68SMTQmrd+R2D4oRjd2K/T3QJw4jc3cYeVQVcAHf2/Ffj8oL8pFZl9TzHw
         zKqkal/3N0gD5AkZ26S8nzuEzJdtGPNvwuUtf9Nk/KJxsC0CJVfrcI20V+T/uSUY2l3h
         v6fQBm4F5s1+SV+04nCtBr1v113DuXSz22HHtuT4Plkp5zAz22MlJ53yWWXfIBZ6kW/B
         XdBUnKkZWksiYkhJRxh+aGyDKJxSpkBsZChbb7/x2V+ISIwyDTETlSa3IY2twPSPMDra
         GGO9ugqLsLmf/pHNKUTPGnHsmOSIu2SAvgiMPNwiK8dJF7WiU5YxrJiYQWSItgCTkttV
         HuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493294; x=1758098094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bYSYMP2Z0IUIJfdQoYkXYkAGdrYTGhMeil+naL+UQc=;
        b=hqNMRQuGCpezzKDYsdB+4VhebOw/U9OiGX9g/oUeCGpovftDyKFd6gRh7AWuif7Xrv
         D7ApB/X5j6ylcP1Yng8Emm+xAeB1XaIWahvRHcd1lu+EN/tz/Wj2Hp5qPP9ouah0sAwt
         r+A58oU3ZvbAM/UDG3dD2c3eJhtyz2VUigwYhvkwPOtQEfB/MWUx/R8Dw7XeF1KTlX5n
         J9nbO8um2f5NlRrFgYRoLOSdOcpGxRLBYL54TyI092EzIs3FRrwkzcTh0sarHQXLe1io
         CU5uk9wi+A9eBLD+xuyrb0M1gebTSgfie0VBSKkCVYLboO5Lbuu9AjyLGFkMSKYzJcLx
         quWw==
X-Forwarded-Encrypted: i=1; AJvYcCXU8ZONhFFN/mD2UPxWs0ROkrjWNijqWdiQYO/6rQPKyJ9YtIA0265vai83zzmsA9F5atV3+4V8uyq249Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDboP+P/K0mtf98x2j2Ad0JdXjcoZlg/1nemX2weHM48ay+Rq
	f0eYghKUwTmLiFgGRZbxJ9ucqSKaf56tNfWl32NFWiK6Z3fITvqqNmgi
X-Gm-Gg: ASbGncuFabfD5P5pripu42j133PymBdy0bzlZUiTUdDik5Pt3uRVu/fEK5ePFHWstZ6
	5IPGSYMU7tdFyA5+mLqUnOn5n6fOtqc4lDZrQbt80wryV67CVMhgF3dvRJjSyPU93GqdFKWf8+I
	+UlfF/h1AYP3Q08EleIfRDCHfGUtnsGFhqcgudOSQlcE2doeb2b3mPaPGB3lSLi3ez8voDUQr/F
	gKOxoE7m+5JXSPPN7M5hyLNzaWng69KWasesqKrbFJxaNcgKPrzQ+cFNbymFHwK4h6TbBxvQcx3
	3Xkc3ItOy+3hbeFVIrPJgH1pNTV7X6tUHbZHqvNrZLsxyrnHbeXlJz6EaZVByHc7VCfp5a6z8ur
	RBI63fz6quKzYymNAlpsClXh3b9XD7prd9MlD8TyTpaBbTdGxcwJQMg1u7nvyxwXZVl8=
X-Google-Smtp-Source: AGHT+IFvK6FSXou9OenUrrz/PdbIoxF3WcJL69A9lP4CdFPOW3aq92qZPlSoHiBDeanssK1jlGOOKg==
X-Received: by 2002:a5d:5d05:0:b0:3e4:e4e:3438 with SMTP id ffacd0b85a97d-3e63736d9bcmr5889161f8f.1.1757493294125;
        Wed, 10 Sep 2025 01:34:54 -0700 (PDT)
Received: from thomas-precision3591.inria.fr ([2a0d:e487:311f:7c67:b163:f387:29a1:c54d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7521c9a2esm6378854f8f.14.2025.09.10.01.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:34:53 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Neal Liu <neal_liu@aspeedtech.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Johnny Huang <johnny_huang@aspeedtech.com>,
	Dhananjay Phadke <dphadke@linux.microsoft.com>,
	linux-aspeed@lists.ozlabs.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto: aspeed - Fix dma_unmap_sg() direction
Date: Wed, 10 Sep 2025 10:22:31 +0200
Message-ID: <20250910082232.16723-3-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems like everywhere in this file, when the request is not
bidirectionala, req->src is mapped with DMA_TO_DEVICE and req->dst is
mapped with DMA_FROM_DEVICE.

Fixes: 62f58b1637b7 ("crypto: aspeed - add HACE crypto driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - fix confusion between dst and src in commit message 

 drivers/crypto/aspeed/aspeed-hace-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-crypto.c b/drivers/crypto/aspeed/aspeed-hace-crypto.c
index a72dfebc53ff..fa201dae1f81 100644
--- a/drivers/crypto/aspeed/aspeed-hace-crypto.c
+++ b/drivers/crypto/aspeed/aspeed-hace-crypto.c
@@ -346,7 +346,7 @@ static int aspeed_sk_start_sg(struct aspeed_hace_dev *hace_dev)
 
 	} else {
 		dma_unmap_sg(hace_dev->dev, req->dst, rctx->dst_nents,
-			     DMA_TO_DEVICE);
+			     DMA_FROM_DEVICE);
 		dma_unmap_sg(hace_dev->dev, req->src, rctx->src_nents,
 			     DMA_TO_DEVICE);
 	}
-- 
2.43.0


