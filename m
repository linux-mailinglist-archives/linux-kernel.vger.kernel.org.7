Return-Path: <linux-kernel+bounces-819600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB15B5A38D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E29324AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B102EB843;
	Tue, 16 Sep 2025 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t+bv479J"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1052E613B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056640; cv=none; b=NU7hIaCQ5YaRDxP5qF47yXcWkcXsjBeId1xLdkFFCj7WilZiiKYkJhLL8flFbWhXdhKTbdS6Vy42wz4ReTl9P/WjgNIvXLNMVDpPXoBLyHscDRbtKZcqK/sqX1VQNxnb1qyCGjqixzBlC/VVQgR1ksVCQKFoaICy2YhtZihGYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056640; c=relaxed/simple;
	bh=KaHoQw0mmyST/U0aIeT4Q9rI2vx9p1nFNJx02h4APhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=leEXmpkXGkRdgGHFuAxFNC6DhQ7SdeGxIigMYpwz2Vvf6DL233DNnKrNpx6JCeR3uI0Opvf/JdmpJRWd9a1tYRCUKf1yE8HGf5Ds9oGUdauZdCoX4V36XFg/62JfwjK3FBHf3trOm6mW1862kwe8+XYNbouJa4eMO1liJqXWkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t+bv479J; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-750b77699b4so4616642a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758056638; x=1758661438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JMI9MVOYcVBfLvH8OZk7vA1oBEfGyZCnmiKgJ+DDsE=;
        b=t+bv479JewxlE8dYVspxeFJz1C35aN97vwuza9gZuR23w7Cm0gokT207ebjlTggbIT
         XYVvMPViFDzWjB6PtZg9fbOfYaAyx+GyEYD6JPz6+ah6xCQ/MGLtAXQEhxxx6OZkL3U+
         qVTlulDAuVCEV2PESYDf8A0JQ6nxvSF9iPaiUBbjRhF+XhscVoBB+OF5GheG46AsaZQ2
         RCFcNrRKuMfgvEePgMm0jMa+Z5MS6DHLPSvICQTQfhhBk8vXK2aZ/QQPh5+iTToUCh7u
         naYbXNcCPQ1nGcY8H3u4va22osrcd6Dm2Pc/phcADvVv2gNp2hDS6HDbUv3pmllpqc5c
         aoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056638; x=1758661438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JMI9MVOYcVBfLvH8OZk7vA1oBEfGyZCnmiKgJ+DDsE=;
        b=X8SpIMJAEsbSdM4XgaxAH+k5adbHPetWgVT6cqE2wdVLy26psEWcs30HT8SEjMVVcw
         vMs9HXvaz9YqVjHO34BnvgaI1uS6t263ggSp43RDdle8KNsc4oN/EKOIScwYtBYZbCfJ
         pKzNmfrcOgHwcGX8/r+smTdoLGo8l8ETFzh5Turhn7NA32tWjoluZqYqM8ufCC8tvmG9
         6NrR5QcY75nMvuXY2xfcsJvmPnMFQJ2Q5gS/UGVRnlZJG2fU2Yjm83Feq6CV/xSIVxrN
         yTnr++iRaBXAfeoWAjC0CpicPYO2Q2p5+ZZE6eUatZIqPxftp8SDGGIJ5QxrgW0nlugA
         /pZg==
X-Forwarded-Encrypted: i=1; AJvYcCVOncNLFip3YorlySefvUMMFlcEwgpXLE/MelhGNlt139c4eOMPNPZRcU8hpyRoH+NaLBVymtxrQ5EMV+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvgc+Auy/F+cKOGA2K1WNzRDxWZU+DPGZpDPeS/Huh5vy+9u9t
	/yCDdVY/MHDe/nkzvmTOBB3cMTak+EU4+mNi5rGviXf07ju4YIp6nK1e6kTcEDbVJXY=
X-Gm-Gg: ASbGncvL+w+Q5/NDtlZbfw+9qd2p2tJTmeHbnQ26hGG8roc/pg1ygLQ3raARlJGUjcu
	ViNiTP3xWX1khlzByfLeKdJbWi0fOgv8o7ruczySMS+gdJbyy0BrQO+fDxtzRNQA/7/+F5IOEhZ
	BeJ5pCWn9rsu6MIJJLtnlghqJzIl69gx3CvNkCcPV0tvCFkKyfDW7DLjjuzQQw8yd+WQv8zO8UW
	KaOcx2k/vG7BJxzqOmtzkvj3jMmU9vQfKiuI+UAy0hFAho2z5O0nd2VrdAAvvCSOqSK8GMM1GG1
	fuczJOaZrxgz9GmjnOhFiRcKwwfXmTTYDDto0JCKi5ZJB0z7otOmDJk8avx4yWJAsDATCQIEXTK
	zzHAcH370EI7hWYYWNuBazgawsfnN
X-Google-Smtp-Source: AGHT+IGfNMNMW59wpHN4IoaXc/ymLE7uDVAYILCANvkVPKEkLuR0d/+yMizh+ypitx3t3N0ruACLYw==
X-Received: by 2002:a05:6808:1383:b0:43d:3a08:cdb1 with SMTP id 5614622812f47-43d3a08d14bmr2302437b6e.8.1758056638038;
        Tue, 16 Sep 2025 14:03:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b8294ac06sm3540044b6e.14.2025.09.16.14.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:03:57 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Sep 2025 16:02:55 -0500
Subject: [PATCH v2 5/7] iio: buffer: document iio_push_to_buffers() calling
 context
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-iio-doc-push-to-buffers-context-v2-5-8b17937a6cc7@baylibre.com>
References: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
In-Reply-To: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=935; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=KaHoQw0mmyST/U0aIeT4Q9rI2vx9p1nFNJx02h4APhA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydCg3jaFLRJJRgd3BvUDQI2kvqM2C2CvcyxqA
 PlfpJhkfuSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnQoAAKCRDCzCAB/wGP
 wJlCB/9VAz3ZXDQfl8rv00JSMhrWpf2B27PnUQviEzTrWLlkx6Mf22xXfiUK5ZAjOXjz8Pb26mu
 0SeBpziJC+LZHgth2zDCOi1oDBDRG1uHU3M5pA1+rw0zkQ1zM9tY6STrkWIWnib5+kRYDGpQbVe
 tK3jXpe5ZeC5+clbHTdmS7jixV8PGoexoYTXN3igGri01mcoNppJk9sh3Lc/tsDipx5+3LgpVPB
 vAkdN5GzPZCg3682YkSj9MhplJyzM3wZYCy+ytMTrUQ0ZjrqUyI4oud/5SsYDJ/oRoAS2a7F0sL
 HdqDQY+n1ZWN1pYswQ5Fy3PTqTti8r/cz7hMXiaeJIAkDhn+
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document that iio_push_to_buffers() can be called from any context.

Also document the Return: value while here.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 5599fa37b698dda6ff126496f62939331c12f524..f1448ae1b843fc577599fc1b9cf6d859bba226f1 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2372,6 +2372,9 @@ static int iio_push_to_buffer(struct iio_buffer *buffer, const void *data)
  * iio_push_to_buffers() - push to a registered buffer.
  * @indio_dev:		iio_dev structure for device.
  * @data:		Full scan.
+ *
+ * Context: Any context.
+ * Return: 0 on success, negative error code on failure.
  */
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data)
 {

-- 
2.43.0


