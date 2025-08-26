Return-Path: <linux-kernel+bounces-786421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08651B35996
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DA35E4E70
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42320341660;
	Tue, 26 Aug 2025 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="z+c8El79"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B56338F26
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202095; cv=none; b=ovV7FmDYYxL83Yp2XCaMAHpY6uVbcru3VGF4YuHJI96AsCXqZXQ9L0nxDGX9x2YML1UygbkQjzAnPAFJu8hBoW4QOkjwyJ/XlU3e8Xmf/XQejOy3yYp3FvIiqpBLJK48nQFv9Fngs6IeNnZwKn590XbEHazGpXh8mrdmwUVcOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202095; c=relaxed/simple;
	bh=5PrN4kXWgSkhbgdmlbmnuhGMZyU6jWrz60oOZarPmr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOeooeMMbsqkspspjb6Usz9E/gO2dFCffw/jqCk2C8Z7aqsp4rdd7QS+ehqzYQ99SCDI9Uz3qINdE93gt4eemDYWJWTdiyNhSBVTGXluHZJVHigstRWnQIOVaBj3cStWUKY26giZBlOja89JsKMDSgYsep1I5PwzZV1ETh4NkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=z+c8El79; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c6743a10e3so2191541f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756202090; x=1756806890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaRZ3orPuVdXJjVO7RddRtX98nkKU7skjLyME4PeVHk=;
        b=z+c8El79FvVytEi2Y+isBZboxl+N6Obfi0gSwNtkrwO+lfndYG+e4syCeOxdw6ZrcY
         1fgYBt9pCzU4yDeHCeC1dFJ5N7DmUskr5sqP0EYsawlJ6kXxwzcjozwlhwew7NNmDDPb
         UPHPHcQsMCPiojkKK1NGFVPS1njaVhZ6PzndqxxlLD7UHD/0DWsNbwBwVY1C7illdeRP
         HUDJrHHHxruHxab7IQB4FXGah6OLQnqxmrv1HI8A6MfQfKk0qNEJcdkndlPE/X/AzkvU
         3TCBa8FeO9P6p9yOtJdwnypFytZ/H6m2PGRqQaqCqvfky868YLEJtF/pmtHT8iCK48gd
         rkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756202090; x=1756806890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaRZ3orPuVdXJjVO7RddRtX98nkKU7skjLyME4PeVHk=;
        b=BcrxkW58iXYuwi/GufqrB6yjPIxRcHl3uvMVuhnbyILB81ZXsQlEGFovuUYN3Ruv2D
         r+2NcwofUqNzl5p8apDGlQrnjNl30aefjO0AMKC3an/qTtJMdfCsEs7z0Hy5kvLPsjJn
         LFHSkfy+naPQpYfYYKbQ2eCswWr7fnXU3slHQBy/eIdgJTWHLBABD6+AR8/59q3fMh2T
         S/AS1vBpdsIQUOQUpXErHxmLcmi76NLvT4nKTmAZyoWhdr6QmcA/2Bh+Ldgb/R4SwLSZ
         W5JfKhktW/bEx8WBVt8NcN/V9GN4iymjL4fbRPmZTRtSgGLKPLw9Hd7MZv7FS8oNjw1n
         EOvg==
X-Forwarded-Encrypted: i=1; AJvYcCVq4tYGnIHoonpdXXPGw5qccDDjJYErC8uBFbY3+V/BtPiCwGH/+3V0v6jGnM3UHp7W0SybENqngbB3gKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxGoYPL5+CKYqcoR4ZpQhjpomL6JQ+mZg8ZwjvVNYsjP8APVN
	JIYZMxt/USOApg8byl/uX7uskkrKFpBcrH30J50TdH7hc51st+dVTYF6RkCU/C5a/2o=
X-Gm-Gg: ASbGncvsFTF5+rUnwkV8BX7c71b3x5iUE228W7PlagMjoYdD0OIEdY0kTwuNjumUrAY
	LHThaA3FN2/VByW/k3oJT+XYDA2Pv77lWt6AuAQQd2i2NnSqCfSy9NJwhTg0sPaTJtQqUV6xRNJ
	meN9odanwFntoJqax6TVQzdwb2FGUJWht5PLN+kTi2C+yvSClEYPXtPFvQKMi6iYosaDpyfhMoq
	tKE5TcKtGz+4wa9sbMfNBb5K7CJ/QzSMDF7XAfawW98Pqmi542J7mo8f+uapkGRUvPDnN70E3x7
	nGj7xipZiwgfQOfvGPmD+EgdWKq/2KJiPu7m1fXenLGfnznC+eP96+HXHFiJp/Hopq25Qnjf4H3
	OViR/3lDmryaWYi95Uw==
X-Google-Smtp-Source: AGHT+IGn0GRxBvM+WD5O7v7/hNVOsDJAMieISnJTHVWyn0GlU/XBWButKenSU4mlUYhOne1RniJKdQ==
X-Received: by 2002:a05:6000:25ee:b0:3c7:44eb:dd77 with SMTP id ffacd0b85a97d-3c744ebe211mr9929433f8f.12.1756202090400;
        Tue, 26 Aug 2025 02:54:50 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5977sm15708447f8f.51.2025.08.26.02.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:54:50 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:54:40 +0200
Subject: [PATCH 6/6] gpio: xra1403: don't print out global GPIO numbers in
 debugfs callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-dbg-show-base-v1-6-7f27cd7f2256@linaro.org>
References: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
In-Reply-To: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=pqwEZ6klxsSv4inQWR27IXYKVls3Qm/tc/R/XY/nCmk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorYRhrRtwf1VkVEx/r9gY3Cm0Cya/2HLTxHfso
 Z84jtpt+hSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK2EYQAKCRARpy6gFHHX
 ctnOD/9TINMbHZubtrb6oT50/GRpHQJ063AdQj7zfSKZ59ymB2wM/mX8Pl1NkWFkEcxS9+JVk4Q
 lPCGUt2qfdhvXm5FVVMLwUbmtM9xF3GyeqiUrPPM80PrH0YhwCSOhpd8ghSm6QU6/mcbPNIAxnz
 iHZQDZsDHSgZhL6rcYIzKqG1T6MnBHYERna6eOUJvJflW6t1z+OV3LWM3rbImRGtgzgExtv7SLC
 30vj3gnkMzlCC3/9UutUGDNB1kPT2iIHcQlPVPX3NT2J2i9c4JjsPzRHKmOJ/tf23t6sF/WcQY8
 0K/+WFMJgJCYuA+BBeBvluPlLQadUddZSRNVLac8YMfZVbYS+GJgQvIH/51XCZKdmHV4LmsRxW8
 OWeFH5Gxi2NYcqQOuJm92rLshkHQtFYUp9EdF6UniY5jyq2cMRjDlptaZX5r3544iUHG5UFl/px
 k4HJTHxyqPdHLwJDjbPrvddnDgcVqx4s1Jqth/Bz+apACEuyHb6IQAX6QQMzRFNLyE9VSnUNa9C
 iFFiyE1jb5ZspnxT+439i1UlBmTqgbQv2KXU1/QCJAba6Xalc2I3GIjoFd3cmf0xgJ4uhW2RytJ
 GepfYgtLR5FAxX02LJpbPuWxSPU83zXmv7NVjSnrk/lHcncdZLC4mtHIwKf+gcVHuW31WpU23Na
 lZ8o9Gcmx7zGsjA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to further limit the number of references to the GPIO base
number stored in struct gpio_chip, replace the global GPIO numbers in
the output of debugfs callbacks by hardware offsets.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-xra1403.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-xra1403.c b/drivers/gpio/gpio-xra1403.c
index faadcb4b0b2df0744711b4a8d211adf71ce49a38..7f3c98f9f902013cb4f1c9109dab331609b28997 100644
--- a/drivers/gpio/gpio-xra1403.c
+++ b/drivers/gpio/gpio-xra1403.c
@@ -135,8 +135,7 @@ static void xra1403_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	gcr = value[XRA_GCR + 1] << 8 | value[XRA_GCR];
 	gsr = value[XRA_GSR + 1] << 8 | value[XRA_GSR];
 	for_each_requested_gpio(chip, i, label) {
-		seq_printf(s, " gpio-%-3d (%-12s) %s %s\n",
-			   chip->base + i, label,
+		seq_printf(s, " gpio-%-3d (%-12s) %s %s\n", i, label,
 			   (gcr & BIT(i)) ? "in" : "out",
 			   str_hi_lo(gsr & BIT(i)));
 	}

-- 
2.48.1


