Return-Path: <linux-kernel+bounces-761427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC6FB1F9F6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5880F4E19BF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 12:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA92571DD;
	Sun, 10 Aug 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZYXEJBSq"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8382512FF
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754829219; cv=none; b=WwyNmdc5utOqZzIIOBA6CgemmM2iqgLSnm7VAidc4qDzhiPn4YNWmscHntfQxtYbAFph0lNQWtSsAWo+qlcvLPoQLzldjprQSz7Ay7kQ/ViACVcCA3kEpP8Jl04d0a3iMWL1BNlUVU8sSuavZsyrJm/rZN+GzH8VNryn9xFq42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754829219; c=relaxed/simple;
	bh=71Zw6M2jWdmfIYc6s1O6BKdyVGRBVJ0JuCrqDmGLOrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCbA7f4bkW2iSqs3Ojvig6yA8gv0803vQsq7C6PhhXewc+SNspZQ1btAdv+D3+s4jvvFl0hSiyGZi5LEmAl4qFYMKHR/noIATiHX76LGkCPZEouiFpksbsu41WlXTj3lHHZ3qhPxSGUgVLkTHJrpgePcPezEm4k1OHJ6LNiYkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZYXEJBSq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af939afe5efso407205166b.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754829216; x=1755434016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV/TDtPSqEo+5cYQ2J1jzlBNpBRLHkqgnRcU52xQyv4=;
        b=ZYXEJBSqA80sslOIrXCOU+y1HCZUKmtuhLBBHIAId4Ir1YtgwkbD1a6EODY+RRMxoQ
         YJL5FvLMC6faUauyIzTXdHqXAStRs/hn2x5WA6W1ssFBj6dMutleEa3eV78tAPr5KFA0
         Y7LK5VqjEM6MGeCkR1ThujRVS1TGmLSGPr7TTaioKnqdCtMBYtAddrsXjcpjD0JTvZ0G
         Rqu1ocd1b2IQqGKD+jtr2Eexqi+XZNL6LmbRmVlCwz1WpfZUInbsPK2FQA77F/RYPE1Z
         kk8W6gi+UChMISJdeHYgPYrWUO9qe5zpDTCAAf9sIxlNqaZAkjgmWp8D3iKdo2N3akno
         cMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754829216; x=1755434016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV/TDtPSqEo+5cYQ2J1jzlBNpBRLHkqgnRcU52xQyv4=;
        b=r041EkEpBFCvJ2qfixudx29hV/wuoyJMj6jxOVta6ryOG+9yMZLOE9LZ9PcEXatKzf
         k5oZwZK1Qq43igN5mcxcnV6EOWG1pib4+CPsgXeQ3grvNhRlI/5AD304X55WeAzFzxkR
         zub2BNxElfbZVqYtaXfeX8T0+69aoQ+Lka7HojfWSDIL5pyjFZXoEOW8vsbeQqxfdV/5
         yextIJnYkQlCANUilobcKhm/+Ek2vyZrIQoWr9J9EyXMUb2ZDNdHgyPPu7u8sX3sAq2Z
         n/LEhSC1im1RC0CwcIBuwajCTDhn6CM8LuKT5WVP3TE9bOKcuixgaalySSkfDiQUQ3YZ
         aMWA==
X-Forwarded-Encrypted: i=1; AJvYcCW7KzeCieJes0awY0AmUJOOwUlwc7tV8bSNuIjA9mKCgA7wstkA06BU4KB2nEbMT8rl6tfOY8H9iPD374U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyv4gDipMAKOETRz4fW0UzsoA7dQg7Ih5cOOGUZdNxGcpH96z
	NJr9UhF2/ZtKpjVPOyfZazAxLGziXOER/O+GT1N5yv9NEDJh6e7Xv1wVJPVrUhMLmLA=
X-Gm-Gg: ASbGncvlwQRRM3Q/zH4/KpssDPrwbWxu3UAaS4p4VCsN49FC+cmXG1IX5UxRXKHrjW3
	Iw90wZtjj+z5b33RvF/Lg9yR8L94ErHYiQi/haXyJSyMG9hnscs3DNAKdZqypNlkxsFPYc0Pb4L
	ORDYXyy07qBh48Ixnbgi8dZA0qtDkp4nY/JXEilRZPI/+S3yUceYSicE0REe9vgKkRD72v+G1YF
	U7i7q6mgeveNAflcWghBWoYtoO8ECxu28k/iCcg8s5sa/GKYY8vA3QJxSmm502ZrgOxkJmleOxs
	Df2bfQ43ZkXDOCOh5QANDQbDB5JAOrLvqoDtfZwwtaCyRvovQTbP4bJINIkquedpGksEIOgWJWf
	K6DaBDRDlJUwDwzAUSM9MIRwdTwbAXug4V2nmtpAAfyq4cXNGzBl4fpG6+r1ZfLc=
X-Google-Smtp-Source: AGHT+IHQAKMYrFI+05pz7SbKlvMrNUdxOuLAR74amCZyX1EGKun0OSM/Q4gjT8wSLWIIGGUnBnwFMg==
X-Received: by 2002:a17:906:d542:b0:af9:1ee4:a30c with SMTP id a640c23a62f3a-af9c64d3cfbmr922368866b.36.1754829215779;
        Sun, 10 Aug 2025 05:33:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2437desm1852203366b.127.2025.08.10.05.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:33:35 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 2/2] iio: adc: rzg2l_adc: Set driver data before enabling runtime PM
Date: Sun, 10 Aug 2025 15:33:28 +0300
Message-ID: <20250810123328.800104-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250810123328.800104-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250810123328.800104-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

When stress-testing the system by repeatedly unbinding and binding the ADC
device in a loop, and the ADC is a supplier for another device (e.g., a
thermal hardware block that reads temperature through the ADC), it may
happen that the ADC device is runtime-resumed immediately after runtime PM
is enabled, triggered by its consumer. At this point, since drvdata is not
yet set and the driver's runtime PM callbacks rely on it, a crash can
occur. To avoid this, set drvdata just after it was allocated.

Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none; this patch is new

 drivers/iio/adc/rzg2l_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 0cb5a67fd497..cadb0446bc29 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -427,6 +427,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, indio_dev);
+
 	adc = iio_priv(indio_dev);
 
 	adc->hw_params = device_get_match_data(dev);
@@ -459,8 +461,6 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	ret = rzg2l_adc_hw_init(dev, adc);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
-- 
2.43.0


