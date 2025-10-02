Return-Path: <linux-kernel+bounces-840720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBBBBB511F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 955073416EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326E529E10F;
	Thu,  2 Oct 2025 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHf2aNm/"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAA299948
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435377; cv=none; b=H+BNQPVDcrwNQRJmdBAL1cpC9VqR/Mk15xBHAX4OUmC0//PufsO0v1qmWpcQWwODZDmSflV2Tpbf81Yj308JUJ98V0ctI9wwxAaaFv5V8mp5QRCoawiAeHRGo1hqxEewhBguRjyGVQmGb9bg9M2WoOQ0SF0JKV0UMn+KUrJH5Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435377; c=relaxed/simple;
	bh=REDD5MKT+T6fE11WtgKxnSCfTx1waCKVI6IWJJQuEiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GO3WktHDusA8SzIn0d+UcQwCFaGG+uFhjxXaD/auXvl/+CxVIy5MC14nCjv45Tffi5o53FrR4KK4c4lNCgkJE0aZk4gP8O67q5KU8DboT5WbwuJqT4Vjr/mF2+ioGH4KLEbqiGq5tJcdz9agoSxdqZm23RnGo1od8fiz7d1lT7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHf2aNm/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-637e74e92easo1656324a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759435374; x=1760040174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5B+iY1CVYEWEXhFVr0arn1MWUauujSFMSYkHP0zG1o=;
        b=lHf2aNm/HR0E1L8j+2OMz5cHcVL8uyDCe9WYS6Q/U1i6WB6ObwzglCKTQ+NWWA7H08
         yZGYi1j+BTjn6IdHumi/76nclBQ2fhwxC9Zq7Rd2muJpgAphvqJMJ8WPwjJWykDOm8dU
         u5pFa+kEnTtLi2P4SCY87KZo+TqwSkeVAwCUSlRh0rm0rj3EHJOqd3Yz8YEBNxR7iZ1Q
         ctIWa+AzzIUuP/GkI+MGhNiuQG+Zskr80pg8FnrkGvZO4z14QANmYNR0KQlGsNB4NrmA
         jbSoERbHa/eQQcCuR7hv1i/jS3RWkb8+gwAyYsRxyq+2Af8uAg5BE0c5yfhYBcoTuZxL
         F8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759435374; x=1760040174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5B+iY1CVYEWEXhFVr0arn1MWUauujSFMSYkHP0zG1o=;
        b=GdpF7z5CkqPBKJVq5vpLqVNYVZ5TnjiDmrbIBAuNumTj8K4c5O0z5yxjCD7c1cCaD7
         fsR+ZXrdc12WdwrRD1vI1EpbyZRBF8cSpleHUW5sJ7rpgg5UDP/eGW7zzDksjwEXXSSL
         8H3y9Bw+nhuNopvjrrkjpFGFOwCqSc4d9K/0hPVsByA7tRSbXWxW8s5b+tACyER2aPbF
         h/RwN5t5HpOkpzNQTKqCRYVPMU7M8bi8d0tnua3CZJpOViMXneCpJsJEyQfVHYTZwTDk
         roXOYuNc4+jRmYW1Fv6eKrybdZwo/QlkVqrYBhzLoaqbbe3zKSzQ0hfHP2kVYQxuBlB1
         557Q==
X-Gm-Message-State: AOJu0Yw99hVayFb6mmBAXlw+VHQd2TNJqNuM8HBKjtDydS5PWBMeju1b
	6zWiStkX9QTTmYEK6zVGP6DHAUKoR86APGAxGICDQyszgSC+QgBQECfc
X-Gm-Gg: ASbGnctzYHvdDucI6fxvBPoprKucPG1S8P7i3UWB1Nv8xpbmJ7gNSQB9jz9H+tHiRL1
	xyxE5kJ2JTbwHEI6d7/yO7Ti/rYbt4RA7dRXH6q06E2YUi78SaH0lOtE1/hK6+APr0ZmrvY/F8S
	Z0m0cgH01W0D/Db2Rj95h6WaCUDs7KdMWY/FS3OUL2urppdUHjdBI5eXgRlQZhgRUi0/ymoC91C
	cHrTDISPdAHrOo78mHOWranGd5PC4QA3v4PTaIDMsLpKcYC5l2xF7O4tN0Iq4NaCFtMevq0Cxtd
	iPJLUZcITQ9jYXaA4GgcVnFgR+Aw357RcuGi2TPkOe7fy5ibKJOJvgQL0IJ9w0KU0f+4AixTBFb
	ej0nHjtzH43OVPJGkanUXNTBHay622UonZ2nVAf2ghXjUfCzCWjad7eE=
X-Google-Smtp-Source: AGHT+IHLLuSxZSfWj6JmA7gazFVSXaP5F8QLszT1jN6eLNAVZ7qyjvjL4BW50x/00CvbU9ELpFQ4Hg==
X-Received: by 2002:a17:907:6eab:b0:b0d:ee43:d762 with SMTP id a640c23a62f3a-b49c12809ddmr83263966b.4.1759435373813;
        Thu, 02 Oct 2025 13:02:53 -0700 (PDT)
Received: from localhost.localdomain ([78.212.167.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4c1f6sm270880466b.78.2025.10.02.13.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:02:53 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 3/5] iio: mpl3115: rename CTRL_REG1 field macros
Date: Thu,  2 Oct 2025 22:02:04 +0200
Message-Id: <20251002200206.59824-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251002200206.59824-1-apokusinski01@gmail.com>
References: <20251002200206.59824-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the bitfield macros of CTRL_REG1, so that their names clearly
indicate their relation to CTRL_REG1.

This is a preparation for introducing the support for the DRDY interrupt
which requires the usage of other control registers.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 1da78081ca7e..61830edd959b 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -30,10 +30,10 @@
 #define MPL3115_STATUS_PRESS_RDY BIT(2)
 #define MPL3115_STATUS_TEMP_RDY BIT(1)
 
-#define MPL3115_CTRL_RESET BIT(2) /* software reset */
-#define MPL3115_CTRL_OST BIT(1) /* initiate measurement */
-#define MPL3115_CTRL_ACTIVE BIT(0) /* continuous measurement */
-#define MPL3115_CTRL_OS_258MS (BIT(5) | BIT(4)) /* 64x oversampling */
+#define MPL3115_CTRL1_RESET BIT(2) /* software reset */
+#define MPL3115_CTRL1_OST BIT(1) /* initiate measurement */
+#define MPL3115_CTRL1_ACTIVE BIT(0) /* continuous measurement */
+#define MPL3115_CTRL1_OS_258MS GENMASK(5, 4) /* 64x oversampling */
 
 struct mpl3115_data {
 	struct i2c_client *client;
@@ -47,7 +47,7 @@ static int mpl3115_request(struct mpl3115_data *data)
 
 	/* trigger measurement */
 	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
-		data->ctrl_reg1 | MPL3115_CTRL_OST);
+		data->ctrl_reg1 | MPL3115_CTRL1_OST);
 	if (ret < 0)
 		return ret;
 
@@ -56,7 +56,7 @@ static int mpl3115_request(struct mpl3115_data *data)
 		if (ret < 0)
 			return ret;
 		/* wait for data ready, i.e. OST cleared */
-		if (!(ret & MPL3115_CTRL_OST))
+		if (!(ret & MPL3115_CTRL1_OST))
 			break;
 		msleep(20);
 	}
@@ -268,10 +268,10 @@ static int mpl3115_probe(struct i2c_client *client)
 
 	/* software reset, I2C transfer is aborted (fails) */
 	i2c_smbus_write_byte_data(client, MPL3115_CTRL_REG1,
-		MPL3115_CTRL_RESET);
+		MPL3115_CTRL1_RESET);
 	msleep(50);
 
-	data->ctrl_reg1 = MPL3115_CTRL_OS_258MS;
+	data->ctrl_reg1 = MPL3115_CTRL1_OS_258MS;
 	ret = i2c_smbus_write_byte_data(client, MPL3115_CTRL_REG1,
 		data->ctrl_reg1);
 	if (ret < 0)
@@ -295,7 +295,7 @@ static int mpl3115_probe(struct i2c_client *client)
 static int mpl3115_standby(struct mpl3115_data *data)
 {
 	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
-		data->ctrl_reg1 & ~MPL3115_CTRL_ACTIVE);
+		data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE);
 }
 
 static void mpl3115_remove(struct i2c_client *client)
-- 
2.25.1


