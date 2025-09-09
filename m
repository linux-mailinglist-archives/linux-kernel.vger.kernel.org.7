Return-Path: <linux-kernel+bounces-807668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8669B4A794
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510DD165C57
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E143C3090DF;
	Tue,  9 Sep 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cGuyF7Nw"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1C306B27
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409357; cv=none; b=UHyvkhIcPxp24CvcdWto+oE0fFWxmk8PIWcvCzDq3Gg+H1drLRGmr3Qdg0ertGA1K2B+OIbpcSQwWGXfN8+16EScu0XQ9OJyq6ud30fyRQU6bq0KpOAsPDl3nRHwngIjES+LSiUnK3Um9kUpdFCEM1oNlQr7UQDnCqkohSxz/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409357; c=relaxed/simple;
	bh=yVgPPOcE+ewclBktjz5E2v2YtjZnxTx9c2rSBG/L3iY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1dh9VOfnPUo3TkuNkI556iEfoJR29zSqVwYGEBO4d5fUEc+TdZpPnJUrWeYZOarplSAe3LKyEPWjINNfUfqRCUKYFoo6zTTl8CWKkBDOkKH9cUqaXYDpB3ZsDdhoiaizLLD91yWRmg0Pq98QU1vvUO9TDzuwcmE0j0Ong4z/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cGuyF7Nw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso2264545e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757409354; x=1758014154; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHR8kEAINHQx8cEJdNb56gXGfX3p65LuAbViPfkkq1g=;
        b=cGuyF7Nw+OiZsJoZm6af6wDLnN7mXyVnETWwWmOAWY26y0dCBnG3Qbf2wVhca/r9hp
         l/evGoLW0OAm1SUwN9DQ56rwW5AvGme5YHsBI5TktP/VGOmCmdW0J4ms0qTzaElSJ9jJ
         dl4DR121ZpmZ2NhGjGJIlQJqrtoeBihedFm1kh8iUUgkph9eZ+0fefspSkIaeRfE/z5m
         M+vA8/k75kzlI5Iug2ZDvJL8nc95vfod8f0PyYU7HJEZNSqvld1IimbxWwtV2anPTIJL
         pNBB6gV5aLm+xANlIUnlg4mS97izS0MZKjjWmhftYB1U9HhG79fknof+66S1Kjdk7W8w
         wjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409354; x=1758014154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHR8kEAINHQx8cEJdNb56gXGfX3p65LuAbViPfkkq1g=;
        b=gp+6Azb91DZ75wEjCxMu7zQdgVARLC/SwqYDtJQ9E9rVjCa5eQOJLnvhwDZv9SnC3t
         iKDbfUXEK0+/WpMauyuxcP02cdfLgC2sAApT6Jny0aR+SZKZmKrsQoCoGNdqcCwarkN5
         HmC30II9EFmnGoLs6VXZCpqHwEeBJC9CFdVKn3X3jmsQtXeKib/PCJAI8DlMTKWnfS3U
         XAkigOQ14VYnG/aj014DupHm1DV6OVuFBFjR7C1v/N6yQD0imGpLb077/cF5ln6ibRDO
         lXUEAyI0rDWfinm709EYAjOgQnMTcPWh5jBszKv36cKS+LxUhPNh6FDcsNH2QBXNWTWu
         RNtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEw/myv0HqzNhq38yB2a95EqtawijQ9vyI1rYhWBjjLlmORdJck+JH4MoJa206DfbxI8C8i7vT2G38HfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4WIEv03qjNPU5OicsD+A+xNN0rtljgh9N/Pe8Dt+64BYCTOw
	6qcC0znwWlrq9oOzrcqrJlLr06m9iOYEPFGQofk4WH1vMlPtmxzPB+CqrGt0QIftQcY=
X-Gm-Gg: ASbGncuM++03B/MJwo8lUHeb4u0JBCpidYUt8G+CTRfIXebHQfh8GqzIXGo7/Gfp38L
	T7+6cWj1kw0LYukLucypzGvC7Wh/lmyS5wqYMpews12sn6V3Y6mV3tZy3gnmOT6Cmb2O8X0itDq
	XnoLroVTvLYa4l4bhQMpumuQp1v84VckP2jIYCydU38Z+iVGSbkV1yGBUAtItc+nVlV8L3Op7p5
	8dEIpQNRK9dI4PQH/dnSGgY0GJorwFiOayAy6rpUKR6Q8qiapFU4Y20AD3EP5GtQ8FwiuX/Sfqx
	mY+rwe85fGRkirvWAoZzJZWDaxcr1WKuDYqIVvjKf5gryL0o8XS7J8sMvDXjUEfKvqV3WR25n1g
	kE2WID8MMGj0IWO25vbNV4tdcFRJT
X-Google-Smtp-Source: AGHT+IHhcgO6dwZxJtkrv/4cgFJ9AZZjVhBwJVC7OCJoGvWxqWltiwPbbtdGBypNoYfTrgC0pMDsDA==
X-Received: by 2002:a05:600c:4f47:b0:45d:d903:beea with SMTP id 5b1f17b1804b1-45dec7992demr29926925e9.30.1757409353851;
        Tue, 09 Sep 2025 02:15:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c1ee:7be9:3ebb:6cc0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9caasm1900039f8f.19.2025.09.09.02.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:15:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 09 Sep 2025 11:15:33 +0200
Subject: [PATCH 06/15] gpio: xgene-sb: use generic GPIO chip register read
 and write APIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gpio-mmio-gpio-conv-part4-v1-6-9f723dc3524a@linaro.org>
References: <20250909-gpio-mmio-gpio-conv-part4-v1-0-9f723dc3524a@linaro.org>
In-Reply-To: <20250909-gpio-mmio-gpio-conv-part4-v1-0-9f723dc3524a@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Keguang Zhang <keguang.zhang@gmail.com>, Alban Bedel <albeu@free.fr>, 
 Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Samuel Holland <samuel.holland@sifive.com>, Yixun Lan <dlan@gentoo.org>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=We0X7xb7ACmLY+lbQa1fcNw6pP25NDN5z92R8VM93TU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBov/A4pQZLBZn4BjfERAi0jFAen5It67lNNEGX4
 28/FwbaFj+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaL/wOAAKCRARpy6gFHHX
 cppTD/4ubzT5gkUPHClRcXZW7nUjOwMKszigAjd07nNOb4PF0UpVU/Xa7EnK+Syz6p0XN914Vg1
 dMG2j9qlrjrNzhrbPetN/pzgg0RJ5FtkBeCt0QXzTIM/a+OIXPh7USmz0K2fiNPTPV2j9/afS9Q
 o1uvp7fh5vygt/dxzTY3GXRvzvAvlXF7Nj7cXXbufdr+leL6pNp9oAtHKmepILW5EXpYFjMoStH
 jbkjAo0gaQWdhdfr3K7hUFVirfvRgS3xp/s0PuStezskzt2soyUXvzAk68x1n1aoTsHvj8e18/M
 ELZsqbHx5BzbZXplavqjtoWHWaIHPaZGUK5I96znEf7RNJcznFDPSn3z2hemiZlD5j5zjVbaiQJ
 e7fMVvjPH1WvX60+a5oopYA1ZIZjLNqd31TgZltatr7zdX2BQbFJRQo8bHngbWak1gQiVh/7Cex
 zwXws2yfiUCjol1anGcqyeNvCPSA0b+vzKTlM9Yg+31ZHNGWeisiXTVtlVO8mxr5JdJg8IXJFhE
 HIN1TnCnnyCKDjmqRucW6M/Sj4KBGnUNgwFtA+dnhk1DDyvACq73VpW4OXZUPBsKF9uHpEHvW0M
 ymUv6nH3ayojO3TG4dtSPtFoY2Y4aol+CHE8v2IqHm74wWbdOuT7cdf+yMxDJ/DCtZs3ND+cIUd
 3eWJFcmxF3LRACg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The conversion to using the modernized generic GPIO chip API was
incomplete without also converting the direct calls to write/read_reg()
callbacks. Use the provided wrappers from linux/gpio/generic.h.

Fixes: 38d98a822c14 ("gpio: xgene-sb: use new generic GPIO chip API")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-xgene-sb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index c559a89aadf7a77bd9cce7e5a7d4a2b241307812..62545e358b6c4b1cab25e1135cb24ccc3e955078 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -63,14 +63,15 @@ struct xgene_gpio_sb {
 static void xgene_gpio_set_bit(struct gpio_chip *gc,
 				void __iomem *reg, u32 gpio, int val)
 {
+	struct gpio_generic_chip *chip = to_gpio_generic_chip(gc);
 	u32 data;
 
-	data = gc->read_reg(reg);
+	data = gpio_generic_read_reg(chip, reg);
 	if (val)
 		data |= GPIO_MASK(gpio);
 	else
 		data &= ~GPIO_MASK(gpio);
-	gc->write_reg(reg, data);
+	gpio_generic_write_reg(chip, reg, data);
 }
 
 static int xgene_gpio_sb_irq_set_type(struct irq_data *d, unsigned int type)

-- 
2.48.1


