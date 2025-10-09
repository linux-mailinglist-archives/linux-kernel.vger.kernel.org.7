Return-Path: <linux-kernel+bounces-847266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23FCBCA642
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B41348134C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B205248F7F;
	Thu,  9 Oct 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XTP+0TLU"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A823B605
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031375; cv=none; b=qpjc3o8YQ7PnmQgUnTfaOpAu6p/vkc4cgDv1uOoJg0ZlpKkOFS6G1AkRy+3Ye7ZGOsu+UxW912mwx4x6s6aadna+30UY2BH4L5YmhLlRMwrSjjjzmCLQjHzKTyPwyf5nmP3XWPmjInzMvlKvGg4TZljbL0sk/l975+4WFwu0ZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031375; c=relaxed/simple;
	bh=Vkty7DzuVOFqKx8/EsqX2XjqQtiwC7HTIRMiI4/cOrc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMDGCgXfpnoBycvGvGUbb0m9dlKrxW3ithXL6ZJ++Pcmu1r0rwcZz6kn1tVw1A0UQUsEu1/3huXrDmxcKfH434wyZzpZEPuLjx058hPcw4GQCVGuSW/AcEvN4DZ2LMaX6yuV1qi/vrgUdTVu95tuklzchZTrlM3gN0zIV5yaSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XTP+0TLU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b00a9989633so126305466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760031371; x=1760636171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1r4d5+0RxhBZSIdX3lc2DX4DwfElrj3TmzYbJi6k7c=;
        b=XTP+0TLUULiPhVzXCuTETZvahUNoLOX/lCneOK1276ul3xGEJKxCrvLVVMz9dmRdBi
         F/4v/sJq3pwp4MBvRkS7GwRB943a2s+IsR2lVzzcofmvN7A/TATjf/pC3k6WL5r+v7+m
         YsKEKRkTcbVCy+5JWXiixndEMkZoEapWpkRKg5jV+CH5iIFtRvhiTb0QINYyMYneK+5r
         XyYcYEOuoQHBs10qtdVi0KwkUaZ4EIsSz18VPMjIQGKhQGrz3IrUc5+CQEIeBvaiHQ8E
         Wgu9A9MVXTpI01PcDNVjoTlTLfvekCRHrt5VNgEZLqYxgACTFoQ+4FoK8u/Pf/ccp4SU
         o5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760031371; x=1760636171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1r4d5+0RxhBZSIdX3lc2DX4DwfElrj3TmzYbJi6k7c=;
        b=CHKeZh3UOMb4mD8j8jgfSiPnVskg4f7Jah1MH9Kk/udC7TQU3eTu2VDKQP54pI4rsc
         sAmgqZaNmVEUovEe8iOVBjTEvRb40Rq6TN57z5yTasH9elxm7zjwX1WUQUtBHiVtV3h/
         PGJKkfsvlzTHxGxFgHfy8loIkCGuUnLwUMraqaIxf1zAZUeLfuhq4SMAmd/DaIlhz3XM
         u1EwFmeBR2e5SrLIewie1H9e1BRDYANZWvsytIlm70mC6gw9E3pv8h4EeJJDmuweTWDI
         a175juwgbKKd8CdnCIF1hVDV7lbrdxM6mXAFf5jIa9QZ7xyRk4VkKuoi3B4s444jhcys
         fQzw==
X-Forwarded-Encrypted: i=1; AJvYcCVebL5L0D7npL25Cr7OEPpThPO1hH52VNK85MUMcfovP1Vag3MwTqPrkfEBK9rF2snhzZj7PfQphpdPeTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMgUTpJxEZ8VQ2gOUDBNTXLxdvYZtyI2PWZYk40u/e08CyjBM
	QZ2d5ejHpOT357vYwl6LdH7uguXqIhQp6eo90DQMx9AGqfKimxyksHVvJK+Ai6PMTzo=
X-Gm-Gg: ASbGncuGnwHuIeoY8UGb5NXJdH6wxr50ZvtRAxt4vUZTwUCqC0VzJanmp+1tfbH4ZMK
	vR6JLqIKA2ICy+44sfp5uMRfJsejCIXLinuAocA2E4rdWmUJGtQVmcLXtPAtWV9E2vHV7XpKD7G
	hEKFlwQjHX2sUOllyFFZ8E60+dtrnYSm5WT0v4fdQPRPMmHONVh7FcWu23sCkvvwBgfsTAUoVs3
	WG5kDyq6gy1EdAP4iam/4ippvIxpozd8y/ei9F8O6zjtVzgcqjlAWugbcNJrgIG9tX78sx47RYA
	j95hnsqxY/EtVxCWVmRVqSaSP81OwsgWlVSHbfYXdR97+JDks58SUj8L1mX8M6Dnx52H8gc0C3x
	PgS3YRGcG2k9yl9l1uA==
X-Google-Smtp-Source: AGHT+IHvd+4Q0w6q9Mqh3z9M0DeiQevOZL6zWVn+VNI9+7YPCwjTmW5gjknFUGylxug+1sKlSbi8mg==
X-Received: by 2002:a17:907:a70d:b0:b4a:e7fa:3196 with SMTP id a640c23a62f3a-b4f429efe15mr1253251066b.20.1760031371466;
        Thu, 09 Oct 2025 10:36:11 -0700 (PDT)
Received: from localhost ([151.35.157.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d951deb6sm20547466b.76.2025.10.09.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:36:11 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
Date: Thu,  9 Oct 2025 19:36:08 +0200
Message-Id: <20251009173609.992452-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009173609.992452-1-flavra@baylibre.com>
References: <20251009173609.992452-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=flavra@baylibre.com; h=from:subject; bh=Vkty7DzuVOFqKx8/EsqX2XjqQtiwC7HTIRMiI4/cOrc=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo5/JEYLnqVvshBifg78xCx/6GToqsV6PVZTzrI ZT3rW0HpEeJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaOfyRAAKCRDt8TtzzpQ2 X2aVC/9PQQzoQFJjZ06iHXpU0MmfI8dCT7Fh4GetcHUvfMTR6C825UKwHMvM1Zk6OMtB8mut0rU 4wFNj4U13uDpVc3YR20NrddcTUJEus3MoLmZo0V5NOIEc4tC/twt+QYazPrgrf5y/s9SvAFTr36 j0exuraYLbZUjAmlyhnFleqV9TQRZJCHEQ7KU981a7fMT6tqXz8sigsVQbEpRffkxx0Jqmgis8q rgZjDYze0ZVc/+VXvLH2Kw5I6X0IqvHvZhQPGjLhYg/HYQgSJgqbErG5tdD4W04q47J3LC18uNb pGbho+n5sRuRlJ6v7FTV+klL0hYfNqFLfAMEBvCeGpjONjNk4ni0Zp0piFedP2QPt9Cq0qPmDWs 5oKfdwFMsFr+zzln3vi66wyPR+WqxYHgPIrt/SB6/zf/mV+nhIF2SJVYB8xIoE8qQIgvuc3spVU xJoXjCgcKAQ2WM6BhbDssv0oOLpYetLiSzhbMJtuMci3xXirVvGviIY6ej50g2t+Cpqj0=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The `odr` field in struct st_lsm6dsx_sensor contains a data rate
value expressed in mHz, not in Hz.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c225b246c8a5..bd366c6e282a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -365,7 +365,7 @@ enum st_lsm6dsx_fifo_mode {
  * @id: Sensor identifier.
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
- * @odr: Output data rate of the sensor [Hz].
+ * @odr: Output data rate of the sensor [mHz].
  * @samples_to_discard: Number of samples to discard for filters settling time.
  * @watermark: Sensor watermark level.
  * @decimator: Sensor decimation factor.
-- 
2.39.5


