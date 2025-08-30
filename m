Return-Path: <linux-kernel+bounces-792872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB26B3C9EB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA233AE32C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA40242D7B;
	Sat, 30 Aug 2025 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L49tdd/6"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F344C2264AB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756547400; cv=none; b=CO8/gBnsDGhCfVbdcH2vSMm14m40Pe09V/UMCZUsY4ux+n0DhdaKFLOJuB2TZ6Hlq0aZ2tdG9RR+Q/pmu3FCa8wOZyKHUHcAroFhd7SQCfwGJe34pWyZNQvv7PapTNZ+NYsA9mpJ1EVlF4xxMGojwbbHDq6qYyxgBM6hDuk1yfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756547400; c=relaxed/simple;
	bh=MhydSjpAwABmF/rCF0KsztuXi9gwym6dmu8o5mvUOII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/ND2vXorOzqlyhUnOM94M7zVAvZuhNovfUIz2yQWdgzGPzon76TO2pi1mqyYXpjfFi0xc2H+Ew3fUhMEk2apgA5XuTlSBGey9kKEZ8QImO48MGglcGc56iQHZA/qMpzZxBVfELtMgmQPtutFPYlh82/4d6KtjBzO1js2C6lIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L49tdd/6; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f3b4c9fb5so269961e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756547397; x=1757152197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRNROOHHAw2Bc/THJAy9MOJuP831ZvEwTWSfbFMLjGk=;
        b=L49tdd/6XCRK6SBM5NBertOUCHAhaX+AeNgZzWfPAn14t+pDP8QIz2IMuZTRksxmZK
         bjD0VC5TTzLz/hVitDT9EIdxz2iL1tlVKpbT2QA17BiKpEEHnMu5dPTeNw8Xh/C0gHwF
         4c7xKlDHjc/Doo9hXkxs0ncUpbAZ8uuP3PhSV2jH2JCf3m9WJYR2vpKt33O9E2ql8hBs
         PckSUziW3WrJdjt5f/3zex7/57sDkW/Zja/0IzhGVgscBN+Zub2GE7pYNMDoWQa1BRuO
         HwqCKdItZrbS9g28GwNPevlvcdRoFDoviKmQ4OvOA55tBMBxoS2qD/lAaDlAFUzWSAut
         lo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756547397; x=1757152197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRNROOHHAw2Bc/THJAy9MOJuP831ZvEwTWSfbFMLjGk=;
        b=tA4cufGFTRXQzl8IcQt7Ilvu30BDEKFuMHwuTTjNC5HnbKEXESeXs5x/MK0fljFr60
         0hL5KqX1bODkVDrthEoemWJsI+A//ZPswmVtxHIyTU6duhYdLPXpFqeAXtW8ap5R7ndf
         tog7Oa9eJbTsMf4Ol7z3F2JIx2U1F5PYuRKyNTbn9UZzHihl9Rp7lzazHrY+zpm6vznG
         m8Bsioq6CzYo53B02eRgQHkMGfMyssw/DsH2hxZjUCkHTCWsNB54ZtTSxr3f2JlKd/IJ
         NQIEEzEl0ssANxsMZzSncxq4KNZbibLSuwKLI+/o/wpfGyQufRYKPI0CyxIoG5B7Ui0c
         XMeg==
X-Forwarded-Encrypted: i=1; AJvYcCX8SxVBDqbkspkr9HBNgI/Kck+fZwBwdLvWlCpuzexb7By7G5jHYs/pxfamIHL9QB5WYnLwqgojT7409gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGty9RFYondbkDCWcArNs2AecRaxD02eYvyiS9XgTtXjLz024s
	hCnEFSMIMNxkglgqaQ4AdrnoqBynYyvQDGNsddIuYNJn8OiPtKxKHI1EFaqKlFoErVY=
X-Gm-Gg: ASbGncvN+8/HpRi5akYTgPeeaS4AUT9vThKxPc9Ef7UmVazIxO2u7spbbeHl8JJBb+v
	pF1I7CNFGaxAdxWXo/4DO+gGGC3phHEcGmarPd6UQVRZRsy/zv373DcWvmdtBfEeNBZJsXPG9MT
	440K/XNAolOF1iQ5A1eWe5rUufGSTAPMhBEYOLhmLF44MIByfIMiZyqQZdEmeBLYfN3nLBA6Pso
	Lg1rY51oacE2vtRb8rmFiyXW39S/GwJBMpFpWsnGyJer/F+Zm6T3yEQzviRVDi7EGhPD4xj1Gvp
	B7IF+3wPBzBl15bzvpAnDWUam+6p2cVPh+SOeCBVxsE1gXxBq11j5vmDhwG8SrY7Tvgx5qFGpe2
	Q8ZEqYuqwi3UE6R5bboJLxEHioeaDl42QSCzvgn0TpeZtTinSFlP9xIaGc5LlBlpB7w79
X-Google-Smtp-Source: AGHT+IG3HJ4okzHDbXzyC+DgyjCqGWEYnjZkIT75Na3msr+BLTTBdvc2Ju4vaDO6zUBBUpv9efwGtg==
X-Received: by 2002:a05:6512:104e:b0:55f:612b:b350 with SMTP id 2adb3069b0e04-55f6afd91d7mr563621e87.3.1756547396895;
        Sat, 30 Aug 2025 02:49:56 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55f6784fdcbsm1325961e87.98.2025.08.30.02.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 02:49:56 -0700 (PDT)
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
Subject: [PATCHv2] dmaengine: ti: edma: Fix memory allocation size for queue_priority_map
Date: Sat, 30 Aug 2025 11:49:53 +0200
Message-ID: <20250830094953.3038012-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829232132.GA1983886@ax162>
References: <20250829232132.GA1983886@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a critical memory allocation bug in edma_setup_from_hw() where
queue_priority_map was allocated with insufficient memory. The code
declared queue_priority_map as s8 (*)[2] (pointer to array of 2 s8),
but allocated memory using sizeof(s8) instead of the correct size.

This caused out-of-bounds memory writes when accessing:
  queue_priority_map[i][0] = i;
  queue_priority_map[i][1] = i;

The bug manifested as kernel crashes with "Oops - undefined instruction"
on ARM platforms (BeagleBoard-X15) during EDMA driver probe, as the
memory corruption triggered kernel hardening features on Clang.

Change the allocation to use sizeof(*queue_priority_map) which
automatically gets the correct size for the 2D array structure.

Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/dma/ti/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 3ed406f08c44..552be71db6c4 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2064,8 +2064,8 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	 * priority. So Q0 is the highest priority queue and the last queue has
 	 * the lowest priority.
 	 */
-	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
-					  GFP_KERNEL);
+	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1,
+					  sizeof(*queue_priority_map), GFP_KERNEL);
 	if (!queue_priority_map)
 		return -ENOMEM;
 
-- 
2.50.1


