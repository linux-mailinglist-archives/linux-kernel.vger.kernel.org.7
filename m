Return-Path: <linux-kernel+bounces-629945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9D9AA73A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 15:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB161899361
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C09925524A;
	Fri,  2 May 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cl9tbAis"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7C22DF92
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192500; cv=none; b=RBBXETRZpXKIqyY+3uH5pfRLwNVXyrKRmVwYziK0Nr5FFKSZrvE6njGDii9SpNZ4olQchGM0OtmELnrt62rLDtcgp+GLoOcKQlfMWLTJRDd2dPyYDRsXK5cP9IFbtO6zZoJXfXgfGDAK8KU8TTSqeNJIBKt0tlBgz5qokhsNW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192500; c=relaxed/simple;
	bh=9EK0Atp8rHdpu+X+rVm01GkzEyZtG4aZwO22eC6200s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L09UA2DK/wOiYVULUnXQt86NQpTNDoiErd7Cb97nOsrXZXbDE03oa8BDEiZ48UYBDyA/+i1LvtagO7vgr5p4QSQpPEbyE4BgyxAh0JPGvJUViP1qqdZHU6AsTo07Er3q/mg6skUQzyh+v2dWaZUXGl/LxCZXV/mD/U3A+WgISoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cl9tbAis; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so11913805e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746192497; x=1746797297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtntWz6cXKALzOhF2uJU1XcNxPBVH+VawQkBo5EZDg8=;
        b=Cl9tbAisCZ7CF6Omk9KfjX88GX8DuNq8qM6K4S2UAjQho5tXwOzShv6ZcYyd26kxKp
         k79lQaCy+wBogvwhPNRRyR4wUwEUTFP7uMk57hIyF7rUA3p6Okgrwj/AIFuZ6wZhiZtZ
         KZLrKMjYVUkoF+zY28k/7BYp25d4RdWR6tE38s+RpTDSvymnVysxn4KnxwLYmn1rw0to
         pCVRTupo37T4TaBdJkzMAVHzYhcVj12RfGubb6xtbWon6JNg5X4UdD4hOd1iLH75bBWo
         JPIZtNC2zUZTie4kx3/ZIij33F96QUZMmz17bP5j8D1U50O9VawJqXR5Q8Z/m2bOaQa2
         xoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746192497; x=1746797297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtntWz6cXKALzOhF2uJU1XcNxPBVH+VawQkBo5EZDg8=;
        b=ZgsIeAp3JXszw8Zbl7+6rPlZr3YWCpEMjRU/Ch+R6Gi2RpreMf+jfTN8Gb8JdDjgKL
         +e9Yxe9sJRJ+hVu3OeLls6kBQ2kT7pvoxGZBqArZxPZPSwITxCnTjoQhalxkMFFkyd7D
         PnFP5UrMifVzn6RgbQwsYCt7kXrIFQ0mzwASLiakc5+IErsSHwfMA6AoMksCAd9hfNU2
         9qqN7TIKkr6QgG4c2wT94vbaSn08z5VsJ60+e5ppPyk8CHmFjTLaFGzODsESn3MTH0wI
         E82aoMrou2TlwjKmRLKH75K1plU07W7oU37aRj2K67FCxmiJ1AZAAahRqOhEZtABriL3
         0N3A==
X-Forwarded-Encrypted: i=1; AJvYcCWK8s6gTk0gbQmCgiXmCU+6PXBD1588itUAIomLI/Pj6KApeN+ksz3RtX1P9qAe+vd39JUXT8sOmrAyEBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkyOJotD1Lwwf+jdurNZNjCbWbFTyghBOXH2u+8J2I3U2wvDtm
	9mnsRp5JfcD4msAtZ//VGxfsrmRqm5s8dvt7QpZ35cN3PErabFzMj7qMlyzkz0A=
X-Gm-Gg: ASbGnctB46zu/MDQL/N4xleZgE6OBVmUfXdT8Mom5BMvgb7hbw7i16dgyKF30tVvOEt
	DjIoN8MQ3s++ABlQl9xjxIYO4LyQWbf3G2dNNuj2wg/PUVm4FlBEdYj7lpchYUV7tsh/slpd2Zj
	L40iV7uw+wWkZ/ch6ysKO1O3XX9G/nz9+meER6FWZ1Xe2ipNKkCch+G1PMt/HOz7KUkeUnHwoeH
	iGcWL2aM0KRHoBIN+Jhf/vJOJgOzisI5sP9obNR3Tl6zTr6KDu1fWb8TaAsl8RM+N0W9qUyuRzV
	mCuKz7GwGxJaTBB0DR10QrPHwyknXacuiDScKAPcS0+t
X-Google-Smtp-Source: AGHT+IHvcHbDPsyxb9la/dnjRvBkv8xkLYMqVH8JAhaqEDZzXIAl/dQSOfxdGlQyySBEP7xgydCKdA==
X-Received: by 2002:a05:600c:628b:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-441b72b10f2mr62622585e9.3.1746192497181;
        Fri, 02 May 2025 06:28:17 -0700 (PDT)
Received: from [192.168.0.2] ([87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc50esm45761065e9.8.2025.05.02.06.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 06:28:16 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 02 May 2025 15:26:58 +0200
Subject: [PATCH v2 1/5] Documentation: ABI: IIO: add calibconv_delay
 documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-wip-bl-ad7606-calibration-v2-1-174bd0af081b@baylibre.com>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=vb/6wvniAJeAs3RXPvCaUldK2+XHWqS8d1UiRHckMTI=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgQOaEu92fjy4WvJ6i+WvtB+vefQvkn91iMJ04SkPAp/
 iwdvlBLpaOUhUGMi0FWTJGlLjHCJPR2qJTyAsbZMHNYmUCGMHBxCsBEHq9lZHg5/+5PK6Ndsq//
 T9rMHcI767huytKE/SG+YtkdiibFMa8ZGfbznYxesN3kjHXf6nWF73ZutXnMoX3G+aH+yWXmN9O
 2SXICAA==
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add new IIO calibconv_delay documentation.

The ad7606 implements a phase calibation feature, in nanoseconds.
Being this a time delay, using the conv_delay suffix.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 33c09c4ac60a4feec82308461643134f5ba84b66..56eb42f88999660b5f93f2311b7d57e0303b0647 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -559,6 +559,26 @@ Description:
 		- a small discrete set of values like "0 2 4 6 8"
 		- a range specified as "[min step max]"
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibconv_delay
+KernelVersion:  6.16
+Contact:        linux-iio@vger.kernel.org
+Description:
+		Hardware applied calbiration delay (assumed to fix errors that are
+		introduced from external circuitry).
+		For the ad7606 ADC series, this value is intended as a time delay,
+		as an integer plus nanoseconds.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibconv_delay_available
+KernelVersion:	6.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Available values of calibconv_delay. Maybe expressed as:
+
+		- a range specified as "[min step max]"
+
+		If shared across all channels, <type>_calibconv_delay_available
+		is used.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale

-- 
2.49.0


