Return-Path: <linux-kernel+bounces-817634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEEAB584BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6084C38C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255831B818;
	Mon, 15 Sep 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmKOYmxY"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5030E84B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961467; cv=none; b=C1kAu0g+Ih169k+My7RkEgezNpuUeExRMAt0ABYAtacecC3kRlVOfirFaL4GtZ+tg/b1/evzCQYo6dMk3hTD1mFClZwo4LIS8a8VSipVNjmC3lLbX56M5vyftzkQ4tOgxbiK+TBNcn77ZuIqQk59mD9z2ZEeLbmt+F/knRvNp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961467; c=relaxed/simple;
	bh=D7l1i7Tso98Yp3oxSA+xRb+WgnIZVt0f20hEA6CTpEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrzlH5l7+aJQls1lid7lJzAAV5o7NjS5CGjgq+4MHxoGrOs73c2tU4Fdjhvr3qqJR+Ah66aRooPfOuPQku6Xp+hiidsYs4+7G2/C2juCZKTT50nqDT296haKP3weiLJJ31v6Pw7hfTpRhpxNX83YoxYxszSnChPw+i5VPQemnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmKOYmxY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7322da8so146580966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961464; x=1758566264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeZpyFc4Ckatn0hgt18UAr4UISB/Kvr7U8EfP7dfVc4=;
        b=fmKOYmxYsQbKxpl7ZdipV8Y9fsUxTh8mLAJTHqE7eZK+oZ0vXV6hsSpEjTj10wy52B
         xGSC6mo5GV2GR9fN6wqTXu7SR51mzxmvEyjP48BXs2th9xyX4fIsNRAcEBM5YVaE6PVZ
         FFuzPaRcytdPuPENx3LkQ0uuh1mvHrnKLVGKcLxTAUXuuQup3mmCZql62sy517IIpcWY
         evsoMHgEvQ5BdySaJf+BR71lypeq8GOlK/mBZIf3ZOsI6fFwvLSJ2Tsj8Ox/lNBiinVJ
         cuCtw2s3BglSXWXdWiiPl1EHplo3AbyyjH0JSmdOvEVDNsZG/vWhR7fOlIHRkVzRZ4e8
         0fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961464; x=1758566264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeZpyFc4Ckatn0hgt18UAr4UISB/Kvr7U8EfP7dfVc4=;
        b=F049JFL215Tn1ERbuLukFVqyvAs6VAh/hmqxcytXup8B2vWPef/SurfmEngsYCrXvn
         hXBaHgXICU1aoYVDKcGZHQRaA//HL+uaeleTSdGApoXric5LuCQ5yJ6yuj4/0ozqg57M
         /PHYFXyixbrllxqisQzrgY2wvMnJPO2dXG4P7pqwhVFIy48pliBpXzut7cbhRsXCuDUl
         U7DsFcaW3LLUlzosVBP9NrgYRbmHropeW8S+iuq9ozTOGZzoJvjNNiR+csR1fh3ahB1d
         mu46blJf7BW0knpLcsy7dQ/olL++ekp5cV2xcvMCfH9n91cafigQooLQRdC4vxxEmCGo
         Q7yg==
X-Forwarded-Encrypted: i=1; AJvYcCWzurM09kjKqLhKveyGyX569Gn5VTc1OPExPWRogBo3RxHt84tR0angRzUCuCY62lxQU+kunSILyOTE97I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEcXQ7iTlAEKfLas5VohkciyF6D0bEvWhmHRO0W2dGEyUFYaE7
	osnhtNmbnzRVMsKBPZGaqNTd+7fYdrDrdvM3fhr3JhsoshqmZ0jGNFd1
X-Gm-Gg: ASbGnctk4TgMkhkcAVY9W0ZDJcM/K2k6EUVw2vtlIDcR15pPuK4ub3qqh4PhuE2V7WB
	jxUEx/vJGkooOYASWiBagG0SAfBw7RxZAmTQ3UXbVVG3Zb8WGCaZRC2cXUEcRWQEZhADbBcFkNW
	8nu/oAxORm3AXwyteHkMcKn0+DwmGBVjrLDGFvs3+MZpOGbye7Gr+/2wF6KlMokfNEtD6N6UNnw
	Wu/QA+w3u/8u4ObcAbYlNm/sftZK/jyXPKZEQaE/3Ji7IZBJ/4YNzUZKhaEHAdtwzK21YMBwgTx
	lYUI7g+LHG7+V9Io7Q+J5H0DahfN7PBzhNHEo33itBxDzkdkQOJt0sGk3OJ1YhNlrdNFVHr+xht
	lNjavB5acinZM8V0y1gEZBcxEDjTF+T6ZAqtMEhE4+0rrv7IXSaJ5Q+mLzLSqGAPXUy/lEcSFgH
	jlG45JLckjp5CBag==
X-Google-Smtp-Source: AGHT+IG4ukwBCnrVrafYVIfnQ2fBgnMS356P5egIxyTNPI1AtkBlvU4TPcYBay4AUhoWx6zE9fBkLQ==
X-Received: by 2002:a17:907:3e1f:b0:b04:25ae:6c74 with SMTP id a640c23a62f3a-b07c354fadbmr1221786266b.9.1757961463847;
        Mon, 15 Sep 2025 11:37:43 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd3e4sm983305466b.54.2025.09.15.11.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:37:43 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 5/7] spi: don't check spi_controller::num_chipselect when parsing a dt device
Date: Mon, 15 Sep 2025 20:37:23 +0200
Message-ID: <20250915183725.219473-6-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915183725.219473-1-jonas.gorski@gmail.com>
References: <20250915183725.219473-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not validate spi_controller::num_chipselect against SPI_CS_CNT_MAX
when parsing an spi device firmware node.

Firstly this is the wrong place, and this should be done while
registering/validating the controller. Secondly, there is no reason for
that check, as SPI_CS_CNT_MAX controls the amount of chipselects a
device may have, not a controller may have.

So drop that check as it needlessly limits controllers to SPI_CS_CNT_MAX
number of chipselects.

Likewise, drop the check for number of device chipselects larger than
controller's number of chipselects, as __spi_add_device() will already
catch that as either one of the chip selects will be out of range, or
there is a duplicate one.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* no changes

 drivers/spi/spi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 91e2f4f504e8..2eb361e9e44d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2427,11 +2427,6 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		return 0;
 	}
 
-	if (ctlr->num_chipselect > SPI_CS_CNT_MAX) {
-		dev_err(&ctlr->dev, "No. of CS is more than max. no. of supported CS\n");
-		return -EINVAL;
-	}
-
 	/* Device address */
 	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
 						 SPI_CS_CNT_MAX);
@@ -2440,11 +2435,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			nc, rc);
 		return rc;
 	}
-	if (rc > ctlr->num_chipselect) {
-		dev_err(&ctlr->dev, "%pOF has number of CS > ctlr->num_chipselect (%d)\n",
-			nc, rc);
-		return -EINVAL;
-	}
+
 	if ((of_property_present(nc, "parallel-memories")) &&
 	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
 		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
-- 
2.43.0


