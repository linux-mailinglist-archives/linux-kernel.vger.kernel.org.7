Return-Path: <linux-kernel+bounces-830729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13843B9A68E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E049F161E96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC90130F927;
	Wed, 24 Sep 2025 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nV/E1HNy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD3030CDA9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725523; cv=none; b=Ad5+rwrCwh4kDcmVNOmaI9HBL9778LEGJG4q/ey6E5wxrLeHB4OwWIEtxeVbfujPm6nj2r/5SQXb05B8kOR/RO00Hbz177erHyeoou7x9S3ZhzcsOcgWNg4HZiE+IwPPFuVrUp+KYoUq1psiImvRbYNDca0njr0kRMlnfMB/WOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725523; c=relaxed/simple;
	bh=2qMqnWq/naOFzTCUU9EEKFnLmItDIx+R8oO+Cct9CwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUJa715cNoXQgFOI3gXS2T7vP3HlDlt8WMcST6kV0gi+sGY4EneieMUa6eab6+Btf/GBF1HjaO3FeNQm7RCJtpdNSKivStLTPHjc+m97NTMg9uIGlu60/j1/kjwQF4zrDNvQ79y0uT1B7eB1X9tzHCoGxOXptD4bjsijIOUsroc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nV/E1HNy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso36749165e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758725519; x=1759330319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhDMW9EyWA9awJNXX9Q3cXommnoch0fAiufj04SUcx0=;
        b=nV/E1HNyV+9QN7xEVB5QfDKrjBv/H4MFWv88Wqrt+kquUk/2YqkG7g79aCYpyW9FK4
         s5KrBrYL48LPPP4XaBevW4C/aiTY4znvn5ymgvd+gDtz4B6K8bWVYicqK64kWRaHTIUG
         EzlOoJ1cX7aMkAgR1phQfeIn3nsUrVkdKpkxoyigoo9O6rx2nnkUmOD5I0DK+LEpajMr
         K+XT1iZhTrKmISOV5V51LoGUuKTSfAmWyk7Gtao8uvgXOArgD8ZO651Tfec7hy47JT5H
         KnsTVh99zFFWcI0JNKEeaa4YAsO4xE+V33xwQLxckJsLjwTXNVEGJgHtyJXAkhDp+RvD
         y1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725519; x=1759330319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhDMW9EyWA9awJNXX9Q3cXommnoch0fAiufj04SUcx0=;
        b=BLiLXRplOyg8/Ix8V5D6d7C3AdtIX9+mFBwZWbukZISx1/WRfSaN65znBk7g8H9dUm
         lablXPYcCSBJ9e2E5/Oz8R9cL4Cc0exHPkS3YVT6SJzqMArHhRvt1ypGO9x0jtoBSzNV
         VjXGS+oZ6Eim0oKDKdnOOH7laKuMvFi05nsK9V9/k0Weg+1N9fXWTz/EIzq7pBCHV1Se
         dP2pZjVWNFakCaQpSPVfJaB6/tPChsrTcDeEslpCtUKDe8xaLmUTau2+oEumByvz43AU
         QU5gpY6XoqBWDh4Farh0HUh3H7LmwWXzfnohNcXLquAtNZi1WqCMkGrfj9gsqeMwXTcF
         ZdyA==
X-Forwarded-Encrypted: i=1; AJvYcCVm53meeAVGfidoE6ewiBTYbGqJXMlh9W8/x2dNIkIgxayg2S0Km09JXVWhC13Z4f13sOrk/K9qM1Gqndk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0GBnRTmeJ3N3Ox7XQqOyi8gFNHKMxj+wk0zX8DFNRTKv+pzRK
	mshKWU3dauv7gFelIy3wCJvcuLaDBopoxqwg4U+D8NBnIYCrzKIR05YSKkW0Vcky1u4=
X-Gm-Gg: ASbGncsJDpdtO6HfIe7UuZ26cdk9sWDWxPjzFtB+VswwudX8tWXBr50fOekf+OljWBz
	g8m2q0yqSbUUEtP8JKpjscSTMdzLP6cgmI9XEJY6h0+p8yiMJt2yMH+C6i4oklcSGk78JEwZSEA
	s+fkGqd0AQgv16N2itdEaXn4YNDJLdEUMp/u25qPGTcmTTy3CByjfgGPXNLAlwjihjWJPA9vD+D
	6B4LT2kp1LhVRFcGnXufIqjaHwD9mjTxrt6rNqKdv2fUG+IHfWPmGpBTKBFsSxf/aRTzEpr46xW
	ZlL4dp0Jp8zdHH5nnZUBrIzVLzqmO+iYqJgNmMfLKthbPV9IXDsYwJ0MS1XpiKvXz8Xel8spin6
	bmxiaP0qHSQ+aQgovUA==
X-Google-Smtp-Source: AGHT+IEXQ1OsqbaopW/81AV01FMskOhevY3liqHQ+TaZzWyXAp5VdKtAaaFJhzum2Q2RFl6zG/ksTg==
X-Received: by 2002:a05:600c:c168:b0:45d:f897:fbe1 with SMTP id 5b1f17b1804b1-46e32a0de18mr1279345e9.32.1758725518644;
        Wed, 24 Sep 2025 07:51:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1729:c9b6:7a46:b4a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm29514750f8f.37.2025.09.24.07.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:51:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Sep 2025 16:51:31 +0200
Subject: [PATCH RFC 3/9] gpiolib: define GPIOD_FLAG_SHARED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-gpio-shared-v1-3-775e7efeb1a3@linaro.org>
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
In-Reply-To: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
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
 bh=der9rbuzwFrj8Ks9ulK3QjlAd3x3WVP4lOrBQ5vkuIQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo1AWF7GWhBGJxTAGF0PPNPgubeRhYpSPwz8NCv
 Nvi6uNAKwmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaNQFhQAKCRARpy6gFHHX
 clM3EADgqkPo+x/ufaWkg/WHiN9hw/cvQg7FiJdhEdeFpxtrREOwOstiUn/WMlvJf2D4BMLn7cu
 mokj2sl9AHpKriv5ymzg4FA1FGhJEgjkK46mjC6T56uk4Lj9yapACQkatEbVat7XhRM8PnBgluX
 Jc+89aNvU/Dx088tAolt+UYFAl+45zfiOJEARt1xuEWwW8P/26l93XIE+bDy0qu9fGkKuWiRiec
 5PdwrLSNmbfVKAra7sRgOFFBewIJM2rhf9J34K74Y3g4fM9WjzeTKconSAaEHPSkgUzxHn2Q8Bo
 sSz2uatngoMnPxxCaiAuGawKLv90e+HbbLng9dghn5mD9Espf42WF6cqI5EJ1kbl76L1Xv4oiue
 4RnSq6pmGN3nL+LQg99+Yv2BmrBcQsjFh5vIuLyKyCGI7YLSssw+V5trZHExBH3knl1QCTqHCNH
 V3CU9z91FC4t5KeEimKB2XzTMj6XkCOI5YUN3iau8Od1M16+qMysica7cKJ6L+gPMKCrgkLVfqP
 DV6Y3x/EvuCr1EbBd2jXOdBJ0vxxBXrwn4+N1KFQR3AyEkhgar155iTpZRzVjehN0VABnc/eJCp
 sRS11jZ1qiNgb7iCtv05Cc3QFmyId9CcL8ck/LYyTKXH2HqwC9kuIWvmrc27II/8qMFiGJZM5tT
 G4vQ94hkIbTiDFw==
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
index 2a003a7311e7ac5beeaa1c947d921149ad991acf..09ac92ed0853f2ff0013d1b16a5dd082c9fd162e 100644
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


