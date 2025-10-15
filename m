Return-Path: <linux-kernel+bounces-854748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF61ABDF4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AE518821FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD9C26E6FA;
	Wed, 15 Oct 2025 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SH7IAli9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1162F0C48
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541370; cv=none; b=rYzIztajTNb7CLnJsFLjry1wcoCo7YCAtJAPySeysiqTNESiLiIfg9pfh22sEPrviw60LiXbbmO7qkvlUeUYBvvRXTrjiJKX4JSL73nGS4TfekLCF7VIlti2g1uoF83jcFFEp8EUqxJWUZdWbZuZvp6AkMjfBbMOOB8oRNTAnXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541370; c=relaxed/simple;
	bh=uCgt805cHRK5qUGajx+3IfAQ3/pisK3BcFy2PmB4M4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7qCR2HfNthpdJ2lIlLRffAvC/lsYiXXamwjrJbp6zux1V4kNqiD093VIkeKwNVxIL2UF5mNq0CqUWn8TZ8pKpGqkE6SwvPi0npCCn6IU7BO5rgJGteLTFdyCaAFsa7HZ5f4xJD7CuC9JWga8qdAaQ3cQyRm5Xmod+JEC5t3gXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SH7IAli9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so61118145e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760541367; x=1761146167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=leA4p5KdGzuUByIONtOKgx/UtP5+WR5VhZskIIy7wo0=;
        b=SH7IAli9zwgkbmF1lewCVBrKn0gsDmudtGWSI4A/+GewKyYigDXkTgc6KGnNtw+f0I
         Bg/189W+tQI40xqcFiyINBYCA+SMlXxDAQuHLO8XCKPVyNhHctKQdRYgrjz1xwkrzRXn
         20FpZXAGIQvwpoBUV6YFAyFDANN5hUUca16Cy4AfaTjVDy6vWSriu81gJlbn43cIa64m
         Uaixe1QmBofX+rMu0MMBk+5PEfKMoKsZ5rUwcjO7Kz5oj6me5SjyjL0yE9edjXmOuh9x
         d/Cr5tXudANBl1EaBYRbT+aJzHC4iV6bk0+HbYZCGOdC38BzALmcYIokQPu24WYchYC4
         xHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760541367; x=1761146167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leA4p5KdGzuUByIONtOKgx/UtP5+WR5VhZskIIy7wo0=;
        b=U1ycSacurzCqK0muij0rDG5EawmP7tj1K3QMz6LbHOZmcdnAKekJTwRYyWuYsSJKo0
         qSANYMYTprKINfhjWujk5Snujy9jGKTe9ZAXbutGnfVboAy/Z1KGt41wio6XazVkYqPA
         ZtjU2yKo4O98SjWY4adFJtjdEWr9aa3eD5d8dxD3edklwaecrSXu7U5Je3jYZyKfd/jT
         0DTXDUlYimZRtrWkh6/VgIBw8Mlb24/fFq+K3iWnwQwvRGkoK48o1kcgVKFsAxNP09uu
         9aL6Sfj/fhpkjqjPGl9YTewcgg2PjDnLx9yrtwPIoZDnp76PbMnv3ESspYLeKiE+eCGT
         tdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1J5YfI89OKOO0WbzXBb7jJXmk2yZraJevNicxiK4ennbAncps990kn3cC8mzeVRRtxeDIEG9b7o1Tx8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPuG0Pv0PuRnvCYBTzE/XaaFirkWDIqRNOVcMXEmf2Eqe4/JUJ
	YeNE/96RPpuPlT2rXBGU/oe0l5ykC/16xDiv0BYFRnazDjNi1J+4I6h/xbk/ufH3cKU=
X-Gm-Gg: ASbGncuhspl99OJVnkAkV8K38+ljHWatvnFK03RTx8+RAZftmxMR5W/dqv1fEz9N0K7
	YNUuJZSxdRcXWndR4tajNJbxsFDVhwfG4+25nm/4nPfyfKv/UzXVHeH5Z3PLt00m7W4garJlV+t
	qcDsYuRf09zLq3Hg1Sxo4rmWVX1fKTGDPF13piesjCpB61zNiwM3I/vKRq4rpMYBYW1Fenj/3my
	77YNXafcjEOGmygAZcVRXry8imNM39lxHeqbH1FyJQqiDHXEdU1gtM+KVNHT97WgWthgd6/Wmof
	cnhQLZL2K3LrDvgTDhms/7HL88u6S5qKSGOBwoui9Xa8IoL7VStd9IdxbeaFS75/bBGhYZErTgj
	aJ+z225j237vq1izlq25p+Mipdc5aA/6stpbMyagF5lU9yTRshwE1
X-Google-Smtp-Source: AGHT+IFobeSqnmbUBNUK5N3Z6RnbXKgGRPhiEdaBCRGo2rpUCq2z1ZjchQMQ0dd2uRi1a1GL0TkZiA==
X-Received: by 2002:a05:600c:4745:b0:46d:cfc9:1d0f with SMTP id 5b1f17b1804b1-46fa9af30e5mr229761485e9.19.1760541366622;
        Wed, 15 Oct 2025 08:16:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9ef5:841b:1380:f197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101c0371csm32994155e9.7.2025.10.15.08.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:16:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: latch: remove unneeded include
Date: Wed, 15 Oct 2025 17:16:05 +0200
Message-ID: <20251015151605.71203-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver no longer uses any GPIOLIB internal symbols. We can drop the
gpiolib.h include.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-latch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-latch.c b/drivers/gpio/gpio-latch.c
index c64aaa896766..452a9ce61488 100644
--- a/drivers/gpio/gpio-latch.c
+++ b/drivers/gpio/gpio-latch.c
@@ -48,8 +48,6 @@
 #include <linux/property.h>
 #include <linux/delay.h>
 
-#include "gpiolib.h"
-
 struct gpio_latch_priv {
 	struct gpio_chip gc;
 	struct gpio_descs *clk_gpios;
-- 
2.48.1


