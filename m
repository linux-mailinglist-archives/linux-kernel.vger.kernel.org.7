Return-Path: <linux-kernel+bounces-897327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3728C529EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95CD42172E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EECF26E6FF;
	Wed, 12 Nov 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WE6btBxV"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9924A06D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955746; cv=none; b=h4gWF3FdqwHR13sn0AtR5a7Eny8nbVG7GNAMexLZDpM+nQWOLtPGcBGBh5No8hCt7NiHgvTOFoB8xQclA3m2O/wiGJCZnzy88za0uJBAzwpAG6tHefXyNWCmzT2jp8FaRtQStWE0N1cvCh7GEKPyCBshzeX2+h82RB8jX1ZXDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955746; c=relaxed/simple;
	bh=KN033bDXd68p0ygzAwO9lMJaY9FplVJ3RsK58yXEA24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0bsbz0N3iiicsKvfAkdea50rSZpkKEy5GoxC6t17e8CDs2sOana9SFaaITiB+fSewMyAlMnipurfNs3JpXq6IewRenonf81oJSO+yWnDq7pngkSSgBtt3PO4DBZVz2EZwz8auXO9iTy03haknhGm8dFmZ6FlAX2carIgfJlNRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WE6btBxV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477632cc932so3974065e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762955742; x=1763560542; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hgFs5jtdGYJBZ1LEdVbgHUHnMs4CKKuQJyrqRFEph4=;
        b=WE6btBxVDTXx8n/dyWjbAKye7yMioyNQIy2em+DowK6RvO/+CgSaF3xiOwEpadP6J5
         Yu8dO/6INKWUvsFR0NkfG3bXVYJKlP65eX8EbUhw838I+0Y5SpEzJVqlNOJFsoQ90+8K
         g6H5v0ru/aiWVUtw53AV2066R+F8u5cLQSvrnFErvWu1tZye2n2zzZkCg09nwtaLa1l5
         jXdMSzePO+XkhnI6u89UMZC52jNS8BGZqqerC/jyGIO5VLzWf4NhHu+Xyj6iBw1ZA5fE
         2JClMCr1oPzngthmuIaW6WJjGBkx3dYFE11YvCjpQoRLvXin6W4bycFfslfmQGv0/REk
         igig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955742; x=1763560542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2hgFs5jtdGYJBZ1LEdVbgHUHnMs4CKKuQJyrqRFEph4=;
        b=S4tmGjeF0uk3RNxcpiOZQv+EFpo4c7yeSOckAXTDXpLa9OwJFkmynEQWfdAC4fbOjk
         nejR2YHTuPn9iECwgjRuUXos4gx3n/AbsYkebojlCu2duyUyHp+aFIzHuFBuuo3lIo0+
         76Sj4kRLLCkaUoYRUX1hlHb3sgODKm4b3fotdyzSHwuqWHqIFGgBoxSXFBUlSIAZEiWX
         MKN3DlwYDko+6HJAiQmDAnjcFAcqJaCkitZcNR7ddDslllqN2iPhWgQk4w7TarvSv9xY
         kf1UCtQWkWyzIDX6ligEvmxW2bZwQKcOLbHqzA/9I1letcyNCgA3AsbnVdHyoui5MUxJ
         KRWA==
X-Forwarded-Encrypted: i=1; AJvYcCVKFsCSWXc3Wx9FJFwfNd0FRMbEJ9SMbk0nfPoH+1XA/4eE71lcTkMryIDVXrcOne8SJ9mseCW+oAP6kyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9HSbZXy2EB7yk4hQ3sMr6lg0TwET1xgAEFIyJsamiuPUt4Izg
	UD6nA4LkxbwHRvaMrtBOsdyNNRgha31Wc7ziOjaV2ZB3nfxarb5oqyu9d2OZPAqtVHU=
X-Gm-Gg: ASbGncvBVkZaMRICaEuCSpr18Uhf/idV5HuDf4XYUhWCqPO9LGaM3pBg8UNQvvAIHeW
	PuMRiXdEO4GQZeimRNJF+AcchJXvqn7Fel+aY+A3IAa9SZQx2EqH48ixHC4oTOBeEs3WKGwcCgY
	DXUSj4t3kmT11rlVJrPFtAcLkkThqppqiC39qlu8qf3Tdz7oscJea7I0Vg185E0WhiPdVcKQO7k
	Ngc4+YxPTi/f0dKnFDM3108cjasZz61zMfMr3pk0RNnjtCGL7+CCpSpG9M7kTJHcn9A/UK5f9N7
	vFMlmhvrKQ9nio8I+Pjgb1T6YTAyVlLtA6SuPo+JHjrsCCnlxrqa6zL1SRP+fY0/EhHpJang9up
	Zq9dLcksVq01CVrSjRvIQGWpj0trinkB/7AqNFlgqyHwcdpy+HApmj4e6lTcot6siRsQ=
X-Google-Smtp-Source: AGHT+IGpKMpu73nkeB94rPHaIZutixTAdFFPa6qysCajDttSQ0OQGd/OBq10tj2PVKg3TstrN7uRIQ==
X-Received: by 2002:a05:600c:4f91:b0:46e:4704:b01e with SMTP id 5b1f17b1804b1-477870708e1mr27099245e9.8.1762955742150;
        Wed, 12 Nov 2025 05:55:42 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2a6:e453:42d3:11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2b835sm37711685e9.2.2025.11.12.05.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:55:41 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Nov 2025 14:55:31 +0100
Subject: [PATCH v4 02/10] gpiolib: define GPIOD_FLAG_SHARED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-gpio-shared-v4-2-b51f97b1abd8@linaro.org>
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
In-Reply-To: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
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
 Takashi Iwai <tiwai@suse.com>, Alexey Klimov <alexey.klimov@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=fe01g4C6qCSbAEu6zmke8JCgZ5Eo9dDIwKAhmTSay1w=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpFJHVBTDDrvJHZ80xPG9a4F7QqcyJzJgbcSXHa
 oo9SZzZ15CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaRSR1QAKCRAFnS7L/zaE
 w91FEACnpe+vPiO9uBC+BsokWIYfbDME+aBKEozY7SwP0GRthdoEWwpZO7sgtgsDqvbBiW27PQj
 u3dNIE3sC+Xq4qVOYGD1CwpgZRYk+nWkm0G/rdY9Cdt3WkjzDjmRKQ6nfYxQ8QCUe3oWOHRD2aD
 FIGPCTly2E8ANXYEWTCdTDIlSifKrLDkfDYoiYC4zvzVFh7yfTrfN3OorFzIpqoBDiFUdOF5v4R
 kZXRmcAik8hp+cSw2IqltJYa0IpkM3fi35svUUVAiaLFemUnTXLwinqOdZXoAR3NUUIkg+yfyGT
 Ng+kpi792Y0jFdeMbPRqb7Brix32Pi7kA6zS6AWsT36I9rQzC1uWHWh10ar6IO4g/0eihjuFPkq
 lIUPxsIpKrOIaKFX5oLZFonmQNcTu/QgsBF3WvKDnb+soIUb4YRd94DdPk93QpQ+YX0A+xvfNvf
 WxDOUFlr8mhOjvU+AbCZTnisyN6TBs1WfXYv2BMxjlOki2kzA6/hsumjEZ41oXWs/fNBeAOSZiV
 uAFemOSTTwgXTlYdblMtR4YBxsA+hUnf62j8isuIFTVeDl04b/T9Q6CDK87kqWqQNOrJgJL27OE
 djN1+y17ilgzoN87pxNZICYpjc2tighS0XY2870Hyn8BpJTZ2mwyf627na0bY0v18oddUykWYfU
 xrHzssrVMLnGRhg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Define a new GPIO descriptor flag for marking pins that are shared by
multiple consumer. This flag will be used in several places so we need
to do it in advance and separately from other changes.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 14e6a9807a89da6d7c6594a0a2de5f5032c49e0d..c9de4bb10584206f4888c0f28468762a3680aae6 100644
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
2.51.0


