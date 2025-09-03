Return-Path: <linux-kernel+bounces-797955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B97B417A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47AC94E4992
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53262EBBA8;
	Wed,  3 Sep 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="S5Xjcpn9"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F32E8E11
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886434; cv=none; b=bbWTk1aIytoJpWIvl5LKKbWQEo3HhHohq+rrh3InPnBHKsORWYFjDkt0suqyH9XbF/bUqgMpfqHDPwa77hhs93ApQcjlGZcgCtDMfdZ49i0H0wp0QS65+fbxcHU8ZVEFFqkJns4aRTg1focFBwUQmOcQrtScvZALmNJ7F2QqB9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886434; c=relaxed/simple;
	bh=xmgkhNllS9jvnToyYZlu9hfBz7CKgkm0Hr1jvX7r7Ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6egLoxvyEOPAtiqy8WmNQDls3nopF5Sow/zm2nON7/nMt7niYLrSdm4ofMy/qY5Ino936qKyzY21ejNflh9BTvHmlS0f3KIPTfxvW7XDJSxo+PChDUU/mxOzvAR74tQpoTHgd9uoGeVbj16owI8UNIxi8DeaKiKehrUlbfLtDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=S5Xjcpn9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so1447605e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756886431; x=1757491231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18wUDZNoCbqEG6tqUCcwZ6EF2CMi46nnuyazWZg3eg4=;
        b=S5Xjcpn986k7SqzsW57UaK/XHwdBHMd+fBPEzvX4qMzDJs403p3KoGJ53moL2KTskQ
         lVWCybOlX/Y6yXtSm2NWFV3/ECZypAccYk4ce0wDpwYLupZcPu2UhCTjdPw9RXSUmWBp
         6FwwFsMT6TmezmFnDu/K/0FJmYJCke2cKT0EEjE0qVi2ntH3i4LXYAgdQhAhekYg1/AG
         CVXkE71GOme0Qaa9zL/rFYTOm5A0QeHqYDBQfTUJJWp0ivzupQqX6Tp4f8pBBzrH1Zqg
         941HqDZszhWBIe22A3DXtGl89ujGhenJAk1Z+7MHpbaiQhrpzasts1LYn9mCFoxp0vGj
         d80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886431; x=1757491231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18wUDZNoCbqEG6tqUCcwZ6EF2CMi46nnuyazWZg3eg4=;
        b=dzFpEtmuShalhL57CD8VUkGnLEW16ahVhMhgt89kCoGVry2eA3m2n+IpQQlkI26vfJ
         pPd+SMxLt27dERDF5ATLcSaSfa2cCkDGGwsZ3v6oBxLUT3y/Wpl1lB1zeFLxjvRCG0Ne
         QDUacHOv99E3MUlUVnMava2bQ+kZQ234W35mXi0ywaVHw5QvDZO47rJG/1cNk04KwIId
         sSrXRl7CCHONUi65vMRdMZZbRDK2SnjwXP0y4vD9Dqqksz8C7i3oj6ri/hzKeCkJG0Og
         1MvDW1tYDFYE5HnfNq4PekkzNzdx4plZwchyiqQ6L+u8n140aHs3bSXaCGHzrZEmiHgS
         Qs3w==
X-Forwarded-Encrypted: i=1; AJvYcCVR/SNjjOEE8WvZ8CHwhHMjkD94WsLZKX89troF4AUqhaK8rgCrzZGS8VE9wXKzZMJ8nMpZZi8dk864+Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6YXz0ZMvD06UwitrmvdYUT4XN1bKTSpLaBf5lJIWbiU42iBW9
	HUX1B2iN79gt8PG6wK+d3KSdfra95B0RuuyYl6cqrfkCsKRjipE8Q2O1B9gmm2zN2LQ=
X-Gm-Gg: ASbGncuPcE7YNDiKBOzu70M0LjxfJNZGuo7YaxyUAAWc1+LstSjCeGJx5NZQeN6Tthb
	0l95qLLQfLbA+RGMFSbRv0b387RvGB1gdgJGa/x6w6VdGD01qXKaU3uOFRLh3xNhK9VrHKYC7za
	EJQn17Ph/s2Y8Rlv4fTC2VHAISNdf2mkxpNVAhFlRywopTi81htu0XPaJikTcakVnTlPNa3rxkj
	NHhy5VEc2pJKE+Y5zTGg0FhXTNO227/9+XOluXQkMhb0LP82oEBDMSIuy4rxwUjkDs5JuOZCKka
	ay5tr0KrtmdQQ0rz9t73m46dl6JFC/COs51H6HuCJxZn52NYPhCs14/7JOauDftJpTHSeWS7TUg
	NriuUtdfN8XNr5sXJ
X-Google-Smtp-Source: AGHT+IF5KpHSkjjzJJ7M7jfgIF5Fx1K+eiZBRp5hE9btLtkWTijcKBFpACkt0UwL+yVIo0fMGVn6sQ==
X-Received: by 2002:a05:600c:1c15:b0:456:1514:5b04 with SMTP id 5b1f17b1804b1-45b9353e825mr48986465e9.21.1756886430953;
        Wed, 03 Sep 2025 01:00:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2f8b:4799:6bd6:35df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b83e954b7sm113331635e9.1.2025.09.03.01.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:00:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 03 Sep 2025 10:00:13 +0200
Subject: [PATCH 09/12] gpio: ep93xx: allow building the module with
 COMPILE_TEST enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-gpio-mmio-gpio-conv-part3-v1-9-ff346509f408@linaro.org>
References: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
In-Reply-To: <20250903-gpio-mmio-gpio-conv-part3-v1-0-ff346509f408@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>, 
 Imre Kaloz <kaloz@openwrt.org>, James Cowgill <james.cowgill@blaize.com>, 
 Matt Redfearn <matt.redfearn@blaize.com>, 
 Neil Jones <neil.jones@blaize.com>, 
 Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=662;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=RyabPByGikXCRgzs1yNMhXnICz9jTd5ZeCItLmkI7LE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBot/WSs7BrYudE/MV1P1Rz91UsCyzxCl5FxgCJc
 nZOU6oYImeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLf1kgAKCRARpy6gFHHX
 cunLEACakmrfrVS5eWsQLoNk8R7Zf5LSFhgcD03hO4jXvLeHunckz0WUwYEgk+ANWT5aGf8cRb4
 biREJ6YbDPXpXvjo4jI8g16RHULATmNewkP+0uA2By/zyKKQ+t0BpYpE4uwTM6sUCjznKjfuOYz
 nYXpr7ONFzhBcMa/DVi+xS3tynC7ZlXa2J4rwz5YBLAwiiCNfEu8wmSqjz7m/YBhAnKfGA+YIbp
 GTmV6SA2D3WIVVFvoWlJKM3arEmSM6sI8oQMMunl4B5t/cf03KQAfqHFHmIruWLcrYRdPw3e6rl
 TXszTmHehIC7gp0lOJMNpyJsqjKhuXN9oz374CWeolahMsBiA8UdlpP/wyrD3C0gkbqgBlaCChz
 xgOe1bA+zQ47AZhsNTRaDGaoq6FwcUBbK2os/KjPsPdc3y0pzO1EVqiGwH2KJG4oMa7H9Lu93qB
 hZG1+JAP//Nc83iMXLYBNBn24HzlQF5rrccHBcW76Nf9HUQ26uvm7I06CAAhGikl5EDAguOfYzl
 dDGqSo+DzpohslCLolSytFn2muBK8hSD1Xfs7NfMF/KdQPXIoU0KnX1aO8dkdC0a5suNNT40BZQ
 KjaDIN6CWTm6Fq6B8FjmmQajFbDhP100T44TDou/G7yytDlFzNHw9ufv38v3yhDq+6KsBPJ7Ltq
 x32uruAOOcF7Sgw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Increase build coverage by allowing the module to be built with
COMPILE_TEST=y.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 2fb77eff3b1f2e862a81eb77f2d4d8f14c27873d..08e1fc13195452bda347f81a3552614d8e603bd0 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -303,7 +303,7 @@ config GPIO_EN7523
 
 config GPIO_EP93XX
 	def_bool y
-	depends on ARCH_EP93XX
+	depends on ARCH_EP93XX || COMPILE_TEST
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
 

-- 
2.48.1


