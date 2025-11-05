Return-Path: <linux-kernel+bounces-886056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECF7C349D6
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB03560B57
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF6A2DAFD6;
	Wed,  5 Nov 2025 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iaJuOu+L"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BC2DC342
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332683; cv=none; b=oT8d8TeSoVjPkZxBuj5gVpM6ISr/jszXdRkfCE7He+5hlnTYFE/kuCfITXtHQA/qJIuw+5Rp8IoNYTeBR9SjshR9NsEfSL6MzaTW9LQSEOl6nbqf/1qDhzPA0gxW6Md6h1PwB+IHzq2EaqJWRhdI7PmYeV6vWDpBUNnfIC4wrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332683; c=relaxed/simple;
	bh=MC0E0LFV/xPEYcoJSyRt7YbqwEmoTDhxfkNTbgU/xNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rx6x3crLIBjBqr2uySaZakUnjVdRzd0E/RvQPQsubc8SLbFA5EoOu1dmiVPzZ9YySI+kT/O9bGOqQNw9dh+rlIy3/x5IUR7+YyGTxe4c+mBDE7xmdbd+4E7Hqfbiu+wG2frhtwxCeIpIv8r/k772Psoupr8ftlsXCw418u577II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iaJuOu+L; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E2AAC1A18AB;
	Wed,  5 Nov 2025 08:51:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A76EC60693;
	Wed,  5 Nov 2025 08:51:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D3F210B51B68;
	Wed,  5 Nov 2025 09:51:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762332671; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SGMIavh+U2EDQDSS/pNGC+7pHshWF/DndMrY4tOtrpA=;
	b=iaJuOu+LZNyNp0nQwOmzehXT+PA5/6t0gcb8lUhFw/SUvhokUgLy5MdfKhqNNkGFW0Kw0K
	OzWIt0wHVi0OB9xXE0uZj5gWwQQV59BaKqBEj6ikBx9hl+B0uCyCWI46NTj6YX25bqyj53
	W7NF63xJWL6UW/VdYq1NpBwM60bTYchoQQs279XR+rEGIcaByQWWy7jkvYqmHcfcgBtEDr
	2N8sQukctUzJhwkk6aLLuaNmKf8PnOKsl74FVdHdMVEWi+10e0Ev77CnQfkXZk5JwUh1yd
	vnOwsa1KAiFXoHR/5laU9iqKPl2cJli+8AB/qo2F07QxG4pNxdNh6rrkZWa9aA==
Message-ID: <087643b4-7a29-4424-a3b0-b60bbc7c3140@bootlin.com>
Date: Wed, 5 Nov 2025 09:51:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] gpio: add gpio-line-mux driver
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251104210021.247476-1-jelonek.jonas@gmail.com>
 <20251104210021.247476-3-jelonek.jonas@gmail.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20251104210021.247476-3-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jonas,

On 11/4/25 10:00 PM, Jonas Jelonek wrote:
> Add a new driver which provides a 1-to-many mapping for a single real
> GPIO using a multiplexer. Each virtual GPIO corresponds to a multiplexer
> state which, if set for the multiplexer, connects the real GPIO to the
> corresponding virtual GPIO.

[...]

> +
> +struct gpio_lmux {
> +	struct gpio_chip gc;
> +	struct mux_control *mux;
> +	struct mutex lock;
> +
> +	struct gpio_desc *shared_gpio;
> +	/* dynamically sized, must be last */
> +	unsigned int gpio_mux_states[];
> +};
> +
> +DEFINE_GUARD(gpio_lmux, struct gpio_lmux *, mutex_lock(&_T->lock), mutex_unlock(&_T->lock))

I think you don't need this. A mutex guard is already defined in the
mutex header file [1].

So you just have to call:

	guard(mutex)(&glm->lock);

[1]
https://elixir.bootlin.com/linux/v6.17.7/source/include/linux/mutex.h#L228

> +
> +static int gpio_lmux_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct gpio_lmux *glm = (struct gpio_lmux *)gpiochip_get_data(gc);

useless cast

Best Regards,
Thomas

