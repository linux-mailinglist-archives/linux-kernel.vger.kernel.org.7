Return-Path: <linux-kernel+bounces-880187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02818C25140
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51A614F4155
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3AE34B69B;
	Fri, 31 Oct 2025 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r21dU9u5"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F88B348445
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914727; cv=none; b=q0aEidM+Uq2jKKWE5kep4336X++roWas3JSWzRTnDKnZUKEyHkI4wVXOep3q997kvLYdx4756nJDRBxb01d5lchHFkZEa+8CKPPWRnoza2mKd4tlr7vMzddq0BA8A9NoeEcMOg6D5UH1aJSzRQhvP3MzVGTa/w6JplHSpLkScv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914727; c=relaxed/simple;
	bh=BRKY3GPe1+dBZ+eX+MLZ66l0mvit2jHge4hZNEeZzx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m1wP/exqV4NYwE4cBmtcWXXgHCiTw8cSPk65hXZWZor2zId6mCyjyyO+gknmcaN1Ieww/nnqL5eqnrLyYQLnO5WxnmA5zKTghHLe1yrF5kzI//V7V9bTHqegxetk4jOFfgEfqRLdG5GL2n74oJOmTY34aCLwJ5V5xLb2hFeeQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r21dU9u5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4770e7062b5so15853675e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761914722; x=1762519522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEEzVDPaPo+3opvcFtHcUqZXHRFcLJbK7RKFKgESsWk=;
        b=r21dU9u5HEoMAYmQNFOUW09/rZPM+Lo098a7nuG0KikNfEMxOpMnWox0ze8t/PTvQo
         7HxhuWMr4vZgfKUPQyY5YHazN6599J9FOzstFgRniveYbdZs4yUBddCU2c2gqoWK6d+5
         iTi5tmbdStm+lYGk2sSfhT6x5fefKAInGjHiNgpJHaCExPrjxNbx+KBgsNLivYNt6N4D
         kLuOOy4Jm7bpBefJtbmGn5u5yBz+ye1YSyb+hK39PUsDIsIpTBuZNV+pQbAWxF8LmoH7
         VjfLpvQpHMTlib1aTTddMY/F31s0w3iwlGWCnBV5Gvyq8KApYR/rinCoSk/DuZVh3UEM
         QVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914722; x=1762519522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEEzVDPaPo+3opvcFtHcUqZXHRFcLJbK7RKFKgESsWk=;
        b=STvn578IwrsKjxea+J0+XkV714+I4y1s25TYzspqy6iIMWfCgg3cJDiG0Rl/raFNBg
         DC+mfffkuIZQmsC+N9Jofi4mwr7lReB7j0B3OUXlqmLCGPoUmpXqFuhCtk+nsHr9fUd2
         vDTOCthbJgN3oIhtPRl+/SrfzmzjnEqlIThbPyB4mWs9AFhno+2Aa6kEjKnVN62HYOrB
         qEyJHVT1GvmTtXw8ehArH+qJASF2ghmqZsBQ/W2Hq7E1JjtCWD/rv+IDqWe5KOKdrWS7
         tFSD3054tQeQS47kJK35BddS8OAxvRsDoySv20ESJprXsBxiHTsz8vsadavQCweiArsG
         nn9w==
X-Forwarded-Encrypted: i=1; AJvYcCXKseKLSEkjxG8YmqPQSM5Lj9ur+A/zpLgikbo6Dl/+8Ov8tDT3rUFOgMiqCWkQpIdCybmTnMi7ex/0TI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqdGA6XJ6FxMIHbjDjuLhPJ9TzKIBhUG2fSD8zpVO6tOtptk/W
	dP+oMjV3UK2bhJzzQ46WkSMl1yZGuI5m192R13PYsgFLdPKTJfxpOWrM3qdYL5pKeZQ=
X-Gm-Gg: ASbGncuDoMe/C7GU3OuH0U01P+7Sxaf9e5Zb6Z7r1WCzNhDkXAnfOJ4uKIjJ3so/aRn
	1FFyHGT7NZ2hKHo5Rea5gv/RuXM3g4uja7aoL10M7hZafvVHhkgswVRWYr6EtoqpyZD/QZs9ubI
	T9mWk6y9ZVjGM2iPtmH5OUSSUq9Wo6chc3Xr9bp+49OFigf3S1ad6O3c07UFTk5auspAyujJ8MT
	sMZ3zbZna6O2Ftg517VtnUd3ghGB05MDWJ30/5N/B9Krc/VgtrxWUxmYtsJ8vLYwJggb/y7AWwC
	37x1mbYU4LQIy4vJCxGdgZBYmcJcxc0t1U+4cjLMjMGvfo4DpSoQn22/A7wi+pGFiqmrr+KM+5C
	fwa/eZYuakcryFWP+J4lFTFwhbwPyDoeV3AXXCfm5AqCv2A2lX+eU6uPiAFrhVTikpJaG++zy0S
	sqUCtfrrIcDsmn9oAuE1rfBHIcpjwHDSNgdPGetqpbsvV2uBp6D1vq
X-Google-Smtp-Source: AGHT+IGudjMOXqaJcnSNpcKIftQR6nLMDH8mkpNCYaYHTE5PBNCG7YLAiVUUFPpv+vByeUUIkYFsMA==
X-Received: by 2002:a05:600d:4393:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-477331db3ccmr15144245e9.3.1761914722313;
        Fri, 31 Oct 2025 05:45:22 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff7fdbsm31077535e9.16.2025.10.31.05.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:45:21 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:45:13 +0000
Subject: [PATCH 5/5] MAINTAINERS: add entry for the Samsung Exynos OTP
 controller driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-otp-v1-5-2a54f6c4e7b6@linaro.org>
References: <20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org>
In-Reply-To: <20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761914716; l=979;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=BRKY3GPe1+dBZ+eX+MLZ66l0mvit2jHge4hZNEeZzx0=;
 b=kaB+fFcB2Da40OLIuL4pYpifdRadcaa8Qg7wjSD6cQePf9r8H8vzcuSNE/jhnhWzXLFwTTsAf
 ljjUdOxSwlEA3FtVZA0GGk3QXkQ/RXgqhsL3tx8kww9VrOB6mnl68KR
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
2.51.1.930.gacf6e81ea2-goog


