Return-Path: <linux-kernel+bounces-740131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E5AB0D061
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9386B16CA16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA87E28B406;
	Tue, 22 Jul 2025 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLU6Qq6m"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578222737F0
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155352; cv=none; b=AZREYPgQbjP8zA2PBwrhMEFiHXL9fN7yUcPk/5N6Iq8SgEyjGyHnU4ISd7DYMhYdbXNJcPu5ksBfIHjxugCXVMnWl4hWRKviWksXrfSw3Tn5fdN/TEB2P4xr//DV/Cliy5H7dR99O53e7dzm2DD8of8qhZvvEceYbcTiPrvmJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155352; c=relaxed/simple;
	bh=9XEHvf4vG1D4yyvbE6MLh31skmRGLDLGj0AHdpDV6CQ=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X0H3fwe6Fa9sSLjhY7okzrabac3hMoVjoyWi//viR9UF3Cm7Te21x0Bm8QbYMaoJkN3haUhmScRz2jtwDca69cOGEikLBUqK4tt14Cg591k351lceswXUPCsuFIo1qJEchkxClvnelRHM6oChgdpn2kAcVxsTQP3956CidxvgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLU6Qq6m; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b27c1481bso3127023b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753155349; x=1753760149; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F2LbdLcacR9W8sqqUGkM7qsaJ4maKUnitzkAiJJt3Aw=;
        b=PLU6Qq6mu8WsA4fj6dIpDZvfm7lW2F2THF0wrvG7gC9XgAzKtnuQvcfVu8g25Ijmhc
         dakIbbIILd5J1uccCyTTo9wqsGenyjOYaGrhzjosXNsKMgL4USsBi5EX656HZUtcOqWM
         HeAemmw7SIGQn6rAsuHsPqwp8e0wIWNR/YrDe3vwWFAMxsYvbvBBorsALhpGi99uCKe2
         EVeaxD/h+JOTxmZPY5OLt3Pc+x+3OaEZ3lVB5uFVGBaN5GSTjfQ4Av5IIn+OrgvBx4Jv
         i8Pgv8B0w3J3URqejrhlgC1LPaFofvUtBUEZKha9R7MCUwQ2mBh/+9LdUWCvfrhVYZ6n
         Ljow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753155349; x=1753760149;
        h=content-disposition:mime-version:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2LbdLcacR9W8sqqUGkM7qsaJ4maKUnitzkAiJJt3Aw=;
        b=KnfrF/a0WVqySy4GXMLd9lA0e75RECZfBp625jbxtubLzNyBK5kGB+57K+3Yxs7Tm0
         RKemtJ4HFRWGBvt0xsoLMm5JMS8i5JYinVp9oxxEC7der9DqR/WHvGqakempbrQxvHLc
         JUqPJ5xsBHzss+chbKQF7+BnNVqWVBRjWG6DaSNch476jFtH544j+kZ9I7ENQpZ1ghnW
         LSRAmLPJRMykdkgLVtky90ZoKw2GPYTa/8r0hOdSP5drbQ1HgFyzDAlifxYzypuFXP8F
         AH+7brk+pRSMEex9qoxWTbU2D4EQMSRYIdI4hALKH8CvJEHvgeTUKTwS022h2oRqVRMg
         3vxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCq3cWQm/ir7G/NeS8T8ONxQO1WvaKMHA5t2bFcRMuzJ5kLYOMNcTdQQDR0VJFBmz2pxdauZr8IXSkd38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7FHQFwg1eT+TNOG3tUUh0siDWId6DJWIzQrIngmuoMJmXQJt5
	z/lIXjX9Al8m8fSsfO5+BLEKEYQC9rlN6PbI7xfFqZJWn4m3w+o4tJVECgG81Q==
X-Gm-Gg: ASbGncv3vIDU32awvQo6gESuHWpKLUbdNyMaXawUTr9Y/Q/zvazGkg4I0dYo4HGNaB1
	f8t7hujEN3Th72FUS92YrDzqL0NTxd9DHa7cdgsnlS8O3s8bT99j83Bl3G4OsgMNlfet4dgXn6t
	rA1fYtAOnV0yKNTUm4UgLIOJopXc1J50bypCPDTsuFLIeBZkHAj3EsT2F3/AT8oToQ+RAvAtsyz
	mbahcpLY0jFHYX83vGr38WFevFADfx62f6pinZ9qWFhzzmaaNYBCbT4JTEDuID85hmSYTq9jaUB
	Ke29HWO+TtAiK8gqcqyxOlbc+P0Rfzs1rHOoTBs0v70EFpPWxHMTctzLYdFfAzEX3RzhJ40cHS4
	ycc3AwPLa3ngH5z3u+g97DwPOuuMgE6Y=
X-Google-Smtp-Source: AGHT+IHv2JveUKY4jPAPdg0y0FEpCFWmS72cA64bGwD9nQdsd9BsKzCXCJ4dAYh7/e8A0baYOoHK7A==
X-Received: by 2002:a05:6a21:6da8:b0:239:c7c:8de8 with SMTP id adf61e73a8af0-2390c7cf703mr28643449637.12.1753155349537;
        Mon, 21 Jul 2025 20:35:49 -0700 (PDT)
Received: from brak3rDesk ([115.96.77.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff61ff2sm5028368a12.35.2025.07.21.20.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:35:49 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:05:45 +0530
From: Rujra Bhatt <braker.noob.kernel@gmail.com>
To: geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Message-ID: <aH8HEQoqGhSN9AJ9@brak3rDesk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

linux-kernel-mentees@lists.linux.dev 
Bcc: 
Subject: [PATCH] drivers:zorro:zorro-sysfs.c Replace sprintf() with
 sysfs_emit()
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


