Return-Path: <linux-kernel+bounces-842979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFCDBBE1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAE8188BB9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0AF285061;
	Mon,  6 Oct 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2csNWe1R"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8B2848A6
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755646; cv=none; b=Ph71t8KBYvskUIVCKMrQ8CY6UDu1JdQ4rQFasgmQ4ness0npoRcBYAekegSOiycNQgbX6/YFl95ZGXXyANq1PnFY272wGWnpjFyHzQhea6H5bZ3gOHbzDxQ7kvaxOdpgm388Md8+6H4NycazuActhsUu+RdHZgMj/AJUmvNPdZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755646; c=relaxed/simple;
	bh=LiKNRN4b6Rog3bOF2ZYrAAug90U1uNL0NBVGRtkRLdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fc9BYTVwxnkxisdFjd84Yq9Ig65l9YDNbedrQaO/SWKS/Kstgf7V6YObhAyV6MtHrpU+z8bDjI/cBJ4a0lXfemSvajw4EuM+wdUkZeYzjBkOCbDH2oQCIHdPbP4hx8g1dym3waqWBwOQ4u67X3+reVqsGAqzFF6b3bE/rCdhsbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2csNWe1R; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so25510915e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759755643; x=1760360443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UJiGuxpdr2uQskb5nJaM3QuQzryJ9Mudo5s0IYG1NI=;
        b=2csNWe1Rnifm/BdzFd/ythjoyDcwZct58eGHKoWAKdFkR8MGHyjUqwgFO2GDMZt5p/
         0Y3MUFVMMc1lNLB37Z0oPpeAc3fLSmGf0WRYoajW25OJk4+xIOTwbVN9MLzWzIvHta7y
         qa2S+Sftjnmu7T4jx4ndvH5mnXwNo//aCDxx4RZIh76hyv8b/plU8o7wl+rCQd4mj+kH
         6npu2tK5FxhUA7re605Zdsl5VMsku3UHlgsiNm++NdJyVpqQ6U4aNPrijmmXd14ZNy+w
         q3ICcpgbKN7NEByv7207fDURanBZSxjnm2M3eCbf5XE/BcEWLzFJimL7CvRI/VzC44Gl
         ddiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759755643; x=1760360443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UJiGuxpdr2uQskb5nJaM3QuQzryJ9Mudo5s0IYG1NI=;
        b=T9PirV+5SRAiP6p136+H82l/N0HazfLqtsRb21lQhjbXYjTHQFA3aLNuX9wxDKY4yn
         zN0oZKRbY9Jha1fkBWEqzTtpksLscW/8jUN5yI/ZuoAn9xjh7GQyRmpLfVV+eNLfgaJB
         bTqiv4q3W6IzsXBjS7bnmpZ2tnQGr5PQwSGl5m61iGONdTmYVNBGVquPbRERdjOp0jfT
         KuCm9CnO4Hs5LkjPz8Odyq3YCrA3iMNulSrCZ/1esMaTu/GDkLIWdqKjKJApqh/SsW3T
         wSmNSIJzALQWwCLM1feQEKmk+YtV0ZKL7KkGFpI1UaUXi/XFAQkNU84hpgAabiBSDiok
         Qtcw==
X-Forwarded-Encrypted: i=1; AJvYcCVpLkWYmkdUtbiq04yx8ZpGQCf60N7dL2OQzGRhG4YEZLZm7PU9XfLEUk5AefijMnrb9YEJKQeoMjOrT6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhe14vFVdZ3Inb2QIFMjleLjyVeqkEskIjf6EN6286nGEreASt
	qMqrZwZG+l4WrTlz8jLM0ohLXuJLGTtFzKoyg8FFfnIfpz+zBS5gRQRNWSwinywQSjtMPZw9X56
	YQQteTks=
X-Gm-Gg: ASbGncu28Kdj8zaF1ITaJ8v6m7PnSdAQS7x5r5mjxfOHI92Ig55+aaYt8D1ixDNYSG6
	iEfPrhHbhJ+OIxi9taIuvTVm9Of2YQoCDFjkZbioKofCda/PY6qp8R4p/QsYBwUCWA6M4RybdoK
	OyGG5GxehvIhcPxvTQLJAdVwdBq2BiH5mnCI/TtAs4Dlmej+D1OYsE7p03zi9HXIrjiEXtRbSHF
	OKOQ4vl/EB83XmrvNSYRF4txhzYb3El0gYLzJFQm8YBQIitZm8tTuXa6M72/0l0t4Ye5wRCOL7r
	MrTJx3zN/YedYNnBTaJQ6NrdWuXLgl2AbCI0xu12nVWPfYjWcxyVbAnfSWtJqmCXp1VSVS0RJvM
	JVZoeBRZQYcaDTvDbzneF6pWTdRT5Jnyj2Tlz27AOa4cq8dstcNVDwwkq/ryeBwQ=
X-Google-Smtp-Source: AGHT+IHReGjRTXAEj4+vwvO9u/f9ZuRyHo0s8k66WpB93PuyVoJgCciFXUHJKSLOxZzbTKByXL45NQ==
X-Received: by 2002:a05:600c:840f:b0:46e:1b9d:ac6c with SMTP id 5b1f17b1804b1-46e68c0c4d4mr116982805e9.17.1759755642862;
        Mon, 06 Oct 2025 06:00:42 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ed2b:276f:1a72:aac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm249725965e9.5.2025.10.06.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:00:41 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 06 Oct 2025 15:00:20 +0200
Subject: [PATCH 5/9] gpio: swnode: update the property definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-reset-gpios-swnodes-v1-5-6d3325b9af42@linaro.org>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
In-Reply-To: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=992;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=2oDrBv8aDfvA250bRkDwWtWP1E31zoeQQskPCFFlV80=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo471wajgCtsvE2edixdkcm6VSrxIu2UJSr9RZR
 87oR5sRtUCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOO9cAAKCRARpy6gFHHX
 cjUDD/9UUxRlTRmA4VRrdVGqze7ySIptImxOeDvxSSi7iXxcS1qPwPovr0yMvpffdzTixfidORd
 CHFvrjrqbkQ2pP1KLhi/VfiCShRZD+/4Pah1MKOn8QyJcLcrI6aomkGiFxrlOScvu/SilzSq7PD
 qER5pmNjPVyV7RPgARi/z/opwBjWgsDzegtopitqXclrDeFqZSt/jL6Xej92aD38lUUlZ2dPzAy
 e/a8Q3tzQbxbhhDGKtx7U52ezFnC+Tw/BtBFfsQ+7XmCRUXjq99Fs387BJgK2HDqoituNC9H8ch
 olMVj/jRjD4Px3MX3+2TRcMgZIEJEMIosocfiFKIXwazf+EYRD8kIe6aAfYXuJetAuwt0ScA1Hf
 LcITQTIUydkscoQSWvz6gswBp1oHood9jUtkIXAzeyHy3/AQotdJYGBOGfANip4vp/Dt3wn4u4T
 hyEw1R8Pdf/aSJY54bnPpR0GlnZPA+V6M2uBFxXfoNAydgrhfUFpDR8So6p7eL14OoNzhemC4rC
 9fma6eGsvy8ZgWqoyy+pyyHop/X8OvbWggvl6ygoptnO9pQQXnv2yMGNv/Bh1rsrsfUWkTBjtHr
 i9HLOsbaWyC/WQIe0UIzSHtN7sOb+jBIJlf5nak5otrr/26t2othcxilq6I4HiTA64GubEXLUSH
 1A+cPZ6OZtzNfaA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the recommended macros for creating references to software and
firmware nodes attached to GPIO providers.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/property.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/gpio/property.h b/include/linux/gpio/property.h
index 0d220930800276a21b5ba96a68371ce66fc4ae3e..6b1c2ed9c57594bf3ead5edc82439f9fb7f514fd 100644
--- a/include/linux/gpio/property.h
+++ b/include/linux/gpio/property.h
@@ -7,7 +7,10 @@
 struct software_node;
 
 #define PROPERTY_ENTRY_GPIO(_name_, _chip_node_, _idx_, _flags_) \
-	PROPERTY_ENTRY_REF(_name_, _chip_node_, _idx_, _flags_)
+	PROPERTY_ENTRY_REF_SWNODE(_name_, _chip_node_, _idx_, _flags_)
+
+#define PROPERTY_ENTRY_GPIO_FWNODE(_name_, _chip_node_, _idx_, _flags_) \
+	PROPERTY_ENTRY_REF_FWNODE(_name_, _chip_node_, _idx_, _flags_)
 
 extern const struct software_node swnode_gpio_undefined;
 

-- 
2.48.1


