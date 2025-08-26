Return-Path: <linux-kernel+bounces-786380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3BAB35914
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324471B643B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2602312808;
	Tue, 26 Aug 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ce1L/w+5"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C08319840
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200919; cv=none; b=Ewa8y8mqmsPKGmzeecxpO2cylDdAxg30LLZJ/5LM95ZivLarFZDi4mWrN3wlaOYWkv9hrtVaqS0ZoilT1YOFTIGZUTA1SaCSZcb75VjJolvQarCLFDHseHUUJQh1u13sEyzY9x3j47sLMKFDUIkRudTtfIvjlThZZ5X3tO7WfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200919; c=relaxed/simple;
	bh=iMU0rNgXbMpWcmAeYjzIqLI52qcL5///qyanpfM4ZAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CokBusmjRq5OYe+Tpw4nZlz3bxjvvUT4u+1qi5A0aq/PfMn2g1uV9xmS068BH0dmA9KBMfh5GIt4Ygb4pgpUtMKwuq4Aqr2okAHBRpgkWTbKf1R4uGo7kqTgDG02y8boNUrNG18e/oLSjCc7dCf6iMlWolaN6RnxQH3u03jWWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ce1L/w+5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b4d892175so26222255e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756200914; x=1756805714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGtfsW0w1WiZlRd5nd/Re/Px8c+YGmOHA/Ir0hFEdro=;
        b=Ce1L/w+57cJ/aTToWGrOZWrtGU0LmVmsFKBuyoW+tdB+yJ2W/7V4qulvstDocWYb+k
         44qRY5W8Dajgv4T7X9G56V8+UVBrM5ZHQMRYFr082aKhW/r/luPKK+W0DRsMdSiJU6ew
         bLUYDqAjs6U1e2EblEe8nBLv298kk/PZnnbLRODzCNW/OGpk2ndM5ozgEd44YIC7on3s
         pEHbDRt5XBK0kTvx3K6b4PajT32IWNg2jvHjrDdNn3ty9afWJ3v7sETln/QJr0GEXxxR
         34OjvlQ7GgMjgI9qDeMTCg96uFg/Os6c8j+gdmBoi52GELdnx2G/rWvR8rO4hrtIoo//
         GUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200914; x=1756805714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGtfsW0w1WiZlRd5nd/Re/Px8c+YGmOHA/Ir0hFEdro=;
        b=gZ5qzqMd9KlcKIUy8jz2B8ZLjvHy3dg73MtD5xTv2U/kcrmJI46zPVd8fm3CCEySNr
         YgiBKQMYYPwv6iPavN8+jk+kcNPAO4sSKDBrA2IeCtm56OEzfqO4SNoZ1QHGrwfom5EW
         /KxdZ0tKfZdL18yZxXGS7qQV6LmNVOCfWmS+3QTm060lPdhm0VCTcvHMAQxQ5VJJ9o3W
         jU9CqbdRngVZwYW+dy7qNLLsURLZAv4o0Yoenx8BWyfNYDorXLjQIoXAnptffVdwnOEJ
         Bv0H0cR4KNtyVPi1oXdBC5lnea4hTOvTguE40MQQ4+zUYuyxwufnMYJa4JtwL1DT+3F4
         RPzg==
X-Forwarded-Encrypted: i=1; AJvYcCXABhZavBus3A3H2273UGyCDc9tJNyeVMvg1X2/4V/0/sM+jSCdnhTtY384bOCYYSkv9XiyLYdOZIFr+js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxatDiPiFaPFBYy0PFiYfxtoZetTfhRHAlW23ZKrfSeQzyyCKOD
	KvhiuBjfyKojLMQLa3aI3dIkLAx6a1WkUeZHjcBU8P0pWXPa32oN1br8GlsDYzCrlKA=
X-Gm-Gg: ASbGncuZaExNEUjlX6/1A4rz8CIXR6fj9hN7221UbzPFGld6y5H8zPO3kPMNMlDfikC
	b5dXRQ2OZZCeSx4Y2sYV4LuyLw1s7z8zrSX30UB9gN8ggegqo41E/IeZl9aWsXn9rRlbziHc2ed
	t9mHfoGiK86rPlfn+4r1lQTc3mAxE2R1xCyjZxr3wZBxEyGrAcesKCyxWOhDB/nW5Y7GyhFV5HA
	kWAOR3QtrgUTP73uBH2mRGcpWvMOi5qNfkn7BXV+7iXwsrls/P1oqHaB4bCBNVT0cjf6Sh3h7AR
	XIweQBY4B6KHQjHvECdNE0wEaSezLsW4Bq0nBQIcwsimosuNcppZ1Hm/UpCveKl7ETx7LQ3ZC/7
	T1Go4xIyWEyHiDUko
X-Google-Smtp-Source: AGHT+IFCT8K43FmYf5m1ztIgvX2Fjw+GEW6Ck53Etdpp26KgnKp00bfzhvxPN07C+xOfaCd/tjuJQA==
X-Received: by 2002:a05:6000:43cc:20b0:3c6:aa87:d959 with SMTP id ffacd0b85a97d-3c6aa87dab1mr8425016f8f.26.1756200913910;
        Tue, 26 Aug 2025 02:35:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm15308255f8f.47.2025.08.26.02.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:35:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:35:03 +0200
Subject: [PATCH 02/12] gpio: mxs: order includes alphabetically
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-mmio-gpio-conv-part2-v1-2-f67603e4b27e@linaro.org>
References: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
In-Reply-To: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Yang Shen <shenyang39@huawei.com>, 
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=/ZPycHZAJYq+cwPqjcUCTodGjlR5/fbPuBgY495SbXQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorX/MPuJ13oy7EJTZgd9B5mOUZ3BPJXtY/Ws7Y
 pBLB3iReFSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK1/zAAKCRARpy6gFHHX
 cn8jEADiVhvactMnyVz0TLK/1lSYmKBQ0xCRvjBYVtCD5N/B1mqD/GKrYpGqbIw3KQrvl3LKs8A
 27a7sIyKR6tBNLoCkoHvIY3HtaZKYOs0wPuc5DMAtpCdJef3YJXOVijtKqzvIFxhcjOutGehOEv
 4hwpFsovmfK8YTOTUCr0blyP7zatckLDZsbIHo7WHlvlzAr1Pt53ZvH8Tq1HgiOmL7gVeJ/5UYN
 0GiilKgYrait3IrZKIRDqSfSpCcTOt7IYT3cEpWeKDVFfAm2pjkSpFa4/56RfzakYQ5uTbKT3xa
 jusqrQnLH5sdbPQ3DfbJizcsiy7j7bfQu+n49ak5dE3t1G4wX+BeUmUnI+d8PPm+YRdbhoXEllx
 BW1WnatXpWTjs9wUZ4ykXy6bPYjq1rXiqkoK2Rt8EEZFWcVO2TWSW7vxX0FNpJqPiLkbPX1ab/B
 dL6SxuxnPr462roWGxmp8yHz2Je8M20fwveLsi4Kth9CYuPQLdm3Wx7DLqlbwabVn4av+xuU+ip
 NPM0fLfjeUB41nXy+JOA+JXeoXkBSoJiourNZKsKLtWjKTKuW2nKHLGfGxnZo8+aqYGDXF3C346
 7yUTWG5BrVSV/lJqO7w0fretAVTMEcSorYpsFpSz2wQlii1NbmTe2MnyUgns+uG7Ja+/9ehF912
 y/G7Vqn+VCST8tA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For easier maintenance: put includes in alphabetical order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mxs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 0ea46f3d04e128bc8e70941e26c618c0378ab9ae..bf0c97f589c96a5dce37dc140babda5998d5e365 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -7,17 +7,17 @@
 // Copyright (C) 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
 
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/gpio/driver.h>
-#include <linux/module.h>
 
 #define MXS_SET		0x4
 #define MXS_CLR		0x8

-- 
2.48.1


