Return-Path: <linux-kernel+bounces-585926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F4A79927
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 01:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593EE18857EB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 23:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184181F8921;
	Wed,  2 Apr 2025 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dpH1DHpc"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643D61F8744
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743638188; cv=none; b=r4PciknX2odl89WIticav1/lnr7GZcQwjwSN04xaWOTTK9ekXmiAmjZvtApDMoswB7Dl7Sn2pU9IwaqOsjXRrXWUdIW/VCOrLoXzxwfNKlQCFbnw91WEbqUWlDJidZtfc2LWFne2bT250N3dt1OfFqRVxemqsxwgEYfIBZet6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743638188; c=relaxed/simple;
	bh=uiizrBkkBTqW3XgNsdY+NKHr9C+xFnQzIJMmto1lSL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uWPujAHiuaBRzjBGYcvJWnFRqwXGivYy0xGqOpsem/4oD2hQh5g5dcre/2+pzv/r7ITOx7IKf31C11l6hWGxsGJ/sQeGkXFv7jGWRvx+2cBQt6/g7xIRVX2rqeUQVI3gjGud/6GqcgfC7h2VeJQiInHOxHlo2oqTqyxaKF5u6xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dpH1DHpc; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72c0cf1922bso57830a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 16:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743638183; x=1744242983; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U84fsGmbM0MYlvtDoSFJcWVBHsJh/MexnRXMIlE8VF0=;
        b=dpH1DHpca1nitaWCr18zuw/64GnG8wadNesVW/dntc5vV1MnXG+zfR+YzlftRCoPFR
         vcSIltzhihU6rcgc79F71KTPsms/2qI/ZjfM1Qi3D/zU5M/5P96z6TK1+jjWK0EEifaU
         vZEQ1NYkkDUojDuszZkLxVlGq3/HrQMuvLUGXYFNWpwKObh9anTzUGOgvBl8Tl79FnFs
         GcPsplnsqWTkhDxLsD2AAHflF/dlGDL4t4ZMGcSQ6DmhayFP8bJ5WjsRMqhhAx4pk5w6
         3+akVkD5S0VjJ1SyyHlNR/XnukD8qa+lSWO4ZgWhfBEIN8ugtJLj6EQpssgAsu/nKwf3
         SIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743638183; x=1744242983;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U84fsGmbM0MYlvtDoSFJcWVBHsJh/MexnRXMIlE8VF0=;
        b=reOsGt5g6Z4403Vk0qFkvU2HXtsmT+z35ah3DWTMuws10kH0WdjL5hgi8wyhQbSKl3
         CzW5/s8qIZ5/KMag2QvjWhKFMRdGwsgMyfVav9VmBnt1HRtONk/qPcZUCxpZs1+D7Sb/
         YS3TBshL9bV0/IaTn55tr3KQ+56owUPQYdQyLx1lVu6KSLjV9BIEjUb5/T2pBh7gTgbN
         8h4YdX/Iml7wTi24PeCoL7yDRffF0WLFaLcKJMBU4Z5MpHw6oH44QvAG6TkXEig9UZ6E
         odg+7UC2J9nqIUrO6m8vlZFEOZ61Xi1vZVoj7L1UGCbnqydwF+GXh/rXX6b9Byhcnbfg
         OHZg==
X-Forwarded-Encrypted: i=1; AJvYcCXxugOAgb4TGHJcv0Qv3WFz0V7g4PxQiYdFmvjnoDIc5auO86Cu6g1FN001Rt81RBUf9USI4DXjOQ41NSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNOISHsGprD4eU/LYxWjvjmLQW7u/KU8DdIPVwufGwEvHwINWr
	9rWQWgu7Qtgvs1RKR+K6sLyjPba08hzDSlUs4oOvrbpkVtw+/3DqF/RQHyoIsTtlHpI/Ukkpi6t
	fYYY=
X-Gm-Gg: ASbGncvFsRYEAb6QEWHHGSXmq/WEMTtQcR0N28jVArninMGjJmgFfwEX6qyZYEw+6oO
	uvgP1bCcA9N/ElktBjcyR0abnhF+sw0gms62EZwiy0LcPL6YZiMhz29diIiYQGJYNlMcrPXHOWU
	2nZXu1rij7xjVoPv964YFhLnMdCU1aMap2UtKIti/UbFA7SRjDPph2Z4CG8BwfevQZN+7oVl8CQ
	unA1VBV7EsPkMSVCEQONrvYbfkIK7XgSoquiFA39+MpikbN0CJAqaZm+iEN5Gabs5GDw5O5+gPK
	k269BIuF3b9TRUHzVomGZEJ2cOpQ4FHIoTXplwdcS93ZlBIF9VR+4NSYmEQ4ukf3KxSOgQEh1dw
	M
X-Google-Smtp-Source: AGHT+IHxwavlcu3eVlrKaPi0mNNmlbrWHSl3n8JBOTFFwrww1D/K6A1MV5UrnbV0rAf1H/jNtJ/cAQ==
X-Received: by 2002:a05:6820:1849:b0:603:fada:ac47 with SMTP id 006d021491bc7-6040b699933mr372311eaf.1.1743638183135;
        Wed, 02 Apr 2025 16:56:23 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6040c58f694sm46205eaf.30.2025.04.02.16.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 16:56:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 02 Apr 2025 18:55:58 -0500
Subject: [PATCH] iio: adc: ad7380: fix event threshold shift
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-iio-adc-ad7380-fix-event-threshold-shift-v1-1-ad4975c296b2@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAI3O7WcC/x2NQQrDMAwEvxJ0rkB20qb0KyUHJ5ZrQbGLZUIh5
 O8VPcxhYNg9QLkJKzyGAxrvolKLibsMsOVQXowSzcGTv9JEHkUqhrgZ83gnTPJF3rl07Lmx5vq
 OqFlSx/Xmpri6MNKcwOY+jS3+Xz2X8/wBsgAs0XoAAAA=
X-Change-ID: 20250402-iio-adc-ad7380-fix-event-threshold-shift-b614db1a307f
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Julien Stephan <jstephan@baylibre.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2994; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=uiizrBkkBTqW3XgNsdY+NKHr9C+xFnQzIJMmto1lSL0=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn7c6PQwT/FsqVTGfQ+Cy2P7sFYLqv9X/lN5muy
 RCBYSwd77yJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ+3OjxUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAPjig//aH3rHftvitgIbG1fMeJqdqD5hG4fTb59GJse2Wm
 nAdW0NWgLl1M0OyQTrlAAKqLPB6NTx3Ewb0youn4YLBnQCGwWWD8AwBkbzl93uPDZn0dO8VSPdL
 pQ/Gh91TFDZjXM1YehCUPc+3o/9NAhTjip72kktBi+KbTaTbv1uQSwsauADVjNcF3Fgz30tCYKV
 Fb0NW3SuidglwqTWn6+cnT7KYjOtB/ruuI16GvT1IjEa0JR8EPFpVdL8CCF5ZZxSfKu56zbAzg5
 Y0k4THWlgpk2/Jj0tYlhNCmRN/7QjwDd/nAPl5p4LjewYjFFzs/3b6RM5dAG7ACQLPpP78ryCpM
 85wL3OCNA6SW7Il7qJi1V8AmsSq3h/nCApdWlQNnfDA5SKmLwj/ipmvoXu/nZ+TOEDZ3yolDMD/
 3x2nUCIJqRoHL2A2q8St7bjyXOPi6pierP6gELmyxbnkvtkb7iskE6jZDs7YpT7PaT0w+fw0CYO
 1C2UqcJCYii4AO1EjnXHolb6IX3n4I9boWzZJO83rioQXqUICb2BAQPIh6TghTLqsuNMq7if/KB
 kD5LhYswrsc1UxhuZVGgoGUssAf8lAnWDsvKZ8YXA4rLLsD7XPwO8gWlnbyw2noUEtXWpBQa+Ip
 UFWCkcmmI84VN/ozIbiZwLqo6tg3rtqwalsCMOtjfhrg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add required bit shift to the event threshold read function to get
correct scaling.

When alert support was added, the write function correctly included the
required shift needed to convert the threshold register value to the
same scale as the raw ADC value. However, the shift got missed in the
read function.

Fixes: 27d1a4dbe1e1 ("iio: adc: ad7380: add alert support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 4fcb49fdf56639784098f0147a9faef8dcb6b0f6..f3962a45e1e5b88cebf712cc867fbb576d3ca058 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1611,11 +1611,25 @@ static int ad7380_write_event_config(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int ad7380_get_alert_th(struct ad7380_state *st,
+static int ad7380_get_alert_th(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
 			       enum iio_event_direction dir,
 			       int *val)
 {
-	int ret, tmp;
+	struct ad7380_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	int ret, tmp, shift;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	/*
+	 * The register value is 12-bits and is compared to the most significant
+	 * bits of raw value, therefore a shift is required to convert this to
+	 * the same scale as the raw value.
+	 */
+	shift = scan_type->realbits - 12;
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
@@ -1625,7 +1639,7 @@ static int ad7380_get_alert_th(struct ad7380_state *st,
 		if (ret)
 			return ret;
 
-		*val = FIELD_GET(AD7380_ALERT_HIGH_TH, tmp);
+		*val = FIELD_GET(AD7380_ALERT_HIGH_TH, tmp) << shift;
 		return IIO_VAL_INT;
 	case IIO_EV_DIR_FALLING:
 		ret = regmap_read(st->regmap,
@@ -1634,7 +1648,7 @@ static int ad7380_get_alert_th(struct ad7380_state *st,
 		if (ret)
 			return ret;
 
-		*val = FIELD_GET(AD7380_ALERT_LOW_TH, tmp);
+		*val = FIELD_GET(AD7380_ALERT_LOW_TH, tmp) << shift;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -1648,7 +1662,6 @@ static int ad7380_read_event_value(struct iio_dev *indio_dev,
 				   enum iio_event_info info,
 				   int *val, int *val2)
 {
-	struct ad7380_state *st = iio_priv(indio_dev);
 	int ret;
 
 	switch (info) {
@@ -1656,7 +1669,7 @@ static int ad7380_read_event_value(struct iio_dev *indio_dev,
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
-		ret = ad7380_get_alert_th(st, dir, val);
+		ret = ad7380_get_alert_th(indio_dev, chan, dir, val);
 
 		iio_device_release_direct(indio_dev);
 		return ret;

---
base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
change-id: 20250402-iio-adc-ad7380-fix-event-threshold-shift-b614db1a307f

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


