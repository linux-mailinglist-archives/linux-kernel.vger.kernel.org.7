Return-Path: <linux-kernel+bounces-740134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF14B0D066
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259FF3B9266
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F60628A1E6;
	Tue, 22 Jul 2025 03:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpsEuHI3"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DBD28AB02
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155553; cv=none; b=IX7BnhGcgUkn1TdiW6LpkPau0qS2Ann+whdph99w4/g5YadIGraVqSl/jWC8ujPXhvCAYSEmtFhlTdTNXbN/Okn929DypKbpjpddLNrlCS8LyfM92GS+4APe3MdqWFi0yVn4kTwj8gWrcKd3Z9o/A/3FsR1jxKNX9sLIuM6ijKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155553; c=relaxed/simple;
	bh=a8ZDCKvk1z9V4mWSqgga4htHIEnZXgftQcODAhyHbhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S0HDHAhOV/G1J73NrmpWTI75YHkRqLe0NFQJ9YXej6WZloA6FWuBF+jP/j4U9ujwWkz249mD1IjkpI3DTckTjyjCsmFCaExm95yEs/mFpawQSlU70UWKh007S13jsqOjEy6LHqjID8eC3Ci6CLYhiEPsfqZLULwTch9lhyq/KK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpsEuHI3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235f9e87f78so46404935ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753155551; x=1753760351; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HxvgsGdyX3E0xq2IbH1R0rlYmLQG970WtCL2FPZRg4=;
        b=JpsEuHI3dG0IuHQo4F/9I1edc38o2g2UtC2EERcU6k+xJeNnwx0WRyLyMFS1CWw46M
         kyvdNynIfKQwU0BWPqy4aprtC24BbRHCH5IQxWCu300KiefC0vDn60XKGDiwWeCtvb9+
         gD+nzoXckXRK2U97q9e77wuKXbFis4WPDY5TuLQ7aPrvnF+12Sb6lGzvgtdEJTgDa/lO
         7Cap6zFq0GifvF2FUV/tMyFYMQs/jEbSlOcBtHFWaheBbhmUqvXMVhEnfmiovysbEYSU
         cHMMoiq3y7yeq+hrDC7OsB5U5wFVFOGAhddyCOzl38TU9RNfsD7j3iv5A91nGhNwiIc/
         +l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753155551; x=1753760351;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HxvgsGdyX3E0xq2IbH1R0rlYmLQG970WtCL2FPZRg4=;
        b=huuxav4bJuqAL4i/pH6yXXv4wOS/SxBIC3fRZrf1pYo/RkC2USJu1ERdfIy5rTDKMC
         bOsTTup8YjorqmCdS/i7sswC/7dJH0IyTJ83AYexSIIZ11wjhGtSgoMLgyaNm4GyfT0W
         I1bvwmfY/0U6SY9K2asXtw3KEk6m1hgAL3clczIo6jycJJ9DaLcZAyf0DexMOyG3x+FD
         r7mrDrmtSAkBeLGVn8HAVjLdeHIjCesRMx7o6MmM3XufYFLw+qTy0+1TaRKDdyjaqzaQ
         Ijg1p533FY2wYbt6UDhwdE5lwOzKmac+fAk5wGnb+N711jsoV6Asee7PQyuMlj2nML6j
         Yyug==
X-Forwarded-Encrypted: i=1; AJvYcCWEJ0i/9mAiGer1V2m43NC5+XeD2EXVPZM5/J5+3ywyi/s3A/4JaXGvr1ZH0MJepiRVsVQQTcU2ROLxXhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX8NO1RWEgX8ght7/dXnH7zZ06kUhD8BfPW8TCf3642CZz9PE3
	Vk+jPuT24dJA6SPf49a8nj58/D9qrTVdN9IT70QBtEWyLZz4zLBTUwXXnWU4/w==
X-Gm-Gg: ASbGncsuBc5PpRv/e6rfUZgEqkTmdqDCZfD+RqGL7dKOUxVXbSSPDiUhFghwIFzjA5z
	vBtGc/n824+tAObMD3eWuOo+1qtGzpdqq1nAy1NY2VXoLdjjlNnh05HE+rA3MZ6T3IMMNbzQ7cf
	AjkZDgv5aOd4TZseiCKYejNt3ya1Np2/QYfLQHpdlneYKX/JRY6xZEZuvdHzguJ2zzsxM+CBKrk
	t1hFCl1dMJEjBWt0Cj4G+4lnnKdyiMfArPP4sblFYTok7MBogk7eQbZFUs+pXoONQuiUAdst0EH
	Gc5/3STVPJApkX/eiDIM7U90OEPoqXaSvXujt+ODalKRJCG1JO62loBWPPa9Imp0Q3nPwiWpcf4
	d/58XvjKp2CmfymxSRagCuG0EGkMpNSw=
X-Google-Smtp-Source: AGHT+IELXenhGbrXs3GHqpCXNMZRZtfRAufEp0joWU/yATfc1Fkd0qA6Op2/PITBrKGg0UU01VXk1w==
X-Received: by 2002:a17:903:faf:b0:235:799:eca5 with SMTP id d9443c01a7336-23e2576e67cmr337988305ad.44.1753155551546;
        Mon, 21 Jul 2025 20:39:11 -0700 (PDT)
Received: from brak3rDesk ([115.96.77.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6f309fsm65886665ad.223.2025.07.21.20.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:39:11 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:09:08 +0530
From: Rujra Bhatt <braker.noob.kernel@gmail.com>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drivers:zorro:zorro-sysfs.c Replace sprintf() with
 sysfs_emit()
Message-ID: <aH8H3D0WRrqqZYc4@brak3rDesk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reply-To: 

replace sprintf() with sysfs_emit() in sysfs
*_show() functions in zorro-sysfs.c to follow the kernel's guidelines
from Documentation/filesystems/sysfs.rst.

This improves consistency, safety, and makes the code easier to
maintain and update in the future.

Signed-off-by: Rujra Bhatt <braker.noob.kernel@gmail.com>
---
 drivers/zorro/zorro-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/zorro/zorro-sysfs.c b/drivers/zorro/zorro-sysfs.c
index 10aedcd21363..a552724b7fc7 100644
--- a/drivers/zorro/zorro-sysfs.c
+++ b/drivers/zorro/zorro-sysfs.c
@@ -29,7 +29,7 @@ static ssize_t name##_show(struct device *dev,				\
 	struct zorro_dev *z;						\
 									\
 	z = to_zorro_dev(dev);						\
-	return sprintf(buf, format_string, z->field);			\
+	return sysfs_emit(buf, format_string, z->field);			\
 }									\
 static DEVICE_ATTR_RO(name);
 
@@ -44,7 +44,7 @@ static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 	struct zorro_dev *z;
 
 	z = to_zorro_dev(dev);
-	return sprintf(buf, "0x%08x\n", be32_to_cpu(z->rom.er_SerialNumber));
+	return sysfs_emit(buf, "0x%08x\n", be32_to_cpu(z->rom.er_SerialNumber));
 }
 static DEVICE_ATTR_RO(serial);
 
@@ -53,7 +53,7 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 {
 	struct zorro_dev *z = to_zorro_dev(dev);
 
-	return sprintf(buf, "0x%08lx 0x%08lx 0x%08lx\n",
+	return sysfs_emit(buf, "0x%08lx 0x%08lx 0x%08lx\n",
 		       (unsigned long)zorro_resource_start(z),
 		       (unsigned long)zorro_resource_end(z),
 		       zorro_resource_flags(z));
@@ -65,7 +65,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct zorro_dev *z = to_zorro_dev(dev);
 
-	return sprintf(buf, ZORRO_DEVICE_MODALIAS_FMT "\n", z->id);
+	return sysfs_emit(buf, ZORRO_DEVICE_MODALIAS_FMT "\n", z->id);
 }
 static DEVICE_ATTR_RO(modalias);
 
-- 
2.43.0


