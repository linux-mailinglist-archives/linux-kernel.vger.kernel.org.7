Return-Path: <linux-kernel+bounces-788336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D37DB38314
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525A1461DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FC4350D71;
	Wed, 27 Aug 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROQyeSXt"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F57D34F463
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299458; cv=none; b=h8171DNkJouyJBrAUBcQhB1NhZYKlmCQJfEKmfV+cfF/7V3qd0dQu2ZDatI1yIyEmXWhNbNYKDTR3n4GPDbo+Se4dYkpSeyjUZBuWvxn/W88k46KmjR6/IcjE8XiEA3UlFjsveoxJu6fbpwCDO+Kde/g6+d5KoUFcByw3VvFt0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299458; c=relaxed/simple;
	bh=IVQvp15wfNkLgDcY12BQoE0NmPQxYuWThoUBl1tUWxk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RLNnNFUQMAo84HCE5Z4cvfH77g7cFE6vGr3OOXyuuaRq9UqB17zxbDfB9AjQvCkeCIoA1nz/0aROA8CidXtyozVSZqtMahx80oJ3VZX6BHvrvmKALTycl5ujgiBuKOVp4yMt1nnLKGsNP97hwr403IijQUs4z+HU+fYr2jCK3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ROQyeSXt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso51191265e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756299455; x=1756904255; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qt3k+9WJ1vxtDbvUOLITs++A80wdPJ5qfZ84mPyZtBY=;
        b=ROQyeSXtvrK2+APnbNXPM9OoO40s261Y6zCB6D/C1eUzr65UiWGuXZigWKEIRkTvMu
         GRgHf/XjogakwKg8yibhQ93RK39QlTPPbUBzYX5+AhDwZuIhOimp/uMX/WutvlWjwuBx
         YnGLl2VgIarMF3cLK14XBa1SYAHceY9z2uUSGpns4AlIBrBDRYtS3ywl9Ls/GwK59aQi
         ujLD7mArJRFf2k33dQ1d2dYKo9EblTQ7EpUJAJq/pYA4LTp4Y+Mmds9nfQRbNMKX0KCU
         D2Co7zLlRVAC5ZFQ6wXkG5LyF6Ml09FtyZM/KdjzeRV+RHLamKz2am4AUu4Nxe1m25Pi
         G1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299455; x=1756904255;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qt3k+9WJ1vxtDbvUOLITs++A80wdPJ5qfZ84mPyZtBY=;
        b=sKL3hozafB6NiD0WaRDkLA4zg6nCUCRhczxwAdHBLN5UDdFFNKS1HEy9X9oZ+wGu3e
         NtIT1cc23u86mRjJup9WqAaElVP4xDV9RyBk2KMAjK/iwi7U1K7k6hu3BpiXlAZzazmh
         uBR1qiquD4bovGG7o+/nsQ/ELp5b9FIBDCSKwDyEc+ybYJmGOU9CBJ00e20ohtN3MZss
         lyIVnJ5uPrb3ea06t8EH7/85Hpa1KczOxrme6BGc8i0i/J9gIZnIPFid0d+4JfzeO0fq
         rN/EaTQy3sliXtpr/JtCmN6lkmdgaUjnkBuwKKibhczZZG/kOtSMM5d0uPm9d8W8vI60
         2T9w==
X-Forwarded-Encrypted: i=1; AJvYcCWKXOZ3nV66WOgqZTqgfJtWI8CnNSPMbFIHxJJUHooHiyftpFjfEQy3FmzzaYSuyGLpExQQOtw5yaXGFak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyceew5gzR49goil55p2tW8IVh8VkKuQrgGVpe2SYt9nk3lm+rt
	Acot82XqkHYcoTHEYE4/lGcuE6TZYsV6ayukErL4BiGK9HVe8EMiCnkMDRm6ZfBgEQA=
X-Gm-Gg: ASbGncs/GL2CgSnugkDQNYh4nRXPXyJnY1Lu2vDTuqqJItARn816S4owq6f82MCemui
	CwqFJTZtRNEka22xfvSHhv+mDDrOF2rfYgiDBMyfmfKd/7WPj0iQvTf+b8ZqWyGTZ7eVF9KlGGL
	7LLM2QjZEXsznfW0tu2dBi22BpfnT4xVIPWxrWXVD+62PNo7CYf2l2ANG2nmDp1w0dHu4oNGxYT
	ez8L+nn2Hzn8VV+kVIueUEr4278u1Exp4Cr8r2E1N2NHQoX5OGYulUfpRTcSFcWwZ3K/gLuEnkF
	gYIZ2TrFFq/V/ukIG+RH45d74bYaxQ3PgcgFNp44nlrRXVzSHtCxEJn8WwTVUj5gkuCn8fph9jr
	xmiF5XpLIPiYujWzOBZ2XTjSotX4=
X-Google-Smtp-Source: AGHT+IHjUEVNRaMcvygKv+iGwtxqWwlTGN/e2l08ILhSI6zslwistJVIxeihubmkK8ZmS/PqRK6l8w==
X-Received: by 2002:a05:600c:3552:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45b517d26d4mr163145305e9.26.1756299455350;
        Wed, 27 Aug 2025 05:57:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c711211e87sm20190252f8f.44.2025.08.27.05.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:57:34 -0700 (PDT)
Date: Wed, 27 Aug 2025 15:57:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pin-yen Lin <treapking@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	=?utf-8?Q?Bart=C5=82omiej_Mary=C5=84czak?= <marynczakbartlomiej@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kenny Levinsen <kl@kl.wtf>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] HID: i2c-hid: Fix test in
 i2c_hid_core_register_panel_follower()
Message-ID: <aK8Au3CgZSTvfEJ6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Bitwise AND was intended instead of OR.  With the current code the
condition is always true.

Fixes: cbdd16b818ee ("HID: i2c-hid: Make elan touch controllers power on after panel is enabled")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 99ce6386176c..30ebde1273be 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1189,7 +1189,7 @@ static int i2c_hid_core_register_panel_follower(struct i2c_hid *ihid)
 	struct device *dev = &ihid->client->dev;
 	int ret;
 
-	if (ihid->hid->initial_quirks | HID_QUIRK_POWER_ON_AFTER_BACKLIGHT)
+	if (ihid->hid->initial_quirks & HID_QUIRK_POWER_ON_AFTER_BACKLIGHT)
 		ihid->panel_follower.funcs = &i2c_hid_core_panel_follower_enable_funcs;
 	else
 		ihid->panel_follower.funcs = &i2c_hid_core_panel_follower_prepare_funcs;
-- 
2.47.2


