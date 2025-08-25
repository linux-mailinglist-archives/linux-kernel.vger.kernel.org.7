Return-Path: <linux-kernel+bounces-784425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776BB33BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B307AFDD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE3B2D0C97;
	Mon, 25 Aug 2025 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="w+VgnMj3"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879331DDA09
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115334; cv=none; b=VU01hU1LzSvVr9F2k35FT0ggDTfmoqcWV1s7Xw30r5yJkueuL32C0k6BSrXL6GYdiRn+WgZqCqW72u65AVbBHeYMWmwSCs7htxK2QyVqcDU0q0dRb38EkGgGYR+ZiUIEJJcCfpjtxEdBeb8YaTfiGKPEd8lQ17igDKcj4vY8qQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115334; c=relaxed/simple;
	bh=weXYtvOJal0gfVKqkBOQyBy266M+SxjHRozHrgmLGEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddDOGzHWIV6I/fkeQhF+xf6iEH+9gJn2/yD5xJ3DOX/RHnUXHA+6g+OXSVazrkbnWZJ26B3Bw5O0xO/Ea++d2IKMvkbPKx3ikyLuI+PqP2sYPCQ+Dlgax+1x7yVOmhKrKBnFDwdcdHkDrqcDbUO4v5Y5Ll79Yi9qrW0ng3DZnUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=w+VgnMj3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c51f015a1cso1948861f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756115331; x=1756720131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpowzIaT1cDZkW3EQqK0abqv+liy/Ny1FTTw1g5xEZ4=;
        b=w+VgnMj3fcxH/OnWntMR+y5kK96i2FeCGoHda3nR3gZOe3mzaeLbCdxOFHBqAy7HtB
         U/+GHw13rUJw2Bo/Mx0llCdEq/Fp0NaumM0JustMcVH1HyWder9AchQVwMTpwJ3EW8qI
         +Bndk+LSxmryJkkOmX4og+M11bq7JqqOcVDg/4Bs33pO1/aZnrxmNNZvm6byj03VR9bP
         hBdnTqvMGC/Fx7NJNUH18XjbdrS+w8zxNeaDi1VYwNkO3pWL9UTtkAipA3c1ZEmEL8gW
         shiq81qkbzM32SDilgr5aGxOEKaXzFURYhLGeX1o6bPZPnYc3o/nqoPvr3LJKve5byK/
         x07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115331; x=1756720131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpowzIaT1cDZkW3EQqK0abqv+liy/Ny1FTTw1g5xEZ4=;
        b=V5mL7AxtD0Sg6HMrwYxWUB9fMKqC8kOfIw2pCgvaVPcStuQP9Ch/W8fgwjtJoVaHRc
         k1OfAasDrU9Xoo7yvy/YqxdMH8OT/3Dx3Ep8SMGowWyv1Z9GsCNRhvTmqTmQ0255N9OI
         u9DUJg9yeLr2Ys6nfm+n4IJxnrlsZpzBTsCjPFHlF+BOj2z3HpdjNI0mMcAXIK88zCu3
         y7T0WL6X9RhhqrN9YHGrVWzCpZRwVFHFheyhHIEGurR3gijOxdx2dhFe8USVFYhqxF/i
         zAF8F4FeObsu8cSg6UM2verperkcMnC/8STDSTbktphLC3GFyikr8IbY3wS2NIXiU7hD
         NNUA==
X-Forwarded-Encrypted: i=1; AJvYcCU6T+n6XwRyev/eWQzgL6jmSD+OAhl4CbJhW+mnyobjkVw5O0bMKSKw1YSzFBF0IpwvOu3tZm2T2Dz21IM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3X2CR3XhLR7UqQp48PKb0QUym2wG1ly2MN/B/eh8mVQLiuf4
	RHgSDGPGCojXY7jaNvtT/CIgvHM52TxIFR1fr4gD0jZx8gQiR7ID+loOkQzoc3w6b2E=
X-Gm-Gg: ASbGncvb+8CGMFRXJSHNGuIH63ync5u24tPmOIIj6GCUDAXMTSOTDL1pcAUdrYKDePA
	Tj5QK/f+62bJkxvZpa02eeHDcMYtMwY9+QiJTlMgIVKw6Y9AwkjvUzIyhLLgOu8+SCM+a8PPWt+
	nmNz/Zrkr0KkJl2yk7bCJrnLhgKNd2+w60AG2l68J2SJiDlZ5ZrloyVgDAiBMWf8a1tSmYG3gLJ
	bnW5vRWBpT4DlLU43jlzlIGMxD6XNZzHpVIYfLaNn63IBczaUvTfmgjIyNYbMv91Ojx8yqIxDL0
	UTO2PeWnrfzei2OnjC04zz51WpXsqWZBySG1C52xLPTKYEtvuFNPRwsNGYvr7bSrl8bMv5wdNpu
	KkLGeS6b79EtZn0N0p7PuCGQQIQzG
X-Google-Smtp-Source: AGHT+IHWTHIcMhEQ5HQdM6YoOeolJohMogAZDIPB52mBaKmxTUaFs5nkdQ77PxRV7ddsa+Y2+klbLw==
X-Received: by 2002:a05:6000:2b05:b0:3c9:9ec0:2057 with SMTP id ffacd0b85a97d-3c99ec03013mr1335028f8f.24.1756115330763;
        Mon, 25 Aug 2025 02:48:50 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef52:fc8d:34ad:9bfe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711bb1e3asm10877449f8f.57.2025.08.25.02.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:48:50 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 11:48:42 +0200
Subject: [PATCH RESEND 01/14] gpio: generic: provide to_gpio_generic_chip()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-gpio-mmio-gpio-conv-v1-1-356b4b1d5110@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=872;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=q7IZHV9NOU3n+seY+p1AeQbkCwKHTjI/3z6Qnen62yA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorDF9StIdV+XMb86jGojQYOxVC3O+FG2OF+hdT
 i78Cbu5/oCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaKwxfQAKCRARpy6gFHHX
 crWhEACncvMwkOcPwHAi9aj2OHDq7X5SHxv8s8KrRap+M2V0ErklcQNs1GLob7iWSimgg2QnjeB
 qtJybnFa0IOrpakdguy2J/Rxhl3L3bRl+U2GAabp/gyfdRTE3wV1D4LkuAD37BAfjJ81R8pgHXC
 XUFfK1yQRSp+7Rf1NANuInvx4GYMPqcTWz7Ju8wI1BJdh3R6oTSbcMb6F8+WsQ2QzwUCFYCU+0+
 5XUpZSuNCZ4VHHgLWO58F0hglpj1zAyoPi3lW5c84DCfxfcXRgjbZf68zuXrfIZxNaoE1PXDTK0
 n+nqj2mmgKePqI1V+75Gbv8zLR28FTK/0/EXyERUgxRGJbmHBceAXX2fzFJpvmxYN5Zks/a/8XJ
 g8g5QzjfPG+UnFnGrNSfTEX4gcmuqSCmNITY+3PkFxd3AlVL0NnR0y8ZGf2EEzOJbUZ/exvWBhK
 UM6ox13XeBAuBlYx7ru6QTnvaJNiuLG/6enWBUZusa9cNfbnFNMSEyRIa6o5c5Bfbu3btwMHdmg
 NtiwGbECS+2PceI3NfqmGBIo02UcLUakC3+B+ACRcFZY+Y12U0OK5vAwkEVEChYTsSypiSvxEJw
 cc3WaWYVAUWxYNcIIomXMJtQYPKiUDDGsW37GBu5UPlonio/jlUxf1/ZS2zK43DeordcubSJzBX
 lDY8PScKDVMc3LA==
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


