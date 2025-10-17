Return-Path: <linux-kernel+bounces-857476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC0BE6E64
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34013A17FA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FA03112A0;
	Fri, 17 Oct 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FyWsD4Uw"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F530FC3D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685151; cv=none; b=k7yiIHdhEUfHtnBZWT19a/pS/ZckjK5I+sk8GHcHRE9cWEUUKDQr751L/9rpjM1OnrLp7L+KSbcQ37Jg9eN/nxM+CjpJFxKe9JJa9bjK4PRZkHuc3FXhzqxqz0HUQYS3fSvO827XjKUI4kZgYj6F+R/DXU58jzFEiStBJVR+FW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685151; c=relaxed/simple;
	bh=25YUziEhf9uU4zAhrMwI7Nzd6K8Li1d73QSpIFvWNy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0Uv4F8gHihHv0qUqKhSIZpJZbm2K8p/aX64Az4daeuHdUfcMJ4Y81S2cvPlYUf3fu/181h2lUI5PCtA/6aoGAaRPubeyv1OW2mgc6R7R098deHo3HG20n/66d9c/6n+knNwNf76tnwAi1QdvT5B/3WnBmbjvcA7K73vW7NHDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FyWsD4Uw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-591c9934e0cso1811280e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760685148; x=1761289948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25YUziEhf9uU4zAhrMwI7Nzd6K8Li1d73QSpIFvWNy0=;
        b=FyWsD4UwUsYXqKuj+6OHL8sM15xUnl/aRGH9KGC3WPoUXNxbmsrZ7Iqhq4UJhqkevj
         GE2OUwBSaGqqmRen3P/7lAzvmQk1ujQS2MgKFSmW0LOTtrDNNy/mvfuz+l2BBe1tqjB8
         Mk6weoPuxdW1lCUq1wDyzTAZtdaUWOS8cQscukLNPhnF5WVA0BUcgNGnJS8Mk6hSLvfb
         QdPWmaOw9xa5INbayYaoIZtZBjhOlUiC9bEkGyL5s/fRAia5z3iVth4YjQ3o4lnlt69p
         T2hIPhsvo6Q0jRU11R5LtSH8YpZoo80Lr9Wds5SFkmOITF0SLmjxWh+gczBxHHmEnhk2
         wyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760685148; x=1761289948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25YUziEhf9uU4zAhrMwI7Nzd6K8Li1d73QSpIFvWNy0=;
        b=lgHyPBLBwvK63nh1RAh42Hpk/CIEhBJFUNDkCDwXm1paLK0NZUxvqnuL8z411bYj+Z
         dAl4/8+b/YpHdzoWtQmK/fQ1RwXLPIwM4YzZDCxy9Uf+Ds3TNa/lPLIu8IXOu2SoPxty
         jvdwBvW58dMRaOtucqUvn1jcniwinBy2jJr83q49rWyugcRlGUvzAIrj8RqT7hg8zg4n
         x8hpjnRy6CuBsHJQAmDwtnpLzwo09nXkUWeEnRX48c3BFno5qyPcEDvnnJkMuthHZ8rw
         POBHdgydTTlJJcUgHF65d9+s4wZu2maSyaA7u4Y0A4eyTv0rzZOl8mmt5oKl9wzTzOCO
         YmAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfuw3ydORAeSBfqEfwFh8CcXH7OROGhrM6OrfaeLgr0hLfBEVJs3V/HOYXAgzukp4R89pB24ANG6MMTsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+kBTEvsWf3lk0eAoIxHuRBccSmzy+qh16VPYlEPJewBIh/JST
	gi9Ma7N5mCwup8f4TPgdKSm3tC7UvZY5QbZTL2yodWIOeJCsUc1Ai0jbvWwgUJF6rlplcD+VJbU
	dqtAASv8lQVqicYZS0VoaG99X1CuHZhTqr/4JSWV89w==
X-Gm-Gg: ASbGncspWzVLFQ6y3hkjTm9Ic/t7yIiwluGgN8orrKC0R5igYGPA/s5JOafbrU7ZhAf
	uf1PnxG5RkkJyuM+0qHSp+okVKNG11JyWfSXSfZSIPptnLOi4i/pUJGSZLjxqrxCiwmH3hGd9ss
	dKzvQjgoqimeR5PzsHGt15Q9NJzN0MtwrPCJjag4lJwKxDjsuxmzH/HOr4GDwtD8Z8+YqL4o/YB
	/hqMBe6ocQROg4Ck2nt9bsFh/RlOMEYP+8+Qo/2Sv1ywjAmJ43GYGAr5U5+/vnSa6i+yxRr5qhw
	vqygzJbgZj7xJ5Mq0FKbI3YlEBt1ThCAc2cdsg==
X-Google-Smtp-Source: AGHT+IFxsGx5ftXqLpFiYlA84nFq8R9lxAW0hXzt0jnPlbVMKUOA3s65BQF+cV2LW4ytM3YBAr0RQpHCOIZdAc+N9t4=
X-Received: by 2002:a05:6512:ea8:b0:591:c346:1106 with SMTP id
 2adb3069b0e04-591d84cee43mr889809e87.9.1760685148094; Fri, 17 Oct 2025
 00:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
In-Reply-To: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 17 Oct 2025 09:12:16 +0200
X-Gm-Features: AS18NWDblNzpuLCnzeXon3yTi_RZXCYBcRhb_slg09UcNYGLrahNCin0h6f8tMA
Message-ID: <CAMRc=Me=atAoPSGdTOn32rEHh3djTSVveYg0QYxYdb9yivy5YQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] reset: rework reset-gpios handling
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 3:00=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> Machine GPIO lookup is a nice, if a bit clunky, mechanism when we have
> absolutely no idea what the GPIO provider is or when it will be created.
> However in the case of reset-gpios, we not only know if the chip is
> there - we also already hold a reference to its firmware node.
>
> In this case using fwnode lookup makes more sense. However, since the
> reset provider is created dynamically, it doesn't have a corresponding
> firmware node (in this case: an OF-node). That leaves us with software
> nodes which currently cannot reference other implementations of the
> fwnode API, only other struct software_node objects. This is a needless
> limitation as it's imaginable that a dynamic auxiliary device (with a
> software node attached) would want to reference a real device with an OF
> node.
>
> This series does three things: extends the software node implementation,
> allowing its properties to reference not only static software nodes but
> also existing firmware nodes, updates the GPIO property interface to use
> the reworked swnode macros and finally makes the reset-gpio code the
> first user by converting the GPIO lookup from machine to swnode.
>
> Another user of the software node changes in the future could become the
> shared GPIO modules that's in the works in parallel[1].
>
> Merging strategy: the series is logically split into three parts: driver
> core, GPIO and reset respectively. However there are build-time
> dependencies between all three parts so I suggest the reset tree as the
> right one to take it upstream with an immutable branch provided to
> driver core and GPIO.
>
> [1] https://lore.kernel.org/all/20250924-gpio-shared-v1-0-775e7efeb1a3@li=
naro.org/
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Are there any comments on the software node part before I respin it
with Philipp's comments addressed?

Bartosz

