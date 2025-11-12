Return-Path: <linux-kernel+bounces-896748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D04C511D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9651D18969CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37EE2F7ACD;
	Wed, 12 Nov 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqDX+qAt"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CEA2F5A11
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936161; cv=none; b=ucuDWoU3NvU7WPYoolZUSqLjc2pz7nWZ25LrrWJbcJSclPnkUPeluXxG9rNJ7uENyGscj55SI2K0y8lBxsLptVh4MLexwJHVAUbbnVK1F8jlcbHiuv+OTqQUtXrvli0WcEZZiprRW8mJXAtpyab4AUFIGWoiCs6Xg6WsPVtudLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936161; c=relaxed/simple;
	bh=7rM6ipANT27ulRQJdHPgB/KMFu8QO3gc2s7q+k9b64Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXhVblahNl+QFLgEmU81OQ9lynRdqoozxWfFNyaIX0+cQ2vSk8eMD5b+eNS9M8on06Hqy/QIY2DmMGl+bdS+AGZp3OW9GxEK5YRw/7DhzHFHIK64dGY9hDnoFBCnkW0S+P7yjS4GyWCB3ZTLjHXcjbcTvXpbeGSjNYbammJPi64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cqDX+qAt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3108f41fso288850f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762936157; x=1763540957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLVC1yr/nkYxv5RM5OgIDp9oj0yRWmQJunkOHBdVjz8=;
        b=cqDX+qAtWNVu+9S0QQy84Cud+eXfAfxMj2gQUL0h2onk+GdGfyLkyLBk2aXhl4woG6
         88J5wpawkTzcGhJkHby0Lmc3wgFHzdgjdRFCpMl6B9sNBPa61ZpdTvA4JyKQKmGHQCCp
         ZCq84l0GK743TIzlISUgu6SzCBZZNtBq9xxlgIiwBBytF0z3+sPDX1aZH7RF9/pVmumS
         BQobX8SJNpgcxpRLpnV2WU6NcVt4k+oxdXzk4BVpFHDeTGuGG1eeJNpZmTME9efQnyms
         NCdVT94gj5WgwuQDgmklTI5XQt6Ax1AgBAjwTKfubTOkP76gEYyra145ygTrf4+uvGzn
         4/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762936157; x=1763540957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nLVC1yr/nkYxv5RM5OgIDp9oj0yRWmQJunkOHBdVjz8=;
        b=dkxJfFWrdxpDcF92kdR5rtwRO2axA1kK2UwsgxRGFBaiH5xtdKPgX+QGS4aSsXunUw
         2DOI9muH4zZiqNEBlblGeyx+mpTQpXkxY/6XL81nkHn20PYKfdD+uBuI9+Aq0yrYtAnl
         nTr+nK3eF3fQvD3xK5+Evlh+IOmZ+tMETEoUwIrVO20R7sV/sj+4qLyBP1YYfT8lz9WZ
         DO3FOj5eYmiAXGd5kIXB8fapBZfZi+56TcikxKrkHfny2PJ6pdL7muVp78sN+HAN2IMe
         cFc9o1QxBkmMIP7+QZQAKmROwgPFAMGSYrf3lGi2G90cs947dQKgDAHMLJNmH96Xo8LF
         Qypw==
X-Forwarded-Encrypted: i=1; AJvYcCXbHwZSOxy4dq2lpz08oItE6pGmFGDhuoiOqQpDfG5COqG36OoJx/P3WZbmPW2h5VBJ6e+btvgXOwh25JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1XW5CDUWSdprgfDbo3Xy4/oGXrnai5llYtA3BKMVVlqk/V+N5
	SKhR8V9++Si8dunp8NboIuOVSaZ1O0xb8ERRR024iEadeUXIBwbbf7kK1dakEdr+J7g=
X-Gm-Gg: ASbGnctxzkP5cWbh2zFi40uAEdNTtbuQwEBL1N9tcy/RY1+9WgogVrhoPN23of3MyMp
	09WLq62SP8BPYqdA7B4+U2RT8zhbAPO9oo2MQiL5whLQv0lRWYdv/jP/gaLwVkwN4smI3zzsI8V
	iBikkdkCY+wn5b14fu4x5buUKnZueDBX4kEzYrSGq2RVNtCLjF3iYEghluHRq9LfhzExzorJane
	w4Fx+TUqRH1cbuJBBpecjtqTV/uGIkgzfY21F36CJLqjbUu5DYXCQwlN14jJ0Bej4S3WxZ7n6TP
	Fyy/TQ0zn2xZEDbjwt9h9Wa4TKT5g8Mk/niC2C8z6Hp0LMY03HVAy/trVZo2Xlq9vlNXr4a69Ak
	4rg5+0lKWY3VCgagVZUxdqtpaGifzR6aKMxwUa4AL2UsO1I54wPL6KLssRBZWDAsJwW73wdUmP5
	UBy1sV6Lu0RpQYeeiY4C88A/Ympa1IcWnM/WvCRQO2ONXR47L62Zi2C2Oy3rCAbrOd4g4=
X-Google-Smtp-Source: AGHT+IHFW/GKxKCw0ILsA/SJT72Uei+QJ38/wrMr3u+rGJwwJXDKwY/90elYIzeiZ134HBFWWuCaMw==
X-Received: by 2002:a05:6000:40db:b0:42b:3c8d:1932 with SMTP id ffacd0b85a97d-42b4bba5627mr1678878f8f.23.1762936157486;
        Wed, 12 Nov 2025 00:29:17 -0800 (PST)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm31571428f8f.35.2025.11.12.00.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:29:17 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 12 Nov 2025 08:29:09 +0000
Subject: [PATCH v2 5/5] MAINTAINERS: add entry for the Samsung Exynos OTP
 controller driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-gs101-otp-v2-5-bff2eb020c95@linaro.org>
References: <20251112-gs101-otp-v2-0-bff2eb020c95@linaro.org>
In-Reply-To: <20251112-gs101-otp-v2-0-bff2eb020c95@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: semen.protsenko@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762936153; l=980;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=7rM6ipANT27ulRQJdHPgB/KMFu8QO3gc2s7q+k9b64Y=;
 b=Lurn43cxRReGlo/BJV58dAB7nj1wlW2HtMqDlBqeLRMi1dZmQeHSO44u6JwfT0f2fBaR1GlW3
 aM4MGm3X4kVDqVIjmlIkpfG2dt6YhPsVYTKuB/TqOfTIpnjc+5/W5gh
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add an entry for the Samsung Exynos OTP controller driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ab00eca640e02d40dd80949986d6cd6216ee6194..813a098475ab7d5371c811020ea022f63d1acb35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22775,6 +22775,14 @@ F:	Documentation/devicetree/bindings/mailbox/google,gs101-mbox.yaml
 F:	drivers/mailbox/exynos-mailbox.c
 F:	include/linux/mailbox/exynos-message.h
 
+SAMSUNG EXYNOS OTP DRIVER
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/nvmem/google,gs101-otp.yaml
+F:	drivers/nvmem/exynos-otp.c
+
 SAMSUNG EXYNOS PSEUDO RANDOM NUMBER GENERATOR (RNG) DRIVER
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-crypto@vger.kernel.org

-- 
2.51.2.1041.gc1ab5b90ca-goog


