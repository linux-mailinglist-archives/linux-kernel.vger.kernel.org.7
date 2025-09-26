Return-Path: <linux-kernel+bounces-833880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B872BA3473
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155B06208F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CEE2BDC1D;
	Fri, 26 Sep 2025 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cxKDBoE6"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4028F948
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881075; cv=none; b=bG8T87yx2C9zYquhwLOm5RtjiBNyhiZfRfE5VzneKykrsRpTHu6RBuUL+Z3DI0/uzK/uPI5TIx4GXvcFy1zt8ws9s72R4JRzMzsJF9QaYBCPXRWZmuezsOJlg1sX0cBSovF5YbS/bAyXnPVU2+tcDhFq0AaXj74RPmAqv8zfZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881075; c=relaxed/simple;
	bh=lfsbpXTCfUSN6aBMYs/nnoiIdzUuh9IZb45T4QOdBFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i88Z/ZuVCPWytOJ7i0/yJFuCtOvKLN9N5Yuqb0jsMSMRteHyp8Lzu6OJVG1kSeZXjRbT3brsQRHXCA0s+OkDE9BZxWijXYtpHrLvXCspYfCrGXqtRI9xPbvErCH6dMQMYF0/vrr8gNhhri9fvNCJ5GTIxPSfZoUFr+0WbU8/4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cxKDBoE6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46c889b310dso15361815e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758881071; x=1759485871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQM9vZFM7FnvGLKPuP4NIyjEuejpFr/yasQmtJhsCF4=;
        b=cxKDBoE66gfM2ZcLKJqPdpQ8OcWN40RWoTA1sV0q5MQdNmfEFOPme/TEHulGmTBjyy
         UJxGJl6KpMr7cDaMW1q5fSVykfZ0OwSHYHEqHFeOisTYuD/hZZPIuzPTK4pPLM9CuYm9
         /wNgPO+3dub9u1oGubDivoVeW1ox5OOjt7aEmEq9ijxUF/hmwh89nw6DwSnoY9dWUqEx
         eQ+Zgjuqe4cdV4mLgRswjpjQiCP7wz8PghAdAyoL8c1AFC1By1/WqaRXj7Utm3e8VBok
         /NU7u/zkHNoYpTJSRdLVoee/iwWQhm9tujNZ8DWPhNQ0e7HlDe6sbKzYMqiOZREGdz0G
         y3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758881071; x=1759485871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQM9vZFM7FnvGLKPuP4NIyjEuejpFr/yasQmtJhsCF4=;
        b=pMDL3fYUEDIO+lWDEkZso06UmUkpwR5RYOh3TrU5uJ1YXvZEOrJaAnsA3MUA/gAtZC
         460gKd8i8H2mEkgUgc60CeI9Oiv1R1qCrDPHjolu0amuQRL4KXVY1lrkc9diK5jlQ5+4
         6EWapGKSG5AiznXspl973P+7pvNQxWIZBYuzdc7sXbhKhKEJo2e1SwrjZn8qLF59MQ7j
         ttyTkfS3whJKYaFl+9P/Q36YM20YiSXZC52YJnRNJq8KzcjBAWF+Tqp+bmRKhBlxs7bw
         CrdHYAUZp6SiEi+X81SHIoJUeve9eL23tVy3zq1u6XUnLcBGXo3Q/2k38ZhWQOIGQeXk
         XjQw==
X-Forwarded-Encrypted: i=1; AJvYcCVYS8otzC6K4IaRhYuC/ZoWigRkh8G7dDpgthUfPPFd8OPz3TpS+67G+YYXY4m19BbEVl0lxm0YY8dBpT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+CwNhAGhnquzPUoe0l/3xJtv4S663kO/1sXdrIw9dUqLTd0o
	fEx+S51KMG5vkcYBaAmAkiGWWkEBfUB2lZKEKV+fL3nhj4ljgsdcGcJZ3LwtxVapQdQ=
X-Gm-Gg: ASbGnctb36N7aT/Wl5rPg19Afr8ZW2FXH+7vXuGH9jUYWzekJfsz3q8CdtEyzOeUyvp
	9MqViDh5gfwkscomzt1QIT43nVLl1UxitU1aTDi3z2yQqPvjUY9mo4UPsOzZmO9TZLwvZ9L/XHH
	epIlNIz27K1DbFu/aut18aXxFEjf/hmHIcoTzCBwViHGm0oZ1zTFli9hdBsUTr2sgo18pjHbSPj
	izszwbe0cL2+RuYnkkBNWlbPH726EkKoVtFgh8g4CqbxuYC53r+pWwPL4KoxOTeNhkg+EZTTETY
	a+K+D0V1wF3oeoXz9YGzSyQmdnBEk0MlLD5sU93h1rqcXRTzNbxtbSfHkmSNaWDFLc/M8Bu5xlH
	TvkFEdI0zJ1pwNgfqBW0RL9o=
X-Google-Smtp-Source: AGHT+IEgYt39FJi5czBmqHTA/Ju3Jq2wKhFs+ghFwOE8QfeZzBA/+qSEwQ2i6S4wbag+tndOkFR0Ug==
X-Received: by 2002:a05:600c:c05a:b0:46e:24a4:c247 with SMTP id 5b1f17b1804b1-46e33c37045mr45634845e9.5.1758881071244;
        Fri, 26 Sep 2025 03:04:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ab15:a65:aecd:6def])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf70b5sm67209715e9.21.2025.09.26.03.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:04:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.17
Date: Fri, 26 Sep 2025 12:04:29 +0200
Message-ID: <20250926100429.40265-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the final set of GPIO fixes for this release.

Thanks,
Bartosz

The following changes since commit 07e27ad16399afcd693be20211b0dfae63e0615f:

  Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.17

for you to fetch changes up to 3bd44edd6c55828fd4e11cb0efce5b7160bfa2de:

  gpio: regmap: fix memory leak of gpio_regmap structure (2025-09-22 16:35:21 +0200)

----------------------------------------------------------------
gpio fixes for v6.17

- allow looking up GPIOs by the secondary firmware node too
- fix memory leak in gpio-regmap

----------------------------------------------------------------
Hans de Goede (1):
      gpiolib: Extend software-node support to support secondary software-nodes

Ioana Ciornei (1):
      gpio: regmap: fix memory leak of gpio_regmap structure

 drivers/gpio/gpio-regmap.c |  2 +-
 drivers/gpio/gpiolib.c     | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

