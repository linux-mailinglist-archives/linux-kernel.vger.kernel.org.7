Return-Path: <linux-kernel+bounces-898284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D7C54C39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1B6E4E01BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D01F2ED15F;
	Wed, 12 Nov 2025 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI7RZwQy"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0D2EA498
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988247; cv=none; b=Fgw9RWIqOBXkO8JplY9i+SyEKIQzsc2Vivzqo5J4jN2ulcHUViLhqKKVOUFw5hTgadT/CixJmLWRq3+dMSh7qGnrPU0QxBGXqIOEhfMRlv67puuAUsR/eL/3TxfHdPOtkH2d2yjimUxJjw5ciCGt9fg4P4qcs1uxRGRlKEEvrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988247; c=relaxed/simple;
	bh=4R9uJSwfRDFDC4yeCtA2URaQMWypx5dHgLVpcs09cS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MunIFzX4ZXaIgCkisc6tA8DzbOmfZ8I+8LDWfrW+aecbMofjwlQDsq1nOaSnERKjwK5YhoF5ZmpfZklMO9fxbrRrx1qWwTgoDmhIq5657+InMfdv0DHCL0poDDk0XKCp6cJz+be09WN9gu09Tz3SXqnkPLLgcyriJSCahWUjBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI7RZwQy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so104872f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762988244; x=1763593044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7502WjO5EoP4P++yfuX6KQ8nm9HsOVK8ctMCfYyteQ=;
        b=RI7RZwQyJyhgcL/81aggSimqFOzcGHv9XpO3DADaThX7Uv694ufufowg0WKV/iLvai
         2TvIAdkYlxFWmL4gD0uV8MUBt/r/RAwa8nW/ARmWNZ4rLDXKGfuX7MHmVINt4Aq8+qxu
         U9NBMbqcm7YkqI4Ol74FFACNGOC+G50h9fszoPikZRlQ6Ursy0FI9iYUNo4P5OHn2tdM
         UjPxu69eZxzGtzfTuM39i4QhP5/dBdOXzNyxE92SyKhacKQM6pQR/SHoJr7nXmG0pAo7
         eILzDel/GV1GGkWDLfmZaK4HBQDHQkOTiGyJ8XFxZ3iHD1ef6AMt2sGgcTk7/SJ+urTx
         w7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762988244; x=1763593044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7502WjO5EoP4P++yfuX6KQ8nm9HsOVK8ctMCfYyteQ=;
        b=QcCuSfuoqW5QEkHisx5ZLpwy+Rl7922BVNaPHO+odDyFPfASJ1IUwj67U8NJvSVfSZ
         oVib6pXWA+vi3zoAbqJLaVnkwrBwvt93hBKjX5IQXpZW3RiH9bjT37hPWWT5pHNVRyeo
         8C6ZB9B7E9T3EJM+Azrh9PdYPOLJYJ0GMCc/Bb4dBwXf/NYpWw8HzhKO7fpA0s6eVdFZ
         /iMwzxDebnuS/heKyOUNIpB2yYXt/46dNiYBkmG0ibrJgYxA7dQ7vr58gxP8EWC8HeUo
         FZUV59k5wGSO5tK5qcmMACkj/JSBXn4kGVUf23dSGaIn6lM6aqxQ8K9llBD6xJqeix/r
         UI0w==
X-Forwarded-Encrypted: i=1; AJvYcCWCctCBBdsIjTX/1uN1g3/4fF+MAkG+L0Q5H8521AV1K/zE5piiRBd4DQK5GHevqUh67QtMbBF1jNjFy9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3ZoHwil/WfKIx9a5s5ltpXtDOcIzBxdTuAJ5x9PHwt2wmGio
	Sp6XsYbZUM0DVdzrT0P2f2w8ieR1/IiOL30841sXMQYeTpCb6zvk+iO1
X-Gm-Gg: ASbGncunr3gR7maJ49HbaEB+do2cgrvQua6VFF7+DeY9CsGZWhrtK2agc2yVSYHfIYH
	eWItal4sg40iqZuMYVkxYy0w2FDKSo3I3ujbXVcCP/k6jLCac78Po6Gti8zvIfxZwULY3bmYGP7
	tYfhx8zvdO22zYa8Rr96WGA2Xz/PkheMx6yx7y3NhmfX5jDVGkLx0BmvkfdL7IHxGJ2JCUe1C3w
	ck66pFmiE3eUOS0H9QvA3aGz960CVKUgUWiJM9v1M7j77U70KAoBrEkp/EjQ9GVqq+rkr81n+t7
	DHy6ID5fOg3TSXhgaMCXZCPAsKzOWwqjxOoOAsKd5QM/vGP7Grp41BUpttuKpdgvCXvKEc/k9dJ
	b77Dr3Y1RFv9/nvaUmtQJiOy1wtVaoCJcOZ0FwCitRUgEXUahRK1FHRM3fjGoASvIUSThagavPS
	l5hvpa4cE=
X-Google-Smtp-Source: AGHT+IEZeLFhjKlX+2oecgSyqmpUsjOHozvWH5fS1TJhDkljS6rsAK5pW51JKAcYLMQ4PnfaBkLYDw==
X-Received: by 2002:a5d:5848:0:b0:42b:3298:4690 with SMTP id ffacd0b85a97d-42b4bdb020amr4463095f8f.33.1762988244234;
        Wed, 12 Nov 2025 14:57:24 -0800 (PST)
Received: from localhost.localdomain ([78.209.131.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm236979f8f.17.2025.11.12.14.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:57:23 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 1/3] iio: mpl3115: use get_unaligned_be24() to retrieve pressure data
Date: Wed, 12 Nov 2025 23:56:59 +0100
Message-Id: <20251112225701.32158-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251112225701.32158-1-apokusinski01@gmail.com>
References: <20251112225701.32158-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pressure measurement result is arranged as 20-bit unsigned value
residing in three 8-bit registers. Hence, it can be retrieved using
get_unaligned_be24() and by applying 4-bit shift.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index c212dfdf59ff..5594256fffbd 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/unaligned.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -125,7 +126,7 @@ static int mpl3115_read_info_raw(struct mpl3115_data *data,
 
 	switch (chan->type) {
 	case IIO_PRESSURE: { /* in 0.25 pascal / LSB */
-		__be32 tmp = 0;
+		u8 press_be24[3];
 
 		guard(mutex)(&data->lock);
 		ret = mpl3115_request(data);
@@ -134,11 +135,17 @@ static int mpl3115_read_info_raw(struct mpl3115_data *data,
 
 		ret = i2c_smbus_read_i2c_block_data(data->client,
 						    MPL3115_OUT_PRESS,
-						    3, (u8 *) &tmp);
+						    sizeof(press_be24),
+						    press_be24);
 		if (ret < 0)
 			return ret;
 
-		*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
+		/*
+		 * The pressure channel shift is applied in the case where the
+		 * data (24-bit big endian) is read into a 32-bit buffer. Here
+		 * the data is stored in a 24-bit buffer, so the shift is 4.
+		 */
+		*val = get_unaligned_be24(press_be24) >> 4;
 		return IIO_VAL_INT;
 	}
 	case IIO_TEMP: { /* in 0.0625 celsius / LSB */
-- 
2.25.1


