Return-Path: <linux-kernel+bounces-881301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D434CC27F2E
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0806F401AB4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431812E92B5;
	Sat,  1 Nov 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eH6/Ao1X"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DCD25CC40
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003554; cv=none; b=flGf1mu/nhlgUFs8t+N9u37gSJMQ2JrHJIcMEpfSG53v5RYyLI/Tz6hd3W+bSFvtOEaoKhVV/FhFlN7VoMt9F9z3G21nniqF7Pcs3K8u8VQ3q8gC2gBWuYWTSlCGZFR101+aZdkf8DL7ieNFyhR6BuQx5okYDZy9LAPy5WTm9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003554; c=relaxed/simple;
	bh=Mc1wsSOnWuVBW5U3mmx+TYZyVd9CGG8SkUFXpUY1mqo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jbzhiqgEqG3N4IVVjHA/X+0kw0RLLbKgNZr34R++zUEEscMB9386pQZHSYI2efY9xrnX8zg0fzXgk+tbjy2d4+x0JzmWcT/GbnUsdRF6ofvVOrT+S85hGNO0po3Ef8Tcg4gFc7HvqxrMSttGiG3R4o2x5Fd2zL0DozcHcBw1Wdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eH6/Ao1X; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso18328495e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762003551; x=1762608351; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kefLFDRMJrK9HnSrDfYpLnvqtBuSL8Qun0L1purZEqI=;
        b=eH6/Ao1XjBYqaHdXLBpygJfeBPrFmBZvJ828MYS/cDd9KmUK5/7GERD/wKsFl9luz2
         qbcoq5u4wMQlgdCAKrY2Xqsfa09+EMa1GH9HGgkjT7OPWC3OPrP5UBYd+sytptJfrXOd
         ZVfF8ceZNDCpDRYsaOTZy577y6aWobLFpvSOC4Pbg0uU9dsOyxfIsI0foQWfObzKgdJU
         ZoytmCWFiSXB20QvuojVKsBvI6bJ1sXs+gRHpMmFKG5J2nPEqT8+/arT3a4VOLv9nFhM
         ypX0Rf3k16h9oXI8d2LjNJZqgg9wXazRZUmvuac44wd/32Ivrfa3xU4n+Zkg4kcIqkiD
         vP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003551; x=1762608351;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kefLFDRMJrK9HnSrDfYpLnvqtBuSL8Qun0L1purZEqI=;
        b=Te5kEwrk1Mz4vu+BCBh7eN0bUfl1lePPDhhKQBE1vZ2U5gfN6tFheZ0CSxHeQHHrMq
         LhwcZNC/cDHwIGWM2KBSfAIhzD7Ek9lyXBc77wAZzEtAVxRD4wD9AHPGxMol3dlHRry/
         QpP6XuX8URUkiCRJaEzJf470RwUAfrLrZ6Khk6v8IkXmR6uLaa3zpU7/sz0tskf8LUf9
         pabhhoyq0UPkG3diR41nVtSi4cKE+/bNrBWWHGcBwTeoF45HDoJgyG7UvpfzsoZXXnVJ
         0oycixXOu8h2fDVtS4dBYrW9HkH4atudFATzGUn8qwIczfLQrQ/yrYrpqo3OtNday3yC
         ObtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6pDKh3RSovZCRzQFczMmEVNkIXCqJoHYFLoxZJusT3vFdcU4IggJPxMopoYTNWVF9XefnVyGHtZVT6qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaeAGWlfkhrMauq8sQcmEThIIFJzvF/P4ZfAIV7QahustfNqpQ
	ya/cxpqMVD46pyKvhtOGR++7CL5DOS2G6Iqixuvq3XbcZcG58UtOueHu3Vso0YWSG+s=
X-Gm-Gg: ASbGncsruLDQmCxzOi3WqlX33ij9sK+G9SGOF8YqWI/HKuO/Y+hA4QmhOGV+kbBPRvE
	5+DyVXb6RRf0t2vAAA7araO3po+G4p9uBvFMlHMrVMMyKUFVsNl6a1BJxqoxqllqxDI3ogfDHJm
	zYXWPlk5Va0ytIe50FWN8d8ljO2Zwf+yE0Qmxbx+LKZIcTW0JmWdLiRNJe4gUu7IFf6AiXPhnwy
	twJPXuMo6f/n1plKJmXd466nVNK8wLfMdvGCgXk5D3fjWq06liFsRtlZ7dzlmqDMQCNsF+JCsP5
	PgfEJEkMchO/Vda6oYTHYl/pzvTZaJOvLIfIT9A3ez2WNK8R14deMkOjUbfR6/V+EvM0ts0JtOl
	mGGCpZTAHE+MH9CJPf5YEXP1UNZ2qh70hLdpgIu9L2B1y32IcrOEGcfrqTKMxVMFCbWrRGxaoMQ
	g8yh0xV70vcrH1lR0k
X-Google-Smtp-Source: AGHT+IHg6f3fIsXsLrLzGR7r5NdaH5rE26INwWReTi4lRgX0CdFFywAF4j5hbZstscw0VD02x8o6vg==
X-Received: by 2002:a05:600c:c4a7:b0:475:de81:563a with SMTP id 5b1f17b1804b1-477308b22a2mr64707215e9.33.1762003551417;
        Sat, 01 Nov 2025 06:25:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c2e674csm49318355e9.4.2025.11.01.06.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:25:51 -0700 (PDT)
Date: Sat, 1 Nov 2025 16:25:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	David Woodhouse <David.Woodhouse@intel.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] mtd: onenand: Pass correct pointer to IRQ handler
Message-ID: <aQYKXGSoLqCLNqKg@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This was supposed to pass "onenand" instead of "&onenand" with the
ampersand.  Passing a random stack address which will be gone when the
function ends makes no sense.  However the good thing is that the pointer
is never used, so this doesn't cause a problem at run time.

Fixes: e23abf4b7743 ("mtd: OneNAND: S5PC110: Implement DMA interrupt method")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mtd/nand/onenand/onenand_samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/onenand/onenand_samsung.c b/drivers/mtd/nand/onenand/onenand_samsung.c
index f37a6138e461..6d6aa709a21f 100644
--- a/drivers/mtd/nand/onenand/onenand_samsung.c
+++ b/drivers/mtd/nand/onenand/onenand_samsung.c
@@ -906,7 +906,7 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 			err = devm_request_irq(&pdev->dev, r->start,
 					       s5pc110_onenand_irq,
 					       IRQF_SHARED, "onenand",
-					       &onenand);
+					       onenand);
 			if (err) {
 				dev_err(&pdev->dev, "failed to get irq\n");
 				return err;
-- 
2.51.0


