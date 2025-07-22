Return-Path: <linux-kernel+bounces-741448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8E5B0E44A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A281C804DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB31284674;
	Tue, 22 Jul 2025 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jpPxN/Hu"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94701281353
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212916; cv=none; b=C+kufRkUkNRWuFZ0LDFz9z+1wzIvy4LeweEpyTlubICtrtZW3mEdj2+ZuBcwSmQYkj7VHhQXrJhB4eQD5W5gk3ymz4ggMfFLIpT62IhM4xgZqHy0MLBHOdArin+oUR7DLZmMMuNnV9f9+l5YGI/fgwHBBORyu883rlwVw7zCHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212916; c=relaxed/simple;
	bh=yRFRhMPm7jNLGGqB0LF4R3l3KyFeu06cYWiQMGcs2t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jDbtwEGB6tQwBGCC2ppBh7owUdv9Brn0rhp+uT+MXk7BbubrX7+WiN6HoXSw4gOWX89Bua48KS0IGo5vvli30naPaQ82wMhMY5uOfOXA7Ag9B/JUAiAflTfTPpgaEw/AUU5iMPeW0svHFcTRppw6tg2tzzYkUuXhvkJja7xMLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jpPxN/Hu; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-73e810dc22dso2650236a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753212912; x=1753817712; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWqidPkEwwKODP+KFOjNIgdSCFO9hHiUxuXFTn1kZ7o=;
        b=jpPxN/HudjZoaAvK3AfTHQZQpiP/0BsGf1YPTuopO5mM0t4oYMaUV5CgGSYW7H8Ugk
         xTQOE3S6iB3nKo5/jr4ZrmF2Ox2ov/wdMWIm70Fr1O+w+CPYMfPlxTy/R0XP5D39yWY8
         tsgYl+PgWLH9dn0autTIjHk1v0Zk0USnIFY8FQWxefSfl0fgYOpiduWyRA4NmhEb/RVN
         8z+Y8yFpxPrYhan7UijdOvlfKsCPE8Wmn9nFymoolC+0E2A92VQqwqO5Y2nuYCHW8xIL
         74qPbKpia04kVL/CmJPWcF56CmnpDR/83pQHhrnufa1oPQYSjuUJZldrba+StXrlw1JH
         dkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753212912; x=1753817712;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWqidPkEwwKODP+KFOjNIgdSCFO9hHiUxuXFTn1kZ7o=;
        b=tioBfdrlo0NGnSWnKrWOIkw5cvgYslxDm++2015WGp0JuNtLEkXmAvdnal/qmRJP0K
         QSRL8a8hoZGiJLkWAe5+DXgIp00SnIk3YdNUJvTInOLtk0Ot9gIXO6sWZn54PZ7DbCdC
         9eqUOhANpP1PvMeGirUL8wyoD4BhgI3U8D5xgp+ER/WTocNktbzNTCuB8sMd0mWKs0rs
         oRXB+GXoYl7rWA5x8UUr2b3mYo//uxP4sJ/69kXkky1iXCz48pGRB2XtX+2Y+lIKcXvY
         4YPxmmfP8kVRM8gkidJn/mpveVGUMPPlbI5Yz2sAF2KdCmRIWyQE8YdHjTjyP7jXJS2K
         oAUg==
X-Forwarded-Encrypted: i=1; AJvYcCUSH50uCPLuFHlHqh6AVee8+xtKsAl0LPFc8nCh5rKexVO2dXEKPHH6+K7+KkQIG7f77sbFWhPMQBQLC5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVYNFSAhFsg7btwEOQ5QaKAEYaD0UVkPbWxb19fBl2UC8i4Mw0
	nFEtQ8barnE7hIxFSij/3rt7BWetjh3zwlHRAwJswBcYUQTRyRarBGtgoA8+Qf6mMQM=
X-Gm-Gg: ASbGncv7x5iikmHAtEk0Qx8Jf9e4vc3cV8DkgmEv++mua6LluJ+Z0f//k1TUMRX2ZJg
	ImsE5ogN1+iIkH+U+62JkPPznXVzcNPZ+HcoAkW4xgZxGM8QfQ2Lw8nEn3mJHj0DLcNbuQntjAp
	MrPAZPuNT+nnqdpBQa1mKQwfWVkcllFDLfp4cEyi3KWaiVeD3dqZHzIb4WScnkE7fUunPK9h8ek
	gbtF9wMVQ/RkLxoeL3+3xVMpxGWRAxnTDMATaifs5h2YtUNHEV0LXtbJj8ZeF1VxsEOyitoK8sg
	meMpKkXErQB8J8StQfIP55jT19ldk+sTda4GVQUbBPcHE+V2Voa6fJWkxLRrpSn21S57bRDQk5Y
	imyOM2mONa/X39T4LmCBH4wF45yzL
X-Google-Smtp-Source: AGHT+IHWjjjnvGCMQyiHrwuY7qYrjByD+x94DB6d6OoorDDQ+V8cuPmoT2p26TZIB9h6fNK3fjiziA==
X-Received: by 2002:a05:6830:8206:b0:73e:9d9d:8562 with SMTP id 46e09a7af769-74080537cecmr306315a34.8.1753212912449;
        Tue, 22 Jul 2025 12:35:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e8354df6dsm3515525a34.5.2025.07.22.12.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:35:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Jul 2025 14:35:02 -0500
Subject: [PATCH v2] iio: proximity: sx9500: use stack allocated struct for
 scan data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-iio-use-more-iio_declare_buffer_with_ts-4-v2-1-9e566f3a4c6a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOXnf2gC/53NTQqDMBCG4avIrJtiUn+gq96jSIjJpA6oKRO1F
 fHujR6hzOqZxfduEJEJI9yzDRgXihTGBHXJwHZmfKEglwwqV2VeSymIgpgjiiEwHtAObW8YdTt
 7j6w/NHV6iqIQVeWcdVhWN4+Q9t6Mnr5n69kkdxSnwOuZXuTx/aeySJHOSCyVtL4u6kdr1p5ax
 qsNAzT7vv8ACNTGCOUAAAA=
X-Change-ID: 20250711-iio-use-more-iio_declare_buffer_with_ts-4-66ddcde563fe
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3486; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=yRFRhMPm7jNLGGqB0LF4R3l3KyFeu06cYWiQMGcs2t8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBof+fpswTuivJAp1iQQuPyc7MzRJv3EIyU6cyBr
 o9RkiUpboqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaH/n6QAKCRDCzCAB/wGP
 wPhWB/97aMoX5H0VD5kyF7x8QAP7S2CwPjDf/F+Cjy2J7CXuJCua0lwwFw4RYadCaDz1do1Kbab
 QkTrxu4/VL/h5CtIXQ051zwdLbb3s+dpsvDWBpT6JUloArshE9J5v/kAg06MQkkgKAEEBZk2CKf
 PXAKiiowl5AX/KOcEK2aRU6A2iFlO5fDNxFGBwOXf1309UtVhj5nyHs+T2bDlG+YrXbmSgaz8Lw
 dRf+I45vVfwjB1beNRzmtm/isp0zDkKaaomuMM0hZI+FXNHDoV0pfIq043ytjVtZjoOOt1HhBpq
 TGEpH3kk71/jUD8RvJmMu/FX9KYjAPypFXoLNGoisae4jreJ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a stack-allocated struct in sx9500_trigger_handler() to hold the
IIO buffer scan data. Since the scan buffer isn't used outside of this
function, it doesn't need to be in struct sx9500_data.

By always allocating enough space for the maximum number of channels,
we can avoid having to reallocate the buffer each time buffered reads
are enabled.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Replaced `IIO_DECLARE_BUFFER_WITH_TS()` with struct.
- I didn't pick up Andy's review tag since I don't consider this a trivial
  change and deserves a 2nd look.
- Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_declare_buffer_with_ts-4-v1-1-1a1e521cf747@baylibre.com
---
 drivers/iio/proximity/sx9500.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 05844f17a15f6980ab7d55536e5fecfc5e4fe8c0..6c67bae7488c4533ea513597f182af504a22c86d 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -88,7 +88,6 @@ struct sx9500_data {
 	bool prox_stat[SX9500_NUM_CHANNELS];
 	bool event_enabled[SX9500_NUM_CHANNELS];
 	bool trigger_enabled;
-	u16 *buffer;
 	/* Remember enabled channels and sample rate during suspend. */
 	unsigned int suspend_ctrl0;
 	struct completion completion;
@@ -578,22 +577,6 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int sx9500_update_scan_mode(struct iio_dev *indio_dev,
-				   const unsigned long *scan_mask)
-{
-	struct sx9500_data *data = iio_priv(indio_dev);
-
-	mutex_lock(&data->mutex);
-	kfree(data->buffer);
-	data->buffer = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	mutex_unlock(&data->mutex);
-
-	if (data->buffer == NULL)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 	"2.500000 3.333333 5 6.666666 8.333333 11.111111 16.666666 33.333333");
 
@@ -612,7 +595,6 @@ static const struct iio_info sx9500_info = {
 	.write_raw = &sx9500_write_raw,
 	.read_event_config = &sx9500_read_event_config,
 	.write_event_config = &sx9500_write_event_config,
-	.update_scan_mode = &sx9500_update_scan_mode,
 };
 
 static int sx9500_set_trigger_state(struct iio_trigger *trig,
@@ -649,6 +631,10 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct sx9500_data *data = iio_priv(indio_dev);
 	int val, bit, ret, i = 0;
+	struct {
+		u16 chan[SX9500_NUM_CHANNELS];
+		aligned_s64 timestamp;
+	} scan = { };
 
 	mutex_lock(&data->mutex);
 
@@ -658,10 +644,10 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
 		if (ret < 0)
 			goto out;
 
-		data->buffer[i++] = val;
+		scan.chan[i++] = val;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -984,7 +970,6 @@ static void sx9500_remove(struct i2c_client *client)
 	iio_triggered_buffer_cleanup(indio_dev);
 	if (client->irq > 0)
 		iio_trigger_unregister(data->trig);
-	kfree(data->buffer);
 }
 
 static int sx9500_suspend(struct device *dev)

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-4-66ddcde563fe

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


