Return-Path: <linux-kernel+bounces-848477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F231BCDDBB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF3D54792B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B662258EE8;
	Fri, 10 Oct 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kOe8I1kZ"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D432FB610
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111102; cv=none; b=t+7EhqamL/OoOrWKiKUjtuHMtwunG4jguveB6JRed7QK+uLNqTRsLBlVXUaoev2dAlhmzWMBGm8fuONw1lgwtUgzyOa6CJMlzGguO9GJzZYwSXKNoLtGBjm1rlI8BLQis6/pKWiXVS7cZJQCBGzPcx5bRJRuZVTiUt+tIdSdv+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111102; c=relaxed/simple;
	bh=QKS4puind1Hws4Fkj8Bknp+M1UP2qskwWYb41VBUG5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dx3G3n6qLQOIL/hcQPIjfFjye0fKKvHAwMkKU3790SaN6MmmiBTxeCBav7axehtA2e1Re2DcFMM+4w4mH9idsm9bwekAyq5BuvBjMA2IW5dRlkT1uihZW66Qyd2VSvkjXipxlyMd2XHGUWwHOc5JXVhHJd2C54E40omAd2/jcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kOe8I1kZ; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6418c6b8cbdso1170081eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760111099; x=1760715899; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7RNbFN6Pb19G5qsWCgJJs11kMSx198ewO/+S27H86/8=;
        b=kOe8I1kZEWO5axLQPIEc/39XmNzDGiKD2gMaPTm/+tlNCyk/KvTig35oBM+4NjQ2cY
         LLXPl+vT4ClMMAIPH6h3ukcB7vMaFmPtoDilfe6I9tCZ3KRBhO/QZ6B7xDN51JnR9Y/4
         dunLfgfbQiPqGMc5cLCmWj7FKkG4bTFgGLZYkQiPuwvFhT+aaxnnXBMT5eLtrp1kUlvc
         amJDjtWbPPf1XYgoxLFQnOH9xXvF/jbnaDUSXNf3ZM6xImyVN230GMD/lwWSnCt1DLkT
         Cuu9a0nIMqoVf5G0TcW59zN11CFG8JSZaq+Mj3qzAcJTxk0BW95NWNz6cgHao86tdYeR
         BWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760111099; x=1760715899;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RNbFN6Pb19G5qsWCgJJs11kMSx198ewO/+S27H86/8=;
        b=p0W7J2mKYdehvJhpqlN4YjMoHUIlIA9WCMA0aiNQrJjE7MQ80wx5SKLuYitVHFi0/P
         s845SSnln7LqTxdte4NyqVaYGDEBgy6QgmwhA0d7YtaK9iV18UM3Uip1LY9uYHSe6JoJ
         O/qSwbhAxtb56GtYRBEFnKyeCFpv/d4e/9a6sFHYmBqKFMG0sG1WY69762PvRXlGoTRJ
         jAWysyOBtRHtSKUwziH11wNvvlpnojeXuqVJTgJX/0DDzjT/Kaq7HyM6OrMtLoTv3Tuy
         4GHc+Vfw7XTLwG7vaxtA/PUU0bFum+ojKsdrAQDlZaAfhrMXjIn1qTWOskV0YDHWSLc7
         N+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgP3yMWaas8lKFEhChuvecSV54Nk4gvUAdVSfpscWVVFIUwoB9L8nxhGghRjvg/fd8LZN1LZdF4mF+I0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQEJ69KMGtXL14aCq1UN3fpL62oShIensYKhes7X8RLj6l99w
	rYUrsQlbrpD274Zr06Q9ALuY7W6ZDdfRpA8Wl5Y8zuF5iUE5fJ2EmyraCqN5YF4XTrs=
X-Gm-Gg: ASbGnctwgi54O4oEJiFzCPeMVamPCF+TM9fiIhSVB+8FUrBIpA0WyQoUb/ykIC7IRjM
	YQfs52UFxAN1VgL1gJkbmkQ2HbcGLDTyZPbfPfx+vRU/rGEXJbFoErtF4SL3FKvPKsaQuFefflZ
	lmu0V9qpLtlrRY0jly/xN4dEOeNHPDIR79jz9nIFYIed9bYbcRtrYNGT8K1msza2Jw4OhvMUxDI
	ViYXE4d0EQDJ1Ar0PO7MlxVZqCjJDUkMLJH4+FLAMdMNnkQapS53P66GhT8WmuRxXBYlVJc7E2W
	wUtixwnBUCBrNnKwtgl3jtAqUO8igPdL69FxyPImVjUZDjWxAfwDEfZGP99fhHQPUe6NtPUPg7t
	FYtQDJCRn1bue87uu+g6dyOgqyP5ozvKf+FrgCOMYDkyCoXjLaGBe9LA7
X-Google-Smtp-Source: AGHT+IEowqnjFNk2SMDGNBQ7/rWYKGwr7JvacbcVw43nyMdMwwbXs1/wLxCgvDkG0souDgxaV2Oo/Q==
X-Received: by 2002:a05:6820:238e:b0:63c:b999:f8a3 with SMTP id 006d021491bc7-64fffab8d69mr4686181eaf.0.1760111099185;
        Fri, 10 Oct 2025 08:44:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f915f53asm933666a34.37.2025.10.10.08.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:44:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Oct 2025 10:44:45 -0500
Subject: [PATCH] iio: adc: ad7280a: fix ad7280_store_balance_timer()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-v1-1-e11746735192@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOwp6WgC/y2N2woCMQxEf2XJs4G0uN5+RaSk3agBbSVdRFj23
 w3iw8CchzOzQBdT6XAaFjB5a9dWHcJmgHLnehPUyRkixTFQIFRtyFPx7OOBGK/6+ffU52aSMj+
 4FkmzPsUwxF0uY96KHAl89GXixu/wfFnXL2kvVryAAAAA
X-Change-ID: 20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-126bc5b4ee90
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=QKS4puind1Hws4Fkj8Bknp+M1UP2qskwWYb41VBUG5k=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo6SnvgIT0W1cfGXR0CP2Xv4IlR5KOwiCLl19jw
 6/u4+Kg9FiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaOkp7wAKCRDCzCAB/wGP
 wNtXB/9/LZIEn30rqQaTd6Znvy1Kd+1aCYoNIXF+0+4eDOdkwsa95ztcktWJY43dKPwuiet5vsO
 yeXmP7Xf5Tyd948+LqDYFotZb+ApO+mNCc1vp7biIk6I7JKaqIL6agLYNVrtVV2Dp1i/V7ic12B
 J5jMjUtDLm4rCdk7Y9n6RSN8Av24YC+MiX8S+1CrowTZPBvj7p/59CZnOPsDsL7w98lYm4RAI5T
 OGqq23SbdTgYx9xV7Nkp/aJqKnRIs5Nqm5kq45F8iwEX4tVLmn6T9yofLKZ6oQVgQaeCVNbZccO
 1G2sVJJCk9c15Wtv/1GuE2TXydO+ysloLVimfiLYTJQ9pGc6
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use correct argument to iio_str_to_fixpoint() to parse 3 decimal places.

iio_str_to_fixpoint() has a bit of an unintuitive API where the
fract_mult parameter is the multiplier of the first decimal place as if
it was already an integer.  So to get 3 decimal places, fract_mult must
be 100 rather than 1000.

Fixes: 96ccdbc07a74 ("staging:iio:adc:ad7280a: Standardize extended ABI naming")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7280a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index dda2986ccda075fbfa04851a1ceac7a186b47537..50a6ff7c8b1c73905fabdef119d41204c32b590c 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -541,7 +541,7 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
 	int val, val2;
 	int ret;
 
-	ret = iio_str_to_fixpoint(buf, 1000, &val, &val2);
+	ret = iio_str_to_fixpoint(buf, 100, &val, &val2);
 	if (ret)
 		return ret;
 

---
base-commit: a9682f53c2d1678b93a123cdaa260e955430bc5c
change-id: 20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-126bc5b4ee90

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


