Return-Path: <linux-kernel+bounces-829618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4757CB97792
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021DE4A05D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED1BE49;
	Tue, 23 Sep 2025 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lRTmUeQy"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB73207
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658696; cv=none; b=uxdwf7VgKJ4ydqJpSCNK7W8p5iHXdD9OmpD+WJQ8JJLPwa4TZforKP03sFzYRFTYH8+Gld1+KwkHJq54wF6Tpwl70p0Vmyz2IF5gJkcXbGeG8HwPnDXS+kGxCTULmUfAhDPBf7eYW5SUnbBeiTlvDycGaqL13RoZMjp29OktgI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658696; c=relaxed/simple;
	bh=PdloU9lUcNigpqawRG614VYXEABIgO+DNrSDB0byo0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZgqRkpVSC4bRROzT3s/ElDl3UD9uCJDtKwHKbbr2Eq3xTeGEE/BsrbeGXqx6jEqq1ff2giN0o/id/HeqLgS8pkMbLw7Hfa3nJxn3JymVW5ICbecrBsraxMzyYGoKcmYaEf3PDd17iZhpGfay9JDYBQ40KiChRVk9EZdkfPsxQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lRTmUeQy; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7827025e548so1451036a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758658693; x=1759263493; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aDPZEX1Se6QeCt3KvdyPFqtPVMI5PCpL90eCVP8oByc=;
        b=lRTmUeQyOOsDCS3VUdXlDYgZ9rXyySEvuq6gD+9luT4K1xSBKzbhOLgj0JRwgFrU92
         jXDJI17LULLBk3yTHsX82HX0RN5wCP8Lh2YFCdkLTYRQ4AzUreW8iuSIgwET8+Nkb0mY
         bVUldWtf2LbZekvs+UlIZIFaqzJcPtewNhTmgqxSttnfJUrCDATgsqFJ9tJCFymNja31
         zU4vtvyRQjXh+KowWbSbHOompySNQeCjV45cXLidPe7mc0De3RSwNbgFueq02kCzPYRv
         d4ovEjuXIItaTGFNP3lg8EcjQaRcfalbZHfBA7z+tL2Cvt9+sBjibIghW25FN65GgN7a
         SHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758658693; x=1759263493;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDPZEX1Se6QeCt3KvdyPFqtPVMI5PCpL90eCVP8oByc=;
        b=XVREkJ2dTRHGfGq5m58LBk93aVjszxP4L7SRboCXOv4yYM6KM2Dd/aA4t9spd4ZiNN
         wqn2UOa2lUB2/ZexkNt908DTlg35AnaxRfBFkuvjQu8ik5ymHvAdE85luPRIiMOyUizG
         TjSwPLkLP9UEYGIeJ5bEptRHW7O87gG0COym4PWVGhBu7rdLnkxjQzyRZijgFyoswFy4
         m5MJo8ahSGmktD6DbdWKZCEnQ7PVKK3xDoIFWWA3IDRsOUNhU3O0iAtUHu5RT8cSUYEp
         BcUPbw9OwsRdiMSBCoOaW1AKwFUMGIv9m8VlW4WoBFn+T1aOTfOjSb0hK0C2xYyuwN8F
         CRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNvmjpXJtW8TKy4yTAFjTgRWFCBLsPLgDmfpD8HCDGyaq20GYxo7iYWQVEL6SDVmbmtaqkzbJZzVw9PFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRecvv3EOgQ+RsgOjxmBcrcyy2SI7MmC3UzkNQIaK6qvmzzxo
	7mmWVks31p/J9kdxF7UHdQFa5KV5c2LSluU8vTOAhsYE8934Xr9i2qPVUPpCMYiFMBk=
X-Gm-Gg: ASbGncv9RZJjuK+JJd0llSi/GSuq9WKQwATeGoGaOjpYwA0wExOnhJTQtuMta6hOOVr
	NNgRX5J1nPHmmyv6Ct5ajuYxUzg6wrG94QJb/eeFC7N+E9qdnKL+P9ukHAXawSzNbKFokvmbN1R
	IP/cwDL8+rQGN/6m2fI3VfEJTDTKSGjtXIquFklCSGJJoIVvDISKrt27YuCKTmaWNLm2wU7nCZ9
	AlCFr9gglkbVuUFkJK70WlHx8e4h30pclkpqw+6/r+GELdUl2NmYxc7JWDEHnM9iarawVmBlrxD
	btQX31uY8Ii7Cofmmx1TcOBfADS8wlKxUtYDdpdnR2/afGONqREo77Ufn6Z/0HPdhj6C80vF+K/
	tzLy7hSpFabgifEoZFV7ytAavEc25
X-Google-Smtp-Source: AGHT+IGYuFMOBtN+MRlBqbaM3vIufu2aQP+VIVxkfJ3IU7O/Q6FGwWPAvlE8f/F4JRy9gSs1s6xtUw==
X-Received: by 2002:a05:6830:6ac5:b0:748:8b42:779e with SMTP id 46e09a7af769-791590a4e7fmr2703856a34.27.1758658692847;
        Tue, 23 Sep 2025 13:18:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-787303d25bfsm2199731a34.15.2025.09.23.13.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:18:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 23 Sep 2025 15:18:02 -0500
Subject: [PATCH] iio: adc: ad7124: fix temperature channel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHkA02gC/x2NywqDUAxEf0WyNhBjrY9fKV1cNNpAe5VcWwTx3
 01dzOLAnJkdkphKgi7bweSnSefoUOQZ9K8QJ0EdnIGJK2q5RNUZw9B76oJvOOqGq3wWsbB+TfA
 vRXlj1RKNdUncNHfwscXEq9fR43kcJ8u74oR4AAAA
X-Change-ID: 20250923-iio-adc-ad7124-fix-temperature-channel-5900f7302886
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=PdloU9lUcNigpqawRG614VYXEABIgO+DNrSDB0byo0w=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo0wB8eCDSh+bOkroC6WLZKngB6ZWixGjr4TgtX
 YZ11zWDRkeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaNMAfAAKCRDCzCAB/wGP
 wB5PCACMNUp9YoiBK0muwuQDUUbDJGbEOhUdY8z6+dY3vIqNwzK/UOXbumhdQTs41fzje2I/DGi
 rAoE/Vt+m28mAUSVpbX2DQu3HDjwMJGFNrWsImQBqS9SQxtlWlvtVxHY4Scn/ZUQut09tIG5JBB
 ewmqBTbJQWhVD0w5NyhXfZhRTC1VC0QDz8GI/yYhOwknjShGh6hKfx/LXLSyk/AQnoGs2uRJQrQ
 DiX+GO1/Fd3AtjbCB4uWXKJjqoOqdVie4pD0II2Tw8BC0gMCFp8KDG5beyw8+2mkJjekOShOUAC
 GBjZ/bvcoKzHAui5Cn0pXnS2Xck3mV5Jb+e74VB6yWv5R3rj
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix temperature channel not working due to gain and offset not being
initialized. This was causing the raw temperature readings to be always
8388608 (0x800000).

To fix it, we just make sure the gain and offset values are set to the
default values and still return early without doing an internal
calibration.

While here, add a comment explaining why we don't bother calibrating
the temperature channel.

Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at probe time")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 374e39736584f55c1290db3e257dff2c60f884d2..94d90a63987c0f9886586db0c4bc1690855be2c1 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1518,10 +1518,6 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 	int ret, i;
 
 	for (i = 0; i < st->num_channels; i++) {
-
-		if (indio_dev->channels[i].type != IIO_VOLTAGE)
-			continue;
-
 		/*
 		 * For calibration the OFFSET register should hold its reset default
 		 * value. For the GAIN register there is no such requirement but
@@ -1531,6 +1527,13 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 		st->channels[i].cfg.calibration_offset = 0x800000;
 		st->channels[i].cfg.calibration_gain = st->gain_default;
 
+		/*
+		 * Only the main voltage input channels are important enough
+		 * to be automatically calibrated here.
+		 */
+		if (indio_dev->channels[i].type != IIO_VOLTAGE)
+			continue;
+
 		/*
 		 * Full-scale calibration isn't supported at gain 1, so skip in
 		 * that case. Note that untypically full-scale calibration has

---
base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
change-id: 20250923-iio-adc-ad7124-fix-temperature-channel-5900f7302886

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


