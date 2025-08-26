Return-Path: <linux-kernel+bounces-786414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60744B3597A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AA93B416D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2CE32143D;
	Tue, 26 Aug 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hgA34U9+"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB79319867
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202086; cv=none; b=afVNKb8256vaIxQZmphMPazDCgPVPA+ZWlgljrZBrql574yNE1WHx38JtxGyodzLsJHWPbJuVtP9yuGEV+seOqpfFBtz2XbVliqMue8OafOMfveuLiA8SRgYu/3q9D0vBWyX4fNKCgQ3aarhRleTMI6S0hHANQZX5IzzljFXhWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202086; c=relaxed/simple;
	bh=Gn/lKg9DW9+7A7NG/Xm8HI1PObyZ8u17xB6xLp+6Zns=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MfFGKn1NN404TgJ4l4qCyFJAYO5AXBzNt/Pc/jW12/RYfiI/6otznQdHgujj+EWPI9LmqhHNSb72tAkmhKZ+Kz9NnENE0ybb303Ky/nd/qeuptqOFA87j8Gv0BV9nz8b/ZXAwW2aBBXlzaT/Ek2HnYfat3U1ia9p7OcjFcchpUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hgA34U9+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b49f7aaf5so32222515e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756202083; x=1756806883; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKCpxqsXSBWd5rXXvtS9KbFsw7XYgbeW+Y6mgnOOsQs=;
        b=hgA34U9+ksdIXjCRBYDVP5Y5ZyODSOnQUcR2PEmukWY0SDe1XslOC4GDN9us64JiZP
         Ee6KTHzB0BgqNedlrZ5gHImRDgISqNkcczLkoRJnJ4V4OComER2SvpsFw7HbZuHNcu3P
         +6FMCscHbMTUGmAIUm1tAlQCxqJfcS/fge0B4s3x4h5VdQwJ0zWEZ3ClWOJLFmbFtJ/j
         Q3aeYhO0vJSHjsTuCVg8ewfezhkwkqF2Q2Dj5gMGDONT60RmEZ6zGGQYVAG9npqPki0j
         KF9sw28cg8h8uWHLkGKN7WhPYPRSmmiPLZAHQkUbh/Bn+5EqrxlijYbOdZYvV6Apn2hh
         q/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756202083; x=1756806883;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKCpxqsXSBWd5rXXvtS9KbFsw7XYgbeW+Y6mgnOOsQs=;
        b=dtG+jolwzFbtdq0jYdlcWZ9uhyx6uXnc8hQFNNiAIThv6kt98Th5kTCoXx8Q+GEopA
         g4J/rkC0FjKHZDgG4wpT35Y0Ql1sOUjBIOL5RuPjQ1JI99IfEzPxBLAdQidH8sVh37MU
         chb31jP44LMdEVCDhhFDt81hD4IKd4nMZPEDLZBFq4t2pRmO3zWwTNVj6xQhRndNh52N
         ajYw/sAOIS59xrq5Srm0KBxN+tTL9dxN7zbpYulHdGfYv8FnVUjDuUZyIlcYYEJW/GBK
         QDMvRa8EYVOOZ/3FndvI9R7fi9EB5eNVkckGMIqjUxTO5cpNKvip+MdHcHv3Hv0NpYb6
         Ug+g==
X-Forwarded-Encrypted: i=1; AJvYcCXbfoK3zAij87mpMQIFc7Pj5nBuJgjn0iL+eyVtBFrb4T86I1wcYCaDdvmWaQS6OBkvuQkEVa7F2p3RPFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMH3uBn94/MzTA0t8NBAGKI71/+Oqda8M4YRFr4l2cUmpcksJS
	cQDzZya4VZH5Itzfeme35BW+g6BV6tVTo3pL8LDSE8rXpB6k9dd2eYgLJjQ9gtVov5c=
X-Gm-Gg: ASbGncsxhr31o+PrpJWdiB10l3kGP41Vl8JvbKq/NZqzAxziQO/zgG7lZvfDgLFSGJH
	mw6JnLM9ctaW11HAJMPFT6CRSuQ4BjmqYnuFQdhHWw8SkwgiVFhPgoftkZgmsOHORYNd5iHWWf9
	/ZZmpXnwjfug+XRrVFh/l/2gLxtLyCF4WBNBxcE9Ns7h0VRwV2G0ZEbxU0zwBBRYOVzO70lQkV4
	OM5bSVJ/krfbZ/fv8mcmL9dZWdLPDiaXtbwRX4o9iBbmlrd+7BKLbwhJE1gzF/+9kFPheSYhP2r
	fjvP5fAjiHJXBfWSegBEx5sN4jqIhzxdljeQxbozvn352ERMYJnEUhRx+eoM/koQiZOMv3Zww5D
	0ObAexWalcts6xapEV0KA/kHSPQbL
X-Google-Smtp-Source: AGHT+IG+25ORqjof2ATwzWOqh5zMg6Fps3s9la097lt+3O2I/uIH0JvNAAkPT5A+WwcwcTlymgdPXQ==
X-Received: by 2002:a05:600c:45cd:b0:458:c045:ee99 with SMTP id 5b1f17b1804b1-45b517d4562mr118379285e9.28.1756202082873;
        Tue, 26 Aug 2025 02:54:42 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5977sm15708447f8f.51.2025.08.26.02.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:54:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/6] gpio: remove references to gpio_chip::base from
 debugfs callbacks
Date: Tue, 26 Aug 2025 11:54:34 +0200
Message-Id: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFqErWgC/x3MQQqAIBBA0avErBvQQsquEi20JptNigMVSHdPW
 r7F/wWEMpPA1BTIdLFwPCt028B6uDMQ8lYNneqMGrXBkDji5gPKEW/0Tgjd0PvRKL1bZ6GGKdP
 Ozz+dl/f9ALZCNeNkAAAA
X-Change-ID: 20250815-gpio-dbg-show-base-a73b8501f9a9
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Gn/lKg9DW9+7A7NG/Xm8HI1PObyZ8u17xB6xLp+6Zns=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorYRdOrntH6xLuqY0RG6LOlTXHAItfAvEs25aM
 ASHA1ZZdbOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK2EXQAKCRARpy6gFHHX
 cmEtD/9Kspk5oVvRCV8qA4ZGfkv7SpRDLcPGj8xu9wBbaIAEc3SFVsuf56Fk5ofc3w3SsJTnhYr
 mXtMgsAOjRgswZA0xPsP1/YIRGwVdmHNBywk+6bhKaUz8+sTSyL3+vQ+IBPQ8NN11dV1IdkgrLu
 7ch/JoZCDM5HVPLziqdmKKyg2P4IOD1McVr1lXvvjQsKp8yBkyB3LDCOqb5TSb/D6jVQEsQ8X2B
 PqQGvNnB1Mi7f4vwP8MrjNyzfwQsk0g24n1Hp2RLCzM4ovP5DO2jmHKWP3GIi9bJgmG3ADgZeo9
 aYZaf0S59RIUz49NIZSjizww7qHTJtVtvWuNsIQVxkUn+6B25mzkZ+lRo+SrPjwKOIdjy/ocfuz
 0iHNyDod57+ptCo48ED1p2U4pNrMnkf/oSZKWFjGyt5BUniAqdss1bcCDOB12acGAd3Y7fnf753
 2WJjitNAWknKwpilmOMpnqK+RLI1FEffx/OITVlWPCOrSkBdYDGYyWBuMxyouSP8O3wqA/JlrXC
 6SuzAVXLdAzBMTP9jYXOjq7ZLUntsdCjCIFtG5C9lILvgvK5UgXEN8t+YrqX0sPkkkshhT2hUhh
 N5+rsep5nGITtAFlSSOOFWcmJW1x9smqqTHgh0wpaYusTUyCDuJ6CFpj1ZCHWmxmNsjBWvwnvda
 JoUY+IbaNQ/gW0Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

We've stopped displaying the global GPIO numbers from core GPIOLIB
debugfs callbacks. Start dropping it from drivers too.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (6):
      gpio: stmpe: don't print out global GPIO numbers in debugfs callbacks
      gpio: nomadik: don't print out global GPIO numbers in debugfs callbacks
      gpio: wm831x: don't print out global GPIO numbers in debugfs callbacks
      gpio: wm8994: don't print out global GPIO numbers in debugfs callbacks
      gpio: mvebu: don't print out global GPIO numbers in debugfs callbacks
      gpio: xra1403: don't print out global GPIO numbers in debugfs callbacks

 drivers/gpio/gpio-mvebu.c                 |  2 +-
 drivers/gpio/gpio-nomadik.c               | 25 ++++++++++++-------------
 drivers/gpio/gpio-stmpe.c                 | 14 ++++++--------
 drivers/gpio/gpio-wm831x.c                |  5 ++---
 drivers/gpio/gpio-wm8994.c                |  6 ++----
 drivers/gpio/gpio-xra1403.c               |  3 +--
 drivers/pinctrl/nomadik/pinctrl-nomadik.c |  2 +-
 include/linux/gpio/gpio-nomadik.h         |  3 +--
 8 files changed, 26 insertions(+), 34 deletions(-)
---
base-commit: d0630b758e593506126e8eda6c3d56097d1847c5
change-id: 20250815-gpio-dbg-show-base-a73b8501f9a9

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


