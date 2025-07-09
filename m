Return-Path: <linux-kernel+bounces-722625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423BDAFDD00
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8275D585347
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FA718C011;
	Wed,  9 Jul 2025 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HyOMZbI9"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BDEEB3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025128; cv=none; b=PAuL+lBLFiKontLhTBY1tMV0rNXqj69angYbkFOrmsh3nyaeo9EHt/ZdUjKnprzG+USbE0wJw2crypEurw5DGPxRlFtLO6AVoD+t9NQ7Foztd9K3s9ON7VZea7RMYab3cpU885MvKujwSGYUkLX30l4JEAuokuXzY6T1aJd5cD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025128; c=relaxed/simple;
	bh=EqGUvq1W9b8p3s/SlI2fGWuYuasEZUTVTqAe7DLTlUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BgBj5GjxvC/lkLeDPJXQN6sEvPr11DP8xYSzlFZP4jrWkgRi6FIjxTfJ9bM1mXmRO69qUGW0hti/61d879rhQkvlcU/WKGGq2/03wMtKbLCf37ndF9Sn1DKDosUv6EVy/c8INIUYTxq8ezEHjrg64tVspW6Kub6radaFGIWsd9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HyOMZbI9; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2fef7f6d776so49911fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 18:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752025124; x=1752629924; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sBnzqVWdy7tR6bkEPhROARFzHB6TNAPq7wVTbLSq9hw=;
        b=HyOMZbI9Zl3HRuD/G0edErmyM8AlzzXkd7pYmliHjO8ZD48LUkU17NomRpKomAXARR
         hnLAErVkqpJ5/RiGvxBYhZoQE0EvlY3fHLP79xpFI+W+4rufxtmY3Xhzr6kmy3fZoclQ
         pF1Nc0atxTrTzQyiZglQy9maln2duuN4mGJ47tEni7r/RNBKpphE8ltqUt7OMRbBTq6Y
         nrc3/0ycDPtAM5sxrW0eAi1lE8UHpYYN4xnXYfl3lroCyF11RBS228ZzWoYne+AxNA8i
         bLiEKsLbrzvmvyOkm2O72u7j7yh1ikF9fz9GEhCknZxbiKxOnvh0YY/8YyPec2BcoHNR
         vxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752025124; x=1752629924;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBnzqVWdy7tR6bkEPhROARFzHB6TNAPq7wVTbLSq9hw=;
        b=ruye+UbAjiLrP9MEHoclPgkNbUn294Ys/X5wIkae8GxEp4PY8+K8xmgJKYbJbiTySE
         G5kBArwTnFDoNJemdATk8EL6Q0nvGSBq4uO2680Q8j85klzGHsc9BuVE9Gj15bqcMs0+
         JV3VEAK7WwDnbzclayqIsCpobCBrOqyaKxLYog+0Mhm904/3VmYFlgnBcEtb1MtpoIBO
         gcpbdrS8uwaYUsez41nzP5MG87Ip513KfENDGhhiL90yZpALK+UMYcdXzo8TBpJhU6eQ
         NQJ1sF098b0zBqedvyMtMAHS7tnrLc2E8HRWIJD2NvJ5mkOokJL1/DNLrmfDyzXAlPBO
         6KwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2EYebRfvwETpLx6VP0cPzkVhy19iSuRbTLzTtzwlPFCfheQ9zsdPV6dkauQIcjp4dQbtTL37FW+/oVBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD24yzKlW9Z39IXpnfNdFfPKnCr3LoehiKoJRD+AujFphhpVv6
	BCsedS611CfbqlEVqU9qKzibt4eF3moWv7x4p9eskTlsst7nO9aQ6obBYzWMAoQQa/9sKwjinKs
	7CfGdQuY=
X-Gm-Gg: ASbGncuPcS1mgqapnUyKMkXeX/0TdP4gIFD42U4mibbdbl+pDAwJBobnI+eavNS5vy4
	nMYJaDSW9TG/EiEqoWd9PdpQzxHdqQPNd3sZVPZhse6H7/ZWvEOZH28Up/Azo0w2IHsjG6JDMIB
	xHolGgCy/ffxpZjhY8uJ+DN7O64XXzZrj2A/3flA7PDzptEv5FQ9y4Ab/GcqwOAadVD1AmPPUIS
	hWsGaFfZBmcV31DIMHA9qmsFMPwOX2DlV90KpLg1zsRtYMaQ/eVcQLy7vuJ2AlfZRmpKeQ2pRes
	xFE3F63MpiKVHHs2hhdROgCzE+nTwPS7ZG7YS4qOxUuUoInXPxith7Rec1Kqe4yzwwwg
X-Google-Smtp-Source: AGHT+IH+BlmAzS7hyA7BVuYxetiV/UOA5+C02CPgHs3DgcOAThTJOBQzBgUfcCVJ5uoITeUcFHSEAw==
X-Received: by 2002:a05:6870:f21e:b0:2db:a997:7a62 with SMTP id 586e51a60fabf-2fef85110d5mr456784fac.17.1752025123790;
        Tue, 08 Jul 2025 18:38:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:ddc3:43e9:8174:1067])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2f78ff4c088sm3224266fac.18.2025.07.08.18.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:38:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 08 Jul 2025 20:38:33 -0500
Subject: [PATCH] iio: adc: ad7313: fix calibration channel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-iio-adc-ad7313-fix-calibration-channel-v1-1-e6174e2c7cbf@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABjIbWgC/x2NywqFMAxEf0WyNtAqPn9FXMQ2akCqtCKC+O/m3
 sUsDsyZeSBxFE7QZw9EviTJHhRsnoFbKSyM4pWhMEVlGtOiyI7knaYpbYmz3OhokynSqSr+pMA
 b2q5lX1e+mwyBjh2Rtfo/Gsb3/QDgXfEreAAAAA==
X-Change-ID: 20250708-iio-adc-ad7313-fix-calibration-channel-198ed65d9b0a
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Guillaume Ranquet <granquet@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=EqGUvq1W9b8p3s/SlI2fGWuYuasEZUTVTqAe7DLTlUE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBobcgaKo+egVt1fYjkRHvy4wWlHKngAnEtWKAdo
 l7hC8lNs4mJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaG3IGgAKCRDCzCAB/wGP
 wOJlB/9rK8dWiMwaIrhlhqBpTa+YlsgzBCE8blqSWOK9ITy0bMhzzdzqX4qQrIlhHDdIddpW/CX
 SJE4SrYO6nl/eNc23LLWIpt2xzSs4AfS1kxM1J3Hb6Bjs7uC8SXxprW6OQTJcCx1XWxODQEbzC1
 eU9R1viIW2fmeQgBfRtZa8w7HyrLllD1Zl/nQzgyvtTzEttd1ztyWlJhKWx6Nx/zyV5Cx4/bj6Z
 mtaj/d8ayL0Nh6jJOW9GseIa6dJA7hcmnTERSPb2QePmwlYUtgQfIcCzBTTRQsEgX65bgMzm/fg
 iF0r196AJrATS7jbp4ixx85DJqb7Ck/t4mfB9hPd1ctIqNx1
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix the channel index values passed to ad_sd_calibrate() in
ad7173_calibrate_all().

ad7173_calibrate_all() expects these values to be that of the CHANNELx
register assigned to the channel, not the datasheet INPUTx number of the
channel. The incorrect values were causing register writes to fail for
some channels because they set the WEN bit that must always be 0 for
register access and set the R/W bit to read instead of write. For other
channels, the channel number was just wrong because the CHANNELx
registers are generally assigned in reverse order and so almost never
match the INPUTx numbers.

Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index c41bc5b9ac597f57eea6a097cc3a118de7b42210..61749586670d4f0730ca423d6e4c0ee1bf19edfa 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -392,13 +392,12 @@ static int ad7173_calibrate_all(struct ad7173_state *st, struct iio_dev *indio_d
 		if (indio_dev->channels[i].type != IIO_VOLTAGE)
 			continue;
 
-		ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_ZERO, st->channels[i].ain);
+		ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_ZERO, i);
 		if (ret < 0)
 			return ret;
 
 		if (st->info->has_internal_fs_calibration) {
-			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_FULL,
-					      st->channels[i].ain);
+			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_FULL, i);
 			if (ret < 0)
 				return ret;
 		}

---
base-commit: 2233378a8c606f7f6893d4c16aa6eb6fea027a52
change-id: 20250708-iio-adc-ad7313-fix-calibration-channel-198ed65d9b0a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


