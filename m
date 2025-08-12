Return-Path: <linux-kernel+bounces-764718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7945FB2267C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA6D427B40
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE6D2EFDA3;
	Tue, 12 Aug 2025 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m0HJMO5L"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C252EF66B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000775; cv=none; b=SF/fqVF8QPBsW5mTkuF9ngI/KWvZgDKP1bzPudgYqD7GxyQfgiznfUY8WNd94rWu4PAJu24KCo922T0h69ZqvADchj6O9Zh41f/DxzfzWV+c5Y8zUAqLS+ZQBgj5gbSItgoFgwtWkgwohCRZ9ghRR7T98//zJwc6jEJs+4GUE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000775; c=relaxed/simple;
	bh=weXYtvOJal0gfVKqkBOQyBy266M+SxjHRozHrgmLGEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2aWDs2O19/UY7FFq+ruNhG3AL2rAyC0aq/1koTT/qt7BlB090adh8AfYBlXSwvW5ujiakhHDnl0AUcgnJQ7rSltgJodDJhcIshKUk6epRhlYKAsj9hFg0KreV0TSk5Tp7FfeNaeJH2E4U3sfY2zcakTwXFqRWpxV2+mqEbE7kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m0HJMO5L; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b78294a233so4585492f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755000772; x=1755605572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpowzIaT1cDZkW3EQqK0abqv+liy/Ny1FTTw1g5xEZ4=;
        b=m0HJMO5LqUuYUSGZZiEWrzj84Uw3NHcfPPoS1Nev0iodKPZrrpyZwP3S2wo31XOJT5
         edBPZwCU30TnspOx1BekZg2/DyE/gfoLGBkEsuMk8pH3VS6/nN1tK0mqc2KJLe1Rk9f9
         1n4suKMELg0INlZHT3mjJW6OmbUpJ+2PRZVonlvQ0YXzrKjKegWdemYL2QgTQ+QeBzy0
         zr5L6xBlTtrsEodTjs6VOSKO7ZSIBm8p9e/vZMrhWZS+8CFmNXOnNCJUzGdLvSdK5KIh
         rLySA6CQ9+GargqL5fw5uiqyRQJmsEUOJtZU7jrcm+2GBIxhImnnsf8kKPiuE7xzlrPM
         3JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000772; x=1755605572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpowzIaT1cDZkW3EQqK0abqv+liy/Ny1FTTw1g5xEZ4=;
        b=G67tsKg6pU3tghKOrXR9VPAmd0jhTL2OH1amp8WFZAd4suv1DeOJCffgXuDUZfjADA
         tGyS0oRlUM5sebZh+TQ1CNyeTleH1Wc71fkRr8zwmQ5yRgI0latq1pcLMSxUvBCnr8FJ
         qIxzyCE2GhuVFu1mAc9VeGQw3yygsYtrcp8Ln1wmN9S0nHmPR1mhLms/HKn70Y7zqesO
         ou0W2lM/PqFxrwWEAa0c8IF6rI36NdiUnv0Q+aETNVL4bOKM1LjI1JJr814F5sFC/u+V
         +OcFTuih2QBrWsEj99snakAbHQnz2iiTP8XOJ3ZtlCQIrdla0pzvredHLoWgzpdETLAl
         fH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPMEWrlz55r22YbagLXJdQntRy4JLrJNIMflSlsfHSuqq+3Bc2KieLF14D6uqh1K+Z2pQHoGDJO3xj4Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFsb65R0IX3a5DsxX/qtnzB0LPt+eNFlLjTPsEttgcqzcT0xh
	B99S6pvyqUqXeUzkEuqte7jXVr3inpJcpvptlVCGa5OTYKEoJzwxv1srZjYDTErWqjo=
X-Gm-Gg: ASbGncu98UlMfd/TGnB7tIG6PEOaHsEz0ADPdRXHeCHLqSMIkYDijE7AHtklvYmtCkO
	gk6YkNHql/0M2BtUUMaFDJtQS8YY1pPQHLlPbpAQxmOwflI5dDCDvqIa7q9aWd7CfOOgMGHux8c
	Y4l7V4z3yZVFw8NB+70tx7DnpVmr+EmT4yOiwPJ00fIrLF7NnOKVZVESTXCOybwpFDUgo2NliME
	soyxIkYDmH4Ole2yGFM/7dupFp5V7QFf0yPsHbnaQR9Zfc6VJrjBprZlv8ZexnWjrFie2l9wRS4
	owbRuSYSedm51w6hPVy+B0hpeghvH9vtxqJfjAxOJIt1Tdj8nhBV4qErzVrFjptokF/glSmkj2t
	tNf3326qxtL5+4N4=
X-Google-Smtp-Source: AGHT+IGenwtiWKA5m6N8X/17L8Igizzs58tEqhGQ2i43V54n+juzpwGprI0kz/fD8dVQkyyLD0TJFg==
X-Received: by 2002:a05:6000:24c3:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3b91100cd3cmr2802046f8f.46.1755000772287;
        Tue, 12 Aug 2025 05:12:52 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm298878535e9.6.2025.08.12.05.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:12:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 14:12:43 +0200
Subject: [PATCH RESEND 01/14] gpio: generic: provide to_gpio_generic_chip()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-1-aac41d656979@linaro.org>
References: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
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
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomy+/aTeDVPsPxVXdZxmvSFa4YrDThEqevhSwe
 PgxEtRX6SmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsvvwAKCRARpy6gFHHX
 cpyZEACY+tGiTQH3CofyMRCLnRX+JHMRcdsWX3t08rZbJGpX+q5SIOH1+vjwwHSzbbRFgNtb6Az
 yS+Q88S1hUF+Zn42rihC14JaL1n8HPjULnJU9+EmpHxNSdphHWoCyaSDY4lDSZrSgwHxeGLwwCa
 zQ0itokAPCVZnoSTc90/PSQ3wz4OQ4yaC15rrBwVJv+0/uNrSedOx7le8Ch+Yerr/7u5hAfqDw2
 Wh54zE77WdXhVGDPBTOy1tkw0XZ6RxtMrZXc+wPBByD9mPQuTTL/P3DWmU60UyjMf8wKxi8SAxf
 5D4z5myqGCbw/ADv0LvErruoYZD4C8f3qcPRCCA5zCxF5lPfTyNfju8gLEybrLstkErCkmGDIqt
 OU/eZQAaqAR1oGPF1UUkbyopU3fFMvWH9i3xqovxOMrYyhemN/uk2hy/Jxc6W9bqAzNQ6deuXBB
 YUIgDP68wx6qnXpSji2UBHXsbKGMH1cILjqHO52qsG2MenCZR8P3lnDRoiaLxAZnWQg53oWicqb
 ZlyhFECViH2I5yNjFkAa0C15bwra8/mZaOAyQi5JkduX5MzK3I8E8YKdgXGXSmXVtujLjmpgJrj
 Tbqt9+l3+QY7igcmOQXGyFKExVahGcfO78xW0TuCLsdk1OVQEsylXtch3WyKNnZfBcOegTHVRJo
 GraLgXcIK7/LeTQ==
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


