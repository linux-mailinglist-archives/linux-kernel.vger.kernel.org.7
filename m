Return-Path: <linux-kernel+bounces-746809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBC4B12B70
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 18:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624D4AA1C28
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD00628725C;
	Sat, 26 Jul 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LIWrLo2A"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FFE1E51FE
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753547345; cv=none; b=Bw/Kc1R++kmzOwUZWVvABIvkF5tAMnaaAu1Vsc5aN5bpGKFLrDFsAfvhkBWMpuX8non5I2hiI3IVynZOqMU+lCPN/JdlpM5kP8gmp+uIOmyyTHB/Gqbkq0QtE6DsTh4EnGP/iMADXAHa95ydWTLZmc9hTtmIRQ0TWTvp8k9VUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753547345; c=relaxed/simple;
	bh=pDxFtz0hgG3lWIVjF94plvVMN1cgZqmYxIabBIDSsGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Erq9LY9yvBQSbAQUXkzpFqOzFCvvaJsjv19B4kL5i1/VHztRnd0ppfocTV5GGNPWISev0wYhnDxCJDoJr+vavdq9s9iwS5YxtiddZNRWwgyisyFkpzLQai6OaGl5jP03OsEGRgAbDrlf7OuF9k42JqHIWxQBNJXOLiVLTV7pQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LIWrLo2A; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-41cd87eff4dso2059805b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753547341; x=1754152141; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt8DIM5xS78ws8oyJ2vjDrvCmaieqQ3QQrzu0A/RSh4=;
        b=LIWrLo2Ap8aXaTHh2m6lcTcY5Zib+q/U2ANqFyCwVaEJlvz9lsoNI4L195M04j0BOV
         FyGhqkB36vnZBdlCevwLO0jCFlNvVwAY1pye36v2eidf5AkFo2pbYxvcHylTe1aA7/nY
         7ycQ1wEOHHiQLDnXXc/f6prLk/n6i2QGx3HlLlKixxYW6eFTvNEREBYWBLoofI9feU+S
         X8DAykxpwhWCXzfHg9lW83NUrOwnBFbWUDKYF7nyC5c/TptF+wBMtZpakzmbIukRLNVC
         3n2QgYsiXWviub/n+6RM4q2/InsGKQQv9rSqe8wRAovbZ+lspo5aGy2WniKhC/AyKCiO
         jugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753547341; x=1754152141;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tt8DIM5xS78ws8oyJ2vjDrvCmaieqQ3QQrzu0A/RSh4=;
        b=btP3aAUrhr/8gCjirk4Q9yABDyGqmNuLy5SF0mYa+FyzX6G3FCrJ5w3DPeGnozwahu
         e0YsFrrbbZRkyzk0Q/Pi2py1VNQmdNgkF9sbM0F2OGxBIGurYA2JmrAImOnZWz3+G+ok
         zcy58foN7Ayg/40HMld8id5x53VCEYVKm7oRYQZ/24RA6sDdO5Jf07B9w7sXI/oaGLBD
         AFL0TeNQgsV+piobiHa0uFmQy8QgRsMfkpG9yM9P1lEX19LQg8tGT+RZ9KjiZKxiX2ZN
         qo4CCYJrr8SgFnl1N+uZ5in3EVXDJijLXXfdbvbOBtIMvVhYML6AvbKPQ104A14f/Vmb
         un+g==
X-Forwarded-Encrypted: i=1; AJvYcCWn89yeSJEyJzz4xCpyLvO+mdFXOczu4p+b540+bSDjVf7Wc6MGZfyrc9NCCLYsKReMHLZooNBmPLfugUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRS/DD8FbWl7PwbZvnAtZp3G3Nxdce/8X+IGvPcooL3ed8whEB
	0kjSJtENobImF477frgvLfpzV2LD3k2k2VzNmNNtCVu4qaV2e/PwBN78KRnKZ4Qk5jw=
X-Gm-Gg: ASbGnctKsBTMoEyXrDMVUQvIrQDuk+7zi9R3ghJiVoey0JmAqVv8lZPlE8ayzEcbWWi
	2PTlXDlxNe4MqEjYYFTXe5DdiYuv5WQVC79JlpfSPQlJ3QQfBa7Zl2P09Y7arwxz5KZnbKSSee4
	HxIapG2StU5kmsPZanSlMeuGQYuoMpZ2ER4Ty0z7M9QiZO6g3jKGpdZDAtpxN2GVC/yD0XCa76y
	neY8ohwScjThBFX3iU81vKvpEr9GmyLUvhrzMj9/sePFsKD3sH91d4LeWs+M4RUmRINMOaWmGQF
	OxR5UzW5iA8LQpmU2MdidZr2G+5xCFhmg9qf5u32cTLs0MotLT7DsGmOq2NH+CyyyZjEyXtAev1
	EYyYDee2OIFDDIAW8McgwTJc/pNzcx/LVK3f6nQ==
X-Google-Smtp-Source: AGHT+IHsIf1X1e+HWPM1mk7VjDLLG77GWLJnUylCV8XADXNuFHnoFI6iUSOqAMANV5v3YaOOF/3OGQ==
X-Received: by 2002:a05:6808:189f:b0:401:e6f0:a8d4 with SMTP id 5614622812f47-42bb70f897dmr3995875b6e.5.1753547340932;
        Sat, 26 Jul 2025 09:29:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:63fb:769a:c359:cee])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-42c7dfa1335sm393612b6e.41.2025.07.26.09.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 09:28:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 26 Jul 2025 11:28:48 -0500
Subject: [PATCH] iio: adc: ad7124: fix channel lookup in syscalib functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-iio-adc-ad7124-fix-channel-lookup-in-syscalib-v1-1-b9d14bb684af@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAD8ChWgC/x2NwQrCQAxEf6XkbKBN1aq/Ujyku1GDy27ZoFhK/
 93oYQ4P5s2sYFJVDC7NClXealqyQ7drIDw43wU1OgO1dGgHOqJqQY7BM3S0x5t+8FfMkjCV8nz
 NqBltscBJJxQ6hXPfC0di8M25ihv/v/G6bV+WuamPfwAAAA==
X-Change-ID: 20250726-iio-adc-ad7124-fix-channel-lookup-in-syscalib-e28c933ead2a
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2986; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=pDxFtz0hgG3lWIVjF94plvVMN1cgZqmYxIabBIDSsGU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBohQJBIBbr7Ov+4fb76UOJ+XqijmHrKSl5+ybHM
 K8SCfKBneKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaIUCQQAKCRDCzCAB/wGP
 wPWqB/9nVCG8l56TvtkvJnz5/czlEucoVGTyPpsgl3nTgbwU5akqO78Re47vuImaLAeg66d9b7X
 qBMR4UFuczEhcIE0qupbzdm1UVI8g9JchX7YMboGb6Mux4JpjdFdm0U47C+XHdmq9ZxOBNWy2Ra
 TfrpX5DGLYiEoixdOhGeLZ+rZvm2x/+rHIm4D6M36HpBo8Sz/dyNVuTt0F0+tOXZXizO8bmfLOF
 hIsPh2K3jzUTPoJInBcr7i5ntHo+0aEDQZA7QgYP93aT8p4tvlJ7iKifoQkUkQ5Nw8u6ECYg5d7
 NB5aVnXo627VVjwkvejlE8XGWf+ZeyuMClQme57XXoa5AOKQ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix possible incorrect channel lookup in the syscalib functions by using
the correct channel address instead of the channel number.

In the ad7124 driver, the channel field of struct iio_chan_spec is the
input pin number of the positive input of the channel. This can be, but
is not always the same as the index in the channels array. The correct
index in the channels array is stored in the address field (and also
scan_index). We use the address field to perform the correct lookup.

Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at probe time")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9808df2e92424283a86e9c105492c7447d071e44..4d8c6bafd1c3171054c72a0d2b13d6b1afc4e51a 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -849,7 +849,7 @@ enum {
 static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan_spec *chan)
 {
 	struct device *dev = &st->sd.spi->dev;
-	struct ad7124_channel *ch = &st->channels[chan->channel];
+	struct ad7124_channel *ch = &st->channels[chan->address];
 	int ret;
 
 	if (ch->syscalib_mode == AD7124_SYSCALIB_ZERO_SCALE) {
@@ -865,8 +865,8 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
 		if (ret < 0)
 			return ret;
 
-		dev_dbg(dev, "offset for channel %d after zero-scale calibration: 0x%x\n",
-			chan->channel, ch->cfg.calibration_offset);
+		dev_dbg(dev, "offset for channel %lu after zero-scale calibration: 0x%x\n",
+			chan->address, ch->cfg.calibration_offset);
 	} else {
 		ch->cfg.calibration_gain = st->gain_default;
 
@@ -880,8 +880,8 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
 		if (ret < 0)
 			return ret;
 
-		dev_dbg(dev, "gain for channel %d after full-scale calibration: 0x%x\n",
-			chan->channel, ch->cfg.calibration_gain);
+		dev_dbg(dev, "gain for channel %lu after full-scale calibration: 0x%x\n",
+			chan->address, ch->cfg.calibration_gain);
 	}
 
 	return 0;
@@ -924,7 +924,7 @@ static int ad7124_set_syscalib_mode(struct iio_dev *indio_dev,
 {
 	struct ad7124_state *st = iio_priv(indio_dev);
 
-	st->channels[chan->channel].syscalib_mode = mode;
+	st->channels[chan->address].syscalib_mode = mode;
 
 	return 0;
 }
@@ -934,7 +934,7 @@ static int ad7124_get_syscalib_mode(struct iio_dev *indio_dev,
 {
 	struct ad7124_state *st = iio_priv(indio_dev);
 
-	return st->channels[chan->channel].syscalib_mode;
+	return st->channels[chan->address].syscalib_mode;
 }
 
 static const struct iio_enum ad7124_syscalib_mode_enum = {

---
base-commit: e4d9886ad25adae72f38f2b12f41649b101581ae
change-id: 20250726-iio-adc-ad7124-fix-channel-lookup-in-syscalib-e28c933ead2a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


