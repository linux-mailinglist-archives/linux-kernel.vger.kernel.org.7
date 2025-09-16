Return-Path: <linux-kernel+bounces-819744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CADB7DE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BA416B2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504AB2ED853;
	Tue, 16 Sep 2025 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTK4PiKK"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91EE2D46B1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065825; cv=none; b=BTktU5DflDTCT4nIJUjivcSXEow5aGPpK9Pq/N7CM4gqqN7dEmFkfGKCysW1iFqrObtac03bDodnpf1xVSebLKGkl+2i7/i1tYJderQoQ+MX/yztGl+mcg5N24URIHOIAtCJTrPpNMXvHgTuFYe8ikZ3Jp8shpZ+4TEM25Q+Eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065825; c=relaxed/simple;
	bh=jmIFrzhuCkeTq8aoCDJ2rAhb/3DfzKmeBEvuiDdglA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpZeYJA4k8hCArMvU14Hxrr0hva1b5qGy0NpM3sHDHRke2IIpChUSb3WTBMbiJHKrQosKMK85c/0zYne17+wxDCuSeU7f41icb3Kbv0ZsjGo6FTdMiO4sXUh6fxIzzX8i61z/CklYUn3uwJYWF4P171Um7sZXr09Ip81nNDZar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTK4PiKK; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54c707374fso2081797a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065823; x=1758670623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxdcHcBGjhOznZ861gxh1q71v55lbCXoAFjQMQ3zSXI=;
        b=fTK4PiKKBcMBx3xOI1xivxXwdJF4lt1JDhbQpQpWyyfDzqnkbkDETQMoxV3hxUSNDF
         fw4RqLMbWHjBgoAx2OZWnlI3f965OV+OVM1iE5znn+PgxLJgQeBTFmLsARI3/p8PWB2T
         xcj/4+jBgbZzFsNWV2kRuue86gCXl2NHy309ZptcnMM0+2ALnljmNY3h/LYvrpoZhNrL
         q7zHrttD09wAbUuz4A0eQZMi1sO+c9hwN4UlwAIAQpDWEr1XHhvRMPTpIEmry5fezaV5
         bxB0COo+sys19JUS4T90RnIq5jsFoVrHv7z5RiuE4IJepP3aduv5UGP60Al5176jkx0n
         y9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065823; x=1758670623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxdcHcBGjhOznZ861gxh1q71v55lbCXoAFjQMQ3zSXI=;
        b=sOmaAhRAFlQp/Xv60fJNQ52RrVJgtI1lAMLzkBqKn+QuaxYlQU1zoMLoHx/s1Nywbh
         c+1QgGI0SB/qoHzNmt5iKyyCgdOW72vkRZxqQ5KpURygJLOPgMstsm6IeQaj0DQARwOS
         pHXCMoYLpQ5iIDv4456Gm8VrOEostrmUS05GhXM9K19JsQw/3KDDcGn+H2x0f1tmfSav
         mTH+hmL9x2OuBNEVGp7JklZ74HBg/5Vec4vvw3RXFtxH7cQK+CkaTTkgDIor6AX4MTrc
         2ceoEuIvUEZlCHE5FCLjNhSDSFuOArnb/yXeQSEAHshS/xRH7aJEbatFNb6+T6fpZxLC
         Zebw==
X-Forwarded-Encrypted: i=1; AJvYcCXaDpghfjXHsptwskTW5Uh9JAFZwetHxkgsNXhlqJaIJfdtvsvv7KD+jNLfv/qwD8orNKKj+0dSX41jMws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIeQBs9qBkpjTQ/K7SbnDNIXlRuZKbB2BzayzLnd6RuNcuO8kV
	zRlKXoKRNLYG5a9a+4rFq/R9OVCN32YlMEykh6KZ6ABBQZL59eUKGwiVRzxjPLke
X-Gm-Gg: ASbGnctsc4Vy8yeb9Fb8fhJ39YEnthlkK7vWx4JzcAVW3LyHk00ZUVUClBj7A3OkFad
	0FdhbKMrfStmK51SAO2eg8IovSfb2Og2rRJPWNGNI70Grtam3ogj+e62Qmaeiku5rHIKJ2c8t86
	UyU66QXkE4vlXNHZnllHDskIvGIBQbyv09OvWuaR5JmZ3AGmaKrvd1fREAIEtviHTqm30DvkpDs
	coq8q4r+TKz6j2f4CR71BAYeGdhHYdPYHnYAZE5SX78LLVTEZFcdQ2wqg+23HoPhRkgf6YNwIhT
	s5j/Jo60pg8wdtTdFlF+wZFqzgl6xDczcJm1cz8GbO72mPAqjCPQNZ8prhBZpOQB0sS36eOP4gU
	Kh8glEZUbvFHR4HAfkAHTdoToWw==
X-Google-Smtp-Source: AGHT+IHxLbxAZnUj1CScDSKSM3GL/HL/XAd0FoSZ3hZKt/QN7icZfLqKgH8sOlEwoiR3+HsctkbmDg==
X-Received: by 2002:a17:902:7448:b0:249:2318:7a2d with SMTP id d9443c01a7336-26811d9273fmr669685ad.19.1758065823035;
        Tue, 16 Sep 2025 16:37:03 -0700 (PDT)
Received: from [192.168.1.135] ([2804:14d:90a8:4498::371])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b8eb4737sm10108298a12.9.2025.09.16.16.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:37:02 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Tue, 16 Sep 2025 20:38:24 -0300
Subject: [PATCH v6 2/2] iio: ABI: document accelerometer event attributes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-bmi270-v6-2-6acd8d26a862@gmail.com>
References: <20250916-bmi270-v6-0-6acd8d26a862@gmail.com>
In-Reply-To: <20250916-bmi270-v6-0-6acd8d26a862@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758065905; l=4613;
 i=gustavograzs@gmail.com; s=20250915; h=from:subject:message-id;
 bh=jmIFrzhuCkeTq8aoCDJ2rAhb/3DfzKmeBEvuiDdglA8=;
 b=Pz5QdTxcOVElNPSF9gagWNFeCT0go4cKUSZtUVWmRX7pfVomIz+MtkCJhuk3gUlW8dyVHoF0e
 uTCnfZmfcpeAoVWI7dqKKfFtc1B47Sh45wyLi4nxkiEuhOsbYo+YMR4
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=kYkFqZEIlab+1AaYMvpqhTQxwPXcJiTXdMaBQbfORrg=

Add ABI documentation for accelerometer event-related sysfs attributes
exposed by the bmi270 driver. These include threshold, period, and
enable controls for adaptive magnitude (any-motion) and rate of change
(no-motion) event detection.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2fb2cea4b19249743398b1ff0b538b03ced0340b..b45d1ba6972848a6024746d7d741146e35a55ebb 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -908,6 +908,7 @@ What:		/sys/.../iio:deviceX/events/in_accel_y_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_accel_y_roc_falling_en
 What:		/sys/.../iio:deviceX/events/in_accel_z_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_accel_z_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_x&y&z_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_anglvel_x_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_anglvel_x_roc_falling_en
 What:		/sys/.../iio:deviceX/events/in_anglvel_y_roc_rising_en
@@ -991,6 +992,7 @@ What:		/sys/.../events/in_accel_y_raw_thresh_rising_value
 What:		/sys/.../events/in_accel_y_raw_thresh_falling_value
 What:		/sys/.../events/in_accel_z_raw_thresh_rising_value
 What:		/sys/.../events/in_accel_z_raw_thresh_falling_value
+What:		/sys/.../events/in_accel_mag_adaptive_rising_value
 What:		/sys/.../events/in_anglvel_x_raw_thresh_rising_value
 What:		/sys/.../events/in_anglvel_x_raw_thresh_falling_value
 What:		/sys/.../events/in_anglvel_y_raw_thresh_rising_value
@@ -1129,6 +1131,7 @@ Description:
 		will get activated once in_voltage0_raw goes above 1200 and will become
 		deactivated again once the value falls below 1150.
 
+What:		/sys/.../events/in_accel_roc_rising_value
 What:		/sys/.../events/in_accel_x_raw_roc_rising_value
 What:		/sys/.../events/in_accel_x_raw_roc_falling_value
 What:		/sys/.../events/in_accel_y_raw_roc_rising_value
@@ -1177,6 +1180,7 @@ Description:
 
 What:		/sys/.../events/in_accel_x_thresh_rising_period
 What:		/sys/.../events/in_accel_x_thresh_falling_period
+What:		/sys/.../events/in_accel_roc_rising_period
 What:		/sys/.../events/in_accel_x_roc_rising_period
 What:		/sys/.../events/in_accel_x_roc_falling_period
 What:		/sys/.../events/in_accel_y_thresh_rising_period
@@ -1187,6 +1191,7 @@ What:		/sys/.../events/in_accel_z_thresh_rising_period
 What:		/sys/.../events/in_accel_z_thresh_falling_period
 What:		/sys/.../events/in_accel_z_roc_rising_period
 What:		/sys/.../events/in_accel_z_roc_falling_period
+What:		/sys/.../events/in_accel_mag_adaptive_rising_period
 What:		/sys/.../events/in_anglvel_x_thresh_rising_period
 What:		/sys/.../events/in_anglvel_x_thresh_falling_period
 What:		/sys/.../events/in_anglvel_x_roc_rising_period
@@ -1344,6 +1349,15 @@ Description:
 		number or direction is not specified, applies to all channels of
 		this type.
 
+What:		/sys/.../iio:deviceX/events/in_accel_x_mag_adaptive_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_mag_adaptive_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_z_mag_adaptive_rising_en
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Similar to in_accel_x_thresh[_rising|_falling]_en, but here the
+		magnitude of the channel is compared to the adaptive threshold.
+
 What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_en
 What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_rising_en
 What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_falling_en
@@ -2386,3 +2400,23 @@ Description:
 		Value representing the user's attention to the system expressed
 		in units as percentage. This usually means if the user is
 		looking at the screen or not.
+
+What:		/sys/.../events/in_accel_value_available
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of available threshold values for acceleration event
+		generation. Applies to all event types on in_accel channels.
+		Units after application of scale and offset are m/s^2.
+		Expressed as:
+
+		- a range specified as "[min step max]"
+
+What:		/sys/.../events/in_accel_period_available
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of available periods for accelerometer event detection in
+		seconds, expressed as:
+
+		- a range specified as "[min step max]"

-- 
2.51.0


