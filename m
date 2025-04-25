Return-Path: <linux-kernel+bounces-621092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFE5A9D3E6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 23:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A877B7E31
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29AC224AF8;
	Fri, 25 Apr 2025 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GAnSa7F5"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC951B414B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615382; cv=none; b=dmM3oN1thNPsWDbrstsndMj0rXCWFJUnGJ45e+GUr9Trb9QGwYQ1MqENPbNBRm+Hpyjeane5eTgDSBkd7cRK5Ys6I+VGtiYdRzKMyJhxDguYUOAHNhkD3NbqSr6xYQXzP+Gv/qdvbTvOAcfyLkqcw8pGc2NFXZUSYpVzqZoBfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615382; c=relaxed/simple;
	bh=S9yyrbbGceERU79hEYcii6LVQfguSKjlkyu5n+UlTsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLRPXTtDHuRlvrJwX0NgDVhZi3Oj/K7v+vpFeqhN7acimPkTi7LGnRqrFluq7NU3wa9WPOPc/uFeEo7MHla7g3RJnjLdrXNUccbmgbjuiAFVQC4SEFt0E9lNn8RNgmrOoaub+hKvHOxhc/rK1/2ePBYHEDBRmvSg37pUqjnl8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GAnSa7F5; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c769da02b0so2274960fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745615379; x=1746220179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BY1aWIkNQr9/WlVdM/imYDbUDJ4FCN12j5sBaq8Ups4=;
        b=GAnSa7F5xF9OG+cfKIBYF6rZ8E0vWFuGHxyOO9QzT6D8FFe/l8KR9MvD6EdVYViFIZ
         9GzjKYcDugPK9IPo7VIz1IO3AnAkOSjUfGfm+h/YpaIFcjHsGzp518RxAEXCzpT055eh
         2q8aTe1Sl8vbCBh8kE6KsjE/AgGcA8NcAdm9HgLHT/8pCHEiudD5BInzkfZmbM2y+U76
         vi2mSKf21N00vg5SFOn5u2VBtoLLzYLtuz99y5w/ZXIsy+QGu9UDCQ2GNoXVxJ9fWeyi
         nFVkcFX+XL6EARhp22GczlH+1y48lvjItRGZmlbhEQPGkA9D69Af5BHX8CbNmFYGMUr2
         rCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745615379; x=1746220179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BY1aWIkNQr9/WlVdM/imYDbUDJ4FCN12j5sBaq8Ups4=;
        b=wWRKGlNo/kPs0R4ka2I/HPE/ubnBhgXzDH9extDD+k7fAnM+JF2C4YXUUuXCkMXVXK
         CYA3e66MDbYzPXxOi4nRvJG/ihudwksi1P6N1PgbyEiqu++zSI/ELqSENGnDsW7K7gQd
         nT4JjB78GlgopBuXBycKFY/+UIfIlwxkSTWOf6DQtuL2bXc+RwuWzI7EPmvoDRrrPzEM
         iFUZqYPRHS21O7r5ggix5Nkr0saUmYW/W/JDGqOWp2otxxMylFKn9ToHBy2SyJdXrD4x
         cta9TDwGbCiqWAB35f6s074Ic/u1YSz+qvtugZNgx/xkFJltYNrnOo61JTQX1u2ld5TX
         mCiw==
X-Forwarded-Encrypted: i=1; AJvYcCU2t9NnWiPA/kJFRrlSHAffHty9JaU6lHlu9tlqjPy3lumPh5RW1kOucUbM3HrRzkv1035bSWUo6IGdFTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrwStxdWUAF1Y5iAJTwmIr+jnkbOXDjEbYZj2bCw8yQ/GNtSwl
	/ayfBIanmzmDI8DSDIc6aaEwEQDH0USX5FExexGpQxbf99FeqHxjsOm532Luzes=
X-Gm-Gg: ASbGncvomAJ80f6+J34EaJcNWbvIM9UCCfMzeOv4IrokpihCiS/P/2R2IntzL9Bviii
	gPtNoBfdL9/aVJ2jgBIk19H0458ZBcAaiBSpnPGbagz+FhRo+d+uTejsbIAenAqlPdpVUgktktq
	46deF4pihilb5+e9VSVLRkrDdpmQ0PLPq4/WgF7YDIiEy8cg/k4p+CAZNdZAME5oTQH19GziFsy
	Qb7bD3S0J6kSlE9qIWeGQPneVb60fmXlaTi9xXaMDSrr+S/CzXR2quPih9qO6hEDkXpWFO5zpyo
	UqYhQieR7ZWf2/ajPDGoLpLRvtL6lJKEnA/IdafIuqI1C213Cxq1iEc=
X-Google-Smtp-Source: AGHT+IHgoMZkBfZXhz5aqoIzlRTV+NaG/N/wVFvnLQMLS1D8aZCmMXkvEWmf1mqpeRfkisZn7+z95Q==
X-Received: by 2002:a05:6871:792:b0:29e:4ba5:4ddc with SMTP id 586e51a60fabf-2d99db25561mr2208324fac.24.1745615379304;
        Fri, 25 Apr 2025 14:09:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f188052sm847673a34.8.2025.04.25.14.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 14:09:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 25 Apr 2025 16:08:43 -0500
Subject: [PATCH v3 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-1-f12df1bff248@baylibre.com>
References: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
In-Reply-To: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3719; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=S9yyrbbGceERU79hEYcii6LVQfguSKjlkyu5n+UlTsA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoC/nm4JmFy6kPkiyqKsDPXMzKl5mRSVcD8MkmU
 knBSH8PgtKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAv55gAKCRDCzCAB/wGP
 wJSvB/9gSprhYoKqm17uZXVZ6jJRFmsaX8jyoqQBaLCQeqXZdb0j74O/nlC316k+qfISf3o34yh
 /ZAovdK45qS71p3Y20kH3CqNKHpCUgnttFXhEdWcgNjsFcFr/UMUQw/M5T7sQTpYgxl/8sD88KJ
 f4tZd53Vyn5wkQq2ELL4SUF4oVvta5WyOAK5S7/tCmuGLWyJqC1j9ihqeiifuzZRZf+ypJPu4oD
 GxQdYZxyVLx+fmM0y832hdBwp/gcd4J4TH6K3ll5OlYcCJvk7n8SPI0Hjl3egeYyk196dIcMKzf
 B6ZjyRXK7+EJ+iq2t/OBgh4tZOCC5h/5hli4azVUGDAMwFoA
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add new macros to help with the common case of declaring a buffer that
is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
to do correctly because of the alignment requirements of the timestamp.
This will make it easier for both authors and reviewers.

To avoid double __align() attributes in cases where we also need DMA
alignment, add a 2nd variant IIO_DECLARE_DMA_BUFFER_WITH_TS().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Use leading double-underscore for "private" macro to match "private"
  functions that do the same.
* Use static_assert() from linux/build_bug.h instead of _Static_assert()
* Fix incorrectly using sizeof(IIO_DMA_MINALIGN).
* Add check that count argument is constant. (Note, I didn't include a
  message in this static assert because it already gives a reasonable
  message.)

/home/david/work/bl/linux/drivers/iio/accel/sca3300.c:482:51: error: expression in static assertion is not constant
  482 |         IIO_DECLARE_BUFFER_WITH_TS(s16, channels, val);
      |                                                   ^~~

v2 changes:
* Add 2nd macro for DMA alignment
---
 include/linux/iio/iio.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 638cf2420fbd85cf2924d09d061df601d1d4bb2a..1115b219271b76792539931edc404a67549bd8b1 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -7,6 +7,8 @@
 #ifndef _INDUSTRIAL_IO_H_
 #define _INDUSTRIAL_IO_H_
 
+#include <linux/align.h>
+#include <linux/build_bug.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/compiler_types.h>
@@ -777,6 +779,42 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
  * them safe for use with non-coherent DMA.
  */
 #define IIO_DMA_MINALIGN ARCH_DMA_MINALIGN
+
+#define __IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
+	static_assert(count); \
+	type name[ALIGN((count), sizeof(s64) / sizeof(type)) + sizeof(s64) / sizeof(type)]
+
+/**
+ * IIO_DECLARE_BUFFER_WITH_TS() - Declare a buffer with timestamp
+ * @type: element type of the buffer
+ * @name: identifier name of the buffer
+ * @count: number of elements in the buffer
+ *
+ * Declares a buffer that is safe to use with iio_push_to_buffer_with_ts(). In
+ * addition to allocating enough space for @count elements of @type, it also
+ * allocates space for a s64 timestamp at the end of the buffer and ensures
+ * proper alignment of the timestamp.
+ */
+#define IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
+	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(sizeof(s64))
+
+/**
+ * IIO_DECLARE_DMA_BUFFER_WITH_TS() - Declare a DMA-aligned buffer with timestamp
+ * @type: element type of the buffer
+ * @name: identifier name of the buffer
+ * @count: number of elements in the buffer
+ *
+ * Same as IIO_DECLARE_BUFFER_WITH_TS(), but is uses __aligned(IIO_DMA_MINALIGN)
+ * to ensure that the buffer doesn't share cachelines with anything that comes
+ * before it in a struct. This should not be used for stack-allocated buffers
+ * as stack memory cannot generally be used for DMA.
+ */
+#define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count) \
+	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(IIO_DMA_MINALIGN)
+
+static_assert(IIO_DMA_MINALIGN % sizeof(s64) == 0,
+	"macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment");
+
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */

-- 
2.43.0


