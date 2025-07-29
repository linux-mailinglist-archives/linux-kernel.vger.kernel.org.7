Return-Path: <linux-kernel+bounces-749281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B3DB14C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863287AB733
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C249F288C85;
	Tue, 29 Jul 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U2KkoAh4"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF302288C34
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785397; cv=none; b=lvFPNKqS1epeIShR83BqCvxEz6xG9zTYRoOKSvYUir4GOMxr+q7hcwE117v7h0s31ld5VrigKnCp7e/x1/6PPDu5cK8pJHi4ZWyJmLs+Q6bKGuTutIUP8Y37g6Y5x6LKF95F4MCnojuNRtBk5uRMqQs4WTDLMBW+mZl/QoTL4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785397; c=relaxed/simple;
	bh=kStrKArnSK1/UpquxNxJnujQbThqDJu1NL9oxLvTxtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCFR+3+M1CmGRVGV40km65ToQyjoI7mUuYkZieRodmGZJ2EZXLpyOqRhkRelNd7Qw4qld+//GIw4puQDuiGg9TKvNKDmERQmHr/eghxqERSHpHBwFbZ/EgGLp31JyrezJXtSho2KcbGXFt3E+iH8txu/3srjIal1blW++8gVJCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U2KkoAh4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b77673fd78so2610739f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753785392; x=1754390192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3/Mn3OWGfo9s2BHWZIuyQwZlVzznOtE4mN1WG8m4Kg=;
        b=U2KkoAh4HSnbG9f+3ZAzw7SpbD7zyeBc/JVAMu1kZeB01gOik6GcGXq2xa4V9KYcmC
         dCjlqvT42OQTZQTucHGL9RBhdU+SEWudGx5GJjpa8UeGb7TpNLd4PC6VwRw9BtItHICy
         bwkwa+jW+FJdXzvFhEf1VEAGvzK3frr7XL5RPW1Ymz173dtyQAk8S09Oft/YZCft1INN
         Ml/PKn3im0psAAtBCZG3YjgTZ6hnIOCrbBRVLPVr2qOjD6yOKXrWU0seKJvF0F6ZXsWI
         DQYN+kzEyH3PUV3YSOaNtj0abspIp8opB4x5lY2atwtIk/e4u+1qxdB2hdPTFUlZbLWb
         9yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785392; x=1754390192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3/Mn3OWGfo9s2BHWZIuyQwZlVzznOtE4mN1WG8m4Kg=;
        b=F/sSwkweWsNtLZEWmHh4weZZLIjeESWOKAVaXnhnwCYpxeVWTOORSnIH7RXFB3dtmP
         dCWbqKjrSNse5lakyPqEpb+B6rWf9L9Tbzls9uB/0Hd5BslBUOvrQtzdW3SLS+/rc5w1
         SDmKh8IB7D+aVRNHbhcjSUCZB//BkxpgWgpcT5G+JIeuYE6evgrQI6ob21LG9Z1ts2B0
         bG0XgMZcjuv7s2een000Q67XFAOJqPdKI9xf1OgtmWsttcHI1Gq7L4p093DJamckgJDB
         XUuv4WZt48PJgtvtp8ldXxcPtMdvZY6UFKvc0cZ+zjl9GWwj5gh0JYuOWD08eumI8F8Y
         ObiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfFnRnFIZJM5Q+J0+1kF/c9o6xQddsHNmGqbUCjOsnf/p3cxGLw3Td8jepxKwCklJivohabzYMJuIh5n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzsRNBhZ8Bk3hRiH86R3PwYdKVGIqHMzGXKkyMdIyLFAq2+njZ
	UdgLg20LrpMddBQQTXZoDLVAeBN9Tn+BsQDrSbFRG/uMvIhkIrsUYBlWXEcQ6ORSWdo=
X-Gm-Gg: ASbGnctJ3mLP9Ef9UCoP88v25OZESj9rNo3k9b/4j+cM/LFQ0Vzn6UDtvCerN9nz33x
	7+op/B/AKAQfPuSiJhbBz+utM2W2PwXSOWtGYznwj87nPl8BRSiqZx9i7Ua7wi4kveydx8pvv+E
	NlI3TtpUK6nwsCY759kl/o0ZKCaXf6qc552eli6cy2LWilcMrPfMKL2qneoP4GItlFhrzxAGG4V
	WdonBAhWCfGg/G4/3Yhw9ZSEYzGkAK7wgc9lzyPM8fi6+fPCkoiyRuiXQ0KUj6CNQtEaRZjaonz
	sYaHWcwDvdxV9z8XRKWULHYFaPCZhJJA4ihFa2BDwAkV8FaoWR1J+bpL/mZYn0eOetS31wXdWKL
	VKzrouP2MS6HdaP81vVRmRuXNuz1koQ0wIHvHXc0VKlNIYpcpMGrMy9kRlqdNb/Hn
X-Google-Smtp-Source: AGHT+IE866eWL+zj2Yu8ZEdG9Leib9gNx0Mwqy0baoDrZCSd8lBpM6cprNsV7mZpEagWPWAeeS1z3A==
X-Received: by 2002:a05:6000:2502:b0:3b7:90db:aaba with SMTP id ffacd0b85a97d-3b790dbb162mr1187849f8f.24.1753785392003;
        Tue, 29 Jul 2025 03:36:32 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458705c4d91sm198068015e9.23.2025.07.29.03.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:36:31 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Jander <david@protonic.nl>,
	Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] pwm: pca9685: Don't disable hardware in .free()
Date: Tue, 29 Jul 2025 12:36:00 +0200
Message-ID:  <1ee1a514aeb5f0effafa2d6ec91bc54130895cd9.1753784092.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
References: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=kStrKArnSK1/UpquxNxJnujQbThqDJu1NL9oxLvTxtY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoiKQSiW076lomyIjFfY6Xd+adPvN9z6QFCZGEX BJFLG5Zot6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIikEgAKCRCPgPtYfRL+ TloaB/4mI91CeVM7rRzxDsC3YKZtJBVuRHvjeMIOPqWBPmjd/4YL4HqEed6Xqnspkb+6oMhsbAP 69wxv39m+Pv7CSIBI7xHlNuuudz/0DrWDM3eMQweXTwHUbQY/4W9DhMVk295gX1Yhd9IY5LVf0/ YECw4MyGSvS4V2gespyBcWJY28geG5y5Qukd86MyCPyuYnTEtT8RewWk5KiP7N7+5m8OvcT7rSO ZpNFf/9LcZ/SzChNlxmPJi1F74oRnAqNYoFDmrN+qE3rhrymKf47TwurdQUMWSSkmDt3hHOlE+L 7ckDwnAjYPx47kWpfAwgTkm7RX3lWpkv2Ea2SaF0ULsMkBLJ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

It's the responsibility of the consumer to disable the hardware before
it's released. And there are use cases where it's beneficial to keep the
PWM on, e.g. to keep a backlight on before kexec()ing into a new kernel.

Even if it would be considered right to disable on pwm_put(), this
should be done in the core and not each individual driver. So drop the
hardware access in .free().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-pca9685.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index eb03ccd5b688..41eb8e034828 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -497,7 +497,6 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct pca9685 *pca = to_pca(chip);
 
 	mutex_lock(&pca->lock);
-	pca9685_pwm_set_duty(chip, pwm->hwpwm, 0);
 	clear_bit(pwm->hwpwm, pca->pwms_enabled);
 	mutex_unlock(&pca->lock);
 
-- 
2.50.0


