Return-Path: <linux-kernel+bounces-849060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6D7BCF1CA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F7B834BF90
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DED233721;
	Sat, 11 Oct 2025 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THY1O+A4"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C221323C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760170323; cv=none; b=InHB15ifmsV0ytnNZ8rcrlimEYbuch6HsMYNeu9WoHkrlfVnWO2iCdmiFQkPuwfIU3gNefa8jonGHx62+HE8t2H23JxUTRjYn/q2129m2wBtrlluIyLjyPEKFxnNlcNE0BsKREGEtOCCBeEupUvSViIYASEp51jb7MWDotKqgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760170323; c=relaxed/simple;
	bh=l3dtsTPKD7ja5cSlZm3nj/yE7IouGfzVBuBNzd5/+ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eBM7cXMyoq9TMRz72VUhfZz2U+UDpdVr1Aqlk2R8GchE0r1CzGJnQVKXc2T8mknthL2pe3clDehP1gw9bsx06JA4vQTpAcfNLh4iZdFxW8gH/mGMTdJF4KxGnhEri/qsIhlru6KUDdXZ5+9lvu2WUMBthb9Rl4S7uJ633x+mc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THY1O+A4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b457d93c155so444914266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760170319; x=1760775119; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Flr129UWSX8SXF7pjdsaqgp5u0n6XRVU1xssA6urgzw=;
        b=THY1O+A4gmScwnrEx3lfPhyqzfU887qzdZSMLGGe172dS1PZzW0ibbJDe4y8yZbXUp
         Ir4i21lRJdFw+zXVSr/Kv19ZotY67AIleHhWgQ6gyKLfEGziRAgV23Byb3H7EEmhBc3t
         +BxZ53WP5k9bVpNQjTR9CRYK1bH9BJLqFVt25mXpJrPY5JToEwCOxkS6Hjl2a7CTMI6C
         KAw/jfQ92SQ8E60oPp/umujRSwQ5FcIECB4eWS+Jr6tDUxaBtE1YDdD2Vn6rxwQpLSRp
         9ekCRGk6Ctj4oG/DWX0IrwEjbUaWFuea85YqjwRSqHihbnxaL06DgZtYyHfFuyaSqj+s
         xCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760170319; x=1760775119;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Flr129UWSX8SXF7pjdsaqgp5u0n6XRVU1xssA6urgzw=;
        b=d55nyQRr8gKt94Mf5vjZkgG8uk/eWHJzBmMJIUrIrKBDzqdD1LNbsGG9MZByrR4tKB
         GM+0nuJrdX1eiEJLFFBEYCyJ9sC0eud13puQrvWzqc9QvoLRj94CYKVP5zI8xSONMj2Z
         fnB5q5e9yAfh23jg6P9CP4c6uuG2thj5mqpNGJVPp5llRhQV05Bx54WlBCbtkBOaNjNh
         /j1iBufCgBsqHtQ/GxNZDDoo2VFLAZ5D3aMdKpkIrD4DWRU7UNOJfp51vS3Vl3WBc+Ia
         M0POICDwz9+oc5JUCU3YJCnKdcJpQvJ6hmfDpthMOjEzHwOYcIhEkQ385GSLyCCewnk2
         JZKw==
X-Forwarded-Encrypted: i=1; AJvYcCVNI9TdQLDOXMNl2kBofK61grzq4KcWiGFe2+h51/oHfIAHRkFOzK0EYQ6JmABXboxV1BYfY8TfLJvAPOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0YEyBXJ3pv2ZzImY9cpMkF0cpeuaJku5nmm2Cd1XWlhmQKP3o
	YpKGPdiH2rsrJDopn4lHPIVe38C15E1aQfZ5g4T7DA1joUct3jOZzL0qBL0AfQ==
X-Gm-Gg: ASbGncv4nZGUFz24hqsM0fkp6QKqmAoLNRVBoii2+mmrDwtLLPVkS5LOm5ho8Kt2BYq
	+pSsI4zMxgjlAdsWNcOBEJGcNCaFw4wPpQPEXzXRKXbYA//XTLPoAt3inZknJxA8FZ2Vk00l+Uz
	cgrQbAMsQn3USAKEeFeWCDCGR7fjN5W4bl2jqemvi6GVd3GhpovNsMCdDab9zj42Y6BdU6OCKX9
	1DpXiFGo446noLh15SB1xzMxD9FoMQA+aJ1ztuzJNgVav7fYSiLtcYrRB2QxsRMcTwR1+5X/d0a
	rUVt2hoDcHkyuHT/icnEb4vou7nww/eMEjH2Ic4AlpI44JcJrX6A90+ujzsnLA9qJydVkQnrA90
	7kkld4lAjMSm7v/Amu9V68b5g/A3ODRK9p963dHxG6YluMJTMjA==
X-Google-Smtp-Source: AGHT+IH3o8vGhtlvXfVau9yJlPGan0qcPbtv3t8vktLenZO7iFKdltC6qjY3tRHYxMwY2Ztz73G8ig==
X-Received: by 2002:a17:907:c12:b0:b4e:a47f:715d with SMTP id a640c23a62f3a-b50aa08f88bmr1539119266b.17.1760170318950;
        Sat, 11 Oct 2025 01:11:58 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c43:389d:4bae:10bb:730b:cf7f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d65d4f12sm436679966b.27.2025.10.11.01.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:11:58 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Sat, 11 Oct 2025 13:41:49 +0530
Subject: [PATCH] iio: adc: ti-ads131e08: return correct error code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-ret_val-v1-1-8e968b38790a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEQR6mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0ND3aLUkviyxBxdY0MLMyNjsyQjE4M0JaDqgqLUtMwKsEnRsbW1AAa
 rRkJZAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760170314; l=1367;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=l3dtsTPKD7ja5cSlZm3nj/yE7IouGfzVBuBNzd5/+ag=;
 b=sS54gLn3TUckxPhRSL0zRNXRe1Gdh42HpGgckk2CMUfIKiaChL4P1g5uu8Fapl1XwbWrmne9j
 txSMirKcxg+BVXpoqWj0LG6GDFZ6VBSIamnkHjtEwuXUHJDwx0wXU4G
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The error code returned from devm_iio_trigger_register() inturn
iio_trigger_register() can be other than -ENOMEM. Hence return the
same value as it was returned from the function call.
This change makes devm_iio_trigger_register() handling uniform with
other iio drivers.

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
The error code returned from devm_iio_trigger_register() inturn
iio_trigger_register() can be other than -ENOMEM. Hence return the
same value as it was returned from the function call.
This change makes devm_iio_trigger_register() handling uniform with
other iio drivers.
---
 drivers/iio/adc/ti-ads131e08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index b18f30d3fdbe..10330d6913df 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -852,7 +852,7 @@ static int ads131e08_probe(struct spi_device *spi)
 	ret = devm_iio_trigger_register(&spi->dev, st->trig);
 	if (ret) {
 		dev_err(&spi->dev, "failed to register IIO trigger\n");
-		return -ENOMEM;
+		return ret;
 	}
 
 	indio_dev->trig = iio_trigger_get(st->trig);

---
base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
change-id: 20251011-ret_val-3186236b240f

Best regards,
-- 
Dixit Parmar <dixitparmar19@gmail.com>


