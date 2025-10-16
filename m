Return-Path: <linux-kernel+bounces-856379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1F1BE401A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39F034F598E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510D634AAE7;
	Thu, 16 Oct 2025 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MywwBi5l"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7F34AAEE
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626126; cv=none; b=J5rNWu0I/RsKGMQjHhSc10s0VZ51qkkSA39y4fYiEMzD5p51ukCyTkwMOqv+Vm6imj3Gpch+DNN0Z5scZCtgjIuzjzuWpfPKlrjvUKSOsx6gQdCRuKwq2JH2yMSlSaxWImlyoLdqZvDvjPR5ArHh2thC13ndNqsJDZh0FNQbRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626126; c=relaxed/simple;
	bh=fEYTH53YDZJZ8C2Er8bOzHta7ybr+V5+FzGrUdlcHBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDGmh/WP7CJlM1M75+UIZfDvxZRpa6+2jsnZ65Iwdfxj3eP1INPczMLBiw8ss++WsAsfxdfOxAbE6VgG3VWKgAtXvgM8yYy98lRCCIC/XTp1dW1HlMOq6bHk33B1Ndk0QgA5Xrg+GMW+m6JBHbRT9rnRW4e1a8ZWUvkTp4c8bS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MywwBi5l; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee1381b835so722691f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760626114; x=1761230914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il5/r0fmHwvIVU3+4q4zkfdvIMAREkRpbu6Q9Q7Tig4=;
        b=MywwBi5lmsOrpsCmmOV7nsIsxLrHGlTjFrIL4fvXm1GqGyoTm843ZETfE08u+w1whG
         Pd6itPgMW/hVeJSiobWZt4ZB/69aeq4PnEAvH0W5wWV9I++qCvK0hclteTx8rPbg0li/
         UECLKcUbJ6bsohZ9z0fC3GOby2FZtqSQVJOF76rdw9zc5NqUSlNHBUNrvu7aNdgfZP6L
         71UD1mDeKkrNLRX/brgQqU6sXugpZl+YIhHoSzEZkol3xU1yzH+ThXGULoSOvzBH049j
         wkgpLSoN4VA8Be25FHV1XILDwwuuyX486uJl6aWr3dkUEPrU1gdBFNPEOq6NuZppdUNu
         iiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626114; x=1761230914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=il5/r0fmHwvIVU3+4q4zkfdvIMAREkRpbu6Q9Q7Tig4=;
        b=LS37p5s/Z88ewa29CXpKLqxuFHPpYjOHn+vJVk0AncZBsgL31aSAMI7uySf9pzXbOl
         I0E0OivcgvhpZg9T966KBzRjRYn6HfmVilB4K9foO4zyaY6y4B3CLKMs9TS9bz/Ggzh4
         jDGhKVo+XzDndD96HHPkpH+JGN7gDNj7InQJIYBP/O1Yxm1WCAPo9zGQWZDUaOonvo2s
         dWgj9RM3ZdEzelfvaRjqu29L5oFKviiI5IPH8SZlG/ONBLW8biEu9/8xktxd1J/UDkmq
         Z8YE6qeEPGkTQo+Flu9skx+O70S3vHQOPS1D64h7496d9czN+Qlf3d954DdNWJkKEYDi
         sEqw==
X-Forwarded-Encrypted: i=1; AJvYcCXB4dovJ34JObyVmwta6HO1Z4V7n+ugVqN/jTwmg6cLMJj90Ge5zDXhW34I9k08u5m4Ddd5Fh2Hju0XFi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR2WM0cukzyCihH4PJLov31rHpKvH4h/2P9VJEAQYTfo/39U1N
	idIuh2CJmf7wkJqANH6TC9kkcsiV8/g0yw/cUHEysaIUeYymuf95FKrRr5qUVJ8JJYg=
X-Gm-Gg: ASbGncsgwb82TTF+5GB1WiudMnveACygAKypobyKl+NZ8FnMX4/ZLgV5B2YmtIC+U5l
	9ira7xHCvVxx4iL9xp5riVqlvt/6oHY9crT2iHdx/3zCUtAeP8uDoyHETsgOes1syJZQ5TfCABk
	UGpC6VxmjsWhVFwgOPJps39vIwO8dFG1zHb9B9KunG8HtDgqBXo7KqFaOLH1V3qyvPIi9iSh0jN
	9A1/0hoFAg4VYGDM9cOKLN5GV77QRuGkYziBurNdNiKOOj1kXKLWLZPRknofX+fmglzN89XKTPg
	s6I99bbgdMMt1q1EOnDiIesfJCuBIvgdruaSfUcCZdusmBKjBkziD7XbaVI+vJ3327pSGXk7sE+
	JAShkvjZDdoBdR41G2YgZeuphdmJMI+/0PTNSChQBYVBdCmdXhqFbpPUa8tsR6SBZzoN24FmcW3
	EHVQ==
X-Google-Smtp-Source: AGHT+IGU+UUv23rPnRMVt1yR35zGCx+QFDbX2GlDTl3HK/z3KL4fSupr6QTfss0me53/F+Mqd2QUFg==
X-Received: by 2002:a5d:588f:0:b0:425:8591:8f5b with SMTP id ffacd0b85a97d-42704da4b6amr311746f8f.59.1760626114003;
        Thu, 16 Oct 2025 07:48:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ef97:57cb:86cb:f7c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426e6f03a76sm19507158f8f.36.2025.10.16.07.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:48:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-mips@vger.kernel.org,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH 1/2] gpio: mm-lantiq: Drop legacy-of-mm-gpiochip.h header from GPIO driver
Date: Thu, 16 Oct 2025 16:48:21 +0200
Message-ID: <176062606134.122017.14455806740339775356.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <c7415e2870b3bd9109f95bab3784d48e708e30e6.1760360638.git.christophe.leroy@csgroup.eu>
References: <c7415e2870b3bd9109f95bab3784d48e708e30e6.1760360638.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 13 Oct 2025 15:07:14 +0200, Christophe Leroy wrote:
> Remove legacy-of-mm-gpiochip.h header file. The above mentioned
> file provides an OF API that's deprecated. There is no agnostic
> alternatives to it and we have to open code the logic which was
> hidden behind of_mm_gpiochip_add_data(). Note, most of the GPIO
> drivers are using their own labeling schemas and resource retrieval
> that only a few may gain of the code deduplication, so whenever
> alternative is appear we can move drivers again to use that one.
> 
> [...]

Awesome work! Thanks for doing it, we really need to keep getting rid of all
these legacy intefaces. Queued for v6.19.

[1/2] gpio: mm-lantiq: Drop legacy-of-mm-gpiochip.h header from GPIO driver
      https://git.kernel.org/brgl/linux/c/8d0d46da40c878d082b92771355faba8036aecc7
[2/2] gpiolib: of: Get rid of <linux/gpio/legacy-of-mm-gpiochip.h>
      https://git.kernel.org/brgl/linux/c/eba11116f39533d2e38cc5898014f2c95f32d23a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

