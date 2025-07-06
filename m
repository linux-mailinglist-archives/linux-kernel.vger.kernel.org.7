Return-Path: <linux-kernel+bounces-712824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B3AF0F73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 11:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4837A188E4B6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEAF2472AF;
	Wed,  2 Jul 2025 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RDsrazUM"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9802405F9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447654; cv=none; b=uG8wvKM2dUAiQYrLoCvPZltpt6p/kdK4PSVN/0Vu11YZFUodhkdtOD2112XdEO72tWIPEEI1x/kEoyKfI/x34G0+hPKVywXh7lk0tRkTLZzqBlO1ubL1xhtQLHpWTI8D5NmmgzXHK9HuC5DQXnvUjivVG5M98WDsyL7k9j3X0G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447654; c=relaxed/simple;
	bh=sOHXpCVPzm/YZ8eTA3k3opAT2PwIqz3LxOM7hlnGd2U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rphwNww/zSLIM+PTjeMJjBaUR0CcFfvZg5P/3fW/fi6BLOh8K4Q7LAak4akJLxhE1QXE97X9PKHHUcRCphuh/ehuPpdvfFqSfRcO9U9hNaJWZEAPsPDcGT3L313IzrIyzvTuMg1wuKDdhRpafgClcLm9eMEtDrpZ5weN4JeCPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RDsrazUM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so4778483f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 02:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751447651; x=1752052451; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FeL948pEBrM0oIl1f+aZCIR6Mgw1zy0Mr+qFmSzolc8=;
        b=RDsrazUMrPNkDeDIjBHi1xpoderahxDFiHs7Qy32Kvfa2mzONLnoEnCuL8nnGETY1+
         ukS3ClTgePoL6M0G+xHgEZIQxL89Au99E8nH+RAAFtb57DI3u6N14Kf54SC0ZrCZER3j
         Lf9b63mgDMOLtttNTCimRnBGBK2/GX7YYtkoieQF0PNY0pf7TUYUtu3tB7o9m46FTqvU
         PHfGqH2q/S4NXPiHEcfawhfi3WFDav5CC8L3t47ucSalMqRm1/PPMFa9ODEjqzSeYpco
         o/xUn9Jb/Vj4DkskCJNuYtn8K/o6kWUIgxvfw1OECBRtXl64vMD6SHU/W5Ltg2Rq7s1y
         wmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751447651; x=1752052451;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeL948pEBrM0oIl1f+aZCIR6Mgw1zy0Mr+qFmSzolc8=;
        b=iY0kB5Z75g12vw9+gD9dPTOP5+wBq0IbxkQJZz+HzF/fCip3Wh23eSEozrvSSKVm2X
         D84lEk+8ohXo+btO2K7fdXiubI9BvMUapCOjM5G8WkGqYgyBS3SmBjbmINnwgndv7aLT
         deZzcCYqGWv+LrP7kDiIh6AAZZDYkU9oOZHDidZ4R0XDHixGK/jLNSXX/Ob6jOtBvd9R
         2xVLQk9pYUmkUuRus+z69siwB8NoGhQ+nUfeI9PAvtDo/8H5PrYSlnG+EU+muhHe8UeM
         1LS2+ZfJWDxYvGWcu0gObdnkIPvXZ7ywRFPbV2MmcEKWg5heuNSM991h+dZoZl7X/ukv
         NSgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8LVlt0EgyYLwS+wkRWSedKRo48l/8ouvWU6Wr4+f1BFzJutGHmiLxfxjOnc583LJoSQ/Q8rtCmiaQvJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqRUxdWYEiER3klvxI9u5NMzDZ/YfRPRMcdqMloCFQru2O6Fen
	XAKeAG1VfvQbD0jWzU8nn8UDC0LiO8JCD9khkSC8oRXrEs+vqouX6dKdFo9vumlkquw=
X-Gm-Gg: ASbGncub400tQj6T9GRe5zdVS4PkuyPcYHKLXRCV7KTIgEICZ5jqRDTdRpsW5S7ApFY
	bU2o8Ywwkv90HiOVmai6Bw6BQKgxcKmNDVUqtw+ATJfXNiY8b4R0nQ5yIsiwqkIsdblVUeKsmpa
	9cJD8ZcQUxfrHgm5qMU6vyoz7ckQ5GJXGS6uTnenWZmIKz6C95SjBb/XjI9ekCzO3ImUnBWcd76
	0CyS8HSuiruzfaRoTYfAa0WLxxFmL3/vnOkit/B+Xw7xjFZrjQEfS89Ggrh+gItAdtQ8XEAtXaM
	wjUIdiZACwrZJOW4ufvJbRKcDCiqQ1h/HqXA3pjYvYN5Cucl3ljQNxrBRraEv6RW
X-Google-Smtp-Source: AGHT+IF9qG6a/NsxMnQIVPPTepsmvFx1KpI71XHtS998Sg2pHfCt5jeNuVXluvHxs9EveU4oGvY4NQ==
X-Received: by 2002:a05:6000:2010:b0:3a3:6478:e08 with SMTP id ffacd0b85a97d-3b1f93550ddmr1557563f8f.23.1751447650851;
        Wed, 02 Jul 2025 02:14:10 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:8827:d0e:25e:834a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e6f8bsm16027213f8f.17.2025.07.02.02.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:14:10 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 00/12] gpio: use new GPIO line value setter callbacks
Date: Wed, 02 Jul 2025 11:14:01 +0200
Message-Id: <20250702-gpiochip-set-rv-gpio-round3-v1-0-0d23be74f71d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFn4ZGgC/x3MQQqAIBAAwK/Enlsww6i+Eh3M1tqLyloRRH9PO
 s5lHsgkTBnG6gGhizPHUNDUFbjdho2Q12LQShvV6Q63xNHtnDDTgXL9RolnWFs0/eIHMzhtlYc
 yJCHP979P8/t+syLfq20AAAA=
X-Change-ID: 20250626-gpiochip-set-rv-gpio-round3-58bf959c2a0f
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Richter <rric@kernel.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=sOHXpCVPzm/YZ8eTA3k3opAT2PwIqz3LxOM7hlnGd2U=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoZPhfrB5jN1miCdxSaAbtD6Deiu66lCqZxBf/f
 1GxNm7l3hSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGT4XwAKCRARpy6gFHHX
 cl+MD/9PPdqRVBA6/Hn/VbSzDey+uQh7kYAOPnM8zK0b4dKV1xjIuJ7OX6GkMP/n5VHrNM/+g5h
 7aa/TlZyIZLoddPuXkEbiX4J3EZwFt8ERcEjr8GcyudkM2f5X0C6ELBRdTXdXCv0mTRebyysT4j
 uHocpFdhBfZhPWKKurizzAsu7IXiC+9XqvQAcgy3XyfQCH52x2cTLVbh4SoYRML8bNJsgsLfdfR
 h8cO3hRtimKAImdew5URtusgBjsMlUO1RtQYmQxshT80hLJzTrJnCgTtiSOjY24daJXJ8Zwb82+
 yXQgPWzbJT5FNVXOM4Hz1ZTV0aeeuM8DKmR7KJX2iQ9QEvqiN7hw3EYPH9QObeKHHhDkxT10VfC
 UC1Njtu7F2iHriDpuya14mroFTTIXzoGZmiP0e5YSAUPg9W9O3JDH0ZQ/rdHe5RoHYHgv97BvSn
 bQqFQkqRZ+K+5XcdANfrjKfTpCzNqmVt79kwt1eu2R9dN4T2mqhQcSNrSPhr1ks7gwWXRbwAgCh
 s1YjrQNwDDmi8RdBXxZeG6K69Tu/DjxneG9FZ54Q2qfPaOlwQCmDrzZNuDxobuBQ3siG4QEiDQ7
 FaektdzkG1y1jUGeLqBD3nsAMqy5ytUeisckSR60mbikkhNO6AQDoXhb9hPP4RTOt28ZixG1ZYi
 q9DO0A1TJp6u4Sw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Commit 98ce1eb1fd87e ("gpiolib: introduce gpio_chip setters that return
values") added new line setter callbacks to struct gpio_chip. They allow
to indicate failures to callers. We're in the process of converting all
GPIO controllers to using them before removing the old ones. This series
converts another round of GPIO drivers.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (12):
      gpio: tegra186: don't call the set() callback directly
      gpio: tegra186: use new GPIO line value setter callbacks
      gpio: tegra: use new GPIO line value setter callbacks
      gpio: thunderx: use new GPIO line value setter callbacks
      gpio: timberdale: use new GPIO line value setter callbacks
      gpio: tpic2810: remove unneeded callbacks
      gpio: tpic2810: use new GPIO line value setter callbacks
      gpio: tps65086: use new GPIO line value setter callbacks
      gpio: tps65218: remove unneeded callbacks
      gpio: tps65218: use new GPIO line value setter callbacks
      gpio: tps65219: use new GPIO line value setter callbacks
      gpio: tps6586x: use new GPIO line value setter callbacks

 drivers/gpio/gpio-tegra.c      |  8 ++++---
 drivers/gpio/gpio-tegra186.c   | 49 +++++++++++++++++++++++-------------------
 drivers/gpio/gpio-thunderx.c   | 18 ++++++++++------
 drivers/gpio/gpio-timberdale.c |  7 +++---
 drivers/gpio/gpio-tpic2810.c   | 27 ++++++++++-------------
 drivers/gpio/gpio-tps65086.c   | 16 ++++++--------
 drivers/gpio/gpio-tps65218.c   | 31 +++++++++++---------------
 drivers/gpio/gpio-tps65219.c   |  9 ++++----
 drivers/gpio/gpio-tps6586x.c   | 15 +++++++------
 9 files changed, 89 insertions(+), 91 deletions(-)
---
base-commit: 3f804361f3b9af33e00b90ec9cb5afcc96831e60
change-id: 20250626-gpiochip-set-rv-gpio-round3-58bf959c2a0f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


