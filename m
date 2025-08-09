Return-Path: <linux-kernel+bounces-761174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBBDB1F54C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2179918C01FA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783492BE646;
	Sat,  9 Aug 2025 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkO3G7eO"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F6185E7F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754754912; cv=none; b=GfBSymGnFqEGnl7ktVy3+1NpSTdAGBpaiWXc1OfgGaClFiAmXYFz+ddMvJ3roepbxJ7YktWKaoW/sjQTJbeUO9OkjHU82QKBZKef/UXZGv4qkw6XCQYGCysJFoFPyBlkqN4naxUVAnRMjGMi8cbBxi1CcrwcfezRgf36e8MI0WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754754912; c=relaxed/simple;
	bh=oB+AoY5SJ+eOqn3ChXt0gyBniLHHRoFuwoQPw4b193o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iLqkGXs4oATT54RJ2rtz3PhJRUll+IaDR/q4eevOFfa358QKN3s7GW7pCyK6UIM/QjHXRcH24O4o8ijvEs9mLyEr32fCdAKxhmaMqt4Dk+HiWSafeW8bKUKhRMaqPUsLtGIhP9ea+QgGZX3pCAkD6MYo83w5LNhJAQVp6FXIqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkO3G7eO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61571192c3aso3651243a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754754909; x=1755359709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4F2huRSJ+MrIBP4S7/YTIEg6KxlIUao7Ky64IxMrBRw=;
        b=YkO3G7eONutSoTGWlrMz2x6Gf4B1eXMXO0Npclj9v5Ti76qY54HEl2Em95qxMkLwKr
         bF97cT2rMw1WlQLKpnwJxZieifTGVr+b1cQdSQ1riw9XGyXltYtIKtdSDjg1FlSntb/0
         QAopU+43zKrC6o4PhfpbU3rPdAd8Pr/Fyx8P/MbQ/xJCaNmV2KkUIF6tQzQA33MB4126
         096EnbbDl/bVgKMTK8GiDEA7k/W0S2BCjDtrCnNw5joKHp4wlCsQlT7Wdqk5zYPYYi0p
         kD9UF5hJuRYk1JR1boYVdr/vvGS7CdSiK20u1gdpKmYnl2yBBfDVFw3gbDFhsWSgEjB5
         QUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754754909; x=1755359709;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4F2huRSJ+MrIBP4S7/YTIEg6KxlIUao7Ky64IxMrBRw=;
        b=Rvh/JzjZ1hQA/GQl1emCo3XRp6+r7E1tQEZtQzJDW0ROJnAdi+sJyURsyzluaaNHtD
         ZoKGKlk5dGFly5n3H5fwuL0PjdRyhWQeW+EgdOhR/JPTw5p4Ok3NGB+52Ntz6ZdRTl4b
         qZSsQll2bPYgpkoKNPg05ArOuJCQIZm2e6r78R6mlDpbD471mzkKmm+qQjD3DHHr6zqL
         izgIoZNt48KPXt68efLkz1SNA8VgrvexM+cqwqmJBYbnYsOmX827baDCrGWYuhjJk4rf
         dB/4QNyh02G3hEQXx4jaaLKR7f0/ZHBnjNIBzo3La1vbvb7Mm9D9zE/DJ7DzU5mvZjee
         wOMg==
X-Gm-Message-State: AOJu0YySN5AoABCIKluAAi/QtEjZu4a1bf1qmlf1JbLqoU/A/mfYRV02
	Q291OqeDuxDzqqrcEKVSo3ZgqQC9dSFV+bvY9bPwUYFQD3fmZL6PhmSXglfOfWuMKF8sqhd2Ia5
	X0vMcE0WrbQHERLVsDUJy0TbO/RWjh8vryhQrQRU=
X-Gm-Gg: ASbGncuA8fBMMC3LdKwfNI9N/0QU5dhe//4oStuGPScT05ZK7YMsYTFK8YZLfOs1J7U
	H1TXcJvTn8I+edRfquFP7F1pHNmRfhvh3UkorEc0vOQvV+yQA3SAXhK4IwmOVnhUms1Z3rtSzhu
	EXHCOft4JL+SPnaSUOkTL9Ccc/n2DLpFx9JsrOmX5P841Z5Qgsj79w80tnVv+VIoOCW1LGOD9fI
	DyJDsAL1nxM8HWWY2QqURQA5MJJu9ua02tI6K4=
X-Google-Smtp-Source: AGHT+IG1dYGV8GSjuybMnPF3rBV8GDUZoCUiN7GzvvUKHDYJ7wxDN3Y7r83DuK5hPfyahLIpEMf431q0/k4KxAwL7go=
X-Received: by 2002:a05:6402:430f:b0:615:522e:29fe with SMTP id
 4fb4d7f45d1cf-617e2c4bc5dmr6349291a12.19.1754754909400; Sat, 09 Aug 2025
 08:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: wajahat iqbal <wajahatiqbal22@gmail.com>
Date: Sat, 9 Aug 2025 20:54:57 +0500
X-Gm-Features: Ac12FXwA2xrm9o8G2iUXdnliru3coZl3iw6lET9PUx8wDU-o9PVizXWz3VLJB3o
Message-ID: <CA+LcPJ3nAdBmuSBQ0mgzFmUL=ZE5RKkfp_4dQf-ycTiHxH=PXA@mail.gmail.com>
Subject: [PATCH] misc: ds1682: fix out-of-bounds access in EEPROM functions
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Found a couple of issues in the ds1682 driver while reviewing the code:

The EEPROM read/write functions don't check if offset and count exceed
the 10-byte EEPROM size, which could lead to out-of-bounds I2C access.

Also replaced sprintf with scnprintf in the sysfs show function for
better safety.

For reads beyond EEPROM size, return 0. For writes, return -EINVAL if
starting beyond bounds, otherwise truncate to fit within the EEPROM.

Signed-off-by: Wajahat Iqbal <wajahatiqbal22@gmail.com>
---
 drivers/misc/ds1682.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
index cb09e056531a..4cf4b43e5355 100644
--- a/drivers/misc/ds1682.c
+++ b/drivers/misc/ds1682.c
@@ -92,7 +92,7 @@ static ssize_t ds1682_show(struct device *dev,
struct device_attribute *attr,
  * Special case: the 32 bit regs are time values with 1/4s
  * resolution, scale them up to milliseconds
  */
- return sprintf(buf, "%llu\n", (sattr->nr == 4) ? (val * 250) : val);
+ return scnprintf(buf, PAGE_SIZE, "%llu\n", (sattr->nr == 4) ? (val *
250) : val);
 }

 static ssize_t ds1682_store(struct device *dev, struct device_attribute *attr,
@@ -163,6 +163,11 @@ static ssize_t ds1682_eeprom_read(struct file
*filp, struct kobject *kobj,
  dev_dbg(&client->dev, "ds1682_eeprom_read(p=%p, off=%lli, c=%zi)\n",
  buf, off, count);

+ if (off >= DS1682_EEPROM_SIZE)
+ return 0;
+ if (off + count > DS1682_EEPROM_SIZE)
+ count = DS1682_EEPROM_SIZE - off;
+
  rc = i2c_smbus_read_i2c_block_data(client, DS1682_REG_EEPROM + off,
     count, buf);
  if (rc < 0)
@@ -180,6 +185,11 @@ static ssize_t ds1682_eeprom_write(struct file
*filp, struct kobject *kobj,
  dev_dbg(&client->dev, "ds1682_eeprom_write(p=%p, off=%lli, c=%zi)\n",
  buf, off, count);

+ if (off >= DS1682_EEPROM_SIZE)
+ return -EINVAL;
+ if (off + count > DS1682_EEPROM_SIZE)
+ count = DS1682_EEPROM_SIZE - off;
+
  /* Write out to the device */
  if (i2c_smbus_write_i2c_block_data(client, DS1682_REG_EEPROM + off,
     count, buf) < 0)
-- 
2.49.0.windows.1

