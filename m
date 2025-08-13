Return-Path: <linux-kernel+bounces-766130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26358B242A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6983A1681ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA7723D7E8;
	Wed, 13 Aug 2025 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="K3RbWvwU"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFE02C21DB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069827; cv=none; b=sSiQJvhXF7aNS7321IlSCxKWhs0uqJCS0TLNRiXsgd6vv+5LLjgUM7mkJ9h/t+K/tH+UG6XXEBKmuMdCeWYVUHCwnJsqRY3eW3myrYWBtMJkNekEG6+33CobrZJYhir8yLk90FiyFAsMNbkCRJe8OKbs7ujm2FioiK2X+Nl8Pow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069827; c=relaxed/simple;
	bh=bv6DYqjwN2D0DlDYGPWLKAAmU2xcLODMCxxOZH6IMlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8iusFrJO2apU7LpdlM2TB7k6ekdZaI4wJTIcit86lhHXvl/GsUqKK+aEL//mESIe05484fbO4+7figKcx8YJxbe6ru5C+Dk4XKiIq+d5pfNWLlDvepRjL43reRNlvA1gwcfUL9fEr3io1HWjiQXUB1nnwW8Cp6kU9CJtuKrZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=K3RbWvwU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b7920354f9so5102603f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755069824; x=1755674624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WATivFrievb3I0TcPTJrTrvyez6QlhkHAEe8TBXKLU=;
        b=K3RbWvwUUe8d3b1jowxjvceKbI9g+dzxeqo1pC7qbUpHA6qKtbV4FW7akwL18hmOM2
         37jgdCdruRysdghvmPBKViC6uPdiCGzXWEj+msMcodur8LpKGr4oUOjadb0tLzU7Ma/B
         ur8mbLxBsb+mkmmaI00J6xTZrIFXQTEOpDKkP64A+lrsJs3fYwgWeIN5r11LhnASP4vn
         LePMpDryDPHs4XR+hFAJ0gDVlyMxB7NA/yrTzAeJbuS0ZC/jkJ3AgoyNxE9tXg/5vZkN
         z7GkkdQDv8MljgGPAQrv47nVOQly3HSl9oS4+FC1CqE0vDzh/ozDoHRQJIVtw4LhG07f
         ESAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069824; x=1755674624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WATivFrievb3I0TcPTJrTrvyez6QlhkHAEe8TBXKLU=;
        b=hI45jAF4neF4NfpNztgYBTk0slXNNeoTQrALdSInWoB0QdZZXuYRnwE8G9Cj9qq88I
         uD3CikCfGeNmQR3EMx0UGExuMszkWPzoh4LmC0uvsUH04Jhm5AvzHC76Ruaut8xRDfF4
         /7sfygnpGnB/IBplA5ZzoXTxmKAGl3zaSuuZcdBvR0svDsWVahn+FpP7YH+wybnhuPzy
         RyA041ATgZazF6DqjqeEEEHvvTLHRCvE2Z0toqm7MUlprM0q5OzEsXnN37fSpLdv3ggL
         dq7tlrqEBsYaC69hU2+HWTTXoyAYt6793Etf0lbjaNh44WXIFTD1qv8iWOSQ8YO5HvvQ
         DyTw==
X-Forwarded-Encrypted: i=1; AJvYcCWIINEclIFJIBKD6t2NW/d5SevV5zhnDKKkeQ/kW7VH4tPM+mUG3cYJwK9UmMIRIfPRKM55FCBvFHEWy8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGzv++drBkOvFvYl+vlVmaU4CUbclFdV5RBH9yhOUo9XwRkkzB
	2r2cJ7Jl9P45IjjcTdIckNJPuLl/60jUF3bhCXQsuY926a2mtyHlGBIzOGAGcDbwGXw=
X-Gm-Gg: ASbGncsEdRJgloenmaTOlrrhNWcTST0o53J0FMGCrWguDhPz9YeEABxEQ8xZqA+FBVq
	gsl6YBRTzueCrvLk8KllScFaMrzZDIYVsnZrWowrcPzPJgfVMC/tMG0tVVL8w6cM7yS3g+J+Ufm
	rXHZEsnzx2smCCwS1acwC2ZiKCUve9b282oo2DpAonEKfDmTIpqvUs/5WwdD1V38YoJtKTBHE3L
	UUj3RplWoSS9j0eaATsBKlEfLMxzX9h4eN1PyudiyewFBV90Tmp46r7I9fHkKRtxyinJAoFthd4
	3T52B4t8CevW4XL60SjT1sArIoyLllCnogM531qwrBwf0YLtrz4rVhpJWKXyG3tflzz883RU0Tu
	Hu7sGbaPUJvJHwtoq/k/Xv13c
X-Google-Smtp-Source: AGHT+IF1MjcUvwgYnjulLvHKgyfmZ4E6I3kIjMN9y8mrIIK3WlP8h9WdbRGmZ0ZNF9dbobExy36HTA==
X-Received: by 2002:a05:6000:238a:b0:3b7:76e8:ba1e with SMTP id ffacd0b85a97d-3b917d29ae3mr1458813f8f.11.1755069824008;
        Wed, 13 Aug 2025 00:23:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:74d7:9082:2b54:5348])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac51asm47740936f8f.1.2025.08.13.00.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 00:23:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Thomas Richard <thomas.richard@bootlin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] gpio: aggregator: Fix off by one in gpiochip_fwd_desc_add()
Date: Wed, 13 Aug 2025 09:23:42 +0200
Message-ID: <175506979055.8476.10658684000717777329.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <aJwk0yBSCccGCjX3@stanley.mountain>
References: <aJwk0yBSCccGCjX3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 13 Aug 2025 08:38:27 +0300, Dan Carpenter wrote:
> The "> chip->ngpio" comparison here needs to be ">= chip->ngpio",
> otherwise it leads to an out of bounds access.  The fwd->valid_mask
> bitmap only has chip->ngpio bits and the fwd->descs[] array has that
> same number of elements.  These values are set in
> devm_gpiochip_fwd_alloc().
> 
> 
> [...]

Applied, thanks!

[1/1] gpio: aggregator: Fix off by one in gpiochip_fwd_desc_add()
      https://git.kernel.org/brgl/linux/c/148547000cfc1ba8cec02857268333d08724b9cc

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

