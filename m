Return-Path: <linux-kernel+bounces-876024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F410C1A768
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52206188E4D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D07935580B;
	Wed, 29 Oct 2025 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iLMFvC+e"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE6735502B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740944; cv=none; b=BNTNIs3tmipmze2273XLeyVBtCdf+iD1iYAzWfnUAOkEkl0ObyXHqwp3mS31Fx+J7ii93NIQbtEMqshBNzKGSTI/cKOezqM0i0Kpd2TKJht3xvR+Y05aURxmameg5OeYfYjtpuU8JSYPBb6Q6oVm6zHw9n71EjCGWlIWIvZGXZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740944; c=relaxed/simple;
	bh=X6AXe1jSRBq4KEJrHmdBq6xZuD9cdi0d/HUSMjgRwhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srH04/pXBOB6Qy8GFX8hD8yHR6YqnXCeoR679VsJrHunfBorN3/etBSadj+XDoSoDLReqzpGz+W/ahXib21LiWALjsNS608AlEoCshiAInHNOKSKTCjW3GuPxbwXblconvok0ESEE/5Os9/Z1n5ZhH/0FTHZBKF0pNJhyEuH2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iLMFvC+e; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso60717935e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740940; x=1762345740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2edun2hn2o8/WMgJNeA0p3kxXswqKrNqwNnjThzAN6Y=;
        b=iLMFvC+elPkSAJK7/CDVNUI9srbHdViP/k/4U2EhPUzPZhgK4N27lnsPl1GR7nZb3W
         s2hK9LewT3Q152667XC9bx6m+6z+mu3PjLz9O67oZr0A7zZWOAMGdopWt80z1flbWvKT
         eegS4S2ll0zRq2qfRsgCny/ZSmgLpG9WMl2f5llPSp2R8H02GPIYR36wunaqVaCBTKjq
         GoSuBlr9Zgtfuuzfx4T0/2zEONW2trPI07bxU/FZZLXesapPzOXsfWjWQ7fV6wuW9BOL
         jzeW0JarxS3glXttu1IvM8ofRC56jED93witvhfp1rUC4e4U4zrexVZuWXULjimar2lH
         SUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740940; x=1762345740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2edun2hn2o8/WMgJNeA0p3kxXswqKrNqwNnjThzAN6Y=;
        b=NCpQArbjm363IER+Ukxjy0CbsOolRNFbOYVXWCERmJ/g4wQ7YgjB+0Hf+LwDK5vAhc
         IG43mb2niCX8frkTAj/8o11CjDWBAvvzJKZ9oBgko1oLcqzQkVOUF4z4jD9p3yfre1TY
         FN4k+840OYcggAtJ2sP5nqcI1AUehSVGYm2jicNYeUNQZuwldz1CWya6JOUm/DomimVl
         JLmvxAjJhiMlavpOjKDAjymKEMN+4wzrmDZMoI76f+q4Gfhd1/L7Ye+e0FCYbPeKXQ/5
         LsWrpRW1qVcPpgD+8MdJwebU53PIDGrrWHxLGU95XcE3Qm63E1rG1aPbCUa/IqwNO6Nl
         icIA==
X-Forwarded-Encrypted: i=1; AJvYcCX2v6tnYwJIqPRNpY7lskfJH7E1fgveG4jBx2IDnblMkhUSl+j8xapZWwGTv1U2fM+z+jdFHtRvSXwNoOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5pdxDIlCapup8Vc9s408isxv1Q4bOiWIqIbgZsAltls0mmyFC
	RMylL2xI33NRZFRbmKAZPcxTBDz77qeYvKavsgUruetuE8LCRcWNkddK2U5BZUoYUcU=
X-Gm-Gg: ASbGncvkSGV2CAGI6se2NLG3yfKK8i2X2hqVRZZimeQBa8NvQd8lCRDDbD6a76cbKLd
	GYQs8cVaFitfwpM+0aIfBmPfF3Ujr5AuNj5yCZ5s34r+nr0a0j+W3CymflKyO2Fx5ngfIJveEuo
	/Odo5c7FutIsM+lqAoyKS0sJ3X+mGdB+lCX+nX9jVpw6Be6OqArhHAaUuIoY9b3TjGdcGLO0cdo
	Avds1TKTqOYPYXJHdCzFQNlBZ5zTww/1JGKrkhYHTGJU7ithv4nkcavb4djYAY0IbJzCAvof7GX
	g7IVe4Hf1/2MFBkvnE4nIsdN0JHw8diUmkARWnfQmGZM6kkVhJ195WFC/c6YY47lh9NantybZ3F
	qqLEdUWv+1nhIhaeM+1ku/zRAvPhATP4hBXQqgjCaQSQlBZ26FP2mf8NdEQm1GtYQHTDALTl+lC
	ZmZO3p
X-Google-Smtp-Source: AGHT+IHS+VsWEygsOc+A8x/7XjIirk6Z2+ec/QSTP9F+rFxuXxZu/OJVHHDmiPLgNVJdADJ0GzGP8w==
X-Received: by 2002:a05:600c:3b25:b0:46e:394b:49b7 with SMTP id 5b1f17b1804b1-4771e206a1cmr25175295e9.37.1761740940574;
        Wed, 29 Oct 2025 05:29:00 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:28:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:28:41 +0100
Subject: [PATCH v3 07/10] reset: order includes alphabetically in
 reset/core.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-reset-gpios-swnodes-v3-7-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
In-Reply-To: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=3ioQwKPzou2lSqn80K030vy/XMiDzWorAZyKbBrMyu8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh+MShEqQi36ZJ7GYHN2epnXfOxGOvyPD1Az
 5/iBt5biO2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIfgAKCRARpy6gFHHX
 cqHuEADhMa/O5AM464uKfoc66jVysImTGSoaQVrgEg9g7bMaCDLylQVbwPvg6yni0h0pv0L1nC8
 6tfSb4WukhgO7unX57B/aDfU6Q5ciGVydTOP0U9mPCF4ZNr980kwoeu/Sobff7HOgO0Tl6SE3yC
 U++TW2n1YcHTfITwhDpFWhAs7d+fLPGV674ppjfhDpPTTdU7iJzpNj/A0Zd0WB2WQmQLVyb4LWm
 XIg4qoDnUpJ7CohXFNUouo7Am4W0PGzOSXn5umca3GryiCfvLC8N4FwhMe/1xyhZgWWAqvTJk5L
 HOqjKOV7mi/QLqYSdcPGCMJe/QKT1/kflUsh9XaNpiQbfEInr29F8r43s/+rcxWYyMNEInjbFjj
 +K/95NOGBvtwDek2aOtPzBJeqpCvywFYrjGXM6eR5902TGgldJE2BI/Kpxkffly6Uv9G2aL7XDH
 i/MTU4p1W+TAFXYYMx8Kmwwz/8gKFVfcH5wq3dkRGDIRuhsn54om1ZAkJRKpVFMlNvaddMSQx6F
 P3xlGOCEMplHH3zF9amoENjn7rchB/OHvAV41oU1iBcNPvgQPae58HchHSsiDSsOpyxKL1C4k4K
 8o+kUGmobz0he/dyHF03N4E4cmejU7quIjfhYqxrvXDBcnTugaYSZR72LgIOw5vvSGxSZIyBO6M
 94NPbHZ/QPPoQDA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability and easier maintenance order the includes
alphabetically.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 22f67fc77ae531c6efba3ce92cc73a2d57397762..5a696e2dbcc224a633e2b321da53b7bc699cb5f3 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -4,19 +4,20 @@
  *
  * Copyright 2013 Philipp Zabel, Pengutronix
  */
+
+#include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/kref.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>

-- 
2.48.1


