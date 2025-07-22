Return-Path: <linux-kernel+bounces-741602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A65BB0E677
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EDE6C7087
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556628983A;
	Tue, 22 Jul 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IIlsvvHq"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF1F2874E0
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753223696; cv=none; b=kB0bE7CWTFyOnsbXaxsSYsrhn01LK3ygqagUgu3Qi/uuYuBQW78ZYHJZUgtCvZZP8CeWpRgIHMgoxPgEVsejzp2AFtbP572sByEmATsLTKPm1tjcZan3UdyABNLqlcihoU3MHVS6PdpgV/Y3gTlkDN0XGuW9KC6uT0MEqpyZzBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753223696; c=relaxed/simple;
	bh=DI7Py06D/Fb6XwmsmpUlNeYX8jsG+Z8UnZwXBY4+GIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XJF3yIEy5sG1JtGym0dMEFegqs/km2k9DTXJ1hCl7LRQ2pHsxJYsZQsM9aNgXzdm5k1oqlrsVoSyhREoq1EV4qBuz9FIYGCSuCcYx8JpoLyOH6QnLDiueQPRi2xJmdNdeJ6S14SUFGV7WVar0EbIuZhsV9ijY9d11eA4nXj+gIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IIlsvvHq; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73e586fcc28so178340a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753223693; x=1753828493; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcC4a63ILBfBOzpEzRk/1K2T/rRgSqcFhHU1Bre51Eo=;
        b=IIlsvvHqBSSRxRM2YMGs6hGHBxtvxLGrlO6CEELhDHh72b917RB5AU8+AnYjC5o68e
         GS9grGCblhO69gKNwf5eIxZD34+/LF4H7mNovkTeel9h0EVp4SkS5aRxgOEhwkloT4s9
         OQR9mxpOyJdoexUxf2p3uandgdVPy9/ZwIC+pasEcPK3hy+FvJPYn9vb1ZaENfdczT+5
         qaIf/O4mRXU8GBxhkjsWIKr/SEMxqc/+dCROjAlL9nGw8fr5Q0lXlkGLEpTHBRda2RLH
         oUCQq0D7spEYtdCKwRNJJNdEmLGmENaRn/hoR8SFZUu2jphfrKKuOzkwmqXur/O5i8Wo
         jlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753223693; x=1753828493;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcC4a63ILBfBOzpEzRk/1K2T/rRgSqcFhHU1Bre51Eo=;
        b=az9D0trmyaRhBxmsCCjdziwfQF9LrXCiOncU05xyYzqKetLZASqYgtkYvtfAUz7F9C
         98Z+/MYpNtgoaKzALkthJk4wkCjv7LQD7/jYQ2JJNmOp+U3/dtgPNfAS3MF8k9YdHhud
         JvjOo0rDkk0zNqhPnDgynJn2y2ROTWYwpe2EuSoyT8ogym1tOBs1HqbTyORri0daSpBW
         OFBBKBWUc2IGSDp1I6n05cFuSkEk0iPHagY7wnG16rERtCXN8MZ5Dky7ocdLmfnURuHV
         DGpmQipH9dVUEUNgHSllyILrk0m7jZrgHvaefzmtGDu0RpVdRhpxA/cPMbVN6prCKLYl
         mqnA==
X-Forwarded-Encrypted: i=1; AJvYcCWqCVuV849rTMh4Qs40GOy+qo6a1o+FtwRqm9wUgGEbC8HKKBeZciUYtkiyFvwX4FYggFgIh5YDGf9tQcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz76m2C8jzRHx3QCSLGdDQVHhuRm98W4siphlsinaWutP13P5dg
	vaFit8mKwyM0MO3VxI/FKMOfrUv2hnAGc5WMLJPwOTW62N36rdXOd/l8Y54s+KID7Os=
X-Gm-Gg: ASbGncv4XJBeGXQaAuuiNZ1koTfvz1o/5+ku6c+wYr0i/oLp5j/Zr9euk8pqUaeU3ER
	SQjLjD0yLUEZ941ih6S0pgYI/WUJjC5pQkyVNezhDJv+NMJ9Sg8hRNm1MWb3gHJZ/EVgY+zp4B4
	VCXQpaOTgNxHZDRXKUh3DmmjBK6sXrUPJ3/LBQeu0h5zahnnMHacNQRESM2UhMzR5/V2C6pExsR
	ArVNHEDgnFNCBKE2qyaXFFDJ5NmYOe/aq1bXkOk+glkWp7miSAxV0EZoBvkrIZuWwnWIfiTcATY
	DDNy0lBiEYzHdADGZy/3db5PrikHZNs+i+Ryn9AemuidWFPZ7RPXV3+UhGbkbJrT+KqwgKQsafh
	6xPFt98Y0oRqeeptFRLU2NpFrEVE=
X-Google-Smtp-Source: AGHT+IEoC1tAXROBGi3RQHF7mZb2ZTqK16V1Kfsyori2hyi2oRRR5xleBX3p+LoUN7WuQjvRPkwP6g==
X-Received: by 2002:a05:6830:3e17:b0:738:5294:785a with SMTP id 46e09a7af769-73ebb8bff52mr2499090a34.6.1753223693398;
        Tue, 22 Jul 2025 15:34:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73eb24b1c04sm1228221a34.35.2025.07.22.15.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:34:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Jul 2025 17:34:45 -0500
Subject: [PATCH] iio: proximity: pulsedlight-lidar-lite-v2: use stack
 allocated scan struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-iio-proximity-pulsedlight-lidar-lite-v2-use-stack-allocated-scan-struct-v1-1-4c253339b941@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAQSgGgC/x2OQQrCMBBFr1KydiANVdGriIvpZGwHY1IySamU3
 t3g5sF7m/93o5yF1dy73WReRSXFJv2pMzRjnBjENzfOurO9OgciCZacNvlI+cJSg7IPMs0Fgnj
 MjYVhdVCVQQvSGzCERFjYgxLGFnOlAiPRONh+uNgbmra2ZH7J9n/yeB7HD9hPqNiZAAAA
X-Change-ID: 20250722-iio-proximity-pulsedlight-lidar-lite-v2-use-stack-allocated-scan-struct-bccb4014609a
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=DI7Py06D/Fb6XwmsmpUlNeYX8jsG+Z8UnZwXBY4+GIo=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDIahFgZavapO6dMKBTK/tWa4HhXnuHs5gkXTmRqc5gsk
 Qvw9hTuZDRmYWDkYpAVU2R5I3FzXhJf87U5NzJmwAxiZQKbwsUpABPxKmf/ZxF24nTm75DLH42j
 +JxkmlsemskyPzLb3duwWp3d13Wy5fpjPsWz19x6PGFe1ltlaa0IuUr555LHc0743HVZMOX2L50
 w7hjDeX+FGHzy0vawLLFNvs6/90L00SjDjvLlpu0tO9++8bA5euWYyd1XT70XelbXul5wPVTlcO
 6DSKXakxeXK1g45e1LpCSDt0p//bVvWVlI+WHNu54nApJdeLU4Z6xTFnHRD+RcdDjowUmRlPxuK
 94sjYOq+RsOPJErKg/t/jjzgXYMe7UjnzgL/zcfh0rBb1tOsR8oOTXt+by5O8raLk2eUXHjyUOp
 VQftN1+MO2/dJ25u1Myi9bdobb7VI4ETq4w9595cns8GAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a stack allocated struct for the scan data instead of using the
driver state to store the struct. The scan data is not used outside of
the interrupt handler function so the struct does not need to exist
outside of that scope.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 1deaf70e92ceb788ad8a5b82ea0bd1c28faadf1a..01c013acfda2a2d34f89248178ddf9340a77ad11 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -43,12 +43,6 @@ struct lidar_data {
 
 	int (*xfer)(struct lidar_data *data, u8 reg, u8 *val, int len);
 	int i2c_enabled;
-
-	/* Ensure timestamp is naturally aligned */
-	struct {
-		u16 chan;
-		aligned_s64 timestamp;
-	} scan;
 };
 
 static const struct iio_chan_spec lidar_channels[] = {
@@ -235,11 +229,14 @@ static irqreturn_t lidar_trigger_handler(int irq, void *private)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct lidar_data *data = iio_priv(indio_dev);
 	int ret;
+	struct {
+		u16 chan;
+		aligned_s64 timestamp;
+	} scan = { };
 
-	ret = lidar_get_measurement(data, &data->scan.chan);
+	ret = lidar_get_measurement(data, &scan.chan);
 	if (!ret) {
-		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
-					    sizeof(data->scan),
+		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 					    iio_get_time_ns(indio_dev));
 	} else if (ret != -EINVAL) {
 		dev_err(&data->client->dev, "cannot read LIDAR measurement");

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250722-iio-proximity-pulsedlight-lidar-lite-v2-use-stack-allocated-scan-struct-bccb4014609a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


