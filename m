Return-Path: <linux-kernel+bounces-770486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB90EB27BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E976E3BD327
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55643255F31;
	Fri, 15 Aug 2025 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CneucR+M"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F18212B31
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247668; cv=none; b=qfxiNX7pS1Lj2fMELC2PGBbp6IJ/MkXTt/1+dh4KTw5H0z9Se/pfZqYCBMk/+Uzb44tfi1qBCMPDdZGCUWe2xK6dbPpMBqffsmvIaqDF9vBCYop9iU0nherJdmGMxLJmxqbwVDXJPzteN77L76m4bMREZHbJ8MK+b/ZINMDgqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247668; c=relaxed/simple;
	bh=RYALQ/VZFhgTzYxmgzWoAtvdoZBFMfovB3h/tVNez7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9P/tRV0r9MJadiYGtllnCSDLT/b2wxG3iwW3ftIXIR0vhoVSaSq8sq5oa+kN56wMQ1Iaz3ZOMlI8/23oRIQS5By0ppCPbL5RiqUsL3TcCx5MZboexlUzabO7zdn12oFHeTJ6FPCxY0efx4PlTmlGjFjw5VBUQxC3WaUm60E2V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CneucR+M; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9dc5c6521so991629f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755247664; x=1755852464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dIMBkGRRdaJ5ZRiDeo0WeGWMzhcFu0Qu77VfnkG3cGY=;
        b=CneucR+Mn423uioIXsp49XvRrPz3ebxaWThk4aFF27h9q6xtZ5uP+cfqPOifXA2PWO
         EoihXpvDdNLNhcuwRUGzKHfBXFO32vVkcq/r4HqZfVHE4sJBIrvun1DToCDSTb5VauTI
         FztomLK4ETswLGeD/8YYc8t33zGFegWXWcHA2Tb3pOEk4vIM4JJ69FhremkrtN5onKYn
         GdUXWOlqLW6RoWy+WMhpO9f5UWwR7m+0mEe5PcnpEnEbpqs0b0Utr5IeISYOvYimEsGQ
         TkLOrS4Zn4aQtGcJ5TT2N/4DDBtAKMgg25ZvoMIe9E9gJofEnhyxVauFefvaK03JlSw5
         DExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755247664; x=1755852464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIMBkGRRdaJ5ZRiDeo0WeGWMzhcFu0Qu77VfnkG3cGY=;
        b=FWVIdVkTEgpmNLnOuPRKJSmKwyZpQjUe1n5maE4f9VVAuh+TF8WKcwdkIH5vcl8Q+Y
         N5pFRVVzqJmBxwFSTcYsl9Ot8ccZgBbG+uGEF/pu8CIamoOiei99yCIQ2Wdrq7fu3kJf
         UpJ2f4znvXLyd+OZoYGYrwOxFcnLXLLz1LX+PModOm4tL2xXiDBG4TOPzJTr61lEpot9
         ts1N1JnEFNtF6cjRG/CTuBvghHFaxN9l022GNIoiSDzelDlEzLO+Xp5TkgAGIKhJHTeN
         8481IGTNCRL+wbph0Iq5ng0ldiZ+81dZI1PVxH2t5BVr6f7lQSFek913lrJkjMSBM8SZ
         zMMA==
X-Forwarded-Encrypted: i=1; AJvYcCX8d1b19Rygzh7yaLHStM/iEF87soVjU2VIwCR1BhI7w4gkCbAqOPTNwfOfca3umOP6g69rB7QjMIblbAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWLy6SVEfNUUm0URytfVBMlcXxp8fAoguWuZ7aIwi5I40PwLM
	/faVwzIvsNQ4Hq4NJvqRtdqFKrLBLXvbOke9JZY1ik0f/iMAL1zpG2MYZM02zY4qCO0=
X-Gm-Gg: ASbGncuUe20X90/Bz+Obf8cgD3zBhifH/Bkrg47Vxlq6LrV9jjTNFPWO+dNZ9ONAI7X
	H6dUl3o2tYOyfb0Y/1tCmBbh2h8m5rU7iPWPV9t3o7NXCgprVJ74QHcLD9zdIlMfjnHv+t31TrX
	7CkDdJpLjksQF6YRSWfhoYffsPH8eVDqLQXEYzBYxATp+OotXNLhCY3yMtGyoOehXFrOys3DY+X
	YTNyPQCLUB3abfPzklPAgKClgmn5Ym7PMqqtsDkOTNCTrrRY1Hfaa3jOJPuMNza2VpAgjvm6uE0
	JVsB6LbisiKAqiB6sVZQ4H4LIkUXRYabApWGSLxKPdODf68sWwXAdskTLDsUC/HaIIBA9xWjp2s
	nW/XwKguxhdN4leEtZlnmA4ILIJInfb343cw=
X-Google-Smtp-Source: AGHT+IFK/PBM+v8APN1/Zvq4cSIYlHkSkGTuq1ae9CofliyDmCBIhWJ/UJpMahqDcWkjaik/M9sKgw==
X-Received: by 2002:a05:6000:438a:b0:3a4:eef5:dece with SMTP id ffacd0b85a97d-3bb68734ac1mr814100f8f.35.1755247664222;
        Fri, 15 Aug 2025 01:47:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a125:bd3e:6904:c9f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6816ee9fsm1153601f8f.59.2025.08.15.01.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 01:47:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.17-rc2
Date: Fri, 15 Aug 2025 10:47:40 +0200
Message-ID: <20250815084740.13431-1-brgl@bgdev.pl>
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

Please pull the following GPIO driver fixes for the next RC.

Thanks,
Bartosz

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.17-rc2

for you to fetch changes up to 810bd9066fb1871b8a9528f31f2fdbf2a8b73bf2:

  gpio: mlxbf3: use platform_get_irq_optional() (2025-08-12 15:40:28 +0200)

----------------------------------------------------------------
gpio fixes for v6.17-rc2

- fix the way optional interrupts are retrieved from firmware in
  gpio-mlxbf3

----------------------------------------------------------------
David Thompson (2):
      Revert "gpio: mlxbf3: only get IRQ for device instance 0"
      gpio: mlxbf3: use platform_get_irq_optional()

 drivers/gpio/gpio-mlxbf3.c | 52 ++++++++++++++++------------------------------
 1 file changed, 18 insertions(+), 34 deletions(-)

