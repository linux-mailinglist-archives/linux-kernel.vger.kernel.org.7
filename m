Return-Path: <linux-kernel+bounces-875870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2DC1A038
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1370846735F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7533970D;
	Wed, 29 Oct 2025 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="P46194gR"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B85337B92
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736878; cv=none; b=ku6dCk3iYFGq6U1CAlcB3XFljwJ/DGgwr+APXkZtOyUSGgCZ6LYwcSk+PsVPsGpv9tOwy4z/uYqeeAQi6xOnR2kRpJgd5YzTf6045JhfSZv2rRZ5RQZxuWv/45gXdT7+LyzHOsuM2HPabdMaphjrJfOmjtw9ThSuyr6BiGc2lNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736878; c=relaxed/simple;
	bh=t49A/kBppSVTxxxXVfsc6pd4jOUk3IVyTl41R7bfQmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJkpSiPXfEpxz08l7YLQZz95i6MVhj+2r0ucD5/hSH5F945vah8+iMnuH8B3HNRFgYYuca7ul9r5JDZgDiUjh4Hj8HAQUbT5zCeAEGLkTTA42LeSQ/Ap8LHR7LGYsgrDaF7JRmN77yM0axGOg/zwHAKJtRcU/TWJxoHPOPEPNCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=P46194gR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4695781f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761736873; x=1762341673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSw2EdxjOi8kYZ3PupDeUSTW/56qTSGlR/hARhYoX30=;
        b=P46194gRLMInXXN3IPuYeRafbyKTx38VXF0ZU2+P3qSaw2rzKfeIBc4wRIRSNHqS/K
         IM4a0d7y9YIUH8aLCURa0586cDUYG5EInyesYMyp0csEaxmY0emJO8LhdYxxUs4dBNt+
         oOjv5Wf51zh4JDGeSVcQvCApDIh5vBhUYWTOjL/kVjMENF/4P4FFe1NfkFRi9Gsonoqg
         YkZC/aBbRwKxOuyC76ZwHhgqMHcqKl7JswSgergfeBnCjKgpFXsF16VbDQxR6q6dY9IU
         /8bUMIj+hP8MQQ6P0K6c6MTkZ55QFTm1ftxX11FjfXtWtPyTYcP+Q1XII0NKkl6rzbiE
         UFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736873; x=1762341673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSw2EdxjOi8kYZ3PupDeUSTW/56qTSGlR/hARhYoX30=;
        b=mfRMZ7Z2pTlW8wpyUZd/g1bOXYChTWj7pCqkw6lxTO0LM0P4Cc2CKud1qK4SmpE0X6
         1L8FG+JF/vgunBhLYbQWNOYIoISSwVZJwWiXY8St3N4Iodj34K2hXa6dwssnz9JiFuoM
         YVIiiwpcOMLf9DOrakx6zUwOR/bOzUodHySs4xGHyyOLf/r6r3J/FuZbxqB4oQNjh3cP
         UdxtXYdkcajqtbzS0T+Y25qiKbRHNnmUszQreeNKjoyH2lDGVNJ0WtGMWEu49vg+OMu0
         RngO9JLw4z/UmRPL59nFS3Z4edidptda8ed20OXksiDR9aON5Jju6PNgRbAI3Hha2/qT
         i5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCV/ofclStNKGMb7pv3sXhxIdSLCTdvH45w56mYd98dLbVnHWWYlsFTR/NQmwm4fBWNSckDtA39EaHg106g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY3GbACXELY6/jLLtI/fWRKhxhOT1yg3UiiWj+HgQdqJ4Togrd
	YOYV86w3qbXkhIbzPJpkL+jXgd+NUWw4IsfMFeVorm8kisofjuYAf+p5DUHyYGrWrio=
X-Gm-Gg: ASbGncvkdrHbslYURlMqzxNlebSvYVsZN+0Eiw5u3a1gS83TU5c16zxhadAp/ddTGhT
	Xbjv3c98WBWZ77mEu8Y3e4OJ7b+0JTanC6so+jrkzdBXKE79qBwgnyXLO6aBSb/UZuQrK6dpUfg
	6tn/bzA4BiNX/YpbLm5GDK+QiQXZ+rYr1IZldgieTKv/EfKBATqd5RecFNaUXTiVyw8fTDPhpgO
	9hK6piePzREkEPd1kgzecUzt6V6jJptlxki9gubi/X2Wu9uR9WkZRNjpIhzQNOnMM054MU50wja
	bVI2ezbMgRshZjiRZ15Vhoz5gMHiQ2jJstbYGMgTn6xmhpAV1ccawd5G51TA9meA9xJUJPezbeM
	wnnl0PqtaHlRU9hYVwlgi2R7o3WA1QeXxLgOf5wxdsLPQ3f92EG92dwgy9WNOZyYwgGwDefp0tS
	zelxWZ
X-Google-Smtp-Source: AGHT+IHFL3/SEypSJwx0z/KiduAwAaTPznbT5JJfFEzpWMAJnW6K+9SO/RgtFfJleuosrj/o5yax2Q==
X-Received: by 2002:a05:6000:2089:b0:428:4354:aa43 with SMTP id ffacd0b85a97d-429aef83083mr1953832f8f.18.1761736873302;
        Wed, 29 Oct 2025 04:21:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df682sm25657486f8f.43.2025.10.29.04.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:21:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 12:20:45 +0100
Subject: [PATCH v3 09/10] ASoC: wsa883x: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
 flag from GPIO lookup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-gpio-shared-v3-9-71c568acf47c@linaro.org>
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
In-Reply-To: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
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
 Takashi Iwai <tiwai@suse.com>, Alexey Klimov <alexey.klimov@linaro.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=vbLbGIRrVxCCk3wt/NECqvmCZHfWshBV2zBTPFShXA8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAfiXMGr304xGBu7tq+dWAfIS6q2tDWWQKveWm
 r22V+7NbSWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQH4lwAKCRARpy6gFHHX
 cmvWD/9A2sOwmknVVLQVKABwBt8qycLb4JNObvNJ4aRgS6PD/ENhwvX/HEy9aPpX/OPWJLDaWBi
 v1LS7Jo2LbgVh3gQ/k9j9zogkLL+fZLSYgjIzsYzCsc+fv0Pf+Pd2hM1F21g+nFzqpIaeE2bjTf
 lKKtWoGDhh3cOB5Ynw5OZ0lXQtdOPkY0ynJp4d4SugeLwZ2sVlboPaFVVInEjP9jbDX+qaQGUtW
 ZXz1wxfDEey087MB54ZEKKSJE8EkOckNaSrJwGteoDmImCmdnQbvG+gOS7cr4LSc+wU4BPwqY2G
 7kAq7gg//lCBUGn9fJu8z3PFHmp10lO8GovA9M9UTOaIDq6yAhJT/QShNTDlIYqajICuLe/9r6N
 1XylMntalgyk/QeuFFbM2nShQKrR6nj5f78oWbDBXtQZU/Nfd+n9KZ75/OmmS71h4vNvccn+u/f
 QMwB/wSuHbYZY8m+hnL7gbiF7TMPccpZiIh3duEFfFrnXz51Ux5ROW9PPZ8CREQh825sXocYvfy
 evWCuhwluI3Jshr1EFB1/QPtGa4E3iFjfuaxJFv4DQMcWxflUT02mQesgQtabdaFBa9PVnDpPGA
 mx3paf/ZPiy+CzHgnMMTLxs/1PLkFKjEMV827AEeyzgzv1kZnsIWJLxttu7Sae9eYoBW+Qdje/Z
 ZcfHMA13BxzE1bQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver is only used on Qualcomm platforms which now select
HAVE_SHARED_GPIOS so this flag can be dropped.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 96dd66c4b88dea34f1f24bed4d5ab66d3e2249ae..c3046e260cb958296a41b78b545f1ac7f377a968 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1572,13 +1572,10 @@ static int wsa883x_get_reset(struct device *dev, struct wsa883x_priv *wsa883x)
 	if (IS_ERR(wsa883x->sd_reset))
 		return dev_err_probe(dev, PTR_ERR(wsa883x->sd_reset),
 				     "Failed to get reset\n");
-	/*
-	 * if sd_reset: NULL, so use the backwards compatible way for powerdown-gpios,
-	 * which does not handle sharing GPIO properly.
-	 */
+
+	 /* if sd_reset: NULL, so use the backwards compatible way for powerdown-gpios */
 	if (!wsa883x->sd_reset) {
 		wsa883x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
-							GPIOD_FLAGS_BIT_NONEXCLUSIVE |
 							GPIOD_OUT_HIGH);
 		if (IS_ERR(wsa883x->sd_n))
 			return dev_err_probe(dev, PTR_ERR(wsa883x->sd_n),

-- 
2.48.1


