Return-Path: <linux-kernel+bounces-771212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD526B28432
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAA0621D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134A3291C0E;
	Fri, 15 Aug 2025 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uxKNhrSx"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA430E0EC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276267; cv=none; b=hRsVRWTDy+hH60dXLbb4onJ/Hn92dYgBHh0/sgINe6iFWDmtZSvyhsqHbIGLrr66Iiaso/OyKdc7g+FZj4pr90ysyTkJU5fwiCWmdrwKF/kFaEiG7PUN8MFDfE/eASZgekwmZavgGpVSr/hlaapkRndBnvhOzRRKJgdsc5GRqcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276267; c=relaxed/simple;
	bh=C6Sbq/OY4SHcE/xtSRHV50ylmu+czCYaMl135JwPHbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFph5hWoALOu7VhHgu5ZYob581A6xt+h12gUGNl7w9drXKdTyKBf+MG+VzGXAy6/DyzYvSHoDGheKy8WEDlSuSa91diUWi92XrJPoLptvWxLyhLJJYzFaLN/SPmx4gVRNorFANONsxTuLMlkqwfZeHNcdQ38xH892IyRdNMbdNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uxKNhrSx; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-743749537caso2854317a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755276264; x=1755881064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9v5Q7YvIr6z7FxxndA8ulIPadDXolz0J5rCqGDBtwQ=;
        b=uxKNhrSxZYStuB1NqwfbzFE8OYKNOaGLX63U+9lsA/1xE2M6O7Z0gLxDoG+kRnlkX0
         M0FVH7SQIF5wt0oD/mphZ7hIUjnhJy4va0di8vTkmnlii/lq2M6zDMzQYL0eQHulU0RQ
         0BtkNHp4i7Rd9oEwSoVBsB3MlNawxBDCScRo9knOo8+83GztmyhN9FdpGTDV4pgK0Vji
         wqyPZgd32soePId6+2FFlhnk8KwDUGosmC7rSHBtnUV+GeGFEpob1Rhoi/FzC7T63NaU
         izrgwmkbq72CosMoSGvqeBObpIiILODyRvG4eXZ8SVcTj9yplcOsYzDA15yhoH5bISDH
         hyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755276264; x=1755881064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9v5Q7YvIr6z7FxxndA8ulIPadDXolz0J5rCqGDBtwQ=;
        b=mmZqEv9qWWQ2oM3yUT0CVzmZmswt0LWw1NURuJHGtps5RcnrGjuRA2vAge4VJFbCR+
         N3soH50I+NX7l5VrZlEXeXDCubvBj5FrI6kGLlFoa1dPFV0Q/qldyzNbbjfPJuqbwKqL
         JceX/xH7oFu1DTrdkKQIHreBcTDaj40YmQlNdTQ7ViitnEyF+o4hSJs4xjtkxkKztgQ2
         LfTPXgTG1VtnCrP+Xrd3p8G+i8j4VNl8WJSvdKdCsHqXh1voJeU6w4WnYDTSLylSQqa4
         ue8Px6a9580mz9AS7qbbi9vmKRr0C4dzGexOK037Ncj2GCafK4PQMOM0TXr0YH76FMZq
         jUuQ==
X-Gm-Message-State: AOJu0Ywg4thihkUOGNQgrnSa3iUUuBO5p/F1OXDxtWLiwLDvzFaITege
	jbLmpubG7pBHAjtSPxCym3FpVjVEhCGBeUnS1QI9S9fa/b+gp7TyQZ/0bhwTA6O/ETecCXLZoq8
	SvzR7
X-Gm-Gg: ASbGncv+pSghIF7O/keIZ4HpU8Zpng4kMeK7462LM+++LmCg8S05BCxYc4sr+FaweWg
	SxIotTCspKu36HGgLEBRob36aVaaqLry4pPKJsRM5c3kta4Y9lSi+Xoh7mecsTCVIUPU0zM5Z1B
	9CvGa8f+3Lc7RWqkM6eLeqFQrReZjU/S+MWHdOzu1+zbVXhc83EwzlW+lxjTVYY1ft5HXwaxfXj
	h/i5A2O5zWrfdh5y7kASmEn3GFxU672o2nETCeXMwXJwmjJD8MBVJEyM4dJ3kWEDevfBsNVsAHP
	9i12AWG7vnDaMDmC9RxyxJ5fXexgKOaFIgzFgN3uT0Bitlf+e6VtHjfSs6nGWw8+zaqd63eymRB
	HHY/7P52DnjYV3n3tEeQhLtJ5VkI=
X-Google-Smtp-Source: AGHT+IE89r9aei242UabfYdm3XkYBPY9iDF+aY8iCNu/xvh5Kq2pKHmQMS2d47zetchl62kPMT5vxg==
X-Received: by 2002:a05:6808:190d:b0:434:3f2:4ced with SMTP id 5614622812f47-435e067da34mr4483989b6e.4.1755276264378;
        Fri, 15 Aug 2025 09:44:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed1b186bsm305263b6e.21.2025.08.15.09.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:44:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Aug 2025 11:44:01 -0500
Subject: [PATCH 2/2] spi: offload trigger: adi-util-sigma-delta: clean up
 imports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-spi-offload-trigger-followup-v1-2-8ec5413a8383@baylibre.com>
References: <20250815-spi-offload-trigger-followup-v1-0-8ec5413a8383@baylibre.com>
In-Reply-To: <20250815-spi-offload-trigger-followup-v1-0-8ec5413a8383@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=C6Sbq/OY4SHcE/xtSRHV50ylmu+czCYaMl135JwPHbk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBon2PfvvVd1yFqg6leU7v8wYnKY/5GZDsaVXoU0
 mYUFPFjKJeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaJ9j3wAKCRDCzCAB/wGP
 wPBIB/9NrmkmsU0qBKZoyUr6/EtKwy0QruhG2maoZ8JkoiNtuEYjUBJLz8RDw5/brbXmobDz03f
 8oxfXulhvyaMv7OUvSCUjg0spsRcLNk416e1MxxN6f3Ufa9JyUfYJQk94cIwMbhimVEbdcvlfaV
 FCjZJ17FZYPVGoAU5boL6MD8V2oLUzoEV4QanlW6xwTzGIxbbdwLwYYDq46CVmIK29LT+7puIAe
 aiQRTOVl1PHZH/1nrgI5Jz9elCOZooPNGDEepHxSB5EWRYZDQwX/KkJLX6JBwDEoncDirpcaZUf
 HayE21an++0s72qhedqj8nAexaUmDKumzJzwjIJwNYO5ejB2
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Clean up imports using include-what-you-use principles.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c b/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c
index 035d088d4d33d6d32146a340381bb167f080e085..8468c773713a3d203b2e668f340ee3f477b8fb6c 100644
--- a/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c
+++ b/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c
@@ -5,12 +5,15 @@
  */
 
 #include <linux/clk.h>
-#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/spi/offload/provider.h>
+#include <linux/spi/offload/types.h>
+#include <linux/types.h>
 
 static bool adi_util_sigma_delta_match(struct spi_offload_trigger *trigger,
 				       enum spi_offload_trigger_type type,

-- 
2.43.0


