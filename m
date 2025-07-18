Return-Path: <linux-kernel+bounces-736530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA7B09E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFA01AA55DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69127293B7F;
	Fri, 18 Jul 2025 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zMyS19aQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAFD13FEE
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827917; cv=none; b=QAjQKuLorTWdvAaH7YugobYu8RjPlr8l+HMA/INsErh5JRNJLrac4aR0iMAxYQHqcnGEPtn5t+tiMmUPGPGv82GhbBzR7f3Qb7H28Q4Y8pI20/GFLMIDs13Aj0w9609xOPTxlsQfm7S4788tIGNFXJxa6SIuPkZ456ilzKYohUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827917; c=relaxed/simple;
	bh=0rnRywdj99vUjh7GmU3PmAiPRCJhenK4DLNxhtNGISg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dPxL5KYdoDy7J5VqEe0ECAY6zcJ3HztKdMnXudg5/3JkXa8RSGKbzE1+b0HE56RgzcqIKPYibFvUiE55cSwedWnTHe33FkUtCx58dagP79oipbmPD7BGjATQ0oSnAj3hH46O7pRPCXTa4E3nW29Lktg63KeP4HqAF0YyeVYQE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zMyS19aQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso14163825e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752827915; x=1753432715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXgOYTbgBt90IjpwJ0T6DCAurOotkArJw103biH/iBE=;
        b=zMyS19aQtkIQuN1e0s093A6GhlSVA3kKqNnRzXUXH7zB7EyxnXDk/ih+Qk5EBvO6vH
         CQ831dFv31NYGq8C5fjpvUExdsBGjEvfZtS7rDcvfDJsKanbHoM8LT8ji5XIAtA0axWq
         aQV8JiCJclSvuIy2D/dkzoBmOWi+1j/ftaRQsM/EGY+3Cuj0jdz8cKnROz2U7uVziyaW
         OvmwBweBpJjpe+3wPOLKg7Dahh8S5v78XDSVjb8nT7n2lU552ueHA2nByOUiqX5ecvu6
         dj22E2XZpELZM9FwDcy5pbvVzW4ND/E6L70SoJ8rZt73RY3/1nPCQ0zbe/GWLlZCB53q
         F0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752827915; x=1753432715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXgOYTbgBt90IjpwJ0T6DCAurOotkArJw103biH/iBE=;
        b=eejfzHL5nQ+XPyre2Bldnb7r01xe4WPGEfoue/5XCm2Ldw1mEqCKIqwAUpnKqLg1B4
         TbMNa7zpOpEa5AUBhcXw6BZyzk0Jb+magorsovqVQrUOpz+XIG9hW3J5OKOJvyUCY8dI
         oJ5OXLkGX2p3CC+nINq6n+hsEJ8zK99rhK3aasi6+18nPGzM0j9JnIJvBW/3N66ejAy1
         nytH7hWft6+4E+ymbV7ohEkue1kssWtqMKsfUyz7aozSIonGcaHE1LLm8s1vvUDAsA2p
         ffLK5tDwgjSAGUkAZemW9wFyePcA7RkRp/EdkfwBHE2SP0KvCTjYXvn0vMCYoIRcWO1Y
         gR0g==
X-Forwarded-Encrypted: i=1; AJvYcCUStvAjg+aK5sqS2ZI6txNJR+TzrKUDgNTjoVKarvguWR6c4vSG3xD35ZF3ItwKQ5N7ode3kzSG0V7zSMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXKaN8tpkN8xZ1oGDPBfaf43JxzvO11H2z0bfBfHgsqm+ewtne
	y1uaGW4O8t2KCazTENFL9VG1wTwFKABFQzi5eLwskzBS4HApayExRIhDtV8kRt2DvwA=
X-Gm-Gg: ASbGncuJvn94lRXjgFXuKgwbNNCdhYojzbSWCkRKq+jVg1Ml9e3s5IMwc6Hts67/GrB
	yp5PYh60mj9WoBmn9JbKZCoIWoHbWnm8+jGz4vZLimBprgNW+dL7w3FA8TRqH6F5vm4YtnWfVLw
	g+ws2XTHeHJ7fbVcEy+S2OiBG2a7F2/DFodbWU9HzY+CrC3pf+4q/t4HGly+xmgXIZ0RaylKaYH
	B8EQpOk/fHGFIeDDhrwswzSiwtT+YmmJxJf+x8WSpBwnQpcyYESF4C4q929ps7TbteGw2AjNU6I
	e49DXnzVeODEXzx0AKFzd59t4odU9HhN9uw5AK3mMw3/VynMKUun8XrddDlbhhByIzLFux+dt7v
	9XPLp0Fw3E8zQNDX0hp2e
X-Google-Smtp-Source: AGHT+IFNocjEuc28rYTEh2nD7SaeEUsWN82H3W4NGv5/y7cD/uTzD8xEZbBDBcDw8hK3CoiOtNza6Q==
X-Received: by 2002:a05:600c:1d84:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-4563b89f7c6mr16164375e9.2.1752827914610;
        Fri, 18 Jul 2025 01:38:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e88476csm73582005e9.21.2025.07.18.01.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:38:34 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.16-rc7
Date: Fri, 18 Jul 2025 10:38:29 +0200
Message-ID: <20250718083830.81316-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of GPIO fixes for the next RC.

Thanks,
Bartosz

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.16-rc7

for you to fetch changes up to 11ff5e06e02326a7c87aaa73dbffaed94918261d:

  gpiolib: devres: release GPIOs in devm_gpiod_put_array() (2025-07-17 09:22:46 +0200)

----------------------------------------------------------------
gpio fixes for v6.16-rc7

- fix the devres release callback for devm_gpiod_put_array()
- add an ACPI quirk for Acer Nitro V15 suspend & wakeup

----------------------------------------------------------------
André Draszik (1):
      gpiolib: devres: release GPIOs in devm_gpiod_put_array()

Bartosz Golaszewski (1):
      Merge tag 'intel-gpio-v6.16-2' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-current

Mario Limonciello (1):
      gpiolib: acpi: Add a quirk for Acer Nitro V15

 drivers/gpio/gpiolib-acpi-quirks.c | 13 +++++++++++++
 drivers/gpio/gpiolib-devres.c      |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

