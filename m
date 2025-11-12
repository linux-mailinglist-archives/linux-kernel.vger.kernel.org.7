Return-Path: <linux-kernel+bounces-897086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D4C51EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198221899C12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C678831283B;
	Wed, 12 Nov 2025 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp9dJzVn"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B6A31283C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946325; cv=none; b=iw28EA/xp03iePvgwiXGvh4KXpHtaVfdJFvF3mabQnYY8Z4BzBCK8bgSmPwRM2fbXL+fTIw8uo9zaWwu+h9gJU/kcsM3gFLX+jOs1Di2pw2oa6yMvFA3PR7xU6Yw7q+SlEL99TrxzFe9UuQveA5BQ02KKkQ4mEafykyEaR4j3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946325; c=relaxed/simple;
	bh=Gjco+o33Ze1VtTmwY3+n9x0V+5Bjmx76JK+PO6sbBb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NkpWaiAfW6dHATvR+CSs8r2k+xjoYOa0l7GJ76O2EdMGM0eDmy0qFebdVL8+5/Ut9SrC0ZCT5B263B64Es/1pUsGCXK9b5N3mKye8DkM+qwpNjKz48uIxzsebuBvdYFZ96TPwKV2N5PVAiUNVrdhrziQ+0n8GtsRjkVyk/LtW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp9dJzVn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297e982506fso8453385ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762946322; x=1763551122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMg0B2M6mlNno5KCjV7xdRrPsgdx1eaJiYPjLRnt1dA=;
        b=Xp9dJzVntfsFm6Hdqw2gc8lrNREsswKpHWO25P7JAixkO8IEj9GFCv2TV/A57HVNsK
         OA31dV371iQYe4QE+5SzJCZpuHnjIdHVh1PGFOyXBjKgfmbDzoRWO2yCoz+NYeeSZOPZ
         75YQWyULeLKPMBhWJZ7NhrtfqlTGtKFLaPP164si+N8UwslUEX0HxMmuTE+Dm7XMHr7h
         ary/9bOZz1FYET03D1da6LLHw/fXlwfBnrfi7Kxwg9NJHPfaEQe+EeUKejTbSGOJr0RU
         Dk+1I3IJ6ZPBsf2mI+olaM3jS6b42gSV0f1StWn9ubYaMYa+MVc8+s65pgJqEbmHFId6
         /QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946322; x=1763551122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RMg0B2M6mlNno5KCjV7xdRrPsgdx1eaJiYPjLRnt1dA=;
        b=FoIcOf9fWBUyXuiev4dQfraaLmI+oEKCqWE90Boqmmd6jVGZc+UDS2BFFHSEeuLn+j
         1pRDrU64qfdvI8EIgfE3aIAW13fg/JcLo95CxsfzRFe/e46X3TBv1gJJwaWMWHfIyAe+
         gaquxmSW5Y7l+wRGFzbjTc3LgOdeoafUeaG3haGCBDSSFci1elQmwsTxjfo+f66qiM5E
         528+ll7lz4DnDPWd0ShDCr0bFKAX1a1lRlt1rljOPjbml++a+7140LghOSKyulMBLwHZ
         mxgE4s1OxfvIG1dHpiKA+thEfbHg9w79ckJSEfwgWYFlq+2TTe5tP1l7hBfaHEnGhEyq
         SQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCXAZSHpuaRAyPTSTO2CzrgnmhfFLLtpwz/FVnQN5ATogy5zxU0q4l7RCHTAdhoy24z7JqYHr/6WW44Hovc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3oWKILqTyjo0bs2dJ0K0a1L8TlkXpsKw5ryrcPMucbKkU2VP2
	dBk443NJu+zNgWYU0IQSdFNcYTdquqXekU04zd1ikTdbVZKuHKnGxBzG
X-Gm-Gg: ASbGncspgnworHvIVA/m9BvfdXIkmbgz1peGhXg+z5DulLEw6RtQvmnn0yA6B47urws
	4rUyHDhQ6TCMjG8tz4bzcpugv8SLcGYHS3Z4mzTkbdMosAkHGQZjnkZl/hm7Lsx7htjAYQW5Zx0
	44L3YnNXOAc3+/FuzIPLmUnXAB2PS6QBh7HNFOAq2cIDVjv/0TRo4TQzpNwxNlQ3RdrcNojAANl
	VyofqqJLQ485A6KqWcTlYy2XFO/2FyM3GHin25HXUVuxlH6nXw6r/16dBv/jqErBixTNvNZzdQ8
	t6KCkTODGGvYAVuFEt9nbrFjgRv+DERZPtqeaCIvZbhV1zOB3gRsjNylFA79afVpnev/SnZRwcj
	W0l9uVV+deE1SzWhS3ki8rgTro1Wjb/905ngWbHhrjg4yUtmHeVBO5aoKd9jfv088JfEisaBRH9
	N8yAgpldK/UUnh9svbG2BCArUq9RXlgwcmQzf/vaAEyIQ539WCfas5HUtBuzvNiTewfMkgkmuzG
	qNMblAUaAjXDGYo3/bNAQ3+ljyoMtnsAKwRWx1JXDg6de4skpOix2Y=
X-Google-Smtp-Source: AGHT+IHJszkUFQqYlR5AFfzTGIEAaKvG8RL+kwBBJVNc77ojPYvNHMx8YbFZwpTAtKabQYIgMU5Dvg==
X-Received: by 2002:a17:902:fc47:b0:295:24c3:8b49 with SMTP id d9443c01a7336-2984ee0ada1mr33966605ad.46.1762946322113;
        Wed, 12 Nov 2025 03:18:42 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dca0f28sm27386695ad.60.2025.11.12.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:18:41 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Wed, 12 Nov 2025 21:16:55 +1000
Subject: [PATCH v5 09/11] mfd: macsmc: Wire up Apple SMC input subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-macsmc-subdevs-v5-9-728e4b91fe81@gmail.com>
References: <20251112-macsmc-subdevs-v5-0-728e4b91fe81@gmail.com>
In-Reply-To: <20251112-macsmc-subdevs-v5-0-728e4b91fe81@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 James Calligeros <jcalligeros99@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=737;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=Gjco+o33Ze1VtTmwY3+n9x0V+5Bjmx76JK+PO6sbBb8=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDJkiOUe9MqcoXO87L1RrfX5F5enpO+XeLfuuXJ0+02Ubs
 7Dj91SGjoksDGJcDJZiiiwbmoQ8Zhux3ewXqdwLM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GuoY6xgxcHEKwFTPdGH472O74la/3mPRvl8BylqCRWoyR8UunDqpHsCo80ls1Q6em4wMm22qelk
 nzL8Uw5BRsPxd9cobzkyfXVcpMehOeLLkl9dURgA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

Add the new SMC input function to the mfd device

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 drivers/mfd/macsmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
index 51dd667d3b5f..3b69eb6d032a 100644
--- a/drivers/mfd/macsmc.c
+++ b/drivers/mfd/macsmc.c
@@ -45,6 +45,7 @@
 #define SMC_TIMEOUT_MS		500
 
 static const struct mfd_cell apple_smc_devs[] = {
+	MFD_CELL_NAME("macsmc-input"),
 	MFD_CELL_OF("macsmc-gpio", NULL, NULL, 0, 0, "apple,smc-gpio"),
 	MFD_CELL_OF("macsmc-hwmon", NULL, NULL, 0, 0, "apple,smc-hwmon"),
 	MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),

-- 
2.51.2


