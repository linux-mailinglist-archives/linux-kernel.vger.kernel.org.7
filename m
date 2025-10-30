Return-Path: <linux-kernel+bounces-877686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE071C1EBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED99A404D46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E453F338926;
	Thu, 30 Oct 2025 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C3dX9SNh"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17444337B9D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809284; cv=none; b=ai8ekKzWrOxfS7zXZwA/8K7luhj6duTL79GuBBahfwhjaLHt82cY0qTvqEGGIN2hfhhPAoIq+HoS5aBonjgjTzwrbrB0PZHutXMO9FFNDgyYLWgQM4gnftRTY4XyjB+3GHlQsDbsP3JdEPIqr1kp/DDBNPbEjXb3VI5Fg/JhN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809284; c=relaxed/simple;
	bh=b7Dh9immXL0raytQ5VJzXmvSgU6Eg8zKWr14CvTFrQI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BCil9Lay/ZgOq4d+PEw+NZwbcvLkFatplqaE4+6WOsCJKVFZM5LdrC5k79W/CDRbB5b6P/q1c5UvKbdeMDRAHmt0I86A0DuvnuJKUO5IOq1WY75nuEOOkkRPT9G8u1ApZbUDtD2X/wm1spFFxZBDpPOTvGyDVhtYcVkYSIu+dUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C3dX9SNh; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso1365263a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809280; x=1762414080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QT0z8mODIZIMMuRwFEf11FLhr8FVbk/1fZHt5oodyj0=;
        b=C3dX9SNhczqtyCYSvYL5QQBAa7+SPSYyEJH1vomMZhVcNlTwD19YC/wUwVbl4+M8vk
         lprtnjdrdA2Dt/0R2T0hp/YZ0Rwp+7WRP57Yqjf6QxuUzt7JQrUg9w+a94BSaDeTy/ZK
         W05OkJq/nBNL3d+KIvFZS54k8NaaMfw5L7RW6jEIRC5RhTqB2L6yvxeppoJRFMV1aBvu
         VusShjPgEn/eAWXtrq/NU0AWcDf7Rb2r1ymR0woPxqkTSevvz1cByaulYzHFdeLbjabX
         8I3pMBVrR1Lgl5X+jppC5NmF0vo1vf6GP2mdbgaBY+otMp56qi/sw95nArqEuj1aP4C+
         WvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809280; x=1762414080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT0z8mODIZIMMuRwFEf11FLhr8FVbk/1fZHt5oodyj0=;
        b=h87WNlFm6ETSUHoBd+3DgsTPDirTdoQBLx8y0e1w69eg32uKa2V+xVJ5IzlRv6dWxD
         hcXlB3Zho0XJpFUpWBUqMoVwgpZOuAZv2Nh68YGJLKMH5Qz2vo0YztHg6CJzA10Lwcoy
         LVWOnTIv+w2mbpND91Ge8GyTAysRyc2o0IeueOkmm+A7ZkCltSdzQ3RCSbDfvKMWVtLz
         SxVb/Y5nDWS+9vaKeDWlVj5SvMvuHssN/81d0izqZQJCdQIYsFOClMA+U6T0DnJhkdHL
         g0rwafupQ41t5tyBbf2uQGaNe4IZ/+gWlLfXKp6yYfEMPKQiBNJBI6fUUW+aDv9QFTbB
         LhNw==
X-Forwarded-Encrypted: i=1; AJvYcCUg+tlhV15FpLPj6Qt1dBU+F2zUMogD9ecLEH+jCtakSEVzMu19nTF/w0qhLXXFX+p3z4wKqtWT5iTyib8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVBuAS0Y4Yk0mX9RWNlmlBv/wjOcApjcM7OvAs21sq7KfBDQQw
	+4b9XOSXNESOSrg0QnHs9YfI1acZcwgytBx8dUYck364ufEHZNeCdbIKzcoP20uXEFW+uvEUfF3
	xvoUX
X-Gm-Gg: ASbGncsGu6Isgv6Ym5H7x7JDtFtwFqm4X1WLSKqpE3MJzzaVaJr2Tg9aOft7cAiJu9w
	nHtmcwFJ/zQbNl/2/Ms+PBcYgBeg3uWUTE6hSPIUfeMeLIBACSw2l08QFmjH59t3Ocy/XVlqdoj
	A5XlRGgbc/20KKGt49EqBeo2x8UMlT+ZOJQLB1Ax97gug+Vpb//nhhLQjlyJQpHBEQQhtYwPNmf
	SHr3njR8X+15BudIHvyvjEEf+oCr4grL9KRIUrPmeOLh82H0yrQ7LGNDb1qThZj/Zb07okotzhQ
	u0o6vwlUtVg77I41EWg4BLHNNzFyZttTyuRINBjBW1Gssm7HXTrwVzu1Hauf7JPEEIOwBgsTYJ5
	GdefOFd7fzVcx91h4iNvk7xbwMtcrXWfotray0hXU4ypw74d5ZtrXSC/qgWJMXkPu4fYrFNioW5
	ALbLswVX2ptyG24HDkxMM0hZuBJw==
X-Google-Smtp-Source: AGHT+IE28vhagzBIqtsvFMlUCSlRCxRphCpZDF1Ly1iiRyJKZCT9Fu6Ll5Quw1HqsG9dFJn6ANMnnQ==
X-Received: by 2002:a17:907:2da0:b0:b47:de64:df1b with SMTP id a640c23a62f3a-b7053e097aamr189683066b.39.1761809280322;
        Thu, 30 Oct 2025 00:28:00 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef8288asm14128438a12.10.2025.10.30.00.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:28:00 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] iio: imu: st_lsm6dsx: remove event_threshold field from hw struct
Date: Thu, 30 Oct 2025 08:27:49 +0100
Message-Id: <20251030072752.349633-7-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251030072752.349633-1-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2449; i=flavra@baylibre.com; h=from:subject; bh=b7Dh9immXL0raytQ5VJzXmvSgU6Eg8zKWr14CvTFrQI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNK2vYG8vGV/Fkd4xN4etrjC5aDxbKlwjtbe g/iAEenn6iJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTSgAKCRDt8TtzzpQ2 X7B9C/9Dr35JbHqe3T9yYUEs/dpWOJDYkCA024XIf6eIPF2OaKWYtW7tl/o0lpmzEzazRXH+zEl O8HEcPNs/JSm1mg602ZOV0TO5C9FTNehbpBBZN7SdQZG7e3inJDqyxG3DAU8yHiigNmlVi4PcKU ialKHxEqWkVwj3aDHkblUBYRKxBy85PMnVo7MzaTTj7xeqs63A2VSL1imLFjZCqe0p1VPjKx/M9 m4I+OTDyeag7b2W5ZIKZ2y1goXaLvFwzzPrfuGB1fC7GpLKnlDwzrOo4JxV+plynLgnDn+UfObS teeVRfVjITra8nmFE/sdumDhBo/zw5VBWqhUnzi4T/Oxd85gz9vHgVN/eQghjLsGLSFmzl+X8l7 KAuXajxfiaEoN8UEs8IPxatmY5StDjVD3sT4+4pptEWXpecrZU9T5538+W6eFOeQ7qGizGsgBXW Ax8nyGxhNB3Vlmu4MW/LLOGJrc46RXHjoqolVPQ2VwXEUmkl+wKfPxqrOM0Qqm2+hjIsA=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This field is used to store the wakeup event detection threshold
value. When adding support for more event types, some of which may
have different threshold values for different axes, storing all
threshold values for all event sources would be cumbersome. Thus,
remove this field altogether, and read the currently configured
value from the sensor when requested by userspace.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 --
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 12 +++++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index ec4efb29c4cc..98aa3cfb711b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -398,7 +398,6 @@ struct st_lsm6dsx_sensor {
  * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
  * @buff: Device read buffer.
  * @irq_routing: pointer to interrupt routing configuration.
- * @event_threshold: wakeup event threshold.
  * @enable_event: enabled event bitmask.
  * @iio_devs: Pointers to acc/gyro iio_dev instances.
  * @settings: Pointer to the specific sensor settings in use.
@@ -422,7 +421,6 @@ struct st_lsm6dsx_hw {
 	u8 sip;
 
 	u8 irq_routing;
-	u8 event_threshold;
 	u8 enable_event;
 
 	u8 *buff;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 157bc2615dc6..ea145e15cd36 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1825,12 +1825,20 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
+	const struct st_lsm6dsx_reg *reg;
+	u8 data;
+	int err;
 
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
+	reg = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value;
+	err = st_lsm6dsx_read_locked(hw, reg->addr, &data, sizeof(data));
+	if (err < 0)
+		return err;
+
 	*val2 = 0;
-	*val = hw->event_threshold;
+	*val = (data & reg->mask) >> __ffs(reg->mask);
 
 	return IIO_VAL_INT;
 }
@@ -1862,8 +1870,6 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 	if (err < 0)
 		return -EINVAL;
 
-	hw->event_threshold = val;
-
 	return 0;
 }
 
-- 
2.39.5


