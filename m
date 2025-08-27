Return-Path: <linux-kernel+bounces-788236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E20B381A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FA717EE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9F73019A2;
	Wed, 27 Aug 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKD/8t11"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3330146E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294866; cv=none; b=bdzSGb6GpXGPqcPHK8Sfgah2H8Jd4VL2wwH3rREdrtgEbB1mFCTCIdDwjUBpkExHz4pJls3anrMJfCVVTETYR1LYcmzBIqdkEAM2iJvxch++uhjb8q1lKuYYa1UJ/zIPzt436tgpsh+LG0lCJ2Phl+GoK7XUtiNCgv6Kz5vLik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294866; c=relaxed/simple;
	bh=pgWs9Fl3AjMXf1LDTSZaRvAPsDeDuu34wIaIvn9qwSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OfHajw/9hT5N+v/IhCq53soNaLt1rC1LDXmc61DbJI20VvSJlbOSbVS+dC6NSaEiFIeNu24OOz07owmApmmne0LYeDK3y7tMab8Mi8jooxMRjzGED9/6bDJkhPPa07C+Bjbyi8c59L+RzexB6n4Gc9avLEs4azS6bbm23HKQWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKD/8t11; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb78ead12so937911366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756294863; x=1756899663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F5UXkam6EZFJ2kTkcI17dPcXugh4l+mwYsBdJc9Nb64=;
        b=kKD/8t11R2K9+t+9/kLCY0arii9GVQ54IIQoJngjBqCc78yN0+Q/ohxTNaEuHWRwmC
         Mc/5XOqgSQPckYXA4A9PkS1KmaiQGpPlNKGcq98a5HcTkPHhv9ok2+enT1aoOugu0GrJ
         fk3zrVcPnYQPnOcv1CPxN0wtC6im3GuMVPhBJTYyZnh7Dw7FT/j83LeY/oKNlCaD/qPI
         YSNo3x6G/H7dGh92bfjR48cueZp2vLy5//Ixjfc1aSgZq/XG80CzEYK7vm0VbA2gM19Y
         6qqOZQHUU+HaJTnfO72A4Zy073mgjay/e7BR0tszEjIXbvDWtGt30Mt8LTXfiZkaXvjh
         bzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294863; x=1756899663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5UXkam6EZFJ2kTkcI17dPcXugh4l+mwYsBdJc9Nb64=;
        b=VqR8bDGM8w7rCEP1KveJxl6wB1qa2PADLGSCAT9VnZN/7NsNHgFDdwhldcfaGEluJT
         qToCo/5ak2m7oVfQ3bzdajIMj+dm6gM3hCWK/xvZSyGtiDHcgvB9ZSwIC6CDplIEPY2p
         8siELf+J0nVaw+v9QTJV8vNJEU5joEVIAj3fWQmbQRqOGTYUUZOPPZisoiVw/YIqFYPo
         PWT946XdQDSn1YSY0UCgQhCD2R5pktiL7fM7MH8xVKgoXhrxqfyphiu+fjb7shfYPq0Z
         GLSpibaI+ten3eHyTonQlDWvHXb+RLAwqykEPspyAtaKJZwnFvt7A81DNzhgzamUL9CA
         9+eg==
X-Gm-Message-State: AOJu0Yx9AWfoXyIY/2ywlxeh7jkTE0w2CSZa2hYecmEVkDpHbgEVQr42
	FYfG+YxS1bVYRe9u0SPZGAh7Z4EIwOPhPCQFLOg8aJQRoSoEGlTb8X9QxvH3Bh4q
X-Gm-Gg: ASbGncviJcJJL1o7NLro+mt3Jsl+oyr3kaYOzs1ncyMRNo2ocBcBd2/CNZnWeK4hDvv
	e11MLsnpS3u8SvlAWTUBxz0ImWyJHArbfen7HE+oxJRhh8ZbkWk023BcBgIq6C0kW9OlvoERw/W
	G0DFcSiiHYL7pveIywgDQsIjy9WigldsESZeIRQm16nX7vNM4i7Lq4e4cQ8hbcF66+MHkve7jdR
	/jbq4iQsGxkKTSXldLHcT9ehzG51U2P9wsoXwMs2mXN6LG2qRJlpULmt29440PQeEYSFSWENwh5
	G8a7qwlYXDEdcW9IKv26/rPOaH5L4bhucTwC9u+jmsIpuor+oZ3soUI8kZ+g1qB8fSpB7kjyBn7
	mqn0KRu1JQqJLXw+iPUzGnjci1nM6jSerfksxNr36G7oAGNcoK5GWL6xB0VqBHxi736/KzVTHDL
	0dUkJJ+2Jk7Vm+NpO003OQARSapKNpP2VvJ2c7UhewaEu6XRDg9Y/R6wQfmn4+cIRK
X-Google-Smtp-Source: AGHT+IGYhcCBY0Z6VtU4bCCKfFBVqvgDRnjW3XahYt+KCx0GJMTDNhG4q4QETcByqCiQjaB3Rf8D6Q==
X-Received: by 2002:a17:906:fe01:b0:afe:5ce6:3bd with SMTP id a640c23a62f3a-afe5ce60598mr1212751166b.40.1756294862864;
        Wed, 27 Aug 2025 04:41:02 -0700 (PDT)
Received: from XPS.. (ipservice-092-210-202-008.092.210.pools.vodafone-ip.de. [92.210.202.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8725112bsm571725166b.36.2025.08.27.04.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 04:41:02 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: gregkh@linuxfoundation.org,
	dpenkler@gmail.com,
	matchstick@neverthere.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v2] staging: gpib: simplify and fix get_data_lines
Date: Wed, 27 Aug 2025 13:38:57 +0200
Message-ID: <20250827113858.17265-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `get_data_lines()` in gpib_bitbang.c currently reads 8
GPIO descriptors individually and combines them into a byte.
This has two issues:

  * `gpiod_get_value()` returns an `int` which may be negative on
    error. Assigning it directly into a `u8` may propagate unexpected
    values. Masking ensures only the LSB is used.
  * The code is repetitive and harder to extend.

Fix this by introducing a local array of GPIO descriptors and looping
over them, while masking the return value to its least significant bit.

This reduces duplication, makes the code more maintainable, and avoids
possible data corruption from negative `gpiod_get_value()` returns.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
Just print the gpio pin error and leave the bit as zero
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 28 ++++++++++++++----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 17884810fd69..f4ca59c007dd 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -1403,17 +1403,23 @@ static void set_data_lines(u8 byte)
 
 static u8 get_data_lines(void)
 {
-	u8 ret;
-
-	ret = gpiod_get_value(D01);
-	ret |= gpiod_get_value(D02) << 1;
-	ret |= gpiod_get_value(D03) << 2;
-	ret |= gpiod_get_value(D04) << 3;
-	ret |= gpiod_get_value(D05) << 4;
-	ret |= gpiod_get_value(D06) << 5;
-	ret |= gpiod_get_value(D07) << 6;
-	ret |= gpiod_get_value(D08) << 7;
-	return ~ret;
+	struct gpio_desc *lines[8] = {
+		D01, D02, D03, D04, D05, D06, D07, D08
+	};
+
+	u8 val = 0;
+	int ret, i;
+
+	for (i = 0; i < 8; i++) {
+		ret = gpiod_get_value(lines[i]);
+		if (ret < 0) {
+			pr_err("get GPIO pin %d error: %d\n", i, ret);
+			continue;
+		}
+		val |= (ret & 1) << i;
+	}
+
+	return ~val;
 }
 
 static void set_data_lines_input(void)
-- 
2.43.0


