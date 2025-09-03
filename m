Return-Path: <linux-kernel+bounces-797951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD0CB41798
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28444838E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F6B2EAB9D;
	Wed,  3 Sep 2025 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sUTFkEE0"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013EC2E9755
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886430; cv=none; b=fBfPTxrND/W5vQZHJYneuW1DxVFZb1jybK4wBeRAAssexdTw1pYvKlOoG/pOfDKB4VDDzUVZVwS0AKhaOHeX2kYZ2lVW1raOfahJuCfc/v5u5NtQF5gAdXEgodnt+AAcXrqyAwJYdL4/D+pd3vhwv0C0gdvj+DmfSBUr5JsZ+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886430; c=relaxed/simple;
	bh=7YQruYTKMSzeRLMD776kbtwhLsZf6wQSro2METsYqRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3Eh23mCX056yFDuPGZ5bqrPT8GXUcEDuhcV1y/yk8qAU6gyZT8GFdbcuYCOMj0fZg0fmbu+YJvABxsnZ+l2T2UYbIiX5I20+toyrDmxFAS5YRfRJ5ntIlksaDLQ0Wx0vNbu35x+wyBR2TR8ZjG/RVlyc+6xpvdBsxRQqLiU3UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sUTFkEE0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b7d485173so38448595e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756886427; x=1757491227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTuRpSb/cqzor7io9mL/6axrUs4fHV3EPX6PfmfRG/o=;
        b=sUTFkEE0t7+jfrhvTNx7kKrjGCfNrlQu2Sm8rGl656liiGAc8khUK9RisQQo8aTrrB
         RqljN03Bq90y6IuRlHcI42/DNvi/Xsm5Z0Ke0MFOxlNR7CdSVF/sMu0GHNbvR+nHFQMv
         hiSOyY7qz8iVyp4lzta/1ab1JblgWjnfJPjt1lijN+w12dNVgP65s2ysaw3NCEByIpPJ
         vlt6BJQxnFC2LTcrbMsUC3XbMrY7qOTAb76m4NchqQR+eCwsX+5Ym7rqD2bGiCTL5rpM
         vu1NqBVJTSGr7KdTw9JjQeEQI1dhcCcIrj9RGlipuRzrp52+rHrh8xMv7Q95vsYHoaWP
         0dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886427; x=1757491227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTuRpSb/cqzor7io9mL/6axrUs4fHV3EPX6PfmfRG/o=;
        b=tXV7OQO2LvgxEIlomBi5pNk3AV9chy5gklHEFuLfonJIh60+dOJFXhKUHHZ7aeyNP5
         yesyV0Z/ZC/RIMsEbYPBnOn4ZzGMbkjzDhdiMdyHsdG4nTyMQYCW7pp4pevsrmuNPcNj
         WNO47j2Nb0F2M2MZ2hmkelVc9hioZtTSdYyxXNnAsk6wqSQrGr7wDOioNgzwc7R2i/CC
         /luf8uLemXDjfRkGIoU3uKM/955ok7L6lVT4aahkOQOJe62ogT3LyBtpSq2uyJDx9582
         l1Y/EXc0yPcRK3C9jFCGumNZ95zhZXDM8IQf6dH6nkHoxBKpbFlq7gWPzSGrDdHtZXDF
         nA9g==
X-Forwarded-Encrypted: i=1; AJvYcCXxOCF6krwMGvbfCck05ym+52eBx8/Q3hje29qBV34z+Di19vBC1mEuCzqoVl/8xuhPbXik+XwIS6FU8N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1EF7W32lEewmhnRaIo+bUj/gN3AgAxrBENlG/+wdBVhYGQS9
	g61IyEUeJ1H7FzqWMqh7Yc6jkxTyFsnjQ5s/eGJRf8tPlzsVpGmE7vFpTeVjMybYUOw=
X-Gm-Gg: ASbGnctpEyfNmsAoyhDcqkJYUSanJZq+nmYlmixdLPiI4swn860t46c5zwdR4z0iGzK
	y6JhvZGhAdSkiU5Ub0wihVtkhvGqK1j+zLh3JSxSuPEWrR6NDPHGkl8bf5a8WwD2RhgwHRF7UXE
	BYbOPkFoYrvnpnxLN4U2/NGjw6MVX3tS/dy7FWs3fYfBHfAgjsBZO8czCGS6Quq/8qlLDuyvs+L
	G5sf1oOgSwhLegs1kvGh8Hw8npLCM6meIthh2TGSVS7I5c1NaVet9SuZYc/jxN782P2PsZy7m1X
	VAH5jaYj+WwtQO2VD+7hUiUQeeu72/XnBtRR84QJWi+MuBvMHF0jd6XxtBruWCknDlLSc87Tz/d
	V72TJDGbNBRf7QUk+cQBjBpLOyHo=
X-Google-Smtp-Source: AGHT+IEEDQfAylHCOtfbDJfAjy6O++lSjcwcu62QI8WIck14KRu39Vhmu2za0cVtvDIlQTaXtZ5IFw==
X-Received: by 2002:a05:600c:1d1f:b0:45b:8f11:8e00 with SMTP id 5b1f17b1804b1-45c055e1774mr27463845e9.37.1756886426610;
        Wed, 03 Sep 2025 01:00:26 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2f8b:4799:6bd6:35df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b83e954b7sm113331635e9.1.2025.09.03.01.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:00:26 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 03 Sep 2025 10:00:10 +0200
Subject: [PATCH 06/12] gpio: tb10x: allow building the module with
 COMPILE_TEST=y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-gpio-mmio-gpio-conv-part3-v1-6-ff346509f408@linaro.org>
References: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
In-Reply-To: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>, 
 Imre Kaloz <kaloz@openwrt.org>, James Cowgill <james.cowgill@blaize.com>, 
 Matt Redfearn <matt.redfearn@blaize.com>, 
 Neil Jones <neil.jones@blaize.com>, 
 Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=810;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=KKi5iBWXbZE+HQVIiNlH30Zpf3I7GR7YN3wH//ihyCk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBot/WRSZbQN81jQTxh6MrWPRLLtHDK0Efr6Qker
 rgp9pyu1VqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLf1kQAKCRARpy6gFHHX
 ctddD/9w00XQmxkA4UbvnoqaIlfr7D/wppS64eGYxPzqjHvGw3IkU8d3roaKZGJMxSTP5deq4XF
 w6FBq5C2OJCqIehX1vMSwcQrKGh/nb5BOf6dqUIb2eN4exlRLIITgszMDJQiONRB5N9i5F17hdR
 zKUWoJwzBmPSaD9kxblKle0/wVP2FTg81Xtfa+4rMAna/YgbNYkkwOXUUFa2csQcORy5zAUmw9c
 SX7lKoJzIeLOdayzSxDxZkNe1R0sKDKEbKO5nrfDiQCVMwvP662f3z6VeKkidRSda4+qz6m1BQ/
 JMXa10H3A3oedqoufmB7tihVaQmOXTLiy260HEUhY1mDZiyn9+/JOlXer9YU3Vs7qJ1p+QveleD
 +wrD58nySpKLxYjyIygyXNbVgDlll3jd4Pd7Chs3+jOt5ByNmTGduUYG1g1uZGcWbzUjyeEOfXR
 jEXa+KqoVCFQskb/UiNXrOS9vOHce6mi6KaQhPJozeTrtzrurBXCtbq5/s4HQY9nQSs7MH69dFJ
 7yK/3c8Oxwp5PvcfKvMFtK83TBpFAqsxkRs3hyJphw6BWvCR6WJazuknDwF2fWpmZhIx+Sr6HHi
 WyXgujybN/txaCIugikN3gYBNJYra6I6brjZ/vclUUJLZJUspKhkXdiYjuyQdqALuGG/lH8e44J
 2ljwHxU9L8t39JQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Increase build coverage by allowing the module to be built with
COMPILE_TEST=y. We need an actual prompt entry in this case so add it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0fd5b09c499ac8468269b62a306f9ec03c3f7a9b..2fb77eff3b1f2e862a81eb77f2d4d8f14c27873d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -734,7 +734,8 @@ config GPIO_TANGIER
 	  If built as a module its name will be gpio-tangier.
 
 config GPIO_TB10X
-	bool
+	bool "Abilis Systems TB10x GPIO controller"
+	depends on ARC_PLAT_TB10X || COMPILE_TEST
 	select GPIO_GENERIC
 	select GENERIC_IRQ_CHIP
 	select OF_GPIO

-- 
2.48.1


