Return-Path: <linux-kernel+bounces-864273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D10BFA5A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C5604F81A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF592F2613;
	Wed, 22 Oct 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IZF57K8e"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68542F2606
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116068; cv=none; b=m2x0c+a8ntgAqaWkMpY6OnR9VKTXr1xSupNFErTssdk4wzwconCwVTW+QGAln8WYfMY6r92coZd1v07lBPZAApYQMyL92HQwkjYk8jJgaSEGxw7WkAZIYxML7rSjRPNG8lmmWBe9abXTNH/B97m9au0D+BNs1HV87AKcPDAPIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116068; c=relaxed/simple;
	bh=Ah8PG5J743WoNYOxpQyKjv3h/CacudCbl+vpW6XErgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1JjZiWAQjZ8dJilA1AzhS5nsmoDJQIxZX+1K82z9g7xWkHT/aZAdigjwOX6p479ihaUjkvT3l98hSiMjt/4fFi3hDmsu30ICWzQJGsPE1RFOqY4sL7rConnak0lRPdG9WbpzNifHzKLwiGXc6NJrPx4XRfVMf3/5TEckUwxUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IZF57K8e; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-427060bc0f5so2166821f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761116065; x=1761720865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8ofwNtGiAL6AxuIGzZrtcIojpwaY7cB/ELuMg3Y+QA=;
        b=IZF57K8e+O2XP5uL26g4JPmSF3KlLdoXslJqCK8yUEqUKWEsVUpEGsii0PF15UZmaL
         BIlI2rekhTmn+xei4QE5xAvVmy+0y8zXMfUVYTft9qXHUzckUT2GBqr5cjApOCtLSfY5
         cjukzVtr6d6Pv3bHq7xhjGjIGWq41khjaFiNz9iULjS82ITDoGbJEc8NohSA7s+2STM5
         R6GdetKj7j8+qsxSQje/Q5vAeBm+EHu3TVCW3nI4DlhnmMNWoUkJrhUJCVOUqBdYKZR1
         trOlcOJbDUOAIZh6EED2/9Hyu1Mj54YMbEYOF03MljNlAd6Uas1/3sqrKnhKCCF8boP7
         tZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761116065; x=1761720865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8ofwNtGiAL6AxuIGzZrtcIojpwaY7cB/ELuMg3Y+QA=;
        b=f5Qca1J6yUW5SAKxvZrPHp5zkddaGwwrLZ5ldj5Ho48E/nfcR+rUG7LSJXM70cpK7v
         3aaPm+JzgwtLAaE9XmeONHbWu0m03xmsB8lYLIk5Ml9srbzD9+0Oz/Vo5rg8TC/tMN9v
         KJQWVwbTVh8p0IQKKDobMj7Dm1Q8uHU6+usVJM8ww1wwppNb1BsNQpXCDqVr/24NwbI7
         nE448EzLYN4LZ/MvDwgS/MjDKfFhGC4p6SA2OtuJd4VIHp4yZoI9JUreM5e9T3a0PSUV
         sbkeZqfNKriAwsosE3qWt1dMn+Mv1M+XyPZ+VQ5UZLlMIFt2eVSYAykq2aBDufXlNunB
         hasw==
X-Forwarded-Encrypted: i=1; AJvYcCVp8ySFum4rYiO8gmSWLk4ihdWqj4RWPuixS5HpuPhVbnt7zAN99fYrSiKWBVIdzaDaad0O0qcaETgxPsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33NXIlNfzO/0pbVKx7eemLof2SwA9gB6cjRERgNSkTANniGS8
	adMxJD+6eguOH3GYMCGes807m8iY7JbpZTjtDa4E9NDjKVkM6eSXPYdrwJNQs7wJfyg=
X-Gm-Gg: ASbGnctvYgVl9QmUL5shO/L+gCGil0lkAb+UjXk/VsfxzVYH++Wgsyu8+q0dTccCOE2
	lkcTa6ogTQfm6JxLMlWgntUEvSlKJJveBtNg3KTFRLs0s3L6vTkatZJZx1TwnL3owkqgdd1Q94m
	77uw6RBCB/9/iVuHmGkQ5Nd6BjP6YVEUERBNa2vbfJZEK9JkWQOrlHl0QSReYsGIXVgVX2WmaM+
	cLdwLAUKWY/X3Lh9z4i7u2ymmE8FwpxomPffsTHWdRiypthqhN27vBswa7yiPq08eDPRS4cEROU
	GIs3dnaYgps53cLeW11o6/8Wsp0mdaxT3COhdx/yoN9eOeNv60GY2B0opy9LOhCHsS5+wvG2oE8
	AVIxIRcaIFMacKegCQm2nw5GlLury0U6S8zaK28C8Kfsjc9hMZBI4jGIDdHB/Yd6DdSZGOvK24a
	e0mw==
X-Google-Smtp-Source: AGHT+IGeS49WdlsfP1XvLx4YQzh+izqkykPAWb+jEk7om9xBT2YfRwHS9OSz8bm5e5uOfp01dJD2TQ==
X-Received: by 2002:a05:6000:2881:b0:428:3fa7:77ed with SMTP id ffacd0b85a97d-4283fa778b8mr8595836f8f.46.1761116064486;
        Tue, 21 Oct 2025 23:54:24 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9f9dsm23722959f8f.39.2025.10.21.23.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:54:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] gpio: idio-16: Fix regmap initialization errors
Date: Wed, 22 Oct 2025 08:54:22 +0200
Message-ID: <176111605268.7660.15686618336635662485.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020-fix-gpio-idio-16-regmap-v2-0-ebeb50e93c33@kernel.org>
References: <20251020-fix-gpio-idio-16-regmap-v2-0-ebeb50e93c33@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 20 Oct 2025 17:51:43 +0900, William Breathitt Gray wrote:
> The migration of IDIO-16 GPIO drivers to the regmap API resulted in some
> regressions to the gpio-104-idio-16, gpio-pci-idio-16, and gpio-idio-16
> modules. Specifically, the 104-idio-16 and pci-idio-16 GPIO drivers
> utilize regmap caching and thus must set max_register for their
> regmap_config, while gpio-idio-16 requires fixed_direction_output to
> represent the fixed direction of the IDIO-16 GPIO lines. Fixes for these
> regressions are provided by this series.
> 
> [...]

Applied, thanks!

[3/3] gpio: idio-16: Define fixed direction of the GPIO lines
      https://git.kernel.org/brgl/linux/c/2ba5772e530f73eb847fb96ce6c4017894869552

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

