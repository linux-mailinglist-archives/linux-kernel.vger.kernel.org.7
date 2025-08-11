Return-Path: <linux-kernel+bounces-762555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E08B20868
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B6F3B1661
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122062D3A68;
	Mon, 11 Aug 2025 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4XVeF6B"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B4822B8A9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914163; cv=none; b=XP4b8o7JEWG+36Jp2F5F3WrY+dAoA0AwGdX8+wGeiew5GnBdPzeLnF1n596+GHpWQhEpWtkOPcJ5zRMWNkv6oHvRaA0sBqgFVrICgcK4e3YENN0nB9NiyDS7GQ1nqdVu893etvaY9lbA5/m/42eVoOUjtyzzlxjg11lPzoxto6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914163; c=relaxed/simple;
	bh=J97EISt+feR5gjDpkDK+gHUF8opqRwDUlNJ64CUaNgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=inNtZBh7iPO/1O4RbDhbJEaGsle4iGHPPCiSGgqkXSTqWPGBvO1UP+G3HIePn2Nse9lIqMefoWKdlYtRDPLVJ5DMibCms9xNqZFQwk6Nrkt1G6JyzJj9yVcQtBWcofguVHWUG16bSO3MF1oajlt39UyT+I0ZmSJ1RubSeCWIGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4XVeF6B; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4594440145cso6171995e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754914160; x=1755518960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGWojVuAahncp2PL7F7k52hXQw6pomfkevqP1zuZMgU=;
        b=T4XVeF6B8BdS0Ft3HUVu0aiCM/L5t0mCWYta0n7jR8tHUvAmXRgMjQwKzsKzmO7cKH
         0TSkP4ECC6CKThxq1MVYhBEk5btffbga/yA/hJ4BjGAWaobBEfjoAA7gErnneQalIOei
         P3ofBTSlwIt5269sz696niaFoXKAsVX5X393s9kxC7WsIO3OMeoW1p7KfHrhv9nsEJVH
         yYno2z2/6Vktxqjf6R4E8CPOdPh8P70i1UCexi37SPbZZra6+C+upYbBpdiqSrYMxmas
         iUcNN9B8z5FnwGxp36tsJu4AgBPgjNrQglLuuK8z/sSOf2g42+Ej740WMFVkvrsT9wWV
         MA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754914160; x=1755518960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGWojVuAahncp2PL7F7k52hXQw6pomfkevqP1zuZMgU=;
        b=NoyGx1WnaqSP/lb76SlWpO23yPqaQGJjRaI4arCpV1RJe3NaOkW68otWrZh91bdpRS
         qLG9XXHuUPPtnleKyT1mxoBV7FqS5PlGzIVelsHJiUkfGmRRVGgNXLHpj8NRArszPx2T
         bbF3a+E6zgtH/tZe16gAUIvQKedhGh6iPgUSVl/PB1R+5BJFzGrBttEuPlImAVLOtgH7
         VOcvt0LXJMO/HHYHCoyB16uqrC5AQCXhMbtq5q+jutoVVOV0y6u9nNnmecIaROG9lUiu
         GgNltK3q8xn/bDEEpuKNo9oxBBcHEIT9lchE4d39Wiqgdi5cHeXs4064onz140vlHn7k
         63FA==
X-Forwarded-Encrypted: i=1; AJvYcCUkZ9zv7WANnsHEdROzeFZXUOxuubEwJfhDppVt1oqdFFC3Aakv2E3X/CBlFu/YIkrCE0DLcdm0hnj4Pu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFPIwjPYgorRmaPZF5N28XSgrOZ4qmp8OsmqpZo2vOO3+NX+hM
	J0cccSj6jbx0d5jFaQ7h/jxKykPfKz6V8RUV2uQJUS+KVa/hHJw7s4uC
X-Gm-Gg: ASbGncuaTUG6B/+5iK4NGLj7EKNqL+MtGmvb5XjNPGqAAqNUP5on3T7J0wwflDPrXN/
	WxZ9ojJEmsOg/KQEa73QHah0+InHr943gCDTL6LCqkkimJWzM01v5Ui2pIO6usknwdsFdortr+B
	exwRhDGzAMDTKo2x+8FJ1SnefkImZCp02l1wGNT5h/iDT1kGeKDDRfDgm3ctusCf1Xs7sKkB94r
	OsEM+THxIjNK53VZMJIyBIOG+eNUvqgfUDxi0F1ygskAp58SnXKiW/OG7de/t8x+20BK2O+ixFd
	vuQmrNW1D8ny1Y0MgseAt7Nwph9HydU5jIXLzBmqVHANSGE3/7nKnwKQGFPZ67ifOK3IBd9zdHB
	hlbY+n7txW/irQ/mXAFuxq5VfTczvHIC8yCwRv4+goJFbx37ab/LF/rAcx0MqtrLUVcgzcMnCMI
	OVhXHC30I2
X-Google-Smtp-Source: AGHT+IFUSi10Oj0WFDCpb1FhBCdi2Dpon9R34C/nfzX3ReyO2Evkf4zyiSkjs/FeVpPcgdd/AiqGKA==
X-Received: by 2002:a05:6000:4382:b0:3b7:8890:8e71 with SMTP id ffacd0b85a97d-3b906883a54mr2524334f8f.11.1754914159866;
        Mon, 11 Aug 2025 05:09:19 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458f713eb44sm376739085e9.14.2025.08.11.05.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:09:19 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: richard@nod.at,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com
Cc: chengzhihao1@huawei.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH] mtd: ubi: replace strcpy with strscpy in mtd parameter parser
Date: Mon, 11 Aug 2025 14:09:12 +0200
Message-Id: <20250811120912.144720-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the strcpy() calls used to copy the 'mtd=' parameter into local
buffers with strscpy() to avoid potential overflow and guarantee NUL
termination. Destinations are fixed-size arrays (buf and p->name), so
use sizeof().

While this code is currently safe due to prior length checks
(strnlen(val, MTD_PARAM_LEN_MAX) and early return on overflow),
replacing strcpy() with strscpy() follows current kernel best practices
and makes the code more robust to future changes. The sizeof() calls
correctly compute the buffer sizes, matching MTD_PARAM_LEN_MAX.

Tested in QEMU (initramfs + built-ins):
 - mtdram.total_size=16384 mtdram.erasesize=256 ubi.mtd=0
 - ubi.mtd="mtdram test device"
 - overly long name -> proper "parameter ... is too long" handling

No functional change intended.

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 drivers/mtd/ubi/build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index ef6a22f372f9..0d9f31522356 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1497,7 +1497,7 @@ static int ubi_mtd_param_parse(const char *val, const struct kernel_param *kp)
 		return 0;
 	}
 
-	strcpy(buf, val);
+	strscpy(buf, val, sizeof(buf));
 
 	/* Get rid of the final newline */
 	if (buf[len - 1] == '\n')
@@ -1512,7 +1512,7 @@ static int ubi_mtd_param_parse(const char *val, const struct kernel_param *kp)
 	}
 
 	p = &mtd_dev_param[mtd_devs];
-	strcpy(&p->name[0], tokens[0]);
+	strscpy(&p->name[0], tokens[0], sizeof(p->name));
 
 	token = tokens[1];
 	if (token) {
-- 
2.34.1


