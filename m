Return-Path: <linux-kernel+bounces-742817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C43EB0F709
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4A21C26536
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D77B2F6F80;
	Wed, 23 Jul 2025 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qMn/Kray"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F32F5310
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284564; cv=none; b=sqAMUxl6r6QuPwZY9mXNMkYKdbEakWohc1f6PiCHugGyN6RzFifxjiulMrJC4TyBD5oVjPRkwdc7jK+dQWXZBnp/Rp5hzHCx0ij4QAsEUdRoFOdknkRrciGT0rqBIHE0nif/NoDcCiv1V8o05/Yg1ltox78hmDJoGvRafUZSYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284564; c=relaxed/simple;
	bh=I8prMzuBcDXZ857CRmzJv7VW1BMuBb+kd79S5VeLnH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gY+WFOTcymXrhv/mwQ3ZzjMo809dRvCf+Zx8r02A95YEbsqjm5E2uMz8xcwVUhRHvfAgaWMueqi/lhjLHV/cRJGz3nlgsffgyY9nf2heLwtNfO9b0KU14kePs8kZ2FPc6XbRsfvm3fgwplfoACy2e5WF6GfAv/TxS9wOfvFVU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qMn/Kray; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61593d51267so22464eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753284561; x=1753889361; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Al3ZnTse2+tczXQwH279dMGvstxFBA2utm8tKg3aYg=;
        b=qMn/Krayr3JmVRRE/t2wZaonwB32Gs0RI9Zp7uX6np1QCpXFywX/qLvgxq7EXuNOcT
         Fq/c/M19YHleMzOhbhQiRc7XGaywE1yi91TG7SkcSSSBKKuOfL20STGMivskdUArUL57
         RKyEXy+k8e8z5ADg3QwNgjLS15U46cr3FeLZhgu9nHf5dUzWOhOs8YGfRlTugdaMLwxX
         t1FbWbISkeBZcdQHauvjZTLdzqZhZJ1UufgcsieN9tZXI0oXp8PMCzL9XN+q271wt50N
         HrWlpkL2jKnnb+/ND4gmqLJQtXJyCn+ngLk6pQkDgrmGFsSPnN85MgmrrRyoCTmZLzSS
         8QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753284561; x=1753889361;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Al3ZnTse2+tczXQwH279dMGvstxFBA2utm8tKg3aYg=;
        b=p7xi9W2xtGa/3KBEAKR8hKCnevl1q0A1qhH8S8NH+ry2Y1qrOZ9o65cfmdEmYTfeGE
         MyB+S2yVL5UH/ySituMX3z5RCK1Lghw/fE2C/ApV+sgNov92x1CUalGQcOH+AbiBh9CE
         p+RdMtotnKmu20tZWAerlGO0mHEAihxYiasmUAebL5mKhuuD9MV0BBJgEmscKHO2kuXt
         kLSfpMygnxJaXlQZnI7CdcMOmvKrqlfedjkFN6G+fiQ2eqrpJ/0cF7wyVqEcvd86bZWz
         HG/NnMMj1G+Cw+ZVK3mXDYOMzMEoOUs0Uf9Qb8l4tb3WTEcCZMifqHTDcDu4Md5i1lId
         tRkw==
X-Forwarded-Encrypted: i=1; AJvYcCU9O8Uuz0Aj2SD2WvvyxzhYBCFXRr/sjgmNb7IgOkixGppK3oD/ha3N7QOtLQM6F0iGgWZoUj9jLUywkKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdZF8YRUjU8PCqAbiCwTfTY6yKC+2YdGAUwahNgmabQB6+Xkov
	KE224xVUAVE1pWAE7VYwXMBmXns0WZ4pnthG6qNjoT2zcs+CiK/JSlgaFSn/JmgX887RmXpZjZm
	zR3W1
X-Gm-Gg: ASbGnctJaJwAfOqX9x3/j5wlo13kZcTK/vNdXz+TeVLxd+WP2TQzf4O8DiHlANIXgqH
	sgxLFQP7Lvgrq0mz1vq/IzJNABstgIMLAR9TC+2ei8IR1FdU/ps76XVq4HI5HSdr95jSKuSMPsG
	PSX+XZ2EMBy3PNWGi7Qfn553w0wT4zlEqYbznbx2taIW1c4cv4Wl2ukIrDGPeL710hZ33J2MdSJ
	z9CrGOHyeQ29AffHAkdCV3WXmltiRtTIAG+QnEB/+PRuQPhxPGl6vJvGdFY4xtwTJj5icSsb3l9
	7Ba3DIJulVQeqmnZzjaETFWOmgmjhiiSK65D57MIs1XGS+lxoBeVAhl9A1fjDiGa/J9yARn5NXO
	Tu+loXpfZwt/t8xXN5AMi8LVYf9k=
X-Google-Smtp-Source: AGHT+IEsag1bTNogfBmOUZnDG8/YmooD6O4BEiaqkmsTy6ubZndk9JILI+eemiJPseoD3CNhHpwbmA==
X-Received: by 2002:a05:6870:c394:b0:2ff:a521:1c2a with SMTP id 586e51a60fabf-306c730c84emr2236672fac.27.1753284561145;
        Wed, 23 Jul 2025 08:29:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30104694f03sm5106877fac.44.2025.07.23.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:29:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Jul 2025 10:29:12 -0500
Subject: [PATCH] iio: accel: sca3300: fix uninitialized iio scan data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-iio-accel-sca3300-fix-uninitialized-iio-scan-data-v1-1-12dbfb3307b7@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAMf/gGgC/x2NSwqDQBBEryK9TsN8IoFcJWTRzrRJgbRhxoSge
 HcHl4+qV7VR1QKtdO82KvpDxWwN/KWj9BZ7KSM3puBC724hMjCzpKQT1yQxOscj/vw1GBbIhFX
 z2WmpcZZFOEU/+jhchz44arufok05Px/PfT8ALx5ohYMAAAA=
X-Change-ID: 20250723-iio-accel-sca3300-fix-uninitialized-iio-scan-data-c31f13b4b520
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=I8prMzuBcDXZ857CRmzJv7VW1BMuBb+kd79S5VeLnH0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBogP/Jnw6zfc0b6WaXfQK7r5GRTKeQvgf+kXrOu
 G+0I8GF83+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaID/yQAKCRDCzCAB/wGP
 wMhJB/9qbNTaq/BdobRSDB0Dt8gq6aL4ZO0qI3hM/0SBReFGzc/YTiY4D647tocco+x0v+L45p4
 v2k8QhQKAFuQXOM2eQt0Fp174Vqz15bn4B2JljXed5D7GK6htze5pqL7jAxg632png5OzfzeBGq
 OBfUGYP59veSXLNBpMt4VPsirD992HxNggKYoQnkxWNQNViJTX1EPL4ymEoG8pI+DT44TaM6zSO
 asjIpb88+06yEbHp7wkizrJq7X7Rq3pVVqJOMpGKypshj8vn5Vnhkf1KSNcfdKA/p+vLQNvMS3J
 D1FTSUuwqv86UGG0RD5lzhD50Eeql5cZvdAGNtK53EfBKz0z
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix potential leak of uninitialized stack data to userspace by ensuring
that the `channels` array is zeroed before use.

Fixes: edeb67fbbf4b ("iio: accel: sca3300: use IIO_DECLARE_BUFFER_WITH_TS")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/accel/sca3300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index bda370c0f660b2a603d7d70dbe5e088bf96eca7a..8380b237831cec8e7520335dd9f78a2f30531448 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -477,7 +477,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct sca3300_data *data = iio_priv(indio_dev);
 	int bit, ret, val, i = 0;
-	IIO_DECLARE_BUFFER_WITH_TS(s16, channels, SCA3300_SCAN_MAX);
+	IIO_DECLARE_BUFFER_WITH_TS(s16, channels, SCA3300_SCAN_MAX) = { };
 
 	iio_for_each_active_channel(indio_dev, bit) {
 		ret = sca3300_read_reg(data, indio_dev->channels[bit].address, &val);

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250723-iio-accel-sca3300-fix-uninitialized-iio-scan-data-c31f13b4b520

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


