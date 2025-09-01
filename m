Return-Path: <linux-kernel+bounces-794600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E901BB3E3C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5B33B2949
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD13314DE;
	Mon,  1 Sep 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wdBpPWzb"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016B2E0907
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731320; cv=none; b=g9X10nA6y7bDsDNqg0PTKO7dHxo/7anfb2V1SHNR5yf6njfYG6j2bLSnEu+oT6FcetnxLDCPOTD69ukDLLKua75eIMmxGgBCQdGcxeuuVD8c+krclVh9UopkUTYbU3SUxvOiz/KEikIkiSemBye6pDvHXADPqy9KZv60cfSzTO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731320; c=relaxed/simple;
	bh=hd5YuUb43lmK9NYWKfd0042YSg6zpeLa+EqhNF43SKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDvJlrQwDn4Bi2s0npZjlslBSLmYz+96eSA1CSxoH3QfM1N8OUkKqyGxPBo0t/tUjJ9YrdeISsGVa0hz2hNheumeFIV92zYrmpCfdOgmMaFg2UVipALj+b6G6vkYYKv7+LqeF6PvgRgH84YDvUXzCcJ3Cc6Pfby4JptUS2f9pjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wdBpPWzb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so29422625e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756731317; x=1757336117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWKZDQFyYwOuNuulI3WR/HKsVV7Iww/yTWKQQUevPSM=;
        b=wdBpPWzbHRLTnzh2tNh14GkP2faT9kXMjhYz3VPyNkbTcycbRO+2E9JTzaHjsUEPSK
         PIeam9NPlrtl1I6R5jDfY2DGJRYKE87MUqIYpgItV/lxxpgZeLwetVX+vme7RNNzuWR4
         zhyRrDbFgogMDy+iJ09ikv1wPnPw9RLkXf1i4s7ehP1loDfmMTI+GgaT59uuTRNcpgtS
         8oaw8X0/FI3k3hz8pbKjullOTR1LYRaFZFlkgUyBxhoqU/Zr7s68U2zgy9N5CVf8sAL+
         O4jL02M+6DAVgiVU3HCryW/IFspOckLIpvXMFpybM+IAmUTibxQ7B0IYovdpbX9o8i60
         vVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756731317; x=1757336117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWKZDQFyYwOuNuulI3WR/HKsVV7Iww/yTWKQQUevPSM=;
        b=vuy75VeY0a/TLeHzkzlcasVXDNUM8r36CILjlPjuCzQbAdtOv+uzuYePzBELIRWfTu
         8vRxcd0eWlTtNAj26Hiyo5GLiOVbJQChHoYj9UHmYRAnGiSikQO6cEp9oFwVmDukK3K2
         4cETlibFnltYRcmadioF8rLtFcL8Eq3j6FoTymVOrpVwtZwV2cjFfmdkY1bYwswjsoVF
         We99F9JqDZ0GRacQnt/3udbakjwX3r5Cwht+1qWE50PHxty/uMSM5gV8WLX4hRRn++iH
         oRjzURkVTy7Y6PVMNdSxd+NNMCk56UngzZikBiovLcV5UebgW60blirA1cvIgtO4pKfR
         CkVA==
X-Forwarded-Encrypted: i=1; AJvYcCVIPZYx2JUV05mh6v2OQc/IsDS2v5/zmpEp5aH1soDJl2itNmP1KxIloEZxiXUj+AOQ+5IKL29g1PCx7QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAkpAluSb2vFgvA+5wYmcj98/xys+2ps0KA0SbhZY5vfXSFgeE
	tcF7Av/RE41MDuTKFtQfByYVzBerc59pR9u+JO1DRVtV5O7s2KjyxG3qSrdl6cPRMZU=
X-Gm-Gg: ASbGncsGfWCGRFreLy0tVTQdA9KJ4Oa1E+DHqbdhU14xb5bfn+xk6x5tl00UHpmyiZL
	OLRS462TR91cmh4EMXvSNbvs9QS/2fscvw6qvxSbGCf4awx+XBHhr4MoDbZ+UTHwvalelyJQHSt
	sl9VlF1JK40pt4N9487NWhMxeuHuWzXjEcC+O+sfZ6C3846hnUCDROp2bVHLvNqsWNesAOYjg5W
	J0xTsl/O4afLNh8FjhYgi+LuJGh40AyAPcHNGlSbMrJdJw+1D5lS7JjPuaACZ0Mrx3K+RAFYABI
	BCx9UFuOu9XMNQFVd6MLGSDbSK3ZIMP1V+kiIrnYukDPxu+XnzIuwzIj/sGGenVeHj//thm7mnK
	87pVqZISADFSUjMZbrYP10ajPWbP+bH8sGw==
X-Google-Smtp-Source: AGHT+IEfTJGjgZ6QGyy0XNs8W/KLBwucktc5Nnhf6C+tAQhHRtrP5B4Mes94NZ8oGoVH0Lqq/BK7wA==
X-Received: by 2002:a05:600c:3111:b0:45b:7185:9f4 with SMTP id 5b1f17b1804b1-45b8f477445mr15347715e9.34.1756731316267;
        Mon, 01 Sep 2025 05:55:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:fab9:fd92:e2cb:ddcb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm208282115e9.17.2025.09.01.05.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:55:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH] gpio: fix GPIO submenu in Kconfig
Date: Mon,  1 Sep 2025 14:55:13 +0200
Message-ID: <20250901125513.108691-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Commit a86240a37d43 ("gpiolib: enable CONFIG_GPIOLIB_LEGACY even for
!GPIOLIB") accidentally pulled all items from within the GPIOLIB submenu
into the main driver menu. Put them back under the top-level GPIO entry.

Suggested-by: Rob Herring <robh@kernel.org>
Fixes: a86240a37d43 ("gpiolib: enable CONFIG_GPIOLIB_LEGACY even for !GPIOLIB")
Reported-by: Rob Herring <robh@kernel.org>
Closes: https://lore.kernel.org/all/20250813222649.GA965895-robh@kernel.org/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a437fe652dbc6..6fd904e29c3e7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -3,6 +3,9 @@
 # GPIO infrastructure and drivers
 #
 
+config GPIOLIB_LEGACY
+	def_bool y
+
 menuconfig GPIOLIB
 	bool "GPIO Support"
 	help
@@ -12,9 +15,6 @@ menuconfig GPIOLIB
 
 	  If unsure, say N.
 
-config GPIOLIB_LEGACY
-	def_bool y
-
 if GPIOLIB
 
 config GPIOLIB_FASTPATH_LIMIT
-- 
2.48.1


