Return-Path: <linux-kernel+bounces-784426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D9CB33B95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1CE486D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B2A2C0F7E;
	Mon, 25 Aug 2025 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nJU+lUk6"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A372D0626
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115335; cv=none; b=Sf3OqgvUj1KTe04FBqtEWyD9gs8f/8a+IiFWljqZcNMKVwwnqzdkG/d1IfOiYKpQ2RUpS3U2MO+I29Q4oaQe7BimQ7vDjPbnmsd2SkH6qZEfV6BwGaQT/WxXtn+VwkRQtnMoDNt9VJV9VfnzJFu+CL9ubZXuM/hM1DeYA0nn1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115335; c=relaxed/simple;
	bh=vkpZBLTpaIui+7bJpSkDPzFmEy+B6nYwKDayQOON0kA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJgGIrftjmha6v+PqkhTgJMeIlY6O91q5fRK8t1/r17epVqpwz1N0Q2zO/cJ9zBAtQGlOYkbVa0QqbKzw+1aBV9L/qvHJiiDb3Ubt2wgi4An8pR4vzAILghNQQgntaPOkZta+uh9CO8x2vYspt/Db2vCOVwys3dtAT971kEtpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nJU+lUk6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso21203975e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756115332; x=1756720132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knHQSjIWdfCUEPeYoPW7hFKkqoSdgZ12PWpZI20C2uk=;
        b=nJU+lUk6WynTiAulmF0P5MIfRSrg51Uurd6gjMc0DBe0rH2q0SDJny7taMVHdJ/gFI
         AEw6q2GvqvqwvsA55JFCP758dTLBLJRyeqTVYj9zZntYwy9zCWkzM3f3llbqiKm/zR1T
         eN2nbQFuVFfEPSvwOcZSJZwG3NW9uvJJhc0Ce29wdjORcHwguKycvhx62Ygq4Z7xFNm9
         6VMzP4dGu3TxIQrMSpuVNa9eVPf6MOLAXxpvW7I3N6o9stpVWkjsYDE6tgLZMxvQvYql
         oV5MIjJU6iziTNyDz9Eb7kEZeUpvdWyrTVVasmmnJmTkS25SYy1INNTsHvBOeVkSRPPF
         Ssug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115332; x=1756720132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knHQSjIWdfCUEPeYoPW7hFKkqoSdgZ12PWpZI20C2uk=;
        b=qbS78HqR6x90HveAnFUjNzCb6A3zDLaPEkukxv4Tl35hD/wsehl/MPWtGWn7iEEbC/
         S77tnlaCLEorHmWscUZOd7lt92nQxa9w6aNGZ8+rDOXmlmKD173v5By7tjIIM7XfFKD7
         xiwielmYXnr9GtXm0aAIgVcJO3SvffTV6UcgZko+RGH7SduJ/h1Y/YEV83SmGUf+TLnR
         8cf1WN0AX4K2yomzRlG6Kh9zI28jKHSFw0LM8UoOfAbV/HcJ1z7M0/FHz0TpwY6O3a82
         cbXEVPkWoWib0s3RJ+K5y8jrY1ZYx20q1nUPf425WGprsQEJvzqabpvPp1ZWyrzL3CDE
         3mGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0juT6/dbIzCFxdtMCkRvqzj1ofIyFqrVf+kn8JVJqiuUst1qhjye618zljpboXX3JWX1aQgbTektCgFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBKQNc42XQgDFbCmqLWXe2dIinsSeeSMQyHMG5/7AALccpfAhU
	4OOBHINbwFQFXnV/qUtwgKMSopp4oWX1l7OwV2gOFRvGOhl/IvM5iagg23tC+IS73yo=
X-Gm-Gg: ASbGncutECSEqa2wpnNrvQln3h6HQTyPLQwfKO5/OYHc1xteTI3A3H9gVMvbzm/xf2d
	UeT6pb0IN2o+3dFkPY5geOSInOvmEin4l98LsooApH9UUl1rn/KjdDCNj42dPNfVGxCPCZ6j2hM
	XxwMGR4H1DT9JCvh4193UwSFJiJTQnKIPiMHQE6HFdip3FEJwFBXuPVk/jL4LtwjFiF9e20Zg5X
	ukYTXehra+E0AauBHoq6xjDEJK8J+cQMOOSIjkxU5/UnR2JXlX/kw+cmSPH1MiRNfK0tORshQVW
	HtQSZkf9LmmGEALfEWBAwkOIc4Gg4mQO8btTkadjXOJ/NFi2w7ALxjRmRyQnJY154jNLCPIoAO+
	+rcwg7DBb9jLbUwX0fA==
X-Google-Smtp-Source: AGHT+IErwpn4wYmB5jWccKig8AZtnAMXECNBpK7ppyejcQJbbvls81o2Gjjr0DQ/5R6ReudO+l7A1g==
X-Received: by 2002:a05:600c:8b55:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-45b54b21175mr93803705e9.9.1756115331853;
        Mon, 25 Aug 2025 02:48:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef52:fc8d:34ad:9bfe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711bb1e3asm10877449f8f.57.2025.08.25.02.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:48:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 11:48:43 +0200
Subject: [PATCH RESEND 02/14] gpio: generic: provide helpers for reading
 and writing registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-gpio-mmio-gpio-conv-v1-2-356b4b1d5110@linaro.org>
References: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
In-Reply-To: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=OZyZWSGy8uPs2UaDZUWXQTJ09CV/XrDYoRGt1dr0Y80=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorDF9HIhZW6BvlmVuXoPopEENCwXIxMLWctX64
 fTuynaHZbCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaKwxfQAKCRARpy6gFHHX
 cp6zEADBIpzlbLlGa3I1SdfKLKbDta+9JyIZmdQVLH2mg/LNCF3YbcK7N0mgsnw43q1025et3av
 XaqJK6ibXMqtva6QKx/z75U+yaEpyhwnaux/B8j5HHpRyLw48PQJttWNqRcyP71qcfJ2FhDphQh
 4cnxQ9aGm8RkciEgxizFghS1f5BTqXruI6MSTByi4cwe4KhbwKsGAbC4G860vkkiPmIWc2PxaIm
 HGYdALZjgUCHAsoyF1+1eh+4mZJhYgKlLI2Xkt4lv4BSLhEKphBquzql77PjRVAs14euy9DvPJ2
 Ax71OechHRIFXG6y9b0oJCpurOwo0qT5/VG78lOFbB9L0scZtAYlzqqF3mjNyU3+BDHqKhN/Hla
 ttWDVJ40ELpeFmo1oWpTm/Aq3j3VBw0ZDH+WCPwfu+J5tpVV3QPXjGweYxfrKFjhn9qQPZHhOmx
 zdTi+vMitZGd0nwY0Ar8ra36TepQFKD1sT7U20KG1YlXc4rENwZfow0x35suq+TUsUYr+vB4M7t
 dMGCWuAFqyBah+9PO8x3qZJfFNDe3YIwOzbFf1rHZmQPp/UohxtdxkHIQxGE6DcuJs6VH28B7EL
 brDe1BxthAdC6j2rcK8o8b5Grf2aLJWcEPQLqn9hC7w/Mpj8noMauYy3lFNHDLZy53gYjJzdFES
 fjcFitr2B/rR2nw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide helpers wrapping the read_reg() and write_reg() callbacks of the
generic GPIO API that are called directly by many users. This is done to
hide their implementation ahead of moving them into the separate generic
GPIO struct.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/generic.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/gpio/generic.h b/include/linux/gpio/generic.h
index 5a85ecbef8d234d9cf0c2f1db7a97f5f3781b2e4..4c0626b53ec90388a034bc7797eefa53e7ea064e 100644
--- a/include/linux/gpio/generic.h
+++ b/include/linux/gpio/generic.h
@@ -100,6 +100,37 @@ gpio_generic_chip_set(struct gpio_generic_chip *chip, unsigned int offset,
 	return chip->gc.set(&chip->gc, offset, value);
 }
 
+/**
+ * gpio_generic_read_reg() - Read a register using the underlying callback.
+ * @chip: Generic GPIO chip to use.
+ * @reg: Register to read.
+ *
+ * Returns: value read from register.
+ */
+static inline unsigned long
+gpio_generic_read_reg(struct gpio_generic_chip *chip, void __iomem *reg)
+{
+	if (WARN_ON(!chip->gc.read_reg))
+		return 0;
+
+	return chip->gc.read_reg(reg);
+}
+
+/**
+ * gpio_generic_write_reg() - Write a register using the underlying callback.
+ * @chip: Generic GPIO chip to use.
+ * @reg: Register to write to.
+ * @val: New value to write.
+ */
+static inline void gpio_generic_write_reg(struct gpio_generic_chip *chip,
+					  void __iomem *reg, unsigned long val)
+{
+	if (WARN_ON(!chip->gc.write_reg))
+		return;
+
+	chip->gc.write_reg(reg, val);
+}
+
 #define gpio_generic_chip_lock(gen_gc) \
 	raw_spin_lock(&(gen_gc)->gc.bgpio_lock)
 

-- 
2.48.1


