Return-Path: <linux-kernel+bounces-814472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA50EB5547B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36EBAAA86BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD7B3168FC;
	Fri, 12 Sep 2025 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QNWfob5h"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B413203A1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693226; cv=none; b=ehIqkVjFyq1Vw9GivLOhMfSNGIa35Sitnv1yvnMsoTP21v5mS5GsMmJ7ZUQTg4avfGvg5Cdwm6OijmplVx8nIr6NRTtqpW6vqVzbXFXk/jwvWIhPDRfiC21h9w6WLW1LzkHBF7yTIqK4smHrnUpZkhaW7fwKae8+MJQxy7C8lGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693226; c=relaxed/simple;
	bh=6mdeYyd3hF07QuqGuLzQcOwjnfUK2lpqXDhP/AFlcKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XtrBM/x9XX3+jtu6GwfJB1UlcUJ161PhbiZ0jZwbWcFKyjLdvGk/BwIMm8ofi7KDk/ntE4jl0/dgSCaLnZReH+bi5XeD0iLqqwDpp5a1/AIDZ6yXuLz5Qqa8R6XEexxFhAuqrXuqB5LHMQ6TZr24JWWaJ5v8WjI6ShAgsjgfo+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QNWfob5h; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30cce5be7d0so938924fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757693224; x=1758298024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuUiBdYdOzhT/4QysYZeoKXL89SuD8knZroyb1BNveM=;
        b=QNWfob5hlgs+iSq2tLGvg8BMd5u7DiHKyG0C1yQK65FRgbGO8j+vqpQB8VAbceB35B
         byGlej9vPgpJPPN4LtA7uR8GKB/ZOXtl0OYPKHbpRnwYbRYo7WaTLvbbI36rXYVeF72z
         AhcEFm8xNltkGc8fbv2m8T8sMLRcTeNwJx9WcWPhPC5Q5kdhH+wb1dVNK0EdA5gCJOc1
         Jk0zzJBfBz4fpIJa3UrQ+ReCZQ8vTadFcqpUCu1JUiWM1BYdGKy0fZ7WG76FbeVQ94hs
         NGFdpHcQzgM9pIBrCiI3uRyuyomgpy1X9eKvNWTqHptkidTsg0L9CB1s8hzSbZCPpm0w
         aQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693224; x=1758298024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuUiBdYdOzhT/4QysYZeoKXL89SuD8knZroyb1BNveM=;
        b=pRMDSqu7erzQa0jARfmxNB+AZyWWHtnha4PWVa3K77PfZD/Mf7jh4LbTELdHzMFl5v
         /+s3DMZdAsbus1jJ7Gur3v1ONYxAazb7VLeVmeypTNlapo93JrJn/XSKpxDa8jWX1PxW
         23VjjEVfQUe9rZYwhVK8utrw/3/EcNGfFExykfH7eSQH/G1aKaXY+rk8pKWFdqikL4X2
         nO+YCYLEWq/Vg4a/9Vn1LNf6B5w1r99ay0lNEz/ItNALEGxmZIATr2kXjMwOqYxoZtLK
         +tl3DCp8tkvHsU+40oAO9Qf5mPmIwH9ZUbMtXiPalwBwGkbCZ8o86D5G3xdvgp6XXQTn
         ShuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo52N7YOlJQ56azDpKmhJb8KJmHjBSSypcotEnK5cDycUAo36EmwNlKsueDLJ8QyyGCDZgkKnG2ooOth0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Zs11Q1UBlVrJK+YcRj7YXt1Oagtvm6P+kiZwP98Qowr6yBY/
	INOv6792slYCxtWlvHAZm6hG/E01NhCj9ZGeoMmsbTYy+o598du/SAOEEwQCtChrVQY=
X-Gm-Gg: ASbGncsV8jkk1I/nqTocYedcEEfrnSXlktmGp2a0ODdRJM97X3OL4HZaXmefx7EusZo
	Y6WHpxexRS1vzkAv9bZ0CFSlRyu4YkSB/sDSieU8ytkdbPRUD8RpyxVaV+Y/SOyKe04W8Bnmpbr
	oCrpO84SpqyIXOa8QQYu97dv/P6zSfViD3qXr23/1umPrlnWymCmr/Ox/JyA0NNU7V54KCN20Mi
	fSsiKh5Mic2km/vK94EcMgCY1AIeI7VsnY20PdGDHtuY3Sn6pIqtxAEQzDgQvOBQbz3Wkf5/2u/
	PLo74+XT3PMfh2gXlVqOd9tGVLb15/e4nv5gvjjyrbZ6T7vniJ3jNjCGKZ+SrMv9tFs8KFhcjFc
	DG53hUBfYPUjv7dZ4TWtgRhRD019fmI0VBDt2kws=
X-Google-Smtp-Source: AGHT+IEece21/Wf69nhlOq5vMROWm4ROwTKSNf9dUQSOL8WXvaC/Qb5i7szMjnhXT8f3xk0bFvp93A==
X-Received: by 2002:a05:6870:2c85:b0:321:2521:5a5 with SMTP id 586e51a60fabf-32e54e819e4mr1773625fac.3.1757693223831;
        Fri, 12 Sep 2025 09:07:03 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1073863a34.23.2025.09.12.09.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:07:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 11:05:58 -0500
Subject: [PATCH 7/7] iio: buffer: document that buffer callback must be
 context safe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-iio-doc-push-to-buffers-context-v1-7-c4aad013d96e@baylibre.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=6mdeYyd3hF07QuqGuLzQcOwjnfUK2lpqXDhP/AFlcKY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxEUR8jVNgAKhSyBxjAa9rQh/UHfJqz4WQGOwp
 ZIh/TBlDxGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRFEQAKCRDCzCAB/wGP
 wOXcCACTtCM3r5X/VEpmrprum2PMSTKqs3GgI14iesumjCXuij/5jAx9itvCr3iVjiQBB2baOLr
 n3TMcn6Ul7FkEzmhaVJ1bhuxLSHoBudhpegwiPfKCO2dElYRpX4MT09wJnGDsFStDhw9rt1JpnJ
 QWyfbeZsRf1mV1ypVNBPyMiWvRzfMLOqDeEhltTry/9FhODX7O97GUSv7VqjFIB45S2u0PqflYX
 WZbLoe+8bHou1Y/EBJQ6yYmzQY6YVI0vGsm5StKl4AKIik2MkCPtUA/HQSBhmO/nT3BXsKWgism
 wR4iFNm6YJWfQrUOjhmN0f0ttZ9/alP3C+Xq2Bi6zcznM+hW
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document that the callback registered with iio_channel_get_all_cb()
must be safe to call from any context since it is called from by
iio_push_to_buffer() which can be called in any context.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/buffer/industrialio-buffer-cb.c | 1 +
 include/linux/iio/consumer.h                | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 3e27385069edb5b717a4c56e72dff2c0a238fa07..f4ebff9684936365ec179489d9041d8bdbe58738 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -13,6 +13,7 @@
 
 struct iio_cb_buffer {
 	struct iio_buffer buffer;
+	/* Must be safe to call from any context (e.g. must not sleep). */
 	int (*cb)(const void *data, void *private);
 	void *private;
 	struct iio_channel *channels;
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index a38b277c2c02cb85a766d645a046bdfa534db51a..5039558267e4c17b2e09246036d0df352e242d06 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -131,7 +131,8 @@ struct iio_cb_buffer;
 /**
  * iio_channel_get_all_cb() - register callback for triggered capture
  * @dev:		Pointer to client device.
- * @cb:			Callback function.
+ * @cb:			Callback function. Must be safe to call from any context
+ *			(e.g. must not sleep).
  * @private:		Private data passed to callback.
  *
  * NB right now we have no ability to mux data from multiple devices.

-- 
2.43.0


