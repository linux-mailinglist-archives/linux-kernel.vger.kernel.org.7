Return-Path: <linux-kernel+bounces-840053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F172BB36D1
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB49419C0415
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C825A3002AD;
	Thu,  2 Oct 2025 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id7XSuOy"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D52765E1
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396709; cv=none; b=NcU9IGkIeml6hSbUw2uehYN2JBJWNeCCaK7gGgOKD6F+4vhj5e9narTe3Ob5r36d/yjIMtIH13TrYngvMBr0RhD2SXKopq0B+qjfhFLs/G2uYjPv6f+7xmnuwO62n8HwpdFFjLEkuZ9b+yiJU8JlI4lVJWFQDGn1q0KfAMFw4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396709; c=relaxed/simple;
	bh=9U35PDJp1zrgjJiWpV+8ufBKcQePZ3+RIEP1cmNj3rI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQ7nET8A577W0xMpYRn7/+oX1lb/VLAB16txpqJKiN+QO+uzc3aMETOE9WF+3tZfMHomkVLa4V78VK6FKev4T1fRmeR0l1l51XH7KLF3klci6jzCmjuMGkpGLjvvXuLd7WKXHiWSIss6bgTF3ymnHzigEo6DqoaCiNmDkjU+1oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id7XSuOy; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3635bd94f3eso6783191fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396706; x=1760001506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz5/F4IItgfEhyo+NSCQ6fvJsiViiC5LvbwSU7cY27o=;
        b=Id7XSuOy8YWXOocR/QbgHtgXWUNjS/e6H5j5FQorjG+PxlsnJmHutTSxZ4Qx6t9d38
         yiac5VZgfumY5wckPzl2+MiWKbEG+Cpap/+gAt1GlbmY1wTltBvNgXIPVhe0nXYNnRo+
         GwM0Bak4dEakee/YoPPgGJ6Fd3//lQNwMKfh8zyLE9/7aUQe5vLcX2ZX4fsBvMLgfjxt
         r4uzQgs4WVrAOS9V3Z8w4piACEsSAkdE+iD213tNWyRvvVbLr4/sai2ndMgeQo5BC5RN
         Uql3eujrNNMYdrWlrD9yxMT4dY2X9zCqaEOOcoW6h4mtMiMD+l5Ryj9xPE9SsWxkVSEl
         AIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396706; x=1760001506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xz5/F4IItgfEhyo+NSCQ6fvJsiViiC5LvbwSU7cY27o=;
        b=TGab/GT5VUcc1lWQqNqeNZeRrMoFZb+Qkhh+gj+MaLXUk599AcTQl/Ob5VlPXRn6mz
         QYTJNS45JEos1IYKRtLoagdqZearuwrIl/x0nb1dsxGnFz5/gi4FuY4S2hhEwK7YKz/a
         P10ZAjBtaGA5Ez6xaekbKUBaebo1nAwMaUEHUcsF+bDcTwi7DEh5xqmahmzEqbpsetCh
         XwNkraNRW6s2LcrnOifAlBU0UhUBZgdEEP4bpAxEsnoZaiqOlJ050kNppL+O13Fy0JcJ
         8abnnQXJNQ6YEGv7PHlOvO2Q8Lt1A9CX7gDS8benYYwoVHB1WaAG3R7mjVJRD3HqR/zs
         v6yw==
X-Forwarded-Encrypted: i=1; AJvYcCXQoovuyDCZGQvu3KyazBf/kaXRV0ery/PEQnnJrkBKdlIXj8SHtPye+1FPj6NuviK3XZJpIG7urMS4dSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPzuWSPxFyajaKhhm6rR3adRGrIWG7DhW3UYnJcEoCAwt/mZff
	e3STKrXAeZ4X9uP1ziKVg06WfMPHeXqEyN+NpgcFDC6dTPw04UpUt3sc
X-Gm-Gg: ASbGncux6CmhSc9M8/KvI5TquBA9NdO5kECWH2WNO7JWzE+laVQg8bwoU3FhDkPzZ54
	aC4PUdcXYPSqGgNBvRoadlK/qmR7V+paCMrJKWH6F04VPe9su668sogG5PEPjOoYss5RM3jWiGW
	O6SEX8g0I+F0287+bY/dwLCgzPsqSDIbZAMKRR4Qe1SSlLdH22fp8qjdKKME0fLX/GKhfhHa/MB
	64SaJ48FFgt0XTWdDuaYa4fplyvYtKvXg63n1ETd9SPiuYjoWEo5bAIBHi9m4xRVGH9CB8BW5hA
	7WkKPrkdU7gmeUxuA1u7wdcsG/yTWtkFlb+IjZvq1MjV+4mFspLCiZk2scQ2akq2LhLgMT3IdBh
	Xv8PUP3WCDIu6ImRwawG5wsrvIhDqCjhtxLV61FVqOB7TbAVuom5XkRa2wKqNcDaZNXBFu1dSgz
	96EpNUGqGxZOf36sqKAxqYKL907M7mPkUItPzse//SZ8ncTQDpL8w=
X-Google-Smtp-Source: AGHT+IEsEbkjF26VGfwy0fNXoRs8b/ceDtNpzv9IlF9R1X8BqwQs4C7h5k1eJzdW9Lq74h2nNU6fQg==
X-Received: by 2002:a05:651c:b06:b0:336:718f:75ac with SMTP id 38308e7fff4ca-373a7115d9fmr18501671fa.4.1759396705668;
        Thu, 02 Oct 2025 02:18:25 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba4bbb7csm5255191fa.47.2025.10.02.02.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:18:25 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] rtc: fix error return in pm80x_rtc_read_alarm()
Date: Thu,  2 Oct 2025 12:18:20 +0300
Message-ID: <20251002091822.26-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

The regmap_raw_read() function may return an error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/rtc/rtc-88pm80x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index f40cc06b0979..3651dc8436f0 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -153,7 +153,9 @@ static int pm80x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		(buf[1] << 8) | buf[0];
 	dev_dbg(info->dev, "%x-%x-%x-%x\n", buf[0], buf[1], buf[2], buf[3]);
 
-	regmap_raw_read(info->map, PM800_RTC_EXPIRE1_1, buf, 4);
+	ret = regmap_raw_read(info->map, PM800_RTC_EXPIRE1_1, buf, 4);
+	if (ret)
+		return ret;
 	data = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
 		(buf[1] << 8) | buf[0];
 	ticks = base + data;
-- 
2.43.0


