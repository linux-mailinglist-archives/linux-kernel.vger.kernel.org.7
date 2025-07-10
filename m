Return-Path: <linux-kernel+bounces-724764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37317AFF6B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D22116DB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B11027F19F;
	Thu, 10 Jul 2025 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uBUs+n7u"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD2927F01B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114034; cv=none; b=T5peFA6YqftCg91mN/8RotA4aTFb0nBVW6mQv7Qn0f9HD/nmC2iQ7x/ZezQpQVOAbQkLVJCLmenETSn3Kpbblqv6cwckywhLhyntIPxmG5zBmT2Syw3q7M3vFgcOTkNAuW7+ZdZMHxEsWXFXRCG2mSNpCLc9EOxVaPOYsW5FEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114034; c=relaxed/simple;
	bh=PrdYl6cL5ELmEcjkN1E1wVLyUoxLSD2mgLWQ/8TLt70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YiBSdAR9II1kcCjdIr4+QkVnaeJ7kuJtTpmjGGdkM1FNvFPFy5leeVDUfe3ADIaTBQNLVDWNoEpZQnRVQcMFWE+cFkXY4smgzNaED2vt/4tN/gJHgCM+ZUwxCt3zS/oCytJ0MHK1nP8j4bOENTJPf5Pcdt1oTtRWTfjgyloQ3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uBUs+n7u; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6118b000506so128813eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 19:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752114032; x=1752718832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=La38bpNvym9P0SG4sHe+uHRcxOOSKpxAGmg4JaBHWlQ=;
        b=uBUs+n7uWPvdJzywIwtg2RnDgue6mQqp232seMWzRBJECTugH11a6eSocr+84pPCRM
         PsRwOXEyi18GeTfDgFwZvj77+XF1Tn0UOP/dT6eLMyrOS14UQvuZoEuQbFLPWSWtJhoM
         RtVNmMe4jkVzhK2+EyvEViDNQfshTPhbe8fHNcreV1eAx7TjjCzRiMnP1Pm34FiYVY2H
         K+EnQmaaWbV4aUG1TeFfjl56LcCg8J8RJkRV8TAya6y06IHRbdLnn3bji7COSc/97mP5
         5SKUp/4FkLw/avqYB8X3QabyOlg0arrY0xnQusw7dVBNlwqClpZqbtURlGVdis+5DGSS
         j2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752114032; x=1752718832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La38bpNvym9P0SG4sHe+uHRcxOOSKpxAGmg4JaBHWlQ=;
        b=RlDImOqiD3AWZKlBRU5EgNlx7zDh9whn88YGqMwRb8NaZX9i+lGEVbQV5ZmcLhziKK
         +EraTfsvRTTg2avEXR7OErXWTBF2jLSpG6Sk8GN6aPAWNSy9fX5KwWPwpf/y7bmsTOqF
         f4IaI3qhV1cIlAKqgRZ8fisUFGL/N8hVevb++9bVTUEzAJrtiPSyOA7kjTLT/wuoqZCY
         z9X0v+bST8RAUc0AbtpHUYV/T2i+rDu8EpPNR12ki0Dh5PqmSgswmlbgWV0HLIn4ZkiR
         2kRUB8TrEC0YpGBHQGuzPLsEEqgsKEep0c1aM8WzBdo7DX5MDzUbnn/TBsboPWjBiiL/
         uiPw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ4PSMVLdCsqat/AkPvKkRVSa6T8RPEoxgI37L6UEDNg9vi5yvG78j4IBEH4s7f6+aXT2YN4Fg9LetYJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxH1dlhfTjeC0l6jZh08nhOfpwogIYe7MkeFqjg/y65nvOsvTi
	7hSFQucBeum+auzaR5VkFsjDH+LEtor9/YoEgRJJtRBWx2oxD4MeUHBxXQ+Lo9ehks4=
X-Gm-Gg: ASbGncvVgrf9EQVsXlvZ5AT0H+K32mBzDxFw2Bo+HaBbnQtWaSjalxQqocEjIWiyJqq
	eA+QZGh3J/o5PnV4D65RuG+R0HyW3ELLntQvw4eL9NrNd/o8knlTMHKp3VbNUnWdSQLrJbrCnBG
	CgGBoAMpOCJwXzDwlctFS3KSFXxczvQ1Cm9nRCtHhLhqgdIrxVkaik5huFEEwg98e5MMpwIvvad
	LiWApymn3fQb1+uszTHsVIU+wsREg4S8fzdmOjWgiz/UWY0P+X/0ycd76AY5YUZEoWB/CS8NTjJ
	LPYECob2aV7bjRV+7gEi+Ll3S3109ZcxymgHJS20Nsdhmekb/t4Xnx8RIZ56PjJirkzg
X-Google-Smtp-Source: AGHT+IGED0OyDkTZlJZY6bL6UdAlzshsytNE4n6qwY8n7ay5Z6rl6ikJKtV7hvy1K4dtPURwN3dwtw==
X-Received: by 2002:a05:6820:4b89:b0:613:c922:32c6 with SMTP id 006d021491bc7-613d6e13bf0mr1535420eaf.2.1752114031791;
        Wed, 09 Jul 2025 19:20:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9f00d46sm66972eaf.22.2025.07.09.19.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 19:20:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 09 Jul 2025 21:20:00 -0500
Subject: [PATCH v2 1/2] iio: imu: bno055: fix OOB access of hw_xlate array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-iio-const-data-19-v2-1-fb3fc9191251@baylibre.com>
References: <20250709-iio-const-data-19-v2-0-fb3fc9191251@baylibre.com>
In-Reply-To: <20250709-iio-const-data-19-v2-0-fb3fc9191251@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andrea Merello <andrea.merello@iit.it>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=PrdYl6cL5ELmEcjkN1E1wVLyUoxLSD2mgLWQ/8TLt70=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBobyNdqlts8HOoSJGjEpUG0vkpz3w/6lOCHab6J
 x/NMV3xG/WJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaG8jXQAKCRDCzCAB/wGP
 wJZlB/9NBd9Xls/tWIsMyNt2QblowGb92oV81hUIFWXripSyeMN93WZ6cfo1basvQJg4g453W4H
 N9q9aeMYlFwXEBVhANdBQYP5pbMD7Z1PPgMFzP+ZKcCfArjMU+ofRaXgOcJIaEg3DxSmTPlHwXX
 WGobVVtPOBsUVwUjIlm4coJjwBPQ4NHECXtsce9sWUnbhW/bjqk0hA0gwP0jwcmRTe05WKVHetR
 NfBTkbVK2c/hsPqhQM/LSqto5WgpF+Df1+ERLe7FZ4uha6V0J2GtfV72uuQvAMdXi2MJOKT9WMe
 92/yxsnyh5GOmn6SZH1AD+7Zy6ef6uaeAJ8dAY1FPRdBcEkd
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix a potential out-of-bounds array access of the hw_xlate array in
bno055.c.

In bno055_get_regmask(), hw_xlate was iterated over the length of the
vals array instead of the length of the hw_xlate array. In the case of
bno055_gyr_scale, the vals array is larger than the hw_xlate array,
so this could result in an out-of-bounds access. In practice, this
shouldn't happen though because a match should always be found which
breaks out of the for loop before it iterates beyond the end of the
hw_xlate array.

By adding a new hw_xlate_len field to the bno055_sysfs_attr, we can be
sure we are iterating over the correct length.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507100510.rGt1YOOx-lkp@intel.com/
Fixes: 4aefe1c2bd0c ("iio: imu: add Bosch Sensortec BNO055 core driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/imu/bno055/bno055.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 3f4c18dc3ee983fe3c5569406a2c6350b0cc756c..0eb5e1334e5564284c7f4bf560424b5ec734903d 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -118,6 +118,7 @@ struct bno055_sysfs_attr {
 	int len;
 	int *fusion_vals;
 	int *hw_xlate;
+	int hw_xlate_len;
 	int type;
 };
 
@@ -170,20 +171,24 @@ static int bno055_gyr_scale_vals[] = {
 	1000, 1877467, 2000, 1877467,
 };
 
+static int bno055_gyr_scale_hw_xlate[] = {0, 1, 2, 3, 4};
 static struct bno055_sysfs_attr bno055_gyr_scale = {
 	.vals = bno055_gyr_scale_vals,
 	.len = ARRAY_SIZE(bno055_gyr_scale_vals),
 	.fusion_vals = (int[]){1, 900},
-	.hw_xlate = (int[]){4, 3, 2, 1, 0},
+	.hw_xlate = bno055_gyr_scale_hw_xlate,
+	.hw_xlate_len = ARRAY_SIZE(bno055_gyr_scale_hw_xlate),
 	.type = IIO_VAL_FRACTIONAL,
 };
 
 static int bno055_gyr_lpf_vals[] = {12, 23, 32, 47, 64, 116, 230, 523};
+static int bno055_gyr_lpf_hw_xlate[] = {5, 4, 7, 3, 6, 2, 1, 0};
 static struct bno055_sysfs_attr bno055_gyr_lpf = {
 	.vals = bno055_gyr_lpf_vals,
 	.len = ARRAY_SIZE(bno055_gyr_lpf_vals),
 	.fusion_vals = (int[]){32},
-	.hw_xlate = (int[]){5, 4, 7, 3, 6, 2, 1, 0},
+	.hw_xlate = bno055_gyr_lpf_hw_xlate,
+	.hw_xlate_len = ARRAY_SIZE(bno055_gyr_lpf_hw_xlate),
 	.type = IIO_VAL_INT,
 };
 
@@ -561,7 +566,7 @@ static int bno055_get_regmask(struct bno055_priv *priv, int *val, int *val2,
 
 	idx = (hwval & mask) >> shift;
 	if (attr->hw_xlate)
-		for (i = 0; i < attr->len; i++)
+		for (i = 0; i < attr->hw_xlate_len; i++)
 			if (attr->hw_xlate[i] == idx) {
 				idx = i;
 				break;

-- 
2.43.0


