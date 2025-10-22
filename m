Return-Path: <linux-kernel+bounces-865056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E4BBFC180
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AA60561979
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B41348444;
	Wed, 22 Oct 2025 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ySmwzMN8"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBE347FDB
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138668; cv=none; b=D7NMZ+SeeGzjL/YJJc/BLbn5/sTMplfxJPN9Pzkc7vw+cWc+Bvjvmj1gluJ5KGc1Tf9zJa6JrrXQvWUgASPhOiQBUYqd6ItUTLNhG23pJrAm/0Zg8PS8w7exmYwDjk7+1Iozh39fTSVuTvkv3P2uWyo3KiH8h30rs95Nx4KiMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138668; c=relaxed/simple;
	bh=e64n37I4xAvaAkGyJ6yY89r2f0ctBq3OuH/O0o56ZxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kF6wezJTZj4K3xGfCNOdtPLnSy4/E4tBNuFaDfb3WaAvbonJIGAnDuLs/3Xabhr6BZBQr5//fWR6LG1gsNSnBD83FZ+oME2qjJvdh+kH6pnYTviSO19Y8f6Gl3y+aNEWkHFAQ3lO3v1VY6jyQbmfthmhl3ML6IE+pjCV7AUTsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ySmwzMN8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so38542135e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761138663; x=1761743463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLUcw2OFBeNQGOHQeLxgckCo4wtobuiOcK0Z/3Mk7WU=;
        b=ySmwzMN8sE7MA3qlB41arOaDdSti2Zpag8oMvpiHTDuUyDyXbgPT1pYOqZM/n53x5i
         ShV4/iiETV+j5McTxnm8jKWww4/kyu21LvAYfFohExpnfqrBZsqLFaP3ItSo6LvB9+iD
         iB8IvHX9XNGak9MJE77CQXitilThQAprnEO4SwgqJvg5zzvFO6nNvHORE+nBa/59S3mZ
         gh37r8cf5oAwnxYVQBdDm0uVpHeI5AZ816aEjiUq1oO/Z+fAk4QFbd6afuCAwWZOP4QV
         It5Kz3+N/SJkw+lD25js+CuUTeq9ijEFf8cyyc71MCHya11skAC+DHJDLn04ddrcbV/p
         nW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138663; x=1761743463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLUcw2OFBeNQGOHQeLxgckCo4wtobuiOcK0Z/3Mk7WU=;
        b=QLwfkR+vzT671neIY2zXnMwXKRK6zt2etXcgRviX76JE92OrxvmIw8TP0+Al1RbXJB
         h+vkO9CFSLNLUuSppWtqwdF4v5C26P7JN3IUVI38/ASN8XExhRDQe4WaGXCLQl8TrXi0
         ibi/yFOAO+jaPUzf/q1Q7TCXgvtmwqsxqgpm5etV15D0lEwSmz7eq5JEvftAr+CbFXF0
         hOWn4Zy2/j2LGD1tA5Xyli/3FDP6sWiGpKzdfG9M3CH0VWi/NK5pW8MwyyQYhKJh4Tu3
         r+ySYPk+JBY8sWcacSc5bQ3rcLl6lYIRNF32j3H0VnWocCHzbWnOLIidISoKnxf0wDCi
         cMEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU++GzihCwda/RIBqS3JTOW/Z1jUz8P5d7jcIANmNYFKp2ir/Djq9y5vuffroGYq/9+TO/sXP5vupFtHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK+w17Wwdibqu8l+xlc9FeLbo3Tg/YExHFtOXR5n/tL1XpbEmJ
	3/zoM6VWAUGz1Pc+F8Z698cKb2cIsaqd7HV/b5gKBvA/sX4mooVpaRaqGxB9ImA1dKo=
X-Gm-Gg: ASbGncutJOjfyvrBFshHpKggaKchYUM9A49h6384nRAGk8RqJ+sqgVajflRchfdMjvN
	qnuXO7XsfA/e9aCAQkAiOGJYTvl0WnuaIylLO8ctVMKayYUJ7P+OhW8cYCpiKArp2Tk5GQLA5I+
	6c3+p9JozN8F4G8i+56y4kKkxNzA1KV/8NV8lTXPtxzT+9rm2Ob5pbXs0A+AqX2CaL3Wb73a4q9
	WL32SuCVAIgVigAWrdmhnuhX2RmRxmdYhrBG4L794I20tFSc09eodA2Wjfuw0cQQCcX0hFcAsjO
	q+IO4P3YRebflyveqqwEidGJAWFo1r90NZEmW+rRenz76fRXw9FLDiZ+MleJ0lf+/r7VPUUtU9S
	SOUM38yJffUvsscqjE42n78OfBfzfwJNNBXA/phpBi5hi7Cyv++c6wPWCLUGD/SoPlHV+v5O2Nt
	Oav3pv1w==
X-Google-Smtp-Source: AGHT+IF2yoMxKRceyJY5g7EYD06lQq4MGEUKhu1hgrBk0d1+Vdu+vYEezPyJjW99uVj5oDoAk/M1OA==
X-Received: by 2002:a05:600c:4448:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47117912b0dmr153800955e9.31.1761138661004;
        Wed, 22 Oct 2025 06:11:01 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm38839905e9.1.2025.10.22.06.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:11:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:10:41 +0200
Subject: [PATCH v2 02/10] gpiolib: define GPIOD_FLAG_SHARED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-gpio-shared-v2-2-d34aa1fbdf06@linaro.org>
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
In-Reply-To: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
To: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=cX89PpdM44a3eQ0k9H2mF6X//0m35VFWgOWbVIYFNfM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+NfcfcpMLzR96W7BN60H4x3MK6Q+puGFD9uIE
 wmMWYL6QtmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPjX3AAKCRARpy6gFHHX
 cv4hEADgQsk4SDqsQQ4g2XVBZsPrB5rQs2uMZN0YJS0NTCuXM0VRt8+hcPaZqBiwgJ/aqaj0piN
 /NSpg+kXgqg7ZrB+r4iMLM7BwWFCk0uRXWTDqnvnr6IYOjiOk8tmrng05Pycm9LuHYzNxCIuzkl
 yLT3Ixm2/TxEY8e91EQRqZwxggaGKdwvENXSdcCJwXiWIGaCKaTa/HIDkkJHitBi3wU9hmRy79H
 MU69QTGVIu5qvdMUJO8L3eUwgzxZ4poU34/hJOvi7I4ivBvnCT7fcZqWIIMsXMe26WS+kZMfd6p
 Hc44SjrXUUje/Ntlxl0u+T1U7PFLaHoElR5h1t4Uv+7VyrTaGyhPxWZV2x7h687RKI50sv5V4Hf
 a/KahzwR8wvuwT84wDya3UTX/Dn4PCcNnJlN7BKCE58QJ8eVvUybGhEEUd/pEKIxcD3sFCcWt1r
 IRWNJ5Lmx8FQjzDGtu3Yl7DKVYXhfAJsC+59NnbGprw+ZLrVIMNpjhjyPZ7otpfrcDQxf6XJ35X
 wMPLgFrbkb3z9gmBRGl6ug6KGXgsc0Q10xXksnOMpMYWy30rL41Z0pa4GZ48zVmtHszl1luX9dG
 xdrId88bhFySFAMazRmpG3q2PafzOnaTN3PdOT8C9kL39JU6486eE3+eqtF8nP7jMkGWfAhYYsX
 KQaaOpV+fZHnThg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Define a new GPIO descriptor flag for marking pins that are shared by
multiple consumer. This flag will be used in several places so we need
to do it in advance and separately from other changes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index b4c5369f8a3314244424d0c90ba006f7568b314e..ae9aa145ca055c08dad55a537567a27de57f7066 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -204,6 +204,7 @@ struct gpio_desc {
 #define GPIOD_FLAG_EDGE_FALLING		17 /* GPIO CDEV detects falling edge events */
 #define GPIOD_FLAG_EVENT_CLOCK_REALTIME	18 /* GPIO CDEV reports REALTIME timestamps in events */
 #define GPIOD_FLAG_EVENT_CLOCK_HTE	19 /* GPIO CDEV reports hardware timestamps in events */
+#define GPIOD_FLAG_SHARED		20 /* GPIO is shared by multiple consumers */
 
 	/* Connection label */
 	struct gpio_desc_label __rcu *label;

-- 
2.48.1


