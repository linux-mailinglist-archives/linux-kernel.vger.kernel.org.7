Return-Path: <linux-kernel+bounces-877685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0924C1EBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EE61895F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B255D33859A;
	Thu, 30 Oct 2025 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vPizLmos"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E540F3375DC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809282; cv=none; b=Z6G4MucC+iteroQukqcXGzZAfGN4/133hzk1BAYT/eNg91gk1yf2dEMgkaOzLw8pDPtq6fIXfyFMQvrV6mXLn1Wq8ErG/gLU8yI+rYPKj0nm1YYjcQB2lf46bstkbwte1HLDP+McFLfFEZkM/tadBdKQ1fkCv53rL01Yb4is5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809282; c=relaxed/simple;
	bh=Q+pY5HlZqzp8d24g9WNWApNUCq5yqQgOxp3B34hW/uI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mwn7ILi1LE6LZwssfKfi61nS7cHqTXC7X61kx1Gf0jtFxpz8k+ds60SxcXIUpbqvGjk0qa45YjCfsIHp3BMFeExuqya67r68nC1RWFpDhnuk8t0a+t+oy6hkQCtb3WD/c4RfUdmtX7Y0fPyhte/ahqQnpelUf5UgskjkGy9Y25s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vPizLmos; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso121844866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809279; x=1762414079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eykfaIYOJ1O3INq90WvPnPMlXLtVxr6TQYwO1to6mmA=;
        b=vPizLmoslaMEXu41tuytJwx1CBYYAOawuFJCrVrShp7ZmabAMBacMjHYjbsYy3XIfF
         n56b7G85d2PwvdWPqUvRB6ZscyE3rb34jawwJrjiLK7v7RDLMCX6Ssyk+B5UVG79jYBZ
         ZTt4pwbcfyfKo3m2R9mdTWoRJOmp4ay0nHTMk7XGeBtVeoR8GxPUGZHa8k5INmKQ7Wk9
         pzV9dHq6Ca+vgy7QxiwXMP5fom0bC3ym8fthGPtADH4NYdqF/EzPVNPjQzRnhzJVFzc+
         uVZ4ewtRmBlYOYG98HMg9ftfDBJp+7wN/I2XIe4Q/E0/PSDKDwZBeDeSTGO1M/i9Faqs
         zxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809279; x=1762414079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eykfaIYOJ1O3INq90WvPnPMlXLtVxr6TQYwO1to6mmA=;
        b=A3ioVsBMibFoHHLosoFP1sUpyIEkRQVECzjY7WMviNa+NQD03rL1JMZ//oIrksUZhQ
         06JePrnpnlWRmbtu0ZsVRdLxtd9Ml1TK5350JRDVjyHUgAC6DHrD62mNNwWkjaCjfd22
         SA3df2W5S/TmpqCj1kv8N4Y2IFTt03GEDfYk9VZLJNID/hGBIBs7Oet2FFzBpbD5LHhr
         xr0bnKWaDaYHBBVg/OVXfcqhdrTIneck/rp4NUu9ERvKMS69YxKhL9j5lj4JFOsHAm1b
         kf6z9jm0r44gd9o8ZH8WjAO4XPbZkxubeyhTmCd02+nMtJ6TB3DodvpyPKIMkQDHAZ1U
         YW3w==
X-Forwarded-Encrypted: i=1; AJvYcCWmEeHfzr73UQZtjc/XDYks05q5MedDMY3SuokKq84Ph7pjLuoZL8nCl3KSYniJQAolMn8WF/CdYLu/5UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Hy6+8mupZC89MxmLDJ0KHn5NyUdfoXRlNpQn3dOX77cowi95
	PrwvfUfGVQLRi0c+DSXH3LS+YwVwE1UFC+tdAZ/OHCUX4Zj/6pzNQVh2p/0joODjk/Y=
X-Gm-Gg: ASbGncstCyYiOrM2tOmfsyuJP6waDTp63BBEPaWRlmj5hS8BVB5T0HiXxD8IbMSuRT0
	yExdMF79l3sAihSBMhxyK+RvQNOlQZWh5lgP49Q9/R5zXi3Oe8BxJIWyYE6z5fSUY1H0VEatjQj
	nmAPkjMUTL+bCDOQPB7TBD9wFZiFdr/OsTVF5fM4d9W17Gq5wUMZ1QojAcg4NDxhyBUvJRO2FIP
	Z/s4zYjllhMccEqPDLTjrWkKXKdkFD8tZEA/ScgNc9UB+41NMYhUD6YOoQjmHK8eqm3gCHMIYWe
	Yv0eoUbECUNaKSClXkqStqaCdskvWaFixKcQgkCvXuEFrNE1q80w14KpyztdwX3iTkPpQ8iT+/g
	dgmcGzjzxVOGGlIPf3P3iz8w/rFC6YRb4/fDD7AkW2Mi/I5jIrNVGEw7RuKPkSApALBvEfDfP01
	0cJ7cjdcJ6XXhq8+PJ+rYv4p4Hfw==
X-Google-Smtp-Source: AGHT+IHYWU9UwqdXA1AtOzYeRK4XQDCqB2oVm2eTFxu6lZwncXbBg4xxA2xQx+z3ZdHxqH2Ww6Djtw==
X-Received: by 2002:a17:906:7305:b0:b41:e675:95cd with SMTP id a640c23a62f3a-b703d2da8dcmr670932066b.13.1761809279239;
        Thu, 30 Oct 2025 00:27:59 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8536968csm1685933366b.29.2025.10.30.00.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:27:59 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] iio: imu: st_lsm6dsx: rework code to check for enabled events
Date: Thu, 30 Oct 2025 08:27:48 +0100
Message-Id: <20251030072752.349633-6-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251030072752.349633-1-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=flavra@baylibre.com; h=from:subject; bh=Q+pY5HlZqzp8d24g9WNWApNUCq5yqQgOxp3B34hW/uI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNJKCWlxgi4/ZnYsQDZ4vSnVm8krv2CHT0fN us7wnzgonaJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTSQAKCRDt8TtzzpQ2 X6S/C/9vHbJkvEDDf4MRA1ZyOsLosL+qRvBHwdceDO6Ecw1q9QByAliTbIv+Lkjwz8uD3lci/oq wgS1zTlMzkVcwQiM4E3HGDIqEYLiQrGoTnIFlTMfRJYrOJZIHzX9HcAEsqGKaf230JzEsxipoQu E6YrD69YFpVxeJIcIhNqIB554PB9f0Cz/nORQRFASxd5KKjq1NcOlT0jQtQXsN9UVsmEBLrvNY8 YCz0mFrpWbYuiBdQcNz7OQBaKnd5/Qdfa8N1JNdt1JDwejj3hPuezzaABNN9p+qgs3wHJ44xmAQ ece9ybp7LEIgcM7Dlunsdg6ROtMr8N+cXYBFbIjTh3+bJTbVOBX1b7/Ig6TKFtg/uqVLiZHjHXV 3MUHzqIUajFzeWa7gmsRm+tGzFdrDPCfLpYFO4Ls4v9zqKMelLVjq22bTXTHzD0NhYAgCI2XGbV mfTMph1i6dPwqMMRk7xbR4vy886UHiD2Fu2gnA1xNaXM2RH2Dl95aQyt6XFgPHQEJnfQE=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The enable_event field in struct st_lsm6dsx_hw does not lend itself
well to handling multiple event sources, so it will have to be
modified to add support for more event sources. As a preparatory
step, remove references to this field from code that does not deal
with event management; rework the st_lsm6dsx_check_events()
function so that it returns whether any events are currently
enabled on a given sensor.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 76025971c05d..157bc2615dc6 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1670,11 +1670,11 @@ __st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
 }
 
 static int
-st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor, bool enable)
+st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor)
 {
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 
-	if (sensor->id == ST_LSM6DSX_ID_GYRO || enable)
+	if (sensor->id != ST_LSM6DSX_ID_ACC)
 		return 0;
 
 	return hw->enable_event;
@@ -1683,7 +1683,7 @@ st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor, bool enable)
 int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
 				 bool enable)
 {
-	if (st_lsm6dsx_check_events(sensor, enable))
+	if (st_lsm6dsx_check_events(sensor))
 		return 0;
 
 	return __st_lsm6dsx_sensor_set_enable(sensor, enable);
@@ -1711,11 +1711,9 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	if (!hw->enable_event) {
-		err = st_lsm6dsx_sensor_set_enable(sensor, false);
-		if (err < 0)
-			return err;
-	}
+	err = st_lsm6dsx_sensor_set_enable(sensor, false);
+	if (err < 0)
+		return err;
 
 	*val = (s16)le16_to_cpu(data);
 
@@ -2743,7 +2741,7 @@ static int st_lsm6dsx_suspend(struct device *dev)
 			continue;
 
 		if (device_may_wakeup(dev) &&
-		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event) {
+		    st_lsm6dsx_check_events(sensor)) {
 			/* Enable wake from IRQ */
 			enable_irq_wake(hw->irq);
 			continue;
@@ -2774,7 +2772,7 @@ static int st_lsm6dsx_resume(struct device *dev)
 
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (device_may_wakeup(dev) &&
-		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event)
+		    st_lsm6dsx_check_events(sensor))
 			disable_irq_wake(hw->irq);
 
 		if (!(hw->suspend_mask & BIT(sensor->id)))
-- 
2.39.5


