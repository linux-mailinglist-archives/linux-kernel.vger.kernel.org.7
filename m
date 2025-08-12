Return-Path: <linux-kernel+bounces-764490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F23AB223B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE06505144
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071625D8E8;
	Tue, 12 Aug 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GxfG4X95"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88AB2EA72D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992341; cv=none; b=kI4fGYnC3god05d1VFuHoQxQvrVV0hUt5BMjpZsKL2PP1QaYwFaHqARWXrsZSyez6QZBgGKQvBC/cXx/1dluKKISG3LrCPFOH7oRXLFU4bjEQitrcaNXp2+3bjgWxfJpX8Ue6FZVjXMI+rdsdSJn6yK4KMnOzY7I6ERQQE1tlP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992341; c=relaxed/simple;
	bh=weXYtvOJal0gfVKqkBOQyBy266M+SxjHRozHrgmLGEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3fQmuPmCaFe3cutAryndhNZWEE3VUCCMIx9s9zTxTuGM+deLamNBYS6s//eYKy1DHxv8VcNiArZ5yQup3H/oyPwYG3wAdI/K99djc73QMwSIfrryl6k9KrqUOBCzJfek8mtKe+a7vvF48/HXy0wwdo0M33Onulva1DgiJtaifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GxfG4X95; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b91325d79fso198028f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754992338; x=1755597138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpowzIaT1cDZkW3EQqK0abqv+liy/Ny1FTTw1g5xEZ4=;
        b=GxfG4X95Hk8shEG24aBKG6mb0hqK9C0n8HorxVjuQNG+4lzVJJTYYM9QfQSrP0tQLd
         v28pOaeTeSTHP9Mj2ajvUo+KG94zK/ArGE13U1vIZ38/jVJG+LrxvV6WQtwXh91vxX9N
         rnFvPrQT86+G9jRIojdgTGqzRl4I9BdPxosPky1NXkg6bbO+MxzgY3dwULx/Zdb9XfSO
         WsiF3eE/mdbdE8k6ejQh0IsHv1w2CxgFdYHbfYJ2am6S7o1o9nZR7CYDZqLChxDntKdE
         +MokUkMrjVeFMIai15rRpmm+cAWslQ65Z/4YrTK7YpDK1+OvmPrtSutgOrDMcBHDeYT1
         3dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992338; x=1755597138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpowzIaT1cDZkW3EQqK0abqv+liy/Ny1FTTw1g5xEZ4=;
        b=eRn7MaWoBO5c4ldd7MZmqjkIjQ1sgp6xpq+1qlyUvuJnMZF/UrW/boWV5zbMWppVlp
         DpSn4ipCp7+I3L4xCE2uJttuWvtz129R7cwfPSq9c3f//STKNKcBxN2YSy5WCk8yoUMZ
         reweQ75snZ3KJJnH3+3V6ElEbuazf9F0/k2BR51sNL9wHuMEr38ClRouqTV8bp5x4GL2
         Ox7QwBwV3PF7ogzeA1XIHCVWsNbBijesterKpJQKEcr+Cp8qtQeBf2vYi3DftHSI82ey
         QIxqeJ3e3Orf9BR+VsbSFE8Bnx4cZvJ99V6TB16P7IuJEqd39UKq1P7MJTTS58TeHr8I
         F/JA==
X-Forwarded-Encrypted: i=1; AJvYcCW/kdaAoZfsQf/v5wo/xCkgE4e0ErWk3qfgjYpgpNmN7E5MlXpCn7oRGK0B+ZR5gVBWdkB1505BEFEDU2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKgT4nVb3TKTR79hm/WywfEBr8XeR6lo7XOIat/1ryaGcRrpvk
	Fjc7PuIyD702KckB4l39Fwf9pMhPsmqQWl41Oo+ZANgkzVZEEc0Fl+4inA7MuLKI2c8=
X-Gm-Gg: ASbGncshxjTcYvwN2CxYb8F5MMzT7UrvlsVLho9q3Fu/VPqR627QIn5IqJrVMVZ35zJ
	S5b7i1Bf+9+wZ2ZGCfqPJtDPL2hYEtB8N+ZZjQPOql4nCfHuCh0GULAPTNCKEwjWKum/TEp8qZ9
	k/1CzqEk5HPvf1RmJmoT8dkuGglQpYe4baRE+TN+uxogzM6rxWsEE0Z820Yd00rPOITxeNJfOJ8
	bFu79RHi1TjVVl5cptwC5mfdkHx+d2zlyu9xj70jJI0S7sgFGJzkdjfvYUVM5RdW4yGi8D8tWAW
	s1lxvExMB+HvQxpjvabgLuYpuOjsieYWwpeq3YYC9MfbZYySPeuuw9DOePQhWw68qwKTToB3t7G
	iIyUS9vko+Bix/gk=
X-Google-Smtp-Source: AGHT+IEDkb2zYaOQh3qOMcQ7k9tD4E03pa0Qq/HtC6R2/6gV+8zZkb6gglZn1kajQMc54hiPXB8tLg==
X-Received: by 2002:a05:6000:381:b0:3b8:893f:a17d with SMTP id ffacd0b85a97d-3b91100f0a1mr2413378f8f.49.1754992338055;
        Tue, 12 Aug 2025 02:52:18 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587e154sm312580295e9.27.2025.08.12.02.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:52:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 11:51:58 +0200
Subject: [PATCH 01/14] gpio: generic: provide to_gpio_generic_chip()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-1-9f43e95dea98@linaro.org>
References: <20250812-gpio-mmio-gpio-conv-v1-0-9f43e95dea98@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-0-9f43e95dea98@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=872;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=q7IZHV9NOU3n+seY+p1AeQbkCwKHTjI/3z6Qnen62yA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomw7F6b/sc3xyJ9g01VwsG5+SMMxU9DyL9YZqI
 VZzjg+ppbiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsOxQAKCRARpy6gFHHX
 cp7xD/9OaD6zx8qjk4ksBh1Tv9mnlo8kv37xfmX8Jlr72gj0e1Vnv85wGsZx5aOIosq52KdJmfh
 5P3ZIzyWm1BD7s0FIJiqruiIU5+AHeA23FQVWIFB+DDqXcFGaenms/cityggjNSL9JzLdFLMZ5I
 rY4C2MeUvpy6erMNED2GRhLvehwwvno9P01KxHqw7YJGkn+hYkET7YZbmp7okNxIUtcUmS8cALS
 x10LykGNyEX6Kt0AeCyj+VaFTCtAD1Hr+yoP2EpAQmo6PKMrQO0vIlM68rv7mAd5LyL6TiA1XZ5
 yJ/l+zKY+tmOZiUTcakNlFccF8qlqPCa9CiBjjoQ5QcT7H6RX3EPzYzlq7RcSA4CJV/bhPls8i4
 MYp+qqty3toPkf5rsiWBOMQRk8Ma92Tow0U33eNjUhz/nbwAq4zra2A6/e8k3eOZ3bmvPIk0fzl
 fjdAZMmX8Sx6Sf9rpZmcYnxAkoWh/7Gs72mq+TTLy5PGVUUFPljdug8wr0XklE/6VviOIhFNRON
 EQbsn13LaAFgcEfk2vxkWbdu/PsKG8JhJkEwM9EafQaklDSZLEWIQQyBIKNU6kP86Jpa1cDvChI
 0QbwJcLjkLpTO1asQ4eiUnwBTbExico5+jZwkVslMW1qzcxdNblPm/nVJI+P4IW9kl/fo+yQ9sp
 uC7NZ1+J+aFd/IQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide a helper allowing to convert a struct gpio_chip address to the
struct gpio_generic_chip that wraps it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/generic.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/gpio/generic.h b/include/linux/gpio/generic.h
index f3a8db4598bb59f1dba4fbebace24dc10be44ae4..5a85ecbef8d234d9cf0c2f1db7a97f5f3781b2e4 100644
--- a/include/linux/gpio/generic.h
+++ b/include/linux/gpio/generic.h
@@ -55,6 +55,12 @@ struct gpio_generic_chip {
 	struct gpio_chip gc;
 };
 
+static inline struct gpio_generic_chip *
+to_gpio_generic_chip(struct gpio_chip *gc)
+{
+	return container_of(gc, struct gpio_generic_chip, gc);
+}
+
 /**
  * gpio_generic_chip_init() - Initialize a generic GPIO chip.
  * @chip: Generic GPIO chip to set up.

-- 
2.48.1


