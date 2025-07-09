Return-Path: <linux-kernel+bounces-722888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E22AFE055
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEBE540658
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7726E6E0;
	Wed,  9 Jul 2025 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JfXzU4gZ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEDD27E075
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043357; cv=none; b=ghnYxYA7gHoRnYqkLYK96yWfcZ1UEZ/3X8t6g9mEoqChtk7uGgJwxUpFP0rETFFczG7ByIjTmN45JWd0eSNzmeYk+naQlZ8/Qs4/IlqX09FEwoRHDejfBlhynZfVAkP63YvDqyrH8Kp6F/xMn98OpcPIn4EakXEYVL1jgLtFAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043357; c=relaxed/simple;
	bh=Z16Wh+N5kXxDvBxr6DMHdnb1sWANtx5bvYKa90GtsSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ITWn8nIbwJMpG+gw0rso9j59G92bov0SPCb4/Tc5bDXfMfOjZ37E8BO1RIGycuBvB1ht8dNo1lrgiOcJcG2A+z8hrPVKGFXvl4BStuN6/pRM0R+4umeNu9t2+qI3OZmvX8U8om8UqXRfQjSd68+KNprpBA0OY0QHTo+C++SPwc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JfXzU4gZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso44942545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752043353; x=1752648153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tn5OaSA7pgX+Buq36989f1K2AZy81JVBiD7CPukS9v8=;
        b=JfXzU4gZy4YWkb5W550LefT5evY7AuDMT1QIaONXpv/xO29xXjpQE9lsdWANknVnSk
         I3GMF0uxpDw93jeDFdOflket/4+GSQ7RvHmGvg0Uo7syscSJnHe3PTciKLK6MwM85zP0
         O+8ZB8JBjQ7flGMv3aVk/oYGm6spPO0YfjaoxsFA41Vvpwm9oHatlblbQwufhQ4gkB5G
         D7bUICMe424EJG8BpAPHkpxAg2DQaYFID684wlFKrRjyIYvu+yh8R4GHFPQ3IQUOiHSN
         42Q3CxGkz2l696YZyuSaXB/aoxkA8dZWTEg2s9ZbOppwZuSdRh3A/sZQ/gUDt8tQmjza
         AxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752043353; x=1752648153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tn5OaSA7pgX+Buq36989f1K2AZy81JVBiD7CPukS9v8=;
        b=hRi/13RU/h08OtB598pEyQpGUUA/RXnODS6YwNbiolgqTn9QNrfIivT+xu9dxgn/Cl
         FQdMhLGKTDUWsdOqF4b3mbGBf6renomtfwnvFC/otCIBGHl/oru/psb8KKM5IxHKZ65g
         hc8P+N/svVtSwHzWwK1qV2QnYJZi18chnFPc0S/iWI8kKz86LJ1o8gnUc0e42tjuLaCi
         mxte2Y7dRs49QmOZ89agZKxcw+a/cKd6RGBPvnTWcu0onZDj1un9iyFMHVWUTN4ZGwuj
         NZJWs3slk08bcZefdgnowFcaBJKyWMVhhomY6b90pE41FcfXfFlkyz+OryRkvVC/E9O6
         bHBA==
X-Forwarded-Encrypted: i=1; AJvYcCVNCuYzfHRn/1l2Or3KUo+EBNU9OT/lnuAXon8Zf03qQejm/R1gb/gFOA3Unb8CCqdGJQpwOJm+11iYW+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJlnS6hKbonnA1iP1ZTEFnM7HP9OEeaOcpAb4of+HHuqBBmzb
	m/LxjAlAEravKY3LXjQaoXEj2LVaOZNA7vZ5RcH+LEkXafiy34bVq3Pr1JljIpX4SQSAoKa/+P9
	SYGVAs5I=
X-Gm-Gg: ASbGncsQKZfL/U8kOZKsTCdOBQQtRloDVSY3EDZsWriJeRR+buG/kioVIFnoFrvCcjW
	EHy+GCqXEhYQMYNiaRJJAZNJT4ZzeiYgxJYa720jcBdnT+in2LPGyuaGLfpBl4o04gnwnuYtGuj
	/DD6IkfmBaCKHTvtcBuPbodawHcBuEp3sMMxmHP/W1vnm8a7VxDDDM1/UXPYFOn6bJuQFdj7py9
	08B6EgDFo0CI+U5K2oPzqBU1T/ZeKUXbV494A8heiz0+PZgvtve4wKya2R9cqvCqkDqzQzsPUEw
	hlgsIKgtZQthRLHjG4evFLCfysYj2hiQxW6tXWHi5izbMQhdUCnEwCrW
X-Google-Smtp-Source: AGHT+IHCZJ76BMC5iAZPOvIZO3R/y4bpK26NWs5OpVLQ8HU7QJFCnY014+kXEIs26M8XIAEwlsTESg==
X-Received: by 2002:a05:600c:3f19:b0:454:aac0:ce1a with SMTP id 5b1f17b1804b1-454d5325fb2mr10408415e9.14.1752043353524;
        Tue, 08 Jul 2025 23:42:33 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030c443sm15115341f8f.11.2025.07.08.23.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:42:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Jul 2025 08:41:53 +0200
Subject: [PATCH 16/19] gpio: zevio: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-gpiochip-set-rv-gpio-remaining-v1-16-b8950f69618d@linaro.org>
References: <20250709-gpiochip-set-rv-gpio-remaining-v1-0-b8950f69618d@linaro.org>
In-Reply-To: <20250709-gpiochip-set-rv-gpio-remaining-v1-0-b8950f69618d@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Nandor Han <nandor.han@ge.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=XJxjpVAEddSlG/MvMeh2gzi/IAd557glLV2SQIYcYKo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBobg9EueEJwmHe+XyFmtP4FA9GXo0KRwJswOqDK
 T0DLaUwyQyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaG4PRAAKCRARpy6gFHHX
 cnbJEACEn7ZUF+EQ5MudtA1pSdv/Gh/JFn+mK4bQ0UyUdv6ibTfVuUV8C3mDGMjP+4fPdF379K+
 qujYuRfL5iufetXWOz/Gn+D8NGHNALZ6un1R8i6quoSxM529YWbjg8VFeXQ3TztEt1jwShJgYts
 jdLzbXs373mTlh8Fa6IkwpSrHIf1+2jfkDJ7bqIEMlhU7gK9H70nTKbuXRgjOYH3eJGJaNdsY3a
 IyLoN23OP/nNBLPWMV+voveftWtuCZvdKcTKmAFAFLtl9syPdIQ1G4tSEOEfxCuQtl9joaHMcae
 4ECm2Tp+AnHf/POhDnu0+o7SygFNaUIXATnQ3kUd9rdY9lwQt56OQW/BeQ/p79WuEIGU3x+C5lK
 XpNLhz3b+l8UpCynS9gMOINaJGMocrU5XEt4fL9RN6XwaBSRBffxSbvUUCRadCtrN3IUDi5zebk
 s9nWpMVFna5J+JOEZ/wevv8irNpo6NLQmqblYI0VUThLFoyNmRNlTE6zI6gxOTa1hp6U+FUBJiV
 v78jLvhMeBp9Yyu8L0KCD4rsjm6Emhws8k1+XbPDv6kE+7daKHFT15tET2KDgD1iuCFHvV35KYM
 WHlUNSWhg4scEvhorLRFf6lByc1fdNu+8jm652odomc9yFGx/lqWUwE7dNUgVBWoqaxy/gma1K7
 9UJuiwSPNmIwpQw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-zevio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
index d7230fd83f5d68a9d80352b7a57e12cd21c389ce..0799f79767107d1775b7692e582e9548a6bb38d6 100644
--- a/drivers/gpio/gpio-zevio.c
+++ b/drivers/gpio/gpio-zevio.c
@@ -91,7 +91,7 @@ static int zevio_gpio_get(struct gpio_chip *chip, unsigned pin)
 	return (val >> ZEVIO_GPIO_BIT(pin)) & 0x1;
 }
 
-static void zevio_gpio_set(struct gpio_chip *chip, unsigned pin, int value)
+static int zevio_gpio_set(struct gpio_chip *chip, unsigned int pin, int value)
 {
 	struct zevio_gpio *controller = gpiochip_get_data(chip);
 	u32 val;
@@ -105,6 +105,8 @@ static void zevio_gpio_set(struct gpio_chip *chip, unsigned pin, int value)
 
 	zevio_gpio_port_set(controller, pin, ZEVIO_GPIO_OUTPUT, val);
 	spin_unlock(&controller->lock);
+
+	return 0;
 }
 
 static int zevio_gpio_direction_input(struct gpio_chip *chip, unsigned pin)
@@ -159,7 +161,7 @@ static int zevio_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
 static const struct gpio_chip zevio_gpio_chip = {
 	.direction_input	= zevio_gpio_direction_input,
 	.direction_output	= zevio_gpio_direction_output,
-	.set			= zevio_gpio_set,
+	.set_rv			= zevio_gpio_set,
 	.get			= zevio_gpio_get,
 	.to_irq			= zevio_gpio_to_irq,
 	.base			= 0,

-- 
2.48.1


