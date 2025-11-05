Return-Path: <linux-kernel+bounces-886206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F47EC34FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B458518C1453
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E092E092B;
	Wed,  5 Nov 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW/WfXXc"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686A30BB8E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336606; cv=none; b=HbO8qv25BEuB4C55YYuxH5I3jd7Lw12H3cdoPhEYSvM7nTSIq1fGZuHh4q5PkF7NRzpJFrhn08Rb+baW7L16uw6zsvHZGy7xB+DjBf767olaTE+f4lS8vudgBbfRTizxSrEnxtszwOF8qMij/84WhLYGagjPQ/YftRZV5CDl20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336606; c=relaxed/simple;
	bh=9jDhtWjuevu6CdsB87jNrOsEaQLh8BZzx+AyuRQWajg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XyRyu477fX6S2jG6CNTzHaiSuaausaKSxCUqT3zhFyF1z3XBR13DsqAuWxM9PUZcT6xW54kpYcWpLKr4vYMp5/1TehPPeeXWVeu1O2YCP45Kh9ebFr1CKF2ihPeyXzZ8etBHz4eCX+XJSdtaPSG+CUkFU60MOKNmABB02ZtQHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW/WfXXc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso10875611a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762336603; x=1762941403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KbnQuXXseyGUNqWVz/VXg/m4YsWfHrn95OvOMxkE+Y=;
        b=LW/WfXXcVEWh8kdxlFv9+3gOGe1uaKmxBEjgyOdbrfUUa4YIP0e4eoiCOv9vqXyJy+
         CsBQSFIEnC8rb7lAxuwOAnJZOEEiWUUgiXT0axXx/X2ny+0dRE+fL+ZSBkPe3y5DC/NX
         qWeahTI3aDR/SckukbVK/01nsvOJhW8csADwT1HyWSfVzDRJ0h5tv41iWH2u7SXxoZ89
         4+yEIRJ9RnHxBLb8Cfmu+FxgMV+5gu8KJDZzIBJUl4QSMCyDcCTpQi+vmBd/gXpE7Ssk
         0Cb23DPljVIb8qvKSpPFQiHqm6SEV+suv4BD6qV9LXmhJxpVkhrms8DMDC+AuBZL8U8U
         XHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336603; x=1762941403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KbnQuXXseyGUNqWVz/VXg/m4YsWfHrn95OvOMxkE+Y=;
        b=P3qn8xpGajIce0gYUy+L8zVuDFDzbEhnv9SdkGxRj6KC6hkSckhuoXrxwJr7FUOSOP
         dMQQ+IdV0sGY3DWNuovVzocRh7zkk7wsLCT2zAx4SKYFZY0y8tpXr0nrG8W8sYIlfqEQ
         +IiB5ReaivafqLKQGlb799JywSlzalo1ArETHuNZgkcKHUerMINd6D4CY6IzD0c+BhvI
         VYfdWFL3LH0E1n3Grgp83aNbMIyDpQWqEnfuTKuFedrAztRplEFXbLJa5vYDoAFOqdMX
         DFYnaHECwfcZZScQmzeC4+AAYpdBQ8u1KC5w1v6iMB3IiX69xjrI381Tq5AArXZC3V3J
         bpFg==
X-Forwarded-Encrypted: i=1; AJvYcCWjcwVnjsB2cSzKIAjPQbQA33Fk/DswJkVLLULNoEPgoAnjCvmETG4g6WolYvVU8k1xENSLpoz6qbXnrb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIh/As+rZ4mXrbM1nzeyaKMIFV97mwXRKMoLm3EM2gz/DwVVlP
	k8nh9tWfv0hC1OoGCk0ly4DluvDMgxH/ACnVCV8IGkOAWcbGJjwZ6/wr
X-Gm-Gg: ASbGncsPRXMhfWAq+3NI2VB7cHmda9GhonMrGhyj7VwDbbv9Tuy0RQujnbo12vv64iF
	O+vVHpz8Za9aYsBNkSYko6a8eJP829W4E4FwGCXYBxaDpssAsUms+bFhLWsIr8xmHOutvUZuwhQ
	QEetYt/qLu91rpbLu0pyBD/MmefoX9d7584xocwibPCQK3dyDAP4i4pj2a2EVarWOPDS+yUR8vE
	QTYAWeRU8lIrZt4GJHhm7VOZ3F79ubg1WahDHwEBfXBgomH3g7u+sgXCwtascAe5In+qIVqF25f
	CLnyHW4Ii+52aeGW9OZCPv1ns65Nxl/Wmudsy0bLFs0lknfK5gCy1Tm1PSosX0WHy6wgQfbLOVy
	gLSLloAhrO0m1fJyoxVGoBJ1csoZ7S4gsJ94EJUjgItNvaW8uzJu5Ugn16BL56Q0doqp3K2cAfe
	D3vM5KUUkj14ZjXXdKg2bHn4dyyeI=
X-Google-Smtp-Source: AGHT+IFOL6YWrMfoVg/Zxx60R42xpvCcCLaX0Wl7mOAh4GhNX7Za2nI5JMC6KreQGXOUeL/cjLKuRA==
X-Received: by 2002:a17:906:4fce:b0:b72:1ccd:2442 with SMTP id a640c23a62f3a-b726553aabdmr207359966b.47.1762336603201;
        Wed, 05 Nov 2025 01:56:43 -0800 (PST)
Received: from localhost.localdomain ([78.211.196.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37b7asm440266866b.60.2025.11.05.01.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:56:42 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 1/3] iio: mpl3115: use get_unaligned_be24 to retrieve pressure data
Date: Wed,  5 Nov 2025 10:56:13 +0100
Message-Id: <20251105095615.4310-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105095615.4310-1-apokusinski01@gmail.com>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pressure measurement result is arranged as 20-bit unsigned value
residing in three 8-bit registers. Hence, it can be retrieved using
get_unaligned_be24 and by applying 4-bit shift.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index c212dfdf59ff..3f1fa9fe3c76 100644
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
+		u8 tmp[3];
 
 		guard(mutex)(&data->lock);
 		ret = mpl3115_request(data);
@@ -134,11 +135,11 @@ static int mpl3115_read_info_raw(struct mpl3115_data *data,
 
 		ret = i2c_smbus_read_i2c_block_data(data->client,
 						    MPL3115_OUT_PRESS,
-						    3, (u8 *) &tmp);
+						    sizeof(tmp), tmp);
 		if (ret < 0)
 			return ret;
 
-		*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
+		*val = get_unaligned_be24(tmp) >> 4;
 		return IIO_VAL_INT;
 	}
 	case IIO_TEMP: { /* in 0.0625 celsius / LSB */
-- 
2.25.1


