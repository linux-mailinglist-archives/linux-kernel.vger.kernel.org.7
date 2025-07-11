Return-Path: <linux-kernel+bounces-727934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B46B02191
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FBA18938F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B02EF677;
	Fri, 11 Jul 2025 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uOvklqnR"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F292EF675
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250707; cv=none; b=LcROsBfTQQrOA4hfrMkq7rsBkvIq60IBzRNRcep1Q1cI4ls6W7C+wU8a5zUYKdtNz6rohdWLX0cLxoEGpAzmtHOkNy3Q4Glcff+lGtB7VVLRFPV9oahOS8ZY2ON3JjA70ccPWmYR8FIVspoW/Raq0M3Zrn5zZrf5Z3BcsaJsR4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250707; c=relaxed/simple;
	bh=Cle63T6Oo5Tw2DeqJ+hu2bgb3QTwH3FBeOGkiV672Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U1+gbvO9YgiP7vA/ksnWl973raGih0kcvzZfa9iO/SGRGkiczCKMgsdBuKvePoN2D53VLK+XuNWGy6qVhGakpKnnoEmrX1JAM+7TwOm6S4lntL83Wv25wV2NFGuC7XSsuQmafRmIgBA1RpfVCAoRkmxi7qsl7ACqV7YY3qA7I9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uOvklqnR; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2eacb421554so915872fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752250703; x=1752855503; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FkaULoFsJgrFgGT294bMe5qA/hs1W++ZH7et9nZG3CE=;
        b=uOvklqnRmOtDaRSieF1ZVU5NQo90Wp8m4vewReuQdkfK3GFaMEW+/5J1/bdeXSjQCC
         yidWWR2nd8TZg86fYyRHbngtgX++2VGswfsRYNJkIcASir1meLCs47bJys3zbUnK2/px
         Hs3aeIiNkVkUdMWpkSqWYjMbTwqMNzFuherqzavlSJDqrsdgNcWYqXNedcO8AfgWZ8Gv
         L3Vt25ms4A1GQAXDHM6bo6YLsBEVUk3Dqn7zWg557rUB2VUGC1oGFyRQa/lG7AnbfZQc
         JFg37/4F1rbPgUDVAjL1+W74x1LBg4dBpnc0xjeO7Nmloc2ljfijh1n0odGKXTdj6Rf5
         vTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250703; x=1752855503;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FkaULoFsJgrFgGT294bMe5qA/hs1W++ZH7et9nZG3CE=;
        b=ogX/ae5IAGbga0C7/u8cxPz7HZqCwE1MzPSigHifjEyzW3jt3DMhBKOCtS1UQB+ORy
         GCQdh2i4K0RgqaOSllaSPYPVJ6VE3vtsaG6eHQ5C0+3W2zTxzIdYXsAskFIL8dAX4ILO
         oEqelPn414NTM0dj58FwadzWmq89k+MxqcVV5nSqeScRuLMFQSfhLi4WzkrZnIViJEh+
         OtZVaI09ECc2Dg8M3i4AJ7d1B+Es+lneFaehibjx21YUcwruRWUCWuAPgOTiw3yjxUuy
         yrSXeFVi/2vcvUwkWvvgipRs5qrnZdMQhRO2BnmatI7wIaV7tIYNkWBj2NyPmY3R4NU4
         +sTA==
X-Forwarded-Encrypted: i=1; AJvYcCXqHvJDipZN7UdRGelcAByjgsSJH3Laf7Ks1xTCccUWh91vViKAiWCpY+HvVx9IRMGy3iwBgXc0fzthDlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHITK2ZHJxQewcxZxhO/7Pa/OQN0MKVgG7FmslHH8X8Tyj9Vel
	xXO3RKfDCUbEcLtgu+s9ZmD18kMEQICO3kT74ZZt7DvTiJG/H0ny2HlP2zD0plfeA2g=
X-Gm-Gg: ASbGncuMZElWgkMayww8/hbK01Irfn0/ijXgOthS4nxsjJ5MSOjLz1XIKEkX4+eA0Z1
	9nRztgv7q5VOwkim+Kief6j2Wup55ryH2knHgK/bKxl1igJPYAZQG/S/Irztvw5TZ7H3nbVv/cM
	iKz4+KlTCyUUfEQeZ0F8NJPAnoydzuSSQUoH55VRsckcyMwrGdC1P20RzIbOKUMLuTKexXNEy7X
	MLGYMftLMweFILlvFVce8PICyo/SkVIQqIjEW7AK89cwmybVWEASQXn4VuPl1NOp54zjqi566LT
	DxmSawAMz6VrahCKzqvf1TenOqEhsyj3aIyCLwShxCsJ/5iXM7z3hQ0Aqi/dZUXubXXQi4I5Kv+
	t7NyIcZmASbb/T9dLMHjoKs2BoV29
X-Google-Smtp-Source: AGHT+IHDxMu3z0weN+B2hl6khrxAtBeyMDMlt4rGH4W1DiaHeJ0zXaJwL90MVeJghPqCJYhLsv1iKw==
X-Received: by 2002:a05:6871:7287:b0:2a3:c5fe:29b9 with SMTP id 586e51a60fabf-2ff26a6e976mr3789632fac.29.1752250702825;
        Fri, 11 Jul 2025 09:18:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff11259495sm782504fac.17.2025.07.11.09.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:18:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 11 Jul 2025 11:18:13 -0500
Subject: [PATCH] iio: proximity: isl29501: use scan struct instead of array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-iio-use-more-iio_declare_buffer_with_ts-7-v1-1-a3f253ac2e4a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAEQ5cWgC/x3NQQrCQAxA0auUrA1kKjLFq4gMtcnYgHYkaatQe
 ndHl2/z/wYupuJwbjYwWdW1TBXh0MAw9tNdULkaWmpPFENA1YKLCz6LyQ+JZXj0Jum25CyW3jq
 PaXaM2HXEnAMfKRLU3ssk6+f/ulz3/QvOccQnewAAAA==
X-Change-ID: 20250711-iio-use-more-iio_declare_buffer_with_ts-7-880ddf1d3070
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Cle63T6Oo5Tw2DeqJ+hu2bgb3QTwH3FBeOGkiV672Vg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocTlGUjdBccxhCdzwpAbLg8kaVkN60W7RZjD/m
 B7S1EjQmQ2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHE5RgAKCRDCzCAB/wGP
 wIBjCACFI8uzWwu8GhFLDuJSHx7GvQkZ4NbmmhB6B2bWtCB8ekQ8jNJ2nXDE+I/Ts9VQ5TE/i5X
 vu5Cw/M4M5MLdg0AY+JsJWz6fJ/BnlWVLSyV53f3AoIAg04kZ93oGI3BiCgDDnYxlS7Cx/2Tu9E
 zB9MueepW5xHuUz2/vo0qBghm9E5477a6SdhqVBFhDhyyaG/B3cArzlU2TrCR/GCrKeixXDt9VZ
 uHqSW7+RSpvnDnx2ksHnf8y0MWvY2VakOs/5aPRLv5V4e/QStZKAOjiuzalrdIlSWszfMw56GeH
 KB63a5xQ5hmlZCy0laRyWvjGqYy4YbbTSR2Tc3etQDN3f3W5
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace the scan buffer array with a struct that contains a single u32
for the data and an aligned_s64 for the timestamp. This makes it easier
to see the intended layout of the buffer and avoids the need to manually
calculate the number of extra elements needed for an aligned timestamp.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/isl29501.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index d1510fe2405088adc0998e28aa9f36e0186fafae..0eed14f66ab700473af10414b25a56458335b381 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -938,12 +938,15 @@ static irqreturn_t isl29501_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct isl29501_private *isl29501 = iio_priv(indio_dev);
 	const unsigned long *active_mask = indio_dev->active_scan_mask;
-	u32 buffer[4] __aligned(8) = {}; /* 1x16-bit + naturally aligned ts */
+	struct {
+		u32 data;
+		aligned_s64 ts;
+	} scan;
 
 	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
-		isl29501_register_read(isl29501, REG_DISTANCE, buffer);
+		isl29501_register_read(isl29501, REG_DISTANCE, &scan.data);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-7-880ddf1d3070

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


