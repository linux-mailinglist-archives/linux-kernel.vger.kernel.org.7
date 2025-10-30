Return-Path: <linux-kernel+bounces-877684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130AFC1EBF1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E23404990
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D857338598;
	Thu, 30 Oct 2025 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vM7oIt6H"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35AE3375CB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809282; cv=none; b=lv3vehRqRfwjC3bokxkxIyGysMWnNWmiMK1ZOCchV0OUcRHJnUKLtXDo4AgZ8Qu8UwqW3VkJYs4bb3zKiDjwuZgBuma/w1V0a9XaiIwMyvJTivHO5M9nG1VFcmKz4qND0LuTrWYjda/lLoU1/KnNkCdk1ujdz1eVYK0m13FGzEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809282; c=relaxed/simple;
	bh=x+eFJ5CRKeqdWM1Y7tN74EI8+EOeuEga+N/lyxWUhz8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LkfiwlmiIIqkTPLxpsd7RVtzQkgjm1+5sy1dFiYrJ4WsFi52XSyq6e6vX+jU7C5DicSd9ulGW+YlrBwybI6qHONUPOXBN7C4HZDfjx3P6DFuiNbqBGf+JUaEFXB/rn0kWZSTkfiRS1eF0kjE/uBRF4uZLg7/zNbxWKt1ieaQd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vM7oIt6H; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso1449625a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809278; x=1762414078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLXdhud06hc1AMj54Ir7llR8segcukDw5Qg88c3Ij68=;
        b=vM7oIt6HpcWdxg+KLQO5HZNpYkQkGWu5lr0fi6/zoNQ1Yk2QG+AkqDvIEE5lTfPBnp
         xJw0I9b6ezM25XE2Uuch8HrsUely1ZhqXPjqsne5dOTIbkplyNlJ6RfrtCK2Hw9vjGri
         B0m3ftlSOdwIhENKir4tuBQNYil/1sJF/Qdc+mMBmWKeoPMFvqv/n+Sw6/um0/EUoBuX
         gBkAVo/UOWFOJ0HRgIwHnFFnxRfzQJ3xvlSmYKWpL7TuSXCJpE+w6PMXQ9lvYBxH6dh/
         C75/9QYem8zWcCEuK4LI/KTYmfrz0+QIFB8qiRCKcNNVDoPxbC3LyYHpOiz+fKEhpgHQ
         GYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809278; x=1762414078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLXdhud06hc1AMj54Ir7llR8segcukDw5Qg88c3Ij68=;
        b=Y+0EubvBJ7QrI1gOInkavmaHgIriLqFL19G70qVHz79RWNjRtTCLeJtvHo1yGkBKyA
         3pvEsU7uEO4YB0Voxm4KLxdpccMvRaujIH6TZPfIMDHtAp6MecbSaIdi4OGtOJiqPYFr
         Cg8eEE5ZSt+Ij2zZxVvql/gXDf+NRiUGsfcd5ECpRCkb5XpCh186A7/Chgnrg4/CZeUx
         nL48srwlsuyfSgFTLozZUOOtS6iwO02eTWzJps5YYBJ9NCfaSTycBEa+z/CDiIZ8kfwR
         bvgWHbc0XX3KUr12JDV6A0Dnl+qB6TpHsqcEXh0ObwVSoTQuFq3VeKG5rslLKz8mloIo
         AKxA==
X-Forwarded-Encrypted: i=1; AJvYcCXL2owcwQqX5zq/sBnXzNqdFXHbjh6x/SsOY8dBTwK8Lp2j4rMSrEQM8Fd5T1UintO14QEmU8L6Z1b+dH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/pXf3B7SstTJR3Ln8HgLnzl4atuyoZ75sZOfkwNNkHSljypV
	kRkGkch0i2xnnhFJfHnAMX+kDxsHjrmLFnsA97dm33S4LcESQByZNavd5xrxCtgB9SE=
X-Gm-Gg: ASbGncvOvgu/9i+WLICufSxN7V8D0cm/pdru6WZh3xY8FleBHuwvp4wPslonofmC6Th
	gofWuYYS4dw1wb3S3erJEaBi9TXM12aFZ0GkKAohMZNe1Bz9vb8l5brg1iwt/OQ0PxZEY5n7nkI
	+zbGS2S3g1sz1zkI7SnIK4S4RRtJI0MVgwMe28eavqiRm6bH3wSRACB8ZCqyHsyGl92i7QaejNe
	iqiBLpEEoY+RZV+LTuXKT7F4U66GBSlFVCajEUIin7gd96Emv3GE6HG13BatM+FclP8UKV+dl2k
	X5Gm62qPjI5ewVIhgB9VFjufwrqaBO9f4gFfcbZLHbdbzImfqfBhRg76PNubYhG+urEU9nkfOPr
	2S74KTfcWTRiuxfCIS8TMZHo6YiTVSQtks8iB3K9Jx+g9ILVF177vw6OBaxjOqGsNoqeKDui4DI
	ztDrg1V2PcSQzAoYzMv+77MM7GRA==
X-Google-Smtp-Source: AGHT+IFr6vPTfwZdxgBXVeICFNNLmr7TeiCI1sGmzOnlC9S5yEfJX851jXjNAaip4xMKi8WpCjfeLw==
X-Received: by 2002:a05:6402:2711:b0:637:ee5f:d89e with SMTP id 4fb4d7f45d1cf-640443990b3mr4556099a12.20.1761809278219;
        Thu, 30 Oct 2025 00:27:58 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63ecf3686c5sm8034374a12.36.2025.10.30.00.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:27:58 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] iio: imu: st_lsm6dsx: dynamically allocate iio_event_spec structs
Date: Thu, 30 Oct 2025 08:27:47 +0100
Message-Id: <20251030072752.349633-5-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251030072752.349633-1-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725; i=flavra@baylibre.com; h=from:subject; bh=x+eFJ5CRKeqdWM1Y7tN74EI8+EOeuEga+N/lyxWUhz8=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNJIJY8+sB5pNRhti3rWg61By1DSPqWWm4su tU6e1YEkpSJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTSQAKCRDt8TtzzpQ2 X9hyC/4t/k98okusX9PWyJbekqmq7Ihh/vhHJ2mPraEdj5pJoETotg7VEaxgirOPCPrfpqa7H+X EnR5PzveLRB7A1ULLZSVtp20fN0a59g6q3JPPfHcqzS/F1DFaKxTcE/pmo8oDvyPzWxV/oBa93s lbAjXmKSIkJ6TgwxgygyYIt58TmQDxA+VZTAEeQlmh/ln+LYrNsCxS9XlKCiOe8lZ0UioZirPP1 rKiPXZypu1SBPZqzsTKQaBwZlgeuK6/+/xYzOeA0rzvrIKTiL1mHUl0ipIoT9rYAE3BgNL6fIFF ma3qsZVkP5YucRy7OHc/ujcPo735DZPfkw2CVKksWpf0VZ4AAyK4rLuYPisP2i3bdhXkg1rCG0/ GFAb8SXS/Nt7Zn0qasQJ4GUkBxD8htBSb8OKOI2SRzw46Bsa4rjSb9yryeSECY8TgZqstIVSG0m OptwKSrsD9yLrnpuE74eyueH+ogA+FKZM2bmCQCkVO6E+kdtY5wRb/0Ec02RUzA5FRbqY=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In preparation for adding support for more event types, drop the
static declaration of a single struct iio_event_spec variable, in
favor of allocating and initializing the iio_event_spec array
dynamically, so that it can contain more than one entry if a given
sensor supports more than one event source.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  7 -----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 ++++++++++++++++++--
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 5c73156b714a..ec4efb29c4cc 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -439,13 +439,6 @@ struct st_lsm6dsx_hw {
 	} scan[ST_LSM6DSX_ID_MAX];
 };
 
-static __maybe_unused const struct iio_event_spec st_lsm6dsx_event = {
-	.type = IIO_EV_TYPE_THRESH,
-	.dir = IIO_EV_DIR_EITHER,
-	.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			 BIT(IIO_EV_INFO_ENABLE)
-};
-
 static __maybe_unused const unsigned long st_lsm6dsx_available_scan_masks[] = {
 	0x7, 0x0,
 };
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 4bae5da8910e..76025971c05d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2314,9 +2314,33 @@ static int st_lsm6dsx_chan_init(struct iio_chan_spec *channels, struct st_lsm6ds
 	chan->scan_type.endianness = IIO_LE;
 	chan->ext_info = st_lsm6dsx_ext_info;
 	if (id == ST_LSM6DSX_ID_ACC) {
-		if (hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value.addr) {
-			chan->event_spec = &st_lsm6dsx_event;
-			chan->num_event_specs = 1;
+		const struct st_lsm6dsx_event_src *event_src;
+		unsigned int event_sources;
+		int event;
+
+		event_src = hw->settings->event_settings.sources;
+		event_sources = 0;
+		for (event = 0; event < ST_LSM6DSX_EVENT_MAX; event++) {
+			if (event_src[event].status_reg) {
+				event_sources |= BIT(event);
+				chan->num_event_specs++;
+			}
+		}
+		if (event_sources) {
+			struct iio_event_spec *event_spec;
+
+			event_spec = devm_kzalloc(hw->dev,
+						  chan->num_event_specs * sizeof(*event_spec),
+						  GFP_KERNEL);
+			if (!event_spec)
+				return -ENOMEM;
+			chan->event_spec = event_spec;
+			if (event_sources & BIT(ST_LSM6DSX_EVENT_WAKEUP)) {
+				event_spec->type = IIO_EV_TYPE_THRESH;
+				event_spec->dir = IIO_EV_DIR_EITHER;
+				event_spec->mask_separate = BIT(IIO_EV_INFO_VALUE) |
+							    BIT(IIO_EV_INFO_ENABLE);
+			}
 		}
 	}
 	return 0;
-- 
2.39.5


