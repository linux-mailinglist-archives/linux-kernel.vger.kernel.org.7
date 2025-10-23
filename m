Return-Path: <linux-kernel+bounces-866901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F4CC00F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC7B1A6025C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA79298CA6;
	Thu, 23 Oct 2025 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uyG+8FMJ"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FB30CD88
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221153; cv=none; b=Cr9tG91dIGdwYpjOZG5/kfu6boxvzbmUEGOqrCMFe5oMZO29qB9tmHgLVHV4F1PjQeJm+niaouSaMma/E+TbXRaGBwUM0f60ODhZau+TRJFAg3YZh2Aq3iOWIVJtn0M49s+pdBeOXHupfsgfYazxyrID73svCHfhzQsteyCSXpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221153; c=relaxed/simple;
	bh=Iw/i/voACEOEUB0dl8Hwa2eGsgmSTL3oU67E/m1QVYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/gB7896mWRmi+rPGaP0fsrC6qghMeQwnxmPYYBnivgEkj0nPq65/9VxwM0wma/NPLkGlaXnuB8Zf7dY4sLA6nG07OZ7ISPlEQKXg42itq/EQ9c+25rX1O60kWbcGeUw1Ui1vJEJv/4koK0LOq/v8OjkhyP3F+9DsFVZoXDva9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uyG+8FMJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so610403f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761221150; x=1761825950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+knHP+hH8wtFXL9FrX8Adjy6J9Lu8uJnSEg3TGlm3I=;
        b=uyG+8FMJ0sbkNL3nSa3XQOzVI9s2QM7VyNyk9i5TN/UqebVdXbkmHmklYMIX3eodcS
         XBSO1VX/OK+f4qVrfG8kWhp1OaiLxPQ3tNtH0Of5rSk97HhQHfI7LUGoXsXr0OOYABxD
         Y1IePlPMCdWYddBRTEIzxzfyttWk5KNnBeUDrelBeopSGRQ0O29PV+qxrGSgqvRH1rdA
         Qe4GD8ofcIfS3+7PTbQfNzTnsAuqpKJR60NsgDuBuloKnl+3McuZP52DONiXIBux8Vfj
         /27dJ9qYsIkS2fxxLtrORNpy7X5iL4CQbYOOxvKZLV0kUTSs2ZSyK9D42ytpjKLHVqU0
         qrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221150; x=1761825950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+knHP+hH8wtFXL9FrX8Adjy6J9Lu8uJnSEg3TGlm3I=;
        b=LaEmWoYwAWRG2eCwXjmlXkJgmVItjvQNMwNhzeH6PTwjaMHj9u0OktUyLhsMjPD4pz
         +u6TtzUty1sEyS8qoU4yhe70cQqQXbRN/aXU5uYtSJ4h2eJXmLkEYFI2Txaq8F68wGmd
         rQEOYNOmujyY0AiZRDgSwFjC+1QJBzLA4R6lNlUMl5TvhXpCaRbTQOBGayEHfQvV6O62
         5OPcKDPc+2RngZim5WQ8p/Y6OswsloFNnKNTeqVDSrgHR93/NR3e6S6lEHkLD0DWhDKG
         RzID/kgJjqHLlFkjwC2iZ64lj+TzlGUhuNN888cVWvuPHogQXNXFKnlz7Q8mjog/FIyd
         GAHw==
X-Forwarded-Encrypted: i=1; AJvYcCXNe5j27a0BqIeOGrWEQoyxTX4L1xBP2wILmNY5jLNeQZqabWC5Gsv835tSq7X5Dh1CpSAQjKk5TzXUiPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyscyKq5nh6OYU8to9nrEqP4aVZnRUhia9L5DmCETwHy6LKe5hA
	J3j+dhO0oBUhhiRK/itH2G/zFFLJHi4aZk1SVm+MA/7lrh79QND07YyZxjyW9PswjLM=
X-Gm-Gg: ASbGncvoeQ8JuG7toNZHBHOoviFse7sZSnjzG56TWBgV6HqQQOKTO7jqvMIQ+c56uvH
	XMT77htTaaFEgRVntFhyjxwZ2q+R1UkdBDYoOsQCNfSfrK+w50qnib3+QCRskiSuiil0KvH8fxM
	3xnasqUjhXOgJ14+n6PdnHxDBEkxW4JSx405vKKwx3lHymloE30mfiw+5OZG0vLdHSnHH0n/Hyy
	Z3LQ+QNIDVkE3ux72NG5l5eId3XEgMOGLA4nc/vSzpxkDwQHDQPlIdp0QkwNfGf670wr04TqUm2
	nH8ffUPgKb2Z6X/W8wR52gYThUBKQEmk+doyjjhrMgwRsUWGf5zvrls5t1mP8nWfPStgoF9fxan
	t4gwpYpM90faytAbYK2PyEwXTRMyQZnpsyMtTNCFNPpKxZaZuSRuPvmRJ+RjQPD61oWbFnJVvwS
	WftLxdXhocG5tmt1gbQH6BnA==
X-Google-Smtp-Source: AGHT+IHwJs8vP+ZphKLVg8Qnj866Tn55HPAEvE8rihx7f3rOB0WHPIdkAlWdTCpxtTyY9j9MwN+iRA==
X-Received: by 2002:a5d:5d10:0:b0:427:7ac:5287 with SMTP id ffacd0b85a97d-42707ac52e1mr14432699f8f.34.1761221149595;
        Thu, 23 Oct 2025 05:05:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1b4:e02e:c538:6feb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e763csm3719949f8f.6.2025.10.23.05.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:05:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Michael Walle <mwalle@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v6 0/8] RTL8231 GPIO expander support
Date: Thu, 23 Oct 2025 14:05:47 +0200
Message-ID: <176122114012.40841.4682534085501812836.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251021142407.307753-1-sander@svanheule.net>
References: <20251021142407.307753-1-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 21 Oct 2025 16:23:55 +0200, Sander Vanheule wrote:
> The RTL8231 GPIO and LED expander can be configured for use as an MDIO
> or SMI bus device. Currently only the MDIO mode is supported, although
> SMI mode support should be fairly straightforward, once an SMI bus
> driver is available.
> 
> Provided features by the RTL8231:
>   - Up to 37 GPIOs
>     - Configurable drive strength: 8mA or 4mA (currently unsupported)
>     - Input debouncing on GPIOs 31-36
>   - Up to 88 LEDs in multiple scan matrix groups
>     - On, off, or one of six toggling intervals
>     - "single-color mode": 2×36 single color LEDs + 8 bi-color LEDs
>     - "bi-color mode": (12 + 2×6) bi-color LEDs + 24 single color LEDs
>   - Up to one PWM output (currently unsupported)
>     - Fixed duty cycle, 8 selectable frequencies (1.2kHz - 4.8kHz)
> 
> [...]

Applied, thanks!

[1/8] gpio: regmap: Force writes for aliased data regs
      https://git.kernel.org/brgl/linux/c/ed2bd02d24947e36c9438bee1449d9bf87671b16
[2/8] gpio: regmap: Bypass cache for aliased inputs
      https://git.kernel.org/brgl/linux/c/3233741c0be59dd224e797deb2dd1621695ac95c

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

