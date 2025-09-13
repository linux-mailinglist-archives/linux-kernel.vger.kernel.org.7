Return-Path: <linux-kernel+bounces-815066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBBEB55EEF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575F85656B0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E342E7652;
	Sat, 13 Sep 2025 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmXKjmB5"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009F2E718F
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744772; cv=none; b=R1kHk5wkKTw/yjVIXzvVt42ICl8KCt97ES8hHMeyIOwMGmamnZ3ykccbj2vbJb0U4RRVELZSetLFfOYqhh6HpXANpx8H/vra6pNu28Gv9r6AigOnHr/3B2HO7NZlSGVwLxPHL32xlJX1ZG+0TIF39GeBdX8jx88krdDEZbbGq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744772; c=relaxed/simple;
	bh=eSwL1MT+q6WDO2KrNb5iM6MU935ElZHmEA8e3Mn7/nE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GbGhE0OwIWpdvOEbzXeUSwaSzWi0IqD/Y5EqTzBqBDDVoD96MSLpTtNTIR+HKxZ2kEwJSsVViCWrXE7Mr5TW1NroGoK62xlaFrlQHoO2k+UL80c7TmNdWgB4ntYacF7INrRSTOZWfGRp1S8gRN9RPWMYv2yoOiiZYkwGwN2IXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmXKjmB5; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f72452a8eso3104997e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757744769; x=1758349569; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m9qLE3qXnOG94GvXjkAQataKE5t2lJhXnQe1G4RxJtU=;
        b=SmXKjmB5RH4dlidD+bccQb1UDAyGP0cy7Eyv1im+74PMlQ1Vt2b/EsDveAuMs8gX5j
         K6dV2ncpaBllqP8DEnf2ddOEeQpf/pQFxjOXhL4H7VJSqnDzBa0YPefMYEiS9PpaaQiO
         lswpkJgYgVQNq6B3eJjb/qTIRItTJomgvppBp3SmZZLK8qpFrSAnHTt/QLYRBsNqdJqC
         CxgpISZJNLQWJhTdcZ28D9T/ii3lvzLR6PPmqlmbu9a7TKCuftVouC4V2qfbkMqODEdW
         6f9c1eehNcQNFjjrM4K/jzqOOvqy05ACXbLWfdCnPmQDKVUCFC+pW4bdsgcvRhoAVEId
         QWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757744769; x=1758349569;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9qLE3qXnOG94GvXjkAQataKE5t2lJhXnQe1G4RxJtU=;
        b=l17QROHgl/vcldnprnWRjlHcEX0dTCGcuybKrAX9Gt1nReY7smh2/QgStltRGTY/JR
         ahyP3jcFIbp+jsXtpQCP34Dq3CiGhaUgmfSQoWnaNjyO0FvXt4mQWG9LQrXol7llXznM
         md3TIyFo7TBjeGqbwdit/ADXbmXoe4pQjldMqk3JLOLa+K3JuYZXoL8GeKH367RlJAwp
         q1h/itCv46jNU9tNEdrEkR1IU3BkA8LBNimHwo7DxMGz2eMQSB2XRJAbksaSw/Gk+QEB
         o+OFIKSuCvxrJIi2A07WTuLeuDPHL3j5V2+itknVI0pirNsI/Y7cvjaQjK6q543VbumU
         gPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3F9UzOa25cd4JcYy9Iuc3O/XFTOzynqzSIc0tNFpM7d2WaN48I+5SC+A4ncQVhjqvuBlgpD8Q08ldkLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZAHSuzERbZE4ARRNdt12iJuEApGIhjE27isxjCXOvam9wNN/
	pkbaD7A0U2OQBfB0Jc6EaXQfqeitXjHLRoAYYYNv2gWBfZYeGsd+Xe6XMdXLXVsG
X-Gm-Gg: ASbGncs7I0Nxmis1tN2JQrIs3Z/8zWYPkSG8hfsthJCE3Eai8LRgb9wecW+M/0vkmWB
	vpmt3CsYGZHEXSkDSHL64/2KK5F0xV2m1cPk7KB3N52Hi675smetzPlbYc4FufSONAKRVH7YQD5
	nBxo6TU2vNKQBgC/NX/1tBe9gAXNIzpf9RbrfQngI+u8YhJQ+hIoMHI7jOE+dDNIJGHtEg8RZTN
	FHZBRy9wy3woH5vygnOtbllP4j1IaxWWk7Sb3v54U1JfCRaGDVPflQ7Ltsu4YFRSN94sGrfsBpB
	xZMUxQpoTD9vDDrWQLkcJflU3kN/MAFSgDW8VzxcCwqh25dOoJhHvg2nnQODlMXrE5EeNXKGR4S
	JrJyxyqWF3HyiOAKb1LCENetkPWQXzVj8HHHmjOJAMciPYvd0qiuNOn+7Pg0U4S0FGoBhHcKCLc
	Ft7x+8gjc4BiXB
X-Google-Smtp-Source: AGHT+IGXM12xzNIqaGKxCqfh8qmw0eeDtRkYW2hR/ijX7NGKH1pUtKyn6LBcL/b8EiiJAqLbSVqMAA==
X-Received: by 2002:a05:6512:798:b0:55f:51b3:9410 with SMTP id 2adb3069b0e04-5704f5b1386mr1148904e87.49.1757744768758;
        Fri, 12 Sep 2025 23:26:08 -0700 (PDT)
Received: from [192.168.1.166] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63cd7sm1744097e87.90.2025.09.12.23.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:26:08 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sat, 13 Sep 2025 08:25:59 +0200
Subject: [PATCH] i2c: davinci: use I2C_MAX_STANDARD_MODE_FREQ when no
 clock-frequency is set
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-davinci-i2c-v1-1-d18849aeaaba@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHYOxWgC/x3MQQqAIBBA0avIrBPUqLCrRAuZmWo2FgoSiHdPW
 r7F/xUyJ+EMq6qQuEiWO3bYQQFeIZ6shbrBGTcZb0dNoUhE0eJQEyGGOeCC1kMvnsSHvP9t21v
 7APx/YPhdAAAA
X-Change-ID: 20250913-davinci-i2c-ddcca6ac7c19
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=eSwL1MT+q6WDO2KrNb5iM6MU935ElZHmEA8e3Mn7/nE=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBoxQ55acVadW/3JXh++wdkm/MMo+xEeExE4KLXa
 1ln8cAoNKmJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaMUOeQAKCRCIgE5vWV1S
 Mu3AD/4j6iYh68lIRfTr4SdGIuhIMu4tCtdY/vcHUsBEqxwlDXDPZZ7kZlm3bjzMr8t5rU0viwi
 KAz/5t/s2uCkouGjs8/F6T8OYMi2j3hlNV9PmTny4YimZOeukv6LZk1clR+JKW2/HL51IJ0qpz9
 NOYKFw/np7GMR+sxmPwZb6igEjg9CJujOv3cs9eWuGU0pZswSlQl8FnI8Hhwu2j7U71IVZC2CUp
 kyMBGC+2qTSUhPQuT0JSC3edAzwipCHfyPWslq1rNdQhEhphqhZRzvw9ASFjuVpVW6dJDpoI7zM
 3AKasQBnhKrhoIXrbf9OIb86jJe+HPPCyNhpQgnIFQ7VTSHM0wlTH3n86jYlQr43tGD0YLq4hgd
 kTIWbCzUx+QFgvWHqoSKOSUR37j5pEcMRv8Iux/nqdLGebE2j55OLhQ6ZlKAEb4YYf1FbJ/vPbQ
 9HGj18sf44harGe7U24Y3hNsR4ADy0MQJ5dBJ1O75eAukxRcukdGRfRe+alYl9/O28YSVReDctN
 +UMbx7ZXMT327WBmbctcKVjHY3WRrsprGViTGC03nPB0L1SvhAEnibz7E3S7F4c4oOmttUCKcY7
 /zR11Eq5Gov2VX01GeBD8BcFPSx7Cqh3bDV0zo2bFMpALCwjtJ2Anu30SA8UB9isIRxSHovG7v+
 Z6m6TN4mMddXhlA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Go for I2C_MAX_STANDARD_MODE_FREQ instead of a custom variant if no
clock-frequency property is set.

Besides, the calculation to kHz does not work for
DAVINCI_I2C_DEFAULT_BUS_FREQ as it is already specified in kHz.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/i2c/busses/i2c-davinci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 6a3d4e9e07f45ecc228943e877cde1fd9d72e8cb..c6d81efdb9e4dabeb5ac40e9fd9f1a2189619e71 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -117,8 +117,6 @@
 /* timeout for pm runtime autosuspend */
 #define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
 
-#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100
-
 struct davinci_i2c_dev {
 	struct device           *dev;
 	void __iomem		*base;
@@ -761,7 +759,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 
 	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
 	if (r)
-		prop = DAVINCI_I2C_DEFAULT_BUS_FREQ;
+		prop = I2C_MAX_STANDARD_MODE_FREQ;
 
 	dev->bus_freq = prop / 1000;
 

---
base-commit: 22f20375f5b71f30c0d6896583b93b6e4bba7279
change-id: 20250913-davinci-i2c-ddcca6ac7c19

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


